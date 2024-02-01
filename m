Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CFE158D9D
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772785; cv=none; b=mXfpNegFLFgDwK/SAgdX5uQlRR6enG6GRk/+5jy6WGqbTQPgj2IvBz+1mnxYT/myuxqIQl1YO2PKZPWwGz1Y83nFCoPtZuCfkIZhuRj3dcdVHFrozcGX/t5kzCNGjRmWEmFRgv3wP6KQp0u0UDKyDbZEg+dqhCa5cCpPIDsoB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772785; c=relaxed/simple;
	bh=CI74UhAWW//ibkliJwkRJbxN66qAAGoeim2w9J9h0BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quGFn6Xa4zb1Xk8LBS69SRdKiZ8DGXtvE0PIySuvj50HoPeCZCx+6HiWKlozW+W4gR7gOTT2LTTn2A+1hM78Eu/AHIG2EZLYiS+UkY3hEDZZIFmh5AvmGwIeQuCCJOHWS3xR4gBDAGN4y4UaZtR9FQxyUdoVSUXWqArjIjMc2lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ibgGMVMa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eSZqUEIn; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ibgGMVMa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eSZqUEIn"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id DEC521800085;
	Thu,  1 Feb 2024 02:33:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 02:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706772781; x=1706859181; bh=/baS00s2x0
	xo6vipX22IiF8Xbf1nQscP95sr9tl1rdI=; b=ibgGMVMaDkxHgns/GmrrnqqnJh
	f0CrJVfoNTqBntnjH60psTpvjY4bGxYumVTgLVmVMpjlCSkL+7GTGePSDMQzS5FF
	dPca2m1hYppUemBIQh7r0osQP2pmlogEz1lS/yEtzT56kstEEm7AUTgoGh9yne57
	OMHRmmulxihyq/eTqdGEHesRfgYnWQ1XaJEKF/bAYrJPvxv6TBekrLgnH3AixYpH
	fKh5jKwtOeP86irYE9HUgmymKrIzMofssVfZWAoPAVe9hSDR9Dm/uuwoaKoZJvLm
	NqqfV21V1yYAgXzmavVrf9bvupiFpTviqR+cmmftYD97YiMe0tDtVVaprprQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706772781; x=1706859181; bh=/baS00s2x0xo6vipX22IiF8Xbf1n
	QscP95sr9tl1rdI=; b=eSZqUEInRdDGJhHRGwhTN1KFlMRVgbRm58eg2RG7LQO7
	E5SUgdJv5Bu4l7xdVzDIDrS0OwZOHxA697b1g1m4lEq4xj+T+upm+DnNZ83pEI5g
	2xDzkTilNYMABeh1It9tLzdRL29Bgx5kprVv8mbZlG0+o3/7wkn7B1zethmJXxEq
	wmrMf16BzgiYT7W4ZKO1j0JTWegHq5lc91oCRJrYMgWYeLZqn2fHR+4fl1ymKDhi
	iUnbXh1A0MyT6GZzKVsNLK2RFzC2Zf/MlHHauiFJTulczMYDKvSmHqXU78NZumLs
	w79r/wVDGKJdn5+vLDeJbH958PRQxIt3sRFwwqtKbA==
X-ME-Sender: <xms:LUm7ZSGNZo2hz3ND0IiNKyvy2KRPBCg8PAaZ0qYT8sdGKDtz41F1Kg>
    <xme:LUm7ZTXZ11dtP0zS7yDunmfBKt84U5zNpJ-8KAR-Nm8LwZpzFJrx1XWu9__7_Bob2
    z1FIByWSnU0CFZtzw>
X-ME-Received: <xmr:LUm7ZcJxSX4RVFXa3JPmi7ZK7Cbn6ybrKjUmczehNPtKLupsKqFzQDLATGHHbnOI9cP7zQP_E6N5D-o8IWvlhGg2VljW9ZZOPsbPu4zLxFl0_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:LUm7ZcEnNSHpeCIFUBE3JAb1Y-sq8XnAMOrIwScy27dzociT99Y6Xw>
    <xmx:LUm7ZYUXiSX05S2IXzALfRXLgfQ4qjNkdZYBDevXeWckHxYqXRzgrQ>
    <xmx:LUm7ZfMdA6x0znsFWPWrLxyjReDP71Y0MsAspNmcyfc9WIBp_5dAXg>
    <xmx:LUm7ZfQuyEL39ptgX8qZJuQfuVqAvMAWS_xX6KNZLDCSJTO61aEehaj7UI4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:33:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8cc733b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:29:38 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:32:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/9] reftable: introduce macros to allocate arrays
Message-ID: <2dde581a0256e4634ca4a64f313a98204763906a.1706772591.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1706772591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="axff/IdKVcXVmdqO"
Content-Disposition: inline
In-Reply-To: <cover.1706772591.git.ps@pks.im>


--axff/IdKVcXVmdqO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Similar to the preceding commit, let's carry over macros to allocate
arrays with `REFTABLE_ALLOC_ARRAY()` and `REFTABLE_CALLOC_ARRAY()`. This
requires us to change the signature of `reftable_calloc()`, which only
takes a single argument right now and thus puts the burden on the caller
to calculate the final array's size. This is a net improvement though as
it means that we can now provide proper overflow checks when multiplying
the array size with the member size.

Convert callsites of `reftable_calloc()` to the new signature, using the
new macros where possible.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h         |  4 +++-
 reftable/block_test.c     |  2 +-
 reftable/blocksource.c    |  4 ++--
 reftable/iter.c           |  3 +--
 reftable/merged.c         |  4 ++--
 reftable/merged_test.c    | 22 +++++++++++++---------
 reftable/publicbasics.c   |  3 ++-
 reftable/reader.c         |  8 +++-----
 reftable/readwrite_test.c |  8 +++++---
 reftable/record_test.c    |  4 ++--
 reftable/refname.c        |  4 ++--
 reftable/stack.c          | 26 ++++++++++++--------------
 reftable/tree.c           |  4 ++--
 reftable/writer.c         |  7 +++----
 14 files changed, 53 insertions(+), 50 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index 2f855cd724..4c3ac963a3 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -51,8 +51,10 @@ int names_length(char **names);
 void *reftable_malloc(size_t sz);
 void *reftable_realloc(void *p, size_t sz);
 void reftable_free(void *p);
-void *reftable_calloc(size_t sz);
+void *reftable_calloc(size_t nelem, size_t elsize);
=20
+#define REFTABLE_ALLOC_ARRAY(x, alloc) (x) =3D reftable_malloc(st_mult(siz=
eof(*(x)), (alloc)))
+#define REFTABLE_CALLOC_ARRAY(x, alloc) (x) =3D reftable_calloc((alloc), s=
izeof(*(x)))
 #define REFTABLE_REALLOC_ARRAY(x, alloc) (x) =3D reftable_realloc((x), st_=
mult(sizeof(*(x)), (alloc)))
 #define REFTABLE_ALLOC_GROW(x, nr, alloc) \
 	do { \
diff --git a/reftable/block_test.c b/reftable/block_test.c
index dedb05c7d8..e162c6e33f 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -36,7 +36,7 @@ static void test_block_read_write(void)
 	int j =3D 0;
 	struct strbuf want =3D STRBUF_INIT;
=20
-	block.data =3D reftable_calloc(block_size);
+	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	block.len =3D block_size;
 	block.source =3D malloc_block_source();
 	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 8c41e3c70f..eeed254ba9 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -29,7 +29,7 @@ static int strbuf_read_block(void *v, struct reftable_blo=
ck *dest, uint64_t off,
 {
 	struct strbuf *b =3D v;
 	assert(off + size <=3D b->len);
-	dest->data =3D reftable_calloc(size);
+	REFTABLE_CALLOC_ARRAY(dest->data, size);
 	memcpy(dest->data, b->buf + off, size);
 	dest->len =3D size;
 	return size;
@@ -132,7 +132,7 @@ int reftable_block_source_from_file(struct reftable_blo=
ck_source *bs,
 		return REFTABLE_IO_ERROR;
 	}
=20
-	p =3D reftable_calloc(sizeof(*p));
+	REFTABLE_CALLOC_ARRAY(p, 1);
 	p->size =3D st.st_size;
 	p->data =3D xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
diff --git a/reftable/iter.c b/reftable/iter.c
index a8d174c040..8b5ebf6183 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -160,8 +160,7 @@ int new_indexed_table_ref_iter(struct indexed_table_ref=
_iter **dest,
 			       int oid_len, uint64_t *offsets, int offset_len)
 {
 	struct indexed_table_ref_iter empty =3D INDEXED_TABLE_REF_ITER_INIT;
-	struct indexed_table_ref_iter *itr =3D
-		reftable_calloc(sizeof(struct indexed_table_ref_iter));
+	struct indexed_table_ref_iter *itr =3D reftable_calloc(1, sizeof(*itr));
 	int err =3D 0;
=20
 	*itr =3D empty;
diff --git a/reftable/merged.c b/reftable/merged.c
index c258ce953e..2031fd51b4 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -190,7 +190,7 @@ int reftable_new_merged_table(struct reftable_merged_ta=
ble **dest,
 		}
 	}
=20
-	m =3D reftable_calloc(sizeof(struct reftable_merged_table));
+	REFTABLE_CALLOC_ARRAY(m, 1);
 	m->stack =3D stack;
 	m->stack_len =3D n;
 	m->min =3D first_min;
@@ -240,7 +240,7 @@ static int merged_table_seek_record(struct reftable_mer=
ged_table *mt,
 				    struct reftable_record *rec)
 {
 	struct reftable_iterator *iters =3D reftable_calloc(
-		sizeof(struct reftable_iterator) * mt->stack_len);
+		mt->stack_len, sizeof(*iters));
 	struct merged_iter merged =3D {
 		.stack =3D iters,
 		.typ =3D reftable_record_type(rec),
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index e05351e035..e233a9d581 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -93,10 +93,12 @@ merged_table_from_records(struct reftable_ref_record **=
refs,
 	int i =3D 0;
 	struct reftable_merged_table *mt =3D NULL;
 	int err;
-	struct reftable_table *tabs =3D
-		reftable_calloc(n * sizeof(struct reftable_table));
-	*readers =3D reftable_calloc(n * sizeof(struct reftable_reader *));
-	*source =3D reftable_calloc(n * sizeof(**source));
+	struct reftable_table *tabs;
+
+	REFTABLE_CALLOC_ARRAY(tabs, n);
+	REFTABLE_CALLOC_ARRAY(*readers, n);
+	REFTABLE_CALLOC_ARRAY(*source, n);
+
 	for (i =3D 0; i < n; i++) {
 		write_test_table(&buf[i], refs[i], sizes[i]);
 		block_source_from_strbuf(&(*source)[i], &buf[i]);
@@ -266,10 +268,12 @@ merged_table_from_log_records(struct reftable_log_rec=
ord **logs,
 	int i =3D 0;
 	struct reftable_merged_table *mt =3D NULL;
 	int err;
-	struct reftable_table *tabs =3D
-		reftable_calloc(n * sizeof(struct reftable_table));
-	*readers =3D reftable_calloc(n * sizeof(struct reftable_reader *));
-	*source =3D reftable_calloc(n * sizeof(**source));
+	struct reftable_table *tabs;
+
+	REFTABLE_CALLOC_ARRAY(tabs, n);
+	REFTABLE_CALLOC_ARRAY(*readers, n);
+	REFTABLE_CALLOC_ARRAY(*source, n);
+
 	for (i =3D 0; i < n; i++) {
 		write_test_log_table(&buf[i], logs[i], sizes[i], i + 1);
 		block_source_from_strbuf(&(*source)[i], &buf[i]);
@@ -412,7 +416,7 @@ static void test_default_write_opts(void)
 	};
 	int err;
 	struct reftable_block_source source =3D { NULL };
-	struct reftable_table *tab =3D reftable_calloc(sizeof(*tab) * 1);
+	struct reftable_table *tab =3D reftable_calloc(1, sizeof(*tab));
 	uint32_t hash_id;
 	struct reftable_reader *rd =3D NULL;
 	struct reftable_merged_table *merged =3D NULL;
diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
index bcb82530d6..44b84a125e 100644
--- a/reftable/publicbasics.c
+++ b/reftable/publicbasics.c
@@ -37,8 +37,9 @@ void reftable_free(void *p)
 		free(p);
 }
=20
-void *reftable_calloc(size_t sz)
+void *reftable_calloc(size_t nelem, size_t elsize)
 {
+	size_t sz =3D st_mult(nelem, elsize);
 	void *p =3D reftable_malloc(sz);
 	memset(p, 0, sz);
 	return p;
diff --git a/reftable/reader.c b/reftable/reader.c
index 64dc366fb1..3e0de5e8ad 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -539,8 +539,7 @@ static int reader_seek_indexed(struct reftable_reader *=
r,
=20
 	if (err =3D=3D 0) {
 		struct table_iter empty =3D TABLE_ITER_INIT;
-		struct table_iter *malloced =3D
-			reftable_calloc(sizeof(struct table_iter));
+		struct table_iter *malloced =3D reftable_calloc(1, sizeof(*malloced));
 		*malloced =3D empty;
 		table_iter_copy_from(malloced, &next);
 		iterator_from_table_iter(it, malloced);
@@ -635,8 +634,7 @@ void reader_close(struct reftable_reader *r)
 int reftable_new_reader(struct reftable_reader **p,
 			struct reftable_block_source *src, char const *name)
 {
-	struct reftable_reader *rd =3D
-		reftable_calloc(sizeof(struct reftable_reader));
+	struct reftable_reader *rd =3D reftable_calloc(1, sizeof(*rd));
 	int err =3D init_reader(rd, src, name);
 	if (err =3D=3D 0) {
 		*p =3D rd;
@@ -711,7 +709,7 @@ static int reftable_reader_refs_for_unindexed(struct re=
ftable_reader *r,
 					      uint8_t *oid)
 {
 	struct table_iter ti_empty =3D TABLE_ITER_INIT;
-	struct table_iter *ti =3D reftable_calloc(sizeof(struct table_iter));
+	struct table_iter *ti =3D reftable_calloc(1, sizeof(*ti));
 	struct filtering_ref_iterator *filter =3D NULL;
 	struct filtering_ref_iterator empty =3D FILTERING_REF_ITERATOR_INIT;
 	int oid_len =3D hash_size(r->hash_id);
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index b8a3224016..91ea7a10ef 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -56,7 +56,9 @@ static void write_table(char ***names, struct strbuf *buf=
, int N,
 	int i =3D 0, n;
 	struct reftable_log_record log =3D { NULL };
 	const struct reftable_stats *stats =3D NULL;
-	*names =3D reftable_calloc(sizeof(char *) * (N + 1));
+
+	REFTABLE_CALLOC_ARRAY(*names, N + 1);
+
 	reftable_writer_set_limits(w, update_index, update_index);
 	for (i =3D 0; i < N; i++) {
 		char name[100];
@@ -188,7 +190,7 @@ static void test_log_overflow(void)
 static void test_log_write_read(void)
 {
 	int N =3D 2;
-	char **names =3D reftable_calloc(sizeof(char *) * (N + 1));
+	char **names =3D reftable_calloc(N + 1, sizeof(*names));
 	int err;
 	struct reftable_write_options opts =3D {
 		.block_size =3D 256,
@@ -519,7 +521,7 @@ static void test_table_read_write_seek_index(void)
 static void test_table_refs_for(int indexed)
 {
 	int N =3D 50;
-	char **want_names =3D reftable_calloc(sizeof(char *) * (N + 1));
+	char **want_names =3D reftable_calloc(N + 1, sizeof(*want_names));
 	int want_names_len =3D 0;
 	uint8_t want_hash[GIT_SHA1_RAWSZ];
=20
diff --git a/reftable/record_test.c b/reftable/record_test.c
index 2876db7d27..999366ad46 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -231,8 +231,8 @@ static void test_reftable_log_record_roundtrip(void)
 				.value_type =3D REFTABLE_LOG_UPDATE,
 				.value =3D {
 					.update =3D {
-						.new_hash =3D reftable_calloc(GIT_SHA1_RAWSZ),
-						.old_hash =3D reftable_calloc(GIT_SHA1_RAWSZ),
+						.new_hash =3D reftable_calloc(GIT_SHA1_RAWSZ, 1),
+						.old_hash =3D reftable_calloc(GIT_SHA1_RAWSZ, 1),
 						.name =3D xstrdup("old name"),
 						.email =3D xstrdup("old@email"),
 						.message =3D xstrdup("old message"),
diff --git a/reftable/refname.c b/reftable/refname.c
index 9573496932..7570e4acf9 100644
--- a/reftable/refname.c
+++ b/reftable/refname.c
@@ -140,8 +140,8 @@ int validate_ref_record_addition(struct reftable_table =
tab,
 {
 	struct modification mod =3D {
 		.tab =3D tab,
-		.add =3D reftable_calloc(sizeof(char *) * sz),
-		.del =3D reftable_calloc(sizeof(char *) * sz),
+		.add =3D reftable_calloc(sz, sizeof(*mod.add)),
+		.del =3D reftable_calloc(sz, sizeof(*mod.del)),
 	};
 	int i =3D 0;
 	int err =3D 0;
diff --git a/reftable/stack.c b/reftable/stack.c
index 1dfab99e96..d084823a92 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -50,8 +50,7 @@ static ssize_t reftable_fd_write(void *arg, const void *d=
ata, size_t sz)
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 		       struct reftable_write_options config)
 {
-	struct reftable_stack *p =3D
-		reftable_calloc(sizeof(struct reftable_stack));
+	struct reftable_stack *p =3D reftable_calloc(1, sizeof(*p));
 	struct strbuf list_file_name =3D STRBUF_INIT;
 	int err =3D 0;
=20
@@ -114,7 +113,7 @@ int read_lines(const char *filename, char ***namesp)
 	int err =3D 0;
 	if (fd < 0) {
 		if (errno =3D=3D ENOENT) {
-			*namesp =3D reftable_calloc(sizeof(char *));
+			REFTABLE_CALLOC_ARRAY(*namesp, 1);
 			return 0;
 		}
=20
@@ -191,8 +190,7 @@ void reftable_stack_destroy(struct reftable_stack *st)
 static struct reftable_reader **stack_copy_readers(struct reftable_stack *=
st,
 						   int cur_len)
 {
-	struct reftable_reader **cur =3D
-		reftable_calloc(sizeof(struct reftable_reader *) * cur_len);
+	struct reftable_reader **cur =3D reftable_calloc(cur_len, sizeof(*cur));
 	int i =3D 0;
 	for (i =3D 0; i < cur_len; i++) {
 		cur[i] =3D st->readers[i];
@@ -208,9 +206,9 @@ static int reftable_stack_reload_once(struct reftable_s=
tack *st, char **names,
 	int err =3D 0;
 	int names_len =3D names_length(names);
 	struct reftable_reader **new_readers =3D
-		reftable_calloc(sizeof(struct reftable_reader *) * names_len);
+		reftable_calloc(names_len, sizeof(*new_readers));
 	struct reftable_table *new_tables =3D
-		reftable_calloc(sizeof(struct reftable_table) * names_len);
+		reftable_calloc(names_len, sizeof(*new_tables));
 	int new_readers_len =3D 0;
 	struct reftable_merged_table *new_merged =3D NULL;
 	struct strbuf table_path =3D STRBUF_INIT;
@@ -344,7 +342,7 @@ static int reftable_stack_reload_maybe_reuse(struct ref=
table_stack *st,
 				goto out;
 			}
=20
-			names =3D reftable_calloc(sizeof(char *));
+			REFTABLE_CALLOC_ARRAY(names, 1);
 		} else {
 			err =3D fd_read_lines(fd, &names);
 			if (err < 0)
@@ -686,7 +684,7 @@ int reftable_stack_new_addition(struct reftable_additio=
n **dest,
 {
 	int err =3D 0;
 	struct reftable_addition empty =3D REFTABLE_ADDITION_INIT;
-	*dest =3D reftable_calloc(sizeof(**dest));
+	REFTABLE_CALLOC_ARRAY(*dest, 1);
 	**dest =3D empty;
 	err =3D reftable_stack_init_addition(*dest, st);
 	if (err) {
@@ -871,7 +869,7 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 {
 	int subtabs_len =3D last - first + 1;
 	struct reftable_table *subtabs =3D reftable_calloc(
-		sizeof(struct reftable_table) * (last - first + 1));
+		last - first + 1, sizeof(*subtabs));
 	struct reftable_merged_table *mt =3D NULL;
 	int err =3D 0;
 	struct reftable_iterator it =3D { NULL };
@@ -979,9 +977,9 @@ static int stack_compact_range(struct reftable_stack *s=
t, int first, int last,
 	int compact_count =3D last - first + 1;
 	char **listp =3D NULL;
 	char **delete_on_success =3D
-		reftable_calloc(sizeof(char *) * (compact_count + 1));
+		reftable_calloc(compact_count + 1, sizeof(*delete_on_success));
 	char **subtable_locks =3D
-		reftable_calloc(sizeof(char *) * (compact_count + 1));
+		reftable_calloc(compact_count + 1, sizeof(*subtable_locks));
 	int i =3D 0;
 	int j =3D 0;
 	int is_empty_table =3D 0;
@@ -1204,7 +1202,7 @@ int fastlog2(uint64_t sz)
=20
 struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n)
 {
-	struct segment *segs =3D reftable_calloc(sizeof(struct segment) * n);
+	struct segment *segs =3D reftable_calloc(n, sizeof(*segs));
 	int next =3D 0;
 	struct segment cur =3D { 0 };
 	int i =3D 0;
@@ -1268,7 +1266,7 @@ struct segment suggest_compaction_segment(uint64_t *s=
izes, int n)
 static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *s=
t)
 {
 	uint64_t *sizes =3D
-		reftable_calloc(sizeof(uint64_t) * st->merged->stack_len);
+		reftable_calloc(st->merged->stack_len, sizeof(*sizes));
 	int version =3D (st->config.hash_id =3D=3D GIT_SHA1_FORMAT_ID) ? 1 : 2;
 	int overhead =3D header_size(version) - 1;
 	int i =3D 0;
diff --git a/reftable/tree.c b/reftable/tree.c
index a5bf880985..528f33ae38 100644
--- a/reftable/tree.c
+++ b/reftable/tree.c
@@ -20,8 +20,8 @@ struct tree_node *tree_search(void *key, struct tree_node=
 **rootp,
 		if (!insert) {
 			return NULL;
 		} else {
-			struct tree_node *n =3D
-				reftable_calloc(sizeof(struct tree_node));
+			struct tree_node *n;
+			REFTABLE_CALLOC_ARRAY(n, 1);
 			n->key =3D key;
 			*rootp =3D n;
 			return *rootp;
diff --git a/reftable/writer.c b/reftable/writer.c
index 4483bb21c3..47b3448132 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -49,7 +49,7 @@ static int padded_write(struct reftable_writer *w, uint8_=
t *data, size_t len,
 {
 	int n =3D 0;
 	if (w->pending_padding > 0) {
-		uint8_t *zeroed =3D reftable_calloc(w->pending_padding);
+		uint8_t *zeroed =3D reftable_calloc(w->pending_padding, sizeof(*zeroed));
 		int n =3D w->write(w->write_arg, zeroed, w->pending_padding);
 		if (n < 0)
 			return n;
@@ -123,8 +123,7 @@ struct reftable_writer *
 reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 		    void *writer_arg, struct reftable_write_options *opts)
 {
-	struct reftable_writer *wp =3D
-		reftable_calloc(sizeof(struct reftable_writer));
+	struct reftable_writer *wp =3D reftable_calloc(1, sizeof(*wp));
 	strbuf_init(&wp->block_writer_data.last_key, 0);
 	options_set_defaults(opts);
 	if (opts->block_size >=3D (1 << 24)) {
@@ -132,7 +131,7 @@ reftable_new_writer(ssize_t (*writer_func)(void *, cons=
t void *, size_t),
 		abort();
 	}
 	wp->last_key =3D reftable_empty_strbuf;
-	wp->block =3D reftable_calloc(opts->block_size);
+	REFTABLE_CALLOC_ARRAY(wp->block, opts->block_size);
 	wp->write =3D writer_func;
 	wp->write_arg =3D writer_arg;
 	wp->opts =3D *opts;
--=20
2.43.GIT


--axff/IdKVcXVmdqO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7SSoACgkQVbJhu7ck
PpQ6kQ//eXZX8bMeKQQw7mBuXhgYUJyrl0fjZ81gm1xr7Djej3TQCt5Io03FAIrt
5WcFwAaW0yLe4zG7UJu26GwYeN9OC3QSVjR+CMeA2++YIMCRN9D8o9T1xEoOAaxS
Zx89gNDDox1MZ3m+EDlTKTk5DOmPhloaSl7FUAIpA9dJJnlQrlY9tyh+oP0MPhI9
RwI13NP0aQ3Bu/4uVXhrqbsN2rLqhf+Hr3CwBzRxz32RKExczoAC+9YQa2CUCC5N
sDDgZKcNM4QwXte+rwf+iYl50Jb2jzbtB2NyTK0r9/GNT9140NN8woZ3UEBfDmF8
vUM1TDTzWika/ThS5ZxYQmDGBjFbU2yrOce3CSb8p31W/Hl1qrhSUBlgq0vcs0a7
5DWnqVBpfTziD1r+i5/TU+Y/hdLTch6ZeMPravLcNIS5m6YcgJ5SkEoztzHhPQfN
vhLqhrgXjCoYmp4lwg+GGarz6nhRq/I74EGRTWrRFDij0RWheXZmSHCP3ukiQpA4
G+eNVyGBT2rVroRT0xodm/Tpt1eKB/6QciI9F/RntHq1c/L56Mf1T3erld8sKypK
csu6556zhIB3aoVjYqCfDaSgLwCiB54GaZ7vxFPJdOBS4diSYs5tDbx3G0KRgcL+
vIwOcwkGQLXsJy19WJ3DrKLZy4pB/NnXDhVKVJIIxOHsKiUanDI=
=WEyR
-----END PGP SIGNATURE-----

--axff/IdKVcXVmdqO--
