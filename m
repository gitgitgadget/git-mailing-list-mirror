Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39447347530
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527699; cv=none; b=pGDJ3FRA7YtySEtwsjHiToH8TdWRMsUEmJq6RqrZCjLEc5hrozIj0iF3Erf2VjLg6pVS3IStOBQY72k6SxWfoe7eNryOBIsW4v8IOvG34FaHW+3+aSQOZK7C/bQMngUzWnstdEpg6+s9Rc267/wTMKB5ExB2F8U9jpJLZJNsvXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527699; c=relaxed/simple;
	bh=VNAyFDm6CVZV9FkzY8eO59i556UKCFvotLeUxDEmW10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEBtNiEETlHNoq+rUMZbp2mAhdws4IoQ0wSHzNC1PV2QPxUexsgYCX+r2NCI4isc6mgU0pWU/IKgAOrNFfnJ/a7jyzLqZv922yvzkaSGcp4alw0qR6XX5TYGqaQA+kkjqvHGI0/KDZlDMmtOrPTYqRQV85QNpNziXB0UwUj7/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KVbjm7Ov; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qUnDaqEn; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KVbjm7Ov";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qUnDaqEn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B3CE1D001EA;
	Thu, 26 Mar 2026 08:21:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 08:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774527697; x=1774614097; bh=nNs5pQw0c0
	pzLE9kP36pOVyUBhDimxls5eWLh7kKlpU=; b=KVbjm7OvBHQ7/oENshVavKSGee
	4W1OMXtW0VhRWj9s1FkhTP693CNzJQar6Q7QjZ4wjdfw1MrcagpDOw7Xo3u+W6O3
	6/Io139BICVErxeGXVuRYjiVR4nY5A557NUgSS3RoOmwV+/F5WEPXIZrvWxlea1Z
	w6FRncurJ0PqpsbK8MnBIeIGb9yfGkHIluU/Po/7J2CRsoFJqJyLqZCggZW1liXn
	DZwKV0MxxeZGM34mlHOBQRfaT//GqOI9viCTCychNVRVsR+uyTQ6p+j+hpOgdRhG
	lm4zCfsrCgTRw3pDKSB/2fN30y4aCox+Op2oO7zdBHyMGiw7jciYb36dPqlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774527697; x=1774614097; bh=nNs5pQw0c0pzLE9kP36pOVyUBhDimxls5eW
	Lh7kKlpU=; b=qUnDaqEni60g4sjcjdw5zwvpnIzVVAZ21LKFGlYII2YiBy5kYn5
	v0NJebWzTaJ3lN8isSIot3QHUrr3DBUTjox6vfYUpTdNaNXaVbNvr3iRjNRelkuT
	AyM1+2r3k6/77vgeKwT/NIIN2nQu+s/0w4zLvnd7xnvEf4fBfneueWPXiqLrd2hP
	zpp+4LSyf6nYAjVP7gKReC5StqK4CpJjJppvU82mjXF9ucp7xK6jWT+fgJqkcL3z
	q2awVngufIc+DlZEYPoYfFSUt4gKW3h/J6KLmNSv6eamwohWJI46HKnLK/0EGA0T
	go5Q2r8dlJIITVDkN6hnu9bB9RdkRRxdPWg==
X-ME-Sender: <xms:0STFaUo9OwC2E4IM_VS3Qi2hpVRinllDisDL1fm2e-bgniTJICnLBg>
    <xme:0STFac6YT_33yMfJDjZplbjv5cSWqM9I_vP57xbCLcweWcRV_h85dhDlEHHEqml6R
    xfHCVIZG9L8p5XW9K_8VNRh51u-P5ZHdJXfd0DDEh2pNVAGoC1C>
X-ME-Received: <xmr:0STFabf_WMs35LIu6v7JcwKf-ZEBuIczQUGDDJFhQ_ElXmPAy4Try3t3UUNQcMM1yEF8Qm7eSf6HcddAaM6rv9srTLJgwktncV9vKZE8wHSxhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehnvg
    ifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishht
    ihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0STFaR65BojKlKhlF30jBq1SWLnzIJYjBXqZXZ0pDprMi_4CtJ54tg>
    <xmx:0STFaSuaiuiwIjeokshTNauKLBVw18pL3_cZ9GCqvdrg4Ym09JmbuA>
    <xmx:0STFaRimd0UKt1vGSOK2HXTa--FDeMVnc7zTIHpbT1ysZ09Q79YDlA>
    <xmx:0STFadqjJXVHHYGoco5DR0Nr5hGKDEvnxqKht1cYzTxPHeaPG5zW2w>
    <xmx:0STFaZrwo07X78sl2rBasvScSTey1CBkQuQ3aFnfdJe-KhdQzZPfk31v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 08:21:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a028fd99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 12:21:35 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:21:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 13/16] promisor-remote: introduce
 promisor.acceptFromServerUrl
Message-ID: <acUkzY7f5302uWD8@pks.im>
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-14-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323080520.887550-14-christian.couder@gmail.com>

On Mon, Mar 23, 2026 at 09:05:16AM +0100, Christian Couder wrote:
> diff --git a/promisor-remote.c b/promisor-remote.c
> index c2f0eb7223..4cb18e1a6a 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
[snip]
> +static struct string_list *accept_from_server_url(struct repository *repo)
> +{
> +	static struct string_list accept_urls = STRING_LIST_INIT_DUP;
> +	static int initialized;
> +	const struct string_list *config_urls;
> +
> +	if (initialized)
> +		return &accept_urls;
> +
> +	initialized = 1;
> +
> +	if (!repo_config_get_string_multi(repo, "promisor.acceptfromserverurl", &config_urls)) {
> +		struct string_list_item *item;
> +
> +		for_each_string_list_item(item, config_urls) {
> +			struct allowed_url *allowed = valid_accept_url(item->string);
> +			if (allowed) {
> +				struct string_list_item *new;
> +				new = string_list_append(&accept_urls, item->string);
> +				new->util = allowed;
> +			}
> +		}
> +	}
> +
> +	return &accept_urls;
> +}

I'm still not much of a fan of us getting more and more function-local
static variables. It just feels wrong to me, and like we're accruing
technical debt. I also doubt that the performance overhead of storing
this on the stack with proper lifecycle management will matter at all
given that we're in a context where we talk with a remote anyway. The
handful of allocations really shouldn't matter in that context.

Patrick
