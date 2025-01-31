Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3051392
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 04:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738298934; cv=none; b=PQBULAktq6etUU67O2xmV1DEYEZfwU/rtcwN0UojXYSNmbK2H8E0wYaHDiO1xzgoTQ4tSGFJRgom0LEH8f8PsKifD/rQ9Y6ft2rE2YVjF4EyU0GpTPLl1jIxkXTzpUc18zRFLVY4fqstKb9fJs6yScW5yY3Ed4O7KrjZeTYz6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738298934; c=relaxed/simple;
	bh=tAOnASC/N5rYLO10E89TvNfBojl4QGqeLCe1upWfaXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTrwzZjK7wuMZ9TjrA9L/XXI7KL5YHDGwyQni/VToLaTxn/TwnSk1teYMog/6JMgoCrazDh64uK5ryUkcaZNwxz002qtHhRdPstaXcxIJAgJ8Jyl+l89exWrgTZ3LJmBber7ZEtDsCTk9y6jPTmJE8aNMCuUJibIuaNR2gnxV8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZtkwLDuN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wMEuPT52; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZtkwLDuN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wMEuPT52"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5A9961140100;
	Thu, 30 Jan 2025 23:48:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 30 Jan 2025 23:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738298930; x=1738385330; bh=AVFutWkAqL
	Rf9OyOgB6+5WIZMN4vSc0NoClm07/tBiI=; b=ZtkwLDuNI2sklnd6e1fJ9nHXD6
	5Y5lGu8u/y481M3oNaMPzg4z/dw/N12yIFWTyej5lYZ8PX/g/j5h6JrgDnEcEfRN
	zccUGT0mymHpHB0xG1WKBAD1WvxtAeJv8yYgqJVnkfvcYmR/0N+8EvJzLGe8ONdN
	IEV4sD4q8QbWsUX4SU2QFDUdk70iS+i/DxHNpaM5p+iw5BJbXhiKZ/qj6R1+vW99
	vMxQwf04UzvkQ97I0JVzJf4Cn8pX5ZYaCs1H37a4rnLYX/1sgB3AeWb4jBU2fuGV
	Z74hgqRayAB+yH75c9mwsErZd5agc5prY0gMTAr8gLTHXX92EO805Rr0dXwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738298930; x=1738385330; bh=AVFutWkAqLRf9OyOgB6+5WIZMN4vSc0NoCl
	m07/tBiI=; b=wMEuPT52uxofVzGK1Y8gXwqlP4F1W2Go9zJgROiVlpfjIRGiRSE
	kfyMn7UtMgqovCukNcuaFcTBDgGknOfuqgSItTCCE9gFEdwEPBSNODbljNSGy48m
	w6tQ+vmzutM3bDwPRn2Cfw8c5hkBeUKB7FEIgbBy+PYWdL3vVkeChIeYdQ2hx3ws
	c5kN2xIcEy8BqMSPTUaTkdhjLkf4EQv+gurkJsC36dP0LA7Yvohx9UHEt7hmciJs
	maqAUJ9Ts+6L6j7BBrnHvpJo/dDszvB5E7pjUZJPAicq4sdZYTRprz7BTTTof/V6
	pCuLLAhYRV5rWXlkEFxnae1PLKh+SoKwxXQ==
X-ME-Sender: <xms:MlacZ5VPxuQdAPUeVYv-NDyZEAj-WaRMd4UeXmUOZAZM0uduDI0eDA>
    <xme:MlacZ5ncQW82fizaxCKdkrN4HcF6hPOHoe9LLbcmCSeitw3fJyJHc6_pikNk617BT
    MQHm2eJ9y7Wm_70Vg>
X-ME-Received: <xmr:MlacZ1a7qI2usx5dY6M0RmvMsd7DDSOozVcAhNNIhWbwHUVYIVQVkk1EXG4OdVEfjRGI3dMwIlJzYFrimI8NCY6jjpVZPd-YH9U3N_LY8YeIwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MlacZ8VzUnVQ773iMQbdAm2Q5G1yWDHpqLCY5IE3BT_65ejQI1-vFg>
    <xmx:MlacZzkN_tMtTF_-i3R8_ZLPB4TdRnekDjqXPMzcUtK2Tnul_h2o9g>
    <xmx:MlacZ5dzf6KcZzPQCbMpk1fxWp2wcZLoCs732g6lXdnaldaVx9ZBew>
    <xmx:MlacZ9Fy76U-dlthH-CQrMdJMMtMA0GXdOo3xn03jxvRkThwaaDiAQ>
    <xmx:MlacZ8AqVNj-HHLJS6PbLBC3F9iX5pVBN9L_MvOWrNpfdLxbGF_0lbxD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 23:48:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 95b74e02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 04:48:46 +0000 (UTC)
Date: Fri, 31 Jan 2025 05:48:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
Message-ID: <Z5xWLVFZhjUwcN16@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
 <Z44u7od-mDiKcKVZ@pks.im>
 <xmqqr04vzyz9.fsf@gitster.g>
 <b784f612-4b6b-414a-9742-86611c50c55f@gmail.com>
 <Z5srHBSPKQlsuH53@pks.im>
 <xmqqjzaccdpn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzaccdpn.fsf@gitster.g>

On Thu, Jan 30, 2025 at 11:18:44AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >     It is the responsibility of the owner of the topic to determine
> >     whether it is still accurate. This check should happen close to the
> >     noted best-before date and come in the form of a patch that either
> >     bumps the date in case it _is_ accurate, or alternatively removes
> >     the topic from the list in case it is _not_ accurate anymore.
> >
> >     In case the topic owner does not send such a patch, contributors
> >     other than the owner are encouraged to send a patch that removes the
> >     topic, putting the owner into Cc.
> >
> > Well... maybe it _is_ an expiration date. I dunno, I don't mind which
> > exact term we use for it.
> 
> I do not mind either word, either, but I have two small issues to
> raise:
> 
>  - Is each topic "owned" by some specific person?  Would an owner
>    retires from the project, would the leftover bits go away with
>    the owner?

Good point. "Owner" to me rather indicates who is the primary contact
for a specific topic. It doesn't mean that nobody else is allowed to
contribute to it, and neither does it say that the person has any kind
of authority over it. So if that person doesn't care about the topic
anymore due to whatever reason it's also fair to change the primary
contact to somebody else.

>  - "relevant" may be a more appropriate adjective than "accurate".
>    An item in the list may still accurately expresses somebody's
>    wish, but because a better alternative has been implemented in
>    the meantime, the feature-wish may no longer relevant.

Agreed.

> >>   - Fix Sign Comparison Warnings in Git's Codebase
> 
> This one I am not sure if it is even something we want more of; a
> careless "-Wsign-compare" squelching often makes the resulting code
> worse.

That's a fair remark indeed. We could add it, but add a warning that
these refactorings are non-trivial?

Patrick
