Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DED73E1D07
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754033; cv=none; b=jG/7yx+Con1mP8QXM1dQhfl54OJqmKYqMcK8LAPC6YJGVNYuv50l0WVid19rcua3aMvKJjsHe9M1hlb/WKMSmayuTKMVOW2DcT495Slg+rd+Xy5JhFZc7RJEJPwAJBS3+DttQqSh8S7lNajvbRdTm5tKwu5WvgNhUf7CVeNQxAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754033; c=relaxed/simple;
	bh=X8l9TBENAdGfspN1WN1lmgVYeoqZh/YTVOEvKZv2+tM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BgeWg1oK6UJrDbYy+1eKa7IyvgtraByXcgw0Ja+JI6JHC0OsRvQc5FpAsRv6r+NEPkLSERNoHaihOqeucg35XqG3vIqbB8LbdwBWrKur5Ztr6qXg5K6enxfUIe3vw2c/M+bAPjR4UexvjkkiPOobgdbCx6wLENfbFMsysiFBJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kzScj9rR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fV9b21BM; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kzScj9rR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fV9b21BM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B35671400284;
	Thu,  9 Apr 2026 13:00:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 09 Apr 2026 13:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775754030; x=1775840430; bh=eM/LoJlbXt
	T5378BbmdYtKSBoBEgp6NG8xnjMLhE+/4=; b=kzScj9rRIdhczsRbiL0Xu60lhk
	0M/2XFo+T+ejpef0QsLBLkBz6hlbGExrmQaMH/c/Y2XiiltRUk/RoBPoDZwcYGw1
	pP3ed5VIQ7K+vbV93S562fA7mQmX1Pn819B26CY5wvQsmTNngnn2/eJ9PIJbzddF
	yLj7RJFkD7jpVsgUlHoM4NlClG44Utkb195cTqclzGKEIWaV2H2SZg5TewkXU5SJ
	/7KLKXL5gk1AGpqIPEgWkiHwuURQjf1fF1eFavaPCu3o9//gyVszNXh4X1UZXPMU
	h3VPp790FRIzVtAt1yXS4L2bd3tZQDhA+BiAV6UsjOr9Cw3LCAfAZU6an04g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775754030; x=1775840430; bh=eM/LoJlbXtT5378BbmdYtKSBoBEgp6NG8xn
	jMLhE+/4=; b=fV9b21BMv8JcWybbo7RshEoxd6b7R7YUYD7uzZQXQN/U3EzDnBZ
	IXfB3SUhrla/DPg813UEBLEx6HYaPWYMo8lr7IeU1/4vD4OSafaInwn0x326Z8i7
	DLd2mqsQMlkgxZ+iwxoXNCIkgu5v1huEtXSjvxa8KECbaWpURX7zBmoYWyZ1ZQ1m
	yc3hHZ7uXWsEs3CquGQ3Hq/SjQZB29JnzVFJqI4GxcxwwtNRu1xF3P/9Fmhv67gl
	fe8e1BGhXBIiFkEHkMwDktUr04r78y8navHIU4waG0AKpQDrQ087moJD5F8x6xQP
	Zo9iREzcZI83x3V7P2jFkMz0AZ6IQQqUMMw==
X-ME-Sender: <xms:LtvXaQnWN9HENC9RSKUDky16NB1cmZ3Mte1RRng-y2IrQ55Rh1xVRg>
    <xme:LtvXaWsei3jznJ0NgpPW0p8GCiOy0zdceg8m-QBRQkYVv4dE5stBBsHUsa6d9aSNP
    ySbqnfXEFBxkM7RM4tHw8_HRrB6ywHykDYOvMbRGmME3JzKzo91VA>
X-ME-Received: <xmr:LtvXaW-oRsgxzMqnoOQ9RE5XS2mcoCxLFbwcKDYNQIlzk34pGyZiJac_8zynWgJN8hs9eL2dRxkMPNix31mtBLUMOBLO4gv-FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LtvXaYObXs_B58ENRyV_0-5HYV4ysNdPk33A0x0HwBszYYcGZHtqGA>
    <xmx:LtvXacGl2XakahEVrjUDcT-6uBcuY0AX21QvtsnYJI4-6SJehXhxvw>
    <xmx:LtvXaeRSf1Xvh5JKSTIts6L3OKrw_dGgfeGovTFW1Jei3WMtSiwMpA>
    <xmx:LtvXaRtrGEQYuvsbvFvycfb7gpHzW4gqmIlpMiilRbp8IBDcR-7RJg>
    <xmx:LtvXaXdfHgUaaQXbsOaVlbJYuNQDnQiHMA0eYNml5xzlZzeNZR8b00TQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 13:00:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v7 0/4] checkout: 'autostash' for branch switching
In-Reply-To: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Thu, 09 Apr 2026 13:27:41
	+0000")
References: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
	<pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 10:00:28 -0700
Message-ID: <xmqqeckoul03.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Harald Nordgren (4):
>   stash: add --ours-label, --theirs-label, --base-label for apply
>   sequencer: allow create_autostash to run silently
>   sequencer: teach autostash apply to take optional conflict marker
>     labels
>   checkout: -m (--merge) uses autostash when switching branches

Thanks for an update.  Above the list of the commits, it would be
helpful to give a summary of the overall goal of the topic (which
typically stays more or less the same during the life of the topic)
and the highlights of the changes since the previous iteration
(which authors often accumulate, so that in a cover letter for v7,
there will be 6 such summaries), if you are sending a cover letter.

I _think_ the change since v6 is a rebasing onto a more recent
'master', and addition of a new test?

Thanks.

>  Documentation/git-checkout.adoc |  58 +++++-----
>  Documentation/git-stash.adoc    |  11 +-
>  Documentation/git-switch.adoc   |  27 ++---
>  builtin/checkout.c              | 138 ++++++++++-------------
>  builtin/stash.c                 |  32 ++++--
>  sequencer.c                     |  67 +++++++++---
>  sequencer.h                     |   4 +
>  t/t3420-rebase-autostash.sh     |  24 +++-
>  t/t3903-stash.sh                |  18 +++
>  t/t7201-co.sh                   | 188 ++++++++++++++++++++++++++++++++
>  t/t7600-merge.sh                |   2 +-
>  xdiff-interface.c               |  12 ++
>  xdiff-interface.h               |   1 +
>  13 files changed, 431 insertions(+), 151 deletions(-)
>
>
> base-commit: b15384c06f77bc2d34d0d3623a8a58218313a561
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v7
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v7
> Pull-Request: https://github.com/git/git/pull/2234
>
> Range-diff vs v6:
>
>  1:  cd9c64ba60 ! 1:  284075600a stash: add --ours-label, --theirs-label, --base-label for apply
>      @@ Documentation/git-stash.adoc: git stash list [<log-options>]
>       -git stash apply [--index] [-q | --quiet] [<stash>]
>       +git stash apply [--index] [-q | --quiet] [--ours-label=<label>] [--theirs-label=<label>] [--base-label=<label>] [<stash>]
>        git stash branch <branchname> [<stash>]
>      - git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
>      + git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
>        	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
>       @@ Documentation/git-stash.adoc: the index's ones. However, this can fail, when you have conflicts
>        (which are stored in the index, where you therefore can no longer
>  2:  d572c4bb7d = 2:  64261e3cb6 sequencer: allow create_autostash to run silently
>  3:  80a98116fc = 3:  c0d6b4b4c0 sequencer: teach autostash apply to take optional conflict marker labels
>  4:  7ecb0835b7 ! 4:  1c29e19971 checkout: -m (--merge) uses autostash when switching branches
>      @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
>       -					0, 0);
>       -			init_ui_merge_options(&o, the_repository);
>       -			o.verbosity = 0;
>      --			work = write_in_core_index_as_tree(the_repository);
>      +-			work = write_in_core_index_as_tree(the_repository,
>      +-							   the_repository->index);
>       -
>       -			ret = reset_tree(new_tree,
>       -					 opts, 1,
>      @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
>       +	git reset --hard
>       +'
>       +
>      ++test_expect_success 'checkout -m applies stash cleanly with non-overlapping changes in same file' '
>      ++	git checkout -f main &&
>      ++	git reset --hard &&
>      ++	git clean -f &&
>      ++
>      ++	git checkout -b nonoverlap_base &&
>      ++	fill a b c d >file &&
>      ++	git add file &&
>      ++	git commit -m "add file" &&
>      ++
>      ++	git checkout -b nonoverlap_child &&
>      ++	fill a b c INSERTED d >file &&
>      ++	git commit -a -m "insert line near end of file" &&
>      ++
>      ++	fill DIRTY a b c INSERTED d >file &&
>      ++
>      ++	git checkout -m nonoverlap_base 2>stderr &&
>      ++	test_grep "Applied autostash" stderr &&
>      ++	test_grep ! "resulted in conflicts" stderr &&
>      ++
>      ++	fill DIRTY a b c d >expect &&
>      ++	test_cmp expect file &&
>      ++
>      ++	git checkout -f main &&
>      ++	git branch -D nonoverlap_base &&
>      ++	git branch -D nonoverlap_child
>      ++'
>      ++
>       +test_expect_success 'checkout -m -b skips stash with dirty tree' '
>       +	git checkout -f main &&
>       +	git clean -f &&
