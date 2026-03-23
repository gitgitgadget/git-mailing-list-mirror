Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676A52773E4
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279769; cv=none; b=uIaRoQyzTqbNefmidZEP+HQaowA97KsAe1LXbaJIFIHO5a3cxrjeKljC5zwOxerjTpJfaHFQu98omx88zWQzfYA5qpQjhjtAn+2WxgAsx/8W1kS28EBFCLXVOC7bvAi5qInKU/P4eJCmGVQ/BhPkWL1PxGrtFqMN/kBJoDhaQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279769; c=relaxed/simple;
	bh=GMBsYyaQeNontPW8Ou5Igan/0xjx5+DruSEbjeFpOhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y9kLMUExpJUgcn6doUfcpPFQ5cStJZsXEqgmTec43v0NvF+huC+C8Rclwlih/lTXN2wd1r0//uPG9h+I9g8xnJADeTp0q05LUEDe3cXuUyX5FVV898MNKUF6MEq2hg/qnA+mu99yo/yiBD3SMvo5VqEnM0Eovi2uX0Npw6iRRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sc0Hip96; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bO+y6bJq; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sc0Hip96";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bO+y6bJq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BA1C0EC0198;
	Mon, 23 Mar 2026 11:29:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 23 Mar 2026 11:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774279767; x=1774366167; bh=noPx9/k3Uq
	ye7rFvwMF2YFtOZHzoxYdFOieBjUMx0Kk=; b=Sc0Hip96BDfeI4JgCkyKoIjBN1
	NK1vM7qnU/0C2bNiNlEf1yKvRbNlEk0230Icn3DbKBmL28zaSo0r+uPvfi3JbDXd
	dIX8uVfgl3nqCHDIZhPQIuG98keC1jRhpYpAs6Q5mQuQ3Ge+U1t0FRTVjAG9bxJe
	IOK1lcw9at0zBfMxpmum8NNN/ce9U1KkRscoD6x49h2KEVEHqpMEEodFIhzxDb+U
	qV38v5g9CUjASgaorE0xcOigFd28ZuaED01rCeiUR0LWUHDaGhGzMj1hr/C6Wx9Q
	dUS15dG0HFXaVXW2TU+laV5XRdhCyOXOa/81Cr2eWr4yaUKgybNHGTW8t8+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774279767; x=1774366167; bh=noPx9/k3Uqye7rFvwMF2YFtOZHzoxYdFOie
	BjUMx0Kk=; b=bO+y6bJq8Mvo7pepY6Ahnnq9pf/VDdNhoyopN5pny95oEoEWp2B
	K4yS/V0m+sBQ5ocCYTJdPHoNWAoxSI7Zs2ev9GaxjY8XyfR9vtjXjv872v/QwF/g
	xVEWiYlGLhLC68QSFPJVb5XVhMjlDhtcxOHf+DfY0/ovYgC+TbA7aWRY9W+wDGsz
	bjGkjEbTuRVhmUqoLiMQDxA6msrln4AHf+HNR1OxQInI1E77cis02OWk6n0+b0Uu
	7pdZHx1DAigf9HLUTxR9olRv5CvrmGJz0V4ZlSpdZgJ5/sufg2qSi+SzVkJHd2cY
	JXaB7T4vke1gSp/Gl/h96n5rRQsEyUUXpmw==
X-ME-Sender: <xms:V1zBafzr8rRYozIIHtJZFq1BUA-Rc91AoArb9pGEoU_SwbhzU1808g>
    <xme:V1zBaZjmkF6iBngB-GVNQhq1rV6Rcm9sP45dIdkH5Z7A9WcWHz041OxmMYv08m5yq
    AN6MJzEhB7QwH7Y4jyDCrc0P0QQBXoo7MlivwOkuahckzr8VESo9Q>
X-ME-Received: <xmr:V1zBabmaQsJjz4ndi52TwHW3aOZiHW2p_AA586p3qXh_KXJ3w94KNM4w93qeNX5U1qvfkDNdT8zjJA-q1bSUP-xt7dtZl_EyKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheprhdrshhiugguhhgrrhht
    hhdrshhhrhhimhgrlhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:V1zBafiEmSxE8kF9l5J6nGhKjy0BIEeRiWm5NsD-9EQc9iLqpSQ7jA>
    <xmx:V1zBaf1BKdc56AIC_33MWHqg6CZvlYz-AZIMLdX1zVXJ7yxo6N3G6A>
    <xmx:V1zBaYLGYzv5zLIUrkUot4jy2AdWnW44nVxlb9sbxYw2Q4gr7FGJeg>
    <xmx:V1zBafyshh0egLsxBg4noWqv4W2VVSg0p-ejTsmkRfdu6eDZilvLsg>
    <xmx:V1zBaUXx9HNz_eBIUpoawxM6f6eTalRUfhx-61HwCLzBFe7YSpC0dRHR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:29:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  r.siddharth.shrimali@gmail.com,
  ps@pks.im,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/6] t5620: test backfill's unknown argument handling
In-Reply-To: <9699650aa7dc04cf1cdc26803caa8304b29c1662.1774266019.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Mon, 23 Mar 2026
	11:40:19 +0000")
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
	<pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
	<9699650aa7dc04cf1cdc26803caa8304b29c1662.1774266019.git.gitgitgadget@gmail.com>
Date: Mon, 23 Mar 2026 08:29:25 -0700
Message-ID: <xmqqzf3y5zu2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> Before the recent changes to parse rev-list arguments inside of 'git
> backfill', the builtin would take arbitrary arguments without complaint (and
> ignore them). This was noticed and a patch was sent [1] which motivates this
> change to encode this behavior in test.
>
> [1] https://lore.kernel.org/git/20260321031643.5185-1-r.siddharth.shrimali@gmail.com/
>
> Reported-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  t/t5620-backfill.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
> index c6f54ee91c..85740f1f13 100755
> --- a/t/t5620-backfill.sh
> +++ b/t/t5620-backfill.sh
> @@ -7,6 +7,14 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
>  
> +test_expect_success 'backfill rejects unexpected arguments' '
> +	test_must_fail git backfill unexpected-arg 2>err &&
> +	test_grep "ambiguous argument .*unexpected-arg" err &&
> +
> +	test_must_fail git backfill --all --firt-parent unexpected-arg 2>err &&
> +	test_grep "ambiguous argument .*unexpected-arg" err
> +'

Hmph, I would have expected that an earlier --firt-parent on the
command line would trigger "unknown option" instead.

Having said that, if the code lets the setup_revisions() parse the
command line, the usual "unless disambiguated with a double-dash
'--', stop at the first non-revision and take everything as paths
but for safety all of them must refer to an existing path in the
working tree" behaviour should trigger, and it is not specific to
"backfill", and may already be tested centrally (if not, I do not
object to such a new set of tests).

For any cmd that take revisions and pathspec (e.g., log, rev-list,
grep) these should hold true:

  $ git $cmd [<options>]... Makefile HEAD

    Without disambiguation the command should say "Ah, Makefile
    is not a revision, so we will see no more revisions, and
    everything, including the current one we are looking at, must be
    an existing path on the working tree", and barfs on HEAD that
    does not exist as a file/directory.

  $ git $cmd [<options>]... Makefile -- HEAD

    With disambiguation, the command should verify everything before
    the double-dash to be a rev, and barf that Makefile is not a
    rev.

  $ git $cmd [<options>]... -- Makefile HEAD

    With disambiguation, the command should take everything after
    the double-dash to be a pathspec element without barfing.  After
    all, it may be referring to a path that used to exist in some
    revision the command will look at.

Thanks.

