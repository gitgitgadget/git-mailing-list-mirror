Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6169416854
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693312; cv=none; b=ujI77CbuGg72zKW9MdS206wKwImBVBQUYk6PENy7IwQaQ6KJvzwjO6/1cmOJn4OPwTAhokiNo0K6SEGu9Du5fURZNyvcnn+FUWnnQgnE7kdPu8wCbjT/gC1XFQPungP2SSje5BxU/hhtoZxnCrZ3aOPMh757lCy1RXKgjvAJJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693312; c=relaxed/simple;
	bh=7zrn5NYclveAh80R4CSLvxvTu7pKoiuZXnX5Gco3Xqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcFN6le2rg81nIBnBx/KQE1FCBfAbX0v5YjCbhD+E1A3Uxo+xoWk7mOryWlNw2FOZ6IznB5rLJAFQZQILRfkrBhh1c6pkDdC5TxSkWsEuXZ8lwjlGcW+7YZklxvaFxGlFm/Jgq7fvCoNjLUfAv/rFrC0nXpf5rfuEQEPRhQ7GUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UHG1Wnbi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fcDS5ak/; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UHG1Wnbi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fcDS5ak/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id ED8AB1D0034B;
	Fri, 14 Aug 2026 03:27:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 14 Aug 2026 03:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786692471; x=1786778871; bh=KdPZzdtkuC
	gG8lKF0+KmeA4eqgy+dr7AXPcnWvjAB9k=; b=UHG1WnbiH+zDFHN7Z4kgn3hqbN
	P5Oey7x3amIBrLVOeiMBvNuDW5+wM6odFBzrsJk3zCS+k3amhFmDB9SsD9MQDXI2
	coGf3tGHHV+bMkcvxSwnnlLCjMnfHOnvy29XA/N2G0uBDjfGZWtFhbmzU8goEHXQ
	jszYXjaSdayhK2Y3x+brkzlRfCmEcopk6M3lozRjvDFGe/rgyzLNit84s8DZSvwf
	N+68M0iyFlyzL9CDcIal4vXKyTjSlwYutYTq5vPZ+I83apnSh5BoeJsqh6mV6QWa
	n6dd3TiRgFEOZu6k5bynU7FxNhwLgbtnXX2Lafpwsn3k1Sp6Lbg2gXw31CCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786692471; x=1786778871; bh=KdPZzdtkuCgG8lKF0+KmeA4eqgy+dr7AXPc
	nWvjAB9k=; b=fcDS5ak/xPQoJMWzFnjq6Sr02QNqkytl0prFuhcb9kvD5zPyD9G
	40+uW6V7g3dLWltP+UwcnQpEp+FTt0wBVwieJq8lo54z4wj5Rd98cMDeIngLfM/G
	dd5up7C4o9wjaRaKPuAzTgAgmvz26Y0aA8X3qGvaQgtIxjwtE7n/RY5XS9L4AU4h
	+fKLuW6AoCQVIkd5NZCfPWt+OKvK2p7I4Wi14LdWx/hNJKjUSbiakn/+z9hnN9zE
	/QuAGfHi8edqZbl7OHstpkDbgPQUtWGw+RhR2uP/UEue/iAtfjVrXbHjY483ypqH
	SO6Ba3JRDgDnGDOaflIpy/ysItt2K/hZO4g==
X-ME-Sender: <xms:d8N-avqk0OMmsJKx7oun-xNV-aCRfhSFn51i4-80LP7gxdgEr7nMbA>
    <xme:d8N-ar7eVFXJyeDP56leL_DYrTyL4v46LqKNkHwzPPeXfKIJibpq7RtcHWPdBIB4p
    T8BdQUyu1J6Wn2ChnfVSn9l786CPhic_XHoi7sLxYGFerFymx3uJHA>
X-ME-Received: <xmr:d8N-audmrZvlo2vkQZioEtU1YJLmORACEnZsjEzaAoiYXy76toAVQyBhe0L9zlYw2aCIEhHSMO11KI9fMC5YI3MxhI8UVLW1KHGK65W_fZs>
X-ME-Proxy-Cause: dmFkZTE3itlpFNUlyUroRVCo14rTJulh1TInroVxwL6COOeUL0oEZ5LTHxVaUOw9BqQMi/
    WJKJE8haO0EsoGgUMOiP3sP1t8X8/QsuucxE9KbWjpHNt0GkyokQ6FgqQVr4H/dq0CzoLz
    hEfeYJiTTXOY6tT1uU2HsN0od2oZdBwVOgF5nFlE6MJ7rgzABf6etiSiQtyVusIKlGvu8r
    1FdNpMldC2fXrIZrYh9e0fmEyWoNfjfUvq82BmvrANCt0+Mcr2Le5u/b0kidxl+dgWqzdP
    3OAoLOEFvbw2yJ03J3igCE6gO0FRA/I8dbiO/OI5yoXSo6JghzCNDYyoWIeb2famobEicS
    E8wcLEu5GaFcRTthAHJEtLGYi4vZu/f+IGWu0eewsgu5WfjCB69GMXZlTo4ldTLj09cpL0
    ZwDeO7G+pWdQSV2O1LnrRUxFdNV+1F0qD5PpZwnLSmtVcqp5+JuLqX1ZVqxaBa0TVpJzEo
    5kUb70FXkdwTgt5yBVLG7jBVebal8Cwsv+M/frFAAcu0dvktDkIZ7yWjKz2YRIJYZgOOc5
    qQXjy2fk7ghq0hnjg6Pm3WaSEnI4oW15+Mm+i16X6qry3P9o2hvePezzza4a53jO1TWtaH
    H64661Ztm4Vhp5XEHetwcA2cFYtagtKEDikJgISJoLWZuqhwM9nNH1vO8XVw
X-ME-Proxy: <xmx:d8N-ao7I69CgcrGM6moOMxS-GB1hijg4Txi-xQmblJrVsamKss_WYw>
    <xmx:d8N-atvMMBljbCv0aNqqxUOSFdffcm4t-cMFEOkqslIh0L6FxJhb4A>
    <xmx:d8N-aghbBaiKqfbMBBn0s4D6S-WOK7-p04USKEOnbB2agwf6-bSerw>
    <xmx:d8N-agpOS6nLsmNGXQCHRwa05nERDIo2d0mrbjk80UOu5b144cLTFg>
    <xmx:d8N-ahcabEY5TUgApVJrlzS6jRJ_45OdAKXXcgbpFZTCm3NjeMJFGas_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 03:27:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c818eb32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Aug 2026 07:27:47 +0000 (UTC)
Date: Fri, 14 Aug 2026 09:27:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 2/3] midx: pass custom '--base' through incremental writes
Message-ID: <an7DcGwWwjbq-C5a@pks.im>
References: <cover.1781294771.git.me@ttaylorr.com>
 <4115ee0a9a09351e47d557a1283fc6ec4d633304.1781294771.git.me@ttaylorr.com>
 <an2E_F_1DC4cPKG3@pks.im>
 <an4pffUrCY4xhTH2@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an4pffUrCY4xhTH2@com-79390>

On Thu, Aug 13, 2026 at 03:30:53PM -0500, Taylor Blau wrote:
> On Thu, Aug 13, 2026 at 10:49:00AM +0200, Patrick Steinhardt wrote:
> > > @@ -128,19 +128,33 @@ test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file
> > >  		--no-write-chain-file --base=none)" &&
> > >
> > >  	test_cmp "$midx_chain.bak" "$midx_chain" &&
> > > -	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
> > > +	test_path_is_file "$midxdir/multi-pack-index-$layer.midx" &&
> > > +
> > > +	echo "$layer" >"$midx_chain" &&
> > > +	test-tool read-midx --show-objects "$objdir" "$layer" >midx.objects &&
> > > +	test_grep "^$(git rev-parse 2.2) " midx.objects &&
> > > +	cp "$midx_chain.bak" "$midx_chain"
> > >  '
> >
> > Would it make sense to also test for an object from the first MIDX layer
> > to be included? Otherwise we don't really assert that all layers are
> > included in the new MIDX.
> 
> I don't think that is necessary in this case, but let me know if I am
> missing something below.
> 
> The new layer is written with '--bitmap', and '--base=none' means that
> there is no base layer from which the bitmap can inherit objects. Since
> 1.2 is an ancestor of 2.2, writing a bitmap for the new layer already
> requires that it contain 1.2 and the rest of its reachable history.
> Otherwise bitmap generation would fail with the missing-closure error
> before we reached the assertion.
> 
> Checking 2.2 confirms that an object from the old tip was pulled into
> the new layer; the successful bitmap write already establishes that its
> objects from the earlier layer were pulled in, too.

I think that's a bit roundabout, as it simply tells us that the bitmap
was generated correctly, but not that the MIDX contains the objects. It
of course should if the bitmap was generated properly, but I would have
preferred if we verified the property directly.

Anyway, this is not a huge concern, more of a nitpick. Thanks!

Patrick
