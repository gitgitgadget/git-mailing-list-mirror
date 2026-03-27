Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F83C3C16
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774595251; cv=none; b=e4U+HpIDQPQq3ZPmall9tNFBOQDUvWCRkhLrVwzNkPf0JKXwWBLkSZHpGMCDmxjjKyrcpcOpgkNOoNziSwcclpmMqzcXJJBFWWQ60IGcu01Rrt5d1HoqUrvc4ZifwwPqrX+mnpLWEbMiQCbWO6oWnaoqxQlG3m/nCDGW/p47Uik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774595251; c=relaxed/simple;
	bh=SO44iLRJ4n18ZUhTdDxsEfXsyQq7ApCKv4qrDJ7U1Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG5Img1IT+e2a/M8nbvZ8iTDR0n5Fri90sE2SY3qO0Q4OYPkO2LwuKX5bbQB3zpa9thJpwqqtdHry4kfHDKVRSOLZ6aM0FSTkGl9HAY6y+MoYlEswT97cZBo7lWmnKqguZpyiz6iYOzo1UqVpSxDT0BswqYG6zDuUkPKtlTa2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mFeHfe9N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5j7+OTv8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mFeHfe9N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5j7+OTv8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 09F2C14001FB;
	Fri, 27 Mar 2026 03:07:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 27 Mar 2026 03:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774595240; x=1774681640; bh=OpjnIJl7cY
	dqgglfYnO98E5qnfGFTyIjvAg9phzh+x8=; b=mFeHfe9N5DNvOcS6Yvu/aLIQ+G
	KHUV0kF+gXol72OAnuFR9N+JLWHiYOyPxzOGS1TTTzZ/zzqLuzronHWXVeykPiRA
	ux4/VqXIWMComlc55H3fDfCwrnnozjOrX4yrfwaevbXsCrnf8eooBJNB1afJxC8C
	EZKvAciKigBoXIAuEnwKD9HK6h9L5dRur0RS05zvxYx1PrLjXwfnbD9UQem6X2Kv
	WDXejLYXg4XdUEa2982Zdb8JvXxwvP9xztoIyUXQ435flpRJrLR1t7lJmOv5PaJm
	YpG51LHQ3vcoBYzofPl/Sh1Z816VtTVWP2Phvm8JzpYdN7XeNmPm9vtKIlcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774595240; x=1774681640; bh=OpjnIJl7cYdqgglfYnO98E5qnfGFTyIjvAg
	9phzh+x8=; b=5j7+OTv854n5eVRxRML4fVr80QfkFeB9lyzinG6VyWd0kHzaE5J
	N7LUYigV3czhnErXzD4e9HJ4ExFZWtTWfoLAnojMAUBQqW7Z+o6fCaUswq4mh6tU
	p+t7/s8G2KBvYSxRknN9hAQIjkCTCOGxeKl+wuUZ+EyiTs3bd/IaNW+4hA6YvCKz
	d5MSLb7txoxSM2yOi9mI3I3PFuh9wCUvXS5XU7ncLilOy4qWnqPO3SUfmKwXuRtk
	2og+MDBhtbWMLFJyU44pwj89pirkqVOHH8PtW+8wFD8jBOViVDn+YJLkeoBBff2w
	sGYU27QP7pOG9EUxHrNltJaypXC0q6VEDcA==
X-ME-Sender: <xms:pyzGaeDJfpDo7kKN1IW_VA1dMgaKlJBs8TWeWWgX3VwwbppRMR9h_w>
    <xme:pyzGacN1TMFPTx7kSRQgpoiuFvA8xf09AqvowPJiQ5_5lGhS6iNCOt1Cdmdj0gKKQ
    Io7hcKfI_L8kfJlH0f23XGMed_uYYbPYm6CqBzqOuyr4F6uOmVrPG0>
X-ME-Received: <xmr:pyzGabaw4vGIFrIDXUAGmdIN9wA_1KXqtaLlUfKSG2mcl-Y8iYaUI3CcbFVuZ-yogSvlBwpg00Vv8ZSFW82_wOthOv4ZJT6H5Ae_hG68ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehrrdhsihguughhrghrthhhrdhs
    hhhrihhmrghlihesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:pyzGaTsx_kcixUdUSrcuN8fUE9G0TmRFJDHaqmwHH5tlio7fWY8lbA>
    <xmx:pyzGaVPHT_q59rFbPGJC98WkZfJJpydXBbRwHQyAa-8CfRhscPbyZQ>
    <xmx:pyzGaS6PwIrQvSkGBhp-F34PuTc8DPUMrHqECb0zmzZBNrNHz4xHeA>
    <xmx:pyzGaTTBEAUbwvxdyHYOdM-jkhqBI7oqdDIAIXK-1dvV0KVcgLJq5A>
    <xmx:qCzGaTmxqaQPTUyVlxcsJDoKz93krRdVwSne-hp9jzEktlWvAcmlJYL7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 03:07:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a991df1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Mar 2026 07:07:17 +0000 (UTC)
Date: Fri, 27 Mar 2026 08:07:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	r.siddharth.shrimali@gmail.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/6] backfill: accept revision arguments
Message-ID: <acYsortL6kx7yneC@pks.im>
References: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
 <pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>

On Thu, Mar 26, 2026 at 03:14:48PM +0000, Derrick Stolee via GitGitGadget wrote:
>  6:  9699650aa7 ! 6:  b6423f9595 t5620: test backfill's unknown argument handling
>      @@ Commit message
>       
>           Before the recent changes to parse rev-list arguments inside of 'git
>           backfill', the builtin would take arbitrary arguments without complaint (and
>      -    ignore them). This was noticed and a patch was sent [1] which motivates this
>      -    change to encode this behavior in test.
>      +    ignore them). This was noticed and a patch was sent [1] which motivates
>      +    this change.
>       
>           [1] https://lore.kernel.org/git/20260321031643.5185-1-r.siddharth.shrimali@gmail.com/
>       
>      +    Note that the revision machinery can output an "ambiguous argument"
>      +    warning if a value not starting with '--' is found and doesn't make
>      +    sense as a reference or a pathspec. For unrecognized arguments starting
>      +    with '--' we need to add logic into builtin/backfill.c to catch leftover
>      +    arguments.
>      +
>           Reported-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
>           Signed-off-by: Derrick Stolee <stolee@gmail.com>
>       
>      + ## builtin/backfill.c ##
>      +@@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>      + 	repo_init_revisions(repo, &ctx.revs, prefix);
>      + 	argc = setup_revisions(argc, argv, &ctx.revs, NULL);
>      + 
>      ++	if (argc > 1)
>      ++		die(_("unrecognized argument: %s"), argv[1]);
>      ++
>      + 	repo_config(repo, git_default_config, NULL);
>      + 
>      + 	if (ctx.sparse < 0)
>      +
>        ## t/t5620-backfill.sh ##

I would've expected this chunk to already come in patch 3, but that
alone isn't really worth a reroll. All the other changes look good to
me, thanks!

Patrick
