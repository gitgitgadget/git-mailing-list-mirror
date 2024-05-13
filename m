Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225B146A98
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590073; cv=none; b=nNjZedDaeWSup7MrauZvlIRCuaushW3rS1bBJSlHIQ8dcmLq+3sw5LvDayHN3bXzlkWnGnYUGrEpEm//F6QykzyrJ0on7V4QVDCLGx43o9O8omB2rK3wjGPJIOvHduIZbA33VZoVk1Y4A+8wthO7Srf1WoXoGHlsPqxSB+Wf630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590073; c=relaxed/simple;
	bh=hNbE9p/UXxIlz5fmQLRO1mdV1tgFuzv5ozpKsulLWq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TF4ABw/ZM2rf13Vg7HNmKiNTSK8OC0dpFEg/t2/TtnzAx+RwByeoVJAX9iraGcDhLzeFpF78jvQxWTde4MIv3MUY2AdpEyRDpjQb8e0/j6zAhmyhQUm/XLWVPPpN0LxUEboN1PxE9oJRz98MzQfz7tj+6oCE2L2ldjy/gmqbRS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QYCq+0UE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5zmVr3T; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QYCq+0UE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5zmVr3T"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id A4D8C1800120;
	Mon, 13 May 2024 04:47:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 May 2024 04:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715590070; x=1715676470; bh=nNHMuFn9+J
	EDTuhRcXdwa88SeXOp5OllBWrQHCcPxHA=; b=QYCq+0UEMkeHBQ/iLwxbaFB+M5
	TM5qMySF0/567aL+1+3gZalH+O2Xfckosb2HWGCgbtKPgxDH11LSwBAaj0M2A0ZN
	JOmJubezlTsHBjAhi+1ty/LUY1weBYxchwYetc6MhrlNLJALZT7a7WdDiJsEUY/m
	sh5LLPrmFwTZtrK/aAd9jBYalmTcj4CJbuUaf9DYi4k4jIP9xX2XezR7s1Xg+bPH
	/5EDc/YSJyPwTPgJ8NlLtes8dLSALeeFO0xOeIq/bHtEmapuPhAR0MVZ2E1Ovxdl
	Mes5UtQIXHRd8xF6xpX4RtlpbTIkTq5GpEfBb00/WVjFSdJRQlFcNhACwBRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715590070; x=1715676470; bh=nNHMuFn9+JEDTuhRcXdwa88SeXOp
	5OllBWrQHCcPxHA=; b=Z5zmVr3TguSraGViVTK7SwCZafA2QI+N9MOSJ0UeTW7K
	qhaF4V31PMHAQE3KXIG8BKsao+iyF5mqQQWRzF1mFAOfhGGJOufGslJcDyp3RoXn
	Sqb6ApAXAy9tXdt/dVHVuQ2SLWfkTvnesq/9luZRzW12pq/Mgf82UPiNQOHyjQuY
	7b2Ook3hsjgAeW+bjr627uo5B0GAjx5XQzgVfqCDWQV/170KmKwoh8SOXPz9zYj3
	ZFqWmmsTxXQ1Jk6/ibgrlltaPkFoNCd54Sdqjm+1TBF/8atl5VXjX/kupBmfOj35
	esTPQrItYOmoNTufp+OgS2VN2GT+5CeebkcbkwL6LA==
X-ME-Sender: <xms:ttNBZuzGCdT31BZnGqg3tTpVLSOeX0RtgL5EYAkdlKFcvVSiRn5MWQ>
    <xme:ttNBZqTWZ2LD4UQBAJdbjNtVcLUASa8JzjP8ACkOvk73uPrIBb3k9KPEiWQBP7RNZ
    VW6uDT61knZdYCX4Q>
X-ME-Received: <xmr:ttNBZgUUnj9DM2mVLAQQvqdrBB21t2_X-zPYc18VFwOEflmFrC0N__Z5ZJCrDVZUTMbcBGd0nOlHIAqZWC6j06IuTqOs3svLBspqxIbCOGS_G_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ttNBZkhwyiupeEj7OHpLETdZHITaUhhxqnqSCWZ5qcu_7FlXw1iF2Q>
    <xmx:ttNBZgBDtrQXF4g8RLK-z2P5p1USYoQHFl9Zd8lzPPi6SB5WAiWFFA>
    <xmx:ttNBZlIjs_aTuSZlqMPU___j3VgeftHQWYmY-eiGkDJ5IO3LYztMzA>
    <xmx:ttNBZnBHNxoL_p24sNoYtsNZGbgtD9NYKY41YU2CTo5ika1RhP0o2w>
    <xmx:ttNBZjPhif5fHustr7MJ-FulaHR3_sQi7RgJjfn6_KffHqJbHKp8tSch>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:47:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8a8ce537 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:47:31 +0000 (UTC)
Date: Mon, 13 May 2024 10:47:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 10/13] reftable/generic: adapt interface to allow reuse of
 iterators
Message-ID: <b0641dd80073648b297bcd18b9945afd1afa8ba0.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ojFolMoijzsL8PJP"
Content-Disposition: inline
In-Reply-To: <cover.1715589670.git.ps@pks.im>


--ojFolMoijzsL8PJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor the interfaces exposed by `struct reftable_table` and `struct
reftable_iterator` such that they support iterator reuse. This is done
by separating initialization of the iterator and seeking on it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/generic.c           | 53 ++++++++++++++++++++++++++----------
 reftable/iter.c              |  8 +++---
 reftable/reftable-generic.h  |  8 +++---
 reftable/reftable-iterator.h | 21 ++++++++++++++
 4 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/reftable/generic.c b/reftable/generic.c
index 1cf68fe124..28ae26145e 100644
--- a/reftable/generic.c
+++ b/reftable/generic.c
@@ -20,8 +20,20 @@ void table_init_iter(struct reftable_table *tab,
 	tab->ops->init_iter(tab->table_arg, it, typ);
 }
=20
-int reftable_table_seek_ref(struct reftable_table *tab,
-			    struct reftable_iterator *it, const char *name)
+void reftable_table_init_ref_iter(struct reftable_table *tab,
+				  struct reftable_iterator *it)
+{
+	table_init_iter(tab, it, BLOCK_TYPE_REF);
+}
+
+void reftable_table_init_log_iter(struct reftable_table *tab,
+				  struct reftable_iterator *it)
+{
+	table_init_iter(tab, it, BLOCK_TYPE_LOG);
+}
+
+int reftable_iterator_seek_ref(struct reftable_iterator *it,
+			       const char *name)
 {
 	struct reftable_record want =3D {
 		.type =3D BLOCK_TYPE_REF,
@@ -29,29 +41,37 @@ int reftable_table_seek_ref(struct reftable_table *tab,
 			.refname =3D (char *)name,
 		},
 	};
-	table_init_iter(tab, it, BLOCK_TYPE_REF);
 	return it->ops->seek(it->iter_arg, &want);
 }
=20
-int reftable_table_seek_log(struct reftable_table *tab,
-			    struct reftable_iterator *it, const char *name)
+int reftable_iterator_seek_log_at(struct reftable_iterator *it,
+				  const char *name, uint64_t update_index)
 {
 	struct reftable_record want =3D {
 		.type =3D BLOCK_TYPE_LOG,
 		.u.log =3D {
 			.refname =3D (char *)name,
-			.update_index =3D ~((uint64_t)0),
+			.update_index =3D update_index,
 		},
 	};
-	table_init_iter(tab, it, BLOCK_TYPE_LOG);
 	return it->ops->seek(it->iter_arg, &want);
 }
=20
+int reftable_iterator_seek_log(struct reftable_iterator *it,
+			       const char *name)
+{
+	return reftable_iterator_seek_log_at(it, name, ~((uint64_t) 0));
+}
+
 int reftable_table_read_ref(struct reftable_table *tab, const char *name,
 			    struct reftable_ref_record *ref)
 {
 	struct reftable_iterator it =3D { NULL };
-	int err =3D reftable_table_seek_ref(tab, &it, name);
+	int err;
+
+	reftable_table_init_ref_iter(tab, &it);
+
+	err =3D reftable_iterator_seek_ref(&it, name);
 	if (err)
 		goto done;
=20
@@ -76,10 +96,13 @@ int reftable_table_print(struct reftable_table *tab) {
 	struct reftable_ref_record ref =3D { NULL };
 	struct reftable_log_record log =3D { NULL };
 	uint32_t hash_id =3D reftable_table_hash_id(tab);
-	int err =3D reftable_table_seek_ref(tab, &it, "");
-	if (err < 0) {
+	int err;
+
+	reftable_table_init_ref_iter(tab, &it);
+
+	err =3D reftable_iterator_seek_ref(&it, "");
+	if (err < 0)
 		return err;
-	}
=20
 	while (1) {
 		err =3D reftable_iterator_next_ref(&it, &ref);
@@ -94,10 +117,12 @@ int reftable_table_print(struct reftable_table *tab) {
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
=20
-	err =3D reftable_table_seek_log(tab, &it, "");
-	if (err < 0) {
+	reftable_table_init_log_iter(tab, &it);
+
+	err =3D reftable_iterator_seek_log(&it, "");
+	if (err < 0)
 		return err;
-	}
+
 	while (1) {
 		err =3D reftable_iterator_next_log(&it, &log);
 		if (err > 0) {
diff --git a/reftable/iter.c b/reftable/iter.c
index b4528fab47..fddea31e51 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -45,11 +45,11 @@ static int filtering_ref_iterator_next(void *iter_arg,
 		if (fri->double_check) {
 			struct reftable_iterator it =3D { NULL };
=20
-			err =3D reftable_table_seek_ref(&fri->tab, &it,
-						      ref->refname);
-			if (err =3D=3D 0) {
+			reftable_table_init_ref_iter(&fri->tab, &it);
+
+			err =3D reftable_iterator_seek_ref(&it, ref->refname);
+			if (err =3D=3D 0)
 				err =3D reftable_iterator_next_ref(&it, ref);
-			}
=20
 			reftable_iterator_destroy(&it);
=20
diff --git a/reftable/reftable-generic.h b/reftable/reftable-generic.h
index d239751a77..65670ea093 100644
--- a/reftable/reftable-generic.h
+++ b/reftable/reftable-generic.h
@@ -21,11 +21,11 @@ struct reftable_table {
 	void *table_arg;
 };
=20
-int reftable_table_seek_log(struct reftable_table *tab,
-			    struct reftable_iterator *it, const char *name);
+void reftable_table_init_ref_iter(struct reftable_table *tab,
+				  struct reftable_iterator *it);
=20
-int reftable_table_seek_ref(struct reftable_table *tab,
-			    struct reftable_iterator *it, const char *name);
+void reftable_table_init_log_iter(struct reftable_table *tab,
+				  struct reftable_iterator *it);
=20
 /* returns the hash ID from a generic reftable_table */
 uint32_t reftable_table_hash_id(struct reftable_table *tab);
diff --git a/reftable/reftable-iterator.h b/reftable/reftable-iterator.h
index d3eee7af35..e3bf688d53 100644
--- a/reftable/reftable-iterator.h
+++ b/reftable/reftable-iterator.h
@@ -21,12 +21,33 @@ struct reftable_iterator {
 	void *iter_arg;
 };
=20
+/*
+ * Position the iterator at the ref record with given name such that the n=
ext
+ * call to `next_ref()` would yield the record.
+ */
+int reftable_iterator_seek_ref(struct reftable_iterator *it,
+			       const char *name);
+
 /* reads the next reftable_ref_record. Returns < 0 for error, 0 for OK and=
 > 0:
  * end of iteration.
  */
 int reftable_iterator_next_ref(struct reftable_iterator *it,
 			       struct reftable_ref_record *ref);
=20
+/*
+ * Position the iterator at the log record with given name and update index
+ * such that the next call to `next_log()` would yield the record.
+ */
+int reftable_iterator_seek_log_at(struct reftable_iterator *it,
+				  const char *name, uint64_t update_index);
+
+/*
+ * Position the iterator at the newest log record with given name such tha=
t the
+ * next call to `next_log()` would yield the record.
+ */
+int reftable_iterator_seek_log(struct reftable_iterator *it,
+			       const char *name);
+
 /* reads the next reftable_log_record. Returns < 0 for error, 0 for OK and=
 > 0:
  * end of iteration.
  */
--=20
2.45.GIT


--ojFolMoijzsL8PJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB07IACgkQVbJhu7ck
PpRW/xAAp8quMymxZJZJ8ZWPE1s3dXgNDh1C5EQb/ebUjx/kYhwPR6BJChrb75xW
jL7QjZ//DlUuPGic0GiLv153TAfE2eJtCF1Kf2fQtpgw5H/fdjEY/YMBl/RwgHZ5
FoWZ7lC4vFkMZN9gTlfqBCzwE5J74Hw5zn9fQe0cTzmYrZyLFaHTc0/2M1SfFHkb
mEWciENTUm7JYH9wMaHHUlOZBQ/bF6xn0uu6NcQgMubUN4qdU7Cwmeqr7DzmDdLa
mQilCOOu5N4qWDDztkwtc85KOeQMoJbkqCduoqAZ3DXo4AOQVFhn6+8wh3md0DcC
7oSyHQMynRWtavgTnk0BDl3KdzXRJPnFXLF4Z5ZcjQwQ+JIlwR+RLKnG2v25Dn9Q
3trSR01UOr3JvbOr43e5P65oW84FHQLSCnSVmDIbxTeTxw+1hC1DAsL6r2akUF7W
hb9HJZXkR709yGQVoxDCk0TOsS8YVFu7f8gByfli9J00I/M/ds9ksKJrNqjhOxyJ
mywTVxL4TriI3TKvUIiTVMaLtPwAWeGp8Ylg2BVUfmiAsQH6D/kP1gZdqW3NHzkk
EMg1PMfgSXXYIZgsUdzeeIEy/xfo2weQMz1aREFQ83bsTPqyBHHTtZNTb0CzAqv3
FwpwhGe27xLN5TfMuCKjxDpIu0vkuhSbIblzmmcUJcu7Cwq99CY=
=eLju
-----END PGP SIGNATURE-----

--ojFolMoijzsL8PJP--
