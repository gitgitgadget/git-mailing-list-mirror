Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA6128803
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201335; cv=none; b=YY7DpddjRKb3xhmT1uKF1W+Nn52VWaq/CDq1a5G38bfQrWhgQp0j16O5useilbNT+ccbPHF6H7m9BG8oELGGIIkLIf6OH31wY+rRpmTufpQV4YiAVc1kSZiiWALk287Gvi6WmBFQKnkeVzlMHK0+woUNK3FnRkLbRSEHLf3f/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201335; c=relaxed/simple;
	bh=xMkH7vXAlGG0muHvh7Il1ydWi1HZVvQTxXKRy6cfD+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1Ao6w0kpAzIuoOWiYkKa/ORcjTPJlxoPZJBGwhfI+iL4NpLQQNahD7wXHn2V4TFb6jMKLmz9CuzllrEb+5yq1Th/JdjIStMWGfX+wt99OofhAfNNXC6Cr6WECTCjD9gaFNUlJ25mOR4As5k0AmLlu1vSMh8rOa+4fj/oIio/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A8Xv1gIP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WwHVU/km; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A8Xv1gIP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WwHVU/km"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8AE51180007F;
	Tue,  6 Feb 2024 01:35:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Feb 2024 01:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707201330; x=1707287730; bh=OQFhx3cPjw
	X2VmmQMknKx/x01YilqsteVfy7EiB2Yis=; b=A8Xv1gIPkl1lLbLgTHJeFsKSaa
	KnSooWCaeMQOqEI1rpXGjiuD+FoY5aZnRDUc3mDSMmJIBM+fCrAgAcjMc45JKUo8
	yRy8Xuu6RD3cr0X/LQY9MMu2S48RbMENLlkZX56SaSqtS6yhWlw5ydrwn+28wKeV
	17OOFFKr0D7AYPHeB43S7tst6yTmDvKi4XLhnvP0XAvWoNIHR9D1vl1GukOVOxJ0
	wtTBzpIydjzelKL4iag5eVj9UntGXNoxSrdJQjiMuzM5G4L2XxhyIIiktZSZ4pK5
	h4K57kM4CaDqA+NHD06uTlHczsy2N9O9Th9pjJyZn59owj3TaACIlJF20UCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707201330; x=1707287730; bh=OQFhx3cPjwX2VmmQMknKx/x01Yil
	qsteVfy7EiB2Yis=; b=WwHVU/kmlWEmvW1+GfLYDOhvo3VIY85okG+hdnKHv2cd
	q2qvx3VUvLGYk24EL4PSyzrxawEl/YgIDmz4tFpGVF+OPhe++PpjiwHFWBWl7tQC
	AQHoozuBInAjUSiSxGtLk2orwDhrvMv/kRIL0kD8/EJ1DBKqJr9a7C+xjQF7rLQH
	nQUDeWLpZyWG+5aiqNSg1Lw7l2CFST3jkHUFkh0Z8fKZPr+p1eOkVZ5gv6qOO2ub
	M1aCPyYta+SPs0pc8pPG5Ra8vioyKExanNWSj08yDpY6W+FmVxi0ImNqU5JVdUIl
	gGBWdjwEPwAG/1Eb7ItrQn8RN2RbqWbCErk9gS3vnA==
X-ME-Sender: <xms:MtPBZYjIbyP3siRMfvpZbeQiGytDH7VfGGtWp3bL4FlpOh00lharHg>
    <xme:MtPBZRCuGJoJptyHYeVtLdFvPhSU9zDSMqTyilC-OjafM5r8Y9Y7ZltGQwF6zBWqZ
    xGLgnmXOYklsmMxuA>
X-ME-Received: <xmr:MtPBZQHVBBeC0HVFJGhXCZJuIo6X6ikG7J1LyDfe1gSTxu0xCuKsC02-Dk_Ne99ETO7eT7eFXdkDkvnRt0S90RO3qy0BHtor0zT0XUgHsa1o4NGX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeegvedtffehvdehheegueeuffefteeitdefheejheetveeiheekkeeifefhvdev
    heenucffohhmrghinhepuhhpuggrthgvrdhnvgifnecuvehluhhsthgvrhfuihiivgepud
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:MtPBZZQDPaSmVVmhax4vL4E-L444NnXXTvXfwm6ie1jOIFBT5Jsq5A>
    <xmx:MtPBZVxC5Z9OC4DZuN41N0ZqvS9EzPUu_dXshrmxAtDQVZHdwRrrmQ>
    <xmx:MtPBZX6F8oOeRy50lsvBKcuBDgRmRkjhxRwdkrbFpRbizUYiS_tcWg>
    <xmx:MtPBZYpgjSTerJEgBwhn4ULoThPqhwBEhxgtedVj3zkMeI2WKNZqLLS91Nw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 01:35:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3c1672c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 06:31:59 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:35:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 2/9] reftable: introduce macros to allocate arrays
Message-ID: <95689ca7ce235a5717e44a0a6d5c495310babba2.1707200355.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1707200355.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rEYm3WK5okkx5WIM"
Content-Disposition: inline
In-Reply-To: <cover.1707200355.git.ps@pks.im>


--rEYm3WK5okkx5WIM
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

Convert callsites of `reftable_calloc()` to the new signature and start
using the new macros where possible.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h         |  4 +++-
 reftable/block.c          | 10 ++++++----
 reftable/block_test.c     |  2 +-
 reftable/blocksource.c    |  4 ++--
 reftable/iter.c           |  3 +--
 reftable/merged.c         |  4 ++--
 reftable/merged_test.c    | 22 +++++++++++++---------
 reftable/publicbasics.c   |  3 ++-
 reftable/reader.c         |  8 +++-----
 reftable/readwrite_test.c |  8 +++++---
 reftable/record.c         | 14 ++++++++------
 reftable/record_test.c    |  4 ++--
 reftable/refname.c        |  4 ++--
 reftable/stack.c          | 28 +++++++++++++---------------
 reftable/tree.c           |  4 ++--
 reftable/writer.c         |  7 +++----
 16 files changed, 68 insertions(+), 61 deletions(-)

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
diff --git a/reftable/block.c b/reftable/block.c
index 6952d0facf..838759823a 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -143,8 +143,10 @@ int block_writer_finish(struct block_writer *w)
 		int block_header_skip =3D 4 + w->header_off;
 		uLongf src_len =3D w->next - block_header_skip;
 		uLongf dest_cap =3D src_len * 1.001 + 12;
+		uint8_t *compressed;
+
+		REFTABLE_ALLOC_ARRAY(compressed, dest_cap);
=20
-		uint8_t *compressed =3D reftable_malloc(dest_cap);
 		while (1) {
 			uLongf out_dest_len =3D dest_cap;
 			int zresult =3D compress2(compressed, &out_dest_len,
@@ -201,9 +203,9 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *block,
 		uLongf dst_len =3D sz - block_header_skip; /* total size of dest
 							    buffer. */
 		uLongf src_len =3D block->len - block_header_skip;
-		/* Log blocks specify the *uncompressed* size in their header.
-		 */
-		uncompressed =3D reftable_malloc(sz);
+
+		/* Log blocks specify the *uncompressed* size in their header. */
+		REFTABLE_ALLOC_ARRAY(uncompressed, sz);
=20
 		/* Copy over the block header verbatim. It's not compressed. */
 		memcpy(uncompressed, block->data, block_header_skip);
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
diff --git a/reftable/record.c b/reftable/record.c
index 5c3fbb7b2a..2f3cd6b62c 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -497,12 +497,13 @@ static void reftable_obj_record_copy_from(void *rec, =
const void *src_rec,
 		(const struct reftable_obj_record *)src_rec;
=20
 	reftable_obj_record_release(obj);
-	obj->hash_prefix =3D reftable_malloc(src->hash_prefix_len);
+
+	REFTABLE_ALLOC_ARRAY(obj->hash_prefix, src->hash_prefix_len);
 	obj->hash_prefix_len =3D src->hash_prefix_len;
 	if (src->hash_prefix_len)
 		memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
=20
-	obj->offsets =3D reftable_malloc(src->offset_len * sizeof(uint64_t));
+	REFTABLE_ALLOC_ARRAY(obj->offsets, src->offset_len);
 	obj->offset_len =3D src->offset_len;
 	COPY_ARRAY(obj->offsets, src->offsets, src->offset_len);
 }
@@ -559,7 +560,8 @@ static int reftable_obj_record_decode(void *rec, struct=
 strbuf key,
 	int n =3D 0;
 	uint64_t last;
 	int j;
-	r->hash_prefix =3D reftable_malloc(key.len);
+
+	REFTABLE_ALLOC_ARRAY(r->hash_prefix, key.len);
 	memcpy(r->hash_prefix, key.buf, key.len);
 	r->hash_prefix_len =3D key.len;
=20
@@ -577,7 +579,7 @@ static int reftable_obj_record_decode(void *rec, struct=
 strbuf key,
 	if (count =3D=3D 0)
 		return start.len - in.len;
=20
-	r->offsets =3D reftable_malloc(count * sizeof(uint64_t));
+	REFTABLE_ALLOC_ARRAY(r->offsets, count);
 	r->offset_len =3D count;
=20
 	n =3D get_var_int(&r->offsets[0], &in);
@@ -715,12 +717,12 @@ static void reftable_log_record_copy_from(void *rec, =
const void *src_rec,
 		}
=20
 		if (dst->value.update.new_hash) {
-			dst->value.update.new_hash =3D reftable_malloc(hash_size);
+			REFTABLE_ALLOC_ARRAY(dst->value.update.new_hash, hash_size);
 			memcpy(dst->value.update.new_hash,
 			       src->value.update.new_hash, hash_size);
 		}
 		if (dst->value.update.old_hash) {
-			dst->value.update.old_hash =3D reftable_malloc(hash_size);
+			REFTABLE_ALLOC_ARRAY(dst->value.update.old_hash, hash_size);
 			memcpy(dst->value.update.old_hash,
 			       src->value.update.old_hash, hash_size);
 		}
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
index 1dfab99e96..a7b2c61026 100644
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
@@ -94,7 +93,7 @@ static int fd_read_lines(int fd, char ***namesp)
 		goto done;
 	}
=20
-	buf =3D reftable_malloc(size + 1);
+	REFTABLE_ALLOC_ARRAY(buf, size + 1);
 	if (read_in_full(fd, buf, size) !=3D size) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
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


--rEYm3WK5okkx5WIM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB0y4ACgkQVbJhu7ck
PpRrXBAApOsioInJGJQF26EUlnDy6ccVvppnuZGZHFojfKzIB+G9L7BRqar8W8fu
3LYMj6UhJ1wbeKqdniCnG1KUfH0QGZeyjkYVn+HQ25VvUdP+cHm/3aQ7U4QcWjtp
GvaJ8z+KdsJT/G0S/gB/L4RXOsxcMBKsxskFPqBPAGu0y9XZWkL4JwkUuoFQxto/
Cme9miGd9CFAd4GwW1ZaNSAHlcZpV+Sy9di1S9AkpMh0Pd1uPaTk/3yyJlazQwUa
TD04xngs/3IGgHNGRPC9nhRvoqhG752uY/OZHQqvBcAa/wb1rIc14yVRaY+Tx9Ok
iQBQ3cuwDE6FQvv0awjFV/bBKivvwEhRuMLUprrUbYebhLEgWE6BBY8VPiCPyKMe
485hQAKDpqEiCEs+QxoZ4Rg0HdQ4S4ct+YNaMy8kajbXUTYhWP+eiyjl687lqMAX
4IeLS1jVBQSmqpLlCBXYPF02ao99mkDfDECDFIe0/4uFp/faKEzd2AGbh0v6bbIf
xum9epB+DVTwiXsl6QH9xQUFYc31vLS6BQrWh2ploW3DgGrigd0ouEmQ+lwH9dNN
+SJSQmD5A4FFSc8NvA1uWYpaIsdq5FnHrCk45W/NZiJlI/NkJPt6gujpnXvImFze
Tu9w+XRDMrgl9eJePht5Uew6bTcxxngCm2kUgiwuz6XwfyzLL0A=
=pN3x
-----END PGP SIGNATURE-----

--rEYm3WK5okkx5WIM--
