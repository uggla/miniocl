#!/usr/bin/env bash

set -euo pipefail
set -x
IFS=$'\n\t'

if [[ -f remove ]]; then
	rm -rf data1 data2 remove
fi

node1=$(nslookup node-1.uggla.fr | sed -rn '/Name/,/Address/'p | grep "Address" | awk '{print $NF}')
node2=$(nslookup node-2.uggla.fr | sed -rn '/Name/,/Address/'p | grep "Address" | awk '{print $NF}')
node3=$(nslookup node-3.uggla.fr | sed -rn '/Name/,/Address/'p | grep "Address" | awk '{print $NF}')

iam=$(ip a s eth0 | grep inet | head -1 | awk '{print $2}' | sed -r 's#/[0-9]+##')

# Start cassandra
docker-compose up -d
