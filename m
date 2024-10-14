Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDEC1A76CD
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910958; cv=none; b=Lr17S6xECLNTI8ZuMaBA2FiOiQH1oc8SYp52yoOX0ZrvUBJVRbVN5kErpImN5FDNwxGW6Q8J+rOG5yz8/NTfffQZVELVnrUjx3IsWrrpitosxfvGBsGDsSHZ9UgMRB+d6XJSU4tLlVxHzYo1df6ZbiO+Wz40SyQukmyCESyiGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910958; c=relaxed/simple;
	bh=zDSeDhmzK6Dko2sQRk8ilu2ReG7s3lZjpfADNzOUqB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwWKO5IFDXBo605sUMKGYdFvoDzBDtnq4RW9ZPKwHmw+MS307mobBiM4qZ1umGTDxFUUa33uG9v6FghBdWpPtrfTMRXcMQtD84mdZgntNJkNeB7AEEZB3azZVj5b8TqJ0cNutv0mvqVsUUtx29uiXZrlbzF1NKvaQVshyyx4EuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mXIgHIjX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTTJakyv; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mXIgHIjX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTTJakyv"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 09CCA138034A;
	Mon, 14 Oct 2024 09:02:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Oct 2024 09:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728910952; x=1728997352; bh=WxZNmJxUJQ
	L1agbQqWEvK1iRb5HR6qQnv7BgRi+iaEE=; b=mXIgHIjXSMgPdM9j/6vyIgAByY
	Kei9cYJCRqDr9apkqw+2lT8eM5ZWk0p+KQwf09FKF8jrcwJrC9KOdrIsA90IIllO
	g06FR02fGruSnJcKl8g92VuHnVNKQaijYbcI1IRxe1u99zCsJN6Yzh8yxx9gjYYG
	QwW9deQScg8dqUpwwifRNjJ8/Qgkkz9eJHRiO04nrwnNG8e9ZXNdnqu3mhRZXxEr
	M/oMixapQYPO8uQi9xQ3YFN3WobsshKP1QZUolPgdpiDsVY0pwl/0kUHv05dvUJ7
	mW5Q2RAPmP0flGRZWQFPgtWHdI/U/bvaGGNOsfatUV38yCs/kKpqoRB8K7kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728910952; x=1728997352; bh=WxZNmJxUJQL1agbQqWEvK1iRb5HR
	6qQnv7BgRi+iaEE=; b=HTTJakyvZDq+bCZvUeCGVnYcqb6szVbazxWpqP2ylAJp
	Ga2eU5B0IixXkrFaETri4aduCNxLgtAcGWeLbRvJpCGZSlo3Zqp/1MUuXJQeEr2Y
	XAF9nwmDQPBRLUz0necmZOuLT+EaMDin3e409jI3gurYz0C4ANePyKjdedzs/IAb
	6gwo+Olugob9Ny5eQmoCEoqDSIhd/Jeavqgxc60iPc2+qmLGmvLiop1vyr/1IL5g
	Lc6UJCW0Ucpjs631yx4+a06RAHMUuXI90OPObJmmRSp8DqQJVeRx259jcN5ACkBC
	1UlExAQ4gJrf4UQXPGo7Xu00rmMBxieHSMR9lJ7/eg==
X-ME-Sender: <xms:aBYNZ91tESEYcOdtM54YzFILHqv1MNl7layU5E9yA7Rhc29iopMKGw>
    <xme:aBYNZ0Fx0vIcWXvR8rzDsNVRu1vbZ38iLxFKkjK0lXhbocZJHJgIxNQLTL0Op02Tx
    CwP3Qfhv16EHQZehg>
X-ME-Received: <xmr:aBYNZ972pjLjZu3JJ3Tv4vZiY-UuaJsV-6sAaG3pe-3jrJAHtD17yTvsRnG-DRaUmJjRkn0zVPRjuUMsnM9WI2FHxmFbv4Xs9XYiwcyyMmWLFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgfevieehledvleevkeekvdfhjeejledvgfduvdetkeek
    gfeilefftdeitdehledunecuffhomhgrihhnpehuphgurghtvgdrnhgvfienucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhn
    segvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aBYNZ638bfDDsqnmT_5j7IoOUdkXjoS6aQdgryKzeSBgsIHOWDD1Aw>
    <xmx:aBYNZwHIl2HdeOiPdWCD2JTspuWLdzaikjzMJh4c-qBgvxrq-peaGQ>
    <xmx:aBYNZ7-qI6sgcvFBf0IXfTkPXEYXfxjKPIfwSIwnnX84ywloWMJXYg>
    <xmx:aBYNZ9neSGbfaZtOxhqIvnyaaEdD6TqUDZOoB2ZZ2cOl73m-n19rdA>
    <xmx:aBYNZ0AJ6WoGyZiURE4X8uHteuRSPPC7M8Q_w1xi24zAEX_YWYVgJIBl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 09:02:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a36fd1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:01:16 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:02:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 04/10] reftable: convert from `strbuf` to `reftable_buf`
Message-ID: <e1ff1af1f302490f8d79301a73f7cd48314477ba.1728910727.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728910726.git.ps@pks.im>

Convert the reftable library to use the `reftable_buf` interface instead
of the `strbuf` interface. This is mostly a mechanical change via sed(1)
with some manual fixes where functions for `strbuf` and `reftable_buf`
differ. The converted code does not yet handle allocation failures. This
will be handled in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c                   |   2 +-
 reftable/basics.h                   |   3 +-
 reftable/block.c                    |  34 ++++----
 reftable/block.h                    |  14 ++--
 reftable/blocksource.c              |   6 +-
 reftable/blocksource.h              |   3 +-
 reftable/iter.c                     |   6 +-
 reftable/iter.h                     |   8 +-
 reftable/reader.c                   |  16 ++--
 reftable/record.c                   |  80 +++++++++----------
 reftable/record.h                   |  21 ++---
 reftable/stack.c                    | 120 ++++++++++++++--------------
 reftable/system.h                   |   1 -
 reftable/writer.c                   |  66 +++++++--------
 reftable/writer.h                   |   2 +-
 t/unit-tests/lib-reftable.c         |   4 +-
 t/unit-tests/lib-reftable.h         |   7 +-
 t/unit-tests/t-reftable-basics.c    |  16 ++--
 t/unit-tests/t-reftable-block.c     |  42 +++++-----
 t/unit-tests/t-reftable-merged.c    |  26 +++---
 t/unit-tests/t-reftable-reader.c    |   8 +-
 t/unit-tests/t-reftable-readwrite.c |  92 ++++++++++-----------
 t/unit-tests/t-reftable-record.c    |  74 ++++++++---------
 t/unit-tests/t-reftable-stack.c     |  90 ++++++++++-----------
 24 files changed, 371 insertions(+), 370 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 65ad761da0b..bc4fcc91446 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -260,7 +260,7 @@ int names_equal(const char **a, const char **b)
 	return a[i] == b[i];
 }
 
-int common_prefix_size(struct strbuf *a, struct strbuf *b)
+int common_prefix_size(struct reftable_buf *a, struct reftable_buf *b)
 {
 	int p = 0;
 	for (; p < a->len && p < b->len; p++) {
diff --git a/reftable/basics.h b/reftable/basics.h
index bd33c34deae..9d3f13fe04d 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -144,8 +144,7 @@ char *reftable_strdup(const char *str);
 #endif
 
 /* Find the longest shared prefix size of `a` and `b` */
-struct strbuf;
-int common_prefix_size(struct strbuf *a, struct strbuf *b);
+int common_prefix_size(struct reftable_buf *a, struct reftable_buf *b);
 
 int hash_size(uint32_t id);
 
diff --git a/reftable/block.c b/reftable/block.c
index cd4180eac7b..4f62b823db8 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -38,7 +38,7 @@ int footer_size(int version)
 }
 
 static int block_writer_register_restart(struct block_writer *w, int n,
-					 int is_restart, struct strbuf *key)
+					 int is_restart, struct reftable_buf *key)
 {
 	int rlen = w->restart_len;
 	if (rlen >= MAX_RESTARTS) {
@@ -59,8 +59,8 @@ static int block_writer_register_restart(struct block_writer *w, int n,
 
 	w->next += n;
 
-	strbuf_reset(&w->last_key);
-	strbuf_add(&w->last_key, key->buf, key->len);
+	reftable_buf_reset(&w->last_key);
+	reftable_buf_add(&w->last_key, key->buf, key->len);
 	w->entries++;
 	return 0;
 }
@@ -98,8 +98,8 @@ uint8_t block_writer_type(struct block_writer *bw)
    empty key. */
 int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 {
-	struct strbuf empty = STRBUF_INIT;
-	struct strbuf last =
+	struct reftable_buf empty = REFTABLE_BUF_INIT;
+	struct reftable_buf last =
 		w->entries % w->restart_interval == 0 ? empty : w->last_key;
 	struct string_view out = {
 		.buf = w->buf + w->next,
@@ -109,7 +109,7 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	struct string_view start = out;
 
 	int is_restart = 0;
-	struct strbuf key = STRBUF_INIT;
+	struct reftable_buf key = REFTABLE_BUF_INIT;
 	int n = 0;
 	int err = -1;
 
@@ -133,7 +133,7 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	err = block_writer_register_restart(w, start.len - out.len, is_restart,
 					    &key);
 done:
-	strbuf_release(&key);
+	reftable_buf_release(&key);
 	return err;
 }
 
@@ -325,7 +325,7 @@ uint8_t block_reader_type(const struct block_reader *r)
 	return r->block.data[r->header_off];
 }
 
-int block_reader_first_key(const struct block_reader *br, struct strbuf *key)
+int block_reader_first_key(const struct block_reader *br, struct reftable_buf *key)
 {
 	int off = br->header_off + 4, n;
 	struct string_view in = {
@@ -334,7 +334,7 @@ int block_reader_first_key(const struct block_reader *br, struct strbuf *key)
 	};
 	uint8_t extra = 0;
 
-	strbuf_reset(key);
+	reftable_buf_reset(key);
 
 	n = reftable_decode_key(key, &extra, in);
 	if (n < 0)
@@ -355,13 +355,13 @@ void block_iter_seek_start(struct block_iter *it, const struct block_reader *br)
 	it->block = br->block.data;
 	it->block_len = br->block_len;
 	it->hash_size = br->hash_size;
-	strbuf_reset(&it->last_key);
+	reftable_buf_reset(&it->last_key);
 	it->next_off = br->header_off + 4;
 }
 
 struct restart_needle_less_args {
 	int error;
-	struct strbuf needle;
+	struct reftable_buf needle;
 	const struct block_reader *reader;
 };
 
@@ -433,7 +433,7 @@ int block_iter_next(struct block_iter *it, struct reftable_record *rec)
 
 void block_iter_reset(struct block_iter *it)
 {
-	strbuf_reset(&it->last_key);
+	reftable_buf_reset(&it->last_key);
 	it->next_off = 0;
 	it->block = NULL;
 	it->block_len = 0;
@@ -442,12 +442,12 @@ void block_iter_reset(struct block_iter *it)
 
 void block_iter_close(struct block_iter *it)
 {
-	strbuf_release(&it->last_key);
-	strbuf_release(&it->scratch);
+	reftable_buf_release(&it->last_key);
+	reftable_buf_release(&it->scratch);
 }
 
 int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
-			struct strbuf *want)
+			struct reftable_buf *want)
 {
 	struct restart_needle_less_args args = {
 		.needle = *want,
@@ -537,7 +537,7 @@ int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
 		 * with themselves.
 		 */
 		reftable_record_key(&rec, &it->last_key);
-		if (strbuf_cmp(&it->last_key, want) >= 0) {
+		if (reftable_buf_cmp(&it->last_key, want) >= 0) {
 			it->next_off = prev_off;
 			goto done;
 		}
@@ -554,7 +554,7 @@ void block_writer_release(struct block_writer *bw)
 	REFTABLE_FREE_AND_NULL(bw->zstream);
 	REFTABLE_FREE_AND_NULL(bw->restarts);
 	REFTABLE_FREE_AND_NULL(bw->compressed);
-	strbuf_release(&bw->last_key);
+	reftable_buf_release(&bw->last_key);
 	/* the block is not owned. */
 }
 
diff --git a/reftable/block.h b/reftable/block.h
index 18d7ea03373..9a3effa5134 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -38,7 +38,7 @@ struct block_writer {
 	uint32_t restart_len;
 	uint32_t restart_cap;
 
-	struct strbuf last_key;
+	struct reftable_buf last_key;
 	int entries;
 };
 
@@ -98,7 +98,7 @@ void block_reader_release(struct block_reader *br);
 uint8_t block_reader_type(const struct block_reader *r);
 
 /* Decodes the first key in the block */
-int block_reader_first_key(const struct block_reader *br, struct strbuf *key);
+int block_reader_first_key(const struct block_reader *br, struct reftable_buf *key);
 
 /* Iterate over entries in a block */
 struct block_iter {
@@ -109,13 +109,13 @@ struct block_iter {
 	int hash_size;
 
 	/* key for last entry we read. */
-	struct strbuf last_key;
-	struct strbuf scratch;
+	struct reftable_buf last_key;
+	struct reftable_buf scratch;
 };
 
 #define BLOCK_ITER_INIT { \
-	.last_key = STRBUF_INIT, \
-	.scratch = STRBUF_INIT, \
+	.last_key = REFTABLE_BUF_INIT, \
+	.scratch = REFTABLE_BUF_INIT, \
 }
 
 /* Position `it` at start of the block */
@@ -123,7 +123,7 @@ void block_iter_seek_start(struct block_iter *it, const struct block_reader *br)
 
 /* Position `it` to the `want` key in the block */
 int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
-			struct strbuf *want);
+			struct reftable_buf *want);
 
 /* return < 0 for error, 0 for OK, > 0 for EOF. */
 int block_iter_next(struct block_iter *it, struct reftable_record *rec);
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index a2a6a196d55..d6242d67900 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -27,7 +27,7 @@ static void strbuf_close(void *b UNUSED)
 static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
 			     uint32_t size)
 {
-	struct strbuf *b = v;
+	struct reftable_buf *b = v;
 	assert(off + size <= b->len);
 	REFTABLE_CALLOC_ARRAY(dest->data, size);
 	if (!dest->data)
@@ -39,7 +39,7 @@ static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
 
 static uint64_t strbuf_size(void *b)
 {
-	return ((struct strbuf *)b)->len;
+	return ((struct reftable_buf *)b)->len;
 }
 
 static struct reftable_block_source_vtable strbuf_vtable = {
@@ -50,7 +50,7 @@ static struct reftable_block_source_vtable strbuf_vtable = {
 };
 
 void block_source_from_strbuf(struct reftable_block_source *bs,
-			      struct strbuf *buf)
+			      struct reftable_buf *buf)
 {
 	assert(!bs->ops);
 	bs->ops = &strbuf_vtable;
diff --git a/reftable/blocksource.h b/reftable/blocksource.h
index 659a27b4063..ee3647c6531 100644
--- a/reftable/blocksource.h
+++ b/reftable/blocksource.h
@@ -12,9 +12,10 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 
 struct reftable_block_source;
+struct reftable_buf;
 
 /* Create an in-memory block source for reading reftables */
 void block_source_from_strbuf(struct reftable_block_source *bs,
-			      struct strbuf *buf);
+			      struct reftable_buf *buf);
 
 #endif
diff --git a/reftable/iter.c b/reftable/iter.c
index d926db653b1..6c193fd31a9 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -55,7 +55,7 @@ void iterator_set_empty(struct reftable_iterator *it)
 static void filtering_ref_iterator_close(void *iter_arg)
 {
 	struct filtering_ref_iterator *fri = iter_arg;
-	strbuf_release(&fri->oid);
+	reftable_buf_release(&fri->oid);
 	reftable_iterator_destroy(&fri->it);
 }
 
@@ -115,7 +115,7 @@ static void indexed_table_ref_iter_close(void *p)
 	block_iter_close(&it->cur);
 	reftable_block_done(&it->block_reader.block);
 	reftable_free(it->offsets);
-	strbuf_release(&it->oid);
+	reftable_buf_release(&it->oid);
 }
 
 static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
@@ -197,7 +197,7 @@ int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
 
 	*itr = empty;
 	itr->r = r;
-	strbuf_add(&itr->oid, oid, oid_len);
+	reftable_buf_add(&itr->oid, oid, oid_len);
 
 	itr->offsets = offsets;
 	itr->offset_len = offset_len;
diff --git a/reftable/iter.h b/reftable/iter.h
index b3225bc7add..40f98893b85 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -44,12 +44,12 @@ void iterator_set_empty(struct reftable_iterator *it);
 
 /* iterator that produces only ref records that point to `oid` */
 struct filtering_ref_iterator {
-	struct strbuf oid;
+	struct reftable_buf oid;
 	struct reftable_iterator it;
 };
 #define FILTERING_REF_ITERATOR_INIT \
 	{                           \
-		.oid = STRBUF_INIT  \
+		.oid = REFTABLE_BUF_INIT  \
 	}
 
 void iterator_from_filtering_ref_iterator(struct reftable_iterator *,
@@ -60,7 +60,7 @@ void iterator_from_filtering_ref_iterator(struct reftable_iterator *,
  */
 struct indexed_table_ref_iter {
 	struct reftable_reader *r;
-	struct strbuf oid;
+	struct reftable_buf oid;
 
 	/* mutable */
 	uint64_t *offsets;
@@ -75,7 +75,7 @@ struct indexed_table_ref_iter {
 
 #define INDEXED_TABLE_REF_ITER_INIT { \
 	.cur = BLOCK_ITER_INIT, \
-	.oid = STRBUF_INIT, \
+	.oid = REFTABLE_BUF_INIT, \
 }
 
 void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
diff --git a/reftable/reader.c b/reftable/reader.c
index 8d372539220..388f8bf6d7b 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -350,8 +350,8 @@ static int table_iter_seek_start(struct table_iter *ti, uint8_t typ, int index)
 static int table_iter_seek_linear(struct table_iter *ti,
 				  struct reftable_record *want)
 {
-	struct strbuf want_key = STRBUF_INIT;
-	struct strbuf got_key = STRBUF_INIT;
+	struct reftable_buf want_key = REFTABLE_BUF_INIT;
+	struct reftable_buf got_key = REFTABLE_BUF_INIT;
 	struct reftable_record rec;
 	int err;
 
@@ -401,7 +401,7 @@ static int table_iter_seek_linear(struct table_iter *ti,
 		if (err < 0)
 			goto done;
 
-		if (strbuf_cmp(&got_key, &want_key) > 0) {
+		if (reftable_buf_cmp(&got_key, &want_key) > 0) {
 			table_iter_block_done(&next);
 			break;
 		}
@@ -422,8 +422,8 @@ static int table_iter_seek_linear(struct table_iter *ti,
 
 done:
 	reftable_record_release(&rec);
-	strbuf_release(&want_key);
-	strbuf_release(&got_key);
+	reftable_buf_release(&want_key);
+	reftable_buf_release(&got_key);
 	return err;
 }
 
@@ -431,11 +431,11 @@ static int table_iter_seek_indexed(struct table_iter *ti,
 				   struct reftable_record *rec)
 {
 	struct reftable_record want_index = {
-		.type = BLOCK_TYPE_INDEX, .u.idx = { .last_key = STRBUF_INIT }
+		.type = BLOCK_TYPE_INDEX, .u.idx = { .last_key = REFTABLE_BUF_INIT }
 	};
 	struct reftable_record index_result = {
 		.type = BLOCK_TYPE_INDEX,
-		.u.idx = { .last_key = STRBUF_INIT },
+		.u.idx = { .last_key = REFTABLE_BUF_INIT },
 	};
 	int err;
 
@@ -765,7 +765,7 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 	}
 	*filter = empty;
 
-	strbuf_add(&filter->oid, oid, oid_len);
+	reftable_buf_add(&filter->oid, oid, oid_len);
 	iterator_from_table_iter(&filter->it, ti);
 
 	iterator_from_filtering_ref_iterator(it, filter);
diff --git a/reftable/record.c b/reftable/record.c
index 87157f2c386..0182c973437 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -98,7 +98,7 @@ const unsigned char *reftable_ref_record_val2(const struct reftable_ref_record *
 	}
 }
 
-static int decode_string(struct strbuf *dest, struct string_view in)
+static int decode_string(struct reftable_buf *dest, struct string_view in)
 {
 	int start_len = in.len;
 	uint64_t tsize = 0;
@@ -109,8 +109,8 @@ static int decode_string(struct strbuf *dest, struct string_view in)
 	if (in.len < tsize)
 		return -1;
 
-	strbuf_reset(dest);
-	strbuf_add(dest, in.buf, tsize);
+	reftable_buf_reset(dest);
+	reftable_buf_add(dest, in.buf, tsize);
 	string_view_consume(&in, tsize);
 
 	return start_len - in.len;
@@ -133,7 +133,7 @@ static int encode_string(const char *str, struct string_view s)
 }
 
 int reftable_encode_key(int *restart, struct string_view dest,
-			struct strbuf prev_key, struct strbuf key,
+			struct reftable_buf prev_key, struct reftable_buf key,
 			uint8_t extra)
 {
 	struct string_view start = dest;
@@ -183,7 +183,7 @@ int reftable_decode_keylen(struct string_view in,
 	return start_len - in.len;
 }
 
-int reftable_decode_key(struct strbuf *last_key, uint8_t *extra,
+int reftable_decode_key(struct reftable_buf *last_key, uint8_t *extra,
 			struct string_view in)
 {
 	int start_len = in.len;
@@ -200,19 +200,19 @@ int reftable_decode_key(struct strbuf *last_key, uint8_t *extra,
 	    prefix_len > last_key->len)
 		return -1;
 
-	strbuf_setlen(last_key, prefix_len);
-	strbuf_add(last_key, in.buf, suffix_len);
+	reftable_buf_setlen(last_key, prefix_len);
+	reftable_buf_add(last_key, in.buf, suffix_len);
 	string_view_consume(&in, suffix_len);
 
 	return start_len - in.len;
 }
 
-static void reftable_ref_record_key(const void *r, struct strbuf *dest)
+static void reftable_ref_record_key(const void *r, struct reftable_buf *dest)
 {
 	const struct reftable_ref_record *rec =
 		(const struct reftable_ref_record *)r;
-	strbuf_reset(dest);
-	strbuf_addstr(dest, rec->refname);
+	reftable_buf_reset(dest);
+	reftable_buf_addstr(dest, rec->refname);
 }
 
 static int reftable_ref_record_copy_from(void *rec, const void *src_rec,
@@ -350,9 +350,9 @@ static int reftable_ref_record_encode(const void *rec, struct string_view s,
 	return start.len - s.len;
 }
 
-static int reftable_ref_record_decode(void *rec, struct strbuf key,
+static int reftable_ref_record_decode(void *rec, struct reftable_buf key,
 				      uint8_t val_type, struct string_view in,
-				      int hash_size, struct strbuf *scratch)
+				      int hash_size, struct reftable_buf *scratch)
 {
 	struct reftable_ref_record *r = rec;
 	struct string_view start = in;
@@ -415,7 +415,7 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
 			goto done;
 		}
 		string_view_consume(&in, n);
-		r->value.symref = strbuf_detach(scratch, NULL);
+		r->value.symref = reftable_buf_detach(scratch);
 	} break;
 
 	case REFTABLE_REF_DELETION:
@@ -465,12 +465,12 @@ static struct reftable_record_vtable reftable_ref_record_vtable = {
 	.cmp = &reftable_ref_record_cmp_void,
 };
 
-static void reftable_obj_record_key(const void *r, struct strbuf *dest)
+static void reftable_obj_record_key(const void *r, struct reftable_buf *dest)
 {
 	const struct reftable_obj_record *rec =
 		(const struct reftable_obj_record *)r;
-	strbuf_reset(dest);
-	strbuf_add(dest, rec->hash_prefix, rec->hash_prefix_len);
+	reftable_buf_reset(dest);
+	reftable_buf_add(dest, rec->hash_prefix, rec->hash_prefix_len);
 }
 
 static void reftable_obj_record_release(void *rec)
@@ -547,10 +547,10 @@ static int reftable_obj_record_encode(const void *rec, struct string_view s,
 	return start.len - s.len;
 }
 
-static int reftable_obj_record_decode(void *rec, struct strbuf key,
+static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 				      uint8_t val_type, struct string_view in,
 				      int hash_size UNUSED,
-				      struct strbuf *scratch UNUSED)
+				      struct reftable_buf *scratch UNUSED)
 {
 	struct string_view start = in;
 	struct reftable_obj_record *r = rec;
@@ -664,19 +664,19 @@ static struct reftable_record_vtable reftable_obj_record_vtable = {
 	.cmp = &reftable_obj_record_cmp_void,
 };
 
-static void reftable_log_record_key(const void *r, struct strbuf *dest)
+static void reftable_log_record_key(const void *r, struct reftable_buf *dest)
 {
 	const struct reftable_log_record *rec =
 		(const struct reftable_log_record *)r;
 	int len = strlen(rec->refname);
 	uint8_t i64[8];
 	uint64_t ts = 0;
-	strbuf_reset(dest);
-	strbuf_add(dest, (uint8_t *)rec->refname, len + 1);
+	reftable_buf_reset(dest);
+	reftable_buf_add(dest, (uint8_t *)rec->refname, len + 1);
 
 	ts = (~ts) - rec->update_index;
 	put_be64(&i64[0], ts);
-	strbuf_add(dest, i64, sizeof(i64));
+	reftable_buf_add(dest, i64, sizeof(i64));
 }
 
 static int reftable_log_record_copy_from(void *rec, const void *src_rec,
@@ -807,9 +807,9 @@ static int reftable_log_record_encode(const void *rec, struct string_view s,
 	return start.len - s.len;
 }
 
-static int reftable_log_record_decode(void *rec, struct strbuf key,
+static int reftable_log_record_decode(void *rec, struct reftable_buf key,
 				      uint8_t val_type, struct string_view in,
-				      int hash_size, struct strbuf *scratch)
+				      int hash_size, struct reftable_buf *scratch)
 {
 	struct string_view start = in;
 	struct reftable_log_record *r = rec;
@@ -1027,11 +1027,11 @@ static struct reftable_record_vtable reftable_log_record_vtable = {
 	.cmp = &reftable_log_record_cmp_void,
 };
 
-static void reftable_index_record_key(const void *r, struct strbuf *dest)
+static void reftable_index_record_key(const void *r, struct reftable_buf *dest)
 {
 	const struct reftable_index_record *rec = r;
-	strbuf_reset(dest);
-	strbuf_add(dest, rec->last_key.buf, rec->last_key.len);
+	reftable_buf_reset(dest);
+	reftable_buf_add(dest, rec->last_key.buf, rec->last_key.len);
 }
 
 static int reftable_index_record_copy_from(void *rec, const void *src_rec,
@@ -1040,8 +1040,8 @@ static int reftable_index_record_copy_from(void *rec, const void *src_rec,
 	struct reftable_index_record *dst = rec;
 	const struct reftable_index_record *src = src_rec;
 
-	strbuf_reset(&dst->last_key);
-	strbuf_add(&dst->last_key, src->last_key.buf, src->last_key.len);
+	reftable_buf_reset(&dst->last_key);
+	reftable_buf_add(&dst->last_key, src->last_key.buf, src->last_key.len);
 	dst->offset = src->offset;
 
 	return 0;
@@ -1050,7 +1050,7 @@ static int reftable_index_record_copy_from(void *rec, const void *src_rec,
 static void reftable_index_record_release(void *rec)
 {
 	struct reftable_index_record *idx = rec;
-	strbuf_release(&idx->last_key);
+	reftable_buf_release(&idx->last_key);
 }
 
 static uint8_t reftable_index_record_val_type(const void *rec UNUSED)
@@ -1074,18 +1074,18 @@ static int reftable_index_record_encode(const void *rec, struct string_view out,
 	return start.len - out.len;
 }
 
-static int reftable_index_record_decode(void *rec, struct strbuf key,
+static int reftable_index_record_decode(void *rec, struct reftable_buf key,
 					uint8_t val_type UNUSED,
 					struct string_view in,
 					int hash_size UNUSED,
-					struct strbuf *scratch UNUSED)
+					struct reftable_buf *scratch UNUSED)
 {
 	struct string_view start = in;
 	struct reftable_index_record *r = rec;
 	int n = 0;
 
-	strbuf_reset(&r->last_key);
-	strbuf_add(&r->last_key, key.buf, key.len);
+	reftable_buf_reset(&r->last_key);
+	reftable_buf_add(&r->last_key, key.buf, key.len);
 
 	n = get_var_int(&r->offset, &in);
 	if (n < 0)
@@ -1101,14 +1101,14 @@ static int reftable_index_record_equal(const void *a, const void *b,
 	struct reftable_index_record *ia = (struct reftable_index_record *) a;
 	struct reftable_index_record *ib = (struct reftable_index_record *) b;
 
-	return ia->offset == ib->offset && !strbuf_cmp(&ia->last_key, &ib->last_key);
+	return ia->offset == ib->offset && !reftable_buf_cmp(&ia->last_key, &ib->last_key);
 }
 
 static int reftable_index_record_cmp(const void *_a, const void *_b)
 {
 	const struct reftable_index_record *a = _a;
 	const struct reftable_index_record *b = _b;
-	return strbuf_cmp(&a->last_key, &b->last_key);
+	return reftable_buf_cmp(&a->last_key, &b->last_key);
 }
 
 static struct reftable_record_vtable reftable_index_record_vtable = {
@@ -1124,7 +1124,7 @@ static struct reftable_record_vtable reftable_index_record_vtable = {
 	.cmp = &reftable_index_record_cmp,
 };
 
-void reftable_record_key(struct reftable_record *rec, struct strbuf *dest)
+void reftable_record_key(struct reftable_record *rec, struct reftable_buf *dest)
 {
 	reftable_record_vtable(rec)->key(reftable_record_data(rec), dest);
 }
@@ -1151,9 +1151,9 @@ uint8_t reftable_record_val_type(struct reftable_record *rec)
 	return reftable_record_vtable(rec)->val_type(reftable_record_data(rec));
 }
 
-int reftable_record_decode(struct reftable_record *rec, struct strbuf key,
+int reftable_record_decode(struct reftable_record *rec, struct reftable_buf key,
 			   uint8_t extra, struct string_view src, int hash_size,
-			   struct strbuf *scratch)
+			   struct reftable_buf *scratch)
 {
 	return reftable_record_vtable(rec)->decode(reftable_record_data(rec),
 						   key, extra, src, hash_size,
@@ -1294,7 +1294,7 @@ void reftable_record_init(struct reftable_record *rec, uint8_t typ)
 	case BLOCK_TYPE_OBJ:
 		return;
 	case BLOCK_TYPE_INDEX:
-		strbuf_init(&rec->u.idx.last_key, 0);
+		reftable_buf_init(&rec->u.idx.last_key);
 		return;
 	default:
 		BUG("unhandled record type");
diff --git a/reftable/record.h b/reftable/record.h
index 0f53ba54434..271da3bf360 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -9,6 +9,7 @@ license that can be found in the LICENSE file or at
 #ifndef RECORD_H
 #define RECORD_H
 
+#include "basics.h"
 #include "system.h"
 
 #include <stdint.h>
@@ -38,8 +39,8 @@ int put_var_int(struct string_view *dest, uint64_t val);
 
 /* Methods for records. */
 struct reftable_record_vtable {
-	/* encode the key of to a uint8_t strbuf. */
-	void (*key)(const void *rec, struct strbuf *dest);
+	/* encode the key of to a uint8_t reftable_buf. */
+	void (*key)(const void *rec, struct reftable_buf *dest);
 
 	/* The record type of ('r' for ref). */
 	uint8_t type;
@@ -54,9 +55,9 @@ struct reftable_record_vtable {
 	int (*encode)(const void *rec, struct string_view dest, int hash_size);
 
 	/* decode data from `src` into the record. */
-	int (*decode)(void *rec, struct strbuf key, uint8_t extra,
+	int (*decode)(void *rec, struct reftable_buf key, uint8_t extra,
 		      struct string_view src, int hash_size,
-		      struct strbuf *scratch);
+		      struct reftable_buf *scratch);
 
 	/* deallocate and null the record. */
 	void (*release)(void *rec);
@@ -83,7 +84,7 @@ int reftable_is_block_type(uint8_t typ);
 /* Encode `key` into `dest`. Sets `is_restart` to indicate a restart. Returns
  * number of bytes written. */
 int reftable_encode_key(int *is_restart, struct string_view dest,
-			struct strbuf prev_key, struct strbuf key,
+			struct reftable_buf prev_key, struct reftable_buf key,
 			uint8_t extra);
 
 /* Decode a record's key lengths. */
@@ -96,13 +97,13 @@ int reftable_decode_keylen(struct string_view in,
  * Decode into `last_key` and `extra` from `in`. `last_key` is expected to
  * contain the decoded key of the preceding record, if any.
  */
-int reftable_decode_key(struct strbuf *last_key, uint8_t *extra,
+int reftable_decode_key(struct reftable_buf *last_key, uint8_t *extra,
 			struct string_view in);
 
 /* reftable_index_record are used internally to speed up lookups. */
 struct reftable_index_record {
 	uint64_t offset; /* Offset of block */
-	struct strbuf last_key; /* Last key of the block. */
+	struct reftable_buf last_key; /* Last key of the block. */
 };
 
 /* reftable_obj_record stores an object ID => ref mapping. */
@@ -136,15 +137,15 @@ void reftable_record_init(struct reftable_record *rec, uint8_t typ);
 /* see struct record_vtable */
 int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b);
 int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size);
-void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
+void reftable_record_key(struct reftable_record *rec, struct reftable_buf *dest);
 int reftable_record_copy_from(struct reftable_record *rec,
 			      struct reftable_record *src, int hash_size);
 uint8_t reftable_record_val_type(struct reftable_record *rec);
 int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
 			   int hash_size);
-int reftable_record_decode(struct reftable_record *rec, struct strbuf key,
+int reftable_record_decode(struct reftable_record *rec, struct reftable_buf key,
 			   uint8_t extra, struct string_view src,
-			   int hash_size, struct strbuf *scratch);
+			   int hash_size, struct reftable_buf *scratch);
 int reftable_record_is_deletion(struct reftable_record *rec);
 
 static inline uint8_t reftable_record_type(struct reftable_record *rec)
diff --git a/reftable/stack.c b/reftable/stack.c
index d7bc1187dfb..6ba48ddce5d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -31,13 +31,13 @@ static void reftable_addition_close(struct reftable_addition *add);
 static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 					     int reuse_open);
 
-static void stack_filename(struct strbuf *dest, struct reftable_stack *st,
+static void stack_filename(struct reftable_buf *dest, struct reftable_stack *st,
 			   const char *name)
 {
-	strbuf_reset(dest);
-	strbuf_addstr(dest, st->reftable_dir);
-	strbuf_addstr(dest, "/");
-	strbuf_addstr(dest, name);
+	reftable_buf_reset(dest);
+	reftable_buf_addstr(dest, st->reftable_dir);
+	reftable_buf_addstr(dest, "/");
+	reftable_buf_addstr(dest, name);
 }
 
 static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
@@ -56,7 +56,7 @@ static int reftable_fd_flush(void *arg)
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 		       const struct reftable_write_options *_opts)
 {
-	struct strbuf list_file_name = STRBUF_INIT;
+	struct reftable_buf list_file_name = REFTABLE_BUF_INIT;
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *p;
 	int err;
@@ -74,11 +74,11 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 
 	*dest = NULL;
 
-	strbuf_reset(&list_file_name);
-	strbuf_addstr(&list_file_name, dir);
-	strbuf_addstr(&list_file_name, "/tables.list");
+	reftable_buf_reset(&list_file_name);
+	reftable_buf_addstr(&list_file_name, dir);
+	reftable_buf_addstr(&list_file_name, "/tables.list");
 
-	p->list_file = strbuf_detach(&list_file_name, NULL);
+	p->list_file = reftable_buf_detach(&list_file_name);
 	p->list_fd = -1;
 	p->opts = opts;
 	p->reftable_dir = reftable_strdup(dir);
@@ -208,10 +208,10 @@ void reftable_stack_destroy(struct reftable_stack *st)
 
 	if (st->readers) {
 		int i = 0;
-		struct strbuf filename = STRBUF_INIT;
+		struct reftable_buf filename = REFTABLE_BUF_INIT;
 		for (i = 0; i < st->readers_len; i++) {
 			const char *name = reader_name(st->readers[i]);
-			strbuf_reset(&filename);
+			reftable_buf_reset(&filename);
 			if (names && !has_name(names, name)) {
 				stack_filename(&filename, st, name);
 			}
@@ -222,7 +222,7 @@ void reftable_stack_destroy(struct reftable_stack *st)
 				unlink(filename.buf);
 			}
 		}
-		strbuf_release(&filename);
+		reftable_buf_release(&filename);
 		st->readers_len = 0;
 		REFTABLE_FREE_AND_NULL(st->readers);
 	}
@@ -260,7 +260,7 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	size_t reused_len = 0, reused_alloc = 0, names_len;
 	size_t new_readers_len = 0;
 	struct reftable_merged_table *new_merged = NULL;
-	struct strbuf table_path = STRBUF_INIT;
+	struct reftable_buf table_path = REFTABLE_BUF_INIT;
 	int err = 0;
 	size_t i;
 
@@ -374,7 +374,7 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	reftable_free(new_readers);
 	reftable_free(reused);
 	reftable_free(cur);
-	strbuf_release(&table_path);
+	reftable_buf_release(&table_path);
 	return err;
 }
 
@@ -623,14 +623,14 @@ int reftable_stack_add(struct reftable_stack *st,
 	return 0;
 }
 
-static void format_name(struct strbuf *dest, uint64_t min, uint64_t max)
+static void format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
 {
 	char buf[100];
 	uint32_t rnd = (uint32_t)git_rand();
 	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
 		 min, max, rnd);
-	strbuf_reset(dest);
-	strbuf_addstr(dest, buf);
+	reftable_buf_reset(dest);
+	reftable_buf_addstr(dest, buf);
 }
 
 struct reftable_addition {
@@ -648,7 +648,7 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 					struct reftable_stack *st,
 					unsigned int flags)
 {
-	struct strbuf lock_file_name = STRBUF_INIT;
+	struct reftable_buf lock_file_name = REFTABLE_BUF_INIT;
 	int err;
 
 	add->stack = st;
@@ -690,13 +690,13 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 done:
 	if (err)
 		reftable_addition_close(add);
-	strbuf_release(&lock_file_name);
+	reftable_buf_release(&lock_file_name);
 	return err;
 }
 
 static void reftable_addition_close(struct reftable_addition *add)
 {
-	struct strbuf nm = STRBUF_INIT;
+	struct reftable_buf nm = REFTABLE_BUF_INIT;
 	size_t i;
 
 	for (i = 0; i < add->new_tables_len; i++) {
@@ -711,7 +711,7 @@ static void reftable_addition_close(struct reftable_addition *add)
 	add->new_tables_cap = 0;
 
 	rollback_lock_file(&add->tables_list_lock);
-	strbuf_release(&nm);
+	reftable_buf_release(&nm);
 }
 
 void reftable_addition_destroy(struct reftable_addition *add)
@@ -725,7 +725,7 @@ void reftable_addition_destroy(struct reftable_addition *add)
 
 int reftable_addition_commit(struct reftable_addition *add)
 {
-	struct strbuf table_list = STRBUF_INIT;
+	struct reftable_buf table_list = REFTABLE_BUF_INIT;
 	int lock_file_fd = get_lock_file_fd(&add->tables_list_lock);
 	int err = 0;
 	size_t i;
@@ -734,16 +734,16 @@ int reftable_addition_commit(struct reftable_addition *add)
 		goto done;
 
 	for (i = 0; i < add->stack->merged->readers_len; i++) {
-		strbuf_addstr(&table_list, add->stack->readers[i]->name);
-		strbuf_addstr(&table_list, "\n");
+		reftable_buf_addstr(&table_list, add->stack->readers[i]->name);
+		reftable_buf_addstr(&table_list, "\n");
 	}
 	for (i = 0; i < add->new_tables_len; i++) {
-		strbuf_addstr(&table_list, add->new_tables[i]);
-		strbuf_addstr(&table_list, "\n");
+		reftable_buf_addstr(&table_list, add->new_tables[i]);
+		reftable_buf_addstr(&table_list, "\n");
 	}
 
 	err = write_in_full(lock_file_fd, table_list.buf, table_list.len);
-	strbuf_release(&table_list);
+	reftable_buf_release(&table_list);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
@@ -837,19 +837,19 @@ int reftable_addition_add(struct reftable_addition *add,
 					     void *arg),
 			  void *arg)
 {
-	struct strbuf temp_tab_file_name = STRBUF_INIT;
-	struct strbuf tab_file_name = STRBUF_INIT;
-	struct strbuf next_name = STRBUF_INIT;
+	struct reftable_buf temp_tab_file_name = REFTABLE_BUF_INIT;
+	struct reftable_buf tab_file_name = REFTABLE_BUF_INIT;
+	struct reftable_buf next_name = REFTABLE_BUF_INIT;
 	struct reftable_writer *wr = NULL;
 	struct tempfile *tab_file = NULL;
 	int err = 0;
 	int tab_fd;
 
-	strbuf_reset(&next_name);
+	reftable_buf_reset(&next_name);
 	format_name(&next_name, add->next_update_index, add->next_update_index);
 
 	stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
-	strbuf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
+	reftable_buf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
 
 	tab_file = mks_tempfile(temp_tab_file_name.buf);
 	if (!tab_file) {
@@ -894,7 +894,7 @@ int reftable_addition_add(struct reftable_addition *add,
 	}
 
 	format_name(&next_name, wr->min_update_index, wr->max_update_index);
-	strbuf_addstr(&next_name, ".ref");
+	reftable_buf_addstr(&next_name, ".ref");
 	stack_filename(&tab_file_name, add->stack, next_name.buf);
 
 	/*
@@ -913,13 +913,13 @@ int reftable_addition_add(struct reftable_addition *add,
 		err = REFTABLE_OUT_OF_MEMORY_ERROR;
 		goto done;
 	}
-	add->new_tables[add->new_tables_len++] = strbuf_detach(&next_name, NULL);
+	add->new_tables[add->new_tables_len++] = reftable_buf_detach(&next_name);
 
 done:
 	delete_tempfile(&tab_file);
-	strbuf_release(&temp_tab_file_name);
-	strbuf_release(&tab_file_name);
-	strbuf_release(&next_name);
+	reftable_buf_release(&temp_tab_file_name);
+	reftable_buf_release(&tab_file_name);
+	reftable_buf_release(&next_name);
 	reftable_writer_free(wr);
 	return err;
 }
@@ -938,8 +938,8 @@ static int stack_compact_locked(struct reftable_stack *st,
 				struct reftable_log_expiry_config *config,
 				struct tempfile **tab_file_out)
 {
-	struct strbuf next_name = STRBUF_INIT;
-	struct strbuf tab_file_path = STRBUF_INIT;
+	struct reftable_buf next_name = REFTABLE_BUF_INIT;
+	struct reftable_buf tab_file_path = REFTABLE_BUF_INIT;
 	struct reftable_writer *wr = NULL;
 	struct tempfile *tab_file;
 	int tab_fd, err = 0;
@@ -948,7 +948,7 @@ static int stack_compact_locked(struct reftable_stack *st,
 		    reftable_reader_min_update_index(st->readers[first]),
 		    reftable_reader_max_update_index(st->readers[last]));
 	stack_filename(&tab_file_path, st, next_name.buf);
-	strbuf_addstr(&tab_file_path, ".temp.XXXXXX");
+	reftable_buf_addstr(&tab_file_path, ".temp.XXXXXX");
 
 	tab_file = mks_tempfile(tab_file_path.buf);
 	if (!tab_file) {
@@ -986,8 +986,8 @@ static int stack_compact_locked(struct reftable_stack *st,
 done:
 	delete_tempfile(&tab_file);
 	reftable_writer_free(wr);
-	strbuf_release(&next_name);
-	strbuf_release(&tab_file_path);
+	reftable_buf_release(&next_name);
+	reftable_buf_release(&tab_file_path);
 	return err;
 }
 
@@ -1111,10 +1111,10 @@ static int stack_compact_range(struct reftable_stack *st,
 			       struct reftable_log_expiry_config *expiry,
 			       unsigned int flags)
 {
-	struct strbuf tables_list_buf = STRBUF_INIT;
-	struct strbuf new_table_name = STRBUF_INIT;
-	struct strbuf new_table_path = STRBUF_INIT;
-	struct strbuf table_name = STRBUF_INIT;
+	struct reftable_buf tables_list_buf = REFTABLE_BUF_INIT;
+	struct reftable_buf new_table_name = REFTABLE_BUF_INIT;
+	struct reftable_buf new_table_path = REFTABLE_BUF_INIT;
+	struct reftable_buf table_name = REFTABLE_BUF_INIT;
 	struct lock_file tables_list_lock = LOCK_INIT;
 	struct lock_file *table_locks = NULL;
 	struct tempfile *new_table = NULL;
@@ -1372,7 +1372,7 @@ static int stack_compact_range(struct reftable_stack *st,
 	if (!is_empty_table) {
 		format_name(&new_table_name, st->readers[first]->min_update_index,
 			    st->readers[last]->max_update_index);
-		strbuf_addstr(&new_table_name, ".ref");
+		reftable_buf_addstr(&new_table_name, ".ref");
 		stack_filename(&new_table_path, st, new_table_name.buf);
 
 		err = rename_tempfile(&new_table, new_table_path.buf);
@@ -1388,16 +1388,16 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * simply skip writing it.
 	 */
 	for (i = 0; i < first_to_replace; i++) {
-		strbuf_addstr(&tables_list_buf, names[i]);
-		strbuf_addstr(&tables_list_buf, "\n");
+		reftable_buf_addstr(&tables_list_buf, names[i]);
+		reftable_buf_addstr(&tables_list_buf, "\n");
 	}
 	if (!is_empty_table) {
-		strbuf_addstr(&tables_list_buf, new_table_name.buf);
-		strbuf_addstr(&tables_list_buf, "\n");
+		reftable_buf_addstr(&tables_list_buf, new_table_name.buf);
+		reftable_buf_addstr(&tables_list_buf, "\n");
 	}
 	for (i = last_to_replace + 1; names[i]; i++) {
-		strbuf_addstr(&tables_list_buf, names[i]);
-		strbuf_addstr(&tables_list_buf, "\n");
+		reftable_buf_addstr(&tables_list_buf, names[i]);
+		reftable_buf_addstr(&tables_list_buf, "\n");
 	}
 
 	err = write_in_full(get_lock_file_fd(&tables_list_lock),
@@ -1449,10 +1449,10 @@ static int stack_compact_range(struct reftable_stack *st,
 	reftable_free(table_locks);
 
 	delete_tempfile(&new_table);
-	strbuf_release(&new_table_name);
-	strbuf_release(&new_table_path);
-	strbuf_release(&tables_list_buf);
-	strbuf_release(&table_name);
+	reftable_buf_release(&new_table_name);
+	reftable_buf_release(&new_table_path);
+	reftable_buf_release(&tables_list_buf);
+	reftable_buf_release(&table_name);
 	free_names(names);
 
 	if (err == REFTABLE_LOCK_ERROR)
@@ -1666,7 +1666,7 @@ static void remove_maybe_stale_table(struct reftable_stack *st, uint64_t max,
 	uint64_t update_idx = 0;
 	struct reftable_block_source src = { NULL };
 	struct reftable_reader *rd = NULL;
-	struct strbuf table_path = STRBUF_INIT;
+	struct reftable_buf table_path = REFTABLE_BUF_INIT;
 	stack_filename(&table_path, st, name);
 
 	err = reftable_block_source_from_file(&src, table_path.buf);
@@ -1684,7 +1684,7 @@ static void remove_maybe_stale_table(struct reftable_stack *st, uint64_t max,
 		unlink(table_path.buf);
 	}
 done:
-	strbuf_release(&table_path);
+	reftable_buf_release(&table_path);
 }
 
 static int reftable_stack_clean_locked(struct reftable_stack *st)
diff --git a/reftable/system.h b/reftable/system.h
index d0cabd5d171..5ec85833434 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -13,7 +13,6 @@ license that can be found in the LICENSE file or at
 
 #include "git-compat-util.h"
 #include "lockfile.h"
-#include "strbuf.h"
 #include "tempfile.h"
 #include "hash.h" /* hash ID, sizes.*/
 #include "dir.h" /* remove_dir_recursively, for tests.*/
diff --git a/reftable/writer.c b/reftable/writer.c
index 031d8149a9c..da6941a78ac 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -115,7 +115,7 @@ static int writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
 	if (w->next == 0)
 		block_start = header_size(writer_version(w));
 
-	strbuf_reset(&w->last_key);
+	reftable_buf_reset(&w->last_key);
 	ret = block_writer_init(&w->block_writer_data, typ, w->block,
 				w->opts.block_size, block_start,
 				hash_size(w->opts.hash_id));
@@ -146,8 +146,8 @@ int reftable_writer_new(struct reftable_writer **out,
 	if (opts.block_size >= (1 << 24))
 		BUG("configured block size exceeds 16MB");
 
-	strbuf_init(&wp->block_writer_data.last_key, 0);
-	strbuf_init(&wp->last_key, 0);
+	reftable_buf_init(&wp->block_writer_data.last_key);
+	reftable_buf_init(&wp->last_key);
 	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
 	if (!wp->block) {
 		reftable_free(wp);
@@ -179,7 +179,7 @@ static void writer_release(struct reftable_writer *w)
 		block_writer_release(&w->block_writer_data);
 		w->block_writer = NULL;
 		writer_clear_index(w);
-		strbuf_release(&w->last_key);
+		reftable_buf_release(&w->last_key);
 	}
 }
 
@@ -190,7 +190,7 @@ void reftable_writer_free(struct reftable_writer *w)
 }
 
 struct obj_index_tree_node {
-	struct strbuf hash;
+	struct reftable_buf hash;
 	uint64_t *offsets;
 	size_t offset_len;
 	size_t offset_cap;
@@ -198,16 +198,16 @@ struct obj_index_tree_node {
 
 #define OBJ_INDEX_TREE_NODE_INIT    \
 	{                           \
-		.hash = STRBUF_INIT \
+		.hash = REFTABLE_BUF_INIT \
 	}
 
 static int obj_index_tree_node_compare(const void *a, const void *b)
 {
-	return strbuf_cmp(&((const struct obj_index_tree_node *)a)->hash,
+	return reftable_buf_cmp(&((const struct obj_index_tree_node *)a)->hash,
 			  &((const struct obj_index_tree_node *)b)->hash);
 }
 
-static int writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
+static int writer_index_hash(struct reftable_writer *w, struct reftable_buf *hash)
 {
 	uint64_t off = w->next;
 	struct obj_index_tree_node want = { .hash = *hash };
@@ -224,8 +224,8 @@ static int writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
 
 		*key = empty;
 
-		strbuf_reset(&key->hash);
-		strbuf_add(&key->hash, hash->buf, hash->len);
+		reftable_buf_reset(&key->hash);
+		reftable_buf_add(&key->hash, hash->buf, hash->len);
 		tree_insert(&w->obj_index_tree, key,
 			    &obj_index_tree_node_compare);
 	} else {
@@ -246,17 +246,17 @@ static int writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
 static int writer_add_record(struct reftable_writer *w,
 			     struct reftable_record *rec)
 {
-	struct strbuf key = STRBUF_INIT;
+	struct reftable_buf key = REFTABLE_BUF_INIT;
 	int err;
 
 	reftable_record_key(rec, &key);
-	if (strbuf_cmp(&w->last_key, &key) >= 0) {
+	if (reftable_buf_cmp(&w->last_key, &key) >= 0) {
 		err = REFTABLE_API_ERROR;
 		goto done;
 	}
 
-	strbuf_reset(&w->last_key);
-	strbuf_add(&w->last_key, key.buf, key.len);
+	reftable_buf_reset(&w->last_key);
+	reftable_buf_add(&w->last_key, key.buf, key.len);
 	if (!w->block_writer) {
 		err = writer_reinit_block_writer(w, reftable_record_type(rec));
 		if (err < 0)
@@ -303,7 +303,7 @@ static int writer_add_record(struct reftable_writer *w,
 	}
 
 done:
-	strbuf_release(&key);
+	reftable_buf_release(&key);
 	return err;
 }
 
@@ -316,7 +316,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 			.ref = *ref
 		},
 	};
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int err;
 
 	if (!ref->refname ||
@@ -331,7 +331,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 		goto out;
 
 	if (!w->opts.skip_index_objects && reftable_ref_record_val1(ref)) {
-		strbuf_add(&buf, (char *)reftable_ref_record_val1(ref),
+		reftable_buf_add(&buf, (char *)reftable_ref_record_val1(ref),
 			   hash_size(w->opts.hash_id));
 
 		err = writer_index_hash(w, &buf);
@@ -340,8 +340,8 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 	}
 
 	if (!w->opts.skip_index_objects && reftable_ref_record_val2(ref)) {
-		strbuf_reset(&buf);
-		strbuf_add(&buf, reftable_ref_record_val2(ref),
+		reftable_buf_reset(&buf);
+		reftable_buf_add(&buf, reftable_ref_record_val2(ref),
 			   hash_size(w->opts.hash_id));
 
 		err = writer_index_hash(w, &buf);
@@ -352,7 +352,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 	err = 0;
 
 out:
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 	return err;
 }
 
@@ -393,7 +393,7 @@ int reftable_writer_add_log(struct reftable_writer *w,
 			    struct reftable_log_record *log)
 {
 	char *input_log_message = NULL;
-	struct strbuf cleaned_message = STRBUF_INIT;
+	struct reftable_buf cleaned_message = REFTABLE_BUF_INIT;
 	int err = 0;
 
 	if (log->value_type == REFTABLE_LOG_DELETION)
@@ -404,24 +404,24 @@ int reftable_writer_add_log(struct reftable_writer *w,
 
 	input_log_message = log->value.update.message;
 	if (!w->opts.exact_log_message && log->value.update.message) {
-		strbuf_addstr(&cleaned_message, log->value.update.message);
+		reftable_buf_addstr(&cleaned_message, log->value.update.message);
 		while (cleaned_message.len &&
 		       cleaned_message.buf[cleaned_message.len - 1] == '\n')
-			strbuf_setlen(&cleaned_message,
+			reftable_buf_setlen(&cleaned_message,
 				      cleaned_message.len - 1);
 		if (strchr(cleaned_message.buf, '\n')) {
 			/* multiple lines not allowed. */
 			err = REFTABLE_API_ERROR;
 			goto done;
 		}
-		strbuf_addstr(&cleaned_message, "\n");
+		reftable_buf_addstr(&cleaned_message, "\n");
 		log->value.update.message = cleaned_message.buf;
 	}
 
 	err = reftable_writer_add_log_verbatim(w, log);
 	log->value.update.message = input_log_message;
 done:
-	strbuf_release(&cleaned_message);
+	reftable_buf_release(&cleaned_message);
 	return err;
 }
 
@@ -504,7 +504,7 @@ static int writer_finish_section(struct reftable_writer *w)
 			return err;
 
 		for (i = 0; i < idx_len; i++)
-			strbuf_release(&idx[i].last_key);
+			reftable_buf_release(&idx[i].last_key);
 		reftable_free(idx);
 	}
 
@@ -521,13 +521,13 @@ static int writer_finish_section(struct reftable_writer *w)
 	bstats->max_index_level = max_level;
 
 	/* Reinit lastKey, as the next section can start with any key. */
-	strbuf_reset(&w->last_key);
+	reftable_buf_reset(&w->last_key);
 
 	return 0;
 }
 
 struct common_prefix_arg {
-	struct strbuf *last;
+	struct reftable_buf *last;
 	int max;
 };
 
@@ -594,7 +594,7 @@ static void object_record_free(void *void_arg UNUSED, void *key)
 	struct obj_index_tree_node *entry = key;
 
 	REFTABLE_FREE_AND_NULL(entry->offsets);
-	strbuf_release(&entry->hash);
+	reftable_buf_release(&entry->hash);
 	reftable_free(entry);
 }
 
@@ -708,7 +708,7 @@ int reftable_writer_close(struct reftable_writer *w)
 static void writer_clear_index(struct reftable_writer *w)
 {
 	for (size_t i = 0; w->index && i < w->index_len; i++)
-		strbuf_release(&w->index[i].last_key);
+		reftable_buf_release(&w->index[i].last_key);
 	REFTABLE_FREE_AND_NULL(w->index);
 	w->index_len = 0;
 	w->index_cap = 0;
@@ -717,7 +717,7 @@ static void writer_clear_index(struct reftable_writer *w)
 static int writer_flush_nonempty_block(struct reftable_writer *w)
 {
 	struct reftable_index_record index_record = {
-		.last_key = STRBUF_INIT,
+		.last_key = REFTABLE_BUF_INIT,
 	};
 	uint8_t typ = block_writer_type(w->block_writer);
 	struct reftable_block_stats *bstats;
@@ -777,8 +777,8 @@ static int writer_flush_nonempty_block(struct reftable_writer *w)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
 
 	index_record.offset = w->next;
-	strbuf_reset(&index_record.last_key);
-	strbuf_add(&index_record.last_key, w->block_writer->last_key.buf,
+	reftable_buf_reset(&index_record.last_key);
+	reftable_buf_add(&index_record.last_key, w->block_writer->last_key.buf,
 		   w->block_writer->last_key.len);
 	w->index[w->index_len] = index_record;
 	w->index_len++;
diff --git a/reftable/writer.h b/reftable/writer.h
index 8d0df9cc528..e8a6fbb7854 100644
--- a/reftable/writer.h
+++ b/reftable/writer.h
@@ -19,7 +19,7 @@ struct reftable_writer {
 	int (*flush)(void *);
 	void *write_arg;
 	int pending_padding;
-	struct strbuf last_key;
+	struct reftable_buf last_key;
 
 	/* offset of next block to write. */
 	uint64_t next;
diff --git a/t/unit-tests/lib-reftable.c b/t/unit-tests/lib-reftable.c
index 54c26c43e77..2ddf480588d 100644
--- a/t/unit-tests/lib-reftable.c
+++ b/t/unit-tests/lib-reftable.c
@@ -19,7 +19,7 @@ static int strbuf_writer_flush(void *arg UNUSED)
 	return 0;
 }
 
-struct reftable_writer *t_reftable_strbuf_writer(struct strbuf *buf,
+struct reftable_writer *t_reftable_strbuf_writer(struct reftable_buf *buf,
 						 struct reftable_write_options *opts)
 {
 	struct reftable_writer *writer;
@@ -29,7 +29,7 @@ struct reftable_writer *t_reftable_strbuf_writer(struct strbuf *buf,
 	return writer;
 }
 
-void t_reftable_write_to_buf(struct strbuf *buf,
+void t_reftable_write_to_buf(struct reftable_buf *buf,
 			     struct reftable_ref_record *refs,
 			     size_t nrefs,
 			     struct reftable_log_record *logs,
diff --git a/t/unit-tests/lib-reftable.h b/t/unit-tests/lib-reftable.h
index d1154190847..d4950fed3da 100644
--- a/t/unit-tests/lib-reftable.h
+++ b/t/unit-tests/lib-reftable.h
@@ -2,15 +2,16 @@
 #define LIB_REFTABLE_H
 
 #include "git-compat-util.h"
-#include "strbuf.h"
 #include "reftable/reftable-writer.h"
 
+struct reftable_buf;
+
 void t_reftable_set_hash(uint8_t *p, int i, uint32_t id);
 
-struct reftable_writer *t_reftable_strbuf_writer(struct strbuf *buf,
+struct reftable_writer *t_reftable_strbuf_writer(struct reftable_buf *buf,
 						 struct reftable_write_options *opts);
 
-void t_reftable_write_to_buf(struct strbuf *buf,
+void t_reftable_write_to_buf(struct reftable_buf *buf,
 			     struct reftable_ref_record *refs,
 			     size_t nrecords,
 			     struct reftable_log_record *logs,
diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index 1fa77b6faff..a814e819756 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -99,8 +99,8 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	}
 
 	if_test ("common_prefix_size works") {
-		struct strbuf a = STRBUF_INIT;
-		struct strbuf b = STRBUF_INIT;
+		struct reftable_buf a = REFTABLE_BUF_INIT;
+		struct reftable_buf b = REFTABLE_BUF_INIT;
 		struct {
 			const char *a, *b;
 			int want;
@@ -113,14 +113,14 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 		};
 
 		for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
-			strbuf_addstr(&a, cases[i].a);
-			strbuf_addstr(&b, cases[i].b);
+			reftable_buf_addstr(&a, cases[i].a);
+			reftable_buf_addstr(&b, cases[i].b);
 			check_int(common_prefix_size(&a, &b), ==, cases[i].want);
-			strbuf_reset(&a);
-			strbuf_reset(&b);
+			reftable_buf_reset(&a);
+			reftable_buf_reset(&b);
 		}
-		strbuf_release(&a);
-		strbuf_release(&b);
+		reftable_buf_release(&a);
+		reftable_buf_release(&b);
 	}
 
 	if_test ("put_be24 and get_be24 work") {
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 8077bbc5e7a..56514b43630 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -20,7 +20,7 @@ static void t_ref_block_read_write(void)
 	const size_t block_size = 1024;
 	struct reftable_block block = { 0 };
 	struct block_writer bw = {
-		.last_key = STRBUF_INIT,
+		.last_key = REFTABLE_BUF_INIT,
 	};
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_REF,
@@ -29,7 +29,7 @@ static void t_ref_block_read_write(void)
 	int ret;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	check(block.data != NULL);
@@ -100,8 +100,8 @@ static void t_ref_block_read_write(void)
 	block_iter_close(&it);
 	reftable_record_release(&rec);
 	reftable_block_done(&br.block);
-	strbuf_release(&want);
-	strbuf_release(&buf);
+	reftable_buf_release(&want);
+	reftable_buf_release(&buf);
 	for (i = 0; i < N; i++)
 		reftable_record_release(&recs[i]);
 }
@@ -114,7 +114,7 @@ static void t_log_block_read_write(void)
 	const size_t block_size = 2048;
 	struct reftable_block block = { 0 };
 	struct block_writer bw = {
-		.last_key = STRBUF_INIT,
+		.last_key = REFTABLE_BUF_INIT,
 	};
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_LOG,
@@ -123,7 +123,7 @@ static void t_log_block_read_write(void)
 	int ret;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	check(block.data != NULL);
@@ -166,8 +166,8 @@ static void t_log_block_read_write(void)
 
 	for (i = 0; i < N; i++) {
 		block_iter_reset(&it);
-		strbuf_reset(&want);
-		strbuf_addstr(&want, recs[i].u.log.refname);
+		reftable_buf_reset(&want);
+		reftable_buf_addstr(&want, recs[i].u.log.refname);
 
 		ret = block_iter_seek_key(&it, &br, &want);
 		check_int(ret, ==, 0);
@@ -190,8 +190,8 @@ static void t_log_block_read_write(void)
 	block_iter_close(&it);
 	reftable_record_release(&rec);
 	reftable_block_done(&br.block);
-	strbuf_release(&want);
-	strbuf_release(&buf);
+	reftable_buf_release(&want);
+	reftable_buf_release(&buf);
 	for (i = 0; i < N; i++)
 		reftable_record_release(&recs[i]);
 }
@@ -204,7 +204,7 @@ static void t_obj_block_read_write(void)
 	const size_t block_size = 1024;
 	struct reftable_block block = { 0 };
 	struct block_writer bw = {
-		.last_key = STRBUF_INIT,
+		.last_key = REFTABLE_BUF_INIT,
 	};
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_OBJ,
@@ -213,7 +213,7 @@ static void t_obj_block_read_write(void)
 	int ret;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	check(block.data != NULL);
@@ -273,8 +273,8 @@ static void t_obj_block_read_write(void)
 	block_iter_close(&it);
 	reftable_record_release(&rec);
 	reftable_block_done(&br.block);
-	strbuf_release(&want);
-	strbuf_release(&buf);
+	reftable_buf_release(&want);
+	reftable_buf_release(&buf);
 	for (i = 0; i < N; i++)
 		reftable_record_release(&recs[i]);
 }
@@ -287,17 +287,17 @@ static void t_index_block_read_write(void)
 	const size_t block_size = 1024;
 	struct reftable_block block = { 0 };
 	struct block_writer bw = {
-		.last_key = STRBUF_INIT,
+		.last_key = REFTABLE_BUF_INIT,
 	};
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_INDEX,
-		.u.idx.last_key = STRBUF_INIT,
+		.u.idx.last_key = REFTABLE_BUF_INIT,
 	};
 	size_t i = 0;
 	int ret;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	check(block.data != NULL);
@@ -312,9 +312,9 @@ static void t_index_block_read_write(void)
 
 		snprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
 
-		strbuf_init(&recs[i].u.idx.last_key, 9);
+		reftable_buf_init(&recs[i].u.idx.last_key);
 		recs[i].type = BLOCK_TYPE_INDEX;
-		strbuf_addstr(&recs[i].u.idx.last_key, buf);
+		reftable_buf_addstr(&recs[i].u.idx.last_key, buf);
 		recs[i].u.idx.offset = i;
 
 		ret = block_writer_add(&bw, &recs[i]);
@@ -365,8 +365,8 @@ static void t_index_block_read_write(void)
 	block_iter_close(&it);
 	reftable_record_release(&rec);
 	reftable_block_done(&br.block);
-	strbuf_release(&want);
-	strbuf_release(&buf);
+	reftable_buf_release(&want);
+	reftable_buf_release(&buf);
 	for (i = 0; i < N; i++)
 		reftable_record_release(&recs[i]);
 }
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 3c84363e980..9b0162a4b32 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -20,7 +20,7 @@ static struct reftable_merged_table *
 merged_table_from_records(struct reftable_ref_record **refs,
 			  struct reftable_block_source **source,
 			  struct reftable_reader ***readers, const size_t *sizes,
-			  struct strbuf *buf, const size_t n)
+			  struct reftable_buf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
 	struct reftable_write_options opts = {
@@ -75,7 +75,7 @@ static void t_merged_single_record(void)
 
 	struct reftable_ref_record *refs[] = { r1, r2, r3 };
 	size_t sizes[] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
-	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
+	struct reftable_buf bufs[3] = { REFTABLE_BUF_INIT, REFTABLE_BUF_INIT, REFTABLE_BUF_INIT };
 	struct reftable_block_source *bs = NULL;
 	struct reftable_reader **readers = NULL;
 	struct reftable_merged_table *mt =
@@ -97,7 +97,7 @@ static void t_merged_single_record(void)
 	readers_destroy(readers, 3);
 	reftable_merged_table_free(mt);
 	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
-		strbuf_release(&bufs[i]);
+		reftable_buf_release(&bufs[i]);
 	reftable_free(bs);
 }
 
@@ -152,7 +152,7 @@ static void t_merged_refs(void)
 
 	struct reftable_ref_record *refs[] = { r1, r2, r3 };
 	size_t sizes[3] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
-	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
+	struct reftable_buf bufs[3] = { REFTABLE_BUF_INIT, REFTABLE_BUF_INIT, REFTABLE_BUF_INIT };
 	struct reftable_block_source *bs = NULL;
 	struct reftable_reader **readers = NULL;
 	struct reftable_merged_table *mt =
@@ -192,7 +192,7 @@ static void t_merged_refs(void)
 	reftable_free(out);
 
 	for (i = 0; i < 3; i++)
-		strbuf_release(&bufs[i]);
+		reftable_buf_release(&bufs[i]);
 	readers_destroy(readers, 3);
 	reftable_merged_table_free(mt);
 	reftable_free(bs);
@@ -234,8 +234,8 @@ static void t_merged_seek_multiple_times(void)
 	size_t sizes[] = {
 		ARRAY_SIZE(r1), ARRAY_SIZE(r2),
 	};
-	struct strbuf bufs[] = {
-		STRBUF_INIT, STRBUF_INIT,
+	struct reftable_buf bufs[] = {
+		REFTABLE_BUF_INIT, REFTABLE_BUF_INIT,
 	};
 	struct reftable_block_source *sources = NULL;
 	struct reftable_reader **readers = NULL;
@@ -265,7 +265,7 @@ static void t_merged_seek_multiple_times(void)
 	}
 
 	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
-		strbuf_release(&bufs[i]);
+		reftable_buf_release(&bufs[i]);
 	readers_destroy(readers, ARRAY_SIZE(refs));
 	reftable_ref_record_release(&rec);
 	reftable_iterator_destroy(&it);
@@ -277,7 +277,7 @@ static struct reftable_merged_table *
 merged_table_from_log_records(struct reftable_log_record **logs,
 			      struct reftable_block_source **source,
 			      struct reftable_reader ***readers, const size_t *sizes,
-			      struct strbuf *buf, const size_t n)
+			      struct reftable_buf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
 	struct reftable_write_options opts = {
@@ -361,7 +361,7 @@ static void t_merged_logs(void)
 
 	struct reftable_log_record *logs[] = { r1, r2, r3 };
 	size_t sizes[3] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
-	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
+	struct reftable_buf bufs[3] = { REFTABLE_BUF_INIT, REFTABLE_BUF_INIT, REFTABLE_BUF_INIT };
 	struct reftable_block_source *bs = NULL;
 	struct reftable_reader **readers = NULL;
 	struct reftable_merged_table *mt = merged_table_from_log_records(
@@ -412,7 +412,7 @@ static void t_merged_logs(void)
 	reftable_free(out);
 
 	for (i = 0; i < 3; i++)
-		strbuf_release(&bufs[i]);
+		reftable_buf_release(&bufs[i]);
 	readers_destroy(readers, 3);
 	reftable_merged_table_free(mt);
 	reftable_free(bs);
@@ -421,7 +421,7 @@ static void t_merged_logs(void)
 static void t_default_write_opts(void)
 {
 	struct reftable_write_options opts = { 0 };
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record rec = {
 		.refname = (char *) "master",
@@ -457,7 +457,7 @@ static void t_default_write_opts(void)
 
 	reftable_reader_decref(rd);
 	reftable_merged_table_free(merged);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 }
 
 
diff --git a/t/unit-tests/t-reftable-reader.c b/t/unit-tests/t-reftable-reader.c
index eea86966c0d..8a18d7f9be4 100644
--- a/t/unit-tests/t-reftable-reader.c
+++ b/t/unit-tests/t-reftable-reader.c
@@ -16,7 +16,7 @@ static int t_reader_seek_once(void)
 	struct reftable_ref_record ref = { 0 };
 	struct reftable_iterator it = { 0 };
 	struct reftable_reader *reader;
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int ret;
 
 	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
@@ -40,7 +40,7 @@ static int t_reader_seek_once(void)
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
 	reftable_reader_decref(reader);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 	return 0;
 }
 
@@ -57,7 +57,7 @@ static int t_reader_reseek(void)
 	struct reftable_ref_record ref = { 0 };
 	struct reftable_iterator it = { 0 };
 	struct reftable_reader *reader;
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int ret;
 
 	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
@@ -84,7 +84,7 @@ static int t_reader_reseek(void)
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
 	reftable_reader_decref(reader);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 	return 0;
 }
 
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 5f59b0ad6ad..c56a33f1a1e 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -18,12 +18,12 @@ static const int update_index = 5;
 
 static void t_buffer(void)
 {
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_block_source source = { 0 };
 	struct reftable_block out = { 0 };
 	int n;
 	uint8_t in[] = "hello";
-	strbuf_add(&buf, in, sizeof(in));
+	reftable_buf_add(&buf, in, sizeof(in));
 	block_source_from_strbuf(&source, &buf);
 	check_int(block_source_size(&source), ==, 6);
 	n = block_source_read_block(&source, &out, 0, sizeof(in));
@@ -37,10 +37,10 @@ static void t_buffer(void)
 
 	reftable_block_done(&out);
 	block_source_close(&source);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 }
 
-static void write_table(char ***names, struct strbuf *buf, int N,
+static void write_table(char ***names, struct reftable_buf *buf, int N,
 			int block_size, uint32_t hash_id)
 {
 	struct reftable_write_options opts = {
@@ -82,7 +82,7 @@ static void write_table(char ***names, struct strbuf *buf, int N,
 
 static void t_log_buffer_size(void)
 {
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_write_options opts = {
 		.block_size = 4096,
 	};
@@ -114,12 +114,12 @@ static void t_log_buffer_size(void)
 	err = reftable_writer_close(w);
 	check(!err);
 	reftable_writer_free(w);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 }
 
 static void t_log_overflow(void)
 {
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	char msg[256] = { 0 };
 	struct reftable_write_options opts = {
 		.block_size = ARRAY_SIZE(msg),
@@ -148,7 +148,7 @@ static void t_log_overflow(void)
 	err = reftable_writer_add_log(w, &log);
 	check_int(err, ==, REFTABLE_ENTRY_TOO_BIG_ERROR);
 	reftable_writer_free(w);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 }
 
 static void t_log_write_read(void)
@@ -161,7 +161,7 @@ static void t_log_write_read(void)
 	struct reftable_iterator it = { 0 };
 	struct reftable_reader *reader;
 	struct reftable_block_source source = { 0 };
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	const struct reftable_stats *stats = NULL;
 	int N = 2, err, i, n;
@@ -247,7 +247,7 @@ static void t_log_write_read(void)
 	reftable_iterator_destroy(&it);
 
 	/* cleanup. */
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 	free_names(names);
 	reftable_reader_decref(reader);
 }
@@ -260,7 +260,7 @@ static void t_log_zlib_corruption(void)
 	struct reftable_iterator it = { 0 };
 	struct reftable_reader *reader;
 	struct reftable_block_source source = { 0 };
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	const struct reftable_stats *stats = NULL;
 	char message[100] = { 0 };
@@ -312,13 +312,13 @@ static void t_log_zlib_corruption(void)
 
 	/* cleanup. */
 	reftable_reader_decref(reader);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 }
 
 static void t_table_read_write_sequential(void)
 {
 	char **names;
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int N = 50;
 	struct reftable_iterator it = { 0 };
 	struct reftable_block_source source = { 0 };
@@ -352,25 +352,25 @@ static void t_table_read_write_sequential(void)
 
 	reftable_iterator_destroy(&it);
 	reftable_reader_decref(reader);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 	free_names(names);
 }
 
 static void t_table_write_small_table(void)
 {
 	char **names;
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int N = 1;
 	write_table(&names, &buf, N, 4096, GIT_SHA1_FORMAT_ID);
 	check_int(buf.len, <, 200);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 	free_names(names);
 }
 
 static void t_table_read_api(void)
 {
 	char **names;
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int N = 50;
 	struct reftable_reader *reader;
 	struct reftable_block_source source = { 0 };
@@ -393,17 +393,17 @@ static void t_table_read_api(void)
 	err = reftable_iterator_next_log(&it, &log);
 	check_int(err, ==, REFTABLE_API_ERROR);
 
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 	free_names(names);
 	reftable_iterator_destroy(&it);
 	reftable_reader_decref(reader);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 }
 
 static void t_table_read_write_seek(int index, int hash_id)
 {
 	char **names;
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int N = 50;
 	struct reftable_reader *reader;
 	struct reftable_block_source source = { 0 };
@@ -411,7 +411,7 @@ static void t_table_read_write_seek(int index, int hash_id)
 	int i = 0;
 
 	struct reftable_iterator it = { 0 };
-	struct strbuf pastLast = STRBUF_INIT;
+	struct reftable_buf pastLast = REFTABLE_BUF_INIT;
 	struct reftable_ref_record ref = { 0 };
 
 	write_table(&names, &buf, N, 256, hash_id);
@@ -443,8 +443,8 @@ static void t_table_read_write_seek(int index, int hash_id)
 		reftable_iterator_destroy(&it);
 	}
 
-	strbuf_addstr(&pastLast, names[N - 1]);
-	strbuf_addstr(&pastLast, "/");
+	reftable_buf_addstr(&pastLast, names[N - 1]);
+	reftable_buf_addstr(&pastLast, "/");
 
 	err = reftable_reader_init_ref_iterator(reader, &it);
 	check(!err);
@@ -457,10 +457,10 @@ static void t_table_read_write_seek(int index, int hash_id)
 		check_int(err, >, 0);
 	}
 
-	strbuf_release(&pastLast);
+	reftable_buf_release(&pastLast);
 	reftable_iterator_destroy(&it);
 
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 	free_names(names);
 	reftable_reader_decref(reader);
 }
@@ -492,7 +492,7 @@ static void t_table_refs_for(int indexed)
 	struct reftable_ref_record ref = { 0 };
 	struct reftable_reader *reader;
 	struct reftable_block_source source = { 0 };
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_iterator it = { 0 };
 	int N = 50, n, j, err, i;
@@ -565,7 +565,7 @@ static void t_table_refs_for(int indexed)
 	}
 	check_int(j, ==, want_names_len);
 
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 	free_names(want_names);
 	reftable_iterator_destroy(&it);
 	reftable_reader_decref(reader);
@@ -584,7 +584,7 @@ static void t_table_refs_for_obj_index(void)
 static void t_write_empty_table(void)
 {
 	struct reftable_write_options opts = { 0 };
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_block_source source = { 0 };
 	struct reftable_reader *rd = NULL;
@@ -615,7 +615,7 @@ static void t_write_empty_table(void)
 
 	reftable_iterator_destroy(&it);
 	reftable_reader_decref(rd);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 }
 
 static void t_write_object_id_min_length(void)
@@ -623,7 +623,7 @@ static void t_write_object_id_min_length(void)
 	struct reftable_write_options opts = {
 		.block_size = 75,
 	};
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record ref = {
 		.update_index = 1,
@@ -649,7 +649,7 @@ static void t_write_object_id_min_length(void)
 	check(!err);
 	check_int(reftable_writer_stats(w)->object_id_len, ==, 2);
 	reftable_writer_free(w);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 }
 
 static void t_write_object_id_length(void)
@@ -657,7 +657,7 @@ static void t_write_object_id_length(void)
 	struct reftable_write_options opts = {
 		.block_size = 75,
 	};
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record ref = {
 		.update_index = 1,
@@ -684,13 +684,13 @@ static void t_write_object_id_length(void)
 	check(!err);
 	check_int(reftable_writer_stats(w)->object_id_len, ==, 16);
 	reftable_writer_free(w);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 }
 
 static void t_write_empty_key(void)
 {
 	struct reftable_write_options opts = { 0 };
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record ref = {
 		.refname = (char *) "",
@@ -706,13 +706,13 @@ static void t_write_empty_key(void)
 	err = reftable_writer_close(w);
 	check_int(err, ==, REFTABLE_EMPTY_TABLE_ERROR);
 	reftable_writer_free(w);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 }
 
 static void t_write_key_order(void)
 {
 	struct reftable_write_options opts = { 0 };
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record refs[2] = {
 		{
@@ -745,7 +745,7 @@ static void t_write_key_order(void)
 
 	reftable_writer_close(w);
 	reftable_writer_free(w);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 }
 
 static void t_write_multiple_indices(void)
@@ -753,7 +753,7 @@ static void t_write_multiple_indices(void)
 	struct reftable_write_options opts = {
 		.block_size = 100,
 	};
-	struct strbuf writer_buf = STRBUF_INIT;
+	struct reftable_buf writer_buf = REFTABLE_BUF_INIT;
 	struct reftable_block_source source = { 0 };
 	struct reftable_iterator it = { 0 };
 	const struct reftable_stats *stats;
@@ -822,7 +822,7 @@ static void t_write_multiple_indices(void)
 	reftable_iterator_destroy(&it);
 	reftable_writer_free(writer);
 	reftable_reader_decref(reader);
-	strbuf_release(&writer_buf);
+	reftable_buf_release(&writer_buf);
 }
 
 static void t_write_multi_level_index(void)
@@ -830,7 +830,7 @@ static void t_write_multi_level_index(void)
 	struct reftable_write_options opts = {
 		.block_size = 100,
 	};
-	struct strbuf writer_buf = STRBUF_INIT, buf = STRBUF_INIT;
+	struct reftable_buf writer_buf = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
 	struct reftable_block_source source = { 0 };
 	struct reftable_iterator it = { 0 };
 	const struct reftable_stats *stats;
@@ -878,13 +878,13 @@ static void t_write_multi_level_index(void)
 	reftable_iterator_destroy(&it);
 	reftable_writer_free(writer);
 	reftable_reader_decref(reader);
-	strbuf_release(&writer_buf);
-	strbuf_release(&buf);
+	reftable_buf_release(&writer_buf);
+	reftable_buf_release(&buf);
 }
 
 static void t_corrupt_table_empty(void)
 {
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_block_source source = { 0 };
 	struct reftable_reader *reader;
 	int err;
@@ -897,17 +897,17 @@ static void t_corrupt_table_empty(void)
 static void t_corrupt_table(void)
 {
 	uint8_t zeros[1024] = { 0 };
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_block_source source = { 0 };
 	struct reftable_reader *reader;
 	int err;
-	strbuf_add(&buf, zeros, sizeof(zeros));
+	reftable_buf_add(&buf, zeros, sizeof(zeros));
 
 	block_source_from_strbuf(&source, &buf);
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 }
 
 int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index a7f67d4d9f2..f2dd01688f3 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -116,7 +116,7 @@ static void t_reftable_ref_record_compare_name(void)
 
 static void t_reftable_ref_record_roundtrip(void)
 {
-	struct strbuf scratch = STRBUF_INIT;
+	struct reftable_buf scratch = REFTABLE_BUF_INIT;
 
 	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
 		struct reftable_record in = {
@@ -124,7 +124,7 @@ static void t_reftable_ref_record_roundtrip(void)
 			.u.ref.value_type = i,
 		};
 		struct reftable_record out = { .type = BLOCK_TYPE_REF };
-		struct strbuf key = STRBUF_INIT;
+		struct reftable_buf key = REFTABLE_BUF_INIT;
 		uint8_t buffer[1024] = { 0 };
 		struct string_view dest = {
 			.buf = buffer,
@@ -166,11 +166,11 @@ static void t_reftable_ref_record_roundtrip(void)
 						 GIT_SHA1_RAWSZ));
 		reftable_record_release(&in);
 
-		strbuf_release(&key);
+		reftable_buf_release(&key);
 		reftable_record_release(&out);
 	}
 
-	strbuf_release(&scratch);
+	reftable_buf_release(&scratch);
 }
 
 static void t_reftable_log_record_comparison(void)
@@ -262,7 +262,7 @@ static void t_reftable_log_record_roundtrip(void)
 			.value_type = REFTABLE_LOG_UPDATE,
 		}
 	};
-	struct strbuf scratch = STRBUF_INIT;
+	struct reftable_buf scratch = REFTABLE_BUF_INIT;
 	set_hash(in[0].value.update.new_hash, 1);
 	set_hash(in[0].value.update.old_hash, 2);
 	set_hash(in[2].value.update.new_hash, 3);
@@ -274,7 +274,7 @@ static void t_reftable_log_record_roundtrip(void)
 
 	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
 		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
-		struct strbuf key = STRBUF_INIT;
+		struct reftable_buf key = REFTABLE_BUF_INIT;
 		uint8_t buffer[1024] = { 0 };
 		struct string_view dest = {
 			.buf = buffer,
@@ -313,11 +313,11 @@ static void t_reftable_log_record_roundtrip(void)
 		check(reftable_log_record_equal(&in[i], &out.u.log,
 						 GIT_SHA1_RAWSZ));
 		reftable_log_record_release(&in[i]);
-		strbuf_release(&key);
+		reftable_buf_release(&key);
 		reftable_record_release(&out);
 	}
 
-	strbuf_release(&scratch);
+	reftable_buf_release(&scratch);
 }
 
 static void t_key_roundtrip(void)
@@ -327,30 +327,30 @@ static void t_key_roundtrip(void)
 		.buf = buffer,
 		.len = sizeof(buffer),
 	};
-	struct strbuf last_key = STRBUF_INIT;
-	struct strbuf key = STRBUF_INIT;
-	struct strbuf roundtrip = STRBUF_INIT;
+	struct reftable_buf last_key = REFTABLE_BUF_INIT;
+	struct reftable_buf key = REFTABLE_BUF_INIT;
+	struct reftable_buf roundtrip = REFTABLE_BUF_INIT;
 	int restart;
 	uint8_t extra;
 	int n, m;
 	uint8_t rt_extra;
 
-	strbuf_addstr(&last_key, "refs/heads/master");
-	strbuf_addstr(&key, "refs/tags/bla");
+	reftable_buf_addstr(&last_key, "refs/heads/master");
+	reftable_buf_addstr(&key, "refs/tags/bla");
 	extra = 6;
 	n = reftable_encode_key(&restart, dest, last_key, key, extra);
 	check(!restart);
 	check_int(n, >, 0);
 
-	strbuf_addstr(&roundtrip, "refs/heads/master");
+	reftable_buf_addstr(&roundtrip, "refs/heads/master");
 	m = reftable_decode_key(&roundtrip, &rt_extra, dest);
 	check_int(n, ==, m);
-	check(!strbuf_cmp(&key, &roundtrip));
+	check(!reftable_buf_cmp(&key, &roundtrip));
 	check_int(rt_extra, ==, extra);
 
-	strbuf_release(&last_key);
-	strbuf_release(&key);
-	strbuf_release(&roundtrip);
+	reftable_buf_release(&last_key);
+	reftable_buf_release(&key);
+	reftable_buf_release(&roundtrip);
 }
 
 static void t_reftable_obj_record_comparison(void)
@@ -413,7 +413,7 @@ static void t_reftable_obj_record_roundtrip(void)
 			.hash_prefix_len = 5,
 		},
 	};
-	struct strbuf scratch = STRBUF_INIT;
+	struct reftable_buf scratch = REFTABLE_BUF_INIT;
 
 	for (size_t i = 0; i < ARRAY_SIZE(recs); i++) {
 		uint8_t buffer[1024] = { 0 };
@@ -427,7 +427,7 @@ static void t_reftable_obj_record_roundtrip(void)
 				.obj = recs[i],
 			},
 		};
-		struct strbuf key = STRBUF_INIT;
+		struct reftable_buf key = REFTABLE_BUF_INIT;
 		struct reftable_record out = { .type = BLOCK_TYPE_OBJ };
 		int n, m;
 		uint8_t extra;
@@ -443,11 +443,11 @@ static void t_reftable_obj_record_roundtrip(void)
 		check_int(n, ==, m);
 
 		check(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
-		strbuf_release(&key);
+		reftable_buf_release(&key);
 		reftable_record_release(&out);
 	}
 
-	strbuf_release(&scratch);
+	reftable_buf_release(&scratch);
 }
 
 static void t_reftable_index_record_comparison(void)
@@ -456,22 +456,22 @@ static void t_reftable_index_record_comparison(void)
 		{
 			.type = BLOCK_TYPE_INDEX,
 			.u.idx.offset = 22,
-			.u.idx.last_key = STRBUF_INIT,
+			.u.idx.last_key = REFTABLE_BUF_INIT,
 		},
 		{
 			.type = BLOCK_TYPE_INDEX,
 			.u.idx.offset = 32,
-			.u.idx.last_key = STRBUF_INIT,
+			.u.idx.last_key = REFTABLE_BUF_INIT,
 		},
 		{
 			.type = BLOCK_TYPE_INDEX,
 			.u.idx.offset = 32,
-			.u.idx.last_key = STRBUF_INIT,
+			.u.idx.last_key = REFTABLE_BUF_INIT,
 		},
 	};
-	strbuf_addstr(&in[0].u.idx.last_key, "refs/heads/master");
-	strbuf_addstr(&in[1].u.idx.last_key, "refs/heads/master");
-	strbuf_addstr(&in[2].u.idx.last_key, "refs/heads/branch");
+	reftable_buf_addstr(&in[0].u.idx.last_key, "refs/heads/master");
+	reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master");
+	reftable_buf_addstr(&in[2].u.idx.last_key, "refs/heads/branch");
 
 	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
 	check(!reftable_record_cmp(&in[0], &in[1]));
@@ -493,7 +493,7 @@ static void t_reftable_index_record_roundtrip(void)
 		.type = BLOCK_TYPE_INDEX,
 		.u.idx = {
 			.offset = 42,
-			.last_key = STRBUF_INIT,
+			.last_key = REFTABLE_BUF_INIT,
 		},
 	};
 	uint8_t buffer[1024] = { 0 };
@@ -501,21 +501,21 @@ static void t_reftable_index_record_roundtrip(void)
 		.buf = buffer,
 		.len = sizeof(buffer),
 	};
-	struct strbuf scratch = STRBUF_INIT;
-	struct strbuf key = STRBUF_INIT;
+	struct reftable_buf scratch = REFTABLE_BUF_INIT;
+	struct reftable_buf key = REFTABLE_BUF_INIT;
 	struct reftable_record out = {
 		.type = BLOCK_TYPE_INDEX,
-		.u.idx = { .last_key = STRBUF_INIT },
+		.u.idx = { .last_key = REFTABLE_BUF_INIT },
 	};
 	int n, m;
 	uint8_t extra;
 
-	strbuf_addstr(&in.u.idx.last_key, "refs/heads/master");
+	reftable_buf_addstr(&in.u.idx.last_key, "refs/heads/master");
 	reftable_record_key(&in, &key);
 	t_copy(&in);
 
 	check(!reftable_record_is_deletion(&in));
-	check(!strbuf_cmp(&key, &in.u.idx.last_key));
+	check(!reftable_buf_cmp(&key, &in.u.idx.last_key));
 	n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
 	check_int(n, >, 0);
 
@@ -527,9 +527,9 @@ static void t_reftable_index_record_roundtrip(void)
 	check(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
 
 	reftable_record_release(&out);
-	strbuf_release(&key);
-	strbuf_release(&scratch);
-	strbuf_release(&in.u.idx.last_key);
+	reftable_buf_release(&key);
+	reftable_buf_release(&scratch);
+	reftable_buf_release(&in.u.idx.last_key);
 }
 
 int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index b56ea774312..f49856270d6 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -16,7 +16,7 @@ license that can be found in the LICENSE file or at
 
 static void clear_dir(const char *dirname)
 {
-	struct strbuf path = STRBUF_INIT;
+	struct strbuf path = REFTABLE_BUF_INIT;
 	strbuf_addstr(&path, dirname);
 	remove_dir_recursively(&path, 0);
 	strbuf_release(&path);
@@ -145,7 +145,7 @@ static int write_test_log(struct reftable_writer *wr, void *arg)
 static void t_reftable_stack_add_one(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
-	struct strbuf scratch = STRBUF_INIT;
+	struct reftable_buf scratch = REFTABLE_BUF_INIT;
 	int mask = umask(002);
 	struct reftable_write_options opts = {
 		.default_permissions = 0660,
@@ -172,17 +172,17 @@ static void t_reftable_stack_add_one(void)
 	check_int(st->readers_len, >, 0);
 
 #ifndef GIT_WINDOWS_NATIVE
-	strbuf_addstr(&scratch, dir);
-	strbuf_addstr(&scratch, "/tables.list");
+	reftable_buf_addstr(&scratch, dir);
+	reftable_buf_addstr(&scratch, "/tables.list");
 	err = stat(scratch.buf, &stat_result);
 	check(!err);
 	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
 
-	strbuf_reset(&scratch);
-	strbuf_addstr(&scratch, dir);
-	strbuf_addstr(&scratch, "/");
+	reftable_buf_reset(&scratch);
+	reftable_buf_addstr(&scratch, dir);
+	reftable_buf_addstr(&scratch, "/");
 	/* do not try at home; not an external API for reftable. */
-	strbuf_addstr(&scratch, st->readers[0]->name);
+	reftable_buf_addstr(&scratch, st->readers[0]->name);
 	err = stat(scratch.buf, &stat_result);
 	check(!err);
 	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
@@ -192,7 +192,7 @@ static void t_reftable_stack_add_one(void)
 
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
-	strbuf_release(&scratch);
+	reftable_buf_release(&scratch);
 	clear_dir(dir);
 	umask(mask);
 }
@@ -414,7 +414,7 @@ static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 	};
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st;
-	struct strbuf table_path = STRBUF_INIT;
+	struct reftable_buf table_path = REFTABLE_BUF_INIT;
 	char *dir = get_tmp_dir(__LINE__);
 	int err;
 
@@ -432,10 +432,10 @@ static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 	 * Adding a new table to the stack should not be impacted by this, even
 	 * though auto-compaction will now fail.
 	 */
-	strbuf_addstr(&table_path, dir);
-	strbuf_addstr(&table_path, "/");
-	strbuf_addstr(&table_path, st->readers[0]->name);
-	strbuf_addstr(&table_path, ".lock");
+	reftable_buf_addstr(&table_path, dir);
+	reftable_buf_addstr(&table_path, "/");
+	reftable_buf_addstr(&table_path, st->readers[0]->name);
+	reftable_buf_addstr(&table_path, ".lock");
 	write_file_buf(table_path.buf, "", 0);
 
 	ref.update_index = 2;
@@ -446,7 +446,7 @@ static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 	check_int(st->stats.failures, ==, 1);
 
 	reftable_stack_destroy(st);
-	strbuf_release(&table_path);
+	reftable_buf_release(&table_path);
 	clear_dir(dir);
 }
 
@@ -516,7 +516,7 @@ static void t_reftable_stack_add(void)
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_ref_record refs[2] = { 0 };
 	struct reftable_log_record logs[2] = { 0 };
-	struct strbuf path = STRBUF_INIT;
+	struct reftable_buf path = REFTABLE_BUF_INIT;
 	struct stat stat_result;
 	size_t i, N = ARRAY_SIZE(refs);
 
@@ -575,17 +575,17 @@ static void t_reftable_stack_add(void)
 	}
 
 #ifndef GIT_WINDOWS_NATIVE
-	strbuf_addstr(&path, dir);
-	strbuf_addstr(&path, "/tables.list");
+	reftable_buf_addstr(&path, dir);
+	reftable_buf_addstr(&path, "/tables.list");
 	err = stat(path.buf, &stat_result);
 	check(!err);
 	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
 
-	strbuf_reset(&path);
-	strbuf_addstr(&path, dir);
-	strbuf_addstr(&path, "/");
+	reftable_buf_reset(&path);
+	reftable_buf_addstr(&path, dir);
+	reftable_buf_addstr(&path, "/");
 	/* do not try at home; not an external API for reftable. */
-	strbuf_addstr(&path, st->readers[0]->name);
+	reftable_buf_addstr(&path, st->readers[0]->name);
 	err = stat(path.buf, &stat_result);
 	check(!err);
 	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
@@ -599,7 +599,7 @@ static void t_reftable_stack_add(void)
 		reftable_ref_record_release(&refs[i]);
 		reftable_log_record_release(&logs[i]);
 	}
-	strbuf_release(&path);
+	reftable_buf_release(&path);
 	clear_dir(dir);
 }
 
@@ -1063,7 +1063,7 @@ static void t_reftable_stack_auto_compaction_with_locked_tables(void)
 		.disable_auto_compact = 1,
 	};
 	struct reftable_stack *st = NULL;
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	char *dir = get_tmp_dir(__LINE__);
 	int err;
 
@@ -1078,10 +1078,10 @@ static void t_reftable_stack_auto_compaction_with_locked_tables(void)
 	 * size, we expect that auto-compaction will want to compact all of the
 	 * tables. Locking any of the tables will keep it from doing so.
 	 */
-	strbuf_addstr(&buf, dir);
-	strbuf_addstr(&buf, "/");
-	strbuf_addstr(&buf, st->readers[2]->name);
-	strbuf_addstr(&buf, ".lock");
+	reftable_buf_addstr(&buf, dir);
+	reftable_buf_addstr(&buf, "/");
+	reftable_buf_addstr(&buf, st->readers[2]->name);
+	reftable_buf_addstr(&buf, ".lock");
 	write_file_buf(buf.buf, "", 0);
 
 	/*
@@ -1096,7 +1096,7 @@ static void t_reftable_stack_auto_compaction_with_locked_tables(void)
 	check_int(st->merged->readers_len, ==, 4);
 
 	reftable_stack_destroy(st);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 	clear_dir(dir);
 }
 
@@ -1153,7 +1153,7 @@ static void t_reftable_stack_compaction_with_locked_tables(void)
 		.disable_auto_compact = 1,
 	};
 	struct reftable_stack *st = NULL;
-	struct strbuf buf = STRBUF_INIT;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	char *dir = get_tmp_dir(__LINE__);
 	int err;
 
@@ -1164,10 +1164,10 @@ static void t_reftable_stack_compaction_with_locked_tables(void)
 	check_int(st->merged->readers_len, ==, 3);
 
 	/* Lock one of the tables that we're about to compact. */
-	strbuf_addstr(&buf, dir);
-	strbuf_addstr(&buf, "/");
-	strbuf_addstr(&buf, st->readers[1]->name);
-	strbuf_addstr(&buf, ".lock");
+	reftable_buf_addstr(&buf, dir);
+	reftable_buf_addstr(&buf, "/");
+	reftable_buf_addstr(&buf, st->readers[1]->name);
+	reftable_buf_addstr(&buf, ".lock");
 	write_file_buf(buf.buf, "", 0);
 
 	/*
@@ -1180,7 +1180,7 @@ static void t_reftable_stack_compaction_with_locked_tables(void)
 	check_int(st->merged->readers_len, ==, 3);
 
 	reftable_stack_destroy(st);
-	strbuf_release(&buf);
+	reftable_buf_release(&buf);
 	clear_dir(dir);
 }
 
@@ -1306,7 +1306,7 @@ static void t_reftable_stack_reload_with_missing_table(void)
 	struct reftable_stack *st = NULL;
 	struct reftable_ref_record rec = { 0 };
 	struct reftable_iterator it = { 0 };
-	struct strbuf table_path = STRBUF_INIT, content = STRBUF_INIT;
+	struct reftable_buf table_path = REFTABLE_BUF_INIT, content = REFTABLE_BUF_INIT;
 	char *dir = get_tmp_dir(__LINE__);
 	int err;
 
@@ -1324,13 +1324,13 @@ static void t_reftable_stack_reload_with_missing_table(void)
 	 * our old readers. This should trigger a partial reload of the stack,
 	 * where we try to reuse our old readers.
 	*/
-	strbuf_addstr(&content, st->readers[0]->name);
-	strbuf_addstr(&content, "\n");
-	strbuf_addstr(&content, st->readers[1]->name);
-	strbuf_addstr(&content, "\n");
-	strbuf_addstr(&content, "garbage\n");
-	strbuf_addstr(&table_path, st->list_file);
-	strbuf_addstr(&table_path, ".lock");
+	reftable_buf_addstr(&content, st->readers[0]->name);
+	reftable_buf_addstr(&content, "\n");
+	reftable_buf_addstr(&content, st->readers[1]->name);
+	reftable_buf_addstr(&content, "\n");
+	reftable_buf_addstr(&content, "garbage\n");
+	reftable_buf_addstr(&table_path, st->list_file);
+	reftable_buf_addstr(&table_path, ".lock");
 	write_file_buf(table_path.buf, content.buf, content.len);
 	err = rename(table_path.buf, st->list_file);
 	check(!err);
@@ -1355,8 +1355,8 @@ static void t_reftable_stack_reload_with_missing_table(void)
 	reftable_ref_record_release(&rec);
 	reftable_iterator_destroy(&it);
 	reftable_stack_destroy(st);
-	strbuf_release(&table_path);
-	strbuf_release(&content);
+	reftable_buf_release(&table_path);
+	reftable_buf_release(&content);
 	clear_dir(dir);
 }
 
-- 
2.47.0.dirty

