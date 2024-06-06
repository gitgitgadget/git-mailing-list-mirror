Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A914386F
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667425; cv=none; b=e9wtcNpXLnG/6KSj2Vq/AZLA7J/WZKEGM95jb1cGPEm7ufcoEtMo2HRHuHqRsIfLTBQJJ9bd7y63X38ch+IEzszZB5mAQ68wPZhtjGa66mSTHzWe05AeZxJZGsWi1zw98j5kCCSEEuX2rdF8j5CNhAHUm2pT02XXKQbwz42Lzi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667425; c=relaxed/simple;
	bh=saytAMYWeFyVJ2qgaESnq9VSW7rUOa10E4+X3G7OITA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVJW4XjtHm9PwuqBCX427pAG3OlizbrhdRHbAKMkotGZGoMFENYx/Bkz3HPhVyIBe88SvgQ/zXzIk9AvxKwkhYdeOrSD51pM6WsI1CcbeFQomWCDqKO2fYONRKUaBryzaAzIDN4WPAH/ioPgESaKdKni/7s7my+JB/hacEtINFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ScCP4XFT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6Fk7nHh; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ScCP4XFT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6Fk7nHh"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 71C8F1380182;
	Thu,  6 Jun 2024 05:50:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 05:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717667423; x=1717753823; bh=vzyYMnzVO3
	Mm564fuL1PNFdUmcootzDg/LrUFQopU8o=; b=ScCP4XFT1WZ+t/rfsaHiumQ14r
	av0Z9Ld5fD3pqtf/bf7V8eLJOzyYjOLQLN0cQ8YCvfqF+eTB6rvRSbcvOVyg/EkS
	9WegZjbhW+XYpUBwasqADB+27mMuVYLG7fHes081ohP5XUjeCP+XyhDt9kiB0kJ1
	EcBh4jAl8UG6gDYYYQu66iDUmZQU0wyAeDf0pbBNKLp/rtHAGeF1LsqAkB0JCrRM
	RNXDE7WEBqEbw2WDU0PmzA6PgfTUPiTBg3ELMutDk6c0Js+qEwf7YQa3OitpVbzQ
	Dvzws1wrKZHTV2aD+836fQj2dmzV/o+HjAUJT5eTkP+aG1r0ZQa7W1ZRkCiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717667423; x=1717753823; bh=vzyYMnzVO3Mm564fuL1PNFdUmcoo
	tzDg/LrUFQopU8o=; b=n6Fk7nHhyaXS7ybndHwMZyNYW+PSxbGw6Gi+JlLfbp0W
	mjs0KFs6gwMCd5dE4APfpeOn0iL5ZHXxzuCScdVgoj1XXAgwN4DyQvku90492LT7
	mkovIfvJI/Btn3h5JtKk0sdnqkkEvTZJ0MnL0Vu7w9qJE3MPkVQvq6OIit1TqX2d
	ow+MgmzHVE3elA0xmwemJ9nUtfJo1ufBQh0c1dDmjEFH3eQ24i+3fcz+vZbNcrAg
	BOyw3imvBJTkzflq3AR72aUqOD1NRnKw4+RMCa6QHMz33E0KmqpVncDF2nwaK8lx
	jx2WAVtDgncCIGC9oCSiSFPearjOrozomnGZyfqIRw==
X-ME-Sender: <xms:XoZhZiibSgWgn_bbamScvWkiFjZVPM0Y7g_WzygbGmA4cte3q9XFNA>
    <xme:XoZhZjAcAEn9KfAIzAmpEuGIufzAcOM9jC6jnvqKK0MUgtTHBXExwRDV-Y2GiZ1tZ
    CNkBiWi-36Idaui0w>
X-ME-Received: <xmr:XoZhZqF4_8HRlEgXffhSv6vxn75VHoO8Ra7NmfYnFCfwf8hg7QgRILb-O01F4iNYwVShcNvwp4ECFKW7m8KFhe8VbRhNqwfx71ifEPdny0WDBQbd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:X4ZhZrRudjd_sU37F-SDs6YrxislzKXjkaX0CxqfC4AfokKTRXhJOw>
    <xmx:X4ZhZvyeFmfPspjnHk9ivtA6oP3amOEX5aZvod6os3I3Q44-zyssQw>
    <xmx:X4ZhZp61rtBG6GaObNr0TEKmic2GkpAvIYq4DX3x_gm53TXA3IhDjw>
    <xmx:X4ZhZszZ1LXSiZAzy6FcJBcMqPnC8Kaib3D152npytyk5KGgrsYX5w>
    <xmx:X4ZhZqrhlGjkDy7Q8Ocelj59M7H915kvsL-_K_T7-nMtxvuKhIdSakqs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 05:50:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7cd5f97c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 09:49:49 +0000 (UTC)
Date: Thu, 6 Jun 2024 11:50:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 24/27] builtin/rebase: do not assign default backend
 to non-constant field
Message-ID: <ZmGGWdClbLxNfRwF@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
 <e19457d20c80f9ce332f2d890a5089972e28f0cf.1717504517.git.ps@pks.im>
 <be8a315a-3fa7-40d3-80e1-6a5c01afee70@gmail.com>
 <Zl_6anUl_C3W2j2Z@tanuki>
 <d83f640e-2528-4326-bc46-d2b99f83a153@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YltqRSwPb9I8ZIK/"
Content-Disposition: inline
In-Reply-To: <d83f640e-2528-4326-bc46-d2b99f83a153@gmail.com>


--YltqRSwPb9I8ZIK/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 02:06:55PM +0100, Phillip Wood wrote:
> On 05/06/2024 06:40, Patrick Steinhardt wrote:
> > On Tue, Jun 04, 2024 at 03:06:38PM +0100, Phillip Wood wrote:
>=20
> > Do we have any other cases where we allocate inside of a `_INIT` style
> > macro? If so, I'd go with that precedence and just allocate inside of
> > the macro. But if we don't, then I think I'm leaning more towards the
> > way I did it in this patch.
>=20
> I recently added an allocation to REPLAY_OPTS_INIT, I'm not sure if there
> are any others. In general code that does
>=20
> 	struct foo =3D FOO_INIT;
>=20
> and does not call
>=20
> 	foo_release();
>=20
> is asking for trouble so I don't feel that allocations in _INIT macros are
> generally a problem. The only reason not to have allocations in an _INIT
> macro is if it might be used to initialize a file scope or global variable
> but that's not the case here.
>=20
> > Happy to be convinced otherwise, I don't really feel all that strongly
> > about this. I'm merely aiming for the interface wth least surprises.
>=20
> I'm not that fussed either, but I do prefer our _INIT macros over _init()
> functions as I think they're nicer to use and easier to write (no need to
> worry about memset() to zero out the struct).

Okay, given that there is precedent, and given that Junio also seems to
slightly lean into the direction of the `_INIT` macro, I'll adapt this
as proposed by you.

Patrick

--YltqRSwPb9I8ZIK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhhlgACgkQVbJhu7ck
PpQ3GQ//akyWK2vI78aJwGiqG6gJ/rG/nMRAP7XgXEKOnO3Oznd72Gp/9C2wq4SX
lIblmvrdks2Igtnxt/Vh7Ysb4nqvWE2PymfYrc3QkbNcPpPMNnh0wmSgAklM1q7/
1gCRsF90q20vAT5NAdgGq4JqocTykrHWWmgmPH5X1+5N3NxIwyAoj/FNQTFVZ/5j
pMWN+UF4V9kTdxI2G8KhXqtBGdjO4EysCw2C2plCByj6ypPmXTfUaz3mFYBFClc1
Q8nB537/SxFUFGTe7dLl+lCt9rOfepBSnbSzKC50cQyWhIJOlmU/qeQFw8sleQie
W5pV3GBbXdT10PulNMdVTqYAweO+kTfqkX3HFTV5mA5ZPFAwNguNSjWS/Sy6OtAy
ip3ezcYWRHyM3K7WuD6RsawSZ9EqB6sPXPeKgdwJWTcEipuE1ADA2h4dj1jctbnE
5cagOH2nsynvuujOmT9K1TZbdEQmY30KJjMnrykQ8L2noAAmtdh5A+q7tLBS22Cr
IQZSLBNrXiDhuV9E6aEHm8Xog2USn5+FafMpRe/yA/30q9EGi3q3qKr6mCLifcdp
S0C0wsNoPGd8gW0nVxPfK/Y0m9lkPfTLh7wT46FVWGwEAtmTmkEO681qQY4cgGOm
+259QSjMb5RZoMqxCBi99j8CLgGcKsAELuwVrY5zTH45Qzeg5Ns=
=wQ/1
-----END PGP SIGNATURE-----

--YltqRSwPb9I8ZIK/--
