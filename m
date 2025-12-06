Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5962D4B57
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053101; cv=none; b=dn5z9gkVoKol4GFUbrxjiGUos5xzIB7ZQqqfh8PjuAO4CLo80ohNslpvg/o/I9yVD0WrJrwedAiEaK1oj677Uz2drRFA6Y9aBD80HGtAzV3RPm8kcCshGujQqCTFPeh0u+sJekAANwomCCqoPTrNyDy6PQgZ0DtioOwR1vN07Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053101; c=relaxed/simple;
	bh=EauQH2hV3GT0SNUc4WcOWJbvb68Mq6a4Vt5OEHfx+6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL/V9WA5PXqITzbeImJS6/iVJAFqBLQYP0NswOGK4ppjcenC9SwLHUxvxh+99gHMte4DUcXOvOtzj5cv9p3G7IOI5tHQj8bv8tPwBGsS0YUVW5l6qpOmz2DlyKMWEsjmMp7s+I3phZ5JW/Tgw64J+ASUoKLvESqe6JWwZ1dVKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=K0GUyfyh; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="K0GUyfyh"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64308342458so2952126d50.0
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053098; x=1765657898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Y/nV6TPOZl9lc4qfQDduztdvNBrZ56JqXLeAEURyMw=;
        b=K0GUyfyh3ppWqYMWLEH0iOm3K8xRfRmrs00LFJeW7tC3qI2nR2T65rg/jdmsFux6R7
         NC0jC69F3TVt2sPc+kJupAjuG/sO8XWfA2ai720HdMDmh93zTmkGHfOCxcldCeOzCZht
         20nAPSrKtf6ZoqiqtKrniUw7WCbN5xVu/yWYQEPqr1slHei0rPdU62nHqBMvG6x+KRRf
         uK8W8ekg4gqsNNpJAg0wIUG7ChmfyCJL0+DCjRqsotc6SmPwCQb9NvuJp73U+oUOD/3w
         3ZjLV1DqkFEwHPv+xggLZkrv6UtsJmmtCiAt1DCuf4dWbCYoEggDs6GiaJDt+D2o1Abx
         6Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053098; x=1765657898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Y/nV6TPOZl9lc4qfQDduztdvNBrZ56JqXLeAEURyMw=;
        b=eXIjW3GrJLEPv3PQN26scEji6hru7kT6wr5qFtL5qvYIKwilmKw+RnBqb9i4Ld7OAS
         yAUpHDGmu6FhOvDQWmZC+NEbrVUh2v0NtXX3zXEf+Y3kqOTA0vaFLTxRtzvOUKSMxxbs
         ItYh5VsuLwY80RpH99ByHZXnxwuzeWdB9mf4jntmpiy9gZCuNGJJA8AMHjVcGlfa5SMa
         2TIsoC4kP5v8r6YR3nH5m5o0OiKk59iBCequksunZaLh+46git+4+0msEtOaS/YSpFDb
         hNvPn2h6qxBrT6JsS39vFvXQydLaK2UGHRyge5z5eScWwwtBgI19vtH6z9WhxsriopG2
         yDzA==
X-Gm-Message-State: AOJu0YxLLU3oyxtx50BUw6zYl6M2VbqhbM2LD+U9wJMVfyahABS/ky3s
	8piKoUuXvrAqPnIAV7M6R7sD9j+3yjqLS4PhW7+vSGLShhsDFHyz21E3d2fLV1553nnPuC3s+am
	lI8aaUzM=
X-Gm-Gg: ASbGncsUX/K1Xh7dVyQeNNNTkABb5a1IrvGRsl3kX9g3FFi+fv5jhcNrFToLfuP+XCR
	uVM6ScM8IGaJcfDC0mlDuaw6vUWboSlJuuubdA+ckOcdlVssp0XTDAKb1lCgmTZk3Ive0LOLC/c
	eF/5PtVt3PE/BcY2EUdQVgrPdwyu0ANVZjjByX3rNHg5XeSmDlddCUSEBKuWY30hcujOU4lZLXP
	zavkPi19dN5pum2fyJ1u+yw0gLuj2qwp02QELeFHwdMLILTg88zMkQewWvVZ55CCNIgLVK56Qn7
	BKR6qGWZrNkOI26j6+P33Z2cY2Wu4Pui+xx0qGbj/yit39/S1JaAFdRNsvZ5ZxyMh3cfDNAXtqH
	1sJQKxMmwWixRimDSrP+0Yx3bdxck8Au6KP8EW9Hgb79uahn0iIbxiQpLZNS7tNBZDRkkrrl6jn
	2mDcSjnGAMADMCPdHrMjQDAXNdNzGhI9bmtCkFNudWPWAwhpIAeIYDIeIZ5ocQJkB1CDv4vTB+p
	ieOe2NtUUMoTGg6TQ==
X-Google-Smtp-Source: AGHT+IFFS78a6/uCtWnQzawc86NE1UromoBHQCyYCAuG2k1Bu3U/f4fKGPSSHUenGh/i+1NZHR1gIg==
X-Received: by 2002:a05:690e:4362:b0:641:f5bc:695a with SMTP id 956f58d0204a3-6444e7cac7emr1772338d50.70.1765053098529;
        Sat, 06 Dec 2025 12:31:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b77942bsm30398077b3.27.2025.12.06.12.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:38 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:37 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 13/17] midx-write.c: enumerate `pack_int_id` values directly
Message-ID: <8288afd8cc40a56999353643f49c48d610e6b3aa.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

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
index 5927691f6a0..d3644276aad 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -932,11 +932,11 @@ static int fill_packs_from_midx(struct write_midx_context *ctx)
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
2.52.0.171.gd6a4e6b6955

