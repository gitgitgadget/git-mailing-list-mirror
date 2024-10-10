Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53091BE857
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604599; cv=none; b=rWqURntoGAV0P/M35H9WB5iyJe9TOgRZhEhigeb+PqhAegzMHQ2cU8+SszKakv6K7WSFsUyMQhyxffXM95vzP0iAUxNm9i8V4sK1mLLcQOcH/iZbF/gcXY2aZGkmj/AYkQ6Hzbj1Snqip3UfMY1pq//29ujUYmaFwrzGKcyzSVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604599; c=relaxed/simple;
	bh=2yteCggdA6LXgbOa72SHjQ2rtzToPOp6SaBetTTikRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Is2duycxSanlzX3FTAnmvwG8+aLilYUWLE2kyG0C7cZQOg6WnSObrRuUYegKmFEqzeKEcHL6mu2lN3Ewink5cZEKeyLLjdBTYrBxu99Y8dqCqS6AcBVrKS9dv6dE6/tph5YJNnULQNzlfIknwBwQKP4OI5TwHGd3RvCzw/hB+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=poURlDID; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="poURlDID"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604594;
	bh=2yteCggdA6LXgbOa72SHjQ2rtzToPOp6SaBetTTikRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=poURlDID2ag9TPkE+vc7S/nd6a5zKV05fk79yoNIIxzbY851iu23f7mgbcEu+7vjk
	 98uDYxux14YYchBQo8LLXviIISn2PrTIyMeqeUE3BFfMMQOrlkOQGcSaqxbfseSxRB
	 RMQ5H7jaBFWDMNxA4Mvw7EJGPnpNZ321GfjgDfutlb7h58D0tsVCIgN3QPjPScUdSK
	 rXj1GVNeNUK06A8chnUosXDeEb1QDDB8YQcx6uLPyoyZA44PMZNh7wVKYjX0+WphhF
	 rvweu7YYl0awX67Pq1xVidTtqDkrLcd2n+G+FrgtbEaxZWiAAotCzTlW+D2va/okry
	 FTcI4DlmIct6+90vzi2U+DR7DoL7NgKAmxwl4tikf14w4ZhR1x1H5hOToeFc5NR37Q
	 mZg00N5X34sarc2vHHFIlPqjK+jbxjzIi7HaM1kzT8fRQxaz65hise1twjKEmblHaz
	 sW+YZvSzpuK+OXHoyj0rKPWpgmUO8R+3RjzmRmhqXd+R8yZ3hRK
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1381B200BA;
	Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 04/13] git-curl-compat: remove check for curl 7.39.0
Date: Thu, 10 Oct 2024 23:56:12 +0000
Message-ID: <20241010235621.738239-5-sandals@crustytoothpaste.net>
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

libcurl 7.39.0 was released in November 2014, which is almost ten years
ago, and no major operating system vendor is still providing security
support for it.  Debian 9 and Ubuntu 16.04, both of which are out of
mainstream security support, have supported a newer version, and RHEL 8,
which is still in support, also has a newer version.

Remove the check for this version and use this functionality
unconditionally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-curl-compat.h |  9 ---------
 http.c            | 11 -----------
 2 files changed, 20 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 21306fa88f..b301ef154c 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,15 +28,6 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
-/**
- * CURLOPT_PINNEDPUBLICKEY was added in 7.39.0, released in November
- * 2014. CURLE_SSL_PINNEDPUBKEYNOTMATCH was added in that same version.
- */
-#if LIBCURL_VERSION_NUM >= 0x072c00
-#define GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY 1
-#define GIT_CURL_HAVE_CURLE_SSL_PINNEDPUBKEYNOTMATCH 1
-#endif
-
 /**
  * CURL_HTTP_VERSION_2 was added in 7.43.0, released in June 2015.
  *
diff --git a/http.c b/http.c
index ac4b98baa0..cdef059090 100644
--- a/http.c
+++ b/http.c
@@ -63,9 +63,7 @@ static char *ssl_key;
 static char *ssl_key_type;
 static char *ssl_capath;
 static char *curl_no_proxy;
-#ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
 static char *ssl_pinnedkey;
-#endif
 static char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
@@ -509,12 +507,7 @@ static int http_options(const char *var, const char *value,
 	}
 
 	if (!strcmp("http.pinnedpubkey", var)) {
-#ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
 		return git_config_pathname(&ssl_pinnedkey, var, value);
-#else
-		warning(_("Public key pinning not supported with cURL < 7.39.0"));
-		return 0;
-#endif
 	}
 
 	if (!strcmp("http.extraheader", var)) {
@@ -1104,10 +1097,8 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSLKEYTYPE, ssl_key_type);
 	if (ssl_capath)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
-#ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
 	if (ssl_pinnedkey)
 		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
-#endif
 	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
 	    !http_schannel_use_ssl_cainfo) {
 		curl_easy_setopt(result, CURLOPT_CAINFO, NULL);
@@ -1825,10 +1816,8 @@ static int handle_curl_result(struct slot_results *results)
 		 */
 		credential_reject(&cert_auth);
 		return HTTP_NOAUTH;
-#ifdef GIT_CURL_HAVE_CURLE_SSL_PINNEDPUBKEYNOTMATCH
 	} else if (results->curl_result == CURLE_SSL_PINNEDPUBKEYNOTMATCH) {
 		return HTTP_NOMATCHPUBLICKEY;
-#endif
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code == 401) {
