Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9320BC433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiAXTip (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352019AbiAXT30 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:29:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BA9C029809
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w11so3315518wra.4
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EuA/OwZ5XkXu0yjekdV0UO7bEWVOKyLoLMZUwNCodTw=;
        b=YynI3r3lpIGNkThblqqNVHbhAIgH7NB2o2lZTnlKusq0AsBfOVzAVCDVXLo1bjM2rK
         gxAkpL0NsrQZ7yuwhVMN++ZFMqfRop8v3hK7ehCzd38mToHnzv67Sf9/0Vdsb5+tFMsL
         X3TGOht/rMH3J6bjSi4Os4cTpgJtWqLsYvKxWoZWI4PXOrtsUF9JkIqB2kudF/lBQ1g3
         +8jzBWx0eWW9XbYtpuGA1R0slo8quYOBX2JMMeP7IMTMp9UIiHWs0/HlFTK5N7E99oKp
         63aAclJkHUXOzjmR8shlJfzDgAInB2k7xO7zwy/r+K8U9eula1v68HiX5BnQqd7JYcne
         NUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EuA/OwZ5XkXu0yjekdV0UO7bEWVOKyLoLMZUwNCodTw=;
        b=HSEn7Xo4hpvDFs+DlbKUglkh5lKXy5kVvBj8I45luXXV2G+8wbcMu8tenRgbtWXN73
         7VHoW1dExJ7vtSZJQqYyb3MTAC7/PeqNLt4CnMmASLy9Nebg7TP5BVWTbs0IaPVP3nSx
         Vc0vOV2o+Q23TQeksKgoVqhSeheLYdJt8lPeTplueqbiZ8CEPUeHB4bZgm27AsOrVbVs
         nIjcXQasnRhKSixklr8bf3WQ5aUQZ3XqhBv3eA6cUZZCtvkhs21UtrhcKCkRhZb2NNTi
         4sqGg6GhHDvjTFS2DkNKTe7TtiqWE24keh+9Bt1bswTmWVnkQCdgrxNK+r8/hK1+V5oX
         jqsg==
X-Gm-Message-State: AOAM531flijdY5H51+Cu7+wFHUnuOO6g2VjTukMAkO4lCeXNh/T5+LIp
        j4FBlhSrBs62nDOnYw1NoNO+hpeLZXW4iA==
X-Google-Smtp-Source: ABdhPJwMT5GMSz8nFUx4RPo9W27wUBCj1k+zNwU7NB5s1wmJl2OtmVX8QG1sKBWDNZ/sreSTreDqrw==
X-Received: by 2002:a5d:64e7:: with SMTP id g7mr3054939wri.72.1643051625289;
        Mon, 24 Jan 2022 11:13:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x4sm15750776wrp.13.2022.01.24.11.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:44 -0800 (PST)
Message-Id: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:28 +0000
Subject: [PATCH v7 00/16] Reftable coverity fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series was targeted to 'master'.

This addresses some complaints from Coverity that Peff reported.

v7:

 * address avarab's comments.

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
  reftable: rename typ to type

 reftable/block.c           |  35 ++--
 reftable/block_test.c      |  22 +--
 reftable/blocksource.c     |   6 +-
 reftable/generic.c         |  39 ++--
 reftable/iter.c            |   4 +-
 reftable/merged.c          |  35 ++--
 reftable/merged.h          |   2 +-
 reftable/pq.c              |   2 +-
 reftable/pq_test.c         |  29 ++-
 reftable/reader.c          | 167 +++++++++--------
 reftable/readwrite_test.c  |  67 ++++++-
 reftable/record.c          | 367 +++++++++++++++++++++++--------------
 reftable/record.h          |  49 ++---
 reftable/record_test.c     | 193 +++++++++----------
 reftable/reftable-record.h |  14 +-
 reftable/reftable.c        | 115 ------------
 reftable/stack.c           |  10 +-
 reftable/stack_test.c      |   3 +-
 reftable/writer.c          |  72 ++++----
 t/helper/test-reftable.c   |   9 +-
 20 files changed, 666 insertions(+), 574 deletions(-)
 delete mode 100644 reftable/reftable.c


base-commit: 50b2d72e110cad39ecaf2322bfdf1b60cd13dd96
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1152%2Fhanwen%2Freftable-coverity-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1152/hanwen/reftable-coverity-v7
Pull-Request: https://github.com/git/git/pull/1152

Range-diff vs v6:

  1:  9218bd59b25 !  1:  cc47ec7a50b reftable: fix OOB stack write in print functions
     @@ Metadata
       ## Commit message ##
          reftable: fix OOB stack write in print functions
      
     +    Remove /* BUG */ comment, whose meaning has escaped my memory.
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## reftable/record.c ##
     @@ reftable/record.c: static void hex_format(char *dest, uint8_t *src, int hash_siz
       			       uint32_t hash_id)
       {
      -	char hex[2 * GIT_SHA256_RAWSZ + 1] = { 0 }; /* BUG */
     -+	char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */
     ++	char hex[GIT_MAX_HEXSZ + 1];
       	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
       	switch (ref->value_type) {
       	case REFTABLE_REF_SYMREF:
  2:  315ce62e710 !  2:  1c5441d2f7e reftable: fix resource leak in block.c error path
     @@ Commit message
      
       ## reftable/block.c ##
      @@ reftable/block.c: int block_reader_init(struct block_reader *br, struct reftable_block *block,
     - 	uint32_t full_block_size = table_block_size;
       	uint8_t typ = block->data[header_off];
       	uint32_t sz = get_be24(block->data + header_off + 1);
     --
     + 
      +	int err = 0;
       	uint16_t restart_count = 0;
       	uint32_t restart_start = 0;
  3:  7cf65e141cf =  3:  f11a9964383 reftable: fix resource leak blocksource.c
  4:  8740ba92981 !  4:  b0bffb6e29d reftable: check reftable_stack_auto_compact() return value
     @@ Metadata
       ## Commit message ##
          reftable: check reftable_stack_auto_compact() return value
      
     -    Fixes a problem detected by Coverity.
     +    If compaction consistently errors out, we would accumulate reftables,
     +    and the follow-on EXPECT would start failing, but catching errors
     +    early helps debugging.
     +
     +    Spotted by Coverity.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
  5:  08be6d90a48 !  5:  e3d575ae2b4 reftable: ignore remove() return value in stack_test.c
     @@ reftable/stack_test.c: static void test_read_file(void)
       	}
       	free_names(names);
      -	remove(fn);
     -+	(void) remove(fn);
     ++	EXPECT(unlink(fn) == 0);
       }
       
       static void test_parse_names(void)
  6:  630f67bdb51 =  6:  a21d934f37d reftable: fix resource warning
  7:  afee67fb60d =  7:  b40d91c50a2 reftable: all xxx_free() functions accept NULL arguments
  8:  6f4f24c17ad =  8:  7a1f32a2ff0 reftable: order unittests by complexity
  9:  0abaab1d7c4 =  9:  a118cd40975 reftable: drop stray printf in readwrite_test
 10:  004b7a736bf = 10:  1d5cfbbc47a reftable: handle null refnames in reftable_ref_record_equal
 11:  951efcebcd2 ! 11:  90c72a2df0c reftable: make reftable-record.h function signatures const correct
     @@ reftable/record.c: static void hex_format(char *dest, uint8_t *src, int hash_siz
      +void reftable_ref_record_print(const struct reftable_ref_record *ref,
       			       uint32_t hash_id)
       {
     - 	char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */
     + 	char hex[GIT_MAX_HEXSZ + 1];
      @@ reftable/record.c: static int zero_hash_eq(uint8_t *a, uint8_t *b, int sz)
       	return !memcmp(a, b, sz);
       }
 12:  6385e449ba7 ! 12:  a83a9cf59b7 reftable: implement record equality generically
     @@ reftable/record.c: static int reftable_ref_record_is_deletion_void(const void *p
       		(const struct reftable_ref_record *)p);
       }
       
     -+
      +static int reftable_ref_record_equal_void(const void *a,
      +					  const void *b, int hash_size)
      +{
     @@ reftable/record.c: static int not_a_deletion(const void *p)
      +	    || ra->offset_len != rb->offset_len)
      +		return 0;
      +
     -+	if (ra->hash_prefix_len &&
     -+	    memcmp(ra->hash_prefix, rb->hash_prefix, ra->hash_prefix_len))
     ++	if (memcmp(ra->hash_prefix, rb->hash_prefix, ra->hash_prefix_len))
      +		return 0;
     -+	if (ra->offset_len &&
     -+	    memcmp(ra->offsets, rb->offsets, ra->offset_len * sizeof(uint64_t)))
     ++	if (memcmp(ra->offsets, rb->offsets, ra->offset_len * sizeof(uint64_t)))
      +		return 0;
      +
      +	return 1;
 13:  69c4a554882 = 13:  7e23d14d1af reftable: remove outdated file reftable.c
 14:  54bcac325bd ! 14:  047bbb75fcb reftable: make reftable_record a tagged union
     @@ reftable/generic.c: https://developers.google.com/open-source/licenses/bsd
       {
      -	struct reftable_ref_record ref = {
      -		.refname = (char *)name,
     --	};
     ++	struct reftable_record rec = {
     ++		.type = BLOCK_TYPE_REF,
     ++		.u.ref = { .refname = (char *)name, }
     + 	};
      -	struct reftable_record rec = { NULL };
      -	reftable_record_from_ref(&rec, &ref);
     -+	struct reftable_record rec = { .type = BLOCK_TYPE_REF,
     -+				       .u.ref = {
     -+					       .refname = (char *)name,
     -+				       } };
       	return tab->ops->seek_record(tab->table_arg, it, &rec);
       }
       
     @@ reftable/generic.c: https://developers.google.com/open-source/licenses/bsd
      -	struct reftable_log_record log = {
      -		.refname = (char *)name,
      -		.update_index = ~((uint64_t)0),
     --	};
     ++	struct reftable_record rec = {
     ++		.type = BLOCK_TYPE_LOG,
     ++		.u.log = {
     ++			.refname = (char *)name,
     ++			.update_index = ~((uint64_t)0),
     ++		}
     + 	};
      -	struct reftable_record rec = { NULL };
      -	reftable_record_from_log(&rec, &log);
     -+	struct reftable_record rec = { .type = BLOCK_TYPE_LOG,
     -+				       .u.log = {
     -+					       .refname = (char *)name,
     -+					       .update_index = ~((uint64_t)0),
     -+				       } };
       	return tab->ops->seek_record(tab->table_arg, it, &rec);
       }
       
     @@ reftable/merged.c: int reftable_merged_table_seek_ref(struct reftable_merged_tab
      -		.refname = (char *)name,
      +	struct reftable_record rec = {
      +		.type = BLOCK_TYPE_REF,
     -+		.u.ref = {
     -+			.refname = (char *)name,
     -+		},
     ++		.u.ref = { .refname = (char *)name, },
       	};
      -	struct reftable_record rec = { NULL };
      -	reftable_record_from_ref(&rec, &ref);
     @@ reftable/merged.c: int reftable_merged_table_seek_log_at(struct reftable_merged_
      -	struct reftable_log_record log = {
      -		.refname = (char *)name,
      -		.update_index = update_index,
     --	};
     ++	struct reftable_record rec = {
     ++		.type = BLOCK_TYPE_LOG,
     ++		.u.log = {
     ++			.refname = (char *)name,
     ++			.update_index = update_index,
     ++		}
     + 	};
      -	struct reftable_record rec = { NULL };
      -	reftable_record_from_log(&rec, &log);
     -+	struct reftable_record rec = { .type = BLOCK_TYPE_LOG,
     -+				       .u.log = {
     -+					       .refname = (char *)name,
     -+					       .update_index = update_index,
     -+				       } };
       	return merged_table_seek_record(mt, it, &rec);
       }
       
      
       ## reftable/pq.c ##
     -@@ reftable/pq.c: struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
     - void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e)
     - {
     - 	int i = 0;
     -+
     - 	if (pq->len == pq->cap) {
     - 		pq->cap = 2 * pq->cap + 1;
     - 		pq->heap = reftable_realloc(pq->heap,
      @@ reftable/pq.c: void merged_iter_pqueue_release(struct merged_iter_pqueue *pq)
       {
       	int i = 0;
     @@ reftable/pq_test.c: static void test_pq(void)
      -
      -		reftable_record_as_ref(&rec)->refname = names[i];
      -		e.rec = rec;
     -+		struct pq_entry e = { .rec = { .type = BLOCK_TYPE_REF,
     -+					       .u.ref = {
     -+						       .refname = names[i],
     -+					       } } };
     ++		struct pq_entry e = {
     ++			.rec = {
     ++				.type = BLOCK_TYPE_REF,
     ++				.u.ref = { .refname = names[i], }
     ++			}
     ++		};
       		merged_iter_pqueue_add(&pq, e);
       		merged_iter_pqueue_check(pq);
       		i = (i * 7) % N;
     @@ reftable/pq_test.c: static void test_pq(void)
      -		last = ref->refname;
      -		ref->refname = NULL;
      -		reftable_free(ref);
     -+		// this is names[i], so don't dealloc.
     ++		/* this is names[i], so don't dealloc. */
      +		last = rec->u.ref.refname;
      +		rec->u.ref.refname = NULL;
      +		reftable_record_release(rec);
     @@ reftable/reader.c: static int reader_seek_indexed(struct reftable_reader *r,
      -	reftable_record_key(rec, &want_index.last_key);
      -	reftable_record_from_index(&want_index_rec, &want_index);
      -	reftable_record_from_index(&index_result_rec, &index_result);
     --
      +	reftable_record_key(rec, &want_index.u.idx.last_key);
     + 
       	err = reader_start(r, &index_iter, reftable_record_type(rec), 1);
       	if (err < 0)
       		goto done;
     @@ reftable/reader.c: static int reader_seek(struct reftable_reader *r, struct reft
      -		.refname = (char *)name,
      +	struct reftable_record rec = {
      +		.type = BLOCK_TYPE_REF,
     -+		.u.ref = {
     -+			.refname = (char *)name,
     -+		},
     ++		.u.ref = { .refname = (char *)name, },
       	};
      -	struct reftable_record rec = { NULL };
      -	reftable_record_from_ref(&rec, &ref);
     @@ reftable/reader.c: int reftable_reader_seek_log_at(struct reftable_reader *r,
      -	struct reftable_log_record log = {
      -		.refname = (char *)name,
      -		.update_index = update_index,
     --	};
     ++	struct reftable_record rec = {
     ++		.type = BLOCK_TYPE_LOG,
     ++		.u.log = {
     ++			.refname = (char *)name,
     ++			.update_index = update_index,
     ++		}
     + 	};
      -	struct reftable_record rec = { NULL };
      -	reftable_record_from_log(&rec, &log);
     -+	struct reftable_record rec = { .type = BLOCK_TYPE_LOG,
     -+				       .u.log = {
     -+					       .refname = (char *)name,
     -+					       .update_index = update_index,
     -+				       } };
       	return reader_seek(r, it, &rec);
       }
       
     @@ reftable/record.c: https://developers.google.com/open-source/licenses/bsd
       
      +static struct reftable_record_vtable *
      +reftable_record_vtable(struct reftable_record *rec);
     -+static void *reftable_record_data(struct reftable_record *rec);
     ++
     ++static void *reftable_record_data(struct reftable_record *rec)
     ++{
     ++	switch (rec->type) {
     ++	case BLOCK_TYPE_REF:
     ++		return &rec->u.ref;
     ++	case BLOCK_TYPE_LOG:
     ++		return &rec->u.log;
     ++	case BLOCK_TYPE_INDEX:
     ++		return &rec->u.idx;
     ++	case BLOCK_TYPE_OBJ:
     ++		return &rec->u.obj;
     ++	}
     ++	abort();
     ++}
      +
       int get_var_int(uint64_t *dest, struct string_view *in)
       {
     @@ reftable/record.c: static void reftable_obj_record_copy_from(void *rec, const vo
       	reftable_obj_record_release(obj);
      -	*obj = *src;
      -	obj->hash_prefix = reftable_malloc(obj->hash_prefix_len);
     --	memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
      +	obj->hash_prefix = reftable_malloc(src->hash_prefix_len);
      +	obj->hash_prefix_len = src->hash_prefix_len;
     -+	if (src->hash_prefix_len)
     -+		memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
     + 	memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
       
      -	obj->offsets = reftable_malloc(obj->offset_len * sizeof(uint64_t));
      -	COPY_ARRAY(obj->offsets, src->offsets, obj->offset_len);
     @@ reftable/record.c: static struct reftable_record_vtable reftable_log_record_vtab
       static void reftable_index_record_key(const void *r, struct strbuf *dest)
       {
       	const struct reftable_index_record *rec = r;
     +@@ reftable/record.c: static void reftable_index_record_release(void *rec)
     + {
     + 	struct reftable_index_record *idx = rec;
     + 	strbuf_release(&idx->last_key);
     ++	idx->offset = 0;
     + }
     + 
     + static uint8_t reftable_index_record_val_type(const void *rec)
      @@ reftable/record.c: static struct reftable_record_vtable reftable_index_record_vtable = {
       
       void reftable_record_key(struct reftable_record *rec, struct strbuf *dest)
     @@ reftable/record.c: void string_view_consume(struct string_view *s, int n)
       	s->len -= n;
       }
      +
     -+static void *reftable_record_data(struct reftable_record *rec)
     -+{
     -+	switch (rec->type) {
     -+	case BLOCK_TYPE_REF:
     -+		return &rec->u.ref;
     -+	case BLOCK_TYPE_LOG:
     -+		return &rec->u.log;
     -+	case BLOCK_TYPE_INDEX:
     -+		return &rec->u.idx;
     -+	case BLOCK_TYPE_OBJ:
     -+		return &rec->u.obj;
     -+	}
     -+	abort();
     -+}
     -+
      +static struct reftable_record_vtable *
      +reftable_record_vtable(struct reftable_record *rec)
      +{
     @@ reftable/record.c: void string_view_consume(struct string_view *s, int n)
      +	abort();
      +}
      +
     -+struct reftable_record reftable_new_record(uint8_t typ)
     ++struct reftable_record reftable_new_record(uint8_t type)
      +{
      +	struct reftable_record clean = {
     -+		.type = typ,
     ++		.type = type,
      +	};
      +
      +	/* the following is involved, but the naive solution (just return
      +	 * `clean` as is, except for BLOCK_TYPE_INDEX), returns a garbage
      +	 * clean.u.obj.offsets pointer on Windows VS CI.  Go figure.
      +	 */
     -+	switch (typ) {
     ++	switch (type) {
      +	case BLOCK_TYPE_OBJ:
      +	{
      +		struct reftable_obj_record obj = { 0 };
     @@ reftable/record_test.c
      -	struct reftable_record copy =
      -		reftable_new_record(reftable_record_type(rec));
      +	struct reftable_record copy = { 0 };
     -+	uint8_t typ;
     -+
     -+	typ = reftable_record_type(rec);
     -+	copy = reftable_new_record(typ);
     ++	uint8_t type = reftable_record_type(rec);
     ++	copy = reftable_new_record(type);
       	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
       	/* do it twice to catch memory leaks */
       	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
     @@ reftable/record_test.c: static void test_reftable_ref_record_roundtrip(void)
       		uint8_t buffer[1024] = { 0 };
       		struct string_view dest = {
       			.buf = buffer,
     - 			.len = sizeof(buffer),
     - 		};
     --
     +@@ reftable/record_test.c: static void test_reftable_ref_record_roundtrip(void)
     + 
       		int n, m;
       
      -		in.value_type = i;
     @@ reftable/record_test.c: static void test_reftable_ref_record_roundtrip(void)
      -			set_hash(in.value.val2.value, 1);
      -			in.value.val2.target_value =
      +			in.u.ref.value.val2.value =
     - 				reftable_malloc(GIT_SHA1_RAWSZ);
     --			set_hash(in.value.val2.target_value, 2);
     ++				reftable_malloc(GIT_SHA1_RAWSZ);
      +			set_hash(in.u.ref.value.val2.value, 1);
      +			in.u.ref.value.val2.target_value =
     -+				reftable_malloc(GIT_SHA1_RAWSZ);
     + 				reftable_malloc(GIT_SHA1_RAWSZ);
     +-			set_hash(in.value.val2.target_value, 2);
      +			set_hash(in.u.ref.value.val2.target_value, 2);
       			break;
       		case REFTABLE_REF_SYMREF:
     @@ reftable/writer.c: int reftable_writer_add_refs(struct reftable_writer *w,
       	    block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
       		int err = writer_finish_public_section(w);
      @@ reftable/writer.c: static int reftable_writer_add_log_verbatim(struct reftable_writer *w,
     - 
       	w->next -= w->pending_padding;
       	w->pending_padding = 0;
     --
     + 
      -	reftable_record_from_log(&rec, log);
       	return writer_add_record(w, &rec);
       }
     @@ reftable/writer.c: static void write_object_record(void *void_arg, void *key)
      -		.hash_prefix_len = arg->w->stats.object_id_len,
      -		.offsets = entry->offsets,
      -		.offset_len = entry->offset_len,
     --	};
     ++	struct reftable_record rec = {
     ++		.type = BLOCK_TYPE_OBJ,
     ++		.u.obj = {
     ++			.hash_prefix = (uint8_t *)entry->hash.buf,
     ++			.hash_prefix_len = arg->w->stats.object_id_len,
     ++			.offsets = entry->offsets,
     ++			.offset_len = entry->offset_len,
     ++		}
     + 	};
      -	struct reftable_record rec = { NULL };
     -+	struct reftable_record
     -+		rec = { .type = BLOCK_TYPE_OBJ,
     -+			.u.obj = {
     -+				.hash_prefix = (uint8_t *)entry->hash.buf,
     -+				.hash_prefix_len = arg->w->stats.object_id_len,
     -+				.offsets = entry->offsets,
     -+				.offset_len = entry->offset_len,
     -+			} };
       	if (arg->err < 0)
       		goto done;
       
     @@ reftable/writer.c: static void write_object_record(void *void_arg, void *key)
       	if (arg->err == 0)
       		goto done;
      -	obj_rec.offset_len = 0;
     -+
      +	rec.u.obj.offset_len = 0;
       	arg->err = block_writer_add(arg->w->block_writer, &rec);
       
 15:  82f140cab5c ! 15:  1e8785bbc26 reftable: add print functions to the record types
     @@ reftable/record.c: static void hex_format(char *dest, uint8_t *src, int hash_siz
      +static void reftable_ref_record_print_sz(const struct reftable_ref_record *ref,
      +					 int hash_size)
       {
     - 	char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */
     + 	char hex[GIT_MAX_HEXSZ + 1];
       	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
      @@ reftable/record.c: void reftable_ref_record_print(const struct reftable_ref_record *ref,
       		printf("=> %s", ref->value.symref);
     @@ reftable/record.c: static int reftable_ref_record_equal_void(const void *a,
      +static void reftable_ref_record_print_void(const void *rec,
      +					   int hash_size)
      +{
     -+	reftable_ref_record_print_sz((struct reftable_ref_record *) rec, hash_size);
     ++	reftable_ref_record_print_sz(
     ++		(struct reftable_ref_record *) rec, hash_size);
      +}
      +
       static struct reftable_record_vtable reftable_ref_record_vtable = {
     @@ reftable/record.c: static void reftable_obj_record_release(void *rec)
      +	int i;
      +
      +	for (i = 0; i < obj->offset_len; i++)
     -+		strbuf_addf(&offset_str, "%" PRIu64 " ", obj->offsets[i]);
     ++		strbuf_addf(&offset_str, "%"PRIu64 " ", obj->offsets[i]);
      +	hex_format(hex, obj->hash_prefix, obj->hash_prefix_len);
      +	printf("prefix %s (len %d), offsets [%s]\n",
      +	       hex, obj->hash_prefix_len, offset_str.buf);
     @@ reftable/record.c: static struct reftable_record_vtable reftable_obj_record_vtab
       	switch (log->value_type) {
       	case REFTABLE_LOG_DELETION:
      -		printf("log{%s(%" PRIu64 ") delete", log->refname,
     -+		printf("log{%s(%" PRIu64 ") delete\n", log->refname,
     ++		printf("log{%s(%"PRIu64 ") delete\n", log->refname,
       		       log->update_index);
       		break;
       	case REFTABLE_LOG_UPDATE:
     - 		printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
     +-		printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
      -		       log->refname, log->update_index, log->value.update.name,
      -		       log->value.update.email, log->value.update.time,
     ++		printf("log{%s(%"PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
      +		       log->refname, log->update_index,
      +		       log->value.update.name ? log->value.update.name : "",
      +		       log->value.update.email ? log->value.update.email : "",
     @@ reftable/record.c: static struct reftable_record_vtable reftable_index_record_vt
       };
       
       void reftable_record_key(struct reftable_record *rec, struct strbuf *dest)
     -@@ reftable/record.c: struct reftable_record reftable_new_record(uint8_t typ)
     +@@ reftable/record.c: struct reftable_record reftable_new_record(uint8_t type)
       	}
       	return clean;
       }
     @@ reftable/record_test.c: static void test_reftable_log_record_equal(void)
       {
       	int i;
      -	struct reftable_log_record in[2] = {
     -+
      +	struct reftable_log_record in[] = {
       		{
       			.refname = xstrdup("refs/heads/master"),
     @@ reftable/record_test.c: static void test_reftable_log_record_roundtrip(void)
       			.value_type = REFTABLE_LOG_DELETION,
      +		},
      +		{
     ++			/* make sure we handle optional fields correctly. */
      +			.refname = xstrdup("branch"),
      +			.update_index = 33,
      +			.value_type = REFTABLE_LOG_UPDATE,
     @@ reftable/record_test.c: static void test_reftable_log_record_roundtrip(void)
      +				.update = {
      +					.old_hash = reftable_malloc(GIT_SHA1_RAWSZ),
      +					.new_hash = reftable_malloc(GIT_SHA1_RAWSZ),
     -+					/* rest of fields left empty. */
      +				},
      +			},
       		}
  -:  ----------- > 16:  556fc11080a reftable: rename typ to type

-- 
gitgitgadget
