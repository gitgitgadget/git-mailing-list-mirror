Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2813D516
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726301; cv=none; b=ryokKLfxEYJltgRUnYIZi9pPD8nWj4sE8jpHyTtOOPowEuzjzDVPSA60YIV9N/rxv2XJaQNLDbPm8xx97/EQgOxRq32RzEPhIIQBQ4NFlo20Op1n4iaVQG1f0XNJ/ePScCEQncTcL48IK5OC8sld1E6/64p57Dlgvhf9flCGbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726301; c=relaxed/simple;
	bh=M4MhHOJ7FG1FNZJpiYOco6Hu9gRrY4i4rD8u0vfED8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1Z7cXafNYHL8evhskQT00KiV2ZRqkMqDtJycF3dme2ezYMhib4wXO3kKw9vXQCNvHtewymaTbzfGsnODBu+IlzNijt2U+TzM87TFLo3no7VK25chSw5Sp3ZBU8QW/+8hp/W72XUFjA83bNpVHpcw3/1THymORyR1wD7a1NnQ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ps+Y2Uaa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GIVeKAIP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ps+Y2Uaa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GIVeKAIP"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id B7801138008C;
	Mon, 12 Feb 2024 03:24:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 12 Feb 2024 03:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707726297; x=1707812697; bh=oJi8lVvqGq
	9NxZtPQ4ZcI1JPLR/5PJD/7puzj1DdKx8=; b=Ps+Y2UaapH5m/fAwnNHut2pnpv
	GjYSXaIcwr3eiEIKe28oJTtEds8DOrbIgWwHkEc4EVj0NA20k7ZqpQEjStx/0p7O
	eBrDzuEyOl0B5EzAWTo5DpnvJn9lnzzLXBnRGK5c/QrFkHSGv8RNyIFaSZmNhKsD
	sYniBrxv3dsTBStZSMm/3Lq6uH+SGGQxAIcjkIWJfHekv6u2C8ga2j0xRkZoZ7H1
	1awJnCRbbGaKQ7KvWHdsaxBlEOT8781G7mC44JYcw7asjJUA/4UvckRvLvNKTm2P
	F8ghUPZrvLQ9jb50v4hXWefgmXqD4pAG/UpNwHfwoFPBV4r5BTOBA4NNktog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707726297; x=1707812697; bh=oJi8lVvqGq9NxZtPQ4ZcI1JPLR/5
	PJD/7puzj1DdKx8=; b=GIVeKAIPPlUBLZ6nXT0oZDkb1YlkxDl9fXoPj2DvfRdA
	MV2w0AtE9/VHJIG/xecUgyymtMf3g14au0MgLCmpejk99ZWArAZAqjwQmxZNwUc0
	N28B3V514D0tlvdkWb7F3uuOLWwPD6WiS9xomFpv1bhzqY+l2fOZQ/Dxvzk5ME8x
	hUg/Kh4TX8wo1EtF2MUbKvbI4ke0zvqGXGMINDTkNb58IY9SzPG3I+XX+Z2JC24f
	Kxx5zUWuD7S4pypThP2mcIuve+Xf/cgcxyBnQ6mP6439ftIEhYW/XdcA70gRwEXf
	D6l3ptUmPu4rBRiCfai93/tiwqXzhTVnWCK98BX26A==
X-ME-Sender: <xms:2dXJZQkzVhK5t06Pu_FUVUq6JxVrfHqh7VZn5qa2gjoOFf0TJT3KOQ>
    <xme:2dXJZf3sz2J_y9DAQb6Tg94WTAeaa-sVOW7iWBRVK728VPiYLxyZT1TfeahSDmGUi
    U54t473Qzucck1pwQ>
X-ME-Received: <xmr:2dXJZeqND7gHywfQKKYDwe_2DRYzPvjjE48WUCJg2MH27M_RX7vtiVUVpCv4mIE7hwrLknEtpRwCN5G8wjKSUgJjbaxqMscZLbFCPAbPFQk7uwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:2dXJZckUu1zmSz3p80BMBVW2ba2VG9Y-HY7serU9tJL779F4cfuX1w>
    <xmx:2dXJZe0z5EPern7BkREa5k77838JJW9XmucDZ6aOSaU-KFwDAPWfng>
    <xmx:2dXJZTumM9RppXC1C1aySlvjlwVUqFtQF2MxKbGPynMrDSYfANec0w>
    <xmx:2dXJZcDxtu2KiYjk1qCSYDW6KLzt8CVHCK3i65tORZN4zQyfJZtY_A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 03:24:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd9ff4b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Feb 2024 08:21:09 +0000 (UTC)
Date: Mon, 12 Feb 2024 09:24:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: John Cai <johncai86@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/7] reftable/reader: add comments to `table_iter_next()`
Message-ID: <ZcnV1ULJaurT99tJ@tanuki>
References: <cover.1706782841.git.ps@pks.im>
 <2f1f1dd95e1cc360bde3547bd18e227a9c326e13.1706782841.git.ps@pks.im>
 <5335108F-4A21-4429-9BDF-3923D96884C0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/vvD98pofO4lOgXJ"
Content-Disposition: inline
In-Reply-To: <5335108F-4A21-4429-9BDF-3923D96884C0@gmail.com>


--/vvD98pofO4lOgXJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 11:01:13AM -0500, John Cai wrote:
>=20
> Hi Patrick,
>=20
> On 1 Feb 2024, at 5:25, Patrick Steinhardt wrote:
>=20
> > While working on the optimizations in the preceding patches I stumbled
> > upon `table_iter_next()` multiple times. It is quite easy to miss the
> > fact that we don't call `table_iter_next_in_block()` twice, but that the
> > second call is in fact `table_iter_next_block()`.
> >
> > Add comments to explain what exactly is going on here to make things
> > more obvious. While at it, touch up the code to conform to our code
> > style better.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/reader.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/reftable/reader.c b/reftable/reader.c
> > index 64dc366fb1..add7d57f0b 100644
> > --- a/reftable/reader.c
> > +++ b/reftable/reader.c
> > @@ -357,24 +357,32 @@ static int table_iter_next(struct table_iter *ti,=
 struct reftable_record *rec)
> >
> >  	while (1) {
> >  		struct table_iter next =3D TABLE_ITER_INIT;
> > -		int err =3D 0;
> > -		if (ti->is_finished) {
> > +		int err;
> > +
> > +		if (ti->is_finished)
> >  			return 1;
> > -		}
> >
> > +		/*
> > +		 * Check whether the current block still has more records. If
> > +		 * so, return it. If the iterator returns positive then the
> > +		 * current block has been exhausted.
> > +		 */
> >  		err =3D table_iter_next_in_block(ti, rec);
> > -		if (err <=3D 0) {
> > +		if (err <=3D 0)
> >  			return err;
> > -		}
> >
> > +		/*
> > +		 * Otherwise, we need to continue to the next block in the
> > +		 * table and retry. If there are no more blocks then the
> > +		 * iterator is drained.
> > +		 */
> >  		err =3D table_iter_next_block(&next, ti);
> > -		if (err !=3D 0) {
> > -			ti->is_finished =3D 1;
> > -		}
> >  		table_iter_block_done(ti);
> > -		if (err !=3D 0) {
> > +		if (err) {
>=20
> what's the reason for moving the if statement that handles err down after
> table_iter_block_done?

Good question. Ultimately, it's a simplification because I just merge
the two blocks which checked for `err !=3D 0` into a single block. There
is no need to mark the iterator as finished before calling
`table_iter_block_done()`.

So becaiuse `table_iter_block_done()` doesn't inspect `is_finished`,
these two implementations are in the end equivalent. Before:

```
if (err)
    ti->is_finished =3D 1;
table_iter_block_done(ti);
if (err)
    return err;
```

After:

```
table_iter_block_done(ti);
if (err) {
    ti->is_finished =3D 1;
    return err;
}
```

The latter is much easier to reason about I think. It's also more
efficient because there's one branch less.

Patrick

--/vvD98pofO4lOgXJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXJ1dQACgkQVbJhu7ck
PpT80A/+Nf+49LUKEU3HzjLmXk5usP1TxtkACT3JBB1OvoFlgisDb1Di7VmkUPFM
QhUdAwtT1lvGn51Yb2VL34RxNnM51EYOq3ySxAykQk3Cp5Mqq4KZ1Q40tKHyFA1x
KqFMwedfDDVWoUwEuJY+aHHHNqhR/us5smCIvEGB5X2dupHVT+7KP1PvzjsjQQnC
F+MCLT6Kyoacqc0GdaDVc0h8M1YnqwDm8bqlZnOc4WupzHhuSqveXerrvxq7r8DD
Y7MHnOIuexCiR5mw6767GypUe4/rn1klYY569ltEDUHAwffBDxDij2izr1Oop/pm
0ubspJS9l4GC2XiyE+My/0zM+4jQoylhDwdcNaB0rU+mIWf6Fy4nyKUi4A0WQGUw
weHJufVjMFRCXNaGW159huMk3NQ2Zjnz0w9yfL5G2FgbR5OfaAyptI+2FM/hF7S7
gvZltoo9d3VlEcs4JLx4iwAIKkASiqrwY8+NhnKtMIEHYM/qc52CJDZ8RsxX1W+A
EqY4+L/peBYu2+73/phXHCpDKtO0o0gbyRG1Gn1yb3DdULCfDmvdNVx/bFqRyOwT
BXEV0yOSeOnauqCAccUyLjOQ3++Wf47XWbteG7jYtZl7s7G4Bd/Vp9MeB+JhkrU3
GLDZbTr183A3G+pUfH35uDbHYmLrS/20OUVeF9BpKBazRnHHEH0=
=s9iP
-----END PGP SIGNATURE-----

--/vvD98pofO4lOgXJ--
