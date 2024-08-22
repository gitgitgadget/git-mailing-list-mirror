Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9DE1531DD
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308534; cv=none; b=kDuZTmQDeKK1ijnEO9s3BnbSWyK6PaLieU1TnslXyd3KobYOwCITByks6CHiD8lHXjIM0bSEAuy6c7RUcL12UEZ3Xjik2C5oDddjZfx7x4t7NcouEEVMtk3VRqzpyPFKtLA+bH+A0rhnTg6KG6rLpkIOfYsDlW4020M4BMKZW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308534; c=relaxed/simple;
	bh=oU8p9FYXWfXU19Bcbefcs8O2kCC8cDY43dXuk5nlswY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqkCScDJQM6iUyRienSAKsKUeDmEOtnRBP4GNlp0DS49i2c8N/d5R7L2aAzL9tD7DXT3ZaZie0PmBubOvwFBCRZFh8xC+2m9QRnLgwipvTJYWaCziPap4gnxPyOEVz418ptgjFpEL0Dx6M+BYdPYPtoMjsbrIKXAAYp23L/ipk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gk5Lvfiv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j+4pP+YF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gk5Lvfiv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j+4pP+YF"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BEC721151AF6;
	Thu, 22 Aug 2024 02:35:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 22 Aug 2024 02:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308531; x=1724394931; bh=TD8ITKIMpy
	uKUcmkR4eZDrsevvHko7HwcZ4qC/BosjQ=; b=gk5LvfivDc2/bJbUeAaK/R8A4M
	KGyS7gDyCfGs6boJ75OSuSzYlSy7Cpv4K2t93aA2e8xQ4uMHycURDHUkkpnrpd5d
	Fz0Vvo3hlVBDgEF13izCEdWvHE8fU2u6I8PP/GXe+JPVrIMycS134CtmLEjMrdhS
	u+o+Nj1AY6zl+3eaWYlS7C51kWsyqaAmGVGqopo51vM5P5abGl2QvCIKzSRsHXs5
	cjw2lsWLZmoXAz3GbJraizxt+PlNUJGqigrZYaX1uGUeukzI61AXgah0qUY5LuXq
	rD0SWWoivgf0Mbq9QMFfj7lAM6qaetfzpksjny2xQ1SjVy+hwIQcehkkyFVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308531; x=1724394931; bh=TD8ITKIMpyuKUcmkR4eZDrsevvHk
	o7HwcZ4qC/BosjQ=; b=j+4pP+YF3ko4ZLZPn+3VkElU6xI6Yf9YVPSgkPX/tztb
	qp3S1XTDl+bjbSqmVkmORIA1GUHD5eTcRVilj8das+WEtbHg7VBmenoh7Z3GXyY5
	DcKwDyXeAr9cm9Zg6N+SfDWsn7x0WlXV6yy21MWH5wJDGY2+LYPcwmwGHaxyoqAX
	/B2LkWBB9VPYC111h7V3ZVG7IbOQcn06EpVDgZTJduePmKSPqe9jdNveu8ABpyiD
	IPwtpd980yCV9cIIe6dx6RqBUSa/3M1ZpgZYw/XbY5gQ94KxxisvVbOH4Ipo0wEz
	Mi2jJ1kOGlgbLKUS8FgwI/1AaYRTFls6dPhALgjpTQ==
X-ME-Sender: <xms:M9zGZl7GSmLNtPcN25ubD60m--0m1__qsY4ddHHVP_ZCJh6LFZsxfw>
    <xme:M9zGZi4GrbLucx6BoWP3XHNN87RdlrUrnnT3f-1DPvZjW1tN1Zy_ceCNp2gL7afit
    xK8Je-dvSheYyTTtg>
X-ME-Received: <xmr:M9zGZsdNARWcJ_EV6P3PinPAWQ5Wsct_9WSkSJiSNV6L8qlsEc0jbcP06sNoC-QHEyIRbXB0SHbHbFviQarqbW8RQOudcRFdQqoJRbIlZzxb-4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeuieeuudfhvefhkeeigfekgfegleejtdffteehheet
    hffhvdeludekkeffhfffvdenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:M9zGZuJTxqcvc_vyP7e5AmmHh_eRqsEAt8MMGa06OXDFuhZvjH26JA>
    <xmx:M9zGZpKHaitaWCV_dlYiTNY-8PteBZOq58Pt_9hbro2HiRV73IWBLw>
    <xmx:M9zGZnyBp0moltNTSmkQ0-GhunnL1jOzxWchTtws7Krski2NkdtiNA>
    <xmx:M9zGZlIblTMgWXmXkWg5p7JBKtzjTYwIhMOTxrrmSvned99f-Tz1NQ>
    <xmx:M9zGZp0amCgXrHjqtxyd9wP7AlgvJnoCSIH2vphdYCc4Q4RhuWxUwhXC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:35:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e5b15d9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:56 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:35:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 15/15] reftable/generic: drop interface
Message-ID: <b5d7b5679b573a9d0c0458b0a2e29f0ac1855237.1724308389.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
 <cover.1724308389.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724308389.git.ps@pks.im>

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
index 343f19a488b..41dfa0bad2c 100644
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
index 495ee9af6b0..00000000000
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
index 837fbb8df20..00000000000
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
index 225feb78714..97a4642ed57 100644
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
index 3b401f12590..befc4597df1 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -14,7 +14,6 @@ license that can be found in the LICENSE file or at
 #include "record.h"
 
 #include "reftable-iterator.h"
-#include "reftable-generic.h"
 
 /*
  * The virtual function table for implementing generic reftable iterators.
diff --git a/reftable/merged.c b/reftable/merged.c
index 2e72eab3069..128a810c55d 100644
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
index fbd93b88dff..082cf00b606 100644
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
index b8b1323a331..00000000000
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
index 03c2619c0ff..16d19f8df20 100644
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
index 7c7d1716516..69621c5b0fc 100644
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
index bedd503e7e1..d3a95d2f1d7 100644
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
index 577b1a5be87..93345c6c8be 100644
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
2.46.0.164.g477ce5ccd6.dirty

