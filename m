Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39A21CF8B
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709795706; cv=none; b=PzwFm9FnLYR28LOtCrLeH48pkExrVeOj1TXKQWMm6WtYE/tpP+qmRAJkQRy8c/YA2LynpR2jXJuDfIP2i5TRLUz2Vsqyb7XtYTKq8miafiQ9eYVA9Wur/qvv7M/eDP6NK5mSwkSsn+U951NTJd7C7njv4Gs2UYKGRmDUuQVTbtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709795706; c=relaxed/simple;
	bh=qqtPL83UDuSoxhXWhRRFn/FiDg5YGMfpwweaTWMnuR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeRJXMpHzsQgGgYqTt0PURJX0GIzJTbAWTVsThxxPkh5oE5lZUCcKad57X5S+Vv4yDlRdhojBVnF8ib/he5LRsiddkQVEQ8e4qYViDPqzeNhq4KTbNDcozKNeDiX/2A0GRoeFj9m6erx5/Ph2I0ta78qA3skTj/8IA9i4LIN+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OH9KLlJz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dTxifpAu; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OH9KLlJz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dTxifpAu"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 83DED3200319;
	Thu,  7 Mar 2024 02:15:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 07 Mar 2024 02:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709795703; x=1709882103; bh=KtkwqvRBq7
	wJNtqWZI8MAp5GTb4sSjVrlKp49VRcHf4=; b=OH9KLlJzfAKg/IqnK8LAofB9rY
	K9FyMQRWkpi8VRTQTAdNGa74cLZ0MzTXbwILHfBIoNR9kCOaW2yqwcW3kBUhKGSf
	HD48XqEjagf39k5bK/06jwhM2KcQJZz4++rmOkpEdirjF5hpNM9uue1XzIzXlydn
	4RtPmV+UX2Fh+CG+tKsEf7g+KXuCVOJTZw9/tXAnrZ/A6Ax/5QzA+IvWx5UKKPfF
	Jc88kvfFPScyaV31YvMwlTyvtweZm/w0mCYXy5oBUGmAi+8I58Dfn61IpfSYOgYk
	6/f+/Os9LDzG7dmN9QlGhAJi1uogkKjwcgBAqMm7Z9xUtcrgIoMeRbd0CxWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709795703; x=1709882103; bh=KtkwqvRBq7wJNtqWZI8MAp5GTb4s
	SjVrlKp49VRcHf4=; b=dTxifpAuQh+d1J9AAlwaFTMm/WP8H+s8T4NDFnErQ2b7
	a4znQucgm1wetjZ3ESRMbv9E0IDclOhasT9dnQ/xlRH/tC7psIwNc4Zpy4E0/Rpx
	MjToh/50ZahIUejfyrzQd3koTaXQHm8GPbCrXGNWdbwPzhq37m/S6l0d19oXzynK
	g21taN+5xXSzGXuETpNQ11M8ibdhKAa/u18DhDGa0CMlqb/0tCLv6KJg6lG51Gwj
	9bXioHaPc2bZeaNEvMG+EsGLPv1+X5mKNZBc/D47WknbJ2L6XARcjEm+2/TZ4UjO
	8vCQVCAX3OW94WiHIO6Yo/YSTpiuNl8BWT05kobziQ==
X-ME-Sender: <xms:dmnpZQA_ZJP5IOoiDQgCEW46DO_aDnb6XMet8LJQW-Luz5WHldzbLw>
    <xme:dmnpZSjvPi64EyfWymirVO30XK2RtDyWphVkQrMFybuwOXeFvaA1TFlniqteXL6Kk
    tmrRJ9ENhzph3ORXw>
X-ME-Received: <xmr:dmnpZTkc6ltfhaGw7I13BrCvpT8yeYW60foDHORcqy80bMrj2mAcJ2fQI0PQsMHTy7Q8wY8XjCzf9SpKDxfQsCEbnNj4K7qWrsWkgmezyf_4Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedvgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:dmnpZWymeC-sPobUuFy56qZsMjOhD17XYT16Ylys6-r-bEVMwF3drA>
    <xmx:dmnpZVSot-uOcqPMgkPoLDZevf9Dio0f1UEr3oV208QdSFwl6TeJGg>
    <xmx:dmnpZRbAxOTIL5eI_njWx94uasI7wvNLH6oR94KEleCj5OZJFBsmTA>
    <xmx:d2npZUKT3Up3kDWcijf3FfZME23X8BCAx5BA8NSk4TE931TKUmDOdg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 02:15:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b9678d5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 07:10:29 +0000 (UTC)
Date: Thu, 7 Mar 2024 08:14:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] builtin/config: introduce subcommands
Message-ID: <ZelpcoIh5dalqrRF@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <f79c0f94e415de5c1c7b4120af5270fe4900d825.1709724089.git.ps@pks.im>
 <CAOLa=ZSg35atoTsBVtWj_j94n2Mt8otzfw3DYLYS9FCbNgp_Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h7TS6vgZMp6AbPf+"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSg35atoTsBVtWj_j94n2Mt8otzfw3DYLYS9FCbNgp_Xg@mail.gmail.com>


--h7TS6vgZMp6AbPf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 01:38:25PM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > @@ -910,6 +930,20 @@ int cmd_config(int argc, const char **argv, const =
char *prefix)
> >  {
> >  	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMEN=
T));
> >
> > +	/*
> > +	 * This is somewhat hacky: we first parse the command line while
> > +	 * keeping all args intact in order to determine whether a subcommand
> > +	 * has been specified. If so, we re-parse it a second time, but this
> > +	 * time we drop KEEP_ARGV0. This is so that we don't munge the command
> > +	 * line in case no subcommand was given, which would otherwise confuse
> > +	 * us when parsing the implicit modes.
> > +	 */
> > +	argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options=
, builtin_config_usage,
> > +			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_ARGV0|PARSE_OPT_K=
EEP_UNKNOWN_OPT);
> > +	if (subcommand)
> > +		argc =3D parse_options(argc, argv, prefix, builtin_subcommand_option=
s, builtin_config_usage,
> > +				     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
> > +
>=20
> I wonder if we can drop the PARSE_OPT_SUBCOMMAND_OPTIONAL in the second
> iteration to make it stricter. But this is OK.

We can't due to a restriction in the parse-options interface: when
subcommands are present, then PARSE_OPT_KEEP_UNKNOWN_OPT requires us to
also pass PARSE_OPT_SUBCOMMAND_OPTIONAL. Otherwise we trigger a `BUG()`.

Patrick

--h7TS6vgZMp6AbPf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpaXEACgkQVbJhu7ck
PpSGcQ//fKxp3X8eovemlZPy2sZ4j80QQ5eL4g1yK9lRlvc0OyiVtgz1BY2gfjpK
7khXQvmT8TuThJC7ix1v2vULH6M8e3BUvdzsZGVtGGcX13t7gSaeCQU0WWJmc6VL
gy6Pi2cWAxWIoeWy3kuGCY7zqCTLiCvP2UOEfykhIJFrPN1HJTxAb9A3yaPDWqz5
l8WqUHzoLT2OUivAUNlF1w1t/7tm7amDOXKfC42sxgrOkh4VZBHRZ9QNemlL0oc1
BYs6gB4JEC6JfJ4yBhH9t51tszaGd8NmPCnMu57S6wKkND4uQCwTxvJyzaAsQBJA
HSX241nj4zdT+GYHE4qTo5NjbLPsEGmxa+Qg6pg5uzoMEaBtDFIWFShj51eTWsPE
S+AMix2/aERfhWujPc0z5Pze8j/tV7z/KHysCqyfPVd+xPG7/+GkSLoqV0slBg1p
2x/a8Qdl9ugI5Sn2qimOcIDE+llDqy6a6//uKMihC3oNXumxUmHKgUE3ER6ykRxm
8Ja6YsbC9fKK4zcM/tNI1ggAQWoiX+5hQNAUqlyTAMSVJnDPesVHFG2Ee8tw8CoP
jvggJe/sCurc0TU3MINW4QIYJx8h7gw3gj78G+6RK1yK+xtufUlT7fXzSvZrIE9Z
SooxdKdtAtom0FLCfOt3tp2xIxGoyyTDOOVvyEK7lOmZfrsUK7k=
=Oc0W
-----END PGP SIGNATURE-----

--h7TS6vgZMp6AbPf+--
