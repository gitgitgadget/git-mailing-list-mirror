Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B72195811
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317486; cv=none; b=hgzHf629RAs8fpmoIUj0byJjYHNLj22wCNTiTHgKYPsIM/I5jnSJuaXxZ1Fz93EbMO1JR+/woetN/i2FuGrYRZvV2y9jBlt2QkfmXemq6Hfd+8NeEn2dQ3Vi5cHMm2JVmXHW6+J6RvEkRHL3yjZFFpNFCpq5knW6ws0gUBUV5OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317486; c=relaxed/simple;
	bh=/ODbghaOqmRpWPrYIDybg189ZETQyP1N8w23D7pjlU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KR/9j3xJ7BxegMpx502l5bcso7B6L0nahp7e8rXJ5tLUCvdZSWE1nMsUAUymMfngmM1+JPQhmIRUGoOvxoMonbKvdFwJfajT9ft2vdj0e7inS6At2Pm35xiuvtLoIsAKpYIEpTnxdh1uv6B211dlIO+QDsXKS1x0+gSBJXg9G9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cyIiVCy+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=igt6Cqoz; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cyIiVCy+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igt6Cqoz"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B898625400F4;
	Thu, 15 May 2025 09:58:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 15 May 2025 09:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747317483; x=1747403883; bh=8ViQm/LQN/
	feHQz+MzHu9j2sHkXwfrS4ES4oTdvwIA0=; b=cyIiVCy+CxE5dX0+HdCgCtvMxY
	e7ejbAMGeGNF5adslKKowKZGGb01kZ4cZ++PnNgXmPFVfVhgjl3ro3o7SKSCdU4H
	Lqcy01ZaNBaS8PWzo0fAlBlKfJsMGP/29oii+GEseOzWdnRTzNrV3mzWNtn7Sxqg
	cqx2TgpJ94yBeA4JGn19P82GvWGobpXHppUGelmOFC96H4R3/zC6FZjK3omooTyn
	U/LOTCqPG2YVZW9yKlZwIFxS45I5QsJHntkhIU1MQTbOU87/ZhHUovSGI75anaNM
	JeSdDsKl8tcjLziMn4AaufOarPj+qrX3OgLzFwNOjXHU3W+qx+r1omPwxRIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747317483; x=1747403883; bh=8ViQm/LQN/feHQz+MzHu9j2sHkXwfrS4ES4
	oTdvwIA0=; b=igt6CqozdrsXOlUAD8+RW4dAYYYB/GlV2zWcxEUC3Zr+wt7j/d1
	KLoiIWnNBGXnaFeGv+s2WuhJz1pu5v4BtX2zTiTpfRDGEBonmqMfKta2kcTHXfIq
	lobTxL+F+fKKJrc+M4CtXt+XvSkkZRQGdbS6Sc2PajTw+0gSl1Nf/PfrC4Mdjk8v
	GTct9Kw1PnYu5V13UvCoama0d4bIgxvrh5voe8tNr+rsCuDysIOSGpREPulipDtC
	fDTKEqPYRKRa1FflgdVZKI+NG08ZcePFdy1J0oV3pPCZucAGb0PKQ0rBCX7Ls2LD
	R/inNmPsJg4tZqPqqO2VKlCTStbuGBGsinA==
X-ME-Sender: <xms:6_IlaFSX0Xt4s68led2vcEpDfQGQtSocy2SdWXDbIbF-c3i2X4phfw>
    <xme:6_IlaOwCmaerDAaV2xrQUcIdARbHPw4ixt2csDLInrZaphpVjKkYZKH1votF2XADF
    HrORE2mCBEk7Nba8Q>
X-ME-Received: <xmr:6_IlaK2etiXe5BUzRs9ByTEhaDtaSam06McoI1EfA1o8dRVSxFG8ANBkAiaCeUKqoaXsrpj3vY4i12h-7ga0oW4qhp7GvVAXdSG6TYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddttdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:6_IlaNBpsLO73VWpE0NI1lLTFGsS5_vtQeONZv66UDxxJKa_V40xKw>
    <xmx:6_IlaOixMSkF8UKmTmJnjqWHdKPowY9wg5TtTnUf_4LgwREtVSD1YQ>
    <xmx:6_IlaBrMxeJUSTdxvknGt45s36ohr9taffsy_P2nsNyc0nPIJyLiiA>
    <xmx:6_IlaJjULGrRyhXOHa6wHT-zC_6NS7I9FoTkJsXKeR3jssoLS6OK8w>
    <xmx:6_IlaJg675KfB7o1-rQVnjo7iKbjmb9C9dTlfrNcH5kZ7pnsyCyQHtj5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 09:58:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: make it clearer that commit descriptions are
 just comments
In-Reply-To: <pull.1923.git.1747275627422.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Thu, 15 May 2025 02:20:27
	+0000")
References: <pull.1923.git.1747275627422.gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 06:58:02 -0700
Message-ID: <xmqqzffe2cyd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> suggesting that users are (a) only using one-line commit messages, and
> (b) not understanding that the commit summaries are merely helpful
> comments to help them find the right hashes.
>
> It may be difficult to correct users' poor commit messages, but we can
> at least try to make it clearer that the commit summaries are not
> directives of some sort by inserting a comment character.  Hopefully
> that leads to them looking a little further and noticing the hints at
> the bottom to use 'reword' or 'edit' directives.

Cute and clever.

>  Last commands done (2 commands done):
> -   pick $COMMIT2 two_split
> -   edit $COMMIT3 three_split
> +   pick $COMMIT2 # two_split
> +   edit $COMMIT3 # three_split
>  Next command to do (1 remaining command):
> -   pick $COMMIT4 four_split
> +   pick $COMMIT4 # four_split
>    (use "git rebase --edit-todo" to view and edit)

These show the intentions quite well.  I think all places the
addition of '#' is done at the output layer, and the matching of
commits for the purpose of --autosquash should be done solely using
the internal representation without '#', this change should not
break anything, I would think, that we internally have.

Breaking custom todo-editors the users may have is a different
story, but if they are somehow matching against the first line of
the commit log message when there prominently is a short-but-unique
commit object name, they are simply crazy and not worth worrying
about, I would say ;-)


