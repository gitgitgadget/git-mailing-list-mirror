Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206DA38C2BF
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663022; cv=none; b=Y8ty9PJMB55sFP9Rj57X4P3D0H9TCNRTg19l89MdAHLvhXe8uEP2HRdDoCGl+8HQeZJS+Jk7aqCyi47w5IP4ofbNrGzYw1Yyiq/dKMrHHGjomMGaHYMYa5Ix4XFywkiThuXeeUds/6e8Axmh4h+3vEIqfM0xWoZ3PNAPYoc/eyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663022; c=relaxed/simple;
	bh=CkUV3pgBWdijWLkc7gLBVGBRZfg03TLHKsXJUyEjW20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwkO/L3Qold9NO8/Zpck5BZJA+pTTY4ZTMWx96tTwhyBetvydlCYXX7d3ms8GTAg5mStyJO93yLHLZdlaSCURkC/5v/8kImdZKRYrpTAX6v+k1S1IXQD9GvrlJL3Et+UP7uuv70a5/rTJibn9GqF/PdsaIUNMsP535KSQIrcTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WgdOU4sc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qjHGFp2d; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WgdOU4sc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qjHGFp2d"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 50CF87A0077;
	Fri, 10 Jul 2026 01:57:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 10 Jul 2026 01:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783663020; x=1783749420; bh=Woffgfo/NB
	Gx/yic/e0ljsLenXtovdiN5X0iqoL8U7s=; b=WgdOU4scH4yaGlgkAil20GGdfm
	qvxKHOMCZkAoO5wP2zO8t3oIbJBWhcKCGhBa4OhqrrMDxEKoQQdJxDj1g4UpTCr0
	f6iM+kf+RIzGLrd0XsHmWKeelMREl9nhhnl5+hojicY2WPn5SumcUxn3K7qb3OC9
	Md+cK6HtRMK/rHKGCub37DmUxHQag0A5RS5H0itPO1yo2fHJVz3fQ6pv7yLNVP6Q
	jW8L+Aj4cYkN7st8wEnlAOxY/wMWI84Qu8tgCFGJHNGJfrOCGcrHv8yhzlQbBFn/
	a3eD1Ri17H/WaEHc7BAu0I2ZzXMYJBUqZjfMEVax+Sw23f1Uh6YdIz75DsLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783663020; x=1783749420; bh=Woffgfo/NBGx/yic/e0ljsLenXtovdiN5X0
	iqoL8U7s=; b=qjHGFp2dvxDl0u1i7C32hWXtse19BK0GHFpbvoE+wQV6Ej7+6/1
	D0Me4fZL1fow36FywRhT4QWMSVuSungYSNxvXdkEZfyl/HbELrTOQzCf0yzVReWG
	yrKpd0utboA9JJnAWH84F4ymM60ML/qTOV7JklGQZ5VrFjkqphHC9cCDbqGd6Ef3
	rVRLRTiEyP8YYBvAv9YWWZy3dfflIxuxKcT1o7pPaD8P18HSSIYy941CE0DtkgQc
	6wl8Hd60X5Iex4uLes1jeH1UNMzcAo0pugsqnukNSwsnOi95Ys7PX9FaXMYKiWHA
	GIG0YE3f8eTomMcpFithitmBKKYG83na3xw==
X-ME-Sender: <xms:rIlQap1IgivfmyrFyQNC0qYKljHvJcRVoPfp67IbNzh3vUv6Lx4onw>
    <xme:rIlQamGYBYM0gjZeEqtyglebIBsgB9AJEUzq_M_WULutJZiDshN1NCFNT5Nd57U0m
    QZX3_FczbmUlwqMT5HRqJ0jl5w6OxAN0ujzv6AOu07P65xt3nu->
X-ME-Received: <xmr:rIlQanj9_Zu2MCfgmtz5wak1WXOJULBy52rVNAMmUR8b4nkylfHCgeykHdXI4rrFvauqMp9NS9sDF3reMJMN3nZtIhxvLnj5fnUyjNorI8DGyw>
X-ME-Proxy-Cause: dmFkZTG4idemQZ07RCxuepwc8mlokes+HVHTJOJeEUggVMKm77ixtcDkPng0SptgAkvDXT
    dS9oYVk5hleofWwvHy2vxuETzDz2s4Wh3Axzqfy9vPV694u4IC9weOizGCoA/LoQg6R9zZ
    ol2bdiSTHhB22njESGv51df2eGQw/cm/hffkUKWdNLA7eTOpkmMjga4RNbqum75itV28aN
    cKjpyEh870I/VoAO5nfYmUQYn5GpZ7Ud1VClP0Zo9NbP+2sd43SZRbn0/6b3xGxkIr6mYX
    n/RmMNMIbB5jFkj3Y+ULCMDP2eKjPV9GveQ+nLEr7u8E8gAeg7WTITdQqdDzNvUpJXd6RQ
    00l44NdJX9HO5lAVwqxCv/c6bFo563e/ABYz1GbuqUthZQ0TCxkSLJkRsJD4R+3NN4m6WP
    /MCD3XuHJKGxR/nasVoRCjQqYzF7flntR+Qud/0sbjqjnx9epdadkEq5xbnjoiZNRCuswu
    lLoNEezXq6LjoiiZrpT7OvwWzwQd90VPvqibABr1HllzidPat++HZ1npi8Jvtfdf+wl/g4
    mcnJ1CEZG6dZlFn4vn48c+AwAAZxs+bQDTpT/yF7HmWcSbg5Byq8Et68+Ewlw7Y565hE32
    YSYtZrnDX9aWIu7AUUVj+2ivFYcjWUKRa8NcUbKd63Ugd1z1mMo9DDqmgenQ
X-ME-Proxy: <xmx:rIlQah8FWX9ehpb0vnvABjoQ_FUK2aqAQnAkXgmJSLQoC6Mt-MyjMQ>
    <xmx:rIlQauqF27d3-3oxkrJtfFx_jD8jc4zHB1UJ4F34RQVpPj_hNPbRRQ>
    <xmx:rIlQag8sGIBS-cFWPtGjc23ske-NhDFUre7ulWTQR0WXSjin9cwAmw>
    <xmx:rIlQaiXvSL1YEvP8qZfatJS3KiWkiBXlsBwLYyWvZNNtLsjp7Tnsrw>
    <xmx:rIlQalPpANxpu_tJEVN8qac0b-fyVrYL_NKj-mMLRCt8tLiCeJ-XnEtn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 01:56:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b4c7670c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 05:56:58 +0000 (UTC)
Date: Fri, 10 Jul 2026 07:56:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] refs/packed: de-globalize handling of
 "core.packedRefsTimeout"
Message-ID: <alCJpxAQwpTQ4g93@pks.im>
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
 <20260709-pks-refs-wo-the-repository-v1-1-1ad6f27529c9@pks.im>
 <xmqq7bn4ov1g.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bn4ov1g.fsf@gitster.g>

On Thu, Jul 09, 2026 at 11:52:11AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index 499cb55dfa..5c49c06493 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -162,6 +162,13 @@ struct packed_ref_store {
> >  	 * `packed_ref_store`) must not be freed.
> >  	 */
> >  	struct tempfile *tempfile;
> > +
> > +	/*
> > +	 * Timeout when taking the "packed-refs.lock" file. configurable via
> > +	 * "core.packedRefsTimeout".
> > +	 */
> > +	bool timeout_configured;
> > +	int timeout_value;
> >  };
> >  
> >  /*
> > @@ -1233,12 +1240,10 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
> >  	struct packed_ref_store *refs =
> >  		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
> >  				"packed_refs_lock");
> > -	static int timeout_configured = 0;
> > -	static int timeout_value = 1000;
> >  
> > -	if (!timeout_configured) {
> > -		repo_config_get_int(the_repository, "core.packedrefstimeout", &timeout_value);
> > -		timeout_configured = 1;
> 
> In the original code, when core.packedrefstimeout is not configured,
> our call to repo_config_get_int() does not touch timeout_value.  As
> a result, we get the static 1000 and flip the "configured" flag to
> prevent this _value from further getting updated.
> 
> > +	if (!refs->timeout_configured) {
> > +		repo_config_get_int(ref_store->repo, "core.packedrefstimeout", &refs->timeout_value);
> > +		refs->timeout_configured = true;
> 
> But what happens in the new code when core.packedrefstimeout is not
> configured?  It is up to whoever initialised refs->timeout_value.
> 
> If I am not mistaken, packed_ref_store_init() does xcalloc(), lets
> base_ref_store_init() initialise some members, initialises a few
> members itself (such as .store_flags and .path), and leaves other
> members, including .timeout_configured and .timeout_value,
> NUL-filled.  .timeout_configured starting as false is perfectly
> fine, but shouldn't we initialise .timeout_value to 1000 as before?

Ugh, we should. That's what happens when you tack on a last-minute patch
to a series you had sitting around for weeks. Thanks for noticing!

Patrick
