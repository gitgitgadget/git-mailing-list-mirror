Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD804C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbhLMQCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240295AbhLMQCE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:02:04 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B24C061751
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:02:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 133so12321073wme.0
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HhrNW5xv+3caPg3xzQBtDWdXID3+X86gTVklC77x6/o=;
        b=flGN1zvecQBuA8WT1TyWhEbW63h2jZFkgG4Q4xD38OgL3qFs1mQDRDGhbku7/dcuqw
         CzeRcnYZQ1TTUITcQG9xNSGc4xl2PzJme6NfCIWixStDjCvgwWpP59oDRKWVlY6Y7niD
         AAs8CUfIfV0Y9t7T+ocI4S3hpk3MMR2DvTtnNc+4lfalpJbDBurQNU1EplUs8Ulrsfxz
         i8K0//ayyNI0GTD0jO2z0ZS8v/Izg6R+dMbIKM8y0jMQC4hWU63exfTEtt+fnbJRiYRs
         aqjf0RlCsIWGMqXs9uXHkB4CQ0emmPi1aX7GQf0s8JDCGuucNenywVHYt4dUpDQRYz8A
         Dn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HhrNW5xv+3caPg3xzQBtDWdXID3+X86gTVklC77x6/o=;
        b=jRrF81t+2P3YhFqdDUt1pNZ0g0az3QBVdzYz5pQD4copUz1dpnTNk/T0IVz9rlRYsM
         8V8t87MU4DblWHm56p8e4JtxNFzRRS2h6WvCMRE83gUraZ5cTir5eTTxHEdK6SbkX/Tq
         OOa75FRUSYmQplg/zl1pmbGTm0MQwoOhl8pMfs6Nv6XNLXIRAAVckI8BpBPf1c/cgH/3
         xNtukP50OPcoK/b7woc9GkWH6uuHN82/ul7N5Fo6T1wU95WpkApJym/wZiFuQ2qBTrza
         rJlY1aHmJnJVhEz95svmHG2HvnFwGEveNLBIev/Ja7eAg6110VMnFcqWTbZ49fgIsG0q
         saDQ==
X-Gm-Message-State: AOAM5332bTNS+tZyXX2mC32/bRawHzWl7PdOozDVaLt+8pJCMWCig1Lw
        2jRfKcC9ZpijiR3GNUQgO4CftXhUPSw=
X-Google-Smtp-Source: ABdhPJxSo7ZfUy5lpRuiJik5QmxbFmvyEXwcp5vew0LHM5+4DgxjBEevfDCeQ32nikR42P3ob2nCew==
X-Received: by 2002:a05:600c:6024:: with SMTP id az36mr37289027wmb.11.1639411321659;
        Mon, 13 Dec 2021 08:02:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7sm14375934wrg.31.2021.12.13.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:02:01 -0800 (PST)
Message-Id: <b3e592b9c27a0c205b5f75e6f5df86d637f76f5d.1639411309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
        <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 16:01:49 +0000
Subject: [PATCH v3 11/11] reftable: make reftable_record a tagged union
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This reduces the amount of glue code, because we don't need a void pointer or
vtable within the structure.

The only snag is that reftable_index_record contain a strbuf, so it cannot be
zero-initialized. To address this, use reftable_new_record() to return fresh
instance, given a record type. Since reftable_new_record() doesn't cause heap
allocation anymore, it should be balanced with reftable_record_release() rather
than reftable_record_destroy().

Thanks to Peff for the suggestion.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/block.c       |   2 +-
 reftable/block_test.c  |  22 ++---
 reftable/generic.c     |  35 ++++----
 reftable/iter.c        |   4 +-
 reftable/merged.c      |  33 ++++----
 reftable/pq.c          |   3 +-
 reftable/pq_test.c     |  31 +++----
 reftable/reader.c      |  93 +++++++++++----------
 reftable/record.c      | 173 ++++++++++++++++-----------------------
 reftable/record.h      |  42 ++++------
 reftable/record_test.c | 181 +++++++++++++++++++++--------------------
 reftable/writer.c      |  40 +++++----
 12 files changed, 317 insertions(+), 342 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 37a85b9576d..872bedaa2f0 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -423,7 +423,7 @@ int block_reader_seek(struct block_reader *br, struct block_iter *it,
 done:
 	strbuf_release(&key);
 	strbuf_release(&next.last_key);
-	reftable_record_destroy(&rec);
+	reftable_record_release(&rec);
 
 	return err;
 }
diff --git a/reftable/block_test.c b/reftable/block_test.c
index 4b3ea262dcb..fa2ee092ec0 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -26,8 +26,9 @@ static void test_block_read_write(void)
 	struct block_writer bw = {
 		.last_key = STRBUF_INIT,
 	};
-	struct reftable_ref_record ref = { NULL };
-	struct reftable_record rec = { NULL };
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_REF,
+	};
 	int i = 0;
 	int n;
 	struct block_reader br = { 0 };
@@ -40,7 +41,6 @@ static void test_block_read_write(void)
 	block.source = malloc_block_source();
 	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
 			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
-	reftable_record_from_ref(&rec, &ref);
 
 	for (i = 0; i < N; i++) {
 		char name[100];
@@ -48,14 +48,14 @@ static void test_block_read_write(void)
 		snprintf(name, sizeof(name), "branch%02d", i);
 		memset(hash, i, sizeof(hash));
 
-		ref.refname = name;
-		ref.value_type = REFTABLE_REF_VAL1;
-		ref.value.val1 = hash;
+		rec.u.ref.refname = name;
+		rec.u.ref.value_type = REFTABLE_REF_VAL1;
+		rec.u.ref.value.val1 = hash;
 
 		names[i] = xstrdup(name);
 		n = block_writer_add(&bw, &rec);
-		ref.refname = NULL;
-		ref.value_type = REFTABLE_REF_DELETION;
+		rec.u.ref.refname = NULL;
+		rec.u.ref.value_type = REFTABLE_REF_DELETION;
 		EXPECT(n == 0);
 	}
 
@@ -74,7 +74,7 @@ static void test_block_read_write(void)
 		if (r > 0) {
 			break;
 		}
-		EXPECT_STREQ(names[j], ref.refname);
+		EXPECT_STREQ(names[j], rec.u.ref.refname);
 		j++;
 	}
 
@@ -92,7 +92,7 @@ static void test_block_read_write(void)
 		n = block_iter_next(&it, &rec);
 		EXPECT(n == 0);
 
-		EXPECT_STREQ(names[i], ref.refname);
+		EXPECT_STREQ(names[i], rec.u.ref.refname);
 
 		want.len--;
 		n = block_reader_seek(&br, &it, &want);
@@ -100,7 +100,7 @@ static void test_block_read_write(void)
 
 		n = block_iter_next(&it, &rec);
 		EXPECT(n == 0);
-		EXPECT_STREQ(names[10 * (i / 10)], ref.refname);
+		EXPECT_STREQ(names[10 * (i / 10)], rec.u.ref.refname);
 
 		block_iter_close(&it);
 	}
diff --git a/reftable/generic.c b/reftable/generic.c
index 7a8a738d860..4446b8ed360 100644
--- a/reftable/generic.c
+++ b/reftable/generic.c
@@ -7,6 +7,7 @@ https://developers.google.com/open-source/licenses/bsd
 */
 
 #include "basics.h"
+#include "constants.h"
 #include "record.h"
 #include "generic.h"
 #include "reftable-iterator.h"
@@ -15,23 +16,21 @@ https://developers.google.com/open-source/licenses/bsd
 int reftable_table_seek_ref(struct reftable_table *tab,
 			    struct reftable_iterator *it, const char *name)
 {
-	struct reftable_ref_record ref = {
-		.refname = (char *)name,
-	};
-	struct reftable_record rec = { NULL };
-	reftable_record_from_ref(&rec, &ref);
+	struct reftable_record rec = { .type = BLOCK_TYPE_REF,
+				       .u.ref = {
+					       .refname = (char *)name,
+				       } };
 	return tab->ops->seek_record(tab->table_arg, it, &rec);
 }
 
 int reftable_table_seek_log(struct reftable_table *tab,
 			    struct reftable_iterator *it, const char *name)
 {
-	struct reftable_log_record log = {
-		.refname = (char *)name,
-		.update_index = ~((uint64_t)0),
-	};
-	struct reftable_record rec = { NULL };
-	reftable_record_from_log(&rec, &log);
+	struct reftable_record rec = { .type = BLOCK_TYPE_LOG,
+				       .u.log = {
+					       .refname = (char *)name,
+					       .update_index = ~((uint64_t)0),
+				       } };
 	return tab->ops->seek_record(tab->table_arg, it, &rec);
 }
 
@@ -129,17 +128,19 @@ void reftable_iterator_destroy(struct reftable_iterator *it)
 int reftable_iterator_next_ref(struct reftable_iterator *it,
 			       struct reftable_ref_record *ref)
 {
-	struct reftable_record rec = { NULL };
-	reftable_record_from_ref(&rec, ref);
-	return iterator_next(it, &rec);
+	struct reftable_record rec = { .type = BLOCK_TYPE_REF };
+	int err = iterator_next(it, &rec);
+	*ref = rec.u.ref;
+	return err;
 }
 
 int reftable_iterator_next_log(struct reftable_iterator *it,
 			       struct reftable_log_record *log)
 {
-	struct reftable_record rec = { NULL };
-	reftable_record_from_log(&rec, log);
-	return iterator_next(it, &rec);
+	struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
+	int err = iterator_next(it, &rec);
+	*log = rec.u.log;
+	return err;
 }
 
 int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
diff --git a/reftable/iter.c b/reftable/iter.c
index 93d04f735b8..a8d174c0406 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -32,7 +32,7 @@ static int filtering_ref_iterator_next(void *iter_arg,
 				       struct reftable_record *rec)
 {
 	struct filtering_ref_iterator *fri = iter_arg;
-	struct reftable_ref_record *ref = rec->data;
+	struct reftable_ref_record *ref = &rec->u.ref;
 	int err = 0;
 	while (1) {
 		err = reftable_iterator_next_ref(&fri->it, ref);
@@ -127,7 +127,7 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
 {
 	struct indexed_table_ref_iter *it = p;
-	struct reftable_ref_record *ref = rec->data;
+	struct reftable_ref_record *ref = &rec->u.ref;
 
 	while (1) {
 		int err = block_iter_next(&it->cur, rec);
diff --git a/reftable/merged.c b/reftable/merged.c
index e5b53da6db3..a7c0df91ff0 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -30,7 +30,7 @@ static int merged_iter_init(struct merged_iter *mi)
 
 		if (err > 0) {
 			reftable_iterator_destroy(&mi->stack[i]);
-			reftable_record_destroy(&rec);
+			reftable_record_release(&rec);
 		} else {
 			struct pq_entry e = {
 				.rec = rec,
@@ -57,18 +57,17 @@ static void merged_iter_close(void *p)
 static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
 					       size_t idx)
 {
-	struct reftable_record rec = reftable_new_record(mi->typ);
 	struct pq_entry e = {
-		.rec = rec,
+		.rec = reftable_new_record(mi->typ),
 		.index = idx,
 	};
-	int err = iterator_next(&mi->stack[idx], &rec);
+	int err = iterator_next(&mi->stack[idx], &e.rec);
 	if (err < 0)
 		return err;
 
 	if (err > 0) {
 		reftable_iterator_destroy(&mi->stack[idx]);
-		reftable_record_destroy(&rec);
+		reftable_record_release(&e.rec);
 		return 0;
 	}
 
@@ -126,11 +125,11 @@ static int merged_iter_next_entry(struct merged_iter *mi,
 		if (err < 0) {
 			return err;
 		}
-		reftable_record_destroy(&top.rec);
+		reftable_record_release(&top.rec);
 	}
 
 	reftable_record_copy_from(rec, &entry.rec, hash_size(mi->hash_id));
-	reftable_record_destroy(&entry.rec);
+	reftable_record_release(&entry.rec);
 	strbuf_release(&entry_key);
 	return 0;
 }
@@ -290,11 +289,12 @@ int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
 				   struct reftable_iterator *it,
 				   const char *name)
 {
-	struct reftable_ref_record ref = {
-		.refname = (char *)name,
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_REF,
+		.u.ref = {
+			.refname = (char *)name,
+		},
 	};
-	struct reftable_record rec = { NULL };
-	reftable_record_from_ref(&rec, &ref);
 	return merged_table_seek_record(mt, it, &rec);
 }
 
@@ -302,12 +302,13 @@ int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
 				      struct reftable_iterator *it,
 				      const char *name, uint64_t update_index)
 {
-	struct reftable_log_record log = {
-		.refname = (char *)name,
-		.update_index = update_index,
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_LOG,
+		.u.log = {
+			.refname = (char *)name,
+			.update_index = update_index,
+		}
 	};
-	struct reftable_record rec = { NULL };
-	reftable_record_from_log(&rec, &log);
 	return merged_table_seek_record(mt, it, &rec);
 }
 
diff --git a/reftable/pq.c b/reftable/pq.c
index efc474017a2..96ca6dd37b3 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -74,6 +74,7 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e)
 {
 	int i = 0;
+
 	if (pq->len == pq->cap) {
 		pq->cap = 2 * pq->cap + 1;
 		pq->heap = reftable_realloc(pq->heap,
@@ -98,7 +99,7 @@ void merged_iter_pqueue_release(struct merged_iter_pqueue *pq)
 {
 	int i = 0;
 	for (i = 0; i < pq->len; i++) {
-		reftable_record_destroy(&pq->heap[i].rec);
+		reftable_record_release(&pq->heap[i].rec);
 	}
 	FREE_AND_NULL(pq->heap);
 	pq->len = pq->cap = 0;
diff --git a/reftable/pq_test.c b/reftable/pq_test.c
index c9bb05e37b7..e0f5c584ada 100644
--- a/reftable/pq_test.c
+++ b/reftable/pq_test.c
@@ -31,7 +31,7 @@ static void test_pq(void)
 	int N = ARRAY_SIZE(names) - 1;
 
 	struct merged_iter_pqueue pq = { NULL };
-	const char *last = NULL;
+	char *last = NULL;
 
 	int i = 0;
 	for (i = 0; i < N; i++) {
@@ -42,12 +42,14 @@ static void test_pq(void)
 
 	i = 1;
 	do {
-		struct reftable_record rec =
-			reftable_new_record(BLOCK_TYPE_REF);
-		struct pq_entry e = { 0 };
-
-		reftable_record_as_ref(&rec)->refname = names[i];
-		e.rec = rec;
+		struct pq_entry e = {
+			.rec = {
+				.type = BLOCK_TYPE_REF,
+				.u.ref = {
+					.refname = names[i],
+				}
+			}
+		};
 		merged_iter_pqueue_add(&pq, e);
 		merged_iter_pqueue_check(pq);
 		i = (i * 7) % N;
@@ -55,19 +57,18 @@ static void test_pq(void)
 
 	while (!merged_iter_pqueue_is_empty(pq)) {
 		struct pq_entry e = merged_iter_pqueue_remove(&pq);
-		struct reftable_ref_record *ref =
-			reftable_record_as_ref(&e.rec);
-
+		struct reftable_record *rec = &e.rec;
 		merged_iter_pqueue_check(pq);
 
+		EXPECT(reftable_record_type(rec) == BLOCK_TYPE_REF);
 		if (last) {
-			EXPECT(strcmp(last, ref->refname) < 0);
+			EXPECT(strcmp(last, rec->u.ref.refname) < 0);
 		}
-		last = ref->refname;
-		ref->refname = NULL;
-		reftable_free(ref);
+		// this is names[i], so don't dealloc.
+		last = rec->u.ref.refname;
+		rec->u.ref.refname = NULL;
+		reftable_record_release(rec);
 	}
-
 	for (i = 0; i < N; i++) {
 		reftable_free(names[i]);
 	}
diff --git a/reftable/reader.c b/reftable/reader.c
index 8d308d858f8..4a25c1d44f4 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -239,8 +239,7 @@ static int table_iter_next_in_block(struct table_iter *ti,
 {
 	int res = block_iter_next(&ti->bi, rec);
 	if (res == 0 && reftable_record_type(rec) == BLOCK_TYPE_REF) {
-		((struct reftable_ref_record *)rec->data)->update_index +=
-			ti->r->min_update_index;
+		rec->u.ref.update_index += ti->r->min_update_index;
 	}
 
 	return res;
@@ -437,8 +436,7 @@ static int reader_start(struct reftable_reader *r, struct table_iter *ti,
 static int reader_seek_linear(struct reftable_reader *r, struct table_iter *ti,
 			      struct reftable_record *want)
 {
-	struct reftable_record rec =
-		reftable_new_record(reftable_record_type(want));
+	struct reftable_record rec = reftable_new_record(reftable_record_type(want));
 	struct strbuf want_key = STRBUF_INIT;
 	struct strbuf got_key = STRBUF_INIT;
 	struct table_iter next = TABLE_ITER_INIT;
@@ -475,7 +473,7 @@ static int reader_seek_linear(struct reftable_reader *r, struct table_iter *ti,
 
 done:
 	block_iter_close(&next.bi);
-	reftable_record_destroy(&rec);
+	reftable_record_release(&rec);
 	strbuf_release(&want_key);
 	strbuf_release(&got_key);
 	return err;
@@ -485,34 +483,36 @@ static int reader_seek_indexed(struct reftable_reader *r,
 			       struct reftable_iterator *it,
 			       struct reftable_record *rec)
 {
-	struct reftable_index_record want_index = { .last_key = STRBUF_INIT };
-	struct reftable_record want_index_rec = { NULL };
-	struct reftable_index_record index_result = { .last_key = STRBUF_INIT };
-	struct reftable_record index_result_rec = { NULL };
+	struct reftable_record want_index = {
+		.type = BLOCK_TYPE_INDEX,
+		.u.idx = { .last_key = STRBUF_INIT }
+	};
+	struct reftable_record index_result = {
+		.type = BLOCK_TYPE_INDEX,
+		.u.idx = { .last_key = STRBUF_INIT },
+	};
 	struct table_iter index_iter = TABLE_ITER_INIT;
 	struct table_iter next = TABLE_ITER_INIT;
 	int err = 0;
 
-	reftable_record_key(rec, &want_index.last_key);
-	reftable_record_from_index(&want_index_rec, &want_index);
-	reftable_record_from_index(&index_result_rec, &index_result);
-
+	reftable_record_key(rec, &want_index.u.idx.last_key);
 	err = reader_start(r, &index_iter, reftable_record_type(rec), 1);
 	if (err < 0)
 		goto done;
 
-	err = reader_seek_linear(r, &index_iter, &want_index_rec);
+	err = reader_seek_linear(r, &index_iter, &want_index);
 	while (1) {
-		err = table_iter_next(&index_iter, &index_result_rec);
+		err = table_iter_next(&index_iter, &index_result);
 		table_iter_block_done(&index_iter);
 		if (err != 0)
 			goto done;
 
-		err = reader_table_iter_at(r, &next, index_result.offset, 0);
+		err = reader_table_iter_at(r, &next, index_result.u.idx.offset,
+					   0);
 		if (err != 0)
 			goto done;
 
-		err = block_iter_seek(&next.bi, &want_index.last_key);
+		err = block_iter_seek(&next.bi, &want_index.u.idx.last_key);
 		if (err < 0)
 			goto done;
 
@@ -540,8 +540,8 @@ static int reader_seek_indexed(struct reftable_reader *r,
 done:
 	block_iter_close(&next.bi);
 	table_iter_close(&index_iter);
-	reftable_record_release(&want_index_rec);
-	reftable_record_release(&index_result_rec);
+	reftable_record_release(&want_index);
+	reftable_record_release(&index_result);
 	return err;
 }
 
@@ -549,8 +549,7 @@ static int reader_seek_internal(struct reftable_reader *r,
 				struct reftable_iterator *it,
 				struct reftable_record *rec)
 {
-	struct reftable_reader_offsets *offs =
-		reader_offsets_for(r, reftable_record_type(rec));
+	struct reftable_reader_offsets *offs = reader_offsets_for(r, reftable_record_type(rec));
 	uint64_t idx = offs->index_offset;
 	struct table_iter ti = TABLE_ITER_INIT;
 	int err = 0;
@@ -590,11 +589,12 @@ static int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
 int reftable_reader_seek_ref(struct reftable_reader *r,
 			     struct reftable_iterator *it, const char *name)
 {
-	struct reftable_ref_record ref = {
-		.refname = (char *)name,
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_REF,
+		.u.ref = {
+			.refname = (char *)name,
+		},
 	};
-	struct reftable_record rec = { NULL };
-	reftable_record_from_ref(&rec, &ref);
 	return reader_seek(r, it, &rec);
 }
 
@@ -602,12 +602,13 @@ int reftable_reader_seek_log_at(struct reftable_reader *r,
 				struct reftable_iterator *it, const char *name,
 				uint64_t update_index)
 {
-	struct reftable_log_record log = {
-		.refname = (char *)name,
-		.update_index = update_index,
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_LOG,
+		.u.log = {
+			.refname = (char *)name,
+			.update_index = update_index,
+		}
 	};
-	struct reftable_record rec = { NULL };
-	reftable_record_from_log(&rec, &log);
 	return reader_seek(r, it, &rec);
 }
 
@@ -649,31 +650,33 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 					    struct reftable_iterator *it,
 					    uint8_t *oid)
 {
-	struct reftable_obj_record want = {
-		.hash_prefix = oid,
-		.hash_prefix_len = r->object_id_len,
+	struct reftable_record want = {
+		.type = BLOCK_TYPE_OBJ,
+		.u.obj = {
+			.hash_prefix = oid,
+			.hash_prefix_len = r->object_id_len,
+		},
 	};
-	struct reftable_record want_rec = { NULL };
 	struct reftable_iterator oit = { NULL };
-	struct reftable_obj_record got = { NULL };
-	struct reftable_record got_rec = { NULL };
+	struct reftable_record got = {
+		.type = BLOCK_TYPE_OBJ,
+		.u.obj = { 0 },
+	};
 	int err = 0;
 	struct indexed_table_ref_iter *itr = NULL;
 
 	/* Look through the reverse index. */
-	reftable_record_from_obj(&want_rec, &want);
-	err = reader_seek(r, &oit, &want_rec);
+	err = reader_seek(r, &oit, &want);
 	if (err != 0)
 		goto done;
 
 	/* read out the reftable_obj_record */
-	reftable_record_from_obj(&got_rec, &got);
-	err = iterator_next(&oit, &got_rec);
+	err = iterator_next(&oit, &got);
 	if (err < 0)
 		goto done;
 
-	if (err > 0 ||
-	    memcmp(want.hash_prefix, got.hash_prefix, r->object_id_len)) {
+	if (err > 0 || memcmp(want.u.obj.hash_prefix, got.u.obj.hash_prefix,
+			      r->object_id_len)) {
 		/* didn't find it; return empty iterator */
 		iterator_set_empty(it);
 		err = 0;
@@ -681,15 +684,15 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 	}
 
 	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
-					 got.offsets, got.offset_len);
+					 got.u.obj.offsets, got.u.obj.offset_len);
 	if (err < 0)
 		goto done;
-	got.offsets = NULL;
+	got.u.obj.offsets = NULL;
 	iterator_from_indexed_table_ref_iter(it, itr);
 
 done:
 	reftable_iterator_destroy(&oit);
-	reftable_record_release(&got_rec);
+	reftable_record_release(&got);
 	return err;
 }
 
diff --git a/reftable/record.c b/reftable/record.c
index 8bbcbff1e69..f766ee20ace 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -15,6 +15,10 @@ https://developers.google.com/open-source/licenses/bsd
 #include "reftable-error.h"
 #include "basics.h"
 
+static struct reftable_record_vtable *
+reftable_record_vtable(struct reftable_record *rec);
+static void *reftable_record_data(struct reftable_record *rec);
+
 int get_var_int(uint64_t *dest, struct string_view *in)
 {
 	int ptr = 0;
@@ -926,58 +930,6 @@ static struct reftable_record_vtable reftable_log_record_vtable = {
 	.is_deletion = &reftable_log_record_is_deletion_void,
 };
 
-struct reftable_record reftable_new_record(uint8_t typ)
-{
-	struct reftable_record rec = { NULL };
-	switch (typ) {
-	case BLOCK_TYPE_REF: {
-		struct reftable_ref_record *r =
-			reftable_calloc(sizeof(struct reftable_ref_record));
-		reftable_record_from_ref(&rec, r);
-		return rec;
-	}
-
-	case BLOCK_TYPE_OBJ: {
-		struct reftable_obj_record *r =
-			reftable_calloc(sizeof(struct reftable_obj_record));
-		reftable_record_from_obj(&rec, r);
-		return rec;
-	}
-	case BLOCK_TYPE_LOG: {
-		struct reftable_log_record *r =
-			reftable_calloc(sizeof(struct reftable_log_record));
-		reftable_record_from_log(&rec, r);
-		return rec;
-	}
-	case BLOCK_TYPE_INDEX: {
-		struct reftable_index_record empty = { .last_key =
-							       STRBUF_INIT };
-		struct reftable_index_record *r =
-			reftable_calloc(sizeof(struct reftable_index_record));
-		*r = empty;
-		reftable_record_from_index(&rec, r);
-		return rec;
-	}
-	}
-	abort();
-	return rec;
-}
-
-/* clear out the record, yielding the reftable_record data that was
- * encapsulated. */
-static void *reftable_record_yield(struct reftable_record *rec)
-{
-	void *p = rec->data;
-	rec->data = NULL;
-	return p;
-}
-
-void reftable_record_destroy(struct reftable_record *rec)
-{
-	reftable_record_release(rec);
-	reftable_free(reftable_record_yield(rec));
-}
-
 static void reftable_index_record_key(const void *r, struct strbuf *dest)
 {
 	const struct reftable_index_record *rec = r;
@@ -1055,91 +1007,52 @@ static struct reftable_record_vtable reftable_index_record_vtable = {
 
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest)
 {
-	rec->ops->key(rec->data, dest);
+	reftable_record_vtable(rec)->key(reftable_record_data(rec), dest);
 }
 
 uint8_t reftable_record_type(struct reftable_record *rec)
 {
-	return rec->ops->type;
+	return rec->type;
 }
 
 int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
 			   int hash_size)
 {
-	return rec->ops->encode(rec->data, dest, hash_size);
+	return reftable_record_vtable(rec)->encode(reftable_record_data(rec),
+						   dest, hash_size);
 }
 
 void reftable_record_copy_from(struct reftable_record *rec,
 			       struct reftable_record *src, int hash_size)
 {
-	assert(src->ops->type == rec->ops->type);
+	assert(src->type == rec->type);
 
-	rec->ops->copy_from(rec->data, src->data, hash_size);
+	reftable_record_vtable(rec)->copy_from(reftable_record_data(rec),
+					       reftable_record_data(src),
+					       hash_size);
 }
 
 uint8_t reftable_record_val_type(struct reftable_record *rec)
 {
-	return rec->ops->val_type(rec->data);
+	return reftable_record_vtable(rec)->val_type(reftable_record_data(rec));
 }
 
 int reftable_record_decode(struct reftable_record *rec, struct strbuf key,
 			   uint8_t extra, struct string_view src, int hash_size)
 {
-	return rec->ops->decode(rec->data, key, extra, src, hash_size);
+	return reftable_record_vtable(rec)->decode(reftable_record_data(rec),
+						   key, extra, src, hash_size);
 }
 
 void reftable_record_release(struct reftable_record *rec)
 {
-	rec->ops->release(rec->data);
+	reftable_record_vtable(rec)->release(reftable_record_data(rec));
 }
 
 int reftable_record_is_deletion(struct reftable_record *rec)
 {
-	return rec->ops->is_deletion(rec->data);
-}
-
-void reftable_record_from_ref(struct reftable_record *rec,
-			      struct reftable_ref_record *ref_rec)
-{
-	assert(!rec->ops);
-	rec->data = ref_rec;
-	rec->ops = &reftable_ref_record_vtable;
-}
-
-void reftable_record_from_obj(struct reftable_record *rec,
-			      struct reftable_obj_record *obj_rec)
-{
-	assert(!rec->ops);
-	rec->data = obj_rec;
-	rec->ops = &reftable_obj_record_vtable;
-}
-
-void reftable_record_from_index(struct reftable_record *rec,
-				struct reftable_index_record *index_rec)
-{
-	assert(!rec->ops);
-	rec->data = index_rec;
-	rec->ops = &reftable_index_record_vtable;
-}
-
-void reftable_record_from_log(struct reftable_record *rec,
-			      struct reftable_log_record *log_rec)
-{
-	assert(!rec->ops);
-	rec->data = log_rec;
-	rec->ops = &reftable_log_record_vtable;
-}
-
-struct reftable_ref_record *reftable_record_as_ref(struct reftable_record *rec)
-{
-	assert(reftable_record_type(rec) == BLOCK_TYPE_REF);
-	return rec->data;
-}
-
-struct reftable_log_record *reftable_record_as_log(struct reftable_record *rec)
-{
-	assert(reftable_record_type(rec) == BLOCK_TYPE_LOG);
-	return rec->data;
+	return reftable_record_vtable(rec)->is_deletion(
+		reftable_record_data(rec));
 }
 
 static int hash_equal(uint8_t *a, uint8_t *b, int hash_size)
@@ -1212,3 +1125,53 @@ void string_view_consume(struct string_view *s, int n)
 	s->buf += n;
 	s->len -= n;
 }
+
+static void *reftable_record_data(struct reftable_record *rec)
+{
+	switch (rec->type) {
+	case BLOCK_TYPE_REF:
+		return &rec->u.ref;
+	case BLOCK_TYPE_LOG:
+		return &rec->u.log;
+	case BLOCK_TYPE_INDEX:
+		return &rec->u.idx;
+	case BLOCK_TYPE_OBJ:
+		return &rec->u.obj;
+	}
+	abort();
+}
+
+static struct reftable_record_vtable *
+reftable_record_vtable(struct reftable_record *rec)
+{
+	switch (rec->type) {
+	case BLOCK_TYPE_REF:
+		return &reftable_ref_record_vtable;
+	case BLOCK_TYPE_LOG:
+		return &reftable_log_record_vtable;
+	case BLOCK_TYPE_INDEX:
+		return &reftable_index_record_vtable;
+	case BLOCK_TYPE_OBJ:
+		return &reftable_obj_record_vtable;
+	}
+	abort();
+}
+
+struct reftable_record reftable_new_record(uint8_t typ)
+{
+	struct reftable_record clean_idx = {
+		.type = BLOCK_TYPE_INDEX,
+		.u.idx = {
+			.last_key = STRBUF_INIT,
+		},
+	};
+	struct reftable_record clean = {
+		.type = typ,
+	};
+
+	if (typ == BLOCK_TYPE_INDEX) {
+		return clean_idx;
+	}
+
+	return clean;
+}
diff --git a/reftable/record.h b/reftable/record.h
index 498e8c50bf4..407cdaba018 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -60,16 +60,10 @@ struct reftable_record_vtable {
 	int (*is_deletion)(const void *rec);
 };
 
-/* record is a generic wrapper for different types of records. */
-struct reftable_record {
-	void *data;
-	struct reftable_record_vtable *ops;
-};
-
 /* returns true for recognized block types. Block start with the block type. */
 int reftable_is_block_type(uint8_t typ);
 
-/* creates a malloced record of the given type. Dispose with record_destroy */
+/* return an initialized record for the given type */
 struct reftable_record reftable_new_record(uint8_t typ);
 
 /* Encode `key` into `dest`. Sets `is_restart` to indicate a restart. Returns
@@ -97,6 +91,22 @@ struct reftable_obj_record {
 	int offset_len;
 };
 
+/* record is a generic wrapper for different types of records. It is normally
+ * created on the stack, or embedded within another struct. If the type is
+ * known, a fresh instance can be initialized explicitly. Otherwise, use
+ * reftable_new_record() to initialize generically (as the index_record is not
+ * valid as 0-initialized structure)
+ */
+struct reftable_record {
+	uint8_t type;
+	union {
+		struct reftable_ref_record ref;
+		struct reftable_log_record log;
+		struct reftable_obj_record obj;
+		struct reftable_index_record idx;
+	} u;
+};
+
 /* see struct record_vtable */
 
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
@@ -111,25 +121,9 @@ int reftable_record_decode(struct reftable_record *rec, struct strbuf key,
 			   int hash_size);
 int reftable_record_is_deletion(struct reftable_record *rec);
 
-/* zeroes out the embedded record */
+/* frees and zeroes out the embedded record */
 void reftable_record_release(struct reftable_record *rec);
 
-/* clear and deallocate embedded record, and zero `rec`. */
-void reftable_record_destroy(struct reftable_record *rec);
-
-/* initialize generic records from concrete records. The generic record should
- * be zeroed out. */
-void reftable_record_from_obj(struct reftable_record *rec,
-			      struct reftable_obj_record *objrec);
-void reftable_record_from_index(struct reftable_record *rec,
-				struct reftable_index_record *idxrec);
-void reftable_record_from_ref(struct reftable_record *rec,
-			      struct reftable_ref_record *refrec);
-void reftable_record_from_log(struct reftable_record *rec,
-			      struct reftable_log_record *logrec);
-struct reftable_ref_record *reftable_record_as_ref(struct reftable_record *ref);
-struct reftable_log_record *reftable_record_as_log(struct reftable_record *ref);
-
 /* for qsort. */
 int reftable_ref_record_compare_name(const void *a, const void *b);
 
diff --git a/reftable/record_test.c b/reftable/record_test.c
index f4ad7cace41..96f65035c1b 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -16,24 +16,22 @@
 
 static void test_copy(struct reftable_record *rec)
 {
-	struct reftable_record copy =
-		reftable_new_record(reftable_record_type(rec));
+	struct reftable_record copy = reftable_new_record(reftable_record_type(rec));
+
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
 	/* do it twice to catch memory leaks */
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
-	switch (reftable_record_type(&copy)) {
+	switch (copy.type) {
 	case BLOCK_TYPE_REF:
-		EXPECT(reftable_ref_record_equal(reftable_record_as_ref(&copy),
-						 reftable_record_as_ref(rec),
+		EXPECT(reftable_ref_record_equal(&copy.u.ref, &rec->u.ref,
 						 GIT_SHA1_RAWSZ));
 		break;
 	case BLOCK_TYPE_LOG:
-		EXPECT(reftable_log_record_equal(reftable_record_as_log(&copy),
-						 reftable_record_as_log(rec),
+		EXPECT(reftable_log_record_equal(&copy.u.log, &rec->u.log,
 						 GIT_SHA1_RAWSZ));
 		break;
 	}
-	reftable_record_destroy(&copy);
+	reftable_record_release(&copy);
 }
 
 static void test_varint_roundtrip(void)
@@ -106,61 +104,60 @@ static void test_reftable_ref_record_roundtrip(void)
 	int i = 0;
 
 	for (i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
-		struct reftable_ref_record in = { NULL };
-		struct reftable_ref_record out = { NULL };
-		struct reftable_record rec_out = { NULL };
+		struct reftable_record in = {
+			.type = BLOCK_TYPE_REF,
+		};
+		struct reftable_record out = {
+			.type = BLOCK_TYPE_REF
+		};
 		struct strbuf key = STRBUF_INIT;
-		struct reftable_record rec = { NULL };
 		uint8_t buffer[1024] = { 0 };
 		struct string_view dest = {
 			.buf = buffer,
 			.len = sizeof(buffer),
 		};
-
 		int n, m;
 
-		in.value_type = i;
+		in.u.ref.value_type = i;
 		switch (i) {
 		case REFTABLE_REF_DELETION:
 			break;
 		case REFTABLE_REF_VAL1:
-			in.value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
-			set_hash(in.value.val1, 1);
+			in.u.ref.value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
+			set_hash(in.u.ref.value.val1, 1);
 			break;
 		case REFTABLE_REF_VAL2:
-			in.value.val2.value = reftable_malloc(GIT_SHA1_RAWSZ);
-			set_hash(in.value.val2.value, 1);
-			in.value.val2.target_value =
+			in.u.ref.value.val2.value =
+				reftable_malloc(GIT_SHA1_RAWSZ);
+			set_hash(in.u.ref.value.val2.value, 1);
+			in.u.ref.value.val2.target_value =
 				reftable_malloc(GIT_SHA1_RAWSZ);
-			set_hash(in.value.val2.target_value, 2);
+			set_hash(in.u.ref.value.val2.target_value, 2);
 			break;
 		case REFTABLE_REF_SYMREF:
-			in.value.symref = xstrdup("target");
+			in.u.ref.value.symref = xstrdup("target");
 			break;
 		}
-		in.refname = xstrdup("refs/heads/master");
+		in.u.ref.refname = xstrdup("refs/heads/master");
 
-		reftable_record_from_ref(&rec, &in);
-		test_copy(&rec);
+		test_copy(&in);
 
-		EXPECT(reftable_record_val_type(&rec) == i);
+		EXPECT(reftable_record_val_type(&in) == i);
 
-		reftable_record_key(&rec, &key);
-		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
+		reftable_record_key(&in, &key);
+		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
 		EXPECT(n > 0);
 
 		/* decode into a non-zero reftable_record to test for leaks. */
-
-		reftable_record_from_ref(&rec_out, &out);
-		m = reftable_record_decode(&rec_out, key, i, dest,
-					   GIT_SHA1_RAWSZ);
+		m = reftable_record_decode(&out, key, i, dest, GIT_SHA1_RAWSZ);
 		EXPECT(n == m);
 
-		EXPECT(reftable_ref_record_equal(&in, &out, GIT_SHA1_RAWSZ));
-		reftable_record_release(&rec_out);
+		EXPECT(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
+						 GIT_SHA1_RAWSZ));
+		reftable_record_release(&in);
 
 		strbuf_release(&key);
-		reftable_ref_record_release(&in);
+		reftable_record_release(&out);
 	}
 }
 
@@ -213,7 +210,9 @@ static void test_reftable_log_record_roundtrip(void)
 	set_test_hash(in[0].value.update.new_hash, 1);
 	set_test_hash(in[0].value.update.old_hash, 2);
 	for (i = 0; i < ARRAY_SIZE(in); i++) {
-		struct reftable_record rec = { NULL };
+		struct reftable_record rec = {
+			.type = BLOCK_TYPE_LOG
+		};
 		struct strbuf key = STRBUF_INIT;
 		uint8_t buffer[1024] = { 0 };
 		struct string_view dest = {
@@ -221,23 +220,25 @@ static void test_reftable_log_record_roundtrip(void)
 			.len = sizeof(buffer),
 		};
 		/* populate out, to check for leaks. */
-		struct reftable_log_record out = {
-			.refname = xstrdup("old name"),
-			.value_type = REFTABLE_LOG_UPDATE,
-			.value = {
-				.update = {
-					.new_hash = reftable_calloc(GIT_SHA1_RAWSZ),
-					.old_hash = reftable_calloc(GIT_SHA1_RAWSZ),
-					.name = xstrdup("old name"),
-					.email = xstrdup("old@email"),
-					.message = xstrdup("old message"),
+		struct reftable_record out = {
+			.type = BLOCK_TYPE_LOG,
+			.u.log = {
+				.refname = xstrdup("old name"),
+				.value_type = REFTABLE_LOG_UPDATE,
+				.value = {
+					.update = {
+						.new_hash = reftable_calloc(GIT_SHA1_RAWSZ),
+						.old_hash = reftable_calloc(GIT_SHA1_RAWSZ),
+						.name = xstrdup("old name"),
+						.email = xstrdup("old@email"),
+						.message = xstrdup("old message"),
+					},
 				},
 			},
 		};
-		struct reftable_record rec_out = { NULL };
 		int n, m, valtype;
 
-		reftable_record_from_log(&rec, &in[i]);
+		rec.u.log = in[i];
 
 		test_copy(&rec);
 
@@ -245,16 +246,16 @@ static void test_reftable_log_record_roundtrip(void)
 
 		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
 		EXPECT(n >= 0);
-		reftable_record_from_log(&rec_out, &out);
 		valtype = reftable_record_val_type(&rec);
-		m = reftable_record_decode(&rec_out, key, valtype, dest,
+		m = reftable_record_decode(&out, key, valtype, dest,
 					   GIT_SHA1_RAWSZ);
 		EXPECT(n == m);
 
-		EXPECT(reftable_log_record_equal(&in[i], &out, GIT_SHA1_RAWSZ));
+		EXPECT(reftable_log_record_equal(&in[i], &out.u.log,
+						 GIT_SHA1_RAWSZ));
 		reftable_log_record_release(&in[i]);
 		strbuf_release(&key);
-		reftable_record_release(&rec_out);
+		reftable_record_release(&out);
 	}
 }
 
@@ -322,47 +323,52 @@ static void test_reftable_obj_record_roundtrip(void)
 					       } };
 	int i = 0;
 	for (i = 0; i < ARRAY_SIZE(recs); i++) {
-		struct reftable_obj_record in = recs[i];
 		uint8_t buffer[1024] = { 0 };
 		struct string_view dest = {
 			.buf = buffer,
 			.len = sizeof(buffer),
 		};
-		struct reftable_record rec = { NULL };
+		struct reftable_record in = {
+			.type = BLOCK_TYPE_OBJ,
+			.u.obj = recs[i],
+		};
 		struct strbuf key = STRBUF_INIT;
-		struct reftable_obj_record out = { NULL };
-		struct reftable_record rec_out = { NULL };
+		struct reftable_record out = {
+			.type = BLOCK_TYPE_OBJ
+		};
 		int n, m;
 		uint8_t extra;
 
-		reftable_record_from_obj(&rec, &in);
-		test_copy(&rec);
-		reftable_record_key(&rec, &key);
-		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
+		test_copy(&in);
+		reftable_record_key(&in, &key);
+		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
 		EXPECT(n > 0);
-		extra = reftable_record_val_type(&rec);
-		reftable_record_from_obj(&rec_out, &out);
-		m = reftable_record_decode(&rec_out, key, extra, dest,
+		extra = reftable_record_val_type(&in);
+		m = reftable_record_decode(&out, key, extra, dest,
 					   GIT_SHA1_RAWSZ);
 		EXPECT(n == m);
 
-		EXPECT(in.hash_prefix_len == out.hash_prefix_len);
-		EXPECT(in.offset_len == out.offset_len);
-
-		EXPECT(!memcmp(in.hash_prefix, out.hash_prefix,
-			       in.hash_prefix_len));
-		EXPECT(0 == memcmp(in.offsets, out.offsets,
-				   sizeof(uint64_t) * in.offset_len));
+		EXPECT(in.u.obj.hash_prefix_len == out.u.obj.hash_prefix_len);
+		EXPECT(in.u.obj.offset_len == out.u.obj.offset_len);
+		if (in.u.obj.hash_prefix_len)
+			EXPECT(!memcmp(in.u.obj.hash_prefix, out.u.obj.hash_prefix,
+				       in.u.obj.hash_prefix_len));
+		if (in.u.obj.offset_len)
+			EXPECT(!memcmp(in.u.obj.offsets, out.u.obj.offsets,
+					   sizeof(uint64_t) * in.u.obj.offset_len));
 		strbuf_release(&key);
-		reftable_record_release(&rec_out);
+		reftable_record_release(&out);
 	}
 }
 
 static void test_reftable_index_record_roundtrip(void)
 {
-	struct reftable_index_record in = {
-		.offset = 42,
-		.last_key = STRBUF_INIT,
+	struct reftable_record in = {
+		.type = BLOCK_TYPE_INDEX,
+		.u.idx = {
+			.offset = 42,
+			.last_key = STRBUF_INIT,
+		},
 	};
 	uint8_t buffer[1024] = { 0 };
 	struct string_view dest = {
@@ -370,31 +376,30 @@ static void test_reftable_index_record_roundtrip(void)
 		.len = sizeof(buffer),
 	};
 	struct strbuf key = STRBUF_INIT;
-	struct reftable_record rec = { NULL };
-	struct reftable_index_record out = { .last_key = STRBUF_INIT };
-	struct reftable_record out_rec = { NULL };
+	struct reftable_record out = {
+		.type = BLOCK_TYPE_INDEX,
+		.u.idx = { .last_key = STRBUF_INIT },
+	};
 	int n, m;
 	uint8_t extra;
 
-	strbuf_addstr(&in.last_key, "refs/heads/master");
-	reftable_record_from_index(&rec, &in);
-	reftable_record_key(&rec, &key);
-	test_copy(&rec);
+	strbuf_addstr(&in.u.idx.last_key, "refs/heads/master");
+	reftable_record_key(&in, &key);
+	test_copy(&in);
 
-	EXPECT(0 == strbuf_cmp(&key, &in.last_key));
-	n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
+	EXPECT(0 == strbuf_cmp(&key, &in.u.idx.last_key));
+	n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
 	EXPECT(n > 0);
 
-	extra = reftable_record_val_type(&rec);
-	reftable_record_from_index(&out_rec, &out);
-	m = reftable_record_decode(&out_rec, key, extra, dest, GIT_SHA1_RAWSZ);
+	extra = reftable_record_val_type(&in);
+	m = reftable_record_decode(&out, key, extra, dest, GIT_SHA1_RAWSZ);
 	EXPECT(m == n);
 
-	EXPECT(in.offset == out.offset);
+	EXPECT(in.u.idx.offset == out.u.idx.offset);
 
-	reftable_record_release(&out_rec);
+	reftable_record_release(&out);
 	strbuf_release(&key);
-	strbuf_release(&in.last_key);
+	strbuf_release(&in.u.idx.last_key);
 }
 
 int record_test_main(int argc, const char *argv[])
diff --git a/reftable/writer.c b/reftable/writer.c
index 3ca721e9f64..990f78ff7ed 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -251,8 +251,10 @@ done:
 int reftable_writer_add_ref(struct reftable_writer *w,
 			    struct reftable_ref_record *ref)
 {
-	struct reftable_record rec = { NULL };
-	struct reftable_ref_record copy = *ref;
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_REF,
+		.u.ref = *ref,
+	};
 	int err = 0;
 
 	if (ref->refname == NULL)
@@ -261,8 +263,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 	    ref->update_index > w->max_update_index)
 		return REFTABLE_API_ERROR;
 
-	reftable_record_from_ref(&rec, &copy);
-	copy.update_index -= w->min_update_index;
+	rec.u.ref.update_index -= w->min_update_index;
 
 	err = writer_add_record(w, &rec);
 	if (err < 0)
@@ -301,7 +302,10 @@ int reftable_writer_add_refs(struct reftable_writer *w,
 static int reftable_writer_add_log_verbatim(struct reftable_writer *w,
 					    struct reftable_log_record *log)
 {
-	struct reftable_record rec = { NULL };
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_LOG,
+		.u.log = *log,
+	};
 	if (w->block_writer &&
 	    block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
 		int err = writer_finish_public_section(w);
@@ -311,8 +315,6 @@ static int reftable_writer_add_log_verbatim(struct reftable_writer *w,
 
 	w->next -= w->pending_padding;
 	w->pending_padding = 0;
-
-	reftable_record_from_log(&rec, log);
 	return writer_add_record(w, &rec);
 }
 
@@ -393,8 +395,10 @@ static int writer_finish_section(struct reftable_writer *w)
 		w->index_len = 0;
 		w->index_cap = 0;
 		for (i = 0; i < idx_len; i++) {
-			struct reftable_record rec = { NULL };
-			reftable_record_from_index(&rec, idx + i);
+			struct reftable_record rec = {
+				.type = BLOCK_TYPE_INDEX,
+				.u.idx = idx[i],
+			};
 			if (block_writer_add(w->block_writer, &rec) == 0) {
 				continue;
 			}
@@ -462,17 +466,18 @@ static void write_object_record(void *void_arg, void *key)
 {
 	struct write_record_arg *arg = void_arg;
 	struct obj_index_tree_node *entry = key;
-	struct reftable_obj_record obj_rec = {
-		.hash_prefix = (uint8_t *)entry->hash.buf,
-		.hash_prefix_len = arg->w->stats.object_id_len,
-		.offsets = entry->offsets,
-		.offset_len = entry->offset_len,
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_OBJ,
+		.u.obj = {
+			.hash_prefix = (uint8_t *)entry->hash.buf,
+			.hash_prefix_len = arg->w->stats.object_id_len,
+			.offsets = entry->offsets,
+			.offset_len = entry->offset_len,
+		}
 	};
-	struct reftable_record rec = { NULL };
 	if (arg->err < 0)
 		goto done;
 
-	reftable_record_from_obj(&rec, &obj_rec);
 	arg->err = block_writer_add(arg->w->block_writer, &rec);
 	if (arg->err == 0)
 		goto done;
@@ -485,7 +490,8 @@ static void write_object_record(void *void_arg, void *key)
 	arg->err = block_writer_add(arg->w->block_writer, &rec);
 	if (arg->err == 0)
 		goto done;
-	obj_rec.offset_len = 0;
+
+	rec.u.obj.offset_len = 0;
 	arg->err = block_writer_add(arg->w->block_writer, &rec);
 
 	/* Should be able to write into a fresh block. */
-- 
gitgitgadget
