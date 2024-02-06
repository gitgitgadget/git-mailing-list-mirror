Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CB383CC8
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203046; cv=none; b=kz1xTGvNPkfWxupFaL8YSpyhiSzp253nKquSMOLdLfrVS7ykt4zlwCXud1C5KE6zt2k7IZ0Sn6PYz6XalOhqkeCA1CqPBnBgNdezCXQ9YZFJYmPJNclOwT2AJPWgv2tX3MgCK0VMVwno++lykljCcMjZakT0ltUSJhzBQZHiki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203046; c=relaxed/simple;
	bh=zVa/qEP4qrXMDjr4alMC5QtgtUt5OaxoB+X0PYZykhE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9fRQMkyo+xz4ucg4XkG4daDjI7PFN3dzNNN7u37S2M8AH55yyq4HwS55HZRk/9MQKgABGURZ6tjuTfg3sSNetilo4b/4jy0uJzrXN5JQYE1yQB9C+QXac/85rT88vGAHOFR+hzP0Dz+HbbwKA1VhfLgsRfSbHlEiqlDSFFL7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AQgsjz/G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bh2Ekx4o; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AQgsjz/G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bh2Ekx4o"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id CEB643200AF2;
	Tue,  6 Feb 2024 02:04:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 06 Feb 2024 02:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707203043; x=1707289443; bh=wVrXSOMGSY
	8F/jlXhaSDPDSK7OGaP9thac3REvDxHic=; b=AQgsjz/GSUBFNdVx+ZBGba4yn3
	4V4zoj30Waa8790fNZ5nf+TLIc03S0pF2wmfM71DXFadF9QbaOdL77esBhxkmQKZ
	V2BulbUJpS7GVbZEXwNIu3Je7MgrRsFBDxdEifv4gQcMdt+Jytnb7o3LXqdLerF8
	cUGzO/jWTPp23Q3X5Cs43Wd9v5z+ku3VjsZKnD5HVMXEYIargnn7lbCYZbmPBFCr
	83OQHvjLTQYYznjaYG2TE5y6++kN9t/gk2HdunLhY+a/YGHyu7vfPCnNT7ZKdg8F
	eJ3mZh0CYlH/9n1W4cbXmGlR+45/FC/JtIUsnn/REueNzGyzy7H1Gw+MexFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707203043; x=1707289443; bh=wVrXSOMGSY8F/jlXhaSDPDSK7OGa
	P9thac3REvDxHic=; b=bh2Ekx4oyIzjJMTdld+zOhuohzOonDRoeVOHWzWEo771
	Eiyw9/wYidGvmUx1LKlR2qcWs/qy8Fthg4bbzZqzlHZhbTR0iJ+j0SQuj9nXyXC8
	r9xL6Gxj7QL76PK36JYHwXirnP2rvtLKah1PnkAFd9wVEcgJoFChKSjHDIR1gkgW
	tx9dVALHQ47uHRRlWkr4m2a8sTu2aXKjCnWuayEDL9lKyNvHGqI0cMHDo2LPRj59
	W3Pl8T3eXluXBDa5b19Nz6hkKO2BgUuaS2CzBoJQKU6kMnfeCJBXfn4mfu20JQci
	VN6akf4snNUE0JlulvGhWByN8wiuf66pcVVjlajLtA==
X-ME-Sender: <xms:49nBZen1Y1YeHGo090n5A2hdOU764nLzRem4S5EoXXLK5jmyZU_fIw>
    <xme:49nBZV0mQaC94ovuM60FhTKxUBUcWXKfkCuW5ne_dPTERWEwpKX3W9uk2XMSfzOmm
    GnxuWwKpRjRorwKjQ>
X-ME-Received: <xmr:49nBZco7Ub8lUgTtwrzKIQ-wb4lLQ9ANWXcfPzt6oBIWDOUVQwPZtFe1xECdhfEG_-29g9MquZptja3lEoEsrVP5-yMj7iLtLUrMZakM2kTrFaN4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:49nBZSldaQC61BCP2MZ8a9lqetyM_df4ssk3SQ4eZwrB5dq4ce8TSg>
    <xmx:49nBZc1En4Jgr33jYvKhUChzaInIMBbWrFU3MNSFBIsLURIuPyPJhw>
    <xmx:49nBZZsVg2loTN4QepIZayIWyYo-C8LPoBDfbHRNZ5x2jfhzEBcebg>
    <xmx:49nBZZxzYE4bvF7_z6JzT2ZT_FBhpOhknDB-m3MJKKrHx4nnnQ5Y9Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 02:04:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f3065961 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 07:00:32 +0000 (UTC)
Date: Tue, 6 Feb 2024 08:04:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2 5/5] reftable: document reading and writing indices
Message-ID: <ZcHZ4HM8f1eGr710@tanuki>
References: <cover.1706263918.git.ps@pks.im>
 <cover.1706773842.git.ps@pks.im>
 <c3492bbd42b9d2c17764208e814faccf395cb282.1706773842.git.ps@pks.im>
 <oslbbspnu4spohamhenhxyqv23fct7ltuqkdl67liw774opxwj@jjprhh7zy34o>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="acQPUkNOmUQj78Cq"
Content-Disposition: inline
In-Reply-To: <oslbbspnu4spohamhenhxyqv23fct7ltuqkdl67liw774opxwj@jjprhh7zy34o>


--acQPUkNOmUQj78Cq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 07:43:07PM -0600, jltobler wrote:
> On 24/02/01 08:52AM, Patrick Steinhardt wrote:
> > The way the index gets written and read is not trivial at all and
> > requires the reader to piece together a bunch of parts to figure out how
> > it works. Add some documentation to hopefully make this easier to
> > understand for the next reader.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/reader.c | 27 +++++++++++++++++++++++++++
> >  reftable/writer.c | 23 +++++++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> >=20
> > diff --git a/reftable/reader.c b/reftable/reader.c
> > index 278f727a3d..6011d0aa04 100644
> > --- a/reftable/reader.c
> > +++ b/reftable/reader.c
> > @@ -508,11 +508,38 @@ static int reader_seek_indexed(struct reftable_re=
ader *r,
> >  	if (err < 0)
> >  		goto done;
> > =20
> > +	/*
> > +	 * The index may consist of multiple levels, where each level may have
> > +	 * multiple index blocks. We start by doing a linear search in the
> > +	 * highest layer that identifies the relevant index block as well as
> > +	 * the record inside that block that corresponds to our wanted key.
> > +	 */
> >  	err =3D reader_seek_linear(&index_iter, &want_index);
> >  	if (err < 0)
> >  		goto done;
> > =20
> > +	/*
> > +	 * Traverse down the levels until we find a non-index entry.
> > +	 */
> >  	while (1) {
> > +		/*
> > +		 * In case we seek a record that does not exist the index iter
> > +		 * will tell us that the iterator is over. This works because
> > +		 * the last index entry of the current level will contain the
> > +		 * last key it knows about. So in case our seeked key is larger
> > +		 * than the last indexed key we know that it won't exist.
>=20
> The last block in the highest-level index section should end with the
> record key of greatest value. Doesn't that mean the initial linear seek
> should be sufficient to stop the iterator from continuing if the wanted
> record key is of a greater value?

Yes. But we only notice it here when calling `table_iter_next()`. The
call to `reader_seek_linear()` will not return an end-of-iterator
indication.

Is there any way you think this comment can be improved to clarify this?

Patrick

--acQPUkNOmUQj78Cq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB2d8ACgkQVbJhu7ck
PpRRTw//YwfbcVLZYW8YvaWtq+sEvSiHYVUu5MobEsSiV17xBxIxfs/BeyB80OLC
0kLClP/DAwfcRiOfWe89EEuyyqlh8c8Vv4V/yEdtQvektQ2reBdh4HTvY8xbmafX
WEuUvvMxv0Vqr+TYey6wutKjv6Cm5ZVQGWMvG7de1PiOsdB3frif5p6FfOM+bQAy
GuUQbwbKvQrv/k+b0OC/4qEFO5JcHcivz2PkPMoz/9QglnelHsLJfLhJV8Bfs4/G
Kc+7V746cNKkoT+z28xhobKb0jlanzLSyQJulE3Q4HIZnZJTeXuFDnO5ZoNwTOmt
fPHKmmd2HnISZaFCu96B0hgYgcKs1EJU46XpLBn33pDVu69oTcvKoIBhMQy5IJGV
LgosF7I/RKDabPXXrO6tCcSaFCAwV1eeb8+cX/3aqffOr/k8OHhu8lnzimnD8CBC
PTwemxxj/VXaK45T9H28HgiX38n3Eqd1+fpSDIQQYNfE/jlHorNqtHGEk71E5D7b
DLSTfvTR5C8mNcYF5b7siAl/kUoL21oY5AF8VIXeADK1zebpi+AHxuO4KtffZ7nH
QdBsOmy6Xnk19WWRFwq/TTLQHmiqrt2aJNqLy/0NDCyEuvElk6+WwxOiFsWNxzBY
d21mMM6MFylvwGquRDbuQ0F2zQlqRnOXxrxXK7HSqtO46m/osf8=
=MZ/7
-----END PGP SIGNATURE-----

--acQPUkNOmUQj78Cq--
