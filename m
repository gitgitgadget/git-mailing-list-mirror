Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53651C1AD8
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604598; cv=none; b=EtkCs3txRlTxT9BlqR3dglLyY7qVzWGfiyAUdadW8fa9hOz832NTf7iqfTayD4ZG1W3yQ5faBcNxXniuxXd53g0i4+ntX014v5IrWoRIiAzFP171G0YVAccPZ9rEd5KPDQZESDbJw4z0ROaOQBjrV6j/r3SkCLKw/nmpH0d6GKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604598; c=relaxed/simple;
	bh=yAqcvlaKyIMF7BH0xkxVj5SI8sM+mq1ekp/FwBpmvzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h115MpJopg7H+xKTqK+5kngDHmIok/mF8WNoj3v1qTSPY1h2s4aowdNtKEise7bJ3SvmNljyC4STxEVrj3j1afv6SAi3uU7ZyhygUDg/MXF2/x2t6x0TD9ZMGErwVZwdId7SdWqyyxKucoRjBuEoDm29SFmfctFio39Wpu+Iep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hvCPOl12; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hvCPOl12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604594;
	bh=yAqcvlaKyIMF7BH0xkxVj5SI8sM+mq1ekp/FwBpmvzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=hvCPOl12qpsKJoggz6RKmfSbiXAbV8k7ykRdW7/sZAqThjyf1Au3zEwDnF7bkE2bo
	 3gXwWKgThWV1t8RNyRdNcO7/6iR9runO1x6cz8fbVLIrTH+0Xtj7CMqYvNLcqQNMSo
	 kDt8ZJUdAmNSjkBdW439XthpgeRpaeUqA4IeLhkgSqOxlgjuc9L4fRMjkxrqaLNYde
	 VRX/JrG5ZPbX31ELU37bLhoMJru6qCFwoMIHY8P4wF3CyJ6+0sWNPXIhKJm5QI32dy
	 KeO8ZM6iuJxcsPfIAQL0yW9UarjAUFEv85hy1fowW8OcEczUiLkXkJolwPEoCzYhDC
	 gqNu45II+NdDbzK26nhzH3gLmg1cFC45jXzGTkqOTJw6DCCvb0gAWe8IQF7gAV7nCU
	 lPbpRZWCjupWaPyqdVUg1ekRYYJ/n2tGAt2JFmEUwglji3BWWYhC/McHcmi4DFBzwA
	 k3wpKqZmU1fjIpISaDyxYOm2FZHBRq0anntheCRjDend/C62uwe
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0A063200B9;
	Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 03/13] git-curl-compat: remove check for curl 7.34.0
Date: Thu, 10 Oct 2024 23:56:11 +0000
Message-ID: <20241010235621.738239-4-sandals@crustytoothpaste.net>
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
