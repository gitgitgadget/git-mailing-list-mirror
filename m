Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1C261B64
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058597; cv=none; b=lDbQ0SPU8As8dfwAySq9K7mswaCDGKyqT3fP80IsdQLU3XuI9940KFHJ5RBfTOSm3IVvONcg1iaTVDQco7MbAUHeDOa8oHpDHKKVn6vsHlL8bThSTTWDuyhkdOTNGy4Zv7u3qljS4Y8tXIiodQ4BeoKgf9OMa8WKaLxvl663QK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058597; c=relaxed/simple;
	bh=iW+q/x8SODj1dsVIWNvhzdHGSAxiYosf+5IjGU2TXEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueDzI2MECPzFFTEkNSc6lznUxvz5c1gPC4wsbQf+t+9/Tnyetl2pPW4Na6eZZhy/HrkoamtafkWZlAYOBjgraiWTlezq7MBQKXiuXMNU0zTjm6oEbDTfrqctnqD4pIt4ZEXUIE5IkgM+HFSPUiaafTrH1SvD9BOmpdWtr21riHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o4IwGODj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvV1kdst; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o4IwGODj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvV1kdst"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 751CB1D00470;
	Fri,  5 Sep 2025 03:49:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 05 Sep 2025 03:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757058594; x=1757144994; bh=mhByzIfUAh
	B78bOg1GiUMpwgUNUlbTLv+jHG8o66UOk=; b=o4IwGODjWqC7F6wHR+ga3HcxoY
	3hpIXXoEnDS5dTClfty1bgI4WvfHsda8YFYFEWeXtJGnc/+kjI1MJEzr2LmwYJ6L
	zXPxCGSV3ETf78uVG3q95x1biXPtRXi73VQyJ5tDKf14cGmLXhPWsfMk/s0UpCF2
	qoGe8Dw/N2YA1MtV9wB9/mtH2ZXL8CwDJ7J/FVA0N1m9qak6xl/1t/3Js71qCKpX
	nkAmHS4LKub36myqzO2X4gDGJMOYShjTFDeFkUiHo8s1954O9LijG0QU25iWicld
	nf9Cd44c7hw0k7WZ7CokEcmUeE9k9t4wami6wWnAlpFSUEGyoX0WjYlLy7bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757058594; x=1757144994; bh=mhByzIfUAhB78bOg1GiUMpwgUNUlbTLv+jH
	G8o66UOk=; b=HvV1kdstxF5ZwVO6oZw68rD+/OoYTIC1lcOWjWmtKHWzNiRoeXG
	htgV0n4haz/e79qQiWJppq4gstrWsZJwW/EVAtgcADIEXKe/DgLs1V/d/w1C0evW
	PtDom7vJi1EQPLcR8v+GZldw1144KdoP+1aASJeeCBjCJzRimvmM0tFJv2U5/5vh
	VQ7z5dlgtvNpp1U4tF42G70L6by1CwqC1UfZ033PapTSB4zxz4uYtdVviMsoF1Pr
	v3ZiPJyUiMgg2g+TlRstYRYLx/dYj5bCePSHylNztG6VGy90Lrts/ybmRheYvSYV
	+Wp/4EiBUvIEA5mVTgNJ2U8bwXY3sVcGk5A==
X-ME-Sender: <xms:IZa6aDKEB7u_poyzRd_0yFSA3xfBmj9oCqbr-AlNzIrLdnvCw2_byw>
    <xme:IZa6aHTGy9_7B45FOPRHG8Eay2rjEb-crdADOfPrKdaZMBWMSZDT0ZQRDs8GT1CJX
    vnuWRe_Dtj4l-YLbA>
X-ME-Received: <xmr:IZa6aDLMNHCujZqSlZO7e5v95FDbLrKVOUIDTqFLV2JqOcOXI9KjNfTO6Vyvzp5m7I8op569IJw4HeTtdyuhjVGEbgWKE8t-vueO-3P65YfG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepje
    dttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphht
    thhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrhihsegvmhgsvggtohhsmhdrtg
    homhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnth
    hoohdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphht
    thhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IZa6aC99znyxPBDGjgC_awlsK_sNMC0R5dhD9YtIE7QaGR-z1DIV4Q>
    <xmx:IZa6aCKrHu0dHmEM_HruuAsXwGafVgVjCXHqnqNxfT5ouV10oiKwDA>
    <xmx:IZa6aJFuUld-80xhdv-qtcS4q02VY0im5QlsduiqJKLg561UDJMkkA>
    <xmx:IZa6aOzMxRxVCQGMZMRHetP5nqd637s0QwuNb1AznXPJHqsjW5Y7cQ>
    <xmx:Ipa6aCcMpUrPLOmSi2JAFBU4jmUw5CB66mEUpVxcNZkPZ749jibXxTzH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 03:49:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cab6ee23 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 07:49:49 +0000 (UTC)
Date: Fri, 5 Sep 2025 09:49:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC 1/3] meson: add infrastructure to build internal Rust
 library
Message-ID: <aLqWFBqNranJWSFh@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250904-b4-pks-rust-breaking-change-v1-1-3af1d25e0be9@pks.im>
 <aLoNc5S6PVW8jLu5@fruit.crustytoothpaste.net>
 <xmqqa5397s4i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa5397s4i.fsf@gitster.g>

On Thu, Sep 04, 2025 at 03:46:53PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > I don't see any changes in this series that wire up the Makefile to do
> > the same thing.  Lots of people use the Makefile, or things based on the
> > Makefile like the autotools, so we'll want to make sure this
> > autodetection works there.  For instance, I build with the Makefile, we
> > build with it at work, and Debian builds only with the Makefile.
> 
> Yeah, that is a bit disappointing, but I was not surprised, as that
> is what the cover letter promised to give us ;-)

Yup. This series is currently RFC, so I was first seeking feedback on
it and encourage discussions on the general direction. I mostly did it
for Meson only because it was easier, but if we agree on the direction
of this patch series I'll implement it in our Makefile in subsequent
versions, as well.

> > We also probably need to test this configuration in CI as well.
> >
> >> diff --git a/meson.build b/meson.build
> >> index e8ec0eca165..1c0e98bbc14 100644
> >> --- a/meson.build
> >> +++ b/meson.build
> >> @@ -1702,8 +1702,21 @@ version_def_h = custom_target(
> >>  )
> >>  libgit_sources += version_def_h
> >>  
> >> +libgit_libraries = [ ]
> >> +
> >> +if meson.version().version_compare('>=1.9.0')
> >
> > I think we need a different approach.  Debian 13, which was just
> > released, only supports meson 1.7.0, and you have to use testing or
> > unstable to get 1.9.0.  There are no versions of Ubuntu, released or
> > not, that support meson 1.9.0.
> >
> > If we require this version, practically nobody is going to actually test
> > this case.
> >
> > Our platform support policy implies that we should be requiring nothing
> > greater than meson 0.56.2, which is available in Debian 11 and has LTS
> > support until 2026-08-31.  Ubuntu 22.04 offers 0.61.2.
> 
> Thanks for reminding all of us.

Eli mentioned that this version check shouldn't even be needed, so I can
probably drop it altogether. Will have a look.

Patrick
