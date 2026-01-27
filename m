Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF50278E63
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769499316; cv=none; b=A1JOpNWghadcIHRHJqHOpsKk/cxc267ihYxMuGEN6xIvTZ5L/vK9ZKwygYtLYpiHKNAsApDW33V19BFmddUxV23XvrUi4NV0sdoFSQVj3gaKk5clJBjXCNhdYCc9LbPEl1YO+zaFWvAk0pHOrvj4YHrlOlljIqQGzgis08P61ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769499316; c=relaxed/simple;
	bh=LcwLdsCXYkEwhfpkfdRuCFRR9bl9dIcrvF5VbpRvwb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXKqDhn12r0vffMKuQXjHnFK3jx2wrAPiJZCyZFvUiy6Hkhm29FfEBUlFOzxmsb7z5yIOVh+D4NcjhT1dh/9ilf9lX4Q1FJs4SBAgum/0clZnL59MjNBsgAc1mRnRg3ERTph19bVF+LmG+wrjHAisz3ypASHZQ1knqYwebNY14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iDl2owGC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LSHd+bhZ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iDl2owGC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LSHd+bhZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 76753EC0217;
	Tue, 27 Jan 2026 02:35:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 27 Jan 2026 02:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769499314; x=1769585714; bh=3L7aBEuJ8d
	TWoq3ixXrO/EfVkQ9WtCuC2Bv7PhGtbHg=; b=iDl2owGC0GkFd6V7i5gEaLmsVh
	cQZx9x+wWm/kLXMD8A/uTA4LP8q5LRpXpM4XvjW2cVbY8e0DcfrOZcXHdhNKjev3
	Uu2n7TEkEd27oSkrqdsalqCo7WeL/4BCanlAjxFxaiKgfQBMankAC3wbilk+H8R7
	5bHgWT+JiaVzh2rotORom5v+pT8+/2tif1bayUtEUcP9AdCxZNmnZXbhXcHaGqc1
	FaZOAvHX+nZ1SqMHOJPOaixACDZ9C7M1PNLhBpiAKSg1UWOXocIKhvg3xcVYkXov
	1zbWO6K6W+H07uE+MG0ZPLA0pQN4TPeNfvBOY91D+YKL83+aTaK4wE5GoD2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769499314; x=1769585714; bh=3L7aBEuJ8dTWoq3ixXrO/EfVkQ9WtCuC2Bv
	7PhGtbHg=; b=LSHd+bhZc8q4XroQP9HEeJ8sq9aDZ2UeakdfVK6SBOxSFve7HtV
	2oAMzGsXOfNknTCHXuTJgIaHZF7CvG/tg4szjvjV/heNW7KhrbM0K445Xc4+syrH
	F2wYh3vV1hK0ZCo4aJybLZ+ys9fJbAy7teZ81SsDxNYnvaYE70NFSH6Gq+3qzx5x
	L3rvBcn1UzWlMiP6wn374H9HnpMpgZvK84EQ9KJrvf1j8VALMU3+TUJ/MusvaLlJ
	XoTzj/2MqOzTtpjDhgx4Wg23xJqYkd14YhsUzxE4RvTnr8+I2B1XJHqISRlAZi+g
	bwX7ZkHDVppnUmhzbT7aM5D5ql5TZ3XM1Jw==
X-ME-Sender: <xms:smp4aaAJEE_-tfJ48ncEMdX6FlnUDhqk6hPBOG6a1IxZrgbxfSm0xw>
    <xme:smp4aba_Js2toWgZAiAkSNvbbt-LshYSVOxr9KWHxJE-UVCrnIjp194V_fDpW8E-g
    _GUDhlFC0fbT8Sw-DJVFm_I_YBmdR0WAY97xNa-0Ub72TKVywc2NA>
X-ME-Received: <xmr:smp4aV63l1zaGFjCajFYWyviUAY12L4fzOymGHpNTJU5JHssRtJoJ3TJ4ISO2KXXc19-jItmr0_raJBpNiDIFdLJ320Uzi47E7UzUPXVHxKb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheelleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvght
X-ME-Proxy: <xmx:smp4aUaxoM-g5KMmDhLoo0TSCiVdLd_HJji__fQ_TduEiUTSaPJR1w>
    <xmx:smp4acgbThx5gSeO3qXnnKdO41KqRwDfWkJvnCfWE7hePJmxXZDFPQ>
    <xmx:smp4ad_dk0o_-V2viYtEP2kqwZtsyKS5QRrqORL1BQu1Rt1RhcutxQ>
    <xmx:smp4afoZGdzqBhTfhDoFKkK3P_4SbR8SgBJZ9UAIHQTvbaaAMkE5kw>
    <xmx:smp4aQ5zsncF1oRxTq8qKvQejGf4VZmC2rCOY7s2EhDHNurZlziECThD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 02:35:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12b67d1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Jan 2026 07:35:13 +0000 (UTC)
Date: Tue, 27 Jan 2026 08:35:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 17/18] midx: implement MIDX compaction
Message-ID: <aXhqroubXFbnBgJI@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <13336e864f4ed3a6954b782f0bcc090d92ac722c.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13336e864f4ed3a6954b782f0bcc090d92ac722c.1768420450.git.me@ttaylorr.com>

On Wed, Jan 14, 2026 at 02:55:10PM -0500, Taylor Blau wrote:
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index c0c6c1760c0..043ee8c478a 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -195,6 +204,70 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
[snip]
> +	if (!from_midx)
> +		die(_("could not find MIDX: %s"), argv[0]);
> +	if (!to_midx)
> +		die(_("could not find MIDX: %s"), argv[1]);
> +	if (from_midx == to_midx)
> +		die(_("MIDX compaction endpoints must be unique"));
> +
> +	for (m = from_midx; m; m = m->base_midx) {
> +		if (m == to_midx)
> +			die(_("MIDX %s must be an ancestor of %s"), argv[0], argv[1]);
> +	}

These new checks all feel sensible to me.

> diff --git a/midx-write.c b/midx-write.c
> index ca2469213e6..afa077a09cc 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1120,12 +1216,23 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
> @@ -1162,6 +1270,19 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  		die(_("unknown MIDX version: %d"), ctx.version);
>  
>  	ctx.incremental = !!(opts->flags & MIDX_WRITE_INCREMENTAL);
> +	ctx.compact = !!(opts->flags & MIDX_WRITE_COMPACT);
> +
> +	if (ctx.compact) {
> +		if (ctx.version != MIDX_VERSION_V2)
> +			die(_("cannot perform MIDX compaction with v1 format"));

Right. So if the user has configured "midx.version=1" they cannot
compact.

> @@ -1354,12 +1491,19 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  			ctx.large_offsets_needed = 1;
>  	}
>  
> -	QSORT(ctx.info, ctx.nr, pack_info_compare);
> +	if (ctx.compact) {
> +		if (ctx.version != MIDX_VERSION_V2)
> +			BUG("performing MIDX compaction with v1 MIDX");

Isn't this `BUG()` redundant with the above call to `die()`?

Patrick
