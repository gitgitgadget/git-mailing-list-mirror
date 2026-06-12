Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A143AFD1D
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781294839; cv=none; b=fXKmLBjjzET+94WJ30frFZfewFx0VJF7rA42wCkXz6c7L8CjuisIWwRSumxV7xp/JqAuhvh72FSLScqR+sKmsE1V5kj5g53++0XRRDYQxscOiJBoJrPJ0Z1Cga5K0Q8h/epBb/d2T5KSHNazDHW/+ZSKNZT/0Uojo+BqIBoLfHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781294839; c=relaxed/simple;
	bh=n+gJCPMcEr6UO2nt6qKwxs2bNkmD91c8EfT/TPu5EhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7n1LN0r164fJPBXBvg9V4SW7ESKmfXyN6RuUj7TMlCh0EX6CD57KEENAUI31brFMbkbfa1v6NgJ7Tzni5Ljvn4JdyuOTFSqakS2TQogMrbrMi7S2FgzxMo5LcIipnn+yUvYMd8hO0Z/LPA5ZsH4Nr+g7yg93QBnZI85nr6CP64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Nu9NNHN9; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Nu9NNHN9"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7ddd3d67084so16229907b3.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781294835; x=1781899635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6+2l72HdIjxiYb615Ptb87/k/n35vWzCgI5reDoQYk=;
        b=Nu9NNHN9HxpkaMqSl27gOP5eM1D6cN5gbmksrN7/sjQEwSRYd3E7Tjg6jRTVKvDuZF
         WMI42X1Bcrs/Qb7yfdPf+YssVfEgYWshsslyCgF4vUPHCPT4JL6HrniKi6ur5rzOYFvW
         wcVc9CM3Iezu6bR2j2A1TEOclIeWz8YbmuZB+HzRdJGkw+07I5vY3PQdhwlriawULDB0
         AzeOcwbxBHnwyLXoHWJ1Pc4tcuNQh1F9/sr6D3XdczoSEeq3ZzsAGKo2nMa1PdWUEYUJ
         /sr8QyC1JAKC3DAcF5J3cIvKvu4DHel8dohPJ9W6NdBEZwdKp0M+PRefFEaicGxBRIip
         rKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781294835; x=1781899635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6+2l72HdIjxiYb615Ptb87/k/n35vWzCgI5reDoQYk=;
        b=j1uid94ZyO7tB4s192BkepwVWtwgaAjUkNnjOD4MO/tMSNkJOMEF0kCAr1dEubIDJv
         Rt08si8Q/SyEY6QI+LZr0rCpsZLCereXwdOMkiIezcx+IIDim+abcACLCJ9QWPHUgwaL
         OMBZWc+/4zl0wcU24OpSk51lZucnaVNYEBld1sAxuP6nXO7OtgHxOAl0U3aC9cQgTBEk
         bHFc42BjBCAiYyrLsYEmBpRt/BGFLgamJMZ3FJOJlNf+72zLivQYReWbRPBxdluR3PvE
         aHrelFuM32fkvA4IsaEQPIG2Coh7rjFNV5JS8+L/YpTYuj2vsx1dnKv6zrICbjLWYQ1n
         zL+w==
X-Gm-Message-State: AOJu0YwvSKwfPaPn9MCn/iLCpLp6F82stqUEKpGakZQ54MeIYcb/ryTB
	6gvgM+3b9S2nQdh5Zj52XaqU3Dqrfn6V+sYY9el5wOd8kxfons+PsaLKg4Irt8hPYDzRAWD8AoA
	x+mMf0Aw=
X-Gm-Gg: Acq92OHLcEvoVr6xuV+C+ckcX5omZ5ZLOsTQL1+F60m4kqZs9/aDb8o0Qg58JDIzJab
	lvSBky+VLJC50hP/3i2rf7PfYVFq8+ja91vF/nq3JaNXrwv05y0ZTHVYRLf9lAIKz9IX63VF0iS
	alDNXdGZLYDOGWj78kAfpEhjt9Vy7JqKSwA4QECKg1L06JLZjF4lhzJ/n3QN5qfe07VIkTZvuUr
	APZNgFnZOD6yrpkQ2/PYG9F6KdmCnS9Hs7/VBe9EFN/clt9vwOvkApLMkft501JjCegCpdqivZk
	vNlqPSm493uuaj1CrDBEtA6b2uRaggcktV7/fyNUUEOUlHfVJAyFbivptfE5s6dUzyEdhC1C75b
	ZlTfsKmrZwCvG5qIJhn6+zmNPVBmXmgoGJNe58b+bgBeUomvbowDOBl76VpgD/RuZiAXmA+yMx8
	2nIwx6FDh8lW3k+RKJTr9jBzVSBGOccBEKk2xBYLWB5wynaYc3OdNA7RDrgTbZP7BH2fxkGKWPE
	JuLkb+0/bwEi/CbF9b52nQ3jH9vvXlfLy9aEUoTbwHQHqLyhZoIqTjQXm4oLFTGcBQ8YkfCTAeO
	36Byl5UE/C/z0Hqh
X-Received: by 2002:a05:690e:1243:b0:660:6d41:df5d with SMTP id 956f58d0204a3-6627831d801mr3763738d50.46.1781294835510;
        Fri, 12 Jun 2026 13:07:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66274e5718asm1596816d50.20.2026.06.12.13.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:07:15 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:07:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH 3/3] midx-write: include packs above custom incremental base
Message-ID: <7bf7c87b60532a90c04c4a2404449a9d8ea21214.1781294771.git.me@ttaylorr.com>
References: <cover.1781294771.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1781294771.git.me@ttaylorr.com>

The previous commit made '--base' take effect on the normal incremental
write path, which exposed an existing assumption in our helper function
`should_include_pack()`, which is that any pack already present in
`ctx->m` was skipped.

That is only correct for non-incremental writes. For incremental writes,
`ctx->base_midx` is the boundary that should be excluded from the new
layer. If the caller selects an older base, or no base at all, then
packs from layers above that base have to be included in the detached
layer so that its bitmap has reachability closure.

Teach `should_include_pack()` to choose the MIDX used for pack exclusion
based on whether or not we are performing an incremental write. When
doing so, use `ctx->base_midx`, and use `ctx->m` otherwise.

The t5334 cases from the previous commit can now be marked as
successful.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c                            | 16 +++++++++++-----
 t/t5334-incremental-multi-pack-index.sh |  4 ++--
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index aa438775ebd..c50fdb5c6d1 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -133,8 +133,17 @@ static uint32_t midx_pack_perm(struct write_midx_context *ctx,
 static int should_include_pack(const struct write_midx_context *ctx,
 			       const char *file_name)
 {
+	struct multi_pack_index *m = ctx->m;
 	/*
-	 * Note that at most one of ctx->m and ctx->to_include are set,
+	 * When writing incrementally, ctx->m may contain layers above
+	 * the selected base MIDX, which must be included in the new
+	 * layer.
+	 */
+	if (ctx->incremental)
+		m = ctx->base_midx;
+
+	/*
+	 * Note that at most one of m and ctx->to_include are set,
 	 * so we are testing midx_contains_pack() and
 	 * string_list_has_string() independently (guarded by the
 	 * appropriate NULL checks).
@@ -148,10 +157,7 @@ static int should_include_pack(const struct write_midx_context *ctx,
 	 * should be performed independently (likely checking
 	 * to_include before the existing MIDX).
 	 */
-	if (ctx->m && midx_contains_pack(ctx->m, file_name))
-		return 0;
-	else if (ctx->base_midx && midx_contains_pack(ctx->base_midx,
-						      file_name))
+	if (m && midx_contains_pack(m, file_name))
 		return 0;
 	else if (ctx->to_include &&
 		 !string_list_has_string(ctx->to_include, file_name))
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index 69e96bf8d93..84ff6120978 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -119,7 +119,7 @@ test_expect_success 'write MIDX layer with --base without --no-write-chain-file'
 	test_grep "cannot use --base without --no-write-chain-file" err
 '
 
-test_expect_failure 'write MIDX layer with --base=none and --no-write-chain-file' '
+test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file' '
 	test_commit base-none &&
 	git repack -d &&
 
@@ -136,7 +136,7 @@ test_expect_failure 'write MIDX layer with --base=none and --no-write-chain-file
 	cp "$midx_chain.bak" "$midx_chain"
 '
 
-test_expect_failure 'write MIDX layer with --base=<hash> and --no-write-chain-file' '
+test_expect_success 'write MIDX layer with --base=<hash> and --no-write-chain-file' '
 	test_commit base-hash &&
 	git repack -d &&
 
-- 
2.55.0.rc0.3.g7bf7c87b605
