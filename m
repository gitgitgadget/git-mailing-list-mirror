Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17514C59A
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728403; cv=none; b=qUxplGx21aKyjwwGas2lyiz+bx7l481hrqXOIh0ywnm768OZ7+d/e3AORVNR1QOUy+RuRxQu7h1o0pi60CAIcKg96vIVJL58BSebQOyqmTPADmXbbDOUH/c5k1vPLan4XJ7Aa3KNzwmuvaHH9HwKJV6DWC/CNylELLUXraXHPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728403; c=relaxed/simple;
	bh=SUSxy/SiITJmIKA3rxD/Z9P8x96DEeNhx3sAE99zGHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYl9C4KlO2mm2EV95pLOJa6nUobj1e+JFLyNShBim3X99aV+Qd+H0C1AgR9C6C0bjScBeCwdhKhSAvnqmQBYG1gtOhRiBXOJk6l/1Lm9+lSWG8HmHSHUYoDOx82wxC0lVnhxlvFjMlMdptTvfYF9CDzrD86EMEuaL8LqoR5iN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HNTXIukb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TIA9ZOs9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HNTXIukb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TIA9ZOs9"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id A3B581380671;
	Tue, 23 Jul 2024 05:53:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 23 Jul 2024 05:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721728399; x=1721814799; bh=EEMOvwgAO7
	773SB77/8ynpVB7+GefrwDpk4DGj8QOU0=; b=HNTXIukbv5uHI1Rkk0eZa5a+cm
	CFL1RRd4wQ5jjEf/Q8EWCsb4d3Dk6aOGeDKugGeSlH/TxjFCwqaDEEUufPDPPfgU
	+ChUbl8xbS2RNybjOcTEnOA2eNtCCDTaKqAX9OXxr9J+JU/nOfpyD5FHXdR5Kl9J
	uHS2L9B5JRPCNr2kQCpzTpUAEzmDOo5LmA4Yy8aaFfTLrciZpkjd474Q/sqJc9Ov
	qICBCM3rkzBPX8qItpR89vCMqbzJlDTkkY+LtKjeR3gACYlVV8DltP6qySDFqmJk
	AWbVitugdsrg+rkBEqNYZp/Se4IvyMgYMUsD02wa1DVmbN6Hm+/hdYzya2dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721728399; x=1721814799; bh=EEMOvwgAO7773SB77/8ynpVB7+Ge
	frwDpk4DGj8QOU0=; b=TIA9ZOs9wY0CBNFZ+M8oJ8FgOv70pOVtS4VaW9Juh8pk
	cvU4e9i4QnphcYQYQR7q60tUre1x3QW3nVNQORRGdcBD0PX24E7DOfxIyagJEmnX
	Ej8DilMtwLzozTQOHERzX/+OzO6MRqgqOr6jaVmgcvtT36rD4jQu1irVeBcyE7Xw
	xDOfVKpInD9lrqAuo53zC1h0+yh2QX9pz8gPfw3uLTFikLSnlF2x7uZwgaYuaJCG
	G3andlwIBporOzoUMynEy7Wq9xFlN3tXG6i7j6So5JyMqas6MGmS6DzsZ2ddJ1Gm
	+AoyUvh+Gkd632Pt/PAUC/9SGtUCutZ9hMj3FrN0QQ==
X-ME-Sender: <xms:jn2fZoxqYB77i0QonCwXgroOT-ernJsiTGLAbAVWGc0XkBAo3m2Hog>
    <xme:jn2fZsRBzXcRcYYBp5DES-uHS86ChDqyhe8PfbYSwh7Q20pwFEnkqDiXI9PNqSZ2W
    En9M6UamGxejvyW9Q>
X-ME-Received: <xmr:jn2fZqVwi_uPjrvr8d7PDyUiD_Vx_R1FvQHfYNdVZGrjam5T5VY5i_vdeQyL5K6CCe3aC-pjHu0v3xneeGBz0RoQsmTzo0_TH6O43I1mp82NIhFF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:jn2fZmigkpQDR7WeJUAlV9aMwpPQU4jLvwUv2SO3jb5zMLPl8Uh16w>
    <xmx:jn2fZqCAr0oej9qunMh_wWw35kcDD4oXmysmTuEJqrEJXzV71jrAtQ>
    <xmx:jn2fZnIgsE5p763ndPtITwe-fcGjK3AxdCB8rlj3B-YCHh9OPg7MEg>
    <xmx:jn2fZhDO2fW3mRHpgeyK1LrUOTWWA_aMyQR2R2JnUJcvyj_LogrVdQ>
    <xmx:j32fZs2KLeqJCMTxOXcOAs2z0Zn1kx2g7SInqq-xYf3slUXK53-G6O8K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 05:53:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ed0f53ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Jul 2024 09:52:01 +0000 (UTC)
Date: Tue, 23 Jul 2024 11:53:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
Message-ID: <Zp99icyrc0rdxg9a@tanuki>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g>
 <Zp9PfdZtWJBp2xgl@tanuki>
 <71aa553e-9b10-4bc7-9c7d-5414691db79a@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kE6GcJXrXLnYsWgj"
Content-Disposition: inline
In-Reply-To: <71aa553e-9b10-4bc7-9c7d-5414691db79a@web.de>


--kE6GcJXrXLnYsWgj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 11:25:29AM +0200, Ren=C3=A9 Scharfe wrote:
> Am 23.07.24 um 08:36 schrieb Patrick Steinhardt:
> > There is of course some magic involved with how we generate the file.
>=20
> It requires magic function names and generates code using a different
> language, while for_test is a just single new control flow keyword,
> like the dozen or so we already have.  So the magic employed by the
> libgit2 system is both broader and deeper.

It is broader, that's certainly true. But it feels more self-contained,
less fragile and easier to read to me compared to macros.

> > But I think that would be quite manageable, and ultimately all that the
> > developer would need to care about is writing a `test_foo_something()`
> > function. Everything else would be handled by our infra.
>=20
> With for_test all the developer has to do is write a test with a
> description, no extra infrastructure beyond the existing unit test
> framework needed.

True, but it feels like it is an invitation for writing unidiomatic
code to me. Unidiomatic in this context to me mostly means code that is
not self-contained and thus cannot be run standalone.

These are quite obviously subjective opinions though.

Patrick

--kE6GcJXrXLnYsWgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaffYgACgkQVbJhu7ck
PpR7QA/+M80FfkxXh+g9UOwAT7DiaxdWP0pmG9DNLCGPprIQjA64rHSgsEDHTf2Z
dws729nn7P41MVNpZe2R4D2GFxbcDk1GK1PM7VtvvMygcI0RWrB3abzJVcnioYF+
XGbx2ksL4IJvhjjTZxXXQYnzpTwo4/6iCFGoZecC4cwin/3Y/qtCWdwN8h4kN9Ia
Hq8EoyNbum0wG9c1H1Qy5lCsTFFA2SHSHq27AE96MvHynMU8dudY7Yg85F/URW+L
n9YBn4sYXTSAoit0XzH5RPntr7mPgUNsIB4yCgA+o45hs7uFSjwCGSogBOiWpBOe
7mcgEfuK2tKxOZjKuaFwK/Sx8PeDy9ck/HtZumi6+DB1vRCGok/9APckByMUjkGd
QSZSCClQ1yBo/ynqn72Owu3maWPE+v5Pp2vPaUTIkcpDeYXHqqjw/Y7UO8KEF0Ap
MlwvPQKrOqgj5qRGeePs06moJydrth9moxsDnTD6A7D/Q9/+fHxDpRWX8APreRAG
mgz2IN/hd+xWe//tuZbscisGiZSsKE1D970GAanqhSRF854oU33JzHa1gTQFrFhd
Rz3/lMR0k63ogaq1zGL/TiCUtqAUEUEtwpjSFB8zlub60mV5uyn3P2HARxikXRWJ
YVJ848hsMqgQqEkNHST/nZocdCz8p9GGsnBoNnlrIcXaG85N09s=
=+OOv
-----END PGP SIGNATURE-----

--kE6GcJXrXLnYsWgj--
