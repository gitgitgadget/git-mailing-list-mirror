Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B153BFAC8
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156753; cv=none; b=r7bk0DCfDLmCaYFy8gN6tLQUJBaNOSMhiDTa4gQhCAdCtwGfKeEYamziQWsnYV2zOccM7S8TZADBMGhT+tecN+4AvU8jxFNZb/NoXpT7pnDBGVCL9R10vWGbloUTPwWII02HHi+/XTCPsIl2lzR6kjCWt2yVKLrlpPBl1IrTKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156753; c=relaxed/simple;
	bh=p21Fa10KqSCGCdQWcNILSFI+CGBq6Q95LY8j6kgnJJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW87fnHl+w/qP0TaSg9pBQohHHYhjKZDC541fFdHj8ROKPULXhvYjnMvsUGCCAeAZWYt5WrBXBqlImFD3di4EwGuO5VQ8m2+K8Jl+F6DT6Ssh4xs+xcxtRKJIFLTT7XaUn7L+xBs9wE2k5CUc0WhbQ+tiAlp49lnhYt9HsggxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oANAf3Fk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aEiVBJJ8; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oANAf3Fk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aEiVBJJ8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 37D251D00128;
	Mon, 31 Aug 2026 02:12:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 02:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788156747; x=1788243147; bh=9bpZcrc/Ue
	5BxPrLrtcb7Pv1fpdc52lfr3+ixLKlE6c=; b=oANAf3Fku7js4SIWF/YkpRt8XA
	qVkMCivEk8ZBAt3K1K2cbRop82yW82fX0ZSdQLuSUejDs/GR+rLMBLBEJFkTvgU2
	SVTeh4soVXQISul0p7brEf8y074i9MuhabfdtIDhJVaOtSqRilg0TOSqEdtmnQg3
	PPxRUk/0dUJrsCi1QwjhOgE3wr3zI4+UUMIQvhuXL0a7F/Ro5SSdugKkHlxmYv82
	SIkcNBIyuR46/0ekPlKTihJ4OsKeoTnpDQ1bz8+gMRB2XHhjlsWbiTZXRERxQNMa
	H94oHfykBGrP5cRnFl8gJv9I49eX3q7UmihBoEUa2GSBHi6wesfcGx7QsiWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788156747; x=1788243147; bh=9bpZcrc/Ue5BxPrLrtcb7Pv1fpdc52lfr3+
	ixLKlE6c=; b=aEiVBJJ8XIKRC+2IZ9hqjjkR1iRa6z0JGjQFSVNTAqQW873atP4
	iLA/WsgIGJXsdAp59eq6a0PS3rU63IDvJPCrVGIhF5cxjem1uBxxC/y0NJC/5v6Q
	lc2DYZ5Wel4VfPPfkGpxYo+A1+pans2TCJxAJ9afc//G9tz352jkL+0TwibsvQxv
	20+EUMPy037QEpqArjDnHSaTHxI8/cl8tCMzpc9moCh1LRpLiwCL+lcuQIDkXlnw
	AyQg9kIY8TpcmzlHp8IiZYKG4IudqCtR73FGAGMpuu2mcEMVe4lC6TOQyb/FhC6q
	1Bxj9cWbLzcJCclZMwIFD9vE5IfObSkyrcQ==
X-ME-Sender: <xms:ShuVaneeLssbUN3PTMzqA0OM-i0TqY-2dn9DF_FxvTkSe0uS4Rql3w>
    <xme:ShuVavdmuqshPD1rkS-XgSpJcOuKRPe7WG595ZmJkEXKmbAVMDxADGOtJ7dTqXXhA
    fC42rqhWYAKkLBiJVDuMkn6Ndlt62e7mYevKpq5HCwevoaOsByB5Q>
X-ME-Received: <xmr:ShuVaiyd15_OJGqqnAcuohpgLhJqeaWj_5uw5nveasNNRMzLQKEodwxm-gLJ6zLIny0IZw>
X-ME-Proxy-Cause: dmFkZTGnMRRrwJEcVmLFULNwgBQbr29XNmQfDAhr9mjIxkE2ocVjIJaEShW6WJltlz2FEy
    /6sC60G3yRwqLT3L8y1lSTCbi4KQx5YJvqgUEnlJUeTnI0su/B3gnc2tIXPgZpTYsbWwg9
    Fs+/mRHnHDJlc2/tGqbPyXbIa37XiPQnq7caEhMjVRMjcZ8ESVyvQHJDDFCiWArRTeONvv
    tQlSUyAoZnsRddlfiAGwevABdaFKxds0cGLln0OuCCWjw86ANsRAQQBWlpc55/varDo8MG
    wDGwxIBy/3i4QUH/rcETOXrU7LFUSLkwiSR2nt5Iq/K+AcdsXc/Wf4/r/+TVXpaJUlCLEK
    tn+lax+kQnMrWwJZ5x/i76glGKRj1ycLJZdnO7g2iiZ1WMHxcxYm9y+hEejlX8vlPFf+Ty
    KsFzFJgzF4j1BeO7XsJz5L4b5vsgF5/EAilHQ/bTTPQt5H9DVg1ysA2BV9dfTWEczpZG2h
    kbeABnUzPv5A0svz802SrYXXHZHAFCBrr1A4dZoI7qIGJUk5ntiu5DaqqNHm2n7wX1fIXS
    p8BZBNQwyYI3kPQw6ErC9b1yj2h68Or5fF1PFPsXQnH6ykMPDv/kgdJ8C2zwZetXLCE+Fx
    jHGiJfhFWhFivwV3xxV/+ifgATFV+FTaE8hgyJHm7STRoNCHIyIIPt98mCEg
X-ME-Proxy: <xmx:ShuVau_hQmHFvvCyfjBeWvcI5RgsRGIfSiD8Zw5BpXSEQ3Uaxr-Hew>
    <xmx:ShuVaijBf1Le41Djl2DuK-8kwIvt6kwfjcsjXZJ11mUZXERrsXwzMw>
    <xmx:ShuVatGNHPtGOz8uVA2GF047rU5Q0T46JTRcojMabqPj_3OVJRwTpA>
    <xmx:ShuVap-DGAES8WSQnAuL433oC0zUTgLN4PddiVY59I8ho-T1WaPJ2Q>
    <xmx:SxuVarDad1XFEgIWbDpYv1jsM8DXD_86XzsJrBufcf8gWAAw1rM5EfA7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:12:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 73a14af9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:12:31 +0000 (UTC)
Date: Mon, 31 Aug 2026 08:12:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 3/3] midx-write: include packs above custom incremental
 base
Message-ID: <apUbQ4S-zJGtBeu2@pks.im>
References: <cover.1781294771.git.me@ttaylorr.com>
 <7bf7c87b60532a90c04c4a2404449a9d8ea21214.1781294771.git.me@ttaylorr.com>
 <an2FAWvyfX2LuGsG@pks.im>
 <an4uIQA09rDCwwBp@com-79390>
 <xmqqtsogd0mk.fsf@gitster.g>
 <ao945zRwDt9ThFTG@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao945zRwDt9ThFTG@com-79390>

On Wed, Aug 26, 2026 at 06:38:15PM -0500, Taylor Blau wrote:
> On Wed, Aug 26, 2026 at 02:37:23PM -0700, Junio C Hamano wrote:
> > Taylor Blau <ttaylorr@openai.com> writes:
> >
> > > `ctx->to_include` can indeed be non-NULL.
> > > ...
> > > The filtering still does the right thing: packs covered by the selected
> > > base are excluded, and the remaining packs are checked against the stdin
> > > list. But the comment is wrong, so I'll fix it.
> >
> > Has anything happened since we saw this comment on Aug 13th?
> 
> Not until you sent this message ;-).
> 
> I had a small reroll prepped that I had meant to send a couple of weeks
> ago but never got around to doing so. When I looked at it just now, I
> found that I wasn't quite satisfied with the range-diff in that the
> resulting block comment was somewhat confusing.
> 
> Instead of sending a new round immediately, let me instead share the
> comment that I wrote instead. Patrick (or others): does this comment
> seem clear, or do you think there are ways to tighten it up further?
> 
> --- 8< ---
> diff --git a/midx-write.c b/midx-write.c
> index 66da608370..ff94076104 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -143,15 +143,31 @@ static int should_include_pack(const struct write_midx_context *ctx,
>  		m = ctx->base_midx;
> 
>  	/*
> -	 * Note that m and ctx->to_include may both be set,
> -	 * so we are testing midx_contains_pack() and
> -	 * string_list_has_string() independently (guarded by the
> -	 * appropriate NULL checks).
> -	 *
> -	 * We could support passing to_include while reusing an existing
> -	 * MIDX, but don't currently since the reuse process drags
> -	 * forward all packs from an existing MIDX (without checking
> -	 * whether or not they appear in the to_include list).
> +	 * Note that it is OK for both ctx->base_midx and
> +	 * ctx->to_include may both be non-NULL, but at most one of
> +	 * ctx->m and ctx->to_include may be non-NULL.

That reads a bit off. Should that be "Note that it is OK for both ... to
be non-NULL" instead?

> +	 * When ctx->m is NULL we are writing a new MIDX without reusing
> +	 * any packs from the previous layer(s). In that case, we care
> +	 * that both:
> +	 *
> +	 *   - the new layer's base MIDX (ctx->base_midx) does not
> +	 *     already contain the pack we are considering, or the new
> +	 *     layer has no base (i.e., it is a non-incremental MIDX)
> +	 *
> +	 *   - the pack appears in ctx->to_include, or ctx->to_include
> +	 *     is NULL, meaning that we can include any pack provided
> +	 *     the above condition is met.
> +	 *
> +	 * When ctx->m is non-NULL, we are writing a new MIDX that will
> +	 * subsume ctx->m and thus includes its packs. In this case, we
> +	 * could support respecting ctx->to_include, but currently
> +	 * don't.
> +	 *
> +	 * The only caller of this function which permits
> +	 * ctx->to_include being non-NULL restricts setting ctx->m when
> +	 * this is the case. So in this setting it is impossible that
> +	 * both will be non-NULL.

I feel like this last paragraph could be dropped -- it's something that
we could mention as part of the commit message, but in this function
here I think it's very likely to go stale fast.

Other than that I think this is good. It's quite long, but I don't have
any good ideas for how to tighten this up significantly.

Thanks!

Patrick
