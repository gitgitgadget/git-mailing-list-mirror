Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB041E522
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731656572; cv=none; b=a/GfBO5dzi7FEzGtPs5tGga79OEABwY+tLvxpyWGezY6fpI0Mqw2Lv/R+5wAaT7dDY0rm1WLNvePGexwfGVqu1NDLglt+6c3EjrrIQ4iWH7TqedsHY4PKamJCQCmuhjQi0X1SHCei+Q5X2+KKwe/HbVzq4pJOf7tttnnKDlTWMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731656572; c=relaxed/simple;
	bh=l4PkM2KetJlLwHgM2m8/ThyylEWrSaoFg0wF1u6XoIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPKktjNu6a6P4IVIKpy/+URELVtDyYcnUdYFhvm7WTIQOBt7HfK79nTnzQqy6Scz2wIXivEd1BKs2F61Ovptf53f65stN50IvctFBk5O3SwWlMvki7Px5WGmSSgHBIx12mdUydNhDYD6KEHRtT6Roq57i982Dx+mnmnzopKEI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2N0SRfzY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OttIIDvq; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2N0SRfzY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OttIIDvq"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5C9C1140118;
	Fri, 15 Nov 2024 02:42:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 15 Nov 2024 02:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731656569; x=1731742969; bh=vXml83k9oB
	Lx0IhZM3mtVq/w52gAHqzj/lmjffwXcDc=; b=2N0SRfzYrNlT+/px4T5R6grALh
	inSoVBFLRZ6iYgNCWO5p6UTFeRS0KK7Z67oMwoxcbx+gEJGmHN2MaJ1gO8ujUUbF
	6EA+yV0gvXtyv0jf/dqjhUJ/cbdfcOICPM4NPPTZ35V7h7wETzSJo5eNl55imQLD
	jP636kD8rTY9BpuveRTDn3kij4vgsxd8ElW9duptU/JOQ2HdgHw231oVDok7ht+x
	kNADKI6i37HRCHTrMiPON46ouaUj7G/YzGIkk5RBk1qn1/IwF+tl6W38ZFZ/dQrO
	8OZwy2lzh8/XNLCFBhIjUHJ/B5fBWQ2vxrWG10VuyCDRSPlj4UnaOEi7G4kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731656569; x=1731742969; bh=vXml83k9oBLx0IhZM3mtVq/w52gAHqzj/lm
	jffwXcDc=; b=OttIIDvqGQSECSMSEnWdUzpraSFnUvS9Jxgka5R3EXjFoLMb9VU
	NXDeLvlIOSDM9WWwjnCiR9i/LJVPFe1mTsgd8EsvJ5g57KIowRc8OGKn1hhIsZIH
	5/jfFZfHI0DraOTV2IzBEZleYNCUNcVNbaMZEeOcDZUeH3k7K5PbdfWRRTaaEclw
	XJNkjv955dibElM2HZJnerSKCTe4CHAuEU8v43UxAAALkkaCIRn8HbsO+ocjaJ67
	fF+hpTy/zWORrSoxPf+7WTnZSTIf195e1yyg9WCr3CVzbp8YUPtF03J3oS8grRYr
	Y2+GqAzN7DWUeRH90uQRA0CYWQOeoQuR8LA==
X-ME-Sender: <xms:efs2Z3biYNj3vaq0aJWC7-UecpTTsOHFHZwm6eHVOK9fg-MzjpPuuQ>
    <xme:efs2Z2aMdI3GdSADh0nqCKHCY9wgK_lku-dB_HrhYZiVLfxXaw02W0p8BH7DDC9y1
    Jkz6HVVrleEJlhezQ>
X-ME-Received: <xmr:efs2Z5_DK8rTE8O6fhKOgupieaOeFZ1-9f5_14I-0sGEHtESYHeicQm8LafhpUqxmyV9jou8BJtTZn_uhNh4mY1H2-l69qg67u8G-EwFEKQnWEek8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfhhfjhhlrggsohesghhmrghilhdrtghomhdprhgtph
    htthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:efs2Z9qQ2uNWMIKO3rwXpGxXyGmUO2qbXv5_lPUENC3iUn87J6k1UQ>
    <xmx:efs2ZypNbzPPlqrBjDwA2qV86-uyP6hOWbEDoJ4kZHRl-QMXikvJLw>
    <xmx:efs2ZzQzVvU8qxuyQaY6JGUoJBU9kwtq4hWQVCTt5WAnZhMk5W6TWg>
    <xmx:efs2Z6oWQqZ1tUodAFSWoLibF80uxn4-FXN0ChlJTmK0OVFmnjN6GA>
    <xmx:efs2Z7kQHKyH3CMGSmXnmYNgrTteuo97Xyy9IKcGM1pWUpYMv4BCA9ka>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:42:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b6105b6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:42:05 +0000 (UTC)
Date: Fri, 15 Nov 2024 08:42:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	=?utf-8?B?44G144GY44KS?= <ffjlabo@gmail.com>, git@vger.kernel.org
Subject: Re: Trailers Containing Underscore or Dot Characters
Message-ID: <Zzb7aI2C2uh_nwuc@pks.im>
References: <CABpqQ_u4GG28L9KGX+HXiOv2AVAL7sckRBN4a99pCyeaQS+n_w@mail.gmail.com>
 <CAP8UFD0_+=5xmw6y5qiO22KMZhExLyZ=5HRjYphLD66vt0LLNg@mail.gmail.com>
 <xmqqa5e2ahqf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa5e2ahqf.fsf@gitster.g>

On Thu, Nov 14, 2024 at 07:31:20AM +0900, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
> >> Date:   Wed Nov 13 08:28:19 2024 +0300
> >>     Test
> >>     test_hoge: fuga:
> >>     test.hoge: fuga:
> >>     test-hoge: fuga
> >> ```
> >>
> >> What's different between what you expected and what actually happened?
> >>
> >> The one for `--trailer "test-hoge: fuga"` is finished with nothing.
> >> But The others for ones which have "_" or "." are finished with ":".
> >
> > Yeah, that's because '-' is allowed in trailer keys while '_' and '.' are not.
> 
> Thanks for responding.
> 
> I did not offhand recall seeing anywhere in our documentation set
> that defines what a valid trailer key looks like, so I went and read
> the interpret-trailers manual page and did not find any.  For
> example, is this a valid trailer line, even if we know '-' is
> "allowed in trailer keys"?
> 
> 	-test: fuga
> 
> Is this a valid trailer line, when your configuration adds '-' to
> the set of separator characters?
> 
> 	test- fuga
> 
> We do not even have an entry in the glossary for "trailer", and that
> probably is the first thing we need to fix.

The second thing we should be fixing is that git-interpret-trailers(1)
allows us to add invalid trailers:

    $ touch file
    $ git interpret-trailers --in-place file --trailer 'Valid-trailer: bar'
    $ git interpret-trailers --parse file
    Valid-trailer: bar
    $ git interpret-trailers --in-place file --trailer 'Invalid_trailer: bar'
    $ git interpret-trailers --parse file
    $ cat file

    Valid-trailer: bar
    Invalid_trailer: bar:

After the second invocation of git-interpret-trailers(1) it is unable to
find any trailers anymore due to the bogus format of the second trailer
line.

Patrick
