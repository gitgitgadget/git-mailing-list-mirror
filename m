Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033E23754
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521439; cv=none; b=NkF9Oq52OGExLcRDKYUsRwP4xBjuinhFQfUFV51D2IfGuozkCjaCgxYsc+Z6/OUbhYm+ATrwpjWQw/B7Ac/iq7L8R9hlOYz62nJYSV4ww5o8tdavakUHjJuHhBLh43WaGb/nxMkB7T3wCLS5Mn8K9z2khSVgA70ztd5+R7ZTcU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521439; c=relaxed/simple;
	bh=QCcfceFnigUZmqAN/YjnIPXdI2cBJswsPltMTUKIfuA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsJzUePxfBjSQqMRU6pGIhNy/3uECCoAVGSwoD07Uw0Z1to4zhs5qL6ri5H8DL50afWYWc/A5a6xNg6n02llGzFACrIsm15m7+bve8WOZRR1KOO8g3PY9PENyTV63j8pGALqxzSTgusY1EUN/gX7iP9kJ1X/v1NBSCXKyZsQnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eU1cwJnL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JuLVIWlD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eU1cwJnL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JuLVIWlD"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 51B6F13800D7
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 27 Mar 2024 02:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711521436; x=1711607836; bh=IZTDVXtIIi
	bAQwbX0SZ1wv7MzI9deTq1PY8Cz5kSd4c=; b=eU1cwJnLRMC1EdP0ZQFPmVHHEu
	Q2Y6G+6c5BKUomDlGaprbSjYjyhP/AiH8bAbYfUysr4KRGTTTR7mTEBqV8Z0bQ3w
	tU2s93HZTW+v3TIqoqRQUsuZ62G49Gr4HAjT62xiy4oOKWOQPnsgzK9UVeAfkRWu
	840IDEggZ93Y5fQ0hiVJaYEsI9o/lzoHTIigd872kBamFx3lXvIQ7+33YYOl5CZf
	l/On85Z8WLqeoh2uS/28YxOzROrJ6xqO/NUI2m+DbEvQXOvTMC0jQcAfY3YUFrPh
	NmaG7evb/ldM4iYVIgr+6K7cTRK7jE9jTAfN8KWYTb0xcEgjx2OhlWTy1Ljg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711521436; x=1711607836; bh=IZTDVXtIIibAQwbX0SZ1wv7MzI9d
	eTq1PY8Cz5kSd4c=; b=JuLVIWlD8iMZU1L1MvCDMn8cJJWu4ejQe7EuERjrhX5F
	FqMl2xqmvpr3jksX49Zs/+pBJj4s5NBUa7ON1QCWups2h22t3WyeOfitxIS9lzDi
	CMsAgJEAj5KoLg/1mpmXGIuY3D+W2SLw33UXomOqs/IXvRaIiXlsPUF6bBH+Ex4z
	bsBSRResdyzfvDCcpPnByeFKIsHOq0BqRWsMoXpFYB6eZ86lLcdfvrdn6t6Lg81b
	F0ESZ+ExuLTj88HaMdHCPkwP4ZbKUK6ixC/LXkWEvd3327zMBH9662ftSp84kQT/
	9ChBbwD2OnUjID7qBd6nBo4b4czMh/tkRCvy8j/4NQ==
X-ME-Sender: <xms:nL4DZj9Kc5cgriQCLlCJHKLfdmDDMUqjO7nVrkrHJYwmeL6094waLQ>
    <xme:nL4DZvtS1WyecZQKS30iFJd87uUKEKZ24EZNyyPR0b-XSi7jF_1KI7t1C7w8iKuQd
    xP2WSMxr5-dvpleew>
X-ME-Received: <xmr:nL4DZhAvJiD1l8lx8v2mJMt3LLq6pHEugtDoURmbV_fDDkSS7NsKLNwI346RMN0-p4FW4kbVzraqiXbxEtRsxRp181BKXdc_bwmIbgHZtUr1zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:nL4DZvfVLYaI-SfFYw0i-Qj3Y4M5NMppqffs6YmAuc9ZfcWGYDJ1LQ>
    <xmx:nL4DZoPIt_17YDTA6s5e98-6O12APPXt8u42vzLT6MGIWZ3OxPF2MA>
    <xmx:nL4DZhmuEBmJv-e0M44EA-wygFmMu1BZgcLgVb0mchppcm3x5h6toA>
    <xmx:nL4DZisoLkjp8WqqfGa5THyYipbkysaDpvykG7RWLcmrzPvZPVRVSQ>
    <xmx:nL4DZhZD9O5btuAKPOCyYnB3cloK7HsMORlbIMgxpzT0tkK8kwe7Dw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3ad3d08d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 27 Mar 2024 06:37:01 +0000 (UTC)
Date: Wed, 27 Mar 2024 07:37:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/9] reftable/block: move ownership of block reader into
 `struct table_iter`
Message-ID: <f10882a0840a77f2569cf891374b70d1e84ceb4b.1711519925.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ozCpVLhufOaYVlnW"
Content-Disposition: inline
In-Reply-To: <cover.1711519925.git.ps@pks.im>


--ozCpVLhufOaYVlnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The table iterator allows the caller to iterate through all records in a
reftable table. To do so it iterates through all blocks of the desired
type one by one, where for each block it creates a new block iterator
and yields all its entries.

One of the things that is somewhat confusing in this context is who owns
the block reader that is being used to read the blocks and pass them to
the block iterator. Intuitively, as the table iterator is responsible
for iterating through the blocks, one would assume that this iterator is
also responsible for managing the lifecycle of the reader. And while it
somewhat is, the block reader is ultimately stored inside of the block
iterator.

Refactor the code such that the block reader is instead fully managed by
the table iterator. Instead of passing the reader to the block iterator,
we now only end up passing the block data to it. Despite clearing up the
lifecycle of the reader, it will also allow for better reuse of the
reader in subsequent patches.

The following benchmark prints a single matching ref out of 1 million
refs. Before:

  HEAP SUMMARY:
      in use at exit: 13,603 bytes in 125 blocks
    total heap usage: 6,607 allocs, 6,482 frees, 509,635 bytes allocated

After:

  HEAP SUMMARY:
      in use at exit: 13,603 bytes in 125 blocks
    total heap usage: 7,235 allocs, 7,110 frees, 301,481 bytes allocated

Note that while there are more allocation and free calls now, the
overall number of bytes allocated is significantly lower. The number of
allocations will be reduced significantly by the next patch though.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  |  43 ++++++++++------
 reftable/block.h  |  19 ++++---
 reftable/reader.c | 123 ++++++++++++++++++++++------------------------
 3 files changed, 102 insertions(+), 83 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 013849f028..8f5dfe10bf 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -261,12 +261,12 @@ void block_reader_release(struct block_reader *br)
 	reftable_block_done(&br->block);
 }
=20
-uint8_t block_reader_type(struct block_reader *r)
+uint8_t block_reader_type(const struct block_reader *r)
 {
 	return r->block.data[r->header_off];
 }
=20
-int block_reader_first_key(struct block_reader *br, struct strbuf *key)
+int block_reader_first_key(const struct block_reader *br, struct strbuf *k=
ey)
 {
 	int off =3D br->header_off + 4, n;
 	struct string_view in =3D {
@@ -286,14 +286,16 @@ int block_reader_first_key(struct block_reader *br, s=
truct strbuf *key)
 	return 0;
 }
=20
-static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
+static uint32_t block_reader_restart_offset(const struct block_reader *br,=
 int i)
 {
 	return get_be24(br->restart_bytes + 3 * i);
 }
=20
-void block_iter_seek_start(struct block_iter *it, struct block_reader *br)
+void block_iter_seek_start(struct block_iter *it, const struct block_reade=
r *br)
 {
-	it->br =3D br;
+	it->block =3D br->block.data;
+	it->block_len =3D br->block_len;
+	it->hash_size =3D br->hash_size;
 	strbuf_reset(&it->last_key);
 	it->next_off =3D br->header_off + 4;
 }
@@ -301,7 +303,7 @@ void block_iter_seek_start(struct block_iter *it, struc=
t block_reader *br)
 struct restart_find_args {
 	int error;
 	struct strbuf key;
-	struct block_reader *r;
+	const struct block_reader *r;
 };
=20
 static int restart_key_less(size_t idx, void *args)
@@ -329,9 +331,11 @@ static int restart_key_less(size_t idx, void *args)
 	return result < 0;
 }
=20
-void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
+void block_iter_copy_from(struct block_iter *dest, const struct block_iter=
 *src)
 {
-	dest->br =3D src->br;
+	dest->block =3D src->block;
+	dest->block_len =3D src->block_len;
+	dest->hash_size =3D src->hash_size;
 	dest->next_off =3D src->next_off;
 	strbuf_reset(&dest->last_key);
 	strbuf_addbuf(&dest->last_key, &src->last_key);
@@ -340,14 +344,14 @@ void block_iter_copy_from(struct block_iter *dest, st=
ruct block_iter *src)
 int block_iter_next(struct block_iter *it, struct reftable_record *rec)
 {
 	struct string_view in =3D {
-		.buf =3D it->br->block.data + it->next_off,
-		.len =3D it->br->block_len - it->next_off,
+		.buf =3D (unsigned char *) it->block + it->next_off,
+		.len =3D it->block_len - it->next_off,
 	};
 	struct string_view start =3D in;
 	uint8_t extra =3D 0;
 	int n =3D 0;
=20
-	if (it->next_off >=3D it->br->block_len)
+	if (it->next_off >=3D it->block_len)
 		return 1;
=20
 	n =3D reftable_decode_key(&it->last_key, &extra, in);
@@ -357,7 +361,7 @@ int block_iter_next(struct block_iter *it, struct refta=
ble_record *rec)
 		return REFTABLE_FORMAT_ERROR;
=20
 	string_view_consume(&in, n);
-	n =3D reftable_record_decode(rec, it->last_key, extra, in, it->br->hash_s=
ize,
+	n =3D reftable_record_decode(rec, it->last_key, extra, in, it->hash_size,
 				   &it->scratch);
 	if (n < 0)
 		return -1;
@@ -367,13 +371,22 @@ int block_iter_next(struct block_iter *it, struct ref=
table_record *rec)
 	return 0;
 }
=20
+void block_iter_reset(struct block_iter *it)
+{
+	strbuf_reset(&it->last_key);
+	it->next_off =3D 0;
+	it->block =3D NULL;
+	it->block_len =3D 0;
+	it->hash_size =3D 0;
+}
+
 void block_iter_close(struct block_iter *it)
 {
 	strbuf_release(&it->last_key);
 	strbuf_release(&it->scratch);
 }
=20
-int block_iter_seek_key(struct block_iter *it, struct block_reader *br,
+int block_iter_seek_key(struct block_iter *it, const struct block_reader *=
br,
 			struct strbuf *want)
 {
 	struct restart_find_args args =3D {
@@ -394,7 +407,9 @@ int block_iter_seek_key(struct block_iter *it, struct b=
lock_reader *br,
 		it->next_off =3D block_reader_restart_offset(br, i - 1);
 	else
 		it->next_off =3D br->header_off + 4;
-	it->br =3D br;
+	it->block =3D br->block.data;
+	it->block_len =3D br->block_len;
+	it->hash_size =3D br->hash_size;
=20
 	reftable_record_init(&rec, block_reader_type(br));
=20
diff --git a/reftable/block.h b/reftable/block.h
index 601a1e0e89..b41efa5042 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -84,16 +84,18 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *bl,
 void block_reader_release(struct block_reader *br);
=20
 /* Returns the block type (eg. 'r' for refs) */
-uint8_t block_reader_type(struct block_reader *r);
+uint8_t block_reader_type(const struct block_reader *r);
=20
 /* Decodes the first key in the block */
-int block_reader_first_key(struct block_reader *br, struct strbuf *key);
+int block_reader_first_key(const struct block_reader *br, struct strbuf *k=
ey);
=20
 /* Iterate over entries in a block */
 struct block_iter {
 	/* offset within the block of the next entry to read. */
 	uint32_t next_off;
-	struct block_reader *br;
+	const unsigned char *block;
+	size_t block_len;
+	int hash_size;
=20
 	/* key for last entry we read. */
 	struct strbuf last_key;
@@ -106,17 +108,22 @@ struct block_iter {
 }
=20
 /* Position `it` at start of the block */
-void block_iter_seek_start(struct block_iter *it, struct block_reader *br);
+void block_iter_seek_start(struct block_iter *it, const struct block_reade=
r *br);
=20
 /* Position `it` to the `want` key in the block */
-int block_iter_seek_key(struct block_iter *it, struct block_reader *br,
+int block_iter_seek_key(struct block_iter *it, const struct block_reader *=
br,
 			struct strbuf *want);
=20
-void block_iter_copy_from(struct block_iter *dest, struct block_iter *src);
+void block_iter_copy_from(struct block_iter *dest, const struct block_iter=
 *src);
=20
 /* return < 0 for error, 0 for OK, > 0 for EOF. */
 int block_iter_next(struct block_iter *it, struct reftable_record *rec);
=20
+/*
+ * Reset the block iterator to pristine state without releasing its memory.
+ */
+void block_iter_reset(struct block_iter *it);
+
 /* deallocate memory for `it`. The block reader and its block is left inta=
ct. */
 void block_iter_close(struct block_iter *it);
=20
diff --git a/reftable/reader.c b/reftable/reader.c
index f925570bf3..b77b639751 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -220,6 +220,7 @@ struct table_iter {
 	struct reftable_reader *r;
 	uint8_t typ;
 	uint64_t block_off;
+	struct block_reader br;
 	struct block_iter bi;
 	int is_finished;
 };
@@ -227,16 +228,6 @@ struct table_iter {
 	.bi =3D BLOCK_ITER_INIT \
 }
=20
-static void table_iter_copy_from(struct table_iter *dest,
-				 struct table_iter *src)
-{
-	dest->r =3D src->r;
-	dest->typ =3D src->typ;
-	dest->block_off =3D src->block_off;
-	dest->is_finished =3D src->is_finished;
-	block_iter_copy_from(&dest->bi, &src->bi);
-}
-
 static int table_iter_next_in_block(struct table_iter *ti,
 				    struct reftable_record *rec)
 {
@@ -250,14 +241,8 @@ static int table_iter_next_in_block(struct table_iter =
*ti,
=20
 static void table_iter_block_done(struct table_iter *ti)
 {
-	if (!ti->bi.br) {
-		return;
-	}
-	block_reader_release(ti->bi.br);
-	FREE_AND_NULL(ti->bi.br);
-
-	ti->bi.last_key.len =3D 0;
-	ti->bi.next_off =3D 0;
+	block_reader_release(&ti->br);
+	block_iter_reset(&ti->bi);
 }
=20
 static int32_t extract_block_size(uint8_t *data, uint8_t *typ, uint64_t of=
f,
@@ -321,32 +306,33 @@ int reader_init_block_reader(struct reftable_reader *=
r, struct block_reader *br,
 	return err;
 }
=20
+static void table_iter_close(struct table_iter *ti)
+{
+	table_iter_block_done(ti);
+	block_iter_close(&ti->bi);
+}
+
 static int table_iter_next_block(struct table_iter *dest,
 				 struct table_iter *src)
 {
-	uint64_t next_block_off =3D src->block_off + src->bi.br->full_block_size;
-	struct block_reader br =3D { 0 };
-	int err =3D 0;
+	uint64_t next_block_off =3D src->block_off + src->br.full_block_size;
+	int err;
=20
 	dest->r =3D src->r;
 	dest->typ =3D src->typ;
 	dest->block_off =3D next_block_off;
=20
-	err =3D reader_init_block_reader(src->r, &br, next_block_off, src->typ);
-	if (err > 0) {
+	err =3D reader_init_block_reader(src->r, &dest->br, next_block_off, src->=
typ);
+	if (err > 0)
 		dest->is_finished =3D 1;
-		return 1;
-	}
-	if (err !=3D 0)
+	if (err) {
+		table_iter_block_done(dest);
 		return err;
-	else {
-		struct block_reader *brp =3D
-			reftable_malloc(sizeof(struct block_reader));
-		*brp =3D br;
-
-		dest->is_finished =3D 0;
-		block_iter_seek_start(&dest->bi, brp);
 	}
+
+	dest->is_finished =3D 0;
+	block_iter_seek_start(&dest->bi, &dest->br);
+
 	return 0;
 }
=20
@@ -377,14 +363,13 @@ static int table_iter_next(struct table_iter *ti, str=
uct reftable_record *rec)
 		 * iterator is drained.
 		 */
 		err =3D table_iter_next_block(&next, ti);
-		table_iter_block_done(ti);
 		if (err) {
 			ti->is_finished =3D 1;
 			return err;
 		}
=20
-		table_iter_copy_from(ti, &next);
-		block_iter_close(&next.bi);
+		table_iter_close(ti);
+		*ti =3D next;
 	}
 }
=20
@@ -393,16 +378,14 @@ static int table_iter_next_void(void *ti, struct reft=
able_record *rec)
 	return table_iter_next(ti, rec);
 }
=20
-static void table_iter_close(void *p)
+static void table_iter_close_void(void *ti)
 {
-	struct table_iter *ti =3D p;
-	table_iter_block_done(ti);
-	block_iter_close(&ti->bi);
+	table_iter_close(ti);
 }
=20
 static struct reftable_iterator_vtable table_iter_vtable =3D {
 	.next =3D &table_iter_next_void,
-	.close =3D &table_iter_close,
+	.close =3D &table_iter_close_void,
 };
=20
 static void iterator_from_table_iter(struct reftable_iterator *it,
@@ -417,19 +400,16 @@ static int reader_table_iter_at(struct reftable_reade=
r *r,
 				struct table_iter *ti, uint64_t off,
 				uint8_t typ)
 {
-	struct block_reader br =3D { 0 };
-	struct block_reader *brp =3D NULL;
+	int err;
=20
-	int err =3D reader_init_block_reader(r, &br, off, typ);
+	err =3D reader_init_block_reader(r, &ti->br, off, typ);
 	if (err !=3D 0)
 		return err;
=20
-	brp =3D reftable_malloc(sizeof(struct block_reader));
-	*brp =3D br;
 	ti->r =3D r;
-	ti->typ =3D block_reader_type(brp);
+	ti->typ =3D block_reader_type(&ti->br);
 	ti->block_off =3D off;
-	block_iter_seek_start(&ti->bi, brp);
+	block_iter_seek_start(&ti->bi, &ti->br);
 	return 0;
 }
=20
@@ -454,23 +434,34 @@ static int reader_seek_linear(struct table_iter *ti,
 {
 	struct strbuf want_key =3D STRBUF_INIT;
 	struct strbuf got_key =3D STRBUF_INIT;
-	struct table_iter next =3D TABLE_ITER_INIT;
 	struct reftable_record rec;
 	int err =3D -1;
=20
 	reftable_record_init(&rec, reftable_record_type(want));
 	reftable_record_key(want, &want_key);
=20
+	/*
+	 * First we need to locate the block that must contain our record. To
+	 * do so we scan through blocks linearly until we find the first block
+	 * whose first key is bigger than our wanted key. Once we have found
+	 * that block we know that the key must be contained in the preceding
+	 * block.
+	 *
+	 * This algorithm is somewhat unfortunate because it means that we
+	 * always have to seek one block too far and then back up. But as we
+	 * can only decode the _first_ key of a block but not its _last_ key we
+	 * have no other way to do this.
+	 */
 	while (1) {
+		struct table_iter next =3D TABLE_ITER_INIT;
+
 		err =3D table_iter_next_block(&next, ti);
 		if (err < 0)
 			goto done;
-
-		if (err > 0) {
+		if (err > 0)
 			break;
-		}
=20
-		err =3D block_reader_first_key(next.bi.br, &got_key);
+		err =3D block_reader_first_key(&next.br, &got_key);
 		if (err < 0)
 			goto done;
=20
@@ -480,16 +471,20 @@ static int reader_seek_linear(struct table_iter *ti,
 		}
=20
 		table_iter_block_done(ti);
-		table_iter_copy_from(ti, &next);
+		*ti =3D next;
 	}
=20
-	err =3D block_iter_seek_key(&ti->bi, ti->bi.br, &want_key);
+	/*
+	 * We have located the block that must contain our record, so we seek
+	 * the wanted key inside of it. If the block does not contain our key
+	 * we know that the corresponding record does not exist.
+	 */
+	err =3D block_iter_seek_key(&ti->bi, &ti->br, &want_key);
 	if (err < 0)
 		goto done;
 	err =3D 0;
=20
 done:
-	block_iter_close(&next.bi);
 	reftable_record_release(&rec);
 	strbuf_release(&want_key);
 	strbuf_release(&got_key);
@@ -508,6 +503,7 @@ static int reader_seek_indexed(struct reftable_reader *=
r,
 		.u.idx =3D { .last_key =3D STRBUF_INIT },
 	};
 	struct table_iter index_iter =3D TABLE_ITER_INIT;
+	struct table_iter empty =3D TABLE_ITER_INIT;
 	struct table_iter next =3D TABLE_ITER_INIT;
 	int err =3D 0;
=20
@@ -549,7 +545,6 @@ static int reader_seek_indexed(struct reftable_reader *=
r,
 		 * not exist.
 		 */
 		err =3D table_iter_next(&index_iter, &index_result);
-		table_iter_block_done(&index_iter);
 		if (err !=3D 0)
 			goto done;
=20
@@ -558,7 +553,7 @@ static int reader_seek_indexed(struct reftable_reader *=
r,
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D block_iter_seek_key(&next.bi, next.bi.br, &want_index.u.idx.last=
_key);
+		err =3D block_iter_seek_key(&next.bi, &next.br, &want_index.u.idx.last_k=
ey);
 		if (err < 0)
 			goto done;
=20
@@ -572,18 +567,20 @@ static int reader_seek_indexed(struct reftable_reader=
 *r,
 			break;
 		}
=20
-		table_iter_copy_from(&index_iter, &next);
+		table_iter_close(&index_iter);
+		index_iter =3D next;
+		next =3D empty;
 	}
=20
 	if (err =3D=3D 0) {
-		struct table_iter empty =3D TABLE_ITER_INIT;
 		struct table_iter *malloced =3D reftable_calloc(1, sizeof(*malloced));
-		*malloced =3D empty;
-		table_iter_copy_from(malloced, &next);
+		*malloced =3D next;
+		next =3D empty;
 		iterator_from_table_iter(it, malloced);
 	}
+
 done:
-	block_iter_close(&next.bi);
+	table_iter_close(&next);
 	table_iter_close(&index_iter);
 	reftable_record_release(&want_index);
 	reftable_record_release(&index_result);
--=20
2.44.GIT


--ozCpVLhufOaYVlnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYDvpgACgkQVbJhu7ck
PpSLTg//T7iXOmaAsFaiEvq8M+QApY7nnS+T/rkdjnoPWf8XuqEfFgwuX1LuT7HA
Gpl701BQvM+VylihtJMVx+m/y7FFUWlyPAWZVN+vV4F0MdoIcNi1ZCFiik5go7la
uzW1YSCggvPYkhLvBfexXMBkbGX/jKxkPIskqmZ98I0U2Y7ae0veFSCzIbDdUnhs
ld7tjOCT5kn0bBLFO+9M4WUMmyvyytOS/yHbMFCU4pZ76KEbCj1C21Mw8Z3tFhX5
mc5rzvxYN4LWaJLVTt3zQ3Y3nUww65yuqh1H4Zi41LkVsmfCCT+ujMbLuhXPhvPT
2K4HtlPVRO0vpU8SEedUipraGkIlDRtY+jsbRTh6naHL86LM+F1N0QXHIu1RnGgu
QFFKp5MG9QUYOeOBFdvHqatzaLs6Xg0NdErqZS9Co8iitipgONVtTvy/XeBuW5GJ
GvnEvW3MvueI1Mt1FM99A6HniOKfyZ62+1Xg8TFu4cvsBxeMKMPJKJ/qYKpnSekM
eXqQXZGZhFPYP10N0b2Uj3jk0VDE5HOfJu3ofubP+Bx/T1foS2gS7j0ahyo6jjDc
ds+jdnaRCReHhEI6s+KJf0iR0XTPG7Gf3g9Ia7KIQ69dtbaRmAyvqwC5AV0krqQG
8x9gxkW98Zc2n55VOzly6e93y97soVG9NIIbU+tnbo/EmNmyycA=
=ZX7t
-----END PGP SIGNATURE-----

--ozCpVLhufOaYVlnW--
