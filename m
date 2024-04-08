Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF669E07
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578625; cv=none; b=EArcfOBGU9dCALH7CHjo6KGuCf2hbekos52v7ysNK8z4O23k8NqYoPknBe8sraXtJ2qDsH45avwX6CTtxvF5c5zR+yS435Mu2SXkCXov+yHpr9JyeK8l9S55R4VpE9VP6z23nJhrcbG8wt8OKhQuVu2RIN0l22utnLgeGAmudMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578625; c=relaxed/simple;
	bh=h9Zu2MfSCa9Ira5lzqVQb93eQXrCsJf+u+6L/+AcZ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7ehJeC3j0Y/hk3kNOwovSzgOfWmQOkfNqkG4ykS8HxDejc9Eui2c3kPfVRJ4YPAPj+RHtkdUtcvrNmPXx3iND5ISDQh6uQQg9QVo7KrJ7DJyG5vXmLFlqirWa+IG3Wt8+r9jxQtS3FJW3HG+E+tbzta6tw/YVDcdqRVo+4xODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gWJEVc1t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f1VqdeUR; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gWJEVc1t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f1VqdeUR"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id B7C8A13800BE;
	Mon,  8 Apr 2024 08:16:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Apr 2024 08:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712578613; x=1712665013; bh=BFVtMKp35k
	760b6c1cdfhLBgYF4lXpHCRKE9A8LAmVI=; b=gWJEVc1tnvGVS51mP4S7aCxYH8
	QpstrEVI/HLRkTCW+SWfoXDLKYg0q5lbPzppMlyFqt/WYCUdU6Gtq7RhPz38Mzgu
	27EXUZxemq7Sqn71gR7AwzfLzZliELthveuuGUgxsdCL5RF+UCS+ESb+Jq3kTHvH
	QIMHCcfNIig/iUF9nQBi8CqXo5URdrdcRFqG90+pnTkiZL42qxEXOGGZyIpyWp6X
	Ds+7qDGDT0597U9SqkL22OxGcCLUGNgpzUaVMOPr1aNgHs8hypykBljf3JLuY2jv
	dEhiphxc1haG592I6tEo2XPkTwPz09vUiI4HdNTcUpPjwE8nkkVDyhc/JGgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712578613; x=1712665013; bh=BFVtMKp35k760b6c1cdfhLBgYF4l
	XpHCRKE9A8LAmVI=; b=f1VqdeUR4Q2be+jT8Uk9PzWFBqdhoiUOhbYleNT7pRHs
	JR2DpHI6MkhtLQG7MvRkURcURk9tJ2hIiHyyHef48SE5qJNWeCBxjSe2+p9uNTq7
	BcXARFW5LFgC5yLUZnWnHE8I6j6nhEHdB6tw7rJYoCtUwZh95iKnMrDlMOA34eFA
	ZUG1HWIw8rbZYWMWxBchhEwMepAo/8jEpi20IZ3JCpM5xdTIxkAH0maG0bvLv9wC
	ArumNN7PyOqAc4LzRTZ0fhcuYIKS+wrnqqoHXResYpNqjTXlO8DGIE9EbFOzVqkW
	WHnmnWjqZO4irz6VIFcsRcoVwaSmT1Kt4YgekHYDYQ==
X-ME-Sender: <xms:NeATZrEl33Vb2owB304KL9ZmDsnMFtyDbsQZWiubMNGhJiDwW2B-ww>
    <xme:NeATZoUuAjG398PMQuwuer0Sb3iGEJtYwR-v2z0BsK01UsCNmlLTqzuCUzAXJTebO
    6LiIoJIS_aRuWhLcA>
X-ME-Received: <xmr:NeATZtKktQNNgnx_xzYFsKNbDYRcf3aEpQicSibCKLMwdojlztATLqyqT_riNkf8hrIY0D5pV3UeStnWVH-iZAElWJTcbtHWh7J8omXJmxHGPS-4yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:NeATZpFF5xhfo4H2UE4Vlsz8EzawzakXlVsbiP35erIJsCZ5slQtrg>
    <xmx:NeATZhWp6H5EZUvfukqt0mp3AXxcWmiMVlIaqJRuP6bnlaDSSPW0sw>
    <xmx:NeATZkN4O6fSJpJ1P_3v4lds8ulFr4Yv0AGz-92kBj9bFMb7SrWhJQ>
    <xmx:NeATZg34vwzJ6l9iYZfCRCv5mKjQP2-jF78hcsJYqy0xi1hIFUTwBA>
    <xmx:NeATZnyboSFToRuMT98tDBUfAB4B_jjtBFafT4wsgNFQc1N0TbPyHhEC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:16:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7733ce13 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:16:46 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:16:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 06/10] reftable/reader: iterate to next block in place
Message-ID: <685f0a40bc5ac6a8c3eaab78bac2050c0cad8de4.1712578376.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
 <cover.1712578376.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dV7krx01+zqytbn7"
Content-Disposition: inline
In-Reply-To: <cover.1712578376.git.ps@pks.im>


--dV7krx01+zqytbn7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The table iterator has to iterate towards the next block once it has
yielded all records of the current block. This is done by creating a new
table iterator, initializing it to the next block, releasing the old
iterator and then copying over the data.

Refactor the code to instead advance the table iterator in place. This
is simpler and unlocks some optimizations in subsequent patches. Also,
it allows us to avoid some allocations.

The following measurements show a single matching ref out of 1 million
refs. Before this change:

  HEAP SUMMARY:
      in use at exit: 13,603 bytes in 125 blocks
    total heap usage: 7,235 allocs, 7,110 frees, 301,481 bytes allocated

After:

  HEAP SUMMARY:
      in use at exit: 13,603 bytes in 125 blocks
    total heap usage: 315 allocs, 190 frees, 107,027 bytes allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  |  2 ++
 reftable/reader.c | 47 ++++++++++++++++++++++++++---------------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 2d8d0668b3..0c4e71eae3 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -188,6 +188,8 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *block,
 	uint8_t *restart_bytes =3D NULL;
 	uint8_t *uncompressed =3D NULL;
=20
+	reftable_block_done(&br->block);
+
 	if (!reftable_is_block_type(typ)) {
 		err =3D  REFTABLE_FORMAT_ERROR;
 		goto done;
diff --git a/reftable/reader.c b/reftable/reader.c
index b77b639751..dd4de294a1 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -312,26 +312,20 @@ static void table_iter_close(struct table_iter *ti)
 	block_iter_close(&ti->bi);
 }
=20
-static int table_iter_next_block(struct table_iter *dest,
-				 struct table_iter *src)
+static int table_iter_next_block(struct table_iter *ti)
 {
-	uint64_t next_block_off =3D src->block_off + src->br.full_block_size;
+	uint64_t next_block_off =3D ti->block_off + ti->br.full_block_size;
 	int err;
=20
-	dest->r =3D src->r;
-	dest->typ =3D src->typ;
-	dest->block_off =3D next_block_off;
-
-	err =3D reader_init_block_reader(src->r, &dest->br, next_block_off, src->=
typ);
+	err =3D reader_init_block_reader(ti->r, &ti->br, next_block_off, ti->typ);
 	if (err > 0)
-		dest->is_finished =3D 1;
-	if (err) {
-		table_iter_block_done(dest);
+		ti->is_finished =3D 1;
+	if (err)
 		return err;
-	}
=20
-	dest->is_finished =3D 0;
-	block_iter_seek_start(&dest->bi, &dest->br);
+	ti->block_off =3D next_block_off;
+	ti->is_finished =3D 0;
+	block_iter_seek_start(&ti->bi, &ti->br);
=20
 	return 0;
 }
@@ -342,7 +336,6 @@ static int table_iter_next(struct table_iter *ti, struc=
t reftable_record *rec)
 		return REFTABLE_API_ERROR;
=20
 	while (1) {
-		struct table_iter next =3D TABLE_ITER_INIT;
 		int err;
=20
 		if (ti->is_finished)
@@ -362,14 +355,11 @@ static int table_iter_next(struct table_iter *ti, str=
uct reftable_record *rec)
 		 * table and retry. If there are no more blocks then the
 		 * iterator is drained.
 		 */
-		err =3D table_iter_next_block(&next, ti);
+		err =3D table_iter_next_block(ti);
 		if (err) {
 			ti->is_finished =3D 1;
 			return err;
 		}
-
-		table_iter_close(ti);
-		*ti =3D next;
 	}
 }
=20
@@ -453,9 +443,24 @@ static int reader_seek_linear(struct table_iter *ti,
 	 * have no other way to do this.
 	 */
 	while (1) {
-		struct table_iter next =3D TABLE_ITER_INIT;
+		struct table_iter next =3D *ti;
+
+		/*
+		 * We must be careful to not modify underlying data of `ti`
+		 * because we may find that `next` does not contain our desired
+		 * block, but that `ti` does. In that case, we would discard
+		 * `next` and continue with `ti`.
+		 *
+		 * This also means that we cannot reuse allocated memory for
+		 * `next` here. While it would be great if we could, it should
+		 * in practice not be too bad given that we should only ever
+		 * end up doing linear seeks with at most three blocks. As soon
+		 * as we have more than three blocks we would have an index, so
+		 * we would not do a linear search there anymore.
+		 */
+		memset(&next.br.block, 0, sizeof(next.br.block));
=20
-		err =3D table_iter_next_block(&next, ti);
+		err =3D table_iter_next_block(&next);
 		if (err < 0)
 			goto done;
 		if (err > 0)
--=20
2.44.GIT


--dV7krx01+zqytbn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4DEACgkQVbJhu7ck
PpRVNg//XwCfbiAwS5+7BMM465ndM8cKoslFbM9ytYwM9eWQmBUTNhuNNuGDds4S
lmJpcsXco3iSlcJgPULPS7dHBKwgPw2WWZvImRJAe9csSlJ5kxQxYDQKk9Gr6eVm
L21FQoyGwbSKDq4q/yrGdnQPSHxC/YK74SNT+WGtcQK+GJDAT3CM8zUH1VjUutqx
DNxkSJ8nkYl9IVi2f3jsULn09QIXROv8j2IELmhtrbRbu9ouOmwjSFS6gLEgaFLK
4OUDHiX8cvX6Uu5rMd78uRgCRxkeufRtrsnjnutFjHo6A2sOJVAokjhd5uN6aGrJ
ExINXyTAblvId9syZDjlTuxjEU5271jdqW8Yr3taxoDgqSHPvNbEkkUh3W2P6VQC
2e2Y+bc0eTAkijQRDKglYvhWmUI1xVpZsWGkR4TnPBBQ6MSyXwuB9b1iVUnyfBme
KvJna7/AfeoFckFljc5IhDyvi+9HNL4C1uPzW+mHFL9CHceM6q39tt5A3krjgCFf
TflEe6asz0QDEKR6b6poUfOINIPKu0cH1iG3c9ZKKhvbfyoi3qbQQ3pxIcFsW8pr
20FNp/E6ZCXgEkzbvfDZ5kB4hk1n7+IQnBIdRnxgIiTAyGMh3IsAYLiccj8qCF9C
qyM2NQdxNXw2EMLkwsNhkYe5F3y176YiKwoXLmd+1zOfSaA7wYo=
=LYhR
-----END PGP SIGNATURE-----

--dV7krx01+zqytbn7--
