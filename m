Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2208147C90
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590032; cv=none; b=jjHFOz/Eatnd4G4mpXIoX2fIqijcLCpV19RKTVz1a2Sck92Sy+OotchZeYXh4OjCCL/Qwn7KIFKFFPdaa70wOdgT8O0XpAlwvzofmjijGMVGjWXVMHEWRUYPtobmm42seN5nD2hXTfmkiNXyPsDPPAdLcz/2Z7l7KBRN+9bJIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590032; c=relaxed/simple;
	bh=2l7pvMDNRTEdXVtuOXwNH+EVkqdoHZmL2btydQLH7B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFTS1/xtHxYOdVLCYl+Wu9VZpwmUUQ6AOdXOqYfdFOtUKGP4QaiP0a5gXYVM6KXjhYcE97SLun1hhDA7SZ52blzHa/EFxpHfpUtsddzir8gf9Lh+ZteooHRZ1VggZq/lI+ayt7tF2i2eTQ9J18txvSTRabr7FDUjU+6K6qKaX7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KTN8AMVv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KK+7GBQp; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KTN8AMVv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KK+7GBQp"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 1B21C1C00065;
	Mon, 13 May 2024 04:47:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 04:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715590029; x=1715676429; bh=N0+vRGR+ww
	7zn1Oyq8eSjpiWvSjEmsRPvOH18PkQMYw=; b=KTN8AMVvATtFf+sZPVVm7g4tav
	PRWoFKD0Ma3D7IA4DUNDImloBNqFSpFwcQg1h+jCMq/8y6hm7LItqi26oufJ5+ov
	TDNZHlsg4hM8IM9q82KWwhn8Uih66hkJ88M4LbrX1R+nVUYEP8BiRqlQ+cyOcPPl
	Qu8mR0qjzYH7Gr8l8Ky+BNeWmLYiXgReoms3OvN/0Nht2vk24RK2gyzDN2CZwA8W
	2vjDOkUKValI6KaE2oUU3zW6to3lcPtyltVj7n+T60I0jp6f7t0r0aTqqFZ/36v3
	1WQEud93U+vB+5FVSE9MUnb003AuNNNlo3Z5QTwB6A+UsMW43roqLZK+8ceA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715590029; x=1715676429; bh=N0+vRGR+ww7zn1Oyq8eSjpiWvSjE
	msRPvOH18PkQMYw=; b=KK+7GBQpWK+qnJCPCx1bZ78VIITgF0ozZhDCr/cEM8Rq
	ChsEfNrsNGHI/x7IKl/7u1H72UbuUtfZ9fcOnTb/AI0yL9ZE+SsHMh6A5pgSz9Ef
	Ovcv2brzWRpjLuTPw6F9Tt1Uy+kbEeRbBvmtIb0I/6/1WT8ArTkfZbK9YFo7NCF5
	Nj2yYr0O4v+KgOgj+WQn4hp/a3rZd5D9a+4V7vbQElLWxyCoMkRUpcISudNHYOAY
	yvYUxDUyY/14lii8taUcLSh2rIH8QMe7xmbthk1cCxnUqBSV0Sw0JcSvsssULV6x
	jlxtiPygwkYq9rga4MatoUrQyxWUrQa0cg/jgGmytA==
X-ME-Sender: <xms:jdNBZlbw8tsClL-30rKxHV3Lk6n5w6LKIonr4Ghd_qE9pmcxIMZPUg>
    <xme:jdNBZsa0m1WqZ9IH9uqCDEg85fI_dmYgcZeFVayRnUcBA8-Exxwf_rhRh5yoq5KT0
    v2Zilsy98pYUgYjag>
X-ME-Received: <xmr:jdNBZn80nqky3RPW2RwoLKDN7d4QdvOiBtdaU1WvzliFKFfgrShz9VCW89r2ILPartlJcLROzvOD7RfMTGdb2uteeY3sm63KJjd5gd5sGthacHI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:jdNBZjrgfSc3WpqqzsEG6s8k184ev7rK4R1bvn6yVgeCfVHbIaY9_Q>
    <xmx:jdNBZgpZyCXzWZlvQF8zt5Gljfgm-e0IEbE8TZ30t0HZ7fgOF5kx4A>
    <xmx:jdNBZpSBa1hZH-rFYIwZkNlcXli2aL61R_uUTfMeVyNDPSrv7fIt7A>
    <xmx:jdNBZoq1PntGIHARy6D6d1nm7IRhm0aGt7lEKsJR00E3-6__AbOChw>
    <xmx:jdNBZrUFY7ctoEk0n8v_iHt_xRKbIRFZDrXvrVTJDt1IPDdtuppfg56N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:47:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b3477757 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:46:50 +0000 (UTC)
Date: Mon, 13 May 2024 10:47:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 02/13] reftable/reader: avoid copying index iterator
Message-ID: <bdbebdbd363fc264c6327e7bf0af29ee5357e83d.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z02SRw2OJq1PbcFa"
Content-Disposition: inline
In-Reply-To: <cover.1715589670.git.ps@pks.im>


--z02SRw2OJq1PbcFa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When doing an indexed seek we need to walk down the multi-level index
until we finally hit a record of the desired indexed type. This loop
performs a copy of the index iterator on every iteration, which is both
hard to understand and completely unnecessary.

Refactor the code so that we use a single iterator to walk down the
indices, only.

Note that while this should improve performance, the improvement is
negligible in all but the most unreasonable repositories. This is
because the effect is only really noticeable when we have to walk down
many levels of indices, which is not something that a repository would
typically have. So the motivation for this change is really only about
readability.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 481dff10d4..6bfadcad71 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -510,13 +510,11 @@ static int reader_seek_indexed(struct reftable_reader=
 *r,
 		.type =3D BLOCK_TYPE_INDEX,
 		.u.idx =3D { .last_key =3D STRBUF_INIT },
 	};
-	struct table_iter index_iter =3D TABLE_ITER_INIT;
-	struct table_iter empty =3D TABLE_ITER_INIT;
-	struct table_iter next =3D TABLE_ITER_INIT;
+	struct table_iter ti =3D TABLE_ITER_INIT, *malloced;
 	int err =3D 0;
=20
 	reftable_record_key(rec, &want_index.u.idx.last_key);
-	err =3D reader_start(r, &index_iter, reftable_record_type(rec), 1);
+	err =3D reader_start(r, &ti, reftable_record_type(rec), 1);
 	if (err < 0)
 		goto done;
=20
@@ -526,7 +524,7 @@ static int reader_seek_indexed(struct reftable_reader *=
r,
 	 * highest layer that identifies the relevant index block as well as
 	 * the record inside that block that corresponds to our wanted key.
 	 */
-	err =3D reader_seek_linear(&index_iter, &want_index);
+	err =3D reader_seek_linear(&ti, &want_index);
 	if (err < 0)
 		goto done;
=20
@@ -552,44 +550,36 @@ static int reader_seek_indexed(struct reftable_reader=
 *r,
 		 * all levels of the index only to find out that the key does
 		 * not exist.
 		 */
-		err =3D table_iter_next(&index_iter, &index_result);
+		err =3D table_iter_next(&ti, &index_result);
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D reader_table_iter_at(r, &next, index_result.u.idx.offset,
-					   0);
+		err =3D reader_table_iter_at(r, &ti, index_result.u.idx.offset, 0);
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D block_iter_seek_key(&next.bi, &next.br, &want_index.u.idx.last_k=
ey);
+		err =3D block_iter_seek_key(&ti.bi, &ti.br, &want_index.u.idx.last_key);
 		if (err < 0)
 			goto done;
=20
-		if (next.typ =3D=3D reftable_record_type(rec)) {
+		if (ti.typ =3D=3D reftable_record_type(rec)) {
 			err =3D 0;
 			break;
 		}
=20
-		if (next.typ !=3D BLOCK_TYPE_INDEX) {
+		if (ti.typ !=3D BLOCK_TYPE_INDEX) {
 			err =3D REFTABLE_FORMAT_ERROR;
-			break;
+			goto done;
 		}
-
-		table_iter_close(&index_iter);
-		index_iter =3D next;
-		next =3D empty;
 	}
=20
-	if (err =3D=3D 0) {
-		struct table_iter *malloced =3D reftable_calloc(1, sizeof(*malloced));
-		*malloced =3D next;
-		next =3D empty;
-		iterator_from_table_iter(it, malloced);
-	}
+	REFTABLE_ALLOC_ARRAY(malloced, 1);
+	*malloced =3D ti;
+	iterator_from_table_iter(it, malloced);
=20
 done:
-	table_iter_close(&next);
-	table_iter_close(&index_iter);
+	if (err)
+		table_iter_close(&ti);
 	reftable_record_release(&want_index);
 	reftable_record_release(&index_result);
 	return err;
--=20
2.45.GIT


--z02SRw2OJq1PbcFa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB04kACgkQVbJhu7ck
PpRpOQ/+OWpz8vNDauzwFUmy+XRFXloAlGomBtjTswQofnBvqsAiLcXgaKqfk7Qj
+zFWtCua+JrCCDlB5utPdRqZ1Mt4vXw7MGwGQoVDr9plaoih7ojTj3bEm3j7IYHG
Qskt5jZLo7N52edL7XPi1YuzN0qBfOBLko55JX8vx8JsFOjhk24J82ANkqPChaNP
uFAPb72nIvPiPf/n2E2mVFUKgBvIu4ntU1mIFVrSB0bw1dKP4tk5xvNiEIEVn+lp
MOuopeGncc3bk+xj6PLf4hQccw8NKHIWybADqw006toAyrRZ6Sl0VVd4w3SNwZpu
Qr5T9294tdL3pROstXZPOYstEsVaXdaKHWka6OUVm3W4l8Gm7D/Xp50rc6SoB+jH
WaPMPLgpAp7QbedUzVkAkaTow5WAAcIFwbohFEXDYJcUk251Wcsa4vV0hWQZAvxV
YdEXwuRRvauH7apKhjEazxGpcS7Dmgmd/pCF+X0IDi2WPDVTY2p1ozjk7rlqo9ty
MitDWk3cLAlSNMMSwG2D4nOvB42hDccAu6+7mZw27+bh+RVs4NfbPbCf+1wu2a9P
fxROfaPQDA31mVDqYPJxBTxbOGhODN1TVRRiLBkWD2+i8okOljJs/ceNbTLn/gm3
wnjUWuIdx4jMCbI8E0yzXXdwKkfx+05/wSZnYcOHx42qMPtYblQ=
=TtXh
-----END PGP SIGNATURE-----

--z02SRw2OJq1PbcFa--
