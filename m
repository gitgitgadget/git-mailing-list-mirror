Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D752FDC52
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936486; cv=none; b=ZH5RZ/eVrsJrfi6sLBO65kt7yHOa29AOrNjtBl4hGE/+YEOBtaWK2Wf+Yi3xKqvB6PfZmZiN6bwXOvxR/E5Jp50sJhpxDVYn5d05TNB/IPC2fu8Kl+Ihjbj27eFXuZYqHusTwMEBwTlJ7B3ppQP9x3/R1ktQE8JtKH2DEyQd96s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936486; c=relaxed/simple;
	bh=MfLgQ5eU7T8h/GORQax22b4z+HOWMSGoUp7VRL9YpME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4mRXVFg8GiKaqAcnQ6kb66gBoCP2fzYzzB/cIIzIyIX57zmDvX4rfmbJry+6YB0mCtdVMVTfbQ+8a680i3GZgaePZnz/3wkVUosRnkkmPFK1SgmXTuUdO/6sIxacvJnn7AsMynbK8lZJQLspm7ZHltb6o1hBCwmPne8eY2qv8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qg7kfQnC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PaZxTYTl; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qg7kfQnC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PaZxTYTl"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 2AF24EC02E5;
	Mon, 15 Sep 2025 07:41:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 15 Sep 2025 07:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757936484;
	 x=1758022884; bh=WPY0BNboZZu1+talGKjxXIvAgzCp2akYgCqqY1/mmLg=; b=
	Qg7kfQnCzrj30OSG8fc6KmCw8hg7t3n30k9XvjZebH8YTkQHrgcqVk4XuQvvvcLP
	wXINtaL98iWNtK7Is4B0DtG/03/9k5FBTbqzv1SjkUV/aSEtfZrx3HutflhyoPRP
	TeV3HAtWOZxzWpETXATKfci9+XEhAjI5rzqqbM5x/g4a9OshpZPQeXVi6gsdvu84
	UhOlks9yMksZ5JTYPsIRKN6mWsAmCOaCzhL3JhlO2jAfIERcWwdPbaiZPWIvgVXi
	ZqwTNAw53+YQ4tNdf5xZPwtALK94Vwyl2wyLnP5Zqi+VvJcxpG3rB4IdJERGu53Y
	0OU2Z91E288vLXXEe4xXPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757936484; x=
	1758022884; bh=WPY0BNboZZu1+talGKjxXIvAgzCp2akYgCqqY1/mmLg=; b=P
	aZxTYTlZahUk4ReZty6T675u8utRtX48aA+056ZSFLN/cGtf0Zvb5Mq2mXG0izDQ
	PWQFpwfHpUrccKbJehuC0hEWDotI3x4DGOSj/H6SUClZKnHpf7UxwO07LmuDFbLe
	6ieT07ZKEZkz6nlhVgr5qtGY28A06xuh0L4aUon3WaAGRY5Ews/LTnKn8kHPNIOo
	Fg60BK5PrLSAGjw2F8V+srmpa2Sui2eGRcJHRYvM5hB3wCM+CHyAsmkOETZQHRQ7
	WolyH0dnDy1D82WOKmWD0eE6dI8zeoocXCmFi+uIOq0I9VNKSbtccps4bqmAx1vr
	tISfBMtKOzQSOqjXlz5AQ==
X-ME-Sender: <xms:Y_vHaCF8SRnhYOAVnp2NeOsKwopMEW0akQbOm8m8lKXpHoNGe4Tl1Q>
    <xme:Y_vHaN6NJURKmphAryyaBd1zy8RWiMjcqU6I8N887i2Hb98yaTaXdYhI6tf7lvIaH
    UvbMz26vOh1bsR07Q>
X-ME-Received: <xmr:Y_vHaIvpOudJuqKEh8cxR-EaVqWsSsNlQFgJOHE3OE8vERjcwEAJjEaD0Te59T6sAx72561e-B0G-gTMQe2X_hFOWuypk2-ds1nUtN1ASnWaew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehs
    iigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZPvHaO6HTeUEzkM5GJRGPKWB4IVMV-odTZisg8XRpQs6_JWPOiM1qw>
    <xmx:ZPvHaDUCIUwktybTSfe6j3x1k29B6doaRluwrEQZIMg3fZWKUj8E5g>
    <xmx:ZPvHaA-i0JgjoZFDkHPdVAO33bo_DSgRnp3eZe6XOl0ceaR5DPRHmQ>
    <xmx:ZPvHaPlgbwVFiZkQbznJu2pyfdXUa7KN50cL6wEA1PrOYQxQ_vyRig>
    <xmx:ZPvHaBVTToJ_fjZBhWWooBZIkzru22LVjVnerTAFubxcelAFgttTG8iq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 07:41:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a276c0b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 11:41:21 +0000 (UTC)
Date: Mon, 15 Sep 2025 13:41:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t1300: write test expectations in the test's body
Message-ID: <aMf7XvXasOiUAaxo@pks.im>
References: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
 <20250911-pks-config-color-v1-1-3a7c79df65b1@pks.im>
 <94eb9052-18e1-4565-8f33-42fdf136e2a4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94eb9052-18e1-4565-8f33-42fdf136e2a4@app.fastmail.com>

On Thu, Sep 11, 2025 at 06:50:29PM +0200, Kristoffer Haugsbakk wrote:
> On Thu, Sep 11, 2025, at 15:24, Patrick Steinhardt wrote:
> > There are a bunch of tests in t1300 where we write the test expectation
> > handed over to `test_cmp ()` outside of the test body. This does not
> > match our modern test style, and there isn't really a reason why this
> > would need to happen outside of the test bodies.
> >
> > Convert those to instead do so as part of the test itself.
> >
> > Note that there are two exceptions that we don't convert. In both of
> > these cases the expectation is reused across multiple tests, and thus a
> > conversion where we'd move that into the first test that uses the
> > expectation would be invalid. Those are simply left as-is for now.
> 
> This is just a suggestion (which everything is):
> 
>     Note that there are two exceptions that we leave as-is for now since
>     they are reused across tests.

Yup, that reads way better.

> > index f856821839..bde9bda234 100755
> > --- a/t/t1300-config.sh
> > +++ b/t/t1300-config.sh
> > @@ -134,38 +134,39 @@ test_expect_success 'clear default config' '
> >  	rm -f .git/config
> >  '
> >
> > -cat > expect << EOF > +test_expect_success 'initial' '
> > +	cat >expect <<EOF &&
> >  [section]
> >  	penguin = little blue
> >  EOF
> > -test_expect_success 'initial' '
> 
> Ok.  Correct.  But I see that you are also overall doing a sort of
> normalization.
> 
> • Remove-tabs if it makes sense
> • No variable expansion if it makes sense
> 
> And here `<<\EOF` would work too.  Or is that worse style?
> 
> I will keep mentioning this throughout the rest.

No, it's not. I already did it sometimes, but not consistently. I'll
mention this in the commit message and adapt as possible.

> > @@ -214,7 +213,9 @@ test_expect_success 'Prohibited LF in comment' '
> >  	test_must_fail git config ${mode_set} --comment="a${LF}b" section.k v
> >  '
> >
> > -test_expect_success 'non-match result' 'test_cmp expect .git/config'
> > +test_expect_success 'non-match result' '
> > +	test_cmp expect .git/config
> > +'
> 
> Okay.  You normalize the one line to
> 
>     test_expect_success <name> '
>          <body>
>     '
> 
> The same kind of change done in the next patch `t1300: small
> style fixups`.

True, will move into the next patch.

Thanks for going through all of these!

Patrick
