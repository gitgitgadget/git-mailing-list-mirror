Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585F33ADB6
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420501; cv=none; b=KOTPvGCkvG8SD2TbAvf9Ny2bfx4/BDHGQXAkKPZgy9jKjT317hGtc2DAOR4d3fgvCacXgbyytBpye8kRb21xFIW0x0v5ApmlXFBIBf4ObdXJF+ImNT/mfBqrzLPAHnE1e7Hth6T4asBL+whiFr8gxcw1ajSXyP/8DAof63ZQ92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420501; c=relaxed/simple;
	bh=ztMaKIuyUgXN5CGk5qDEToBMaaYaQhzhHrPAtbbIMss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ohr+ngUPesSqh665TA/nxCKc9/aS0Gi9WM8uwKMzo5OXg6jedQ9LmcTPEV0AgNuun1ThkWLyt1THLb193k8+kIZRd7MKXW2W0n69R0l0y9cD5paP8Pd7a/1XtcdL5BHzK8L1kE50UowVh1KLFZpVGXyUKz8h5iYFxU39yc0EqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=RtvpKCFJ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="RtvpKCFJ"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fc174ada4so1048107b3.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420499; x=1769025299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/jvWHcJYcag41vKSf09WQcpRZAUUYzWcQ/NgU4BS0Y=;
        b=RtvpKCFJMue0dDg04gIGjHf6ekPPS5HsrjXuxVRRR06xLdTfNm9vf+ZKW9OEiKJ3IM
         CFymDSduRrd0sWvo7D3eQ+tc2k9GnzzwqTMJciYKrkRiuA9aEVm0kn829M4/kg11Vtp+
         XCuTbxWIBdQhjzOQV2ZTRMZ8SmmQ2tFNfyzzw8dJWjKpC6UMc8RBLClccfU19yQF5053
         hQAZBC/egt8kftUd0KUbi0mLkndofjfHcsIGw5RYkTmK/6yJsEyXfoaZ0B1DkM+HtgfY
         1X4sosv6lKxEOg9W5V4LC+RscoA5iuYjPPkHrSkUcNWGhGEEM6Tq7++xTYjJ5UMD4LWz
         8sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420499; x=1769025299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/jvWHcJYcag41vKSf09WQcpRZAUUYzWcQ/NgU4BS0Y=;
        b=LjOAMyc4xfBIGtnqyfEXsz/Vhgw3/tKjpIKs5m1tI3hpKxlnmB1K+Jhbdvg+5ggKlV
         PjhCK5zlT9xJXDpgg8bXzx2B3mC45+zhj5iVRiJOguWEtu9nfq0h0pctejNdNetQXiT/
         qWJKhJ2g/rOMaWfV4SxfZJX0yrWV/YomofoQYW0kUrjV0mBkTrWFg7F64BqgSgvcPqg6
         guWYwmUw/0n6j8FLnD397azfVQh4tVxV5AZD9gFwUm3Hz9MA0U7JIGD/2t5tUm2r0ucX
         w+pVOZpGU23TNt3GbxEOfqKSFKCWL4dJ7Fa4gDGPZ8Wy4c+yYYXdjj1PqerQT5xNptw4
         VkNQ==
X-Gm-Message-State: AOJu0YxqiTCkugbQMZbLkUh0jiWcQbe6v9FS5IazmicEfYNdZ/Yw0Kbz
	WLBFNWDOAxvX6keJsafOGIWHhqfLgIalIrwfMDqQNcPuOYM6A4FjAZwSx4JOPDWLKOGhLxm8Ug0
	DKs+QdgJboA==
X-Gm-Gg: AY/fxX6oyq4VIPPZpxhCGItma5WhJjAzq+ICMCBd1QOm9alAJGwynkS+WPKLS1qWuPt
	qzZEyUzerTKOzefemkdFtC50vJfnoOLh98a1AhQE+xZlTczLoWJ/bF7gXwuZ59YfpFQdnbG+bJe
	sPlrQHpc1c/dXFJbBV7DI4en8OlcjhzSxvree900I0GcvzUTcX6bxzDmWp0WGhShBnb/cHwRvLK
	KJeI7MtJCFk7i26b9fm+zoiEDtuq2NXuA3j5DVVxMFe41QwZrdqhWRk8wSiPANNgRIBUOlgstYU
	zEVSGnqIp2KOZZiryEAaGEzViHEwHaNa8JoWNMh68nZLsEmzNor0Jdjk8pKPWQdsW6jPKEiU6bz
	G93kX0Jl1YTa0ugdywXnFdAFRvcKbKa51Tv+/BYN8t8+Ar5YJUD2kuWk1Sizz1B/sKqIcR4yUlv
	xu0S8EtjrMGuYjZkQjpMZ3rIYPq2nvJouu8OUpEg3eWzpgM4qJAZCbFHnddpQ7J/GAQJbz5cfnN
	E+BbAU05B2hNPlYXa9LIa0ipXkX
X-Received: by 2002:a05:690c:dd5:b0:78c:69fe:eb1d with SMTP id 00721157ae682-793a197e096mr30449927b3.17.1768420499537;
        Wed, 14 Jan 2026 11:54:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6713e5sm93143957b3.29.2026.01.14.11.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:59 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:58 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/18] midx-write.c: enumerate `pack_int_id` values
 directly
Message-ID: <c6f8d323477e9e74ce038b111d400c706f535676.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com>

Our `midx-write.c::fill_packs_from_midx()` function currently enumerates
the range [0, m->num_packs), and then shifts its index variable up by
`m->num_packs_in_base` to produce a valid `pack_int_id`.

Instead, directly enumerate the range:

    [m->num_packs_in_base, m->num_packs_in_base + m->num_packs)

, which are the original pack_int_ids themselves as opposed to the
indexes of those packs relative to the MIDX layer they are contained
within.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index c54113cdc84..80334914d3e 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -935,11 +935,11 @@ static int fill_packs_from_midx(struct write_midx_context *ctx)
 	for (m = ctx->m; m; m = m->base_midx) {
 		uint32_t i;
 
-		for (i = 0; i < m->num_packs; i++) {
+		for (i = m->num_packs_in_base;
+		     i < m->num_packs_in_base + m->num_packs; i++) {
 			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
-			if (fill_pack_from_midx(&ctx->info[ctx->nr], m,
-						m->num_packs_in_base + i) < 0)
+			if (fill_pack_from_midx(&ctx->info[ctx->nr], m, i) < 0)
 				return -1;
 
 			ctx->nr++;
-- 
2.52.0.457.gb599f1ad4b0

