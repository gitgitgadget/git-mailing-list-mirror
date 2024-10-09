Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D471DFE2B
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505865; cv=none; b=j50RqB1DGjA6tJQTIqLk4LP2cVTcCtu6S2n/WNE3YKVAGYd3h2uoOkZEghZ/Hz5thnTt7d0uT1y1wBTDSY2rGmYZgB0v60yIyulhxVA19hX4110r2GalZCOizq/xvlCxnPSQ/ZuGB3nzuMyoFkQpl6CN1ajgwB3JwMc1wxfOpGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505865; c=relaxed/simple;
	bh=vKIPL9Fr/i9KtxXEyK7ZSY6cNCKrYkZAIgUa4+Z6/KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpjj0wq3KqMNntEGzmFT41dmG3bPcEY4w1GxACvaCMNP3IgXTuioxdMJgpTvoKBfRgMAJpS3EpygKzE8lvcabznuRXmVm5lJhV9ViRtdCENu40JdKRnxxU/fbNp0pK13agHfXq1HHdEwXt1Txt8FCoZ+dksc8S9f+DS1WUXrvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BPHWTig3; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BPHWTig3"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e2772f7df9so2377397b3.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728505863; x=1729110663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oFyixOplwrZsxrWxVQzNGlIn5uVn9Hg+dQ+hQe1FUK8=;
        b=BPHWTig3uyHzOxZdD13m1UFWwGp2EYmsN7x5foY6x0yhkVGN48mwbvqqSqiVot4Jib
         +mKd3En8vIm6+BayuB5Zx4h3lPsq/oUkN4rw0WHQAYOoCcM0UJQGl5ehOxMW6tzQsqD9
         3nGtYTor8yFj7/KFHGy5lmwvcsvrHJ2oS3jgXuTCfEZ9qWAFtzMnEeotKpLgbqOSJyHa
         n3vFPHuXERU1wsPezjDdvbsq5oFxPWsMyKcQRfPBT4TKfyHTK+nrq6TSUCy59PolhmwV
         E1xCY16dsGeKv8pBvB+Yn0E9ILsxh4RUrJo0oeKtTBc73iL2+f1OMF0sHBUKD66Y5zcP
         op5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505863; x=1729110663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFyixOplwrZsxrWxVQzNGlIn5uVn9Hg+dQ+hQe1FUK8=;
        b=dmHwvbmpRK2cNp6Ds3WG+p+LR5xpEzXlb/yCXK22jCiF6RCU0y2aQbtKKRdfsl2hLE
         FLqPWCORb8PIIPV8q4jaxSVMvg7xrI1HteYr+rY19aglcxcMbxweg7N7L6vZK3vdbIhI
         iK9mM3lU0k/uD0uQkbPKwnfIvBUQupnq/K3GXRUR4/lXnNq7B15IntXp38t/NxZOQjVP
         FSn3PpkXRk8euF8qASxX+5VnGAzOxTUpJFh4kJSI/3dT22oPOBBr3QUHrt4IjiyMJ0dj
         1/acM9IAtqvRl42clCiHcp1WBhdTWAtU+wPDdapalA1mZHG6C+jjivQn6hLQaxWrbzfU
         oaeg==
X-Gm-Message-State: AOJu0YysTGPY38lMZaRDpYM3N58L59oL7vR3AAhC5fTrbspKptnu0FAZ
	M5fyd9D0r+dBt38JKqYRbhRp554JocV3J61TJThVTDPZi1ifiVP8cFnv8AcSFLZFaiVTCPiW8H3
	XiVc=
X-Google-Smtp-Source: AGHT+IG+aEDbUa079rXBa/2VlHEGq1I5y29U9tEwF4DYXPb0NySbe96LYNKUZfGT99dxvRANtRKGZg==
X-Received: by 2002:a05:690c:62c2:b0:6b5:409e:654 with SMTP id 00721157ae682-6e32215c7f1mr47872947b3.24.1728505862846;
        Wed, 09 Oct 2024 13:31:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d937c4d9sm19881827b3.56.2024.10.09.13.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:31:02 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:31:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 01/11] pack-bitmap.c: do not pass `pack_pos` to
 `try_partial_reuse()`
Message-ID: <80f96385a7724fd2f8bf10c42ccce5b0b454a107.1728505840.git.me@ttaylorr.com>
References: <cover.1728505840.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728505840.git.me@ttaylorr.com>

The function `try_partial_reuse()` uses its `pack_pos` parameter to
determine if:

  - the object specified by that position is in bounds of the pack
    it's operating on, and

  - in the case that the specified object is an OFS_DELTA (and we're
    operating on a single-pack reachability bitmap) to ensure that the
    position of the base object occurs earlier than the delta

But neither of these checks are necessary. The bounds-check is
redundant because we are operating on bit positions which we know
correspond to objects in some pack, and the caller in
reuse_partial_packfile_from_bitmap_1() is smart enough to know to stop
processing bits when it is at the end of some pack.

Likewise, the delta dependency check is also unnecessary, because we
can use the object offsets within a single pack as a proxy for bit
positions in that pack's bitmap.

So let's avoid passing in this redundant piece of information, and
save one call to offset_to_pack_pos(), which is O(log N) in the number
of objects in the pack we're currently processing.

(This all comes from a discussion on a semi-related series from [1]).

[1]: https://lore.kernel.org/git/Zti0xrzCtpWScPjz@nand.local/

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9d9b8c4bfbc..706ff26a7b1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2054,7 +2054,6 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 static int try_partial_reuse(struct bitmap_index *bitmap_git,
 			     struct bitmapped_pack *pack,
 			     size_t bitmap_pos,
-			     uint32_t pack_pos,
 			     off_t offset,
 			     struct bitmap *reuse,
 			     struct pack_window **w_curs)
@@ -2063,9 +2062,6 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 	enum object_type type;
 	unsigned long size;
 
-	if (pack_pos >= pack->p->num_objects)
-		return -1; /* not actually in the pack */
-
 	delta_obj_offset = offset;
 	type = unpack_object_header(pack->p, w_curs, &offset, &size);
 	if (type < 0)
@@ -2121,8 +2117,13 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 			 * OFS_DELTA is the default). But let's double check to
 			 * make sure the pack wasn't written with odd
 			 * parameters.
+			 *
+			 * Since we're working on a single-pack bitmap, we can
+			 * use the object offset as a proxy for the bit
+			 * position, since the bits are ordered by their
+			 * positions within the pack.
 			 */
-			if (base_pos >= pack_pos)
+			if (base_offset >= offset)
 				return 0;
 			base_bitmap_pos = pack->bitmap_pos + base_pos;
 		}
@@ -2184,7 +2185,6 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 
 		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
 			size_t bit_pos;
-			uint32_t pack_pos;
 			off_t ofs;
 
 			if (word >> offset == 0)
@@ -2203,12 +2203,9 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 
 				midx_pos = pack_pos_to_midx(bitmap_git->midx, bit_pos);
 				ofs = nth_midxed_offset(bitmap_git->midx, midx_pos);
-
-				if (offset_to_pack_pos(pack->p, ofs, &pack_pos) < 0)
-					BUG("could not find object in pack %s "
-					    "at offset %"PRIuMAX" in MIDX",
-					    pack_basename(pack->p), (uintmax_t)ofs);
 			} else {
+				uint32_t pack_pos;
+
 				pack_pos = cast_size_t_to_uint32_t(st_sub(bit_pos, pack->bitmap_pos));
 				if (pack_pos >= pack->p->num_objects)
 					BUG("advanced beyond the end of pack %s (%"PRIuMAX" > %"PRIu32")",
@@ -2219,7 +2216,7 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 			}
 
 			if (try_partial_reuse(bitmap_git, pack, bit_pos,
-					      pack_pos, ofs, reuse, &w_curs) < 0) {
+					      ofs, reuse, &w_curs) < 0) {
 				/*
 				 * try_partial_reuse indicated we couldn't reuse
 				 * any bits, so there is no point in trying more
-- 
2.47.0.11.g487258bca34

