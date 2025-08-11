Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470502C21C5
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950228; cv=none; b=Do8AsDweL4UmDXvECQ1ADVmyqTV2eloMgU4hQV7BIx6+zKX8AAwKUm81KdH5DFhJ5p0eFChZb6Kin+k2GvFtIiIAPd+TtRtiZSQPrGJDq8oDziLUMyqlHEcb15QKFYpepYOy+FR+X+x4IvHO2bQwiQFQugjLPykG3ZZZs3Aqy20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950228; c=relaxed/simple;
	bh=u0oo1qEXtddLHaLwwilH8FD7BqrwgL0Chzuq0Ojzi1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gd+XAsQtO+qyXSBHytY2tReA8JyIVscn0J8R4w0HdQ6bC5lRhK4STlVQA0uKoduQLpVlLWiTBENGsXCn/KQtGqIHNiEJCNSmthbgV2RrLJ83HvE0s5+9TjNcoisvXeA91q1z+9fb0DhyJr9VqRUnhXJkLgy4fg9x8m0z9df7hfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TCtybWWs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K9pzitmF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TCtybWWs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K9pzitmF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 82C901400138;
	Mon, 11 Aug 2025 18:10:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 11 Aug 2025 18:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754950225; x=1755036625; bh=FT7uMNKUde
	DrTGahu7lnvwy7EctD9eBCEuLSPIn4uL8=; b=TCtybWWsYhcv9qvGyNY3H3s7D8
	V9Hm9Nt1RgjIPFmvofm36CMmAi/Q9Shs+F4ESH/PhAtznda/DdqPhorteCoVuBB9
	9wLwZIyC4/dWoRNVQAs9BMr7aktS/rvtLjbAmUQagXOA1veS2lkQWnEjcTPamf5Z
	NwDksgcp/OTkEvhj248LehZdhsBQDrz81QgvY3cpPJC5USHRIEqC7eb/usFH0YW+
	VLeihdmuF0SqZWEI4Xr0in6IYNtKJcmdcMQ18hOQGHKuXq9j77v+GF0lgy71DkRM
	HcD5WLXLBMZXvt89lE7b9KNdvTZg8sR5ER3l5ma0vSFn4zpQSmPC88pTYtgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754950225; x=1755036625; bh=FT7uMNKUdeDrTGahu7lnvwy7EctD9eBCEuL
	SPIn4uL8=; b=K9pzitmFAvhsscMFqlDTngMXYBIBg5e9f18Y576s5E8jG7SrWsm
	8/P6oYJCKz0MJUuLK35G+vPt2FTvmUovaqsRXoQ3a3kTlZRDjT99/sLbEhBcIgsc
	Rfw+XxQEfkCqIlTtf6yfNMalTnpqUzDGs9KsFyoDkobLKHYd/kMtuZytqzEhIExw
	7ayGLgQMy3Ep+JOaWFFYjj/3RU+7f/M1el5AzDjKDxv9CBjHDXLeHd4hdJM5kzPY
	JHrT2gKIfzK3WZaadt7cxa6Z9stIzDJf+QvrcCZLmGIUILKNSSB0O5AbOp1BxTAC
	IbGEhoSdJ7gwzVj5KLkUk7FDL4ZreW7WpAQ==
X-ME-Sender: <xms:UWqaaHi0m5uqVGtxx7VnoyuXJtd1_1bR3pjuWr6b0rvsaVZtiyssYg>
    <xme:UWqaaA9lnCdGmwqFy0Ye9bqpPNgC7uqgeQfr3Q2kJtFaT-bIrh6JMk8oQHdXMI6Po
    UuyICb-u05iOR2h-g>
X-ME-Received: <xmr:UWqaaCufHwF0yf3XJfk1mdVHr2PSGeYktprmme53Ih84qonfG94Og5rsNpHzJIoO83-rT0Gl-q2Xi-ex1E9aVlaUIhDN97TnSVurZ-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:UWqaaMr1WRGm1Oowcv8Oqz_ZNWd_y_YVKCI0IbBpJnSyBon9RGPmYA>
    <xmx:UWqaaOogEdmn1zS54FIYPpzbAafjnuojEuWuFeVHoBK4xLykbirLUg>
    <xmx:UWqaaDaQWJZbPSeIv-8KVDmZ2C8DGFmN9RWKOi4rD-SbTh_5mT3uyg>
    <xmx:UWqaaE_LwY2W0iCFw9XUiarlqNzi3UHEj5rP1aKx-RDEgLGuO5PTuw>
    <xmx:UWqaaG7i5xNwcwvjOhSuYbsKQeHLmefbpNGmRBQDW5YKh91-EDLtxRFS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 18:10:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Karthik Nayak <karthik.188@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v6 5/5] doc: git-rebase: update discussion of internals
In-Reply-To: <9c7f2716bc8dca2a73f7c8a994ccb8ed4a66fd9a.1754949075.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Mon, 11 Aug 2025 21:51:15
	+0000")
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
	<pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
	<9c7f2716bc8dca2a73f7c8a994ccb8ed4a66fd9a.1754949075.git.gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 15:10:23 -0700
Message-ID: <xmqqh5ydzf00.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +Here is a simplified description of what `git rebase <upstream>` does:

Now this is a "this is roughly how it works", we can afford to give
a simplified picture that may not exactly match the implementation,
which is great freedom to have while writing documentation for first
time users.

> +1. Make a list of all new commits on your current branch since it branched
> +   off from `<upstream>`. This is the same set of commits that would be shown
> +   by `git log  <upstream>..HEAD`. You can use `--fork-point` or  `--root` to
> +   change how this list of commits is constructed.
> +2. Check whether any of those commits are duplicates of commits already
> +   in `<upstream>` and remove them from the list.

So, I do not mind #2 described as a separate step.  Conceptually, it
is between "create a list of all commits in the range and filter out
what have already been applied" and "create a list of all commits
that are not in the upstream yet".  We may be able to rephrase "all
new commits on your current branch" somewhat to make it unnecessary
to describe #2, though.  If we are willing to stop talking about
"This is the same set of ...", then the description becomes very
simple:

    Make a list of all commits on your current branch since it
    branched off from `<upstream>` that do not have equivalent
    change in `<upstream>`.

> +3. Check out `<upstream>` with the equivalent of `git checkout --detach <upstream>`.

The line is getting overly long here and a few lines below.  If your
editor has the feature, tell it to auto-wrap at around 66-72 column.

> +4. Replay the commits, one by one, in order. This is similar to running
> +   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
> +   are handled.
> +5. Update your branch to point to the final commit with the equivalent
> +   of `git checkout -C <branch>`.

Force-create-branch while checking out is `git checkout -B
<branch>`, not -C.
