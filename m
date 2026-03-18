Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4DD2D46B2
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872725; cv=none; b=Wn1psVS2lPvdgLrVKE+LnBAj8cevj3Omy7dQeboi1ltj0fx3rxHPGcuciD+0dUsOrsKBcnjqAq1sp9tZzgRvXzH0GZ+VMdeR6EtOf2knkYpav0CMk1eNHFoqHhzmFEeZtWNBVqM641j5sxNQruUFxbw0ybR2cvo0AM5NdtdmdD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872725; c=relaxed/simple;
	bh=oFk+VYmdmLDu0EYluMgWHSfFe8uiKJtgcMzl3rUpEzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nIFEHNU28fXe5tusrN9M0AL4yV8b1zwdJVL4ucBLFLWErOGxfuxNE+y0GZRdqn097FzjLx3F12ewznN3DKmmEtszeihIvcn/2bwYpYGqP0UA+1lhejb9JqNAX+WwulKzzybtajuQ892FCDaMGrzLlOrXBbbmzOQg4xwulHAYIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=czWb1WOp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yutqpyRo; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="czWb1WOp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yutqpyRo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 61F141D00127;
	Wed, 18 Mar 2026 18:25:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 18 Mar 2026 18:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773872723; x=1773959123; bh=7agGCfZIRu
	OTC3CsF2fK/foXwwIEM7FI4RFxGo/C91E=; b=czWb1WOp07ApfYduFoR1Q261Ga
	5Jnl1ohLcBrD1N5/S4czPfDQnM0ZIizeNza99YwACkNxy7Vb4DghHJ7K7UjE1QvM
	FElQzuyI+laxgfrPqIcDGSbTjTen9eU/D1zTUYDKi8oHcxf20tnS8W62PCq/1YUu
	12qCEOPPLVfVws6GrL61G6GXQXg9nCC4t69T5BHiyoz3TNdSv2KhnK8nsT19aqu/
	ojqMvqxhx5uQ8nRwHIm1p2sWoQqJDf1b5Adl1cUPadQJ2917sd/x9iVeMIao3Cn5
	4G9FJvZL9CjNqBeFOLu9dACcRrBdMil311ZSoB2/NUFowz74WG1ynu4iM2BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773872723; x=1773959123; bh=7agGCfZIRuOTC3CsF2fK/foXwwIEM7FI4RF
	xGo/C91E=; b=yutqpyRoGsSWLztxNBFYWYPq7PF+ZDTPpPsoOW970/QomQHzcuw
	9hMgBht6VcCFgHUv5/e+rGislQbtApSwzWvIchI/WQMyohZgsV4Tt3BbiAcQ1/Hg
	DUYzco3EJO881tC8PWe1RjXrOqFDgbaK1VMcD3ibENxUD9Y3h5VsimFY57+NZlTT
	XSDz9s8dHcVvBaQEm4i33/5z1ZzRSy6ocki/nekW6xILA3fW9Lwv6GFuUIJmfZMY
	BQLO0fZh+rmn4v6DQAP/TzqXoqkV9wt42DNF+N1jzckbtSq1AdclbYWOMD7jMkg4
	meWV2se6XlYD0WU4Ht1GCNxNVvz1Zi5tFEA==
X-ME-Sender: <xms:Uia7aTp01gMi7sdkY8q8HZl2UICA81_3Gr9m3YGhJ_XlpZqE93dqRA>
    <xme:Uia7af6cAb8AtGcX-RZmWmdho6ji7jomDi9o3hbavDyLFMyc9VsS1NAaOc7TbirF8
    YEfruHgBG_OUOV4GMTo9iVqwyXf44_5mXVPG4TOW0kVDsDEP7uS>
X-ME-Received: <xmr:Uia7aSfoJ7D69xhjxAcPh0P_2UcpCjDEFurtoOCcgy3VkjmIZimWoFav1X6gdJNAbjhxfDZbL-v_8Ay7MllFHbQhfiNK5WX2Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Uia7ac5QNEBF8fRl-zmzBLRqvK6R6KI7xkTSFCwRs09LFuqGhdD7jA>
    <xmx:Uia7aRtQfMBh3D6M__W7rv9-xRd_ymnOVYlzcGpIqCWCt3aUkMgIhA>
    <xmx:Uia7aUi9FzpCM7CoCdGx5-XMJs_fWkluA4_-kmQy2XWmZqiyNsqYRw>
    <xmx:Uia7aUqjZHLNklIz-uoSJzBAsDcqDXLzxecjXQafQrJNVNUWdGWKNQ>
    <xmx:Uya7aUiDn1R-bP5a73-uSdGyP_LXDDr2JAEOkITPPBpYmBhgPsUc-Wgq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 18:25:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [RFC PATCH v2 2/2] push: support pushing to a remote group
In-Reply-To: <20260318204028.1010487-3-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 19 Mar 2026 02:10:28 +0530")
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
	<20260318204028.1010487-1-usmanakinyemi202@gmail.com>
	<20260318204028.1010487-3-usmanakinyemi202@gmail.com>
Date: Wed, 18 Mar 2026 15:25:21 -0700
Message-ID: <xmqqpl50ojvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> diff --git a/t/t5566-push-group.sh b/t/t5566-push-group.sh
> new file mode 100755
> index 0000000000..9e0d378f2a
> --- /dev/null
> +++ b/t/t5566-push-group.sh
> @@ -0,0 +1,95 @@
> +#!/bin/sh
> +
> +test_description='push to remote group'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	for i in 1 2 3
> +	do
> +		git init --bare dest-$i.git &&
> +		git -C dest-$i.git symbolic-ref HEAD refs/heads/not-a-branch ||
> +		return 1
> +	done &&
> +	test_tick &&
> +	git commit --allow-empty -m "initial" &&
> +	git config set remote.remote-1.url "file://$(pwd)/dest-1.git" &&
> +	git config set remote.remote-1.fetch "+refs/heads/*:refs/remotes/remote-1/*" &&
> +	git config set remote.remote-2.url "file://$(pwd)/dest-2.git" &&
> +	git config set remote.remote-2.fetch "+refs/heads/*:refs/remotes/remote-2/*" &&
> +	git config set remote.remote-3.url "file://$(pwd)/dest-3.git" &&
> +	git config set remote.remote-3.fetch "+refs/heads/*:refs/remotes/remote-3/*" &&
> +	git config set remotes.all-remotes "remote-1 remote-2 remote-3"
> +'

So we have three remotes, dest-{1,2,3}.git/ that are all bare, and a
remote group "all-remotes" that name them.  Is there a reason why
you want to use an unborn HEAD?

> +test_expect_success 'push to remote group pushes to all members' '
> +	git push all-remotes HEAD:refs/heads/main &&

Our "push" exits with 0 status.  How would we make sure we pushed
correctly?

> +	j= &&
> +	for i in 1 2 3
> +	do
> +		git -C dest-$i.git for-each-ref >actual-$i &&

We grab dest-$i's refs to actual-$i

> +		if test -n "$j"
> +		then
> +			test_cmp actual-$j actual-$i

and make sure if refs in dest-N differ from dest-(N-1)'s refs.

> +		else
> +			cat actual-$i

of course, the first one has nothing to compare against, so we get a
debugging "cat" for it.

> +		fi &&
> +		j=$i ||
> +		return 1

But does this loop test what we really want to make sure?  You could
write your "group push" to push one commit less than what was asked
to push out to all remotes, and they will match with each other to
pass the above test, but it would be different from our original.

Don't we know the exact state of refs in these dest-$i.git
repositories?  If we do, then

    printf "%s commit\trefs/heads/main\n" >expect &&
    for i in 1 2 3
    do
	git -C dest-$i.git for-each-ref >actual &&
	test_cmp expect actual || return 1
    done

perhaps?

> +test_expect_success 'push second commit to group updates all members' '
> +	test_tick &&
> +	git commit --allow-empty -m "second" &&
> +	git push all-remotes HEAD:refs/heads/main &&
> +	for i in 1 2 3
> +	do
> +		git -C dest-$i.git rev-parse refs/heads/main >hash-$i ||
> +		return 1
> +	done &&
> +	test_cmp hash-1 hash-2 &&
> +	test_cmp hash-2 hash-3
> +'

Again, the primary thing we are interested in is that dest-*.git
has a copy of what we pushed.  They may be identical to each other
among themselves but they still could be different from what we
pushed, and that is something we want to catch, no?

    git rev-parse refs/heads/main >expect &&
    for i in 1 2 3
    do
	git -C dest-$i.git rev-parse refs/heads/main >actual &&
	test_cmp expect actual || return 1
    done

> +
> +test_expect_success 'push to single remote in group does not affect others' '
> +	test_tick &&
> +	git commit --allow-empty -m "third" &&
> +	git push remote-1 HEAD:refs/heads/main &&
> +	git -C dest-1.git rev-parse refs/heads/main >hash-after-1 &&
> +	git -C dest-2.git rev-parse refs/heads/main >hash-after-2 &&
> +	! test_cmp hash-after-1 hash-after-2
> +'

Obviously correct.

> +test_expect_success 'push to nonexistent group fails with error' '
> +	test_must_fail git push no-such-group HEAD:refs/heads/main
> +'

Obviously correct---we probably should already have a test to see
that a push to nonexistent remote repository fails (missing one you
cannot even tell if it is a single remote or a group), in which case
this is not even needed.

> +test_expect_success 'push explicit refspec to group' '
> +	test_tick &&
> +	git commit --allow-empty -m "fourth" &&
> +	git push all-remotes HEAD:refs/heads/other &&

Didn't we do this already?  We did so with 'main' into dest-*.git
that did not know anything about 'main' (after its HEAD repointed
to a missing branch).

> +	for i in 1 2 3
> +	do
> +		git -C dest-$i.git rev-parse refs/heads/other >other-hash-$i ||
> +		return 1
> +	done &&
> +	test_cmp other-hash-1 other-hash-2 &&
> +	test_cmp other-hash-2 other-hash-3
> +'
> +
> +test_expect_success 'mirror remote in group with refspec fails' '
> +	git config set remote.remote-1.mirror true &&
> +	test_must_fail git push all-remotes HEAD:refs/heads/main 2>err &&
> +	grep "mirror" err &&

test_grep??

> +	git config unset remote.remote-1.mirror
> +'
> +test_expect_success 'push.default=current works with group push' '
> +	git config set push.default current &&
> +	test_tick &&
> +	git commit --allow-empty -m "fifth" &&
> +	git push all-remotes &&
> +	git config unset push.default
> +'
> +
> +test_done
