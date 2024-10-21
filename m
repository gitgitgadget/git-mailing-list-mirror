Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931381E130D
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500311; cv=none; b=QoRBJcBbsJdtBKDKkrfMuJyFPn/ZtAgpVgDEtCC54vZZa4yy08TNz9j1EUbmHbMirYcsw8K6Pz+ne7u8fuikyZlxZlTKj4Ilq1ePRGPEULc7oviFV3Te5FF/YdmHVY3Hihi4Enk7S2tTT4+fv2G2CJ4syZ2J6VHJdNebUzGW4KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500311; c=relaxed/simple;
	bh=qV0eQEfym+ndtdbVGjuT8VVyJgoOxpDSRrNzkY4J6r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBZhQC9LgAq5BzfcDSE1WxDA/yLb1C4vsNZDPQ5TuBgWVZENDs30PfLVjUiy3VG99iHTMah8QNABMHfbpIVOIMt0w7z8Ikr1DN3etCAk0OkYCEsuvV2YbDqAHTWCXPfxFKawPi2VYbaSsH9DdDovd7CxtqeoXYag54/+X3G/aAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DgWsyaWw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GafA4QP8; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DgWsyaWw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GafA4QP8"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B225C1140187;
	Mon, 21 Oct 2024 04:45:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Oct 2024 04:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729500308; x=1729586708; bh=R1Szpm3ul7
	5JTgTIWuCF7lEcYlHBhw/UgIOF3Cs2BbU=; b=DgWsyaWwEJUgpNmbsWqBWTDj0k
	IaRIacM1l/4sWLQ1mmp6V5to8DeB9JkvbNiTQIW4ksWUJeJNYVyLi52sjpC6k4iX
	zEv+G9MATxdwOz5UA+gTn8HBjQil6xKzt7j9Wz0vsvboUicCk0SRlCDIzFoQyyjB
	F/7YbNz0/fRw0/VGS98V34gSoDoc7bFl7s6lJgw+K20e2eSv30pJFR20INyrk60M
	BRAGPJxaIm12w+N5aA3McGHsQY6IWLxruPQYqAv5Xac/pTutHjxTf75O5ockiHxG
	yGpnm9ayZDAfVXyfpDERVewZNEH1XK5vcibq8CFoJKHuK0rVD1cyCsU+wFLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729500308; x=1729586708; bh=R1Szpm3ul75JTgTIWuCF7lEcYlHB
	hw/UgIOF3Cs2BbU=; b=GafA4QP88N5vTtrp+sTrIKwT5LZgpWLVbeS7/opFODwX
	Q/P6XSSePjlYNURH64yIPioeVKUymV2H6Q/QrcA3lQI2fMCrvoz84FuSvbC0Gk9h
	cw1x5wr+4Z6vg7qEWRjkeXVj3VxONnq7kNjSK6FHUKu9Esau2GI02peBkjja6thk
	wcrmcQcXtAQs7lGn4RuZCP0h4UWX/+DjnnFmtVO3HXWHXgPDpBGOJqg+RIEUK1mM
	UCntpq1GMgeDsJX/hXXvEneHI3kqWwN5DlA7Pk0/465LzS3W9ybL9KnguDJACPyV
	vDpHqHJb4hHMIpOiNk9WeijZ02bI4mtJRgjpP01j0A==
X-ME-Sender: <xms:lBQWZ7lJmImgsVV2K55bkOa4Jl783KdNwsWQX8A0OJbULYvVinyHaA>
    <xme:lBQWZ-21lRQaZhyoh3l6mJVRjqeSRlfyFpyBJ5JjUgo2aK6tf7FL5SKCbm7qNOHzH
    LMhBKETXpg6TiD68g>
X-ME-Received: <xmr:lBQWZxq8DXntR6cqw7up4jZGGXtX7vp3mtRbl35W_1oeIZbgf4CjUcXxPLtjf2VLKhG8RzaUnlPfkA9fhj8F7Gd8zfEnVINM8T6n6DDgoCWr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lBQWZznfsxp9jeMw-ln7Gf74NL2699eNjP05pw8C8eFQgvm8P0fezw>
    <xmx:lBQWZ50F82tAHeLQDViYVqrs5AClojaheU13vc2e4B98FTIKjHboxQ>
    <xmx:lBQWZysOJyEKHys7nkYInPqOJKKcP9MyLf-BC9zal574HPaLYsyDVA>
    <xmx:lBQWZ9U7nQA7SJYd6Nq84AoFjzqqXyzgAsxcir42fFPEHoxCZNipZw>
    <xmx:lBQWZ3BJTOpGfSqME3bW0lrHuIqTZUS51bP0X6JR_qvB3vrGWrhuW-8a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 04:45:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ca12d0df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 08:43:40 +0000 (UTC)
Date: Mon, 21 Oct 2024 10:45:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 21/21] list-objects-filter-options: work around reported
 leak on error
Message-ID: <ZxYUkKAm0iBT8f5L@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <6a2baf0d3e538e5f450c45c22248fbc3fefd77af.1728624670.git.ps@pks.im>
 <875xppd3ct.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xppd3ct.fsf@iotcl.com>

On Fri, Oct 18, 2024 at 02:04:18PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> > index 00611107d20..fa72e81e4ad 100644
> > --- a/list-objects-filter-options.c
> > +++ b/list-objects-filter-options.c
> > @@ -252,16 +252,14 @@ void parse_list_objects_filter(
> >  	const char *arg)
> >  {
> >  	struct strbuf errbuf = STRBUF_INIT;
> > -	int parse_error;
> >  
> >  	if (!filter_options->filter_spec.buf)
> >  		BUG("filter_options not properly initialized");
> >  
> >  	if (!filter_options->choice) {
> > +		if (gently_parse_list_objects_filter(filter_options, arg, &errbuf))
> > +			die("%s", errbuf.buf);
> >  		strbuf_addstr(&filter_options->filter_spec, arg);
> > -
> > -		parse_error = gently_parse_list_objects_filter(
> > -			filter_options, arg, &errbuf);
> >  	} else {
> >  		struct list_objects_filter_options *sub;
> >  
> > @@ -271,18 +269,17 @@ void parse_list_objects_filter(
> >  		 */
> >  		transform_to_combine_type(filter_options);
> >  
> > -		strbuf_addch(&filter_options->filter_spec, '+');
> > -		filter_spec_append_urlencode(filter_options, arg);
> >  		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
> >  			      filter_options->sub_alloc);
> >  		sub = &filter_options->sub[filter_options->sub_nr - 1];
> >  
> >  		list_objects_filter_init(sub);
> > -		parse_error = gently_parse_list_objects_filter(sub, arg,
> > -							       &errbuf);
> > +		if (gently_parse_list_objects_filter(sub, arg, &errbuf))
> > +			die("%s", errbuf.buf);
> 
> Do we actually have a test hitting this code path? I wanted to figure
> out why `filter_options->sub` wasn't leaky (I assume that's what you're
> talking about in your commit message), but I wasn't able to reproduce a
> scenario where we should die here.

You only refer to the second hunk, right? I couldn't find any code paths
hitting this, so this is more of a "Let's massage this code in the same
way" change. I don't want the next person to go through the same rabbit
hole as I had to go through :)

Patrick
