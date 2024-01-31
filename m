Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1514664CF
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688101; cv=none; b=by2+Tty/qpp24CY1+u8qSvs9aJMtrmFKDxvQDavWhBAEpWgExtAwG1P1FeYu6XGST1fyzLAfphlG/xW7gbMgdyTuV0jXYx1lFyveeswZ7isHINKWiUULrO3bMbHysD+XV/l+E9gYVOEX1icLUJmyN0aSGJ/ibbaXZ/N690NIIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688101; c=relaxed/simple;
	bh=xTYOTPIfubl7CzDC15qp8y4ivyhMT0QUPSQnZkEBCE0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4BkVB1M11J8nyUdnHBh3SCbBjifqu79x/0V7BpouETC/DcACtPNo8Xuk/RbrSBRkBFbzvJthVaGxq7p+8IcT7580EAC4ye+r4BaayhwvV+/t3+8yOUZv15muV/e04J8lCKHALqQpgFDXVkMR3gImqf69VMq3kmaoQkVhIN8xmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k/fXeLuo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JxnTZo4G; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k/fXeLuo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JxnTZo4G"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id B9E725C00A3
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 31 Jan 2024 03:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706688098; x=1706774498; bh=TRADLeOCBg
	Bv+izm7XRZ5EE4kxu8BIj7IfgZpIRAb/w=; b=k/fXeLuos5Y4idv3uh6HRpcLqF
	gtGZNEzU/lwQeXL9WUr57D9zAJe5A7BwsYvUmFC0/jJNHrLIhxZ+8kn2l/MAWxEI
	T5Vy1OOMr5rkvraWmoHYHevMkU5pv4ZICG0UonqbCsRAWrZdJ2UIzdhV/0mwhIpi
	bGCF7VV+4UzdqRT8I141RSYg+zGCty6+RlTOtf0p41blb2xPq0SWLyxM3T1IapIm
	e19WM/c4eWaitqzI8andoM0NFtQyHXKNCROjB27vMuWEF6rXPgWD64Dac4HTbt4t
	doE8wwK7GHfw0+FWFhKR+hKhmfIli5cS6fY26slmDEt3PqIZ0WIXYDqHxeJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706688098; x=1706774498; bh=TRADLeOCBgBv+izm7XRZ5EE4kxu8
	BIj7IfgZpIRAb/w=; b=JxnTZo4G7PotUtRYl/mgN+PF83RviBZv4uTmE+hpA03S
	+7+T4O+Hx26ds9IbfCB416sRyDIyISaOUjhSnCM39h3/+/pASYi6mlUZVLef4IIm
	eX7XL+p0aeqPETQcgk+M8NjHOWnY4zctZm+g3DvPjQQo58q8gkDmuMt7UNuWFAre
	+sA0RH5WcDK1bbU69pHVa+nVFtExpWJOABNvbryiS+p/Xh4ARCXWWtvmP6w1decU
	Tpdkz/sshO5uj1/sFPL2qiPyK24SygAqSbckm24bMqv3yvg59I1YmgQy9p3nY7Z4
	ToBAoDNfBm1ZtI0aE1n5zmx+W1zj7UIJ2TyTgyEclA==
X-ME-Sender: <xms:Yv65ZSReF8W-bqAtnTPKIkaKaHtL6fmgPuPwJ5v1lcWwJgO7ejxHFQ>
    <xme:Yv65ZXyJrTL3c_Ula_YitQZdJnrsfMcYClKiklp9Zp-1ciW_DwDQppk5-8c4ldPil
    TKunyBWlFllCB_Zqw>
X-ME-Received: <xmr:Yv65Zf1JGbt5glKihMI_oKv8gdP_DM_BAiVcI-KgU_4AyOBme63hWvcpuyh7nBJKMYbVKshJ8b2VY0muVeS2zq1MJIpLuOzU88dMm19vLeUjudk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Yv65ZeA6XULEWK91rJcIek-Ies_GgcO5hYIe1I_RIgbmRIV4zVf48Q>
    <xmx:Yv65ZbgVW8daaGWgVe6D2N1Jkm-NR5ywLoPI3mpUa7onPdJ2PGyFDg>
    <xmx:Yv65Zaor0s3GJcmoy6YSgreE5wAk_HQC1TN6OSf4d4z4lRq-G9nRzA>
    <xmx:Yv65ZbLJFNDKywUWWBGC-XuTyzhs0ljumM_th0soO9IG65CzoPeZRA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 39946f3e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jan 2024 07:58:18 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:01:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 9/9] reftable/record: improve semantics when initializing
 records
Message-ID: <fd8a1ce99d10ac63f495e1723b143235fcf318e1.1706687982.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wF3ZQWe+UGSHuUTz"
Content-Disposition: inline
In-Reply-To: <cover.1706687982.git.ps@pks.im>


--wF3ZQWe+UGSHuUTz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

According to our usual coding style, the `reftable_new_record()`
function would indicate that it is allocating a new record. This is not
the case though as the function merely initializes records without
allocating any memory.

Replace `reftable_new_record()` with a new `reftable_record_init()`
function that takes a record pointer as input and initializes it
accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c       | 18 +++++++++---------
 reftable/merged.c      |  8 +++++---
 reftable/reader.c      |  4 ++--
 reftable/record.c      | 43 ++++++++++--------------------------------
 reftable/record.h      | 10 +++++-----
 reftable/record_test.c |  4 ++--
 6 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 6952d0facf..9ad220747e 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -380,23 +380,23 @@ int block_reader_seek(struct block_reader *br, struct=
 block_iter *it,
 		.key =3D *want,
 		.r =3D br,
 	};
-	struct reftable_record rec =3D reftable_new_record(block_reader_type(br));
-	int err =3D 0;
 	struct block_iter next =3D BLOCK_ITER_INIT;
+	struct reftable_record rec;
+	int err =3D 0, i;
=20
-	int i =3D binsearch(br->restart_count, &restart_key_less, &args);
 	if (args.error) {
 		err =3D REFTABLE_FORMAT_ERROR;
 		goto done;
 	}
=20
-	it->br =3D br;
-	if (i > 0) {
-		i--;
-		it->next_off =3D block_reader_restart_offset(br, i);
-	} else {
+	i =3D binsearch(br->restart_count, &restart_key_less, &args);
+	if (i > 0)
+		it->next_off =3D block_reader_restart_offset(br, i - 1);
+	else
 		it->next_off =3D br->header_off + 4;
-	}
+	it->br =3D br;
+
+	reftable_record_init(&rec, block_reader_type(br));
=20
 	/* We're looking for the last entry less/equal than the wanted key, so
 	   we have to go one entry too far and then back up.
diff --git a/reftable/merged.c b/reftable/merged.c
index 0e60e2a39b..a0f222e07b 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -21,11 +21,11 @@ static int merged_iter_init(struct merged_iter *mi)
 {
 	for (size_t i =3D 0; i < mi->stack_len; i++) {
 		struct pq_entry e =3D {
-			.rec =3D reftable_new_record(mi->typ),
 			.index =3D i,
 		};
 		int err;
=20
+		reftable_record_init(&e.rec, mi->typ);
 		err =3D iterator_next(&mi->stack[i], &e.rec);
 		if (err < 0)
 			return err;
@@ -57,10 +57,12 @@ static int merged_iter_advance_nonnull_subiter(struct m=
erged_iter *mi,
 					       size_t idx)
 {
 	struct pq_entry e =3D {
-		.rec =3D reftable_new_record(mi->typ),
 		.index =3D idx,
 	};
-	int err =3D iterator_next(&mi->stack[idx], &e.rec);
+	int err;
+
+	reftable_record_init(&e.rec, mi->typ);
+	err =3D iterator_next(&mi->stack[idx], &e.rec);
 	if (err < 0)
 		return err;
=20
diff --git a/reftable/reader.c b/reftable/reader.c
index 3e0de5e8ad..5e6c8f30a1 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -444,13 +444,13 @@ static int reader_start(struct reftable_reader *r, st=
ruct table_iter *ti,
 static int reader_seek_linear(struct table_iter *ti,
 			      struct reftable_record *want)
 {
-	struct reftable_record rec =3D
-		reftable_new_record(reftable_record_type(want));
 	struct strbuf want_key =3D STRBUF_INIT;
 	struct strbuf got_key =3D STRBUF_INIT;
 	struct table_iter next =3D TABLE_ITER_INIT;
+	struct reftable_record rec;
 	int err =3D -1;
=20
+	reftable_record_init(&rec, reftable_record_type(want));
 	reftable_record_key(want, &want_key);
=20
 	while (1) {
diff --git a/reftable/record.c b/reftable/record.c
index 5c3fbb7b2a..8b84b8157f 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1257,45 +1257,22 @@ reftable_record_vtable(struct reftable_record *rec)
 	abort();
 }
=20
-struct reftable_record reftable_new_record(uint8_t typ)
+void reftable_record_init(struct reftable_record *rec, uint8_t typ)
 {
-	struct reftable_record clean =3D {
-		.type =3D typ,
-	};
+	memset(rec, 0, sizeof(*rec));
+	rec->type =3D typ;
=20
-	/* the following is involved, but the naive solution (just return
-	 * `clean` as is, except for BLOCK_TYPE_INDEX), returns a garbage
-	 * clean.u.obj.offsets pointer on Windows VS CI.  Go figure.
-	 */
 	switch (typ) {
-	case BLOCK_TYPE_OBJ:
-	{
-		struct reftable_obj_record obj =3D { 0 };
-		clean.u.obj =3D obj;
-		break;
-	}
-	case BLOCK_TYPE_INDEX:
-	{
-		struct reftable_index_record idx =3D {
-			.last_key =3D STRBUF_INIT,
-		};
-		clean.u.idx =3D idx;
-		break;
-	}
 	case BLOCK_TYPE_REF:
-	{
-		struct reftable_ref_record ref =3D { 0 };
-		clean.u.ref =3D ref;
-		break;
-	}
 	case BLOCK_TYPE_LOG:
-	{
-		struct reftable_log_record log =3D { 0 };
-		clean.u.log =3D log;
-		break;
-	}
+	case BLOCK_TYPE_OBJ:
+		return;
+	case BLOCK_TYPE_INDEX:
+		strbuf_init(&rec->u.idx.last_key, 0);
+		return;
+	default:
+		BUG("unhandled record type");
 	}
-	return clean;
 }
=20
 void reftable_record_print(struct reftable_record *rec, int hash_size)
diff --git a/reftable/record.h b/reftable/record.h
index fd80cd451d..e64ed30c80 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -69,9 +69,6 @@ struct reftable_record_vtable {
 /* returns true for recognized block types. Block start with the block typ=
e. */
 int reftable_is_block_type(uint8_t typ);
=20
-/* return an initialized record for the given type */
-struct reftable_record reftable_new_record(uint8_t typ);
-
 /* Encode `key` into `dest`. Sets `is_restart` to indicate a restart. Retu=
rns
  * number of bytes written. */
 int reftable_encode_key(int *is_restart, struct string_view dest,
@@ -100,8 +97,8 @@ struct reftable_obj_record {
 /* record is a generic wrapper for different types of records. It is norma=
lly
  * created on the stack, or embedded within another struct. If the type is
  * known, a fresh instance can be initialized explicitly. Otherwise, use
- * reftable_new_record() to initialize generically (as the index_record is=
 not
- * valid as 0-initialized structure)
+ * `reftable_record_init()` to initialize generically (as the index_record=
 is
+ * not valid as 0-initialized structure)
  */
 struct reftable_record {
 	uint8_t type;
@@ -113,6 +110,9 @@ struct reftable_record {
 	} u;
 };
=20
+/* Initialize the reftable record for the given type */
+void reftable_record_init(struct reftable_record *rec, uint8_t typ);
+
 /* see struct record_vtable */
 int reftable_record_equal(struct reftable_record *a, struct reftable_recor=
d *b, int hash_size);
 void reftable_record_print(struct reftable_record *rec, int hash_size);
diff --git a/reftable/record_test.c b/reftable/record_test.c
index 999366ad46..a86cff5526 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -16,11 +16,11 @@
=20
 static void test_copy(struct reftable_record *rec)
 {
-	struct reftable_record copy =3D { 0 };
+	struct reftable_record copy;
 	uint8_t typ;
=20
 	typ =3D reftable_record_type(rec);
-	copy =3D reftable_new_record(typ);
+	reftable_record_init(&copy, typ);
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
 	/* do it twice to catch memory leaks */
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
--=20
2.43.GIT


--wF3ZQWe+UGSHuUTz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW5/l8ACgkQVbJhu7ck
PpS6uQ//VA6nYtJVTlQPj1HPu96nR8UPu2N16lQVdK5/5Acooo2kcTIQPmxIvUic
TkkOWn9X6MZCXdLielUqqsadoDAUptJ6QSsk6evTpiKqir6ntn1hdQ82Jr++LSJs
u95rx91GV4kNxICOgfON+8jASUQM/IEYSuy4i+H7DbgAPENoDs10fBAvWa0wn1Ww
aGSfxf37trl9pkJWepXPdnMMW3ZmPPHgjJKgMaSYANc4R/JdECsxQ6OP3Yf4TTQC
k6NldlXS34SAQ/qLRphwVaNX5Le8Yb9V/Qy5Ae18FXQACAb2wQ4hDvPdhs2z5VJL
6trxJNLN24lnXR00UZGKTsa/LbQmY58SUQ1r4XA/TazVjO24/uma+Udsd4Mwf6l6
DAg8+NyFHShAYIV+Z67lbR9fmUaXIVsVUMflMkxJhOkCQS4q/knF0mGKIg5xEixs
D84labfIMo14L2tF8FFsBNAcbPoh+JRcC8Vx9grxbUYfT843nE8E8wKAblwnK1ET
BxXaKtA9udfr6tqiLhXhfvcreq/mP6PqVjM8ewgaXq8ahDgKeL8bdiQS3b5l8ANS
t8yXgPJyYWSdPkDY4E9A/8mhyzgb8Br86VAQ3CiaJ1yPAlEuwJifzX2h9c65e8ib
z6YLUx4hpDXKtqEAIxpbNDM8yQoaEfbR8ENPCmz4t68HAjhehy0=
=fvJh
-----END PGP SIGNATURE-----

--wF3ZQWe+UGSHuUTz--
