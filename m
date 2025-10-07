Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30993199FB0
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832845; cv=none; b=OC/6KjmTvVye+qF4W84SSq3QiD9b1TJFNta1GXPgOeGkh46PciZU9HscdIYvUWuTJDphw9DBDckgC00o+w0qEez+e0qCSBWT5bQzy6x2QZsekzeBin8r7ywMHULYsoAB7PIxHK9nM4+FUf3qWKMHoSXvHdJxscpdzE0s+5bThic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832845; c=relaxed/simple;
	bh=7osfagAmk/SH3L3ib+zE7izf8HNeRyPHB8fNCJRGdtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7MI0lf2Mann5eAmsTOdDbhyreQxRI4Db0V8I1abBOt4N806XrxUmKMqqElaKGF2tnZVozFEy6zS5PvnyQBpNc6Bl++MMBttulCX+pg0NkX/qtHvKdN3RrFMqlMqh6r2BHM6hITz8vXwudEU3eNN/19XIkSrANSpDMhfHgYGUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kra6P3mm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UBD0DYwe; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kra6P3mm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UBD0DYwe"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2BB517A01A4;
	Tue,  7 Oct 2025 06:27:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 07 Oct 2025 06:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759832842;
	 x=1759919242; bh=Qn7I1qBTLyDqBnj5rXvC3XqF4L4InRPovjPr9h+GHD8=; b=
	Kra6P3mmJUFDHK5Ir3HhdApV78MjXy8lwyhSWkiYK1DrBYw8gky5kYXkwbulPGKt
	cllq7aL4kYt46y9HlbFqUZ8VrBz2joOLmnb+jiLXxuOGevuiatrZuz6NYbCBnYgY
	bEjdMDSt1boPvghF75VMhgWa8Z4P5jWAL0aElBZM9S6SoTClhb+qlrTd7JxQlJ+6
	16yv837DD/JUk9IFx50RihPXlZAuWBKrL0L/SUrQC+nH5t5TQ6vB+IaWKHjfbyH/
	+M16U5ACUFUqcvc2VcQ4A/xwIJ3+yOsv1hv15LOLRscTAzvWDRELeGhiDwUzL6sY
	EuRxwNRURgIG41o2sFEMkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759832842; x=
	1759919242; bh=Qn7I1qBTLyDqBnj5rXvC3XqF4L4InRPovjPr9h+GHD8=; b=U
	BD0DYweVsxqqWCJKB/FLKV51z9DhuhnGvx6864iVTR4TZQRG4N0BoV5uyWz7b+u5
	NODAtHSfFahLXL33FrohkicdNUJRblnH419CBX0yGTUrO8kkw8SAoDLSgBh70oYP
	2SRRH3iTh10iJypBZRcvDVruCaAZJeh5ydkfCpp6sqM9EiuNhWNzOMkq3o/xHHtB
	xxrYdbgnKBa1NB0gTAi/6+OLxB+x6MHqmViEi9PrdtyuGbbzeEH7SUliTwd6mX+9
	Bb3AmQj/v3SYOchBusQvnRva9jrGM3xs6RZ858wqx9W6wmpjBZvyKqOS6CMh80z/
	L+3fhJKfyqxymOinfYjew==
X-ME-Sender: <xms:CevkaDlSY4IoocM904To1tDXMHCz5l9O9ZThiW_BWT7KfJFWwa9-6Q>
    <xme:CevkaN34412dtJG-W8wwI8_JoJuI3PtZK_3XV1YGNCzXkP7ravB9m499_sznIllXX
    IrRqLex7U9QOnw5McxGYw6DTwxkoXqYGabctddz6XdUzl8-oFJn>
X-ME-Received: <xmr:CevkaOqRTUt5M8-kmev6kfQz4DemO8mBW509XBqYe5SkzqgAOHiP4ytSiBL4tQk4c_BaTKfCnpJM0lKqPAaG9DTqoJyyPz9i3UzTLQ4ZfRI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehluhgtrgdrmhhilhgrnhgvshhiohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:CevkaKdq9wlJKrZgHDk0ig9QiQjoKw_INZVD2BBoANEn6SXb_qYQbA>
    <xmx:CevkaNqoX1lhzhHjYcSwLhEOf2Lgyd6uJ47_Y7YJb1fN8X5dvwPN_g>
    <xmx:CevkaLEO_QLmnWL_OMW3Dowy6yNohgHZeItTkPrMuufkFbGclICLBA>
    <xmx:CevkaNtaCTJDI0Zyd8XHxhXnVeoWX1o7on1HGOdOyHh74gYtjc1gEA>
    <xmx:CuvkaGl2OdHI6abUKvDid44oIzYr5QP576zWQG5rg6XFzqym7Urz7ieF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 06:27:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d1a6fb5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 10:27:19 +0000 (UTC)
Date: Tue, 7 Oct 2025 12:27:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aOTrBAXhKF4iYzQB@pks.im>
References: <aN5-n_ArhQqaQZgt@pks.im>
 <D59D0576-63C9-4144-B49E-54D43A80E0B0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D59D0576-63C9-4144-B49E-54D43A80E0B0@gmail.com>

On Thu, Oct 02, 2025 at 12:54:13PM -0400, Ben Knoble wrote:
> 
> > Le 2 oct. 2025 à 09:33, Patrick Steinhardt <ps@pks.im> a écrit :
> > 
> > ﻿On Wed, Oct 01, 2025 at 12:04:38PM -0400, Taylor Blau wrote:
> >> 
> >> 
> >> So my feeling here is that we should take into account not just the
> >> readiness of the underlying Git implementation used by hosting providers
> >> in the Git ecosystem, but also the readiness of the hosting providers
> >> themselves to do the work necessary to facilitate that transition
> >> outside of their Git implementation.
> > 
> > We definitely should take into account the readiness. But what I think
> > we'll need is a roadmap from impacted Git implementations and hosting
> > providers so that we can answer the question when they plan to have
> > SHA256 support ready.
> > 
> > Without such a roadmap it's basically impossible for us to set up any
> > realistic date. In that case, we only have one of two options:
> > 
> >  - We just wait until eventually everyone has SHA256 support. This has
> >    the effect that there is no pressure on anybody, and thus it is more
> >    likely than not that it'll just never happen.
> > 
> >  - We set a strict, "uninformed" deadline that may be too ambitious and
> >    unrealistic.
> 
> This seems like a false dichotomy to me. Of course we can forever
> debate options to go forward, too, so at some point we must have a
> decision :)
> 
> Anyway, what about establishing a strong but adjustable (“proposed”)
> timeline now, based on informed opinions from folks who have already
> provided estimates of what’s required? Then we can shop around for
> input on the proposed deadline while still taking into account new
> information. 
> 
> It also provides impetus: “sans input, we will go forward with the
> proposal, so let us know if you need more time” might motivate folks
> to firm up their own timelines and provide said input.

Yeah, it's definitely my goal here to do exactly that: reach out to
folks and take everyone's input into account. Once we've got it, propose
a timeline.

I guess as part of that initial communication with the stakeholders we
can also mention that the current plan is to release roughly towards the
end of next year, which may help to put things into perspective.

> > Once we have roadmaps, we should set a strict deadline that takes them
> > into account. Any hosting provider or implementation of Git that doesn't
> > provide a roadmap will not be taken into account in our planning.
> 
> Btw, I’ve often wondered since I see representatives from
> GitHub/GitLab (and JGit/Gerrit to a lesser extent) often prominently
> identified as such: do we have folks from GitTea/SourceHut/other
> smaller forges around on the mailing list to weigh in? I assume we’d
> also like to include their input.

Such smaller forges should definitely be included. My plan is to gather
a list of stakeholders for now and then send an email where we Cc
maintainers of such implementations.

Patrick
