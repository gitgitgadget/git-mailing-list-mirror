Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92114830A
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590042; cv=none; b=ds4xS8Yo6n8RM+8aby4wMeXVKEKemNJUndcYVUzuoP4JcwVeSziRaVQ4OOPu5hZMhuanMFExosH5JcD6W4pUSnC+58wGiBNRhBimWnmCMy51S5y9EXlmmroec3w72fo691j61ImxIihiqdLH4q/mRioZm1fjRb/5I0VtJJyNAK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590042; c=relaxed/simple;
	bh=hLnkd0nTh24UmyITmW2LECpNMFe2VTLm4cxnAO5TAmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbMnizck95z3uOj3dQoQ84cr5oRMDtK1PODGyUdZ9EnBnQuuluedD53KIAXW+UqwnVD3QyNYCoLykNVsYlXqjpeLiJQldQpuZO46W+LXRPM3a5HeiXX1njK+5Gvbam6Hk8BTJWqYljSBIDqLf4ikvkh5JxEu2jSYebaG0BxZHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E01LaFkW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNi8+u8g; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E01LaFkW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNi8+u8g"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id B732318000CC;
	Mon, 13 May 2024 04:47:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 May 2024 04:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715590039; x=1715676439; bh=94L/0XEgrN
	1oBxW8oHCPQmBan05P7btQXrzyrH3u7Nk=; b=E01LaFkW6ZA+edS63vKcz7vtY2
	Sf0+dt5PZiL24gYp5f6lKqIUVPcEHe6at/wcn4hzODT2tGO+0hw6Suzchy6eXyt4
	lm9As8RrZKqHz2otoB2+kTACMMD+UpdmpbIqcdWDuuUeRzfwXct4I+rkOcH9sGLY
	+Jb0324AXdc2/Uqaas1LWncDctwh7gsCp9f9tYxKTNDqtVI9PmGmUs+5k4gHq34Y
	33VBNzmbSrMrNh2D4h8Lg6dwL3469dNHJH2bJdvtaio/Zcgo+MuTniWuhPtuBBdE
	JWUSpS2KP8ngzsuJ05yhiUynV6vsUMHAggunfEb7WoWNPcoESgAvGmTHYWhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715590039; x=1715676439; bh=94L/0XEgrN1oBxW8oHCPQmBan05P
	7btQXrzyrH3u7Nk=; b=RNi8+u8gGEobWG0Kdb7Sp8/HGsWotD5d6M4mjkNmmNLu
	ei73s/Mfd3PaFmz8W2CpQSesKeODJYAeg6QCtXFwMDeMOzDyDdWJrojjUizdhKQ5
	/mcKH6QpiizIOpdOw6T3zxD24JKUWBR0hNMF2ldmRx9jAWMv8FYseLuA9PDwXMzF
	wCxOZErFxfriZWOCxyzSKgrsytzyhk1B/Y+2tIyRcnuVrsk3hHJX8v9vH1t3y3j0
	xoK+VDbJmvCGTdX6M2mf80mIYbHzXdREwf5KfIdUtjmj5lphTqowmo7Ag+qh5Gms
	ecr4dgJdY8IsG23xHoXpl20UDJ6qCV2OOeq6fQ9vjg==
X-ME-Sender: <xms:l9NBZhpsWpWxFKG3q07C_7EybMdt7e75Ef5SQXx-o28dT_mrk1NaQA>
    <xme:l9NBZjp_jVA07unoRgBN3YS4D5c5Mbggs5lZbiBT4GWFwTQzFei1CV_BuXsd5WQkG
    NBNqp9--JkSEKB8QA>
X-ME-Received: <xmr:l9NBZuOfZflWYLWPgAsnZsnNdTjWO_krm2mpdpqxcqjsOrd8BNRKFEMqN5aJGMe0s6HOCrGD5Bq4LnuXKpJZ7H5wD8zoTb5AHJGdK5MaYUZwXRk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:l9NBZs5xEgKyJVE8E_Fg__drUVhnji076C__ErArf5_ZmA8MR6IRuQ>
    <xmx:l9NBZg5NRT4MzGe59LAgKEWgLHFmeeqCimLidLKdMs7jTxcSVF2vFw>
    <xmx:l9NBZkj_inTwVTLW2XmtHS79tcZmIyaj2dhI402I-HAwhEl-_mVB6Q>
    <xmx:l9NBZi7zhrnJlF3oxnyC8CVKUsExY0nTCQ0nXLW_X5cl-PWHQ46avw>
    <xmx:l9NBZukFid0zdzh2_kEX9afug8DADwNo5w6Lg8lFNl-1wZUt6MNQnZwX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:47:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eb810813 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:47:00 +0000 (UTC)
Date: Mon, 13 May 2024 10:47:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 04/13] reftable/reader: separate concerns of table iter
 and reftable reader
Message-ID: <91db2f18c105611bc85fa07fa6eb33ba600e742a.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uF9iQLj4caRrskWU"
Content-Disposition: inline
In-Reply-To: <cover.1715589670.git.ps@pks.im>


--uF9iQLj4caRrskWU
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
2.45.GIT


--uF9iQLj4caRrskWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB05MACgkQVbJhu7ck
PpTzUQ//W0EzN0ZzvDqsXxMPcJh1OllE87zBJm2AwX4ugsaMo/Us9UDFaxJK3/1x
l6g0hwiq3m/orNWGYM6uJK+GAt6NPY9eL8lCcY1f9ViLicPJg1Zuap/JD/4eNOps
awJ/GR0B2Ou3/zgUyIae7nOC4DGlZp14+nyWgeIqnFCmDkDKKycWzvQG6skF2IwH
S2wY3ayXpidA/1MlMl+rSd7Kagq0ZIvAQ8+vPe5EmCpsV6AlTE6JfrMfhrHiF/r9
pXSUHO39wDnqN2QwSVhfE6+UWJTcQO5YGhumoYnMka9/JFlYSZqt0tKbdmo4CNMq
7c7CSgWfKS+6nfWp/7Zrm+UcIuMrWEkLlvrSxiHsFzNwNEtqPhC+9lFOLlNl1asS
O4bpA4R+3+SwObH5xgwSHNwXpN9licSdc7WAVwTkqL7/gbql1cwOxPLvMGUsIeLe
RDGciEIJidi/yBQKhKRFxLZjFN1/QlqoB/WDGW06v12Cj0YH0UFteKUKnsKLHcTr
B9vjQ9Q6zUVgnat3aW6KCymRsFH1WN7DpbxCax1V7W86NXeR1BFoottZRsswbiEU
o26I6Yo6EqjxK5rxUgqdwtT8bPAiZDFfDIxkDZAg3Oxmdem5AnLl3LtGxNCLq9CT
YvIGdZc6Uax+T4jgO+Ax5Pd1e7mrjbI2w9IMNQZihr+kcOQtDQM=
=gkVU
-----END PGP SIGNATURE-----

--uF9iQLj4caRrskWU--
