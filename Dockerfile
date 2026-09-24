FROM node:24-bookworm-slim AS builder

WORKDIR /app

RUN corepack enable

COPY . .

RUN pnpm install --frozen-lockfile

RUN pnpm --filter @synch/cli build


FROM node:24-bookworm-slim

WORKDIR /app

COPY --from=builder /app/apps/cli/dist/synch.js /usr/local/bin/synch

RUN chmod +x /usr/local/bin/synch

ENTRYPOINT ["/usr/local/bin/synch"]
