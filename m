Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE7AF507
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549134; cv=none; b=cz66NR5SNlTmM8D3wXnQvkMixU4E9d+FTNCRlOpN8fV1LYcWZAHMMDiR4CJmW5B8nF62T2JguyHZi1JW5BSiJH/tuCMhbkOJUKEKVhy8DZ5gN/33fB9Xh0i+aID0hfvEi2m6n8wBvktuile4gc4aJRB9BOECwuJ/AHGfTlkT/yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549134; c=relaxed/simple;
	bh=OPd54Shw5KgWOzQQ17KuWTJpavIibVeHYPzfHSEuXAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL1Y2R4RVQgAUeaJDsGr3U2CQQXS6tuHg6iOOvQIgqSPDlAOX8Sgkfx10ASRVMPhEmM2OY/aTNaOCEeb2k395IHI7q3SAk7c9ysKX5dmuCTjy0uDowExf5ZtB15MUpjlNiNy+5Nv/aKLejGpPPZ4atjRVKD20TvuaUhhPcCWOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rh2AqkHF; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rh2AqkHF"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6bada443ffeso7239587b3.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725549131; x=1726153931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b6voiSCHT2M9BzZNk+KaZ2KNwGbL9u6Ib6pBhPxkuIc=;
        b=rh2AqkHFFIhUh1tU9LFea7d6qm3GET+JGjEKlqGlThgHwooddmCu5Rn7PhhFrRfikn
         9bxu5eHIHzlpPBmJl9MxDLRj6l94hau9TgWYBZMfKSnOXEQ5sQc5U8JLMwM0WFGQjwQz
         cIJzoopTFCD6c7Rn1W59gwyqO5qcvOTMLB2GKt/fKwuOFAQeZ6Tr7ykDYhReNuDuTi/G
         7kpCeJ8an69D94oOhFIh9dGzPhIh6C2jLjGsxanm4AZdEL7/ZEYr9qM5D5Dmalch1Osu
         5hn6XY889eODdYvlKgSrQGBqZuDGAag62IVeibfZHBW6/qHh9Pv1x9feJEYs6hI9waXZ
         HvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549131; x=1726153931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6voiSCHT2M9BzZNk+KaZ2KNwGbL9u6Ib6pBhPxkuIc=;
        b=BcS73PMW4akBBd6u1N1la+8kKEmoiNXTkNVZz9CaJvQYyXav3T02HdXfWgRraR0OQP
         Oq/unGjb648re++nqXYxrn5CRvKlWoVIq85AHfte/RREzHJ1BYV8479fctpu3HBqaPzs
         ngyJoS4s+wAgd6gC42JaOg6nkHW4etcdzEJZYtRP24dfyJKjDutsz92dAuvnekad8qKC
         +BS+0+kzGqCX9MNiKc/kCwII9Aw1IpjeDXe7sc8PoezikO/dlKsM7j1+o82LboJ6Vlq4
         S7oQNPvFtM3E/LGDDMDvg59Mnt7YYn/As7ISOIydBl/Tt4ILJp9C4TE9bU/Z8dwcFPdw
         fYeA==
X-Gm-Message-State: AOJu0YyFwC4fFfn+H8zqBk7U6AXe/JFLhazpoxivw9JnxOf6HIpMRqQh
	4wGR5IQ8298w8FXtTQ4YKJbm9IvUCOsCyY4GKBpJs4ts3z/aB+ou0nz1TzyJ66kkvCGCwwznzTx
	8yxs=
X-Google-Smtp-Source: AGHT+IEWTQg2g8OreXOqp8t06qpttWherRITN5zETfXAA8mr9qOHmiS5sgr7YaGoO1p/uKuSJRS2Pw==
X-Received: by 2002:a05:690c:458a:b0:6d5:7617:950e with SMTP id 00721157ae682-6db25fce581mr41076147b3.18.1725549131052;
        Thu, 05 Sep 2024 08:12:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d6f637ca5csm17908807b3.55.2024.09.05.08.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:12:10 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:12:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] sha1: do not redefine `platform_SHA_CTX` and friends
Message-ID: <e7cd23bf4cd232fa2ce610284199996383fb3323.1725549065.git.me@ttaylorr.com>
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

Our in-tree SHA-1 wrappers all define platform_SHA_CTX and related
macros to point at the opaque "context" type, init, update, and similar
functions for each specific implementation.

In hash.h, we use these platform_ variables to set up the function
pointers for, e.g., the_hash_algo->init_fn(), etc.

But while these header files have a header-specific macro that prevents
them declaring their structs / functions multiple times, they
unconditionally define the platform variables, making it impossible to
load multiple SHA-1 implementations at once.

As a prerequisite for loading a separate SHA-1 implementation for
non-cryptographic uses, only define the platform_ variables if they have
not already been defined.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 block-sha1/sha1.h | 2 ++
 sha1/openssl.h    | 2 ++
 sha1dc_git.h      | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
index 9fb0441b988..47bb9166368 100644
--- a/block-sha1/sha1.h
+++ b/block-sha1/sha1.h
@@ -16,7 +16,9 @@ void blk_SHA1_Init(blk_SHA_CTX *ctx);
 void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, size_t len);
 void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
 
+#ifndef platform_SHA_CTX
 #define platform_SHA_CTX	blk_SHA_CTX
 #define platform_SHA1_Init	blk_SHA1_Init
 #define platform_SHA1_Update	blk_SHA1_Update
 #define platform_SHA1_Final	blk_SHA1_Final
+#endif
diff --git a/sha1/openssl.h b/sha1/openssl.h
index 006c1f4ba54..1038af47daf 100644
--- a/sha1/openssl.h
+++ b/sha1/openssl.h
@@ -40,10 +40,12 @@ static inline void openssl_SHA1_Clone(struct openssl_SHA1_CTX *dst,
 	EVP_MD_CTX_copy_ex(dst->ectx, src->ectx);
 }
 
+#ifndef platform_SHA_CTX
 #define platform_SHA_CTX openssl_SHA1_CTX
 #define platform_SHA1_Init openssl_SHA1_Init
 #define platform_SHA1_Clone openssl_SHA1_Clone
 #define platform_SHA1_Update openssl_SHA1_Update
 #define platform_SHA1_Final openssl_SHA1_Final
+#endif
 
 #endif /* SHA1_OPENSSL_H */
diff --git a/sha1dc_git.h b/sha1dc_git.h
index 60e3ce84395..f6f880cabea 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -18,7 +18,10 @@ void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
 void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
 
 #define platform_SHA_IS_SHA1DC /* used by "test-tool sha1-is-sha1dc" */
+
+#ifndef platform_SHA_CTX
 #define platform_SHA_CTX SHA1_CTX
 #define platform_SHA1_Init git_SHA1DCInit
 #define platform_SHA1_Update git_SHA1DCUpdate
 #define platform_SHA1_Final git_SHA1DCFinal
+#endif
-- 
2.46.0.426.g82754d92509.dirty

