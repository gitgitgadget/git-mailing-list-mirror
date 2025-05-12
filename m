Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4B24EABF
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747069467; cv=none; b=ZTUfAbCjNvtXaH4l9yjN2qsR+wWXC7l2yIke+6hHN0q0SX9Oyay11GwnFCS5Ezovte10/OVkp1Dm6rTPgo3piWD6toiI7kHnXTtC4668zRt8TSSc6bNsWhpr+hCFDOgP8UHFmrD/F//YS9M1DkkuysG3vR7Sbyrmir7LqJud4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747069467; c=relaxed/simple;
	bh=8nWS0bk0t72VZTqM5xTNre23ssgkyweWStuBrRwtZlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pg3efxDlMhlTDKk8LgtO7cebmiD/6wWRIhkLBjutCowT7zayI/hAOvU5cmKj8WkT1q9a1KXBJ0JsMuZijrdlk5vWW7wwXpraNPwNdNdtZlNrb/rywz5iRHSCtTQ/8zH07wGQWFZo+l6lq7+QJczoDQDe6Xzn8xPmv5Zzq1jCaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AnBqW6kb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PyagGX/1; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AnBqW6kb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PyagGX/1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B50525400A2;
	Mon, 12 May 2025 13:04:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 12 May 2025 13:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747069464; x=1747155864; bh=8nWS0bk0t7
	2VZTqM5xTNre23ssgkyweWStuBrRwtZlA=; b=AnBqW6kb9jone/IyGi7/dRliiP
	9W4ke7AITCwfWrZsXZ4XaKQxbIPhBdm3fBpNsr3L2hMOglK4eUVqaQveS5sFtAO4
	5b/Je5U3Sgdrx1U1tONZr4f+ZwAohbSqTDQlMXz44J5ShauPAbpoehPw+XOkp3Rj
	lte/xTWhoAuH+wwPvjftgd8MoGIpMC1QoijAfscO9xdXbp3Ohyfvbym/B+QkP0o3
	3hKUxAPCazR2F9V3lhCiGWpEwtAXxQyQXaxQdNVO5yPCpQEi382q5SxtytaUIcrg
	RVHlmKrKLCJqxkB5qjBbSLpiXLXrNAQZtitikfYyH3Fp7SN/XiVN3N3vK2fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747069464; x=1747155864; bh=8nWS0bk0t72VZTqM5xTNre23ssgkyweWStu
	BrRwtZlA=; b=PyagGX/1QLYJWvOLli5zwV84t4IjrOVwrmbqlKGEmvKN3XM+Rk6
	q1aH1BUFVD23FhIog0lfIb9azPfwiRSgIPLutiFPFuaxPMsgwggU4FviACYCsDmu
	bQo2wSVjIYUh31U3KLgPpN+wkv9OSQ0kDR+xqEGiWq/3xOMYIWRFbVaQBOnpb5aB
	fzWekIvt3bvVL9G79IWFlsV9HQAlMtQNu8+nmKNftx75k0KDs13CGdUeA5DPsd+w
	GxT/s27bGNjIsbOuzCxj50cic0RjhdBdC5WsgxqRrG2N5eHYtyS8IKUdMKkCfZAP
	9VAIkWZ7k0JqEP4YZHVe6FoWuneLt8kJH4A==
X-ME-Sender: <xms:GCoiaPOfH3pU6IWfwRUqIX37pLvn_o3Rdz-nofZ69DyAGpifCy9Qnw>
    <xme:GCoiaJ-IJd_mVNKLbUhJ2qEvakIRPMP9YMtDxd6EjR47XbtFUPkVBy7N1ThrymYLB
    BlEYotkP4IXah-fzw>
X-ME-Received: <xmr:GCoiaORdrodqAIsn9_lPKLs4urSI8HnRTWiEF9fz64tvbHutLTCs4daI7xqgoIRzcEH8_a0icB5sk327xBZBviPCztz-HVXrrFg9c6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddukeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GCoiaDs-rPggVCCtLsjW32k5fEGY-sGEAFDZpOUfhX_09GvG2J6aSQ>
    <xmx:GCoiaHdF52Xk1WlVAm1IYYwBSQlxj2fcNf3oL3OIxWVzvI3QquFkHw>
    <xmx:GCoiaP0ZfOitRNxe5Esgy_7hT0tlhY5XBE_LVQsimnwx-dmrFsgqjA>
    <xmx:GCoiaD_wCUrl8EPFTQxJ83n3UoffCJrYCCiZtL6aWNFE-BxoFWPJKQ>
    <xmx:GCoiaKKDkNIwAQdYW9eSP20XcbCqe8n6fgUpKoX-qtCDLPRBt67v1jrh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 13:04:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] merge-tree: add new --mergeability-only option
In-Reply-To: <pull.1920.git.1746914561.gitgitgadget@gmail.com> (Elijah Newren
	via GitGitGadget's message of "Sat, 10 May 2025 22:02:39 +0000")
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 10:04:22 -0700
Message-ID: <xmqqplgdu5ex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This adds a new flag, --mergeability-only, to git merge-tree, which
> suppresses all output and leaves only the exit status (reflecting successful
> merge or conflict). This is useful for Git Forges in cases where they are
> only interested in whether two branches can be merged, without needing the
> actual merge result or conflict details.

Sounds useful, but wouldn't that usually called --dry-run?

