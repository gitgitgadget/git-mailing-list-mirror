Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F669E07
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578262; cv=none; b=Gh/UO9TI3Pk0Ub3tC328MjniSHvmHf/n0Eq5W7dMkkRaq/DjxQeEyTaMkcf9Skx1Zc66Pxtu4qSRxfFQ/dMTwy4mFSf5hrpJu6wkNxP7lEy+Vpa3M57s05PHrG9/WFDbZAJW3KuSRwkROtmMv5ispG8Ee3dlmYPvZZqKd6Y5h2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578262; c=relaxed/simple;
	bh=zcDlG+x5cFFV9qxmuUm6dPHH6dq7NBzBUPgPXwfE9ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stztj4SduR7UnGZk0VSlY+/umqrENVLyHzwKRZXWKsJtvaBkxA/hdq0xZof6HuwuG+by6Q4kZVbC2NFk7IhSumLzIpflC+ygPnEgF8AQeC5st5kFAtaPg/Vl92k8D2W38z9H8+pWuIG5z7fMxyb/wafvEDaVBP5wWpJwi/CyF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tz+TdrXV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FaEAKnT0; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tz+TdrXV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FaEAKnT0"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 127F31380124;
	Mon,  8 Apr 2024 08:10:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 08 Apr 2024 08:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712578259; x=1712664659; bh=3GazO+utky
	Ohq1H2RycT55LyDwlQRJNd0lGDb0EH79s=; b=Tz+TdrXVJwRr9q7glCn4oIQHee
	63JUS4FcDWnmBaGmymGfKd+3N1dSgyBzcQ/TuQQxbe5HJ5IvUi2IV/44Obze+g7l
	DUWu52ATaWAj89sq6rI+m6X6255Znp0ef9CuXB/X51+CRhSyZe7h3jylEGt12s7a
	PrL0p3N2aIRwiEDOVgBSarwAnOEJV9nh77yy2WIpAHg+LZikpbSAAnsp+tHhoX3p
	c9T/7x8Gf/KL3/+I5h5SsyWO660Xy0mdpcVlSunWFByCZzOCndSvITy7dATxWabl
	vx8msV/3iFa8ITRRnnu6sCbc2b3Ny+I8WsD2lomXSrQcIyGGWzMyLUB5vJGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712578259; x=1712664659; bh=3GazO+utkyOhq1H2RycT55LyDwlQ
	RJNd0lGDb0EH79s=; b=FaEAKnT0J7nMtPKHLyPPczQBaUrIgvmWyXwWrhd/bI4n
	AAwonfsphYwWO0rKA23mNgWM26u+z5wjKPnaNXl3+NXOnmDBmjJSWXb9pax4tci0
	Gk8/MtOpU07onM9NNebinV1FOjtAT6m6WTGKGs3WZVVqaQXf4du5iKY6nsuXD0mR
	VPCqYKkomiAk1Z9rtJ9wcLko92zFzU9+C2ZU0BMtZ0VIzYmbWzPw769XjTY61DvP
	rhVTjdXptix0Z+ZG1EK7U3BtJTukhROFHI6+Xz6gmmwItS0ndRk+/Io1TWnVJtgz
	tDX2skQnM3LyJqWcKRjMX4dsFA8r7wsE6JYIxppnKw==
X-ME-Sender: <xms:0t4TZhyBzsknm2JH7xPqwDXQps2mxp51YzexicQ2GFYt1o1eT3dbtQ>
    <xme:0t4TZhQ9sgoo_PZPxFcfqiBmDkS69L41TiXxXOM6lidPUYNmYbujYKgeksa1YQKjn
    aoN99_5A6caCLeEUw>
X-ME-Received: <xmr:0t4TZrVRlE4-z4fSVwna_m5sn19D0Nt96rFBppKCOvR0qgfx4NqA1Mw3GxUxOxaRJmLZ2Ya6pFnDBcjsEl35G1A6tJT_Ww7aJA1Wgba7Cp5vJtv1yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:0t4TZjjUTkT0wZketoHh5bsEYQ1ZJp9EAcU0woHjyqeU84NJ6phQjQ>
    <xmx:0t4TZjBwHlj0a3DUwZ1q2lHXilxhlwB010Dr90XZqRW3Zx72u1XTtg>
    <xmx:0t4TZsKA52px-QIn9i1BALvayJfdqZhgILknkgIbZqrylhyTNoXLQg>
    <xmx:0t4TZiCwteOGrY1aZve9pSNepvYnscEiUnxYG4RdvqfHLOAiVaMBLQ>
    <xmx:094TZmNTVQcK8Es2sQDUC0kV17CrweBLm-U5t7-7LWtlaKwNhAuReaTe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:10:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6dec799c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:10:48 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:10:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/9] reftable/block: introduce `block_reader_release()`
Message-ID: <ZhPezL_8Ozf375FI@tanuki>
References: <cover.1711519925.git.ps@pks.im>
 <9a1253649a4dc993da7caced2f15839d988905d9.1711519925.git.ps@pks.im>
 <CAOLa=ZQ4Vq7YfUsh4mky8HsEurp3RyUEXsZS7tDU0XMc+6Gv0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yUzR8RJ7vJLxZxYF"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ4Vq7YfUsh4mky8HsEurp3RyUEXsZS7tDU0XMc+6Gv0w@mail.gmail.com>


--yUzR8RJ7vJLxZxYF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 06:16:35AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >
> > diff --git a/reftable/reader.c b/reftable/reader.c
> > index f70efa2b7c..f925570bf3 100644
> > --- a/reftable/reader.c
> > +++ b/reftable/reader.c
> > @@ -253,7 +253,7 @@ static void table_iter_block_done(struct table_iter=
 *ti)
> >  	if (!ti->bi.br) {
> >  		return;
> >  	}
> > -	reftable_block_done(&ti->bi.br->block);
> > +	block_reader_release(ti->bi.br);
> >  	FREE_AND_NULL(ti->bi.br);
> >
> >  	ti->bi.last_key.len =3D 0;
>=20
> I would expect `FREE_AND_NULL(ti->bi.br)` to also be within
> `block_reader_release`, but then you'd have to pass `table_iter` or
> `**`. So I guess this is okay.

It is customary in the Git codebase to discern `release` and `free`
functions. `release` will release all memory hosted by a structure, but
will not release the structure itself. `free` on the other hand is
expected to free both the memory hosted by a structure, and the
structure itself. `block_reader_release()` thus shouldn't free the
`struct block_reader`.

Patrick

--yUzR8RJ7vJLxZxYF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT3ssACgkQVbJhu7ck
PpQGow//SlsGAPLmVESpydIHyl24h2okezKNuP4Kq9ZF+IDzaPmNwLFnlh9PO0kb
A8z1VfGGk2v2OTNDX3WS7/BUCOsVdhbzguzW9n04DgSNrxEdl4liuWtlu8sjDrBZ
dLemHhYzjXXgXDW5JZFi6VZBYFMo2+VldbqZXfD81zXkRRplF+jTzXLUl4nenqg4
mObTGRZGD4TboQCxBqekxHez2CGRts7nn3mknl4sY9Lg7VXfTU9Nbs9iBbYW8ojy
FSa7GBBSYItJgntmZvMligSw9xBf6HfbxrrmrdHdBhENV8MOCMsyCFIvSL5l+2Xb
PCSQCJCva8mrP3Vter23jkOe5rTvxj0HK/SH9fdCWLFnszwBMTn1xRSvqGgyKCCL
/Q/c4e9/zKaHbEVYT/zQiG0K/BKrdwJ0pUZG7BWc8l1YLIypEO7lpJLaoaN3Xq//
DTR/NAJaeJz7FQCTvpqOYTGGYoNRQXVMeBy3AtcGEWtf8TjkxWhEsHpSyVrfqV7H
+vnyJJ+Bfh1/uhxlQznzZOXip6cyCXu92qOqdLrrE5I89aJ1C6FP/acuNBe5/Rr6
SqXqzsAPQ2pL7IkFxT/HNKQpe4ttmtU8kHUHL2U462NV7hXYf6oPvSbNAur+/RE8
5eYVeJpPdFSWiKzvrGZJFzjhPsJk8rLpCh0at3QN8Rctu+E6TdM=
=5gZ+
-----END PGP SIGNATURE-----

--yUzR8RJ7vJLxZxYF--
