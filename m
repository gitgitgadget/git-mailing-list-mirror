Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9658436B1E
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548774; cv=none; b=Zp3IUY+2SWiB96DKpR8LmadyLSTXQHiyytfXNMKLEeSpKwkIkk1vWsdQrAdrYtIPYeKYB4w2CCcZJl2qD1sdZlQ0wSZQxEsoIY1IOqh7hBoiNKrysKaShIbtPyL4RTepL2WzagU2U5uyzaBRr4SoFnLTEhElbrlvcc9Wcaa6rfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548774; c=relaxed/simple;
	bh=9q5cwCmidxnRI1SfnZ+XjLbyFo8qCnB/RhYHWwm0I4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWpAu5piryBUOCSQTokGpU4mjd8Tjy/ZmnVTjkUsV4Yv+n5z0mB2vcEl5OH9/mIDCR94QHLhLUsuRv8yVEKMAOt62J5pCZzjZ8m0B5pAr1EZ9L2lyZyQmVxOZMNfX5wT6LCMZStNmHDGfgrBgsKQwa5oazzS1Kiqox06TC/JvBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X/kOKhij; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WHJO0oNe; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X/kOKhij";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WHJO0oNe"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0A58E180009B;
	Mon,  4 Mar 2024 05:39:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 04 Mar 2024 05:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709548770; x=1709635170; bh=mG912gQTmP
	jz/3zMMn8Uzbaq1vD/pmHiJ9ZjxhV3dko=; b=X/kOKhijVk51H9oQkcp3FEjhbO
	ikP1j0dF98dDEB3JTu+kuX8tBCoyZX2kIHEv2JrcLOsq/qRQCKmOuoHCKjo96gCj
	o5H/9xu86LKxMhDVtjDcqdyB6omM998aVMxlHOKz5RMRQo2bkzWJ7LOFCwDFMWoj
	02+nAqkgDVf2dPYYcW04RuJCCy+kvujawYJzwkyobGkcHHj2Kb/St8TFRS+dtGOz
	hc3hgSuFKEBqEJfnToA+O1rq8qInlL4l7EoVsh1OUc1N+6flAFajWsbkB6AhWL3k
	dHC45TivH0V41z1iBZf1QXTEvnvHAYMln54R1N7HhpgDp+CmtHSLqzSqOUGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709548770; x=1709635170; bh=mG912gQTmPjz/3zMMn8Uzbaq1vD/
	pmHiJ9ZjxhV3dko=; b=WHJO0oNeH6AP/8U3sx+jjnK/pB0YR1T4K6eucFsP1z+k
	LUQUSOk3p30l6Nac19fAqXhpbb64qxdqCRGO1GBYmzbrkSVQiIFAM7e73pmUm9CL
	XNIkaFk+FrEZxdxvzs5LpWOs9Gk1b6pI4pVD8EPI5iIXb0bnbATI6vfrM/JP1z2H
	aqjalMpC8Vwo58X3fRfH6U8UFjHaHKM7BDcYxsCX9+9e0FRluPIMC5sJNGY7ku+2
	Qr65gTZ6rHiTDwDigjINfIWLP0EXXZXwL2NhvKrnyQX/emYKD2DnQ/P6TFT5AIbL
	vYlhH8J6MAk9WPMQhIh8bFqtmztxz/5CO1F7NSikUg==
X-ME-Sender: <xms:4qTlZQ4331GT5d18nxmI4hzjiTQ1yWXez9o7l0ElIEIKH95qoYjTGQ>
    <xme:4qTlZR4hX5Qsm6d9QxEO6_ZZDqBbVtS3DQPXejRzarY9A7aY16k_8HgsAfWxIiO9F
    1PC9zcVSlZX2yvVLA>
X-ME-Received: <xmr:4qTlZfdlSieJ3V4iQQGdKCnmYwYC6_CWDj7V4wHdI4R4a3klw1FKmREg5efU8nuq8nEsaFFfssgSmSO7kNiPgNywihb6gbqWL2FTDnyTFW1bSIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:4qTlZVLA4AgnpEHfsX1eXd9e0rprhdevBZsltobQD95L8yeXVq3nxQ>
    <xmx:4qTlZUJTV1izR_liZq6sLoc8C--cukDNnY5Ccyirzk08RxlQ0coc4Q>
    <xmx:4qTlZWxbuo_lQzKYa8A04NU2IrmpVQxbVY0oh85XKEB1O0Meks6iiA>
    <xmx:4qTlZbXGTGN5AKCiN9EOmCBLvDt07rmQcusspCnOQGjnjrj5dfxLVUK4Lh8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:39:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 265e3f1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:35:04 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:39:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/12] reftable/record: reuse refname when decoding
Message-ID: <ZeWk34iSgTQllpFc@tanuki>
References: <cover.1707895758.git.ps@pks.im>
 <3ba697036c1db3837f46775823a7bd55602b4bac.1707895758.git.ps@pks.im>
 <CZG9VJKP1EA8.432Y9U39737O@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j35RJ/U3qompCoqe"
Content-Disposition: inline
In-Reply-To: <CZG9VJKP1EA8.432Y9U39737O@jamesliu.io>


--j35RJ/U3qompCoqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 11:06:52AM +1100, James Liu wrote:
> On Wed Feb 14, 2024 at 6:46 PM AEDT, Patrick Steinhardt wrote:
> > This refactoring is safe to do because all functions that assigning to
> > the refname will first call `release_reftable_record()`, which will zero
> > out the complete record after releasing memory.
>=20
> s/release_reftable_record/reftable_ref_record_release
>=20
> > Furthermore, with this change we now perform a mostly constant number of
> > allocations when iterating.
>=20
> That's awesome!
>=20
> > +	SWAP(refname, r->refname);
> > +	SWAP(refname_cap, r->refname_cap);
> >  	reftable_ref_record_release(r);
> > +	SWAP(refname, r->refname);
> > +	SWAP(refname_cap, r->refname_cap);
>=20
> What do you think about reversing the order of the `SWAP` arguments in
> the last two invocations? If my understanding is correct that we're
> preserving the `refname` and `refname_cap` fields so we can set them back
> into a freshly initialised `r`, reversing the args might make that intent
> a bit clearer.

Yeah, fair enough.

> Also, since we're unconditionally `memcpy`ing the key into `r->refname`
> below, can we avoid the `SWAP(refname, r->refname)` call altogether?

No, otherwise `reftable_ref_record_release()` would have already
released the underlying pointer of `r->refname` and the call to
`REFTABLE_ALLOC_GROW()` would always have to reallocate it.

Patrick

> > -	assert(hash_size > 0);
> > -
> > -	r->refname =3D reftable_malloc(key.len + 1);
> > +	REFTABLE_ALLOC_GROW(r->refname, key.len + 1, r->refname_cap);
> >  	memcpy(r->refname, key.buf, key.len);
> >  	r->refname[key.len] =3D 0;
>=20

--j35RJ/U3qompCoqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpN4ACgkQVbJhu7ck
PpQtZw//egLS/8xqDpe9qVBcTEfLQJ5LwT7eHMsHl2RIrkJj3jtsowRRu5lyBhPm
5/OPnpNTApL8ch0f4qqhgWcWj2VLKUmeXQEZHGL3fUFXwOVFcj4gLe0HTIgF+lEX
qpjZUQIm4w3lnEpllWUggKOh5OB/XBQ3PWAuQqK/qCY0bqJcy8v+R/XyclRHhikX
L/02A0YOPyqfdbbuPJL81lwztU2WI0vttrXFQgnAHbcoblzGeY5y9fZAlseBLA52
p5i6lPoxFjBiVr3Umy8DQNt24EcO3fpazHz5Mni2mp+dLdvRukesq/hrqDnkw4Gg
V5PqTfNWrT4S/i97E6ypvJLo3zjXo75a6X8huSL2blIm7VEURO1PqxN7eSMBa8qQ
xegKwpbwmygwBJY5V+RH3PHztiPJsBNwgd4tt7XwNq8X/oGJWSISo7E4Jz3YIALB
7Bt6U8KQxM9OORMFHMlUDokwN2RUai2D3ejizwQiSYzW0IPMjBPYVfBiBkug7Xde
9mMdtwCtp3uk2t6OdSucsKbKsnP1U45NN4eL6aPk8toiMKXivC+JnqYyleXH34jm
hoQaD8lWE/wbe5/MI5mXuBl74xLfY9Y1IXlUERb7JhO0kncr3inNTy2W5f7YJGyz
G27WcboWCda6+uXEVdJdvK9UT2NS44SAEKKnaWLfknhmZP0mPis=
=v46y
-----END PGP SIGNATURE-----

--j35RJ/U3qompCoqe--
