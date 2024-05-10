Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250EF161B6A
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341627; cv=none; b=uThFrTNC1pI1uSuYGa2iqPnGkqYrmDRiWC59U9JiztO5xdVVqvVutoCAjzcxkdHf8SWhMKBOzddQnKd/A/yZL3eSgYx7idpfjSt2TquoGrNdSoS7MCt/UtOMLcooMzQ4UYUKSNF8zslBEEwBwPnhUVigYMgk0vYl0qwIFKlmx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341627; c=relaxed/simple;
	bh=FPQpm4EAhhugGdqKMw7wJUcgV6Tj5zPYMLMkWN7xU4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg40U1zmwiCCw1P22pUHJhIK6OweYqiRodoMIjlCcGKNZef5hS0Mho597wFNu3Enk7kUAicSEZ5UoeI6wgeHZwc2SyDOkZ2KR29KiBySMCpttCJINPzaPHT7A9pza3bQtVOHVhO7irzKQI5u6NE3T7j2vQCPDyME/K63fzjkcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DQntUqVo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aIFsDx7f; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DQntUqVo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aIFsDx7f"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 36168180008D;
	Fri, 10 May 2024 07:47:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 May 2024 07:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715341624; x=1715428024; bh=UqWJwufRmr
	2CC+WENvZFV9zDkvCuwHpCU6lDej8Ag4Y=; b=DQntUqVo9Ebq4iIPrUMKuHndtJ
	XVa2ffND2IHU8J2FJTrBtpCpWXCkkQA9zndlIxgI7LERgRfZaCuk8Md15gPPWhV/
	kl/SNo1amlk6+7VuZK+t+q2gI01FNKIiFdeb4rD2vQawxlGYVYK0y8fqIsaMdHE7
	H6DtdCxUc32oV2lef1GzhYUPGsvHu5zaDvTh23b4bz5kr66asGH5lXKdJwB0ON5n
	I+bzI1eDU+cAjWCsx9ClJVHS+mAeAbwp5wNlrpDyPOmhnmq5Zf5ERNHqr9zjTvKr
	g1iCL6wRhqF2qb6I8vwB/tdhRPCzSm0SsrTueJ1KyuyDsaHgfRl8OPVqEBeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715341624; x=1715428024; bh=UqWJwufRmr2CC+WENvZFV9zDkvCu
	wHpCU6lDej8Ag4Y=; b=aIFsDx7fyJOSvSlN7Rd1k4oxhKMf9f3G5I2oz66r1t/P
	PqXKoIvpwDTcqjb0zMU+ynd7l4wMvp/cL1r8dfloqO+3XGxvVT9QZyJJ3AaWufKw
	jG49BG4Dq3w/7548oUx2WnYhrLOXdVQ9DPIA2HC8s7j3Dgsa4Q4HaZduI1BJuuN/
	GYDpRav0fLTRsRQQ4vUzGugMcvcNNEyT33Aa0Sargm7Zx/SMtTFPg6UKf2pM8+Ne
	w6RRBTgkUdNv11GzLyaE/Aud3pKvCRA0P8MGFcqRENZGb9e4igc7As/y5T+tWsYT
	6gTA1IL7Qx3X/w7zES3WxGEu/yTlitKuYbZiQrQ6DA==
X-ME-Sender: <xms:OAk-Zke4mYtvDg7QKyoIFU5IKAjjRZZ_YEng3oGAqlM-ojW_csJOnw>
    <xme:OAk-ZmNcbUcYJ7jhhrVTmPVi9X_STz9dTMadir6OxF9KF8OHIszQMKFpK-C2dqgJv
    EflzvZkV-ju4e8PmQ>
X-ME-Received: <xmr:OAk-ZligNadGW94kVvvPqUPGQCUwoL-oNjSpNrzJlLs8y1DFKj3cKmIOpmZvV_xgLYzY6UB58AI8XPBfDablHbt-h6D1B1DdwRIl-_1RCJOe4ez4mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:OAk-Zp_B58X2JWTeUACGW4KmBY3p249jwwTuRmz6OMIB3q8fOUAsNQ>
    <xmx:OAk-ZgsPehi4lsdCfAwLbnAqjBUlK7cSc1RMGmeF5z-xXBlV765hqg>
    <xmx:OAk-ZgHmhv4bDE9dMTfeVTRekQyqJH3lGEHweuXGhcFdhuxcbCKubg>
    <xmx:OAk-ZvNlnutCRakzY6lmrWd7XVFrZXl618ahnwvYv75nLtXvwAMiuA>
    <xmx:OAk-ZqWwDEu0aVh7_xWD5vx2XFb1jrYKpo-7qTNQ-Nt-zuCAmhYef73R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 07:47:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 19e0fa3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 11:46:49 +0000 (UTC)
Date: Fri, 10 May 2024 13:46:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/23] Documentation/technical: describe pseudo-merge
 bitmaps format
Message-ID: <Zj4JM3ATSMice5do@tanuki>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <43fd5e3597151a86254e18e08ffd8cadbcb6e4f0.1714422410.git.me@ttaylorr.com>
 <ZjjEjNRp2BAMWJ47@tanuki>
 <ZjkHT9XVl7ua8E14@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5TpDqcP6hXN44sft"
Content-Disposition: inline
In-Reply-To: <ZjkHT9XVl7ua8E14@nand.local>


--5TpDqcP6hXN44sft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 12:37:35PM -0400, Taylor Blau wrote:
> On Mon, May 06, 2024 at 01:52:44PM +0200, Patrick Steinhardt wrote:
> > > diff --git a/Documentation/technical/bitmap-format.txt b/Documentatio=
n/technical/bitmap-format.txt
> > > index f5d200939b0..63a7177ac08 100644
> > > --- a/Documentation/technical/bitmap-format.txt
> > > +++ b/Documentation/technical/bitmap-format.txt
> > > @@ -255,3 +255,182 @@ triplet is -
> > >  	xor_row (4 byte integer, network byte order): ::
> > >  	The position of the triplet whose bitmap is used to compress
> > >  	this one, or `0xffffffff` if no such bitmap exists.
> > > +
> > > +Pseudo-merge bitmaps
> > > +--------------------
> > > +
> > > +If the `BITMAP_OPT_PSEUDO_MERGES` flag is set, a variable number of
> > > +bytes (preceding the name-hash cache, commit lookup table, and trail=
ing
> > > +checksum) of the `.bitmap` file is used to store pseudo-merge bitmap=
s.
> >
> > Here you say that the section is supposed to come before some other
> > sections, whereas the first sentence in the "File format" section says
> > that it is the last section in a bitmap file.
>=20
> This is a quirk of the on-disk .bitmap format. New sections are added
> before existing sections, so if you were reading the file from beginning
> to end, you'd see the pseudo-merges extension, then the lookup table,
> then the name-hash cache (assuming all were written).
>=20
> I think that describing them in the order they were introduced here
> makes more sense, leaving their layout within the .bitmap file as an
> implementation detail.
>=20
> If you feel strongly otherwise, let's clean it up outside of this series
> since this whole portion of the documentation would need to be
> reordered.

I don't, thanks for the explanation.

[snip]
> +=3D=3D=3D Overview
> +
>  A "pseudo-merge bitmap" is used to refer to a pair of bitmaps, as
>  follows:
> --- >8 ---
>=20
> > > +For example, suppose there exists a pseudo-merge bitmap with a large
> > > +number of commits, all of which are listed in the `WANTS` section of
> > > +some bitmap traversal query. When pseudo-merge bitmaps are enabled, =
the
> > > +bitmap machinery can quickly determine there is a pseudo-merge which
> > > +satisfies some subset of the wanted objects on either side of the qu=
ery.
> > > +Then, we can inflate the EWAH-compressed bitmap, and `OR` it in to t=
he
> > > +resulting bitmap. By contrast, without pseudo-merge bitmaps, we would
> > > +have to repeat the decompression and `OR`-ing step over a potentially
> > > +large number of individual bitmaps, which can take proportionally mo=
re
> > > +time.
> > > +
> > > +Another benefit of pseudo-merges arises when there is some combinati=
on
> > > +of (a) a large number of references, with (b) poor bitmap coverage, =
and
> > > +(c) deep, nested trees, making fill-in traversal relatively expensiv=
e.
> > > +For example, suppose that there are a large enough number of tags wh=
ere
> > > +bitmapping each of the tags individually is infeasible. Without
> > > +pseudo-merge bitmaps, computing the result of, say, `git rev-list
> > > +--use-bitmap-index --count --objects --tags` would likely require a
> > > +large amount of fill-in traversal. But when a large quantity of those
> > > +tags are stored together in a pseudo-merge bitmap, the bitmap machin=
ery
> > > +can take advantage of the fact that we only care about the union of
> > > +objects reachable from all of those tags, and answer the query much
> > > +faster.
> >
> > I would start the explanation with a discussion of the problem before
> > presenting the solution to those problems. In the current version it's
> > the other way round, you present a solution to a problem that isn't yet
> > explained
> >
> > It might also be helpful to discuss a bit who is supposed to create
> > those pseudo-merge bitmaps. Does Git do so automatically for all tags?
> > Does the admin have to configure this? If the latter, when do you want
> > to create those and what strategies are there to create them?
>=20
> The pseudo-merge bitmaps are created by Git itself, configured via the
> options described later on in this series. I'm happy to add a specific
> call-out, but I would rather do it elsewhere outside of
> Documentation/technical/bitmap-format.txt, which I think should be
> mostly focused on the on-disk format.

I think what throws me off here is that you already go into the
non-technical somewhat by explaining their usecases. This causes us to
end up halfwhere between "We motivate the changes" and "We document the
technical parts, only".

[snip]
> > In case you have multiple pseudo-merge bitmaps, is the whole of the
> > above repeated for each bitmap or is it just parts of it?
>=20
> The "pseudo-merge bitmaps" section contains a variable number of pairs
> of EWAH bitmaps, one pair for each pseudo-merge bitmap. I think this is
> covered below where it says "one or more pseudo-merge bitmaps, each
> containing: [...]", but let me know if I should be more explicit.
>=20
> > > +* An (optional) extended lookup table (written if and only if there =
is
> > > +  at least one commit which appears in more than one pseudo-merge).
> > > +  There are as many entries as commits which appear in multiple
> > > +  pseudo-merges. Each entry contains the following:
> > > +
> > > +  ** `N`, a 4-byte unsigned value equal to the number of pseudo-merg=
es
> > > +     which contain a given commit.
> >
> > How exactly is the given commit identified? Or in other words, given an
> > entry in the lookup table here, how do I figure out what commit it
> > belongs to?
>=20
> They aren't identified within this section. The extended lookup table is
> indexed into via the lookup table with an offset that is stored in the
> `offset` field when the MSB is set.

Okay. Would this explanation be a good addition to the document?

Patrick

--5TpDqcP6hXN44sft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+CTIACgkQVbJhu7ck
PpRt/BAAqh1t1e+iaSVcc2EWiVWV269X/pdoeqeqNWW7yEr3xRTPKl5jXy1mRinP
E5ao2NvSGlnR9nucb9Jzq1XgyBVbXfaunPlmxkC4+OkGcGNLID/1M42Kqat51LBk
eO65RwISbXHMoztRn2ze/C8edc51M+u4NZ7SVHkRbABR9GOdVuCTsg/BXH6n6XK4
nGv4WEoLVHf7EMC7tkdHqci+IZOnnqWy5SESMPJRELPRpoEqtqqQnb5wYwTQyETk
Bdr38ZWRKlktdyQdWmUUTsCZj29RVIBFY8i9UDSEu4s33IjRrAevEsz8sy3a5gop
w+NCZbR+1VXe+ZlC/2pVGEMKdvIoCvCkRdUyJ7i8NPjCqAkX21qhdWsgUkx0T6y3
mpm1ZRxE9LGZUewGwf3mXRws2iM6+gtSSRQhRDJdU6GJ3xe/CqaZcvFVH0KrIL7M
3/dO119ilS2c4Hjk3Iogq9/bqt6371r8H1MjRHXhxV+6EI0qXgqrVY9euziOoIPJ
eK1SrJj6nw4sovfi3onNwJoiRK37/4B2RJOxSJW5Vdyl0CCrhis+OtrlPGI6pNDD
pSLCzqH0EResGMDLriA4X06F1/806RTc7m4hUDc5HJpldmofY9J/BUh9sTdCtPDx
64uRpNX9l4vXtZEkqJSuQrpmBodM1EOPbDPvEuqe0dK238/TWM8=
=ORMt
-----END PGP SIGNATURE-----

--5TpDqcP6hXN44sft--
