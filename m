Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C67C34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 08:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5852064C
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 08:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ3a1Dyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgBRInq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:43:46 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:35410 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgBRInp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 03:43:45 -0500
Received: by mail-wm1-f47.google.com with SMTP id b17so1914573wmb.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 00:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IJ9Hayos3SLKv4KD3qT/Kt8TGPNFToAJOpd5A3rtEtU=;
        b=XZ3a1DyhHPtQkY3n+qUHlooZlxOo4UDMzDFPCyuUmP7fZcglNOxZyQkrSre1+h7vr+
         HGeo2THTlifyEZu4kD+qOyu34CnANFxjpm2Bq7VUSe0OZJKC5RkZ1iadfKX4A7CRPR56
         /M6H5iGV2XGggKZtet/T4PbGZZ95EloKDTUp9CNKk3n1CI8vXjLCat5GSO5JAj3WQJQV
         3fBLpKRJChg/v7+/NJtydYC5Inr36osPHnCWTRcMGq61A/dRFlKnwBOy+80ZvGeXoe/u
         PxKBNtUqFgPrchN+4MO8azLUWDPolLdIrsbrZ/N2Pf1Lbt8sdl28BPSygqMjSr1rCW5u
         f6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IJ9Hayos3SLKv4KD3qT/Kt8TGPNFToAJOpd5A3rtEtU=;
        b=RO05AW0AnKrPC/jb8X+KwhLojHCjDmVO/D8u+CURJRJbKg23G6yjlWO6UtfpykbfPL
         eJpp+d4ABYDS92LMt8/c1NMS+neCOgrsmrfnoqhFofC+ezfr8kumChuJxbLObBmlCpMm
         5PRASj4Cw+J10dsVFXjUt0PQvJUnBbcOtnMGcg0WDqsvfPlR0ujER/U9NlHDQaDea/d5
         oppWjer/HYsWS1G3VWSr5DxeSeJMekPkNlYImJqfo9uNF1ktjzhySc+zwBG1VYuDatj7
         Ezelciwg9zzw5ovU+zcEAbW+gMAyOqwfufI0fvPsdL3mgLmTF8jcEp7fAnnk2CuJHKEi
         6Xgw==
X-Gm-Message-State: APjAAAW+3ZzxycTmYAmgiicqWF/7fc3jZBcwz4LnYJ2HAArdK2axjZMO
        aYd1AKfrBmSNUF+UtpuyVxnyNewX
X-Google-Smtp-Source: APXvYqxWV+e7WAZZFeA0EG8WJu0SeZ+mTB5yxAHv/dVlerZBkMuL0DYzH2ft9UmP9yh2MK+yUqmIqA==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr1835091wmb.150.1582015421858;
        Tue, 18 Feb 2020 00:43:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm4983156wrw.5.2020.02.18.00.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 00:43:41 -0800 (PST)
Message-Id: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 08:43:35 +0000
Subject: [PATCH v6 0/5] Reftable support git-core
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the reftable library, and hooks it up as a ref backend.

Feedback wanted:

 * spots marked with XXX in the Git source code.
 * how to write a unittest script? From the command-line, it works; inside
   the test framework, it says: 

fatal: could not open '/usr/local/google/home/hanwen/vc/git/t/trash directory.t0031-reftable/.git/refs/heads' for writing: Is a directory

ie. the files backend already initialized.

 * what is a good test strategy? Could we have a CI flavor where we flip the
   default to reftable, and see how it fares?

v6

 * implement reflog expiry.

v7

 * support SHA256 as version 2 of the format.

Han-Wen Nienhuys (5):
  refs.h: clarify reflog iteration order
  create .git/refs in files-backend.c
  refs: document how ref_iterator_advance_fn should handle symrefs
  Add reftable library
  Reftable support for git-core

 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   24 +-
 builtin/clone.c                               |    4 +-
 builtin/init-db.c                             |   57 +-
 cache.h                                       |    4 +-
 refs.c                                        |   20 +-
 refs.h                                        |    8 +-
 refs/files-backend.c                          |    6 +
 refs/refs-internal.h                          |    6 +
 refs/reftable-backend.c                       |  971 +++++++++++++++
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   19 +
 reftable/VERSION                              |   11 +
 reftable/basics.c                             |  196 +++
 reftable/basics.h                             |   37 +
 reftable/block.c                              |  413 ++++++
 reftable/block.h                              |   71 ++
 reftable/blocksource.h                        |   20 +
 reftable/bytes.c                              |    0
 reftable/config.h                             |    1 +
 reftable/constants.h                          |   25 +
 reftable/dump.c                               |   97 ++
 reftable/file.c                               |   97 ++
 reftable/iter.c                               |  229 ++++
 reftable/iter.h                               |   56 +
 reftable/merged.c                             |  290 +++++
 reftable/merged.h                             |   34 +
 reftable/pq.c                                 |  114 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  718 +++++++++++
 reftable/reader.h                             |   52 +
 reftable/record.c                             | 1107 +++++++++++++++++
 reftable/record.h                             |   79 ++
 reftable/reftable.h                           |  405 ++++++
 reftable/slice.c                              |  199 +++
 reftable/slice.h                              |   39 +
 reftable/stack.c                              |  984 +++++++++++++++
 reftable/stack.h                              |   40 +
 reftable/system.h                             |   59 +
 reftable/tree.c                               |   66 +
 reftable/tree.h                               |   24 +
 reftable/writer.c                             |  630 ++++++++++
 reftable/writer.h                             |   46 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |   12 +-
 47 files changed, 7407 insertions(+), 32 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/README.md
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/bytes.c
 create mode 100644 reftable/config.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/file.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/slice.c
 create mode 100644 reftable/slice.h
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/system.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 reftable/zlib-compat.c


base-commit: e68e29171cc2d6968902e0654b5687fbe1ccb903
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v5:

 1:  c00403c94de = 1:  e4b0773becd refs.h: clarify reflog iteration order
 2:  4d6da9bc473 = 2:  c25b6c601dc create .git/refs in files-backend.c
 3:  fbdcdccc885 = 3:  e132e0f4e00 refs: document how ref_iterator_advance_fn should handle symrefs
 4:  546b82fe798 ! 4:  fe29a9db399 Add reftable library
     @@ -86,7 +86,7 @@
      +   cp reftable-repo/LICENSE reftable/ &&
      +   git --git-dir reftable-repo/.git show --no-patch origin/master \
      +    > reftable/VERSION && \
     -+   echo '/* empty */' > reftable/config.h
     ++   sed -i~ 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|' reftable/system.h
      +   rm reftable/*_test.c reftable/test_framework.*
      +   git add reftable/*.[ch]
      +
     @@ -98,11 +98,17 @@
       --- /dev/null
       +++ b/reftable/VERSION
      @@
     -+commit 6115b50fdb9bc662be39b05f5589bc109282ae7f
     ++commit 42aa04f301a682197f0698867b9771b78ce4fdaf
      +Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Mon Feb 10 13:59:52 2020 +0100
     -+
     -+    README: add a note about the Java implementation
     ++Date:   Mon Feb 17 16:05:22 2020 +0100
     ++
     ++    C: simplify system and config header handling
     ++    
     ++    reftable.h only depends on <stdint.h>
     ++    
     ++    system.h is only included from .c files. The git-core specific code is
     ++    guarded by a #if REFTABLE_IN_GITCORE, which we'll edit with a sed
     ++    script on the git-core side.
      
       diff --git a/reftable/basics.c b/reftable/basics.c
       new file mode 100644
     @@ -485,19 +491,31 @@
      +	if (block_writer_type(w) == BLOCK_TYPE_LOG) {
      +		int block_header_skip = 4 + w->header_off;
      +		struct slice compressed = {};
     -+		uLongf dest_len = 0, src_len = 0;
     -+		slice_resize(&compressed, w->next - block_header_skip);
     ++		int zresult = 0;
     ++		uLongf src_len = w->next - block_header_skip;
     ++		slice_resize(&compressed, src_len);
      +
     -+		dest_len = compressed.len;
     -+		src_len = w->next - block_header_skip;
     ++		while (1) {
     ++			uLongf dest_len = compressed.len;
      +
     -+		if (Z_OK != compress2(compressed.buf, &dest_len,
     -+				      w->buf + block_header_skip, src_len, 9)) {
     -+			free(slice_yield(&compressed));
     -+			return ZLIB_ERROR;
     ++			zresult = compress2(compressed.buf, &dest_len,
     ++					    w->buf + block_header_skip, src_len,
     ++					    9);
     ++			if (zresult == Z_BUF_ERROR) {
     ++				slice_resize(&compressed, 2 * compressed.len);
     ++				continue;
     ++			}
     ++
     ++			if (Z_OK != zresult) {
     ++				free(slice_yield(&compressed));
     ++				return ZLIB_ERROR;
     ++			}
     ++
     ++			memcpy(w->buf + block_header_skip, compressed.buf,
     ++			       dest_len);
     ++			w->next = dest_len + block_header_skip;
     ++			break;
      +		}
     -+		memcpy(w->buf + block_header_skip, compressed.buf, dest_len);
     -+		w->next = dest_len + block_header_skip;
      +	}
      +	return w->next;
      +}
     @@ -885,8 +903,6 @@
      +#ifndef CONSTANTS_H
      +#define CONSTANTS_H
      +
     -+#define SHA1_SIZE 20
     -+#define SHA256_SIZE 32
      +#define VERSION 1
      +#define HEADER_SIZE 24
      +#define FOOTER_SIZE 68
     @@ -1555,13 +1571,17 @@
      +	it->ops = &merged_iter_vtable;
      +}
      +
     -+int new_merged_table(struct merged_table **dest, struct reader **stack, int n)
     ++int new_merged_table(struct merged_table **dest, struct reader **stack, int n,
     ++		     int hash_size)
      +{
      +	uint64_t last_max = 0;
      +	uint64_t first_min = 0;
      +	int i = 0;
      +	for (i = 0; i < n; i++) {
      +		struct reader *r = stack[i];
     ++		if (reader_hash_size(r) != hash_size) {
     ++			return FORMAT_ERROR;
     ++		}
      +		if (i > 0 && last_max >= reader_min_update_index(r)) {
      +			return FORMAT_ERROR;
      +		}
     @@ -1578,7 +1598,7 @@
      +			.stack_len = n,
      +			.min = first_min,
      +			.max = last_max,
     -+			.hash_size = SHA1_SIZE,
     ++			.hash_size = hash_size,
      +		};
      +
      +		*dest = calloc(sizeof(struct merged_table), 1);
     @@ -1985,6 +2005,11 @@
      +	block_source_return_block(r->source, p);
      +}
      +
     ++int reader_hash_size(struct reader *r)
     ++{
     ++	return r->hash_size;
     ++}
     ++
      +const char *reader_name(struct reader *r)
      +{
      +	return r->name;
     @@ -2005,8 +2030,13 @@
      +		goto exit;
      +	}
      +
     ++	r->hash_size = SHA1_SIZE;
      +	{
      +		byte version = *f++;
     ++		if (version == 2) {
     ++			r->hash_size = SHA256_SIZE;
     ++			version = 1;
     ++		}
      +		if (version != 1) {
      +			err = FORMAT_ERROR;
      +			goto exit;
     @@ -2070,7 +2100,7 @@
      +	r->size = block_source_size(source) - FOOTER_SIZE;
      +	r->source = source;
      +	r->name = strdup(name);
     -+	r->hash_size = SHA1_SIZE;
     ++	r->hash_size = 0;
      +
      +	err = block_source_read_block(source, &footer, r->size, FOOTER_SIZE);
      +	if (err != FOOTER_SIZE) {
     @@ -3883,7 +3913,7 @@
      +#ifndef REFTABLE_H
      +#define REFTABLE_H
      +
     -+#include "system.h"
     ++#include <stdint.h>
      +
      +/* block_source is a generic wrapper for a seekable readable file.
      +   It is generally passed around by value.
     @@ -3934,6 +3964,10 @@
      +
      +	/* how often to write complete keys in each block. */
      +	int restart_interval;
     ++
     ++	/* width of the hash. Should be 20 for SHA1 or 32 for SHA256. Defaults
     ++	 * to SHA1 if unset */
     ++	int hash_size;
      +};
      +
      +/* ref_record holds a ref database entry target_value */
     @@ -4147,6 +4181,9 @@
      + */
      +int reader_seek_ref(struct reader *r, struct iterator *it, const char *name);
      +
     ++/* returns the hash size used in this table. */
     ++int reader_hash_size(struct reader *r);
     ++
      +/* seek to logs for the given name, older than update_index. */
      +int reader_seek_log_at(struct reader *r, struct iterator *it, const char *name,
      +		       uint64_t update_index);
     @@ -4173,7 +4210,11 @@
      +/* new_merged_table creates a new merged table. It takes ownership of the stack
      +   array.
      +*/
     -+int new_merged_table(struct merged_table **dest, struct reader **stack, int n);
     ++int new_merged_table(struct merged_table **dest, struct reader **stack, int n,
     ++		     int hash_size);
     ++
     ++/* returns the hash size used in this merged table. */
     ++int merged_hash_size(struct merged_table *mt);
      +
      +/* returns an iterator positioned just before 'name' */
      +int merged_table_seek_ref(struct merged_table *mt, struct iterator *it,
     @@ -4688,7 +4729,8 @@
      +	}
      +
      +	/* success! */
     -+	err = new_merged_table(&new_merged, new_tables, new_tables_len);
     ++	err = new_merged_table(&new_merged, new_tables, new_tables_len,
     ++			       st->config.hash_size);
      +	if (err < 0) {
      +		goto exit;
      +	}
     @@ -5084,7 +5126,7 @@
      +	writer_set_limits(wr, st->merged->stack[first]->min_update_index,
      +			  st->merged->stack[last]->max_update_index);
      +
     -+	err = new_merged_table(&mt, subtabs, subtabs_len);
     ++	err = new_merged_table(&mt, subtabs, subtabs_len, st->config.hash_size);
      +	if (err < 0) {
      +		free(subtabs);
      +		goto exit;
     @@ -5568,9 +5610,7 @@
      +#ifndef SYSTEM_H
      +#define SYSTEM_H
      +
     -+#include "config.h"
     -+
     -+#ifndef REFTABLE_STANDALONE
     ++#if 1 /* REFTABLE_IN_GITCORE */
      +
      +#include "git-compat-util.h"
      +#include <zlib.h>
     @@ -5606,7 +5646,7 @@
      +		memcpy(&a, &b, sizeof(a));      \
      +		memcpy(&b, &tmp[0], sizeof(a)); \
      +	}
     -+#endif
     ++#endif /* REFTABLE_IN_GITCORE */
      +
      +typedef uint8_t byte;
      +typedef int bool;
     @@ -5614,6 +5654,9 @@
      +int uncompress_return_consumed(Bytef *dest, uLongf *destLen,
      +			       const Bytef *source, uLong *sourceLen);
      +
     ++#define SHA1_SIZE 20
     ++#define SHA256_SIZE 32
     ++
      +#endif
      
       diff --git a/reftable/tree.c b/reftable/tree.c
     @@ -5788,6 +5831,9 @@
      +		opts->restart_interval = 16;
      +	}
      +
     ++	if (opts->hash_size == 0) {
     ++		opts->hash_size = SHA1_SIZE;
     ++	}
      +	if (opts->block_size == 0) {
      +		opts->block_size = DEFAULT_BLOCK_SIZE;
      +	}
     @@ -5796,7 +5842,8 @@
      +static int writer_write_header(struct writer *w, byte *dest)
      +{
      +	memcpy((char *)dest, "REFT", 4);
     -+	dest[4] = 1; /* version */
     ++	dest[4] = (w->hash_size == SHA1_SIZE) ? 1 : 2; /* version */
     ++
      +	put_u24(dest + 5, w->opts.block_size);
      +	put_u64(dest + 8, w->min_update_index);
      +	put_u64(dest + 16, w->max_update_index);
     @@ -5825,7 +5872,7 @@
      +		/* TODO - error return? */
      +		abort();
      +	}
     -+	wp->hash_size = SHA1_SIZE;
     ++	wp->hash_size = opts->hash_size;
      +	wp->block = calloc(opts->block_size, 1);
      +	wp->write = writer_func;
      +	wp->write_arg = writer_arg;
     @@ -6222,7 +6269,10 @@
      +	byte footer[68];
      +	byte *p = footer;
      +
     -+	writer_finish_public_section(w);
     ++	int err = writer_finish_public_section(w);
     ++	if (err != 0) {
     ++		return err;
     ++	}
      +
      +	writer_write_header(w, footer);
      +	p += 24;
 5:  702fb89871e ! 5:  8d95ab52f75 Reftable support for git-core
     @@ -6,10 +6,8 @@
      
          TODO:
      
     -     * Make CI on gitgitgadget compile.
     -     * Redo interaction between repo config, repo storage version
     -     * Resolve the design problem with reflog expiry.
           * Resolve spots marked with XXX
     +     * Test strategy?
      
          Example use:
      
     @@ -411,11 +409,6 @@ $^
      +
      +#include "../reftable/reftable.h"
      +
     -+/*
     -+  The reftable v1 spec only supports 20-byte binary SHA1s. A new format version
     -+  will be needed to support SHA256.
     -+ */
     -+
      +extern struct ref_storage_be refs_be_reftable;
      +
      +struct reftable_ref_store {
     @@ -470,6 +463,7 @@ $^
      +	struct ref_store *ref_store = (struct ref_store *)refs;
      +	struct write_options cfg = {
      +		.block_size = 4096,
     ++		.hash_size = the_hash_algo->rawsz,
      +	};
      +	struct strbuf sb = STRBUF_INIT;
      +
     @@ -676,6 +670,7 @@ $^
      +		(struct reftable_ref_store *)transaction->ref_store;
      +	uint64_t ts = stack_next_update_index(refs->stack);
      +	int err = 0;
     ++	struct log_record *logs = calloc(transaction->nr, sizeof(*logs));
      +	struct ref_update **sorted =
      +		malloc(transaction->nr * sizeof(struct ref_update *));
      +	COPY_ARRAY(sorted, transaction->updates, transaction->nr);
     @@ -695,6 +690,14 @@ $^
      +
      +	for (int i = 0; i < transaction->nr; i++) {
      +		struct ref_update *u = sorted[i];
     ++		struct log_record *log = &logs[i];
     ++		fill_log_record(log);
     ++		log->ref_name = (char *)u->refname;
     ++		log->old_hash = u->old_oid.hash;
     ++		log->new_hash = u->new_oid.hash;
     ++		log->update_index = ts;
     ++		log->message = u->msg;
     ++
      +		if (u->flags & REF_HAVE_NEW) {
      +			struct object_id out_oid = {};
      +			int out_flags = 0;
     @@ -706,6 +709,7 @@ $^
      +			struct ref_record ref = {};
      +			ref.ref_name =
      +				(char *)(resolved ? resolved : u->refname);
     ++			log->ref_name = ref.ref_name;
      +			ref.value = u->new_oid.hash;
      +			ref.update_index = ts;
      +			err = writer_add_ref(writer, &ref);
     @@ -716,23 +720,15 @@ $^
      +	}
      +
      +	for (int i = 0; i < transaction->nr; i++) {
     -+		struct ref_update *u = sorted[i];
     -+		struct log_record log = {};
     -+		fill_log_record(&log);
     -+
     -+		log.ref_name = (char *)u->refname;
     -+		log.old_hash = u->old_oid.hash;
     -+		log.new_hash = u->new_oid.hash;
     -+		log.update_index = ts;
     -+		log.message = u->msg;
     -+
     -+		err = writer_add_log(writer, &log);
     -+		clear_log_record(&log);
     ++		err = writer_add_log(writer, &logs[i]);
     ++		clear_log_record(&logs[i]);
      +		if (err < 0) {
     -+			return err;
     ++			goto exit;
      +		}
      +	}
     ++
      +exit:
     ++	free(logs);
      +	free(sorted);
      +	return err;
      +}
     @@ -1076,7 +1072,7 @@ $^
      +			       1);
      +	ri->base.oid = &ri->oid;
      +
     -+	return empty_ref_iterator_begin();
     ++	return (struct ref_iterator *)ri;
      +}
      +
      +static int
     @@ -1214,6 +1210,53 @@ $^
      +	return 0;
      +}
      +
     ++struct reflog_expiry_arg {
     ++	struct reftable_ref_store *refs;
     ++	struct log_record *tombstones;
     ++	int len;
     ++	int cap;
     ++};
     ++
     ++static void clear_log_tombstones(struct reflog_expiry_arg *arg)
     ++{
     ++	int i = 0;
     ++	for (; i < arg->len; i++) {
     ++		log_record_clear(&arg->tombstones[i]);
     ++	}
     ++
     ++	FREE_AND_NULL(arg->tombstones);
     ++}
     ++
     ++static void add_log_tombstone(struct reflog_expiry_arg *arg,
     ++			      const char *refname, uint64_t ts)
     ++{
     ++	struct log_record tombstone = {
     ++		.ref_name = xstrdup(refname),
     ++		.update_index = ts,
     ++	};
     ++	if (arg->len == arg->cap) {
     ++		arg->cap = 2 * arg->cap + 1;
     ++		arg->tombstones =
     ++			realloc(arg->tombstones, arg->cap * sizeof(tombstone));
     ++	}
     ++	arg->tombstones[arg->len++] = tombstone;
     ++}
     ++
     ++static int write_reflog_expiry_table(struct writer *writer, void *argv)
     ++{
     ++	struct reflog_expiry_arg *arg = (struct reflog_expiry_arg *)argv;
     ++	uint64_t ts = stack_next_update_index(arg->refs->stack);
     ++	int i = 0;
     ++	writer_set_limits(writer, ts, ts);
     ++	for (i = 0; i < arg->len; i++) {
     ++		int err = writer_add_log(writer, &arg->tombstones[i]);
     ++		if (err) {
     ++			return err;
     ++		}
     ++	}
     ++	return 0;
     ++}
     ++
      +static int reftable_reflog_expire(struct ref_store *ref_store,
      +				  const char *refname,
      +				  const struct object_id *oid,
     @@ -1223,11 +1266,57 @@ $^
      +				  reflog_expiry_cleanup_fn cleanup_fn,
      +				  void *policy_cb_data)
      +{
     -+	BUG("per ref reflog expiry is not implemented for reftable backend.");
      +	/*
     -+	  TODO: should iterate over the reflog, and write tombstones. The
     -+	  tombstones will be removed on compaction.
     -+	 */
     ++	  For log expiry, we write tombstones in place of the expired entries,
     ++	  This means that the entries are still retrievable by delving into the
     ++	  stack, and expiring entries paradoxically takes extra memory.
     ++
     ++	  This memory is only reclaimed when some operation issues a
     ++	  reftable_pack_refs(), which will compact the entire stack and get rid
     ++	  of deletion entries.
     ++
     ++	  It would be better if the refs backend supported an API that sets a
     ++	  criterion for all refs, passing the criterion to pack_refs().
     ++	*/
     ++	struct reftable_ref_store *refs =
     ++		(struct reftable_ref_store *)ref_store;
     ++	struct merged_table *mt = stack_merged_table(refs->stack);
     ++	struct reflog_expiry_arg arg = {
     ++		.refs = refs,
     ++	};
     ++	struct log_record log = {};
     ++	struct iterator it = {};
     ++	int err = merged_table_seek_log(mt, &it, refname);
     ++	if (err < 0) {
     ++		return err;
     ++	}
     ++
     ++	while (1) {
     ++		struct object_id ooid = {};
     ++		struct object_id noid = {};
     ++
     ++		int err = iterator_next_log(it, &log);
     ++		if (err < 0) {
     ++			return err;
     ++		}
     ++
     ++		if (err > 0 || strcmp(log.ref_name, refname)) {
     ++			break;
     ++		}
     ++		hashcpy(ooid.hash, log.old_hash);
     ++		hashcpy(noid.hash, log.new_hash);
     ++
     ++		if (should_prune_fn(&ooid, &noid, log.email,
     ++				    (timestamp_t)log.time, log.tz_offset,
     ++				    log.message, policy_cb_data)) {
     ++			add_log_tombstone(&arg, refname, log.update_index);
     ++		}
     ++	}
     ++	log_record_clear(&log);
     ++	iterator_destroy(&it);
     ++	err = stack_add(refs->stack, &write_reflog_expiry_table, &arg);
     ++	clear_log_tombstones(&arg);
     ++	return err;
      +}
      +
      +static int reftable_read_raw_ref(struct ref_store *ref_store,

-- 
gitgitgadget
