Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522FA1E7C08
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103659; cv=none; b=iXM5X3q5J9bvlKWKFEGj7DqzQKqnaoxPYO3JD9cgZqIj6zyOsx6gkbfv8fDmTlU9X8hv8aYzgcUdv7TPFVbiVA5aCAYj4Grn703T76z6BiaGoaEEAgdZnN49lp80L7p3wx164BYelIYJEVmDWgIxmJLWjh9C9jWXegzSZkvqfcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103659; c=relaxed/simple;
	bh=/+ZTeRnT48ho6hWzf7w5ho8eJS/B0O8EtrWWOxJJRRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGIbBun+w6oQKAfBW5aBv5xYztzRlLDYrRQJsGcjv8L4g0UwOvBQcF57CRHLlto0/Yns8dSlG6TLMJAJrqOKYHlwcUz+4RhE+gReNVbcZXwm6hVAYLZZDJra5AzndDUMwSraariEgC7HAYmqIMBcMZGxfWRHCpK8d3KeyBoxkVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SKGyCoiI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DPg3jaxR; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SKGyCoiI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DPg3jaxR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E61B14001FC;
	Fri, 14 Nov 2025 02:00:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 14 Nov 2025 02:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763103655; x=1763190055; bh=UiVty1ZmF/
	gpFIB9/PIHQ1Kgniu/o1K1LGd1LL+xn2g=; b=SKGyCoiIOmIlfDIg83xRXwGdhR
	Waj6GplumtzsUZbVlAv6J/7wlyZ3d8AOtPgVJZVNrhRXLVvsQbOmx2ch+yOZQPE9
	dCsOGzvVMSrrHoo645ZKznlY0BuwmCaEi97RXdpmKBySqCVqazl2qgvJ/ptC1WA/
	wdxTYXhTRJBwXZzaQh9FdRNQwgWM9/02yFj8KGHa+mP7v/dE0JUkr5F0MP8ZxRdY
	bxYY5Jo2PkN6oE007jGpzBNOlafbgwYbe6B/lHKCYHQ0UkZ27ktb1uLRbYN3lMIc
	ZYPzpP3hyKMMOy1iY8JOs7dsopmdj6R8o05gwIWz6FIxAknE9WAqGiIk9XTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763103655; x=1763190055; bh=UiVty1ZmF/gpFIB9/PIHQ1Kgniu/o1K1LGd
	1LL+xn2g=; b=DPg3jaxRY9WopUR5C6lZ3yjeGf6AHDhsc4kNhsuOfeIOGruVs8b
	8uYobwkOc9DhSyDfmL17XBd0Y4zQnMr2CokMMKx+TOP97MwZENw9LEI+uzN5xhik
	0s45FLGZNW94QHy6YsTNzBmtX106dBH5mfa/2IGgtGEHEn/uss2wnRlFk8dkAOiq
	OAkVs9XxGrrel3wTGDGsLYvcVKxtYk16GaUrmhK9dZh6nEQu/nN/punGC7j1GUWe
	kh1FEQhbk87XaVZBNe+JndW+AtHF+7yz2ojSjxYZn6tXOBLzkxQZ/leImXnKhYRe
	2bA6Hmx+CnVP3RiRsWupW5rc5W3hg0pNUFw==
X-ME-Sender: <xms:ptMWaS4waYYnNVkML76G8H-pDM2uPH95ywheijtDPOQ6mLVGK1jcww>
    <xme:ptMWaSy-pyUDCbqxjptAIMX59L5f4X8v1yFXfuAHOESCgih9kkIQlXvXkLrAeRrgj
    4caChtp1DRuQXFi5vWDw5mmJMVacWifvCXe_qaegWf4kM_TxPDCoWg>
X-ME-Received: <xmr:ptMWaZwT6tgYmpbAcCxcEq_KrzQBrqKhrXUOc2oexieHuBoT-0TV_yY3RvStZJH-3sygOySrTEQJzv2o9mkdQ8-55ijhTyRInsObKW5qog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeludeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdortd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtie
    duleeulefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopegtmhhlihhsthhssehsvghnthdrtghomh
X-ME-Proxy: <xmx:ptMWaayruYooLFEVToqeLINaJqRAduEwzWOrOGP9yE98YOANZz8Nfg>
    <xmx:ptMWaTZd8ICcRa17IrmvKsHRdApU8Ck9UV8mLjlCWJF78TYOGUYv3Q>
    <xmx:ptMWabWN2p9jdb55th8wLpEG2LGqmK0vrQEo8zwyfpe2xVKZ9WvV1A>
    <xmx:ptMWaRg8dFrfo0uwEyHTxGLM9F759r1Gtq2TUXk3TRdLINZ5WTTtfA>
    <xmx:p9MWaeDcFn96M5yA6_R4dgDKKzEqqClG05fm1ZmIw6KTUuuiDmZzgJTY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 02:00:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3357ea1a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 14 Nov 2025 07:00:52 +0000 (UTC)
Date: Fri, 14 Nov 2025 08:00:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/9] Makefile: turn on NO_MMAP when building with ASan
Message-ID: <aRbToFLhzewwBaSv@pks.im>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080215.GC979063@coredump.intra.peff.net>
 <aRRu1cxpIzd60AoU@pks.im>
 <xmqqfrahq4j8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrahq4j8.fsf@gitster.g>

On Thu, Nov 13, 2025 at 08:30:03AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Wed, Nov 12, 2025 at 03:02:15AM -0500, Jeff King wrote:
> >> diff --git a/Makefile b/Makefile
> >> index 7e0f77e298..0f44268405 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -1587,6 +1587,7 @@ SANITIZE_LEAK = YesCompiledWithIt
> >>  endif
> >>  ifneq ($(filter address,$(SANITIZERS)),)
> >>  NO_REGEX = NeededForASAN
> >> +NO_MMAP = NeededForASAN
> >>  SANITIZE_ADDRESS = YesCompiledWithIt
> >>  endif
> >>  endif
> >
> > Let's also apply this to Meson. Thanks!
> >
> > Patrick
> 
> Do you two want me to squash this into the Makefile patch?

I feel like there's going to be a revised version of this series anyway,
so that's probably not necessary. Thanks!

Patrick
