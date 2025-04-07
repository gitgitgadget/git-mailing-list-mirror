Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6969F255E2B
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031802; cv=none; b=RkzktpQ6gEH7zPwqcJjT8L04JnbnOxhM9G1iq5pfO6wKRngSpBNsXfKXu/eG4F2Z1o15cDHMzNqfHjhbevZDAlPb2It0tSxtNaW1e5DdSI/kVo3C7y0R7ZU9dSJZC2gs+459bWzJIVWtz3MXCamCwZ8iDQ3M8DUUIsI5Jp3IWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031802; c=relaxed/simple;
	bh=flbtjHC9Ql6egAB5eAwjPCaCWTIFmyCTqp857THY7dA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esgSWFqqazlXZTdA9y7hupGfFeQw9UwAsctCjyg3ZCnP8OAcFA4SwU23ZUfOVgyV8QJmb/m94VaxmkS8Idb8NbZeNvl2QlVDOeesU9wSLpPqcWIwSkOXbb5Q1aBK2AheKGc25G7Yvdch2YQ6mdZYM+toPCnE+usY6CHuj/EiZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ejoVIUQe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPnNfTGn; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ejoVIUQe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPnNfTGn"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 76D3C11401D2;
	Mon,  7 Apr 2025 09:16:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 07 Apr 2025 09:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031798;
	 x=1744118198; bh=aqmRiLFExgPp7/Dh1zy0pQkua+d6hzjKihhk41K2vlU=; b=
	ejoVIUQeh7fr/UZd0ZPXmxbV0jfghDzwNWYpWFkz/tnPkI4/VWrzbfLOrgUxFWvT
	oymgyePNYImmFX0h5QiAWDi4iOGxsyTQN7jOHfV3izyDVTGm90RSsjJcUygGgdZv
	yfeFH3eZxWzzXR6om7/BNrn12JtKjB8M8tYollte/riXu4SpU3qkI6SoXl4gQs2Y
	r0yO60TD2FutRJ6Mlb3LZ85WmfSHT1xrgWFd5tBhrDuMKtoc7L91ovg255mQZpvh
	Y1YTwuPK1JjOvCSFBQ+Qj/ZG+8IQHkKgk3AMj/GTZm4TIGlBL1XD97Vb/qvIgtWa
	ctjC79etaLnz7eNuM/hQjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031798; x=
	1744118198; bh=aqmRiLFExgPp7/Dh1zy0pQkua+d6hzjKihhk41K2vlU=; b=F
	PnNfTGntkuPPSdDGYEhuu2z2oDxUOilMkVyRBC1GWRIGr9Tx+LfBCc9gi/3zNuvb
	MzBcsQeO70agBx7kWlYV4cJwTmaSG4du+j6otvdOneaYLgwunZXxLwu5Yn/jhAVP
	n9iUha1oiSRjkg4/PB6AjXRdnD9JHyXPjs+Ara1OpKlzFhxufRvZ/IZ2Q+1M4Mmw
	dHKRMza/zhxOa6LbZLxKyyph4yOCsFum6BDFTnuSvLcJzo64qhTrg1JEHWdwWJ6b
	5BxeN5Dooj6grWNE4dZA7b9RykWT+K0HdXPXQyT7BWhokEdW3ZB5HElnFoSeZPxc
	P9R1Rpyevec97MaviN2XA==
X-ME-Sender: <xms:NtDzZ_rUGyGJupBC5G7Am85GGQsJkzBEIoq6QX_I_Mi-cQ79hdrU2w>
    <xme:NtDzZ5pmoIS6uWonqyFCR3lrrhxMjPXN18KlC6qXszTvtDDBGWLgUvYpJRjp5jk4E
    s4HxoRXTxYjWPi-4Q>
X-ME-Received: <xmr:NtDzZ8Nj0q3reBEjlF4AVIh_QcGJ84hgNNbBe1nZbsEVOwqqUfWOOB65LsZIzHXqcxC8XW4RfMZMdTnqO0UG6KwS1_u7UNfBlRfGZqPIyzIg7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedthfegfeejuefgieffvefhvedvfedtffdtgffh
    heevgfdtjedukefgkefgfeevtdenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:NtDzZy4Y3V6CnPzPdskcxf3PWNTCk9YaC_DaC9pUW5fzDNE2ZkbJdA>
    <xmx:NtDzZ-5jiHKsR9LOat7FWKQ0FjwbOqSqgeARnUqQI6mBF9u_zq6Mbg>
    <xmx:NtDzZ6j8KFJvqVOYZJs8sYqKhyCwsv6JWktIgVpET1qyhTc6MKSNdA>
    <xmx:NtDzZw4V8NuYvPVCVL8rF8b5yLchqJEbecOyAieWESOsQ5CNYG0slw>
    <xmx:NtDzZ0H2g3zW_FM5biFqHT489o8IYe6A4BeJRVur_fdvecVCfxW3BdIS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 273603ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:27 +0200
Subject: [PATCH v2 15/16] reftable/constants: make block types part of the
 public interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-15-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Now that reftable blocks can be read individually via the public
interface it becomes necessary for callers to be able to distinguish the
different types of blocks. Expose the relevant constants.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                 |  4 ++--
 reftable/constants.h             |  6 +-----
 reftable/iter.c                  | 10 +++++-----
 reftable/merged.c                |  4 ++--
 reftable/record.c                | 40 ++++++++++++++++++++--------------------
 reftable/reftable-constants.h    | 18 ++++++++++++++++++
 reftable/stack.c                 |  8 ++++----
 reftable/table.c                 | 40 ++++++++++++++++++++--------------------
 reftable/writer.c                | 22 +++++++++++-----------
 t/unit-tests/t-reftable-block.c  | 22 +++++++++++-----------
 t/unit-tests/t-reftable-merged.c | 12 ++++++------
 t/unit-tests/t-reftable-pq.c     | 10 +++++-----
 t/unit-tests/t-reftable-record.c | 40 ++++++++++++++++++++--------------------
 t/unit-tests/t-reftable-table.c  | 12 ++++++------
 14 files changed, 131 insertions(+), 117 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 08e22170d56..795815b4762 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -160,7 +160,7 @@ int block_writer_finish(struct block_writer *w)
 	 * Log records are stored zlib-compressed. Note that the compression
 	 * also spans over the restart points we have just written.
 	 */
-	if (block_writer_type(w) == BLOCK_TYPE_LOG) {
+	if (block_writer_type(w) == REFTABLE_BLOCK_TYPE_LOG) {
 		int block_header_skip = 4 + w->header_off;
 		uLongf src_len = w->next - block_header_skip, compressed_len;
 		int ret;
@@ -254,7 +254,7 @@ int reftable_block_init(struct reftable_block *block,
 			goto done;
 	}
 
-	if (block_type == BLOCK_TYPE_LOG) {
+	if (block_type == REFTABLE_BLOCK_TYPE_LOG) {
 		uint32_t block_header_skip = 4 + header_size;
 		uLong dst_len = block_size - block_header_skip;
 		uLong src_len = block->block_data.len - block_header_skip;
diff --git a/reftable/constants.h b/reftable/constants.h
index 091728cf033..e3b1aaa5164 100644
--- a/reftable/constants.h
+++ b/reftable/constants.h
@@ -9,11 +9,7 @@
 #ifndef CONSTANTS_H
 #define CONSTANTS_H
 
-#define BLOCK_TYPE_LOG 'g'
-#define BLOCK_TYPE_INDEX 'i'
-#define BLOCK_TYPE_REF 'r'
-#define BLOCK_TYPE_OBJ 'o'
-#define BLOCK_TYPE_ANY 0
+#include "reftable-constants.h"
 
 #define MAX_RESTARTS ((1 << 16) - 1)
 #define DEFAULT_BLOCK_SIZE 4096
diff --git a/reftable/iter.c b/reftable/iter.c
index a79c90d9ba6..2ecc52b3366 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -131,7 +131,7 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 	block_source_release_data(&it->block.block_data);
 
 	off = it->offsets[it->offset_idx++];
-	err = table_init_block(it->table, &it->block, off, BLOCK_TYPE_REF);
+	err = table_init_block(it->table, &it->block, off, REFTABLE_BLOCK_TYPE_REF);
 	if (err < 0) {
 		return err;
 	}
@@ -246,7 +246,7 @@ int reftable_iterator_seek_ref(struct reftable_iterator *it,
 			       const char *name)
 {
 	struct reftable_record want = {
-		.type = BLOCK_TYPE_REF,
+		.type = REFTABLE_BLOCK_TYPE_REF,
 		.u.ref = {
 			.refname = (char *)name,
 		},
@@ -258,7 +258,7 @@ int reftable_iterator_next_ref(struct reftable_iterator *it,
 			       struct reftable_ref_record *ref)
 {
 	struct reftable_record rec = {
-		.type = BLOCK_TYPE_REF,
+		.type = REFTABLE_BLOCK_TYPE_REF,
 		.u = {
 			.ref = *ref
 		},
@@ -272,7 +272,7 @@ int reftable_iterator_seek_log_at(struct reftable_iterator *it,
 				  const char *name, uint64_t update_index)
 {
 	struct reftable_record want = {
-		.type = BLOCK_TYPE_LOG,
+		.type = REFTABLE_BLOCK_TYPE_LOG,
 		.u.log = {
 			.refname = (char *)name,
 			.update_index = update_index,
@@ -291,7 +291,7 @@ int reftable_iterator_next_log(struct reftable_iterator *it,
 			       struct reftable_log_record *log)
 {
 	struct reftable_record rec = {
-		.type = BLOCK_TYPE_LOG,
+		.type = REFTABLE_BLOCK_TYPE_LOG,
 		.u = {
 			.log = *log,
 		},
diff --git a/reftable/merged.c b/reftable/merged.c
index d5b974d660e..733de07454d 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -301,13 +301,13 @@ int merged_table_init_iter(struct reftable_merged_table *mt,
 int reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
 					    struct reftable_iterator *it)
 {
-	return merged_table_init_iter(mt, it, BLOCK_TYPE_REF);
+	return merged_table_init_iter(mt, it, REFTABLE_BLOCK_TYPE_REF);
 }
 
 int reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
 					    struct reftable_iterator *it)
 {
-	return merged_table_init_iter(mt, it, BLOCK_TYPE_LOG);
+	return merged_table_init_iter(mt, it, REFTABLE_BLOCK_TYPE_LOG);
 }
 
 enum reftable_hash reftable_merged_table_hash_id(struct reftable_merged_table *mt)
diff --git a/reftable/record.c b/reftable/record.c
index 26cd834d405..ed00a724417 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -69,10 +69,10 @@ int put_var_int(struct string_view *dest, uint64_t value)
 int reftable_is_block_type(uint8_t typ)
 {
 	switch (typ) {
-	case BLOCK_TYPE_REF:
-	case BLOCK_TYPE_LOG:
-	case BLOCK_TYPE_OBJ:
-	case BLOCK_TYPE_INDEX:
+	case REFTABLE_BLOCK_TYPE_REF:
+	case REFTABLE_BLOCK_TYPE_LOG:
+	case REFTABLE_BLOCK_TYPE_OBJ:
+	case REFTABLE_BLOCK_TYPE_INDEX:
 		return 1;
 	}
 	return 0;
@@ -462,7 +462,7 @@ static int reftable_ref_record_cmp_void(const void *_a, const void *_b)
 
 static struct reftable_record_vtable reftable_ref_record_vtable = {
 	.key = &reftable_ref_record_key,
-	.type = BLOCK_TYPE_REF,
+	.type = REFTABLE_BLOCK_TYPE_REF,
 	.copy_from = &reftable_ref_record_copy_from,
 	.val_type = &reftable_ref_record_val_type,
 	.encode = &reftable_ref_record_encode,
@@ -664,7 +664,7 @@ static int reftable_obj_record_cmp_void(const void *_a, const void *_b)
 
 static struct reftable_record_vtable reftable_obj_record_vtable = {
 	.key = &reftable_obj_record_key,
-	.type = BLOCK_TYPE_OBJ,
+	.type = REFTABLE_BLOCK_TYPE_OBJ,
 	.copy_from = &reftable_obj_record_copy_from,
 	.val_type = &reftable_obj_record_val_type,
 	.encode = &reftable_obj_record_encode,
@@ -1035,7 +1035,7 @@ static int reftable_log_record_is_deletion_void(const void *p)
 
 static struct reftable_record_vtable reftable_log_record_vtable = {
 	.key = &reftable_log_record_key,
-	.type = BLOCK_TYPE_LOG,
+	.type = REFTABLE_BLOCK_TYPE_LOG,
 	.copy_from = &reftable_log_record_copy_from,
 	.val_type = &reftable_log_record_val_type,
 	.encode = &reftable_log_record_encode,
@@ -1137,7 +1137,7 @@ static int reftable_index_record_cmp(const void *_a, const void *_b)
 
 static struct reftable_record_vtable reftable_index_record_vtable = {
 	.key = &reftable_index_record_key,
-	.type = BLOCK_TYPE_INDEX,
+	.type = REFTABLE_BLOCK_TYPE_INDEX,
 	.copy_from = &reftable_index_record_copy_from,
 	.val_type = &reftable_index_record_val_type,
 	.encode = &reftable_index_record_encode,
@@ -1280,13 +1280,13 @@ int reftable_log_record_is_deletion(const struct reftable_log_record *log)
 static void *reftable_record_data(struct reftable_record *rec)
 {
 	switch (rec->type) {
-	case BLOCK_TYPE_REF:
+	case REFTABLE_BLOCK_TYPE_REF:
 		return &rec->u.ref;
-	case BLOCK_TYPE_LOG:
+	case REFTABLE_BLOCK_TYPE_LOG:
 		return &rec->u.log;
-	case BLOCK_TYPE_INDEX:
+	case REFTABLE_BLOCK_TYPE_INDEX:
 		return &rec->u.idx;
-	case BLOCK_TYPE_OBJ:
+	case REFTABLE_BLOCK_TYPE_OBJ:
 		return &rec->u.obj;
 	}
 	abort();
@@ -1296,13 +1296,13 @@ static struct reftable_record_vtable *
 reftable_record_vtable(struct reftable_record *rec)
 {
 	switch (rec->type) {
-	case BLOCK_TYPE_REF:
+	case REFTABLE_BLOCK_TYPE_REF:
 		return &reftable_ref_record_vtable;
-	case BLOCK_TYPE_LOG:
+	case REFTABLE_BLOCK_TYPE_LOG:
 		return &reftable_log_record_vtable;
-	case BLOCK_TYPE_INDEX:
+	case REFTABLE_BLOCK_TYPE_INDEX:
 		return &reftable_index_record_vtable;
-	case BLOCK_TYPE_OBJ:
+	case REFTABLE_BLOCK_TYPE_OBJ:
 		return &reftable_obj_record_vtable;
 	}
 	abort();
@@ -1314,11 +1314,11 @@ int reftable_record_init(struct reftable_record *rec, uint8_t typ)
 	rec->type = typ;
 
 	switch (typ) {
-	case BLOCK_TYPE_REF:
-	case BLOCK_TYPE_LOG:
-	case BLOCK_TYPE_OBJ:
+	case REFTABLE_BLOCK_TYPE_REF:
+	case REFTABLE_BLOCK_TYPE_LOG:
+	case REFTABLE_BLOCK_TYPE_OBJ:
 		return 0;
-	case BLOCK_TYPE_INDEX:
+	case REFTABLE_BLOCK_TYPE_INDEX:
 		reftable_buf_init(&rec->u.idx.last_key);
 		return 0;
 	default:
diff --git a/reftable/reftable-constants.h b/reftable/reftable-constants.h
new file mode 100644
index 00000000000..4ae9ba4bacc
--- /dev/null
+++ b/reftable/reftable-constants.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
+
+#ifndef REFTABLE_CONSTANTS_H
+#define REFTABLE_CONSTANTS_H
+
+#define REFTABLE_BLOCK_TYPE_LOG 'g'
+#define REFTABLE_BLOCK_TYPE_INDEX 'i'
+#define REFTABLE_BLOCK_TYPE_REF 'r'
+#define REFTABLE_BLOCK_TYPE_OBJ 'o'
+#define REFTABLE_BLOCK_TYPE_ANY 0
+
+#endif /* REFTABLE_CONSTANTS_H */
diff --git a/reftable/stack.c b/reftable/stack.c
index cc48e725b14..4caf96aa1d6 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -203,14 +203,14 @@ int reftable_stack_init_ref_iterator(struct reftable_stack *st,
 				      struct reftable_iterator *it)
 {
 	return merged_table_init_iter(reftable_stack_merged_table(st),
-				      it, BLOCK_TYPE_REF);
+				      it, REFTABLE_BLOCK_TYPE_REF);
 }
 
 int reftable_stack_init_log_iterator(struct reftable_stack *st,
 				     struct reftable_iterator *it)
 {
 	return merged_table_init_iter(reftable_stack_merged_table(st),
-				      it, BLOCK_TYPE_LOG);
+				      it, REFTABLE_BLOCK_TYPE_LOG);
 }
 
 struct reftable_merged_table *
@@ -1098,7 +1098,7 @@ static int stack_write_compact(struct reftable_stack *st,
 	if (err < 0)
 		goto done;
 
-	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_REF);
 	if (err < 0)
 		goto done;
 
@@ -1126,7 +1126,7 @@ static int stack_write_compact(struct reftable_stack *st,
 	}
 	reftable_iterator_destroy(&it);
 
-	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
+	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_LOG);
 	if (err < 0)
 		goto done;
 
diff --git a/reftable/table.c b/reftable/table.c
index a2a0c7a1d2f..1af39423224 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -20,11 +20,11 @@ static struct reftable_table_offsets *
 table_offsets_for(struct reftable_table *t, uint8_t typ)
 {
 	switch (typ) {
-	case BLOCK_TYPE_REF:
+	case REFTABLE_BLOCK_TYPE_REF:
 		return &t->ref_offsets;
-	case BLOCK_TYPE_LOG:
+	case REFTABLE_BLOCK_TYPE_LOG:
 		return &t->log_offsets;
-	case BLOCK_TYPE_OBJ:
+	case REFTABLE_BLOCK_TYPE_OBJ:
 		return &t->obj_offsets;
 	}
 	abort();
@@ -112,9 +112,9 @@ static int parse_footer(struct reftable_table *t, uint8_t *footer,
 	}
 
 	first_block_typ = header[header_size(t->version)];
-	t->ref_offsets.is_present = (first_block_typ == BLOCK_TYPE_REF);
+	t->ref_offsets.is_present = (first_block_typ == REFTABLE_BLOCK_TYPE_REF);
 	t->ref_offsets.offset = 0;
-	t->log_offsets.is_present = (first_block_typ == BLOCK_TYPE_LOG ||
+	t->log_offsets.is_present = (first_block_typ == REFTABLE_BLOCK_TYPE_LOG ||
 				     t->log_offsets.offset > 0);
 	t->obj_offsets.is_present = t->obj_offsets.offset > 0;
 	if (t->obj_offsets.is_present && !t->object_id_len) {
@@ -150,7 +150,7 @@ static int table_iter_next_in_block(struct table_iter *ti,
 				    struct reftable_record *rec)
 {
 	int res = block_iter_next(&ti->bi, rec);
-	if (res == 0 && reftable_record_type(rec) == BLOCK_TYPE_REF) {
+	if (res == 0 && reftable_record_type(rec) == REFTABLE_BLOCK_TYPE_REF) {
 		rec->u.ref.update_index += ti->table->min_update_index;
 	}
 
@@ -177,7 +177,7 @@ int table_init_block(struct reftable_table *t, struct reftable_block *block,
 	if (err < 0)
 		goto done;
 
-	if (want_typ != BLOCK_TYPE_ANY && block->block_type != want_typ) {
+	if (want_typ != REFTABLE_BLOCK_TYPE_ANY && block->block_type != want_typ) {
 		err = 1;
 		goto done;
 	}
@@ -270,7 +270,7 @@ static int table_iter_seek_start(struct table_iter *ti, uint8_t typ, int index)
 		if (off == 0) {
 			return 1;
 		}
-		typ = BLOCK_TYPE_INDEX;
+		typ = REFTABLE_BLOCK_TYPE_INDEX;
 	}
 
 	return table_iter_seek_to(ti, off, typ);
@@ -366,10 +366,10 @@ static int table_iter_seek_indexed(struct table_iter *ti,
 				   struct reftable_record *rec)
 {
 	struct reftable_record want_index = {
-		.type = BLOCK_TYPE_INDEX, .u.idx = { .last_key = REFTABLE_BUF_INIT }
+		.type = REFTABLE_BLOCK_TYPE_INDEX, .u.idx = { .last_key = REFTABLE_BUF_INIT }
 	};
 	struct reftable_record index_result = {
-		.type = BLOCK_TYPE_INDEX,
+		.type = REFTABLE_BLOCK_TYPE_INDEX,
 		.u.idx = { .last_key = REFTABLE_BUF_INIT },
 	};
 	int err;
@@ -429,7 +429,7 @@ static int table_iter_seek_indexed(struct table_iter *ti,
 			break;
 		}
 
-		if (ti->typ != BLOCK_TYPE_INDEX) {
+		if (ti->typ != REFTABLE_BLOCK_TYPE_INDEX) {
 			err = REFTABLE_FORMAT_ERROR;
 			goto done;
 		}
@@ -517,13 +517,13 @@ int table_init_iter(struct reftable_table *t,
 int reftable_table_init_ref_iterator(struct reftable_table *t,
 				     struct reftable_iterator *it)
 {
-	return table_init_iter(t, it, BLOCK_TYPE_REF);
+	return table_init_iter(t, it, REFTABLE_BLOCK_TYPE_REF);
 }
 
 int reftable_table_init_log_iterator(struct reftable_table *t,
 				     struct reftable_iterator *it)
 {
-	return table_init_iter(t, it, BLOCK_TYPE_LOG);
+	return table_init_iter(t, it, REFTABLE_BLOCK_TYPE_LOG);
 }
 
 int reftable_table_new(struct reftable_table **out,
@@ -625,7 +625,7 @@ static int reftable_table_refs_for_indexed(struct reftable_table *t,
 					   uint8_t *oid)
 {
 	struct reftable_record want = {
-		.type = BLOCK_TYPE_OBJ,
+		.type = REFTABLE_BLOCK_TYPE_OBJ,
 		.u.obj = {
 			.hash_prefix = oid,
 			.hash_prefix_len = t->object_id_len,
@@ -633,14 +633,14 @@ static int reftable_table_refs_for_indexed(struct reftable_table *t,
 	};
 	struct reftable_iterator oit = { NULL };
 	struct reftable_record got = {
-		.type = BLOCK_TYPE_OBJ,
+		.type = REFTABLE_BLOCK_TYPE_OBJ,
 		.u.obj = { 0 },
 	};
 	int err = 0;
 	struct indexed_table_ref_iter *itr = NULL;
 
 	/* Look through the reverse index. */
-	err = table_init_iter(t, &oit, BLOCK_TYPE_OBJ);
+	err = table_init_iter(t, &oit, REFTABLE_BLOCK_TYPE_OBJ);
 	if (err < 0)
 		goto done;
 
@@ -692,7 +692,7 @@ static int reftable_table_refs_for_unindexed(struct reftable_table *t,
 	}
 
 	table_iter_init(ti, t);
-	err = table_iter_seek_start(ti, BLOCK_TYPE_REF, 0);
+	err = table_iter_seek_start(ti, REFTABLE_BLOCK_TYPE_REF, 0);
 	if (err < 0)
 		goto out;
 
@@ -748,15 +748,15 @@ int reftable_table_print_blocks(const char *tablename)
 	} sections[] = {
 		{
 			.name = "ref",
-			.type = BLOCK_TYPE_REF,
+			.type = REFTABLE_BLOCK_TYPE_REF,
 		},
 		{
 			.name = "obj",
-			.type = BLOCK_TYPE_OBJ,
+			.type = REFTABLE_BLOCK_TYPE_OBJ,
 		},
 		{
 			.name = "log",
-			.type = BLOCK_TYPE_LOG,
+			.type = REFTABLE_BLOCK_TYPE_LOG,
 		},
 	};
 	struct reftable_block_source src = { 0 };
diff --git a/reftable/writer.c b/reftable/writer.c
index f0accfd0c32..0954c29bcf2 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -172,7 +172,7 @@ int reftable_writer_new(struct reftable_writer **out,
 	wp->write_arg = writer_arg;
 	wp->opts = opts;
 	wp->flush = flush_func;
-	writer_reinit_block_writer(wp, BLOCK_TYPE_REF);
+	writer_reinit_block_writer(wp, REFTABLE_BLOCK_TYPE_REF);
 
 	*out = wp;
 
@@ -347,7 +347,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 			    struct reftable_ref_record *ref)
 {
 	struct reftable_record rec = {
-		.type = BLOCK_TYPE_REF,
+		.type = REFTABLE_BLOCK_TYPE_REF,
 		.u = {
 			.ref = *ref
 		},
@@ -411,13 +411,13 @@ static int reftable_writer_add_log_verbatim(struct reftable_writer *w,
 					    struct reftable_log_record *log)
 {
 	struct reftable_record rec = {
-		.type = BLOCK_TYPE_LOG,
+		.type = REFTABLE_BLOCK_TYPE_LOG,
 		.u = {
 			.log = *log,
 		},
 	};
 	if (w->block_writer &&
-	    block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
+	    block_writer_type(w->block_writer) == REFTABLE_BLOCK_TYPE_REF) {
 		int err = writer_finish_public_section(w);
 		if (err < 0)
 			return err;
@@ -537,7 +537,7 @@ static int writer_finish_section(struct reftable_writer *w)
 
 		max_level++;
 		index_start = w->next;
-		err = writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
+		err = writer_reinit_block_writer(w, REFTABLE_BLOCK_TYPE_INDEX);
 		if (err < 0)
 			return err;
 
@@ -549,7 +549,7 @@ static int writer_finish_section(struct reftable_writer *w)
 		w->index_cap = 0;
 		for (i = 0; i < idx_len; i++) {
 			struct reftable_record rec = {
-				.type = BLOCK_TYPE_INDEX,
+				.type = REFTABLE_BLOCK_TYPE_INDEX,
 				.u = {
 					.idx = idx[i],
 				},
@@ -614,7 +614,7 @@ static void write_object_record(void *void_arg, void *key)
 	struct write_record_arg *arg = void_arg;
 	struct obj_index_tree_node *entry = key;
 	struct reftable_record
-		rec = { .type = BLOCK_TYPE_OBJ,
+		rec = { .type = REFTABLE_BLOCK_TYPE_OBJ,
 			.u.obj = {
 				.hash_prefix = (uint8_t *)entry->hash.buf,
 				.hash_prefix_len = arg->w->stats.object_id_len,
@@ -632,7 +632,7 @@ static void write_object_record(void *void_arg, void *key)
 	if (arg->err < 0)
 		goto done;
 
-	arg->err = writer_reinit_block_writer(arg->w, BLOCK_TYPE_OBJ);
+	arg->err = writer_reinit_block_writer(arg->w, REFTABLE_BLOCK_TYPE_OBJ);
 	if (arg->err < 0)
 		goto done;
 
@@ -670,7 +670,7 @@ static int writer_dump_object_index(struct reftable_writer *w)
 		infix_walk(w->obj_index_tree, &update_common, &common);
 	w->stats.object_id_len = common.max + 1;
 
-	err = writer_reinit_block_writer(w, BLOCK_TYPE_OBJ);
+	err = writer_reinit_block_writer(w, REFTABLE_BLOCK_TYPE_OBJ);
 	if (err < 0)
 		return err;
 
@@ -694,7 +694,7 @@ static int writer_finish_public_section(struct reftable_writer *w)
 	err = writer_finish_section(w);
 	if (err < 0)
 		return err;
-	if (typ == BLOCK_TYPE_REF && !w->opts.skip_index_objects &&
+	if (typ == REFTABLE_BLOCK_TYPE_REF && !w->opts.skip_index_objects &&
 	    w->stats.ref_stats.index_blocks > 0) {
 		err = writer_dump_object_index(w);
 		if (err < 0)
@@ -799,7 +799,7 @@ static int writer_flush_nonempty_block(struct reftable_writer *w)
 	 * By default, all records except for log records are padded to the
 	 * block size.
 	 */
-	if (!w->opts.unpadded && typ != BLOCK_TYPE_LOG)
+	if (!w->opts.unpadded && typ != REFTABLE_BLOCK_TYPE_LOG)
 		padding = w->opts.block_size - raw_bytes;
 
 	bstats = writer_reftable_block_stats(w, typ);
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 5577a5769ed..7dbd93601c7 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -24,7 +24,7 @@ static void t_ref_block_read_write(void)
 		.last_key = REFTABLE_BUF_INIT,
 	};
 	struct reftable_record rec = {
-		.type = BLOCK_TYPE_REF,
+		.type = REFTABLE_BLOCK_TYPE_REF,
 	};
 	size_t i = 0;
 	int ret;
@@ -37,7 +37,7 @@ static void t_ref_block_read_write(void)
 	check(block_data.buf != NULL);
 	block_data.len = block_size;
 
-	ret = block_writer_init(&bw, BLOCK_TYPE_REF, (uint8_t *) block_data.buf, block_size,
+	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_REF, (uint8_t *) block_data.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
@@ -118,7 +118,7 @@ static void t_log_block_read_write(void)
 		.last_key = REFTABLE_BUF_INIT,
 	};
 	struct reftable_record rec = {
-		.type = BLOCK_TYPE_LOG,
+		.type = REFTABLE_BLOCK_TYPE_LOG,
 	};
 	size_t i = 0;
 	int ret;
@@ -131,7 +131,7 @@ static void t_log_block_read_write(void)
 	check(block_data.buf != NULL);
 	block_data.len = block_size;
 
-	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, (uint8_t *) block_data.buf, block_size,
+	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_LOG, (uint8_t *) block_data.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
@@ -208,7 +208,7 @@ static void t_obj_block_read_write(void)
 		.last_key = REFTABLE_BUF_INIT,
 	};
 	struct reftable_record rec = {
-		.type = BLOCK_TYPE_OBJ,
+		.type = REFTABLE_BLOCK_TYPE_OBJ,
 	};
 	size_t i = 0;
 	int ret;
@@ -221,7 +221,7 @@ static void t_obj_block_read_write(void)
 	check(block_data.buf != NULL);
 	block_data.len = block_size;
 
-	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, (uint8_t *) block_data.buf, block_size,
+	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_OBJ, (uint8_t *) block_data.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
@@ -291,7 +291,7 @@ static void t_index_block_read_write(void)
 		.last_key = REFTABLE_BUF_INIT,
 	};
 	struct reftable_record rec = {
-		.type = BLOCK_TYPE_INDEX,
+		.type = REFTABLE_BLOCK_TYPE_INDEX,
 		.u.idx.last_key = REFTABLE_BUF_INIT,
 	};
 	size_t i = 0;
@@ -305,7 +305,7 @@ static void t_index_block_read_write(void)
 	check(block_data.buf != NULL);
 	block_data.len = block_size;
 
-	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, (uint8_t *) block_data.buf, block_size,
+	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_INDEX, (uint8_t *) block_data.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
@@ -315,7 +315,7 @@ static void t_index_block_read_write(void)
 		snprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
 
 		reftable_buf_init(&recs[i].u.idx.last_key);
-		recs[i].type = BLOCK_TYPE_INDEX;
+		recs[i].type = REFTABLE_BLOCK_TYPE_INDEX;
 		check(!reftable_buf_addstr(&recs[i].u.idx.last_key, buf));
 		recs[i].u.idx.offset = i;
 
@@ -389,13 +389,13 @@ static void t_block_iterator(void)
 	REFTABLE_CALLOC_ARRAY(data.buf, data.len);
 	check(data.buf != NULL);
 
-	err = block_writer_init(&writer, BLOCK_TYPE_REF, (uint8_t *) data.buf, data.len,
+	err = block_writer_init(&writer, REFTABLE_BLOCK_TYPE_REF, (uint8_t *) data.buf, data.len,
 				0, hash_size(REFTABLE_HASH_SHA1));
 	check(!err);
 
 	for (size_t i = 0; i < ARRAY_SIZE(expected_refs); i++) {
 		expected_refs[i] = (struct reftable_record) {
-			.type = BLOCK_TYPE_REF,
+			.type = REFTABLE_BLOCK_TYPE_REF,
 			.u.ref = {
 				.value_type = REFTABLE_REF_VAL1,
 				.refname = xstrfmt("refs/heads/branch-%02"PRIuMAX, (uintmax_t)i),
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index fed6beb85c0..18c3251a56a 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -84,7 +84,7 @@ static void t_merged_single_record(void)
 	struct reftable_iterator it = { 0 };
 	int err;
 
-	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_REF);
 	check(!err);
 	err = reftable_iterator_seek_ref(&it, "a");
 	check(!err);
@@ -164,7 +164,7 @@ static void t_merged_refs(void)
 	size_t cap = 0;
 	size_t i;
 
-	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_REF);
 	check(!err);
 	err = reftable_iterator_seek_ref(&it, "a");
 	check(!err);
@@ -244,7 +244,7 @@ static void t_merged_seek_multiple_times(void)
 	struct reftable_merged_table *mt;
 
 	mt = merged_table_from_records(refs, &sources, &tables, sizes, bufs, 2);
-	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_REF);
 
 	for (size_t i = 0; i < 5; i++) {
 		int err = reftable_iterator_seek_ref(&it, "c");
@@ -320,7 +320,7 @@ static void t_merged_seek_multiple_times_without_draining(void)
 	int err;
 
 	mt = merged_table_from_records(refs, &sources, &tables, sizes, bufs, 2);
-	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_REF);
 
 	err = reftable_iterator_seek_ref(&it, "b");
 	check(!err);
@@ -445,7 +445,7 @@ static void t_merged_logs(void)
 	size_t cap = 0;
 	size_t i;
 
-	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
+	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_LOG);
 	check(!err);
 	err = reftable_iterator_seek_log(&it, "a");
 	check(!err);
@@ -469,7 +469,7 @@ static void t_merged_logs(void)
 		check(reftable_log_record_equal(want[i], &out[i],
 						 REFTABLE_HASH_SIZE_SHA1));
 
-	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
+	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_LOG);
 	check(!err);
 	err = reftable_iterator_seek_log_at(&it, "a", 2);
 	check(!err);
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index c128fe8616a..fb5a4eb1877 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -34,7 +34,7 @@ static void t_pq_record(void)
 	char *last = NULL;
 
 	for (i = 0; i < N; i++) {
-		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
+		check(!reftable_record_init(&recs[i], REFTABLE_BLOCK_TYPE_REF));
 		recs[i].u.ref.refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
 	}
 
@@ -57,7 +57,7 @@ static void t_pq_record(void)
 		merged_iter_pqueue_check(&pq);
 
 		check(pq_entry_equal(&top, &e));
-		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
+		check(reftable_record_type(e.rec) == REFTABLE_BLOCK_TYPE_REF);
 		if (last)
 			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
 		last = e.rec->u.ref.refname;
@@ -76,7 +76,7 @@ static void t_pq_index(void)
 	size_t N = ARRAY_SIZE(recs), i;
 
 	for (i = 0; i < N; i++) {
-		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
+		check(!reftable_record_init(&recs[i], REFTABLE_BLOCK_TYPE_REF));
 		recs[i].u.ref.refname = (char *) "refs/heads/master";
 	}
 
@@ -100,7 +100,7 @@ static void t_pq_index(void)
 		merged_iter_pqueue_check(&pq);
 
 		check(pq_entry_equal(&top, &e));
-		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
+		check(reftable_record_type(e.rec) == REFTABLE_BLOCK_TYPE_REF);
 		check_int(e.index, ==, i);
 		if (last)
 			check_str(last, e.rec->u.ref.refname);
@@ -117,7 +117,7 @@ static void t_merged_iter_pqueue_top(void)
 	size_t N = ARRAY_SIZE(recs), i;
 
 	for (i = 0; i < N; i++) {
-		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
+		check(!reftable_record_init(&recs[i], REFTABLE_BLOCK_TYPE_REF));
 		recs[i].u.ref.refname = (char *) "refs/heads/master";
 	}
 
diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 59549663736..553a0076647 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -84,17 +84,17 @@ static void t_reftable_ref_record_comparison(void)
 {
 	struct reftable_record in[3] = {
 		{
-			.type = BLOCK_TYPE_REF,
+			.type = REFTABLE_BLOCK_TYPE_REF,
 			.u.ref.refname = (char *) "refs/heads/master",
 			.u.ref.value_type = REFTABLE_REF_VAL1,
 		},
 		{
-			.type = BLOCK_TYPE_REF,
+			.type = REFTABLE_BLOCK_TYPE_REF,
 			.u.ref.refname = (char *) "refs/heads/master",
 			.u.ref.value_type = REFTABLE_REF_DELETION,
 		},
 		{
-			.type = BLOCK_TYPE_REF,
+			.type = REFTABLE_BLOCK_TYPE_REF,
 			.u.ref.refname = (char *) "HEAD",
 			.u.ref.value_type = REFTABLE_REF_SYMREF,
 			.u.ref.value.symref = (char *) "refs/heads/master",
@@ -141,10 +141,10 @@ static void t_reftable_ref_record_roundtrip(void)
 
 	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
 		struct reftable_record in = {
-			.type = BLOCK_TYPE_REF,
+			.type = REFTABLE_BLOCK_TYPE_REF,
 			.u.ref.value_type = i,
 		};
-		struct reftable_record out = { .type = BLOCK_TYPE_REF };
+		struct reftable_record out = { .type = REFTABLE_BLOCK_TYPE_REF };
 		struct reftable_buf key = REFTABLE_BUF_INIT;
 		uint8_t buffer[1024] = { 0 };
 		struct string_view dest = {
@@ -198,17 +198,17 @@ static void t_reftable_log_record_comparison(void)
 {
 	struct reftable_record in[3] = {
 		{
-			.type = BLOCK_TYPE_LOG,
+			.type = REFTABLE_BLOCK_TYPE_LOG,
 			.u.log.refname = (char *) "refs/heads/master",
 			.u.log.update_index = 42,
 		},
 		{
-			.type = BLOCK_TYPE_LOG,
+			.type = REFTABLE_BLOCK_TYPE_LOG,
 			.u.log.refname = (char *) "refs/heads/master",
 			.u.log.update_index = 22,
 		},
 		{
-			.type = BLOCK_TYPE_LOG,
+			.type = REFTABLE_BLOCK_TYPE_LOG,
 			.u.log.refname = (char *) "refs/heads/main",
 			.u.log.update_index = 22,
 		},
@@ -297,7 +297,7 @@ static void t_reftable_log_record_roundtrip(void)
 	check(!reftable_log_record_is_deletion(&in[2]));
 
 	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
-		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
+		struct reftable_record rec = { .type = REFTABLE_BLOCK_TYPE_LOG };
 		struct reftable_buf key = REFTABLE_BUF_INIT;
 		uint8_t buffer[1024] = { 0 };
 		struct string_view dest = {
@@ -306,7 +306,7 @@ static void t_reftable_log_record_roundtrip(void)
 		};
 		/* populate out, to check for leaks. */
 		struct reftable_record out = {
-			.type = BLOCK_TYPE_LOG,
+			.type = REFTABLE_BLOCK_TYPE_LOG,
 			.u.log = {
 				.refname = xstrdup("old name"),
 				.value_type = REFTABLE_LOG_UPDATE,
@@ -384,21 +384,21 @@ static void t_reftable_obj_record_comparison(void)
 	uint64_t offsets[] = { 0, 16, 32, 48, 64, 80, 96, 112};
 	struct reftable_record in[3] = {
 		{
-			.type = BLOCK_TYPE_OBJ,
+			.type = REFTABLE_BLOCK_TYPE_OBJ,
 			.u.obj.hash_prefix = id_bytes,
 			.u.obj.hash_prefix_len = 7,
 			.u.obj.offsets = offsets,
 			.u.obj.offset_len = 8,
 		},
 		{
-			.type = BLOCK_TYPE_OBJ,
+			.type = REFTABLE_BLOCK_TYPE_OBJ,
 			.u.obj.hash_prefix = id_bytes,
 			.u.obj.hash_prefix_len = 7,
 			.u.obj.offsets = offsets,
 			.u.obj.offset_len = 5,
 		},
 		{
-			.type = BLOCK_TYPE_OBJ,
+			.type = REFTABLE_BLOCK_TYPE_OBJ,
 			.u.obj.hash_prefix = id_bytes,
 			.u.obj.hash_prefix_len = 5,
 		},
@@ -450,13 +450,13 @@ static void t_reftable_obj_record_roundtrip(void)
 			.len = sizeof(buffer),
 		};
 		struct reftable_record in = {
-			.type = BLOCK_TYPE_OBJ,
+			.type = REFTABLE_BLOCK_TYPE_OBJ,
 			.u = {
 				.obj = recs[i],
 			},
 		};
 		struct reftable_buf key = REFTABLE_BUF_INIT;
-		struct reftable_record out = { .type = BLOCK_TYPE_OBJ };
+		struct reftable_record out = { .type = REFTABLE_BLOCK_TYPE_OBJ };
 		int n, m;
 		uint8_t extra;
 
@@ -482,17 +482,17 @@ static void t_reftable_index_record_comparison(void)
 {
 	struct reftable_record in[3] = {
 		{
-			.type = BLOCK_TYPE_INDEX,
+			.type = REFTABLE_BLOCK_TYPE_INDEX,
 			.u.idx.offset = 22,
 			.u.idx.last_key = REFTABLE_BUF_INIT,
 		},
 		{
-			.type = BLOCK_TYPE_INDEX,
+			.type = REFTABLE_BLOCK_TYPE_INDEX,
 			.u.idx.offset = 32,
 			.u.idx.last_key = REFTABLE_BUF_INIT,
 		},
 		{
-			.type = BLOCK_TYPE_INDEX,
+			.type = REFTABLE_BLOCK_TYPE_INDEX,
 			.u.idx.offset = 32,
 			.u.idx.last_key = REFTABLE_BUF_INIT,
 		},
@@ -523,7 +523,7 @@ static void t_reftable_index_record_comparison(void)
 static void t_reftable_index_record_roundtrip(void)
 {
 	struct reftable_record in = {
-		.type = BLOCK_TYPE_INDEX,
+		.type = REFTABLE_BLOCK_TYPE_INDEX,
 		.u.idx = {
 			.offset = 42,
 			.last_key = REFTABLE_BUF_INIT,
@@ -537,7 +537,7 @@ static void t_reftable_index_record_roundtrip(void)
 	struct reftable_buf scratch = REFTABLE_BUF_INIT;
 	struct reftable_buf key = REFTABLE_BUF_INIT;
 	struct reftable_record out = {
-		.type = BLOCK_TYPE_INDEX,
+		.type = REFTABLE_BLOCK_TYPE_INDEX,
 		.u.idx = { .last_key = REFTABLE_BUF_INIT },
 	};
 	int n, m;
diff --git a/t/unit-tests/t-reftable-table.c b/t/unit-tests/t-reftable-table.c
index ba39cdf9a76..7e1eb533d0b 100644
--- a/t/unit-tests/t-reftable-table.c
+++ b/t/unit-tests/t-reftable-table.c
@@ -106,33 +106,33 @@ static int t_table_block_iterator(void)
 		uint16_t record_count;
 	} expected_blocks[] = {
 		{
-			.block_type = BLOCK_TYPE_REF,
+			.block_type = REFTABLE_BLOCK_TYPE_REF,
 			.header_off = 24,
 			.restart_count = 10,
 			.record_count = 158,
 		},
 		{
-			.block_type = BLOCK_TYPE_REF,
+			.block_type = REFTABLE_BLOCK_TYPE_REF,
 			.restart_count = 10,
 			.record_count = 159,
 		},
 		{
-			.block_type = BLOCK_TYPE_REF,
+			.block_type = REFTABLE_BLOCK_TYPE_REF,
 			.restart_count = 10,
 			.record_count = 159,
 		},
 		{
-			.block_type = BLOCK_TYPE_REF,
+			.block_type = REFTABLE_BLOCK_TYPE_REF,
 			.restart_count = 2,
 			.record_count = 24,
 		},
 		{
-			.block_type = BLOCK_TYPE_INDEX,
+			.block_type = REFTABLE_BLOCK_TYPE_INDEX,
 			.restart_count = 1,
 			.record_count = 4,
 		},
 		{
-			.block_type = BLOCK_TYPE_OBJ,
+			.block_type = REFTABLE_BLOCK_TYPE_OBJ,
 			.restart_count = 1,
 			.record_count = 1,
 		},

-- 
2.49.0.604.gff1f9ca942.dirty

