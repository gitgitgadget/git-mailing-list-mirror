Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBCD36074F
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339168; cv=none; b=YNR3EehrkS9RBvenjlu3yWxq8VpUIsPH24letFxM4xHFjNLQAOp6BnP3JbTQC7BHqv3sN/eO0iAOiCx935nf7j9XWTGoBjoQ2sIBO/Alno1F044nrHp2IwYHooWXiq/wwUp+B+Glgx7Wp049ZPR3G14UEi25x9fnmLxJEclyN/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339168; c=relaxed/simple;
	bh=ievtW3x511HSuN7n8g/MHWkX+MukzsPgQCiMoNq1xlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCIUB0WpSzorVGnLcSc2PxttgT2UBtrQYNFlYMyHPCH4Zb7QcHx6TgczkV1kurszcsXJADcIsjTOWkP7u7Xc+d5tqe8MvVMefUgj4ZNV0fWpdwB3UIwD2paXA+dV0uu0HYFoVoX0gaqhqfiiiwDy9HMzyhJh3iNVdoYXYtCooe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cDmGay4v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+yH+ttN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cDmGay4v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+yH+ttN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E209EC01D6;
	Tue, 24 Mar 2026 03:59:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 24 Mar 2026 03:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774339156; x=1774425556; bh=0RnDNLpu2U
	5vsFoRRFYazgTjckZmDGyh3yGG8MI4ck0=; b=cDmGay4vlbaPRWoehbj0jztqt2
	VseEehLPpjLf2mgHhGdx/gAif6cMw2K0obrnkct5S/BgXuxqREX+zdLzZTMzIkFJ
	29WpiqvPq0h9eWHEohQ5LbihnZ6vq03i/+En3Ov1dD8LCh42/jSDGiIb6n66HrgH
	myZCmqRxvJchcrrY6bUVIr7l3uJIVk0yuO2YKdyh7ifxsGbE+on7ubVlPeE6JZ4G
	lO7KweWA7vZgJ+527lugNZSet0qfrv0vfB1NiJD4qPpDCxzKcn3BnO1mWCMAyckJ
	IgxV2Zkhq3mMZwUvT7KGE7IdN+1Y2QkGojkgZz246juynn9+HStSAxZMDDyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774339156; x=1774425556; bh=0RnDNLpu2U5vsFoRRFYazgTjckZmDGyh3yG
	G8MI4ck0=; b=a+yH+ttNJKzyE4FGvXP4Hx5aMPbulOuKuznm0iP5YsOJE1PlIYx
	ut9hM7yWRW1qntlh7tGx1HfgW52SSt9JGATV3D929UQZ6c1WyhnPbVtEQ50MBjZl
	smrnscQrwQmXyPEr8LwE//PYtxV4pENxQSg6JuQbLtcvd+HlAmZbqynPVjxTa6SQ
	Ppz1ow1qbw6XEG+PUMmxCJykoVbL43x2RvR3BedyIgTtNj8uecDCny7Mm10hshJu
	Ah2EuVg5m4Wsq6hmicqQyjWwH74fQIuRdoRDJem3AeUxUts5s2u/ijk6zhfYWcLz
	jr5u4Kas9FugIEzw6KP0Ozj24eQ7JGgZfQA==
X-ME-Sender: <xms:VETCaeH8jWSHY30dhnD7TrhNS7VMoOINcCELukjixhcIJHlDJlK70w>
    <xme:VETCaTAThJY9MQghZvwyB1OkX4zHPdNa9K-saxdNsQRmWjcLSyeOizpZbdDMVsqMi
    rRNa1L4OJBmjFyfvAn5GX--vnuGID2y4xTivAKXEgTBkhjx-xSafA>
X-ME-Received: <xmr:VETCaR-mfFhdtEn3J9_PC0ZpZYTJlun1rVfn95euoAg4Nr469glyYBUsjclMp9w6fGDATzBAHObN11VdH0e4T_UBeeaKLgNQt3faMO967cQQmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddutdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhdrshhiugguhhgrrh
    hthhdrshhhrhhimhgrlhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:VETCafAE1JRufgEobFeoZBr5yWATTSyfw2p6LnF3eo0HbsLZANXRhQ>
    <xmx:VETCaWSJa-4qQ8kkOgfLys9ikEJM2f6BkvOxgw_4n87Rv6dRmJtZbw>
    <xmx:VETCaWt2mRCqrBuv51_UXzaJOOA4XNuMnC09GtfbnPbVKphb6P-lig>
    <xmx:VETCaS0EaPTWWWPPodYTXhvrGx9ZnLxlSsHw4l0xjwvLG50u46cS5Q>
    <xmx:VETCaYpSldmXp91pDcCDIK7eEVD5McJcwxXeg3jLfaGKs-SDuRdpiAoh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 03:59:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86fa3c72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 07:59:13 +0000 (UTC)
Date: Tue, 24 Mar 2026 08:59:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	r.siddharth.shrimali@gmail.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/6] backfill: accept revision arguments
Message-ID: <acJESdSvJUSCSWtK@pks.im>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
 <610a162973a7ad59eba4ef4d5a9288f1fea1d2e8.1774266019.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <610a162973a7ad59eba4ef4d5a9288f1fea1d2e8.1774266019.git.gitgitgadget@gmail.com>

On Mon, Mar 23, 2026 at 11:40:16AM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index e80fc1b694..90c9d84793 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -134,7 +135,12 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>  					 builtin_backfill_usage, options);
>  
>  	argc = parse_options(argc, argv, prefix, options, builtin_backfill_usage,
> -			     0);
> +			     PARSE_OPT_KEEP_UNKNOWN_OPT |
> +			     PARSE_OPT_KEEP_ARGV0 |
> +			     PARSE_OPT_KEEP_DASHDASH);
> +
> +	repo_init_revisions(repo, &ctx.revs, prefix);
> +	argc = setup_revisions(argc, argv, &ctx.revs, NULL);

We should probably die here in case we still have unknown arguments.

Patrick
