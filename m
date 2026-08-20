Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16182D73BC
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 03:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787196116; cv=fail; b=JxmBHhpj7Eu6RHkhWpeIQDbsO0hAGFsNKdmFXVtaoy6nfOKSrXdnWzY+LPNKqTHqMzPJRPuIP9CkjZvSA/wusYDb8RPHFBgMhoiNi3FmQ9ruzCR77tZSBQqhMdyqpzgj13qAaIxUnh9vGS4NxYZugfr2I0epeodGvHrdEsTBhsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787196116; c=relaxed/simple;
	bh=6UlmEq35ia/oE8ZbbZSLgEeijzGBtMoVZzZ+mhaWSeU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fE5RmhlWnJ1wj0OJ6HcVLk/8tlJXMaLsa/q4+/QZyE/jggKSwUiSTEVwwl5WXTLWU77svUIzC8zevn7nSNYtrxmRGHO8tfKBV844Wclynhg741NfdlfUecqfnKFW5w/peG2XaRUnDKoirnyEtrUO+hZHAs+RnchhWGdTg7ug/5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LuB3WDrN; arc=fail smtp.client-ip=40.93.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LuB3WDrN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Db0Gsvhsxjv8EVNDBd96f8dt302ViIrRupVkyB2GvstqJkpjjYOpLwICwGl8EpR4izEq6Q5hGdeWPSjxAVyPoTbGfWPqOap0QE81gb8Vptx2BULIHHjFvBz4b+K6SfLOFf0jQ3yvMwRCDxavXx7I9fATYQcvQaPUz5sb1TPTLYOlYD7zsCHf+ZEGegXZkKti9iqr3//OpoYc3sVxW1PoAv3IIXvrvnrRHAUVti74yv+CdthpUqRp+rq2uqmt43+TgBgQlbRcujt2xhw4gmTLEgt6DWKyeFmybi/xEbNPzTAw8F/fSuW/mi3U6e0QYUcTLO9sGJzG72PO88aH73R5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs5OSkWFON9nYS7zelc5/9XZpbaZYJsba0Rb1WzQt8s=;
 b=SCsJWUhRqsTfiIaCnhbrk27PU3aUvoHQaZVZ2JQEJew15UatXdUID11s4GBJcopeVFIifKrBQEbTa3eIkeR51ncDyJJqdlHDRYe2T7+v21EzrQYpO/zejX7MoTivE/+YgvToVOnpTM2o8M7RFWBfQBfP6HesY3IhX6bgQOjo3bAqUtC1tObUnioicNwR8i+f1Z8zc/BLDefkq18yEggM51bDKbsnW7TaBq+vynFr/q85SyUMzwOBDh/Re7wDyDM3WYMDBYMve29QRZ474iWhCxjYxZ2hFl+KZy45jrqed79on4lWd6umZcn5klWxv768g9z9ePPq1s8jrdBG2OCqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs5OSkWFON9nYS7zelc5/9XZpbaZYJsba0Rb1WzQt8s=;
 b=LuB3WDrNQ1scK4XnX7v7bjnsSNLHX4bvbRaDPDSUuI0TM4WpLL/RK+1r26a2MKKurlVhjzg7FarcScvozjIJDsMQGAmIU8LF9vmifWJsYiXqlALB91HOwW/tBZI6g7O+Muv/lglL/AAwX+hdq0J807cv3YgwOMlq6nOB1xF2P/e2pgMP8R0YOSjOgInhICMLJBXTx0VjZ39XFVUgpgLbY4VsD/kaYq0T9IElVJZcn84dX8u4WRcfOLx7iOjxgRNJbLBTR3g92sFvLvolQDaW3Ouiz3kF6/C65pXA2yFdWwom9MJ41o155ud5VqJGppEULmGOPopmKx8Vgetjwj3MxA==
Received: from CYXPR02CA0037.namprd02.prod.outlook.com (2603:10b6:930:cc::15)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 03:21:49 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::a) by CYXPR02CA0037.outlook.office365.com
 (2603:10b6:930:cc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 03:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 03:21:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 19 Aug
 2026 20:21:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Aug
 2026 20:21:25 -0700
Received: from treble.plattner.fun (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Aug 2026 20:21:24 -0700
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] http: preserve wwwauth_headers across redirects
Date: Wed, 19 Aug 2026 20:21:04 -0700
Message-ID: <20260819-http-preserve-wwwauth-redirect-v2-1-4c61039432b0@nvidia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260819-http-preserve-wwwauth-redirect-a3fe4dab6b35
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7395; i=aplattner@nvidia.com; h=from:subject:message-id; bh=6UlmEq35ia/oE8ZbbZSLgEeijzGBtMoVZzZ+mhaWSeU=; b=owGbwMvMwCT4NetMP+euaaaMp9WSGLLaiirf9hwP8y0X6jmhqz012Fh/WtihPb9M/jNO7tvdc +kom41xRywLgyATg6yYIsvejAVOx5jvrp21OGQDzBxWJpAhDFycAjARdm6G+YUqj0+aZSytO9+d 68wlI9j46fPX1wwLvtS/uPU5S8b2+CObj2FB2z/M0xM0AAA=
X-Developer-Key: i=aplattner@nvidia.com; a=openpgp; fpr=BD68A042C603DDAD9AA354B0F56ACC8F09BA9635
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2259d0-74ab-4da7-d562-08defe6a2bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|13003099007|6133799003|3023799007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ho19cKuS9tErXs1CfCdwjPnhPECDMeZb22rPisVa50kskOkogb/56lEBR8fGxcvAEIQnwM/nQ3nDn2olx7rO+81VNQ72D1tqNuBpPpCaHdq3ehn33t+NWUOtSbisPTNOW/w3ObLc/E/hgr35T823gkIId4ClVjqbCbbIu4+RL6JbZ7lklVIKYfVqX7GilqCo0fXTCwRq3XYZaJqvuw4M4hz7zLTdJ6vmRWOTcNL3/JhpS7BaJ169c5YISd3tIpum1eqiwtXBZ0iyFBFS3auVrUFFiKNHPugPP7n973t/nXQd1Pf8N/NVvVcu/djnD6dPrQuAZ4mFgdKojNNeifOJ9E0acb42aaGM0q4BnkM/v6X/8FcswiUuXLW5/ODagoN4vueyMvqvJo1T7b585wHHpdtOQ0Sx7lfK9Q8P90zu1XnXR1k7LDx+3AUTHmRbKxnp82p50ASOaWm+xTgd45FAVxRh//QHzJjjRd0kLs5bLOooMxM25jypvKUSoPPpeTQdrceqnIleTW5pKwa9ySRx6GTCA5UBLbI512bDTE3JyDhuZsDYM8s5XcdthCt6HcWm9CNpYb1K4/Dp5O0/RvxfNEVpDP0MqASc+F/dGoxDYEXFa3Pw1TaKgLx4nsYmtnqFxTkfuIxWPol5+eao3GHo5ns4UUYrOHhQblwDX0UQRMwacrQ3H6cvwMpW8EZh0xpkfzWxA2O2/hKM9AeNRTUUgg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(13003099007)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ut6BhzT9SI1DUU7AT8iHgZURP/5RoEB6pHn6ex736yspw5iuM/YBT810Z84Y7/HWjUEsRnAzZNK8Y2tDl3oGyBRf+Q9ASLQ0xLw7mTcKC45Om7EkE/FPm+Hvr0bP8p8xlGpMK4S1hE1IXGCPgaFGJTED3HyCZCgS/V6W5GxCo0MfdZpaVCG2QptRXNyZBx2YcaW2Jyj9kmlOitCHJu81s8otMxlJhooLB7q9oeg5a14JqaBHmGRt8ZZ2sbAZwzOEOBPqbK2hbnyyTC9vLfudNskxWwrBEjuIZmzUMm8Wr0mjy3Gx5/l2VNU6HiruxyG8FWoWTNiONCkvMPvalkKJdKYn+qzisur0s2XjIYPoE8nkdg5pcTtfYWJ0syIBgfLxnp0J6LXblIs4MqbvlO/jnn0C9AbF+5ZbQZVav7AgNizvOujx8c5gm7wb/nyu/WAG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 03:21:48.7459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2259d0-74ab-4da7-d562-08defe6a2bd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403

When cURL follows a redirect, it calls the CURLOPT_HEADERFUNCTION for
each header received including ones from a redirect. http_request() sets
fwrite_wwwauth() as the header function, which will record the wwwauth[]
entries for the last step in the redirection chain.

However, when http_request_recoverable() sees that cURL followed a
redirect, it attempts to update the credentials for the request from the
new URL using credential_from_url(). The first thing that does is call
credential_clear(), which clears everything including wwwauth_headers.

If the new URL should use a credential helper rather than credentials
embedded in the URL, this loses the list of authentication methods that
the server provided in the redirect.

The WWW-Authenticate challenge is not derived from the URL; it is
populated from the server's response, and after a redirect it describes
how to authenticate to the redirect target and it needs to survive the
URL update so that credential helpers can know which authentication
methods are allowed.

Add a new credential_update_url() that wraps credential_from_url() and
preserves wwwauth_headers specifically. Use SWAP() to avoid having to
copy the whole strbuf.

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
I decided to come back to this after I noticed that at least one other
person had run into the same bug:

https://lore.kernel.org/all/CADoNwcscDrx+YcfbcW4YKONDZZQgnPiwEOxL4QYV_C7_=FOFcg@mail.gmail.com/

Rather than reworking everything about how credentials are stored, I
took your advice in [1] and just moved the code to preserve the wwwauth_headers
into credential.c. That way any future credential fields that need to be
preserved can be added there without having to hunt down other places
like http.c that are reaching into it.

[1] https://lore.kernel.org/all/xmqqpl28scll.fsf@gitster.g/
---
Changes in v2:
- Move strvec preservation into a helper function in credential.c
- Use SWAP instead of strvec_pushv() to avoid having to copy the
  contents of the strvec.
- Link to v1: https://patch.msgid.link/20260602161150.1527493-1-aplattner@nvidia.com
---
 credential.c                | 16 ++++++++++++++++
 credential.h                |  8 ++++++++
 http.c                      |  9 ++++++++-
 t/lib-httpd/apache.conf     |  1 +
 t/t5563-simple-http-auth.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/credential.c b/credential.c
index 2594c0c422..035399d7ee 100644
--- a/credential.c
+++ b/credential.c
@@ -708,3 +708,19 @@ void credential_from_url(struct credential *c, const char *url)
 	if (credential_from_url_gently(c, url, 0) < 0)
 		die(_("credential url cannot be parsed: %s"), url);
 }
+
+void credential_update_url(struct credential *c, const char *url)
+{
+	struct strvec wwwauth_headers = STRVEC_INIT;
+
+	/*
+	 * credential_from_url() clears the whole credential. Preserve the
+	 * WWW-Authenticate list, which is derived from the server's original
+	 * response rather than from the URL and is required to authenticate to
+	 * the new URL.
+	 */
+	SWAP(wwwauth_headers, c->wwwauth_headers);
+	credential_from_url(c, url);
+	SWAP(c->wwwauth_headers, wwwauth_headers);
+	strvec_clear(&wwwauth_headers);
+}
diff --git a/credential.h b/credential.h
index c78b72d110..b90f666e33 100644
--- a/credential.h
+++ b/credential.h
@@ -305,6 +305,14 @@ void credential_write(const struct credential *, FILE *,
 void credential_from_url(struct credential *, const char *url);
 int credential_from_url_gently(struct credential *, const char *url, int quiet);
 
+/*
+ * Update the URL-derived fields (protocol, host, path) of an existing
+ * credential to match a new URL. Unlike credential_from_url(), this function
+ * preserves state that was derived from a server's HTTP redirect response,
+ * such as the WWW-Authenticate headers.
+ */
+void credential_update_url(struct credential *c, const char *url);
+
 int credential_match(const struct credential *want,
 		     const struct credential *have, int match_password);
 
diff --git a/http.c b/http.c
index a0d399b274..e8abb9f95a 100644
--- a/http.c
+++ b/http.c
@@ -2427,7 +2427,14 @@ static int http_request_recoverable(const char *url,
 	if (options->effective_url && options->base_url) {
 		if (update_url_from_redirect(options->base_url,
 					     url, options->effective_url)) {
-			credential_from_url(&http_auth, options->base_url->buf);
+			/*
+			 * Use credential_update_url() rather than
+			 * credential_from_url() so that the WWW-Authenticate
+			 * challenge the server sent with the redirect target's
+			 * response is preserved and handed to the credential
+			 * helper.
+			 */
+			credential_update_url(&http_auth, options->base_url->buf);
 			url = options->effective_url->buf;
 		}
 	}
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 4149fc1078..0627ef1433 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -203,6 +203,7 @@ RewriteRule ^/dumb-redir/(.*)$ /dumb/$1 [R=301]
 RewriteRule ^/smart-redir-perm/(.*)$ /smart/$1 [R=301]
 RewriteRule ^/smart-redir-temp/(.*)$ /smart/$1 [R=302]
 RewriteRule ^/smart-redir-auth/(.*)$ /auth/smart/$1 [R=301]
+RewriteRule ^/custom_auth_redir/(.*)$ /custom_auth/$1 [R=302]
 RewriteRule ^/smart-redir-limited/(.*)/info/refs$ /smart/$1/info/refs [R=301]
 RewriteRule ^/ftp-redir/(.*)$ ftp://localhost:1000/$1 [R=302]
 
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index a7d475dd68..349ae4ab39 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -557,6 +557,51 @@ test_expect_success 'access using bearer auth' '
 	EOF
 '
 
+test_expect_success 'bearer auth after redirect preserves wwwauth headers' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	capability[]=authtype
+	authtype=Bearer
+	credential=YS1naXQtdG9rZW4=
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	id=1 creds=Bearer YS1naXQtdG9rZW4=
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	id=1 status=200
+	id=default response=WWW-Authenticate: FooBar param1="value1" param2="value2"
+	id=default response=WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
+	id=default response=WWW-Authenticate: Basic realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	test_config_global credential.useHttpPath true &&
+	git ls-remote "$HTTPD_URL/custom_auth_redir/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	capability[]=authtype
+	capability[]=state
+	protocol=http
+	host=$HTTPD_DEST
+	path=custom_auth/repo.git
+	wwwauth[]=FooBar param1="value1" param2="value2"
+	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	capability[]=authtype
+	authtype=Bearer
+	credential=YS1naXQtdG9rZW4=
+	protocol=http
+	host=$HTTPD_DEST
+	path=custom_auth/repo.git
+	EOF
+'
+
 test_expect_success 'access using bearer auth with invalid credentials' '
 	test_when_finished "per_test_cleanup" &&
 

---
base-commit: dea0ea3582e6980ddbc1173cc8e3e9f9db91cde0
change-id: 20260819-http-preserve-wwwauth-redirect-a3fe4dab6b35

