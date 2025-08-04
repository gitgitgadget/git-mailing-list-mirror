Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B72E36F4
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289196; cv=none; b=IbXeADDUcQFMNNfRpJ7v08Fbyrd1Bgi80gSC+bdNU7EfGVUpmFlP2hbVf7838Y/k6UdXiaDzL+5+1ntZ94FGUU3TX31y6jguMLRyH2kBxSatRCbu+R4CVu4iBhjLl/Rr8k95kSDe7zF2we9UQo0IXNnWHmRFCEQLLrLnB+ojKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289196; c=relaxed/simple;
	bh=df1FpzL2d50AA7a4TSNVLZwBmZH4ZXXPZHmqh7JVMAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBnfvX4JGZg4OlMtMc0lmdTvuaiuu+yn2oPDLf6EJFZKN66kuWFk//cWCaU4RRmwKQBYZhohy2wyViVHHNwj+RgXxAu4Sfl6x4i/nhpBlbNnDY8k8zKLz/mprxDTekfaxeNtMr9VfNlFoSqhbXdSftbka6K0m/ltrWier0wpKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OLrGE573; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nY/UZjQo; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OLrGE573";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nY/UZjQo"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D82481D000FB;
	Mon,  4 Aug 2025 02:33:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 04 Aug 2025 02:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754289193; x=1754375593; bh=to83sQqney
	FY8AYl+qPW/cGD1E0JpohVTR8g0ht8/Iw=; b=OLrGE5738FkaM7xWL4vKb6JJuV
	RXOe+I0k1qief1WvSq258QjxzVMl+WZyDcgX+Kv4uO3S0+Po5UDh0ZGITSHMP8TA
	4t+uUeKhVCPrUj/HQLkSxTein5duWpJ91N3yWdPene0wcuRgLqJ5mOMoi6KsZOhx
	CwJnRZ6fxG09vIpUJSor8kbaDMS1tC7Oat55qXsXhmF+5Rc1TH0LlS1C9DPSarvZ
	RG64mvyiACPzB1mLlExyvcb/cf0fDTPx1JI+AfRWulMJUc6U02MYNFtzTBLEy82U
	MswPReod9U9qA8/Hu9Vp5QGT9f4MO1chMps/vKlcbmdf2NgDmK81Kls3Kk1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754289193; x=1754375593; bh=to83sQqneyFY8AYl+qPW/cGD1E0JpohVTR8
	g0ht8/Iw=; b=nY/UZjQokAiiSPksYhNz+Ed/d8m+aawqUb9MmajVzkfyVuVZXSS
	hSzuWuLzJsViTkhmnichKaOVJEVPbgQI1buMhbu7KQH4AdolvbUuA5sqxvtppGXD
	WXwtaTkLzyTCH0+2pYiv+lE4EFrJXmwDPuNWbD9RrY0P4O8tT7KYrTv0l7ft9Lq6
	pn13wjUUQ6COkERdoEeB5bNQLrMcyL9D+h+mXvxCI3IW47N4PpynBxLft0VIGaln
	myMEqk+mF5XEhwmXuM1i4Z1v+zTalIQA2/enTjnWECu5NLSOxc/0cybNkF3hP394
	035Ae+GcHoan0E2KSKvaaHDlq09fYQJJhSw==
X-ME-Sender: <xms:KFSQaIZcH-BvnsbWuomJIs9g8J67JxXs4XmaHabcFXh---WZWwo1mQ>
    <xme:KFSQaA-lRgWr6-OEuXOQqGHFKE5NDpP0cmA7GetsLMXbEogaV-iFYT6SsJ1GxOPSK
    pXoczjfWJUnAJ2qWw>
X-ME-Received: <xmr:KFSQaJYv43Hb1P5R_LIPIczWFfq28w81mdtzClXSilIFWYNfWS5hqWh9quXCYD0wNR6emnUk8glDs8KhhR0eRU1Y8SVX4xp5oz264GIi9eI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:KFSQaEPbeNRoK-2h4l83npR-yIfkygIwt4mycafad31kTxvIP6-y2g>
    <xmx:KFSQaFDthJoWNzVMtQX0yoJKuwOZvUNva1YyFCmbUCUZZYsXfaCcCQ>
    <xmx:KFSQaLJGadGwGESoF1RQ_MTz0pr8BY3zH6J8B9fr6qKoRbvkydnIQg>
    <xmx:KFSQaOMA2NXQHve__snhdnEBPehj04Y1aDGDAR6sie7UenIIUOaPmw>
    <xmx:KVSQaAvg5hFDDerZuUDbIfEJYINVzRoW40v6QAawoal9KoONF8FrmJpf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 02:33:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 500b077c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 06:33:09 +0000 (UTC)
Date: Mon, 4 Aug 2025 08:33:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 4/4] last-modified: use Bloom filters when available
Message-ID: <aJBUIrPDx8Ds-8ni@pks.im>
References: <20250716133206.1787549-1-toon@iotcl.com>
 <20250730175510.987383-5-toon@iotcl.com>
 <aIsQfZyMq0ltbMtz@pks.im>
 <87ldo3ui37.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldo3ui37.fsf@iotcl.com>

On Fri, Aug 01, 2025 at 06:23:08PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Wed, Jul 30, 2025 at 07:55:10PM +0200, Toon Claes wrote:
> >> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> >> index e4c73464c7..19bf25f8a5 100644
> >> --- a/builtin/last-modified.c
> >> +++ b/builtin/last-modified.c
> >> @@ -179,6 +192,27 @@ static void last_modified_diff(struct diff_queue_struct *q,
> >>  	}
> >>  }
> >>  
> >> +static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
> >> +{
> >> +	struct bloom_filter *filter;
> >> +	struct last_modified_entry *ent;
> >> +	struct hashmap_iter iter;
> >> +
> >> +	if (!lm->rev.bloom_filter_settings)
> >> +		return 1;
> >> +
> >> +	filter = get_bloom_filter(lm->rev.repo, origin);
> >> +	if (!filter)
> >> +		return 1;
> >> +
> >> +	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
> >> +		if (bloom_filter_contains(filter, &ent->key,
> >> +					  lm->rev.bloom_filter_settings))
> >> +			return 1;
> >> +	}
> >> +	return 0;
> >> +}
> >
> > This function is basically the same as `maybe_changed_paths()` in
> > "blame.c", but that isn't a huge issue from my point of view. What makes
> > me wonder though is why we have an additional check over there for
> > whether or not the commit has a valid generation number.
> 
> I've been asking me the same question. And I couldn't find a good reason
> (neither from the commit history, or from my reasoning). This check was
> in the version shared by Taylor, but because we were ignoring the return
> value from generation_numbers_enabled() in that version, it didn't make
> sense to me to do this check. That's why I removed it.

Okay. It might make sense to point this out in the commit message.

> >> @@ -227,6 +264,9 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
> >>  		return argc;
> >>  	}
> >>  
> >> +	prepare_commit_graph(lm->rev.repo);
> >> +	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
> >> +
> >
> > So this here is why we export `prepare_commit_graph()`. How about we
> > instead expose `bloom_filters_enabled()` that mirrors what we do in
> > `generation_numbers_enabled()` and `corrected_commit_dates_enabled()`?
> > That would both be on a higher level and do exactly what we want to
> > achieve.
> 
> I've got another proposal, what if we let get_bloom_filter_settings()
> call prepare_commit_graph()? Functions like
> repo_find_commit_pos_in_graph() and lookup_commit_in_graph() do this
> too. 

Yeah, I don't see any issue with that, either.

Patrick
