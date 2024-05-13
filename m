Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918A1482E6
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590053; cv=none; b=lz8hsq+qc6iZf4Ri7fca8KD1InUjEEdXNVQ6msiNgg8EMOHITuTcHBBe7jFakqszNM+khI0+VBRwotehglzDLkrEPI+rkQl58l4CJ9S04jWF5Giwk+W0SrYu9sGKujwsTrsoy+N9fl4katdCcULh1oCyv51d5wsAAk/N0kc2hxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590053; c=relaxed/simple;
	bh=gY7j83ePQZL58jfWTR/XSPVNq2YXY6qOsxgGXP1AF4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4zSBMjULxI8K0jrZV8I61CxIbFkliosw6FE1qr8WAIWx0V8a9JW6lGUNAimN+CnbmsdzmMEcSCZ78le8ZAdcyAeVCUxKmC376E9UpyaiWWR4SrL+wBd66giEOoXjONU6AwwpUYHuzttOE/aN05jLlTfMt6cmDjSLwxvpvT5qSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=amWzfYKm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I64xuKKv; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="amWzfYKm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I64xuKKv"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 826851C000BF;
	Mon, 13 May 2024 04:47:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 May 2024 04:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715590050; x=1715676450; bh=+D9UioQqm0
	+0Gf9xCYcI+jufPJVzjCMA0cd1YYXbZqA=; b=amWzfYKmVVSeU18wqhINfYjzV+
	ayKrCVoSn900lAwL4B47HDxVX9BMz6HjywRkcpFXOR3IYIE61dgY2ZWlgnPyZKvg
	mW0AyySrVRryLGHF5bzbiuFhYZg/PVsd2jqoP5oHJlHFhjOAZza3jM7nUXfakRZC
	XY3eGFXoI+EVrcvp27vb0q8l0d6FIRoZsY4jlde9C5fuOLcKuV6pwoB1+scSyiSo
	c/UYPv5GjmcTG1XcKPezQyLJFz89ZKHa4Xb6Vhgrhe0nXoQzeJZZc4RF1nfIQyYj
	lRSoRO2r5djIzEw4eqwuHkKOJTScvsXvE9SESmljKUQpFcPiG6R4jTuHPrag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715590050; x=1715676450; bh=+D9UioQqm0+0Gf9xCYcI+jufPJVz
	jCMA0cd1YYXbZqA=; b=I64xuKKvro4WmSWZqIDa2wzdNtW+IYVuHId912YFQnVP
	aFH69kw69fn9bYedyB+PmI8y3iu+7iIxpmZ7LMwyG/to8AFdfW6muRSBeB6DKMco
	Jw0D2MmIq7BHG9iEcOlWhHemYBF5vPexxwj0KsxZJb0OQ3I0GBsp9VCpfXH9UaHg
	qP5qCGWwsWJs8va0n7vVf/bE73d2PHpFvfSTsq8Rn+vmQoUQy9wxtMK7AHjRBeNP
	ktFZyRvGjjR154EjjlneP2XYTtvmyFZzxvl5lP94qmZngZY58bSqxj6mxhMYg0ZM
	K7tTBZN70UYyyrt2i4UBA7R+CJgLzgzfIbYz5VDVPQ==
X-ME-Sender: <xms:odNBZntBqRyBgaKM6B2dNjVDyhkdIMtxmG9LIKs2PjNRs0on1sP4Bw>
    <xme:odNBZod_P5R9qOdZRPV5mw7IfhjM9px3Q-EI2a3_2o5uFMb9VaB9GX_UDs-pgfTPI
    gNbxcBDt9fVal_8Hg>
X-ME-Received: <xmr:odNBZqzucMVvakXu7uixfLkpCLMYYPqK3XMoft00TqXBl1tsXOmMKLTSE9wf-U_1YNzP--9WDFHQgNY8SOjuRyrNNb9cn0Ea6Rp-MtJ7QZtHttY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:otNBZmOT9_pjl1NFQ22osURj15i-HRGAHF96sv-9ipbLE1znUPnc6w>
    <xmx:otNBZn93XD-j3l_t4cuDytBRXE5RIL41RZo8T0j8PqJCmJgF1_Ttew>
    <xmx:otNBZmWXtdnXs2PJpOwVeEo3f3OTQ51ROQswSXFs0ujePYDUvssVdg>
    <xmx:otNBZofFD3IPpZi-Iem9qWF8-Pb10kNjEkSlgaTUuog5JqOqgtOm8g>
    <xmx:otNBZqaksVvonCB8hg_t6tDifXg2sd6uX3Mu5MPvkzv0Yw4bWEu-YMep>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:47:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 36548134 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:47:10 +0000 (UTC)
Date: Mon, 13 May 2024 10:47:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 06/13] reftable/reader: set up the reader when
 initializing table iterator
Message-ID: <5a10a115841512a46e4d3a3d3713e5532facdb39.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RYqlQyyq4dEorvJU"
Content-Disposition: inline
In-Reply-To: <cover.1715589670.git.ps@pks.im>


--RYqlQyyq4dEorvJU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

All the seeking functions accept a `struct reftable_reader` as input
such that they can use the reader to look up the respective blocks.
Refactor the code to instead set up the reader as a member of `struct
table_iter` during initialization such that we don't have to pass the
reader on every single call.

This step is required to move seeking of records into the generic
`struct reftable_iterator` infrastructure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index c3541e2c43..021608f638 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -224,8 +224,14 @@ struct table_iter {
 	struct block_iter bi;
 	int is_finished;
 };
-#define TABLE_ITER_INIT { \
-	.bi =3D BLOCK_ITER_INIT \
+
+static int table_iter_init(struct table_iter *ti, struct reftable_reader *=
r)
+{
+	struct block_iter bi =3D BLOCK_ITER_INIT;
+	memset(ti, 0, sizeof(*ti));
+	ti->r =3D r;
+	ti->bi =3D bi;
+	return 0;
 }
=20
 static int table_iter_next_in_block(struct table_iter *ti,
@@ -386,26 +392,23 @@ static void iterator_from_table_iter(struct reftable_=
iterator *it,
 	it->ops =3D &table_iter_vtable;
 }
=20
-static int table_iter_seek_to(struct table_iter *ti, struct reftable_reade=
r *r,
-			      uint64_t off, uint8_t typ)
+static int table_iter_seek_to(struct table_iter *ti, uint64_t off, uint8_t=
 typ)
 {
 	int err;
=20
-	err =3D reader_init_block_reader(r, &ti->br, off, typ);
+	err =3D reader_init_block_reader(ti->r, &ti->br, off, typ);
 	if (err !=3D 0)
 		return err;
=20
-	ti->r =3D r;
 	ti->typ =3D block_reader_type(&ti->br);
 	ti->block_off =3D off;
 	block_iter_seek_start(&ti->bi, &ti->br);
 	return 0;
 }
=20
-static int table_iter_seek_start(struct table_iter *ti, struct reftable_re=
ader *r,
-				 uint8_t typ, int index)
+static int table_iter_seek_start(struct table_iter *ti, uint8_t typ, int i=
ndex)
 {
-	struct reftable_reader_offsets *offs =3D reader_offsets_for(r, typ);
+	struct reftable_reader_offsets *offs =3D reader_offsets_for(ti->r, typ);
 	uint64_t off =3D offs->offset;
 	if (index) {
 		off =3D offs->index_offset;
@@ -415,7 +418,7 @@ static int table_iter_seek_start(struct table_iter *ti,=
 struct reftable_reader *
 		typ =3D BLOCK_TYPE_INDEX;
 	}
=20
-	return table_iter_seek_to(ti, r, off, typ);
+	return table_iter_seek_to(ti, off, typ);
 }
=20
 static int table_iter_seek_linear(struct table_iter *ti,
@@ -548,7 +551,7 @@ static int table_iter_seek_indexed(struct table_iter *t=
i,
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D table_iter_seek_to(ti, ti->r, index_result.u.idx.offset, 0);
+		err =3D table_iter_seek_to(ti, index_result.u.idx.offset, 0);
 		if (err !=3D 0)
 			goto done;
=20
@@ -578,7 +581,7 @@ static int reader_seek(struct reftable_reader *r, struc=
t reftable_iterator *it,
 {
 	uint8_t typ =3D reftable_record_type(rec);
 	struct reftable_reader_offsets *offs =3D reader_offsets_for(r, typ);
-	struct table_iter ti =3D TABLE_ITER_INIT, *p;
+	struct table_iter ti, *p;
 	int err;
=20
 	if (!offs->is_present) {
@@ -586,7 +589,9 @@ static int reader_seek(struct reftable_reader *r, struc=
t reftable_iterator *it,
 		return 0;
 	}
=20
-	err =3D table_iter_seek_start(&ti, r, reftable_record_type(rec),
+	table_iter_init(&ti, r);
+
+	err =3D table_iter_seek_start(&ti, reftable_record_type(rec),
 				    !!offs->index_offset);
 	if (err < 0)
 		goto out;
@@ -722,15 +727,15 @@ static int reftable_reader_refs_for_unindexed(struct =
reftable_reader *r,
 					      struct reftable_iterator *it,
 					      uint8_t *oid)
 {
-	struct table_iter ti_empty =3D TABLE_ITER_INIT;
-	struct table_iter *ti =3D reftable_calloc(1, sizeof(*ti));
+	struct table_iter *ti;
 	struct filtering_ref_iterator *filter =3D NULL;
 	struct filtering_ref_iterator empty =3D FILTERING_REF_ITERATOR_INIT;
 	int oid_len =3D hash_size(r->hash_id);
 	int err;
=20
-	*ti =3D ti_empty;
-	err =3D table_iter_seek_start(ti, r, BLOCK_TYPE_REF, 0);
+	REFTABLE_ALLOC_ARRAY(ti, 1);
+	table_iter_init(ti, r);
+	err =3D table_iter_seek_start(ti, BLOCK_TYPE_REF, 0);
 	if (err < 0) {
 		reftable_free(ti);
 		return err;
--=20
2.45.GIT


--RYqlQyyq4dEorvJU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB050ACgkQVbJhu7ck
PpR/lQ/8Dn4FM7gME7ivgagIrflCTPW0RN9C3BCwa8m1sFge9gF0VngpGofy3wGf
e3JQYlLgU+e8J21Wo+a+UGBBGhdqgwRVo0mOb5L+a64RtdwWGzQWEGUy3PD6I0rH
6K3dOWkmLMeTQvlWo/mFUavI2yaF7q1/VFo/C+s0Kej0FL/BqnTQxTU4e7N63QV8
E9QlXeecKUbUEjrfDLOO8YAily/4csvpzdMPA3pZnDhASEFD5F/330dwGRH7UQY2
0j11wcO7/hkotDE/LQRtv+WUkIzlPInc4s37ksYq+rq0sP5DEjlXk3cKv2zjK9X3
f3/p8PcgxNHMlF1NzCw9Y/zdn3GuddZeIR6OP5JoP7RJInN1aml9LW50JHpRbVhE
KD+MFSp2zrzNKpue7xxMpyM+43HklOgnP3Q9WGyi9yNVe1c79xrOOpvIV0rsYP7a
fXbtpBQIVzp19jtAye4yqeWGTuYDl/EY92Da2sTQTvtdzo1CrPfdz4lKuSqM6bxQ
l139j+sruuD/6WZ+9bRWBpCgbkCdaiRwJcPO7jXLCFDrsZhYsBEXMFc4R8F91y4R
drEUPfrUi7pX8Sj8mx2XXJMsh+QrKmyLHtO7pFzy9ZgcCMSstFcd+sKDERI2Ibon
DwjdEcbtJ8CHi3RzUxyt3crblT0rzlVCzZ9qEaMj60dC5gTu4OM=
=FIIR
-----END PGP SIGNATURE-----

--RYqlQyyq4dEorvJU--
