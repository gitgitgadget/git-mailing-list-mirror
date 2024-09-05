Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470519E7F0
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549101; cv=none; b=QOaWc2PV9Uc8l10/eM9ugIzAOjEpw08u3mLPsK9EvGzu+oA6JiTNg63DGUsqPgrjwBILXSO0pHR5qXzlKHcdD5LP6c+wlDMSfOaRtNpy7Ol+yif7/QQqxp6ZtcXWYF9JyCrzQJ1vPhoVJfxT4xw8S30lRD6Wa1TXstiMhAp8tpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549101; c=relaxed/simple;
	bh=+gR53V8lUZBwgIEGghajdNmx9dRGBvUCXwtn87pqDgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okmDuaBKAS4JswZAuP2F7pKy7kLS/kRbCqjczVZbt6lLUBu+D9TUJ3QBJDC75NiaICmuwjka+e9NuKQVxWyAEBcdlrOscM90kw2dRpKLLGhpSdcSLUotHUsdhgeFyelmkEGO/S7MKQUOL66pbloCxIFtV1vpimOER3KFZUjXfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=F4fFt3xs; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="F4fFt3xs"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso985128276.3
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725549098; x=1726153898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OyxgbizEDKVcgjJVNKa6a/dhQulx0Dq0vbS1jIDRDmE=;
        b=F4fFt3xszIcm/7c6cpKiSP1k5Yuxc0cfoPZr9ngnCRDLxOK8U/kWsNNQLr9bhCQuz6
         rVBf0PpDT6+CikFz7HiUVSyfsIKtoXT9atzqIUJtdc262gGHdG8jctJOn0NZVy4YehWd
         TVz+Q/NPf8momRNtu8zhw7IGZry9GFoPvEa+dzVcXjDLu3wSUKkOmU/Rs8hSilUL7cJ/
         ShCXPN3AFVy5RgOMh5eg76NEIaBhrsf/wJYA+r3vmdKGOCqSgyG4uhtMe/kesEkEG/Fo
         mJBxTubIIDnT2bowxuMni7jMwIl72/kRa8S1vIqQ1/CF76UlqqWsyWUy55XY0plF7V7i
         dmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549098; x=1726153898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyxgbizEDKVcgjJVNKa6a/dhQulx0Dq0vbS1jIDRDmE=;
        b=nYVW0TxL7F84JojyLMF+1GoO/VIAPQA+UI0PYppFQjZ39hR0RTiB8z/ulbCxJ2lK13
         riadDxc+esVDR4/572ihRLLt3G4JCEDkRLneSgvZiU78VMs5XhoI/naL3r2VPHO7UKEI
         vmbxYhSxeMGWEWHT3ps9grTTTENkCGHQ/dRV9Ls7RyX9T2JZ5SP7vPobPcGSxQWeYOE+
         /E15XqYInJM5gb+HayNoX6VkUJIkhLmjCbSrp3arI49RBeP+EEa2ZVkLjM/ccQm2aqzX
         jTjmAOOeKxeyCZFMTZG0C0WgWWvAtN/MlHrsRyoGSuSYFWAROs9P7Mu9NCR3F1v2UJ9V
         Hp4A==
X-Gm-Message-State: AOJu0YzZUMRxlsTn6pI24gmrXbQpf1LfUa8376H6B0qsyoOrKeWxB735
	LEy7NnRBLe7jh/18rPKMzIaYGyZrCrL7qY+hGmXC2sMF59X+TCbPp4rqYM5nlh/85gL17yTZynx
	fui8=
X-Google-Smtp-Source: AGHT+IH0bIM9lM9cWwzFPUYxabSaauH8bl87uexRFBrHxMGh+82H5YhE0qQ3S2q5k5+oC+ZWvTv8Bg==
X-Received: by 2002:a05:6902:11c3:b0:e1c:e381:5080 with SMTP id 3f1490d57ef6-e1d0e795734mr6866013276.28.1725549098372;
        Thu, 05 Sep 2024 08:11:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1d0abde5dbsm912135276.55.2024.09.05.08.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:11:37 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:11:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <cover.1725549065.git.me@ttaylorr.com>
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

This series adds a build-time knob to allow selecting an alternative
SHA-1 implementation for non-cryptographic hashing within Git, starting
with the `hashwrite()` family of functions.

This version is a small reroll from the original round which addresses a
handful of suggestions made during review, and also fixes compiling with
OPENSSL_SHA1_FAST with older versions of OpenSSL (having
OPENSSL_API_LEVEL < 3).

Otherwise, the series is unchanged from the first round. But as always,
a range-diff is included below for convenience.

Thanks in advance for your review!

Taylor Blau (4):
  sha1: do not redefine `platform_SHA_CTX` and friends
  hash.h: scaffolding for _fast hashing variants
  Makefile: allow specifying a SHA-1 for non-cryptographic uses
  csum-file.c: use fast SHA-1 implementation when available

 Makefile          | 25 ++++++++++++++++
 block-sha1/sha1.h |  2 ++
 csum-file.c       | 18 ++++++------
 hash.h            | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 object-file.c     | 42 +++++++++++++++++++++++++++
 sha1/openssl.h    |  2 ++
 sha1dc_git.h      |  3 ++
 7 files changed, 155 insertions(+), 9 deletions(-)

Range-diff against v1:
1:  e7cd23bf4c = 1:  e7cd23bf4c sha1: do not redefine `platform_SHA_CTX` and friends
2:  6ac6f934c3 ! 2:  3b5f21e4a6 hash.h: scaffolding for _fast hashing variants
    @@ hash.h
      #endif

     +#ifndef platform_SHA_CTX_fast
    -+#define platform_SHA_CTX_fast	  platform_SHA_CTX
    -+#define platform_SHA1_Init_fast	  platform_SHA1_Init
    -+#define platform_SHA1_Update_fast platform_SHA1_Update
    -+#define platform_SHA1_Final_fast  platform_SHA1_Final
    -+#ifdef platform_SHA1_Clone
    -+#define platform_SHA1_Clone_fast  platform_SHA1_Clone
    -+#endif
    ++#  define platform_SHA_CTX_fast     platform_SHA_CTX
    ++#  define platform_SHA1_Init_fast   platform_SHA1_Init
    ++#  define platform_SHA1_Update_fast platform_SHA1_Update
    ++#  define platform_SHA1_Final_fast  platform_SHA1_Final
    ++#  ifdef platform_SHA1_Clone
    ++#    define platform_SHA1_Clone_fast platform_SHA1_Clone
    ++#  endif
     +#endif
     +
      #define git_SHA_CTX		platform_SHA_CTX
    @@ hash.h
      #define git_SHA1_Clone	platform_SHA1_Clone
      #endif
     +#ifdef platform_SHA1_Clone_fast
    -+#define git_SHA1_Clone_fast	platform_SHA1_Clone_fast
    ++#  define git_SHA1_Clone_fast platform_SHA1_Clone_fast
     +#endif

      #ifndef platform_SHA256_CTX
    @@ hash.h: struct git_hash_algo {
      	/* The hash finalization function for object IDs. */
      	git_hash_final_oid_fn final_oid_fn;

    -+	/* The fast hash initialization function. */
    ++	/* The fast / non-cryptographic hash initialization function. */
     +	git_hash_init_fn fast_init_fn;
     +
    -+	/* The fast hash context cloning function. */
    ++	/* The fast / non-cryptographic hash context cloning function. */
     +	git_hash_clone_fn fast_clone_fn;
     +
    -+	/* The fast hash update function. */
    ++	/* The fast / non-cryptographic hash update function. */
     +	git_hash_update_fn fast_update_fn;
     +
    -+	/* The fast hash finalization function. */
    ++	/* The fast / non-cryptographic hash finalization function. */
     +	git_hash_final_fn fast_final_fn;
     +
    -+	/* The fast hash finalization function for object IDs. */
    ++	/* The fast / non-cryptographic hash finalization function. */
     +	git_hash_final_oid_fn fast_final_oid_fn;
     +
      	/* The OID of the empty tree. */
3:  682e4c2cc3 ! 3:  02764de139 Makefile: allow specifying a SHA-1 for non-cryptographic uses
    @@ hash.h
      #endif

     +#if defined(SHA1_APPLE_FAST)
    -+#include <CommonCrypto/CommonDigest.h>
    -+#define platform_SHA_CTX_fast CC_SHA1_CTX
    -+#define platform_SHA1_Init_fast CC_SHA1_Init
    -+#define platform_SHA1_Update_fast CC_SHA1_Update
    -+#define platform_SHA1_Final_fast CC_SHA1_Final
    ++#  include <CommonCrypto/CommonDigest.h>
    ++#  define platform_SHA_CTX_fast CC_SHA1_CTX
    ++#  define platform_SHA1_Init_fast CC_SHA1_Init
    ++#  define platform_SHA1_Update_fast CC_SHA1_Update
    ++#  define platform_SHA1_Final_fast CC_SHA1_Final
     +#elif defined(SHA1_OPENSSL_FAST)
     +#  include <openssl/sha.h>
     +#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
     +#    define SHA1_NEEDS_CLONE_HELPER_FAST
     +#    include "sha1/openssl.h"
    ++#    define platform_SHA_CTX_fast openssl_SHA1_CTX
    ++#    define platform_SHA1_Init_fast openssl_SHA1_Init
    ++#    define platform_SHA1_Clone_fast openssl_SHA1_Clone
    ++#    define platform_SHA1_Update_fast openssl_SHA1_Update
    ++#    define platform_SHA1_Final_fast openssl_SHA1_Final
    ++#  else
    ++#    define platform_SHA_CTX_fast SHA_CTX
    ++#    define platform_SHA1_Init_fast SHA1_Init
    ++#    define platform_SHA1_Update_fast SHA1_Update
    ++#    define platform_SHA1_Final_fast SHA1_Final
     +#  endif
    -+#  define platform_SHA_CTX_fast openssl_SHA1_CTX
    -+#  define platform_SHA1_Init_fast openssl_SHA1_Init
    -+#  define platform_SHA1_Clone_fast openssl_SHA1_Clone
    -+#  define platform_SHA1_Update_fast openssl_SHA1_Update
    -+#  define platform_SHA1_Final_fast openssl_SHA1_Final
     +#elif defined(SHA1_BLK_FAST)
    -+#include "block-sha1/sha1.h"
    -+#define platform_SHA_CTX_fast blk_SHA_CTX
    -+#define platform_SHA1_Init_fast blk_SHA1_Init
    -+#define platform_SHA1_Update_fast blk_SHA1_Update
    -+#define platform_SHA1_Final_fast blk_SHA1_Final
    ++#  include "block-sha1/sha1.h"
    ++#  define platform_SHA_CTX_fast blk_SHA_CTX
    ++#  define platform_SHA1_Init_fast blk_SHA1_Init
    ++#  define platform_SHA1_Update_fast blk_SHA1_Update
    ++#  define platform_SHA1_Final_fast blk_SHA1_Final
     +#endif
     +
      #if defined(SHA256_NETTLE)
4:  e8f5cbd280 = 4:  311fcc9596 csum-file.c: use fast SHA-1 implementation when available
--
2.46.0.426.g82754d92509.dirty
