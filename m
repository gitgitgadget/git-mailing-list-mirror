Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01B2F657C
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058850; cv=none; b=XeaspuKycrx1qPWypfI2glTFUBgFHH4XT0Lpdf/MMCmOHF2awkBwLwI5wIMtqkaHc/FU09BUFZVJ0GWr2bd6N91PMVBrpQqusOfSCJ6XzCLw3ZcDmIK1G2dCGm9n5YGqBL4YU5/iCLCSRKk1TAqIgPjw1X1qfuOO6vRVBYfmKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058850; c=relaxed/simple;
	bh=DorrbYC7lmI63+THW5M56AshEqbmLTtjuV1dMPIEnD4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0FikesfjX+vVqMMKeGke1otmnBdZJ92H9r+/wgKNFzTN092m2wkhX50VhiWIi7u8d3UxtSpyFP5BRS26sEoL9CA1TTQ/KdD/SdwbbzJyPtZESn7NHzzzbhINbPkKMojqte1ruYWXBI5EWcNcvkqv2gcPtGLikEbwS75f4t2qlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=axBr03su; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZAi4MxS7; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="axBr03su";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZAi4MxS7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5022E7A0467;
	Fri,  5 Sep 2025 03:54:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 05 Sep 2025 03:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757058847; x=1757145247; bh=bkSsGYNqxY
	CHkERvSRTVNdtTcrg2au+82Aa+FjVbdk4=; b=axBr03suiN82UEpgIhiLftYQCg
	5Gl5DMIkibLQoUSfdprBg1LP5MZd1ef+42MS9FKN0LB3B2cmfjdNlHXwGDmYAf5M
	yP53WAdQXswFdL4Yz5NT6Lz61zppeiofnlzEZ30JhrZMUviqB4FYMOWLdZHm6WnS
	0BjATwz/eG8eBzRZ1J3A3PhA64UANdahJYaQCZu2kkgAAFoWFYvhZA2K2jAjHsIf
	pCP3ScP6pZMbpEeDKOTrM7Tr+jyRofOGEUJqespxVJthQUxzp4/tK+qo/fy0PQ7r
	mEG6pvuqxwTfPGxfha3nveeVxWHFDhFxZ23uvRzmOqZ2kW2vKVy2T4qk+aPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757058847; x=1757145247; bh=bkSsGYNqxYCHkERvSRTVNdtTcrg2au+82Aa
	+FjVbdk4=; b=ZAi4MxS7jhYNLtLDT3W5lZq/i9zQSuWIpSwt30SmoGRypbXFPpm
	aOz1/2yzTwztfuw2FR98ykdPrvv8Ca2YByy6MuXTKczG8PqOYAhy25VlaJ3KOiV7
	8kAQYXOffyPCEUH22honnTxgvBhiT3j0SPyrA9Cj4GxJcWRqrqvSLP0ZbuzDgEW2
	4GE2uO7oDMT7KJ4XgR3VfWAOmK3HbOmyccWFZRICneN9T/vWSHjTVcR7fYb0uKwn
	BEsUmXY52/R691CBhacLEWaPSN2lFEvUpMY5qiiultX0G2bCFket26NT2FlhzNiR
	mWzbuFna35Vj2aNvHWTEGG3qKfklYzTaY1g==
X-ME-Sender: <xms:Hpe6aFafte2yGjYXMCgqwDwmVUtfQ6gH98Y5brbekPjf8g-BhOa6YA>
    <xme:Hpe6aMisfx2YhWTwr9RW3KFlZhNSk_U78R1-Pq1g_sAAm37NGxiOxsaPG1n4V69IF
    xhFbm_oDhTUV0uvyg>
X-ME-Received: <xmr:Hpe6aPZVLYQkT68PfE-e5Vox1GSdIB29NitOuvjYcGs3jnvi71CshWvM_JQmLqkAXFTz1fDFw9ny6blsVvFpnclyMFY6cUb9szv4s50ptiym>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehke
    effeeggedvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    tghonhhtrggttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthih
    thhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdr
    ohhrghdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrhihsegvmh
    gsvggtohhsmhdrtghomhdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:Hpe6aKM9F0IW0i91g--fTglKv_7YDfRMtJ38sSPO1vwSjpIuLTHenQ>
    <xmx:Hpe6aIbU8EzaMHSU_adxIJjHpilQfy-aoPvi6vhlxLYIO4x07xWCDw>
    <xmx:Hpe6aCXmLdVqG_ZIwGme-FnadQ4DCDY16bee2XUAdI0BaJmWepTDCQ>
    <xmx:Hpe6aPCuFnV97zA3JjSK4gMgqU1xg_euqoW3qsoi0LdQE7L1nBLbbA>
    <xmx:H5e6aBu-_xqO5iRL-oH38ZCEPaN4p14bZ4fL6lbuGMc1KGg5yAPVZAbb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 03:54:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 743e643d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 07:54:03 +0000 (UTC)
Date: Fri, 5 Sep 2025 09:54:00 +0200
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
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint"
 subsystem
Message-ID: <aLqXGP5K6so13rCc@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
 <aLoUuxfQmxHdqiYe@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLoUuxfQmxHdqiYe@fruit.crustytoothpaste.net>

On Thu, Sep 04, 2025 at 10:37:47PM +0000, brian m. carlson wrote:
> On 2025-09-04 at 14:26:44, Patrick Steinhardt wrote:
> > diff --git a/meson.build b/meson.build
> > index 1c0e98bbc14..b52a68b0bb6 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1713,6 +1712,10 @@ rust_option = get_option('rust').disable_auto_if(not rust_available)
> >  
> >  if rust_option.allowed() and meson.version().version_compare('>=1.9.0')
> >    subdir('src')
> > +else
> > +  libgit_sources += [
> > +    'varint.c',
> > +  ]
> >  endif
> 
> Can we also add a #define constant when building?  For instance, if I'm
> writing interop code in Rust, I'll need to be able to do something like
> this:
> 
>     int do_foobar()
>     {
>     #ifdef RUST
>       /* Call some code */
>     #else
>       die(_("interoperability not supported"));
>     #endif
>     }

Sure, that sounds like a useful addition. I can add it to the next
version already if you want to, or we can add it at a later point once
it becomes needed.

Patrick
