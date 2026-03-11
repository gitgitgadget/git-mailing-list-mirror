Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB5175A73
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265289; cv=none; b=Ldkn0GIpmUfQvTjY+nd1ASNANzCZf03KpS0SeddwXtGQQsC42bpXEAg0ZpRI9BUZ2RhDpLBHG2foAKKi+J27kNv77xGsVWNUhQqyMQPgcfRs4Fu7sZKyDwqK19MwnZ5u+f/qBwEnSdcAPqn/SB8Ya3ej1Lim+aqdlc7K2AlnlP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265289; c=relaxed/simple;
	bh=KFTk/gfLIBFgWKwJwkSL8KN1CX5eVHQbs8dVmZzl4k0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SccwkVSnW8+6My96ib4bHt2b6vWZSuk9LO2d6C8DeABEX7ELRiI4148bWpFfjKTWGn9HHyJVNC/uvIG2GGXa2OtJQULibg2LvNplGD8VyLxEjhLX9rqovgXmvhOLLA18+jdOnWBNgvw7j97b5ciyOTKCk/PYC2t5POQChbRUFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DPb6aySh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DO6gHCG3; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DPb6aySh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DO6gHCG3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 840D97A0196;
	Wed, 11 Mar 2026 17:41:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 11 Mar 2026 17:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773265287; x=1773351687; bh=oN5QyVn3v0
	kLdeRGKFRhY6t5ldhYdvhQKdwaM30F7kE=; b=DPb6ayShEVmDiEJ2DX0k1wvInU
	zmT+Vf/VWFJZJ6QjxRV1R2lmaSA8r2HDovctJQsrnyteBcW0fRGJjws0OZyCh0Oy
	hWbGSruSOirg5U3QKiZG9UYLlfMZ1vbsxi5POi8oJxDyu1WrvfoUCDlFOxyE/XVw
	ZVdTmZIWv3Awj6axleswRLHl+gMdMak1pulTFQ020bHo9haTDKP4o70pQCiUktYk
	FxKIz1LDTbRD2kJnEzwyIu+96yjsaLHnnIKV4nAdXiB4X/jIY7ytBkHx7o2lS+zy
	tsOAXCBHl3gb/1ZAytOxgwYg5hPpEpFZjtIvgSGHnH1dqy76axVXq1vpNMbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773265287; x=1773351687; bh=oN5QyVn3v0kLdeRGKFRhY6t5ldhYdvhQKdw
	aM30F7kE=; b=DO6gHCG3W9HibTsCjfxRPChHpQFu9m0atAswIPpnKN6Q48/J3Qh
	wFfiwPJn8IqQsSKsWimx0lXCsdOh4nWYr6P9piDyUVIzDA8yZa21urX5WFXUPg3G
	AlFLpQQXwWDJTjmIe8lfTaaS4NvTxP36G16arsFd7vSo8dD0/7qgbJ/e+vuFpyMW
	hemvfCEG3BChx11PD/9zscylAOPOo7tVYqadhzaqS+AfD0HeZtkdCvK5OV56d3f4
	aQaWRdc2w9V88U+avMvLMgI0uc/OPoFwvcaOV4FNFrPy4vtj+2UMhbEfJ2Dd6KCx
	Ve2lmt4Wlom9s1rGJhcaOBgdbproGsbCatg==
X-ME-Sender: <xms:h-GxadIQmig56_CO6Ln1CschS2OqGI19DNQ5heBTli5L9zFym87iKg>
    <xme:h-GxaQC8em1f4_Jpp8Rdy7l-rtbps_B3l-RLptjid0vFI750WziTa8pK6njX9SfQf
    sEbKhjbDhYHtt9D2tkpfAWLocDCzOKqCUCcrlGD0suNZNaa0Vr0_Q>
X-ME-Received: <xmr:h-GxaeCePNWJ41zQeBCq2JyWeZgtCYU0vTnWuvZMznkwif80ZPIqJvw3kcsD-ofa5PtpWtMeeE_6ExLor3iCvqrd40RWT90Wyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtohepshiivgguvghrrdgu
    vghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhih
    hnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:h-GxaaAPrn0-y41UDK7usLk5OyR_fQGBActEdVG1I6uooF8GpJnoJQ>
    <xmx:h-GxaRokvEFVk2itmxpDu556avMDzPrmlTnIUAp86ZGFf1E6FsQ-HA>
    <xmx:h-GxackUf926Oa_EQl_-Sqt1wbOe0hvG3jDz9nRT41ML8uCGNvk09g>
    <xmx:h-GxaZy3TUl1zwQce9eOj8VxFSC0yLTkq8ti4JBG7Et_jse_QlJWSA>
    <xmx:h-GxaVZHcJeueoXWesPsWRDfhALI_FrrFJ9lG5TohZQJnoymlatce-Y2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 17:41:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com> ,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC] t: allow use of "sed -E"
In-Reply-To: <xmqq5x72m4lu.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	11 Mar 2026 14:35:41 -0700")
References: <xmqq5x72m4lu.fsf@gitster.g>
Date: Wed, 11 Mar 2026 14:41:25 -0700
Message-ID: <xmqq1phqm4ca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Since early 2019 with e62e225f (test-lint: only use only sed [-n]
> [-e command] [-f command_file], 2019-01-20), we have been trying to
> limit the options of "sed" we use in our tests to "-e <pattern>",
> "-n", and "-f <file>".
>
> Before the commit, we were trying to reject only "-i" (which is one
> of the really-not-portable options), but the commit explicitly
> wanted to reject use of "-E" (use ERE instead of BRE).  The commit
> cites the then-current POSIX.1 (Issue 7, 2018 edition) to show that
> "even recent POSIX does not have it!", but the latest edition (Issue
> 8) documents "-E" as an option to use ERE.
>
> But that was 7 years ago, and that is a long time for many things to
> happen.
>
> Besides, we have been using "sed -E" without the check in question
> triggering in one of the scripts since 2022, with 461fec41 (bisect
> run: keep some of the post-v2.30.0 output, 2022-11-10).  It was
> hidden because the 'E' was squished with another single letter
> option.
>
> t/t6030-bisect-porcelain.sh:	sed -En 's/.*(bisect...
>
> This escaped the rather simple pattern used in the checker
>
>     /\bsed\s+-[^efn]\s+/ and err 'sed option not portable...';
>
> because -E did not appear as a singleton.
>
> Let's change the rule to allow the "-E" option, which nobody has
> complained against for the past 3 years.  We rewrite our first use
> of the "-E" option so that it is caught by the old rule, primarily
> because we do not want to teach our mischievous developers how to
> smuggle in an unwated option undetected by the test lint.  And at

"unwated" -> "unwanted", of course ;-)

> the same time, loosen the pattern to allow "-E" the same way we
> allow "-n" and friends.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  t/check-non-portable-shell.pl | 2 +-
>  t/t6030-bisect-porcelain.sh   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git c/t/check-non-portable-shell.pl w/t/check-non-portable-shell.pl
> index 6ee7700eb4..dd8af6d08f 100755
> --- c/t/check-non-portable-shell.pl
> +++ w/t/check-non-portable-shell.pl
> @@ -36,7 +36,7 @@ sub err {
>  
>  	$_ = $line;
>  	/\bcp\s+-a/ and err 'cp -a is not portable';
> -	/\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
> +	/\bsed\s+-[^Eefn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
>  	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
>  	/^\s*declare\s+/ and err 'arrays/declare not portable';
>  	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
> diff --git c/t/t6030-bisect-porcelain.sh w/t/t6030-bisect-porcelain.sh
> index cdc0270640..1ba9ca219e 100755
> --- c/t/t6030-bisect-porcelain.sh
> +++ w/t/t6030-bisect-porcelain.sh
> @@ -402,7 +402,7 @@ test_expect_success 'git bisect run: negative exit code' "
>  	git bisect good $HASH1 &&
>  	git bisect bad $HASH4 &&
>  	! git bisect run ./fail.sh 2>err &&
> -	sed -En 's/.*(bisect.*code) (-?[0-9]+) (from.*)/\1 -1 \3/p' err >actual &&
> +	sed -E -n 's/.*(bisect.*code) (-?[0-9]+) (from.*)/\1 -1 \3/p' err >actual &&
>  	test_cmp expect actual
>  "
>  
