Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03978285C98
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753944201; cv=none; b=l6A41dmy8jWjwufwS1g+bgFi/t5BihYs9zZtGwiMXYmfDT+huQtL0fs1qsKFDCxs8xhixcBaK3q7YRTcVBcj8aleZ1vIcbutSuPDn9L6iWT0fQKQwVZ10bSjsQLzbAewjvu64iGM3ChDhqAgxQ4iBLYcJIHVQnf70BDU8aywk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753944201; c=relaxed/simple;
	bh=AuQTl0zxlgmDgdjvyO60mY4GxMjiyAfubsiimSjLtQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGy4IkEiuJQKxfJFUYRbehccjTXto/guIlAhXlfvy/XhcQU8zQeOf+CGh5bOBSMdk61PV18OAiY1iafshjW6wJN0NksJIsSCN3NrDJ8/1C2kxGuFXL6MNSDSeNfg16v3cTIc7lxgJQODdp+HuFpcrBN5YDwRxc3/jpfE0cYsK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xb4RJeBC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H9+Tonn1; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xb4RJeBC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H9+Tonn1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1C00A1D0086D;
	Thu, 31 Jul 2025 02:43:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 31 Jul 2025 02:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753944194; x=1754030594; bh=KD/zMWkrj0
	eIPosXqm9HLhfRM2ytdmpwRus0ITVn438=; b=Xb4RJeBCPZ8xHhqfQHytxBfSms
	YmWqjfJjzvnuIsoLXMOUCUBn2cUBq8pwVvj7Dqcfz1tmezyi3JLaUSpUE0X/Yp3j
	teC/E6WKI5Qp9dG+CuYeUqKtZs+yKjvXxF8ax57T8hcXm1Yqx8otY56TwtBHBRF3
	N8raF6rfLYvbkfTrONadsgmp7Q14oWlDGJXoLckJRieHHuDwb9vKA1gS2Z9rBYIR
	XVEq11KJwVo6sZPf2lw2a9xPrxZsb8EXviBVEUgpkZ3MrYuEslMzIctVkaZNHDJR
	RQZO2aC6D81R59ZnbdMci7ax5L/ccvXm3TC3b6pckABEWx/5Me3K9X5CKcSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753944194; x=1754030594; bh=KD/zMWkrj0eIPosXqm9HLhfRM2ytdmpwRus
	0ITVn438=; b=H9+Tonn1QlUn+GjtjjacVHA4VU7UY9tN2YRkNbHiSV2uNlM4CP1
	IbYuWASJ8X1gb738RhK14Dcqsk189L7jXA9/7sk2YBz5rQSu41mwY236Nm5hEhoQ
	5A6CWfrkEA6uiakqtj4GlTiqytCwRWsJ62CBUCj3Ign5t2MSF5NaqhW5nW7uApM6
	FHVm3udZ2hwKyVPm5wcfaO63EThSAB8G2Z8YpelyUFVogR1RWIKjkK0Pd0iwdoRT
	OLHdVYyBh493batl8wXsig2z6/dN0tiUm59rXy8uqBDZSm1aUFmgnfa4aaENvpMM
	0pnv/koS4JEkaFWOidNuhAq+EjzLkC6OJ9Q==
X-ME-Sender: <xms:ghCLaGCALFrKPts4w9GrixoAyFTGZk33uC2HR_KuUep0vIxACqg9CQ>
    <xme:ghCLaOHEDOSUn2I3z7RXCq-ldJSu39lKiBUsmzVc_3rxJd6iAGjjLrGeWf9sV82L3
    9GfLAdyGHFDr6mh9Q>
X-ME-Received: <xmr:ghCLaABobb7QvHDuVps1F9Ne3dc8U4bc2jjcIdtN1eaE34mBPibHM4pIlWzgO_f5Bw6LHz3vSfLXo2aH_d7Wrz3iz0Vfds-rF8kpLCIz-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ghCLaGUcuoeINA_1Z7Vai0CtQQ7zNgerOwEibfBPuKjBlCMTIXgUUw>
    <xmx:ghCLaMo0KhXZFNM8IqeojWO0foadbz7oOhMquf3DDj50Yy2GBbe4yQ>
    <xmx:ghCLaKRReDjUjg5L4RiCbT9aVQ68NWNhynPtQgJnNT53L2yrjgkOXA>
    <xmx:ghCLaO0VLS79PNjyuKxITh71qSlxOSmjpXIFgUOryotjywa_x4O2-g>
    <xmx:ghCLaB0sF3Va9h5mKbt039-8yvLPsSB9e_pUQXS-wnvxEIh9IPkYwFyA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 02:43:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ddb8ef5f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 06:43:12 +0000 (UTC)
Date: Thu, 31 Jul 2025 08:43:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 4/4] last-modified: use Bloom filters when available
Message-ID: <aIsQfZyMq0ltbMtz@pks.im>
References: <20250716133206.1787549-1-toon@iotcl.com>
 <20250730175510.987383-5-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730175510.987383-5-toon@iotcl.com>

On Wed, Jul 30, 2025 at 07:55:10PM +0200, Toon Claes wrote:
> Our 'git last-modified' performs a revision walk, and computes a diff at
> each point in the walk to figure out whether a given revision changed
> any of the paths it considers interesting.
> 
> When changed-path Bloom filters are available, we can avoid computing
> many such diffs. Before computing a diff, we first check if any of the
> remaining paths of interest were possibly changed at a given commit by
> consulting its Bloom filter. If any of them are, we are resigned to
> compute the diff.
> 
> If none of those queries returned "maybe", we know that the given commit
> doesn't contain any changed paths which are interesting to us. So, we
> can avoid computing it in this case.
> 
> Comparing the perf test results on git.git:
> 
>     Test                                        HEAD~             HEAD
>     ------------------------------------------------------------------------------------
>     8020.1: top-level last-modified             4.49(4.34+0.11)   2.22(2.05+0.09) -50.6%
>     8020.2: top-level recursive last-modified   5.64(5.45+0.11)   5.62(5.30+0.11) -0.4%
>     8020.3: subdir last-modified                0.11(0.06+0.04)   0.07(0.03+0.04) -36.4%

Nice results.

> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index e4c73464c7..19bf25f8a5 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -179,6 +192,27 @@ static void last_modified_diff(struct diff_queue_struct *q,
>  	}
>  }
>  
> +static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
> +{
> +	struct bloom_filter *filter;
> +	struct last_modified_entry *ent;
> +	struct hashmap_iter iter;
> +
> +	if (!lm->rev.bloom_filter_settings)
> +		return 1;
> +
> +	filter = get_bloom_filter(lm->rev.repo, origin);
> +	if (!filter)
> +		return 1;
> +
> +	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
> +		if (bloom_filter_contains(filter, &ent->key,
> +					  lm->rev.bloom_filter_settings))
> +			return 1;
> +	}
> +	return 0;
> +}

This function is basically the same as `maybe_changed_paths()` in
"blame.c", but that isn't a huge issue from my point of view. What makes
me wonder though is why we have an additional check over there for
whether or not the commit has a valid generation number.

> @@ -227,6 +264,9 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
>  		return argc;
>  	}
>  
> +	prepare_commit_graph(lm->rev.repo);
> +	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
> +

So this here is why we export `prepare_commit_graph()`. How about we
instead expose `bloom_filters_enabled()` that mirrors what we do in
`generation_numbers_enabled()` and `corrected_commit_dates_enabled()`?
That would both be on a higher level and do exactly what we want to
achieve.

Patrick
