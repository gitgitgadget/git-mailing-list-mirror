Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53C31C9B93
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604597; cv=none; b=Z/ovO1vMdK8a5ur3DDuPVosJp4B6pRtTufLF1D6sNQ+hnpjOH6q+L89KAa6tvEnjeudtxsluqsAxF/1rwIzKyD7eldB1MoycmZL/Jc2+vruxbuogZYbZC3B2CyEqI5ox0XwDG6jwSDYtC6Pgzkz7GkWLrKye0gLQVOzd5oZM6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604597; c=relaxed/simple;
	bh=BQa8EISFWbwCF6AOQjRJNUTzXNdQVdIfGLAt8WXpLaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsTJJ07zma4vW3faRPmO3icXcE6A+QK75Rx2OyvHsX7Kr2nMKHb00wgVUfgIU+8XaxmzMm4JRv58LfuxaUuUKNRQNyWUO9tpWbhESbsOzOjbZ9vgE33BN1l6RVar1hSGlOtrKdjJ7rRmilMONvr3hpj0c62w7YdSzUH5kEE6UzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=o15U3QG9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="o15U3QG9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604594;
	bh=BQa8EISFWbwCF6AOQjRJNUTzXNdQVdIfGLAt8WXpLaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=o15U3QG9N0cguPU7xNavMfH00u3FhM1mYCDgxVe5S9KC8A1lD8BEjG7FFrTYlrxZC
	 V456wQTcXKO1X0QonkxfiJsDxCkvUkPUiUbKWUID+tLN50la86CfiF3h68uL50Nhvy
	 sgunoIvRajPZfrGulnBf6PxM1g5/FsQAnl5yPdsMVIqjZ9eN5W6yn9nsXLp9cHfqEi
	 G2Ju3S9U7VV5803NCtvX0JPKNefjMXaRWjBQ35o7zUBomUqOAQ8NOCTxtrpEjt4OEF
	 QVORHbkM3JIv/39/0T3MqkJsMSPAiUkgc9d0elvkBbHhzSi+jIQlDF2Sy/1ebyLYj4
	 bY8IWKD76eAEOr3y8F15WIJ+wFT3msSK7/4i4nShpMew6jWMxfwMDgMWzrLL/v7pid
	 OyInM2q8JoJ8mwSihCZbAroQghOwWAtGKSSRLmaTBlbWc2k5EbcZFrsLnCODpvTa6M
	 lujW3wYwm4n3q2l0Og5GRpuv0tKobvCkzhFUnYo/JnJJMuRMag8
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 00F29200B8;
	Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 02/13] git-curl-compat: remove check for curl 7.25.0
Date: Thu, 10 Oct 2024 23:56:10 +0000
Message-ID: <20241010235621.738239-3-sandals@crustytoothpaste.net>
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
