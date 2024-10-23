Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D83A935
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644367; cv=none; b=P6Ai1568GPfzav47lGEWQbZPWUyBsu2uABX1/Ep3XO19I43BHg+YRunisUgWTt38QpNHLdAXOwbDwrLiedERy89MGCt9k3dlenZn2c6uZpD7+BWBs2aAmY9sNobyvoJWJW9N7cvpOKZ7m9F3oypVD+zi706pALeUZv9AgjgiWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644367; c=relaxed/simple;
	bh=BQa8EISFWbwCF6AOQjRJNUTzXNdQVdIfGLAt8WXpLaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qElqVEL26oFr7lK2eirsIGUUqa8y15+5AeLfQprXJhAvcVY/zX8Jl+zt41SNRchTivp5diU8MDoRicOqSCgtl7M/TBUI/mMwNfVUJC+HbPy68b2wWNy9NDliaoRW6rpgpewuZ506IJHuxBg40gp28LWk33z4iJWmQ7uBWUFjLy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=g9l25Nha; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="g9l25Nha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729644364;
	bh=BQa8EISFWbwCF6AOQjRJNUTzXNdQVdIfGLAt8WXpLaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=g9l25Nha/qsLHr0Iye5q6PK6vuNwP4tpCaZvYXUakpS/oadlnF/O2oj87I94X/qXW
	 SHGGKkwW2J3FabqWknZdQnmBjvoVtjGXPnGaZIPm5FAFiS7hIgAcReYZlik7NfwXv+
	 Ehq79UU8TBgsj1KgO1JVC+7BbzTT6A756p+dBWhbSOMy9UGQuJ1Q3GEbSZ6qvMj5fi
	 GFfIKGMT5ycIc8inDdM5DIHSI0H3wjTXyZ/i4PaoYsNXAPCIECaKExfpttrqj+RC4S
	 WrbzMtttIKGpNU396cjMxx0wpQ4FdaSI0xo7yfdyGbbln1x9bpZ7XU6EXQM5YB06YO
	 /nadtK6eHn8DJVjTGfnJBEBOKrRpqHN+WWNtGz2JTkktNKi2bFFdgI+9YE0J3qP49y
	 y6qjEM7VmwiWYvvlF+bjoL1lYUi2J62VgbwyUwsWf8ecSM7rBA69smLNfRHxBZZnF+
	 ltZyKQKkgMdZdJI92ia1c0Xl93zDUzkfb0FBN8Zz5KnbZKcxjIu
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 32E6C200BC;
	Wed, 23 Oct 2024 00:46:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 02/12] git-curl-compat: remove check for curl 7.25.0
Date: Wed, 23 Oct 2024 00:45:50 +0000
Message-ID: <20241023004600.1645313-3-sandals@crustytoothpaste.net>
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

libcurl 7.25.0 was released in March 2012, which is well over ten years
ago, and no major operating system vendor is still providing security
support for it.  Debian 8, RHEL 7, and Ubuntu 12.10, all of which are
out of mainstream security support, have all supported a newer version.

Remove the check for this version and use this functionality
unconditionally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-curl-compat.h |  8 --------
 http.c            | 24 ------------------------
 2 files changed, 32 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index c24ed686c1..9100af027f 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,14 +28,6 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
-/**
- * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
- */
-#if LIBCURL_VERSION_NUM >= 0x071900
-#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
-#endif
-
-
 /**
  * CURLOPT_LOGIN_OPTIONS was added in 7.34.0, released in December
  * 2013.
diff --git a/http.c b/http.c
index d59e59f66b..633bbf74ee 100644
--- a/http.c
+++ b/http.c
@@ -716,35 +716,11 @@ static int has_proxy_cert_password(void)
 }
 #endif
 
-#ifdef GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE
 static void set_curl_keepalive(CURL *c)
 {
 	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
 }
 
-#else
-static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
-{
-	int ka = 1;
-	int rc;
-	socklen_t len = (socklen_t)sizeof(ka);
-
-	if (type != CURLSOCKTYPE_IPCXN)
-		return 0;
-
-	rc = setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, (void *)&ka, len);
-	if (rc < 0)
-		warning_errno("unable to set SO_KEEPALIVE on socket");
-
-	return CURL_SOCKOPT_OK;
-}
-
-static void set_curl_keepalive(CURL *c)
-{
-	curl_easy_setopt(c, CURLOPT_SOCKOPTFUNCTION, sockopt_callback);
-}
-#endif
-
 /* Return 1 if redactions have been made, 0 otherwise. */
 static int redact_sensitive_header(struct strbuf *header, size_t offset)
 {
