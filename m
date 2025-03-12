Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F8230BF4
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766800; cv=none; b=VYqe60S/+8fQ37IPPZL9LXXdgZ+4h7htTLynlUjK4iVLooWdATT8yVR9M1mZpSo+i59V6nONKYL9aOVsbCxeM/Z4lxYAsYquEQO0KnovwJ3lpcDvbjr5ppbvEQO19RijRsDC6jin3C6z58Mfk3zWytLG/B8wyj5GNZMcWdE9izY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766800; c=relaxed/simple;
	bh=4eUe/93yds9PMJpUE7cw8LCZv+f8ARiVN32TIIBNGpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7mVjEC7WmzH3TmCrJ9ne3+cNtLZLWDEdMQNk63yUKrLv1BjWG2w6KsULpBijIPWmZhPtpPE1HxwOxOReX3xv1wktTuLU4/dN9hbsZW+Q4bI9iZr4RhgpfcgXEW4sFNYMQhEgU4UvtLsCB5z+KUA0NRz7ViyBEg08QuOrpWW9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zoy37l8W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XWRZ1DRD; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zoy37l8W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XWRZ1DRD"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id AFF8111402A2;
	Wed, 12 Mar 2025 04:06:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 12 Mar 2025 04:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741766797; x=1741853197; bh=9vHYcxFJUx
	qgST4B3KxpaYZ4bQzfH3lMYkBG16wfBUc=; b=Zoy37l8WwLX8bLRgJQP1tMIr7s
	Mc1tFD2+wk1ck+mZcaRQwkShP4m7+loPQYCXfIeXwEYtxcMmVQedqOMBTQe40SVR
	qsxgokib+4fBlEay6Inb+iuL6ZRgbIpbuA2pTNQJbWrurStMjtrfXA6OgVgQtTW6
	6NbDeRkqS6vbWsz11REWGHDd1YAT5EUp1+GGfMubv4m7DRHK737qbmZAr7sd/0fy
	g9Meb26LIfDtuOVyc28RH6Z5XACWgkH3aJEJuOKRjPv5e2Vq/mXuSJK3n4VO7gzI
	e/YgTOiY7VcuT739BEiGA1qo9DaMcLYuwgUtiOGzOzWBc37b5wJKgJEpWeMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741766797; x=1741853197; bh=9vHYcxFJUxqgST4B3KxpaYZ4bQzfH3lMYkB
	G16wfBUc=; b=XWRZ1DRDVaRx4k2Q6djG/aBjZqepsRC5aJ1vrwcwCJ2RmVVFL/v
	e797CzELg1mgBC6Me5hZxP+ZxupCof0Xx65nPeVaRroeziIN3lVmfhQxbjOPtCLy
	git6OEzm8a/RGYc87KwYb4gUVdVQdX2OqqcTbf7EybR++P4pcSZeVVWHKyruauuh
	bgBDaN36tzjBAaf8a2ydq9/KcgUcaXxzdwvUAKOyvOp4JDyAIdwhU1j9BqclU3y7
	LUQzniVilRKya1pmTRxvue/79afRzHeVS7kJmaApqirBwQwujQ4ugs+pLc5xTV8K
	A4w2BFNbhjoCFOvHos6b3sbUsK6w8Bj70qw==
X-ME-Sender: <xms:jUDRZ4CZpJAP074G4lgD4NYdSbyK0KR4yQUjUEBrUG-cDKfFydLNXw>
    <xme:jUDRZ6h39EFpwJ3BnPZ1g98RvBxVJWmR0TaFimN8Ku5PFqeWW9Gns-o-DED__cb36
    ZAV-AW_LeBllC1Meg>
X-ME-Received: <xmr:jUDRZ7k62K680VO1E5eCRaaLMr1OG0AhK7F-cGX_avrS3pLxueuQG4Kpp3VueaspfbzZKoueG8IDZZBguXVePXBvswnAIjvZg8b6sCLycfIJEU_Tpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdegheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:jUDRZ-yiQozWJFLMOkmZGe-awDd8v_TZhr_XTwOaEn_JHlvZ0R5M7Q>
    <xmx:jUDRZ9Qqk6yuXvri5a9UidUmQjt4JumDEwWXTs6Z53QKvVjN7QXoMQ>
    <xmx:jUDRZ5ZQeod6Fmal9ivF8nn1Q_6MnIej43iTOwSGnRzP0lYC7ZeoCQ>
    <xmx:jUDRZ2SlYGSc20e4ahqHun7Jp09OcH_TLELjRLaBatqWxtIZlXQlBw>
    <xmx:jUDRZ_fyJyTN_i3jV7ZnUlug0YnB9AkGsrdFiR_aVAYyIpGyT_q79Oql>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 04:06:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 79b7c991 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 08:06:36 +0000 (UTC)
Date: Wed, 12 Mar 2025 09:06:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/3] merge-ort: allow rename detection to be disabled
Message-ID: <Z9FAix-VKGte8UKk@pks.im>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
 <4292b22723f759c3e0f84ac1000992187a9c7f7c.1741362522.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4292b22723f759c3e0f84ac1000992187a9c7f7c.1741362522.git.gitgitgadget@gmail.com>

On Fri, Mar 07, 2025 at 03:48:41PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When merge-ort was written, I did not at first allow rename detection to
> be disabled, because I suspected that most folks disabling rename
> detection were doing so solely for performance reasons.  Since I put a
> lot of working into providing dramatic speedups for rename detection
> performance as used by the merge machinery, I wanted to know if there
> were still real world repositories where rename detection was
> problematic from a performance perspective.  We have had years now to
> collect such information, and while we never received one, waiting
> longer with the option disabled seems unlikely to help surface such
> issues at this point.  Also, there has been at least one request to
> allow rename detection to be disabled for behavioral rather than
> performance reasons, so let's start heeding the config and command line
> settings.

It might be nice to provide a link to that request for more context.

> diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-strategies.adoc
> index 93822ebc4e8..59f5ae36ccb 100644
> --- a/Documentation/merge-strategies.adoc
> +++ b/Documentation/merge-strategies.adoc
> @@ -82,6 +82,11 @@ find-renames[=<n>];;
>  rename-threshold=<n>;;
>  	Deprecated synonym for `find-renames=<n>`.
>  
> +no-renames;;
> +	Turn off rename detection. This overrides the `merge.renames`
> +	configuration variable.
> +	See also linkgit:git-diff[1] `--no-renames`.
> +
>  subtree[=<path>];;
>  	This option is a more advanced form of 'subtree' strategy, where
>  	the strategy makes a guess on how two trees must be shifted to
> @@ -107,7 +112,7 @@ For a path that is a submodule, the same caution as 'ort' applies to this
>  strategy.
>  +
>  The 'recursive' strategy takes the same options as 'ort'.  However,
> -there are three additional options that 'ort' ignores (not documented
> +there are two additional options that 'ort' ignores (not documented
>  above) that are potentially useful with the 'recursive' strategy:
>  
>  patience;;
> @@ -121,11 +126,6 @@ diff-algorithm=[patience|minimal|histogram|myers];;
>  	specifically uses `diff-algorithm=histogram`, while `recursive`
>  	defaults to the `diff.algorithm` config setting.
>  
> -no-renames;;
> -	Turn off rename detection. This overrides the `merge.renames`
> -	configuration variable.
> -	See also linkgit:git-diff[1] `--no-renames`.
> -
>  resolve::
>  	This can only resolve two heads (i.e. the current branch
>  	and another branch you pulled from) using a 3-way merge

Makes sense.

> diff --git a/merge-ort.c b/merge-ort.c
> index b4ff24403a1..a6960b6a1b4 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3448,6 +3448,11 @@ static int detect_and_process_renames(struct merge_options *opt)
>  
>  	if (!possible_renames(renames))
>  		goto cleanup;
> +	if (opt->detect_renames == 0) {
> +		renames->redo_after_renames = 0;
> +		renames->cached_pairs_valid_side = 0;
> +		goto cleanup;
> +	}
>  
>  	trace2_region_enter("merge", "regular renames", opt->repo);
>  	detection_run |= detect_regular_renames(opt, MERGE_SIDE1);

Do we want to add a test that demonstrates that the option works as
expected?

Patrick
