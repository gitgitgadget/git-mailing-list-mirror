Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C38E2BEC5E
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723117; cv=none; b=ZBJmVvoFixje0TPZAC2fARWTmUuo2uAJ1I0O5H6o5j4anzCENscPigGAMoi0aRj7efhsfIkOOg4CWVpFIMy3KtH6QtEAtMg06RawUUTnjN7LCUxuLp36vitjJj9ZW495nEL5aotayJ454IFOqc8GgXvrDmKK44LYEVSIULMuuV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723117; c=relaxed/simple;
	bh=geqdts7bcdcjldgO3iMbeAiShDVE2i8o9K4iyUdwiM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mgz/wXveq8j59n8m4D/TXApAsOw0EY1BWW4RgRhwyQ1uT9EllowVBGsm8NAMD660GCS+y6IkB0SBq5F2wrtRuhKtMlbRLcr/3oX/qKh07UlI9hoXvIDRzVoHW/58yZ2iu0PN/7d8Td068GnQvnuFeyE/U/m2ln26B7xHa+9sk1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hmqaAs+3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h30QsF4S; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hmqaAs+3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h30QsF4S"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F6C91D0015F;
	Fri, 17 Oct 2025 13:45:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 17 Oct 2025 13:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760723114; x=1760809514; bh=hzkPD1X+lm
	WpNo2/oeXOAiJjvcsxEy1Al9m5mvaU+PQ=; b=hmqaAs+3o0OplVSDWGXrvdPSlj
	08LsgZ5oer+gbHZk66R2tVKmKPwniISr5g33qlPF6vhBgp70SeX9ydUK9RgTPbg5
	SVtMRVxixvO8UCEy5eT68gRTmj2jL5Fw90t2qF4K1IliLLJPPuaNzYlSWQpZ3wE5
	kWQckSW8mqrD1k3hwm1Y/PUlKCEB3CVDJb4616MBqWaS1LU0Pc98kyKSogeIMueh
	xdmwmqfKYEKwuYN5rm/SMe2qhXhwFzHv2zwJzyaocwJJc5VLary+IuJj28JqEX/z
	z0Xjl5IDdQmz4d119sokIGZx3Ew9StTHXgrHsCos4U585VsmXNwvGY4L+gtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760723114; x=1760809514; bh=hzkPD1X+lmWpNo2/oeXOAiJjvcsxEy1Al9m
	5mvaU+PQ=; b=h30QsF4S2w2e3jIzEPpNws8zY3IWMRG8VcokuUoNdUg8FtAVks1
	cZysKDTpm9fDXX6A1h7LRI+h8ZVS7ORXftF+61Z8mKvUBddl90S2emI63aIrdhrC
	oMu/Ekp/28xbVSWcRVD5gkI1ryK29U5Q7lK9/tv/7eileyxjTH50/0P/HlL8xmmp
	nM241HS61PbTlyXtrZdGPVS+C9ZDceACGgSn+bC3FuzeMQ47Oj/WI7F2qC5MJZYO
	9TJIplPQw6PgtZRT/CXwlJIxf1stY7woX3kRwQ2DGqRGzqVsNztg3BOXXqtYc/9z
	Lcps7B4vE0cFituYoGayuad3J2pMKca74og==
X-ME-Sender: <xms:qYDyaHSsE_PYAPlulTnYTadqq2GO7PN4o8k3JfXoElc1Ho2_unFBXQ>
    <xme:qYDyaPqLbdq0FA02sogx7BYL02yaUok5qxW_UNdI8xRdtX_KCtUHST52uZwztVelk
    V9zMdfKhR1qIjUl6OANg6xw32XD2ybT1igl4eDL5OEvP8mY8PFoqt8>
X-ME-Received: <xmr:qYDyaFLI8eVBSNCC1Ddl_UVV7u-TeWZ3cg9SynC_MWVHj_e05UNj9L2yIfoNyKSwWadtVbmqxxc6c6g_aaKSCHnaVH0Fsv4-dfvq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelkedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:qYDyaCohJW_iVeD0hw1yl9L-xZQ_LLCTWW6c98BcpH0sySFnmabOCw>
    <xmx:qYDyaNyXaOKl5w6WNYWiwLtLkZbaf5_mrDDR02lUGC1S79rc9ljgyQ>
    <xmx:qYDyaGOqxCl0EisWrhcugii1It8V-JVW4-NWlU9xrH08DKvMsuLmcg>
    <xmx:qYDyaC7GTr3mDjS1wArOG0RVdlw83yIuKObmzB65ffl2jrq3duzhZQ>
    <xmx:qoDyaDgXXEH4hWNWl3WuYcE9RdMWC_jiX252D-kIVk_i8D8cQRGAORrD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 13:45:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jake Zimmerman <jake@zimmerman.io>,  Lidong Yan <yldhome2d2@gmail.com>,
  git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
In-Reply-To: <20251017075153.GA4078773@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 17 Oct 2025 03:51:53 -0400")
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
	<20251017075153.GA4078773@coredump.intra.peff.net>
Date: Fri, 17 Oct 2025 10:45:12 -0700
Message-ID: <xmqq7bwt1kyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Looking at that patch, my biggest concern is: are we missing other spots
> that need to special-case the dry_run setting? Because it's a regression
> in a maint release, I'm tempted to say we should do the dumbest possible
> thing that covers all cases and just revert this hunk from the original
> patch, like:
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
>
> That would catch the bug here, as well as any others lurking. And it
> converts any missing dry_run from correctness problems (we definitely
> will not produce extra output) into optimization problems (we might emit
> data we do not need, but we can fix those separately). At least for the
> normal code paths. I think without those extra fixes the problems that
> b55e6d36eb tried to fix for "-I" would still be observable, but at least
> its fixes could not regress the other code paths.

Ahh.  I like this "stupid but cannot be incorrect" version even
better than the original one that introduced the "dry run" mode.

But once we go in that direction, do we still need the dry-run
machinery with diff_flush_patch_quietly() helper function?

