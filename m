Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA7B26ED34
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323864; cv=none; b=mrt8850NBFEUtGwlp1KBR6I5VIyEqbfRt1ijRgrCD1BCK+sFHiDgH1kbuq7Lik8QhQjGFw04HwfrIYVXY7HDbS3SZXN+8jXHE9Pfxi1tXcCvoK9sO0fSKhlSKvW41CJiRbpx2LRKE5NbawO+a1QgCBiKu90EGNfOYXXUxm7MgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323864; c=relaxed/simple;
	bh=RpA0+l/tSpqDAy14DAkQN377p2Ie2F+KRhCUl4zA14M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QnkLBF7wYxYDzJlD0Mksjys1tpvTcQmyGkVULlFFozsb9RYAUWWKzFyrMTsGwWTS8LivbIaCv/q8oxLohtAtoZTuEbo1/i8zNJ2jLBhuetpPKtLQFEYdZkjEOObEGYghWiUA0Z4xhBOFodzfitiaidut3NuFNAmffWzWY8iJrew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SQs9Vp4t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wXGRHq69; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SQs9Vp4t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wXGRHq69"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D0AA7A00C8;
	Fri, 24 Oct 2025 12:37:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 24 Oct 2025 12:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761323861; x=1761410261; bh=lwTNf7BKNy
	CuQDqLSF4ILX028AwiHksi38XckJNfrSA=; b=SQs9Vp4tmnw7hZeK6T1kutlz2x
	SJeJoE4gKBiJ0oZ/VBvI0Epj2g36eQhhHN36CSUD/85WxYcKHGGjvLXRwvDpr5XL
	SSZMf9h0W0bMZxeclZXAOC40N6Hjv+UN/lSSD8iaE9YTlRR8fNE3E8X6ZTPWRuER
	C5l6M28T9EzH4+bpJGr3DL1a6wJ4JRQG9oQP0ddmsPDVQ+5f5wBQDNbZwyoP6/+1
	DLcNaQmxBfVp8u2cB+ksNRwAhMzuh0RFoNWWtPS3ew1Qqups5A6tfjKaYEg8IvP1
	+hz4jdwaZOLfBvu9dceB1ucMkzEka3JuDNO6n7qIT+eQ1NgX/szqy1bCHSaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761323861; x=1761410261; bh=lwTNf7BKNyCuQDqLSF4ILX028AwiHksi38X
	ckJNfrSA=; b=wXGRHq69nPfKZbgxZclD8gynCagKk22vOTCL4TTISAwOGgJmNJ2
	IjjVtAYqD2I8Y0PPhi8yHv0cjtZ5U4G6ENt3VFHQLRV4JWVYycAgKvnwYiuJCvBJ
	pTgIjMe60nd77hruq7egARF9Us2KxCECK90Z7XI2dPsDaKFzefrE1qko6NJMOsdH
	fB7VyVzXpcIT/KmFml8ewclVltLG9aZ9HPsNQ99j66mU7wjYDQbYe5FlgTZ3H3Co
	FfgtlVoG4PwYs0SxSiuIeX0yepx7Lbs9l1sMMtoB7pZhcb+7+gdgCtdgmJSePCgj
	5+ehLd074nbAZZiN0QT5l5iSRaoIxm0khPA==
X-ME-Sender: <xms:VKv7aA0NYJZLCyKBLxKL5qYS1lmtshXJht_QXZaqz-2riQSRhAokQw>
    <xme:VKv7aCg0bVK3Pw9dzTweLHNaiL9_sblvNNlsyhYztZ7SOwri1ff_37YovJiwpuMnU
    52K45u85jrRvkyVYsOO0FlZZ9H0SaUzJUrwWEHKACC_GoFZPYdcKg>
X-ME-Received: <xmr:VKv7aGQtuS4eCvUFlKEZjl-2z6BMDOmYfuJ9_AZXRzL_2Nx0JKTIfBdsIBmJwIlRZifWHa8l10dlQWOQeEb-8j_QrSW_yiB8jK61>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:VKv7aDivmrzzwSUiBUydewXzPKE0cmJmb5J7mYmPyjSoCs18oNKtWw>
    <xmx:VKv7aG5mSsmpMubc1YRm5oO6A37RH0TVlOWpPZp-Ijp76qYIGvC3PA>
    <xmx:VKv7aADyrWhdoLCamW2Kh9HN7LgLgwuX5D_i2VU-LA2N-jMG7vIwXA>
    <xmx:VKv7aNYTT1_Edr_QHsF7YnoTHfc1tbkIqq0cmNzBEFtjRoVqIQR1NQ>
    <xmx:Vav7aCrWXY7OfXlfIKxUlDOWEuGyQs-8elpXWWZpvStmLB7hc4tpthtL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 12:37:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] odb: introduce `odb_source_new()`
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-2-1a4202273c38@pks.im>
	(Patrick Steinhardt's message of "Fri, 24 Oct 2025 11:56:01 +0200")
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
	<20251024-b4-pks-odb-loose-backend-v1-2-1a4202273c38@pks.im>
Date: Fri, 24 Oct 2025 09:37:39 -0700
Message-ID: <xmqqjz0kp86k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/repository.c b/repository.c
> index 6faf5c73981..6aaa7ba0086 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -160,20 +160,24 @@ void repo_set_gitdir(struct repository *repo,
>  	 * until after xstrdup(root). Then we can free it.
>  	 */
>  	char *old_gitdir = repo->gitdir;
> +	char *objects_path = NULL;
>  
>  	repo->gitdir = xstrdup(gitfile ? gitfile : root);
>  	free(old_gitdir);
>  
>  	repo_set_commondir(repo, o->commondir);
> +	expand_base_dir(&objects_path, o->object_dir,
> +			repo->commondir, "objects");
>  
>  	if (!repo->objects->sources) {
> -		CALLOC_ARRAY(repo->objects->sources, 1);
> -		repo->objects->sources->odb = repo->objects;
> -		repo->objects->sources->local = true;
> +		repo->objects->sources = odb_source_new(repo->objects,
> +							objects_path, true);
>  		repo->objects->sources_tail = &repo->objects->sources->next;
> +		free(objects_path);
> +	} else {
> +		free(repo->objects->sources->path);
> +		repo->objects->sources->path = objects_path;
>  	}
> -	expand_base_dir(&repo->objects->sources->path, o->object_dir,
> -			repo->commondir, "objects");
>  
>  	repo->objects->sources->disable_ref_updates = o->disable_ref_updates;

Everything else is straight-forward, but this one is trickier.  When
the .sources structure already exists, we used to just change the
path in it, but now because creation of .sources structure requires
path to be computed beforehand, we need an "else" clause to handle
the "when we already had .sources when we enter this section of
code" case.


