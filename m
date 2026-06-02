Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D6627FD74
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416756; cv=fail; b=EkQzqTJb4GL4TXrzoSSNESoOdqet1iqkxkbtRLjQitMhUsFsBWStyTmPZZMkrY3ImLg7ag7YSxQzWmh7Ea+m4uZBHzs9fyWXfQCjuKBvKzFzSC6QWsdgOQFwRcHVKrpLbjbvOc8RVmWbPBJbpBEiuFj926cLlrbdbrDMSFR6jvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416756; c=relaxed/simple;
	bh=6xUVgpmZagpvND+dykw7bDQ/0mwcuG8M09FebUokaGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YulcdvAC2wDPFw2oasqi6+XXr4V3DTcfq/bVZi/TGIygG0ErJTmEicU3KPSHN5meiq06MCHEeFzWT3yELDBF+OYF0JxyKj7u4m00Nr95Z9U0mvZnmlc54SuYOg4+MeWoa9qRLwS2/7a8EJ4er6ENzHjhvlL7xQOh3cnc/gKonQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eZm52tkr; arc=fail smtp.client-ip=52.101.48.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eZm52tkr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQ8+0OAvilfEULcneIjpjjvmqPoljSBuj8qt6zKAzlEgd43VuZEBiJ7irXJSU3FsC9ovtzmbEkzEOIstfkp0Fk50MNMwhOhIBEx58/jgE5wwvDKBeHZIH8seBO9FBsz066SKZPUBvJojteE8/2bHWsn00sdLIoOZbFA+1VAknHCdsinVSmgUzDGRVbD+Cx4B5xSwtCClafq4SJK5CJfZzgKX71B0CJPhxqAs6Lst4zG+WO0usmxhzhdmbfxObrJbT8toIbTUi8BoNndKGBs7jf0wbLSpOsGvVk8prKUPT1RfWfNkjiXe1mkhN849iKVFic+ujwv3svX+21Xv/1/03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg4NCwczCSHINBO/55QVXs73qyQzNDuzoHpexv48GmA=;
 b=vtRuGzVCkr3kv5xpFjlA+6nkcSrccZbP1Cw9u1czbyZtgsZzvYxpGRnQhfe+QDmMsqdmcNE/FSepy2dXn8HRh7Gh2WnMBZzJaCtqo+YZC3Lov+XaRnM7lNSCCWk9+eejGTja7+I2zzWRWc2yMnkn5g7t3+vNeBM56k0stdkQvhkqk27lYZAaLLU8Qsofkoq8SC7491Kvud8jZoSbQLa59/4tK6/V83h3pjR96pq1zQo+DF+H60XJcm20t1Z/GUhf9/12QPC10YE9UanPvHfF3uNisyz5dqGlLgZYOwDI/G3uWFNb8tFXeuwK0MHctmNfOS4L6Bnpucc1szechv+5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg4NCwczCSHINBO/55QVXs73qyQzNDuzoHpexv48GmA=;
 b=eZm52tkreZ2UI8itU2Q2uAL/0x+3mhSzVEAC59cXWk/sMFOpJ9NI760+fSwbXOQE/I1NkxB2QQTGSCDjs8EjTFRdI14zhlO+gBq5/Z5TovRAZ32qwuszyLxZjdWdcMomHQXg8+bJgwwtVQ6p/6AI6cjBo2a7/GAPW8SGs+jTaA0oCkSF/H8S9ZqQNUDQzk71PEipEzEpPJ5Fj8YZvZ4iqHMELmPabiFyQhXkBje3a5QTbKDjv0E7MAqVuxwj+RUFDzPZyDD3r18FLJXcMqqSmny3c4Df+4fyCulTUt5CTipqXAXBuDK5p7TJu8IN0HHiWdA5jxcK3fG9+cs5HKGwgA==
Received: from CY5PR15CA0173.namprd15.prod.outlook.com (2603:10b6:930:81::18)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 16:12:29 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::40) by CY5PR15CA0173.outlook.office365.com
 (2603:10b6:930:81::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 16:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 16:12:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 09:12:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 09:12:03 -0700
Received: from treble.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 2 Jun 2026
 09:12:03 -0700
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>
Subject: [PATCH] http: preserve wwwauth_headers across redirects
Date: Tue, 2 Jun 2026 09:11:48 -0700
Message-ID: <20260602161150.1527493-1-aplattner@nvidia.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb8b3b9-43b2-49c0-bc70-08dec0c1bee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|5023799004|3023799007|11063799006|18002099003|56012099006|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	E3/EYinWah1RLpv+MdMlRqIxt3NHd6LPw1we47CJmuDcAADH4CIATM9DutLsauL7plwODYA+knWeWNx4dSav3JHuSEYmenxthoJmpd13CwPSjWvnKUYAVWNJ+/bE23kQtHSS96GfOsgRoJH1Z13bmrdt2/bFceMjdvfLF5wqr3MbiBKr42k1R8OMy7/ZjgGZ6fEaR9UyYPK5pDKYtZpMya41uzr0oJLtR9R43P3Hv26Zuq3SrHUr3lCjm5Kzoioh1O9qQpyb5f00bLcWLlA0CZmLZ6XxyAzjTVfpIzpYlZb+0XDbKR4BLQH7EzemBhbCrqw6zO2gf7y2A1He7N4RqVWpYMarL3HbUSzKoCHY8k5ZJ1QxgKE9PPbYCgPmbkDGB8CeURTFcZSJYKPHVxOleNt8/D5ttmy72DIK+d6Uc8FNRvxJZNudSzzd7v0vyvD54a5ggPadyN7/eGiRvJ+9jERi9PcKAuoOrdia+0XjgtWyoWXW5KZKYaQjmFGtETq+HcVe0flHLe97xV2ZEAzjJFW5/qh7iSzXUJUT5EoEHw+Ad7mOxKSk9VZBoRzN6vwxUFc8swQUPYTvpATNcS0zDXXlopdJ+sKTk65Y+1MdWYg4ufKrmUHwqxKU/AI5q3/vfW+OK5MtjIPg4ejTDypb5QWjhMBkIGWuJOavfEbdvmDGd30ToeVtQ5v6+vs5IE2se9Mevw/sj6ZqysaMZOqFMDUqpkayQ86TM6vbCRVccRw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(5023799004)(3023799007)(11063799006)(18002099003)(56012099006)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dg/aax/k7ezEUgvv6K9YvBP4Og/yVzeNdc0MZ71uy2parqFScsEBOVHdiazamNm/la/Aoi1mhPl0ogkjGw6IoEGedG8kF7h17WSOS/OIGfBDKaGBAoKW0alpApVq+SF4iPIzfzKyq1VZqTfXFIoAn59Zn55pcciCXgi5dYYT1tn8YIYzg1MTGegrcMSRugv51zAHXLtbOYTBchPgvmgVolpvsFF5PSIKWpHKr0DEqPzchXu4AcV5u0bCQWgQd64dg8ZpIZsZq+sG4LB9vmahVVFV8y0MQdA1BRuUOwhjCjWyR44QJx8wEwbLbIQavvDK4ANaLYsOzpqqBDbdpBwRxWqJCExO4qjypAlysJIKF+/9b1b7+Cr7MwZ1N2OlFtk6FFN+KuGwBoe3G6SNAa7sVdeLToqAV706gv9xvJonsvqFVvUEge501l6a/M5RR7wY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 16:12:29.5490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb8b3b9-43b2-49c0-bc70-08dec0c1bee2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320

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

For example, I have a server that supports HTTP but always redirects to
HTTPS before handling requests. This redirect breaks OAuth
authentication:

  $ git ls-remote http://server/git
  => Send header: GET /git/info/refs?service=git-upload-pack HTTP/1.1
  <= Recv header: HTTP/1.1 302 Found
  <= Recv header: Location: https://server.nvidia.com/git/info/refs?service=git-upload-pack
  == Info: Issue another request to this URL: 'https://server.nvidia.com/git/info/refs?service=git-upload-pack'
  => Send header: GET /git/info/refs?service=git-upload-pack HTTP/1.1
  <= Recv header: HTTP/1.1 401 Unauthorized
  <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
  trace: run_command: 'git credential-cache --timeout 7200 get'
  trace: start_command: /bin/sh -c 'git credential-cache --timeout 7200 get' 'git credential-cache --timeout 7200 get'
  trace: built-in: git credential-cache --timeout 7200 get
  trace: run_command: 'git credential-msal get'
  trace: start_command: /bin/sh -c 'git credential-msal get' 'git credential-msal get'
  trace: exec: git-credential-msal get
  trace: run_command: git-credential-msal get
  trace: start_command: /usr/bin/git-credential-msal get
  Username for 'https://server.nvidia.com': ^C

When git invokes the credential helper, it doesn't include the wwwauth[]
array, so git-credential-msal doesn't think that OAuth is supported [1].

Fix the problem by preserving the wwwauth_headers strvec across the call
to credential_from_url().

[1] https://github.com/Binary-Eater/git-credential-msal/blob/trunk/src/git_credential_msal/main.py#L69

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
 http.c                      | 14 ++++++++++++
 t/lib-httpd/apache.conf     |  1 +
 t/t5563-simple-http-auth.sh | 45 +++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/http.c b/http.c
index ea9b16861b..cac8c9bfc9 100644
--- a/http.c
+++ b/http.c
@@ -2425,7 +2425,21 @@ static int http_request_recoverable(const char *url,
 	if (options->effective_url && options->base_url) {
 		if (update_url_from_redirect(options->base_url,
 					     url, options->effective_url)) {
+			struct strvec wwwauth_headers = STRVEC_INIT;
+
+			/*
+			 * Preserve wwwauth_headers across the call to
+			 * credential_from_url(): if the effective URL doesn't
+			 * specify its own credentials, a credential helper
+			 * might need the wwwauth[] array from the server's
+			 * redirect response in order to authenticate.
+			 */
+			strvec_pushv(&wwwauth_headers,
+				     http_auth.wwwauth_headers.v);
 			credential_from_url(&http_auth, options->base_url->buf);
+			strvec_pushv(&http_auth.wwwauth_headers,
+				     wwwauth_headers.v);
+			strvec_clear(&wwwauth_headers);
 			url = options->effective_url->buf;
 		}
 	}
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 40a690b0bb..664f23fc6c 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -202,6 +202,7 @@ RewriteRule ^/dumb-redir/(.*)$ /dumb/$1 [R=301]
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
 
-- 
2.54.0

