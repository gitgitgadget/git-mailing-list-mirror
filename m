Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D48E3A28B
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530290; cv=none; b=RiNRgdqvmqZSV4KewFhyinZ4kFN+wQWe/v42D4poY1LYrRXHK1yHTvcBd/BSzZkAmmlHg4lFdwCszyIu+f/005f0myNWcFH7E057gpCqvMizDn081dCHzxD+C048U+5iYChep+NGLHCU9HMDzPU22qcYh8nRdUUU+PQmCBN827M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530290; c=relaxed/simple;
	bh=Vn9wleb72ed7VV7sxY0UMODh/WarwA4HmPehjUor2QE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCMqX/LXuZUOfFXD2di2Nl3UOgzxxAJLJU0Dm/aA6r2VM7S7nuU7LptNuc/ppTdka7qgyHfXZxn1VLbFol76oFCJ/l0BDRLvg71Afi59vZMXhHexbKfJWFBtwpOh/jmhBvkKRyMv6i+Yyw4k5btxjqNd3IM+u8KpMxqftKK3CJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gbSSGHeZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vmsxyhbj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gbSSGHeZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vmsxyhbj"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8BA44138FD36
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 02:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723530287; x=1723616687; bh=IasAY38QGz
	tRIP7BltkufyxcloA3sR/po7ZkxtTffVc=; b=gbSSGHeZ0CooLXbpYv2RQZ2mGZ
	Cmm2iD3u9xSJVbxZT/ZhZ74ILnH6zHXTSJgwzGvHt6vFYnqRfZw1m40A9b79LWs7
	yprjstmw14gGW2UntIw66Ib2IUPRMSTZHbFnGn4hH9c3pH5rZLnNXX6RwIz2VLXD
	dxkw3RalQbrR2uJFsiG+DUkZBrftWljboNBp8GuB5e7fIMOZzzC/hHcMpbYGRFBz
	raDOIQVKzrtQuv/zRVPn/MNNgruwDpwc7AIFPTcwrTL4+C/AWhVzFQ+PRSTic3cg
	i6T5PJLBBhQ/7apLAkO/ZtVSus9LuF1c9HECAzXXapVHCjqF6D4mvcXhUsug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723530287; x=1723616687; bh=IasAY38QGztRIP7BltkufyxcloA3
	sR/po7ZkxtTffVc=; b=VmsxyhbjtMETgQiGWDu9IDqMqsjwjRcTiHk0hv8JfOAJ
	murBWhN+Ne/RqdQwhkwmUUBkfXyL1ZmsSvZR/YW0Owen4CeCoXrHkx2WLgIvYiw7
	KoDDRpZH2vZQarJwHq/y3eQnj3CZVEaPRxfqns/3LY2SYA26oWVTH86DlI0QwJIw
	T9gp9poUpEbRCp51I3OFWlnoWW1/JHhJe3Ngv1qhhVUZPmBwT+fNe9+m/tc9h6in
	EAwD8AOMISUCYl5/34qc5ZhCukZF+Y1gWFIXg0sjiS++RH1czCeNRKJ1C60jbNOx
	//jvDNtiA3HO4Eto9RH8wiW49uBs31l2CyLF5ieoHw==
X-ME-Sender: <xms:L_y6ZoF4yrWQw86dqgEtTVZ0rLREtTt-o1iHQlltPtZsQZU2oBSukA>
    <xme:L_y6ZhVRW4zGqmM1OimjygiiV0l7cmKxFDN8lPHDbEQbo89HynDGMYameCw52WtLj
    IpAU7kT74m-xqR5Cg>
X-ME-Received: <xmr:L_y6ZiK8drqWyT5iLi-dTzewB1bqjNRQSN98PMgU98tdH-2ERJZx4JwVfPKnQk5SSRd5fnOhFpuOX_lvwprPaGQqeKQUK0mb1QfcGCO0gM_-EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeekieekhfefge
    etfefgfeehheekveelgffgtdevleeihfeijeeffeehudehkedvteenucffohhmrghinhep
    ghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:L_y6ZqES0EH_-tf4OuypGI1FtgPWR0BViRaru8CV3h5xz8ZDi085nQ>
    <xmx:L_y6ZuVYBP2grFCfPiBoMr-yvJwMHyGWh4kz0lL-5q1eJZo8UKDx0g>
    <xmx:L_y6ZtMzuqwv2VXby9GFx0yJdJWwKr8uKqz4W2bG49GjUKed_MvqbA>
    <xmx:L_y6Zl00-QiMKk1Igm3nii37XP-nK9HQU7K_wt6n-oDsOPmh8RRA-w>
    <xmx:L_y6ZhdxAIPWpOsVAReVvzUedFAkL6izuVAL32TOvP3lRsK7DsHHjCNi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 53e3087b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 06:24:30 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:24:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/10] reftable/generic: drop interface
Message-ID: <723495adf624cbc483b9c5d9fa4b5b6078e46168.1723528765.git.ps@pks.im>
References: <cover.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723528765.git.ps@pks.im>

The `reftable_table` interface provides a generic infrastructure that
can abstract away whether the underlying table is a single table, or a
merged table. This abstraction can make it rather hard to reason about
the code. We didn't ever use it to implement the reftable backend, and
with the preceding patches in this patch series we in fact don't use it
at all anymore. Furthermore, it became somewhat useless with the recent
refactorings that made it possible to seek reftable iterators multiple
times, as these now provide generic access to tables for us. The
interface is thus redundant and only brings unnecessary complexity with
it.

Remove the `struct reftable_table` interface and its associated
functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                         |  1 -
 reftable/generic.c               | 77 --------------------------------
 reftable/generic.h               | 27 -----------
 reftable/iter.c                  |  1 -
 reftable/iter.h                  |  1 -
 reftable/merged.c                | 38 ----------------
 reftable/reader.c                | 41 -----------------
 reftable/reftable-generic.h      | 44 ------------------
 reftable/reftable-merged.h       |  6 ---
 reftable/reftable-reader.h       |  7 ---
 reftable/stack.c                 |  1 -
 t/unit-tests/t-reftable-merged.c |  1 -
 12 files changed, 245 deletions(-)
 delete mode 100644 reftable/generic.c
 delete mode 100644 reftable/generic.h
 delete mode 100644 reftable/reftable-generic.h

diff --git a/Makefile b/Makefile
index 343f19a488..41dfa0bad2 100644
--- a/Makefile
+++ b/Makefile
@@ -2674,7 +2674,6 @@ REFTABLE_OBJS += reftable/merged.o
 REFTABLE_OBJS += reftable/pq.o
 REFTABLE_OBJS += reftable/reader.o
 REFTABLE_OBJS += reftable/record.o
-REFTABLE_OBJS += reftable/generic.o
 REFTABLE_OBJS += reftable/stack.o
 REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
diff --git a/reftable/generic.c b/reftable/generic.c
deleted file mode 100644
index 495ee9af6b..0000000000
--- a/reftable/generic.c
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "constants.h"
-#include "record.h"
-#include "generic.h"
-#include "iter.h"
-#include "reftable-iterator.h"
-#include "reftable-generic.h"
-
-void table_init_iter(struct reftable_table *tab,
-		     struct reftable_iterator *it,
-		     uint8_t typ)
-{
-
-	tab->ops->init_iter(tab->table_arg, it, typ);
-}
-
-void reftable_table_init_ref_iter(struct reftable_table *tab,
-				  struct reftable_iterator *it)
-{
-	table_init_iter(tab, it, BLOCK_TYPE_REF);
-}
-
-void reftable_table_init_log_iter(struct reftable_table *tab,
-				  struct reftable_iterator *it)
-{
-	table_init_iter(tab, it, BLOCK_TYPE_LOG);
-}
-
-int reftable_table_read_ref(struct reftable_table *tab, const char *name,
-			    struct reftable_ref_record *ref)
-{
-	struct reftable_iterator it = { NULL };
-	int err;
-
-	reftable_table_init_ref_iter(tab, &it);
-
-	err = reftable_iterator_seek_ref(&it, name);
-	if (err)
-		goto done;
-
-	err = reftable_iterator_next_ref(&it, ref);
-	if (err)
-		goto done;
-
-	if (strcmp(ref->refname, name) ||
-	    reftable_ref_record_is_deletion(ref)) {
-		reftable_ref_record_release(ref);
-		err = 1;
-		goto done;
-	}
-
-done:
-	reftable_iterator_destroy(&it);
-	return err;
-}
-
-uint64_t reftable_table_max_update_index(struct reftable_table *tab)
-{
-	return tab->ops->max_update_index(tab->table_arg);
-}
-
-uint64_t reftable_table_min_update_index(struct reftable_table *tab)
-{
-	return tab->ops->min_update_index(tab->table_arg);
-}
-
-uint32_t reftable_table_hash_id(struct reftable_table *tab)
-{
-	return tab->ops->hash_id(tab->table_arg);
-}
diff --git a/reftable/generic.h b/reftable/generic.h
deleted file mode 100644
index 837fbb8df2..0000000000
--- a/reftable/generic.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#ifndef GENERIC_H
-#define GENERIC_H
-
-#include "record.h"
-#include "reftable-generic.h"
-
-/* generic interface to reftables */
-struct reftable_table_vtable {
-	void (*init_iter)(void *tab, struct reftable_iterator *it, uint8_t typ);
-	uint32_t (*hash_id)(void *tab);
-	uint64_t (*min_update_index)(void *tab);
-	uint64_t (*max_update_index)(void *tab);
-};
-
-void table_init_iter(struct reftable_table *tab,
-		     struct reftable_iterator *it,
-		     uint8_t typ);
-
-#endif
diff --git a/reftable/iter.c b/reftable/iter.c
index 844853fad2..4eb7fafd2f 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -11,7 +11,6 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 
 #include "block.h"
-#include "generic.h"
 #include "constants.h"
 #include "reader.h"
 #include "reftable-error.h"
diff --git a/reftable/iter.h b/reftable/iter.h
index 3b401f1259..befc4597df 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -14,7 +14,6 @@ license that can be found in the LICENSE file or at
 #include "record.h"
 
 #include "reftable-iterator.h"
-#include "reftable-generic.h"
 
 /*
  * The virtual function table for implementing generic reftable iterators.
diff --git a/reftable/merged.c b/reftable/merged.c
index 2e72eab306..128a810c55 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -13,7 +13,6 @@ license that can be found in the LICENSE file or at
 #include "pq.h"
 #include "reader.h"
 #include "record.h"
-#include "generic.h"
 #include "reftable-merged.h"
 #include "reftable-error.h"
 #include "system.h"
@@ -270,40 +269,3 @@ uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *mt)
 {
 	return mt->hash_id;
 }
-
-static void reftable_merged_table_init_iter_void(void *tab,
-						 struct reftable_iterator *it,
-						 uint8_t typ)
-{
-	merged_table_init_iter(tab, it, typ);
-}
-
-static uint32_t reftable_merged_table_hash_id_void(void *tab)
-{
-	return reftable_merged_table_hash_id(tab);
-}
-
-static uint64_t reftable_merged_table_min_update_index_void(void *tab)
-{
-	return reftable_merged_table_min_update_index(tab);
-}
-
-static uint64_t reftable_merged_table_max_update_index_void(void *tab)
-{
-	return reftable_merged_table_max_update_index(tab);
-}
-
-static struct reftable_table_vtable merged_table_vtable = {
-	.init_iter = reftable_merged_table_init_iter_void,
-	.hash_id = reftable_merged_table_hash_id_void,
-	.min_update_index = reftable_merged_table_min_update_index_void,
-	.max_update_index = reftable_merged_table_max_update_index_void,
-};
-
-void reftable_table_from_merged_table(struct reftable_table *tab,
-				      struct reftable_merged_table *merged)
-{
-	assert(!tab->ops);
-	tab->ops = &merged_table_vtable;
-	tab->table_arg = merged;
-}
diff --git a/reftable/reader.c b/reftable/reader.c
index fbd93b88df..082cf00b60 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -11,11 +11,9 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 #include "block.h"
 #include "constants.h"
-#include "generic.h"
 #include "iter.h"
 #include "record.h"
 #include "reftable-error.h"
-#include "reftable-generic.h"
 
 uint64_t block_source_size(struct reftable_block_source *source)
 {
@@ -759,45 +757,6 @@ uint64_t reftable_reader_min_update_index(struct reftable_reader *r)
 	return r->min_update_index;
 }
 
-/* generic table interface. */
-
-static void reftable_reader_init_iter_void(void *tab,
-					   struct reftable_iterator *it,
-					   uint8_t typ)
-{
-	reader_init_iter(tab, it, typ);
-}
-
-static uint32_t reftable_reader_hash_id_void(void *tab)
-{
-	return reftable_reader_hash_id(tab);
-}
-
-static uint64_t reftable_reader_min_update_index_void(void *tab)
-{
-	return reftable_reader_min_update_index(tab);
-}
-
-static uint64_t reftable_reader_max_update_index_void(void *tab)
-{
-	return reftable_reader_max_update_index(tab);
-}
-
-static struct reftable_table_vtable reader_vtable = {
-	.init_iter = reftable_reader_init_iter_void,
-	.hash_id = reftable_reader_hash_id_void,
-	.min_update_index = reftable_reader_min_update_index_void,
-	.max_update_index = reftable_reader_max_update_index_void,
-};
-
-void reftable_table_from_reader(struct reftable_table *tab,
-				struct reftable_reader *reader)
-{
-	assert(!tab->ops);
-	tab->ops = &reader_vtable;
-	tab->table_arg = reader;
-}
-
 int reftable_reader_print_blocks(const char *tablename)
 {
 	struct {
diff --git a/reftable/reftable-generic.h b/reftable/reftable-generic.h
deleted file mode 100644
index b8b1323a33..0000000000
--- a/reftable/reftable-generic.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#ifndef REFTABLE_GENERIC_H
-#define REFTABLE_GENERIC_H
-
-#include "reftable-iterator.h"
-
-struct reftable_table_vtable;
-
-/*
- * Provides a unified API for reading tables, either merged tables, or single
- * readers. */
-struct reftable_table {
-	struct reftable_table_vtable *ops;
-	void *table_arg;
-};
-
-void reftable_table_init_ref_iter(struct reftable_table *tab,
-				  struct reftable_iterator *it);
-
-void reftable_table_init_log_iter(struct reftable_table *tab,
-				  struct reftable_iterator *it);
-
-/* returns the hash ID from a generic reftable_table */
-uint32_t reftable_table_hash_id(struct reftable_table *tab);
-
-/* returns the max update_index covered by this table. */
-uint64_t reftable_table_max_update_index(struct reftable_table *tab);
-
-/* returns the min update_index covered by this table. */
-uint64_t reftable_table_min_update_index(struct reftable_table *tab);
-
-/* convenience function to read a single ref. Returns < 0 for error, 0
-   for success, and 1 if ref not found. */
-int reftable_table_read_ref(struct reftable_table *tab, const char *name,
-			    struct reftable_ref_record *ref);
-
-#endif
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index 03c2619c0f..16d19f8df2 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -26,8 +26,6 @@ license that can be found in the LICENSE file or at
 /* A merged table is implements seeking/iterating over a stack of tables. */
 struct reftable_merged_table;
 
-/* A generic reftable; see below. */
-struct reftable_table;
 struct reftable_reader;
 
 /*
@@ -60,8 +58,4 @@ void reftable_merged_table_free(struct reftable_merged_table *m);
 /* return the hash ID of the merged table. */
 uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *m);
 
-/* create a generic table from reftable_merged_table */
-void reftable_table_from_merged_table(struct reftable_table *tab,
-				      struct reftable_merged_table *table);
-
 #endif
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index 7c7d171651..69621c5b0f 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -23,9 +23,6 @@
 /* The reader struct is a handle to an open reftable file. */
 struct reftable_reader;
 
-/* Generic table. */
-struct reftable_table;
-
 /* reftable_new_reader opens a reftable for reading. If successful,
  * returns 0 code and sets pp. The name is used for creating a
  * stack. Typically, it is the basename of the file. The block source
@@ -60,10 +57,6 @@ uint64_t reftable_reader_max_update_index(struct reftable_reader *r);
 /* return the min_update_index for a table */
 uint64_t reftable_reader_min_update_index(struct reftable_reader *r);
 
-/* creates a generic table from a file reader. */
-void reftable_table_from_reader(struct reftable_table *tab,
-				struct reftable_reader *reader);
-
 /* print blocks onto stdout for debugging. */
 int reftable_reader_print_blocks(const char *tablename);
 
diff --git a/reftable/stack.c b/reftable/stack.c
index bedd503e7e..d3a95d2f1d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -14,7 +14,6 @@ license that can be found in the LICENSE file or at
 #include "merged.h"
 #include "reader.h"
 #include "reftable-error.h"
-#include "reftable-generic.h"
 #include "reftable-record.h"
 #include "reftable-merged.h"
 #include "writer.h"
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 577b1a5be8..93345c6c8b 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -12,7 +12,6 @@ license that can be found in the LICENSE file or at
 #include "reftable/merged.h"
 #include "reftable/reader.h"
 #include "reftable/reftable-error.h"
-#include "reftable/reftable-generic.h"
 #include "reftable/reftable-merged.h"
 #include "reftable/reftable-writer.h"
 
-- 
2.46.0.46.g406f326d27.dirty

