Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39CB17DFF4
	for <git@vger.kernel.org>; Sun,  1 Sep 2024 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206614; cv=none; b=l7IERGRR50oycpmIfOFq1hDBgAkt65KulBHiH136fenQqRnqUK51to0qkGbOKNbCxPKRKW9LFMT4VqV8HFsEbAUHhyo0IWIrVBFu6Hi6wFc+DXBqmnjvHaH2QHaZ5jfjlIBe9QG8Z468rzVr4oBit+K0cKruui7WXssalLiy7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206614; c=relaxed/simple;
	bh=7fTJuw9P9vU6sJtyZFlLHwvsZlxS+aPCP4dPuOMdegE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBgvuRQ3nX/6C5OE8XWkKEtKFnTjzTaAiGVMJasaLmU9Nd93WifY4uproD1hBa34xZqme0mRL/lCXnqQ1feAQo/le4YK/NLkktd68hXcuLkxqbEBrzsS5l1mKao2hvKJRuHQQo/lJeAPstuAYobOtYXN+ka4INiz/6cZFLfkrzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EqeNeXrK; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EqeNeXrK"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-27018df4ff3so2200676fac.1
        for <git@vger.kernel.org>; Sun, 01 Sep 2024 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725206610; x=1725811410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LxYreUVxCdHo+0bKb2lGeQIBpUecTpOEGnIHyvKrhA=;
        b=EqeNeXrKiAPYNykvhgvc/OOs+Usjp7X95flMEfTw2DsjCVXvM3W+yEZKqL2VEZq8yx
         3PMRIDmRtzNZQlxJ/RaVw/YsONPXN8+utsLPmxNl+tsZ9vHXueqimI6kVIMA/Fran3QD
         +9/XQm7EceL6cwq/4o+1n7K7FSe97niizi/x8SJKsVg/qo8IEvWe7CDbu6fyPJOiqs1S
         wwITB8KoEctDIeTuyuGKPOQr0rCC2ECHD4cHJ4/Q1pV19RbRytzffGNOYhwdu5BGScwC
         0gR/XxUlNK40mrJTEi4qaavJVPe3JCWIP1hmoRy42TjXYCHsHdrg/21vT+fnvR5wnor3
         8gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725206610; x=1725811410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LxYreUVxCdHo+0bKb2lGeQIBpUecTpOEGnIHyvKrhA=;
        b=VCvnrQj9zFlLmSjg+lXcAwGqlCe2Wb2ySvrj1H0EmSrWo6icUOha51FxzOhg/Klrmu
         f1uSMd5BLAIjTGFvcGIIfaeYD7xwRSGZbEVh9rAyxDP2F6c6A6xUtvLl9vlZPS6mj+7d
         iw/zf3ENLa5zHjGv/fVA0W8lwxLY1aUWlOKDh+myYHZBVcmC+O417noRtHSR94N1nVSZ
         sIIqhd7wI29KAMtfG1v1IjP1R7UrAlp5UWV06wlPANEqaLE+Of92mbZw0jGspQov7/Lf
         fkub28Zaf+kuS50eiC/8/S/tKLJtZUg413roT4M3yyeEp//u1HXGET3lcuFyIpFcNwrE
         x1yQ==
X-Gm-Message-State: AOJu0YwqjufwT8Aoc6gW84eqy9BSUmnXg+ygmjJaS1fp5UiKQAX9Asn6
	l/FTZ+VHMsH/RkY9S4h3F5/5rqUX262eEU+/FlXuQmkk2qWyAXd1KJ7hpUh2DW7mdFsjIkfkm9z
	7joc=
X-Google-Smtp-Source: AGHT+IEsgVAFLsIIMNMTVUF/Hv6A6pm5a98nUKQQLLgaLHmzfxXVQTuQ6GWT5siZoAwIf3UqsLMPQw==
X-Received: by 2002:a05:6871:4e97:b0:261:44d:3b86 with SMTP id 586e51a60fabf-277d0443357mr5518965fac.23.1725206610431;
        Sun, 01 Sep 2024 09:03:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1a626e3d5asm1436013276.44.2024.09.01.09.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:03:29 -0700 (PDT)
Date: Sun, 1 Sep 2024 12:03:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] Makefile: allow specifying a SHA-1 for non-cryptographic
 uses
Message-ID: <682e4c2cc3581c72262ea6a9b488a246fc6fde28.1725206584.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725206584.git.me@ttaylorr.com>

Introduce _FAST variants of the OPENSSL_SHA1, BLK_SHA1, and
APPLE_COMMON_CRYPTO_SHA1 compile-time knobs which indicate which SHA-1
implementation is to be used for non-cryptographic uses.

There are a couple of small implementation notes worth mentioning:

  - There is no way to select the collision detecting SHA-1 as the
    "fast" fallback, since the fast fallback is only for
    non-cryptographic uses, and is meant to be faster than our
    collision-detecting implementation.

  - There are no similar knobs for SHA-256, since no collision attacks
    are presently known and thus no collision-detecting implementations
    actually exist.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile | 25 +++++++++++++++++++++++++
 hash.h   | 25 +++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/Makefile b/Makefile
index e298c8b55ec..d24f9088802 100644
--- a/Makefile
+++ b/Makefile
@@ -517,6 +517,10 @@ include shared.mak
 # Define APPLE_COMMON_CRYPTO_SHA1 to use Apple's CommonCrypto for
 # SHA-1.
 #
+# Define the same Makefile knobs as above, but suffixed with _FAST to
+# use the corresponding implementations for "fast" SHA-1 hashing for
+# non-cryptographic purposes.
+#
 # If don't enable any of the *_SHA1 settings in this section, Git will
 # default to its built-in sha1collisiondetection library, which is a
 # collision-detecting sha1 This is slower, but may detect attempted
@@ -1982,6 +1986,27 @@ endif
 endif
 endif
 
+ifdef OPENSSL_SHA1_FAST
+ifndef OPENSSL_SHA1
+	EXTLIBS += $(LIB_4_CRYPTO)
+	BASIC_CFLAGS += -DSHA1_OPENSSL_FAST
+endif
+else
+ifdef BLK_SHA1_FAST
+ifndef BLK_SHA1
+	LIB_OBJS += block-sha1/sha1.o
+	BASIC_CFLAGS += -DSHA1_BLK_FAST
+endif
+else
+ifdef APPLE_COMMON_CRYPTO_SHA1_FAST
+ifndef APPLE_COMMON_CRYPTO_SHA1
+	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
+	BASIC_CFLAGS += -DSHA1_APPLE_FAST
+endif
+endif
+endif
+endif
+
 ifdef OPENSSL_SHA256
 	EXTLIBS += $(LIB_4_CRYPTO)
 	BASIC_CFLAGS += -DSHA256_OPENSSL
diff --git a/hash.h b/hash.h
index f255e5c1e8a..450e579b405 100644
--- a/hash.h
+++ b/hash.h
@@ -15,6 +15,31 @@
 #include "block-sha1/sha1.h"
 #endif
 
+#if defined(SHA1_APPLE_FAST)
+#include <CommonCrypto/CommonDigest.h>
+#define platform_SHA_CTX_fast CC_SHA1_CTX
+#define platform_SHA1_Init_fast CC_SHA1_Init
+#define platform_SHA1_Update_fast CC_SHA1_Update
+#define platform_SHA1_Final_fast CC_SHA1_Final
+#elif defined(SHA1_OPENSSL_FAST)
+#  include <openssl/sha.h>
+#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
+#    define SHA1_NEEDS_CLONE_HELPER_FAST
+#    include "sha1/openssl.h"
+#  endif
+#  define platform_SHA_CTX_fast openssl_SHA1_CTX
+#  define platform_SHA1_Init_fast openssl_SHA1_Init
+#  define platform_SHA1_Clone_fast openssl_SHA1_Clone
+#  define platform_SHA1_Update_fast openssl_SHA1_Update
+#  define platform_SHA1_Final_fast openssl_SHA1_Final
+#elif defined(SHA1_BLK_FAST)
+#include "block-sha1/sha1.h"
+#define platform_SHA_CTX_fast blk_SHA_CTX
+#define platform_SHA1_Init_fast blk_SHA1_Init
+#define platform_SHA1_Update_fast blk_SHA1_Update
+#define platform_SHA1_Final_fast blk_SHA1_Final
+#endif
+
 #if defined(SHA256_NETTLE)
 #include "sha256/nettle.h"
 #elif defined(SHA256_GCRYPT)
-- 
2.46.0.425.ge8f5cbd280c

