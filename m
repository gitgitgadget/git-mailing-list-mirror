Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B044414
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 04:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745469103; cv=none; b=owz6cBoCwtWBwvJV01sGZkS6MO+Eq7A1vwspCFM0ahf5iwN1hz4qIOGWqxupeu0YQ959o7TAKNl88MfBfUtjZ5r6+34pIvTRiqU8MBCezpj0bND0PMy4rn/8Qdh1AtMaVj+4JXC4eGjEjoAjVSkRzd9tZeXs2vaHn4LY7ZQ2RXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745469103; c=relaxed/simple;
	bh=oHPLbP/s4yRuFlW51Xf8Fm+GGp4edk9hJqWxrlVO+Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II+qA4Ytc3Wv/96wiYXgxAEtUgHNeIdjA6ZZslCEf5WoA/h7pAZq4k9qz6Vgb8ChVVO/d2sijeGrABgXF4Aqhqk5XEu8RJkjlp8jRpbZoNaRFu4rsLg/0qT037FrhiAGfCdHTRyateV/4pe5KL9P1rx1HLogoCVfLJK+h4dmCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i0zYsTFx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7LzUOKZ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i0zYsTFx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7LzUOKZ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 4C4E11380422;
	Thu, 24 Apr 2025 00:31:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 24 Apr 2025 00:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745469098;
	 x=1745555498; bh=4zuIPcQUrXmDIuqR/KvU9NA9wQ2sD0wFniRCzTgG5d8=; b=
	i0zYsTFxtNJ8ES/P/xMJqBk4HlbsUUVx5HEDIRItbv52aIVbTgmBxiq/73fg4E5f
	U2sHSKtfg8EnLd3UHI59htwqkTIuKjqMNOjeM3Trp1BtvaXhImhPq0nlC3gVWbgw
	/cF4chX4f7L7T6a++lZuOnKvwVvPj3/8Ls65PI/AQpKkyAKtPUtjj38R9DGAkHyD
	y21djD8tiTr0Q61i5dRbeyWt3kJJJfIedQk7/PYPgzr8dkixHwzwzpXeMxBCepPB
	k9MAgb4wbFIZS8otdVNaGaA2oBPVZQFPkIxSzL75OD+qGP7F2qS+jtOggwNmP4Dy
	zbn2M7V4IbpwOYp4GvAGzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745469098; x=
	1745555498; bh=4zuIPcQUrXmDIuqR/KvU9NA9wQ2sD0wFniRCzTgG5d8=; b=k
	7LzUOKZPmGD+3qccvuil3ClibMh6tSk4465pkfEnk4b3Bgolt52nwawB2GVtWHHl
	V70x/yw2Bhkx4d9ADi9m2Ne4vUr3hlZkgkzWAUbifzBGw0Lb7LaN81vcOJEPVRyn
	81Zc6J6Q7Rbs89kCKMv7NqXiNc3LdefuXsRM6X4CrIFXqNHYRI/ssbmfqaOKSH5l
	AeYwZDZGjo8f+4X9DxbQJi4yKbHE+S//EI6TlMNKu8B2tn9UPHVrCJV2iTMxASYw
	Ya4LIDEqsRVDpN3tUScBjbsb0ObdJFuOqopHQ7Nl+8COsTt0ikISkIbEo5BIX4t+
	4LBrD5+TzqcODK5Vmjb0A==
X-ME-Sender: <xms:qb4JaMUKSPNO74MNTNmZgQXqXLyRRhUK28gth2zOvSCXwM3tNCnPRw>
    <xme:qb4JaAmw61qXVDk_Bl5KNwpeh6K7ktDsZWTiEBXq8utqT7KuF5y2CDXsDgG1xhKsR
    KPd4JfV_1afObVdzA>
X-ME-Received: <xmr:qb4JaAZiLoSmhXp7tGeRd29ZE8YL5CreA2Qd4B0j1ssJNVYlmxKsVoVgoHbTLFhLcFg_NXinL-pIgjbJxy-pNr4uaI6Y5nbGydtvYqKT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeekheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetheffvddtleettdetueeukedugeettedutdeg
    ueeukeetheefueevvdeitddtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihho
    thgtlhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdho
    rhhg
X-ME-Proxy: <xmx:qb4JaLWMPMr7cOjAb0pno2Ix9y1HOO6FIDTJCNYfUgKkLSfQA8SLIA>
    <xmx:qb4JaGlLUmsLRDx3uEfzokrvehwxTMULW-QS7TwelTSplvUQUgQ7Hw>
    <xmx:qb4JaAcOfbWvRj2seODS2lfwn7S0Fas9Lol6UI2ShqiG04qbfsQ1BA>
    <xmx:qb4JaIHU6hNS2F_xSMLUxzFglkKLXH6DGaweG-DW-5Pww8QWQNu8Zg>
    <xmx:qr4JaHLPO7vspOJkxde3h09gfA5040I4QzLT49dYlZvjh9dcVZNxoBj4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 00:31:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a1e2a605 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Apr 2025 04:31:34 +0000 (UTC)
Date: Thu, 24 Apr 2025 06:31:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/5] meson: wire up support for benchmarks
Message-ID: <aAm-pcIfrFt6mjlV@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
 <CAP8UFD3Nr_f7WSzjv4AEKzH9Kpsf6soOd+VSO9ng=-ZSws6P3g@mail.gmail.com>
 <aAdK9gnXOO3ERq7w@pks.im>
 <CAP8UFD1zqAk1_Y0ECu4=iyeF4k4LagfLgHWkEr8iz8ZnwkVT8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1zqAk1_Y0ECu4=iyeF4k4LagfLgHWkEr8iz8ZnwkVT8A@mail.gmail.com>

On Wed, Apr 23, 2025 at 04:44:20PM +0200, Christian Couder wrote:
> On Tue, Apr 22, 2025 at 9:53 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Apr 22, 2025 at 09:27:57AM +0200, Christian Couder wrote:
> 
> > > In https://lore.kernel.org/git/CAP8UFD2jKwYzmc40knXY7k+FQabjZbGTqs9fowF=-0OqfNYp_w@mail.gmail.com/
> > > I wrote:
> > >
> > > "I wonder what happens when we run `meson test -C build --benchmark`
> > > but 'time' is not found."
> > >
> > > because I wasn't sure if it would just do nothing in that case which
> > > might not be very user friendly.
> >
> > Ah, sorry, forgot to answer that question. What Meson does in that case
> > is to print "No tests defined". We could help improve usability a bit by
> > printing benchmarks as part of the auto-detected features after setup of
> > the build directory has finished. That would make it more discoverable
> > that benchmarks have been disabled.
> 
> I was more expecting something simple like:
> 
> if time.found()
>   ...
> else
>   error('Benchmarking requires the `time` command')
> endif
> 
> in the same way as in meson.build elsewhere we have things like:
> 
> if not msgfmt.found() and gettext_option.enabled()
>   error('Internationalization via libintl requires msgfmt')
> endif

But erroring out by default doesn't really feel nice to the general
developer. I'd claim that 99% of the time, developers will only end up
running the test suite, never the benchmarks. So the default should
match that and not require GNU time to be available, if you ask me.

An alternative could be to have a 'benchmarks' feature option wired up.
This feature would be set to 'auto', and then we can detect time like
this:

    time = find_program('time', dirs: program_path, required: get_option('benchmarks'))

This will then auto-enable or -disable the feature depending on the
availability of GNU time. But if the user passes `-Dbenchmarks=enabled`,
we would fail the setup in case the program wasn't found.

Patrick
