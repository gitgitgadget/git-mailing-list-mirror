Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A2231A3B
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313666; cv=none; b=uO4rFs7hapK70bh9gFq6/mnj4SlksMMFQkbhdVhOqWlR5tSO30EEek5FMN1KPFr8cGZkjTkM3iO9UmRJPQQ3+ge5dx6Wwlyb1Kxwpv2Zc9wvaps45QERCWWeWHyIOU6V1i7rLeANN0uJN/lwbuRty35svWjsyuHoK7huSGJ/TgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313666; c=relaxed/simple;
	bh=WRvYOX49se7A740gwa/cZFeCbc8PACEj/aqWQoFMzYA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUhktKmnTdVfKnr2/OvqfdaLjRjyUoTMkcK9/O1rfJoZv18dcPgv02ee0eO/KK9kCgwPE3tIkwh/bPydCTDzqe4DlD1chYiJuKPZ3rlFZyd2oB5WmXEVV9ggtCGQXb4+jdg+aWjFtjCkLf4VIWxe8eQ+KUqvF69I5k4FDaIqApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OnYmoUjL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BohfXvOr; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OnYmoUjL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BohfXvOr"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 05D717A0128;
	Mon,  8 Sep 2025 02:41:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 08 Sep 2025 02:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757313661;
	 x=1757400061; bh=fEo7F4WhQwZHneb2RmDIBHN85pXqQnjwM7P2iCYHPgU=; b=
	OnYmoUjLlXF2cgqzDESQp7y4KL1IcjstJrVfmkV4gjq61KRuMaDNtxfT2PdFmDou
	bBZXxQkO+gmXAZYbWJC0tDeay/0JJjsn/QMrSnLrCtnAN6WDyr0EqQQE9BiSQU94
	WfrfyTlGXn4BU9JINpRNnEOmttPl6fG6a+jwpkxkHYATLnuFRaxVyDWCbuB7BA7A
	5cB//4obzQZeHH/o1HYEcwGnNIrBpuLgjkXoDggiRyD0P1xeLxkYPub3DzJAdk4R
	Crq/LswWqbOgkDrYDfIuLbJ81oHTmrN92zDmUWyq5syLmG2eNLWVtKBgzDcKBb54
	dzkGgZHVtXeczta6wJAZ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757313661; x=1757400061; bh=f
	Eo7F4WhQwZHneb2RmDIBHN85pXqQnjwM7P2iCYHPgU=; b=BohfXvOr2/BZvkTWN
	sAkpLDP3aSAl6elTQpMb5H9AIFD2X/LnNozDKbrE1OrZYBsqZS3bFs4ULpmIxMLe
	V+E2D6DVLdIn/IV5j5IF14ivityOSWxWrjwLG2PN90i2fznhLrjSwmdms8enB2Wj
	eF6JnlZgwPaYPFOPFeP1zMbK7xiYtJkVNN3tcl17CWpklb8lYJ/x9tQWtlosXkTY
	UwYo+3xD9qxT7DWDi+1rbgMQTkG6rDzLu+3wTYiypQrbUk9jrbQMpLENxl3n79No
	pZl8HbFR2JvjHWylGYphYT02KzI3HjW3xgX0xhw9OVJa0uG9FFHmXIG+DumtlGa0
	fQPog==
X-ME-Sender: <xms:fXq-aOm7l9rnDXKTxf3HhQHhtfavqkhIyrjKhOspd66NJHc53x8Pfw>
    <xme:fXq-aF_p9fBjiprgNWotdwV2f9OFqk8rN2GHX0XW2nc3XJVO25KaJfAqDnCjR4uws
    N-CvtKepVbQK33FKQ>
X-ME-Received: <xmr:fXq-aEHMKJWVjkMJy_V-sJ6Hs4w5MX2sVj6mBkpiomna_xALV7OHDQaXrfaLgu20EO7W5FdnDCKCEDA4997JqTL5aEMxZ2ke4xnOf2EMDBwBmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    elheffgfegieeufeehieethfegveejvddvjedtueduvedvvddtkedtgfegjeffkeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtoh
    hmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhif
    rghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fXq-aJL9k4CWY2Ftuw8dc0C-sdIyMbW1HWtlFTzbRI51H5mB73_fsA>
    <xmx:fXq-aElH0y73plqI-BdUXQLVh47GvulR9lYcBcKx_nxSnSbPCJYoXQ>
    <xmx:fXq-aCz1d1ucRlq9buvKq4BNWYKdL6rFUTMNM_CXMutcYcJa_KbXaQ>
    <xmx:fXq-aOtekxj1N4c6YklMqY9Gyv_2Wz6SYlJoj5Pch4pB38q7Mn2jYA>
    <xmx:fXq-aCoA8JZrUh6Eg_4AYPmwQEzvGi87bGcJY9kW_yterwp074_USZjV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:40:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6ffc9ca6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:40:59 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:40:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 2/7] Makefile: introduce infrastructure to build
 internal Rust library
Message-ID: <aL56eP7v-qfVKxu2@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-2-6939cbf4a0b8@pks.im>
 <aLtGYlTXktuzxD0q@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLtGYlTXktuzxD0q@fruit.crustytoothpaste.net>

On Fri, Sep 05, 2025 at 08:21:54PM +0000, brian m. carlson wrote:
> On 2025-09-05 at 11:50:58, Patrick Steinhardt wrote:
> > diff --git a/Makefile b/Makefile
> > index 555b7f4dc3..e7b3c8e57b 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1411,6 +1428,19 @@ BASIC_LDFLAGS =
> >  ARFLAGS = rcs
> >  PTHREAD_CFLAGS =
> >  
> > +# Rust flags
> > +CARGO_ARGS =
> > +ifndef V
> > +CARGO_ARGS += --quiet
> > +endif
> > +ifndef DEBUG
> > +CARGO_ARGS += --release
> > +endif
> > +
> > +ifdef WITH_RUST
> > +BASIC_CFLAGS += -DWITH_RUST
> > +endif
> 
> …but unfortunately, all of this code is above the `-include config.mak`
> line, so if I set `WITH_RUST=1` in `config.mak`, it doesn't work: no
> `target` directory is created and `git version --build-options` says
> Rust isn't enabled.  (It does work if I specify `WITH_RUST=1` on the
> command line, though.)
> 
> Might it be a better idea to place this with the conditional code
> farther down so it's properly honoured when configured in `config.mak`
> and friends?

Oops, good catch!

Patrick
