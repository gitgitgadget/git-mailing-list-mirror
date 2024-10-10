Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA61E882E
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604599; cv=none; b=B5oCiTJZLdjL+6L43BzdJ/gJy4FbIyibypBcKq61S01k3oF9Qq3ZCXGp3R5AoRX1B//brn2/gU0O5Ur35aGrLgruhYscCo+t13/FgyEM3/q+HSYlhfGUy+dDNJdtGQ78wN6iMNa57IrcUpENnb2gPvy97UEl8LLWGOvLyZ2Zzu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604599; c=relaxed/simple;
	bh=H9yfEMCXOdKkCyMy4ehXK57MDNa4HiytfYISS7UhBLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WI4ISHIki4HoC7610+CaHH56k8C0RGw2PzPaRZFbr5otX+RoyUuYPXIPvqgxt5w/bJNaIVthqeLi4PQG46dwTcPtEMui2BPmBF4UkSNibyR3FsEDk9VYlV/VSnRhjo9sFJsd83w9i24NuhYbVoCwkhtk+PDHBNqk0CzBcOvh3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=d8/8gNiM; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="d8/8gNiM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604594;
	bh=H9yfEMCXOdKkCyMy4ehXK57MDNa4HiytfYISS7UhBLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=d8/8gNiMtlAiIh6KvLyNGOici1++muEx0iPDz5JcGshYYKeU//km/hw9JjwiOdq+e
	 W4/UHTV24NwCpPy4xUGat3+lv8tq0FeG5OSfjQyBIRLRt5je2Rw5R4qQluvqJ6j1Xs
	 /HtLRqxKK9rc/1DS//IoqxcFS189bzO9X1HGXLZfDjvTyX79wyCJm8ikilPLXJRnxL
	 DZtYEfXgVn8xUIStKHxTRSE/+lTcGsDrLc0Rof19XCpe6hX4q8D9Rx1NfI1aUjLSr7
	 fpnzGWagbmWIYJ506u9tGxZaR/vmkR/0IqFBOwrCpJeBuAn7dH9xCojinGWQqzudyt
	 HHedpGTPj9wnVP4FUQQ3EfCUFM8xPGvYDRcLZ8xNvf08UYxT5sq27oC7SXwhxhKHzN
	 Cxlyagj81LoR0CZHoTX83KOZnoiDkec2QmMUDOZTaAc8H+CNQaxXKhwk/ORh8aa/Mb
	 v4MqfX8O2WIo+cn+trZtGQvVDubZj4PL6PhH6xXUAQfBXDhrSv2
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3013B200BD;
	Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 07/13] git-curl-compat: remove check for curl 7.52.0
Date: Thu, 10 Oct 2024 23:56:15 +0000
Message-ID: <20241010235621.738239-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241010235621.738239-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libcurl 7.52.0 was released in August 2017, which is over seven years
ago, and no major operating system vendor is still providing security
support for it.  Debian 9 and Ubuntu 18.04, both of which are out of
mainstream security support, have supported a newer version, and RHEL 8,
which is still in support, also has a newer version.

Remove the check for this version and use this functionality
unconditionally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-curl-compat.h | 15 ---------------
 http.c            |  8 --------
 2 files changed, 23 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 6b05d70d42..edee8f2ba0 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,21 +28,6 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
-/**
- * CURLOPT_PROXY_CAINFO was added in 7.52.0, released in August 2017.
- */
-#if LIBCURL_VERSION_NUM >= 0x073400
-#define GIT_CURL_HAVE_CURLOPT_PROXY_CAINFO 1
-#endif
-
-/**
- * CURLOPT_PROXY_{KEYPASSWD,SSLCERT,SSLKEY} was added in 7.52.0,
- * released in August 2017.
- */
-#if LIBCURL_VERSION_NUM >= 0x073400
-#define GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD 1
-#endif
-
 /**
  * CURL_SSLVERSION_TLSv1_3 was added in 7.53.0, released in February
  * 2017.
diff --git a/http.c b/http.c
index bdf8bf7b59..24764f1272 100644
--- a/http.c
+++ b/http.c
@@ -691,7 +691,6 @@ static int has_cert_password(void)
 	return 1;
 }
 
-#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD
 static int has_proxy_cert_password(void)
 {
 	if (http_proxy_ssl_cert == NULL || proxy_ssl_cert_password_required != 1)
@@ -705,7 +704,6 @@ static int has_proxy_cert_password(void)
 	}
 	return 1;
 }
-#endif
 
 static void set_curl_keepalive(CURL *c)
 {
@@ -1093,16 +1091,12 @@ static CURL *get_curl_handle(void)
 	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
 	    !http_schannel_use_ssl_cainfo) {
 		curl_easy_setopt(result, CURLOPT_CAINFO, NULL);
-#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_CAINFO
 		curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, NULL);
-#endif
 	} else if (ssl_cainfo != NULL || http_proxy_ssl_ca_info != NULL) {
 		if (ssl_cainfo)
 			curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
-#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_CAINFO
 		if (http_proxy_ssl_ca_info)
 			curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, http_proxy_ssl_ca_info);
-#endif
 	}
 
 	if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
@@ -1198,7 +1192,6 @@ static CURL *get_curl_handle(void)
 		else if (starts_with(curl_http_proxy, "socks"))
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
-#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD
 		else if (starts_with(curl_http_proxy, "https")) {
 			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
 
@@ -1211,7 +1204,6 @@ static CURL *get_curl_handle(void)
 			if (has_proxy_cert_password())
 				curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD, proxy_cert_auth.password);
 		}
-#endif
 		if (strstr(curl_http_proxy, "://"))
 			credential_from_url(&proxy_auth, curl_http_proxy);
 		else {
