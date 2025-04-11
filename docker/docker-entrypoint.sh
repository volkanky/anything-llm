#!/bin/bash
# Ensure persistent directories exist and are writable
mkdir -p /persistent/vector-db
mkdir -p /persistent/uploads
mkdir -p /persistent/sqlite
chmod -R 777 /persistent
{
  cd /app/server/ &&
    npx prisma generate --schema=./prisma/schema.prisma &&
    npx prisma migrate deploy --schema=./prisma/schema.prisma &&
    node /app/server/index.js
} &
{ node /app/collector/index.js; } &
wait -n
exit $?
