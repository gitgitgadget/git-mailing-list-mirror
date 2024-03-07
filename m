Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6611848
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709793398; cv=none; b=vAKU8fXEd21sLYWLbuHufCWlqeDCO22QzPmxmpTnx01tRJSBFQLfj0MbyE40rorld2mfbUj1bm7UxedPCGjt3J8VAR2ifxLfaBgNxlrVKyHJ5SzKkXXbJ62eBfoRf87I2KbBuvQpl7OFY5XdfOJuiosiVcCOZVQXpA7lPFkj2J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709793398; c=relaxed/simple;
	bh=c/kcSTUt7ywouqiD+YBE6WLymgkI3/BxYklRQ7BzydE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLrks9ChW+oam5i0u1u9M2IkidWMg9SIx0+A1yclXcLk5cSK4Q0xJFXzOQaD+HWvUx1vQb7FFr89yQogoJgjGivctyB9CK4Z2eHGW4Fkz9MIqJ+W0oqWxe1BqIMNam9tVXgHocCrLwAsewc0Cqtk8F2A8Kt46gAlLGrnlUzcKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eZ+Duybs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cZSie5LM; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eZ+Duybs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cZSie5LM"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5E1851800099;
	Thu,  7 Mar 2024 01:36:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Mar 2024 01:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709793394; x=1709879794; bh=j69sZhm63P
	Pq/5jgD9GVq4sDif0WgPzCuN/Qs17qd/A=; b=eZ+Duybs5uJG4/OeTqHxOgwXSI
	lqnqwFZqlqJspqJByUdEnRJQIfUEXPTvv2BTZGrRqryNGTnsHDgzsQBIn0LsCXGC
	da9iabsv9Wl1d15mAJZG5edfO60Twwu0+qOZQfdlRjS+DqMyCQqjqd6H1haZxV+E
	Obk0v+LI9Ic4b3lZMH1R5S8AiSqVJaGTwfQbY3Oxjq68dYDGaCaL0sRcJzm8eucc
	x5Y6TYU55NXg8SNP/IrOjtEEEk5qhHG2fHITOn93JOgeepvqqW95+fj11ss47GQJ
	ZH9ofH8AES2ro1aKfDaS5TEpu+Mv+GosPJs/9Vr/vObgDDB7ayEUmYZ6JH0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709793394; x=1709879794; bh=j69sZhm63PPq/5jgD9GVq4sDif0W
	gPzCuN/Qs17qd/A=; b=cZSie5LMda7hv3KJr/Lq2PbsLFJdy7OpkTY0CzcJ2QCi
	PRUYN+oA7ibjQVoXuUlx2BHtc58XShk3LHea9lEdMmJqNKujRmmRfkZKi3GLSbkh
	j4ugGbLfZ3TZ4bItgtdioz5shUB2ooSSVvkE8CqouVXPA/58wm0P3XRkzAomlkeS
	HmEhyWJ/+OPaZBtKanPx1pdJDiQqztgu7WqwmQ0oolZnsIb+Grh9I49IiyaI5Bea
	jJKPJi68wjyUfhBqIXetLGw17iRhvfqsz/PTIiOuSGDTvGuUX39RhOVGujIj7osf
	HjsNSSyM5LnfdsQDpyzGYVMfD+7QRxwvA4h2vRw35g==
X-ME-Sender: <xms:cmDpZYJqvq7adkppQPoBTvBJ5ZOh8OqkS90Oz6rXeGybBHzL_ouxSg>
    <xme:cmDpZYJBkq5zQWvF5blUzty631xjiJChpoWcTsmrsp2u4j_LfNLF99MMc54QgnOrD
    qecO2gOSrdtYhLuuQ>
X-ME-Received: <xmr:cmDpZYsIWdKjUrwQb90-tzPFgg1BpABgQ-XyL3nicv3g72F4DiqnhAIrn4zg569JthZGjrTw4WNxTNBhjeG9tHeDHx07YsKedMCf7DgJeh8lkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:cmDpZVbxnDxVqj00xj1aXko_9eIIW1krQVyubm8G5XH3lD_yW45Urg>
    <xmx:cmDpZfbJMRvtfNZO62aWMjRnbaV5MndWma2skS5yXngkOEbK1F-Y8g>
    <xmx:cmDpZRCeVFPEzwhgD2iMveL1cI-nyG7w0X5ZPulsQUi0FNW7sTVG7Q>
    <xmx:cmDpZenfMyXx7HaGa-P0YB4wFpQKol9LUQyCsP0-P4McDazQ7tx7wLwu1zA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 01:36:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed989528 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 06:32:01 +0000 (UTC)
Date: Thu, 7 Mar 2024 07:36:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/8] builtin/config: track subcommands by action
Message-ID: <Zelgbmol7AL71Jgt@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <e39774d6495767c6505999bdc33110678139e347.1709724089.git.ps@pks.im>
 <ZekF4aqq+NUf52go@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uyYzwGTaqRv4zZtg"
Content-Disposition: inline
In-Reply-To: <ZekF4aqq+NUf52go@nand.local>


--uyYzwGTaqRv4zZtg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 07:10:09PM -0500, Taylor Blau wrote:
> On Wed, Mar 06, 2024 at 12:31:50PM +0100, Patrick Steinhardt wrote:
> > @@ -976,33 +993,43 @@ int cmd_config(int argc, const char **argv, const=
 char *prefix)
> >  		key_delim =3D '\n';
> >  	}
> >
> > -	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
> > -		error(_("--get-color and variable type are incoherent"));
> > -		usage_builtin_config();
> > -	}
> > -
> > -	if (actions =3D=3D 0)
> > +	if (action =3D=3D ACTION_NONE) {
> >  		switch (argc) {
> > -		case 1: actions =3D ACTION_GET; break;
> > -		case 2: actions =3D ACTION_SET; break;
> > -		case 3: actions =3D ACTION_SET_ALL; break;
> > +		case 1: action =3D ACTION_GET; break;
> > +		case 2: action =3D ACTION_SET; break;
> > +		case 3: action =3D ACTION_SET_ALL; break;
>=20
> Wondering aloud a little bit... is it safe to set us to "ACTION_SET",
> for example, if we have exactly two arguments? On the one hand, it seems
> like the answer is yes. But on the other hand, if we were invoked as:
>=20
>     $ git config ste foo
>=20
> We would get something like:
>=20
>     $ git config ste foo
>     error: key does not contain a section: ste
>=20
> which is sensible. It would be nice to say something more along the
> lines of "oops, you probably meant 'set' instead of 'ste'". I think you
> could claim that the error on the user's part is one of:
>=20
>   - (using the new style 'git config') misspelling "set" as "ste", and
>     thus trying to invoke a non-existent sub-command
>=20
>   - (using the old style) trying to set the key "ste", which does not
>     contain a section name, and thus is not a valid configuration key
>=20
> I have no idea which is more likely, and I think that there isn't a good
> way to distinguish between the two at all. So I think the error message
> is OK as-is, but let me know if you have other thoughts.

The transition period will be a tad weird, I agree. I think initially
I'd prefer to keep the old behaviour just to ensure we don't regress
anything, but after a couple of releases I think we should revisit this
and become more aggressive about using the new style.

> >  		default:
> >  			usage_builtin_config();
> >  		}
> > +	}
> > +	if (action <=3D ACTION_NONE || action >=3D ARRAY_SIZE(subcommands_by_=
action))
> > +		BUG("invalid action %d", action);
> > +	subcommand =3D subcommands_by_action[action];
> > +
> > +	if (type && (subcommand =3D=3D cmd_config_get_color ||
> > +		     subcommand =3D=3D cmd_config_get_colorbool)) {
> I don't think there's anything wrong with using the function-pointer
> equality here to figure out which subcommand we're in, but I wonder if
> it might be cleaner to write this as:
>=20
>     if (type && (action =3D=3D ACTION_GET_COLOR ||
>                  action =3D=3D ACTION_GET_COLORBOOL)) {
>         ...

The reason I didn't is that we don't always have an action set once we
support subcommands. We can of course figure it out by walking the array
of functions pointers to find the one corresponding to this action. But
I figured it's easier to just use function pointers exclusively.

Patrick

--uyYzwGTaqRv4zZtg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpYG0ACgkQVbJhu7ck
PpSPBQ/+LojFCZIXXqW+ieXSq+Estkni3pL4thZuIh3w0mdT40w91XA/d8FYX2yV
PzAzrigsXJongg0PADoiaUoZs5ZeCBBlutOWTcQEHa5g1LgwYAMY/q+PwNOR9nTE
axj/PgYC0ZG1lxQJikw6mQnoKw7ge64Xo5Q0SIjlC4VQd1flQJD7nU2x4S/fPLUf
nNNRL/anmzNfJXfa+SqQNygV+7uARrjQPtWVcm6ZgJGka0usIvynS4eRBmdxgDCt
aZX3E8FPdiXf9Aqp5SYXercBFFB+rgtG7MfKSD7Y+O083HBp+rgGIXULZLxkgjy5
fEEU6rMJilfur99EKaOvfdhpOzPBjjeid9wPV/LJScfo1ZtU62iX6+CZapJr05oC
N86yrIUWoTyNHdwfLFfw0xxfQg6gbzZQA34UMCstJ6oS6Lyb/o87aO4hoGlf1Vss
ZHA1G7jeda3qeih7g2AzOLVqfjjFgIuvz5aVt13GGZi5JChdB8bb6ihSGiqez6sh
C50yqVpRXI55eCSM6rKKTUR699TzORMTYfUS9zUmM7zHjyTdEQE5vykWfQCWrOti
57+Vz5SXyyxUb/T1jLx2kExxiYb54o2k56Y8saeZSSfnd7GsXa9WJN0Kmjz4i7oi
jK3siH3OgN9CKN8l4dnbJ53+pFJM2bYesKgiemukDs6kponHEi0=
=lISg
-----END PGP SIGNATURE-----

--uyYzwGTaqRv4zZtg--
