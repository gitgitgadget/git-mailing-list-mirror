Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510D3C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344949AbhLVS4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344943AbhLVS4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399EFC061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:39 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r17so6793392wrc.3
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OYY2hbAGXew9+uTBzReWmdX5uZ5Irn3Wx+LwWsxJpAM=;
        b=ddTzG+Z2tkzJ6V+os21aJJs17LkEPgVz+y5Y6SsT//SmYt0uP03tS/pRg5Yz/4vCpY
         tu26f+O3nSByf31lUvqnCw4MSZNAdeu6LE9xQChdg1U7ttFBtjwAO8KdkgIztNKvkp3d
         GTmillVzaamNVqS/ukQDJ/tWqwpC73iJRAjCTWeUgEOB+b9axmJH2ZQGjNgLJWxHOor4
         Wy5JlYgRMJ5Scht8X+eaXope+LDMSs3CB4ry5oHGA2a2/QQNtEKdh7gUrNR5RlXF6iX2
         cr7c1K9EehQkpPNbIUwsGgtSpI7wiH9qv0ESGJazYH2rJpPcputyHvwAji5IE4k5F0JS
         vbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OYY2hbAGXew9+uTBzReWmdX5uZ5Irn3Wx+LwWsxJpAM=;
        b=w7DeYidd7QTVip+JX20ti2SiK4wURGa8KbQ3GQVXF4SKuwP7am7UDYE9QfNm8+OCjs
         vA6maVu+I4gQQweHq/SX402VGA6wLTQGJXvNl4sHMXSTkorrCS/+EuCy/e2pSwh73rtU
         ZmeofNQBpuHHp3Gr/HAiH99caXQD0qJBQd43ABvecMgEfnD6kQvy/iUqhCYCD+QEB+13
         DE7NPFcu88SEdPC05C9JMypT0S8Vy4mA1eFxiZ+8cxl0PlSipgwnXdT6KdNNjAWSBXh2
         JjOs6caFXbepBgPFnMt4F4FqyPMUWZ5nsuTCFtGz95EFjANXpr1VpIhmz6/UoNA0iWaF
         edDQ==
X-Gm-Message-State: AOAM531z6/v8v1zAOFOUX+IaZX5g4rFg+Yg8f7zEeu27qEdIy39xngZJ
        DVFC0/BTNtAoLSbM4ZyCLUdSLsZ9Y80=
X-Google-Smtp-Source: ABdhPJxr3ump8ygEP0oJU1shhPnk5Y4XCP8thBrvfHErUlZ5TF5lCJE+ev3kHhq215r1JVSRne0liA==
X-Received: by 2002:adf:f8cb:: with SMTP id f11mr2910861wrq.700.1640199397278;
        Wed, 22 Dec 2021 10:56:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h27sm6304842wmc.43.2021.12.22.10.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:36 -0800 (PST)
Message-Id: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:20 +0000
Subject: [PATCH v5 00/16] Reftable coverity fixes
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

v5:

 * add generic record equality
 * add generic record printing
 * const correctness for record-reftable.h
 * fix windows crash.
 * 0-length memcpy paranoia
 * drop unused file.

Han-Wen Nienhuys (16):
  reftable: fix OOB stack write in print functions
  reftable: fix resource leak in block.c error path
  reftable: fix resource leak blocksource.c
  reftable: check reftable_stack_auto_compact() return value
  reftable: ignore remove() return value in stack_test.c
  reftable: fix resource warning
  reftable: all xxx_free() functions accept NULL arguments
  reftable: order unittests by complexity
  reftable: drop stray printf in readwrite_test
  reftable: handle null refnames in reftable_ref_record_equal
  reftable: make reftable-record.h function signatures const correct
  reftable: implement record equality generically
  reftable: remove outdated file reftable.c
  reftable: make reftable_record a tagged union
  reftable: add print functions to the record types
  reftable: be more paranoid about 0-length memcpy calls

 reftable/block.c           |  28 ++-
 reftable/block_test.c      |  22 +--
 reftable/blocksource.c     |   6 +-
 reftable/generic.c         |  41 ++--
 reftable/iter.c            |   4 +-
 reftable/merged.c          |  33 ++--
 reftable/pq.c              |   3 +-
 reftable/pq_test.c         |  27 ++-
 reftable/reader.c          | 113 ++++++-----
 reftable/readwrite_test.c  |  67 ++++++-
 reftable/record.c          | 376 ++++++++++++++++++++++++-------------
 reftable/record.h          |  49 ++---
 reftable/record_test.c     | 197 +++++++++----------
 reftable/reftable-record.h |  14 +-
 reftable/reftable.c        | 115 ------------
 reftable/stack.c           |  12 +-
 reftable/stack_test.c      |   3 +-
 reftable/writer.c          |  43 +++--
 t/helper/test-reftable.c   |   9 +-
 19 files changed, 629 insertions(+), 533 deletions(-)
 delete mode 100644 reftable/reftable.c


base-commit: 69a9c10c95e28df457e33b3c7400b16caf2e2962
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1152%2Fhanwen%2Freftable-coverity-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1152/hanwen/reftable-coverity-v5
Pull-Request: https://github.com/git/git/pull/1152

Range-diff vs v4:

  1:  1c1a3ff92bd =  1:  e7f1be7bbec reftable: fix OOB stack write in print functions
  2:  923293b79b4 !  2:  9ab631a3b29 reftable: fix resource leak in block.c error path
     @@ Metadata
       ## Commit message ##
          reftable: fix resource leak in block.c error path
      
     -    Add test coverage for corrupt zlib data.
     +    Add test coverage for corrupt zlib data. Fix memory leaks demonstrated by
     +    unittest.
      
          This problem was discovered by a Coverity scan.
      
     @@ reftable/block.c: int block_reader_init(struct block_reader *br, struct reftable
       
       static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
      
     + ## reftable/reader.c ##
     +@@ reftable/reader.c: int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
     + 
     + 	err = reader_get_block(r, &block, next_off, guess_block_size);
     + 	if (err < 0)
     +-		return err;
     ++		goto done;
     + 
     + 	block_size = extract_block_size(block.data, &block_typ, next_off,
     + 					r->version);
     +-	if (block_size < 0)
     +-		return block_size;
     +-
     ++	if (block_size < 0) {
     ++		err = block_size;
     ++		goto done;
     ++	}
     + 	if (want_typ != BLOCK_TYPE_ANY && block_typ != want_typ) {
     +-		reftable_block_done(&block);
     +-		return 1;
     ++		err = 1;
     ++		goto done;
     + 	}
     + 
     + 	if (block_size > guess_block_size) {
     + 		reftable_block_done(&block);
     + 		err = reader_get_block(r, &block, next_off, block_size);
     + 		if (err < 0) {
     +-			return err;
     ++			goto done;
     + 		}
     + 	}
     + 
     +-	return block_reader_init(br, &block, header_off, r->block_size,
     +-				 hash_size(r->hash_id));
     ++	err = block_reader_init(br, &block, header_off, r->block_size,
     ++				hash_size(r->hash_id));
     ++done:
     ++	if (err)
     ++		reftable_block_done(&block);
     ++
     ++	return err;
     + }
     + 
     + static int table_iter_next_block(struct table_iter *dest,
     +
       ## reftable/readwrite_test.c ##
      @@ reftable/readwrite_test.c: static void test_log_write_read(void)
       	reader_close(&rd);
  3:  7a914f77756 =  3:  8301000e83b reftable: fix resource leak blocksource.c
  4:  51b4a17a2e1 =  4:  e6e53aabc39 reftable: check reftable_stack_auto_compact() return value
  5:  43989afcb5a =  5:  7551bcdd917 reftable: ignore remove() return value in stack_test.c
  6:  1c7f15d811c =  6:  700a4e247e7 reftable: fix resource warning
  7:  47ba5ddceb8 =  7:  30016fee4c8 reftable: all xxx_free() functions accept NULL arguments
  8:  aba8b8113ad =  8:  f90846cc103 reftable: order unittests by complexity
  9:  f2af404d7f1 =  9:  425e12d3667 reftable: drop stray printf in readwrite_test
 10:  d2ce1bfef9f = 10:  67d858ec59e reftable: handle null refnames in reftable_ref_record_equal
  -:  ----------- > 11:  1e50924894f reftable: make reftable-record.h function signatures const correct
  -:  ----------- > 12:  c81b17ad57e reftable: implement record equality generically
  -:  ----------- > 13:  4175089ec43 reftable: remove outdated file reftable.c
 11:  0ffc1cf0e42 ! 14:  ede2e792ab6 reftable: make reftable_record a tagged union
     @@ reftable/generic.c: void reftable_iterator_destroy(struct reftable_iterator *it)
      -	struct reftable_record rec = { NULL };
      -	reftable_record_from_ref(&rec, ref);
      -	return iterator_next(it, &rec);
     -+	struct reftable_record rec = { .type = BLOCK_TYPE_REF };
     ++	struct reftable_record rec = {
     ++		.type = BLOCK_TYPE_REF,
     ++		.u.ref = *ref,
     ++	};
      +	int err = iterator_next(it, &rec);
      +	*ref = rec.u.ref;
      +	return err;
     @@ reftable/generic.c: void reftable_iterator_destroy(struct reftable_iterator *it)
      -	struct reftable_record rec = { NULL };
      -	reftable_record_from_log(&rec, log);
      -	return iterator_next(it, &rec);
     -+	struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
     ++	struct reftable_record rec = {
     ++		.type = BLOCK_TYPE_LOG,
     ++		.u.log = *log,
     ++	};
      +	int err = iterator_next(it, &rec);
      +	*log = rec.u.log;
      +	return err;
     @@ reftable/merged.c: int reftable_merged_table_seek_log_at(struct reftable_merged_
      -	struct reftable_log_record log = {
      -		.refname = (char *)name,
      -		.update_index = update_index,
     -+	struct reftable_record rec = {
     -+		.type = BLOCK_TYPE_LOG,
     -+		.u.log = {
     -+			.refname = (char *)name,
     -+			.update_index = update_index,
     -+		}
     - 	};
     +-	};
      -	struct reftable_record rec = { NULL };
      -	reftable_record_from_log(&rec, &log);
     ++	struct reftable_record rec = { .type = BLOCK_TYPE_LOG,
     ++				       .u.log = {
     ++					       .refname = (char *)name,
     ++					       .update_index = update_index,
     ++				       } };
       	return merged_table_seek_record(mt, it, &rec);
       }
       
     @@ reftable/pq_test.c: static void test_pq(void)
      -
      -		reftable_record_as_ref(&rec)->refname = names[i];
      -		e.rec = rec;
     -+		struct pq_entry e = {
     -+			.rec = {
     -+				.type = BLOCK_TYPE_REF,
     -+				.u.ref = {
     -+					.refname = names[i],
     -+				}
     -+			}
     -+		};
     ++		struct pq_entry e = { .rec = { .type = BLOCK_TYPE_REF,
     ++					       .u.ref = {
     ++						       .refname = names[i],
     ++					       } } };
       		merged_iter_pqueue_add(&pq, e);
       		merged_iter_pqueue_check(pq);
       		i = (i * 7) % N;
     @@ reftable/reader.c: static int table_iter_next_in_block(struct table_iter *ti,
       	}
       
       	return res;
     -@@ reftable/reader.c: static int reader_start(struct reftable_reader *r, struct table_iter *ti,
     - static int reader_seek_linear(struct reftable_reader *r, struct table_iter *ti,
     - 			      struct reftable_record *want)
     - {
     --	struct reftable_record rec =
     --		reftable_new_record(reftable_record_type(want));
     -+	struct reftable_record rec = reftable_new_record(reftable_record_type(want));
     - 	struct strbuf want_key = STRBUF_INIT;
     - 	struct strbuf got_key = STRBUF_INIT;
     - 	struct table_iter next = TABLE_ITER_INIT;
      @@ reftable/reader.c: static int reader_seek_linear(struct reftable_reader *r, struct table_iter *ti,
       
       done:
     @@ reftable/reader.c: static int reader_seek_indexed(struct reftable_reader *r,
      -	struct reftable_index_record index_result = { .last_key = STRBUF_INIT };
      -	struct reftable_record index_result_rec = { NULL };
      +	struct reftable_record want_index = {
     -+		.type = BLOCK_TYPE_INDEX,
     -+		.u.idx = { .last_key = STRBUF_INIT }
     ++		.type = BLOCK_TYPE_INDEX, .u.idx = { .last_key = STRBUF_INIT }
      +	};
      +	struct reftable_record index_result = {
      +		.type = BLOCK_TYPE_INDEX,
     @@ reftable/reader.c: static int reader_seek_indexed(struct reftable_reader *r,
       	return err;
       }
       
     -@@ reftable/reader.c: static int reader_seek_internal(struct reftable_reader *r,
     - 				struct reftable_iterator *it,
     - 				struct reftable_record *rec)
     - {
     --	struct reftable_reader_offsets *offs =
     --		reader_offsets_for(r, reftable_record_type(rec));
     -+	struct reftable_reader_offsets *offs = reader_offsets_for(r, reftable_record_type(rec));
     - 	uint64_t idx = offs->index_offset;
     - 	struct table_iter ti = TABLE_ITER_INIT;
     - 	int err = 0;
      @@ reftable/reader.c: static int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
       int reftable_reader_seek_ref(struct reftable_reader *r,
       			     struct reftable_iterator *it, const char *name)
     @@ reftable/reader.c: int reftable_reader_seek_log_at(struct reftable_reader *r,
      -	struct reftable_log_record log = {
      -		.refname = (char *)name,
      -		.update_index = update_index,
     -+	struct reftable_record rec = {
     -+		.type = BLOCK_TYPE_LOG,
     -+		.u.log = {
     -+			.refname = (char *)name,
     -+			.update_index = update_index,
     -+		}
     - 	};
     +-	};
      -	struct reftable_record rec = { NULL };
      -	reftable_record_from_log(&rec, &log);
     ++	struct reftable_record rec = { .type = BLOCK_TYPE_LOG,
     ++				       .u.log = {
     ++					       .refname = (char *)name,
     ++					       .update_index = update_index,
     ++				       } };
       	return reader_seek(r, it, &rec);
       }
       
     @@ reftable/reader.c: static int reftable_reader_refs_for_indexed(struct reftable_r
       
       	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
      -					 got.offsets, got.offset_len);
     -+					 got.u.obj.offsets, got.u.obj.offset_len);
     ++					 got.u.obj.offsets,
     ++					 got.u.obj.offset_len);
       	if (err < 0)
       		goto done;
      -	got.offsets = NULL;
     @@ reftable/record.c: https://developers.google.com/open-source/licenses/bsd
       int get_var_int(uint64_t *dest, struct string_view *in)
       {
       	int ptr = 0;
     +@@ reftable/record.c: static void reftable_obj_record_copy_from(void *rec, const void *src_rec,
     + 		(const struct reftable_obj_record *)src_rec;
     + 
     + 	reftable_obj_record_release(obj);
     +-	*obj = *src;
     +-	obj->hash_prefix = reftable_malloc(obj->hash_prefix_len);
     +-	memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
     ++	obj->hash_prefix = reftable_malloc(src->hash_prefix_len);
     ++	obj->hash_prefix_len = src->hash_prefix_len;
     ++	if (src->hash_prefix_len)
     ++		memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
     + 
     +-	obj->offsets = reftable_malloc(obj->offset_len * sizeof(uint64_t));
     +-	COPY_ARRAY(obj->offsets, src->offsets, obj->offset_len);
     ++	obj->offsets = reftable_malloc(src->offset_len * sizeof(uint64_t));
     ++	obj->offset_len = src->offset_len;
     ++	COPY_ARRAY(obj->offsets, src->offsets, src->offset_len);
     + }
     + 
     + static uint8_t reftable_obj_record_val_type(const void *rec)
      @@ reftable/record.c: static struct reftable_record_vtable reftable_log_record_vtable = {
     - 	.is_deletion = &reftable_log_record_is_deletion_void,
     + 	.equal = &reftable_log_record_equal_void
       };
       
      -struct reftable_record reftable_new_record(uint8_t typ)
     @@ reftable/record.c: static struct reftable_record_vtable reftable_index_record_vt
       int reftable_record_is_deletion(struct reftable_record *rec)
       {
      -	return rec->ops->is_deletion(rec->data);
     ++	return reftable_record_vtable(rec)->is_deletion(
     ++		reftable_record_data(rec));
     + }
     + 
     + int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size)
     + {
     +-	if (a->ops != b->ops)
     ++	if (a->type != b->type)
     + 		return 0;
     +-	return a->ops->equal(a->data, b->data, hash_size);
      -}
      -
      -void reftable_record_from_ref(struct reftable_record *rec,
     @@ reftable/record.c: static struct reftable_record_vtable reftable_index_record_vt
      -{
      -	assert(reftable_record_type(rec) == BLOCK_TYPE_LOG);
      -	return rec->data;
     -+	return reftable_record_vtable(rec)->is_deletion(
     -+		reftable_record_data(rec));
     ++	return reftable_record_vtable(a)->equal(
     ++		reftable_record_data(a), reftable_record_data(b), hash_size);
       }
       
       static int hash_equal(uint8_t *a, uint8_t *b, int hash_size)
     @@ reftable/record.c: void string_view_consume(struct string_view *s, int n)
      +
      +struct reftable_record reftable_new_record(uint8_t typ)
      +{
     -+	struct reftable_record clean_idx = {
     -+		.type = BLOCK_TYPE_INDEX,
     -+		.u.idx = {
     -+			.last_key = STRBUF_INIT,
     -+		},
     -+	};
      +	struct reftable_record clean = {
      +		.type = typ,
      +	};
      +
     -+	if (typ == BLOCK_TYPE_INDEX) {
     -+		return clean_idx;
     ++	/* the following is involved, but the naive solution (just return
     ++	 * `clean` as is, except for BLOCK_TYPE_INDEX), returns a garbage
     ++	 * clean.u.obj.offsets pointer on Windows VS CI.  Go figure.
     ++	 */
     ++	switch (typ) {
     ++	case BLOCK_TYPE_OBJ:
     ++	{
     ++		struct reftable_obj_record obj = { 0 };
     ++		clean.u.obj = obj;
     ++		break;
     ++	}
     ++	case BLOCK_TYPE_INDEX:
     ++	{
     ++		struct reftable_index_record idx = {
     ++			.last_key = STRBUF_INIT,
     ++		};
     ++		clean.u.idx = idx;
     ++		break;
     ++	}
     ++	case BLOCK_TYPE_REF:
     ++	{
     ++		struct reftable_ref_record ref = { 0 };
     ++		clean.u.ref = ref;
     ++		break;
     ++	}
     ++	case BLOCK_TYPE_LOG:
     ++	{
     ++		struct reftable_log_record log = { 0 };
     ++		clean.u.log = log;
     ++		break;
     ++	}
      +	}
     -+
      +	return clean;
      +}
      
       ## reftable/record.h ##
      @@ reftable/record.h: struct reftable_record_vtable {
     - 	int (*is_deletion)(const void *rec);
     + 	int (*equal)(const void *a, const void *b, int hash_size);
       };
       
      -/* record is a generic wrapper for different types of records. */
     @@ reftable/record.h: struct reftable_obj_record {
      +};
      +
       /* see struct record_vtable */
     - 
     + int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size);
       void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
      @@ reftable/record.h: int reftable_record_decode(struct reftable_record *rec, struct strbuf key,
       			   int hash_size);
     @@ reftable/record_test.c
       {
      -	struct reftable_record copy =
      -		reftable_new_record(reftable_record_type(rec));
     -+	struct reftable_record copy = reftable_new_record(reftable_record_type(rec));
     ++	struct reftable_record copy = { 0 };
     ++	uint8_t typ;
      +
     ++	typ = reftable_record_type(rec);
     ++	copy = reftable_new_record(typ);
       	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
       	/* do it twice to catch memory leaks */
       	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
     --	switch (reftable_record_type(&copy)) {
     -+	switch (copy.type) {
     - 	case BLOCK_TYPE_REF:
     --		EXPECT(reftable_ref_record_equal(reftable_record_as_ref(&copy),
     --						 reftable_record_as_ref(rec),
     -+		EXPECT(reftable_ref_record_equal(&copy.u.ref, &rec->u.ref,
     - 						 GIT_SHA1_RAWSZ));
     - 		break;
     - 	case BLOCK_TYPE_LOG:
     --		EXPECT(reftable_log_record_equal(reftable_record_as_log(&copy),
     --						 reftable_record_as_log(rec),
     -+		EXPECT(reftable_log_record_equal(&copy.u.log, &rec->u.log,
     - 						 GIT_SHA1_RAWSZ));
     - 		break;
     - 	}
     + 	EXPECT(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
      -	reftable_record_destroy(&copy);
      +	reftable_record_release(&copy);
       }
     @@ reftable/record_test.c: static void test_reftable_ref_record_roundtrip(void)
      +		struct reftable_record in = {
      +			.type = BLOCK_TYPE_REF,
      +		};
     -+		struct reftable_record out = {
     -+			.type = BLOCK_TYPE_REF
     -+		};
     ++		struct reftable_record out = { .type = BLOCK_TYPE_REF };
       		struct strbuf key = STRBUF_INIT;
      -		struct reftable_record rec = { NULL };
       		uint8_t buffer[1024] = { 0 };
     @@ reftable/record_test.c: static void test_reftable_ref_record_roundtrip(void)
      -			set_hash(in.value.val2.value, 1);
      -			in.value.val2.target_value =
      +			in.u.ref.value.val2.value =
     -+				reftable_malloc(GIT_SHA1_RAWSZ);
     -+			set_hash(in.u.ref.value.val2.value, 1);
     -+			in.u.ref.value.val2.target_value =
       				reftable_malloc(GIT_SHA1_RAWSZ);
      -			set_hash(in.value.val2.target_value, 2);
     ++			set_hash(in.u.ref.value.val2.value, 1);
     ++			in.u.ref.value.val2.target_value =
     ++				reftable_malloc(GIT_SHA1_RAWSZ);
      +			set_hash(in.u.ref.value.val2.target_value, 2);
       			break;
       		case REFTABLE_REF_SYMREF:
     @@ reftable/record_test.c: static void test_reftable_log_record_roundtrip(void)
       	set_test_hash(in[0].value.update.old_hash, 2);
       	for (i = 0; i < ARRAY_SIZE(in); i++) {
      -		struct reftable_record rec = { NULL };
     -+		struct reftable_record rec = {
     -+			.type = BLOCK_TYPE_LOG
     -+		};
     ++		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
       		struct strbuf key = STRBUF_INIT;
       		uint8_t buffer[1024] = { 0 };
       		struct string_view dest = {
     @@ reftable/record_test.c: static void test_reftable_obj_record_roundtrip(void)
       		struct strbuf key = STRBUF_INIT;
      -		struct reftable_obj_record out = { NULL };
      -		struct reftable_record rec_out = { NULL };
     -+		struct reftable_record out = {
     -+			.type = BLOCK_TYPE_OBJ
     -+		};
     ++		struct reftable_record out = { .type = BLOCK_TYPE_OBJ };
       		int n, m;
       		uint8_t extra;
       
     @@ reftable/record_test.c: static void test_reftable_obj_record_roundtrip(void)
       					   GIT_SHA1_RAWSZ);
       		EXPECT(n == m);
       
     --		EXPECT(in.hash_prefix_len == out.hash_prefix_len);
     --		EXPECT(in.offset_len == out.offset_len);
     --
     --		EXPECT(!memcmp(in.hash_prefix, out.hash_prefix,
     --			       in.hash_prefix_len));
     --		EXPECT(0 == memcmp(in.offsets, out.offsets,
     --				   sizeof(uint64_t) * in.offset_len));
     -+		EXPECT(in.u.obj.hash_prefix_len == out.u.obj.hash_prefix_len);
     -+		EXPECT(in.u.obj.offset_len == out.u.obj.offset_len);
     -+		if (in.u.obj.hash_prefix_len)
     -+			EXPECT(!memcmp(in.u.obj.hash_prefix, out.u.obj.hash_prefix,
     -+				       in.u.obj.hash_prefix_len));
     -+		if (in.u.obj.offset_len)
     -+			EXPECT(!memcmp(in.u.obj.offsets, out.u.obj.offsets,
     -+					   sizeof(uint64_t) * in.u.obj.offset_len));
     +-		EXPECT(reftable_record_equal(&rec, &rec_out, GIT_SHA1_RAWSZ));
     ++		EXPECT(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
       		strbuf_release(&key);
      -		reftable_record_release(&rec_out);
      +		reftable_record_release(&out);
     @@ reftable/record_test.c: static void test_reftable_index_record_roundtrip(void)
      +	m = reftable_record_decode(&out, key, extra, dest, GIT_SHA1_RAWSZ);
       	EXPECT(m == n);
       
     --	EXPECT(in.offset == out.offset);
     -+	EXPECT(in.u.idx.offset == out.u.idx.offset);
     +-	EXPECT(reftable_record_equal(&rec, &out_rec, GIT_SHA1_RAWSZ));
     ++	EXPECT(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
       
      -	reftable_record_release(&out_rec);
      +	reftable_record_release(&out);
     @@ reftable/writer.c: static void write_object_record(void *void_arg, void *key)
      -		.hash_prefix_len = arg->w->stats.object_id_len,
      -		.offsets = entry->offsets,
      -		.offset_len = entry->offset_len,
     -+	struct reftable_record rec = {
     -+		.type = BLOCK_TYPE_OBJ,
     -+		.u.obj = {
     -+			.hash_prefix = (uint8_t *)entry->hash.buf,
     -+			.hash_prefix_len = arg->w->stats.object_id_len,
     -+			.offsets = entry->offsets,
     -+			.offset_len = entry->offset_len,
     -+		}
     - 	};
     +-	};
      -	struct reftable_record rec = { NULL };
     ++	struct reftable_record
     ++		rec = { .type = BLOCK_TYPE_OBJ,
     ++			.u.obj = {
     ++				.hash_prefix = (uint8_t *)entry->hash.buf,
     ++				.hash_prefix_len = arg->w->stats.object_id_len,
     ++				.offsets = entry->offsets,
     ++				.offset_len = entry->offset_len,
     ++			} };
       	if (arg->err < 0)
       		goto done;
       
  -:  ----------- > 15:  6c06bd91662 reftable: add print functions to the record types
  -:  ----------- > 16:  e16bf0c5212 reftable: be more paranoid about 0-length memcpy calls

-- 
gitgitgadget
