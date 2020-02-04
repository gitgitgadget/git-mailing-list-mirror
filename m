Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6160C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A822166E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUl17tkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgBDU1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:27:50 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:52450 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBDU1s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 15:27:48 -0500
Received: by mail-wm1-f48.google.com with SMTP id p9so38496wmc.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 12:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ArQNwDD2dNZeybt+MDckhf018+xpIOQk75/TO+rLSrM=;
        b=AUl17tkxueNkRQnwPMgjguzBPO6lQW+VzCRVGXpqB6EJjdVnqRHfiVF+um8U9nDhxe
         WEo53JecYBHRkEXJPfSnTwiRu309znwu3s1909eQXm+81B5G1bpy507qf2XKhdPRZMIv
         H/MeWOY+/+SwwFm/u6f3TjSjXDOsbFIrF4qBjTHAN+lldt5RbH8buYN9eNUMeC+Luq9S
         C2jOorGP2OwGVaKgIraVl5CEpksGPE7vIEQwjOtGSrjqr5n8vwjycWlHztqnC65/eZoo
         xYHOWlJ+E8kLmznOMHgRSrbzKo3NX7TRCawsnrGQ0YsgYk7zQKS9nrEyyYPgAzTXJAn6
         HW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ArQNwDD2dNZeybt+MDckhf018+xpIOQk75/TO+rLSrM=;
        b=ciHmpSw0C7Mu68Q51cTvKEZp+pVovFkraOtReNCgYGENgkFiVPMi86oJtn+WsdBvm4
         Q8anW22WsrFRI5QTZp8qjKgjwBqjS4718pBVMnt+QeE3qo8brBWHcS58wrLEmpQsKNga
         WwoY42KIioQlTjrGtyU/DIoUgS7/xfr0a0DBzi91ieg/5pdlYILet/shbGa0hX8qEuOs
         BNUNXLUUZWxBLN2OHHL/iuTKW+ej+ymISmcfh928Ll1aHvO67NPHYQD6dnZz+FxDHfFo
         4CGJdZfr3/qy5yyIAIHLuuhVBpU3lswiHfD3vGIaNxH+cVFZm6IKzxSlG6pHs6MvA6qH
         29gQ==
X-Gm-Message-State: APjAAAXV3GXFySQ235GObtoi87WYTEcPYa9sCDhNYQ+84KIipXtp0SpD
        MM8S6FHDxsVyevGmKoYy5ggAsG3Z
X-Google-Smtp-Source: APXvYqwLRkfblzVNzANgssTpar/SLH1MRHTOkLWZ1Ul1yqSPMOUqEsjHxCJkAD4p7fEnAmpOvjhisg==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr728966wma.81.1580848061432;
        Tue, 04 Feb 2020 12:27:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm31808866wra.83.2020.02.04.12.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 12:27:40 -0800 (PST)
Message-Id: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
References: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Feb 2020 20:27:34 +0000
Subject: [PATCH v3 0/6] Reftable support git-core
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

At this point, I am mainly interested in feedback on the spots marked with
XXX in the Git source code, in particular, how to handle reflog expiry in
this backend.

v2

 * address Jun's nits.
 * address Dscho's portability comments
 * more background in commit messages.

Han-Wen Nienhuys (6):
  refs.h: clarify reflog iteration order
  setup.c: enable repo detection for reftable
  create .git/refs in files-backend.c
  refs: document how ref_iterator_advance_fn should handle symrefs
  Add reftable library
  Reftable support for git-core

 Makefile                |   24 +-
 builtin/init-db.c       |   42 +-
 cache.h                 |    2 +
 refs.c                  |   22 +-
 refs.h                  |    5 +-
 refs/files-backend.c    |    5 +
 refs/refs-internal.h    |    6 +
 refs/reftable-backend.c |  880 +++++++++++++++++++++++++++++++
 reftable/LICENSE        |   31 ++
 reftable/README.md      |   19 +
 reftable/VERSION        |    5 +
 reftable/basics.c       |  196 +++++++
 reftable/basics.h       |   37 ++
 reftable/block.c        |  401 ++++++++++++++
 reftable/block.h        |   71 +++
 reftable/blocksource.h  |   20 +
 reftable/bytes.c        |    0
 reftable/config.h       |    1 +
 reftable/constants.h    |   27 +
 reftable/dump.c         |   97 ++++
 reftable/file.c         |   97 ++++
 reftable/iter.c         |  229 ++++++++
 reftable/iter.h         |   56 ++
 reftable/merged.c       |  286 ++++++++++
 reftable/merged.h       |   34 ++
 reftable/pq.c           |  114 ++++
 reftable/pq.h           |   34 ++
 reftable/reader.c       |  708 +++++++++++++++++++++++++
 reftable/reader.h       |   52 ++
 reftable/record.c       | 1107 +++++++++++++++++++++++++++++++++++++++
 reftable/record.h       |   79 +++
 reftable/reftable.h     |  399 ++++++++++++++
 reftable/slice.c        |  199 +++++++
 reftable/slice.h        |   39 ++
 reftable/stack.c        |  983 ++++++++++++++++++++++++++++++++++
 reftable/stack.h        |   40 ++
 reftable/system.h       |   57 ++
 reftable/tree.c         |   66 +++
 reftable/tree.h         |   24 +
 reftable/writer.c       |  622 ++++++++++++++++++++++
 reftable/writer.h       |   46 ++
 reftable/zlib-compat.c  |   92 ++++
 repository.c            |    4 +
 repository.h            |    3 +
 setup.c                 |   27 +-
 45 files changed, 7255 insertions(+), 33 deletions(-)
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


base-commit: 5b0ca878e008e82f91300091e793427205ce3544
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v2:

 -:  ---------- > 1:  c00403c94d refs.h: clarify reflog iteration order
 1:  174b98f6db ! 2:  57c7342319 setup.c: enable repo detection for reftable
     @@ -10,7 +10,6 @@
      
          * allow missing HEAD if there is a reftable/
      
     -    Change-Id: I5d22317a15a84c8529aa503ae357a4afba247fe9
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       diff --git a/setup.c b/setup.c
 2:  d7d642dcf6 ! 3:  5b7060cb2f create .git/refs in files-backend.c
     @@ -2,11 +2,10 @@
      
          create .git/refs in files-backend.c
      
     -    This prepares for supporting the reftable format, which creates a file
     -    in that place.
     +    This prepares for supporting the reftable format, which will want
     +    create its own file system layout in .git
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     -    Change-Id: I2fc47c89f5ec605734007ceff90321c02474aa92
      
       diff --git a/builtin/init-db.c b/builtin/init-db.c
       --- a/builtin/init-db.c
     @@ -30,7 +29,8 @@
       
      +	files_ref_path(refs, &sb, "refs");
      +	safe_create_dir(sb.buf, 1);
     -+ 	// XXX adjust_shared_perm ?
     ++        /* adjust permissions even if directory already exists. */
     ++	adjust_shared_perm(sb.buf);
      +
       	/*
       	 * Create .git/refs/{heads,tags}
 3:  9cf185b51f ! 4:  1b01c735a9 Document how ref iterators and symrefs interact
     @@ -1,20 +1,21 @@
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
     -    Document how ref iterators and symrefs interact
     +    refs: document how ref_iterator_advance_fn should handle symrefs
      
     -    Change-Id: Ie3ee63c52254c000ef712986246ca28f312b4301
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       diff --git a/refs/refs-internal.h b/refs/refs-internal.h
       --- a/refs/refs-internal.h
       +++ b/refs/refs-internal.h
      @@
     -  * to the next entry, ref_iterator_advance() aborts the iteration,
     -  * frees the ref_iterator, and returns ITER_ERROR.
     -  *
     -+ * Ref iterators cannot return symref targets, so symbolic refs must be
     -+ * dereferenced during the iteration.
     -+ *
     -  * The reference currently being looked at can be peeled by calling
     -  * ref_iterator_peel(). This function is often faster than peel_ref(),
     -  * so it should be preferred when iterating over references.
     + 
     + /* Virtual function declarations for ref_iterators: */
     + 
     ++/*
     ++ * backend-specific implementation of ref_iterator_advance.
     ++ * For symrefs, the function should set REF_ISSYMREF, and it should also dereference
     ++ * the symref to provide the OID referent.
     ++ */
     + typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
     + 
     + typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
 4:  2106ff286b ! 5:  eb0df10068 Add reftable library
     @@ -30,7 +30,6 @@
          * go-git support issue: https://github.com/src-d/go-git/issues/1059
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     -    Change-Id: Id396ff42be8b42b9e11f194a32e2f95b8250c109
      
       diff --git a/reftable/LICENSE b/reftable/LICENSE
       new file mode 100644
     @@ -88,6 +87,8 @@
      +   git --git-dir reftable-repo/.git show --no-patch origin/master \
      +    > reftable/VERSION && \
      +   echo '/* empty */' > reftable/config.h
     ++   rm reftable/*_test.c reftable/test_framework.*
     ++   git add reftable/*.[ch]
      +
      +Bugfixes should be accompanied by a test and applied to upstream project at
      +https://github.com/google/reftable.
     @@ -97,11 +98,11 @@
       --- /dev/null
       +++ b/reftable/VERSION
      @@
     -+commit c616d53b88657c3a5fe4d2e7243a48effc34c626
     ++commit e54326f73d95bfe8b17f264c400f4c365dbd5e5e
      +Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Mon Jan 27 15:05:43 2020 +0100
     ++Date:   Tue Feb 4 19:48:17 2020 +0100
      +
     -+    C: ban // comments
     ++    C: PRI?MAX use; clang-format.
      
       diff --git a/reftable/basics.c b/reftable/basics.c
       new file mode 100644
     @@ -327,7 +328,6 @@
      +
      +#define true 1
      +#define false 0
     -+#define ARRAYSIZE(a) sizeof(a) / sizeof(a[0])
      +
      +void put_u24(byte *out, uint32_t i);
      +uint32_t get_u24(byte *in);
     @@ -528,9 +528,10 @@
      +		slice_resize(&uncompressed, sz);
      +		memcpy(uncompressed.buf, block->data, block_header_skip);
      +
     -+		if (Z_OK !=
     -+		    uncompress2(uncompressed.buf + block_header_skip, &dst_len,
     -+				block->data + block_header_skip, &src_len)) {
     ++		if (Z_OK != uncompress_return_consumed(
     ++				    uncompressed.buf + block_header_skip,
     ++				    &dst_len, block->data + block_header_skip,
     ++				    &src_len)) {
      +			free(slice_yield(&uncompressed));
      +			return ZLIB_ERROR;
      +		}
     @@ -545,8 +546,8 @@
      +	} else if (sz < full_block_size && sz < block->len &&
      +		   block->data[sz] != 0) {
      +		/* If the block is smaller than the full block size, it is
     -+                   padded (data followed by '\0') or the next block is
     -+                   unaligned. */
     ++		   padded (data followed by '\0') or the next block is
     ++		   unaligned. */
      +		full_block_size = sz;
      +	}
      +
     @@ -750,8 +751,7 @@
      +
      +void block_writer_clear(struct block_writer *bw)
      +{
     -+	free(bw->restarts);
     -+	bw->restarts = NULL;
     ++	FREE_AND_NULL(bw->restarts);
      +	free(slice_yield(&bw->last_key));
      +	/* the block is not owned. */
      +}
     @@ -833,163 +833,6 @@
      +
      +#endif
      
     - diff --git a/reftable/block_test.c b/reftable/block_test.c
     - new file mode 100644
     - --- /dev/null
     - +++ b/reftable/block_test.c
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "block.h"
     -+
     -+#include "system.h"
     -+
     -+#include "basics.h"
     -+#include "constants.h"
     -+#include "record.h"
     -+#include "reftable.h"
     -+#include "test_framework.h"
     -+
     -+struct binsearch_args {
     -+	int key;
     -+	int *arr;
     -+};
     -+
     -+static int binsearch_func(int i, void *void_args)
     -+{
     -+	struct binsearch_args *args = (struct binsearch_args *)void_args;
     -+
     -+	return args->key < args->arr[i];
     -+}
     -+
     -+void test_binsearch()
     -+{
     -+	int arr[] = { 2, 4, 6, 8, 10 };
     -+	int sz = ARRAYSIZE(arr);
     -+	struct binsearch_args args = {
     -+		.arr = arr,
     -+	};
     -+
     -+	int i = 0;
     -+	for (i = 1; i < 11; i++) {
     -+		args.key = i;
     -+		int res = binsearch(sz, &binsearch_func, &args);
     -+
     -+		if (res < sz) {
     -+			assert(args.key < arr[res]);
     -+			if (res > 0) {
     -+				assert(args.key >= arr[res - 1]);
     -+			}
     -+		} else {
     -+			assert(args.key == 10 || args.key == 11);
     -+		}
     -+	}
     -+}
     -+
     -+void test_block_read_write()
     -+{
     -+	const int header_off = 21; /* random */
     -+	const int N = 30;
     -+	char *names[N];
     -+	const int block_size = 1024;
     -+	struct block block = {};
     -+	block.data = calloc(block_size, 1);
     -+	block.len = block_size;
     -+
     -+	struct block_writer bw = {};
     -+	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
     -+			  header_off, SHA1_SIZE);
     -+	struct ref_record ref = {};
     -+	struct record rec = {};
     -+	record_from_ref(&rec, &ref);
     -+
     -+	int i = 0;
     -+	for (i = 0; i < N; i++) {
     -+		char name[100];
     -+		snprintf(name, sizeof(name), "branch%02d", i);
     -+
     -+		byte hash[SHA1_SIZE];
     -+		memset(hash, i, sizeof(hash));
     -+
     -+		ref.ref_name = name;
     -+		ref.value = hash;
     -+		names[i] = strdup(name);
     -+		int n = block_writer_add(&bw, rec);
     -+		ref.ref_name = NULL;
     -+		ref.value = NULL;
     -+		assert(n == 0);
     -+	}
     -+
     -+	int n = block_writer_finish(&bw);
     -+	assert(n > 0);
     -+
     -+	block_writer_clear(&bw);
     -+
     -+	struct block_reader br = {};
     -+	block_reader_init(&br, &block, header_off, block_size, SHA1_SIZE);
     -+
     -+	struct block_iter it = {};
     -+	block_reader_start(&br, &it);
     -+
     -+	int j = 0;
     -+	while (true) {
     -+		int r = block_iter_next(&it, rec);
     -+		assert(r >= 0);
     -+		if (r > 0) {
     -+			break;
     -+		}
     -+		assert_streq(names[j], ref.ref_name);
     -+		j++;
     -+	}
     -+
     -+	record_clear(rec);
     -+	block_iter_close(&it);
     -+
     -+	struct slice want = {};
     -+	for (i = 0; i < N; i++) {
     -+		slice_set_string(&want, names[i]);
     -+
     -+		struct block_iter it = {};
     -+		int n = block_reader_seek(&br, &it, want);
     -+		assert(n == 0);
     -+
     -+		n = block_iter_next(&it, rec);
     -+		assert(n == 0);
     -+
     -+		assert_streq(names[i], ref.ref_name);
     -+
     -+		want.len--;
     -+		n = block_reader_seek(&br, &it, want);
     -+		assert(n == 0);
     -+
     -+		n = block_iter_next(&it, rec);
     -+		assert(n == 0);
     -+		assert_streq(names[10 * (i / 10)], ref.ref_name);
     -+
     -+		block_iter_close(&it);
     -+	}
     -+
     -+	record_clear(rec);
     -+	free(block.data);
     -+	free(slice_yield(&want));
     -+	for (i = 0; i < N; i++) {
     -+		free(names[i]);
     -+	}
     -+}
     -+
     -+int main()
     -+{
     -+	add_test_case("binsearch", &test_binsearch);
     -+	add_test_case("block_read_write", &test_block_read_write);
     -+	test_main();
     -+}
     -
       diff --git a/reftable/blocksource.h b/reftable/blocksource.h
       new file mode 100644
       --- /dev/null
     @@ -1324,8 +1167,7 @@
      +	}
      +	it->ops->close(it->iter_arg);
      +	it->ops = NULL;
     -+	free(it->iter_arg);
     -+	it->iter_arg = NULL;
     ++	FREE_AND_NULL(it->iter_arg);
      +}
      +
      +int iterator_next_ref(struct iterator it, struct ref_record *ref)
     @@ -1751,16 +1593,14 @@
      +	for (i = 0; i < mt->stack_len; i++) {
      +		reader_free(mt->stack[i]);
      +	}
     -+	free(mt->stack);
     -+	mt->stack = NULL;
     ++	FREE_AND_NULL(mt->stack);
      +	mt->stack_len = 0;
      +}
      +
      +/* clears the list of subtable, without affecting the readers themselves. */
      +void merged_table_clear(struct merged_table *mt)
      +{
     -+	free(mt->stack);
     -+	mt->stack = NULL;
     ++	FREE_AND_NULL(mt->stack);
      +	mt->stack_len = 0;
      +}
      +
     @@ -1897,270 +1737,6 @@
      +
      +#endif
      
     - diff --git a/reftable/merged_test.c b/reftable/merged_test.c
     - new file mode 100644
     - --- /dev/null
     - +++ b/reftable/merged_test.c
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "merged.h"
     -+
     -+#include "system.h"
     -+
     -+#include "basics.h"
     -+#include "block.h"
     -+#include "constants.h"
     -+#include "pq.h"
     -+#include "reader.h"
     -+#include "record.h"
     -+#include "reftable.h"
     -+#include "test_framework.h"
     -+
     -+void test_pq(void)
     -+{
     -+	char *names[54] = {};
     -+	int N = ARRAYSIZE(names) - 1;
     -+
     -+	int i = 0;
     -+	for (i = 0; i < N; i++) {
     -+		char name[100];
     -+		snprintf(name, sizeof(name), "%02d", i);
     -+		names[i] = strdup(name);
     -+	}
     -+
     -+	struct merged_iter_pqueue pq = {};
     -+
     -+	i = 1;
     -+	do {
     -+		struct record rec = new_record(BLOCK_TYPE_REF);
     -+		record_as_ref(rec)->ref_name = names[i];
     -+
     -+		struct pq_entry e = {
     -+			.rec = rec,
     -+		};
     -+		merged_iter_pqueue_add(&pq, e);
     -+		merged_iter_pqueue_check(pq);
     -+		i = (i * 7) % N;
     -+	} while (i != 1);
     -+
     -+	const char *last = NULL;
     -+	while (!merged_iter_pqueue_is_empty(pq)) {
     -+		struct pq_entry e = merged_iter_pqueue_remove(&pq);
     -+		merged_iter_pqueue_check(pq);
     -+		struct ref_record *ref = record_as_ref(e.rec);
     -+
     -+		if (last != NULL) {
     -+			assert(strcmp(last, ref->ref_name) < 0);
     -+		}
     -+		last = ref->ref_name;
     -+		ref->ref_name = NULL;
     -+		free(ref);
     -+	}
     -+
     -+	for (i = 0; i < N; i++) {
     -+		free(names[i]);
     -+	}
     -+
     -+	merged_iter_pqueue_clear(&pq);
     -+}
     -+
     -+void write_test_table(struct slice *buf, struct ref_record refs[], int n)
     -+{
     -+	int min = 0xffffffff;
     -+	int max = 0;
     -+	int i = 0;
     -+	for (i = 0; i < n; i++) {
     -+		uint64_t ui = refs[i].update_index;
     -+		if (ui > max) {
     -+			max = ui;
     -+		}
     -+		if (ui < min) {
     -+			min = ui;
     -+		}
     -+	}
     -+
     -+	struct write_options opts = {
     -+		.block_size = 256,
     -+	};
     -+
     -+	struct writer *w = new_writer(&slice_write_void, buf, &opts);
     -+	writer_set_limits(w, min, max);
     -+
     -+	for (i = 0; i < n; i++) {
     -+		uint64_t before = refs[i].update_index;
     -+		int n = writer_add_ref(w, &refs[i]);
     -+		assert(n == 0);
     -+		assert(before == refs[i].update_index);
     -+	}
     -+
     -+	int err = writer_close(w);
     -+	assert(err == 0);
     -+
     -+	writer_free(w);
     -+	w = NULL;
     -+}
     -+
     -+static struct merged_table *merged_table_from_records(struct ref_record **refs,
     -+						      int *sizes,
     -+						      struct slice *buf, int n)
     -+{
     -+	struct block_source *source = calloc(n, sizeof(*source));
     -+	struct reader **rd = calloc(n, sizeof(*rd));
     -+	int i = 0;
     -+	for (i = 0; i < n; i++) {
     -+		write_test_table(&buf[i], refs[i], sizes[i]);
     -+		block_source_from_slice(&source[i], &buf[i]);
     -+
     -+		int err = new_reader(&rd[i], source[i], "name");
     -+		assert(err == 0);
     -+	}
     -+
     -+	struct merged_table *mt = NULL;
     -+	int err = new_merged_table(&mt, rd, n);
     -+	assert(err == 0);
     -+	return mt;
     -+}
     -+
     -+void test_merged_between(void)
     -+{
     -+	byte hash1[SHA1_SIZE];
     -+	byte hash2[SHA1_SIZE];
     -+
     -+	set_test_hash(hash1, 1);
     -+	set_test_hash(hash2, 2);
     -+	struct ref_record r1[] = { {
     -+		.ref_name = "b",
     -+		.update_index = 1,
     -+		.value = hash1,
     -+	} };
     -+	struct ref_record r2[] = { {
     -+		.ref_name = "a",
     -+		.update_index = 2,
     -+	} };
     -+
     -+	struct ref_record *refs[] = { r1, r2 };
     -+	int sizes[] = { 1, 1 };
     -+	struct slice bufs[2] = {};
     -+	struct merged_table *mt =
     -+		merged_table_from_records(refs, sizes, bufs, 2);
     -+
     -+	struct iterator it = {};
     -+	int err = merged_table_seek_ref(mt, &it, "a");
     -+	assert(err == 0);
     -+
     -+	struct ref_record ref = {};
     -+	err = iterator_next_ref(it, &ref);
     -+	assert_err(err);
     -+	assert(ref.update_index == 2);
     -+}
     -+
     -+void test_merged(void)
     -+{
     -+	byte hash1[SHA1_SIZE];
     -+	byte hash2[SHA1_SIZE];
     -+
     -+	set_test_hash(hash1, 1);
     -+	set_test_hash(hash2, 2);
     -+	struct ref_record r1[] = { {
     -+					   .ref_name = "a",
     -+					   .update_index = 1,
     -+					   .value = hash1,
     -+				   },
     -+				   {
     -+					   .ref_name = "b",
     -+					   .update_index = 1,
     -+					   .value = hash1,
     -+				   },
     -+				   {
     -+					   .ref_name = "c",
     -+					   .update_index = 1,
     -+					   .value = hash1,
     -+				   } };
     -+	struct ref_record r2[] = { {
     -+		.ref_name = "a",
     -+		.update_index = 2,
     -+	} };
     -+	struct ref_record r3[] = {
     -+		{
     -+			.ref_name = "c",
     -+			.update_index = 3,
     -+			.value = hash2,
     -+		},
     -+		{
     -+			.ref_name = "d",
     -+			.update_index = 3,
     -+			.value = hash1,
     -+		},
     -+	};
     -+
     -+	struct ref_record *refs[] = { r1, r2, r3 };
     -+	int sizes[3] = { 3, 1, 2 };
     -+	struct slice bufs[3] = {};
     -+
     -+	struct merged_table *mt =
     -+		merged_table_from_records(refs, sizes, bufs, 3);
     -+
     -+	struct iterator it = {};
     -+	int err = merged_table_seek_ref(mt, &it, "a");
     -+	assert(err == 0);
     -+
     -+	struct ref_record *out = NULL;
     -+	int len = 0;
     -+	int cap = 0;
     -+	while (len < 100) { /* cap loops/recursion. */
     -+		struct ref_record ref = {};
     -+		int err = iterator_next_ref(it, &ref);
     -+		if (err > 0) {
     -+			break;
     -+		}
     -+		if (len == cap) {
     -+			cap = 2 * cap + 1;
     -+			out = realloc(out, sizeof(struct ref_record) * cap);
     -+		}
     -+		out[len++] = ref;
     -+	}
     -+	iterator_destroy(&it);
     -+
     -+	struct ref_record want[] = {
     -+		r2[0],
     -+		r1[1],
     -+		r3[0],
     -+		r3[1],
     -+	};
     -+	assert(ARRAYSIZE(want) == len);
     -+	int i = 0;
     -+	for (i = 0; i < len; i++) {
     -+		assert(ref_record_equal(&want[i], &out[i], SHA1_SIZE));
     -+	}
     -+	for (i = 0; i < len; i++) {
     -+		ref_record_clear(&out[i]);
     -+	}
     -+	free(out);
     -+
     -+	for (i = 0; i < 3; i++) {
     -+		free(slice_yield(&bufs[i]));
     -+	}
     -+	merged_table_close(mt);
     -+	merged_table_free(mt);
     -+}
     -+
     -+/* XXX test refs_for(oid) */
     -+
     -+int main()
     -+{
     -+	add_test_case("test_merged_between", &test_merged_between);
     -+	add_test_case("test_pq", &test_pq);
     -+	add_test_case("test_merged", &test_merged);
     -+	test_main();
     -+}
     -
       diff --git a/reftable/pq.c b/reftable/pq.c
       new file mode 100644
       --- /dev/null
     @@ -2241,12 +1817,7 @@
      +			break;
      +		}
      +
     -+		{
     -+			struct pq_entry tmp = pq->heap[min];
     -+			pq->heap[min] = pq->heap[i];
     -+			pq->heap[i] = tmp;
     -+		}
     -+
     ++		SWAP(pq->heap[i], pq->heap[min]);
      +		i = min;
      +	}
      +
     @@ -2269,11 +1840,7 @@
      +			break;
      +		}
      +
     -+		{
     -+			struct pq_entry tmp = pq->heap[j];
     -+			pq->heap[j] = pq->heap[i];
     -+			pq->heap[i] = tmp;
     -+		}
     ++		SWAP(pq->heap[j], pq->heap[i]);
      +
      +		i = j;
      +	}
     @@ -2286,8 +1853,7 @@
      +		record_clear(pq->heap[i].rec);
      +		free(record_yield(&pq->heap[i].rec));
      +	}
     -+	free(pq->heap);
     -+	pq->heap = NULL;
     ++	FREE_AND_NULL(pq->heap);
      +	pq->len = pq->cap = 0;
      +}
      
     @@ -2561,8 +2127,7 @@
      +		return;
      +	}
      +	reader_return_block(ti->r, &ti->bi.br->block);
     -+	free(ti->bi.br);
     -+	ti->bi.br = NULL;
     ++	FREE_AND_NULL(ti->bi.br);
      +
      +	ti->bi.last_key.len = 0;
      +	ti->bi.next_off = 0;
     @@ -2934,8 +2499,7 @@
      +void reader_close(struct reader *r)
      +{
      +	block_source_close(&r->source);
     -+	free(r->name);
     -+	r->name = NULL;
     ++	FREE_AND_NULL(r->name);
      +}
      +
      +int new_reader(struct reader **p, struct block_source src, char const *name)
     @@ -3271,7 +2835,7 @@
      +	assert(hash_size > 0);
      +
      +	/* This is simple and correct, but we could probably reuse the hash
     -+           fields. */
     ++	   fields. */
      +	ref_record_clear(ref);
      +	if (src->ref_name != NULL) {
      +		ref->ref_name = strdup(src->ref_name);
     @@ -3491,16 +3055,13 @@
      +	}
      +
      +	if (!seen_target && r->target != NULL) {
     -+		free(r->target);
     -+		r->target = NULL;
     ++		FREE_AND_NULL(r->target);
      +	}
      +	if (!seen_target_value && r->target_value != NULL) {
     -+		free(r->target_value);
     -+		r->target_value = NULL;
     ++		FREE_AND_NULL(r->target_value);
      +	}
      +	if (!seen_value && r->value != NULL) {
     -+		free(r->value);
     -+		r->value = NULL;
     ++		FREE_AND_NULL(r->value);
      +	}
      +
      +	return start.len - in.len;
     @@ -3588,8 +3149,8 @@
      +static void obj_record_clear(void *rec)
      +{
      +	struct obj_record *ref = (struct obj_record *)rec;
     -+	free(ref->hash_prefix);
     -+	free(ref->offsets);
     ++	FREE_AND_NULL(ref->hash_prefix);
     ++	FREE_AND_NULL(ref->offsets);
      +	memset(ref, 0, sizeof(struct obj_record));
      +}
      +
     @@ -3713,9 +3274,9 @@
      +{
      +	char hex[SHA256_SIZE + 1] = {};
      +
     -+	printf("log{%s(%" PRIdMAX ") %s <%s> %lu %04d\n", log->ref_name,
     -+	       log->update_index, log->name, log->email, log->time,
     -+	       log->tz_offset);
     ++	printf("log{%s(%" PRIdMAX ") %s <%s> %" PRIuMAX " %04d\n",
     ++	       log->ref_name, log->update_index, log->name, log->email,
     ++	       log->time, log->tz_offset);
      +	hex_format(hex, log->old_hash, hash_size);
      +	printf("%s => ", hex);
      +	hex_format(hex, log->new_hash, hash_size);
     @@ -4306,10 +3867,10 @@
      +
      +#endif
      
     - diff --git a/reftable/record_test.c b/reftable/record_test.c
     + diff --git a/reftable/reftable.h b/reftable/reftable.h
       new file mode 100644
       --- /dev/null
     - +++ b/reftable/record_test.c
     + +++ b/reftable/reftable.h
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ -4319,402 +3880,64 @@
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#include "record.h"
     ++#ifndef REFTABLE_H
     ++#define REFTABLE_H
      +
      +#include "system.h"
      +
     -+#include "basics.h"
     -+#include "constants.h"
     -+#include "reftable.h"
     -+#include "test_framework.h"
     -+
     -+void varint_roundtrip()
     -+{
     -+	uint64_t inputs[] = { 0,
     -+			      1,
     -+			      27,
     -+			      127,
     -+			      128,
     -+			      257,
     -+			      4096,
     -+			      ((uint64_t)1 << 63),
     -+			      ((uint64_t)1 << 63) + ((uint64_t)1 << 63) - 1 };
     -+	int i = 0;
     -+	for (i = 0; i < ARRAYSIZE(inputs); i++) {
     -+		byte dest[10];
     ++typedef uint8_t byte;
     ++typedef byte bool;
      +
     -+		struct slice out = { .buf = dest, .len = 10, .cap = 10 };
     ++/* block_source is a generic wrapper for a seekable readable file.
     ++   It is generally passed around by value.
     ++ */
     ++struct block_source {
     ++	struct block_source_vtable *ops;
     ++	void *arg;
     ++};
      +
     -+		uint64_t in = inputs[i];
     -+		int n = put_var_int(out, in);
     -+		assert(n > 0);
     -+		out.len = n;
     ++/* a contiguous segment of bytes. It keeps track of its generating block_source
     ++   so it can return itself into the pool.
     ++*/
     ++struct block {
     ++	byte *data;
     ++	int len;
     ++	struct block_source source;
     ++};
      +
     -+		uint64_t got = 0;
     -+		n = get_var_int(&got, out);
     -+		assert(n > 0);
     ++/* block_source_vtable are the operations that make up block_source */
     ++struct block_source_vtable {
     ++	/* returns the size of a block source */
     ++	uint64_t (*size)(void *source);
      +
     -+		assert(got == in);
     -+	}
     -+}
     ++	/* reads a segment from the block source. It is an error to read
     ++	   beyond the end of the block */
     ++	int (*read_block)(void *source, struct block *dest, uint64_t off,
     ++			  uint32_t size);
     ++	/* mark the block as read; may return the data back to malloc */
     ++	void (*return_block)(void *source, struct block *blockp);
      +
     -+void test_common_prefix()
     -+{
     -+	struct {
     -+		const char *a, *b;
     -+		int want;
     -+	} cases[] = {
     -+		{ "abc", "ab", 2 },
     -+		{ "", "abc", 0 },
     -+		{ "abc", "abd", 2 },
     -+		{ "abc", "pqr", 0 },
     -+	};
     ++	/* release all resources associated with the block source */
     ++	void (*close)(void *source);
     ++};
      +
     -+	int i = 0;
     -+	for (i = 0; i < ARRAYSIZE(cases); i++) {
     -+		struct slice a = {};
     -+		struct slice b = {};
     -+		slice_set_string(&a, cases[i].a);
     -+		slice_set_string(&b, cases[i].b);
     ++/* opens a file on the file system as a block_source */
     ++int block_source_from_file(struct block_source *block_src, const char *name);
      +
     -+		int got = common_prefix_size(a, b);
     -+		assert(got == cases[i].want);
     ++/* write_options sets options for writing a single reftable. */
     ++struct write_options {
     ++	/* do not pad out blocks to block size. */
     ++	bool unpadded;
      +
     -+		free(slice_yield(&a));
     -+		free(slice_yield(&b));
     -+	}
     -+}
     ++	/* the blocksize. Should be less than 2^24. */
     ++	uint32_t block_size;
      +
     -+void set_hash(byte *h, int j)
     -+{
     -+	int i = 0;
     -+	for (i = 0; i < SHA1_SIZE; i++) {
     -+		h[i] = (j >> i) & 0xff;
     -+	}
     -+}
     ++	/* do not generate a SHA1 => ref index. */
     ++	bool skip_index_objects;
      +
     -+void test_ref_record_roundtrip()
     -+{
     -+	int i = 0;
     -+	for (i = 0; i <= 3; i++) {
     -+		printf("subtest %d\n", i);
     -+		struct ref_record in = {};
     -+		switch (i) {
     -+		case 0:
     -+			break;
     -+		case 1:
     -+			in.value = malloc(SHA1_SIZE);
     -+			set_hash(in.value, 1);
     -+			break;
     -+		case 2:
     -+			in.value = malloc(SHA1_SIZE);
     -+			set_hash(in.value, 1);
     -+			in.target_value = malloc(SHA1_SIZE);
     -+			set_hash(in.target_value, 2);
     -+			break;
     -+		case 3:
     -+			in.target = strdup("target");
     -+			break;
     -+		}
     -+		in.ref_name = strdup("refs/heads/master");
     -+
     -+		struct record rec = {};
     -+		record_from_ref(&rec, &in);
     -+		assert(record_val_type(rec) == i);
     -+		byte buf[1024];
     -+		struct slice key = {};
     -+		record_key(rec, &key);
     -+		struct slice dest = {
     -+			.buf = buf,
     -+			.len = sizeof(buf),
     -+		};
     -+		int n = record_encode(rec, dest, SHA1_SIZE);
     -+		assert(n > 0);
     -+
     -+		struct ref_record out = {};
     -+		struct record rec_out = {};
     -+		record_from_ref(&rec_out, &out);
     -+		int m = record_decode(rec_out, key, i, dest, SHA1_SIZE);
     -+		assert(n == m);
     -+
     -+		assert((out.value != NULL) == (in.value != NULL));
     -+		assert((out.target_value != NULL) == (in.target_value != NULL));
     -+		assert((out.target != NULL) == (in.target != NULL));
     -+		free(slice_yield(&key));
     -+		record_clear(rec_out);
     -+		ref_record_clear(&in);
     -+	}
     -+}
     -+
     -+void test_log_record_roundtrip()
     -+{
     -+	struct log_record in = {
     -+		.ref_name = strdup("refs/heads/master"),
     -+		.old_hash = malloc(SHA1_SIZE),
     -+		.new_hash = malloc(SHA1_SIZE),
     -+		.name = strdup("han-wen"),
     -+		.email = strdup("hanwen@google.com"),
     -+		.message = strdup("test"),
     -+		.update_index = 42,
     -+		.time = 1577123507,
     -+		.tz_offset = 100,
     -+	};
     -+
     -+	struct record rec = {};
     -+	record_from_log(&rec, &in);
     -+
     -+	struct slice key = {};
     -+	record_key(rec, &key);
     -+
     -+	byte buf[1024];
     -+	struct slice dest = {
     -+		.buf = buf,
     -+		.len = sizeof(buf),
     -+	};
     -+
     -+	int n = record_encode(rec, dest, SHA1_SIZE);
     -+	assert(n > 0);
     -+
     -+	struct log_record out = {};
     -+	struct record rec_out = {};
     -+	record_from_log(&rec_out, &out);
     -+	int valtype = record_val_type(rec);
     -+	int m = record_decode(rec_out, key, valtype, dest, SHA1_SIZE);
     -+	assert(n == m);
     -+
     -+	assert(log_record_equal(&in, &out, SHA1_SIZE));
     -+	log_record_clear(&in);
     -+	free(slice_yield(&key));
     -+	record_clear(rec_out);
     -+}
     -+
     -+void test_u24_roundtrip()
     -+{
     -+	uint32_t in = 0x112233;
     -+	byte dest[3];
     -+
     -+	put_u24(dest, in);
     -+	uint32_t out = get_u24(dest);
     -+	assert(in == out);
     -+}
     -+
     -+void test_key_roundtrip()
     -+{
     -+	struct slice dest = {}, last_key = {}, key = {}, roundtrip = {};
     -+
     -+	slice_resize(&dest, 1024);
     -+	slice_set_string(&last_key, "refs/heads/master");
     -+	slice_set_string(&key, "refs/tags/bla");
     -+
     -+	bool restart;
     -+	byte extra = 6;
     -+	int n = encode_key(&restart, dest, last_key, key, extra);
     -+	assert(!restart);
     -+	assert(n > 0);
     -+
     -+	byte rt_extra;
     -+	int m = decode_key(&roundtrip, &rt_extra, last_key, dest);
     -+	assert(n == m);
     -+	assert(slice_equal(key, roundtrip));
     -+	assert(rt_extra == extra);
     -+
     -+	free(slice_yield(&last_key));
     -+	free(slice_yield(&key));
     -+	free(slice_yield(&dest));
     -+	free(slice_yield(&roundtrip));
     -+}
     -+
     -+void print_bytes(byte *p, int l)
     -+{
     -+	int i = 0;
     -+	for (i = 0; i < l; i++) {
     -+		byte c = *p;
     -+		if (c < 32) {
     -+			c = '.';
     -+		}
     -+		printf("%02x[%c] ", p[i], c);
     -+	}
     -+	printf("(%d)\n", l);
     -+}
     -+
     -+void test_obj_record_roundtrip()
     -+{
     -+	byte testHash1[SHA1_SIZE] = {};
     -+	set_hash(testHash1, 1);
     -+	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
     -+
     -+	struct obj_record recs[3] = { {
     -+					      .hash_prefix = testHash1,
     -+					      .hash_prefix_len = 5,
     -+					      .offsets = till9,
     -+					      .offset_len = 3,
     -+				      },
     -+				      {
     -+					      .hash_prefix = testHash1,
     -+					      .hash_prefix_len = 5,
     -+					      .offsets = till9,
     -+					      .offset_len = 9,
     -+				      },
     -+				      {
     -+					      .hash_prefix = testHash1,
     -+					      .hash_prefix_len = 5,
     -+				      }
     -+
     -+	};
     -+	int i = 0;
     -+	for (i = 0; i < ARRAYSIZE(recs); i++) {
     -+		printf("subtest %d\n", i);
     -+		struct obj_record in = recs[i];
     -+		byte buf[1024];
     -+		struct record rec = {};
     -+		record_from_obj(&rec, &in);
     -+		struct slice key = {};
     -+		record_key(rec, &key);
     -+		struct slice dest = {
     -+			.buf = buf,
     -+			.len = sizeof(buf),
     -+		};
     -+		int n = record_encode(rec, dest, SHA1_SIZE);
     -+		assert(n > 0);
     -+		byte extra = record_val_type(rec);
     -+		struct obj_record out = {};
     -+		struct record rec_out = {};
     -+		record_from_obj(&rec_out, &out);
     -+		int m = record_decode(rec_out, key, extra, dest, SHA1_SIZE);
     -+		assert(n == m);
     -+
     -+		assert(in.hash_prefix_len == out.hash_prefix_len);
     -+		assert(in.offset_len == out.offset_len);
     -+
     -+		assert(!memcmp(in.hash_prefix, out.hash_prefix,
     -+			       in.hash_prefix_len));
     -+		assert(0 == memcmp(in.offsets, out.offsets,
     -+				   sizeof(uint64_t) * in.offset_len));
     -+		free(slice_yield(&key));
     -+		record_clear(rec_out);
     -+	}
     -+}
     -+
     -+void test_index_record_roundtrip()
     -+{
     -+	struct index_record in = { .offset = 42 };
     -+
     -+	slice_set_string(&in.last_key, "refs/heads/master");
     -+
     -+	struct slice key = {};
     -+	struct record rec = {};
     -+	record_from_index(&rec, &in);
     -+	record_key(rec, &key);
     -+
     -+	assert(0 == slice_compare(key, in.last_key));
     -+
     -+	byte buf[1024];
     -+	struct slice dest = {
     -+		.buf = buf,
     -+		.len = sizeof(buf),
     -+	};
     -+	int n = record_encode(rec, dest, SHA1_SIZE);
     -+	assert(n > 0);
     -+
     -+	byte extra = record_val_type(rec);
     -+	struct index_record out = {};
     -+	struct record out_rec;
     -+	record_from_index(&out_rec, &out);
     -+	int m = record_decode(out_rec, key, extra, dest, SHA1_SIZE);
     -+	assert(m == n);
     -+
     -+	assert(in.offset == out.offset);
     -+
     -+	record_clear(out_rec);
     -+	free(slice_yield(&key));
     -+	free(slice_yield(&in.last_key));
     -+}
     -+
     -+int main()
     -+{
     -+	add_test_case("test_log_record_roundtrip", &test_log_record_roundtrip);
     -+	add_test_case("test_ref_record_roundtrip", &test_ref_record_roundtrip);
     -+	add_test_case("varint_roundtrip", &varint_roundtrip);
     -+	add_test_case("test_key_roundtrip", &test_key_roundtrip);
     -+	add_test_case("test_common_prefix", &test_common_prefix);
     -+	add_test_case("test_obj_record_roundtrip", &test_obj_record_roundtrip);
     -+	add_test_case("test_index_record_roundtrip",
     -+		      &test_index_record_roundtrip);
     -+	add_test_case("test_u24_roundtrip", &test_u24_roundtrip);
     -+	test_main();
     -+}
     -
     - diff --git a/reftable/reftable.h b/reftable/reftable.h
     - new file mode 100644
     - --- /dev/null
     - +++ b/reftable/reftable.h
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#ifndef REFTABLE_H
     -+#define REFTABLE_H
     -+
     -+#include "system.h"
     -+
     -+typedef uint8_t byte;
     -+typedef byte bool;
     -+
     -+/* block_source is a generic wrapper for a seekable readable file.
     -+   It is generally passed around by value.
     -+ */
     -+struct block_source {
     -+	struct block_source_vtable *ops;
     -+	void *arg;
     -+};
     -+
     -+/* a contiguous segment of bytes. It keeps track of its generating block_source
     -+   so it can return itself into the pool.
     -+*/
     -+struct block {
     -+	byte *data;
     -+	int len;
     -+	struct block_source source;
     -+};
     -+
     -+/* block_source_vtable are the operations that make up block_source */
     -+struct block_source_vtable {
     -+	/* returns the size of a block source */
     -+	uint64_t (*size)(void *source);
     -+
     -+	/* reads a segment from the block source. It is an error to read
     -+	   beyond the end of the block */
     -+	int (*read_block)(void *source, struct block *dest, uint64_t off,
     -+			  uint32_t size);
     -+	/* mark the block as read; may return the data back to malloc */
     -+	void (*return_block)(void *source, struct block *blockp);
     -+
     -+	/* release all resources associated with the block source */
     -+	void (*close)(void *source);
     -+};
     -+
     -+/* opens a file on the file system as a block_source */
     -+int block_source_from_file(struct block_source *block_src, const char *name);
     -+
     -+/* write_options sets options for writing a single reftable. */
     -+struct write_options {
     -+	/* do not pad out blocks to block size. */
     -+	bool unpadded;
     -+
     -+	/* the blocksize. Should be less than 2^24. */
     -+	uint32_t block_size;
     -+
     -+	/* do not generate a SHA1 => ref index. */
     -+	bool skip_index_objects;
     -+
     -+	/* how often to write complete keys in each block. */
     -+	int restart_interval;
     -+};
     ++	/* how often to write complete keys in each block. */
     ++	int restart_interval;
     ++};
      +
      +/* ref_record holds a ref database entry target_value */
      +struct ref_record {
     @@ -5049,493 +4272,6 @@
      +
      +#endif
      
     - diff --git a/reftable/reftable_test.c b/reftable/reftable_test.c
     - new file mode 100644
     - --- /dev/null
     - +++ b/reftable/reftable_test.c
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "reftable.h"
     -+
     -+#include "system.h"
     -+
     -+#include "basics.h"
     -+#include "block.h"
     -+#include "constants.h"
     -+#include "reader.h"
     -+#include "record.h"
     -+#include "test_framework.h"
     -+
     -+static const int update_index = 5;
     -+
     -+void test_buffer(void)
     -+{
     -+	struct slice buf = {};
     -+
     -+	byte in[] = "hello";
     -+	slice_write(&buf, in, sizeof(in));
     -+	struct block_source source;
     -+	block_source_from_slice(&source, &buf);
     -+	assert(block_source_size(source) == 6);
     -+	struct block out = {};
     -+	int n = block_source_read_block(source, &out, 0, sizeof(in));
     -+	assert(n == sizeof(in));
     -+	assert(!memcmp(in, out.data, n));
     -+	block_source_return_block(source, &out);
     -+
     -+	n = block_source_read_block(source, &out, 1, 2);
     -+	assert(n == 2);
     -+	assert(!memcmp(out.data, "el", 2));
     -+
     -+	block_source_return_block(source, &out);
     -+	block_source_close(&source);
     -+	free(slice_yield(&buf));
     -+}
     -+
     -+void write_table(char ***names, struct slice *buf, int N, int block_size)
     -+{
     -+	*names = calloc(sizeof(char *), N + 1);
     -+
     -+	struct write_options opts = {
     -+		.block_size = block_size,
     -+	};
     -+
     -+	struct writer *w = new_writer(&slice_write_void, buf, &opts);
     -+
     -+	writer_set_limits(w, update_index, update_index);
     -+	{
     -+		struct ref_record ref = {};
     -+		int i = 0;
     -+		for (i = 0; i < N; i++) {
     -+			byte hash[SHA1_SIZE];
     -+			set_test_hash(hash, i);
     -+
     -+			char name[100];
     -+			snprintf(name, sizeof(name), "refs/heads/branch%02d",
     -+				 i);
     -+
     -+			ref.ref_name = name;
     -+			ref.value = hash;
     -+			ref.update_index = update_index;
     -+			(*names)[i] = strdup(name);
     -+
     -+			int n = writer_add_ref(w, &ref);
     -+			assert(n == 0);
     -+		}
     -+	}
     -+	{
     -+		struct log_record log = {};
     -+		int i = 0;
     -+		for (i = 0; i < N; i++) {
     -+			byte hash[SHA1_SIZE];
     -+			set_test_hash(hash, i);
     -+
     -+			char name[100];
     -+			snprintf(name, sizeof(name), "refs/heads/branch%02d",
     -+				 i);
     -+
     -+			log.ref_name = name;
     -+			log.new_hash = hash;
     -+			log.update_index = update_index;
     -+			log.message = "message";
     -+
     -+			int n = writer_add_log(w, &log);
     -+			assert(n == 0);
     -+		}
     -+	}
     -+
     -+	int n = writer_close(w);
     -+	assert(n == 0);
     -+
     -+	struct stats *stats = writer_stats(w);
     -+	int i = 0;
     -+	for (i = 0; i < stats->ref_stats.blocks; i++) {
     -+		int off = i * opts.block_size;
     -+		if (off == 0) {
     -+			off = HEADER_SIZE;
     -+		}
     -+		assert(buf->buf[off] == 'r');
     -+	}
     -+
     -+	writer_free(w);
     -+	w = NULL;
     -+}
     -+
     -+void test_log_write_read(void)
     -+{
     -+	int N = 2;
     -+	char **names = calloc(sizeof(char *), N + 1);
     -+
     -+	struct write_options opts = {
     -+		.block_size = 256,
     -+	};
     -+
     -+	struct slice buf = {};
     -+	struct writer *w = new_writer(&slice_write_void, &buf, &opts);
     -+
     -+	writer_set_limits(w, 0, N);
     -+	{
     -+		struct ref_record ref = {};
     -+		int i = 0;
     -+		for (i = 0; i < N; i++) {
     -+			char name[256];
     -+			snprintf(name, sizeof(name), "b%02d%0*d", i, 130, 7);
     -+			names[i] = strdup(name);
     -+			puts(name);
     -+			ref.ref_name = name;
     -+			ref.update_index = i;
     -+
     -+			int err = writer_add_ref(w, &ref);
     -+			assert_err(err);
     -+		}
     -+	}
     -+
     -+	{
     -+		struct log_record log = {};
     -+		int i = 0;
     -+		for (i = 0; i < N; i++) {
     -+			byte hash1[SHA1_SIZE], hash2[SHA1_SIZE];
     -+			set_test_hash(hash1, i);
     -+			set_test_hash(hash2, i + 1);
     -+
     -+			log.ref_name = names[i];
     -+			log.update_index = i;
     -+			log.old_hash = hash1;
     -+			log.new_hash = hash2;
     -+
     -+			int err = writer_add_log(w, &log);
     -+			assert_err(err);
     -+		}
     -+	}
     -+
     -+	int n = writer_close(w);
     -+	assert(n == 0);
     -+
     -+	struct stats *stats = writer_stats(w);
     -+	assert(stats->log_stats.blocks > 0);
     -+	writer_free(w);
     -+	w = NULL;
     -+
     -+	struct block_source source = {};
     -+	block_source_from_slice(&source, &buf);
     -+
     -+	struct reader rd = {};
     -+	int err = init_reader(&rd, source, "file.log");
     -+	assert(err == 0);
     -+
     -+	{
     -+		struct iterator it = {};
     -+		err = reader_seek_ref(&rd, &it, names[N - 1]);
     -+		assert(err == 0);
     -+
     -+		struct ref_record ref = {};
     -+		err = iterator_next_ref(it, &ref);
     -+		assert_err(err);
     -+
     -+		/* end of iteration. */
     -+		err = iterator_next_ref(it, &ref);
     -+		assert(0 < err);
     -+
     -+		iterator_destroy(&it);
     -+		ref_record_clear(&ref);
     -+	}
     -+
     -+	{
     -+		struct iterator it = {};
     -+		err = reader_seek_log(&rd, &it, "");
     -+		assert(err == 0);
     -+
     -+		struct log_record log = {};
     -+		int i = 0;
     -+		while (true) {
     -+			int err = iterator_next_log(it, &log);
     -+			if (err > 0) {
     -+				break;
     -+			}
     -+
     -+			assert_err(err);
     -+			assert_streq(names[i], log.ref_name);
     -+			assert(i == log.update_index);
     -+			i++;
     -+		}
     -+
     -+		assert(i == N);
     -+		iterator_destroy(&it);
     -+	}
     -+
     -+	/* cleanup. */
     -+	free(slice_yield(&buf));
     -+	free_names(names);
     -+	reader_close(&rd);
     -+}
     -+
     -+void test_table_read_write_sequential(void)
     -+{
     -+	char **names;
     -+	struct slice buf = {};
     -+	int N = 50;
     -+	write_table(&names, &buf, N, 256);
     -+
     -+	struct block_source source = {};
     -+	block_source_from_slice(&source, &buf);
     -+
     -+	struct reader rd = {};
     -+	int err = init_reader(&rd, source, "file.ref");
     -+	assert(err == 0);
     -+
     -+	struct iterator it = {};
     -+	err = reader_seek_ref(&rd, &it, "");
     -+	assert(err == 0);
     -+
     -+	int j = 0;
     -+	while (true) {
     -+		struct ref_record ref = {};
     -+		int r = iterator_next_ref(it, &ref);
     -+		assert(r >= 0);
     -+		if (r > 0) {
     -+			break;
     -+		}
     -+		assert(0 == strcmp(names[j], ref.ref_name));
     -+		assert(update_index == ref.update_index);
     -+
     -+		j++;
     -+		ref_record_clear(&ref);
     -+	}
     -+	assert(j == N);
     -+	iterator_destroy(&it);
     -+	free(slice_yield(&buf));
     -+	free_names(names);
     -+
     -+	reader_close(&rd);
     -+}
     -+
     -+void test_table_write_small_table(void)
     -+{
     -+	char **names;
     -+	struct slice buf = {};
     -+	int N = 1;
     -+	write_table(&names, &buf, N, 4096);
     -+	assert(buf.len < 200);
     -+	free(slice_yield(&buf));
     -+	free_names(names);
     -+}
     -+
     -+void test_table_read_api(void)
     -+{
     -+	char **names;
     -+	struct slice buf = {};
     -+	int N = 50;
     -+	write_table(&names, &buf, N, 256);
     -+
     -+	struct reader rd = {};
     -+	struct block_source source = {};
     -+	block_source_from_slice(&source, &buf);
     -+
     -+	int err = init_reader(&rd, source, "file.ref");
     -+	assert(err == 0);
     -+
     -+	struct iterator it = {};
     -+	err = reader_seek_ref(&rd, &it, names[0]);
     -+	assert(err == 0);
     -+
     -+	struct log_record log = {};
     -+	err = iterator_next_log(it, &log);
     -+	assert(err == API_ERROR);
     -+
     -+	free(slice_yield(&buf));
     -+	int i = 0;
     -+	for (i = 0; i < N; i++) {
     -+		free(names[i]);
     -+	}
     -+	free(names);
     -+	reader_close(&rd);
     -+}
     -+
     -+void test_table_read_write_seek(bool index)
     -+{
     -+	char **names;
     -+	struct slice buf = {};
     -+	int N = 50;
     -+	write_table(&names, &buf, N, 256);
     -+
     -+	struct reader rd = {};
     -+	struct block_source source = {};
     -+	block_source_from_slice(&source, &buf);
     -+
     -+	int err = init_reader(&rd, source, "file.ref");
     -+	assert(err == 0);
     -+
     -+	if (!index) {
     -+		rd.ref_offsets.index_offset = 0;
     -+	}
     -+
     -+	int i = 0;
     -+	for (i = 1; i < N; i++) {
     -+		struct iterator it = {};
     -+		int err = reader_seek_ref(&rd, &it, names[i]);
     -+		assert(err == 0);
     -+		struct ref_record ref = {};
     -+		err = iterator_next_ref(it, &ref);
     -+		assert(err == 0);
     -+		assert(0 == strcmp(names[i], ref.ref_name));
     -+		assert(i == ref.value[0]);
     -+
     -+		ref_record_clear(&ref);
     -+		iterator_destroy(&it);
     -+	}
     -+
     -+	free(slice_yield(&buf));
     -+	for (i = 0; i < N; i++) {
     -+		free(names[i]);
     -+	}
     -+	free(names);
     -+	reader_close(&rd);
     -+}
     -+
     -+void test_table_read_write_seek_linear(void)
     -+{
     -+	test_table_read_write_seek(false);
     -+}
     -+
     -+void test_table_read_write_seek_index(void)
     -+{
     -+	test_table_read_write_seek(true);
     -+}
     -+
     -+void test_table_refs_for(bool indexed)
     -+{
     -+	int N = 50;
     -+
     -+	char **want_names = calloc(sizeof(char *), N + 1);
     -+
     -+	int want_names_len = 0;
     -+	byte want_hash[SHA1_SIZE];
     -+	set_test_hash(want_hash, 4);
     -+
     -+	struct write_options opts = {
     -+		.block_size = 256,
     -+	};
     -+
     -+	struct slice buf = {};
     -+	struct writer *w = new_writer(&slice_write_void, &buf, &opts);
     -+	{
     -+		struct ref_record ref = {};
     -+		int i = 0;
     -+		for (i = 0; i < N; i++) {
     -+			byte hash[SHA1_SIZE];
     -+			memset(hash, i, sizeof(hash));
     -+			char fill[51] = {};
     -+			memset(fill, 'x', 50);
     -+			char name[100];
     -+			/* Put the variable part in the start */
     -+			snprintf(name, sizeof(name), "br%02d%s", i, fill);
     -+			name[40] = 0;
     -+			ref.ref_name = name;
     -+
     -+			byte hash1[SHA1_SIZE];
     -+			byte hash2[SHA1_SIZE];
     -+
     -+			set_test_hash(hash1, i / 4);
     -+			set_test_hash(hash2, 3 + i / 4);
     -+			ref.value = hash1;
     -+			ref.target_value = hash2;
     -+
     -+			/* 80 bytes / entry, so 3 entries per block. Yields 17 */
     -+			/* blocks. */
     -+			int n = writer_add_ref(w, &ref);
     -+			assert(n == 0);
     -+
     -+			if (!memcmp(hash1, want_hash, SHA1_SIZE) ||
     -+			    !memcmp(hash2, want_hash, SHA1_SIZE)) {
     -+				want_names[want_names_len++] = strdup(name);
     -+			}
     -+		}
     -+	}
     -+
     -+	int n = writer_close(w);
     -+	assert(n == 0);
     -+
     -+	writer_free(w);
     -+	w = NULL;
     -+
     -+	struct reader rd;
     -+	struct block_source source = {};
     -+	block_source_from_slice(&source, &buf);
     -+
     -+	int err = init_reader(&rd, source, "file.ref");
     -+	assert(err == 0);
     -+	if (!indexed) {
     -+		rd.obj_offsets.present = 0;
     -+	}
     -+
     -+	struct iterator it = {};
     -+	err = reader_seek_ref(&rd, &it, "");
     -+	assert(err == 0);
     -+	iterator_destroy(&it);
     -+
     -+	err = reader_refs_for(&rd, &it, want_hash, SHA1_SIZE);
     -+	assert(err == 0);
     -+
     -+	struct ref_record ref = {};
     -+
     -+	int j = 0;
     -+	while (true) {
     -+		int err = iterator_next_ref(it, &ref);
     -+		assert(err >= 0);
     -+		if (err > 0) {
     -+			break;
     -+		}
     -+
     -+		assert(j < want_names_len);
     -+		assert(0 == strcmp(ref.ref_name, want_names[j]));
     -+		j++;
     -+		ref_record_clear(&ref);
     -+	}
     -+	assert(j == want_names_len);
     -+
     -+	free(slice_yield(&buf));
     -+	free_names(want_names);
     -+	iterator_destroy(&it);
     -+	reader_close(&rd);
     -+}
     -+
     -+void test_table_refs_for_no_index(void)
     -+{
     -+	test_table_refs_for(false);
     -+}
     -+
     -+void test_table_refs_for_obj_index(void)
     -+{
     -+	test_table_refs_for(true);
     -+}
     -+
     -+int main()
     -+{
     -+	add_test_case("test_log_write_read", test_log_write_read);
     -+	add_test_case("test_table_write_small_table",
     -+		      &test_table_write_small_table);
     -+	add_test_case("test_buffer", &test_buffer);
     -+	add_test_case("test_table_read_api", &test_table_read_api);
     -+	add_test_case("test_table_read_write_sequential",
     -+		      &test_table_read_write_sequential);
     -+	add_test_case("test_table_read_write_seek_linear",
     -+		      &test_table_read_write_seek_linear);
     -+	add_test_case("test_table_read_write_seek_index",
     -+		      &test_table_read_write_seek_index);
     -+	add_test_case("test_table_read_write_refs_for_no_index",
     -+		      &test_table_refs_for_no_index);
     -+	add_test_case("test_table_read_write_refs_for_obj_index",
     -+		      &test_table_refs_for_obj_index);
     -+	test_main();
     -+}
     -
       diff --git a/reftable/slice.c b/reftable/slice.c
       new file mode 100644
       --- /dev/null
     @@ -5774,61 +4510,17 @@
      +byte *slice_yield(struct slice *s);
      +void slice_copy(struct slice *dest, struct slice src);
      +void slice_resize(struct slice *s, int l);
     -+int slice_compare(struct slice a, struct slice b);
     -+int slice_write(struct slice *b, byte *data, int sz);
     -+int slice_write_void(void *b, byte *data, int sz);
     -+void slice_append(struct slice *dest, struct slice add);
     -+
     -+struct block_source;
     -+void block_source_from_slice(struct block_source *bs, struct slice *buf);
     -+
     -+struct block_source malloc_block_source(void);
     -+
     -+#endif
     -
     - diff --git a/reftable/slice_test.c b/reftable/slice_test.c
     - new file mode 100644
     - --- /dev/null
     - +++ b/reftable/slice_test.c
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "slice.h"
     -+
     -+#include "system.h"
     -+
     -+#include "basics.h"
     -+#include "record.h"
     -+#include "reftable.h"
     -+#include "test_framework.h"
     -+
     -+void test_slice(void)
     -+{
     -+	struct slice s = {};
     -+	slice_set_string(&s, "abc");
     -+	assert(0 == strcmp("abc", slice_as_string(&s)));
     -+
     -+	struct slice t = {};
     -+	slice_set_string(&t, "pqr");
     ++int slice_compare(struct slice a, struct slice b);
     ++int slice_write(struct slice *b, byte *data, int sz);
     ++int slice_write_void(void *b, byte *data, int sz);
     ++void slice_append(struct slice *dest, struct slice add);
      +
     -+	slice_append(&s, t);
     -+	assert(0 == strcmp("abcpqr", slice_as_string(&s)));
     ++struct block_source;
     ++void block_source_from_slice(struct block_source *bs, struct slice *buf);
      +
     -+	free(slice_yield(&s));
     -+	free(slice_yield(&t));
     -+}
     ++struct block_source malloc_block_source(void);
      +
     -+int main()
     -+{
     -+	add_test_case("test_slice", &test_slice);
     -+	test_main();
     -+}
     ++#endif
      
       diff --git a/reftable/stack.c b/reftable/stack.c
       new file mode 100644
     @@ -5936,10 +4628,8 @@
      +	merged_table_free(st->merged);
      +	st->merged = NULL;
      +
     -+	free(st->list_file);
     -+	st->list_file = NULL;
     -+	free(st->reftable_dir);
     -+	st->reftable_dir = NULL;
     ++	FREE_AND_NULL(st->list_file);
     ++	FREE_AND_NULL(st->reftable_dir);
      +	free(st);
      +}
      +
     @@ -6170,7 +4860,7 @@
      +static void format_name(struct slice *dest, uint64_t min, uint64_t max)
      +{
      +	char buf[100];
     -+	snprintf(buf, sizeof(buf), "%012lx-%012lx", min, max);
     ++	snprintf(buf, sizeof(buf), "%012" PRIxMAX "-%012" PRIxMAX, min, max);
      +	slice_set_string(dest, buf);
      +}
      +
     @@ -6867,293 +5557,6 @@
      +
      +#endif
      
     - diff --git a/reftable/stack_test.c b/reftable/stack_test.c
     - new file mode 100644
     - --- /dev/null
     - +++ b/reftable/stack_test.c
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "stack.h"
     -+
     -+#include "system.h"
     -+
     -+#include "basics.h"
     -+#include "constants.h"
     -+#include "record.h"
     -+#include "reftable.h"
     -+#include "test_framework.h"
     -+
     -+void test_read_file(void)
     -+{
     -+	char fn[256] = "/tmp/stack.test_read_file.XXXXXX";
     -+	int fd = mkstemp(fn);
     -+	assert(fd > 0);
     -+
     -+	char out[1024] = "line1\n\nline2\nline3";
     -+
     -+	int n = write(fd, out, strlen(out));
     -+	assert(n == strlen(out));
     -+	int err = close(fd);
     -+	assert(err >= 0);
     -+
     -+	char **names = NULL;
     -+	err = read_lines(fn, &names);
     -+	assert_err(err);
     -+
     -+	char *want[] = { "line1", "line2", "line3" };
     -+	int i = 0;
     -+	for (i = 0; names[i] != NULL; i++) {
     -+		assert(0 == strcmp(want[i], names[i]));
     -+	}
     -+	free_names(names);
     -+	remove(fn);
     -+}
     -+
     -+void test_parse_names(void)
     -+{
     -+	char buf[] = "line\n";
     -+	char **names = NULL;
     -+	parse_names(buf, strlen(buf), &names);
     -+
     -+	assert(NULL != names[0]);
     -+	assert(0 == strcmp(names[0], "line"));
     -+	assert(NULL == names[1]);
     -+	free_names(names);
     -+}
     -+
     -+void test_names_equal(void)
     -+{
     -+	char *a[] = { "a", "b", "c", NULL };
     -+	char *b[] = { "a", "b", "d", NULL };
     -+	char *c[] = { "a", "b", NULL };
     -+
     -+	assert(names_equal(a, a));
     -+	assert(!names_equal(a, b));
     -+	assert(!names_equal(a, c));
     -+}
     -+
     -+int write_test_ref(struct writer *wr, void *arg)
     -+{
     -+	struct ref_record *ref = arg;
     -+
     -+	writer_set_limits(wr, ref->update_index, ref->update_index);
     -+	int err = writer_add_ref(wr, ref);
     -+
     -+	return err;
     -+}
     -+
     -+int write_test_log(struct writer *wr, void *arg)
     -+{
     -+	struct log_record *log = arg;
     -+
     -+	writer_set_limits(wr, log->update_index, log->update_index);
     -+	int err = writer_add_log(wr, log);
     -+
     -+	return err;
     -+}
     -+
     -+void test_stack_add(void)
     -+{
     -+	int i = 0;
     -+	char dir[256] = "/tmp/stack.test_stack_add.XXXXXX";
     -+	assert(mkdtemp(dir));
     -+	printf("%s\n", dir);
     -+	char fn[256] = "";
     -+	strcat(fn, dir);
     -+	strcat(fn, "/refs");
     -+
     -+	struct write_options cfg = {};
     -+	struct stack *st = NULL;
     -+	int err = new_stack(&st, dir, fn, cfg);
     -+	assert_err(err);
     -+
     -+	struct ref_record refs[2] = {};
     -+	struct log_record logs[2] = {};
     -+	int N = ARRAYSIZE(refs);
     -+	for (i = 0; i < N; i++) {
     -+		char buf[256];
     -+		snprintf(buf, sizeof(buf), "branch%02d", i);
     -+		refs[i].ref_name = strdup(buf);
     -+		refs[i].value = malloc(SHA1_SIZE);
     -+		refs[i].update_index = i + 1;
     -+		set_test_hash(refs[i].value, i);
     -+
     -+		logs[i].ref_name = strdup(buf);
     -+		logs[i].update_index = N + i + 1;
     -+		logs[i].new_hash = malloc(SHA1_SIZE);
     -+		logs[i].email = strdup("identity@invalid");
     -+		set_test_hash(logs[i].new_hash, i);
     -+	}
     -+
     -+	for (i = 0; i < N; i++) {
     -+		int err = stack_add(st, &write_test_ref, &refs[i]);
     -+		assert_err(err);
     -+	}
     -+
     -+	for (i = 0; i < N; i++) {
     -+		int err = stack_add(st, &write_test_log, &logs[i]);
     -+		assert_err(err);
     -+	}
     -+
     -+	err = stack_compact_all(st, NULL);
     -+	assert_err(err);
     -+
     -+	for (i = 0; i < N; i++) {
     -+		struct ref_record dest = {};
     -+		int err = stack_read_ref(st, refs[i].ref_name, &dest);
     -+		assert_err(err);
     -+		assert(ref_record_equal(&dest, refs + i, SHA1_SIZE));
     -+		ref_record_clear(&dest);
     -+	}
     -+
     -+	for (i = 0; i < N; i++) {
     -+		struct log_record dest = {};
     -+		int err = stack_read_log(st, refs[i].ref_name, &dest);
     -+		assert_err(err);
     -+		assert(log_record_equal(&dest, logs + i, SHA1_SIZE));
     -+		log_record_clear(&dest);
     -+	}
     -+
     -+	/* cleanup */
     -+	stack_destroy(st);
     -+	for (i = 0; i < N; i++) {
     -+		ref_record_clear(&refs[i]);
     -+		log_record_clear(&logs[i]);
     -+	}
     -+}
     -+
     -+void test_log2(void)
     -+{
     -+	assert(1 == fastlog2(3));
     -+	assert(2 == fastlog2(4));
     -+	assert(2 == fastlog2(5));
     -+}
     -+
     -+void test_sizes_to_segments(void)
     -+{
     -+	uint64_t sizes[] = { 2, 3, 4, 5, 7, 9 };
     -+	/* .................0  1  2  3  4  5 */
     -+
     -+	int seglen = 0;
     -+	struct segment *segs =
     -+		sizes_to_segments(&seglen, sizes, ARRAYSIZE(sizes));
     -+	assert(segs[2].log == 3);
     -+	assert(segs[2].start == 5);
     -+	assert(segs[2].end == 6);
     -+
     -+	assert(segs[1].log == 2);
     -+	assert(segs[1].start == 2);
     -+	assert(segs[1].end == 5);
     -+	free(segs);
     -+}
     -+
     -+void test_suggest_compaction_segment(void)
     -+{
     -+	{
     -+		uint64_t sizes[] = { 128, 64, 17, 16, 9, 9, 9, 16, 16 };
     -+		/* .................0    1    2  3   4  5  6 */
     -+		struct segment min =
     -+			suggest_compaction_segment(sizes, ARRAYSIZE(sizes));
     -+		assert(min.start == 2);
     -+		assert(min.end == 7);
     -+	}
     -+
     -+	{
     -+		uint64_t sizes[] = { 64, 32, 16, 8, 4, 2 };
     -+		struct segment result =
     -+			suggest_compaction_segment(sizes, ARRAYSIZE(sizes));
     -+		assert(result.start == result.end);
     -+	}
     -+}
     -+
     -+void test_reflog_expire(void)
     -+{
     -+	char dir[256] = "/tmp/stack.test_reflog_expire.XXXXXX";
     -+	assert(mkdtemp(dir));
     -+	printf("%s\n", dir);
     -+	char fn[256] = "";
     -+	strcat(fn, dir);
     -+	strcat(fn, "/refs");
     -+
     -+	struct write_options cfg = {};
     -+	struct stack *st = NULL;
     -+	int err = new_stack(&st, dir, fn, cfg);
     -+	assert_err(err);
     -+
     -+	struct log_record logs[20] = {};
     -+	int N = ARRAYSIZE(logs) - 1;
     -+	int i = 0;
     -+	for (i = 1; i <= N; i++) {
     -+		char buf[256];
     -+		snprintf(buf, sizeof(buf), "branch%02d", i);
     -+
     -+		logs[i].ref_name = strdup(buf);
     -+		logs[i].update_index = i;
     -+		logs[i].time = i;
     -+		logs[i].new_hash = malloc(SHA1_SIZE);
     -+		logs[i].email = strdup("identity@invalid");
     -+		set_test_hash(logs[i].new_hash, i);
     -+	}
     -+
     -+	for (i = 1; i <= N; i++) {
     -+		int err = stack_add(st, &write_test_log, &logs[i]);
     -+		assert_err(err);
     -+	}
     -+
     -+	err = stack_compact_all(st, NULL);
     -+	assert_err(err);
     -+
     -+	struct log_expiry_config expiry = {
     -+		.time = 10,
     -+	};
     -+	err = stack_compact_all(st, &expiry);
     -+	assert_err(err);
     -+
     -+	struct log_record log = {};
     -+	err = stack_read_log(st, logs[9].ref_name, &log);
     -+	assert(err == 1);
     -+
     -+	err = stack_read_log(st, logs[11].ref_name, &log);
     -+	assert_err(err);
     -+
     -+	expiry.min_update_index = 15;
     -+	err = stack_compact_all(st, &expiry);
     -+	assert_err(err);
     -+
     -+	err = stack_read_log(st, logs[14].ref_name, &log);
     -+	assert(err == 1);
     -+
     -+	err = stack_read_log(st, logs[16].ref_name, &log);
     -+	assert_err(err);
     -+
     -+	/* cleanup */
     -+	stack_destroy(st);
     -+	for (i = 0; i < N; i++) {
     -+		log_record_clear(&logs[i]);
     -+	}
     -+}
     -+
     -+int main()
     -+{
     -+	add_test_case("test_reflog_expire", test_reflog_expire);
     -+	add_test_case("test_suggest_compaction_segment",
     -+		      &test_suggest_compaction_segment);
     -+	add_test_case("test_sizes_to_segments", &test_sizes_to_segments);
     -+	add_test_case("test_log2", &test_log2);
     -+	add_test_case("test_parse_names", &test_parse_names);
     -+	add_test_case("test_read_file", &test_read_file);
     -+	add_test_case("test_names_equal", &test_names_equal);
     -+	add_test_case("test_stack_add", &test_stack_add);
     -+	test_main();
     -+}
     -
       diff --git a/reftable/system.h b/reftable/system.h
       new file mode 100644
       --- /dev/null
     @@ -7173,8 +5576,12 @@
      +#include "config.h"
      +
      +#ifndef REFTABLE_STANDALONE
     ++
      +#include "git-compat-util.h"
     ++#include <zlib.h>
     ++
      +#else
     ++
      +#include <assert.h>
      +#include <errno.h>
      +#include <fcntl.h>
     @@ -7191,151 +5598,25 @@
      +#define PRIuMAX "lu"
      +#define PRIdMAX "ld"
      +#define PRIxMAX "lx"
     -+
     -+#endif
     -+
     -+#endif
     -
     - diff --git a/reftable/test_framework.c b/reftable/test_framework.c
     - new file mode 100644
     - --- /dev/null
     - +++ b/reftable/test_framework.c
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "test_framework.h"
     -+
     -+#include "system.h"
     -+
     -+#include "constants.h"
     -+
     -+struct test_case **test_cases;
     -+int test_case_len;
     -+int test_case_cap;
     -+
     -+struct test_case *new_test_case(const char *name, void (*testfunc)())
     -+{
     -+	struct test_case *tc = malloc(sizeof(struct test_case));
     -+	tc->name = name;
     -+	tc->testfunc = testfunc;
     -+	return tc;
     -+}
     -+
     -+struct test_case *add_test_case(const char *name, void (*testfunc)())
     -+{
     -+	struct test_case *tc = new_test_case(name, testfunc);
     -+	if (test_case_len == test_case_cap) {
     -+		test_case_cap = 2 * test_case_cap + 1;
     -+		test_cases = realloc(test_cases,
     -+				     sizeof(struct test_case) * test_case_cap);
     -+	}
     -+
     -+	test_cases[test_case_len++] = tc;
     -+	return tc;
     -+}
     -+
     -+void test_main()
     -+{
     -+	int i = 0;
     -+	for (i = 0; i < test_case_len; i++) {
     -+		printf("case %s\n", test_cases[i]->name);
     -+		test_cases[i]->testfunc();
     -+	}
     -+}
     -+
     -+void set_test_hash(byte *p, int i)
     -+{
     -+	memset(p, (byte)i, SHA1_SIZE);
     -+}
     -+
     -+void print_names(char **a)
     -+{
     -+	if (a == NULL || *a == NULL) {
     -+		puts("[]");
     -+		return;
     -+	}
     -+	puts("[");
     -+	char **p = a;
     -+	while (*p) {
     -+		puts(*p);
     -+		p++;
     -+	}
     -+	puts("]");
     -+}
     -
     - diff --git a/reftable/test_framework.h b/reftable/test_framework.h
     - new file mode 100644
     - --- /dev/null
     - +++ b/reftable/test_framework.h
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#ifndef TEST_FRAMEWORK_H
     -+#define TEST_FRAMEWORK_H
     -+
     -+#include "system.h"
     -+
     -+#include "reftable.h"
     -+
     -+#ifdef NDEBUG
     -+#undef NDEBUG
     -+#endif
     -+
     -+#include "system.h"
     -+
     -+#ifdef assert
     -+#undef assert
     ++#define ARRAY_SIZE(a) sizeof((a)) / sizeof((a)[0])
     ++#define FREE_AND_NULL(x)    \
     ++	do {                \
     ++		free(x);    \
     ++		(x) = NULL; \
     ++	} while (0)
     ++#define QSORT(arr, n, cmp) qsort(arr, n, sizeof(arr[0]), cmp)
     ++#define SWAP(a, b) \
     ++  { \
     ++     char tmp[sizeof(a)]; \
     ++     assert(sizeof(a)==sizeof(b)); \
     ++     memcpy(&tmp[0], &a, sizeof(a)); \
     ++     memcpy(&a, &b, sizeof(a)); \
     ++     memcpy(&b, &tmp[0], sizeof(a)); \
     ++  }
      +#endif
      +
     -+#define assert_err(c)                                                 \
     -+	if (c != 0) {                                                 \
     -+		fflush(stderr);                                       \
     -+		fflush(stdout);                                       \
     -+		fprintf(stderr, "%s: %d: error == %d (%s), want 0\n", \
     -+			__FILE__, __LINE__, c, error_str(c));         \
     -+		abort();                                              \
     -+	}
     -+
     -+#define assert_streq(a, b)                                               \
     -+	if (strcmp(a, b)) {                                              \
     -+		fflush(stderr);                                          \
     -+		fflush(stdout);                                          \
     -+		fprintf(stderr, "%s:%d: %s (%s) != %s (%s)\n", __FILE__, \
     -+			__LINE__, #a, a, #b, b);                         \
     -+		abort();                                                 \
     -+	}
     -+
     -+#define assert(c)                                                          \
     -+	if (!(c)) {                                                        \
     -+		fflush(stderr);                                            \
     -+		fflush(stdout);                                            \
     -+		fprintf(stderr, "%s: %d: failed assertion %s\n", __FILE__, \
     -+			__LINE__, #c);                                     \
     -+		abort();                                                   \
     -+	}
     -+
     -+struct test_case {
     -+	const char *name;
     -+	void (*testfunc)();
     -+};
     -+
     -+struct test_case *new_test_case(const char *name, void (*testfunc)());
     -+struct test_case *add_test_case(const char *name, void (*testfunc)());
     -+void test_main();
     -+
     -+void set_test_hash(byte *p, int i);
     ++int uncompress_return_consumed(Bytef *dest, uLongf *destLen,
     ++			       const Bytef *source, uLong *sourceLen);
      +
      +#endif
      
     @@ -7441,73 +5722,6 @@
      +
      +#endif
      
     - diff --git a/reftable/tree_test.c b/reftable/tree_test.c
     - new file mode 100644
     - --- /dev/null
     - +++ b/reftable/tree_test.c
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "tree.h"
     -+
     -+#include "basics.h"
     -+#include "record.h"
     -+#include "reftable.h"
     -+#include "test_framework.h"
     -+
     -+static int test_compare(const void *a, const void *b)
     -+{
     -+	return a - b;
     -+}
     -+
     -+struct curry {
     -+	void *last;
     -+};
     -+
     -+void check_increasing(void *arg, void *key)
     -+{
     -+	struct curry *c = (struct curry *)arg;
     -+	if (c->last != NULL) {
     -+		assert(test_compare(c->last, key) < 0);
     -+	}
     -+	c->last = key;
     -+}
     -+
     -+void test_tree()
     -+{
     -+	struct tree_node *root = NULL;
     -+
     -+	void *values[11] = {};
     -+	struct tree_node *nodes[11] = {};
     -+	int i = 1;
     -+	do {
     -+		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
     -+		i = (i * 7) % 11;
     -+	} while (i != 1);
     -+
     -+	for (i = 1; i < ARRAYSIZE(nodes); i++) {
     -+		assert(values + i == nodes[i]->key);
     -+		assert(nodes[i] ==
     -+		       tree_search(values + i, &root, &test_compare, 0));
     -+	}
     -+
     -+	struct curry c = {};
     -+	infix_walk(root, check_increasing, &c);
     -+	tree_free(root);
     -+}
     -+
     -+int main()
     -+{
     -+	add_test_case("test_tree", &test_tree);
     -+	test_main();
     -+}
     -
       diff --git a/reftable/writer.c b/reftable/writer.c
       new file mode 100644
       --- /dev/null
     @@ -7764,7 +5978,7 @@
      +{
      +	int err = 0;
      +	int i = 0;
     -+	qsort(refs, n, sizeof(struct ref_record), ref_record_compare_name);
     ++	QSORT(refs, n, ref_record_compare_name);
      +	for (i = 0; err == 0 && i < n; i++) {
      +		err = writer_add_ref(w, &refs[i]);
      +	}
     @@ -7801,7 +6015,7 @@
      +{
      +	int err = 0;
      +	int i = 0;
     -+	qsort(logs, n, sizeof(struct log_record), log_record_compare_key);
     ++	QSORT(logs, n, log_record_compare_key);
      +	for (i = 0; err == 0 && i < n; i++) {
      +		err = writer_add_log(w, &logs[i]);
      +	}
     @@ -7948,8 +6162,7 @@
      +{
      +	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
      +
     -+	free(entry->offsets);
     -+	entry->offsets = NULL;
     ++	FREE_AND_NULL(entry->offsets);
      +	free(slice_yield(&entry->hash));
      +	free(entry);
      +}
     @@ -8053,8 +6266,7 @@
      +		free(slice_yield(&w->index[i].last_key));
      +	}
      +
     -+	free(w->index);
     -+	w->index = NULL;
     ++	FREE_AND_NULL(w->index);
      +	w->index_len = 0;
      +	w->index_cap = 0;
      +}
     @@ -8189,3 +6401,101 @@
      +int writer_finish_public_section(struct writer *w);
      +
      +#endif
     +
     + diff --git a/reftable/zlib-compat.c b/reftable/zlib-compat.c
     + new file mode 100644
     + --- /dev/null
     + +++ b/reftable/zlib-compat.c
     +@@
     ++/* taken from zlib's uncompr.c
     ++
     ++   commit cacf7f1d4e3d44d871b605da3b647f07d718623f
     ++   Author: Mark Adler <madler@alumni.caltech.edu>
     ++   Date:   Sun Jan 15 09:18:46 2017 -0800
     ++
     ++       zlib 1.2.11
     ++
     ++*/
     ++
     ++/*
     ++ * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Adler
     ++ * For conditions of distribution and use, see copyright notice in zlib.h
     ++ */
     ++
     ++#include "system.h"
     ++
     ++/* clang-format off */
     ++
     ++/* ===========================================================================
     ++     Decompresses the source buffer into the destination buffer.  *sourceLen is
     ++   the byte length of the source buffer. Upon entry, *destLen is the total size
     ++   of the destination buffer, which must be large enough to hold the entire
     ++   uncompressed data. (The size of the uncompressed data must have been saved
     ++   previously by the compressor and transmitted to the decompressor by some
     ++   mechanism outside the scope of this compression library.) Upon exit,
     ++   *destLen is the size of the decompressed data and *sourceLen is the number
     ++   of source bytes consumed. Upon return, source + *sourceLen points to the
     ++   first unused input byte.
     ++
     ++     uncompress returns Z_OK if success, Z_MEM_ERROR if there was not enough
     ++   memory, Z_BUF_ERROR if there was not enough room in the output buffer, or
     ++   Z_DATA_ERROR if the input data was corrupted, including if the input data is
     ++   an incomplete zlib stream.
     ++*/
     ++int ZEXPORT uncompress_return_consumed (
     ++    Bytef *dest,
     ++    uLongf *destLen,
     ++    const Bytef *source,
     ++    uLong *sourceLen) {
     ++    z_stream stream;
     ++    int err;
     ++    const uInt max = (uInt)-1;
     ++    uLong len, left;
     ++    Byte buf[1];    /* for detection of incomplete stream when *destLen == 0 */
     ++
     ++    len = *sourceLen;
     ++    if (*destLen) {
     ++        left = *destLen;
     ++        *destLen = 0;
     ++    }
     ++    else {
     ++        left = 1;
     ++        dest = buf;
     ++    }
     ++
     ++    stream.next_in = (z_const Bytef *)source;
     ++    stream.avail_in = 0;
     ++    stream.zalloc = (alloc_func)0;
     ++    stream.zfree = (free_func)0;
     ++    stream.opaque = (voidpf)0;
     ++
     ++    err = inflateInit(&stream);
     ++    if (err != Z_OK) return err;
     ++
     ++    stream.next_out = dest;
     ++    stream.avail_out = 0;
     ++
     ++    do {
     ++        if (stream.avail_out == 0) {
     ++            stream.avail_out = left > (uLong)max ? max : (uInt)left;
     ++            left -= stream.avail_out;
     ++        }
     ++        if (stream.avail_in == 0) {
     ++            stream.avail_in = len > (uLong)max ? max : (uInt)len;
     ++            len -= stream.avail_in;
     ++        }
     ++        err = inflate(&stream, Z_NO_FLUSH);
     ++    } while (err == Z_OK);
     ++
     ++    *sourceLen -= len + stream.avail_in;
     ++    if (dest != buf)
     ++        *destLen = stream.total_out;
     ++    else if (stream.total_out && err == Z_BUF_ERROR)
     ++        left = 1;
     ++
     ++    inflateEnd(&stream);
     ++    return err == Z_STREAM_END ? Z_OK :
     ++           err == Z_NEED_DICT ? Z_DATA_ERROR  :
     ++           err == Z_BUF_ERROR && left + stream.avail_out ? Z_DATA_ERROR :
     ++           err;
     ++}
 5:  721201269d ! 6:  0b2a1a81d6 Reftable support for git-core
     @@ -6,12 +6,14 @@
      
          TODO:
      
     +     * Make CI on gitgitgadget compile.
     +     * Redo interaction between repo config, repo storage version
           * Resolve the design problem with reflog expiry.
           * Resolve spots marked with XXX
      
          Example use:
      
     -      $ ~/vc/git/git init
     +      $ ~/vc/git/git init --reftable
            warning: templates not found in /usr/local/google/home/hanwen/share/git-core/templates
            Initialized empty Git repository in /tmp/qz/.git/
            $ echo q > a
     @@ -36,7 +38,6 @@
            ** LOGS **
            reftable.LogRecord{RefName:"HEAD", UpdateIndex:0x2, New:[]uint8{0x37, 0x3d, 0x96, 0x97, 0x2f, 0xca, 0x9b, 0x63, 0x59, 0x57, 0x40, 0xbb, 0xa3, 0x89, 0x8a, 0x76, 0x27, 0x78, 0xba, 0x20}, Old:[]uint8{0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, Name:"Han-Wen Nienhuys", Email:"hanwen@google.com", Time:0x5e29ef27, TZOffset:100, Message:"commit (initial): x\n"}
      
     -    Change-Id: I225ee6317b7911edf9aa95f43299f6c7c4511914
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       diff --git a/Makefile b/Makefile
     @@ -84,6 +85,7 @@
      +REFTABLE_OBJS += reftable/stack.o
      +REFTABLE_OBJS += reftable/tree.o
      +REFTABLE_OBJS += reftable/writer.o
     ++REFTABLE_OBJS += reftable/zlib-compat.o
      +
      +
       TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
     @@ -106,6 +108,114 @@ $^
       
       Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
      
     + diff --git a/builtin/init-db.c b/builtin/init-db.c
     + --- a/builtin/init-db.c
     + +++ b/builtin/init-db.c
     +@@
     + }
     + 
     + static int create_default_files(const char *template_path,
     +-				const char *original_git_dir)
     ++				const char *original_git_dir, int flags)
     + {
     + 	struct stat st1;
     + 	struct strbuf buf = STRBUF_INIT;
     +@@
     + 	 * Create the default symlink from ".git/HEAD" to the "master"
     + 	 * branch, if it does not exist yet.
     + 	 */
     +-	path = git_path_buf(&buf, "HEAD");
     +-	reinit = (!access(path, R_OK)
     +-		  || readlink(path, junk, sizeof(junk)-1) != -1);
     ++	if (flags & INIT_DB_REFTABLE) {
     ++		reinit = 0; /* XXX - how do we recognize a reinit,
     ++			     * and what should we do? */
     ++	} else {
     ++		path = git_path_buf(&buf, "HEAD");
     ++		reinit = (!access(path, R_OK) ||
     ++			  readlink(path, junk, sizeof(junk) - 1) != -1);
     ++	}
     ++
     + 	if (!reinit) {
     + 		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
     + 			exit(1);
     + 	}
     + 
     + 	/* This forces creation of new config file */
     +-	xsnprintf(repo_version_string, sizeof(repo_version_string),
     +-		  "%d", GIT_REPO_VERSION);
     ++	xsnprintf(repo_version_string, sizeof(repo_version_string), "%d",
     ++		  flags & INIT_DB_REFTABLE ? GIT_REPO_VERSION_READ :
     ++					     GIT_REPO_VERSION);
     + 	git_config_set("core.repositoryformatversion", repo_version_string);
     + 
     + 	/* Check filemode trustability */
     +@@
     + 	 */
     + 	check_repository_format();
     + 
     +-	reinit = create_default_files(template_dir, original_git_dir);
     ++	reinit = create_default_files(template_dir, original_git_dir, flags);
     + 
     + 	create_object_directory();
     + 
     +@@
     + 		git_config_set("receive.denyNonFastforwards", "true");
     + 	}
     + 
     ++	if (flags & INIT_DB_REFTABLE) {
     ++		git_config_set("extensions.refStorage", "reftable");
     ++	}
     ++
     + 	if (!(flags & INIT_DB_QUIET)) {
     + 		int len = strlen(git_dir);
     + 
     +@@
     + 	const char *template_dir = NULL;
     + 	unsigned int flags = 0;
     + 	const struct option init_db_options[] = {
     +-		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
     +-				N_("directory from which templates will be used")),
     ++		OPT_STRING(0, "template", &template_dir,
     ++			   N_("template-directory"),
     ++			   N_("directory from which templates will be used")),
     + 		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
     +-				N_("create a bare repository"), 1),
     ++			    N_("create a bare repository"), 1),
     + 		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
     +-			N_("permissions"),
     +-			N_("specify that the git repository is to be shared amongst several users"),
     +-			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
     ++		  N_("permissions"),
     ++		  N_("specify that the git repository is to be shared amongst several users"),
     ++		  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0 },
     + 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
     ++		OPT_BIT(0, "reftable", &flags, N_("use reftable"),
     ++			INIT_DB_REFTABLE),
     + 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
     + 			   N_("separate git dir from working tree")),
     + 		OPT_END()
     +
     + diff --git a/cache.h b/cache.h
     + --- a/cache.h
     + +++ b/cache.h
     +@@
     + 
     + #define INIT_DB_QUIET 0x0001
     + #define INIT_DB_EXIST_OK 0x0002
     ++#define INIT_DB_REFTABLE 0x0004
     + 
     + int init_db(const char *git_dir, const char *real_git_dir,
     + 	    const char *template_dir, unsigned int flags);
     +@@
     + 	int is_bare;
     + 	int hash_algo;
     + 	char *work_tree;
     ++	char *ref_storage;
     + 	struct string_list unknown_extensions;
     + };
     + 
     +
       diff --git a/refs.c b/refs.c
       --- a/refs.c
       +++ b/refs.c
     @@ -119,43 +229,65 @@ $^
       static struct ref_storage_be *find_ref_storage_backend(const char *name)
       {
      @@
     - static struct ref_store *ref_store_init(const char *gitdir,
     +  * Create, record, and return a ref_store instance for the specified
     +  * gitdir.
     +  */
     +-static struct ref_store *ref_store_init(const char *gitdir,
     ++static struct ref_store *ref_store_init(const char *gitdir, const char *be_name,
       					unsigned int flags)
       {
      -	const char *be_name = "files";
      -	struct ref_storage_be *be = find_ref_storage_backend(be_name);
     -+	struct strbuf refs_path = STRBUF_INIT;
     -+
     -+        /* XXX this should probably come from a git config setting and not
     -+           default to reftable. */
     -+	const char *be_name = "reftable";
      +	struct ref_storage_be *be;
       	struct ref_store *refs;
       
     -+	strbuf_addstr(&refs_path, gitdir);
     -+	strbuf_addstr(&refs_path, "/refs");
     -+
     -+	if (!is_directory(refs_path.buf)) {
     -+		be_name = "reftable";
     -+	}
     -+	strbuf_release(&refs_path);
      +	be = find_ref_storage_backend(be_name);
       	if (!be)
       		BUG("reference backend %s is unknown", be_name);
       
     -
     - diff --git a/refs.h b/refs.h
     - --- a/refs.h
     - +++ b/refs.h
      @@
     - 				     const char *refname,
     - 				     each_reflog_ent_fn fn,
     - 				     void *cb_data);
     -+
     -+/* XXX which ordering are these? Newest or oldest first? */
     - int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
     - int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
     + 	if (!r->gitdir)
     + 		BUG("attempting to get main_ref_store outside of repository");
       
     +-	r->refs = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
     ++	r->refs = ref_store_init(r->gitdir,
     ++				 /* XXX r->ref_storage_format == NULL. Where
     ++				  * should the config file be parsed out? */
     ++				 r->ref_storage_format ? r->ref_storage_format :
     ++							 "reftable",
     ++				 REF_STORE_ALL_CAPS);
     + 	return r->refs;
     + }
     + 
     +@@
     + 		goto done;
     + 
     + 	/* assume that add_submodule_odb() has been called */
     +-	refs = ref_store_init(submodule_sb.buf,
     ++	refs = ref_store_init(submodule_sb.buf, "files", /* XXX */
     + 			      REF_STORE_READ | REF_STORE_ODB);
     + 	register_ref_store_map(&submodule_ref_stores, "submodule",
     + 			       refs, submodule);
     +@@
     + 
     + struct ref_store *get_worktree_ref_store(const struct worktree *wt)
     + {
     ++	const char *format = "files"; /* XXX */
     + 	struct ref_store *refs;
     + 	const char *id;
     + 
     +@@
     + 
     + 	if (wt->id)
     + 		refs = ref_store_init(git_common_path("worktrees/%s", wt->id),
     +-				      REF_STORE_ALL_CAPS);
     ++				      format, REF_STORE_ALL_CAPS);
     + 	else
     +-		refs = ref_store_init(get_git_common_dir(),
     ++		refs = ref_store_init(get_git_common_dir(), format,
     + 				      REF_STORE_ALL_CAPS);
     + 
     + 	if (refs)
      
       diff --git a/refs/refs-internal.h b/refs/refs-internal.h
       --- a/refs/refs-internal.h
     @@ -184,6 +316,11 @@ $^
      +
      +#include "../reftable/reftable.h"
      +
     ++/*
     ++  The reftable v1 spec only supports 20-byte binary SHA1s. A new format version
     ++  will be needed to support SHA256.
     ++ */
     ++
      +extern struct ref_storage_be refs_be_reftable;
      +
      +struct reftable_ref_store {
     @@ -244,16 +381,28 @@ $^
      +	base_ref_store_init(ref_store, &refs_be_reftable);
      +	refs->store_flags = store_flags;
      +
     -+	strbuf_addf(&sb, "%s/refs", path);
     -+	refs->table_list_file = xstrdup(sb.buf);
     -+	strbuf_reset(&sb);
      +	strbuf_addf(&sb, "%s/reftable", path);
      +	refs->reftable_dir = xstrdup(sb.buf);
     -+	strbuf_release(&sb);
     ++	strbuf_reset(&sb);
     ++
     ++	strbuf_addf(&sb, "%s/reftable/tables.list", path);
     ++	refs->table_list_file = xstrdup(sb.buf);
     ++	strbuf_reset(&sb);
     ++
     ++	strbuf_addf(&sb, "%s/refs", path);
     ++	safe_create_dir(sb.buf, 1);
     ++	strbuf_reset(&sb);
     ++
     ++	strbuf_addf(&sb, "%s/HEAD", path);
     ++	write_file(sb.buf, "ref: refs/.invalid");
     ++	strbuf_reset(&sb);
     ++
     ++	strbuf_addf(&sb, "%s/refs/heads", path);
     ++	write_file(sb.buf, "this repository uses the reftable format");
      +
      +	refs->err = new_stack(&refs->stack, refs->reftable_dir,
      +			      refs->table_list_file, cfg);
     -+
     ++	strbuf_release(&sb);
      +	return ref_store;
      +}
      +
     @@ -261,13 +410,13 @@ $^
      +{
      +	struct reftable_ref_store *refs =
      +		(struct reftable_ref_store *)ref_store;
     ++
     ++	safe_create_dir(refs->reftable_dir, 1);
      +	FILE *f = fopen(refs->table_list_file, "a");
      +	if (f == NULL) {
      +		return -1;
      +	}
      +	fclose(f);
     -+
     -+	safe_create_dir(refs->reftable_dir, 1);
      +	return 0;
      +}
      +
     @@ -277,31 +426,33 @@ $^
      +	struct ref_record ref;
      +	struct object_id oid;
      +	struct ref_store *ref_store;
     ++	unsigned int flags;
     ++	int err;
      +	char *prefix;
      +};
      +
      +static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
      +{
     -+	while (1) {
     -+		struct reftable_iterator *ri =
     -+			(struct reftable_iterator *)ref_iterator;
     -+		int err = iterator_next_ref(ri->iter, &ri->ref);
     -+		if (err > 0) {
     -+			return ITER_DONE;
     -+		}
     -+		if (err < 0) {
     -+			return ITER_ERROR;
     ++	struct reftable_iterator *ri = (struct reftable_iterator *)ref_iterator;
     ++	while (ri->err == 0) {
     ++		ri->err = iterator_next_ref(ri->iter, &ri->ref);
     ++		if (ri->err) {
     ++			break;
      +		}
      +
      +		ri->base.refname = ri->ref.ref_name;
      +		if (ri->prefix != NULL &&
      +		    strncmp(ri->prefix, ri->ref.ref_name, strlen(ri->prefix))) {
     -+			return ITER_DONE;
     ++			ri->err = 1;
     ++			break;
      +		}
     ++		if (ri->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
     ++		    ref_type(ri->base.refname) != REF_TYPE_PER_WORKTREE)
     ++			continue;
      +
      +		ri->base.flags = 0;
      +		if (ri->ref.value != NULL) {
     -+			memcpy(ri->oid.hash, ri->ref.value, GIT_SHA1_RAWSZ);
     ++			hashcpy(ri->oid.hash, ri->ref.value);
      +		} else if (ri->ref.target != NULL) {
      +			int out_flags = 0;
      +			const char *resolved = refs_resolve_ref_unsafe(
     @@ -309,14 +460,30 @@ $^
      +				RESOLVE_REF_READING, &ri->oid, &out_flags);
      +			ri->base.flags = out_flags;
      +			if (resolved == NULL &&
     -+			    !(ri->base.flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
     ++			    !(ri->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
      +			    (ri->base.flags & REF_ISBROKEN)) {
      +				continue;
      +			}
      +		}
     ++
      +		ri->base.oid = &ri->oid;
     -+		return ITER_OK;
     ++		if (!(ri->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
     ++		    !ref_resolves_to_object(ri->base.refname, ri->base.oid,
     ++					    ri->base.flags)) {
     ++			continue;
     ++		}
     ++
     ++		break;
     ++	}
     ++
     ++	if (ri->err > 0) {
     ++		return ITER_DONE;
      +	}
     ++	if (ri->err < 0) {
     ++		return ITER_ERROR;
     ++	}
     ++
     ++	return ITER_OK;
      +}
      +
      +static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
     @@ -324,7 +491,7 @@ $^
      +{
      +	struct reftable_iterator *ri = (struct reftable_iterator *)ref_iterator;
      +	if (ri->ref.target_value != NULL) {
     -+		memcpy(peeled->hash, ri->ref.target_value, GIT_SHA1_RAWSZ);
     ++		hashcpy(peeled->hash, ri->ref.target_value);
      +		return 0;
      +	}
      +
     @@ -352,20 +519,15 @@ $^
      +		(struct reftable_ref_store *)ref_store;
      +	struct reftable_iterator *ri = xcalloc(1, sizeof(*ri));
      +	struct merged_table *mt = NULL;
     -+	int err = 0;
     -+	if (refs->err) {
     -+		/* how to propagate errors? */
     -+		return NULL;
     -+	}
      +
      +	mt = stack_merged_table(refs->stack);
     -+
     -+	/* XXX something with flags? */
     -+	err = merged_table_seek_ref(mt, &ri->iter, prefix);
     -+	/* XXX what to do with err? */
     -+	assert(err == 0);
     ++	ri->err = refs->err;
     ++	if (ri->err == 0) {
     ++		ri->err = merged_table_seek_ref(mt, &ri->iter, prefix);
     ++	}
      +	base_ref_iterator_init(&ri->base, &reftable_ref_iterator_vtable, 1);
      +	ri->base.oid = &ri->oid;
     ++	ri->flags = flags;
      +	ri->ref_store = ref_store;
      +	return &ri->base;
      +}
     @@ -387,12 +549,6 @@ $^
      +	return 0;
      +}
      +
     -+static int ref_update_cmp(const void *a, const void *b)
     -+{
     -+	return strcmp(((struct ref_update *)a)->refname,
     -+		      ((struct ref_update *)b)->refname);
     -+}
     -+
      +static int reftable_check_old_oid(struct ref_store *refs, const char *refname,
      +				  struct object_id *want_oid)
      +{
     @@ -411,6 +567,12 @@ $^
      +	return 0;
      +}
      +
     ++static int ref_update_cmp(const void *a, const void *b)
     ++{
     ++	return strcmp(((struct ref_update *)a)->refname,
     ++		      ((struct ref_update *)b)->refname);
     ++}
     ++
      +static int write_transaction_table(struct writer *writer, void *arg)
      +{
      +	struct ref_transaction *transaction = (struct ref_transaction *)arg;
     @@ -418,13 +580,14 @@ $^
      +		(struct reftable_ref_store *)transaction->ref_store;
      +	uint64_t ts = stack_next_update_index(refs->stack);
      +	int err = 0;
     -+	/* XXX - are we allowed to mutate the input data? */
     -+	qsort(transaction->updates, transaction->nr,
     -+	      sizeof(struct ref_update *), ref_update_cmp);
     ++	struct ref_update **sorted =
     ++		malloc(transaction->nr * sizeof(struct ref_update *));
     ++	COPY_ARRAY(sorted, transaction->updates, transaction->nr);
     ++	QSORT(sorted, transaction->nr, ref_update_cmp);
      +	writer_set_limits(writer, ts, ts);
      +
      +	for (int i = 0; i < transaction->nr; i++) {
     -+		struct ref_update *u = transaction->updates[i];
     ++		struct ref_update *u = sorted[i];
      +		if (u->flags & REF_HAVE_OLD) {
      +			err = reftable_check_old_oid(transaction->ref_store,
      +						     u->refname, &u->old_oid);
     @@ -435,11 +598,12 @@ $^
      +	}
      +
      +	for (int i = 0; i < transaction->nr; i++) {
     -+		struct ref_update *u = transaction->updates[i];
     ++		struct ref_update *u = sorted[i];
      +		if (u->flags & REF_HAVE_NEW) {
      +			struct object_id out_oid = {};
      +			int out_flags = 0;
     -+			/* XXX who owns the memory here? */
     ++			/* Memory owned by refs_resolve_ref_unsafe, no need to
     ++			 * free(). */
      +			const char *resolved = refs_resolve_ref_unsafe(
      +				transaction->ref_store, u->refname, 0, &out_oid,
      +				&out_flags);
     @@ -456,7 +620,7 @@ $^
      +	}
      +
      +	for (int i = 0; i < transaction->nr; i++) {
     -+		struct ref_update *u = transaction->updates[i];
     ++		struct ref_update *u = sorted[i];
      +		struct log_record log = {};
      +		fill_log_record(&log);
      +
     @@ -473,6 +637,7 @@ $^
      +		}
      +	}
      +exit:
     ++	free(sorted);
      +	return err;
      +}
      +
     @@ -527,16 +692,21 @@ $^
      +
      +	for (int i = 0; i < arg->refnames->nr; i++) {
      +		struct log_record log = {};
     ++		struct ref_record current = {};
      +		fill_log_record(&log);
      +		log.message = xstrdup(arg->logmsg);
      +		log.new_hash = NULL;
     -+
     -+		/* XXX should lookup old oid. */
      +		log.old_hash = NULL;
      +		log.update_index = ts;
      +		log.ref_name = (char *)arg->refnames->items[i].string;
      +
     ++		if (stack_read_ref(arg->stack, log.ref_name, &current) == 0) {
     ++			log.old_hash = current.value;
     ++		}
      +		err = writer_add_log(writer, &log);
     ++		log.old_hash = NULL;
     ++		ref_record_clear(&current);
     ++
      +		clear_log_record(&log);
      +		if (err < 0) {
      +			return err;
     @@ -564,12 +734,11 @@ $^
      +{
      +	struct reftable_ref_store *refs =
      +		(struct reftable_ref_store *)ref_store;
     -+	/* XXX reflog expiry. */
      +	return stack_compact_all(refs->stack, NULL);
      +}
      +
      +struct write_create_symref_arg {
     -+	struct stack *stack;
     ++	struct reftable_ref_store *refs;
      +	const char *refname;
      +	const char *target;
      +	const char *logmsg;
     @@ -579,7 +748,7 @@ $^
      +{
      +	struct write_create_symref_arg *create =
      +		(struct write_create_symref_arg *)arg;
     -+	uint64_t ts = stack_next_update_index(create->stack);
     ++	uint64_t ts = stack_next_update_index(create->refs->stack);
      +	int err = 0;
      +
      +	struct ref_record ref = {
     @@ -593,8 +762,36 @@ $^
      +		return err;
      +	}
      +
     -+	/* XXX reflog? */
     ++	{
     ++		struct log_record log = {};
     ++		struct object_id new_oid = {};
     ++		struct object_id old_oid = {};
     ++		struct ref_record current = {};
     ++		stack_read_ref(create->refs->stack, create->refname, &current);
     ++
     ++		fill_log_record(&log);
     ++		log.ref_name = current.ref_name;
     ++		if (refs_resolve_ref_unsafe(
     ++			    (struct ref_store *)create->refs, create->refname,
     ++			    RESOLVE_REF_READING, &old_oid, NULL) != NULL) {
     ++			log.old_hash = old_oid.hash;
     ++		}
     ++
     ++		/* XXX should the resolution be done relative or absolute? */
     ++		if (refs_resolve_ref_unsafe((struct ref_store *)create->refs,
     ++					    create->target, RESOLVE_REF_READING,
     ++					    &new_oid, NULL) != NULL) {
     ++			log.new_hash = new_oid.hash;
     ++		}
      +
     ++		if (log.old_hash != NULL || log.new_hash != NULL) {
     ++			writer_add_log(writer, &log);
     ++		}
     ++		log.ref_name = NULL;
     ++		log.old_hash = NULL;
     ++		log.new_hash = NULL;
     ++		clear_log_record(&log);
     ++	}
      +	return 0;
      +}
      +
     @@ -604,7 +801,7 @@ $^
      +{
      +	struct reftable_ref_store *refs =
      +		(struct reftable_ref_store *)ref_store;
     -+	struct write_create_symref_arg arg = { .stack = refs->stack,
     ++	struct write_create_symref_arg arg = { .refs = refs,
      +					       .refname = refname,
      +					       .target = target,
      +					       .logmsg = logmsg };
     @@ -628,7 +825,11 @@ $^
      +		goto exit;
      +	}
      +
     -+	/* XXX should check that dest doesn't exist? */
     ++	/* XXX do ref renames overwrite the target? */
     ++	if (stack_read_ref(arg->stack, arg->newname, &ref) == 0) {
     ++		goto exit;
     ++	}
     ++
      +	free(ref.ref_name);
      +	ref.ref_name = strdup(arg->newname);
      +	writer_set_limits(writer, ts, ts);
     @@ -638,6 +839,7 @@ $^
      +		struct ref_record todo[2] = {};
      +		todo[0].ref_name = (char *)arg->oldname;
      +		todo[0].update_index = ts;
     ++		/* leave todo[0] empty */
      +		todo[1] = ref;
      +		todo[1].update_index = ts;
      +
     @@ -735,8 +937,7 @@ $^
      +
      +		free(ri->last_name);
      +		ri->last_name = xstrdup(ri->log.ref_name);
     -+		/* XXX const? */
     -+		memcpy(&ri->oid.hash, ri->log.new_hash, GIT_SHA1_RAWSZ);
     ++		hashcpy(ri->oid.hash, ri->log.new_hash);
      +		return ITER_OK;
      +	}
      +}
     @@ -808,12 +1009,16 @@ $^
      +		{
      +			struct object_id old_oid = {};
      +			struct object_id new_oid = {};
     ++			const char *full_committer = "";
      +
     -+			memcpy(&old_oid.hash, log.old_hash, GIT_SHA1_RAWSZ);
     -+			memcpy(&new_oid.hash, log.new_hash, GIT_SHA1_RAWSZ);
     ++			hashcpy(old_oid.hash, log.old_hash);
     ++			hashcpy(new_oid.hash, log.new_hash);
      +
     -+			/* XXX committer = email? name? */
     -+			if (fn(&old_oid, &new_oid, log.name, log.time,
     ++			full_committer = fmt_ident(log.name, log.email,
     ++						   WANT_COMMITTER_IDENT,
     ++						   /*date*/ NULL,
     ++						   IDENT_NO_DATE);
     ++			if (fn(&old_oid, &new_oid, full_committer, log.time,
      +			       log.tz_offset, log.message, cb_data)) {
      +				err = -1;
      +				break;
     @@ -844,7 +1049,6 @@ $^
      +	int cap = 0;
      +	int len = 0;
      +
     -+	printf("oldest first\n");
      +	while (err == 0) {
      +		struct log_record log = {};
      +		err = iterator_next_log(it, &log);
     @@ -868,12 +1072,15 @@ $^
      +		struct log_record *log = &logs[i];
      +		struct object_id old_oid = {};
      +		struct object_id new_oid = {};
     ++		const char *full_committer = "";
      +
     -+		memcpy(&old_oid.hash, log->old_hash, GIT_SHA1_RAWSZ);
     -+		memcpy(&new_oid.hash, log->new_hash, GIT_SHA1_RAWSZ);
     ++		hashcpy(old_oid.hash, log->old_hash);
     ++		hashcpy(new_oid.hash, log->new_hash);
      +
     -+		/* XXX committer = email? name? */
     -+		if (!fn(&old_oid, &new_oid, log->name, log->time,
     ++		full_committer = fmt_ident(log->name, log->email,
     ++					   WANT_COMMITTER_IDENT, NULL,
     ++					   IDENT_NO_DATE);
     ++		if (!fn(&old_oid, &new_oid, full_committer, log->time,
      +			log->tz_offset, log->message, cb_data)) {
      +			err = -1;
      +			break;
     @@ -921,18 +1128,11 @@ $^
      +				  reflog_expiry_cleanup_fn cleanup_fn,
      +				  void *policy_cb_data)
      +{
     ++	BUG("per ref reflog expiry is not implemented for reftable backend.");
      +	/*
     -+	  XXX
     -+
     -+	  This doesn't fit with the reftable API. If we are expiring for space
     -+	  reasons, the expiry should be combined with a compaction, and there
     -+	  should be a policy that can be called for all refnames, not for a
     -+	  single ref name.
     -+
     -+	  If this is for cleaning up individual entries, we'll have to write
     -+	  extra data to create tombstones.
     ++	  TODO: should iterate over the reflog, and write tombstones. The
     ++	  tombstones will be removed on compaction.
      +	 */
     -+	return 0;
      +}
      +
      +static int reftable_read_raw_ref(struct ref_store *ref_store,
     @@ -947,13 +1147,13 @@ $^
      +		goto exit;
      +	}
      +	if (ref.target != NULL) {
     ++		/* XXX recurse? */
      +		strbuf_reset(referent);
      +		strbuf_addstr(referent, ref.target);
      +		*type |= REF_ISSYMREF;
      +	} else {
     -+		memcpy(oid->hash, ref.value, GIT_SHA1_RAWSZ);
     ++		hashcpy(oid->hash, ref.value);
      +	}
     -+
      +exit:
      +	ref_record_clear(&ref);
      +	return err;
     @@ -986,3 +1186,58 @@ $^
      +	reftable_delete_reflog,
      +	reftable_reflog_expire
      +};
     +
     + diff --git a/repository.c b/repository.c
     + --- a/repository.c
     + +++ b/repository.c
     +@@
     + 	if (worktree)
     + 		repo_set_worktree(repo, worktree);
     + 
     ++	repo->ref_storage_format = format.ref_storage != NULL ?
     ++					   xstrdup(format.ref_storage) :
     ++					   "files"; /* XXX */
     ++
     + 	clear_repository_format(&format);
     + 	return 0;
     + 
     +
     + diff --git a/repository.h b/repository.h
     + --- a/repository.h
     + +++ b/repository.h
     +@@
     + 	/* The store in which the refs are held. */
     + 	struct ref_store *refs;
     + 
     ++	/* The format to use for the ref database. */
     ++	char *ref_storage_format;
     ++
     + 	/*
     + 	 * Contains path to often used file names.
     + 	 */
     +
     + diff --git a/setup.c b/setup.c
     + --- a/setup.c
     + +++ b/setup.c
     +@@
     + 			if (!value)
     + 				return config_error_nonbool(var);
     + 			data->partial_clone = xstrdup(value);
     +-		} else if (!strcmp(ext, "worktreeconfig"))
     ++		} else if (!strcmp(ext, "worktreeconfig")) {
     + 			data->worktree_config = git_config_bool(var, value);
     +-		else
     ++		} else if (!strcmp(ext, "refStorage")) {
     ++			data->ref_storage = xstrdup(value);
     ++		} else
     + 			string_list_append(&data->unknown_extensions, ext);
     + 	}
     + 
     +@@
     + 	string_list_clear(&format->unknown_extensions, 0);
     + 	free(format->work_tree);
     + 	free(format->partial_clone);
     ++	free(format->ref_storage);
     + 	init_repository_format(format);
     + }
     + 

-- 
gitgitgadget
