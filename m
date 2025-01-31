Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29FB1F03C4
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351180; cv=none; b=aWBjcamK9aH+f9tsJ1zGL5OqOUEMFOstlW5/9aeDe2xOMgeWmiiIU2xoadd2TCUCcKv2MKyFLUeh+ayVhBXWOM2fkj33ltCCgn5/qhSaLijVIPfHTARvbwf82/MnovmtrgcREAAAgJTRGhCL+YckA16VhVcfgVLAC+08dGR0bog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351180; c=relaxed/simple;
	bh=cQsX+/vFtxIYK3qiEcrGYpykknwNYBzVgeUIuG0+sOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I3fgX4NMMWhHrCqGAby4WhxxQnHRRRnKk/1ZhmOcwe5+aoXXn+TN/lHrusTxojqMvE7LtM/10AcYrzNupz3Q6o0OO10aafg/3zdTHtEeECf+o8brmfpudbveZIG/qILJusAkG/v4aWVKky1LUJ5nXIOwJ71FEDBApHkXONz+XZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bxPYniFa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JbQuqafj; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bxPYniFa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JbQuqafj"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 850132540149;
	Fri, 31 Jan 2025 14:19:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 31 Jan 2025 14:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738351176; x=1738437576; bh=D0m0fEQZsA
	2o0SmeaZy7CoUeEcCQ3kujGWDkVbajzo8=; b=bxPYniFa1aUIygXuiJzPqTbaYk
	dyGkjzigSH2fqnsOVbjCvlCpz3wI9bI3ZTZbxp8Gf2VVbnh/c76rSi4opq9CuKn4
	EQft9Q2FeAh27DyC8FFjUmZJyFtEwe2dL0Rc/itDLBtjWYo9vEmFXEsy11f2AqDo
	tyU7Ay1hCZp7UyBW0e21rwV0Gz8fBDdGErt3ubFnYvdSTZsrkgjBnUYy1vMXp4u6
	ax2NX8qyrgJYCJ5nRQUsibF/ccMzJRyqY/PbRKv9O0ilbgEQvI3CtFAMaKqAFYgi
	aPr7tgr8YX9K/0ljjF5N74RbOrQb3WFzuCIkjHDl1YcUHR5DMXock8R4AsNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738351176; x=1738437576; bh=D0m0fEQZsA2o0SmeaZy7CoUeEcCQ3kujGWD
	kVbajzo8=; b=JbQuqafjrNzveUz8MBd4RFtwLebE0bWgY0K8N1oJexnUEdJKjIM
	Pc8DDmlY34/MVs2VL+vgEwjTqXc9z/A4k97kxxhQ+N809Hnw2DMdKyXJhAGjW5Xh
	p/maOwX/VKr2m3F/iMB1cPnlJmsXre4ppkQjuTRfpglinIFEXHn2IpUZkBYrGpoZ
	LKTxSNQNVdWcCtj62FkjGuawITh8RanX6G/byjSRxQ3350/z/4Y1iktxMLwv9C3e
	6CyTFTusQI+CrjAMt3419hxrAkkZmIrwcjKwV1laSjrQcpJWWq1Ox8gR7rdKiCeL
	/Z+H1fuv6A9QMswxhoUfPKGKcZkGBF23mIw==
X-ME-Sender: <xms:SCKdZyOdM5PQuJH3xMxRRoXi3Nunp-UXV_MpsmDW0slbcViLgTgK1A>
    <xme:SCKdZw92YYoQ7px8CCrnvQKG3G0GgyRNHLCLR2yTM_mFT-3P07qtOt4yN_xP249hI
    UooGNYQrFHpjX32-A>
X-ME-Received: <xmr:SCKdZ5QWxUr9SBRcrDf474K6lMBxF-n86Q8w8HKdWMQtPXLDx5dWOcEKcwTfs-nEkYiImgJ5B-1nHRliAWLAa2jPWpY8h36BXhoG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdr
    shgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehlrdhsrdhrseifvggsrd
    guvgdprhgtphhtthhopeholhhgrgdrphhilhhiphgvnhgtohesshhhohhpihhfhidrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SCKdZysBh1VeWrcBeiNTKACHYc4_1ex4-plTPIQl0hUT10KqcKLYGg>
    <xmx:SCKdZ6flb08jL3JOeRJanBlSwzIl3X8NmGy4uxltRuiLEddI0lumTA>
    <xmx:SCKdZ21u02OMvWwvEZHm7EKS8T8NlAGXejd0jVRrB88CQM8miMvjKg>
    <xmx:SCKdZ--DVTvigZUMwwkFgjOhnq6xSrY0maopn-Uy4gsw2VEQZdxflw>
    <xmx:SCKdZxzM9nixk_oZNzGwqkSBsMnxGaw-N4y0VUmmyPCocnW_uPdwahQs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 14:19:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Olga Pilipenco via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Olga
 Pilipenco <olga.pilipenco@shopify.com>
Subject: Re: [PATCH v3] worktree: detect from secondary worktree if main
 worktree is bare
In-Reply-To: <pull.1829.v3.git.1738346881907.gitgitgadget@gmail.com> (Olga
	Pilipenco via GitGitGadget's message of "Fri, 31 Jan 2025 18:08:01
	+0000")
References: <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
	<pull.1829.v3.git.1738346881907.gitgitgadget@gmail.com>
Date: Fri, 31 Jan 2025 11:19:34 -0800
Message-ID: <xmqqcyg294ft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Olga Pilipenco via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> +* When in a secondary worktree, and when extensions.worktreeConfig
> +* is true, only $commondir/config and $commondir/worktrees/<id>/
> +* config.worktree are consulted, hence any core.bare=true setting in
> +* $commondir/config.worktree gets overlooked. Thus, check it manually
> +* to determine if the repository is bare.
> +*/
> +static int is_main_worktree_bare(struct repository *repo)
> +{
> +	int bare = 0;
> +	struct config_set cs = {0};
> +	char *worktree_config = xstrfmt("%s/config.worktree", repo_get_common_dir(repo));
> +
> +	git_configset_init(&cs);
> +	git_configset_add_file(&cs, worktree_config);
> +	git_configset_get_bool(&cs, "core.bare", &bare);
> +
> +	git_configset_clear(&cs);
> +	free(worktree_config);
> +	return bare;
> +}

That is nicely described.

>  /**
>   * get the main worktree
>   */
> @@ -79,16 +101,11 @@ static struct worktree *get_main_worktree(int skip_reading_head)
>  	CALLOC_ARRAY(worktree, 1);
>  	worktree->repo = the_repository;
>  	worktree->path = strbuf_detach(&worktree_path, NULL);
> -	/*
> -	 * NEEDSWORK: If this function is called from a secondary worktree and
> -	 * config.worktree is present, is_bare_repository_cfg will reflect the
> -	 * contents of config.worktree, not the contents of the main worktree.
> -	 * This means that worktree->is_bare may be set to 0 even if the main
> -	 * worktree is configured to be bare.
> -	 */
> -	worktree->is_bare = (is_bare_repository_cfg == 1) ||
> -		is_bare_repository();
>  	worktree->is_current = is_current_worktree(worktree);
> +	worktree->is_bare = (is_bare_repository_cfg == 1) ||
> +		is_bare_repository() ||
> +		(!worktree->is_current && is_main_worktree_bare(the_repository));

Is "this worktree does not have is_current bit set" equivalent to
"this worktree is the main one, so is_main_worktree_bare() needs to
be consulted"?  That linkage between "the is_current bit unset" and
"is the main worktree" is not obvious to me.

Thanks.
