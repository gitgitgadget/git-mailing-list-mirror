Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E8224D6
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644371; cv=none; b=d8Nn1nK+AtZrjHJXEgHtfHH6pNcfqLR4PbhsHh7IWibY1HUV1+OYFOAX/s0Kj/q/efqyfSVhdSXyHnTiHot3WJ5rnn/X0h/C6/o11umxujPTl9OllZa0udk7TrjUxjRlsOhnsqdttm0swHobrLjcKeJltKU9bFTPyAloym/SWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644371; c=relaxed/simple;
	bh=H9yfEMCXOdKkCyMy4ehXK57MDNa4HiytfYISS7UhBLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgXvSYlU+VdG3jZAt/IvSXD8SdaVyKAK/yJzP0+9YEosMGhACP8K5l4cW3xwXVH9OyfStErR6/VJNYVO4haLfPlOIq2yrwEKVS0p4CtSVcF85BaunDhPUxlm0h4Bpj7HBh+yIGkqonvmi38GAfGkKmaszSSitWAQiX1NOjkC0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Vb15/4Kn; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Vb15/4Kn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729644364;
	bh=H9yfEMCXOdKkCyMy4ehXK57MDNa4HiytfYISS7UhBLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Vb15/4KnGBxJ585oBKOWhq0hWIsvEQExJaDPg63Uleu8F0HAkjyM70kSW06dMZfAo
	 wL7xPpS6C82pLKxl9L7l/b5XKEXHVEIUBMoXwfLDWYZ3ucvzvNkQrbCuaoz1hkXajD
	 hKOvqydwX/Qi9OWR5LgGjI1ZEgZ2/lD479bvVvcJbaLn+SpAyYM0y0T0Jpmiqk1xFG
	 hJwDk7wKqMFoQeNLJotWGoBd4OlUiUufhNX2HUblXpAPD4x4ctPtdekox9vYmspc2u
	 wdx0Kimxq1QZ8ZKcgRz+Iep524PExOTim0VhOh5VjzLcVZipQeEYO/gL0jGu+obToE
	 tMkF26kDOrcEEvrJhNExp3Z5/06nuytTuRRgBvSmiYwiXFQ/bNMF9bSJ/UoRNB7wuS
	 g7x1PSlr+vPNG7eBw+RPuLS3R9Ezt+eXiBJ3yPREXIZl6MS9XJ4v1HhNSyoIQMD4iL
	 W5zm0wxEclDvO+VXNSsFetKr2QyxL44Cl7Pz5bMMAxTiZT43dDK
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 66285200C1;
	Wed, 23 Oct 2024 00:46:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 07/12] git-curl-compat: remove check for curl 7.52.0
Date: Wed, 23 Oct 2024 00:45:55 +0000
Message-ID: <20241023004600.1645313-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241023004600.1645313-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241023004600.1645313-1-sandals@crustytoothpaste.net>
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
