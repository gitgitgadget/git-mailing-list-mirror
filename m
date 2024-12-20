Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE182594A3
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684360; cv=none; b=hD5NOxSMLTZQy4si0h3DmKyVjpjquIl8v3nwqnHeTWS7E6+3m7oMBU7w8hiXFgGKTsHTjzAsOCoBxeOAnY1HF+wvXdIblYo6VIkNCp7fX8mhKxCrQQu+QaJ/1bNa+3RiJjPrW/dbAkr7wLevH6uZS/aB/p7I/nXMh7roCuyB+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684360; c=relaxed/simple;
	bh=3hB/g3RJ6jvnAtXEUX0bM297SL2P5KC4MFszcb1LiKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOvcLyTpiW7WCXumBWa8Y8COr1fO3yiBZokaSgRiRQTXb/CRYScQOJKAVIphlTgWwf+p8rSpacgROrdiT/Qsy8nKVuMwOYizGP8ct/K+8U7ixTlapledgUAGds7WidJfCgg94zoivSZZS4S7e9S8hUoMP6wW04r1LHL7GBF3QgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fX5eG9tJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HwaPaKWc; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fX5eG9tJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HwaPaKWc"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D267713801FF;
	Fri, 20 Dec 2024 03:45:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 20 Dec 2024 03:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734684356; x=1734770756; bh=eZ46Y6fW3J
	5dkRSDFOshX1qJ2gw7fWMJ01GnAawk86g=; b=fX5eG9tJce/ZTuw4zWNoPRRDL3
	8t+RyxoagIrRfVirO72OftuePERyE9xr/odtZdfyI4VwO2ORFH2N8W6bwexrgjby
	WI7CpQI1bHs3ikF2YwE6hAVT1EM9Cj0cFeiOBLAhacv8Do+oBB8YrDIxxW6tM5vV
	pyc2spAcNNm0x7myP+yWveA/R5yyT0i7CTULdCwZ73S38pF9ZTt36zj/VyQooFce
	2kEciEp30+miKuIzn2MgTGlADzZN1i5eEvb2vRL3IfxBOk2rGwGVJEpZKvWORpnA
	Vo+39o40jQOuYVBy4HP7dXsNCzyhOxozZB1aKEvXWnFVHLrT0MpGqmmQ26rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734684356; x=1734770756; bh=eZ46Y6fW3J5dkRSDFOshX1qJ2gw7fWMJ01G
	nAawk86g=; b=HwaPaKWcSclXUHHmnZLvHOa4EG3OWcy42DhqD1wElI4p4ENZhVs
	BubssNMPCq4HOqBMLLnL0UwELHlWRaYhUm9R//BOCn4ZXrPNMz9b/50Y7WUZM7+N
	5i2otsG6FVa1/Me7D8W4e21LU3hwsx7FAn/YVhrjsgbH34ysIqOHxXvR2tmnezGb
	7etKdXaEQkEJvpyIvJciaqEK2bJf5C0OFKjX5/GkPirLvjL7S7obyBopbMtQjewm
	DjQezzQ9KYK0uqW8d2JsYTUIII9Iv1VvUbWgxJ8MGlwsQEE7JW29wRzTTX2egpHw
	d5OJ0za/YgBWvKOUtLwT/qjYzkeaQJLa7Bw==
X-ME-Sender: <xms:xC5lZ6m2XFzo0bWRlShEiBZw3jl_s4_bhIK969UHKtcx7MBMma1ijw>
    <xme:xC5lZx24V9nvS4j_UhW6vr2WHcDoBXoqd2T66SD1a5iikazVWfnIRSHxKGstOUqLk
    moXG6jOTnkKLcA9cg>
X-ME-Received: <xmr:xC5lZ4rK3zGwpg94JJnq7dfcSR4Uhx_heMBWqkIGyHyAArZTxxw6bBgbS8HL7GWrblf2Prk2esiEj2xMEcMdLAP3YsYRYMAUx0BmpxHGCbrTH58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtuddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xC5lZ-mkXPQcyS4Qa_KFbNgvar_0BwRZb9V7VOQzhUYnlvbfEx2omQ>
    <xmx:xC5lZ41Rq5h_eFwZPxP067JZ8WAmZ013HkzzFrHrUdR8fmsEZzyEzQ>
    <xmx:xC5lZ1sDGeFFyLjTMlLW5t6itMmGPLw_xrDlNarloUfnk_dEq0xvXw>
    <xmx:xC5lZ0XBK8UlL2XGvwc8n3z6MUoZUFKDW-okf8jniAI-4W4I26lN-Q>
    <xmx:xC5lZ7RTmLZqwoweRzAtKKOS7x5cvn3tOS2bWRlfEifsKxzUBsmAOI4k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 03:45:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de78e1af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 08:44:03 +0000 (UTC)
Date: Fri, 20 Dec 2024 09:45:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 1/2] GIT-VERSION-GEN: fix overriding version via
 environment
Message-ID: <Z2UlpaDFjvl--zau@pks.im>
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
 <20241219-b4-pks-git-version-via-environment-v1-1-9393af058240@pks.im>
 <20241220073437.GA2389154@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220073437.GA2389154@coredump.intra.peff.net>

On Fri, Dec 20, 2024 at 02:34:37AM -0500, Jeff King wrote:
> On Thu, Dec 19, 2024 at 04:53:36PM +0100, Patrick Steinhardt wrote:
> > diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> > index de0e63bdfbac263884e2ea328cc2ef11ace7a238..787c6cfd04f0a43d0c1c8a6690185d26ccf2fc2f 100755
> > --- a/GIT-VERSION-GEN
> > +++ b/GIT-VERSION-GEN
> > @@ -29,7 +29,10 @@ export GIT_CEILING_DIRECTORIES
> >  
> >  # First see if there is a version file (included in release tarballs),
> >  # then try git-describe, then default.
> > -if test -f "$SOURCE_DIR"/version
> > +if test -n "$GIT_VERSION"
> > +then
> > +    VN="$GIT_VERSION"
> > +elif test -f "$SOURCE_DIR"/version
> >  then
> >  	VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
> >  elif {
> 
> Later we process $VN into $GIT_VERSION, but after removing the leading
> "v" (which would usually be there from the tag name):
> 
>   GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
> 
> So if I do:
> 
>   make GIT_VERSION=very-special
> 
> with v2.47 I'd end up with the version "very-special". But after your
> patch, it is "ery-special".
> 
> I'd guess it's unlikely to come up in practice, but if we are trying to
> restore the old behavior, that's one difference.

Ah, indeed, will fix.

> The second is that the value is read from the environment, but make will
> not always put its variables into the environment. Ones given on the
> command line are, so:
> 
>   make GIT_VERSION=foo
> 
> works as before. But:
> 
>   echo 'GIT_VERSION = foo' >config.mak
>   make
> 
> will not, as the variable isn't set in the environment. The invocation
> of GIT-VERSION-GEN already passes along GIT_USER_AGENT explicitly:
> 
>   version-def.h: version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
>           $(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@+
>           @if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
> 
> Should we do the same thing for GIT_VERSION? And GIT_DATE, etc? If we're
> going to do many of these, it might also be easier to just add "export
> GIT_VERSION", etc, in the Makefile.

I guess. It'll become quite painful to do this at every callsite, so
I'll add another commit on top to introduce a call template that does
all of this for us.

> PS I don't know if meson.build would need something similar. It does not
>    even pass through GIT_USER_AGENT now.

It's easy enough to do, so why not?

Patrick
