Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0856128365
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201366; cv=none; b=r/1pGYnNp2YHiSi82emj8ZLwQ6puwtUKdruutZw9LNcU6gwjRLVGBw7gNvu+fHPX2LUChyRoajqK5k4Jg2BwSXOSJsqf12z/Qjb4JErkyMPhM67n0hBr1P4vKlSGSu0JZ4+lBgwkfuR/zAgrYGo6OmM02ALMbikqJg/VCltBnnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201366; c=relaxed/simple;
	bh=HuApduXqJ8qWx+31eaQljBHY1FlKGtlyBxj9MfA2pmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlGZ8vOPsZ2aBX9Asjm/gTz98jjfe9Ykyrl9uGEukYNDEnP8UYSZTaSSvs4u2QAc/K/D2ng1wybKULLe12psBy3avDh8zZeA04h85WLbyct2R0rKoqLNB1hIKDs5cdZQ8M/WGZdJTKWV3Z9iO0ZzF5vAbE3IKno5/SdUKjQYL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SUh07HlI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=koStJ7rU; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SUh07HlI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="koStJ7rU"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id AD4953200AEA;
	Tue,  6 Feb 2024 01:36:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 06 Feb 2024 01:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707201363; x=1707287763; bh=Kla3aqI6gR
	0G6YcFiSd4vvI6Am/HOaZR459Pp3ShGTI=; b=SUh07HlIm92eb6wklzKAwaS1b2
	1IyfB4+Kv5Ffk6LfwUBipF5jl6+nZ+4DYz3nLU+pH60P+N4BXWKC++yLeezHuDwH
	f4fJXug0xScOuKIFwrq71h2IZ3msv/CgsWJX9wq428jPVbOKeqGeygWfyU0vRxon
	bMdvPiyFPuiEhINN3dlcIMwTwaU33zjpFXoboHSKlvnY2MrxXgESw2Iutyw0RZ0Z
	wZ/HwW/b6SqjouwBxMyB/rtrKW2bFjzoqcf9m4GKXpyToHvs7u1Gwg1cNeba8taJ
	/Ske+JibHSqHBp5Gbl3hO8ke+i8e8rp6wLTiEGOGPECRWwzoFPJ3qyZeT2Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707201363; x=1707287763; bh=Kla3aqI6gR0G6YcFiSd4vvI6Am/H
	OaZR459Pp3ShGTI=; b=koStJ7rUCMIQCFL+dmUJJYRpjThpQyhbNHVCoTRqwwg7
	k+eooPSPqfgf7iEnMxutQOvZK1NDKjX2t2rZBZJytJxKGXTiAZhrUlFBraEBDMNt
	YEdshGutRXwxKf5jitGuewyuO7dNJu2HACYgg7rZTECDYSwPnlUXr3Qm+96AX8np
	qHKbsVRhNh9a/EwWGhfflWC4Eqmmb0CcX9+DX0JBcubj2+/qNi/+9RRCC8lTWbGR
	2P1j0PNPRm651GyIkRNS1cfMi/ugVg4DFMs+a1FvSPbbomvMRA2BSteZzR/pn48o
	2H3dlUdvSke2O8t0S3SW4GIKfDvuJntU2Zir+xTU5w==
X-ME-Sender: <xms:U9PBZZ-UdLj5201Vw4OLGVZ5dY6nFkymUKDjY72h2qcMsfBMx1pKag>
    <xme:U9PBZds9tHN4OUCMhABW5L0X-PoJRMMry5HWbtBrO9XSWVj5R1ywOMh7ky0XXyv4A
    xak6cP-wAdL2xyx9A>
X-ME-Received: <xmr:U9PBZXBwlRrEJB07vzWGp-BC37RwN1vcPrH4kqdlf72oLxUJV-7fpnsoE5upEDrvPFUWokWR8n3BO1sd6W7W_b3e7VvLSM5wmpDQsvAFDLZwdgjD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:U9PBZdfryKA-80B6RVf9jl10oRq0kz9j9b6I2PxBi1MLVkM5Pl3VDg>
    <xmx:U9PBZeNY5xH7Ac4G3mTyOIti8BEMFR3_DU4Zin_mLevzoGH-0x3TbA>
    <xmx:U9PBZflmh8WHeNEu7D4ZBXpo8Np5nm82N0Tt-RiBfuFsmZZNzgpTLg>
    <xmx:U9PBZbr0d3JG26ur1xMTHUTp9MvgpXaR02yJyn5Qm9fR2jkYLsoX4Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 01:36:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d53a8ba3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 06:32:32 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:35:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 9/9] reftable/record: improve semantics when initializing
 records
Message-ID: <5bb2858c1366367e293ca81838c08b643420026b.1707200355.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1707200355.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u9DoU3Y1i6cfpfVa"
Content-Disposition: inline
In-Reply-To: <cover.1707200355.git.ps@pks.im>


--u9DoU3Y1i6cfpfVa
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
index 838759823a..ce8a7d24f3 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -382,23 +382,23 @@ int block_reader_seek(struct block_reader *br, struct=
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
index 2f3cd6b62c..26c5e43f9b 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1259,45 +1259,22 @@ reftable_record_vtable(struct reftable_record *rec)
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


--u9DoU3Y1i6cfpfVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB008ACgkQVbJhu7ck
PpTxtA/9EhSRMARivl/ctseCf2DEEkKAKKjTtw9YdpHbpk40JI5PiWQdgj+ZNZAH
dtVcWH/0pJU4Xry5kZukokEtZhrw5pNkmOV2ceL58QpGIQKkdfRudFFNlsiGY2ZI
IWOnqYivyALslmu2zTk1WVU4bHYujrJRWuH6CG0EjfOiK/0tRzrcseFJwaMOioB8
QgJ9A9cV9m2FMUz2ibByylFxfccbinscRXVYU4jhHWzNyJxulx6KfLTcNOdiSJyf
dwTMbsoizkDbW3EFB2h+6hDI+XMGm7/Iht82KFfvUJb2FCRFUTUjV3XsQxMNqQGr
2XRFpm5RebILy7jN4oAxZHzhyEM3rwbgjCQ0Z/5GYGJdO5joOR5l4T2FuvTHBysG
AuCTqI1UvDgq60SMEC6QWJJHjqmbyaYcQuZ6VCtpNxfFX/An7QT/NwL/Qa0n054k
nnQxfjoU6HJP7mn6im8rzHu4JfHruKda8KneGk4JrIQuHjuw/QqnIoAgyB8/b4yh
WvaZ9S59h+qsxrKEYn4SJiGOiE59oefn7RZhzydlsgUkReAchTorY5R4Uanyg4AM
dx+9kvY+a1rLHM34ECNYCgRUEVkmH2g1mBAGCAAwBXr/dBGLJZiucHA5HU37a2yw
E1lPSwqLVN6Q9mCwdLjtD9I5EzUJfQpi0UmTxXPKqb9fmoT3+rU=
=MCHR
-----END PGP SIGNATURE-----

--u9DoU3Y1i6cfpfVa--
