Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD317C203
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289359; cv=none; b=fwk1+kf3sbnRlr1Mgz7EMToGBmjOCrlRZVTYO3aGgPbwPXRd0X42fqa/m6WswCszVR6ObyWV/g+7y4hzyoELQmLQnfucvl/hBdN5VW1sc7kg6SUWpVkrmhiWuVbQHk9egu8wJaOENzoY0hDWKIjM0Zg26QmeWanhWNZklmMRto4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289359; c=relaxed/simple;
	bh=w+Bio6dvtHjauEYKv7qsE180YIoUQNXzVyYyjN9M6ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjTqvpPRISfE8GcZw4F0qyvTRSRSBH7ScQwuA49qoaV7L7iycOmXrmVPphjCUKce7eBrYkxbIDcjdYw1T0pNWaD+pH+2hMyRL043sZiDIJ7DsetK30R9wVMipeluyPVbdW375D3o6FKCImPC8+u0/EJGIm/Gp7hAOQVE7gLPjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kx1TKcAa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HY+owNUA; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kx1TKcAa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HY+owNUA"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A30D711400D4;
	Mon,  7 Oct 2024 04:22:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 07 Oct 2024 04:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728289356; x=1728375756; bh=I1/thKJDKo
	Kbi0r8RGBKfE1EYDGrLUp0sofl3UiQNvg=; b=Kx1TKcAacLGM0fHdyAlyuKEuYy
	bbprTr8Aq1cPgiTQp7R2CBZ64akeayU9aUshnA6fsBhUgSgwrM8KgbnKjNRCWuMh
	C0I2O+3hqq5xZWZ11SoxTjT7N2GUJGNqP/8gt2t+PIH6ayEdDyZnn/MvU5oeOcI7
	j+mHLV1Y6nV8Deug0MkUvqRxkqd5AZxdePPRJWG0MeNMDJXCxrtIvy5WylTaUBkL
	w/a9x4jcPqSpEAXVHtrJ8J/+MgpBa4PewILkBGXgSn0yVBOPmUI//dm0ten+4MMG
	nKnzwLf+8PdhxrYxcMDqVD9p1yZ07lhLaxMji2xCPPhdU2jLmnjAoMqCOOaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728289356; x=1728375756; bh=I1/thKJDKoKbi0r8RGBKfE1EYDGr
	LUp0sofl3UiQNvg=; b=HY+owNUAbwMZiZHqMvS+OLwPKGezn4XzJJ69U1t2dgd+
	dUV6mz9Xg1cft/gQkiGugH9cIYvc6uGzNGN9F1EvU9cMUYjJ8vGKh2HW+walH4wb
	eGbj8t41XUuKBLR7noiedwO81dYU8JzU+qwxQpUlXTRvNJmTbxkwLqCWK9Te4VLG
	GimZpkBsdVtp9kkq6ON2KCyWG5E/rjJRGROMxoO92DYxutF2zfAHT9ejgI4xliOg
	/xJchlo2zb8SNuv7Ug3VD9nwmTPMwrDsGzUBDl8UAk27m9juTFnI3Y37S24hDqZ8
	9kPJRE420kSMyQE4j5TH9rZ36DVqWu4NPuRNkFwmIQ==
X-ME-Sender: <xms:TJoDZ9bWvWBEJBgo-XgLBob3aU5nRBetJFi2aInBtvXB3ync1u4nAA>
    <xme:TJoDZ0bZFql1hryiZFLaYC54qo73YczYfjP5AC_I2Q_kDZWbKmPxRXwN9EuTugzAG
    qhD2GsBjRxIlFD6KA>
X-ME-Received: <xmr:TJoDZ_--1312h9LMEJcRRjbCVa5CDxxSQ3nIxQmgZ4r5v9g6BjRBygfQef29Su8_x311z_4fk0eAnjAIlvky4UF0azLuDY8Lnko4WVY1C9t9LF8BBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepgihinhhggihinhdrgiigsegshihtvggurghntggvrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepsghuphhtpgigihhnghigihhnseduieefrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhht
    rghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsmhifihhllhesghhoohhglh
    gvrdgtohhm
X-ME-Proxy: <xmx:TJoDZ7rYbOTndnGarp8DEi9DUplgV2etlVyAWUmOiei_8HSw-ja9PQ>
    <xmx:TJoDZ4ony2CbxhYD-t0BGah3GExv7OvuPUq1SNWCgJO-Nlwrlv5zDA>
    <xmx:TJoDZxRuJFx_eOXX-Ccd1wxJC3khrH7pEhFOIoNaAd28iaJv_3qa8g>
    <xmx:TJoDZwpodjvg1H-2xCsP8Ydi3MxfNyKfm1mzlgujIq5IAiuBXlLK7A>
    <xmx:TJoDZ5edRlBZyN6RCPH7krxxprhkY_6P3YMBuvypNAJ1RFkDJkAVwy2f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 04:22:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 28c147a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 08:21:34 +0000 (UTC)
Date: Mon, 7 Oct 2024 10:22:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v2 2/5] remote: introduce remote.<name>.serverOption
 configuration
Message-ID: <ZwOaR5OqdLaS4cu6@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
 <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
 <2474b4c69d68576e901cdd6381aac9410cf21922.1727093878.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2474b4c69d68576e901cdd6381aac9410cf21922.1727093878.git.gitgitgadget@gmail.com>

On Mon, Sep 23, 2024 at 12:17:55PM +0000, Xing Xin via GitGitGadget wrote:
> diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
> index 8efc53e836d..8ba48573fb6 100644
> --- a/Documentation/config/remote.txt
> +++ b/Documentation/config/remote.txt
> @@ -95,3 +95,13 @@ remote.<name>.partialclonefilter::
>  	Changing or clearing this value will only affect fetches for new commits.
>  	To fetch associated objects for commits already present in the local object
>  	database, use the `--refetch` option of linkgit:git-fetch[1].
> +
> +remote.<name>.serverOption::
> +	When no `--server-option=<option>` argument is given from the command
> +	line, git will use the values from this configuration as a default list of

This description feels a bit inelegant to me. How about the following:

    The default set of server options used when fetching from the
    remote. These server options are overridden by the
    `--server-option=` command line arguments.

> @@ -125,6 +126,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
>  	struct remote *ret;
>  	struct remotes_hash_key lookup;
>  	struct hashmap_entry lookup_entry, *e;
> +	struct string_list server_options = STRING_LIST_INIT_DUP;
>  
>  	if (!len)
>  		len = strlen(name);
> @@ -143,6 +145,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
>  	ret->name = xstrndup(name, len);
>  	refspec_init(&ret->push, REFSPEC_PUSH);
>  	refspec_init(&ret->fetch, REFSPEC_FETCH);
> +	ret->server_options = server_options;

I was wondering at first where we actually populate the
`server_options`, until I realized that this is only done to initialize
the `ret->server_options`. I think it would be less confusing if this
used `string_list_init_dup()` instead of the local variable.

Patrick
