Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263A40756C
	for <git@vger.kernel.org>; Tue, 12 May 2026 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565576; cv=none; b=WYaIyA6vyyyWEom+LdF79WOubV1TidmLUaqfm6mebQHwos1MSUH6iGLsmVZhS+1sUJAABJ7rK3BRjbQkmldvNIhj4mzdQYyPsO/TxZojOaJvM2x0PuizoUqxMIcEXm+Mf+RzyE8DWXBk3M+WW7QPN4IYlyAvldJZuEX7qVbv9+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565576; c=relaxed/simple;
	bh=xomLBbiBfOzDNI9vNNO+7r+1w+4EplnOGuuFW4NDfYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXcVgKj+ySjecBxd0VUankEHa85HFCOi8wrDalC5S6HLHOCzvs3S7L1y5+rBaTLYF1E3pW5GJ2wyiiieyFpzvplRT203CNmlqTmIEHfO9EgzUkNRI9dFQJiDGTMyVvyseDUvBnNl9d9VpCfnNCs5p9Ed8H0l1fIloIaluYM9Vag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Luhtdgms; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ohaVEhly; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Luhtdgms";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ohaVEhly"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C4CDD7A0064;
	Tue, 12 May 2026 01:59:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 12 May 2026 01:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778565558; x=1778651958; bh=oErxQA/Ow6
	QdPQl2vVQ5cvOO5liHFv4mF6n7K34Eq1k=; b=LuhtdgmseRbY63sPDgwqRoSbxk
	ta7GlS7jUXJv4HOkNCxctosYaNroZqVH+kh3GUlNoNTpHIoXiGSwzMYKa72SlH5y
	G9Zzx1lrPnVvq8vNzjr5AtYoCXxo3c7+k2+r4xwW8Fn3u5CbsAg8pXkzxupmKrkz
	an6UY1BQ3HiUOKmreehRhxYqfLTBMjUNAtvDLdNLZXpEVDANZufoaYxuMSQTsnXL
	3TcFribbk/Oo91EYUGFcGQN0ffLk7fdQeXUqvVL+817pBAIarTlm0cIhZ3Vo4KC3
	Qw7+sjGBPc2QMSfKbkMl+Iy/t/hCbgRCLjPCSgN6FU+ciXgwis5kevXB6cNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778565558; x=1778651958; bh=oErxQA/Ow6QdPQl2vVQ5cvOO5liHFv4mF6n
	7K34Eq1k=; b=ohaVEhlytxIx60lCaL5p61BTv2RcVCcR6gctcO4ToVkgoR8BpxS
	sc+oi7Kare0NLndaJGA6/1ahqaFtU6us7sZORvN5P1zIoBJwX6kdFAYKBgMcmT64
	q63r0Oy4RSUkPz4IdqWKLLOwr9iymbxade8PeSO+eLVM3ALsCmQpML9CsPrkoSKQ
	g8dxQtIOhFvEBv70Txb0m2dQFjVNgfL9F6n3daThuHpaDK/s7mezChDqbPo3MJnN
	+LGQKe8nJbMA9A8AoefCbmRaK5AxKcmiTe5gvsebW847ts1qPHo9QHHyW552VbaJ
	70vpfCfUo5v6lYspKQmXp9wqElO5ChPKarg==
X-ME-Sender: <xms:tsECakDcFetbSH1Au9aDtkwEZwqOQcqfp8BXpd7hkSw33PqOiODjFg>
    <xme:tsECaoxL_kWeatEyzjsdZVCywdCwodew9A-kIyqHDjx2WGGjw9yXwACZXwxJX5jR8
    57f8SAoNNEaBSP1hCxboESvWNmtMgtI-39HTM0CiI_o31rsHvUe>
X-ME-Received: <xmr:tsECap3OeT0BPGHP4LDzuiSRicau6xXK2ePgC7bGbvL0I7mQm1OJ2KvyNy04EmzvvDmZ_Qka8vjC2DSgnaot-EWWoOybrafR7AJS-RbQZys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddutdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmihhkrggthhhuse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggtthhioh
    hnmhihshhtihhquhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:tsECagx16cn1X_TOK6ar95KQYTvSvRvfMSWAB_KClrgUNtmVnkTAPw>
    <xmx:tsECaoFyVE4-8_6H2_6rqtvneWP4JOgEz9x1uSMsUbC3gTsrs6bbpQ>
    <xmx:tsECarYGDvi8-gDWemtyFMrxm4drj_hMSdnCAJAM8zAIg2hk0kvcUQ>
    <xmx:tsECaiC7oq8HCjz7H7Cx4DKr_fE_6IWlMNjTUa1-AQWn0Uq6g-p5Fg>
    <xmx:tsECapyhcX5TuYmTfYT6X4FburazhP9PvLHk8omKk2nj2_FeygdWpYxr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 01:59:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c3486048 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 May 2026 05:59:15 +0000 (UTC)
Date: Tue, 12 May 2026 07:59:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jean-Christophe Manciot <actionmystique@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] run-command: honor "gc.auto" for auto-maintenance
Message-ID: <agLBsD3y6x2ehO7G@pks.im>
References: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
 <20260511-pks-maintenance-fix-lock-with-detach-v1-2-ccd7d62c9a40@pks.im>
 <20260511201800.GC22912@coredump.intra.peff.net>
 <xmqqzf25pgm0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf25pgm0.fsf@gitster.g>

On Tue, May 12, 2026 at 10:21:43AM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Mon, May 11, 2026 at 02:29:56PM +0200, Patrick Steinhardt wrote:
> >
> >> @@ -1946,8 +1946,10 @@ int prepare_auto_maintenance(struct repository *r, int quiet,
> >>  {
> >>  	int enabled, auto_detach;
> >>  
> >> -	if (!repo_config_get_bool(r, "maintenance.auto", &enabled) &&
> >> -	    !enabled)
> >> +	if (repo_config_get_bool(r, "maintenance.auto", &enabled) &&
> >> +	    repo_config_get_bool(r, "gc.auto", &enabled))
> >> +		enabled = 1;
> >> +	if (!enabled)
> >>  		return 0;
> >
> > gc.auto isn't a bool; it's the count of loose objects after which to run
> > maintenance. So "0" works in both contexts, but will we complain if
> > gc.auto is set to 100? I think maybe not, because we fall back to
> > git_parse_int(), but it feels kind of fragile.
> >
> > The gc code uses repo_config_get_int() here.
> >
> > -Peff
> 
> Very good point.  I was about to send the same message ;-)

Ugh, true indeed. Will fix, thanks!

Patrick
