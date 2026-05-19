Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB063450911
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184263; cv=none; b=BqUKCcqmvTFNxvLhr8wYVU7DNt/QiyrAVzmtEe7uBTKj+M2xMW5O5FAp9+Uuzo2XBzY/9VVtF4aXS7BVjImda1abToXrPgVMorDzRRV7AU96qItY/K4Nl+qekzKlGnBMkPxb0t1AK515hzrgGGSw7pHEGPEO7ZCngBIgPymOtWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184263; c=relaxed/simple;
	bh=cBXr6tHhU7yYPeAOz4sqmwtDcmaAdBD2IVlBMubM+38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kr+x7igQgY20fsoSMq1e1TYlyqLTIXLEq8agqMFAQWuLvdcMYFcnUmvmbXL2P4H2pxApe0qLgTfvFdB1f3hPA8DJh5MeSiW12Ninf01tTBwkfPrC9w0LxOF3B5P2duQEH+7yxomu6Yfjro0ZIy2cbwwo8joNLNHfDUGtP4Mldns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TQ9UZLYg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aCt6FbJc; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TQ9UZLYg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aCt6FbJc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 053347A009C;
	Tue, 19 May 2026 05:51:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 19 May 2026 05:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779184260; x=1779270660; bh=p1Fbkx0lPA
	rU5OoD30MPbNszNtyjzf5fFaYfrNeMeNk=; b=TQ9UZLYgzJSlzD8GBG3bxwWzav
	jwk3kez7rIH0D5eGOuPZAM3CQqJcUWSWIuUGX8PwjWR9jxkWVYunXDpsiiwWpzTr
	gcZnJm1W+yd50qFobeX97BCpb8L0sgJIrBj8ggEH0F2t4v3oGqmFGCuPCAajXNeC
	WcS0t54dhep8iR2FPYl8b2c2JHnAwHKsg8tp6DYEQJ/oOPy8aKaME2JCi5hkrpPH
	PB/L2YYVzotSOFzyp6oC+6p/NzT5243xO2d8jWPW7N5WbmPrqdcO8+Le5tfEE2mS
	PAtCOa2bOVgAvz7bnJfoALL7ue5SQHire8v4IX07G1JgJLNiuo1SLwcmeInw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779184260; x=1779270660; bh=p1Fbkx0lPArU5OoD30MPbNszNtyjzf5fFaY
	frNeMeNk=; b=aCt6FbJcrktL4S0icBxMrAoNmwO974IF5Cny0vRyCC1wN0ZIbhZ
	5FDzJiga0OHK3eF0baM19XR0aKsT5UpWwSDOKWTvjDSDEA40UwoaMg0PXbCxHDgf
	KJePHlglBfoCwE6ZAojf6O0roh55/QPhPjjZ7t6lU5oTAz+AiZU4Z3P6hXFHzYn2
	x1z/ZyyfdaOdEYhb4gmsKhbUq2/DQHKR53fykvpBmBTecK12vS5+CfCJVoJyTB7X
	qMafBDcxmhECR7vrRBLXVTxqndtPQlP6CpW2CgHEnE1iHysn78lF8eP/EAIKXBnV
	yyo2o/sU9QINx0lNvQeVa9X+IWdyW8iv0KA==
X-ME-Sender: <xms:hDIMah4SrE8-mhJTGhkumTNmCr8ThbrmOWQ0LqD9o2BNiEoECPp-1A>
    <xme:hDIMalyRX1cR47_3yfWc5u51MqFT4o4f1yG1UkoM48h8isjor71xT9Gfs6u8unb5C
    WgyiaTmGs2VHX7OfomhzX4OWp7_dxpGL3986wMQNXW6C-bDqLav3Q>
X-ME-Received: <xmr:hDIMagwfLHwyKuyDmr2329gQpkhaSREer3j7epZEGn-Afw7Xrg1G-RQknF_gto_k4fJhdfuXEW4Xl8DT-xE2k4OcLcZNStzdzDBS2dJlryI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopegtrghtsehmrghlohhnrdguvghv
X-ME-Proxy: <xmx:hDIMalwqXw9Vlbc0km_csRyNmPE81EmMcSFpwxud8UNESivPE8TNrg>
    <xmx:hDIMaiZueRVrH38V9uy5PADAJI36_rTtKrsnUicxNea36fP14Sxd-A>
    <xmx:hDIMauVjrsDraXTcJ4GdHFiTIddS-U3kgybVkfwN7xui5xFjCYXzOw>
    <xmx:hDIMaoiOVbuRYvi7B6AqrOMHkhvfTohU1co3cdYEYtoNM1LivHWg0g>
    <xmx:hDIMamGauCgo8_WF_czJb_KM63QiR8MUvuqa08JdFf6_0xNXtFA2UbGp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:50:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 00934001 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:50:58 +0000 (UTC)
Date: Tue, 19 May 2026 11:50:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tian Yuchen <cat@malon.dev>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 02/18] setup: stop using `the_repository` in
 `is_inside_worktree()`
Message-ID: <agwyf8LATRyY0kAq@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
 <20260420-pks-setup-wo-the-repository-v1-2-f4a81c4988e8@pks.im>
 <4d9604e2-036b-485e-aa93-53c35d539bed@malon.dev>
 <xmqqa4txd2p5.fsf@gitster.g>
 <agrD4p1AIPtwa5gW@pks.im>
 <xmqqqzn89os3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzn89os3.fsf@gitster.g>

On Tue, May 19, 2026 at 10:22:20AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> I do not offhand know if other code paths that are called from this
> >> function are thread-safe, but yeah, this use of file-scope static is
> >> not a safe thing to do.
> >
> > In the current status quo this is a safe conversion to do, as we still
> > have the assumption ingrained that this only works for a single repo.
> > We were using static variables before, and we're still using static
> > variables now.
> >
> > That being said, I wouldn't mind dropping the static variable if this is
> > something we'd rather want to get rid of. It's a smell that I'm not
> > particularly happy about myself.
> >
> > I'll send a revised version in a bit, thanks!
> 
> OK.  In the v2 (perhaps v3?) series, I can see the removal of two
> static strbuf based "optimizations" is the only change since the
> previous round (after merging the previous one to the base of the
> new iteration and comparing the result with the new iteration).
> 
> Looking very good.  Shall we mark the topic for 'next' now?

I'll send one final round to address Karthik's comment on the commit
message, but once that's out I think this series is ready. Thanks!

Patrick
