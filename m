Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB48C433FE
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhLMQBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhLMQBx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:01:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B01CC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o13so27807230wrs.12
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YWFGutxkfqNwvlW+NJu7GvYUFf4KvfpdOnN7O/uNj8s=;
        b=N7i6iquqAtsRNnGjgNyaGPb2p7jqSflxHm6ExNFAe0GWIaPx9nN+2VSVn7yX0eBV4O
         YU4lhXrrpz5gCzbWuPkpe5F/YcIO6mrp++H+ZREFClIDtq1S3zFHftol4wIkoqLdBLzD
         6vWxTvZ3cgtUnNa41qIs6qxAzQ0Gwl/sgynixbvoGKxmLkxMF3ZkjpocA2pcdW6VF/dY
         b8emo+BOuaZD00py2hx8fKDRvrTFhWg3vE9e4x6tTq+oHpGczsJdfpbdhf3FuoQ1Wf+6
         pQg+NE/MHeAq7IyICkBQIIkV2bbKsWuF8EUahuAT6N/IOdhohBqhHtX7UliiXzzGaMXp
         ZOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YWFGutxkfqNwvlW+NJu7GvYUFf4KvfpdOnN7O/uNj8s=;
        b=uLazGhXR2U01AuyOweZULdMmi9+iHKcqd2/YNiFqWJO4IzjSlJk73Z3rbZJYR46cjG
         4lkvT0SUKzBXuQMylF0AAGji5SG+35D9p3FGl8EVcqMaS3zSH8WwKgJdR9XLLx3EmuLO
         xc/uCnYqxvJ6MMunr6czCLAD38ku5Ip5UjRmQ5+HiuLXfV8pukmF8Zanj23Oth+IRPW0
         hjyMvbUG8d1enTZwO+QFhse8iZmxewpmRLLMtzwnhILSyRkMnzAFTdkmgarRqNNdSGNU
         1e49lrZsiOrQN+R9OC7ycjg6PrRa6dVqlj83osov2fjXQu7R2XQDPuQqlIlwHxBA8Uub
         RMVQ==
X-Gm-Message-State: AOAM530vp5Is3ScNldZPrGWjq9nVpx8/B0zKu3vslwR6UBPq2oIx3J8i
        ZHl8LvLYUkHISuzsEcFupwDT8b8ZcBk=
X-Google-Smtp-Source: ABdhPJwUFOLD/JNCpoD+SQ1DLozhrvNaaH+UDlp/aUVKj54HXTxazzMQOIItzKJvGhXzWHTAyihiHQ==
X-Received: by 2002:adf:edc1:: with SMTP id v1mr33351724wro.170.1639411311321;
        Mon, 13 Dec 2021 08:01:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm14462745wrc.85.2021.12.13.08.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:01:50 -0800 (PST)
Message-Id: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 16:01:38 +0000
Subject: [PATCH v3 00/11] Reftable coverity fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series was targeted to 'next'.

This addresses some complaints from Coverity that Peff reported.

v3:

 * revert some changes suggested by stolee
 * add unittest for zlib corruption.

Han-Wen Nienhuys (11):
  reftable: fix OOB stack write in print functions
  reftable: fix resource leak in error path
  reftable: fix resource leak blocksource.c
  reftable: check reftable_stack_auto_compact() return value
  reftable: ignore remove() return value in stack_test.c
  reftable: fix resource warning
  reftable: fix NULL derefs in error paths
  reftable: order unittests by complexity
  reftable: drop stray printf in readwrite_test
  reftable: handle null refnames in reftable_ref_record_equal
  reftable: make reftable_record a tagged union

 reftable/block.c          |  30 ++++---
 reftable/block_test.c     |  22 ++---
 reftable/blocksource.c    |   6 +-
 reftable/generic.c        |  35 ++++----
 reftable/iter.c           |   4 +-
 reftable/merged.c         |  33 +++----
 reftable/pq.c             |   3 +-
 reftable/pq_test.c        |  31 +++----
 reftable/reader.c         |  96 ++++++++++----------
 reftable/readwrite_test.c |  68 +++++++++++++-
 reftable/record.c         | 185 ++++++++++++++++----------------------
 reftable/record.h         |  42 ++++-----
 reftable/record_test.c    | 181 +++++++++++++++++++------------------
 reftable/stack.c          |  15 ++--
 reftable/stack_test.c     |   3 +-
 reftable/writer.c         |  40 +++++----
 t/helper/test-reftable.c  |   9 +-
 17 files changed, 431 insertions(+), 372 deletions(-)


base-commit: fae76fe5da3df25d752f2251b7ccda3f62813aa9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1152%2Fhanwen%2Freftable-coverity-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1152/hanwen/reftable-coverity-v3
Pull-Request: https://github.com/git/git/pull/1152

Range-diff vs v2:

  1:  7c033815183 =  1:  1c1a3ff92bd reftable: fix OOB stack write in print functions
  2:  1ddcfe61ebc !  2:  975a570d388 reftable: fix resource leak in error path
     @@ Metadata
       ## Commit message ##
          reftable: fix resource leak in error path
      
     -    This would be triggered by corrupt files, so it doesn't have test coverage. This
     -    was discovered by a Coverity scan.
     +    Add test coverage for corrupt zlib data.
     +
     +    This problem was discovered by a Coverity scan.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     @@ reftable/block.c: int block_reader_init(struct block_reader *br, struct reftable
       		/* Copy over the block header verbatim. It's not compressed. */
       		memcpy(uncompressed, block->data, block_header_skip);
      @@ reftable/block.c: int block_reader_init(struct block_reader *br, struct reftable_block *block,
     + 		if (Z_OK !=
       		    uncompress2(uncompressed + block_header_skip, &dst_len,
       				block->data + block_header_skip, &src_len)) {
     - 			reftable_free(uncompressed);
     +-			reftable_free(uncompressed);
      -			return REFTABLE_ZLIB_ERROR;
      +			err = REFTABLE_ZLIB_ERROR;
      +			goto done;
     @@ reftable/block.c: int block_reader_init(struct block_reader *br, struct reftable
       }
       
       static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
     +
     + ## reftable/readwrite_test.c ##
     +@@ reftable/readwrite_test.c: static void test_log_write_read(void)
     + 	reader_close(&rd);
     + }
     + 
     ++static void test_log_zlib_corruption(void)
     ++{
     ++	struct reftable_write_options opts = {
     ++		.block_size = 256,
     ++	};
     ++	struct reftable_iterator it = { NULL };
     ++	struct reftable_reader rd = { NULL };
     ++	struct reftable_block_source source = { NULL };
     ++	struct strbuf buf = STRBUF_INIT;
     ++	struct reftable_writer *w =
     ++		reftable_new_writer(&strbuf_add_void, &buf, &opts);
     ++	const struct reftable_stats *stats = NULL;
     ++	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1 };
     ++	uint8_t hash2[GIT_SHA1_RAWSZ] = { 2 };
     ++	char message[100] = { 0 };
     ++	int err, i, n;
     ++
     ++	struct reftable_log_record log = {
     ++		.refname = "refname",
     ++		.value_type = REFTABLE_LOG_UPDATE,
     ++		.value = {
     ++			.update = {
     ++				.new_hash = hash1,
     ++				.old_hash = hash2,
     ++				.name = "My Name",
     ++				.email = "myname@invalid",
     ++				.message = message,
     ++			},
     ++		},
     ++	};
     ++
     ++	for (i = 0; i < sizeof(message)-1; i++) {
     ++		message[i] = (uint8_t)(rand() % 64 + ' ');
     ++	}
     ++
     ++	reftable_writer_set_limits(w, 1, 1);
     ++
     ++	err = reftable_writer_add_log(w, &log);
     ++	EXPECT_ERR(err);
     ++
     ++	n = reftable_writer_close(w);
     ++	EXPECT(n == 0);
     ++
     ++	stats = writer_stats(w);
     ++	EXPECT(stats->log_stats.blocks > 0);
     ++	reftable_writer_free(w);
     ++	w = NULL;
     ++
     ++	/* corrupt the data. */
     ++	buf.buf[50] ^= 0x99;
     ++
     ++	block_source_from_strbuf(&source, &buf);
     ++
     ++	err = init_reader(&rd, &source, "file.log");
     ++	EXPECT_ERR(err);
     ++
     ++	err = reftable_reader_seek_log(&rd, &it, "refname");
     ++	EXPECT(err == REFTABLE_ZLIB_ERROR);
     ++
     ++	reftable_iterator_destroy(&it);
     ++
     ++	/* cleanup. */
     ++	strbuf_release(&buf);
     ++	reader_close(&rd);
     ++}
     ++
     + static void test_table_read_write_sequential(void)
     + {
     + 	char **names;
     +@@ reftable/readwrite_test.c: static void test_corrupt_table(void)
     + 
     + int readwrite_test_main(int argc, const char *argv[])
     + {
     ++	RUN_TEST(test_log_zlib_corruption);
     + 	RUN_TEST(test_corrupt_table);
     + 	RUN_TEST(test_corrupt_table_empty);
     + 	RUN_TEST(test_log_write_read);
  3:  e052b2a61d6 =  3:  0b9c7176d71 reftable: fix resource leak blocksource.c
  4:  9063137457b =  4:  1dda4ee717f reftable: check reftable_stack_auto_compact() return value
  5:  5020be156ae =  5:  36858e2070b reftable: ignore remove() return value in stack_test.c
  6:  64c18d01cad =  6:  80b1988b885 reftable: fix resource warning
  7:  700387ac5d3 =  7:  2939286924c reftable: fix NULL derefs in error paths
  8:  713f1d09f68 =  8:  9dce18d7349 reftable: order unittests by complexity
  9:  cb601b51a47 =  9:  6b0af68f0b9 reftable: drop stray printf in readwrite_test
 10:  a0f83eff19f = 10:  bff85cb0809 reftable: handle null refnames in reftable_ref_record_equal
 11:  a2743033cfd ! 11:  b3e592b9c27 reftable: make reftable_record a tagged union
     @@ Commit message
          vtable within the structure.
      
          The only snag is that reftable_index_record contain a strbuf, so it cannot be
     -    zero-initialized. To address this, introduce reftable_record_for() to create a
     -    fresh instance, given a record type.
     +    zero-initialized. To address this, use reftable_new_record() to return fresh
     +    instance, given a record type. Since reftable_new_record() doesn't cause heap
     +    allocation anymore, it should be balanced with reftable_record_release() rather
     +    than reftable_record_destroy().
      
          Thanks to Peff for the suggestion.
      
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## reftable/block.c ##
     -@@ reftable/block.c: int block_reader_seek(struct block_reader *br, struct block_iter *it,
     - 		.key = *want,
     - 		.r = br,
     - 	};
     --	struct reftable_record rec = reftable_new_record(block_reader_type(br));
     -+	struct reftable_record rec = reftable_record_for(block_reader_type(br));
     - 	struct strbuf key = STRBUF_INIT;
     - 	int err = 0;
     - 	struct block_iter next = {
      @@ reftable/block.c: int block_reader_seek(struct block_reader *br, struct block_iter *it,
       done:
       	strbuf_release(&key);
     @@ reftable/iter.c: static int indexed_table_ref_iter_next_block(struct indexed_tab
      
       ## reftable/merged.c ##
      @@ reftable/merged.c: static int merged_iter_init(struct merged_iter *mi)
     - {
     - 	int i = 0;
     - 	for (i = 0; i < mi->stack_len; i++) {
     --		struct reftable_record rec = reftable_new_record(mi->typ);
     -+		struct reftable_record rec = reftable_record_for(mi->typ);
     - 		int err = iterator_next(&mi->stack[i], &rec);
     - 		if (err < 0) {
     - 			return err;
     -@@ reftable/merged.c: static int merged_iter_init(struct merged_iter *mi)
       
       		if (err > 0) {
       			reftable_iterator_destroy(&mi->stack[i]);
     @@ reftable/merged.c: static void merged_iter_close(void *p)
      -	struct reftable_record rec = reftable_new_record(mi->typ);
       	struct pq_entry e = {
      -		.rec = rec,
     -+		.rec = reftable_record_for(mi->typ),
     ++		.rec = reftable_new_record(mi->typ),
       		.index = idx,
       	};
      -	int err = iterator_next(&mi->stack[idx], &rec);
     @@ reftable/merged.c: static int merged_iter_next_entry(struct merged_iter *mi,
       	strbuf_release(&entry_key);
       	return 0;
       }
     -@@ reftable/merged.c: static int merged_table_seek_record(struct reftable_merged_table *mt,
     - 		sizeof(struct reftable_iterator) * mt->stack_len);
     - 	struct merged_iter merged = {
     - 		.stack = iters,
     --		.typ = reftable_record_type(rec),
     -+		.typ = rec->type,
     - 		.hash_id = mt->hash_id,
     - 		.suppress_deletions = mt->suppress_deletions,
     - 	};
      @@ reftable/merged.c: int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
       				   struct reftable_iterator *it,
       				   const char *name)
     @@ reftable/pq_test.c: static void test_pq(void)
      +		struct reftable_record *rec = &e.rec;
       		merged_iter_pqueue_check(pq);
       
     -+		EXPECT(rec->type == BLOCK_TYPE_REF);
     ++		EXPECT(reftable_record_type(rec) == BLOCK_TYPE_REF);
       		if (last) {
      -			EXPECT(strcmp(last, ref->refname) < 0);
      +			EXPECT(strcmp(last, rec->u.ref.refname) < 0);
     @@ reftable/pq_test.c: static void test_pq(void)
      
       ## reftable/reader.c ##
      @@ reftable/reader.c: static int table_iter_next_in_block(struct table_iter *ti,
     - 				    struct reftable_record *rec)
       {
       	int res = block_iter_next(&ti->bi, rec);
     --	if (res == 0 && reftable_record_type(rec) == BLOCK_TYPE_REF) {
     + 	if (res == 0 && reftable_record_type(rec) == BLOCK_TYPE_REF) {
      -		((struct reftable_ref_record *)rec->data)->update_index +=
      -			ti->r->min_update_index;
     -+	if (res == 0 && rec->type == BLOCK_TYPE_REF) {
      +		rec->u.ref.update_index += ti->r->min_update_index;
       	}
       
       	return res;
     -@@ reftable/reader.c: static int table_iter_next_block(struct table_iter *dest,
     - 
     - static int table_iter_next(struct table_iter *ti, struct reftable_record *rec)
     - {
     --	if (reftable_record_type(rec) != ti->typ)
     -+	if (rec->type != ti->typ)
     - 		return REFTABLE_API_ERROR;
     - 
     - 	while (1) {
      @@ reftable/reader.c: static int reader_start(struct reftable_reader *r, struct table_iter *ti,
       static int reader_seek_linear(struct reftable_reader *r, struct table_iter *ti,
       			      struct reftable_record *want)
       {
      -	struct reftable_record rec =
      -		reftable_new_record(reftable_record_type(want));
     -+	struct reftable_record rec = reftable_record_for(want->type);
     ++	struct reftable_record rec = reftable_new_record(reftable_record_type(want));
       	struct strbuf want_key = STRBUF_INIT;
       	struct strbuf got_key = STRBUF_INIT;
       	struct table_iter next = TABLE_ITER_INIT;
     @@ reftable/reader.c: static int reader_seek_indexed(struct reftable_reader *r,
      -	reftable_record_from_index(&want_index_rec, &want_index);
      -	reftable_record_from_index(&index_result_rec, &index_result);
      -
     --	err = reader_start(r, &index_iter, reftable_record_type(rec), 1);
      +	reftable_record_key(rec, &want_index.u.idx.last_key);
     -+	err = reader_start(r, &index_iter, rec->type, 1);
     + 	err = reader_start(r, &index_iter, reftable_record_type(rec), 1);
       	if (err < 0)
       		goto done;
       
     @@ reftable/reader.c: static int reader_seek_indexed(struct reftable_reader *r,
       		if (err < 0)
       			goto done;
       
     --		if (next.typ == reftable_record_type(rec)) {
     -+		if (next.typ == rec->type) {
     - 			err = 0;
     - 			break;
     - 		}
      @@ reftable/reader.c: static int reader_seek_indexed(struct reftable_reader *r,
       done:
       	block_iter_close(&next.bi);
     @@ reftable/reader.c: static int reader_seek_internal(struct reftable_reader *r,
       {
      -	struct reftable_reader_offsets *offs =
      -		reader_offsets_for(r, reftable_record_type(rec));
     -+	struct reftable_reader_offsets *offs = reader_offsets_for(r, rec->type);
     ++	struct reftable_reader_offsets *offs = reader_offsets_for(r, reftable_record_type(rec));
       	uint64_t idx = offs->index_offset;
       	struct table_iter ti = TABLE_ITER_INIT;
       	int err = 0;
     - 	if (idx > 0)
     - 		return reader_seek_indexed(r, it, rec);
     - 
     --	err = reader_start(r, &ti, reftable_record_type(rec), 0);
     -+	err = reader_start(r, &ti, rec->type, 0);
     - 	if (err < 0)
     - 		return err;
     - 	err = reader_seek_linear(r, &ti, rec);
     -@@ reftable/reader.c: static int reader_seek_internal(struct reftable_reader *r,
     - static int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
     - 		       struct reftable_record *rec)
     - {
     --	uint8_t typ = reftable_record_type(rec);
     -+	uint8_t typ = rec->type;
     - 
     - 	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
     - 	if (!offs->is_present) {
      @@ reftable/reader.c: static int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
       int reftable_reader_seek_ref(struct reftable_reader *r,
       			     struct reftable_iterator *it, const char *name)
     @@ reftable/record.c: static struct reftable_record_vtable reftable_index_record_vt
       void reftable_record_key(struct reftable_record *rec, struct strbuf *dest)
       {
      -	rec->ops->key(rec->data, dest);
     --}
     --
     --uint8_t reftable_record_type(struct reftable_record *rec)
     --{
     --	return rec->ops->type;
      +	reftable_record_vtable(rec)->key(reftable_record_data(rec), dest);
       }
       
     + uint8_t reftable_record_type(struct reftable_record *rec)
     + {
     +-	return rec->ops->type;
     ++	return rec->type;
     + }
     + 
       int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
       			   int hash_size)
       {
     @@ reftable/record.c: void string_view_consume(struct string_view *s, int n)
      +	abort();
      +}
      +
     -+struct reftable_record reftable_record_for(uint8_t typ)
     ++struct reftable_record reftable_new_record(uint8_t typ)
      +{
      +	struct reftable_record clean_idx = {
      +		.type = BLOCK_TYPE_INDEX,
     @@ reftable/record.h: struct reftable_record_vtable {
       int reftable_is_block_type(uint8_t typ);
       
      -/* creates a malloced record of the given type. Dispose with record_destroy */
     --struct reftable_record reftable_new_record(uint8_t typ);
     --
     ++/* return an initialized record for the given type */
     + struct reftable_record reftable_new_record(uint8_t typ);
     + 
       /* Encode `key` into `dest`. Sets `is_restart` to indicate a restart. Returns
     -  * number of bytes written. */
     - int reftable_encode_key(int *is_restart, struct string_view dest,
      @@ reftable/record.h: struct reftable_obj_record {
       	int offset_len;
       };
     @@ reftable/record.h: struct reftable_obj_record {
      +/* record is a generic wrapper for different types of records. It is normally
      + * created on the stack, or embedded within another struct. If the type is
      + * known, a fresh instance can be initialized explicitly. Otherwise, use
     -+ * reftable_record_for() to initialize generically (as the index_record is not
     ++ * reftable_new_record() to initialize generically (as the index_record is not
      + * valid as 0-initialized structure)
      + */
      +struct reftable_record {
     @@ reftable/record.h: struct reftable_obj_record {
      +
       /* see struct record_vtable */
       
     -+/* return an initialized record for the given type */
     -+struct reftable_record reftable_record_for(uint8_t typ);
       void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
     - uint8_t reftable_record_type(struct reftable_record *rec);
     - void reftable_record_copy_from(struct reftable_record *rec,
      @@ reftable/record.h: int reftable_record_decode(struct reftable_record *rec, struct strbuf key,
       			   int hash_size);
       int reftable_record_is_deletion(struct reftable_record *rec);
     @@ reftable/record_test.c
       {
      -	struct reftable_record copy =
      -		reftable_new_record(reftable_record_type(rec));
     -+	struct reftable_record copy = reftable_record_for(rec->type);
     ++	struct reftable_record copy = reftable_new_record(reftable_record_type(rec));
      +
       	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
       	/* do it twice to catch memory leaks */
     @@ reftable/record_test.c: static void test_reftable_index_record_roundtrip(void)
       int record_test_main(int argc, const char *argv[])
      
       ## reftable/writer.c ##
     -@@ reftable/writer.c: static int writer_add_record(struct reftable_writer *w,
     - 	strbuf_reset(&w->last_key);
     - 	strbuf_addbuf(&w->last_key, &key);
     - 	if (w->block_writer == NULL) {
     --		writer_reinit_block_writer(w, reftable_record_type(rec));
     -+		writer_reinit_block_writer(w, rec->type);
     - 	}
     - 
     --	assert(block_writer_type(w->block_writer) == reftable_record_type(rec));
     -+	assert(block_writer_type(w->block_writer) == rec->type);
     - 
     - 	if (block_writer_add(w->block_writer, rec) == 0) {
     - 		err = 0;
     -@@ reftable/writer.c: static int writer_add_record(struct reftable_writer *w,
     - 		goto done;
     - 	}
     - 
     --	writer_reinit_block_writer(w, reftable_record_type(rec));
     -+	writer_reinit_block_writer(w, rec->type);
     - 	err = block_writer_add(w->block_writer, rec);
     - 	if (err < 0) {
     - 		goto done;
      @@ reftable/writer.c: done:
       int reftable_writer_add_ref(struct reftable_writer *w,
       			    struct reftable_ref_record *ref)

-- 
gitgitgadget
