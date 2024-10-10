Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444821E571F
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604598; cv=none; b=TyU2BRxm4WUHyLi29c3P8oW507bKsmwVywOF98jCDuH4p8IHVLlMFu2Jgv0CK6WrqdonNgjTWkwquYTz3HLq96Y8nZrNEso80uLmsCxz9atWWNthr4MUdatMaIarDvsqFKUncs8JeLoZe35kKiWR/JQAEY75BIIHOOU88wvcNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604598; c=relaxed/simple;
	bh=/eZ0oHRZKK+QdeosQHMaDtMJ5DTkT1eLqH/CW8IIE3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2xZZqlY9RcapRQ/Ja6UcFmq8hjs2nkARyiz+Y3rqDbFsfwWq62JmChgcXVJfGpa/22MqtCu+dLw/wLW2CwNe7+7G5neraqb8rkg7uMxB3Ki6DLEGC8imZt5W269hpj5OtrWyemQdz3DRfgoU5LVSMbobjGANa3PG+YbWIv2xVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=DLNktl+6; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DLNktl+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604594;
	bh=/eZ0oHRZKK+QdeosQHMaDtMJ5DTkT1eLqH/CW8IIE3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=DLNktl+6X9wgdOHGz4KasXSSVQTIYr+X7vPjb1Wa1U6mfWleNtT5QsrhYr8vAoSaL
	 Jp8bewbSjns4+mmuht3jk6vM2Q4ElM1PqTSIqoDCY+ofBN9w1yolkxoewNxLCWp6Wt
	 L59FtP+YoTWSbFDcle/PFh611Q2FRkvuPocUWFNBwXNzaDjtgsI0D3sfqODF2DLk0A
	 /rQ13DdxxCBQn/zOfGNw+UvhqRXWl3F0SMi4tEAuAXIL0DL75QZQziVrNuy6KtiK1C
	 CuhcmBXFQSOlWDAJSig0g7KQyItm6ogm3TCnvSwisaqXhjy2ZMnQg9HHg4KPuVxaxN
	 xUhN8iGV+IpWjiNdQC+DnbrKD6pJd99+3BdjQ6gOs8wNMw7UWE0C9ggxgomUAQtR1o
	 ivR/DumxrehN9iOwcLaB4qY7AAeIZ4es0XRfgS97ZZ7RLd5czVc8T5kbwk/JGrtnra
	 k6zdF4MUc2oHX78mwahXaIa39k/kehoJxiWY0NG7BdlBEzTAv9I
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1D70A200BB;
	Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 05/13] git-curl-compat: remove check for curl 7.43.0
Date: Thu, 10 Oct 2024 23:56:13 +0000
Message-ID: <20241010235621.738239-6-sandals@crustytoothpaste.net>
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

libcurl 7.43.0 was released in June 2015, which is over nine years
ago, and no major operating system vendor is still providing security
support for it.  Debian 9 and Ubuntu 16.04, both of which are out of
mainstream security support, have supported a newer version, and RHEL 8,
which is still in support, also has a newer version.

Remove the check for this version and use this functionality
unconditionally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-curl-compat.h | 11 -----------
 http.c            |  5 -----
 2 files changed, 16 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index b301ef154c..cd970e34d6 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,17 +28,6 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
-/**
- * CURL_HTTP_VERSION_2 was added in 7.43.0, released in June 2015.
- *
- * The CURL_HTTP_VERSION_2 alias (but not CURL_HTTP_VERSION_2_0) has
- * always been a macro, not an enum field (checked on curl version
- * 7.78.0)
- */
-#if LIBCURL_VERSION_NUM >= 0x072b00
-#define GIT_CURL_HAVE_CURL_HTTP_VERSION_2 1
-#endif
-
 /**
  * CURLSSLOPT_NO_REVOKE was added in 7.44.0, released in August 2015.
  *
diff --git a/http.c b/http.c
index cdef059090..945df9a628 100644
--- a/http.c
+++ b/http.c
@@ -980,7 +980,6 @@ static long get_curl_allowed_protocols(int from_user, struct strbuf *list)
 	return bits;
 }
 
-#ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
 static int get_curl_http_version_opt(const char *version_string, long *opt)
 {
 	int i;
@@ -1003,8 +1002,6 @@ static int get_curl_http_version_opt(const char *version_string, long *opt)
 	return -1; /* not found */
 }
 
-#endif
-
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
@@ -1022,7 +1019,6 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
-#ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
     if (curl_http_version) {
 		long opt;
 		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
@@ -1030,7 +1026,6 @@ static CURL *get_curl_handle(void)
 			curl_easy_setopt(result, CURLOPT_HTTP_VERSION, opt);
 		}
     }
-#endif
 
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
