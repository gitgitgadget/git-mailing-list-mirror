Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D00147C90
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589397; cv=none; b=m2T11wWGQz4lhnbeFX4oWLUh77PRbNicrFD/9UK/XBJ3Pr6SNQrT3Y+LY//5Mx//UWFbVJbh2pSXp1L5IOxKMakb3Gbyto/cqFWz8M7y+4H73pK60NXFEmRfJ7X0msOB06MNgw+MoYGfxSKWL/3ry3EE+1IgQ76qOkv9n7btspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589397; c=relaxed/simple;
	bh=hKzw/LzQSHna52+fMSOdLf2l9ztNjIB9hIj1UZM4gic=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9DFMdLs6nvub4oXpyUW4WuZoh4wkD6UIxcwHCxnI++ZgxFpoZffxoh3f/hjKk5R5cENwVma9dJw97wUzLnXowKIKhWEP9scV0cR/bvoHWVz2FNA/Ys3/UVHl6BfWaH6qkYoh74RCG/8bd5q+awNQdmlALsU4mnKIvVrKNjMN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p8pSSkKi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BMppj+0Y; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p8pSSkKi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BMppj+0Y"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 274A21C000F7
	for <git@vger.kernel.org>; Mon, 13 May 2024 04:36:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 13 May 2024 04:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715589394; x=1715675794; bh=49nbVyXTHn
	k7QoSFHJ3hovQed1eHIwJRaB752br5rdY=; b=p8pSSkKi6HKYxAwiylP1FIvGue
	pTu5SCr6S+HHCMl0xrAmuAwzTwR3SUgNfiQ+QBKdRAvTJaOXS54G1T4nzCgqb5hy
	zzX1P1WmcEpX+UgmRuFJsWHPh2nQDQKbgpk1mlmoIK9e7C1TIzkwVm6D+ur70Qz/
	F9DLBHA5FS6Prgqrh9kls6iMprjdD16tvATgO8AH5ml3gTZPHvTAumCoqNN8LJmV
	kBTVzJqM9d09O2MDGMP72lxV3FFZFdJhE6n3aDOo8/vjlRjg/JIrIHJGE5QPE2pS
	3cMZ291u7zi22K7P8oAsXy7UEPDFJXdSsNzL12Aqq4anuOONi0BjP5u1deBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715589394; x=1715675794; bh=49nbVyXTHnk7QoSFHJ3hovQed1eH
	IwJRaB752br5rdY=; b=BMppj+0YAPezdi6t4r/r0CU20WTGrbXszABzVcBVyB1g
	jHJnhbwnM9ciahnPbuotnSYFoMdUa0DieiRRSWq/tCwzdT2KF6/SDzTrEZpk1w/0
	+ppToOK6ZjkS/05AellPhX9JM13vI/lr0RHZBfTSRjLefmU9f8qb0hrk9Fz89zyg
	fdXrbpY11O4vd5rkDw0xbkYMHBGIyHPh5GR8B6YQze1Kc4fY3Km+uksKyYfSwEg7
	9vMzlHIMkCuI8gWBHB8djsAjzmlkfeH1bb71hUFtzdoFLKHiyQI71DGku4/LQi6S
	deekryqftHvpKxlBfIIip5uBTbCPO51zC7yRe/smPA==
X-ME-Sender: <xms:EtFBZiy2GRo2PwjLcrUdkdlH82qm3ZyMHLUX55T9xI2QMB-hQn3Hog>
    <xme:EtFBZuQ0JJdhaXBJV27RNLS4vRuyWLqhlRfAV5yCBKacMktdtnYuTe6Ga2enE8CnQ
    3pGuqq9bq29NeS3Xg>
X-ME-Received: <xmr:EtFBZkW1f1O7bLStxEYLowQHQC_ACaNYD_kybu8D99eFmPJuUD_RlUBe6wV3xxfmrCnEGn8pDglZ5QT77vtUkWyk9LccCBj68Ngx1x_MVvhJ4zI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:EtFBZoiYu4A94lXeH2-0RApgjYtOjpI9V7u1DhsvZKkdGgtuWuzG3Q>
    <xmx:EtFBZkDmjSSkOlfodVeAtkyAiQRqHqn8v9gC-uh3tmYreuCVOrNDBg>
    <xmx:EtFBZpIlL1EHDuRneTb2IDlQIBoOLSzS3bMXAG9FvTT6AxGR2H7szA>
    <xmx:EtFBZrC8CZ7Er4-ebD4EPTwLLTAvZetbYdApiV6B3QhfXdqMX_R9Bw>
    <xmx:EtFBZt4s6rrdg7oOsOY81446l46qfcdZ8lG_V5CIfXJfzOxzUiq3YPrp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 13 May 2024 04:36:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0f873bb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 13 May 2024 08:36:15 +0000 (UTC)
Date: Mon, 13 May 2024 10:36:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 11/13] reftable/reader: adapt interface to allow reuse of
 iterators
Message-ID: <ZkHRD8zn_KFmJVqi@tanuki>
References: <cover.1715166175.git.ps@pks.im>
 <f688f8f59a05b667b4f4118b7f8c7504bd33329a.1715166175.git.ps@pks.im>
 <odftefkdt65kt4qiptd4tfnlssymmv2wnpzz4uefq6sxycxdsr@b5jm42ulf3b2>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yODtf0vVDiUE3FtW"
Content-Disposition: inline
In-Reply-To: <odftefkdt65kt4qiptd4tfnlssymmv2wnpzz4uefq6sxycxdsr@b5jm42ulf3b2>


--yODtf0vVDiUE3FtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 04:48:45PM -0500, Justin Tobler wrote:
> On 24/05/08 01:04PM, Patrick Steinhardt wrote:
>=20
> > +/* Initialize a reftable iterator for reading refs. */
> > +void reftable_reader_init_ref_iterator(struct reftable_reader *r,
> > +				       struct reftable_iterator *it);
> > +
> > +/* Initialize a reftable iterator for reading refs. */
>=20
> I think you meant to say "reading logs" here.

Indeed, thanks!

Patrick

> > +void reftable_reader_init_log_iterator(struct reftable_reader *r,
> > +				       struct reftable_iterator *it);
> > =20

--yODtf0vVDiUE3FtW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB0Q4ACgkQVbJhu7ck
PpTgtA//YLj173u0kkldwbviNp2y40hdgljdL/xW2nOYRclVNgummyLmczESdMnX
JGY/6LHbBcnWeKUoXG+10fcFYKJxYfRsS6FK3MQ/cxBLI2x4jrffHIYDLFL7PxO3
D9cDuwoI/ZlAhzadRuXxXXTQsfouTIvPjm9x2U2bPantxgCxS12QIz3j5AwJO9kc
OuWjepK4YpWZ8GoD8Xv2krKaQEJLaqExKwXgGu0jrDOYT+otfjDp2ThPaA3MSj2j
HsPFWFzTjm6nYqBpyqNgb/qOyLI6jTQGEyYvphd01v597ro36EDcrCkUf4Jle7WU
VcjqmpMrQG6p3PHo5oFjiT63J8BOkWgFiTw8oz/GKI/RH1ozHJMn9Z7Z2mYmLbsi
PJL0Hg0VCQnyXB6zO/I+yEQPcHyEPTTnxAZK7W0Sg2DvpRAMOaZlStO0zzu4Z5tK
4N6a621RfLEGFmLWmNQ7x5HsF86c66PKFQL6VJhRKlor9f7Pg4+PHLl41qw/Nx9r
ukaMXjbiYMzWVuMLpchrvLIM40BwM9Bl1Zl7sQQsr4gpKLeksj93wD8nrWCiCH0B
nBpK6k2fR+R8oSA+usuq8pt8Tbx6SUwHH4gfC1eYPVG6pmiV52Cqf0tOj26k4N4G
QJah0m7YfjJHoaoDAut7Xqd/GC78xKOfUuUrUJAkGg2xmiVMxdw=
=pyeR
-----END PGP SIGNATURE-----

--yODtf0vVDiUE3FtW--
