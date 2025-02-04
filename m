Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7283A78F4A
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692936; cv=none; b=LbZ9VcJKXgEKRQI2ptuRCG2I0rz2dkQ+Rooj/GZyp44VZVidEAl9ZiyeyLqXv9FNXddhjZxXITEEGqg3uP5K0lL/hZ3NcKxD15MMyoB1WOizQ1RRH52qBEc6fCOnllvoZOrlDeqfsKYDtipOCKdJCOW7DSBLuvy7pwhrYmfmbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692936; c=relaxed/simple;
	bh=Z2jW3OxeMELSdYgJnCWV1IL1pwb2An4//k2TMY0hjj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GFvzValmQv8902bPxoK3/iIUs07m3UZh7COttvmGFmbON1NPMgBRyyQKl9ASWfA3YFBwoL466exab9++tBRbF3VnswMt7VSOUWPYHG+sIgNi9aeW5kYa1qC9rhnsOOdB6ofj6xXMBiFokirPiL5N6sozKHqNsMN1wQ9dKYWB/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gsKgJeVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KXg/F+zq; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gsKgJeVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KXg/F+zq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E67A2540122;
	Tue,  4 Feb 2025 13:15:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 04 Feb 2025 13:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738692933; x=1738779333; bh=MzgACVYbWP
	N2OXJvI+n/Vte146kEkUaBSvfrCsrAF3w=; b=gsKgJeVREjV6AWtaSTLU+ICaG5
	Egf9eh12N5nkG0BiawLQ4FayboU7NB5CnKEXmDZV1cs5nSN19a7KrTzP4H8tKQAA
	BCbRJNQorXppXAZ4zvdzckrJUxhaFBRkj3p7NGPw5MKLKz+30ZwTmSV5ib6wwq2y
	9NCPGy6dEtkVa+7g5blUypi/KzUwxUZmokVQou2/MSSjqVd+4uDMOpjLY7sZ3qbz
	OBdYh0P+ENLGGJ+kjb4boClABWJBNrwFNNTpZNj6fLU6kAMIF6vzEKzRck0ztq+j
	Av9YMpivfSEr7cAG9uVezN/XKxHXyifyPTKSjuxaiR5pAaEoDZuDEzWKOUPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738692933; x=1738779333; bh=MzgACVYbWPN2OXJvI+n/Vte146kEkUaBSvf
	rCsrAF3w=; b=KXg/F+zq5ouvXk/XvCFZKh4ucY6xCsj21QT1TgMZVXr7LJxxjd6
	RAkV/WqpbpmCT0m28zl6dQQfFbaOeHnet8dtN7IZEmZwzW9UF7qgBiHbpZ30UAxg
	w+RWFPlqvVIPn9oZvvN0tAdpLboIbzHr15Ul7Ni3EN9fnq1+osbXB+MSG/ypKrmY
	fOHqdM/71zR79Q5j2WGD8r3md6MsCv6ZbfnTKG+aNdsWXbMeJkmZuZKUqQt9ml9d
	aQXgvLPBAVFVe79HiEg6YgGkYIDOPxLqjLhAUT+OlCJaDgbL27IFX5qD+CTsDp5c
	RHfFzfg3aCrh3dTP2EinvveYmMO+AGfu89g==
X-ME-Sender: <xms:RFmiZzv7HvmFALdFc9V2gpzAoicgusa_IqkP-mIYbk42OjHNItPPGw>
    <xme:RFmiZ0cWQvRUw7xnaCqvTxQH2erLOzU4bwbb_NBI4yRwVzr5iTB5BWA8eKFpzroIn
    rfiKRKeCOy_m2vxOA>
X-ME-Received: <xmr:RFmiZ2ye-3Lp4ph7HBNJSIfQp1DB-a3a8jDBLfuh52AxQHpRdvNkhEkyMOVA0JZ6uH0Qy9Q6-obZPBKkyjm1SXLH_fNWJAW2QL6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:RFmiZyPo6v22yJVmqG7gQoUneADUghWr3cv2Z4O3ByLOJB58MFHxCg>
    <xmx:RFmiZz8NHMBmZ2-vHXxRnNrmvojw9CjdHx-3d6XF_KX_Va8OSAu3Dw>
    <xmx:RFmiZyXa0ljnWVbkYKTiLqzWLQfitTQVFG59b0LubtepPz4t-95FCw>
    <xmx:RFmiZ0exfeQqlKrDXtpVRyYhO7iMV4WvMV0bsiOskEC93zlE3Qj4nw>
    <xmx:RVmiZzyl_SBTmpKxPICccI9EV0iIeKOkhBXN1K_EWH_m-6XOgp626OHS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 13:15:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  peff@peff.net,  ZheNing Hu
 <adlternative@gmail.com>
Subject: Re: [PATCH v4] gc: add `--expire-to` option
In-Reply-To: <pull.1843.v4.git.1737704954987.gitgitgadget@gmail.com> (ZheNing
	Hu via GitGitGadget's message of "Fri, 24 Jan 2025 07:49:14 +0000")
References: <pull.1843.v3.git.1736994932003.gitgitgadget@gmail.com>
	<pull.1843.v4.git.1737704954987.gitgitgadget@gmail.com>
Date: Tue, 04 Feb 2025 10:15:30 -0800
Message-ID: <xmqqh659tw3h.fsf@gitster.g>
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
> this feature was implemented in 91badeba32 (builtin/repack.c:
> implement `--expire-to` for storing pruned objects, 2022-10-24),
> which allowing users to specify a directory where unreachable
> and expired cruft packs are stored during garbage collection.
> However, users had to run `git repack --cruft --expire-to=<dir>`
> followed by `git prune` to achieve similar results within `git gc`.
>
> By introducing `--expire-to=<dir>` directly into `git gc`,
> we simplify the process for users who wish to manage their
> repository's cleanup more efficiently. This change involves
> passing the `--expire-to=<dir>` parameter through to `git repack`,
> making it easier for users to set up a backup location for cruft
> packs that will be pruned.
>
> Due to the original `git gc --prune=now` deleting all unreachable
> objects by passing the `-a` parameter to git repack. With the
> addition of the `--cruft` and `--expire-to` options, it is necessary
> to modify this default behavior: instead of deleting these
> unreachable objects, they should be merged into a cruft pack and
> collected in a specified directory. Therefore, we do not pass `-a`
> to the repack command but instead pass `--cruft`, `--expire-to`,
> and `--cruft-expiration=now` to repack.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---

This hasn't seen any reaction for a while.

Does anybody have further comments?  Otherwise let's mark it for
'next'.

Thanks.

>  Documentation/git-gc.txt |  7 +++++++
>  builtin/gc.c             |  9 +++++++--
>  t/t6500-gc.sh            | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 370e22faaeb..0eac8e85f08 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -69,6 +69,13 @@ be performed as well.
>  	the `--max-cruft-size` option of linkgit:git-repack[1] for
>  	more.
>  
> +--expire-to=<dir>::
> +	When packing unreachable objects into a cruft pack, write a cruft
> +	pack containing pruned objects (if any) to the directory `<dir>`.
> +	This option only has an effect when used together with `--cruft`.
> +	See the `--expire-to` option of linkgit:git-repack[1] for
> +	more information.
> +
>  --prune=<date>::
>  	Prune loose objects older than date (default is 2 weeks ago,
>  	overridable by the config variable `gc.pruneExpire`).
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
>  	else if (cfg->cruft_packs) {
>  		strvec_push(&repack, "--cruft");
> @@ -441,6 +443,8 @@ static void add_repack_all_option(struct gc_config *cfg,
>  		if (cfg->max_cruft_size)
>  			strvec_pushf(&repack, "--max-cruft-size=%lu",
>  				     cfg->max_cruft_size);
> +		if (cfg->repack_expire_to)
> +			strvec_pushf(&repack, "--expire-to=%s", cfg->repack_expire_to);
>  	} else {
>  		strvec_push(&repack, "-A");
>  		if (cfg->prune_expire)
> @@ -675,7 +679,6 @@ struct repository *repo UNUSED)
>  	const char *prune_expire_sentinel = "sentinel";
>  	const char *prune_expire_arg = prune_expire_sentinel;
>  	int ret;
> -
>  	struct option builtin_gc_options[] = {
>  		OPT__QUIET(&quiet, N_("suppress progress reporting")),
>  		{ OPTION_STRING, 0, "prune", &prune_expire_arg, N_("date"),
> @@ -694,6 +697,8 @@ struct repository *repo UNUSED)
>  			   PARSE_OPT_NOCOMPLETE),
>  		OPT_BOOL(0, "keep-largest-pack", &keep_largest_pack,
>  			 N_("repack all other packs except the largest pack")),
> +		OPT_STRING(0, "expire-to", &cfg.repack_expire_to, N_("dir"),
> +			   N_("pack prefix to store a pack containing pruned objects")),
>  		OPT_END()
>  	};
>  
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index ee074b99b70..74f7bd09046 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -339,6 +339,39 @@ test_expect_success 'gc.maxCruftSize sets appropriate repack options' '
>  	test_subcommand $cruft_max_size_opts --max-cruft-size=3145728 <trace2.txt
>  '
>  
> +test_expect_success '--expire-to sets repack --expire-to' '
> +	rm -rf expired &&
> +	mkdir expired &&
> +	expire_to="$(pwd)/expired/pack" &&
> +	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --cruft --expire-to="$expire_to" &&
> +	test_subcommand $cruft_max_size_opts --expire-to="$expire_to" <trace2.txt
> +'
> +
> +test_expect_success '--expire-to with --prune=now sets repack --expire-to' '
> +	rm -rf expired &&
> +	mkdir expired &&
> +	expire_to="$(pwd)/expired/pack" &&
> +	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --cruft --prune=now --expire-to="$expire_to" &&
> +	test_subcommand git repack -d -l --cruft --cruft-expiration=now --expire-to="$expire_to" <trace2.txt
> +'
> +
> +
> +test_expect_success '--expire-to with --no-cruft sets repack -A' '
> +	rm -rf expired &&
> +	mkdir expired &&
> +	expire_to="$(pwd)/expired/pack" &&
> +	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --no-cruft --expire-to="$expire_to" &&
> +	test_subcommand git repack -d -l -A --unpack-unreachable=2.weeks.ago <trace2.txt
> +'
> +
> +test_expect_success '--expire-to with --no-cruft sets repack -a' '
> +	rm -rf expired &&
> +	mkdir expired &&
> +	expire_to="$(pwd)/expired/pack" &&
> +	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --no-cruft --prune=now --expire-to="$expire_to" &&
> +	test_subcommand git repack -d -l -a <trace2.txt
> +'
> +
>  run_and_wait_for_gc () {
>  	# We read stdout from gc for the side effect of waiting until the
>  	# background gc process exits, closing its fd 9.  Furthermore, the
>
> base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
