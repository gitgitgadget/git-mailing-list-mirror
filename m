Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488E81729
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166237; cv=none; b=OID0QHt5c/ugwHLy6L4YLH+FEByYdvqySADU+MacYVY9KwG3FUCJMB6jqMasSPIg9THBp4r3Z8n8wa+JO/MFb8GMeBXmmvhpa/UJY8P8UrmZOvcHnRLTzKXZTPiwVfEykX6t5DV/MQypj/8c0zEg6Nh3jXl+KtCj5gJl+7xqa4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166237; c=relaxed/simple;
	bh=Yvr7g5uFV6Crs9TpGgA9y1KhmIXzuhsjfgcVyrrqxzE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twp3fFmzaT8SSSWPZp77sGcxYCN3LFx565tESEcmYbMOFUcgV7Z9SKNWJogOXSo5RmQ3CUHkNGmLyqV8PfRG27mHnfISf01zjRw2F6xF4BQg0yrbknbTNSJTCMsmztOA+YlQLWuKVGr0yCugPVqfX3IPsB5CbnCN/oZEkCVaFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nG8PYbMM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AbIdGsVg; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nG8PYbMM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AbIdGsVg"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9DDA5114025A
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:03:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 May 2024 07:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715166235; x=1715252635; bh=uWv1iAH4Oe
	jG5M7xt2bxYGTjSLsIGqMem0z30x9Mfko=; b=nG8PYbMM0Z9qHoWuYYjxt/KeVO
	cBRVVxcJVvo13LYY/tpUBpEMkm+aFvoDB8HAtXzxVR3TBisumJxV8RXSRtjiqm06
	3pZYaskaZ+yBd1dEwBPA4prN2c3nyBZnKjip4hWMUgod0XTSn6qp3eS+22Wvmp+y
	1H2yJon8gS0r8Lgmw8J384icof5T3Gf37bxcQ1nf7ZUWjRrRtleSlbxmw3q7Tu96
	mrDRj3fRgUyLxaNFBlePMG2CTVVSEsIsWMUjyOebU0106b05vNbE+K9I7iPrpR4w
	r0VI0QQ/2bbKgQY7N/iT0NxQjC6ZhQ6SeYafsUTfAejDhpD+Rx5WkDNCIOGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715166235; x=1715252635; bh=uWv1iAH4OejG5M7xt2bxYGTjSLsI
	GqMem0z30x9Mfko=; b=AbIdGsVgQDIWyvyvwzgFkmUOvd9Ea6+++XagIhJTlZCw
	glHh1yeO2wQlSZtTOVaeRNFYL82vnKOLLBcBwlDc9fKHANgsYpyQCx9lPKaf4M4q
	lRimtMJH4vyBq2D5bffo/p9+aYKdfJuTs+sh3sQt9vo3UrEqGSrWMiQD2Xxz1HPY
	KlLdcLPy+QKD4FSXScwITs79uM34CFkF2/f7awCt7yu8CaylsqJRwzmIuudBuO+I
	ZlsCj+OUCowGgoMLz9zV8WNr5jZjHcdquUq/bmHAaN+cI8CceN1jhBnBts5AlWgE
	Jywtn2nW5EUX5puzuuFrbtUFKYSgcgRZ7N933IZD9w==
X-ME-Sender: <xms:G1w7ZsSc0hs3PSZ3dpR8muWh84wxIdRKvuED_vCFmrkV4QKpad-KlQ>
    <xme:G1w7ZpzzKtZKWmb_9KBXVFAw4ryuYcC6_2BRZj0-fd-fS2Ttm-ig8I0dk6DApqydR
    tP41SUg8X0l8wE3sA>
X-ME-Received: <xmr:G1w7Zp05WJpnP3yZ50HrmDH7gCSVTFZ6qODHIJ5LoG3a1DW4585TnmOaCgg9xktkOUx28ghe16v8dHsDlhbK2TYcjezHUHX20_2zLyzj43qZthT_wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:G1w7ZgAC84IOObBVuBqLIvDZ1-GWthBvvA7EVM_rtVJiKbONzY7Wvg>
    <xmx:G1w7ZliehymuWAdppe6eufg6tHg4fvRl2zqBKdD3hw2QuVThE9sqxA>
    <xmx:G1w7ZsoXCFFPTc1phK_mq-dn1JdirFlM1cPqEkCqN5fHKpZxi13hUA>
    <xmx:G1w7Zogup1KX0TBiGxuAY8sKHevqHHOPDPzf5JIHsCuZjbOB4xfqlw>
    <xmx:G1w7ZlZN6DRWkGcmFx4pzS7PxYW3a7BSiS6BiKxzxRKuggxJtz1O64fy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:03:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3b011c7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:03:44 +0000 (UTC)
Date: Wed, 8 May 2024 13:03:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/13] reftable/reader: separate concerns of table iter and
 reftable reader
Message-ID: <91db2f18c105611bc85fa07fa6eb33ba600e742a.1715166175.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FhBE0Vug2BlbaGsP"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--FhBE0Vug2BlbaGsP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In "reftable/reader.c" we implement two different interfaces:

  - The reftable reader contains the logic to read reftables.

  - The table iterator is used to iterate through a single reftable read
    by the reader.

The way those two types are used in the code is somewhat confusing
though because seeking inside a table is implemented as if it was part
of the reftable reader, even though it is ultimately more of a detail
implemented by the table iterator.

Make the boundary between those two types clearer by renaming functions
that seek records in a table such that they clearly belong to the table
iterator's logic.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index cf7f126d8d..b210753441 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -386,9 +386,8 @@ static void iterator_from_table_iter(struct reftable_it=
erator *it,
 	it->ops =3D &table_iter_vtable;
 }
=20
-static int reader_table_iter_at(struct reftable_reader *r,
-				struct table_iter *ti, uint64_t off,
-				uint8_t typ)
+static int table_iter_seek_to(struct table_iter *ti, struct reftable_reade=
r *r,
+			      uint64_t off, uint8_t typ)
 {
 	int err;
=20
@@ -403,8 +402,8 @@ static int reader_table_iter_at(struct reftable_reader =
*r,
 	return 0;
 }
=20
-static int reader_start(struct reftable_reader *r, struct table_iter *ti,
-			uint8_t typ, int index)
+static int table_iter_seek_start(struct table_iter *ti, struct reftable_re=
ader *r,
+				 uint8_t typ, int index)
 {
 	struct reftable_reader_offsets *offs =3D reader_offsets_for(r, typ);
 	uint64_t off =3D offs->offset;
@@ -416,11 +415,11 @@ static int reader_start(struct reftable_reader *r, st=
ruct table_iter *ti,
 		typ =3D BLOCK_TYPE_INDEX;
 	}
=20
-	return reader_table_iter_at(r, ti, off, typ);
+	return table_iter_seek_to(ti, r, off, typ);
 }
=20
-static int reader_seek_linear(struct table_iter *ti,
-			      struct reftable_record *want)
+static int table_iter_seek_linear(struct table_iter *ti,
+				  struct reftable_record *want)
 {
 	struct strbuf want_key =3D STRBUF_INIT;
 	struct strbuf got_key =3D STRBUF_INIT;
@@ -499,9 +498,8 @@ static int reader_seek_linear(struct table_iter *ti,
 	return err;
 }
=20
-static int reader_seek_indexed(struct table_iter *ti,
-			       struct reftable_reader *r,
-			       struct reftable_record *rec)
+static int table_iter_seek_indexed(struct table_iter *ti,
+				   struct reftable_record *rec)
 {
 	struct reftable_record want_index =3D {
 		.type =3D BLOCK_TYPE_INDEX, .u.idx =3D { .last_key =3D STRBUF_INIT }
@@ -520,7 +518,7 @@ static int reader_seek_indexed(struct table_iter *ti,
 	 * highest layer that identifies the relevant index block as well as
 	 * the record inside that block that corresponds to our wanted key.
 	 */
-	err =3D reader_seek_linear(ti, &want_index);
+	err =3D table_iter_seek_linear(ti, &want_index);
 	if (err < 0)
 		goto done;
=20
@@ -550,7 +548,7 @@ static int reader_seek_indexed(struct table_iter *ti,
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D reader_table_iter_at(r, ti, index_result.u.idx.offset, 0);
+		err =3D table_iter_seek_to(ti, ti->r, index_result.u.idx.offset, 0);
 		if (err !=3D 0)
 			goto done;
=20
@@ -585,14 +583,14 @@ static int reader_seek_internal(struct reftable_reade=
r *r,
 	struct table_iter ti =3D TABLE_ITER_INIT, *p;
 	int err;
=20
-	err =3D reader_start(r, &ti, reftable_record_type(rec), !!idx);
+	err =3D table_iter_seek_start(&ti, r, reftable_record_type(rec), !!idx);
 	if (err < 0)
 		goto out;
=20
 	if (idx)
-		err =3D reader_seek_indexed(&ti, r, rec);
+		err =3D table_iter_seek_indexed(&ti, rec);
 	else
-		err =3D reader_seek_linear(&ti, rec);
+		err =3D table_iter_seek_linear(&ti, rec);
 	if (err)
 		goto out;
=20
@@ -742,7 +740,7 @@ static int reftable_reader_refs_for_unindexed(struct re=
ftable_reader *r,
 	int err;
=20
 	*ti =3D ti_empty;
-	err =3D reader_start(r, ti, BLOCK_TYPE_REF, 0);
+	err =3D table_iter_seek_start(ti, r, BLOCK_TYPE_REF, 0);
 	if (err < 0) {
 		reftable_free(ti);
 		return err;
--=20
2.45.0


--FhBE0Vug2BlbaGsP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XBcACgkQVbJhu7ck
PpSzBhAAiMOitlG+Si+3Eymi+XO0UUOgd7J/RtGWB3C4C0E1Wm9qGlzdpk2C6/ih
fRxVnJmtrg/m9Rk91a+oFgwvbi42wKcZRYapnAMxt4StT2bpSA/o0BfQSM1nvApb
VjaJr6oC1DDZG8WvrVFefqmpzoO8iznYCY+eK77HNaX+KUPEedkQk/k9s9+D3z2B
nwrfZ+/Kdj3D8n9wZHHl8/oZ6p907Y2wvbdbxwTbD4UY/EHlYPlNI3QQlzl5eSpl
EGlX7gCWzzVxNrgq5XYTAiwYLDiGpjmzUbrH0AktoMcdOdKdkB1NeA3hl+X9R3i9
r/xoQjrGrA7Nq1xSUoa+jSqohDeUorxg31IT5iUXinjFS8tM8fEdMaWLl4DCL3XU
5+7OOVo+fbiKckuXF2gmO0IGmy/qPOUqL9zsZE0N2RIkwbglCfttTB5mTY86Mf63
Aw3f0qoE/YOM64tjIwAu7YAKmXGdEmygnUJ7hf4YedmLdDXH0NACcNBVxAc5C0Z6
MYet7avhQkSxQ+87G2TYNBuugAlaKRp9ySUmcS/2hnL+pfL/sitClu3QhJpv/cWo
AYNdd3WZW995FNLV9csyJETq5S9PNc9Wow8dnKKMZu52RpQemnf1YGxMLwTlGlKG
Qd230P8jbB9rB90py5cYjS78SBANzIiH4XHDybh3jjbOMi/tO8U=
=nIPQ
-----END PGP SIGNATURE-----

--FhBE0Vug2BlbaGsP--
