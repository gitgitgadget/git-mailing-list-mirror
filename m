Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739135A0FA
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640681; cv=none; b=Jg21FLjQdhktnR5RbZDTB6t7gNilw+Avek8xkuiS7rqS86M2fq01yqsowT+ApwLvrqUIQjIpCKsMQ2nD4R6wv8xQknODrmVooYbEmyuYjs1H9Wndn4qFUBYuGu4PXjJ2Yvb/Bq1uLsm6IfjNoqnvBKBAeF27g2YOOnJt1n5HcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640681; c=relaxed/simple;
	bh=UdSwluvUDxuRdFR7QXEp1ysFtYvADLIDNcht5uUDcXo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfW2B/ZDySPzZc+MJd7yyMiFQI9bWt05+IQjKCNz4lKuj8yw0poZOUw9RC6OoopeWx1wubOdQ/NjhunD7OmZrXsOK80oFK1hTVHTS0/T22toVBiLNzg9Hq/Xd+9DMfUs3u2D/fpy3BNqlYl2+Oviaf6iqanTzLemosYlOb6Ccs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dtKJ6fn1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mlUZisOq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dtKJ6fn1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mlUZisOq"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8F4721380132
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 07:11:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 07:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709640678; x=1709727078; bh=ajQBfxepG3
	Q95KEGTE0RwfPMggDJ+k1fn2B91xXp04E=; b=dtKJ6fn1UJnXygZ1mMCUimmzZ/
	zBbrTLs9AS0c8Pppr2aDp8+qkiuyr2tAhTCUDPOSxgxcJpRi7Dg+fCyDhucNJ1zR
	chjq2pmrLHpFTGl3n6LaBszyo8x25fzLRd9ysh1B962fCXQODATVcvvnwb9MmV4E
	LUqg1OsfbCH/FdpRssiQR8pgOheivEEhYobUiNrmkJ1A4MnYfVFsXiHHQuE0GE0o
	mqQAQSKu+yvSl9iclg6XF8KemL5AQWgATqtSPHFre8TCWvORQzjw3U7CffWvZWeG
	qv23H7BzkX3IJX9vtbUFnILWMh07K6fhbSvBofluKXycMHAerPPjzWlG1yAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709640678; x=1709727078; bh=ajQBfxepG3Q95KEGTE0RwfPMggDJ
	+k1fn2B91xXp04E=; b=mlUZisOqlE0nZMCYzPKqYMdfF4PU08evttI6FbETr/BJ
	GWGBGqVKTmSVusIEWNpIIT1wbQnDCqnESsc8F68qE70VMM1LM0brnev9m+xZvU/2
	zpgkABVZZTEdEGT1AXYIjbxoZy2OkLBrdEO4aEIvsJyNOP1F0TjpFMZnGJbwB1WX
	1mFQcD9wIc/TY/Ns10GJXJu6JJKf8gAJcRB5yXUQdvtBcEGfWbuF/kpCSrZohHXQ
	KW0XmolkpY54Ul6OZQhk6DmK80kAdg3h+j4QnHSRpeMqZo8HbmH8kRhEFtjDzh9e
	H0GOsugTVY495PtPLrKg8E2FaqCLgVco1XhDENtUJw==
X-ME-Sender: <xms:5gvnZSglVF2yfacYRFgHxeRZG2Rlq4lISTey8a6MHOZLHcI-4cmElw>
    <xme:5gvnZTDeC4_KuRD66mUq02j5umOip1hBAJhA7zzC-r90MPVjFYpNZ97g7vdDKQIPI
    JnTjHIgsjOM_lfUuw>
X-ME-Received: <xmr:5gvnZaESTf2yoZPIteUtIZ5r6GpPpEobYqlqYtQvABQY0rH4FtpU0QpoNOduqVQnePOIJnyw7ySVyi4ANFvpCaBPpDfZU5I6_PYpwCGg9n-O84g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpefhfeejgffhlefhhedvhfdtjeetkeevteejff
    fgleejgedthfetudevgfegtdfgkeenucffohhmrghinhepuhhpuggrthgvrdhnrghmvgdp
    uhhpuggrthgvrdgvmhgrihhlpdhuphgurghtvgdrthiipdhuphgurghtvgdrnhgvfienuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhm
X-ME-Proxy: <xmx:5gvnZbQA3SewYlJT-0MKH3G0uwofCpGB8nxJPMTzL3kFEh-yGoBaxg>
    <xmx:5gvnZfzI7oFPhigFlAnDdHmGwMn3wrbsSJsjzqKE9gx077UpA-SEyQ>
    <xmx:5gvnZZ6XdCyNcnfxZaZ_1QxeCUDNwrEMfYBuWMo1FnAu3MLTyQRaDA>
    <xmx:5gvnZYruR2iqWOfVOMznykCIOUvtwXE-70tOfMNPtYbste5LzFhksw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 5 Mar 2024 07:11:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8bd26769 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 5 Mar 2024 12:06:50 +0000 (UTC)
Date: Tue, 5 Mar 2024 13:11:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/7] reftable/record: use scratch buffer when decoding records
Message-ID: <e0a9057593f761917a3e6fb9a77045400e2b9d1c.1709640322.git.ps@pks.im>
References: <cover.1709640322.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y6o2N2iWFOl7DQuD"
Content-Disposition: inline
In-Reply-To: <cover.1709640322.git.ps@pks.im>


--Y6o2N2iWFOl7DQuD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When decoding log records we need a temporary buffer to decode the
reflog entry's name, mail address and message. As this buffer is local
to the function we thus have to reallocate it for every single log
record which we're about to decode, which is inefficient.

Refactor the code such that callers need to pass in a scratch buffer,
which allows us to reuse it for multiple decodes. This reduces the
number of allocations when iterating through reflogs. Before:

    HEAP SUMMARY:
        in use at exit: 13,473 bytes in 122 blocks
      total heap usage: 2,068,487 allocs, 2,068,365 frees, 305,122,946 byte=
s allocated

After:

    HEAP SUMMARY:
        in use at exit: 13,473 bytes in 122 blocks
      total heap usage: 1,068,485 allocs, 1,068,363 frees, 281,122,886 byte=
s allocated

Note that this commit also drop some redundant calls to `strbuf_reset()`
right before calling `decode_string()`. The latter already knows to
reset the buffer, so there is no need for these.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c       |  4 ++-
 reftable/block.h       |  2 ++
 reftable/record.c      | 52 ++++++++++++++++++--------------------
 reftable/record.h      |  5 ++--
 reftable/record_test.c | 57 ++++++++++++++++++++++++++----------------
 5 files changed, 68 insertions(+), 52 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index ad9074dba6..b67300a734 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -332,7 +332,8 @@ int block_iter_next(struct block_iter *it, struct refta=
ble_record *rec)
 		return REFTABLE_FORMAT_ERROR;
=20
 	string_view_consume(&in, n);
-	n =3D reftable_record_decode(rec, it->last_key, extra, in, it->br->hash_s=
ize);
+	n =3D reftable_record_decode(rec, it->last_key, extra, in, it->br->hash_s=
ize,
+				   &it->scratch);
 	if (n < 0)
 		return -1;
 	string_view_consume(&in, n);
@@ -369,6 +370,7 @@ int block_iter_seek(struct block_iter *it, struct strbu=
f *want)
 void block_iter_close(struct block_iter *it)
 {
 	strbuf_release(&it->last_key);
+	strbuf_release(&it->scratch);
 }
=20
 int block_reader_seek(struct block_reader *br, struct block_iter *it,
diff --git a/reftable/block.h b/reftable/block.h
index 51699af233..47acc62c0a 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -84,10 +84,12 @@ struct block_iter {
=20
 	/* key for last entry we read. */
 	struct strbuf last_key;
+	struct strbuf scratch;
 };
=20
 #define BLOCK_ITER_INIT { \
 	.last_key =3D STRBUF_INIT, \
+	.scratch =3D STRBUF_INIT, \
 }
=20
 /* initializes a block reader. */
diff --git a/reftable/record.c b/reftable/record.c
index 7c86877586..060244337f 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -374,7 +374,7 @@ static int reftable_ref_record_encode(const void *rec, =
struct string_view s,
=20
 static int reftable_ref_record_decode(void *rec, struct strbuf key,
 				      uint8_t val_type, struct string_view in,
-				      int hash_size)
+				      int hash_size, struct strbuf *scratch)
 {
 	struct reftable_ref_record *r =3D rec;
 	struct string_view start =3D in;
@@ -425,13 +425,12 @@ static int reftable_ref_record_decode(void *rec, stru=
ct strbuf key,
 		break;
=20
 	case REFTABLE_REF_SYMREF: {
-		struct strbuf dest =3D STRBUF_INIT;
-		int n =3D decode_string(&dest, in);
+		int n =3D decode_string(scratch, in);
 		if (n < 0) {
 			return -1;
 		}
 		string_view_consume(&in, n);
-		r->value.symref =3D dest.buf;
+		r->value.symref =3D strbuf_detach(scratch, NULL);
 	} break;
=20
 	case REFTABLE_REF_DELETION:
@@ -579,7 +578,7 @@ static int reftable_obj_record_encode(const void *rec, =
struct string_view s,
=20
 static int reftable_obj_record_decode(void *rec, struct strbuf key,
 				      uint8_t val_type, struct string_view in,
-				      int hash_size)
+				      int hash_size, struct strbuf *scratch UNUSED)
 {
 	struct string_view start =3D in;
 	struct reftable_obj_record *r =3D rec;
@@ -849,13 +848,12 @@ static int reftable_log_record_encode(const void *rec=
, struct string_view s,
=20
 static int reftable_log_record_decode(void *rec, struct strbuf key,
 				      uint8_t val_type, struct string_view in,
-				      int hash_size)
+				      int hash_size, struct strbuf *scratch)
 {
 	struct string_view start =3D in;
 	struct reftable_log_record *r =3D rec;
 	uint64_t max =3D 0;
 	uint64_t ts =3D 0;
-	struct strbuf dest =3D STRBUF_INIT;
 	int n;
=20
 	if (key.len <=3D 9 || key.buf[key.len - 9] !=3D 0)
@@ -892,7 +890,7 @@ static int reftable_log_record_decode(void *rec, struct=
 strbuf key,
=20
 	string_view_consume(&in, 2 * hash_size);
=20
-	n =3D decode_string(&dest, in);
+	n =3D decode_string(scratch, in);
 	if (n < 0)
 		goto done;
 	string_view_consume(&in, n);
@@ -904,26 +902,25 @@ static int reftable_log_record_decode(void *rec, stru=
ct strbuf key,
 	 * skip copying over the name in case it's accurate already.
 	 */
 	if (!r->value.update.name ||
-	    strcmp(r->value.update.name, dest.buf)) {
+	    strcmp(r->value.update.name, scratch->buf)) {
 		r->value.update.name =3D
-			reftable_realloc(r->value.update.name, dest.len + 1);
-		memcpy(r->value.update.name, dest.buf, dest.len);
-		r->value.update.name[dest.len] =3D 0;
+			reftable_realloc(r->value.update.name, scratch->len + 1);
+		memcpy(r->value.update.name, scratch->buf, scratch->len);
+		r->value.update.name[scratch->len] =3D 0;
 	}
=20
-	strbuf_reset(&dest);
-	n =3D decode_string(&dest, in);
+	n =3D decode_string(scratch, in);
 	if (n < 0)
 		goto done;
 	string_view_consume(&in, n);
=20
 	/* Same as above, but for the reflog email. */
 	if (!r->value.update.email ||
-	    strcmp(r->value.update.email, dest.buf)) {
+	    strcmp(r->value.update.email, scratch->buf)) {
 		r->value.update.email =3D
-			reftable_realloc(r->value.update.email, dest.len + 1);
-		memcpy(r->value.update.email, dest.buf, dest.len);
-		r->value.update.email[dest.len] =3D 0;
+			reftable_realloc(r->value.update.email, scratch->len + 1);
+		memcpy(r->value.update.email, scratch->buf, scratch->len);
+		r->value.update.email[scratch->len] =3D 0;
 	}
=20
 	ts =3D 0;
@@ -938,22 +935,19 @@ static int reftable_log_record_decode(void *rec, stru=
ct strbuf key,
 	r->value.update.tz_offset =3D get_be16(in.buf);
 	string_view_consume(&in, 2);
=20
-	strbuf_reset(&dest);
-	n =3D decode_string(&dest, in);
+	n =3D decode_string(scratch, in);
 	if (n < 0)
 		goto done;
 	string_view_consume(&in, n);
=20
-	REFTABLE_ALLOC_GROW(r->value.update.message, dest.len + 1,
+	REFTABLE_ALLOC_GROW(r->value.update.message, scratch->len + 1,
 			    r->value.update.message_cap);
-	memcpy(r->value.update.message, dest.buf, dest.len);
-	r->value.update.message[dest.len] =3D 0;
+	memcpy(r->value.update.message, scratch->buf, scratch->len);
+	r->value.update.message[scratch->len] =3D 0;
=20
-	strbuf_release(&dest);
 	return start.len - in.len;
=20
 done:
-	strbuf_release(&dest);
 	return REFTABLE_FORMAT_ERROR;
 }
=20
@@ -1093,7 +1087,7 @@ static int reftable_index_record_encode(const void *r=
ec, struct string_view out,
=20
 static int reftable_index_record_decode(void *rec, struct strbuf key,
 					uint8_t val_type, struct string_view in,
-					int hash_size)
+					int hash_size, struct strbuf *scratch UNUSED)
 {
 	struct string_view start =3D in;
 	struct reftable_index_record *r =3D rec;
@@ -1174,10 +1168,12 @@ uint8_t reftable_record_val_type(struct reftable_re=
cord *rec)
 }
=20
 int reftable_record_decode(struct reftable_record *rec, struct strbuf key,
-			   uint8_t extra, struct string_view src, int hash_size)
+			   uint8_t extra, struct string_view src, int hash_size,
+			   struct strbuf *scratch)
 {
 	return reftable_record_vtable(rec)->decode(reftable_record_data(rec),
-						   key, extra, src, hash_size);
+						   key, extra, src, hash_size,
+						   scratch);
 }
=20
 void reftable_record_release(struct reftable_record *rec)
diff --git a/reftable/record.h b/reftable/record.h
index 5e8304e052..826ee1c55c 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -55,7 +55,8 @@ struct reftable_record_vtable {
=20
 	/* decode data from `src` into the record. */
 	int (*decode)(void *rec, struct strbuf key, uint8_t extra,
-		      struct string_view src, int hash_size);
+		      struct string_view src, int hash_size,
+		      struct strbuf *scratch);
=20
 	/* deallocate and null the record. */
 	void (*release)(void *rec);
@@ -138,7 +139,7 @@ int reftable_record_encode(struct reftable_record *rec,=
 struct string_view dest,
 			   int hash_size);
 int reftable_record_decode(struct reftable_record *rec, struct strbuf key,
 			   uint8_t extra, struct string_view src,
-			   int hash_size);
+			   int hash_size, struct strbuf *scratch);
 int reftable_record_is_deletion(struct reftable_record *rec);
=20
 static inline uint8_t reftable_record_type(struct reftable_record *rec)
diff --git a/reftable/record_test.c b/reftable/record_test.c
index 57e56138c0..c158ee79ff 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -99,6 +99,7 @@ static void set_hash(uint8_t *h, int j)
=20
 static void test_reftable_ref_record_roundtrip(void)
 {
+	struct strbuf scratch =3D STRBUF_INIT;
 	int i =3D 0;
=20
 	for (i =3D REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
@@ -140,7 +141,7 @@ static void test_reftable_ref_record_roundtrip(void)
 		EXPECT(n > 0);
=20
 		/* decode into a non-zero reftable_record to test for leaks. */
-		m =3D reftable_record_decode(&out, key, i, dest, GIT_SHA1_RAWSZ);
+		m =3D reftable_record_decode(&out, key, i, dest, GIT_SHA1_RAWSZ, &scratc=
h);
 		EXPECT(n =3D=3D m);
=20
 		EXPECT(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
@@ -150,6 +151,8 @@ static void test_reftable_ref_record_roundtrip(void)
 		strbuf_release(&key);
 		reftable_record_release(&out);
 	}
+
+	strbuf_release(&scratch);
 }
=20
 static void test_reftable_log_record_equal(void)
@@ -175,7 +178,6 @@ static void test_reftable_log_record_equal(void)
 static void test_reftable_log_record_roundtrip(void)
 {
 	int i;
-
 	struct reftable_log_record in[] =3D {
 		{
 			.refname =3D xstrdup("refs/heads/master"),
@@ -202,6 +204,8 @@ static void test_reftable_log_record_roundtrip(void)
 			.value_type =3D REFTABLE_LOG_UPDATE,
 		}
 	};
+	struct strbuf scratch =3D STRBUF_INIT;
+
 	set_test_hash(in[0].value.update.new_hash, 1);
 	set_test_hash(in[0].value.update.old_hash, 2);
 	set_test_hash(in[2].value.update.new_hash, 3);
@@ -241,7 +245,7 @@ static void test_reftable_log_record_roundtrip(void)
 		EXPECT(n >=3D 0);
 		valtype =3D reftable_record_val_type(&rec);
 		m =3D reftable_record_decode(&out, key, valtype, dest,
-					   GIT_SHA1_RAWSZ);
+					   GIT_SHA1_RAWSZ, &scratch);
 		EXPECT(n =3D=3D m);
=20
 		EXPECT(reftable_log_record_equal(&in[i], &out.u.log,
@@ -250,6 +254,8 @@ static void test_reftable_log_record_roundtrip(void)
 		strbuf_release(&key);
 		reftable_record_release(&out);
 	}
+
+	strbuf_release(&scratch);
 }
=20
 static void test_u24_roundtrip(void)
@@ -299,23 +305,27 @@ static void test_reftable_obj_record_roundtrip(void)
 {
 	uint8_t testHash1[GIT_SHA1_RAWSZ] =3D { 1, 2, 3, 4, 0 };
 	uint64_t till9[] =3D { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
-	struct reftable_obj_record recs[3] =3D { {
-						       .hash_prefix =3D testHash1,
-						       .hash_prefix_len =3D 5,
-						       .offsets =3D till9,
-						       .offset_len =3D 3,
-					       },
-					       {
-						       .hash_prefix =3D testHash1,
-						       .hash_prefix_len =3D 5,
-						       .offsets =3D till9,
-						       .offset_len =3D 9,
-					       },
-					       {
-						       .hash_prefix =3D testHash1,
-						       .hash_prefix_len =3D 5,
-					       } };
+	struct reftable_obj_record recs[3] =3D {
+		{
+			.hash_prefix =3D testHash1,
+			.hash_prefix_len =3D 5,
+			.offsets =3D till9,
+			.offset_len =3D 3,
+		},
+		{
+			.hash_prefix =3D testHash1,
+			.hash_prefix_len =3D 5,
+			.offsets =3D till9,
+			.offset_len =3D 9,
+		},
+		{
+			.hash_prefix =3D testHash1,
+			.hash_prefix_len =3D 5,
+		},
+	};
+	struct strbuf scratch =3D STRBUF_INIT;
 	int i =3D 0;
+
 	for (i =3D 0; i < ARRAY_SIZE(recs); i++) {
 		uint8_t buffer[1024] =3D { 0 };
 		struct string_view dest =3D {
@@ -339,13 +349,15 @@ static void test_reftable_obj_record_roundtrip(void)
 		EXPECT(n > 0);
 		extra =3D reftable_record_val_type(&in);
 		m =3D reftable_record_decode(&out, key, extra, dest,
-					   GIT_SHA1_RAWSZ);
+					   GIT_SHA1_RAWSZ, &scratch);
 		EXPECT(n =3D=3D m);
=20
 		EXPECT(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
 		strbuf_release(&key);
 		reftable_record_release(&out);
 	}
+
+	strbuf_release(&scratch);
 }
=20
 static void test_reftable_index_record_roundtrip(void)
@@ -362,6 +374,7 @@ static void test_reftable_index_record_roundtrip(void)
 		.buf =3D buffer,
 		.len =3D sizeof(buffer),
 	};
+	struct strbuf scratch =3D STRBUF_INIT;
 	struct strbuf key =3D STRBUF_INIT;
 	struct reftable_record out =3D {
 		.type =3D BLOCK_TYPE_INDEX,
@@ -379,13 +392,15 @@ static void test_reftable_index_record_roundtrip(void)
 	EXPECT(n > 0);
=20
 	extra =3D reftable_record_val_type(&in);
-	m =3D reftable_record_decode(&out, key, extra, dest, GIT_SHA1_RAWSZ);
+	m =3D reftable_record_decode(&out, key, extra, dest, GIT_SHA1_RAWSZ,
+				   &scratch);
 	EXPECT(m =3D=3D n);
=20
 	EXPECT(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
=20
 	reftable_record_release(&out);
 	strbuf_release(&key);
+	strbuf_release(&scratch);
 	strbuf_release(&in.u.idx.last_key);
 }
=20
--=20
2.44.0


--Y6o2N2iWFOl7DQuD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXnC+MACgkQVbJhu7ck
PpTGhg/9Esi54eic1g/HqQ2phue60ljlUkc4ylVmHdO9h2/kIB3bRcTTQYU1K8Wg
ACnoexDPrDofkBo5FCfUr4KPH185c68xDU7RR3d0CtGCWc6LkAmz03n6xcQYYoW8
Zyf46cigSNfhsGq8DaGFb9IM1mhifCmvI5vMFpfHREIrAqZkvgrj4CRgl0JEAtMC
ZKHTBx5vf4WeqTm9apYPyVmYuG8nfQUy9WiBGmsPLpjoY1NwXwxrZNL5vXX78xGi
OUwcYSJ9o4UgYbondofHeeNJggWZZ0wjaBano012U6Grg+FwjSyN0rqpCdp1/epC
YHvdq2zR7n69cBVkDJOpo5vbpt2ouc6kjyCz09fVM3J5oknU2vHYHti4fWo5OdgO
CP5pKy6Z7kFNY9bZ3MQed1S0NBGZ8ppLXi2lVbjYNKpHPleUZLgLG8lOeV6Jt6L5
vEzG9BIHKDtpdgXAyzo16qTYGPZEWX60SVM7GOjX/sfdGpegQxOsvVQ2f+6Sin4D
DxWNP1VfKz6uQcjATzeCdMD7WFfw1hoME7F8uRN/YXpPhz8HS3//VdMtFLeqIZkL
F/fuR0T5Pv854ASAu8cShBg/DgHGXMSM5oBwueYWDfSXKjisPTAJxLqY0Zqq6LEG
BzMqtQ5nkqNtIAfeeIEsK+PYss6FaE5uCXDuw1QPXppvgjQhM+k=
=Luh2
-----END PGP SIGNATURE-----

--Y6o2N2iWFOl7DQuD--
