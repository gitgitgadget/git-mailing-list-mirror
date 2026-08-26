Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3BB390237
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787508; cv=none; b=V6L2R6YgicTrkDgN3OWdPkuB9BJFF0nkQhV6/muH+c5CFnm7uFi4ZLw2GdqQHUzZshJAPk4ya1OlGydfMLPoZ1A6dNkieONmGCcZ5ABT3AS1f6zBuKvK9pKPsuBYmtJdzK0nU+w2CasYiWthywtxiTz2U25l/li6KBsG5uj+gW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787508; c=relaxed/simple;
	bh=tXe1bJW8cotQiqdQhSaiaf28AOD+WmodUgVIHsxBYf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsPqktSW3TsDWXw0HwtZW/wBVbsTbeVK397yYWeG5VjBuYLewJJU+vNjnRSrDQsiDZaN66gG81zfV9CrhynsELCNYH0kTyg+FXdvInHBnemh0Ni58yxpfsIKXQ4JyfPwdd/+gf+XcjbEe7L8iF+YdAl1Op4PpiLuF/iHJVUIFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=EiK7lWDx; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="EiK7lWDx"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-836c718715fso16787967b3.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 16:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1787787506; x=1788392306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mibiQDT9GeG6+z9PanXyvG93vHlD20tDcS8sPUjlY6g=;
        b=EiK7lWDxffSVwSPVJZ9ivWTfuyaK76OuQhWcFDcRcANXr4H33rlJQcQC86tG0zs21M
         cqkSVokoQs3Z843HhOG/KHz0eUsGTkNCygI9vD4V/n3cgcSeNn+bwIBI8fw8qGOcQ8+t
         hhTenlytDjkPw9twBkSpqLqYUSHCFEb82ZWhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787787506; x=1788392306;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mibiQDT9GeG6+z9PanXyvG93vHlD20tDcS8sPUjlY6g=;
        b=AJ/uXwuaEy2yzNc2cDk0aUtRHm7WlUgzEOsNLBK9gfBgCXIs941oyMs4tDcBmZlHw9
         umuuVUR9ySaGtLbGsQcLdVmoe2RvC54KoU4woM3lG0PDLLcUML4eQgHLBh7/PMOsOuFD
         ZXxrZ9xo0pX2JKGcOPgBXsiTo3BhgmPyp9BLagxWN+xphgdQKSsr9M1WewsuUdWzCzlZ
         XZeWpb0saNOTevYBhD/DWXhBm2Ege20iSQG/LzxI8EpYSctHLOp084Zaq/y0jUjod954
         8hDfOxF6HRPSe6XfWk0HJ7oiNDj9ZA5JvPlGVyeq6SGtdtM9EuHgRoiLFxvq56uXiYSv
         N2nQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZDIS3u5DnzlszvYY3zhdx2wTkIcGKPg71D15GAalVKAUYBekyNCZWrH/srEu9vm0eHF0=@vger.kernel.org
X-Gm-Message-State: AFuF++mnYxiawa2gqjt+ftY9aoD6odxUkjV2t4LnKgefSQqVFFTzB6pN
	9RiefSKupOMVnzB53DwPamVafNl/Af/jnOE8LFIaXFqTfQtFI1P2B9wo9rWFxfMSH34=
X-Gm-Gg: AR+sD12ojyV28mLygSn+LEqJGHJtcp5Q4/at/lA+hKK3S3joBqSt6jq7dk9k7zv0weU
	GGRXbWgRwuRvT6pgJGR6MLFOppAcz3+IlyaVx+N7pz3431PxJEjKigdmY81h7pJ4cdX2Z5eT/Vx
	MHrGmslM85S/5m8XCekTk2Sqq3t4LEkVbn6UQPZW2d+4fEAL+LJMtdFuKOuefDqdirWpHfU7q7x
	bdFuQxo62x4WlxYpuk4/PAzlmK0bqMjHbWQsdEMT+JiuiGVhr17WF/tBi1sY0NcjXeyrDUXhzuK
	ObH2I3JL7U1LVEdK4z/ewzVtW1KzAKr5pWvY2tn+jWBAGy6lar6NbztXAulqdw3MSmj9X9SAjzs
	gsoiJU01VRlOwl8+jNm9Fi3oZ42uSC6qpxLiC6v0lw07v4+bKr3ha6Mf8idJG6w2XqR/4ND8fDF
	rYDPOSQATG5rdHvoNmV1DQ4ubSSo1/JK3iMDRxspsub221QI7o2ixFj56b+GFC2ls3Rz2aQOLG1
	gIbHIxtz6so1OI15zQX5XI+f0n9oMuC/jyH5qFonCRE0qucDfrjUxVz
X-Received: by 2002:a05:690c:4b04:b0:845:d58c:cc8 with SMTP id 00721157ae682-8573fade218mr50132057b3.20.1787787506416;
        Wed, 26 Aug 2026 16:38:26 -0700 (PDT)
Received: from com-79390 ([20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85b6143f961sm1343517b3.23.2026.08.26.16.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 16:38:26 -0700 (PDT)
Date: Wed, 26 Aug 2026 18:38:15 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 3/3] midx-write: include packs above custom incremental
 base
Message-ID: <ao945zRwDt9ThFTG@com-79390>
References: <cover.1781294771.git.me@ttaylorr.com>
 <7bf7c87b60532a90c04c4a2404449a9d8ea21214.1781294771.git.me@ttaylorr.com>
 <an2FAWvyfX2LuGsG@pks.im>
 <an4uIQA09rDCwwBp@com-79390>
 <xmqqtsogd0mk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtsogd0mk.fsf@gitster.g>

On Wed, Aug 26, 2026 at 02:37:23PM -0700, Junio C Hamano wrote:
> Taylor Blau <ttaylorr@openai.com> writes:
>
> > `ctx->to_include` can indeed be non-NULL.
> > ...
> > The filtering still does the right thing: packs covered by the selected
> > base are excluded, and the remaining packs are checked against the stdin
> > list. But the comment is wrong, so I'll fix it.
>
> Has anything happened since we saw this comment on Aug 13th?

Not until you sent this message ;-).

I had a small reroll prepped that I had meant to send a couple of weeks
ago but never got around to doing so. When I looked at it just now, I
found that I wasn't quite satisfied with the range-diff in that the
resulting block comment was somewhat confusing.

Instead of sending a new round immediately, let me instead share the
comment that I wrote instead. Patrick (or others): does this comment
seem clear, or do you think there are ways to tighten it up further?

--- 8< ---
diff --git a/midx-write.c b/midx-write.c
index 66da608370..ff94076104 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -143,15 +143,31 @@ static int should_include_pack(const struct write_midx_context *ctx,
 		m = ctx->base_midx;

 	/*
-	 * Note that m and ctx->to_include may both be set,
-	 * so we are testing midx_contains_pack() and
-	 * string_list_has_string() independently (guarded by the
-	 * appropriate NULL checks).
-	 *
-	 * We could support passing to_include while reusing an existing
-	 * MIDX, but don't currently since the reuse process drags
-	 * forward all packs from an existing MIDX (without checking
-	 * whether or not they appear in the to_include list).
+	 * Note that it is OK for both ctx->base_midx and
+	 * ctx->to_include may both be non-NULL, but at most one of
+	 * ctx->m and ctx->to_include may be non-NULL.
+	 *
+	 * When ctx->m is NULL we are writing a new MIDX without reusing
+	 * any packs from the previous layer(s). In that case, we care
+	 * that both:
+	 *
+	 *   - the new layer's base MIDX (ctx->base_midx) does not
+	 *     already contain the pack we are considering, or the new
+	 *     layer has no base (i.e., it is a non-incremental MIDX)
+	 *
+	 *   - the pack appears in ctx->to_include, or ctx->to_include
+	 *     is NULL, meaning that we can include any pack provided
+	 *     the above condition is met.
+	 *
+	 * When ctx->m is non-NULL, we are writing a new MIDX that will
+	 * subsume ctx->m and thus includes its packs. In this case, we
+	 * could support respecting ctx->to_include, but currently
+	 * don't.
+	 *
+	 * The only caller of this function which permits
+	 * ctx->to_include being non-NULL restricts setting ctx->m when
+	 * this is the case. So in this setting it is impossible that
+	 * both will be non-NULL.
 	 *
 	 * If we added support for that, these next two conditional
 	 * should be performed independently (likely checking
--- >8 ---

Thanks,
Taylor
