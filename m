Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F233DC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbhLHVxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhLHVxW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:53:22 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE91BC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 13:49:49 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j3so6505752wrp.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 13:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4llwKganjKNjmZOg8egqT2I/YUDYwQVpJgRPBHxuxz0=;
        b=c4qzgcdU1E4FtWDh23XHF4U6Z1PSMZ6izbPkEvUJnQjxsyb2GrFRUdaWtNdnNspWtj
         saXK5In0sq5KB8oRwShvlmmk/ZP0BAAjnxOTOEVem2AS177gptzfhAuhdcVpocPJ2cuv
         Vx8h8Fi4CxKgdZaPZFbIXIjPEqDwskJ69ZcdnGPCguHJoEmg8xHwg+zZsLbEtqSZZxDN
         nabry7SRIEbZzvjrO15hGsEJW57vGWQ+DSi3jfS/DlDMqHhORODGKcK83AQJwRAWVYUD
         tn31mWFJikOGIxQr9TTS9Ar8haYgS7RpltLP5Rw37gUp8X5/gnR+nuBfhLNoOLTrguIV
         zRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4llwKganjKNjmZOg8egqT2I/YUDYwQVpJgRPBHxuxz0=;
        b=JCmhlZBpUC8GJLdqM0s6Qk7pvMxlqKPgqMjLD4PZ49ZqylBvkux9kxGTLYtaF99Dbv
         eKnrJps902BMJdE9oY3sklpF9ntQZ2qT0KNdGHiEM9H8iLm/119nroXclrtmKK1bpm0l
         e8u9QCooSP32F/eXdVHJBFsjWPd4PCf/EvxAVLyEjZESU1jiEI9srrDIE9/GMi7ArFie
         JTEDRDB/eL1cFqE9bVLatrANJrHd4aQxiAUFQEaAx89xb48mvQQJAIXKszGJhqxdBp66
         KMTDYnZQJLOEewg1vokbjM7kCJ+yQSUV/15xA2vp1oub8WiKvOiJ87/dI+weNt8joAE3
         us2g==
X-Gm-Message-State: AOAM533Nt7frD3ZrEeADiuHvtpp+u8f03oHBI3t166aEPgqg8y/PQ1MP
        jnGZvdFyJsFcsZ9C3haXSMAX4aF1tLQ=
X-Google-Smtp-Source: ABdhPJx+bdKJEDppKJoFyuFYTzYf/qlxLgOtchr4rRU9ynhnt0qQMQo8fPDPbacnJczMku0qXVw5gQ==
X-Received: by 2002:adf:f80f:: with SMTP id s15mr1536234wrp.542.1639000188065;
        Wed, 08 Dec 2021 13:49:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm3820613wrm.96.2021.12.08.13.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:49:47 -0800 (PST)
Message-Id: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 21:49:35 +0000
Subject: [PATCH v2 00/11] Reftable coverity fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series was targeted to 'next'.

This addresses some complaints from Coverity that Peff reported.

CI on GGG shows a segfault on windows
(https://github.com/git/git/runs/4446635428?check_suite_focus=true), which I
can't make sense of. Any hints would be greatly appreciated.

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

 reftable/block.c          |  31 +++++--
 reftable/block_test.c     |  22 ++---
 reftable/blocksource.c    |   6 +-
 reftable/generic.c        |  35 +++----
 reftable/iter.c           |   4 +-
 reftable/merged.c         |  37 ++++----
 reftable/pq.c             |   3 +-
 reftable/pq_test.c        |  31 ++++---
 reftable/reader.c         | 108 +++++++++++-----------
 reftable/readwrite_test.c |   1 -
 reftable/record.c         | 188 +++++++++++++++-----------------------
 reftable/record.h         |  45 ++++-----
 reftable/record_test.c    | 181 ++++++++++++++++++------------------
 reftable/stack.c          |  15 +--
 reftable/stack_test.c     |   3 +-
 reftable/writer.c         |  46 ++++++----
 t/helper/test-reftable.c  |   9 +-
 17 files changed, 376 insertions(+), 389 deletions(-)


base-commit: a8338297339b1ab064e799c15c4fc56c122ef967
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1152%2Fhanwen%2Freftable-coverity-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1152/hanwen/reftable-coverity-v2
Pull-Request: https://github.com/git/git/pull/1152

Range-diff vs v1:

  1:  7c033815183 =  1:  7c033815183 reftable: fix OOB stack write in print functions
  2:  603bd1d4f6e !  2:  1ddcfe61ebc reftable: fix resource leak in error path
     @@ reftable/block.c: int block_reader_init(struct block_reader *br, struct reftable
       
       	if (typ == BLOCK_TYPE_LOG) {
       		int block_header_skip = 4 + header_off;
     +@@ reftable/block.c: int block_reader_init(struct block_reader *br, struct reftable_block *block,
     + 		uLongf src_len = block->len - block_header_skip;
     + 		/* Log blocks specify the *uncompressed* size in their header.
     + 		 */
     +-		uint8_t *uncompressed = reftable_malloc(sz);
     ++		uncompressed = reftable_malloc(sz);
     + 
     + 		/* Copy over the block header verbatim. It's not compressed. */
     + 		memcpy(uncompressed, block->data, block_header_skip);
      @@ reftable/block.c: int block_reader_init(struct block_reader *br, struct reftable_block *block,
       		    uncompress2(uncompressed + block_header_skip, &dst_len,
       				block->data + block_header_skip, &src_len)) {
  3:  97279040dde =  3:  e052b2a61d6 reftable: fix resource leak blocksource.c
  4:  9288289ebcb =  4:  9063137457b reftable: check reftable_stack_auto_compact() return value
  5:  9269977a1c3 =  5:  5020be156ae reftable: ignore remove() return value in stack_test.c
  6:  eab71ab008e =  6:  64c18d01cad reftable: fix resource warning
  7:  47fef87eb4a =  7:  700387ac5d3 reftable: fix NULL derefs in error paths
  8:  458adf0fa9b =  8:  713f1d09f68 reftable: order unittests by complexity
  9:  cd5d8d3607d =  9:  cb601b51a47 reftable: drop stray printf in readwrite_test
  -:  ----------- > 10:  a0f83eff19f reftable: handle null refnames in reftable_ref_record_equal
 10:  8deccc3a1df ! 11:  a2743033cfd reftable: make reftable_record a tagged union
     @@ Commit message
      
          Thanks to Peff for the suggestion.
      
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## reftable/block.c ##
     @@ reftable/block_test.c: static void test_block_read_write(void)
      -		ref.refname = name;
      -		ref.value_type = REFTABLE_REF_VAL1;
      -		ref.value.val1 = hash;
     -+		rec.ref.refname = name;
     -+		rec.ref.value_type = REFTABLE_REF_VAL1;
     -+		rec.ref.value.val1 = hash;
     ++		rec.u.ref.refname = name;
     ++		rec.u.ref.value_type = REFTABLE_REF_VAL1;
     ++		rec.u.ref.value.val1 = hash;
       
       		names[i] = xstrdup(name);
       		n = block_writer_add(&bw, &rec);
      -		ref.refname = NULL;
      -		ref.value_type = REFTABLE_REF_DELETION;
     -+		rec.ref.refname = NULL;
     -+		rec.ref.value_type = REFTABLE_REF_DELETION;
     ++		rec.u.ref.refname = NULL;
     ++		rec.u.ref.value_type = REFTABLE_REF_DELETION;
       		EXPECT(n == 0);
       	}
       
     @@ reftable/block_test.c: static void test_block_read_write(void)
       			break;
       		}
      -		EXPECT_STREQ(names[j], ref.refname);
     -+		EXPECT_STREQ(names[j], rec.ref.refname);
     ++		EXPECT_STREQ(names[j], rec.u.ref.refname);
       		j++;
       	}
       
     @@ reftable/block_test.c: static void test_block_read_write(void)
       		EXPECT(n == 0);
       
      -		EXPECT_STREQ(names[i], ref.refname);
     -+		EXPECT_STREQ(names[i], rec.ref.refname);
     ++		EXPECT_STREQ(names[i], rec.u.ref.refname);
       
       		want.len--;
       		n = block_reader_seek(&br, &it, &want);
     @@ reftable/block_test.c: static void test_block_read_write(void)
       		n = block_iter_next(&it, &rec);
       		EXPECT(n == 0);
      -		EXPECT_STREQ(names[10 * (i / 10)], ref.refname);
     -+		EXPECT_STREQ(names[10 * (i / 10)], rec.ref.refname);
     ++		EXPECT_STREQ(names[10 * (i / 10)], rec.u.ref.refname);
       
       		block_iter_close(&it);
       	}
     @@ reftable/generic.c: https://developers.google.com/open-source/licenses/bsd
      -	struct reftable_record rec = { NULL };
      -	reftable_record_from_ref(&rec, &ref);
      +	struct reftable_record rec = { .type = BLOCK_TYPE_REF,
     -+				       .ref = {
     ++				       .u.ref = {
      +					       .refname = (char *)name,
      +				       } };
       	return tab->ops->seek_record(tab->table_arg, it, &rec);
     @@ reftable/generic.c: https://developers.google.com/open-source/licenses/bsd
      -	struct reftable_record rec = { NULL };
      -	reftable_record_from_log(&rec, &log);
      +	struct reftable_record rec = { .type = BLOCK_TYPE_LOG,
     -+				       .log = {
     ++				       .u.log = {
      +					       .refname = (char *)name,
      +					       .update_index = ~((uint64_t)0),
      +				       } };
     @@ reftable/generic.c: void reftable_iterator_destroy(struct reftable_iterator *it)
      -	return iterator_next(it, &rec);
      +	struct reftable_record rec = { .type = BLOCK_TYPE_REF };
      +	int err = iterator_next(it, &rec);
     -+	*ref = rec.ref;
     ++	*ref = rec.u.ref;
      +	return err;
       }
       
     @@ reftable/generic.c: void reftable_iterator_destroy(struct reftable_iterator *it)
      -	return iterator_next(it, &rec);
      +	struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
      +	int err = iterator_next(it, &rec);
     -+	*log = rec.log;
     ++	*log = rec.u.log;
      +	return err;
       }
       
     @@ reftable/iter.c: static int filtering_ref_iterator_next(void *iter_arg,
       {
       	struct filtering_ref_iterator *fri = iter_arg;
      -	struct reftable_ref_record *ref = rec->data;
     -+	struct reftable_ref_record *ref = &rec->ref;
     ++	struct reftable_ref_record *ref = &rec->u.ref;
       	int err = 0;
       	while (1) {
       		err = reftable_iterator_next_ref(&fri->it, ref);
     @@ reftable/iter.c: static int indexed_table_ref_iter_next_block(struct indexed_tab
       {
       	struct indexed_table_ref_iter *it = p;
      -	struct reftable_ref_record *ref = rec->data;
     -+	struct reftable_ref_record *ref = &rec->ref;
     ++	struct reftable_ref_record *ref = &rec->u.ref;
       
       	while (1) {
       		int err = block_iter_next(&it->cur, rec);
     @@ reftable/merged.c: int reftable_merged_table_seek_ref(struct reftable_merged_tab
      -		.refname = (char *)name,
      +	struct reftable_record rec = {
      +		.type = BLOCK_TYPE_REF,
     -+		.ref = {
     ++		.u.ref = {
      +			.refname = (char *)name,
      +		},
       	};
     @@ reftable/merged.c: int reftable_merged_table_seek_log_at(struct reftable_merged_
      -		.update_index = update_index,
      +	struct reftable_record rec = {
      +		.type = BLOCK_TYPE_LOG,
     -+		.log = {
     ++		.u.log = {
      +			.refname = (char *)name,
      +			.update_index = update_index,
      +		}
     @@ reftable/pq_test.c: static void test_pq(void)
      +		struct pq_entry e = {
      +			.rec = {
      +				.type = BLOCK_TYPE_REF,
     -+				.ref = {
     ++				.u.ref = {
      +					.refname = names[i],
      +				}
      +			}
     @@ reftable/pq_test.c: static void test_pq(void)
      +		EXPECT(rec->type == BLOCK_TYPE_REF);
       		if (last) {
      -			EXPECT(strcmp(last, ref->refname) < 0);
     -+			EXPECT(strcmp(last, rec->ref.refname) < 0);
     ++			EXPECT(strcmp(last, rec->u.ref.refname) < 0);
       		}
      -		last = ref->refname;
      -		ref->refname = NULL;
      -		reftable_free(ref);
      +		// this is names[i], so don't dealloc.
     -+		last = rec->ref.refname;
     -+		rec->ref.refname = NULL;
     ++		last = rec->u.ref.refname;
     ++		rec->u.ref.refname = NULL;
      +		reftable_record_release(rec);
       	}
      -
     @@ reftable/reader.c: static int table_iter_next_in_block(struct table_iter *ti,
      -		((struct reftable_ref_record *)rec->data)->update_index +=
      -			ti->r->min_update_index;
      +	if (res == 0 && rec->type == BLOCK_TYPE_REF) {
     -+		rec->ref.update_index += ti->r->min_update_index;
     ++		rec->u.ref.update_index += ti->r->min_update_index;
       	}
       
       	return res;
     @@ reftable/reader.c: static int reader_seek_indexed(struct reftable_reader *r,
      -	struct reftable_record index_result_rec = { NULL };
      +	struct reftable_record want_index = {
      +		.type = BLOCK_TYPE_INDEX,
     -+		.idx = { .last_key = STRBUF_INIT }
     ++		.u.idx = { .last_key = STRBUF_INIT }
      +	};
      +	struct reftable_record index_result = {
      +		.type = BLOCK_TYPE_INDEX,
     -+		.idx = { .last_key = STRBUF_INIT },
     ++		.u.idx = { .last_key = STRBUF_INIT },
      +	};
       	struct table_iter index_iter = TABLE_ITER_INIT;
       	struct table_iter next = TABLE_ITER_INIT;
     @@ reftable/reader.c: static int reader_seek_indexed(struct reftable_reader *r,
      -	reftable_record_from_index(&index_result_rec, &index_result);
      -
      -	err = reader_start(r, &index_iter, reftable_record_type(rec), 1);
     -+	reftable_record_key(rec, &want_index.idx.last_key);
     ++	reftable_record_key(rec, &want_index.u.idx.last_key);
      +	err = reader_start(r, &index_iter, rec->type, 1);
       	if (err < 0)
       		goto done;
     @@ reftable/reader.c: static int reader_seek_indexed(struct reftable_reader *r,
       			goto done;
       
      -		err = reader_table_iter_at(r, &next, index_result.offset, 0);
     -+		err = reader_table_iter_at(r, &next, index_result.idx.offset,
     ++		err = reader_table_iter_at(r, &next, index_result.u.idx.offset,
      +					   0);
       		if (err != 0)
       			goto done;
       
      -		err = block_iter_seek(&next.bi, &want_index.last_key);
     -+		err = block_iter_seek(&next.bi, &want_index.idx.last_key);
     ++		err = block_iter_seek(&next.bi, &want_index.u.idx.last_key);
       		if (err < 0)
       			goto done;
       
     @@ reftable/reader.c: static int reader_seek(struct reftable_reader *r, struct reft
      -		.refname = (char *)name,
      +	struct reftable_record rec = {
      +		.type = BLOCK_TYPE_REF,
     -+		.ref = {
     ++		.u.ref = {
      +			.refname = (char *)name,
      +		},
       	};
     @@ reftable/reader.c: int reftable_reader_seek_log_at(struct reftable_reader *r,
      -		.update_index = update_index,
      +	struct reftable_record rec = {
      +		.type = BLOCK_TYPE_LOG,
     -+		.log = {
     ++		.u.log = {
      +			.refname = (char *)name,
      +			.update_index = update_index,
      +		}
     @@ reftable/reader.c: static int reftable_reader_refs_for_indexed(struct reftable_r
      -		.hash_prefix_len = r->object_id_len,
      +	struct reftable_record want = {
      +		.type = BLOCK_TYPE_OBJ,
     -+		.obj = {
     ++		.u.obj = {
      +			.hash_prefix = oid,
      +			.hash_prefix_len = r->object_id_len,
      +		},
     @@ reftable/reader.c: static int reftable_reader_refs_for_indexed(struct reftable_r
      -	struct reftable_record got_rec = { NULL };
      +	struct reftable_record got = {
      +		.type = BLOCK_TYPE_OBJ,
     -+		.obj = { 0 },
     ++		.u.obj = { 0 },
      +	};
       	int err = 0;
       	struct indexed_table_ref_iter *itr = NULL;
     @@ reftable/reader.c: static int reftable_reader_refs_for_indexed(struct reftable_r
       
      -	if (err > 0 ||
      -	    memcmp(want.hash_prefix, got.hash_prefix, r->object_id_len)) {
     -+	if (err > 0 || memcmp(want.obj.hash_prefix, got.obj.hash_prefix,
     ++	if (err > 0 || memcmp(want.u.obj.hash_prefix, got.u.obj.hash_prefix,
      +			      r->object_id_len)) {
       		/* didn't find it; return empty iterator */
       		iterator_set_empty(it);
     @@ reftable/reader.c: static int reftable_reader_refs_for_indexed(struct reftable_r
       
       	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
      -					 got.offsets, got.offset_len);
     -+					 got.obj.offsets, got.obj.offset_len);
     ++					 got.u.obj.offsets, got.u.obj.offset_len);
       	if (err < 0)
       		goto done;
      -	got.offsets = NULL;
     -+	got.obj.offsets = NULL;
     ++	got.u.obj.offsets = NULL;
       	iterator_from_indexed_table_ref_iter(it, itr);
       
       done:
     @@ reftable/record.c: void string_view_consume(struct string_view *s, int n)
      +{
      +	switch (rec->type) {
      +	case BLOCK_TYPE_REF:
     -+		return &rec->ref;
     ++		return &rec->u.ref;
      +	case BLOCK_TYPE_LOG:
     -+		return &rec->log;
     ++		return &rec->u.log;
      +	case BLOCK_TYPE_INDEX:
     -+		return &rec->idx;
     ++		return &rec->u.idx;
      +	case BLOCK_TYPE_OBJ:
     -+		return &rec->obj;
     ++		return &rec->u.obj;
      +	}
      +	abort();
      +}
     @@ reftable/record.c: void string_view_consume(struct string_view *s, int n)
      +{
      +	struct reftable_record clean_idx = {
      +		.type = BLOCK_TYPE_INDEX,
     -+		.idx = {
     ++		.u.idx = {
      +			.last_key = STRBUF_INIT,
      +		},
      +	};
     @@ reftable/record.h: struct reftable_obj_record {
      +		struct reftable_log_record log;
      +		struct reftable_obj_record obj;
      +		struct reftable_index_record idx;
     -+	};
     ++	} u;
      +};
      +
       /* see struct record_vtable */
     @@ reftable/record_test.c
       	case BLOCK_TYPE_REF:
      -		EXPECT(reftable_ref_record_equal(reftable_record_as_ref(&copy),
      -						 reftable_record_as_ref(rec),
     -+		EXPECT(reftable_ref_record_equal(&copy.ref, &rec->ref,
     ++		EXPECT(reftable_ref_record_equal(&copy.u.ref, &rec->u.ref,
       						 GIT_SHA1_RAWSZ));
       		break;
       	case BLOCK_TYPE_LOG:
      -		EXPECT(reftable_log_record_equal(reftable_record_as_log(&copy),
      -						 reftable_record_as_log(rec),
     -+		EXPECT(reftable_log_record_equal(&copy.log, &rec->log,
     ++		EXPECT(reftable_log_record_equal(&copy.u.log, &rec->u.log,
       						 GIT_SHA1_RAWSZ));
       		break;
       	}
     @@ reftable/record_test.c: static void test_reftable_ref_record_roundtrip(void)
       		int n, m;
       
      -		in.value_type = i;
     -+		in.ref.value_type = i;
     ++		in.u.ref.value_type = i;
       		switch (i) {
       		case REFTABLE_REF_DELETION:
       			break;
       		case REFTABLE_REF_VAL1:
      -			in.value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
      -			set_hash(in.value.val1, 1);
     -+			in.ref.value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
     -+			set_hash(in.ref.value.val1, 1);
     ++			in.u.ref.value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
     ++			set_hash(in.u.ref.value.val1, 1);
       			break;
       		case REFTABLE_REF_VAL2:
      -			in.value.val2.value = reftable_malloc(GIT_SHA1_RAWSZ);
      -			set_hash(in.value.val2.value, 1);
      -			in.value.val2.target_value =
     -+			in.ref.value.val2.value =
     ++			in.u.ref.value.val2.value =
      +				reftable_malloc(GIT_SHA1_RAWSZ);
     -+			set_hash(in.ref.value.val2.value, 1);
     -+			in.ref.value.val2.target_value =
     ++			set_hash(in.u.ref.value.val2.value, 1);
     ++			in.u.ref.value.val2.target_value =
       				reftable_malloc(GIT_SHA1_RAWSZ);
      -			set_hash(in.value.val2.target_value, 2);
     -+			set_hash(in.ref.value.val2.target_value, 2);
     ++			set_hash(in.u.ref.value.val2.target_value, 2);
       			break;
       		case REFTABLE_REF_SYMREF:
      -			in.value.symref = xstrdup("target");
     -+			in.ref.value.symref = xstrdup("target");
     ++			in.u.ref.value.symref = xstrdup("target");
       			break;
       		}
      -		in.refname = xstrdup("refs/heads/master");
     -+		in.ref.refname = xstrdup("refs/heads/master");
     ++		in.u.ref.refname = xstrdup("refs/heads/master");
       
      -		reftable_record_from_ref(&rec, &in);
      -		test_copy(&rec);
     @@ reftable/record_test.c: static void test_reftable_ref_record_roundtrip(void)
       
      -		EXPECT(reftable_ref_record_equal(&in, &out, GIT_SHA1_RAWSZ));
      -		reftable_record_release(&rec_out);
     -+		EXPECT(reftable_ref_record_equal(&in.ref, &out.ref,
     ++		EXPECT(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
      +						 GIT_SHA1_RAWSZ));
      +		reftable_record_release(&in);
       
     @@ reftable/record_test.c: static void test_reftable_log_record_roundtrip(void)
       		/* populate out, to check for leaks. */
      -		struct reftable_log_record out = {
      -			.refname = xstrdup("old name"),
     +-			.value_type = REFTABLE_LOG_UPDATE,
     +-			.value = {
     +-				.update = {
     +-					.new_hash = reftable_calloc(GIT_SHA1_RAWSZ),
     +-					.old_hash = reftable_calloc(GIT_SHA1_RAWSZ),
     +-					.name = xstrdup("old name"),
     +-					.email = xstrdup("old@email"),
     +-					.message = xstrdup("old message"),
      +		struct reftable_record out = {
      +			.type = BLOCK_TYPE_LOG,
     -+			.log = {
     ++			.u.log = {
      +				.refname = xstrdup("old name"),
     - 			.value_type = REFTABLE_LOG_UPDATE,
     - 			.value = {
     - 				.update = {
     -@@ reftable/record_test.c: static void test_reftable_log_record_roundtrip(void)
     - 					.message = xstrdup("old message"),
     ++				.value_type = REFTABLE_LOG_UPDATE,
     ++				.value = {
     ++					.update = {
     ++						.new_hash = reftable_calloc(GIT_SHA1_RAWSZ),
     ++						.old_hash = reftable_calloc(GIT_SHA1_RAWSZ),
     ++						.name = xstrdup("old name"),
     ++						.email = xstrdup("old@email"),
     ++						.message = xstrdup("old message"),
     ++					},
       				},
       			},
     -+			},
       		};
      -		struct reftable_record rec_out = { NULL };
       		int n, m, valtype;
       
      -		reftable_record_from_log(&rec, &in[i]);
     -+		rec.log = in[i];
     ++		rec.u.log = in[i];
       
       		test_copy(&rec);
       
     @@ reftable/record_test.c: static void test_reftable_log_record_roundtrip(void)
       		EXPECT(n == m);
       
      -		EXPECT(reftable_log_record_equal(&in[i], &out, GIT_SHA1_RAWSZ));
     -+		EXPECT(reftable_log_record_equal(&in[i], &out.log,
     ++		EXPECT(reftable_log_record_equal(&in[i], &out.u.log,
      +						 GIT_SHA1_RAWSZ));
       		reftable_log_record_release(&in[i]);
       		strbuf_release(&key);
     @@ reftable/record_test.c: static void test_reftable_obj_record_roundtrip(void)
      -		struct reftable_record rec = { NULL };
      +		struct reftable_record in = {
      +			.type = BLOCK_TYPE_OBJ,
     -+			.obj = recs[i],
     ++			.u.obj = recs[i],
      +		};
       		struct strbuf key = STRBUF_INIT;
      -		struct reftable_obj_record out = { NULL };
     @@ reftable/record_test.c: static void test_reftable_obj_record_roundtrip(void)
       
      -		EXPECT(in.hash_prefix_len == out.hash_prefix_len);
      -		EXPECT(in.offset_len == out.offset_len);
     -+		EXPECT(in.obj.hash_prefix_len == out.obj.hash_prefix_len);
     -+		EXPECT(in.obj.offset_len == out.obj.offset_len);
     - 
     +-
      -		EXPECT(!memcmp(in.hash_prefix, out.hash_prefix,
      -			       in.hash_prefix_len));
      -		EXPECT(0 == memcmp(in.offsets, out.offsets,
      -				   sizeof(uint64_t) * in.offset_len));
     -+		EXPECT(!memcmp(in.obj.hash_prefix, out.obj.hash_prefix,
     -+			       in.obj.hash_prefix_len));
     -+		EXPECT(0 == memcmp(in.obj.offsets, out.obj.offsets,
     -+				   sizeof(uint64_t) * in.obj.offset_len));
     ++		EXPECT(in.u.obj.hash_prefix_len == out.u.obj.hash_prefix_len);
     ++		EXPECT(in.u.obj.offset_len == out.u.obj.offset_len);
     ++		if (in.u.obj.hash_prefix_len)
     ++			EXPECT(!memcmp(in.u.obj.hash_prefix, out.u.obj.hash_prefix,
     ++				       in.u.obj.hash_prefix_len));
     ++		if (in.u.obj.offset_len)
     ++			EXPECT(!memcmp(in.u.obj.offsets, out.u.obj.offsets,
     ++					   sizeof(uint64_t) * in.u.obj.offset_len));
       		strbuf_release(&key);
      -		reftable_record_release(&rec_out);
      +		reftable_record_release(&out);
     @@ reftable/record_test.c: static void test_reftable_obj_record_roundtrip(void)
      -		.last_key = STRBUF_INIT,
      +	struct reftable_record in = {
      +		.type = BLOCK_TYPE_INDEX,
     -+		.idx = {
     ++		.u.idx = {
      +			.offset = 42,
      +			.last_key = STRBUF_INIT,
      +		},
     @@ reftable/record_test.c: static void test_reftable_index_record_roundtrip(void)
      -	struct reftable_record out_rec = { NULL };
      +	struct reftable_record out = {
      +		.type = BLOCK_TYPE_INDEX,
     -+		.idx = { .last_key = STRBUF_INIT },
     ++		.u.idx = { .last_key = STRBUF_INIT },
      +	};
       	int n, m;
       	uint8_t extra;
     @@ reftable/record_test.c: static void test_reftable_index_record_roundtrip(void)
      -	reftable_record_from_index(&rec, &in);
      -	reftable_record_key(&rec, &key);
      -	test_copy(&rec);
     -+	strbuf_addstr(&in.idx.last_key, "refs/heads/master");
     ++	strbuf_addstr(&in.u.idx.last_key, "refs/heads/master");
      +	reftable_record_key(&in, &key);
      +	test_copy(&in);
       
      -	EXPECT(0 == strbuf_cmp(&key, &in.last_key));
      -	n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
     -+	EXPECT(0 == strbuf_cmp(&key, &in.idx.last_key));
     ++	EXPECT(0 == strbuf_cmp(&key, &in.u.idx.last_key));
      +	n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
       	EXPECT(n > 0);
       
     @@ reftable/record_test.c: static void test_reftable_index_record_roundtrip(void)
       	EXPECT(m == n);
       
      -	EXPECT(in.offset == out.offset);
     -+	EXPECT(in.idx.offset == out.idx.offset);
     ++	EXPECT(in.u.idx.offset == out.u.idx.offset);
       
      -	reftable_record_release(&out_rec);
      +	reftable_record_release(&out);
       	strbuf_release(&key);
      -	strbuf_release(&in.last_key);
     -+	strbuf_release(&in.idx.last_key);
     ++	strbuf_release(&in.u.idx.last_key);
       }
       
       int record_test_main(int argc, const char *argv[])
     @@ reftable/writer.c: done:
      -	struct reftable_ref_record copy = *ref;
      +	struct reftable_record rec = {
      +		.type = BLOCK_TYPE_REF,
     -+		.ref = *ref,
     ++		.u.ref = *ref,
      +	};
       	int err = 0;
       
     @@ reftable/writer.c: int reftable_writer_add_ref(struct reftable_writer *w,
       
      -	reftable_record_from_ref(&rec, &copy);
      -	copy.update_index -= w->min_update_index;
     -+	rec.ref.update_index -= w->min_update_index;
     ++	rec.u.ref.update_index -= w->min_update_index;
       
       	err = writer_add_record(w, &rec);
       	if (err < 0)
     @@ reftable/writer.c: int reftable_writer_add_refs(struct reftable_writer *w,
      -	struct reftable_record rec = { NULL };
      +	struct reftable_record rec = {
      +		.type = BLOCK_TYPE_LOG,
     -+		.log = *log,
     ++		.u.log = *log,
      +	};
       	if (w->block_writer &&
       	    block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
     @@ reftable/writer.c: static int writer_finish_section(struct reftable_writer *w)
      -			reftable_record_from_index(&rec, idx + i);
      +			struct reftable_record rec = {
      +				.type = BLOCK_TYPE_INDEX,
     -+				.idx = idx[i],
     ++				.u.idx = idx[i],
      +			};
       			if (block_writer_add(w->block_writer, &rec) == 0) {
       				continue;
     @@ reftable/writer.c: static void write_object_record(void *void_arg, void *key)
      -		.offset_len = entry->offset_len,
      +	struct reftable_record rec = {
      +		.type = BLOCK_TYPE_OBJ,
     -+		.obj = {
     ++		.u.obj = {
      +			.hash_prefix = (uint8_t *)entry->hash.buf,
      +			.hash_prefix_len = arg->w->stats.object_id_len,
      +			.offsets = entry->offsets,
     @@ reftable/writer.c: static void write_object_record(void *void_arg, void *key)
       		goto done;
      -	obj_rec.offset_len = 0;
      +
     -+	rec.obj.offset_len = 0;
     ++	rec.u.obj.offset_len = 0;
       	arg->err = block_writer_add(arg->w->block_writer, &rec);
       
       	/* Should be able to write into a fresh block. */

-- 
gitgitgadget
