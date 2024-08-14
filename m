Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A1D1AED58
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641776; cv=none; b=S550NyJeG1lzV9yVDbo2XI2oBnZSe1Hc3EigwrBhjz7vaRNMf7I4c1ydvcIT3KAZyXqo7ySwj6G7LEcOdOMxX4G1Hga4eskM+Lz6NtgIvZ5qhILZ1Wttc7a8xPRWdKwTaF1k0TcFYja2qsHMVBS81eUR/MxahlqtmW2lRtXDMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641776; c=relaxed/simple;
	bh=Mhwge3xFJBXNESpNv8E1WB4VbEiluGJkK9PCYRj6xEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgvyxeXdRQ6/bn2Wi8VVEHTha+BdOws8VALQARH7u8RxMOkmyLF2m4m6LDZHM3DO5y38gba9POZ2AUlhTySa/F+0VVEpYZLGQr/P/hUBAHH6zWyPUaQxv70pk9Ldc2NYRejJ8RydQLiauFmKCE7NOwN9k6WS3cYWgL+M/eIh5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e0616U3I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e2G0GAQu; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e0616U3I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e2G0GAQu"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 36422114AA77;
	Wed, 14 Aug 2024 09:22:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 14 Aug 2024 09:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641773; x=1723728173; bh=p75PYTHWih
	BwWHhm6Bla7LK/qR6/OmQezxH65fLHq+I=; b=e0616U3I0cVtY/o8dCWxeIhxWB
	1X1aTv33WgxSOpnftV/BW+TuO87uCvysHUV5nJ09Rglefh1Y63WKC4T5Rg0MPDUx
	JyRk5Qy7Rr2RrKykaJwx5SpVvKfqWliqyLdggKPFr6VMPGC40bjVDr4dBumi8iYh
	+3uwA6J0sb9O6u+IsuI+6TjDY91SGB/SOFfcczoYZrjsoVBWvJ7sCrslvjzMYzeb
	/ncZ+tMiUBQZkBNA4s3ebC4UwE/ycu4RSh1Y9F5KTaRK2b9xVLJ93WpPK5rKwCKw
	CWR+OjxruxWSZIDI/KbpuVwweHoSvlnn56JQJ/zgSCqpWvir+6uLw8URvqPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641773; x=1723728173; bh=p75PYTHWihBwWHhm6Bla7LK/qR6/
	OmQezxH65fLHq+I=; b=e2G0GAQuv2R7HS3J6aTFTbhXz8uFsB81c8nLSX6vWGwE
	t7FbD0Pe1RZ5Tox8ZusN3Vprz90sERpNfEZnw/gLBtiVT3kzaNIuzbg8mXLsx8v+
	3pzqF/LQQnhXesLVsz/6kidftE0fY2fuXFYg52nP+grZ0YMZ/pqjIQGj4FLlszce
	x1GbluFg9exTTZyfa6OSK4aiFqphbxv5cMrDbXQw37Gs0TOfBhAJ+FPwWfhiLf7I
	2KToUsID0xOSDk/F1/tyhtHsfvKvIuOGdcO0xbvo0zoE3cweIsJs14fA3Wo5X3gF
	yTfX2ipBdjZyHdmXRwjlAsOLgzU+P/SImoifJIeBsg==
X-ME-Sender: <xms:ra-8ZqCBK_SS8nO89npx_MBu0nrVYuzu66hg3d5iupHrGKKt5c2EEQ>
    <xme:ra-8ZkgNcpQe0RApibNPQKQR5fXV_8mJ3GcbN81Rni4BX84cinb9VrEkz6tZBoHai
    2N9DZoH2-zQDp_ESQ>
X-ME-Received: <xmr:ra-8ZtmvPlIXjTwA3oRkyV1r6KWGusQ4Rwb5KcrCgZRKpncJhAirQYbKd_YH7cD2VS2r6LmfXNrpCWOdv3hkYbqdXc7UZdUQubozmteUfCzXpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ra-8ZoxBneWC3QJejTZ7k2nB2TczbKCQolUHGhWAjP0vdso2bD0eCQ>
    <xmx:ra-8ZvR0LB6awNfPG28U2rAd7_0we0tXUP2jBT3Dbexq82Lb5q7RYg>
    <xmx:ra-8Zjag17NIL7H8gd_AVzPzrjHbuJLMqgjIaTudKfrcby47ytnPEw>
    <xmx:ra-8ZoRMJUUc9wa48g3mBp9tPB1OxvMzLy1paj8fzYVl9VNDdGXJow>
    <xmx:ra-8ZqesbbBtTgupBN0MikcrKvNU8iVpuoEYWf-PBHItY6m50wl9gaLE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:22:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d3730906 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:22:33 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:22:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 03/15] reftable/merged: stop using generic tables in the
 merged table
Message-ID: <58e91ab4b3415bb1fade8183964fcedd39eb6e4b.1723640107.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723640107.git.ps@pks.im>

The merged table provides access to a reftable stack by merging the
contents of those tables into a virtual table. These subtables are being
tracked via `struct reftable_table`, which is a generic interface for
accessing either a single reftable or a merged reftable. So in theory,
it would be possible for the merged table to merge together other merged
tables.

This is somewhat nonsensical though: we only ever set up a merged table
over normal reftables, and there is no reason to do otherwise. This
generic interface thus makes the code way harder to follow and reason
about than really necessary. The abstraction layer may also have an
impact on performance, even though the extra set of vtable function
calls probably doesn't really matter.

Refactor the merged tables to use a `struct reftable_reader` for each of
the subtables instead, which gives us direct access to the underlying
tables. Adjust names accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c                | 28 +++++++++----------
 reftable/merged.h                |  4 +--
 reftable/reader.c                |  6 ++--
 reftable/reader.h                |  4 +++
 reftable/reftable-merged.h       |  7 +++--
 reftable/stack.c                 | 48 ++++++++++++--------------------
 reftable/stack_test.c            | 22 +++++++--------
 t/unit-tests/t-reftable-merged.c | 16 +++--------
 8 files changed, 60 insertions(+), 75 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 25d414ec41..2e72eab306 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -11,6 +11,7 @@ license that can be found in the LICENSE file or at
 #include "constants.h"
 #include "iter.h"
 #include "pq.h"
+#include "reader.h"
 #include "record.h"
 #include "generic.h"
 #include "reftable-merged.h"
@@ -25,7 +26,7 @@ struct merged_subiter {
 struct merged_iter {
 	struct merged_subiter *subiters;
 	struct merged_iter_pqueue pq;
-	size_t stack_len;
+	size_t subiters_len;
 	int suppress_deletions;
 	ssize_t advance_index;
 };
@@ -38,12 +39,12 @@ static void merged_iter_init(struct merged_iter *mi,
 	mi->advance_index = -1;
 	mi->suppress_deletions = mt->suppress_deletions;
 
-	REFTABLE_CALLOC_ARRAY(mi->subiters, mt->stack_len);
-	for (size_t i = 0; i < mt->stack_len; i++) {
+	REFTABLE_CALLOC_ARRAY(mi->subiters, mt->readers_len);
+	for (size_t i = 0; i < mt->readers_len; i++) {
 		reftable_record_init(&mi->subiters[i].rec, typ);
-		table_init_iter(&mt->stack[i], &mi->subiters[i].iter, typ);
+		reader_init_iter(mt->readers[i], &mi->subiters[i].iter, typ);
 	}
-	mi->stack_len = mt->stack_len;
+	mi->subiters_len = mt->readers_len;
 }
 
 static void merged_iter_close(void *p)
@@ -51,7 +52,7 @@ static void merged_iter_close(void *p)
 	struct merged_iter *mi = p;
 
 	merged_iter_pqueue_release(&mi->pq);
-	for (size_t i = 0; i < mi->stack_len; i++) {
+	for (size_t i = 0; i < mi->subiters_len; i++) {
 		reftable_iterator_destroy(&mi->subiters[i].iter);
 		reftable_record_release(&mi->subiters[i].rec);
 	}
@@ -80,7 +81,7 @@ static int merged_iter_seek(struct merged_iter *mi, struct reftable_record *want
 
 	mi->advance_index = -1;
 
-	for (size_t i = 0; i < mi->stack_len; i++) {
+	for (size_t i = 0; i < mi->subiters_len; i++) {
 		err = iterator_seek(&mi->subiters[i].iter, want);
 		if (err < 0)
 			return err;
@@ -193,7 +194,7 @@ static void iterator_from_merged_iter(struct reftable_iterator *it,
 }
 
 int reftable_merged_table_new(struct reftable_merged_table **dest,
-			      struct reftable_table *stack, size_t n,
+			      struct reftable_reader **readers, size_t n,
 			      uint32_t hash_id)
 {
 	struct reftable_merged_table *m = NULL;
@@ -201,10 +202,10 @@ int reftable_merged_table_new(struct reftable_merged_table **dest,
 	uint64_t first_min = 0;
 
 	for (size_t i = 0; i < n; i++) {
-		uint64_t min = reftable_table_min_update_index(&stack[i]);
-		uint64_t max = reftable_table_max_update_index(&stack[i]);
+		uint64_t min = reftable_reader_min_update_index(readers[i]);
+		uint64_t max = reftable_reader_max_update_index(readers[i]);
 
-		if (reftable_table_hash_id(&stack[i]) != hash_id) {
+		if (reftable_reader_hash_id(readers[i]) != hash_id) {
 			return REFTABLE_FORMAT_ERROR;
 		}
 		if (i == 0 || min < first_min) {
@@ -216,8 +217,8 @@ int reftable_merged_table_new(struct reftable_merged_table **dest,
 	}
 
 	REFTABLE_CALLOC_ARRAY(m, 1);
-	m->stack = stack;
-	m->stack_len = n;
+	m->readers = readers;
+	m->readers_len = n;
 	m->min = first_min;
 	m->max = last_max;
 	m->hash_id = hash_id;
@@ -229,7 +230,6 @@ void reftable_merged_table_free(struct reftable_merged_table *mt)
 {
 	if (!mt)
 		return;
-	FREE_AND_NULL(mt->stack);
 	reftable_free(mt);
 }
 
diff --git a/reftable/merged.h b/reftable/merged.h
index 2efe571da6..de5fd33f01 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -12,8 +12,8 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 
 struct reftable_merged_table {
-	struct reftable_table *stack;
-	size_t stack_len;
+	struct reftable_reader **readers;
+	size_t readers_len;
 	uint32_t hash_id;
 
 	/* If unset, produce deletions. This is useful for compaction. For the
diff --git a/reftable/reader.c b/reftable/reader.c
index 29c99e2269..f7ae35da72 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -605,9 +605,9 @@ static void iterator_from_table_iter(struct reftable_iterator *it,
 	it->ops = &table_iter_vtable;
 }
 
-static void reader_init_iter(struct reftable_reader *r,
-			     struct reftable_iterator *it,
-			     uint8_t typ)
+void reader_init_iter(struct reftable_reader *r,
+		      struct reftable_iterator *it,
+		      uint8_t typ)
 {
 	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
 
diff --git a/reftable/reader.h b/reftable/reader.h
index e869165f23..a2c204d523 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -57,6 +57,10 @@ int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
 void reader_close(struct reftable_reader *r);
 const char *reader_name(struct reftable_reader *r);
 
+void reader_init_iter(struct reftable_reader *r,
+		      struct reftable_iterator *it,
+		      uint8_t typ);
+
 /* initialize a block reader to read from `r` */
 int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
 			     uint64_t next_off, uint8_t want_typ);
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index 72762483b9..03c2619c0f 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -28,13 +28,14 @@ struct reftable_merged_table;
 
 /* A generic reftable; see below. */
 struct reftable_table;
+struct reftable_reader;
 
 /*
- * reftable_merged_table_new creates a new merged table. It takes ownership of
- * the stack array.
+ * reftable_merged_table_new creates a new merged table. The readers must be
+ * kept alive as long as the merged table is still in use.
  */
 int reftable_merged_table_new(struct reftable_merged_table **dest,
-			      struct reftable_table *stack, size_t n,
+			      struct reftable_reader **readers, size_t n,
 			      uint32_t hash_id);
 
 /* Initialize a merged table iterator for reading refs. */
diff --git a/reftable/stack.c b/reftable/stack.c
index 64c7fdf8c4..7f4e267ea9 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -225,13 +225,11 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 				      const char **names,
 				      int reuse_open)
 {
-	size_t cur_len = !st->merged ? 0 : st->merged->stack_len;
+	size_t cur_len = !st->merged ? 0 : st->merged->readers_len;
 	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
 	size_t names_len = names_length(names);
 	struct reftable_reader **new_readers =
 		reftable_calloc(names_len, sizeof(*new_readers));
-	struct reftable_table *new_tables =
-		reftable_calloc(names_len, sizeof(*new_tables));
 	size_t new_readers_len = 0;
 	struct reftable_merged_table *new_merged = NULL;
 	struct strbuf table_path = STRBUF_INIT;
@@ -267,17 +265,15 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 		}
 
 		new_readers[new_readers_len] = rd;
-		reftable_table_from_reader(&new_tables[new_readers_len], rd);
 		new_readers_len++;
 	}
 
 	/* success! */
-	err = reftable_merged_table_new(&new_merged, new_tables,
+	err = reftable_merged_table_new(&new_merged, new_readers,
 					new_readers_len, st->opts.hash_id);
 	if (err < 0)
 		goto done;
 
-	new_tables = NULL;
 	st->readers_len = new_readers_len;
 	if (st->merged)
 		reftable_merged_table_free(st->merged);
@@ -309,7 +305,6 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 		reftable_reader_free(new_readers[i]);
 	}
 	reftable_free(new_readers);
-	reftable_free(new_tables);
 	reftable_free(cur);
 	strbuf_release(&table_path);
 	return err;
@@ -520,7 +515,7 @@ static int stack_uptodate(struct reftable_stack *st)
 		}
 	}
 
-	if (names[st->merged->stack_len]) {
+	if (names[st->merged->readers_len]) {
 		err = 1;
 		goto done;
 	}
@@ -659,7 +654,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 	if (add->new_tables_len == 0)
 		goto done;
 
-	for (i = 0; i < add->stack->merged->stack_len; i++) {
+	for (i = 0; i < add->stack->merged->readers_len; i++) {
 		strbuf_addstr(&table_list, add->stack->readers[i]->name);
 		strbuf_addstr(&table_list, "\n");
 	}
@@ -839,7 +834,7 @@ int reftable_addition_add(struct reftable_addition *add,
 
 uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
 {
-	int sz = st->merged->stack_len;
+	int sz = st->merged->readers_len;
 	if (sz > 0)
 		return reftable_reader_max_update_index(st->readers[sz - 1]) +
 		       1;
@@ -906,30 +901,23 @@ static int stack_write_compact(struct reftable_stack *st,
 			       size_t first, size_t last,
 			       struct reftable_log_expiry_config *config)
 {
-	size_t subtabs_len = last - first + 1;
-	struct reftable_table *subtabs = reftable_calloc(
-		last - first + 1, sizeof(*subtabs));
 	struct reftable_merged_table *mt = NULL;
 	struct reftable_iterator it = { NULL };
 	struct reftable_ref_record ref = { NULL };
 	struct reftable_log_record log = { NULL };
+	size_t subtabs_len = last - first + 1;
 	uint64_t entries = 0;
 	int err = 0;
 
-	for (size_t i = first, j = 0; i <= last; i++) {
-		struct reftable_reader *t = st->readers[i];
-		reftable_table_from_reader(&subtabs[j++], t);
-		st->stats.bytes += t->size;
-	}
+	for (size_t i = first; i <= last; i++)
+		st->stats.bytes += st->readers[i]->size;
 	reftable_writer_set_limits(wr, st->readers[first]->min_update_index,
 				   st->readers[last]->max_update_index);
 
-	err = reftable_merged_table_new(&mt, subtabs, subtabs_len,
+	err = reftable_merged_table_new(&mt, st->readers + first, subtabs_len,
 					st->opts.hash_id);
-	if (err < 0) {
-		reftable_free(subtabs);
+	if (err < 0)
 		goto done;
-	}
 
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
 	err = reftable_iterator_seek_ref(&it, "");
@@ -1207,7 +1195,7 @@ static int stack_compact_range(struct reftable_stack *st,
 			 * have compacted them.
 			 */
 			for (size_t j = 1; j < last - first + 1; j++) {
-				const char *old = first + j < st->merged->stack_len ?
+				const char *old = first + j < st->merged->readers_len ?
 					st->readers[first + j]->name : NULL;
 				const char *new = names[i + j];
 
@@ -1248,10 +1236,10 @@ static int stack_compact_range(struct reftable_stack *st,
 		 * `fd_read_lines()` uses a `NULL` sentinel to indicate that
 		 * the array is at its end. As we use `free_names()` to free
 		 * the array, we need to include this sentinel value here and
-		 * thus have to allocate `stack_len + 1` many entries.
+		 * thus have to allocate `readers_len + 1` many entries.
 		 */
-		REFTABLE_CALLOC_ARRAY(names, st->merged->stack_len + 1);
-		for (size_t i = 0; i < st->merged->stack_len; i++)
+		REFTABLE_CALLOC_ARRAY(names, st->merged->readers_len + 1);
+		for (size_t i = 0; i < st->merged->readers_len; i++)
 			names[i] = xstrdup(st->readers[i]->name);
 		first_to_replace = first;
 		last_to_replace = last;
@@ -1358,7 +1346,7 @@ static int stack_compact_range_stats(struct reftable_stack *st,
 int reftable_stack_compact_all(struct reftable_stack *st,
 			       struct reftable_log_expiry_config *config)
 {
-	size_t last = st->merged->stack_len ? st->merged->stack_len - 1 : 0;
+	size_t last = st->merged->readers_len ? st->merged->readers_len - 1 : 0;
 	return stack_compact_range_stats(st, 0, last, config, 0);
 }
 
@@ -1449,9 +1437,9 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
 	int overhead = header_size(version) - 1;
 	uint64_t *sizes;
 
-	REFTABLE_CALLOC_ARRAY(sizes, st->merged->stack_len);
+	REFTABLE_CALLOC_ARRAY(sizes, st->merged->readers_len);
 
-	for (size_t i = 0; i < st->merged->stack_len; i++)
+	for (size_t i = 0; i < st->merged->readers_len; i++)
 		sizes[i] = st->readers[i]->size - overhead;
 
 	return sizes;
@@ -1461,7 +1449,7 @@ int reftable_stack_auto_compact(struct reftable_stack *st)
 {
 	uint64_t *sizes = stack_table_sizes_for_compaction(st);
 	struct segment seg =
-		suggest_compaction_segment(sizes, st->merged->stack_len,
+		suggest_compaction_segment(sizes, st->merged->readers_len,
 					   st->opts.auto_compaction_factor);
 	reftable_free(sizes);
 	if (segment_size(&seg) > 0)
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 8c36590ff0..dbca9eaf4a 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -347,9 +347,9 @@ static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
 		 * all tables in the stack.
 		 */
 		if (i != n)
-			EXPECT(st->merged->stack_len == i + 1);
+			EXPECT(st->merged->readers_len == i + 1);
 		else
-			EXPECT(st->merged->stack_len == 1);
+			EXPECT(st->merged->readers_len == 1);
 	}
 
 	reftable_stack_destroy(st);
@@ -375,7 +375,7 @@ static void test_reftable_stack_auto_compaction_fails_gracefully(void)
 
 	err = reftable_stack_add(st, write_test_ref, &ref);
 	EXPECT_ERR(err);
-	EXPECT(st->merged->stack_len == 1);
+	EXPECT(st->merged->readers_len == 1);
 	EXPECT(st->stats.attempts == 0);
 	EXPECT(st->stats.failures == 0);
 
@@ -390,7 +390,7 @@ static void test_reftable_stack_auto_compaction_fails_gracefully(void)
 	ref.update_index = 2;
 	err = reftable_stack_add(st, write_test_ref, &ref);
 	EXPECT_ERR(err);
-	EXPECT(st->merged->stack_len == 2);
+	EXPECT(st->merged->readers_len == 2);
 	EXPECT(st->stats.attempts == 1);
 	EXPECT(st->stats.failures == 1);
 
@@ -881,7 +881,7 @@ static void test_reftable_stack_auto_compaction(void)
 
 		err = reftable_stack_auto_compact(st);
 		EXPECT_ERR(err);
-		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
+		EXPECT(i < 3 || st->merged->readers_len < 2 * fastlog2(i));
 	}
 
 	EXPECT(reftable_stack_compaction_stats(st)->entries_written <
@@ -905,7 +905,7 @@ static void test_reftable_stack_auto_compaction_with_locked_tables(void)
 	EXPECT_ERR(err);
 
 	write_n_ref_tables(st, 5);
-	EXPECT(st->merged->stack_len == 5);
+	EXPECT(st->merged->readers_len == 5);
 
 	/*
 	 * Given that all tables we have written should be roughly the same
@@ -925,7 +925,7 @@ static void test_reftable_stack_auto_compaction_with_locked_tables(void)
 	err = reftable_stack_auto_compact(st);
 	EXPECT_ERR(err);
 	EXPECT(st->stats.failures == 0);
-	EXPECT(st->merged->stack_len == 4);
+	EXPECT(st->merged->readers_len == 4);
 
 	reftable_stack_destroy(st);
 	strbuf_release(&buf);
@@ -970,9 +970,9 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 		 * all tables in the stack.
 		 */
 		if (i != n)
-			EXPECT(st->merged->stack_len == i + 1);
+			EXPECT(st->merged->readers_len == i + 1);
 		else
-			EXPECT(st->merged->stack_len == 1);
+			EXPECT(st->merged->readers_len == 1);
 	}
 
 	reftable_stack_destroy(st);
@@ -994,7 +994,7 @@ static void test_reftable_stack_compaction_with_locked_tables(void)
 	EXPECT_ERR(err);
 
 	write_n_ref_tables(st, 3);
-	EXPECT(st->merged->stack_len == 3);
+	EXPECT(st->merged->readers_len == 3);
 
 	/* Lock one of the tables that we're about to compact. */
 	strbuf_reset(&buf);
@@ -1008,7 +1008,7 @@ static void test_reftable_stack_compaction_with_locked_tables(void)
 	err = reftable_stack_compact_all(st, NULL);
 	EXPECT(err == REFTABLE_LOCK_ERROR);
 	EXPECT(st->stats.failures == 1);
-	EXPECT(st->merged->stack_len == 3);
+	EXPECT(st->merged->readers_len == 3);
 
 	reftable_stack_destroy(st);
 	strbuf_release(&buf);
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 210603e8c7..577b1a5be8 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -94,10 +94,8 @@ merged_table_from_records(struct reftable_ref_record **refs,
 			  struct strbuf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
-	struct reftable_table *tabs;
 	int err;
 
-	REFTABLE_CALLOC_ARRAY(tabs, n);
 	REFTABLE_CALLOC_ARRAY(*readers, n);
 	REFTABLE_CALLOC_ARRAY(*source, n);
 
@@ -108,10 +106,9 @@ merged_table_from_records(struct reftable_ref_record **refs,
 		err = reftable_new_reader(&(*readers)[i], &(*source)[i],
 					  "name");
 		check(!err);
-		reftable_table_from_reader(&tabs[i], (*readers)[i]);
 	}
 
-	err = reftable_merged_table_new(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
+	err = reftable_merged_table_new(&mt, *readers, n, GIT_SHA1_FORMAT_ID);
 	check(!err);
 	return mt;
 }
@@ -272,10 +269,8 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 			      struct strbuf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
-	struct reftable_table *tabs;
 	int err;
 
-	REFTABLE_CALLOC_ARRAY(tabs, n);
 	REFTABLE_CALLOC_ARRAY(*readers, n);
 	REFTABLE_CALLOC_ARRAY(*source, n);
 
@@ -286,10 +281,9 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 		err = reftable_new_reader(&(*readers)[i], &(*source)[i],
 					  "name");
 		check(!err);
-		reftable_table_from_reader(&tabs[i], (*readers)[i]);
 	}
 
-	err = reftable_merged_table_new(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
+	err = reftable_merged_table_new(&mt, *readers, n, GIT_SHA1_FORMAT_ID);
 	check(!err);
 	return mt;
 }
@@ -418,7 +412,6 @@ static void t_default_write_opts(void)
 	};
 	int err;
 	struct reftable_block_source source = { 0 };
-	struct reftable_table *tab = reftable_calloc(1, sizeof(*tab));
 	uint32_t hash_id;
 	struct reftable_reader *rd = NULL;
 	struct reftable_merged_table *merged = NULL;
@@ -440,10 +433,9 @@ static void t_default_write_opts(void)
 	hash_id = reftable_reader_hash_id(rd);
 	check_int(hash_id, ==, GIT_SHA1_FORMAT_ID);
 
-	reftable_table_from_reader(&tab[0], rd);
-	err = reftable_merged_table_new(&merged, tab, 1, GIT_SHA256_FORMAT_ID);
+	err = reftable_merged_table_new(&merged, &rd, 1, GIT_SHA256_FORMAT_ID);
 	check_int(err, ==, REFTABLE_FORMAT_ERROR);
-	err = reftable_merged_table_new(&merged, tab, 1, GIT_SHA1_FORMAT_ID);
+	err = reftable_merged_table_new(&merged, &rd, 1, GIT_SHA1_FORMAT_ID);
 	check(!err);
 
 	reftable_reader_free(rd);
-- 
2.46.0.46.g406f326d27.dirty

