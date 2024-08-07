Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FEE191474
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009936; cv=none; b=OZ9YWJf4f03H5W3bvMmO++huJsdvQRdTgfeR5/Iivyk4PCWR26kd+riTe4AH+918z1g7rca9KrDrHm/p0CcWD8JA+951j2lrnEiqeGXd2D6jDgNw1+BaNjcezSduwpMNW+Fm+2YeTlajs1QDaO4JMWWR26R1dlLE9n6CQHYe8aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009936; c=relaxed/simple;
	bh=nY0nClapgleCCaOAQEKDuKkyk7xPiDpCFTAOxHRAa6g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh98Ovsr8QT0GjCily38chksGyqzHtrPCiT9OCy/hI+SiG02NxZU4YZxZA17HjKJbJ54ZlpQiHhLH/2rnslEqjjOtVIbAySI9QiAEXxnbnBTlj9iH92ARSbzTtfaZYNCaoG0sMDd4LJwi/OLriCiebRIO2Mobp7+CMeh4I93iAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jeQ0nR2Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HDXvFtQl; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jeQ0nR2Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HDXvFtQl"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8C28A11519F5;
	Wed,  7 Aug 2024 01:52:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Aug 2024 01:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723009933; x=1723096333; bh=TmTZL1DS6R
	vKtkGGzmLvf6HpHUGKQNKstOtKqyNDnfQ=; b=jeQ0nR2QWB0eqGiy1cjgKI9FI+
	444VvDc1pxRyasqoQKRL0XxhLI5MLgFf8ith211yrBekX+Bcz1GyevWvH3rKZYcS
	Evs9wI/0j0vooqzb2wucNq0kSCfhclQ+RKfiItVInkpv7apAVY3dzFBPRBDpnR0y
	1W2gDVq9LjG+18qXEwVCLNlW/NcQpwExXeOCxYO+1SctluZCZpC2w4GBIIC3WKXt
	SP+aCLTBNECP4p3MqnoxRRYeVKDejl5xizEENQZaVUrueVPnAhnGtMrdIEPzgImh
	3Jlje8auhaUQGTC6XRAfMEd0rjWfLlgCU7Ex+yFroUkRF1VyXWkWNqyMks6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723009933; x=1723096333; bh=TmTZL1DS6RvKtkGGzmLvf6HpHUGK
	QNKstOtKqyNDnfQ=; b=HDXvFtQlZjfXQuysMR4gWNjBUaYbNqkeCKAm5Wihp/jJ
	lH472cc/tDlnIpp9nOKF0x0tqPeGkBjV+Suq15e9pKiT1j5GgrIn5W2Mvv6KJBeJ
	Ddh6jQeuhnxWTbEUnpQbhKv9bSaXubJAJjThwu0Zz/FsRhVI4cTvku/WZaDBuP9Y
	eCf2W7nzDCgqMmNh95Q/gkZwIhimXEz288bMWElCthLXDuuiBFiNYpTfxHudrYQO
	w4hn0inJjVVHtvVc7eptzK4KZLc6bGXQj8Rb+t7HP+KXrgBz7xar6PZL2KEqXuEZ
	P97hX7nj8XqEpUvNaVicNgsNWwcqwIBroYEHs+5hIw==
X-ME-Sender: <xms:jQuzZhsVL8xKGRqjWQGT4Y2RrN4QrAjGyv6sbQTVpIuU0uG3J9H1cg>
    <xme:jQuzZqda3GPxhGl6NkZ_Na5SuEvy52W-BIt266Wp20lVG610vCwRPoefve6_2Ox3h
    iNcDSozOqHaz-HL4w>
X-ME-Received: <xmr:jQuzZkz7mNmnltN1hHZsj91ytG1IrQ5exC3fxkRhRWrI7DkHDrJLIYg_26-bUIc1xtbv4VfEkJG8Dv5Z3Ai7gg_b3qaCqgEGlMEhQhc6ZvK3lcFF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefhtddvudelgeetgefhkedtudelueelieelffdtveelleevueffiefhheefkeekieen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    td
X-ME-Proxy: <xmx:jQuzZoOz3O4lCxf-7f1UUZUjvnEN1L0UpgY1Ek2SJat1A3Xw5TKBHg>
    <xmx:jQuzZh_lR1AYHE9Yk_ReSoeC0g85CNYeLhTzmQgDt_P6TWEVHj10kw>
    <xmx:jQuzZoUE8WHZFvqNoG7RdkLcJuTnSYOgXHFVM_rEd_YkpJ9iYoxnRg>
    <xmx:jQuzZif85zAbri7lxJHs3zl8jpyVaymMytAl-meZd8us5WSRtzKATQ>
    <xmx:jQuzZtRO7QcDLrpPEySXUZkm7dyOSM6a08k8FESVdyuc_Z6mjpTfXWZt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 01:52:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af0aa3c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 05:52:05 +0000 (UTC)
Date: Wed, 7 Aug 2024 07:52:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [RFC PATCH v2 2/7] t: import the clar unit testing framework
Message-ID: <ZrMLhzVCq0Ox9nT7@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1722952908.git.ps@pks.im>
 <6a88cf22a5de3faa77cb22998d27f0c1b63bd4ff.1722952908.git.ps@pks.im>
 <36e3ukvajteiywmsca7vohyk35ehqsgs5rj7njy4ssmykfb4om@sbolkz7xfafe>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YFgMfw4mZRWvhFRl"
Content-Disposition: inline
In-Reply-To: <36e3ukvajteiywmsca7vohyk35ehqsgs5rj7njy4ssmykfb4om@sbolkz7xfafe>


--YFgMfw4mZRWvhFRl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 03:18:25PM -0700, Josh Steadmon wrote:
> On 2024.08.06 16:14, Patrick Steinhardt wrote:
> > @@ -212,6 +213,7 @@ Framework,"<<license,License>>","<<vendorable-or-ub=
iquitous,Vendorable or ubiqui
> >  {criterion},{mit},{false},{partial},{true},{true},{true},{true},{true}=
,{false},{true},19,1800
> >  {c-tap},{expat},{true},{partial},{partial},{true},{false},{true},{fals=
e},{false},{false},4,33
> >  {check},{lgpl},{false},{partial},{true},{true},{true},{false},{false},=
{false},{true},17,973
> > +{clar},{lgpl},{false},{partial},{true},{true},{true},{true},{false},{f=
alse},{true},1,192
> >  |=3D=3D=3D=3D=3D
>=20
> Isn't clar ISC-licensed, not LGPL?
> https://github.com/clar-test/clar/blob/main/COPYING

Yes it is, and that's also what I said in other mails. Guess this here
was a copy-paste error, thanks for spotting it!

Patrick

--YFgMfw4mZRWvhFRl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazC4YACgkQVbJhu7ck
PpRZHw//SEZefuexwIR2rDlhrMKxqBQIZjUAGaCPXnaBRkuLFhAU3qNi2f8b2QOo
RE0gpmeKCXLTB1VfX6sTIxBc3Muzdu1S1Gcn49QbKQpmVId5fg/bk+fp0Y/bNKWa
3O7nxedfkZGduB35uBRRgzbPpSqDD7JKMkpk+THAiZRZv7v9M2ZiN0scAE4Y0f59
TOpP/WE2vkVIXPvgJDKtuUATGVdM1jG+D5Bem+UgfHRykGJ4COqDAMvsDluYkL4g
uD4J0LEiibU1wtMok2p8Aa4yS3roeHSqIWovNcIPtQP38yQrffw0zkdaTH85QVgm
qzjmRHMfQCruZD5ZJCU09ZDDHajg2/mUZEkEdqTUmD9g3oZySLR2FbUIkNZofNxz
rVz0qFjgyQiCLnYw+Oodb6hQbMNQ3HuDRvtAJiN/xp/55Wxv1dypzGalC8lYizL2
AcKquUi96/vQElYjR9ocn4gTaMiO+31Xunw+JN1Bo/5gL6tvPPDunAnZF1CVTaro
8zy6NXNyqsqTWTSAmbmXQkktQfK8CCeg13ky4FktwyR+iXLN6SieHsvAHryJLtXz
+s8H9R6ZKC+StuKQ4zbi6CEzCQWZEyDYLEQieAJ5dQ1DyAlOUkSU5Ak7qub4FBlp
4uv9YplbtdNkfHA9MvzXULMN9IPRmYyDnIOErhA42x0OM0F0XuM=
=IfaW
-----END PGP SIGNATURE-----

--YFgMfw4mZRWvhFRl--
