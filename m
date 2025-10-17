Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F232F757
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725362; cv=none; b=ilEYjox7cXZ7ffToHvizTp8jk/SdYrvi4tKf2WVLDkUAmV+bBP1urC03qw5yDa5kEPeofNIY5vTScGg370WVG7ytRsXTF/WLnf+WDPHU+/l3M9/UW8zRdK2K5t90DSeJ6YX1aWcX3+4CWTq6X6L77a3BOW7J6Mk+4c5/KOm97Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725362; c=relaxed/simple;
	bh=HD3TNgpvlC5CwnUGeN2inVKwniRJHQ3cNrbZMKGloZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UL5Rs08QL+pvxnPXkTxecFP/ykqLndRAubFSd/6RGpSRnpJpLlNhqGf+WAzpgbePBSWSzyk5rTq8F9+GUEhU+YovjY4MaKedEK+8lB+TUcpZuHpA8m/nwaf+WLxVwcwjVMNqDe1EU2ANBfK+gM5Z8Tk3d5TWyoVZFFikK8ozWt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N10C8Uia; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nn9biIc0; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N10C8Uia";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nn9biIc0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9080C7A0127;
	Fri, 17 Oct 2025 14:22:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 17 Oct 2025 14:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760725359; x=1760811759; bh=rkX6IQoGwd
	9aRA1+oafR6DkPQJ7f3OiSDX9Lc/MW3jg=; b=N10C8Uiadvjn5wjc/LNs8XcJ43
	S9tSWf6Wr3+DisZ4ASaIQ9RcEjfgaLTLScHGXf6E0ubP31YmE0VnUh4wLZXOGTiz
	kAnvhePDW6B9qqgfR1HEonPnV7uU0Hjw0m/TW1R90YiuX473pjmMgqJAacbJPpbM
	eN/HA/ol3LEUhxrwhGFccYB5HuhWE42THZ9RKnVEl5UKTUsUYZsoqjb/sSnBV/r3
	2jj8cM++BaemAaMUPzJ4yTuE7t1xTXLSnHPzmG4SUeZa0VXruNMi0XXnrbmxO06Q
	+z9H0/UUAb1Hs9wwBPds1w+UE4M1RoipqT/r4fDIWtWvxHTNtUqtW3KdFxvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760725359; x=1760811759; bh=rkX6IQoGwd9aRA1+oafR6DkPQJ7f3OiSDX9
	Lc/MW3jg=; b=Nn9biIc0KD3ZSeI3yJm5FOKmdNl8bdSnscu79BFwsHYPAsa0Z1e
	Uj7mshzHtjAnq4hB2EODN3lZ94YUYcIYnorwVR2C3IUN819dnPk+jikcT4CYksSQ
	c5/Nr05nfi0AWyVzZh4T1kGT3yw8qF7Bx47fyRUhc6SHT1iXRNJDMYhKjOy9WzGH
	Wk/WlhqYCm+qrEkeP0Aq+3gaD/3ojU8qGi7QbyuiXy+XyYyONKO57SoN3M3Ocujf
	jI8hQAArGxsdCXmwQiHnk7dH8BOda93NOPphwLAQXhcAIoHTGwJLnOOTd3dD8Xvl
	tQleUglVs6D55mrhNWwdIKqPdXbuh+KQNlQ==
X-ME-Sender: <xms:bonyaFIQd21BebcehCTv3DiAKUMCycYkAFSx-rya6_9qqIS7AVCQWw>
    <xme:bonyaICFINcZWRcLp-ubhjpVuN_Lqm_n9smeT-G1gLfk8KrHpBOKzrGP_xFxgGlgC
    92FfsQv5_7sXg_AeZywi8RkSyuDqMlopBnn1uG3kd735uTRiY_Sog>
X-ME-Received: <xmr:bonyaGBq3IWDLSUN0hGu7GV0cs4tOQeh1K4pdBxQ80aP37NCGdthAIZxKzhK5JEalE7CDDKOKcaq17c8mEK-PWTjMPXxahb6530i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hjrghkvgesiihimhhmvghrmhgrnhdrihhopdhrtghpthhtohephihlughhohhmvgdvugdv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bonyaCC1jNxK--HEeHcXtF_2Fr6J5Ej8-iIFFm34dzNNFU__2ATfPQ>
    <xmx:bonyaJqbOUEDJM4I6exR-dJqFfXK3WcbIJf3Iig0Fc2nkPRvz9pWMQ>
    <xmx:bonyaEn2R4nCJReHcJMbIlyOpMTPH77PEIAYpBq5t-pktw8VQ9xGAQ>
    <xmx:bonyaBy7bsrD-lDpy_Uzv8CW7YidiYpedOXqKpEzLolrS5c0C8GI-g>
    <xmx:b4nyaCCcI9qS6UD473_TifhnBzZNv9iNhUnEBqf7K_ZX2iHYBdfB-dYC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 14:22:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jake Zimmerman <jake@zimmerman.io>,  Lidong Yan <yldhome2d2@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] diff: restore redirection to /dev/null for
 diff_from_contents
In-Reply-To: <20251017083641.GB4073661@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 17 Oct 2025 04:36:41 -0400")
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
	<20251017075153.GA4078773@coredump.intra.peff.net>
	<20251017083641.GB4073661@coredump.intra.peff.net>
Date: Fri, 17 Oct 2025 11:22:37 -0700
Message-ID: <xmqqzf9pz8uq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Looking at that patch, my biggest concern is: are we missing other spots
>> that need to special-case the dry_run setting? Because it's a regression
>> in a maint release, I'm tempted to say we should do the dumbest possible
>> thing that covers all cases and just revert this hunk from the original
>> patch, like:
>
> Here it is with a commit message and test, in case that is helpful.
>
> -- >8 --
> Subject: [PATCH] diff: restore redirection to /dev/null for diff_from_contents
> ...
> I didn't test, but I also wondered if this might be necessary to avoid
> actual external diff programs from spewing to stdout. Looking at
> run_external_diff(), we do:
>
>   int quiet = !(o->output_format & DIFF_FORMAT_PATCH);
>   [...]
>   cmd.no_stdout = quiet;
>
> so I _think_ it should be OK even without this patch. But again, I like
> the extra layer of protection here.

I do like this direction, in addition I really do appreciate your
thought above on optimizing ext-diff and textconv away when they are
not necessary (obviously outside the scope of the regression fix).

I also wonder if we want to get rid of the new code related to the
"dry-run" mode that we no longer have to use.  But as a regression
fix that wants to be minimum, I think this patch stops at the right
place.

Thanks.


>  diff.c                | 9 +++++++++
>  t/t4035-diff-quiet.sh | 4 ++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index 87fa16b730..687206f353 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6890,6 +6890,15 @@ void diff_flush(struct diff_options *options)
>  	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
>  	    options->flags.exit_with_status &&
>  	    options->flags.diff_from_contents) {
> +		/*
> +		 * run diff_flush_patch for the exit status. setting
> +		 * options->file to /dev/null should be safe, because we
> +		 * aren't supposed to produce any output anyway.
> +		 */
> +		diff_free_file(options);
> +		options->file = xfopen("/dev/null", "w");
> +		options->close_file = 1;
> +		options->color_moved = 0;
>  		for (i = 0; i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
>  			if (check_pair_status(p))
> diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
> index 0352bf81a9..35eaf0855f 100755
> --- a/t/t4035-diff-quiet.sh
> +++ b/t/t4035-diff-quiet.sh
> @@ -50,6 +50,10 @@ test_expect_success 'git diff-tree HEAD HEAD' '
>  	test_expect_code 0 git diff-tree --quiet HEAD HEAD >cnt &&
>  	test_line_count = 0 cnt
>  '
> +test_expect_success 'git diff-tree -w HEAD^ HEAD' '
> +	test_expect_code 1 git diff-tree --quiet -w HEAD^ HEAD >cnt &&
> +	test_line_count = 0 cnt
> +'
>  test_expect_success 'git diff-files' '
>  	test_expect_code 0 git diff-files --quiet >cnt &&
>  	test_line_count = 0 cnt
