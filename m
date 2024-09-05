Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B019FA72
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549140; cv=none; b=hRRXZ/mImkMlN9rRnlMlFx4UPTgt7majHU3uft3kZHFBgO9oRmrjflplMWy34jCeTjJuHOGshYdyE4H9I9Ql/0w9AZ7vyJ/njZMgZge2W4uo2rzjvqhwe7gGQGPSeHjNbTtFroRMGu4SoaMA/S0EzqI4voADLIQKrc7bBy+icxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549140; c=relaxed/simple;
	bh=/r+sR5pvO4mhhQr1616Pgev0fd99VxVkgoljb+Gv/zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djt7ru86Y49lkq1cbGkY63YqvNMClKo9lMx8ToFEH2uEcJyiibK8/VHwfTZV1xoxwwfkOTClvPU9f/gHOg49rQXKttlQYppzUeoOqE3JawEKrszddJjABvpfHfUCXDz7d2u6Ch8rRKNky3vpsy57AlZPsIBYsCk8aj/30YzRpRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mW9BLsgB; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mW9BLsgB"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e17c1881a52so1563503276.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725549137; x=1726153937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt6Qkv+2crSADqLclNY+cpxXEIf233JOFhbBsMDk64I=;
        b=mW9BLsgBKm1Vk/QkBSM/J6JweI7vfZb2Kf6zZc8lVH5+YvjAOxTkKV+IQRRvLiEZAw
         FfV62WqDyGMm1Q7ZRoEFSNZnhqcdKhFIs4xbB9vlIbTsUTGNZb4ruj/S0JAxJzQtfeM8
         JwWjOMeZ1fyhi2Na8Nm2VIgwoF7zmCKe4RptW+pCrmczCzh+w+xJp6yidi0YOUGHbTO7
         Ry4aee3kL+JRa4CizQsEmqr0OZgORosSBxCf5QvWYQZMg7FV3lnbDnONaFHy72CwjceA
         /Oe+AnY/+UlTewyeLEva8oSpvB/jw3LL9c1mbK/OSz/1gnv4OUue6IL5QEtp8TII1qFd
         jUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549137; x=1726153937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt6Qkv+2crSADqLclNY+cpxXEIf233JOFhbBsMDk64I=;
        b=RqQYD614vOwP85bRkWRErzEzkzlHiYafmi/TmlOeFKKBKtbLUxyIhpxhZ0z+PEgmm8
         VQBY6TtThbl75S9JGA6AnWyhR+uAdWdmx5tKSy1hKEPNyvXlECLKtdwF0j6ZaswsoA1M
         wZEBM9EM5iUejAkPoGDC2R+X+ceYQZfrGqBNl90RzgHhEN8aJCi8zypH5qKqM5et2own
         TfHndzVc+nNxG3EUiyM5pOuKmEWsafHuToS9AsaLFfaVo1JWtF9EcFFvPRBw3FIS5cyA
         o+3WC+1STN47/PEHuku0bWhpW03J/Jlk0bIy1SRmyFEULzULxsSrHRl44wAXMMr77nZX
         WNxw==
X-Gm-Message-State: AOJu0YwZORSX06cmzAixCD3Dyy1ziAH6hoJyrB1UG6q/5X3GDXAg+u1I
	1avBy+ejk491C9Qw408qGEUoWXrqjY5uUceF/A9H5DRgjNHQaSCYb/dIQgtVQvfP4ZphMIbxFEz
	73bI=
X-Google-Smtp-Source: AGHT+IHcqOC+KPA1zlN5QjNBMVGRmH+cq1bv2kkuPVH1tS2M09SSuN20W+88KBp0Nfts/nOtq3kz9Q==
X-Received: by 2002:a05:690c:9e:b0:6ac:3043:168a with SMTP id 00721157ae682-6db25f90cccmr60278867b3.10.1725549137247;
        Thu, 05 Sep 2024 08:12:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d3e990e9sm29837097b3.34.2024.09.05.08.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:12:16 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:12:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] Makefile: allow specifying a SHA-1 for
 non-cryptographic uses
Message-ID: <02764de1395119490b4705d27e3f9153d9403dc1.1725549065.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725549065.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725549065.git.me@ttaylorr.com>

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
 hash.h   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

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
index 5e5b8205b58..6ea0d968017 100644
--- a/hash.h
+++ b/hash.h
@@ -15,6 +15,36 @@
 #include "block-sha1/sha1.h"
 #endif
 
+#if defined(SHA1_APPLE_FAST)
+#  include <CommonCrypto/CommonDigest.h>
+#  define platform_SHA_CTX_fast CC_SHA1_CTX
+#  define platform_SHA1_Init_fast CC_SHA1_Init
+#  define platform_SHA1_Update_fast CC_SHA1_Update
+#  define platform_SHA1_Final_fast CC_SHA1_Final
+#elif defined(SHA1_OPENSSL_FAST)
+#  include <openssl/sha.h>
+#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
+#    define SHA1_NEEDS_CLONE_HELPER_FAST
+#    include "sha1/openssl.h"
+#    define platform_SHA_CTX_fast openssl_SHA1_CTX
+#    define platform_SHA1_Init_fast openssl_SHA1_Init
+#    define platform_SHA1_Clone_fast openssl_SHA1_Clone
+#    define platform_SHA1_Update_fast openssl_SHA1_Update
+#    define platform_SHA1_Final_fast openssl_SHA1_Final
+#  else
+#    define platform_SHA_CTX_fast SHA_CTX
+#    define platform_SHA1_Init_fast SHA1_Init
+#    define platform_SHA1_Update_fast SHA1_Update
+#    define platform_SHA1_Final_fast SHA1_Final
+#  endif
+#elif defined(SHA1_BLK_FAST)
+#  include "block-sha1/sha1.h"
+#  define platform_SHA_CTX_fast blk_SHA_CTX
+#  define platform_SHA1_Init_fast blk_SHA1_Init
+#  define platform_SHA1_Update_fast blk_SHA1_Update
+#  define platform_SHA1_Final_fast blk_SHA1_Final
+#endif
+
 #if defined(SHA256_NETTLE)
 #include "sha256/nettle.h"
 #elif defined(SHA256_GCRYPT)
-- 
2.46.0.426.g82754d92509.dirty

