Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97234251782
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072179; cv=none; b=TJwwQXN93zm7ZTwRwfHjMXjDhF251e9MgVs0xzGDCz2ZE44dwYp2ei6BE9qDdRD7yoQQKI9QaTrEstfm/n9Lx40REVQmTGp+4rFE2M3dSd6pYmQKDA1h8POkAjwWGwqU0hbaI64xdfw31Sf8SS5fc1xgqBjD3cqPT6ZqIz1cXQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072179; c=relaxed/simple;
	bh=KZc4LSYvkWpU81hfJUVwRtmgLx1UcIt1f48gFUpMwOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VUXGgMdB/P60RybR2c7pyr8jMZXd0HLG4lk+LNAadR5ONgCnO60y+Z7L8g/XLBYh4+kYYY++ow3hzA/UbvHTC+Ufr+ByAkpdvvHN81tfvuS5gvNtg/0pgRkoX6VAewq1eGcicfx2YhvMTcDuIACXNs47NqXQUPCqtLTExyLJqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=boNzUVrh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BmBl1PUc; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="boNzUVrh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BmBl1PUc"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7FF492540163;
	Mon, 12 May 2025 13:49:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 12 May 2025 13:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747072176; x=1747158576; bh=E/8hDGmdyp
	lBXX/ZJwM9yuQ1KB4bOPQom5EbOMPv3Yg=; b=boNzUVrhX8jRlE83Oz+FHOpPP0
	oqzzuRgbdswgeTvlZ2oydrIRgiovOTgO+pQipMHRd162aH7L59lR5W0SabqaQsrV
	7fqI5K+h0C8QT3A5SS3DZWv7/6gT0CZaWivcBusSD38LMfeF3XjVdhBaz+h6/zef
	mB+tTq5Yl1HXhb2uJbDCZg+gvBDgrMLujDSeG7jRztplcosKatqAeILHLC80rwHX
	W+buqA2xjNTXcNuYWD5DoYjAIwIY+12YNczdxc1SU4ZcJJCvfDJEEFPlhdA1tvci
	PmvOTr1Li3XX25Qq1yYejj3gcidwNNZQNwfji3/EyW8W/n+vGdbDeX8YbDOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747072176; x=1747158576; bh=E/8hDGmdyplBXX/ZJwM9yuQ1KB4bOPQom5E
	bOMPv3Yg=; b=BmBl1PUcX+TDNHSewa215EbNYsEpm8aH+SZ/hlvInOpTt4MGZjM
	IQSK5P9hf0Wc/hznRS37p0B5UcU4XbnKvVqqk+TaIUbpLaAhuFEMcL+Vzb/IC1Rg
	GO57uPAO2PZOS6lnUYm7On8ajmf2ah3OwEzEkNnTnC6UAPhKg7V8Swp+Daci/RVa
	mRGJ0t+wWtBC7xDVxWh026bpGb0smTMR8SdJzXl6ZLXB3MjIZom907+rmEoxh3fO
	5uHSfu8DxX8daqOpVq0e/n6vW43b1XYkzfaPRPyL6hfA4r6sblTISl1B1LT5PdHG
	WSIj0hxsIXYPQNgT82C6eO0PZdJbVdGY6iw==
X-ME-Sender: <xms:sDQiaGlLKiJlTlAo_PIhsBYUt9m46jH08Ok3U7fvNo-O8u69ZBZiMw>
    <xme:sDQiaN2NhGZJ8QYsQUzRptXz4EyOpyFA0U0UApCbnZ9F-KCFWU1of7ZAaibX9ffJo
    Elg6hyxF34E65rYiQ>
X-ME-Received: <xmr:sDQiaEpNASN4XGa_LR7ZzWePlzDu7Q1tPrUOWa8fvsqvjGme8sA7JjpIYs2dOLEl4jiz4jAQxvsLqQptR5WqXPUKzP0duNo5lLuvL98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehs
    mhgrtgguohhnrghlugeskhgrihhmrghgihhnghdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:sDQiaKnQGcSsv4tX9T2lphSvupL7bG3B8AAp7frCSgrtzjD0F9gofw>
    <xmx:sDQiaE1yhdZkeeAQWF1Bo2WrlL8jJZalBZ-zQ8-k3RKVNKVfe9VDEQ>
    <xmx:sDQiaBt1ZeHcaxBnK6HBQhUO48fvJjl4iKvDBzT-QwSJkPYZC5a2Iw>
    <xmx:sDQiaAWw6vDk-inPAj1Bu6R3n2Nwx_J49mLPxBDLKZKsiIqd-1jwPg>
    <xmx:sDQiaNbJvMfznPclXgRJWHIuU0olMEwDVOJBlCXEWzq_CXqp0jBxvBtt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 13:49:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: smacdonald@kaimaging.com,  git@vger.kernel.org
Subject: Re: [PATCH] stash: fix incorrect branch name in stash message
In-Reply-To: <20250512164001.62065-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Mon, 12 May 2025 22:10:01 +0530")
References: <TO1PPF29324B4CE2F822159A3F1C6A5F3B4CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
	<20250512164001.62065-1-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 12 May 2025 10:49:34 -0700
Message-ID: <xmqqtt5psor5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> @@ -1377,6 +1377,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>  	struct strbuf msg = STRBUF_INIT;
>  	struct strbuf commit_tree_label = STRBUF_INIT;
>  	struct strbuf untracked_files = STRBUF_INIT;
> +	char *branch_name_buf = NULL;
>  
>  	prepare_fallback_ident("git stash", "git@stash");
>  
> @@ -1404,11 +1405,20 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>  
>  	branch_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
>  					     "HEAD", 0, NULL, &flags);
> -	if (flags & REF_ISSYMREF)
> -		skip_prefix(branch_ref, "refs/heads/", &branch_name);
> -	head_short_sha1 = repo_find_unique_abbrev(the_repository,
> -						  &head_commit->object.oid,
> -						  DEFAULT_ABBREV);
> +
> +	if (flags & REF_ISSYMREF) {
> +		const char *tmp = NULL;
> +		if (skip_prefix(branch_ref, "refs/heads/", &tmp))
> +			branch_name_buf = xstrdup(tmp); 
> +	}
> +		if (branch_name_buf)
> +			branch_name = branch_name_buf;
> +		else
> +			branch_name = "(no branch)";
> +					    
> +		head_short_sha1 = repo_find_unique_abbrev(the_repository,
> +							&head_commit->object.oid,
> +							DEFAULT_ABBREV);					    
>  	strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);
>  	pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);

Funny indentation, and branch_name_buf needs to be free'ed after use
but other than that, nice digging!

Thanks.
