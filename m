Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E6AC3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 18:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0D421775
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 18:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9A99Tut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgCDSkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:40:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54914 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbgCDSkK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 13:40:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id i9so3336460wml.4
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 10:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WzT4gQZoRdV/E+5Gnfq36lDgD21vhs6b8KmGhqkLVVU=;
        b=j9A99TutAChRoJyHkiWdlvES/gacnuwD52WlQaMZ4TO5b54SV3TaYZeHR0VwNelK2r
         59h+JheS4k2W+NsYEzFZLamojut3hDvXokXz//tmFfXEFmB0lRbf/d6Mg361XlWGmeDJ
         htv5QbPdqRIJ7FYbDQ0MNyvrvabzQ2fbgCUQ7FirwXiEStsstcfik1sknOXtXZSzsVM+
         p1yOMlAxvw9LANgRCL0JzjU239Q9Hxp3xZedhcmAt7+jcXGoln006vo/FzLG6w29hLGf
         1oOJAU3tIpJRcRdzbDOdpbibHVB7/Z/ZiVXk+LzNFDmsohRiAx6BXOUb0maMy7k3CtCj
         TyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WzT4gQZoRdV/E+5Gnfq36lDgD21vhs6b8KmGhqkLVVU=;
        b=krSXeEc9SBJxElb72/eOTU7BBOqvsH/hHAzPGoGAEZsxTcPNyb+LEqfxRJPptr7wIZ
         J4ofJmWKc2gfQ2XeadaKAhIR1KvJN2m1AJkDSWu7cb362JH/V3OvnkIGjeARY6vrdM28
         awsG9+GBurFV5dZu8NfFxbBoJ5/lRwOOTq8ETZl3wU1Sf9EQUOKCmmHSPvSTDBA68r8j
         /SZEB8eoRIYkkqSjJ2VRPzZq/zJHx0vt5ixXOSu9nYapF5MHdTLUZ/ni1jDQZ/4lRv8n
         G69kOKgS7EooMCcd3fp56/Pg+1fEiDuv7nIMY3uqrmiic6yX9dNFr1TUao+tg/nAtp+z
         iajA==
X-Gm-Message-State: ANhLgQ129qjoV64l1u7st27hxEyJ/TVSKIowE5lYfSyWaRki4BLOYOfN
        Nq1kRBlHLs5JaexA452o8PPYEdIM
X-Google-Smtp-Source: ADFU+vv4TRd9vJV6mVmeN0ow2xOXC8vVaUfeCFSRhGZ/m0z7cF8EMxxjcI+kyp3oHd0CkW0dmDMtgw==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr4816210wmi.188.1583347208412;
        Wed, 04 Mar 2020 10:40:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c26sm5307123wmb.8.2020.03.04.10.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:40:08 -0800 (PST)
Message-Id: <e18b342819b445281732269def1912a044171bab.1583347206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.559.v3.git.1583347206.gitgitgadget@gmail.com>
References: <pull.559.v2.git.1582759438.gitgitgadget@gmail.com>
        <pull.559.v3.git.1583347206.gitgitgadget@gmail.com>
From:   "Jorge Lopez Silva via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Mar 2020 18:40:05 +0000
Subject: [PATCH v3 1/2] http: add client cert for HTTPS proxies.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jorge <JALopezSilva@gmail.com>,
        Jorge Lopez Silva <jalopezsilva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jorge Lopez Silva <jalopezsilva@gmail.com>

Git currently supports performing connections to HTTPS proxies but we
don't support doing mutual authentication with them (through TLS). This
commit adds the necessary options to be able to send a client
certificate to the HTTPS proxy.

A client certificate can provide an alternative way of authentication
instead of using 'ProxyAuthorization' or other more common methods of
authentication.  Libcurl supports this functionality already so changes
are somewhat minimal. The feature is guarded by the first available
libcurl version that supports these options.

4 configuration options are added and documented, cert, key, cert
password protected and CA info. The CA info should be used to specify a
different CA path to validate the HTTPS proxy cert.

Signed-off-by: Jorge Lopez Silva <jalopezsilva@gmail.com>
---
 Documentation/config/http.txt | 17 +++++++++
 http.c                        | 67 ++++++++++++++++++++++++++++++++---
 2 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index e806033aab8..7d398f9afba 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -29,6 +29,23 @@ http.proxyAuthMethod::
 * `ntlm` - NTLM authentication (compare the --ntlm option of `curl(1)`)
 --
 
+http.proxySSLCert::
+	The pathname of a file that stores a client certificate to use to authenticate
+	with an HTTPS proxy.
+
+http.proxySSLKey::
+	The pathname of a file that stores a private key to use to authenticate with
+	an HTTPS proxy.
+
+http.proxySSLCertPasswordProtected::
+	Enable Git's password prompt for the proxy SSL certificate.  Otherwise OpenSSL
+	will prompt the user, possibly many times, if the certificate or private key
+	is encrypted.
+
+http.proxySSLCAInfo::
+	Pathname to the file containing the certificate bundle that should be used to
+	verify the proxy with when using an HTTPS proxy.
+
 http.emptyAuth::
 	Attempt authentication without seeking a username or password.  This
 	can be used to attempt GSS-Negotiate authentication without specifying
diff --git a/http.c b/http.c
index 00a0e507633..8d616b5d60e 100644
--- a/http.c
+++ b/http.c
@@ -86,6 +86,13 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *http_proxy_authmethod;
+
+static const char *http_proxy_ssl_cert;
+static const char *http_proxy_ssl_key;
+static const char *http_proxy_ssl_ca_info;
+static struct credential proxy_cert_auth = CREDENTIAL_INIT;
+static int proxy_ssl_cert_password_required;
+
 static struct {
 	const char *name;
 	long curlauth_param;
@@ -365,6 +372,20 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.proxyauthmethod", var))
 		return git_config_string(&http_proxy_authmethod, var, value);
 
+	if (!strcmp("http.proxysslcert", var))
+		return git_config_string(&http_proxy_ssl_cert, var, value);
+
+	if (!strcmp("http.proxysslkey", var))
+		return git_config_string(&http_proxy_ssl_key, var, value);
+
+	if (!strcmp("http.proxysslcainfo", var))
+		return git_config_string(&http_proxy_ssl_ca_info, var, value);
+
+	if (!strcmp("http.proxysslcertpasswordprotected", var)) {
+		proxy_ssl_cert_password_required = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp("http.cookiefile", var))
 		return git_config_pathname(&curl_cookie_file, var, value);
 	if (!strcmp("http.savecookies", var)) {
@@ -565,6 +586,21 @@ static int has_cert_password(void)
 	return 1;
 }
 
+#if LIBCURL_VERSION_NUM >= 0x073400
+static int has_proxy_cert_password(void)
+{
+	if (http_proxy_ssl_cert == NULL || proxy_ssl_cert_password_required != 1)
+		return 0;
+	if (!proxy_cert_auth.password) {
+		proxy_cert_auth.protocol = xstrdup("cert");
+		proxy_cert_auth.username = xstrdup("");
+		proxy_cert_auth.path = xstrdup(http_proxy_ssl_cert);
+		credential_fill(&proxy_cert_auth);
+	}
+	return 1;
+}
+#endif
+
 #if LIBCURL_VERSION_NUM >= 0x071900
 static void set_curl_keepalive(CURL *c)
 {
@@ -924,8 +960,14 @@ static CURL *get_curl_handle(void)
 #if LIBCURL_VERSION_NUM >= 0x073400
 		curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, NULL);
 #endif
-	} else if (ssl_cainfo != NULL)
-		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
+	} else if (ssl_cainfo != NULL || http_proxy_ssl_ca_info != NULL) {
+		if (ssl_cainfo != NULL)
+			curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
+#if LIBCURL_VERSION_NUM >= 0x073400
+		if (http_proxy_ssl_ca_info != NULL)
+			curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, http_proxy_ssl_ca_info);
+#endif
+	}
 
 	if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
 		curl_easy_setopt(result, CURLOPT_LOW_SPEED_LIMIT,
@@ -1018,9 +1060,18 @@ static CURL *get_curl_handle(void)
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
 #endif
 #if LIBCURL_VERSION_NUM >= 0x073400
-		else if (starts_with(curl_http_proxy, "https"))
-			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
+		else if (starts_with(curl_http_proxy, "https")) {
+			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
+
+			if (http_proxy_ssl_cert)
+				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
+
+			if (http_proxy_ssl_key)
+				curl_easy_setopt(result, CURLOPT_PROXY_SSLKEY, http_proxy_ssl_key);
+
+			if (has_proxy_cert_password())
+				curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD, proxy_cert_auth.password);
+		}
 #endif
 		if (strstr(curl_http_proxy, "://"))
 			credential_from_url(&proxy_auth, curl_http_proxy);
@@ -1230,6 +1281,12 @@ void http_cleanup(void)
 	}
 	ssl_cert_password_required = 0;
 
+	if (proxy_cert_auth.password != NULL) {
+		memset(proxy_cert_auth.password, 0, strlen(proxy_cert_auth.password));
+		FREE_AND_NULL(proxy_cert_auth.password);
+	}
+	proxy_ssl_cert_password_required = 0;
+
 	FREE_AND_NULL(cached_accept_language);
 }
 
-- 
gitgitgadget

