Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0B119F422
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754235840; cv=none; b=Ny5nw3i770ArK/FqAjKtX/yPZjEb0ptmFwZO+l1rRKu6KR8JTuOQL0I3lch1Zs0RzkF9s4wHyERdB99/7xIa6rUrzC5brmT0cOFzwSHxRucpKOysqKB8D8Bydjqbh6snaFX5b0sEBzabBUvt+q7WcUpAHjvVcg9BG5lYmqQeLGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754235840; c=relaxed/simple;
	bh=XCek2ugZN1xXF1E+JF9Cs8zMrTL4vi8gpL+K1bbQ6N0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LiH+snRNTtpPP/+1wxUV44kU17LnrxicTO8XT7cIyORHxHD9b8QyhDGU/lACV3+/oToBUAFPEWEb0P07onHgMwkEN2worzDw/SC3ru7E2gA4PNs/DELg8dxe90sdiiO5Ltpm7pZIJPVw9Gr/m1YXUVSRoCgkcv75uo7PFmZa2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WbqjTEkp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=moO0vFYG; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WbqjTEkp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="moO0vFYG"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E09D17A0054;
	Sun,  3 Aug 2025 11:43:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 03 Aug 2025 11:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754235836; x=1754322236; bh=Xz03JGbwkj
	fXH5P0OfpGjzoeBs20s4lsmq0xDuLjfLI=; b=WbqjTEkp4wU6eA8xlqBggaund4
	OUjxf8A3dXA4lXUKettg6Dp57vaMl/khX/76Fr+kHzfmd90E7rEMX4sRgvNRZL01
	OeynUo5yI6gbtmIA0EXvaJywJeZqf4xQ03gx00Oi4EhXJ17sGUkpr7Rj11R7qUK6
	QZu/iIWj/JbaMs3YQFPzyCp4fLuYE4p7aChxSsIJK6kXAe81I8TGq59LTnv/hiN9
	Q3d+opWnU7N3AoIQdwPQJbAkNtFVGSna0P8+wbIxYRKV0VtRnPwl8jhibOdVhmRM
	anoHK9glzrC4QobvUqoLXxAOXc/C3EWjVzEB6Bza6tq6mecRJ89NEc8wYXQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754235836; x=1754322236; bh=Xz03JGbwkjfXH5P0OfpGjzoeBs20s4lsmq0
	xDuLjfLI=; b=moO0vFYGiNdPtnbS9O0kT/TWOYHJSFylaL7dAJj8fBax+kWCLED
	cZ1HqxcdX4D/+rlAjMkE62laDDO1k/FY7Q6GSyP5uBHRwRNzrhv52Qcr/wfbuM+v
	GFuIxyLVNeX3zaHZABd066CEGjjS47iS8YSzLLy1ewbIdQZLBtUzuAgTf0OZay1a
	tNH+1ZY2+aIz19ul/NC9qcGrPutCEmAnLaeBZkOSCPZvp6MpU8BiQudukgZTKKUC
	61ymKUOhXfMyY9Uy5KIZmlm+PI0NtaJ1TJ0ZtptmG1lw2i10vlouxFQRIzOt9OVq
	BnG1HNYvqvjnxbMpwwaA24/6dh13eQ5CKAA==
X-ME-Sender: <xms:vIOPaM9DbSdOi_dL63AMCgjao-PT67StEsYBtqztyDDbzFta9FQjhw>
    <xme:vIOPaNIzCUKwotY3LndjuaD6K61-toETd5D-_dtoguTf4l4V_Nh6Hn5BYXefpqQdU
    gYFOJhF_HaG6ETXAw>
X-ME-Received: <xmr:vIOPaCcs_yetcrW-dh9kUf5Kn-FqMkaLiMYugbaWxiwGz6-7KScTrq9SP8LECnKRi_w3duFcoC6LB64uQZmjEHQAluJT6MAHo90IsNE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdelkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhihesrghrnhgvshdrshhprggtvgdprhgtphhtthhopehmihgthhgrlhesihhstgdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vIOPaM-lujV3PqC_WGC5d8b4i2g6291KafMlw0bS1ckeIcN-CKI1Mw>
    <xmx:vIOPaPqxdH01hqzzxxe8WMZlCpws3bnrm-H_VSMGw_cvn7lZdXZdaw>
    <xmx:vIOPaBDaFi8eCAnnR1xaKfQ47dDNb29ZrSKvj6-ozmB40Gk3okzIbQ>
    <xmx:vIOPaBw9M3o5o9Lw8ccLBcSFCRNynhbYo4K9umaV26V3Gq15agX-IQ>
    <xmx:vIOPaKA3ZicCriiKwutluGLZwbtc8Pa1mtXqUnq7TJbI3X-AJiJZpv6B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 11:43:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Lidong Yan <yldhome2d2@gmail.com>,  git@vger.kernel.org,
  hi@arnes.space,  michal@isc.org
Subject: Re: [PATCH] diff: ensure consistent diff behavior with -I<regex>
 across output formats
In-Reply-To: <20250802102249.GA3738980@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 2 Aug 2025 06:22:49 -0400")
References: <xmqqikjg47qt.fsf@gitster.g>
	<20250729081820.34626-1-yldhome2d2@gmail.com>
	<xmqqcy9io73j.fsf@gitster.g>
	<20250802102249.GA3738980@coredump.intra.peff.net>
Date: Sun, 03 Aug 2025 08:43:54 -0700
Message-ID: <xmqqo6swfm11.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> We already have the diff_from_contents flag which is used for
> --exit-code. We should be able to see where that logic is applied and do
> something similar. It looks like it happens in diff_flush(), which makes
> sense:
>
>           if (output_format & DIFF_FORMAT_NO_OUTPUT &&
>               options->flags.exit_with_status &&
>               options->flags.diff_from_contents) {
>                   /*
>                    * run diff_flush_patch for the exit status. setting
>                    * options->file to /dev/null should be safe, because we
>                    * aren't supposed to produce any output anyway.
>                    */
>                   diff_free_file(options);
>                   options->file = xfopen("/dev/null", "w");
>                   options->close_file = 1;
>                   options->color_moved = 0;
>                   for (i = 0; i < q->nr; i++) {
>                           struct diff_filepair *p = q->queue[i];
>                           if (check_pair_status(p))
>                                   diff_flush_patch(p, options);
>                           if (options->found_changes)
>                                   break;
>                   }
>           }
>
> So here's a naive application of the same technique:
>
> diff --git a/diff.c b/diff.c
> index 76291e238c..0fe6eb7443 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6845,8 +6845,28 @@ void diff_flush(struct diff_options *options)
>  			     DIFF_FORMAT_CHECKDIFF)) {
>  		for (i = 0; i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
> -			if (check_pair_status(p))
> -				flush_one_pair(p, options);
> +
> +			if (!check_pair_status(p))
> +				continue;
> +
> +			if (options->flags.diff_from_contents) {
> +				FILE *orig_out = options->file;
> +				int orig_changes = options->found_changes;
> +				int skip;
> +
> +				options->file = xfopen("/dev/null", "w");
> +				diff_flush_patch(p, options);
> +				skip = !options->found_changes;
> +
> +				fclose(options->file);
> +				options->file = orig_out;
> +				options->found_changes = orig_changes;
> +
> +				if (skip)
> +					continue;
> +			}
> +
> +			flush_one_pair(p, options);
>  		}
>  		separator++;
>  	}
>
> which works on a trivial example. It affects all of raw, name-only,
> name-status, and checkdiff. I know Junio said that --raw should not be
> affected, but I'm not sure I agree. Anyway, it should be possible to
> split the logic by output type.

This is much more palatable to avoid code duplication and
repetition, compared to what was posted before.  A new code that
loops over q->queue[] one more time (which is yucky but cannot be
helped due to output order as you noted earlier) and runs
diff_flush_patch(), like the one we see above, is probably the best
we can do.  The beauty of the above approach is that the new code
only needs to know about a single .diff_from_contents bit, and does
not have to care what features cause the .diff_from_contents bit to
be flipped on.  Doing anything more would be maintenance nightmare.

Thanks.



