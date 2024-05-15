Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B573B18D
	for <git@vger.kernel.org>; Wed, 15 May 2024 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752733; cv=none; b=R7ZuoEt1YoQDIOukTh+1pb/DShk9lBMf33nY0upsf9k8mvrF2/v3SwAaPL8zQt4fAXP1y+InsON0z/JmoL8KysNpyN5+0WHCAzFtRvcveKpQXuTGVXlH/Y6JCD1cUIMdb80Z7PPnYKhGM4SJk35LCv5AqcVLZqOmjcjJ1b4HOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752733; c=relaxed/simple;
	bh=ZEmvWIFPRoWSN9AdpuFSHcLAb4MGMpMIIemijtZtqM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5gxCiITMWby2lNMLwtJOVh5SrI90mhZx5kf4EZVwFKIuW30zUIDFvox/qMacqrQjerkTagJMMJBRNMvhN1FmzbF3HeZz0dgPFFx6H+Q5yllD9imSzmaQw4gFaZ2rrqynB9Aat8ZRz1MezES3QcKVwvIcaR8qLnagtnQGKgJFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lEU6FVve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=To6VVQ+Y; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lEU6FVve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="To6VVQ+Y"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 358AC114017E;
	Wed, 15 May 2024 01:58:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 15 May 2024 01:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715752730; x=1715839130; bh=PlGTye7G1H
	tA0DsL50H+uIaKJvG7CazpC6cBopHNQS4=; b=lEU6FVvebxfKBHhjSmBuOz7OYv
	iqLhxMl/bC+KC1YJhNQ7V7W1BCwlX9AZnL3jLIxSNVEfgVWzN7R79lo0fz9TzoT1
	MHqgDKia0OO/ToKOQKnFiiucYq0epx54+gtWOaXsLkFWVo3qZPJe2VFh3k41pifo
	Eky+pfgFridztCw1+8Nk1ZRV0hYe09l5TXCaPCQ/FEbMmEMlgdi/Bgn41uYKTOwO
	jqMCsKl3Zb1rSWNP/pfnrNGNl+CApNBZhQwNFRCk1RefmuowWTvc0rg/RWGt4+TL
	AOnwht326IjWzbXqFeLyu7R/0DyeRE38+irvp5ALKkt5PpaV0YelzvXR3qyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715752730; x=1715839130; bh=PlGTye7G1HtA0DsL50H+uIaKJvG7
	CazpC6cBopHNQS4=; b=To6VVQ+YxMrW2Rvxl8mjj7ad5ILBZYp5iOCgCPWuA577
	FINILuM2dEqyuJC7BktynVSS9gb/Yte7aXjpUN1RYMPy6fguQ35MsHK4eB5CTLUz
	9VNVRiSjjwtE+nc0B25jE14fIYgPiMKeol+Ixt0xy60urT736ujyoqYhwVlLlqVd
	NcUXJKNnXcpXQ9jzJHFzYpWaBlPy/0/A1xjg/IQgsCSMHg+d0VhQEcD7/vw1651q
	dZgMCBh55PaYqRxetizFRAwSFzY3cX0n9dAqxc63H5ySOAVibtDJt03mT7GD6884
	C0WFW3HVlIxPUqxttrxXzkzsEuIkVKBkvpFTLpWrIA==
X-ME-Sender: <xms:GU9EZnV9ZjMwltGLXHdJJccKpsNLDc4GFzDTHXrkJMilSmaYmuJrcg>
    <xme:GU9EZvmkLF3A6lqgC77Fs18ggsfGMScXnmgrlLN7PhHT4BmdLpb7yLM6_NvryNYUs
    Pvx1AaknqT0sJXNmg>
X-ME-Received: <xmr:GU9EZjZMJsMVL95TnniDACFeBpXgnehohpEx1CDTfDmZ9j310zTC0BzeQWYuocc5noyEaL79SMdyWNXrJVQfHNKBhOhHcmUjGJTKAH2DW72_9l9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:GU9EZiVjctp8tbtF7vH-V3AyV8G7ycR87qTawAn8X_Q5CldUfWosSg>
    <xmx:GU9EZhk5J4Al5gwqevUOuXSVu0spm3SO2ZQjlGEYIr1N5euub2se6w>
    <xmx:GU9EZvdh8p-wclOL7jKWabtKzvth0JYYUjL-PtcVZXQGVXJ4ZEoFrA>
    <xmx:GU9EZrExidIPdv1PRT31aGtIVIB35ryqwxQ9b2BzdVJtwMtinO9XVQ>
    <xmx:Gk9EZkt7IoLMB7RZOug0A4sb1OOdmxs_VI8JKczJVyNDnSxVISXdf8UJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 01:58:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fdc6522f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 05:58:25 +0000 (UTC)
Date: Wed, 15 May 2024 07:58:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 06/21] builtin/config: check for writeability after
 source is set up
Message-ID: <ZkRPFv4xSr26QkWa@tanuki>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
 <7ab99a27c16718ad4dff1f7862e80c52b48c3812.1715595550.git.ps@pks.im>
 <ZkPbZGPq6xFrhngN@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uKOC5a5hx9/NNzOP"
Content-Disposition: inline
In-Reply-To: <ZkPbZGPq6xFrhngN@nand.local>


--uKOC5a5hx9/NNzOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 05:45:08PM -0400, Taylor Blau wrote:
> On Mon, May 13, 2024 at 12:22:28PM +0200, Patrick Steinhardt wrote:
> > diff --git a/builtin/config.c b/builtin/config.c
> > index 0842e4f198..9866d1a055 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -843,7 +843,6 @@ static int cmd_config_set(int argc, const char **ar=
gv, const char *prefix)
> >
> >  	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_set_u=
sage,
> >  			     PARSE_OPT_STOP_AT_NON_OPTION);
> > -	check_write();
> >  	check_argc(argc, 2, 2);
> >
> >  	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
> > @@ -856,6 +855,7 @@ static int cmd_config_set(int argc, const char **ar=
gv, const char *prefix)
> >  	comment =3D git_config_prepare_comment_string(comment_arg);
> >
> >  	handle_config_location(prefix);
> > +	check_write();
> >
> >  	value =3D normalize_value(argv[0], argv[1], &default_kvi);
>=20
> Nice catch.
>=20
> I thought about suggesting that check_write() could be inlined into
> handle_config_location(). But that is not a good idea, since we only
> care about calling check_write() when we are actually going to write
> something.
>=20
> In the spots outside of cmd_config_actions() where we explicitly call
> check_write(), we do so because we know we're about to write something
> (e.g., from cmd_config_set(), cmd_config_unset(), etc.).
>=20
> But in the classic mode we only want to call check_write() when the
> action selected tells us that we're going to write something.

Yeah, I was also wondering whether we want to refactor this, e.g. by
passing in an additional parameter to `handle_config_location()` that
tells it whether we want to read or write. But as you noted, this would
be trivial for the new subcommand modes, but harder for the acton mode.
So I refrained from doing that.

> I do wonder if we could set some "initialized" bit on the
> given_config_source variable so that it is a BUG() to call check_write()
> before it is set.

We could do that, but with the subsequent patch I think it's not as
important anymore. The main problem here is that it was not obvious at
all that `check_write()` and `handle_config_location()` have anything to
do with each other because they both accessed global state. With the
next patch we make that dependency explicit by accepting it as a param,
and with that it becomes clearer that `check_write()` depends on a
properly initialized variable.

Does that work for you?

Patrick

--uKOC5a5hx9/NNzOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZETxUACgkQVbJhu7ck
PpQeUQ//WbePXl4IMyyb74Wm63gwh0tP0O9DswM4j3Rsof5kzgDiqAKXEuMHRx1v
qOXVbatAmxfFWNFxbyu6623GjcnhOHEOm1s2DGYDeMIDBrl+b1oyQ8hj+EW1hv6d
6MUctyOmZlynQFYoAbxiLh9SYaj9S1SNYgQE8icyFn7DO+6S31YlJXXfGBBVks3M
wD13IyE2Geqgvtj+CRbCe9x/13KuN3+D1TeKKNMhIbIS6IQsvc5jW24Cr4HaUANN
b1Q3DtGXz8B8QPLzVW0QWFM7bxsfdJ2X5swmaVb4PfAjvaLYSZ31r2bOKUaCKTeP
kq7u0D3/T6CJsuqjozm5d1mNQA9yvngEyeLIbvKaFeQYO8kDBG066rVSSa3drdaW
aE2ypvkAlECWyqehK6qU2b6No7dOHNjhxM4AkbwGFIn2kjfDJ3PhBBAgTX8ZWv5e
dR9B9vS5gO0E4sxt2VEEeq2fYxIHtWnOpfyvuX5jCAR2q9GoGFOiuX2XCf1340N1
R9EvwXiSaBUI4S19nML55y0vvI+dMlM+XL2NyY549Xy9ycl/vOTArmsFCZNkhstu
CXathUQ24a8TgdXsQ1BGTTBLb8vgraLCZf6iKVOw+5KJejcu3YgiH9+80Pey523W
pPJzXPV4McnCFe/aT83aBpR7k7dT6HEOIWYHJ+GZXce30wyzeaQ=
=9vSg
-----END PGP SIGNATURE-----

--uKOC5a5hx9/NNzOP--
