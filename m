Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B835E38886D
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108025; cv=none; b=jtGGo9vZQMYRkoK2Nh8Jn1aNU0GktHEhFmdLNY1W37NXucOeJgDg60mYD+2YQMv0Upo0mjV2dHcXmBla+8T7gpZQGnOkjgQSTOVMA+vp0Ykm2RrX86wsNsk+cKYlx8BUpFEViIa0gOZluu8XqftmBLAm34uk0nyx2liScc1WYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108025; c=relaxed/simple;
	bh=0xL+g38S+1InzCnGUFpcyjQpsxhvNUUs6KU8n6GlI+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kW1/q8A1naX62Bv7+sNs7RUYkBtesMuvgXw0BatCDd4f+gQ5mqc+zoqY7Q95JkjjulM6d8WW33mBxmO/TzC2pnAw/1rk0naYIG4fa1wR5beaSLnch68trMdTAGf5iJQP982fo+DS7d+lwzIWH0koBxT0/6499QoRrhECvKiuFlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N3dnWNNa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m7KSMCDo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N3dnWNNa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m7KSMCDo"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FF1C1400137;
	Thu, 22 Jan 2026 13:53:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 22 Jan 2026 13:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769108010; x=1769194410; bh=esSycdZPci
	QP8M9hShDKXOYLy60vSRM5JSnzA/XJTEE=; b=N3dnWNNaz64lPzeNMuebUj67Za
	53uRUpr164LtMfqRnGFC0ZbiFzcVadlV00Bpc+pXgKQlMBE2Dw0LyqKXWcIzJsRa
	OhRrHBzX3noOfXmJJaAWM9f4TzSrT1qRKolvrgctDnK5ovzEYvgJ8bENOQXe/tHN
	kpuCwWdrR9XIvhD/smHglZqMNgxAnAummMwi/0CEJyiUD7D9FuePDio03nH3UPgF
	oLEIBOdbbCaXAKbaTxSJ7e75g83MER4ae2dOgixaF9hgdppsP3LqyE9Bp0GXtBIs
	YwlMJSzrx5Wa7i00CX8iIiGR8KFRsbXyLmMscKj3mEFTesE7OtOG7tF0jKIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769108010; x=1769194410; bh=esSycdZPciQP8M9hShDKXOYLy60vSRM5JSn
	zA/XJTEE=; b=m7KSMCDoOUc2mKbCgkbe4A9+b/E8u+cet5j3ch9DftnUm18FfCg
	44Suq7GUQ7c9b9ZELJSVr2LtZX/238sEomGgGO1yRaC+bq+dLT+3uMdHVcPTPz13
	EOvu/prBGJOuFvTOB/hADn+qd81cIsDHRYAuyTki3kEK0b/Fi1EWqRPgHSO5IEGk
	FyguwZiCO3TBj8T60Aplz1GK29bjDAeHdbRMAR3rem0SyWYjN0E9gbFQMT9Z638O
	Nr0NzbirzAwtQzD+YuIGNJyLEIhIhiLqBoufwgreclIUySHqVFIDwXA1qg2VXv/g
	CsMigWcWxR4WPovx8mnK0QTG99hYtu25OqQ==
X-ME-Sender: <xms:KnJyacn4j5zGfa6MV98VDL3SXzdAXqeeW8GNAQ8i-jhW4NQmBgJh-A>
    <xme:KnJyaS1ETA3bHB0WMdONla6iGMl-tB6BSs-hyDKx-_XQt5UKWoT6-OI9NEFaW_IGr
    iRH8m51UWsGIPzSJX93e0MXd4gs35NYDbRFrMXbrsvIfUCztStV5n8>
X-ME-Received: <xmr:KnJyafqCH3xyWvZn-dHrVMWYr9r5mMhQzugc13-iBFFAxsEVxGr9esp9snogznFisj_2huN1RIdK2a7pfgdgNwV5PEq7BouPCvJL06k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeileefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KnJyaXdur4wp5ux8vs1GpyzqmscZDsZ9wT3fE9vUYAEMNSusW76euQ>
    <xmx:KnJyaWoo5ji1qpaBEBM4WgzAIt9gah0j_KCuVJsdgDzSbw2aJUbmoQ>
    <xmx:KnJyaQG_nH5KAyufhRTcNEukGFDag4UgTjzwNSxQEgR6aYvFI_x4jA>
    <xmx:KnJyaetMLzcDCU6GKfnesST285Ax5JJAyz98ORudahe51ROubTOuoA>
    <xmx:KnJyabJl7FTbk0GnW-YyXocvrCWkkaQPNIDdp4CG9OqFjiDqED7MnnOK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 13:53:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v27 0/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Thu, 22 Jan 2026 15:37:18
	+0000")
References: <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
	<pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com>
Date: Thu, 22 Jan 2026 10:53:28 -0800
Message-ID: <xmqq1pjho4wn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

Before these list of CC's (which does not seem to have any effect,
by the way.  The message is going only to the list with your
personal address on CC: and to nobody else), ...

> cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
> ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
> cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
> kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
> cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im cc:
> Jeff King peff@peff.net

... please summarize

 (1) what this series of patches are about, to help those who
     encounter these patches for the first time, and

 (2) what changed in this iteration (v27) relative to the previous
     iteration (v26).

I happen to have seen your other message so I can guess this is
about deduping when more than one comparison target is listed and
some happen to become the same branches, but others may not have
seen that other message, and it is not helpful to just dump the
range-diff and force them to read it to deduce what you did.

Thanks.

> Harald Nordgren (2):
>   refactor format_branch_comparison in preparation
>   status: add status.compareBranches config for multiple branch
>     comparisons
>
>  Documentation/config/status.adoc |  20 ++
>  remote.c                         | 192 ++++++++++++++----
>  t/t6040-tracking-info.sh         | 337 +++++++++++++++++++++++++++++++
>  3 files changed, 512 insertions(+), 37 deletions(-)
>
>
> base-commit: b5c409c40f1595e3e590760c6f14a16b6683e22c
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v27
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v27
> Pull-Request: https://github.com/git/git/pull/2138
>
> Range-diff vs v26:
>
>  1:  27a46f8d9c = 1:  27a46f8d9c refactor format_branch_comparison in preparation
>  2:  caa761f615 ! 2:  0993420fc1 status: add status.compareBranches config for multiple branch comparisons
>      @@ remote.c
>        struct counted_string {
>        	size_t len;
>        	const char *s;
>      -@@ remote.c: static void branch_release(struct branch *branch)
>      - 	free((char *)branch->refname);
>      - 	free(branch->remote_name);
>      - 	free(branch->pushremote_name);
>      -+	free((char *)branch->push_tracking_ref);
>      - 	merge_clear(branch);
>      - }
>      - 
>       @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
>        	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
>        }
>      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
>       -	const char *full_base;
>       -	char *base;
>       -	int upstream_is_gone = 0;
>      --
>      ++	char *compare_branches = NULL;
>      ++	struct string_list branches = STRING_LIST_INIT_DUP;
>      ++	struct string_list processed_refs = STRING_LIST_INIT_DUP;
>      ++	int reported = 0;
>      ++	size_t i;
>      ++	const char *upstream_ref;
>      ++	const char *push_ref;
>      + 
>       -	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
>       -	if (cmp_fetch < 0) {
>       -		if (!full_base)
>       -			return 0;
>       -		upstream_is_gone = 1;
>      -+	char *compare_branches_config = NULL;
>      -+	struct string_list compare_branches = STRING_LIST_INIT_DUP;
>      -+	struct string_list_item *item;
>      -+	int reported = 0;
>      -+	size_t i;
>      -+	const char *upstream_ref;
>      -+	const char *push_ref;
>      -+
>       +	repo_config_get_string(the_repository, "status.comparebranches",
>      -+			       &compare_branches_config);
>      ++			       &compare_branches);
>       +
>      -+	if (compare_branches_config) {
>      -+		string_list_split(&compare_branches, compare_branches_config,
>      -+				  " ", -1);
>      -+		string_list_remove_empty_items(&compare_branches, 0);
>      ++	if (compare_branches) {
>      ++		string_list_split(&branches, compare_branches, " ", -1);
>      ++		string_list_remove_empty_items(&branches, 0);
>       +	} else {
>      -+		string_list_append(&compare_branches, "@{upstream}");
>      ++		string_list_append(&branches, "@{upstream}");
>        	}
>        
>       -	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
>      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
>       -				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
>       -	} else {
>       -		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
>      -+	for (i = 0; i < compare_branches.nr; i++) {
>      ++	for (i = 0; i < branches.nr; i++) {
>       +		char *full_ref;
>       +		char *short_ref;
>       +		int ours, theirs, cmp;
>       +		int is_upstream, is_push;
>       +		unsigned flags = 0;
>       +
>      -+		item = &compare_branches.items[i];
>      -+		full_ref = resolve_compare_branch(branch, item->string);
>      ++		full_ref = resolve_compare_branch(branch,
>      ++						  branches.items[i].string);
>       +		if (!full_ref)
>       +			continue;
>       +
>      ++		if (string_list_has_string(&processed_refs, full_ref)) {
>      ++			free(full_ref);
>      ++			continue;
>      ++		}
>      ++		string_list_insert(&processed_refs, full_ref);
>      ++
>       +		short_ref = refs_shorten_unambiguous_ref(
>       +			get_main_ref_store(the_repository), full_ref, 0);
>       +
>      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
>        
>       -	free(base);
>       -	return 1;
>      -+	string_list_clear(&compare_branches, 0);
>      -+	free(compare_branches_config);
>      ++	string_list_clear(&branches, 0);
>      ++	string_list_clear(&processed_refs, 0);
>      ++	free(compare_branches);
>       +	return reported;
>        }
>        
>      @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
>       +	)
>       +'
>       +
>      ++test_expect_success 'status.compareBranches from upstream has no duplicates' '
>      ++	(
>      ++		cd test &&
>      ++		git checkout main &&
>      ++		git status >../actual
>      ++	) &&
>      ++	cat >expect <<-EOF &&
>      ++	On branch main
>      ++	Your branch is up to date with ${SQ}origin/main${SQ}.
>      ++
>      ++	nothing to commit, working tree clean
>      ++	EOF
>      ++	test_cmp expect actual
>      ++'
>      ++
>       +test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
>       +	(
>       +		cd test &&
