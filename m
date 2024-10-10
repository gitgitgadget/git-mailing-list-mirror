Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D451E8845
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604601; cv=none; b=MTl6RGKhN1FyrYx+oSOYCKq3dCHsMIV1nNaLo1c5tJyig9AQnqsFOX6v1NpvLqACG41jVhne1wxrzWtVztYmgcz2XwXBIYqYXUs8d9lhjL+aqYKvxRnMaiFEun4WABvhWHJOYTHokwvwCFT6ckijkZs1ePNznj+F/6DHlxNhXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604601; c=relaxed/simple;
	bh=Yyx1/9ezc1jQ37JvF0zD81szsoSHY4VK/1sVGZmQ6ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuhY6tJj83LVjYWNCZAqjAEZsb3oduywkcDZMaXy0jL8ibRgsm1eT/bc3V7BKIJoU4M2TyY0ezkwD30y+ASt8SoItkFc9pzitzZjt0gZlJ8GH6IX+iLQjIvQsRDK9OQSJvtgumc56jGA+MGlO1P09WC9iGZrNLSWsDZjLBQO7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=v9dl44O4; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="v9dl44O4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604594;
	bh=Yyx1/9ezc1jQ37JvF0zD81szsoSHY4VK/1sVGZmQ6ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=v9dl44O4aIUv9edpdxy6chw6G0Sw87IBzcY1LZR9m4e65EbSpEREFNolQgPmCLhr0
	 LD3i9YUmw+MfIwXFcSLeUjGXQ6p4hK0Gj88l/hun6Y3xTlX5Ynix2zTgMHEjkLgN18
	 JoJlA+QBcwxYDXhKAWHksxkLCYQa+JsdD/QyyW/cKXUO2uqeoR7btA3bPUoWpgWD2B
	 kprXn/tHCza0zHdKBwFvYQ1NkNljxFv8U0GlAiQ4bkFRSIyoGKTCCsyZ30tNeGHyoa
	 +435yCTeRK7/h1V0j9p54iGmo9xU6CMEXrq8Td38Wvjl3IW4Yy00Jkxw5GDCE3D+hj
	 8ymr4sek6kIaVuVM9J9a2d3sfjS1ZFssYgUAvTU6mopNTO682eYLtn0HxeMtXWER6t
	 AzSKUYKcAA1jKMVP2nT0gYm9pcYyR25OrbPPNOYN1ZJIh/LTRTP0eABdQsaOHiV0GW
	 yRptiDjxqbqoaBZNElTq4K+vs++EfRYPBjIgE7T4jkmPQLJ7SjA
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 457B9200BE;
	Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 08/13] git-curl-compat: remove check for curl 7.53.0
Date: Thu, 10 Oct 2024 23:56:16 +0000
Message-ID: <20241010235621.738239-9-sandals@crustytoothpaste.net>
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

libcurl 7.53.0 was released in February 2017, which is over seven years
ago, and no major operating system vendor is still providing security
support for it.  Debian 10 and Ubuntu 18.04, both of which are out of
mainstream security support, have supported a newer version, and RHEL 8,
which is still in support, also has a newer version.

Remove the check for this version and use this functionality
unconditionally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-curl-compat.h | 8 --------
 http.c            | 2 --
 2 files changed, 10 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index edee8f2ba0..65ba1ee0f8 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,14 +28,6 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
-/**
- * CURL_SSLVERSION_TLSv1_3 was added in 7.53.0, released in February
- * 2017.
- */
-#if LIBCURL_VERSION_NUM >= 0x073400
-#define GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_3 1
-#endif
-
 /**
  * CURLSSLSET_{NO_BACKENDS,OK,TOO_LATE,UNKNOWN_BACKEND} were added in
  * 7.56.0, released in September 2017.
diff --git a/http.c b/http.c
index 24764f1272..c5fdf1cd4c 100644
--- a/http.c
+++ b/http.c
@@ -55,9 +55,7 @@ static struct {
 	{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
 	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
 	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
-#ifdef GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_3
 	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 },
-#endif
 };
 static char *ssl_key;
 static char *ssl_key_type;
