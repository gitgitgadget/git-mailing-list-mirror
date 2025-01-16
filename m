Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A92198E78
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021667; cv=none; b=G06Gm4Gl6Xw3mB/hbViJmg+tHaG3zE+/ja+spaNiY4Wv6v8OGp8ZLjdPZEnQovS2tGNkxLPu9MiMUEO+z+Q+8dyyzH+AVW+XULDAcrCSd/VC9XhtYdPSIp0eF5RVO54kHounTpVlUjUZrJDZKUkKvs3vwbp0QmZP8vi5xslh7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021667; c=relaxed/simple;
	bh=3xIfnWLKoVj8D8SJhcLyX7PT3FUd4injdY8IWbukFQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+HafZHVI2KA42VMOgY1lLrTVRBaV+A9IiF92XGxCazDVM+629Lf/2GMwum6H3OetJclAeaZtzg0c2NEk0rYXKujrB0lSJHaGcOAqp/as+VbS+AWHtBf7MHEqQWxp0YKV1FNQJJ8xbdaPl67RiyMBd1DNeM5LX5mQkpw7NW2rmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f8ayfJ77; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=weje/Vvz; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f8ayfJ77";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="weje/Vvz"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DFAC525401BA;
	Thu, 16 Jan 2025 05:01:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 16 Jan 2025 05:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737021664; x=1737108064; bh=ZgMI8C4LiX
	+A3ObSs8UNCwAB5cdlF+N0DfSwthqOf4s=; b=f8ayfJ77E8P48x9fcMOFrT2cCM
	KSP3h4GEpVWMmBeeF/YyoBiy3XfPBPn8JOESS212ZO3JEt3to2RbkexXET9xCtQu
	P429eMRFZm0w+2tRXU0z5gQ7S77W0WmWuW9tPJAAww8gSJCCy0VmkRYe9tqc1FZS
	H2Lki8UyqFFMHGf4qCrR/PhZSKr4/KjD8h9L/tiEn/kFptvzLwLDyMuiLOtR4JPe
	bOge3vG6R/zOeG4bw2p25ju541cY0nO6oWScm7npaFUsvHii2gYl/pj8we2aWoP5
	Tojo/7gWZiQEK+toTM0CJ1QUpWIprM5CIQ5RQek8pHyyU06PRzCIX/Vb4UdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737021664; x=1737108064; bh=ZgMI8C4LiX+A3ObSs8UNCwAB5cdlF+N0DfS
	wthqOf4s=; b=weje/VvzRh8J/2OYql0/djLM0qlURzELr1lNtOszKF6rGfqHWhO
	9PJPiE4GvUW8gzy3nPWy/N8mvAcHFybv7LXjPv43KvEOHay3AiyH9Q86KMwgDaWt
	sA7w2Wc+tVgbpKdgt0LuObOGcc8s8GQIopdJtcKzlqoIcQ0RlU61y/htrqc2W/WB
	KKdRCze8MOl5wnIVPsASwbZaB5fg6GbyFktk3PnZqwPvcPwy4KpqtwkyO7WKeD+A
	UA7OREj2JJifonZsRhDUMFta+J4Jkm3cHNfeGPYT65sBsjw5HdfcL+FWEzwutYmW
	112o1Urmz+HyWFifCJTp7x1mUh07YIURIMg==
X-ME-Sender: <xms:4NiIZ7oYSvSDL8fzLj6oR2p9VVR_GlDt744YvjLERfveOR3gNvMDFQ>
    <xme:4NiIZ1q_MfVO9JB02kiHOqR2up4knnOvxSPhUrDTwGQ5OwtXD76FlT7gwHwfvLQPd
    GyLLIM3NOatd_LLvQ>
X-ME-Received: <xmr:4NiIZ4OtcYKyzXEa6BFNn4ej6kgkJYBOH1YbGJ_ThltyeCXGbHCGOuuBqBzhTLS--UxF09gbMPoJxkzO-5pJm7RelVom87zXz-inYDsZDZp5ZhgrvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvrhhrih
    gtkhhsthholhgvvgesghhithhhuhgsrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdr
    udekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:4NiIZ-7-8X8NmmbgMy4f03701spTMsh6v0YE1l6kxETc2D7ruDFR0Q>
    <xmx:4NiIZ64jv4jvp0o3AYAURFFl8ujgy8wbqeMpqOmvPQ4KgO5B9pqyvw>
    <xmx:4NiIZ2ghvzxUcQ_Ln_UBEwMATnuaApjWgnpHIUzNieBfCYr16SarxA>
    <xmx:4NiIZ8464gMYlhrdn699VfXYnnYedUvv4jWsMe474lhj-peW8JB5CQ>
    <xmx:4NiIZ5R8gZP3Vx80eTGHPD8BXk9M_NPGaDI3FlXxRQPoB-5OlF3RdWr5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 05:01:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 17af8750 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 10:01:01 +0000 (UTC)
Date: Thu, 16 Jan 2025 11:01:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik.188@gmail.com, Derrick Stolee <stolee@gmail.com>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/5] backfill: basic functionality and tests
Message-ID: <Z4jY3EQbC42scEIF@pks.im>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
 <e4e88794cae7edc568dd054b1376caac7fd30076.1734712193.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4e88794cae7edc568dd054b1376caac7fd30076.1734712193.git.gitgitgadget@gmail.com>

On Fri, Dec 20, 2024 at 04:29:50PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index 38e6aaeaa03..177fd4286c7 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
[snip]
> +static int fill_missing_blobs(const char *path UNUSED,
> +			      struct oid_array *list,
> +			      enum object_type type,
> +			      void *data)
> +{
> +	struct backfill_context *ctx = data;
> +
> +	if (type != OBJ_BLOB)
> +		return 0;
> +
> +	for (size_t i = 0; i < list->nr; i++) {
> +		off_t size = 0;
> +		struct object_info info = OBJECT_INFO_INIT;
> +		info.disk_sizep = &size;
> +		if (oid_object_info_extended(ctx->repo,
> +					     &list->oid[i],
> +					     &info,
> +					     OBJECT_INFO_FOR_PREFETCH) ||
> +		    !size)

So this is the object existence test? Is there a reason why we don't use
`repo_has_object_file()`, or its `_with_flags()` variant if we need to
pass `OBJECT_INFO_FOR_PREFETCH`?

> +			oid_array_append(&ctx->current_batch, &list->oid[i]);
> +	}
> +
> +	if (ctx->current_batch.nr >= ctx->batch_size)
> +		download_batch(ctx);
> +
> +	return 0;
> +}
> +
> +static int do_backfill(struct backfill_context *ctx)
> +{
> +	struct rev_info revs;
> +	struct path_walk_info info = PATH_WALK_INFO_INIT;
> +	int ret;
> +
> +	repo_init_revisions(ctx->repo, &revs, "");
> +	handle_revision_arg("HEAD", &revs, 0, 0);
> +
> +	info.blobs = 1;
> +	info.tags = info.commits = info.trees = 0;

Nit: this should be unnecessary as PATH_WALK_INFO_INIT already
initialized those fields for us, right?

> +	info.revs = &revs;
> +	info.path_fn = fill_missing_blobs;
> +	info.path_fn_data = ctx;
> +
> +	ret = walk_objects_by_path(&info);
> +
> +	/* Download the objects that did not fill a batch. */
> +	if (!ret)
> +		download_batch(ctx);
> +
> +	backfill_context_clear(ctx);

Nit: I think it's a bit funny that we're cleaning up the context over
here rather than in the caller.

Patrick
