Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA98622CBDC
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051815; cv=none; b=OCIXF5vuq4wcGn6d2BJLKM8FmQFdfyc0K1p0pmCwjCPtqJzPC+r/jWIaUVaeue98xAfEIHM6W/rw6esbq0P5QjPLnl7U6YhduVfuO5BWucay2Wu4K98yy5NvNTvl2V9S8Jz5B1dO1/q7to9sTo59OByei7FxvqsIcdEjUhpJTX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051815; c=relaxed/simple;
	bh=78Alyr1z/aXRTtYabRoUvz5HOR0CJx7QY5b7i9Qw4ZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=togUVm3VVMRNC/1cXx55oWWpei8a6Ml6CZoNLg0pUUiW3968jXTsGASoNSyTEhUZj36rblEuUj8ecOtVC+I1riG9osTVloyopgUYoQhrP4YFAPSj2R/OI6Yebc2dUIfcS9JJqic1//BwXo3ox4czaDTN6RVxmrBJ2c16cd3IZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IhUqXaLM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wRYm1cv2; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IhUqXaLM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wRYm1cv2"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1023811400F4;
	Thu, 16 Jan 2025 13:23:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jan 2025 13:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737051812; x=1737138212; bh=fWKHAbxgRj
	OZm3PRh5/nJ90uJpq3KCXO42PXn0A7kHI=; b=IhUqXaLMLa/fp3ws6CRlh0KVEZ
	vz850o1OQSSuoA8cKm8O5tTI6c+8Vo0t7IZ0DAEE/3lfOeoQfzrEkRSz0771p0q0
	i7HNiFTaCFOmzDY9/HSzGdSMvqViYw42mXvzQYsqnUTP28iL5w7Zc4YfOE72TDFw
	5HOm75Lj/FSmdnkA1/ocqPDu8cYKVkkwkGxPUNMVUofhOAaSu9bNVkNWv3Xi5w0U
	VcpfWNrMmFY0LGQkkiPPJKi1IEUhohdeSpkY7p3HKiQ+Oh/4U6fBKdd8lcNr6V6Z
	GAY9S5wBmHAt90yvanWqvOxtraPMWvG2Gum+pQtmmHy6//yBj6+f1CAZfwaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737051812; x=1737138212; bh=fWKHAbxgRjOZm3PRh5/nJ90uJpq3KCXO42P
	Xn0A7kHI=; b=wRYm1cv2P4+bG8JUtHI+i37bQ6YuBt2VGEO7QSxG5ZNJkqn/VGa
	opCajF8fNtMd8SIJ5KA4Qa0JivLmNW+lsM3XD4JyyZEzZT5xu3LCQsoV8VBGhKSf
	h95L+1dqbi1qaV80MDPDlMrW0fCmfB020yyyxPdO5rd9ECQSVCUKLMicJTeBgJit
	zO1Ez+J+x6TsM5cIoKQ5jRUq54YuuMkr2zQETDrqmPzjt9Qfi4ZmUdNt0a2T2D8U
	rwYzs6pdVbJeY1/qkVlMixi1IHuV1+FIaCVFpPGPBGIl5kG2nPcoAq52ptT2WCo1
	irygD/Mes4AFxGqz2+BQs+9bbCQOYWRzFfQ==
X-ME-Sender: <xms:o06JZywg-zjfUnPh5lvOVBJBcDD6EyX08_iwMzP35FaVeKresNuf4A>
    <xme:o06JZ-RWWvpm_9a6azNEoysk-wxUsWPbfKK3oGoEKFve3McVQVRE8Hv-PFX0OpPM5
    p-OYqdzJJEp0pTBWg>
X-ME-Received: <xmr:o06JZ0UvGIz0uQPYO6rTpvmkSAeOylGRnacX1AZ9pcZnvD1t7DJwSvU2h-YsgqoyoEB-jrNZc6UYT1d7kL7hHUfSRZMcEQGmgjAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprggulhhtvghrnhgrthhivhgv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:o06JZ4iKQw-ePFUhiN3jjUxMPhRLzZc9sXE0ohVo2OrgluDqUxC7KQ>
    <xmx:o06JZ0Dw2w80Ex279NkSttTZ_rArxOOo-u3r9OZ9HqA3dTxZtRRrWQ>
    <xmx:o06JZ5JnZdand4PKwmIs6EDsh3IJKYBXI00LeX2zzh4WgqTwcHcGJQ>
    <xmx:o06JZ7DWb-0Ousg93kGhxo9ozYpKW5_a2TdUsQfoRdQexiD1TPbMIA>
    <xmx:pE6JZ23oYC0qhz4NAS5dnymC0Wd_wgQwHYnyiQfq_-hy2i-AvW4UN8CQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 13:23:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  peff@peff.net,  ZheNing Hu
 <adlternative@gmail.com>
Subject: Re: [PATCH v3] gc: add `--expire-to` option
In-Reply-To: <pull.1843.v3.git.1736994932003.gitgitgadget@gmail.com> (ZheNing
	Hu via GitGitGadget's message of "Thu, 16 Jan 2025 02:35:31 +0000")
References: <pull.1843.v2.git.1735611513.gitgitgadget@gmail.com>
	<pull.1843.v3.git.1736994932003.gitgitgadget@gmail.com>
Date: Thu, 16 Jan 2025 10:23:29 -0800
Message-ID: <xmqqzfjqr526.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> This commit extends the functionality of `git gc`
> by adding a new option, `--expire-to=<dir>`. Previously,
> this feature was implemented in `git repack` (see 91badeb),
> allowing users to specify a directory where unreachable and
> expired cruft packs are stored during garbage collection.
> However, users had to run `git repack --cruft --expire-to=<dir>`
> followed by `git prune` to achieve similar results within `git gc`.
>
> By introducing `--expire-to=<dir>` directly into `git gc`,
> we simplify the process for users who wish to manage their
> repository's cleanup more efficiently. This change involves
> passing the `--expire-to=<dir>` parameter through to `git repack`,
> making it easier for users to set up a backup location for cruft
> packs that will be pruned.

Today I do not have enough time to do my usual commit log message
critique.  Please use "git show -s --format=reference" when
referring to an earlier commit.

> Note: When git-gc is used with both `--cruft` and `--expire-to`,
> it does not pass `-a` to git-repack to delete all unreachable
> objects as `git gc --prune=now` originally did. Instead, it
> generates a cruft pack in the directory specified by expire-to.

Is this less important than "we added --expire-to to gc that is
passed down to underlying repack" in the previous paragraph?

Not removing the unreachables too early with "repack -a" is an
essential part of the design of this new feature to allow us not to
lose the cruft objects, so I was a bit surprised that this was
described as a "Note:".

> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 370e22faaeb..b4c0cf02972 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -69,6 +69,12 @@ be performed as well.
>  	the `--max-cruft-size` option of linkgit:git-repack[1] for
>  	more.
>  
> +--expire-to=<dir>::
> +	When packing unreachable objects into a cruft pack, write a cruft
> +	pack containing pruned objects (if any) to the directory `<dir>`.
> +	See the `--expire-to` option of linkgit:git-repack[1] for
> +	more.

Does "When packing unreachable objects into a cruft pack" mean that
this option is only meaningful with "--cruft"?  As "--cruft" is on
by default, is it an error to pass "--no-cruft" when you use this
option?

"for more" -> "for more information" or something?

> diff --git a/builtin/gc.c b/builtin/gc.c
> index d52735354c9..8656e1caff0 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -136,6 +136,7 @@ struct gc_config {
>  	char *prune_worktrees_expire;
>  	char *repack_filter;
>  	char *repack_filter_to;
> +	char *repack_expire_to;
>  	unsigned long big_pack_threshold;
>  	unsigned long max_delta_cache_size;
>  };
> @@ -432,7 +433,8 @@ static int keep_one_pack(struct string_list_item *item, void *data UNUSED)
>  static void add_repack_all_option(struct gc_config *cfg,
>  				  struct string_list *keep_pack)
>  {
> -	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now"))
> +	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now")
> +		&& !(cfg->cruft_packs && cfg->repack_expire_to))
>  		strvec_push(&repack, "-a");

Hmph.  When "--expire-to=<there>" is given, we are dropping these
unreachable objects right away, but we said "--no-cruft", then we
say "repack -a".  If we have both "--cruft" and "--expire-to=<there>",
then ...

>  	else if (cfg->cruft_packs) {
>  		strvec_push(&repack, "--cruft");
> @@ -441,6 +443,8 @@ static void add_repack_all_option(struct gc_config *cfg,
>  		if (cfg->max_cruft_size)
>  			strvec_pushf(&repack, "--max-cruft-size=%lu",
>  				     cfg->max_cruft_size);
> +		if (cfg->repack_expire_to)
> +			strvec_pushf(&repack, "--expire-to=%s", cfg->repack_expire_to);

... we do the usual "repack --cruft --expire-to=<there>" in the next
block.

> @@ -675,7 +679,6 @@ struct repository *repo UNUSED)
>  	const char *prune_expire_sentinel = "sentinel";
>  	const char *prune_expire_arg = prune_expire_sentinel;
>  	int ret;
> -
>  	struct option builtin_gc_options[] = {
>  		OPT__QUIET(&quiet, N_("suppress progress reporting")),
>  		{ OPTION_STRING, 0, "prune", &prune_expire_arg, N_("date"),

OK.

> @@ -694,6 +697,8 @@ struct repository *repo UNUSED)
>  			   PARSE_OPT_NOCOMPLETE),
>  		OPT_BOOL(0, "keep-largest-pack", &keep_largest_pack,
>  			 N_("repack all other packs except the largest pack")),
> +		OPT_STRING(0, "expire-to", &cfg.repack_expire_to, N_("dir"),
> +			   N_("pack prefix to store a pack containing pruned objects")),
>  		OPT_END()
>  	};

OK.

> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index ee074b99b70..d4b0653a9b7 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -339,6 +339,12 @@ test_expect_success 'gc.maxCruftSize sets appropriate repack options' '
>  	test_subcommand $cruft_max_size_opts --max-cruft-size=3145728 <trace2.txt
>  '
>  
> +test_expect_success '--expire-to sets appropriate repack options' '
> +	mkdir expired &&
> +	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --cruft --expire-to=./expired/pack &&
> +	test_subcommand $cruft_max_size_opts --expire-to=./expired/pack <trace2.txt
> +'

As "--cruft" is on by default, the command line does not have to
have it, but being explicit is good.

Should we also see what happens when "--no-cruft" is given?

Thanks.
