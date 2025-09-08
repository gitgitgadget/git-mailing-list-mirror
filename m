Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DF296BC1
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313743; cv=none; b=gny+/uTM/BlGSj2+wjNkNO8CM5UZBD8I4G1lUElvxD85vZMvocCRerrDqwX9/C2nSzFgWrWQBY9HLWlffPqdDi0ATGb829J6iRPCWfDtjsd0pa9XkAzAyVR8ByoGKkqFlJR5vnX08Bivpq6garekB1Y7dlVBG1YKkQsvwNJ0m/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313743; c=relaxed/simple;
	bh=QeZHplEC58/hYNIBjT7D4z29BnCX6Hj1yMZahgbvryg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgxazoyhktR107rROo9hdyREm+czgIsmlmPCuEEuJ7/TJDg+yr+JizQTmOpZfurpvsnrEoD4rkty2G0S/KtumrEkL6Ejpqvunf72XiFlKA9bcXcGseM2LOrhYx+3vN2eBPxQxKc6uIwvrQOYoSK+F9LEvMZkfhwWPcErKTJRj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CiK8Sw8j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VtdVkyWb; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CiK8Sw8j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VtdVkyWb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 43D767A0044;
	Mon,  8 Sep 2025 02:42:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 02:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757313739;
	 x=1757400139; bh=YL+Ttz4n0yroyBg1aDxygO+RUtCiV162grMax+wTK10=; b=
	CiK8Sw8jA1SU4N9Pi2BpDeUbrSiZICKkaJ156Bno9yfA2SubFL2QIE+Uwl7Pln3e
	dgbiDEYQMz5pd97vBpXvMU1/LQlAj8tXyyvUjatOEmF5zEQTXiXM3DTTjcJ0Ba+z
	si3dsBLep3bSuVDjNNLzEZdmbr+c0M5VnDUxHSSRKDdQnJGXvZOIk2vlGB2uLrl2
	0Ycbc4wF9oTrsj3RMzCCB7iKR9Iah7ZPbv6WJ4mnEF7sE7JfpvroiT8XWbec3Qi8
	s5xgrsvrkulJyU6JcSokALZBI+z/8Y7161+Y0gcaUz6iYfwdz+nHXE2FLUh98E1Y
	GCqwjUV6lUdfY94zQGUT7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757313739; x=
	1757400139; bh=YL+Ttz4n0yroyBg1aDxygO+RUtCiV162grMax+wTK10=; b=V
	tdVkyWbtHnb4V7MprpCu9vnC+ECqTZRRCvplr0JI+z7xaF+XJ7bjjd2N4ZP00fU6
	afGxoNuhEOkprPKW5b3K6/RfQKcvvBbKHyZR3kvwZMQo408VX2uN8kNFJvU9Geki
	kyeG0YHMH/pDK3wMFkRIDYmuPtvMX977zus+QZ3GY36siR96vxUJPbiW4hsUDS75
	kO5b356efQO/JNVHDpFp3MQM+Jri6SMNKBJcHxRoZ3g7ZUm+GddwDHjZFWpCH1cl
	1GzUAVto63+aipn0w6W+V6TKgaZ/7QEVI16hZOh/Iq6MF+Yy7fs50TxwLJ+0uWRm
	rJPHjIUXMvMmznBvKXeDg==
X-ME-Sender: <xms:ynq-aIi6C1YyZI1I3ZNFHpXhxWLJhNsRBwvHhYOzqyTQySHL4O7CXw>
    <xme:ynq-aBItsFR8OUfAGimrBAdxkGNgP83xRb4dMwe0ZH0kpB0rGdXcnGeX73uBkql-h
    s-GG2tp9lgL7THdew>
X-ME-Received: <xmr:ynq-aHhxTgebFIGLIsM5i2v0mlZgHO7rOfLY3bIlKBEE8v-dZR0ujt8cWdqmvWmhkNucEQ5X0edpsShW2CvHrN8RXgoSaz70O2FWGqvubR-uTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegvshgthhifrghrthiisehg
    vghnthhoohdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhi
    shdrmhgvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvght
X-ME-Proxy: <xmx:ynq-aP2_vu0UJRpLEhWcRb-82MBH2j5yKFYg6PwZAiK3tk6MDwH6ig>
    <xmx:ynq-aNgwWBkp-5KzYzfNdQXrV-1fFUUOBYxissW_C9X0MwudVWTXdA>
    <xmx:ynq-aA_hufG_gNi5QwNlor6jd1LRJCzS6vZr3FpCrIggwCOJ9ejBpg>
    <xmx:ynq-aJLA1ptk2c79w6oD-wNzE5Iux9mXWZKlkcZnVojoyuYk5OwUzQ>
    <xmx:y3q-aDX1W5q3wTYZrAEdAhqskb0YHJva03AVMwhbk8ohZUwD-1HCJ7CP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:42:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cac77932 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:42:16 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:42:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 1/7] meson: add infrastructure to build internal
 Rust library
Message-ID: <aL56xRcJTCU2wttG@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-1-6939cbf4a0b8@pks.im>
 <CABPp-BGF9Ds=9bLKbWFEuatGmGycemwTMiyez_s3XMJR=M6xQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGF9Ds=9bLKbWFEuatGmGycemwTMiyez_s3XMJR=M6xQw@mail.gmail.com>

On Sat, Sep 06, 2025 at 09:54:18PM -0700, Elijah Newren wrote:
> On Fri, Sep 5, 2025 at 4:51 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Add the infrastructure into Meson to build an internal Rust library.
> > Building the Rust parts of Git are for now entirely optional, as they
> > are mostly intended as a test balloon for both Git developers, but also
> > for distributors of Git. So for now, they may contain:
> >
> >   - New features that are not mission critical to Git and that users can
> >     easily live without.
> >
> >   - Alternative implementations of small subsystems.
> >
> > If these test balloons are successful, we will eventually make Rust a
> > mandatory dependency for our build process in Git 3.0.
> 
> Okay.
> 
> > The availability of a Rust toolchain will be auto-detected by Meson at
> > setup time. This behaviour can be tweaked via the `-Drust=` feature
> > toggle.
> 
> This goes against what you said above, because it turns it into
> something other than a test balloon.  As I've said elsewhere, I don't
> think this part is helpful; it reduces the amount of notice that
> distributors and platforms have about our intent to make Rust
> mandatory.

See the BreakingChanges document later in this series, which talks about
this. Makes me wonder whether I should reverse the order of patches so
that the BreakingChanges are more prominent.

> > diff --git a/src/meson.build b/src/meson.build
> > new file mode 100644
> > index 00000000000..eb752651d35
> > --- /dev/null
> > +++ b/src/meson.build
> > @@ -0,0 +1,15 @@
> > +libgit_rs = static_library('git_rs',
> > +  sources: [
> > +    'lib.rs',
> > +  ],
> > +  rust_crate_type: 'staticlib',
> > +)
> > +libgit_libraries += libgit_rs
> > +
> > +# The 'rust' module was only introduced in Meson 1.0. Furthermore, the module
> > +# does not seem to work on macOS as expected right now. As such, we only
> > +# conditionally enable tests.
> > +if meson.version().version_compare('>=1.0.0') and host_machine.system() != 'darwin'
> > +  rustmod = import('rust')
> > +  rustmod.test('rust', libgit_rs)
> > +endif
> 
> Would it make sense to invoke 'cargo test' as one step of 'meson test'
> on mac as an alternative, so that mac users also can run the tests?

Maybe. I'll revisit the Meson code anyway to figure out how to get Cargo
support in there natively.

Patrick
