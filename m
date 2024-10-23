Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E2717BCE
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644367; cv=none; b=JtbMbjgeqy1A2NZwi6jChlFb6uoG7w+J1KAyI/NE4J+c/PFcyK5rKUypjHkq4DG/Ncf+mhUVy72PXJVTrQpJ1ObOP4ZiFqX9dA/FSlm4leFz8cHBcgf3x6IDD2WMnFjb8gHcOw6n4cPubuvsCpGlzHfNWxBNRo5NuKU96sv2F44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644367; c=relaxed/simple;
	bh=yAqcvlaKyIMF7BH0xkxVj5SI8sM+mq1ekp/FwBpmvzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXzD1Z22OQwZ3u2ij1gYoOz+rTbhIrRr962TwW6Rx/tOdKHHbivOFp7gNwVFmhomQs+JhhvqmN+dplh1GgVwDn4zx0FLKKttq8SbjMSVYHWBVW4MyVDO5wUU/dTOKKGi8k9oagMjDs5+KtOAABHe4UCpQ9dwjoaku6/p0NWUX14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ycn9wZwG; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ycn9wZwG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729644364;
	bh=yAqcvlaKyIMF7BH0xkxVj5SI8sM+mq1ekp/FwBpmvzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=ycn9wZwGCagw6Vm8yz29UBqUyjdKEgNMnLtELcR+NrJJaqQAUFKyUs82Bk1U57Mzx
	 39Kw6SFKxJalvD6ukxhVR7QGWJMlMNCYSVQ2gz6I/yE8OD55Xaw6PXE5Zo/ni/l5zY
	 ieZUiBj1CUSdqVDRZzhkyBbPBcOTUfRP16OHADlhJWuGx8jAKCCCsnQwMS67UCOJV4
	 do0Zz4ZRojBkJ+leqcnhPnFaeYORaNdg8Ehhe+WUS3rRFG/fLteUyPiVi2Nq7Hw0xQ
	 ajTqDhbZA6x+USajM8OyNY8Qbd/xt/pDWgPTN5Q64+gHmlmOJQ3v/LXXbZ/+9P4huH
	 rhEyd51Q6iE62GkxZtd1D+T7Jt1urha6cIfFFymmDybHjUhX/vX9iDn3IOpEHJ3W//
	 mFrhi3wubhdpVtIxTy26JJ7wcpxbAEeEPP8dpUDe07nJDkIFDcVOtp9NqAIa209jVd
	 gGIOjF4KbOGB9ZNWo71WETQOqlcCe8+5OK5KYctbCaQ9CI24knT
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3CDE5200BD;
	Wed, 23 Oct 2024 00:46:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 03/12] git-curl-compat: remove check for curl 7.34.0
Date: Wed, 23 Oct 2024 00:45:51 +0000
Message-ID: <20241023004600.1645313-4-sandals@crustytoothpaste.net>
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

libcurl 7.34.0 was released in December 2013, which is well over ten
years ago, and no major operating system vendor is still providing
security support for it.  Debian 8 and Ubuntu 14.04, both of which are
out of mainstream security support, have supported a newer version, and
RHEL 8, which is still in support, also has a newer version.

Remove the check for this version and use this functionality
unconditionally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-curl-compat.h | 22 ----------------------
 http.c            |  2 --
 imap-send.c       |  4 ----
 3 files changed, 28 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 9100af027f..21306fa88f 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,28 +28,6 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
-/**
- * CURLOPT_LOGIN_OPTIONS was added in 7.34.0, released in December
- * 2013.
- *
- * If we start requiring 7.34.0 we might also be able to remove the
- * code conditional on USE_CURL_FOR_IMAP_SEND in imap-send.c, see
- * 1e16b255b95 (git-imap-send: use libcurl for implementation,
- * 2014-11-09) and the check it added for "072200" in the Makefile.
-
- */
-#if LIBCURL_VERSION_NUM >= 0x072200
-#define GIT_CURL_HAVE_CURLOPT_LOGIN_OPTIONS 1
-#endif
-
-/**
- * CURL_SSLVERSION_TLSv1_[012] was added in 7.34.0, released in
- * December 2013.
- */
-#if LIBCURL_VERSION_NUM >= 0x072200
-#define GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_0
-#endif
-
 /**
  * CURLOPT_PINNEDPUBLICKEY was added in 7.39.0, released in November
  * 2014. CURLE_SSL_PINNEDPUBKEYNOTMATCH was added in that same version.
diff --git a/http.c b/http.c
index 633bbf74ee..ac4b98baa0 100644
--- a/http.c
+++ b/http.c
@@ -52,11 +52,9 @@ static struct {
 	{ "sslv2", CURL_SSLVERSION_SSLv2 },
 	{ "sslv3", CURL_SSLVERSION_SSLv3 },
 	{ "tlsv1", CURL_SSLVERSION_TLSv1 },
-#ifdef GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_0
 	{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
 	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
 	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
-#endif
 #ifdef GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_3
 	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 },
 #endif
diff --git a/imap-send.c b/imap-send.c
index ec68a06687..954cc9be65 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1417,15 +1417,11 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
 
 	if (srvc->auth_method) {
-#ifndef GIT_CURL_HAVE_CURLOPT_LOGIN_OPTIONS
-		warning("No LOGIN_OPTIONS support in this cURL version");
-#else
 		struct strbuf auth = STRBUF_INIT;
 		strbuf_addstr(&auth, "AUTH=");
 		strbuf_addstr(&auth, srvc->auth_method);
 		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
 		strbuf_release(&auth);
-#endif
 	}
 
 	if (!srvc->use_ssl)
