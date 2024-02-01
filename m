Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2615AAAB
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772813; cv=none; b=rQGFS6py/VvW85YCwQ7XHbRvw/OPoMJ0KVwum4REzMyxNJhGCPpqqk6jpWfXceijbHda2/lcZbQzoYpQ3++ilH0xD2wFRlHfXRSIEHh2DO3xvr0U5qF0rWN7n/XiBX1IP84PFaqss+cQdlMlSQZzy8neNX3UHdJgaxzmFkzFQiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772813; c=relaxed/simple;
	bh=bwtbeDCOm7PgYtXtbdzDYFvX/31delFcBzapTGBjUoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABzBXMi/q8QxOXlHMdVxlz+ObxXFA7VaxDLixXYD2PSu1TUVC1ys0YJugxv6S271c8BGtvRmJa/IdoS3af5PY0DPPf1ij92XfpUcQmaEWpZcVyvw3LVoGLuPQ3gxY2jlpaASa/Tlms5jBTLDHbSbBa1ku0Z0oryGuFF2jf+aitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qGsVkBYU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U5bxzaTX; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qGsVkBYU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U5bxzaTX"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 715751800085;
	Thu,  1 Feb 2024 02:33:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Feb 2024 02:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706772809; x=1706859209; bh=pPoBr4V97R
	kdySAxGMEoE6061eddqJnta7Pyy4MnXnE=; b=qGsVkBYUrvf1V65i9qWtknr1sw
	juapT6dOkKw699zFLfd/0rWPghGj+bsjMklSPfyqW9qcuOidJ+ORbGiTy/YJk2Qe
	Z8AP4El/ZeXXIgaS+V6VjTj8jgMpYH4otNGa0dIix6vBNv/be25Vu1zh4uJWmT8/
	r4VvvJQJvqzfMuoyr6MUqWvlcNvAyKkAoEOyUfxybUcHqW1x7ftz9aITyTCQKL++
	urJJxCjGpVCOr4uE4FizPB8uJBKyn+XchNcEM8j8aCsSD28r6I0EmY3y6COXT4hP
	SqBPgBZGrLJhXWdLrgAiGYnYbMfI2LmwMtOHyFczf7OY0RfiHlol41XyXebA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706772809; x=1706859209; bh=pPoBr4V97RkdySAxGMEoE6061edd
	qJnta7Pyy4MnXnE=; b=U5bxzaTXIKkecQeRmyVuLNS5leNSXvYGBGhAjMAyy3Nc
	K0p73EqTlM6hwgkpPRMyRm861OdO5tbPFfxyJ1/PIFdREorFe+Vfh0eRR7nY+UAp
	CDApfjcJiLsuOOtwyXAjK+ajeZdHYVgENy27QaykDFiM/9PN2U1nMnBm0YdOamzz
	fhHQ8qcUszQISHHe5JyNan/7WS2YvLTLNkUJTmOHHY9csmCi73CVIcI9POqbBlUG
	jSlkMna1OqoMSvH6oPAvxOQiBmjVOmgvt51NPhLjQTitG0Cw7zXPUgWo/uhCMzdJ
	3WqOuMKFw1AlVt8gcvmKdfg/W96Pfmy3VIlqG4/AyA==
X-ME-Sender: <xms:SUm7ZaxOa7QzfdiBDG6dmuEuvIxRvvyhTSqPQ00hX7n1wj61DmIijQ>
    <xme:SUm7ZWQj5TDuh3RfUCvTmvvJRbWb965p5ReXg7aczcrarLtjj-R_1m_Nd_BF9lPRE
    BFj89FHFu-lF3z2Hg>
X-ME-Received: <xmr:SUm7ZcVB7P6n8jdis6CwDEe0oarIyQ714ejM4Et-8Z-S15Z8zN0iyXrKxWf2H1Fy4Q4z_7aieL6NSXv4TJ7YxPVy_mk75tkj3VTi-qW5IqW3bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:SUm7ZQhrLorzrF33Kb7uDIPjWTdUWe1-WJxzP1BfLOCbv5_4BmbK9A>
    <xmx:SUm7ZcCGkGFOQSEyWzdvDwLOH9OFJmFHvCX-YezIOCm6mn0WjQ3uxA>
    <xmx:SUm7ZRJ8gJ0y2sb-leE4lrUL_0GCwQfycpMQDJmbssB2FsfXahk51Q>
    <xmx:SUm7ZfOR4RzAlRyKOw6ca67CvEMw6j6YU2TyWzb4LDsrzeUs9GYyemkNVhc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:33:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e2e4e5af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:30:06 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:33:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 9/9] reftable/record: improve semantics when initializing
 records
Message-ID: <c39d7e30e77745fb6dcea3f287f38e4a4c041202.1706772591.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1706772591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vducGbTdq/ff668u"
Content-Disposition: inline
In-Reply-To: <cover.1706772591.git.ps@pks.im>


--vducGbTdq/ff668u
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


--vducGbTdq/ff668u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7SUYACgkQVbJhu7ck
PpSzPg/9F+osn75aV4i1eh30+mnFqPrbwnbjfylKZ/eqt+FexJS7eP6T1NtBY0Ev
oaT7VUXcyfYqoUBqSe2s/BC0JjqztAi1YoLfLYnOfQzJ3S3InddRhC01QXxn4UgV
hz/ktkEYiaAkx2Fb2q1ur+aDbP9I51xzIEUYHqI9act2MlLKsi4vxzcx0msFq26K
8nZFEsMWIjawU7rFty44r4GuZ3zegWcqf8D7NlszUCfrAeE8CFcJRFRJb5FiqP+t
jkBEgKEwFmW/jpxtxAJeHaOQyJkWuBHWPaDuXV13Db+u1WA4i9GlJ5UDHufWkWiv
7AfZMHV7dpg4AA3j9unb06ODZ+/51ZAqwCXKW3rqi+8nArbDFxs6DGJJvlvZKH8G
y5fbZ24m1ovX1quQUdfL4fq9KFAuO2nh0O9Di0rC8b0HRLd1oFZ1c73l4WWmja0l
GKEr9AhOmpLGhRFHpPesd3eBGEwO3jA42naswS1OSpWbVLfIhtPiRfnTYKEadxFL
MEek55dIxEobzSEOnpXfWXMYSHNt2kMAoL4F7ZJhmtu8JnTGWODJS3uAVKMXq1gR
DxUxmkmgetpq6HJ+ekuDggvSwXal+gerel1PbqPTZv9XYJYb8FQ4HLl1TP0glJk1
bH1A1XKDyQ1t8rBao/d7YpUhppdG0DJuH1dwegja0bwuLWruxAY=
=AB0Q
-----END PGP SIGNATURE-----

--vducGbTdq/ff668u--
