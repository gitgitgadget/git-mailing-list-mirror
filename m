Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058B130A7D
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431933; cv=none; b=Ft0nN+UrRjmv6vjkZn5TdfGaFdNGjYaFp3voaSJpZV1dYGWnJGROCxB5ruOHfcjaUuJWhGJpp7AauijveZ42pP0EcwnuztC2crpVY3e95pxuu4yETiqcQsYiQbysmDcR+ZrTc6kqIHjcVTGBkR4b2aiaIRX0CvVnz9MpzjkbX8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431933; c=relaxed/simple;
	bh=hQpgCYSp+8M/10Z9I2vF2yGrZNh4qWYdpPJ+UZvgc3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON5O5zJ28TUjUhQ5L0NIDh8eI6+Y+MhQnDNWaQdXMITZxN7KQVk3KOsz2YSd/5U8iLX5CvP16vk8mXUaJLCwh19rnqWD5+oKJU6x72HsfOShv2Fq/3MWKHv0YOnXbcWbBkyLhbSvbPywACqab/j0fiTp6hBpsB39nocK1UGQTKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n4Hy+myo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ljI6G02z; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n4Hy+myo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ljI6G02z"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56CA71140223;
	Wed,  4 Sep 2024 02:38:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 04 Sep 2024 02:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725431931;
	 x=1725518331; bh=ZQxgG4rmBLpdAkjzZdVMbNIE64vDxakZkWQe422ZllE=; b=
	n4Hy+myoevjnk1/lsOcFYOxv7L3NwopEFnHnu9Ko1INkHJkWO38KpCJyfSeHNeQX
	Q1iMVBx24SPMQhV7hRstsVczesj03nkgP3nj24VCKOu4GAC0Atqt13S5vlFk5qKA
	ZIuRKtfdOqEBTYS5p71cVGxvEWgzdlj73YLKHlJ7GnD+AcvpcghVQzIk93ZbVwVy
	w0QxDLzNR1zeLwEdSmKvUvC0JiQro8ep5t8XDMnOzjTByAswafvzt0cL2KQq575a
	TrbsOV5KlJW6LMaO4HNXNTR7dzNxTtU3uV5JdNyNlqhmCnxvM1S0B4USjvndt0V1
	/8gu8vdfpiG4IzcVB61k+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725431931; x=
	1725518331; bh=ZQxgG4rmBLpdAkjzZdVMbNIE64vDxakZkWQe422ZllE=; b=l
	jI6G02zhMK5dF0Ic33lUT0WICVY/U8vaMEhBIhcORaJPosNuOoZQNdrBPAvUSJ1g
	DPt2n7EqVaLgn1lxer99SUyngPePzYnPxT7glgqmxTIXdPyMZgkL3sKbDArY5o3E
	bMDS8VIREUOxYi33dqDdRRBA3NYUOLFaMLIPe6H/x3GGgaY2eKC61PZoxSqmut90
	nh1GwOCLmiakC3tl3shNKBCOu8x8tia1+8rr++FqyVxOK9c8bcqp2yogcx2a0io6
	4ZJHbDMibzSGSAMOcQ0tEnoYmH5doBeAGN43PbQYcEDKM1u3n5o1Lwv6Ix01Rzo+
	EgdP817holMZ5IkvGObYw==
X-ME-Sender: <xms:ewDYZmmP7Wcgq5jUD_0tHy31bpVFJ04DtNqiEQo3PzB8fFverzcrDw>
    <xme:ewDYZt2BwDnY67GMEYZt8vDhg9suQOBv7IlVdrprYn_1BhrgC_AWk35LU4v3g543d
    ka8bJC0jEW_ikewrw>
X-ME-Received: <xmr:ewDYZkoxwODEMpjVgGmu48twHEEyKsdy1sHO6uHaX_DKh1OUoSwVcDgYpJY5pGaJps2QeMeYjcjMZWYIXrXOIkbYSXcbaRA3gRTboyukRO8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlh
    hmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhh
    ohhmshhonhdrtghomhdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgt
    phhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:ewDYZqnkOD8ndzRPaoMiThgD07KqW9lk5nZyhBp4e4pqPAAkr9E45g>
    <xmx:ewDYZk32uJ61V8DU5nbiUVy187xpnOb_HxqZAUX3hIkMexk6-GqEng>
    <xmx:ewDYZhup7BcWLLvwOHKO01f04GyHWxf6oCmsd-JuADqdnYuPfeozuA>
    <xmx:ewDYZgXUM5E_ZB3UnB68awggXzrkllgeweCqWzEBwMFvjykKHFn4mQ>
    <xmx:ewDYZtu1Lcr-1-4QDSB1RFqGJbcbF1_LJ9_kdRgxNuFchfndwKj3igUU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 02:38:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 478b5f19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 06:38:40 +0000 (UTC)
Date: Wed, 4 Sep 2024 08:38:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 02/14] t: import the clar unit testing framework
Message-ID: <ZtgAcOfOjVDyoI4r@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
 <55a9b46e65f2072ca7994b042dfe24d1c153c334.1725349234.git.ps@pks.im>
 <CAPig+cRrwGsGA+2B5+eYpQY-TdGsDspTgviDgwZ+Zx_sAknZzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRrwGsGA+2B5+eYpQY-TdGsDspTgviDgwZ+Zx_sAknZzA@mail.gmail.com>

On Tue, Sep 03, 2024 at 05:47:04AM -0400, Eric Sunshine wrote:
> On Tue, Sep 3, 2024 at 5:15 AM Patrick Steinhardt <ps@pks.im> wrote:>
> > Our unit testing framework is a homegrown solution. While it supports
> > most of our needs, it is likely that the volume of unit tests will grow
> > quite a bit in the future such that we can exercise low-level subsystems
> > directly. This surfaces several shortcomings that the current solution
> > has:
> >
> >   - There is no way to run only one specific tests. While some of our
> >     unit tests wire this up manually, others don't. In general, it
> >     requires quite a bit of boilerplate to get this set up correctly.
> >
> >   - Failures do not cause a test to stop execution directly. Instead,
> >     the test author needs to return manually whenever an assertion
> >     fails. This is rather verbose and is not done correctly in most of
> >     our unit tests.
> >
> >   - Wiring up a new testcase requires both implementing the test
> >     function and calling it in the respective test suite's main
> >     function, which is creating code duplication.
> >
> > We can of course fix all of these issues ourselves, but that feels
> > rather pointless when there are already so many unit testing frameworks
> > out there that have those features.
> >
> > We line out some requirements for any unit testing framework in
> 
> Perhaps you meant s/line out/outline/ ?
> 
> (Not worth a reroll.)

Hum. Yeah, this is German grammar leaking into English. Anyway, TIL what
"to line out" means :) Thanks!

Patrick
