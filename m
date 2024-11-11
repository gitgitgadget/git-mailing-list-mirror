Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C588150990
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363193; cv=none; b=VGr1eLbMoV6oGlZIKB8kGPLGFWEkkR+fhIU1+eTu6hinXP/15h1EYqM2MjC4bbRfsWfJRYZt26Xk4t7trPFfyKZhR0VV4Uf2vOkQteDuFcB3MFzbFpOoF/j6Dxile38ZXGpqdX7FmCDp++ucZMNNt2tb3WQgpR7VUqgLSbj4JMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363193; c=relaxed/simple;
	bh=gKJreXkS2V+IaI5MD4xSmXli0tM/h7vI5/JtDv4kMMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U+Z4/2KV5WM1kaCXWe2syZOCFubgRi4g53SFyy+Eb0NqziHpb2taiIjxQjLTKQezJ1hI/GaHDVO9xJ5FCA2HNcVWpnfuqKKadiYeUNWmLmCr83BmuMj/MQPmV655RRXH5gYOjtoRiALLDjyADJyFM6UUQtI/b/tTl/joXci+R0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MimxEpVN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nR7m77DV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MimxEpVN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nR7m77DV"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 20259114008C;
	Mon, 11 Nov 2024 17:13:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 11 Nov 2024 17:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731363188; x=1731449588; bh=zMPk13beLN
	oufpXRzUxax4oaOyLEhXqEIJNwqwOz404=; b=MimxEpVNr/pRAv0nc3IO6+ZIm3
	hcugMYotqYyH3J1saEVM5v4MFY/pL+SrlLRVI/8DbFBSCgU3/3gsN3usYiTatPlN
	jTZopBvhA66Tra5xIZ5vpT1XQk8Kmd4ipiII1C6QcXbLFazNGeAeVup8UmubOgHl
	2Y3CSqLnnP0EbKuYh6vWIvssRsQ2l4xIWH17++2jgekFetwxd1w462H3cpuQVbHq
	wgzbINlzLaU6yZdkVAvo3cI5MLP4XEGw9TL2KmEdXwPXBdFqMOtr1O37izC2GfZE
	Qg52gw1r5IX1Bj+tyjYkjukj/uuSdcufH4ZN7mwPGL+KzvQQsm6/33YOCBxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731363188; x=1731449588; bh=zMPk13beLNoufpXRzUxax4oaOyLEhXqEIJN
	wqwOz404=; b=nR7m77DVnhxVDqRDc0D6IduVt/qkufDNlgAxdnkQmGklfvJ8m0I
	2f/9q3Mi+gvjPc00mdu/oXSbgrs9IZiyY0W2M4r/2J2DE73XzwkwtHLXtpcfFXK3
	MfnL4pkzx6FAVQ+ShRLgoyuQEdLXebmyBXrp2jwlY/rcaXxVChrJE9UHiBgsyp4g
	0gIq6tIO31p4WTSlGzQucGlB8fJ9sdq8w2Q/p/CdVcNDUPsUG2LkMt0zYrbhF/+l
	BgiAKpEa6rrrB5J8MN7lKaLd9Z9uCzpcdVmTIsNvdUoxNk2MYpRkeWmDBR+ysnFR
	LCgxAS+HnPrp8Et8y1e5OJWAE+/nOenRjpQ==
X-ME-Sender: <xms:dIEyZwwbX6nL1EIixFuq9x7_X3KA7VGw35YdwjGrgociHWgyLhb6yw>
    <xme:dIEyZ0Ro0S5ahwJFU6iGb3onZqlZ-TgsCX3y0aAvkK8iEEj2ISFuLFA_3lLhlWSda
    MKrrXUFg0JLkzVYGg>
X-ME-Received: <xmr:dIEyZyXV5iAIX1UMd08_dHs3q6H8PxGFw441U8HG5cAYZjZNlvO55J79wcwnH-jmbEXMN_eN3eQle4NpAXKgeZiSHYFXirndf3ac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:dIEyZ-hqxz5jOb13KhozlNsRWxU3BoDCZFc6cwN-joQRsAD-wstyHg>
    <xmx:dIEyZyC5GN_CdbqA1KmPjOwPzitBXB3R1uAv-MtyRVLiH4FjJomeIA>
    <xmx:dIEyZ_IuQB5RpHedr0EcN9kehKgLi5r-PFcwGLjpgDjX88jb3R0Fbw>
    <xmx:dIEyZ5D6NiHrlDj7r3eeJHkVPtdW4QGO70Ptzz4RTV5cGTd7MaFAkw>
    <xmx:dIEyZ01bOSykiE8t30aIsIdSAhYV7uQJyLoTm_Hd1p4lEmNrOWkg0q9_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 17:13:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH] log: --remerge-diff needs to keep around commit parents
In-Reply-To: <b7488a36-0ba6-0847-47cb-6a5f3edec689@gmx.de> (Johannes
	Schindelin's message of "Mon, 11 Nov 2024 19:32:14 +0100 (CET)")
References: <pull.1825.git.1731073435641.gitgitgadget@gmail.com>
	<xmqq7c9ak0e9.fsf@gitster.g>
	<b7488a36-0ba6-0847-47cb-6a5f3edec689@gmx.de>
Date: Tue, 12 Nov 2024 07:13:06 +0900
Message-ID: <xmqqa5e5berx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I consider these examples less clear, but they are still affected:
>
> 	git show --remerge-diff v2.45.2^0
> 	vs
> 	git show --remerge-diff v2.44.2^0 v2.45.2^0
>
> 	git show --remerge-diff v2.45.1~1
> 	vs
> 	git log --topo-order --first-parent --remerge-diff v2.44.2 v2.45.1
>
> Concretely, these diffs should be empty, but are not:
>
> 	git diff --no-index \
> 		<(git show --remerge-diff v2.45.2^0 | sed 1d) \
> 		<(git show --remerge-diff v2.44.2^0 v2.45.2^0 | sed 1,/^commit/d)
>
> 	and
>
> 	git diff --no-index \
> 		<(git show --remerge-diff v2.45.1~1 | grep -v ^commit) \
> 		<(git log --topo-order --first-parent -6 --remerge-diff v2.44.2 v2.45.1 |
> 		  sed '1,/^commit 1c00f92eb5ee4a48ab615eefa41f2dd6024d43bc/d;/^commit/,$d')
>
> No `--reverse` required, not even clock skew.

As we often tell contributors, questions in reviewer comments should
be also answered in an updated patch, so that future readers of "git
log", who cannot ask direct questions to the author of the patch, do
not have to ask the same questions.  Can we add an explanation how
this affects forward traversal in a three-line paragraph?

Thanks.

