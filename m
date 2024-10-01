Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2F1C6899
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791775; cv=none; b=lCalz1xJt41fus1ndgRA9f7STN94LKCH4WEHqmLH2sMOsBN75qfRMwAvADUcTR7FSPk/GQKnCu6UhA/AOIPhm6hki2uGxyTVDlNLy5rDEggr61tnGktPBZJ4151NemVnOFk3Iqwk2TbOBktQxx+Zym62pdZpolPTM6CynTvobR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791775; c=relaxed/simple;
	bh=tKMPKGzG4A0dlq86pje2q+M/Q1MyEzo5AF7cR1ZLeeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxBzjWBIqWD5t5NHLYTsCVxdTgG3ULGSh6JdGRIkBt8/Hpe0WQapZwma93p5NGNFp/5ksITZyGHfLvb/7cyisXrPHZe8M2llrScgoTwURGCLEzF/MIBFA0pc6NUTMvk7gbSvssJwRzrNUsQbJU4o+p7SzvhY5TmNGMQe28yKONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dTcm3j//; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCdRcTkf; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dTcm3j//";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCdRcTkf"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 79EBF1381950;
	Tue,  1 Oct 2024 10:09:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 01 Oct 2024 10:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727791771; x=1727878171; bh=P/832HISi+
	ILtMEAkuh6Addia/shjCaGl5MxdQY1SpY=; b=dTcm3j//RxQGnNCgQ0BE0690/s
	LO9i4s52Ofgb7IobpbfGDs5iR1vYiJtaVctoSHLhxaLeLMAKs5Xn5vJ9UbVkrDiv
	l2J2Wec0eGVJtWpkLZSyL3nXi4lkL9BterAiRNpmgK+xsyxXuSJn3CjRp4IrMy3e
	iZT/Z52faJh8w9FWaRLAOUL+BcBP9/0Sa9siCX8ig13ixHl/hvxMejhOwrfVjgLR
	LV9XL6SDKbcqpTCzgoGDFk3CB/mNYHJ+O2uGEfoG1rgtZtIOLL7rCUtqdkMkfQQN
	P0+ZswReVztH42RquEV1/xKnFytPkwBWgWIVIITtLyj+5FufQp37llBMy01g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727791771; x=1727878171; bh=P/832HISi+ILtMEAkuh6Addia/sh
	jCaGl5MxdQY1SpY=; b=VCdRcTkfAvs/bM2tlXZY/n4SodgJn4AAQs6fPMR2iaQn
	JhEavxAHtRjJjXjrkfV9IIxHOSyLpNj6H5MHxsU5XKY4fQ/YQgE6AXSaBlT6/rZZ
	7RfdxXZTQp3b2Rewu0uUjaGCLviU89oPQTY4M4UHh+i1PoHX4UFxqGwi0yqBDvQp
	l546GXeJyaoXAzYjYaLRuz2SZvm2Igh4jgRkzawNumX4QMwAuFlQxE1IfWQPCXkI
	M7FGLT/u7uR3dUo2g4h6Y/01e86o9k4PIUdTq+BlTGr08u4Adg9Vpgc8carN5Ww0
	bu07LupQjNHxKAuTjaRnUQ8YKZPFVQr4RZ/3W37vPg==
X-ME-Sender: <xms:mwL8ZgR2T6FcijOzd_hgilofyI7NH-FEP6PmFRg1Jyb91t6oEG5e_g>
    <xme:mwL8Ztzzgp5zK3iIg6TdPzqEuDKfwZU9PIShgb-4hBvWe6Xrjyj4a6U5AESle6nye
    YJlvmOTemStiwsnjw>
X-ME-Received: <xmr:mwL8Zt3UCbMLgFrv9AChXgFjSe4xK04KiZiyoc2EQ9nfnBuVYgGD_UPEdlUEzQtBspRvnrSHxKrZvpbTzy7zB_rwhFRIyqClA-LHl9jgApCFnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:mwL8ZkCcDTdsbU2InpUcc__aKY0Ry_Wv4_aMzDV_vxSI0hcjTqFX5A>
    <xmx:mwL8ZpjLcHJTllpGPrVGh9nu5Qb7piatDeG_cj-2iRl33b2bBcHvuw>
    <xmx:mwL8Zgrc9xFOvU_7XzUJZjzrGgmDNrgelN25pltk3Cnjwkmt2Ok0wA>
    <xmx:mwL8Zsg9D05QSCwQhQEd7fgMJASke30O3WEQCtkW76X4Q62ec9Ddpg>
    <xmx:mwL8ZnZZJsCtu-Ie4K5eolkbfGtSb0JQ89wpZ7MDsugAhOSNv76Z0Mdf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 10:09:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af0152f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 14:08:39 +0000 (UTC)
Date: Tue, 1 Oct 2024 16:09:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 3/4] apply: remove the_repository global variable
Message-ID: <ZvwCj4J_HRiSF_S0@pks.im>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
 <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
 <d64955a2e277da138146020f6a0cf96f4636a162.1727718031.git.gitgitgadget@gmail.com>
 <xmqqy13852jk.fsf@gitster.g>
 <ZvuBduVg9TJeULpl@ArchLinux>
 <Zvvr1_9syRh1McVA@pks.im>
 <Zvv723-OwvEr0qMV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvv723-OwvEr0qMV@ArchLinux>

On Tue, Oct 01, 2024 at 09:40:43PM +0800, shejialuo wrote:
> On Tue, Oct 01, 2024 at 02:32:30PM +0200, Patrick Steinhardt wrote:
> > On Tue, Oct 01, 2024 at 12:58:30PM +0800, shejialuo wrote:
> > > On Mon, Sep 30, 2024 at 01:06:55PM -0700, Junio C Hamano wrote:
> > > In my opinion, we should first think about how we handle the situation
> > > where we run builtins outside of the repository. The most easiest way is
> > > to pass the fallback object (aka "the_repository").
> > > 
> > > However, this seems a little strange. We are truly outside of the
> > > repository but we really rely on the "struct repository *" to do many
> > > operations. It's unrealistic to change so many interfaces which use the
> > > "struct repository *". So, we should just use the fallback idea at
> > > current.
> > 
> > I disagree with this statement. If code isn't prepare to not handle a
> > `NULL` repository we shouldn't fall back to `the_repository`, but we
> > should instead prepare the code to handle this case. This of course
> > requires us to do a ton of refactorings, but that is the idea of this
> > whole exercise to get rid of `the_repository`.
> > 
> 
> Actually, I also insist that we should refactor here. But I worry about
> the burden this would bring to John due to we may do a lot of work here.
> So, I expressed my meaning in a compromising way.
> 
> But we should face the problem directly :).

True, all of this is a long-term effort that is probably going to take
us many months, likely even years. So people working on it should take
things slow and refactor chunks that are mostly ready to be converted to
get rid of `the_repository`.

That will sometimes mean that you have to scrap the conversion you're
currently working on because you discover that it inherently relies on
`the_repository` deep down in the stack, and refactoring it would be a
huge undertaking. That definitely happened to me multiple times while
introducing `USE_THE_REPOSITORY_VARIABLE`. And every time I did discover
that, I went one level deeper to try and fix the underpinnings first.

I mostly don't want us to blur the lines by silently falling back to
`the_repository` in situations where we don't intend to. So I'd rather
go a bit slower overall and design the code such that it doesn't fall
back anymore as a way to prove that something is indeed not relying on
`the_repository` anymore. Otherwise we're going to make everyones life
harder.

Patrick
