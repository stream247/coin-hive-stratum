curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.7/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 8
npm install -g pm2
pm2 install pm2-logrotate
npm init --yes
npm install --save coin-hive-stratum
cat >./proxy.js <<FILE
const Proxy = require("coin-hive-stratum");
const p = new Proxy({
  host: "pool.supportxmr.com",
  port: 3333
});
p.listen(80);
FILE
cat >./proxy_secure.js <<FILE
const Proxy = require("coin-hive-stratum");
const domain = "yourdomain.com"
const p = new Proxy({
  host: "pool.supportxmr.com",
  port: 3333,
  key: require("fs").readFileSync("/etc/letsencrypt/live/" + domain + "/privkey.pem"),
  cert: require("fs").readFileSync("/etc/letsencrypt/live/" + domain + "/fullchain.pem"),
});
p.listen(443);
FILE
