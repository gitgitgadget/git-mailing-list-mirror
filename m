Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E39B253F00
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031792; cv=none; b=YqpicbkVnJpuo2K5QqUBi9eqU1R29+al4KdcgK6epwfacKIDpfzZBPoqViboa9yld+IEt3LtUOFdiVUjVm89uuCcbORVRRSJcraszhaSYL03NPlko2Ls2+6wC91fKQBvL53ejhR8KcBG1dLuZ2kDNMyBcLJGp5sqkeidjBxq6t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031792; c=relaxed/simple;
	bh=hTTQF4n1qza1rZaQ2c8ID4OZ7/hlX4LHCI6Vm6mHsRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9McWrIQKi2G/p1PP1CV0RDz2TXF7N88xXQBT4fjDn2acUjv9XFq7CR3kubQSTadNnmuIvTU9/CS34S6e70h4IeoLyGXf7KVDMMWm8nhcfdNLKipJDuAYh4Wgs8jr+mZp9CW+dM2AE8n1/TvIH30xUdni+qmoulpOl8HMdkCwyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MF/r9A56; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+vpSv3P; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MF/r9A56";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+vpSv3P"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B6641140211;
	Mon,  7 Apr 2025 09:16:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 07 Apr 2025 09:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031785;
	 x=1744118185; bh=CQeuuOsUfKAoEPCCsInI79uIUqYCS6zb5xweHtHSrCc=; b=
	MF/r9A56h3lQKmDzLRBqWkme9N0elJxp1gXoYJi0zKcitERvkM4/FJc9TsmNDnC+
	R2tgyahCR/vE/8fqEgpHhK58tYPao7sU/iK9AHWxVIajk7NG0yddbRSpjsN+no/V
	94nDEjeg0zK2H9mdbMq4aKPq7IUnHRbsx2ESERYXrZccJPm3gKpjxMFfik2tmuU5
	p/0+/HFflq6zHuxPiP34jJOMFQvtxbmxZf3cnCwf0SGAfF22HW3NF3Q6AQxiHmXJ
	ob5wazv3qoMElClNmmrJc6fnrZvqRXjdNswJmHJ8LplbYw8hfYXFqkMCfYU54fmT
	gqPZ+VnhQMUfRlYldXEg1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031785; x=
	1744118185; bh=CQeuuOsUfKAoEPCCsInI79uIUqYCS6zb5xweHtHSrCc=; b=U
	+vpSv3PS1rhKsVuaY6UitA/HvwRIb6sTm1FyebM/XbvPyfpY2FJmmMRS12cbllkl
	WY/qKXQuu5RNGbbsiT1eGLPc0Rdrb5+C6/Dwfw828NuBojjLu/FCGGd+iw5ixBpx
	b5rgYH0iEhSBz+Eyl7w20LCwer6nJ3gqGKFwVmnLHQcr2lzyu77P2c8/XqIJvWZJ
	HhRiZjQPosbrvpOmbsuxCLjMrbK9B70tALqRsPbfZ25G99IC5h+vjXaCyOchkXs6
	/7tYauDNigcGmsDqAXL1pnDM/tIzdktzcbKNpxm0eYaQiIFU9y5mN5wQyknu46h+
	NFIAcFhKkqiY/C3tJyfxA==
X-ME-Sender: <xms:KdDzZxysc6LA1MizYzLctUgdI1AGbA5UEpaaGkm6iK9_bl-J2KyQYg>
    <xme:KdDzZxSMp1G100BmseU32tVK53Q6Yam9qf_k9AzYrS8pbPLFgjyuKErbLb4a_FJ0i
    gcyXtF3e8x0is48eg>
X-ME-Received: <xmr:KdDzZ7X0AL5NWEmjUwN02ZWmB15_JipMA-bX-W4XtV0kkIa1x8jMK-deYxpv9K8A7nAMjj9WZINlNhhmOPqJqAHUHD6JCBd8V6BJQfgbcIja4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedthfegfeejuefgieffvefhvedvfedtffdtgffh
    heevgfdtjedukefgkefgfeevtdenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:KdDzZzg7ApRVuGoOdTYrQbn-WfnN1K4h-iBQPJzLE4cpcu6qrCDhAg>
    <xmx:KdDzZzBLC2rTHqNZDQJm47lN6TeotccDZqlEuzKgTdBwWH-5ezLdVg>
    <xmx:KdDzZ8K_gr2Z62Xv17xWRf3SA3yznM_hbJSgzbA7zSzbf-_z5aOvKw>
    <xmx:KdDzZyCDaZ4J4px-GvPeZa_rUQMU8Fjnc66ZUqCkEJD-yLWcR45AqQ>
    <xmx:KdDzZ7NpBFbXCUB65l3LZwRSpRbEi9qT4MgFjrW5UdnSRaXtR7FTxpSM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e77a8a5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:14 +0200
Subject: [PATCH v2 02/16] reftable/reader: rename data structure to "table"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-2-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `struct reftable_reader` subsystem encapsulates a table that has
been read from the disk. As such, the current name of that structure is
somewhat hard to understand as it only talks about the fact that we read
something from disk, without really giving an indicator _what_ that is.

Furthermore, this naming schema doesn't really fit well into how the
other structures are named: `reftable_merged_table`, `reftable_stack`,
`reftable_block` and `reftable_record` are all named after what they
encapsulate.

Rename the subsystem to `reftable_table`, which directly gives a hint
that the data structure is about handling the individual tables part of
the stack.

While this change results in a lot of churn, it prepares for us exposing
the APIs to third-party callers now that the reftable library is a
standalone library that can be linked against by other projects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                                           |   4 +-
 meson.build                                        |   2 +-
 reftable/iter.c                                    |  10 +-
 reftable/iter.h                                    |   4 +-
 reftable/merged.c                                  |  26 +--
 reftable/merged.h                                  |   4 +-
 reftable/reftable-merged.h                         |   6 +-
 reftable/reftable-reader.h                         |  72 ------
 reftable/reftable-table.h                          |  72 ++++++
 reftable/stack.c                                   | 168 +++++++-------
 reftable/stack.h                                   |   4 +-
 reftable/{reader.c => table.c}                     | 254 ++++++++++-----------
 reftable/{reader.h => table.h}                     |  30 +--
 t/helper/test-reftable.c                           |  14 +-
 t/meson.build                                      |   2 +-
 t/unit-tests/t-reftable-merged.c                   |  74 +++---
 t/unit-tests/t-reftable-readwrite.c                |  96 ++++----
 t/unit-tests/t-reftable-stack.c                    |  66 +++---
 .../{t-reftable-reader.c => t-reftable-table.c}    |  26 +--
 19 files changed, 467 insertions(+), 467 deletions(-)

diff --git a/Makefile b/Makefile
index 22d632da4ea..58bd9dc6452 100644
--- a/Makefile
+++ b/Makefile
@@ -1374,10 +1374,10 @@ UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-pq
-UNIT_TEST_PROGRAMS += t-reftable-reader
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
+UNIT_TEST_PROGRAMS += t-reftable-table
 UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGRAMS += t-urlmatch-normalization
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
@@ -2729,10 +2729,10 @@ REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/iter.o
 REFTABLE_OBJS += reftable/merged.o
 REFTABLE_OBJS += reftable/pq.o
-REFTABLE_OBJS += reftable/reader.o
 REFTABLE_OBJS += reftable/record.o
 REFTABLE_OBJS += reftable/stack.o
 REFTABLE_OBJS += reftable/system.o
+REFTABLE_OBJS += reftable/table.o
 REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
 
diff --git a/meson.build b/meson.build
index efe2871c9db..61986cc48db 100644
--- a/meson.build
+++ b/meson.build
@@ -410,10 +410,10 @@ libgit_sources = [
   'reftable/iter.c',
   'reftable/merged.c',
   'reftable/pq.c',
-  'reftable/reader.c',
   'reftable/record.c',
   'reftable/stack.c',
   'reftable/system.c',
+  'reftable/table.c',
   'reftable/tree.c',
   'reftable/writer.c',
   'remote.c',
diff --git a/reftable/iter.c b/reftable/iter.c
index 44a155e756e..7376f263c99 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -12,8 +12,8 @@
 
 #include "block.h"
 #include "constants.h"
-#include "reader.h"
 #include "reftable-error.h"
+#include "table.h"
 
 int iterator_seek(struct reftable_iterator *it, struct reftable_record *want)
 {
@@ -130,8 +130,8 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 	reftable_block_done(&it->block_reader.block);
 
 	off = it->offsets[it->offset_idx++];
-	err = reader_init_block_reader(it->r, &it->block_reader, off,
-				       BLOCK_TYPE_REF);
+	err = table_init_block_reader(it->table, &it->block_reader, off,
+				      BLOCK_TYPE_REF);
 	if (err < 0) {
 		return err;
 	}
@@ -181,7 +181,7 @@ static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
 }
 
 int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
-			       struct reftable_reader *r, uint8_t *oid,
+			       struct reftable_table *t, uint8_t *oid,
 			       int oid_len, uint64_t *offsets, int offset_len)
 {
 	struct indexed_table_ref_iter empty = INDEXED_TABLE_REF_ITER_INIT;
@@ -195,7 +195,7 @@ int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
 	}
 
 	*itr = empty;
-	itr->r = r;
+	itr->table = t;
 
 	err = reftable_buf_add(&itr->oid, oid, oid_len);
 	if (err < 0)
diff --git a/reftable/iter.h b/reftable/iter.h
index bd217405f55..add5c9472fc 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -59,7 +59,7 @@ void iterator_from_filtering_ref_iterator(struct reftable_iterator *,
  * but using the object index.
  */
 struct indexed_table_ref_iter {
-	struct reftable_reader *r;
+	struct reftable_table *table;
 	struct reftable_buf oid;
 
 	/* mutable */
@@ -83,7 +83,7 @@ void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
 
 /* Takes ownership of `offsets` */
 int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
-			       struct reftable_reader *r, uint8_t *oid,
+			       struct reftable_table *t, uint8_t *oid,
 			       int oid_len, uint64_t *offsets, int offset_len);
 
 #endif
diff --git a/reftable/merged.c b/reftable/merged.c
index 1829a081756..d5b974d660e 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -11,11 +11,11 @@
 #include "constants.h"
 #include "iter.h"
 #include "pq.h"
-#include "reader.h"
 #include "record.h"
 #include "reftable-merged.h"
 #include "reftable-error.h"
 #include "system.h"
+#include "table.h"
 
 struct merged_subiter {
 	struct reftable_iterator iter;
@@ -192,7 +192,7 @@ static void iterator_from_merged_iter(struct reftable_iterator *it,
 }
 
 int reftable_merged_table_new(struct reftable_merged_table **dest,
-			      struct reftable_reader **readers, size_t n,
+			      struct reftable_table **tables, size_t n,
 			      enum reftable_hash hash_id)
 {
 	struct reftable_merged_table *m = NULL;
@@ -200,10 +200,10 @@ int reftable_merged_table_new(struct reftable_merged_table **dest,
 	uint64_t first_min = 0;
 
 	for (size_t i = 0; i < n; i++) {
-		uint64_t min = reftable_reader_min_update_index(readers[i]);
-		uint64_t max = reftable_reader_max_update_index(readers[i]);
+		uint64_t min = reftable_table_min_update_index(tables[i]);
+		uint64_t max = reftable_table_max_update_index(tables[i]);
 
-		if (reftable_reader_hash_id(readers[i]) != hash_id) {
+		if (reftable_table_hash_id(tables[i]) != hash_id) {
 			return REFTABLE_FORMAT_ERROR;
 		}
 		if (i == 0 || min < first_min) {
@@ -218,8 +218,8 @@ int reftable_merged_table_new(struct reftable_merged_table **dest,
 	if (!m)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
 
-	m->readers = readers;
-	m->readers_len = n;
+	m->tables = tables;
+	m->tables_len = n;
 	m->min = first_min;
 	m->max = last_max;
 	m->hash_id = hash_id;
@@ -254,20 +254,20 @@ int merged_table_init_iter(struct reftable_merged_table *mt,
 	struct merged_iter *mi = NULL;
 	int ret;
 
-	if (mt->readers_len) {
-		REFTABLE_CALLOC_ARRAY(subiters, mt->readers_len);
+	if (mt->tables_len) {
+		REFTABLE_CALLOC_ARRAY(subiters, mt->tables_len);
 		if (!subiters) {
 			ret = REFTABLE_OUT_OF_MEMORY_ERROR;
 			goto out;
 		}
 	}
 
-	for (size_t i = 0; i < mt->readers_len; i++) {
+	for (size_t i = 0; i < mt->tables_len; i++) {
 		ret = reftable_record_init(&subiters[i].rec, typ);
 		if (ret < 0)
 			goto out;
 
-		ret = reader_init_iter(mt->readers[i], &subiters[i].iter, typ);
+		ret = table_init_iter(mt->tables[i], &subiters[i].iter, typ);
 		if (ret < 0)
 			goto out;
 	}
@@ -280,14 +280,14 @@ int merged_table_init_iter(struct reftable_merged_table *mt,
 	mi->advance_index = -1;
 	mi->suppress_deletions = mt->suppress_deletions;
 	mi->subiters = subiters;
-	mi->subiters_len = mt->readers_len;
+	mi->subiters_len = mt->tables_len;
 
 	iterator_from_merged_iter(it, mi);
 	ret = 0;
 
 out:
 	if (ret < 0) {
-		for (size_t i = 0; subiters && i < mt->readers_len; i++) {
+		for (size_t i = 0; subiters && i < mt->tables_len; i++) {
 			reftable_iterator_destroy(&subiters[i].iter);
 			reftable_record_release(&subiters[i].rec);
 		}
diff --git a/reftable/merged.h b/reftable/merged.h
index ae92409d342..4317e5f5f67 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -13,8 +13,8 @@
 #include "reftable-basics.h"
 
 struct reftable_merged_table {
-	struct reftable_reader **readers;
-	size_t readers_len;
+	struct reftable_table **tables;
+	size_t tables_len;
 	enum reftable_hash hash_id;
 
 	/* If unset, produce deletions. This is useful for compaction. For the
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index 445756e475a..e5af846b32a 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -26,14 +26,14 @@
 /* A merged table is implements seeking/iterating over a stack of tables. */
 struct reftable_merged_table;
 
-struct reftable_reader;
+struct reftable_table;
 
 /*
- * reftable_merged_table_new creates a new merged table. The readers must be
+ * reftable_merged_table_new creates a new merged table. The tables must be
  * kept alive as long as the merged table is still in use.
  */
 int reftable_merged_table_new(struct reftable_merged_table **dest,
-			      struct reftable_reader **readers, size_t n,
+			      struct reftable_table **tables, size_t n,
 			      enum reftable_hash hash_id);
 
 /* Initialize a merged table iterator for reading refs. */
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
deleted file mode 100644
index 9b6a8ac0716..00000000000
--- a/reftable/reftable-reader.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * Copyright 2020 Google LLC
- *
- * Use of this source code is governed by a BSD-style
- * license that can be found in the LICENSE file or at
- * https://developers.google.com/open-source/licenses/bsd
- */
-
-#ifndef REFTABLE_READER_H
-#define REFTABLE_READER_H
-
-#include "reftable-iterator.h"
-#include "reftable-blocksource.h"
-
-/*
- * Reading single tables
- *
- * The follow routines are for reading single files. For an
- * application-level interface, skip ahead to struct
- * reftable_merged_table and struct reftable_stack.
- */
-
-/* The reader struct is a handle to an open reftable file. */
-struct reftable_reader;
-
-/* reftable_reader_new opens a reftable for reading. If successful,
- * returns 0 code and sets pp. The name is used for creating a
- * stack. Typically, it is the basename of the file. The block source
- * `src` is owned by the reader, and is closed on calling
- * reftable_reader_destroy(). On error, the block source `src` is
- * closed as well.
- */
-int reftable_reader_new(struct reftable_reader **pp,
-			struct reftable_block_source *src, const char *name);
-
-/*
- * Manage the reference count of the reftable reader. A newly initialized
- * reader starts with a refcount of 1 and will be deleted once the refcount has
- * reached 0.
- *
- * This is required because readers may have longer lifetimes than the stack
- * they belong to. The stack may for example be reloaded while the old tables
- * are still being accessed by an iterator.
- */
-void reftable_reader_incref(struct reftable_reader *reader);
-void reftable_reader_decref(struct reftable_reader *reader);
-
-/* Initialize a reftable iterator for reading refs. */
-int reftable_reader_init_ref_iterator(struct reftable_reader *r,
-				      struct reftable_iterator *it);
-
-/* Initialize a reftable iterator for reading logs. */
-int reftable_reader_init_log_iterator(struct reftable_reader *r,
-				      struct reftable_iterator *it);
-
-/* returns the hash ID used in this table. */
-enum reftable_hash reftable_reader_hash_id(struct reftable_reader *r);
-
-/* return an iterator for the refs pointing to `oid`. */
-int reftable_reader_refs_for(struct reftable_reader *r,
-			     struct reftable_iterator *it, uint8_t *oid);
-
-/* return the max_update_index for a table */
-uint64_t reftable_reader_max_update_index(struct reftable_reader *r);
-
-/* return the min_update_index for a table */
-uint64_t reftable_reader_min_update_index(struct reftable_reader *r);
-
-/* print blocks onto stdout for debugging. */
-int reftable_reader_print_blocks(const char *tablename);
-
-#endif
diff --git a/reftable/reftable-table.h b/reftable/reftable-table.h
new file mode 100644
index 00000000000..94379026727
--- /dev/null
+++ b/reftable/reftable-table.h
@@ -0,0 +1,72 @@
+/*
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
+
+#ifndef REFTABLE_TABLE_H
+#define REFTABLE_TABLE_H
+
+#include "reftable-iterator.h"
+#include "reftable-blocksource.h"
+
+/*
+ * Reading single tables
+ *
+ * The follow routines are for reading single files. For an
+ * application-level interface, skip ahead to struct
+ * reftable_merged_table and struct reftable_stack.
+ */
+
+/* The table struct is a handle to an open reftable file. */
+struct reftable_table;
+
+/* reftable_table_new opens a reftable for reading. If successful,
+ * returns 0 code and sets pp. The name is used for creating a
+ * stack. Typically, it is the basename of the file. The block source
+ * `src` is owned by the table, and is closed on calling
+ * reftable_table_destroy(). On error, the block source `src` is
+ * closed as well.
+ */
+int reftable_table_new(struct reftable_table **out,
+		       struct reftable_block_source *src, const char *name);
+
+/*
+ * Manage the reference count of the reftable table. A newly initialized
+ * table starts with a refcount of 1 and will be deleted once the refcount has
+ * reached 0.
+ *
+ * This is required because tables may have longer lifetimes than the stack
+ * they belong to. The stack may for example be reloaded while the old tables
+ * are still being accessed by an iterator.
+ */
+void reftable_table_incref(struct reftable_table *table);
+void reftable_table_decref(struct reftable_table *table);
+
+/* Initialize a reftable iterator for reading refs. */
+int reftable_table_init_ref_iterator(struct reftable_table *t,
+				     struct reftable_iterator *it);
+
+/* Initialize a reftable iterator for reading logs. */
+int reftable_table_init_log_iterator(struct reftable_table *t,
+				     struct reftable_iterator *it);
+
+/* returns the hash ID used in this table. */
+enum reftable_hash reftable_table_hash_id(struct reftable_table *t);
+
+/* return an iterator for the refs pointing to `oid`. */
+int reftable_table_refs_for(struct reftable_table *t,
+			    struct reftable_iterator *it, uint8_t *oid);
+
+/* return the max_update_index for a table */
+uint64_t reftable_table_max_update_index(struct reftable_table *t);
+
+/* return the min_update_index for a table */
+uint64_t reftable_table_min_update_index(struct reftable_table *t);
+
+/* print blocks onto stdout for debugging. */
+int reftable_table_print_blocks(const char *tablename);
+
+#endif
diff --git a/reftable/stack.c b/reftable/stack.c
index bc3cfa91170..cc48e725b14 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -11,10 +11,10 @@
 #include "system.h"
 #include "constants.h"
 #include "merged.h"
-#include "reader.h"
 #include "reftable-error.h"
 #include "reftable-record.h"
 #include "reftable-merged.h"
+#include "table.h"
 #include "writer.h"
 
 static int stack_try_add(struct reftable_stack *st,
@@ -248,11 +248,11 @@ void reftable_stack_destroy(struct reftable_stack *st)
 		REFTABLE_FREE_AND_NULL(names);
 	}
 
-	if (st->readers) {
+	if (st->tables) {
 		struct reftable_buf filename = REFTABLE_BUF_INIT;
 
-		for (size_t i = 0; i < st->readers_len; i++) {
-			const char *name = reader_name(st->readers[i]);
+		for (size_t i = 0; i < st->tables_len; i++) {
+			const char *name = reftable_table_name(st->tables[i]);
 			int try_unlinking = 1;
 
 			reftable_buf_reset(&filename);
@@ -260,7 +260,7 @@ void reftable_stack_destroy(struct reftable_stack *st)
 				if (stack_filename(&filename, st, name) < 0)
 					try_unlinking = 0;
 			}
-			reftable_reader_decref(st->readers[i]);
+			reftable_table_decref(st->tables[i]);
 
 			if (try_unlinking && filename.len) {
 				/* On Windows, can only unlink after closing. */
@@ -269,8 +269,8 @@ void reftable_stack_destroy(struct reftable_stack *st)
 		}
 
 		reftable_buf_release(&filename);
-		st->readers_len = 0;
-		REFTABLE_FREE_AND_NULL(st->readers);
+		st->tables_len = 0;
+		REFTABLE_FREE_AND_NULL(st->tables);
 	}
 
 	if (st->list_fd >= 0) {
@@ -284,14 +284,14 @@ void reftable_stack_destroy(struct reftable_stack *st)
 	free_names(names);
 }
 
-static struct reftable_reader **stack_copy_readers(struct reftable_stack *st,
-						   size_t cur_len)
+static struct reftable_table **stack_copy_tables(struct reftable_stack *st,
+						 size_t cur_len)
 {
-	struct reftable_reader **cur = reftable_calloc(cur_len, sizeof(*cur));
+	struct reftable_table **cur = reftable_calloc(cur_len, sizeof(*cur));
 	if (!cur)
 		return NULL;
 	for (size_t i = 0; i < cur_len; i++)
-		cur[i] = st->readers[i];
+		cur[i] = st->tables[i];
 	return cur;
 }
 
@@ -299,19 +299,19 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 				      const char **names,
 				      int reuse_open)
 {
-	size_t cur_len = !st->merged ? 0 : st->merged->readers_len;
-	struct reftable_reader **cur = NULL;
-	struct reftable_reader **reused = NULL;
-	struct reftable_reader **new_readers = NULL;
+	size_t cur_len = !st->merged ? 0 : st->merged->tables_len;
+	struct reftable_table **cur = NULL;
+	struct reftable_table **reused = NULL;
+	struct reftable_table **new_tables = NULL;
 	size_t reused_len = 0, reused_alloc = 0, names_len;
-	size_t new_readers_len = 0;
+	size_t new_tables_len = 0;
 	struct reftable_merged_table *new_merged = NULL;
 	struct reftable_buf table_path = REFTABLE_BUF_INIT;
 	int err = 0;
 	size_t i;
 
 	if (cur_len) {
-		cur = stack_copy_readers(st, cur_len);
+		cur = stack_copy_tables(st, cur_len);
 		if (!cur) {
 			err = REFTABLE_OUT_OF_MEMORY_ERROR;
 			goto done;
@@ -321,28 +321,28 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	names_len = names_length(names);
 
 	if (names_len) {
-		new_readers = reftable_calloc(names_len, sizeof(*new_readers));
-		if (!new_readers) {
+		new_tables = reftable_calloc(names_len, sizeof(*new_tables));
+		if (!new_tables) {
 			err = REFTABLE_OUT_OF_MEMORY_ERROR;
 			goto done;
 		}
 	}
 
 	while (*names) {
-		struct reftable_reader *rd = NULL;
+		struct reftable_table *table = NULL;
 		const char *name = *names++;
 
 		/* this is linear; we assume compaction keeps the number of
 		   tables under control so this is not quadratic. */
 		for (i = 0; reuse_open && i < cur_len; i++) {
 			if (cur[i] && 0 == strcmp(cur[i]->name, name)) {
-				rd = cur[i];
+				table = cur[i];
 				cur[i] = NULL;
 
 				/*
 				 * When reloading the stack fails, we end up
-				 * releasing all new readers. This also
-				 * includes the reused readers, even though
+				 * releasing all new tables. This also
+				 * includes the reused tables, even though
 				 * they are still in used by the old stack. We
 				 * thus need to keep them alive here, which we
 				 * do by bumping their refcount.
@@ -354,13 +354,13 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 					err = REFTABLE_OUT_OF_MEMORY_ERROR;
 					goto done;
 				}
-				reused[reused_len++] = rd;
-				reftable_reader_incref(rd);
+				reused[reused_len++] = table;
+				reftable_table_incref(table);
 				break;
 			}
 		}
 
-		if (!rd) {
+		if (!table) {
 			struct reftable_block_source src = { NULL };
 
 			err = stack_filename(&table_path, st, name);
@@ -372,36 +372,36 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 			if (err < 0)
 				goto done;
 
-			err = reftable_reader_new(&rd, &src, name);
+			err = reftable_table_new(&table, &src, name);
 			if (err < 0)
 				goto done;
 		}
 
-		new_readers[new_readers_len] = rd;
-		new_readers_len++;
+		new_tables[new_tables_len] = table;
+		new_tables_len++;
 	}
 
 	/* success! */
-	err = reftable_merged_table_new(&new_merged, new_readers,
-					new_readers_len, st->opts.hash_id);
+	err = reftable_merged_table_new(&new_merged, new_tables,
+					new_tables_len, st->opts.hash_id);
 	if (err < 0)
 		goto done;
 
 	/*
-	 * Close the old, non-reused readers and proactively try to unlink
+	 * Close the old, non-reused tables and proactively try to unlink
 	 * them. This is done for systems like Windows, where the underlying
-	 * file of such an open reader wouldn't have been possible to be
+	 * file of such an open table wouldn't have been possible to be
 	 * unlinked by the compacting process.
 	 */
 	for (i = 0; i < cur_len; i++) {
 		if (cur[i]) {
-			const char *name = reader_name(cur[i]);
+			const char *name = reftable_table_name(cur[i]);
 
 			err = stack_filename(&table_path, st, name);
 			if (err < 0)
 				goto done;
 
-			reftable_reader_decref(cur[i]);
+			reftable_table_decref(cur[i]);
 			unlink(table_path.buf);
 		}
 	}
@@ -412,25 +412,25 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	new_merged->suppress_deletions = 1;
 	st->merged = new_merged;
 
-	if (st->readers)
-		reftable_free(st->readers);
-	st->readers = new_readers;
-	st->readers_len = new_readers_len;
-	new_readers = NULL;
-	new_readers_len = 0;
+	if (st->tables)
+		reftable_free(st->tables);
+	st->tables = new_tables;
+	st->tables_len = new_tables_len;
+	new_tables = NULL;
+	new_tables_len = 0;
 
 	/*
-	 * Decrement the refcount of reused readers again. This only needs to
+	 * Decrement the refcount of reused tables again. This only needs to
 	 * happen on the successful case, because on the unsuccessful one we
-	 * decrement their refcount via `new_readers`.
+	 * decrement their refcount via `new_tables`.
 	 */
 	for (i = 0; i < reused_len; i++)
-		reftable_reader_decref(reused[i]);
+		reftable_table_decref(reused[i]);
 
 done:
-	for (i = 0; i < new_readers_len; i++)
-		reftable_reader_decref(new_readers[i]);
-	reftable_free(new_readers);
+	for (i = 0; i < new_tables_len; i++)
+		reftable_table_decref(new_tables[i]);
+	reftable_free(new_tables);
 	reftable_free(reused);
 	reftable_free(cur);
 	reftable_buf_release(&table_path);
@@ -615,10 +615,10 @@ static int stack_uptodate(struct reftable_stack *st)
 			/*
 			 * It's fine for "tables.list" to not exist. In that
 			 * case, we have to refresh when the loaded stack has
-			 * any readers.
+			 * any tables.
 			 */
 			if (errno == ENOENT)
-				return !!st->readers_len;
+				return !!st->tables_len;
 			return REFTABLE_IO_ERROR;
 		}
 
@@ -637,19 +637,19 @@ static int stack_uptodate(struct reftable_stack *st)
 	if (err < 0)
 		return err;
 
-	for (size_t i = 0; i < st->readers_len; i++) {
+	for (size_t i = 0; i < st->tables_len; i++) {
 		if (!names[i]) {
 			err = 1;
 			goto done;
 		}
 
-		if (strcmp(st->readers[i]->name, names[i])) {
+		if (strcmp(st->tables[i]->name, names[i])) {
 			err = 1;
 			goto done;
 		}
 	}
 
-	if (names[st->merged->readers_len]) {
+	if (names[st->merged->tables_len]) {
 		err = 1;
 		goto done;
 	}
@@ -792,8 +792,8 @@ int reftable_addition_commit(struct reftable_addition *add)
 	if (add->new_tables_len == 0)
 		goto done;
 
-	for (i = 0; i < add->stack->merged->readers_len; i++) {
-		if ((err = reftable_buf_addstr(&table_list, add->stack->readers[i]->name)) < 0 ||
+	for (i = 0; i < add->stack->merged->tables_len; i++) {
+		if ((err = reftable_buf_addstr(&table_list, add->stack->tables[i]->name)) < 0 ||
 		    (err = reftable_buf_addstr(&table_list, "\n")) < 0)
 			goto done;
 	}
@@ -1000,9 +1000,9 @@ int reftable_addition_add(struct reftable_addition *add,
 
 uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
 {
-	int sz = st->merged->readers_len;
+	int sz = st->merged->tables_len;
 	if (sz > 0)
-		return reftable_reader_max_update_index(st->readers[sz - 1]) +
+		return reftable_table_max_update_index(st->tables[sz - 1]) +
 		       1;
 	return 1;
 }
@@ -1021,8 +1021,8 @@ static int stack_compact_locked(struct reftable_stack *st,
 	struct reftable_tmpfile tab_file = REFTABLE_TMPFILE_INIT;
 	int err = 0;
 
-	err = format_name(&next_name, reftable_reader_min_update_index(st->readers[first]),
-			  reftable_reader_max_update_index(st->readers[last]));
+	err = format_name(&next_name, reftable_table_min_update_index(st->tables[first]),
+			  reftable_table_max_update_index(st->tables[last]));
 	if (err < 0)
 		goto done;
 
@@ -1087,13 +1087,13 @@ static int stack_write_compact(struct reftable_stack *st,
 	int err = 0;
 
 	for (size_t i = first; i <= last; i++)
-		st->stats.bytes += st->readers[i]->size;
-	err = reftable_writer_set_limits(wr, st->readers[first]->min_update_index,
-					 st->readers[last]->max_update_index);
+		st->stats.bytes += st->tables[i]->size;
+	err = reftable_writer_set_limits(wr, st->tables[first]->min_update_index,
+					 st->tables[last]->max_update_index);
 	if (err < 0)
 		goto done;
 
-	err = reftable_merged_table_new(&mt, st->readers + first, subtabs_len,
+	err = reftable_merged_table_new(&mt, st->tables + first, subtabs_len,
 					st->opts.hash_id);
 	if (err < 0)
 		goto done;
@@ -1250,7 +1250,7 @@ static int stack_compact_range(struct reftable_stack *st,
 		table_locks[i] = REFTABLE_FLOCK_INIT;
 
 	for (i = last + 1; i > first; i--) {
-		err = stack_filename(&table_name, st, reader_name(st->readers[i - 1]));
+		err = stack_filename(&table_name, st, reftable_table_name(st->tables[i - 1]));
 		if (err < 0)
 			goto done;
 
@@ -1376,7 +1376,7 @@ static int stack_compact_range(struct reftable_stack *st,
 		 * compacted in the updated "tables.list" file.
 		 */
 		for (size_t i = 0; names[i]; i++) {
-			if (strcmp(names[i], st->readers[first]->name))
+			if (strcmp(names[i], st->tables[first]->name))
 				continue;
 
 			/*
@@ -1386,8 +1386,8 @@ static int stack_compact_range(struct reftable_stack *st,
 			 * have compacted them.
 			 */
 			for (size_t j = 1; j < last - first + 1; j++) {
-				const char *old = first + j < st->merged->readers_len ?
-					st->readers[first + j]->name : NULL;
+				const char *old = first + j < st->merged->tables_len ?
+					st->tables[first + j]->name : NULL;
 				const char *new = names[i + j];
 
 				/*
@@ -1427,16 +1427,16 @@ static int stack_compact_range(struct reftable_stack *st,
 		 * `fd_read_lines()` uses a `NULL` sentinel to indicate that
 		 * the array is at its end. As we use `free_names()` to free
 		 * the array, we need to include this sentinel value here and
-		 * thus have to allocate `readers_len + 1` many entries.
+		 * thus have to allocate `tables_len + 1` many entries.
 		 */
-		REFTABLE_CALLOC_ARRAY(names, st->merged->readers_len + 1);
+		REFTABLE_CALLOC_ARRAY(names, st->merged->tables_len + 1);
 		if (!names) {
 			err = REFTABLE_OUT_OF_MEMORY_ERROR;
 			goto done;
 		}
 
-		for (size_t i = 0; i < st->merged->readers_len; i++) {
-			names[i] = reftable_strdup(st->readers[i]->name);
+		for (size_t i = 0; i < st->merged->tables_len; i++) {
+			names[i] = reftable_strdup(st->tables[i]->name);
 			if (!names[i]) {
 				err = REFTABLE_OUT_OF_MEMORY_ERROR;
 				goto done;
@@ -1451,8 +1451,8 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * it into place now.
 	 */
 	if (!is_empty_table) {
-		err = format_name(&new_table_name, st->readers[first]->min_update_index,
-				  st->readers[last]->max_update_index);
+		err = format_name(&new_table_name, st->tables[first]->min_update_index,
+				  st->tables[last]->max_update_index);
 		if (err < 0)
 			goto done;
 
@@ -1559,7 +1559,7 @@ static int stack_compact_range(struct reftable_stack *st,
 int reftable_stack_compact_all(struct reftable_stack *st,
 			       struct reftable_log_expiry_config *config)
 {
-	size_t last = st->merged->readers_len ? st->merged->readers_len - 1 : 0;
+	size_t last = st->merged->tables_len ? st->merged->tables_len - 1 : 0;
 	return stack_compact_range(st, 0, last, config, 0);
 }
 
@@ -1650,12 +1650,12 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
 	int overhead = header_size(version) - 1;
 	uint64_t *sizes;
 
-	REFTABLE_CALLOC_ARRAY(sizes, st->merged->readers_len);
+	REFTABLE_CALLOC_ARRAY(sizes, st->merged->tables_len);
 	if (!sizes)
 		return NULL;
 
-	for (size_t i = 0; i < st->merged->readers_len; i++)
-		sizes[i] = st->readers[i]->size - overhead;
+	for (size_t i = 0; i < st->merged->tables_len; i++)
+		sizes[i] = st->tables[i]->size - overhead;
 
 	return sizes;
 }
@@ -1665,14 +1665,14 @@ int reftable_stack_auto_compact(struct reftable_stack *st)
 	struct segment seg;
 	uint64_t *sizes;
 
-	if (st->merged->readers_len < 2)
+	if (st->merged->tables_len < 2)
 		return 0;
 
 	sizes = stack_table_sizes_for_compaction(st);
 	if (!sizes)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
 
-	seg = suggest_compaction_segment(sizes, st->merged->readers_len,
+	seg = suggest_compaction_segment(sizes, st->merged->tables_len,
 					 st->opts.auto_compaction_factor);
 	reftable_free(sizes);
 
@@ -1763,7 +1763,7 @@ static void remove_maybe_stale_table(struct reftable_stack *st, uint64_t max,
 	int err = 0;
 	uint64_t update_idx = 0;
 	struct reftable_block_source src = { NULL };
-	struct reftable_reader *rd = NULL;
+	struct reftable_table *table = NULL;
 	struct reftable_buf table_path = REFTABLE_BUF_INIT;
 
 	err = stack_filename(&table_path, st, name);
@@ -1774,12 +1774,12 @@ static void remove_maybe_stale_table(struct reftable_stack *st, uint64_t max,
 	if (err < 0)
 		goto done;
 
-	err = reftable_reader_new(&rd, &src, name);
+	err = reftable_table_new(&table, &src, name);
 	if (err < 0)
 		goto done;
 
-	update_idx = reftable_reader_max_update_index(rd);
-	reftable_reader_decref(rd);
+	update_idx = reftable_table_max_update_index(table);
+	reftable_table_decref(table);
 
 	if (update_idx <= max) {
 		unlink(table_path.buf);
@@ -1803,8 +1803,8 @@ static int reftable_stack_clean_locked(struct reftable_stack *st)
 		if (!is_table_name(d->d_name))
 			continue;
 
-		for (size_t i = 0; !found && i < st->readers_len; i++)
-			found = !strcmp(reader_name(st->readers[i]), d->d_name);
+		for (size_t i = 0; !found && i < st->tables_len; i++)
+			found = !strcmp(reftable_table_name(st->tables[i]), d->d_name);
 		if (found)
 			continue;
 
diff --git a/reftable/stack.h b/reftable/stack.h
index d91f5ce6072..bc28f2998ac 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -22,8 +22,8 @@ struct reftable_stack {
 
 	struct reftable_write_options opts;
 
-	struct reftable_reader **readers;
-	size_t readers_len;
+	struct reftable_table **tables;
+	size_t tables_len;
 	struct reftable_merged_table *merged;
 	struct reftable_compaction_stats stats;
 };
diff --git a/reftable/reader.c b/reftable/table.c
similarity index 73%
rename from reftable/reader.c
rename to reftable/table.c
index 155a26c30ff..440fb559ad1 100644
--- a/reftable/reader.c
+++ b/reftable/table.c
@@ -6,7 +6,7 @@
  * https://developers.google.com/open-source/licenses/bsd
  */
 
-#include "reader.h"
+#include "table.h"
 
 #include "system.h"
 #include "block.h"
@@ -39,48 +39,48 @@ void block_source_close(struct reftable_block_source *source)
 	source->ops = NULL;
 }
 
-static struct reftable_reader_offsets *
-reader_offsets_for(struct reftable_reader *r, uint8_t typ)
+static struct reftable_table_offsets *
+table_offsets_for(struct reftable_table *t, uint8_t typ)
 {
 	switch (typ) {
 	case BLOCK_TYPE_REF:
-		return &r->ref_offsets;
+		return &t->ref_offsets;
 	case BLOCK_TYPE_LOG:
-		return &r->log_offsets;
+		return &t->log_offsets;
 	case BLOCK_TYPE_OBJ:
-		return &r->obj_offsets;
+		return &t->obj_offsets;
 	}
 	abort();
 }
 
-static int reader_get_block(struct reftable_reader *r,
-			    struct reftable_block *dest, uint64_t off,
-			    uint32_t sz)
+static int table_get_block(struct reftable_table *t,
+			   struct reftable_block *dest, uint64_t off,
+			   uint32_t sz)
 {
 	ssize_t bytes_read;
-	if (off >= r->size)
+	if (off >= t->size)
 		return 0;
-	if (off + sz > r->size)
-		sz = r->size - off;
+	if (off + sz > t->size)
+		sz = t->size - off;
 
-	bytes_read = block_source_read_block(&r->source, dest, off, sz);
+	bytes_read = block_source_read_block(&t->source, dest, off, sz);
 	if (bytes_read < 0)
 		return (int)bytes_read;
 
 	return 0;
 }
 
-enum reftable_hash reftable_reader_hash_id(struct reftable_reader *r)
+enum reftable_hash reftable_table_hash_id(struct reftable_table *t)
 {
-	return r->hash_id;
+	return t->hash_id;
 }
 
-const char *reader_name(struct reftable_reader *r)
+const char *reftable_table_name(struct reftable_table *t)
 {
-	return r->name;
+	return t->name;
 }
 
-static int parse_footer(struct reftable_reader *r, uint8_t *footer,
+static int parse_footer(struct reftable_table *t, uint8_t *footer,
 			uint8_t *header)
 {
 	uint8_t *f = footer;
@@ -95,29 +95,29 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 	}
 	f += 4;
 
-	if (memcmp(footer, header, header_size(r->version))) {
+	if (memcmp(footer, header, header_size(t->version))) {
 		err = REFTABLE_FORMAT_ERROR;
 		goto done;
 	}
 
 	f++;
-	r->block_size = reftable_get_be24(f);
+	t->block_size = reftable_get_be24(f);
 
 	f += 3;
-	r->min_update_index = reftable_get_be64(f);
+	t->min_update_index = reftable_get_be64(f);
 	f += 8;
-	r->max_update_index = reftable_get_be64(f);
+	t->max_update_index = reftable_get_be64(f);
 	f += 8;
 
-	if (r->version == 1) {
-		r->hash_id = REFTABLE_HASH_SHA1;
+	if (t->version == 1) {
+		t->hash_id = REFTABLE_HASH_SHA1;
 	} else {
 		switch (reftable_get_be32(f)) {
 		case REFTABLE_FORMAT_ID_SHA1:
-			r->hash_id = REFTABLE_HASH_SHA1;
+			t->hash_id = REFTABLE_HASH_SHA1;
 			break;
 		case REFTABLE_FORMAT_ID_SHA256:
-			r->hash_id = REFTABLE_HASH_SHA256;
+			t->hash_id = REFTABLE_HASH_SHA256;
 			break;
 		default:
 			err = REFTABLE_FORMAT_ERROR;
@@ -127,20 +127,20 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 		f += 4;
 	}
 
-	r->ref_offsets.index_offset = reftable_get_be64(f);
+	t->ref_offsets.index_offset = reftable_get_be64(f);
 	f += 8;
 
-	r->obj_offsets.offset = reftable_get_be64(f);
+	t->obj_offsets.offset = reftable_get_be64(f);
 	f += 8;
 
-	r->object_id_len = r->obj_offsets.offset & ((1 << 5) - 1);
-	r->obj_offsets.offset >>= 5;
+	t->object_id_len = t->obj_offsets.offset & ((1 << 5) - 1);
+	t->obj_offsets.offset >>= 5;
 
-	r->obj_offsets.index_offset = reftable_get_be64(f);
+	t->obj_offsets.index_offset = reftable_get_be64(f);
 	f += 8;
-	r->log_offsets.offset = reftable_get_be64(f);
+	t->log_offsets.offset = reftable_get_be64(f);
 	f += 8;
-	r->log_offsets.index_offset = reftable_get_be64(f);
+	t->log_offsets.index_offset = reftable_get_be64(f);
 	f += 8;
 
 	computed_crc = crc32(0, footer, f - footer);
@@ -151,13 +151,13 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 		goto done;
 	}
 
-	first_block_typ = header[header_size(r->version)];
-	r->ref_offsets.is_present = (first_block_typ == BLOCK_TYPE_REF);
-	r->ref_offsets.offset = 0;
-	r->log_offsets.is_present = (first_block_typ == BLOCK_TYPE_LOG ||
-				     r->log_offsets.offset > 0);
-	r->obj_offsets.is_present = r->obj_offsets.offset > 0;
-	if (r->obj_offsets.is_present && !r->object_id_len) {
+	first_block_typ = header[header_size(t->version)];
+	t->ref_offsets.is_present = (first_block_typ == BLOCK_TYPE_REF);
+	t->ref_offsets.offset = 0;
+	t->log_offsets.is_present = (first_block_typ == BLOCK_TYPE_LOG ||
+				     t->log_offsets.offset > 0);
+	t->obj_offsets.is_present = t->obj_offsets.offset > 0;
+	if (t->obj_offsets.is_present && !t->object_id_len) {
 		err = REFTABLE_FORMAT_ERROR;
 		goto done;
 	}
@@ -168,7 +168,7 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 }
 
 struct table_iter {
-	struct reftable_reader *r;
+	struct reftable_table *table;
 	uint8_t typ;
 	uint64_t block_off;
 	struct block_reader br;
@@ -176,12 +176,12 @@ struct table_iter {
 	int is_finished;
 };
 
-static int table_iter_init(struct table_iter *ti, struct reftable_reader *r)
+static int table_iter_init(struct table_iter *ti, struct reftable_table *t)
 {
 	struct block_iter bi = BLOCK_ITER_INIT;
 	memset(ti, 0, sizeof(*ti));
-	reftable_reader_incref(r);
-	ti->r = r;
+	reftable_table_incref(t);
+	ti->table = t;
 	ti->bi = bi;
 	return 0;
 }
@@ -191,7 +191,7 @@ static int table_iter_next_in_block(struct table_iter *ti,
 {
 	int res = block_iter_next(&ti->bi, rec);
 	if (res == 0 && reftable_record_type(rec) == BLOCK_TYPE_REF) {
-		rec->u.ref.update_index += ti->r->min_update_index;
+		rec->u.ref.update_index += ti->table->min_update_index;
 	}
 
 	return res;
@@ -219,26 +219,26 @@ static int32_t extract_block_size(uint8_t *data, uint8_t *typ, uint64_t off,
 	return result;
 }
 
-int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
-			     uint64_t next_off, uint8_t want_typ)
+int table_init_block_reader(struct reftable_table *t, struct block_reader *br,
+			    uint64_t next_off, uint8_t want_typ)
 {
-	int32_t guess_block_size = r->block_size ? r->block_size :
+	int32_t guess_block_size = t->block_size ? t->block_size :
 							 DEFAULT_BLOCK_SIZE;
 	struct reftable_block block = { NULL };
 	uint8_t block_typ = 0;
 	int err = 0;
-	uint32_t header_off = next_off ? 0 : header_size(r->version);
+	uint32_t header_off = next_off ? 0 : header_size(t->version);
 	int32_t block_size = 0;
 
-	if (next_off >= r->size)
+	if (next_off >= t->size)
 		return 1;
 
-	err = reader_get_block(r, &block, next_off, guess_block_size);
+	err = table_get_block(t, &block, next_off, guess_block_size);
 	if (err < 0)
 		goto done;
 
 	block_size = extract_block_size(block.data, &block_typ, next_off,
-					r->version);
+					t->version);
 	if (block_size < 0) {
 		err = block_size;
 		goto done;
@@ -250,14 +250,14 @@ int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
 
 	if (block_size > guess_block_size) {
 		reftable_block_done(&block);
-		err = reader_get_block(r, &block, next_off, block_size);
+		err = table_get_block(t, &block, next_off, block_size);
 		if (err < 0) {
 			goto done;
 		}
 	}
 
-	err = block_reader_init(br, &block, header_off, r->block_size,
-				hash_size(r->hash_id));
+	err = block_reader_init(br, &block, header_off, t->block_size,
+				hash_size(t->hash_id));
 done:
 	reftable_block_done(&block);
 
@@ -268,7 +268,7 @@ static void table_iter_close(struct table_iter *ti)
 {
 	table_iter_block_done(ti);
 	block_iter_close(&ti->bi);
-	reftable_reader_decref(ti->r);
+	reftable_table_decref(ti->table);
 }
 
 static int table_iter_next_block(struct table_iter *ti)
@@ -276,7 +276,7 @@ static int table_iter_next_block(struct table_iter *ti)
 	uint64_t next_block_off = ti->block_off + ti->br.full_block_size;
 	int err;
 
-	err = reader_init_block_reader(ti->r, &ti->br, next_block_off, ti->typ);
+	err = table_init_block_reader(ti->table, &ti->br, next_block_off, ti->typ);
 	if (err > 0)
 		ti->is_finished = 1;
 	if (err)
@@ -326,7 +326,7 @@ static int table_iter_seek_to(struct table_iter *ti, uint64_t off, uint8_t typ)
 {
 	int err;
 
-	err = reader_init_block_reader(ti->r, &ti->br, off, typ);
+	err = table_init_block_reader(ti->table, &ti->br, off, typ);
 	if (err != 0)
 		return err;
 
@@ -339,7 +339,7 @@ static int table_iter_seek_to(struct table_iter *ti, uint64_t off, uint8_t typ)
 
 static int table_iter_seek_start(struct table_iter *ti, uint8_t typ, int index)
 {
-	struct reftable_reader_offsets *offs = reader_offsets_for(ti->r, typ);
+	struct reftable_table_offsets *offs = table_offsets_for(ti->table, typ);
 	uint64_t off = offs->offset;
 	if (index) {
 		off = offs->index_offset;
@@ -518,7 +518,7 @@ static int table_iter_seek(struct table_iter *ti,
 			   struct reftable_record *want)
 {
 	uint8_t typ = reftable_record_type(want);
-	struct reftable_reader_offsets *offs = reader_offsets_for(ti->r, typ);
+	struct reftable_table_offsets *offs = table_offsets_for(ti->table, typ);
 	int err;
 
 	err = table_iter_seek_start(ti, reftable_record_type(want),
@@ -566,11 +566,11 @@ static void iterator_from_table_iter(struct reftable_iterator *it,
 	it->ops = &table_iter_vtable;
 }
 
-int reader_init_iter(struct reftable_reader *r,
-		     struct reftable_iterator *it,
-		     uint8_t typ)
+int table_init_iter(struct reftable_table *t,
+		    struct reftable_iterator *it,
+		    uint8_t typ)
 {
-	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
+	struct reftable_table_offsets *offs = table_offsets_for(t, typ);
 
 	if (offs->is_present) {
 		struct table_iter *ti;
@@ -578,7 +578,7 @@ int reader_init_iter(struct reftable_reader *r,
 		if (!ti)
 			return REFTABLE_OUT_OF_MEMORY_ERROR;
 
-		table_iter_init(ti, r);
+		table_iter_init(ti, t);
 		iterator_from_table_iter(it, ti);
 	} else {
 		iterator_set_empty(it);
@@ -587,31 +587,31 @@ int reader_init_iter(struct reftable_reader *r,
 	return 0;
 }
 
-int reftable_reader_init_ref_iterator(struct reftable_reader *r,
-				      struct reftable_iterator *it)
+int reftable_table_init_ref_iterator(struct reftable_table *t,
+				     struct reftable_iterator *it)
 {
-	return reader_init_iter(r, it, BLOCK_TYPE_REF);
+	return table_init_iter(t, it, BLOCK_TYPE_REF);
 }
 
-int reftable_reader_init_log_iterator(struct reftable_reader *r,
-				      struct reftable_iterator *it)
+int reftable_table_init_log_iterator(struct reftable_table *t,
+				     struct reftable_iterator *it)
 {
-	return reader_init_iter(r, it, BLOCK_TYPE_LOG);
+	return table_init_iter(t, it, BLOCK_TYPE_LOG);
 }
 
-int reftable_reader_new(struct reftable_reader **out,
-			struct reftable_block_source *source, char const *name)
+int reftable_table_new(struct reftable_table **out,
+		       struct reftable_block_source *source, char const *name)
 {
 	struct reftable_block footer = { 0 };
 	struct reftable_block header = { 0 };
-	struct reftable_reader *r;
+	struct reftable_table *t;
 	uint64_t file_size = block_source_size(source);
 	uint32_t read_size;
 	ssize_t bytes_read;
 	int err;
 
-	REFTABLE_CALLOC_ARRAY(r, 1);
-	if (!r) {
+	REFTABLE_CALLOC_ARRAY(t, 1);
+	if (!t) {
 		err = REFTABLE_OUT_OF_MEMORY_ERROR;
 		goto done;
 	}
@@ -636,72 +636,72 @@ int reftable_reader_new(struct reftable_reader **out,
 		err = REFTABLE_FORMAT_ERROR;
 		goto done;
 	}
-	r->version = header.data[4];
-	if (r->version != 1 && r->version != 2) {
+	t->version = header.data[4];
+	if (t->version != 1 && t->version != 2) {
 		err = REFTABLE_FORMAT_ERROR;
 		goto done;
 	}
 
-	r->size = file_size - footer_size(r->version);
-	r->source = *source;
-	r->name = reftable_strdup(name);
-	if (!r->name) {
+	t->size = file_size - footer_size(t->version);
+	t->source = *source;
+	t->name = reftable_strdup(name);
+	if (!t->name) {
 		err = REFTABLE_OUT_OF_MEMORY_ERROR;
 		goto done;
 	}
-	r->hash_id = 0;
-	r->refcount = 1;
+	t->hash_id = 0;
+	t->refcount = 1;
 
-	bytes_read = block_source_read_block(source, &footer, r->size,
-					     footer_size(r->version));
-	if (bytes_read < 0 || (size_t)bytes_read != footer_size(r->version)) {
+	bytes_read = block_source_read_block(source, &footer, t->size,
+					     footer_size(t->version));
+	if (bytes_read < 0 || (size_t)bytes_read != footer_size(t->version)) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
 
-	err = parse_footer(r, footer.data, header.data);
+	err = parse_footer(t, footer.data, header.data);
 	if (err)
 		goto done;
 
-	*out = r;
+	*out = t;
 
 done:
 	reftable_block_done(&footer);
 	reftable_block_done(&header);
 	if (err) {
-		if (r)
-			reftable_free(r->name);
-		reftable_free(r);
+		if (t)
+			reftable_free(t->name);
+		reftable_free(t);
 		block_source_close(source);
 	}
 	return err;
 }
 
-void reftable_reader_incref(struct reftable_reader *r)
+void reftable_table_incref(struct reftable_table *t)
 {
-	r->refcount++;
+	t->refcount++;
 }
 
-void reftable_reader_decref(struct reftable_reader *r)
+void reftable_table_decref(struct reftable_table *t)
 {
-	if (!r)
+	if (!t)
 		return;
-	if (--r->refcount)
+	if (--t->refcount)
 		return;
-	block_source_close(&r->source);
-	REFTABLE_FREE_AND_NULL(r->name);
-	reftable_free(r);
+	block_source_close(&t->source);
+	REFTABLE_FREE_AND_NULL(t->name);
+	reftable_free(t);
 }
 
-static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
-					    struct reftable_iterator *it,
-					    uint8_t *oid)
+static int reftable_table_refs_for_indexed(struct reftable_table *t,
+					   struct reftable_iterator *it,
+					   uint8_t *oid)
 {
 	struct reftable_record want = {
 		.type = BLOCK_TYPE_OBJ,
 		.u.obj = {
 			.hash_prefix = oid,
-			.hash_prefix_len = r->object_id_len,
+			.hash_prefix_len = t->object_id_len,
 		},
 	};
 	struct reftable_iterator oit = { NULL };
@@ -713,7 +713,7 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 	struct indexed_table_ref_iter *itr = NULL;
 
 	/* Look through the reverse index. */
-	err = reader_init_iter(r, &oit, BLOCK_TYPE_OBJ);
+	err = table_init_iter(t, &oit, BLOCK_TYPE_OBJ);
 	if (err < 0)
 		goto done;
 
@@ -727,14 +727,14 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 		goto done;
 
 	if (err > 0 || memcmp(want.u.obj.hash_prefix, got.u.obj.hash_prefix,
-			      r->object_id_len)) {
+			      t->object_id_len)) {
 		/* didn't find it; return empty iterator */
 		iterator_set_empty(it);
 		err = 0;
 		goto done;
 	}
 
-	err = indexed_table_ref_iter_new(&itr, r, oid, hash_size(r->hash_id),
+	err = indexed_table_ref_iter_new(&itr, t, oid, hash_size(t->hash_id),
 					 got.u.obj.offsets,
 					 got.u.obj.offset_len);
 	if (err < 0)
@@ -748,14 +748,14 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 	return err;
 }
 
-static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
-					      struct reftable_iterator *it,
-					      uint8_t *oid)
+static int reftable_table_refs_for_unindexed(struct reftable_table *t,
+					     struct reftable_iterator *it,
+					     uint8_t *oid)
 {
 	struct table_iter *ti;
 	struct filtering_ref_iterator *filter = NULL;
 	struct filtering_ref_iterator empty = FILTERING_REF_ITERATOR_INIT;
-	uint32_t oid_len = hash_size(r->hash_id);
+	uint32_t oid_len = hash_size(t->hash_id);
 	int err;
 
 	REFTABLE_ALLOC_ARRAY(ti, 1);
@@ -764,7 +764,7 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 		goto out;
 	}
 
-	table_iter_init(ti, r);
+	table_iter_init(ti, t);
 	err = table_iter_seek_start(ti, BLOCK_TYPE_REF, 0);
 	if (err < 0)
 		goto out;
@@ -795,25 +795,25 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 	return err;
 }
 
-int reftable_reader_refs_for(struct reftable_reader *r,
-			     struct reftable_iterator *it, uint8_t *oid)
+int reftable_table_refs_for(struct reftable_table *t,
+			    struct reftable_iterator *it, uint8_t *oid)
 {
-	if (r->obj_offsets.is_present)
-		return reftable_reader_refs_for_indexed(r, it, oid);
-	return reftable_reader_refs_for_unindexed(r, it, oid);
+	if (t->obj_offsets.is_present)
+		return reftable_table_refs_for_indexed(t, it, oid);
+	return reftable_table_refs_for_unindexed(t, it, oid);
 }
 
-uint64_t reftable_reader_max_update_index(struct reftable_reader *r)
+uint64_t reftable_table_max_update_index(struct reftable_table *t)
 {
-	return r->max_update_index;
+	return t->max_update_index;
 }
 
-uint64_t reftable_reader_min_update_index(struct reftable_reader *r)
+uint64_t reftable_table_min_update_index(struct reftable_table *t)
 {
-	return r->min_update_index;
+	return t->min_update_index;
 }
 
-int reftable_reader_print_blocks(const char *tablename)
+int reftable_table_print_blocks(const char *tablename)
 {
 	struct {
 		const char *name;
@@ -833,7 +833,7 @@ int reftable_reader_print_blocks(const char *tablename)
 		},
 	};
 	struct reftable_block_source src = { 0 };
-	struct reftable_reader *r = NULL;
+	struct reftable_table *table = NULL;
 	struct table_iter ti = { 0 };
 	size_t i;
 	int err;
@@ -842,14 +842,14 @@ int reftable_reader_print_blocks(const char *tablename)
 	if (err < 0)
 		goto done;
 
-	err = reftable_reader_new(&r, &src, tablename);
+	err = reftable_table_new(&table, &src, tablename);
 	if (err < 0)
 		goto done;
 
-	table_iter_init(&ti, r);
+	table_iter_init(&ti, table);
 
 	printf("header:\n");
-	printf("  block_size: %d\n", r->block_size);
+	printf("  block_size: %d\n", table->block_size);
 
 	for (i = 0; i < sizeof(sections) / sizeof(*sections); i++) {
 		err = table_iter_seek_start(&ti, sections[i].type, 0);
@@ -873,7 +873,7 @@ int reftable_reader_print_blocks(const char *tablename)
 	}
 
 done:
-	reftable_reader_decref(r);
+	reftable_table_decref(table);
 	table_iter_close(&ti);
 	return err;
 }
diff --git a/reftable/reader.h b/reftable/table.h
similarity index 65%
rename from reftable/reader.h
rename to reftable/table.h
index c9dccbd6c97..9cd8f80a207 100644
--- a/reftable/reader.h
+++ b/reftable/table.h
@@ -6,13 +6,13 @@
  * https://developers.google.com/open-source/licenses/bsd
  */
 
-#ifndef READER_H
-#define READER_H
+#ifndef TABLE_H
+#define TABLE_H
 
 #include "block.h"
 #include "record.h"
 #include "reftable-iterator.h"
-#include "reftable-reader.h"
+#include "reftable-table.h"
 
 uint64_t block_source_size(struct reftable_block_source *source);
 
@@ -22,14 +22,14 @@ ssize_t block_source_read_block(struct reftable_block_source *source,
 void block_source_close(struct reftable_block_source *source);
 
 /* metadata for a block type */
-struct reftable_reader_offsets {
+struct reftable_table_offsets {
 	int is_present;
 	uint64_t offset;
 	uint64_t index_offset;
 };
 
 /* The state for reading a reftable file. */
-struct reftable_reader {
+struct reftable_table {
 	/* for convenience, associate a name with the instance. */
 	char *name;
 	struct reftable_block_source source;
@@ -47,21 +47,21 @@ struct reftable_reader {
 	int object_id_len;
 	int version;
 
-	struct reftable_reader_offsets ref_offsets;
-	struct reftable_reader_offsets obj_offsets;
-	struct reftable_reader_offsets log_offsets;
+	struct reftable_table_offsets ref_offsets;
+	struct reftable_table_offsets obj_offsets;
+	struct reftable_table_offsets log_offsets;
 
 	uint64_t refcount;
 };
 
-const char *reader_name(struct reftable_reader *r);
+const char *reftable_table_name(struct reftable_table *t);
 
-int reader_init_iter(struct reftable_reader *r,
-		     struct reftable_iterator *it,
-		     uint8_t typ);
+int table_init_iter(struct reftable_table *t,
+		    struct reftable_iterator *it,
+		    uint8_t typ);
 
-/* initialize a block reader to read from `r` */
-int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
-			     uint64_t next_off, uint8_t want_typ);
+/* initialize a block reader to read from `t` */
+int table_init_block_reader(struct reftable_table *t, struct block_reader *br,
+			    uint64_t next_off, uint8_t want_typ);
 
 #endif
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 3c72ed985b3..f8f1956f4f3 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -4,8 +4,8 @@
 #include "reftable/system.h"
 #include "reftable/reftable-error.h"
 #include "reftable/reftable-merged.h"
-#include "reftable/reftable-reader.h"
 #include "reftable/reftable-stack.h"
+#include "reftable/reftable-table.h"
 #include "test-tool.h"
 
 static void print_help(void)
@@ -126,19 +126,19 @@ static int dump_reftable(const char *tablename)
 {
 	struct reftable_block_source src = { 0 };
 	struct reftable_merged_table *mt = NULL;
-	struct reftable_reader *r = NULL;
+	struct reftable_table *table = NULL;
 	int err;
 
 	err = reftable_block_source_from_file(&src, tablename);
 	if (err < 0)
 		goto done;
 
-	err = reftable_reader_new(&r, &src, tablename);
+	err = reftable_table_new(&table, &src, tablename);
 	if (err < 0)
 		goto done;
 
-	err = reftable_merged_table_new(&mt, &r, 1,
-					reftable_reader_hash_id(r));
+	err = reftable_merged_table_new(&mt, &table, 1,
+					reftable_table_hash_id(table));
 	if (err < 0)
 		goto done;
 
@@ -146,7 +146,7 @@ static int dump_reftable(const char *tablename)
 
 done:
 	reftable_merged_table_free(mt);
-	reftable_reader_decref(r);
+	reftable_table_decref(table);
 	return err;
 }
 
@@ -184,7 +184,7 @@ int cmd__dump_reftable(int argc, const char **argv)
 	arg = argv[1];
 
 	if (opt_dump_blocks) {
-		err = reftable_reader_print_blocks(arg);
+		err = reftable_table_print_blocks(arg);
 	} else if (opt_dump_table) {
 		err = dump_reftable(arg);
 	} else if (opt_dump_stack) {
diff --git a/t/meson.build b/t/meson.build
index a59da26be3f..ded928d9e6d 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -56,10 +56,10 @@ unit_test_programs = [
   'unit-tests/t-reftable-block.c',
   'unit-tests/t-reftable-merged.c',
   'unit-tests/t-reftable-pq.c',
-  'unit-tests/t-reftable-reader.c',
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
+  'unit-tests/t-reftable-table.c',
   'unit-tests/t-trailer.c',
   'unit-tests/t-urlmatch-normalization.c',
 ]
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 60836f80d60..fed6beb85c0 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -11,7 +11,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/blocksource.h"
 #include "reftable/constants.h"
 #include "reftable/merged.h"
-#include "reftable/reader.h"
+#include "reftable/table.h"
 #include "reftable/reftable-error.h"
 #include "reftable/reftable-merged.h"
 #include "reftable/reftable-writer.h"
@@ -19,7 +19,7 @@ license that can be found in the LICENSE file or at
 static struct reftable_merged_table *
 merged_table_from_records(struct reftable_ref_record **refs,
 			  struct reftable_block_source **source,
-			  struct reftable_reader ***readers, const size_t *sizes,
+			  struct reftable_table ***tables, const size_t *sizes,
 			  struct reftable_buf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
@@ -28,8 +28,8 @@ merged_table_from_records(struct reftable_ref_record **refs,
 	};
 	int err;
 
-	REFTABLE_CALLOC_ARRAY(*readers, n);
-	check(*readers != NULL);
+	REFTABLE_CALLOC_ARRAY(*tables, n);
+	check(*tables != NULL);
 	REFTABLE_CALLOC_ARRAY(*source, n);
 	check(*source != NULL);
 
@@ -37,21 +37,21 @@ merged_table_from_records(struct reftable_ref_record **refs,
 		t_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
 		block_source_from_buf(&(*source)[i], &buf[i]);
 
-		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
-					  "name");
+		err = reftable_table_new(&(*tables)[i], &(*source)[i],
+					 "name");
 		check(!err);
 	}
 
-	err = reftable_merged_table_new(&mt, *readers, n, REFTABLE_HASH_SHA1);
+	err = reftable_merged_table_new(&mt, *tables, n, REFTABLE_HASH_SHA1);
 	check(!err);
 	return mt;
 }
 
-static void readers_destroy(struct reftable_reader **readers, const size_t n)
+static void tables_destroy(struct reftable_table **tables, const size_t n)
 {
 	for (size_t i = 0; i < n; i++)
-		reftable_reader_decref(readers[i]);
-	reftable_free(readers);
+		reftable_table_decref(tables[i]);
+	reftable_free(tables);
 }
 
 static void t_merged_single_record(void)
@@ -77,9 +77,9 @@ static void t_merged_single_record(void)
 	size_t sizes[] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
 	struct reftable_buf bufs[3] = { REFTABLE_BUF_INIT, REFTABLE_BUF_INIT, REFTABLE_BUF_INIT };
 	struct reftable_block_source *bs = NULL;
-	struct reftable_reader **readers = NULL;
+	struct reftable_table **tables = NULL;
 	struct reftable_merged_table *mt =
-		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
+		merged_table_from_records(refs, &bs, &tables, sizes, bufs, 3);
 	struct reftable_ref_record ref = { 0 };
 	struct reftable_iterator it = { 0 };
 	int err;
@@ -94,7 +94,7 @@ static void t_merged_single_record(void)
 	check(reftable_ref_record_equal(&r2[0], &ref, REFTABLE_HASH_SIZE_SHA1));
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
-	readers_destroy(readers, 3);
+	tables_destroy(tables, 3);
 	reftable_merged_table_free(mt);
 	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
 		reftable_buf_release(&bufs[i]);
@@ -154,9 +154,9 @@ static void t_merged_refs(void)
 	size_t sizes[3] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
 	struct reftable_buf bufs[3] = { REFTABLE_BUF_INIT, REFTABLE_BUF_INIT, REFTABLE_BUF_INIT };
 	struct reftable_block_source *bs = NULL;
-	struct reftable_reader **readers = NULL;
+	struct reftable_table **tables = NULL;
 	struct reftable_merged_table *mt =
-		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
+		merged_table_from_records(refs, &bs, &tables, sizes, bufs, 3);
 	struct reftable_iterator it = { 0 };
 	int err;
 	struct reftable_ref_record *out = NULL;
@@ -193,7 +193,7 @@ static void t_merged_refs(void)
 
 	for (i = 0; i < 3; i++)
 		reftable_buf_release(&bufs[i]);
-	readers_destroy(readers, 3);
+	tables_destroy(tables, 3);
 	reftable_merged_table_free(mt);
 	reftable_free(bs);
 }
@@ -238,12 +238,12 @@ static void t_merged_seek_multiple_times(void)
 		REFTABLE_BUF_INIT, REFTABLE_BUF_INIT,
 	};
 	struct reftable_block_source *sources = NULL;
-	struct reftable_reader **readers = NULL;
+	struct reftable_table **tables = NULL;
 	struct reftable_ref_record rec = { 0 };
 	struct reftable_iterator it = { 0 };
 	struct reftable_merged_table *mt;
 
-	mt = merged_table_from_records(refs, &sources, &readers, sizes, bufs, 2);
+	mt = merged_table_from_records(refs, &sources, &tables, sizes, bufs, 2);
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
 
 	for (size_t i = 0; i < 5; i++) {
@@ -266,7 +266,7 @@ static void t_merged_seek_multiple_times(void)
 
 	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
 		reftable_buf_release(&bufs[i]);
-	readers_destroy(readers, ARRAY_SIZE(refs));
+	tables_destroy(tables, ARRAY_SIZE(refs));
 	reftable_ref_record_release(&rec);
 	reftable_iterator_destroy(&it);
 	reftable_merged_table_free(mt);
@@ -313,13 +313,13 @@ static void t_merged_seek_multiple_times_without_draining(void)
 		REFTABLE_BUF_INIT, REFTABLE_BUF_INIT,
 	};
 	struct reftable_block_source *sources = NULL;
-	struct reftable_reader **readers = NULL;
+	struct reftable_table **tables = NULL;
 	struct reftable_ref_record rec = { 0 };
 	struct reftable_iterator it = { 0 };
 	struct reftable_merged_table *mt;
 	int err;
 
-	mt = merged_table_from_records(refs, &sources, &readers, sizes, bufs, 2);
+	mt = merged_table_from_records(refs, &sources, &tables, sizes, bufs, 2);
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
 
 	err = reftable_iterator_seek_ref(&it, "b");
@@ -338,7 +338,7 @@ static void t_merged_seek_multiple_times_without_draining(void)
 
 	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
 		reftable_buf_release(&bufs[i]);
-	readers_destroy(readers, ARRAY_SIZE(refs));
+	tables_destroy(tables, ARRAY_SIZE(refs));
 	reftable_ref_record_release(&rec);
 	reftable_iterator_destroy(&it);
 	reftable_merged_table_free(mt);
@@ -348,7 +348,7 @@ static void t_merged_seek_multiple_times_without_draining(void)
 static struct reftable_merged_table *
 merged_table_from_log_records(struct reftable_log_record **logs,
 			      struct reftable_block_source **source,
-			      struct reftable_reader ***readers, const size_t *sizes,
+			      struct reftable_table ***tables, const size_t *sizes,
 			      struct reftable_buf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
@@ -358,8 +358,8 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 	};
 	int err;
 
-	REFTABLE_CALLOC_ARRAY(*readers, n);
-	check(*readers != NULL);
+	REFTABLE_CALLOC_ARRAY(*tables, n);
+	check(*tables != NULL);
 	REFTABLE_CALLOC_ARRAY(*source, n);
 	check(*source != NULL);
 
@@ -367,12 +367,12 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 		t_reftable_write_to_buf(&buf[i], NULL, 0, logs[i], sizes[i], &opts);
 		block_source_from_buf(&(*source)[i], &buf[i]);
 
-		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
-					  "name");
+		err = reftable_table_new(&(*tables)[i], &(*source)[i],
+					 "name");
 		check(!err);
 	}
 
-	err = reftable_merged_table_new(&mt, *readers, n, REFTABLE_HASH_SHA1);
+	err = reftable_merged_table_new(&mt, *tables, n, REFTABLE_HASH_SHA1);
 	check(!err);
 	return mt;
 }
@@ -435,9 +435,9 @@ static void t_merged_logs(void)
 	size_t sizes[3] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
 	struct reftable_buf bufs[3] = { REFTABLE_BUF_INIT, REFTABLE_BUF_INIT, REFTABLE_BUF_INIT };
 	struct reftable_block_source *bs = NULL;
-	struct reftable_reader **readers = NULL;
+	struct reftable_table **tables = NULL;
 	struct reftable_merged_table *mt = merged_table_from_log_records(
-		logs, &bs, &readers, sizes, bufs, 3);
+		logs, &bs, &tables, sizes, bufs, 3);
 	struct reftable_iterator it = { 0 };
 	int err;
 	struct reftable_log_record *out = NULL;
@@ -485,7 +485,7 @@ static void t_merged_logs(void)
 
 	for (i = 0; i < 3; i++)
 		reftable_buf_release(&bufs[i]);
-	readers_destroy(readers, 3);
+	tables_destroy(tables, 3);
 	reftable_merged_table_free(mt);
 	reftable_free(bs);
 }
@@ -502,7 +502,7 @@ static void t_default_write_opts(void)
 	int err;
 	struct reftable_block_source source = { 0 };
 	uint32_t hash_id;
-	struct reftable_reader *rd = NULL;
+	struct reftable_table *table = NULL;
 	struct reftable_merged_table *merged = NULL;
 
 	reftable_writer_set_limits(w, 1, 1);
@@ -516,18 +516,18 @@ static void t_default_write_opts(void)
 
 	block_source_from_buf(&source, &buf);
 
-	err = reftable_reader_new(&rd, &source, "filename");
+	err = reftable_table_new(&table, &source, "filename");
 	check(!err);
 
-	hash_id = reftable_reader_hash_id(rd);
+	hash_id = reftable_table_hash_id(table);
 	check_int(hash_id, ==, REFTABLE_HASH_SHA1);
 
-	err = reftable_merged_table_new(&merged, &rd, 1, REFTABLE_HASH_SHA256);
+	err = reftable_merged_table_new(&merged, &table, 1, REFTABLE_HASH_SHA256);
 	check_int(err, ==, REFTABLE_FORMAT_ERROR);
-	err = reftable_merged_table_new(&merged, &rd, 1, REFTABLE_HASH_SHA1);
+	err = reftable_merged_table_new(&merged, &table, 1, REFTABLE_HASH_SHA1);
 	check(!err);
 
-	reftable_reader_decref(rd);
+	reftable_table_decref(table);
 	reftable_merged_table_free(merged);
 	reftable_buf_release(&buf);
 }
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index c9626831dac..c4c27242ba9 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -12,9 +12,9 @@ license that can be found in the LICENSE file or at
 #include "lib-reftable.h"
 #include "reftable/basics.h"
 #include "reftable/blocksource.h"
-#include "reftable/reader.h"
 #include "reftable/reftable-error.h"
 #include "reftable/reftable-writer.h"
+#include "reftable/table.h"
 #include "strbuf.h"
 
 static const int update_index = 5;
@@ -204,7 +204,7 @@ static void t_log_write_read(void)
 	struct reftable_ref_record ref = { 0 };
 	struct reftable_log_record log = { 0 };
 	struct reftable_iterator it = { 0 };
-	struct reftable_reader *reader;
+	struct reftable_table *table;
 	struct reftable_block_source source = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
@@ -254,10 +254,10 @@ static void t_log_write_read(void)
 
 	block_source_from_buf(&source, &buf);
 
-	err = reftable_reader_new(&reader, &source, "file.log");
+	err = reftable_table_new(&table, &source, "file.log");
 	check(!err);
 
-	err = reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_table_init_ref_iterator(table, &it);
 	check(!err);
 
 	err = reftable_iterator_seek_ref(&it, names[N - 1]);
@@ -273,7 +273,7 @@ static void t_log_write_read(void)
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
 
-	err = reftable_reader_init_log_iterator(reader, &it);
+	err = reftable_table_init_log_iterator(table, &it);
 	check(!err);
 	err = reftable_iterator_seek_log(&it, "");
 	check(!err);
@@ -294,7 +294,7 @@ static void t_log_write_read(void)
 	/* cleanup. */
 	reftable_buf_release(&buf);
 	free_names(names);
-	reftable_reader_decref(reader);
+	reftable_table_decref(table);
 }
 
 static void t_log_zlib_corruption(void)
@@ -303,7 +303,7 @@ static void t_log_zlib_corruption(void)
 		.block_size = 256,
 	};
 	struct reftable_iterator it = { 0 };
-	struct reftable_reader *reader;
+	struct reftable_table *table;
 	struct reftable_block_source source = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
@@ -345,10 +345,10 @@ static void t_log_zlib_corruption(void)
 
 	block_source_from_buf(&source, &buf);
 
-	err = reftable_reader_new(&reader, &source, "file.log");
+	err = reftable_table_new(&table, &source, "file.log");
 	check(!err);
 
-	err = reftable_reader_init_log_iterator(reader, &it);
+	err = reftable_table_init_log_iterator(table, &it);
 	check(!err);
 	err = reftable_iterator_seek_log(&it, "refname");
 	check_int(err, ==, REFTABLE_ZLIB_ERROR);
@@ -356,7 +356,7 @@ static void t_log_zlib_corruption(void)
 	reftable_iterator_destroy(&it);
 
 	/* cleanup. */
-	reftable_reader_decref(reader);
+	reftable_table_decref(table);
 	reftable_buf_release(&buf);
 }
 
@@ -367,7 +367,7 @@ static void t_table_read_write_sequential(void)
 	int N = 50;
 	struct reftable_iterator it = { 0 };
 	struct reftable_block_source source = { 0 };
-	struct reftable_reader *reader;
+	struct reftable_table *table;
 	int err = 0;
 	int j = 0;
 
@@ -375,10 +375,10 @@ static void t_table_read_write_sequential(void)
 
 	block_source_from_buf(&source, &buf);
 
-	err = reftable_reader_new(&reader, &source, "file.ref");
+	err = reftable_table_new(&table, &source, "file.ref");
 	check(!err);
 
-	err = reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_table_init_ref_iterator(table, &it);
 	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
@@ -396,7 +396,7 @@ static void t_table_read_write_sequential(void)
 	check_int(j, ==, N);
 
 	reftable_iterator_destroy(&it);
-	reftable_reader_decref(reader);
+	reftable_table_decref(table);
 	reftable_buf_release(&buf);
 	free_names(names);
 }
@@ -417,7 +417,7 @@ static void t_table_read_api(void)
 	char **names;
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int N = 50;
-	struct reftable_reader *reader;
+	struct reftable_table *table;
 	struct reftable_block_source source = { 0 };
 	int err;
 	struct reftable_log_record log = { 0 };
@@ -427,10 +427,10 @@ static void t_table_read_api(void)
 
 	block_source_from_buf(&source, &buf);
 
-	err = reftable_reader_new(&reader, &source, "file.ref");
+	err = reftable_table_new(&table, &source, "file.ref");
 	check(!err);
 
-	err = reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_table_init_ref_iterator(table, &it);
 	check(!err);
 	err = reftable_iterator_seek_ref(&it, names[0]);
 	check(!err);
@@ -441,7 +441,7 @@ static void t_table_read_api(void)
 	reftable_buf_release(&buf);
 	free_names(names);
 	reftable_iterator_destroy(&it);
-	reftable_reader_decref(reader);
+	reftable_table_decref(table);
 	reftable_buf_release(&buf);
 }
 
@@ -450,7 +450,7 @@ static void t_table_read_write_seek(int index, enum reftable_hash hash_id)
 	char **names;
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int N = 50;
-	struct reftable_reader *reader;
+	struct reftable_table *table;
 	struct reftable_block_source source = { 0 };
 	int err;
 	int i = 0;
@@ -463,18 +463,18 @@ static void t_table_read_write_seek(int index, enum reftable_hash hash_id)
 
 	block_source_from_buf(&source, &buf);
 
-	err = reftable_reader_new(&reader, &source, "file.ref");
+	err = reftable_table_new(&table, &source, "file.ref");
 	check(!err);
-	check_int(hash_id, ==, reftable_reader_hash_id(reader));
+	check_int(hash_id, ==, reftable_table_hash_id(table));
 
 	if (!index) {
-		reader->ref_offsets.index_offset = 0;
+		table->ref_offsets.index_offset = 0;
 	} else {
-		check_int(reader->ref_offsets.index_offset, >, 0);
+		check_int(table->ref_offsets.index_offset, >, 0);
 	}
 
 	for (i = 1; i < N; i++) {
-		err = reftable_reader_init_ref_iterator(reader, &it);
+		err = reftable_table_init_ref_iterator(table, &it);
 		check(!err);
 		err = reftable_iterator_seek_ref(&it, names[i]);
 		check(!err);
@@ -491,7 +491,7 @@ static void t_table_read_write_seek(int index, enum reftable_hash hash_id)
 	check(!reftable_buf_addstr(&pastLast, names[N - 1]));
 	check(!reftable_buf_addstr(&pastLast, "/"));
 
-	err = reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_table_init_ref_iterator(table, &it);
 	check(!err);
 	err = reftable_iterator_seek_ref(&it, pastLast.buf);
 	if (err == 0) {
@@ -507,7 +507,7 @@ static void t_table_read_write_seek(int index, enum reftable_hash hash_id)
 
 	reftable_buf_release(&buf);
 	free_names(names);
-	reftable_reader_decref(reader);
+	reftable_table_decref(table);
 }
 
 static void t_table_read_write_seek_linear(void)
@@ -535,7 +535,7 @@ static void t_table_refs_for(int indexed)
 		.block_size = 256,
 	};
 	struct reftable_ref_record ref = { 0 };
-	struct reftable_reader *reader;
+	struct reftable_table *table;
 	struct reftable_block_source source = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
@@ -585,18 +585,18 @@ static void t_table_refs_for(int indexed)
 
 	block_source_from_buf(&source, &buf);
 
-	err = reftable_reader_new(&reader, &source, "file.ref");
+	err = reftable_table_new(&table, &source, "file.ref");
 	check(!err);
 	if (!indexed)
-		reader->obj_offsets.is_present = 0;
+		table->obj_offsets.is_present = 0;
 
-	err = reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_table_init_ref_iterator(table, &it);
 	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 	reftable_iterator_destroy(&it);
 
-	err = reftable_reader_refs_for(reader, &it, want_hash);
+	err = reftable_table_refs_for(table, &it, want_hash);
 	check(!err);
 
 	for (j = 0; ; j++) {
@@ -613,7 +613,7 @@ static void t_table_refs_for(int indexed)
 	reftable_buf_release(&buf);
 	free_names(want_names);
 	reftable_iterator_destroy(&it);
-	reftable_reader_decref(reader);
+	reftable_table_decref(table);
 }
 
 static void t_table_refs_for_no_index(void)
@@ -632,7 +632,7 @@ static void t_write_empty_table(void)
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_block_source source = { 0 };
-	struct reftable_reader *rd = NULL;
+	struct reftable_table *table = NULL;
 	struct reftable_ref_record rec = { 0 };
 	struct reftable_iterator it = { 0 };
 	int err;
@@ -647,10 +647,10 @@ static void t_write_empty_table(void)
 
 	block_source_from_buf(&source, &buf);
 
-	err = reftable_reader_new(&rd, &source, "filename");
+	err = reftable_table_new(&table, &source, "filename");
 	check(!err);
 
-	err = reftable_reader_init_ref_iterator(rd, &it);
+	err = reftable_table_init_ref_iterator(table, &it);
 	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
@@ -659,7 +659,7 @@ static void t_write_empty_table(void)
 	check_int(err, >, 0);
 
 	reftable_iterator_destroy(&it);
-	reftable_reader_decref(rd);
+	reftable_table_decref(table);
 	reftable_buf_release(&buf);
 }
 
@@ -803,7 +803,7 @@ static void t_write_multiple_indices(void)
 	struct reftable_iterator it = { 0 };
 	const struct reftable_stats *stats;
 	struct reftable_writer *writer;
-	struct reftable_reader *reader;
+	struct reftable_table *table;
 	char buf[128];
 	int err, i;
 
@@ -852,21 +852,21 @@ static void t_write_multiple_indices(void)
 	check_int(stats->log_stats.index_offset, >, 0);
 
 	block_source_from_buf(&source, &writer_buf);
-	err = reftable_reader_new(&reader, &source, "filename");
+	err = reftable_table_new(&table, &source, "filename");
 	check(!err);
 
 	/*
 	 * Seeking the log uses the log index now. In case there is any
 	 * confusion regarding indices we would notice here.
 	 */
-	err = reftable_reader_init_log_iterator(reader, &it);
+	err = reftable_table_init_log_iterator(table, &it);
 	check(!err);
 	err = reftable_iterator_seek_log(&it, "");
 	check(!err);
 
 	reftable_iterator_destroy(&it);
 	reftable_writer_free(writer);
-	reftable_reader_decref(reader);
+	reftable_table_decref(table);
 	reftable_buf_release(&writer_buf);
 }
 
@@ -880,7 +880,7 @@ static void t_write_multi_level_index(void)
 	struct reftable_iterator it = { 0 };
 	const struct reftable_stats *stats;
 	struct reftable_writer *writer;
-	struct reftable_reader *reader;
+	struct reftable_table *table;
 	int err;
 
 	writer = t_reftable_strbuf_writer(&writer_buf, &opts);
@@ -909,20 +909,20 @@ static void t_write_multi_level_index(void)
 	check_int(stats->ref_stats.max_index_level, ==, 2);
 
 	block_source_from_buf(&source, &writer_buf);
-	err = reftable_reader_new(&reader, &source, "filename");
+	err = reftable_table_new(&table, &source, "filename");
 	check(!err);
 
 	/*
 	 * Seeking the last ref should work as expected.
 	 */
-	err = reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_table_init_ref_iterator(table, &it);
 	check(!err);
 	err = reftable_iterator_seek_ref(&it, "refs/heads/199");
 	check(!err);
 
 	reftable_iterator_destroy(&it);
 	reftable_writer_free(writer);
-	reftable_reader_decref(reader);
+	reftable_table_decref(table);
 	reftable_buf_release(&writer_buf);
 	reftable_buf_release(&buf);
 }
@@ -931,11 +931,11 @@ static void t_corrupt_table_empty(void)
 {
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_block_source source = { 0 };
-	struct reftable_reader *reader;
+	struct reftable_table *table;
 	int err;
 
 	block_source_from_buf(&source, &buf);
-	err = reftable_reader_new(&reader, &source, "file.log");
+	err = reftable_table_new(&table, &source, "file.log");
 	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 }
 
@@ -944,12 +944,12 @@ static void t_corrupt_table(void)
 	uint8_t zeros[1024] = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_block_source source = { 0 };
-	struct reftable_reader *reader;
+	struct reftable_table *table;
 	int err;
 	check(!reftable_buf_add(&buf, zeros, sizeof(zeros)));
 
 	block_source_from_buf(&source, &buf);
-	err = reftable_reader_new(&reader, &source, "file.log");
+	err = reftable_table_new(&table, &source, "file.log");
 	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 
 	reftable_buf_release(&buf);
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index c3f0059c346..2f49c975194 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -12,9 +12,9 @@ license that can be found in the LICENSE file or at
 #include "lib-reftable.h"
 #include "dir.h"
 #include "reftable/merged.h"
-#include "reftable/reader.h"
 #include "reftable/reftable-error.h"
 #include "reftable/stack.h"
+#include "reftable/table.h"
 #include "strbuf.h"
 #include "tempfile.h"
 #include <dirent.h>
@@ -176,7 +176,7 @@ static void t_reftable_stack_add_one(void)
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
 	check(!err);
 	check(reftable_ref_record_equal(&ref, &dest, REFTABLE_HASH_SIZE_SHA1));
-	check_int(st->readers_len, >, 0);
+	check_int(st->tables_len, >, 0);
 
 #ifndef GIT_WINDOWS_NATIVE
 	check(!reftable_buf_addstr(&scratch, dir));
@@ -189,7 +189,7 @@ static void t_reftable_stack_add_one(void)
 	check(!reftable_buf_addstr(&scratch, dir));
 	check(!reftable_buf_addstr(&scratch, "/"));
 	/* do not try at home; not an external API for reftable. */
-	check(!reftable_buf_addstr(&scratch, st->readers[0]->name));
+	check(!reftable_buf_addstr(&scratch, st->tables[0]->name));
 	err = stat(scratch.buf, &stat_result);
 	check(!err);
 	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
@@ -402,9 +402,9 @@ static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 		 * all tables in the stack.
 		 */
 		if (i != n)
-			check_int(st->merged->readers_len, ==, i + 1);
+			check_int(st->merged->tables_len, ==, i + 1);
 		else
-			check_int(st->merged->readers_len, ==, 1);
+			check_int(st->merged->tables_len, ==, 1);
 	}
 
 	reftable_stack_destroy(st);
@@ -430,7 +430,7 @@ static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 
 	err = reftable_stack_add(st, write_test_ref, &ref);
 	check(!err);
-	check_int(st->merged->readers_len, ==, 1);
+	check_int(st->merged->tables_len, ==, 1);
 	check_int(st->stats.attempts, ==, 0);
 	check_int(st->stats.failures, ==, 0);
 
@@ -441,14 +441,14 @@ static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 	 */
 	check(!reftable_buf_addstr(&table_path, dir));
 	check(!reftable_buf_addstr(&table_path, "/"));
-	check(!reftable_buf_addstr(&table_path, st->readers[0]->name));
+	check(!reftable_buf_addstr(&table_path, st->tables[0]->name));
 	check(!reftable_buf_addstr(&table_path, ".lock"));
 	write_file_buf(table_path.buf, "", 0);
 
 	ref.update_index = 2;
 	err = reftable_stack_add(st, write_test_ref, &ref);
 	check(!err);
-	check_int(st->merged->readers_len, ==, 2);
+	check_int(st->merged->tables_len, ==, 2);
 	check_int(st->stats.attempts, ==, 1);
 	check_int(st->stats.failures, ==, 1);
 
@@ -592,7 +592,7 @@ static void t_reftable_stack_add(void)
 	check(!reftable_buf_addstr(&path, dir));
 	check(!reftable_buf_addstr(&path, "/"));
 	/* do not try at home; not an external API for reftable. */
-	check(!reftable_buf_addstr(&path, st->readers[0]->name));
+	check(!reftable_buf_addstr(&path, st->tables[0]->name));
 	err = stat(path.buf, &stat_result);
 	check(!err);
 	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
@@ -1026,7 +1026,7 @@ static void t_reftable_stack_auto_compaction(void)
 
 		err = reftable_stack_auto_compact(st);
 		check(!err);
-		check(i < 2 || st->merged->readers_len < 2 * fastlogN(i, 2));
+		check(i < 2 || st->merged->tables_len < 2 * fastlogN(i, 2));
 	}
 
 	check_int(reftable_stack_compaction_stats(st)->entries_written, <,
@@ -1061,7 +1061,7 @@ static void t_reftable_stack_auto_compaction_factor(void)
 		err = reftable_stack_add(st, &write_test_ref, &ref);
 		check(!err);
 
-		check(i < 5 || st->merged->readers_len < 5 * fastlogN(i, 5));
+		check(i < 5 || st->merged->tables_len < 5 * fastlogN(i, 5));
 	}
 
 	reftable_stack_destroy(st);
@@ -1082,7 +1082,7 @@ static void t_reftable_stack_auto_compaction_with_locked_tables(void)
 	check(!err);
 
 	write_n_ref_tables(st, 5);
-	check_int(st->merged->readers_len, ==, 5);
+	check_int(st->merged->tables_len, ==, 5);
 
 	/*
 	 * Given that all tables we have written should be roughly the same
@@ -1091,7 +1091,7 @@ static void t_reftable_stack_auto_compaction_with_locked_tables(void)
 	 */
 	check(!reftable_buf_addstr(&buf, dir));
 	check(!reftable_buf_addstr(&buf, "/"));
-	check(!reftable_buf_addstr(&buf, st->readers[2]->name));
+	check(!reftable_buf_addstr(&buf, st->tables[2]->name));
 	check(!reftable_buf_addstr(&buf, ".lock"));
 	write_file_buf(buf.buf, "", 0);
 
@@ -1104,7 +1104,7 @@ static void t_reftable_stack_auto_compaction_with_locked_tables(void)
 	err = reftable_stack_auto_compact(st);
 	check(!err);
 	check_int(st->stats.failures, ==, 0);
-	check_int(st->merged->readers_len, ==, 4);
+	check_int(st->merged->tables_len, ==, 4);
 
 	reftable_stack_destroy(st);
 	reftable_buf_release(&buf);
@@ -1149,9 +1149,9 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 		 * all tables in the stack.
 		 */
 		if (i != n)
-			check_int(st->merged->readers_len, ==, i + 1);
+			check_int(st->merged->tables_len, ==, i + 1);
 		else
-			check_int(st->merged->readers_len, ==, 1);
+			check_int(st->merged->tables_len, ==, 1);
 	}
 
 	reftable_stack_destroy(st);
@@ -1172,12 +1172,12 @@ static void t_reftable_stack_compaction_with_locked_tables(void)
 	check(!err);
 
 	write_n_ref_tables(st, 3);
-	check_int(st->merged->readers_len, ==, 3);
+	check_int(st->merged->tables_len, ==, 3);
 
 	/* Lock one of the tables that we're about to compact. */
 	check(!reftable_buf_addstr(&buf, dir));
 	check(!reftable_buf_addstr(&buf, "/"));
-	check(!reftable_buf_addstr(&buf, st->readers[1]->name));
+	check(!reftable_buf_addstr(&buf, st->tables[1]->name));
 	check(!reftable_buf_addstr(&buf, ".lock"));
 	write_file_buf(buf.buf, "", 0);
 
@@ -1188,7 +1188,7 @@ static void t_reftable_stack_compaction_with_locked_tables(void)
 	err = reftable_stack_compact_all(st, NULL);
 	check_int(err, ==, REFTABLE_LOCK_ERROR);
 	check_int(st->stats.failures, ==, 1);
-	check_int(st->merged->readers_len, ==, 3);
+	check_int(st->merged->tables_len, ==, 3);
 
 	reftable_stack_destroy(st);
 	reftable_buf_release(&buf);
@@ -1222,10 +1222,10 @@ static void t_reftable_stack_compaction_concurrent(void)
 static void unclean_stack_close(struct reftable_stack *st)
 {
 	/* break abstraction boundary to simulate unclean shutdown. */
-	for (size_t i = 0; i < st->readers_len; i++)
-		reftable_reader_decref(st->readers[i]);
-	st->readers_len = 0;
-	REFTABLE_FREE_AND_NULL(st->readers);
+	for (size_t i = 0; i < st->tables_len; i++)
+		reftable_table_decref(st->tables[i]);
+	st->tables_len = 0;
+	REFTABLE_FREE_AND_NULL(st->tables);
 }
 
 static void t_reftable_stack_compaction_concurrent_clean(void)
@@ -1275,7 +1275,7 @@ static void t_reftable_stack_read_across_reload(void)
 	err = reftable_new_stack(&st1, dir, &opts);
 	check(!err);
 	write_n_ref_tables(st1, 2);
-	check_int(st1->merged->readers_len, ==, 2);
+	check_int(st1->merged->tables_len, ==, 2);
 	reftable_stack_init_ref_iterator(st1, &it);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
@@ -1283,10 +1283,10 @@ static void t_reftable_stack_read_across_reload(void)
 	/* Set up a second stack for the same directory and compact it. */
 	err = reftable_new_stack(&st2, dir, &opts);
 	check(!err);
-	check_int(st2->merged->readers_len, ==, 2);
+	check_int(st2->merged->tables_len, ==, 2);
 	err = reftable_stack_compact_all(st2, NULL);
 	check(!err);
-	check_int(st2->merged->readers_len, ==, 1);
+	check_int(st2->merged->tables_len, ==, 1);
 
 	/*
 	 * Verify that we can continue to use the old iterator even after we
@@ -1294,7 +1294,7 @@ static void t_reftable_stack_read_across_reload(void)
 	 */
 	err = reftable_stack_reload(st1);
 	check(!err);
-	check_int(st1->merged->readers_len, ==, 1);
+	check_int(st1->merged->tables_len, ==, 1);
 	err = reftable_iterator_next_ref(&it, &rec);
 	check(!err);
 	check_str(rec.refname, "refs/heads/branch-0000");
@@ -1325,19 +1325,19 @@ static void t_reftable_stack_reload_with_missing_table(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 	write_n_ref_tables(st, 2);
-	check_int(st->merged->readers_len, ==, 2);
+	check_int(st->merged->tables_len, ==, 2);
 	reftable_stack_init_ref_iterator(st, &it);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 
 	/*
 	 * Update the tables.list file with some garbage data, while reusing
-	 * our old readers. This should trigger a partial reload of the stack,
-	 * where we try to reuse our old readers.
+	 * our old tables. This should trigger a partial reload of the stack,
+	 * where we try to reuse our old tables.
 	*/
-	check(!reftable_buf_addstr(&content, st->readers[0]->name));
+	check(!reftable_buf_addstr(&content, st->tables[0]->name));
 	check(!reftable_buf_addstr(&content, "\n"));
-	check(!reftable_buf_addstr(&content, st->readers[1]->name));
+	check(!reftable_buf_addstr(&content, st->tables[1]->name));
 	check(!reftable_buf_addstr(&content, "\n"));
 	check(!reftable_buf_addstr(&content, "garbage\n"));
 	check(!reftable_buf_addstr(&table_path, st->list_file));
@@ -1348,7 +1348,7 @@ static void t_reftable_stack_reload_with_missing_table(void)
 
 	err = reftable_stack_reload(st);
 	check_int(err, ==, -4);
-	check_int(st->merged->readers_len, ==, 2);
+	check_int(st->merged->tables_len, ==, 2);
 
 	/*
 	 * Even though the reload has failed, we should be able to continue
diff --git a/t/unit-tests/t-reftable-reader.c b/t/unit-tests/t-reftable-table.c
similarity index 78%
rename from t/unit-tests/t-reftable-reader.c
rename to t/unit-tests/t-reftable-table.c
index 546df6005e4..77c59dbf46d 100644
--- a/t/unit-tests/t-reftable-reader.c
+++ b/t/unit-tests/t-reftable-table.c
@@ -1,9 +1,9 @@
 #include "test-lib.h"
 #include "lib-reftable.h"
 #include "reftable/blocksource.h"
-#include "reftable/reader.h"
+#include "reftable/table.h"
 
-static int t_reader_seek_once(void)
+static int t_table_seek_once(void)
 {
 	struct reftable_ref_record records[] = {
 		{
@@ -15,17 +15,17 @@ static int t_reader_seek_once(void)
 	struct reftable_block_source source = { 0 };
 	struct reftable_ref_record ref = { 0 };
 	struct reftable_iterator it = { 0 };
-	struct reftable_reader *reader;
+	struct reftable_table *table;
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int ret;
 
 	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
 	block_source_from_buf(&source, &buf);
 
-	ret = reftable_reader_new(&reader, &source, "name");
+	ret = reftable_table_new(&table, &source, "name");
 	check(!ret);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	reftable_table_init_ref_iterator(table, &it);
 	ret = reftable_iterator_seek_ref(&it, "");
 	check(!ret);
 	ret = reftable_iterator_next_ref(&it, &ref);
@@ -39,12 +39,12 @@ static int t_reader_seek_once(void)
 
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
-	reftable_reader_decref(reader);
+	reftable_table_decref(table);
 	reftable_buf_release(&buf);
 	return 0;
 }
 
-static int t_reader_reseek(void)
+static int t_table_reseek(void)
 {
 	struct reftable_ref_record records[] = {
 		{
@@ -56,17 +56,17 @@ static int t_reader_reseek(void)
 	struct reftable_block_source source = { 0 };
 	struct reftable_ref_record ref = { 0 };
 	struct reftable_iterator it = { 0 };
-	struct reftable_reader *reader;
+	struct reftable_table *table;
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int ret;
 
 	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
 	block_source_from_buf(&source, &buf);
 
-	ret = reftable_reader_new(&reader, &source, "name");
+	ret = reftable_table_new(&table, &source, "name");
 	check(!ret);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	reftable_table_init_ref_iterator(table, &it);
 
 	for (size_t i = 0; i < 5; i++) {
 		ret = reftable_iterator_seek_ref(&it, "");
@@ -83,14 +83,14 @@ static int t_reader_reseek(void)
 
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
-	reftable_reader_decref(reader);
+	reftable_table_decref(table);
 	reftable_buf_release(&buf);
 	return 0;
 }
 
 int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 {
-	TEST(t_reader_seek_once(), "reader can seek once");
-	TEST(t_reader_reseek(), "reader can reseek multiple times");
+	TEST(t_table_seek_once(), "table can seek once");
+	TEST(t_table_reseek(), "table can reseek multiple times");
 	return test_done();
 }

-- 
2.49.0.604.gff1f9ca942.dirty

