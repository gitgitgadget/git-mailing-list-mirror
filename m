Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8FA1C5D72
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754513793; cv=none; b=UGFlu5hMlfvGC9/8pC6rrZHmsafJRTcCr0RvqVlUgjyIzJURf+ExRnQhGc9BF3pRFYQYOH/Y+PsF8J+36LnPq0qsYJxecFqVNRj8Lx+lGPW9qtbRpYWbvAndgMUyydZI1ewTyVM+UmMBWyq75fC633SlC722V6bocua1Kv0pqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754513793; c=relaxed/simple;
	bh=X69hGs0cJiYuijpvAMDrwQjalnq/AeVD0yesuxQdDj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A4c4iGBCUdnwsovnMd1jKtuOM5ff1zrcrUTRT+7h1Jtrnc5uRVagviu3RFpryB4pNgVq346XVHxYZucG1elwTMKfx/78wCuJE5zzmxvtTzPZD4YLa0OktDdHOwK/BD55erTuX2nAJgEoz17oW0FTM0mc3T2rm5ImDOJSpEMb//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i7rGPkzH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lnE6mTYV; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i7rGPkzH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lnE6mTYV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 947AF7A0137;
	Wed,  6 Aug 2025 16:56:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 06 Aug 2025 16:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754513790; x=1754600190; bh=5Ll7dfEJUc
	9WHq4P3JnA2Hex20vQ7lnK5md9ZrAq+bY=; b=i7rGPkzHjs8S6vF+pJ6ISfF8to
	Ra2uv4+OhVY2KiV4uJUJ9nc1BOnlfvqjLrAKjCjsmJLxVWwwuW3yw5NYARqyGMBG
	iS/qxw1PcniwqS3Xga456QzzXsq/zFVaZFQCMjm53T5nWwXH3pIDon0i3hwKwqjU
	CPcTkatU+etgL2nzsFMwIcQbUP0Fy23tkOC5KeM5sAPC0J03IjBExvnHLQFX9M8y
	81o0K3bhbaGl2s/ls0GPwHjZD2I1EciWDMMwkJ57Ul48G8lU9haIxVIA9F9gSzCr
	8Nn9ibHFMJAik18sdnPCrG21wsSnlmWTcVYpPnZxD1eiKlcIGaKqx6ltnsBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754513790; x=1754600190; bh=5Ll7dfEJUc9WHq4P3JnA2Hex20vQ7lnK5md
	9ZrAq+bY=; b=lnE6mTYV8YJYC19BBCf4tnCtR3j/9Bpwhvse0rXnxEmBTIkfLEp
	VK/hWVTuNXCbXzugrVnxmyMqB9Wy47B9szozMCqiwbR735NrtOIe25uAPEeGrjJO
	uebfJybphRYhxXG1ucRy5nCm475qbaJLGmvUkkNYaU4x/Kdzfm7msvqJnTRuiymX
	LJpaD322sJOjE0L5MePN6UX9gc2DpxSZqJZ2JM+mjJzilgpIrgXPbEXXYVirEdjW
	YSF2GX6ors2IAnYmXh37CIIiCO9cmT/KKj6SqWS+frUn9mwJrLmtH+WFILYb9b6g
	MPU5F7l3NC/YPwFAz6oVspv+2kPdLFk5D5w==
X-ME-Sender: <xms:fsGTaK8DSC8RcykpcIR4zJY34WxiT7-WiEryCScyPexHM30Sy4EVsQ>
    <xme:fsGTaDImEEUFO4e0vuv2AAPC94PLCzqOUU57GrSRjGAnUAT1fIKkvatckCB164KEK
    aJ6kWvJXxPwb_9t2g>
X-ME-Received: <xmr:fsGTaAefNmC-Q6iMD3xsEoi_VSt2lcEvEH--JsMGl1W14DwkfhXLjwqx-ZptdxpUayJ6shlcOmiF8h-6y0aB3Sjj88FLZtMQsLkrnLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeltdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihlhguhhho
    mhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephhhisegrrhhnvghsrdhsphgrtggvpdhrtghpthht
    ohepmhhitghhrghlsehishgtrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fsGTaC_PCx0Gf11crpq4S9o6res7P811OP_TuqMLjXtj1gO818PPeA>
    <xmx:fsGTaNqPr0p2O0u1OijhbHFK9oi_8IrsbHCnzdI9ipJSZSy8oJ0_zg>
    <xmx:fsGTaHCS_j71CTqZQhlE26s8IADnNtb_ifZBuW6aQGtaOF8XGQxoFw>
    <xmx:fsGTaPz9AqgiFCB5elYJUOoWjyaoho7CR7OksayvrWQiB_z5jIIJMA>
    <xmx:fsGTaIDylNrxKLOSNzyxhsnDMwrnzLtU6O-FR0K62zJgZhjtPJGPjr9T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 16:56:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  hi@arnes.space,  michal@isc.org,  peff@peff.net
Subject: Re: [PATCH v3] diff: ensure consistent diff behavior with ignore
 options
In-Reply-To: <20250806123306.25532-1-yldhome2d2@gmail.com> (Lidong Yan's
	message of "Wed, 6 Aug 2025 20:33:06 +0800")
References: <20250803145155.57894-1-yldhome2d2@gmail.com>
	<20250806123306.25532-1-yldhome2d2@gmail.com>
Date: Wed, 06 Aug 2025 13:56:28 -0700
Message-ID: <xmqqpld8tbib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> +static int quick_consume(void *priv, char *line, unsigned long len)
> +{
> +	struct emit_callback *ecbdata = priv;
> +	struct diff_options *o = ecbdata->opt;
> +
> +	o->found_changes = 1;
> +	return 1;
> +}

"make DEVELOPER=YesPlease" would not be very happy, without

-static int quick_consume(void *priv, char *line, unsigned long len)
+static int quick_consume(void *priv, char *line UNUSED, unsigned long len UNUSED)

> +/* return 1 if any change is found; otherwise, return 0 */
> +static int diff_flush_patch_quiet(struct diff_filepair *p, struct diff_options *o)
> +{
> +	int diff_opt = o->diff_optimize;
> +	int found_changes = o->found_changes;
> +	int ret;
> +
> +	o->diff_optimize = DIFF_OPT_DRY_RUN;
> +	o->found_changes = 0;
> +	diff_flush_patch(p, o);
> +	ret = o->found_changes;
> +	o->diff_optimize = diff_opt;
> +	o->found_changes |= found_changes;
> +	return ret;
> +}




>  static void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
>  			    struct diffstat_t *diffstat)
>  {
> @@ -6778,7 +6810,19 @@ void diff_flush(struct diff_options *options)
>  			     DIFF_FORMAT_CHECKDIFF)) {
>  		for (i = 0; i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
> -			if (check_pair_status(p))
> +			int need_flush = 1;
> +
> +			if (!check_pair_status(p))
> +				continue;
> +
> +			if (options->flags.diff_from_contents) {
> +				if (diff_flush_patch_quiet(p, options))
> +					need_flush = 1;
> +				else
> +					need_flush = 0;
> +			}
> +
> +			if (need_flush)
>  				flush_one_pair(p, options);
>  		}

I am having a hard time understanding the logic in this loop.  Is it
equivalent to the following loop, and ...

		for (i = 0; i < q->nr; i++) {
			struct diff_filepair *p = q->queue[i];

			if (!check_pair_status(p))
				continue;
			if (options->flags.diff_from_contents &&
			    !diff_flush_patch_quietly(p, options))
				continue; /* no changes */

			flush_one_pair(p, options);
		}

... if so, isn't the above rewrite easier to follow?

The idea is that we cannot do anything with DIFF_STATUS_UNKNOWN
pairs (hence we continue), and when we are filtering output by the
"has the pair changed in a way that the user cares about?" criteria,
we check with flush_patch_quietly, and if there is no change worth
talking about, we do not do anything with such a pair, either.

Only when these conditions are not met, we call flush_one_pair() to
show the name or name status or whatever.

>  		separator++;
> @@ -6831,19 +6875,10 @@ void diff_flush(struct diff_options *options)
>  	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
>  	    options->flags.exit_with_status &&
>  	    options->flags.diff_from_contents) {
> -		/*
> -		 * run diff_flush_patch for the exit status. setting
> -		 * options->file to /dev/null should be safe, because we
> -		 * aren't supposed to produce any output anyway.
> -		 */
> -		diff_free_file(options);
> -		options->file = xfopen("/dev/null", "w");
> -		options->close_file = 1;
> -		options->color_moved = 0;
>  		for (i = 0; i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
>  			if (check_pair_status(p))
> -				diff_flush_patch(p, options);
> +				diff_flush_patch_quiet(p, options);
>  			if (options->found_changes)
>  				break;
>  		}

It is a natural consequence of having a helper that does the "quiet"
thing that we can now lose the /dev/null hack, which is very nice.

Overall, the changes are easy to follow and look good.

Thanks.
