Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271BCC4BA0A
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 08:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF38E24653
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 08:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEfNCFWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgBZIt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:49:56 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44982 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgBZItz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 03:49:55 -0500
Received: by mail-ed1-f42.google.com with SMTP id g19so2750126eds.11
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 00:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cqC/B53pMbMMHzmgoi5W0A3xpIjHcGDxi0AZHR06U7A=;
        b=FEfNCFWCRhQt2F5ludfQQ0gxyv/H0/SILeHXaOWC7n9qx29rduX2owkRCwQNJsPCW7
         sgrijpgGNkpprmTsSK9BSvSDHtlHHLuHvSucafwRw6+/32vMCOG5mXCP9d8ZzA7VfZSj
         ykLg269ZqJ6xeN4g4SuTk+/S8yG4Tm67P9ZokwJrovfar+bZPS4uW1dysr7wqHXKhhJj
         Q3gXx8rdCzDDclb/YW+ourNhE4xk3QVRClESN1wFeFZrHDtgJwtFchf44OZgAWmKwM5T
         CaJMB2wSCKu/ouMBC3vkssKzGPxq23Spvt+Ekculft1Ioj8xDr/BxnUKT5sfmSc7QAmc
         dMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cqC/B53pMbMMHzmgoi5W0A3xpIjHcGDxi0AZHR06U7A=;
        b=qwpGzwIJCa9y26e1X0MdvFHnvpgGaFpTV/ujSckQi+IdDc0R5ygsDy7fCR+tBE3U5B
         fxZ7lM0exLkF4/CfiIKDli6UUeyE7IQkeUKTc4kCjck114DHIlGRyUp6EFP8w+3fVGdD
         QVVTUh/ELBwe/psCkj+EQMEv/LhDj8bJ49VxTrwlfwW+GzY/xjnkMvHEuoUZF0m2NP5J
         DqplLN03eZK5MOHGgNa0jkLiZrVrAFsv7p86vw+71deBwzGJDO3Nw6th53+sa2NkngdA
         9uBbtbteYV+VpoDgxRSp7QjZv87RKVyrabZnY6hURk7djIe59q1zciQP8YmzSSqeWGUa
         O1lQ==
X-Gm-Message-State: APjAAAXyXRPs10aAmzCu+v44kUstqFbGfz4kye3eABRyozGlvSWz2ytP
        yuf6Y0m8FZil/2ApnnNBsEfwqKnb
X-Google-Smtp-Source: APXvYqz/cczg0tDuU6LddnifLgD9pTkzuR6zyvQ1I3MuviMJtQ3JixB6K2wrecMLd6l0UvDzSsVOxw==
X-Received: by 2002:a17:906:9603:: with SMTP id s3mr3446527ejx.116.1582706988600;
        Wed, 26 Feb 2020 00:49:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm52736edf.43.2020.02.26.00.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:49:47 -0800 (PST)
Message-Id: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 08:49:40 +0000
Subject: [PATCH v7 0/6] Reftable support git-core
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
   
   
 * what is a good test strategy? Could we have a CI flavor where we flip the
   default to reftable, and see how it fares?
   
   

v7

 * support SHA256 as version 2 of the format.

v8

 * propagate errors to git.
 * discard empty tables in the stack. 
 * one very basic test (t0031.sh)

v9

 * Added spec as technical doc.
 * Use 4-byte hash ID as API. Storage format for SHA256 is still pending
   discussion.

Han-Wen Nienhuys (5):
  refs.h: clarify reflog iteration order
  create .git/refs in files-backend.c
  refs: document how ref_iterator_advance_fn should handle symrefs
  Add reftable library
  Reftable support for git-core

Jonathan Nieder (1):
  reftable: file format documentation

 Documentation/Makefile                        |    1 +
 Documentation/technical/reftable.txt          | 1067 ++++++++++++++++
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   24 +-
 builtin/clone.c                               |    4 +-
 builtin/init-db.c                             |   57 +-
 cache.h                                       |    4 +-
 refs.c                                        |   20 +-
 refs.h                                        |    8 +-
 refs/files-backend.c                          |    6 +
 refs/refs-internal.h                          |    6 +
 refs/reftable-backend.c                       | 1015 +++++++++++++++
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   11 +
 reftable/VERSION                              |    5 +
 reftable/basics.c                             |  160 +++
 reftable/basics.h                             |   30 +
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
 reftable/reader.c                             |  720 +++++++++++
 reftable/reader.h                             |   52 +
 reftable/record.c                             | 1119 +++++++++++++++++
 reftable/record.h                             |   79 ++
 reftable/reftable.h                           |  409 ++++++
 reftable/slice.c                              |  199 +++
 reftable/slice.h                              |   39 +
 reftable/stack.c                              | 1007 +++++++++++++++
 reftable/stack.h                              |   40 +
 reftable/system.h                             |   53 +
 reftable/tree.c                               |   66 +
 reftable/tree.h                               |   24 +
 reftable/update.sh                            |   13 +
 reftable/writer.c                             |  637 ++++++++++
 reftable/writer.h                             |   45 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |   12 +-
 t/t0031-reftable.sh                           |   31 +
 51 files changed, 8547 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/technical/reftable.txt
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
 create mode 100644 reftable/update.sh
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 reftable/zlib-compat.c
 create mode 100755 t/t0031-reftable.sh


base-commit: 51ebf55b9309824346a6589c9f3b130c6f371b8f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v6:

 1:  e4b0773becd = 1:  b1e44bc431e refs.h: clarify reflog iteration order
 2:  c25b6c601dc = 2:  b68488a095e create .git/refs in files-backend.c
 3:  e132e0f4e00 ! 3:  da538ef7421 refs: document how ref_iterator_advance_fn should handle symrefs
     @@ -13,8 +13,8 @@
       
      +/*
      + * backend-specific implementation of ref_iterator_advance.
     -+ * For symrefs, the function should set REF_ISSYMREF, and it should also dereference
     -+ * the symref to provide the OID referent.
     ++ * For symrefs, the function should set REF_ISSYMREF, and it should also
     ++ * dereference the symref to provide the OID referent.
      + */
       typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
       
 -:  ----------- > 4:  aae26814983 reftable: file format documentation
 4:  fe29a9db399 ! 5:  30ed43a4fdb Add reftable library
     @@ -2,19 +2,11 @@
      
          Add reftable library
      
     -    Reftable is a new format for storing the ref database. It provides the
     -    following benefits:
     -
     -     * Simple and fast atomic ref transactions, including multiple refs and reflogs.
     -     * Compact storage of ref data.
     -     * Fast look ups of ref data.
     -     * Case-sensitive ref names on Windows/OSX, regardless of file system
     -     * Eliminates file/directory conflicts in ref names
     +    Reftable is a format for storing the ref database. Its rationale and
     +    specification is in the preceding commit.
      
          Further context and motivation can be found in background reading:
      
     -    * Spec: https://github.com/eclipse/jgit/blob/master/Documentation/technical/reftable.md
     -
          * Original discussion on JGit-dev:  https://www.eclipse.org/lists/jgit-dev/msg03389.html
      
          * First design discussion on git@vger: https://public-inbox.org/git/CAJo=hJtTp2eA3z9wW9cHo-nA7kK40vVThqh6inXpbCcqfdMP9g@mail.gmail.com/
     @@ -80,15 +72,7 @@
      +
      +To update the library, do:
      +
     -+   ((cd reftable-repo && git fetch origin && git checkout origin/master ) ||
     -+    git clone https://github.com/google/reftable reftable-repo) && \
     -+   cp reftable-repo/c/*.[ch] reftable/ && \
     -+   cp reftable-repo/LICENSE reftable/ &&
     -+   git --git-dir reftable-repo/.git show --no-patch origin/master \
     -+    > reftable/VERSION && \
     -+   sed -i~ 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|' reftable/system.h
     -+   rm reftable/*_test.c reftable/test_framework.*
     -+   git add reftable/*.[ch]
     ++   sh reftable/update.sh
      +
      +Bugfixes should be accompanied by a test and applied to upstream project at
      +https://github.com/google/reftable.
     @@ -98,17 +82,11 @@
       --- /dev/null
       +++ b/reftable/VERSION
      @@
     -+commit 42aa04f301a682197f0698867b9771b78ce4fdaf
     ++commit ccce3b3eb763e79b23a3b4677d65ecceb4155ba3
      +Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Mon Feb 17 16:05:22 2020 +0100
     -+
     -+    C: simplify system and config header handling
     -+    
     -+    reftable.h only depends on <stdint.h>
     -+    
     -+    system.h is only included from .c files. The git-core specific code is
     -+    guarded by a #if REFTABLE_IN_GITCORE, which we'll edit with a sed
     -+    script on the git-core side.
     ++Date:   Tue Feb 25 20:42:29 2020 +0100
     ++
     ++    C: rephrase the hash ID API in terms of a uint32_t
      
       diff --git a/reftable/basics.c b/reftable/basics.c
       new file mode 100644
     @@ -127,61 +105,23 @@
      +
      +#include "system.h"
      +
     -+void put_u24(byte *out, uint32_t i)
     ++void put_be24(byte *out, uint32_t i)
      +{
      +	out[0] = (byte)((i >> 16) & 0xff);
      +	out[1] = (byte)((i >> 8) & 0xff);
      +	out[2] = (byte)((i)&0xff);
      +}
      +
     -+uint32_t get_u24(byte *in)
     ++uint32_t get_be24(byte *in)
      +{
      +	return (uint32_t)(in[0]) << 16 | (uint32_t)(in[1]) << 8 |
      +	       (uint32_t)(in[2]);
      +}
      +
     -+void put_u32(byte *out, uint32_t i)
     ++void put_be16(uint8_t *out, uint16_t i)
      +{
     -+	out[0] = (byte)((i >> 24) & 0xff);
     -+	out[1] = (byte)((i >> 16) & 0xff);
     -+	out[2] = (byte)((i >> 8) & 0xff);
     -+	out[3] = (byte)((i)&0xff);
     -+}
     -+
     -+uint32_t get_u32(byte *in)
     -+{
     -+	return (uint32_t)(in[0]) << 24 | (uint32_t)(in[1]) << 16 |
     -+	       (uint32_t)(in[2]) << 8 | (uint32_t)(in[3]);
     -+}
     -+
     -+void put_u64(byte *out, uint64_t v)
     -+{
     -+	int i = 0;
     -+	for (i = sizeof(uint64_t); i--;) {
     -+		out[i] = (byte)(v & 0xff);
     -+		v >>= 8;
     -+	}
     -+}
     -+
     -+uint64_t get_u64(byte *out)
     -+{
     -+	uint64_t v = 0;
     -+	int i = 0;
     -+	for (i = 0; i < sizeof(uint64_t); i++) {
     -+		v = (v << 8) | (byte)(out[i] & 0xff);
     -+	}
     -+	return v;
     -+}
     -+
     -+void put_u16(byte *out, uint16_t i)
     -+{
     -+	out[0] = (byte)((i >> 8) & 0xff);
     -+	out[1] = (byte)((i)&0xff);
     -+}
     -+
     -+uint16_t get_u16(byte *in)
     -+{
     -+	return (uint32_t)(in[0]) << 8 | (uint32_t)(in[1]);
     ++	out[0] = (uint8_t)((i >> 8) & 0xff);
     ++	out[1] = (uint8_t)((i)&0xff);
      +}
      +
      +/*
     @@ -234,7 +174,9 @@
      +int names_length(char **names)
      +{
      +	int len = 0;
     -+	for (char **p = names; *p; p++) {
     ++	char **p = names;
     ++	while (*p) {
     ++		p++;
      +		len++;
      +	}
      +	return len;
     @@ -262,7 +204,7 @@
      +				names = realloc(names,
      +						names_cap * sizeof(char *));
      +			}
     -+			names[names_len++] = strdup(p);
     ++			names[names_len++] = xstrdup(p);
      +		}
      +		p = next + 1;
      +	}
     @@ -335,17 +277,10 @@
      +#define true 1
      +#define false 0
      +
     -+void put_u24(byte *out, uint32_t i);
     -+uint32_t get_u24(byte *in);
     -+
     -+uint64_t get_u64(byte *in);
     -+void put_u64(byte *out, uint64_t i);
     ++void put_be24(byte *out, uint32_t i);
     ++uint32_t get_be24(byte *in);
     ++void put_be16(uint8_t *out, uint16_t i);
      +
     -+void put_u32(byte *out, uint32_t i);
     -+uint32_t get_u32(byte *in);
     -+
     -+void put_u16(byte *out, uint16_t i);
     -+uint16_t get_u16(byte *in);
      +int binsearch(int sz, int (*f)(int k, void *args), void *args);
      +
      +void free_names(char **a);
     @@ -403,7 +338,7 @@
      +   success */
      +int block_writer_add(struct block_writer *w, struct record rec)
      +{
     -+	struct slice empty = {};
     ++	struct slice empty = { 0 };
      +	struct slice last = w->entries % w->restart_interval == 0 ? empty :
      +								    w->last_key;
      +	struct slice out = {
     @@ -414,7 +349,7 @@
      +	struct slice start = out;
      +
      +	bool restart = false;
     -+	struct slice key = {};
     ++	struct slice key = { 0 };
      +	int n = 0;
      +
      +	record_key(rec, &key);
     @@ -480,17 +415,17 @@
      +{
      +	int i = 0;
      +	for (i = 0; i < w->restart_len; i++) {
     -+		put_u24(w->buf + w->next, w->restarts[i]);
     ++		put_be24(w->buf + w->next, w->restarts[i]);
      +		w->next += 3;
      +	}
      +
     -+	put_u16(w->buf + w->next, w->restart_len);
     ++	put_be16(w->buf + w->next, w->restart_len);
      +	w->next += 2;
     -+	put_u24(w->buf + 1 + w->header_off, w->next);
     ++	put_be24(w->buf + 1 + w->header_off, w->next);
      +
      +	if (block_writer_type(w) == BLOCK_TYPE_LOG) {
      +		int block_header_skip = 4 + w->header_off;
     -+		struct slice compressed = {};
     ++		struct slice compressed = { 0 };
      +		int zresult = 0;
      +		uLongf src_len = w->next - block_header_skip;
      +		slice_resize(&compressed, src_len);
     @@ -531,14 +466,14 @@
      +{
      +	uint32_t full_block_size = table_block_size;
      +	byte typ = block->data[header_off];
     -+	uint32_t sz = get_u24(block->data + header_off + 1);
     ++	uint32_t sz = get_be24(block->data + header_off + 1);
      +
      +	if (!is_block_type(typ)) {
      +		return FORMAT_ERROR;
      +	}
      +
      +	if (typ == BLOCK_TYPE_LOG) {
     -+		struct slice uncompressed = {};
     ++		struct slice uncompressed = { 0 };
      +		int block_header_skip = 4 + header_off;
      +		uLongf dst_len = sz - block_header_skip;
      +		uLongf src_len = block->len - block_header_skip;
     @@ -570,7 +505,7 @@
      +	}
      +
      +	{
     -+		uint16_t restart_count = get_u16(block->data + sz - 2);
     ++		uint16_t restart_count = get_be16(block->data + sz - 2);
      +		uint32_t restart_start = sz - 2 - 3 * restart_count;
      +
      +		byte *restart_bytes = block->data + restart_start;
     @@ -593,7 +528,7 @@
      +
      +static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
      +{
     -+	return get_u24(br->restart_bytes + 3 * i);
     ++	return get_be24(br->restart_bytes + 3 * i);
      +}
      +
      +void block_reader_start(struct block_reader *br, struct block_iter *it)
     @@ -604,9 +539,9 @@
      +}
      +
      +struct restart_find_args {
     ++	int error;
      +	struct slice key;
      +	struct block_reader *r;
     -+	int error;
      +};
      +
      +static int restart_key_less(int idx, void *args)
     @@ -620,8 +555,8 @@
      +
      +	/* the restart key is verbatim in the block, so this could avoid the
      +	   alloc for decoding the key */
     -+	struct slice rkey = {};
     -+	struct slice last_key = {};
     ++	struct slice rkey = { 0 };
     ++	struct slice last_key = { 0 };
      +	byte unused_extra;
      +	int n = decode_key(&rkey, &unused_extra, last_key, in);
      +	if (n < 0) {
     @@ -656,7 +591,7 @@
      +			.len = it->br->block_len - it->next_off,
      +		};
      +		struct slice start = in;
     -+		struct slice key = {};
     ++		struct slice key = { 0 };
      +		byte extra;
      +		int n = decode_key(&key, &extra, it->last_key, in);
      +		if (n < 0) {
     @@ -681,7 +616,7 @@
      +
      +int block_reader_first_key(struct block_reader *br, struct slice *key)
      +{
     -+	struct slice empty = {};
     ++	struct slice empty = { 0 };
      +	int off = br->header_off + 4;
      +	struct slice in = {
      +		.buf = br->block.data + off,
     @@ -729,10 +664,10 @@
      +
      +	{
      +		struct record rec = new_record(block_reader_type(br));
     -+		struct slice key = {};
     ++		struct slice key = { 0 };
      +		int result = 0;
      +		int err = 0;
     -+		struct block_iter next = {};
     ++		struct block_iter next = { 0 };
      +		while (true) {
      +			block_iter_copy_from(&next, it);
      +
     @@ -830,9 +765,9 @@
      +};
      +
      +struct block_iter {
     ++	uint32_t next_off;
      +	struct block_reader *br;
      +	struct slice last_key;
     -+	uint32_t next_off;
      +};
      +
      +int block_reader_init(struct block_reader *br, struct block *bl,
     @@ -937,7 +872,7 @@
      +
      +static int dump_table(const char *tablename)
      +{
     -+	struct block_source src = {};
     ++	struct block_source src = { 0 };
      +	int err = block_source_from_file(&src, tablename);
      +	if (err < 0) {
      +		return err;
     @@ -950,13 +885,13 @@
      +	}
      +
      +	{
     -+		struct iterator it = {};
     ++		struct iterator it = { 0 };
      +		err = reader_seek_ref(r, &it, "");
      +		if (err < 0) {
      +			return err;
      +		}
      +
     -+		struct ref_record ref = {};
     ++		struct ref_record ref = { 0 };
      +		while (1) {
      +			err = iterator_next_ref(it, &ref);
      +			if (err > 0) {
     @@ -972,12 +907,12 @@
      +	}
      +
      +	{
     -+		struct iterator it = {};
     ++		struct iterator it = { 0 };
      +		err = reader_seek_log(r, &it, "");
      +		if (err < 0) {
      +			return err;
      +		}
     -+		struct log_record log = {};
     ++		struct log_record log = { 0 };
      +		while (1) {
      +			err = iterator_next_log(it, &log);
      +			if (err > 0) {
     @@ -1001,7 +936,7 @@
      +	while ((opt = getopt(argc, argv, "t:")) != -1) {
      +		switch (opt) {
      +		case 't':
     -+			table = strdup(optarg);
     ++			table = xstrdup(optarg);
      +			break;
      +		case '?':
      +			printf("usage: %s [-table tablefile]\n", argv[0]);
     @@ -1091,7 +1026,7 @@
      +
      +int block_source_from_file(struct block_source *bs, const char *name)
      +{
     -+	struct stat st = {};
     ++	struct stat st = { 0 };
      +	int err = 0;
      +	int fd = open(name, O_RDONLY);
      +	if (fd < 0) {
     @@ -1188,14 +1123,14 @@
      +
      +int iterator_next_ref(struct iterator it, struct ref_record *ref)
      +{
     -+	struct record rec = {};
     ++	struct record rec = { 0 };
      +	record_from_ref(&rec, ref);
      +	return iterator_next(it, rec);
      +}
      +
      +int iterator_next_log(struct iterator it, struct log_record *log)
      +{
     -+	struct record rec = {};
     ++	struct record rec = { 0 };
      +	record_from_log(&rec, log);
      +	return iterator_next(it, rec);
      +}
     @@ -1221,7 +1156,7 @@
      +		}
      +
      +		if (fri->double_check) {
     -+			struct iterator it = {};
     ++			struct iterator it = { 0 };
      +
      +			int err = reader_seek_ref(fri->r, &it, ref->ref_name);
      +			if (err == 0) {
     @@ -1389,9 +1324,9 @@
      +bool iterator_is_null(struct iterator it);
      +
      +struct filtering_ref_iterator {
     ++	bool double_check;
      +	struct reader *r;
      +	struct slice oid;
     -+	bool double_check;
      +	struct iterator it;
      +};
      +
     @@ -1511,7 +1446,7 @@
      +
      +static int merged_iter_next(struct merged_iter *mi, struct record rec)
      +{
     -+	struct slice entry_key = {};
     ++	struct slice entry_key = { 0 };
      +	struct pq_entry entry = merged_iter_pqueue_remove(&mi->pq);
      +	int err = merged_iter_advance_subiter(mi, entry.index);
      +	if (err < 0) {
     @@ -1521,7 +1456,7 @@
      +	record_key(entry.rec, &entry_key);
      +	while (!merged_iter_pqueue_is_empty(mi->pq)) {
      +		struct pq_entry top = merged_iter_pqueue_top(mi->pq);
     -+		struct slice k = {};
     ++		struct slice k = { 0 };
      +		int err = 0, cmp = 0;
      +
      +		record_key(top.rec, &k);
     @@ -1542,7 +1477,7 @@
      +		free(record_yield(&top.rec));
      +	}
      +
     -+	record_copy_from(rec, entry.rec, mi->hash_size);
     ++	record_copy_from(rec, entry.rec, hash_size(mi->hash_id));
      +	record_clear(entry.rec);
      +	free(record_yield(&entry.rec));
      +	free(slice_yield(&entry_key));
     @@ -1572,14 +1507,14 @@
      +}
      +
      +int new_merged_table(struct merged_table **dest, struct reader **stack, int n,
     -+		     int hash_size)
     ++		     uint32_t hash_id)
      +{
      +	uint64_t last_max = 0;
      +	uint64_t first_min = 0;
      +	int i = 0;
      +	for (i = 0; i < n; i++) {
      +		struct reader *r = stack[i];
     -+		if (reader_hash_size(r) != hash_size) {
     ++		if (r->hash_id != hash_id) {
      +			return FORMAT_ERROR;
      +		}
      +		if (i > 0 && last_max >= reader_min_update_index(r)) {
     @@ -1598,7 +1533,7 @@
      +			.stack_len = n,
      +			.min = first_min,
      +			.max = last_max,
     -+			.hash_size = hash_size,
     ++			.hash_id = hash_id,
      +		};
      +
      +		*dest = calloc(sizeof(struct merged_table), 1);
     @@ -1650,7 +1585,7 @@
      +	struct merged_iter merged = {
      +		.stack = iters,
      +		.typ = record_type(rec),
     -+		.hash_size = mt->hash_size,
     ++		.hash_id = mt->hash_id,
      +	};
      +	int n = 0;
      +	int err = 0;
     @@ -1693,7 +1628,7 @@
      +	struct ref_record ref = {
      +		.ref_name = (char *)name,
      +	};
     -+	struct record rec = {};
     ++	struct record rec = { 0 };
      +	record_from_ref(&rec, &ref);
      +	return merged_table_seek_record(mt, it, rec);
      +}
     @@ -1705,7 +1640,7 @@
      +		.ref_name = (char *)name,
      +		.update_index = update_index,
      +	};
     -+	struct record rec = {};
     ++	struct record rec = { 0 };
      +	record_from_log(&rec, &log);
      +	return merged_table_seek_record(mt, it, rec);
      +}
     @@ -1739,7 +1674,7 @@
      +struct merged_table {
      +	struct reader **stack;
      +	int stack_len;
     -+	int hash_size;
     ++	uint32_t hash_id;
      +
      +	uint64_t min;
      +	uint64_t max;
     @@ -1747,7 +1682,7 @@
      +
      +struct merged_iter {
      +	struct iterator *stack;
     -+	int hash_size;
     ++	uint32_t hash_id;
      +	int stack_len;
      +	byte typ;
      +	struct merged_iter_pqueue pq;
     @@ -1776,8 +1711,8 @@
      +
      +int pq_less(struct pq_entry a, struct pq_entry b)
      +{
     -+	struct slice ak = {};
     -+	struct slice bk = {};
     ++	struct slice ak = { 0 };
     ++	struct slice bk = { 0 };
      +	int cmp = 0;
      +	record_key(a.rec, &ak);
      +	record_key(b.rec, &bk);
     @@ -1896,8 +1831,8 @@
      +#include "record.h"
      +
      +struct pq_entry {
     -+	struct record rec;
      +	int index;
     ++	struct record rec;
      +};
      +
      +int pq_less(struct pq_entry a, struct pq_entry b);
     @@ -2005,9 +1940,9 @@
      +	block_source_return_block(r->source, p);
      +}
      +
     -+int reader_hash_size(struct reader *r)
     ++uint32_t reader_hash_id(struct reader *r)
      +{
     -+	return r->hash_size;
     ++	return r->hash_id;
      +}
      +
      +const char *reader_name(struct reader *r)
     @@ -2030,11 +1965,12 @@
      +		goto exit;
      +	}
      +
     -+	r->hash_size = SHA1_SIZE;
     ++	r->hash_id = SHA1_ID;
      +	{
      +		byte version = *f++;
      +		if (version == 2) {
     -+			r->hash_size = SHA256_SIZE;
     ++			/* DO NOT SUBMIT.  Not yet in the standard. */
     ++			r->hash_id = SHA256_ID;
      +			version = 1;
      +		}
      +		if (version != 1) {
     @@ -2043,33 +1979,33 @@
      +		}
      +	}
      +
     -+	r->block_size = get_u24(f);
     ++	r->block_size = get_be24(f);
      +
      +	f += 3;
     -+	r->min_update_index = get_u64(f);
     ++	r->min_update_index = get_be64(f);
      +	f += 8;
     -+	r->max_update_index = get_u64(f);
     ++	r->max_update_index = get_be64(f);
      +	f += 8;
      +
     -+	r->ref_offsets.index_offset = get_u64(f);
     ++	r->ref_offsets.index_offset = get_be64(f);
      +	f += 8;
      +
     -+	r->obj_offsets.offset = get_u64(f);
     ++	r->obj_offsets.offset = get_be64(f);
      +	f += 8;
      +
      +	r->object_id_len = r->obj_offsets.offset & ((1 << 5) - 1);
      +	r->obj_offsets.offset >>= 5;
      +
     -+	r->obj_offsets.index_offset = get_u64(f);
     ++	r->obj_offsets.index_offset = get_be64(f);
      +	f += 8;
     -+	r->log_offsets.offset = get_u64(f);
     ++	r->log_offsets.offset = get_be64(f);
      +	f += 8;
     -+	r->log_offsets.index_offset = get_u64(f);
     ++	r->log_offsets.index_offset = get_be64(f);
      +	f += 8;
      +
      +	{
      +		uint32_t computed_crc = crc32(0, footer, f - footer);
     -+		uint32_t file_crc = get_u32(f);
     ++		uint32_t file_crc = get_be32(f);
      +		f += 4;
      +		if (computed_crc != file_crc) {
      +			err = FORMAT_ERROR;
     @@ -2092,15 +2028,15 @@
      +
      +int init_reader(struct reader *r, struct block_source source, const char *name)
      +{
     -+	struct block footer = {};
     -+	struct block header = {};
     ++	struct block footer = { 0 };
     ++	struct block header = { 0 };
      +	int err = 0;
      +
      +	memset(r, 0, sizeof(struct reader));
      +	r->size = block_source_size(source) - FOOTER_SIZE;
      +	r->source = source;
     -+	r->name = strdup(name);
     -+	r->hash_size = 0;
     ++	r->name = xstrdup(name);
     ++	r->hash_id = 0;
      +
      +	err = block_source_read_block(source, &footer, r->size, FOOTER_SIZE);
      +	if (err != FOOTER_SIZE) {
     @@ -2173,7 +2109,7 @@
      +
      +	*typ = data[0];
      +	if (is_block_type(*typ)) {
     -+		result = get_u24(data + 1);
     ++		result = get_be24(data + 1);
      +	}
      +	return result;
      +}
     @@ -2183,7 +2119,7 @@
      +{
      +	int32_t guess_block_size = r->block_size ? r->block_size :
      +						   DEFAULT_BLOCK_SIZE;
     -+	struct block block = {};
     ++	struct block block = { 0 };
      +	byte block_typ = 0;
      +	int err = 0;
      +	uint32_t header_off = next_off ? 0 : HEADER_SIZE;
     @@ -2217,14 +2153,14 @@
      +	}
      +
      +	return block_reader_init(br, &block, header_off, r->block_size,
     -+				 r->hash_size);
     ++				 hash_size(r->hash_id));
      +}
      +
      +static int table_iter_next_block(struct table_iter *dest,
      +				 struct table_iter *src)
      +{
      +	uint64_t next_block_off = src->block_off + src->bi.br->full_block_size;
     -+	struct block_reader br = {};
     ++	struct block_reader br = { 0 };
      +	int err = 0;
      +
      +	dest->r = src->r;
     @@ -2257,7 +2193,7 @@
      +	}
      +
      +	while (true) {
     -+		struct table_iter next = {};
     ++		struct table_iter next = { 0 };
      +		int err = 0;
      +		if (ti->finished) {
      +			return 1;
     @@ -2307,7 +2243,7 @@
      +static int reader_table_iter_at(struct reader *r, struct table_iter *ti,
      +				uint64_t off, byte typ)
      +{
     -+	struct block_reader br = {};
     ++	struct block_reader br = { 0 };
      +	struct block_reader *brp = NULL;
      +
      +	int err = reader_init_block_reader(r, &br, off, typ);
     @@ -2344,9 +2280,9 @@
      +			      struct record want)
      +{
      +	struct record rec = new_record(record_type(want));
     -+	struct slice want_key = {};
     -+	struct slice got_key = {};
     -+	struct table_iter next = {};
     ++	struct slice want_key = { 0 };
     ++	struct slice got_key = { 0 };
     ++	struct table_iter next = { 0 };
      +	int err = -1;
      +	record_key(want, &want_key);
      +
     @@ -2394,12 +2330,12 @@
      +static int reader_seek_indexed(struct reader *r, struct iterator *it,
      +			       struct record rec)
      +{
     -+	struct index_record want_index = {};
     -+	struct record want_index_rec = {};
     -+	struct index_record index_result = {};
     -+	struct record index_result_rec = {};
     -+	struct table_iter index_iter = {};
     -+	struct table_iter next = {};
     ++	struct index_record want_index = { 0 };
     ++	struct record want_index_rec = { 0 };
     ++	struct index_record index_result = { 0 };
     ++	struct record index_result_rec = { 0 };
     ++	struct table_iter index_iter = { 0 };
     ++	struct table_iter next = { 0 };
      +	int err = 0;
      +
      +	record_key(rec, &want_index.last_key);
     @@ -2461,7 +2397,7 @@
      +{
      +	struct reader_offsets *offs = reader_offsets_for(r, record_type(rec));
      +	uint64_t idx = offs->index_offset;
     -+	struct table_iter ti = {};
     ++	struct table_iter ti = { 0 };
      +	int err = 0;
      +	if (idx > 0) {
      +		return reader_seek_indexed(r, it, rec);
     @@ -2503,7 +2439,7 @@
      +	struct ref_record ref = {
      +		.ref_name = (char *)name,
      +	};
     -+	struct record rec = {};
     ++	struct record rec = { 0 };
      +	record_from_ref(&rec, &ref);
      +	return reader_seek(r, it, rec);
      +}
     @@ -2515,7 +2451,7 @@
      +		.ref_name = (char *)name,
      +		.update_index = update_index,
      +	};
     -+	struct record rec = {};
     ++	struct record rec = { 0 };
      +	record_from_log(&rec, &log);
      +	return reader_seek(r, it, rec);
      +}
     @@ -2557,10 +2493,10 @@
      +		.hash_prefix = oid,
      +		.hash_prefix_len = r->object_id_len,
      +	};
     -+	struct record want_rec = {};
     -+	struct iterator oit = {};
     -+	struct obj_record got = {};
     -+	struct record got_rec = {};
     ++	struct record want_rec = { 0 };
     ++	struct iterator oit = { 0 };
     ++	struct obj_record got = { 0 };
     ++	struct record got_rec = { 0 };
      +	int err = 0;
      +
      +	record_from_obj(&want_rec, &want);
     @@ -2585,7 +2521,8 @@
      +
      +	{
      +		struct indexed_table_ref_iter *itr = NULL;
     -+		err = new_indexed_table_ref_iter(&itr, r, oid, r->hash_size,
     ++		err = new_indexed_table_ref_iter(&itr, r, oid,
     ++						 hash_size(r->hash_id),
      +						 got.offsets, got.offset_len);
      +		if (err < 0) {
      +			record_clear(got_rec);
     @@ -2675,9 +2612,9 @@
      +};
      +
      +struct reader {
     -+	struct block_source source;
      +	char *name;
     -+	int hash_size;
     ++	struct block_source source;
     ++	uint32_t hash_id;
      +	uint64_t size;
      +	uint32_t block_size;
      +	uint64_t min_update_index;
     @@ -2755,7 +2692,7 @@
      +
      +int put_var_int(struct slice dest, uint64_t val)
      +{
     -+	byte buf[10] = {};
     ++	byte buf[10] = { 0 };
      +	int i = 9;
      +	buf[i] = (byte)(val & 0x7f);
      +	i--;
     @@ -2868,11 +2805,11 @@
      +	   fields. */
      +	ref_record_clear(ref);
      +	if (src->ref_name != NULL) {
     -+		ref->ref_name = strdup(src->ref_name);
     ++		ref->ref_name = xstrdup(src->ref_name);
      +	}
      +
      +	if (src->target != NULL) {
     -+		ref->target = strdup(src->target);
     ++		ref->target = xstrdup(src->target);
      +	}
      +
      +	if (src->target_value != NULL) {
     @@ -2910,7 +2847,7 @@
      +
      +void ref_record_print(struct ref_record *ref, int hash_size)
      +{
     -+	char hex[SHA256_SIZE + 1] = {};
     ++	char hex[SHA256_SIZE + 1] = { 0 };
      +
      +	printf("ref{%s(%" PRIu64 ") ", ref->ref_name, ref->update_index);
      +	if (ref->value != NULL) {
     @@ -3066,7 +3003,7 @@
      +		in.len -= hash_size;
      +		break;
      +	case 3: {
     -+		struct slice dest = {};
     ++		struct slice dest = { 0 };
      +		int n = decode_string(&dest, in);
      +		if (n < 0) {
      +			return -1;
     @@ -3302,7 +3239,7 @@
      +
      +void log_record_print(struct log_record *log, int hash_size)
      +{
     -+	char hex[SHA256_SIZE + 1] = {};
     ++	char hex[SHA256_SIZE + 1] = { 0 };
      +
      +	printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n", log->ref_name,
      +	       log->update_index, log->name, log->email, log->time,
     @@ -3326,7 +3263,7 @@
      +	slice_resize(dest, len + 9);
      +	memcpy(dest->buf, rec->ref_name, len + 1);
      +	ts = (~ts) - rec->update_index;
     -+	put_u64(dest->buf + 1 + len, ts);
     ++	put_be64(dest->buf + 1 + len, ts);
      +}
      +
      +static void log_record_copy_from(void *rec, const void *src_rec, int hash_size)
     @@ -3335,10 +3272,10 @@
      +	const struct log_record *src = (const struct log_record *)src_rec;
      +
      +	*dst = *src;
     -+	dst->ref_name = strdup(dst->ref_name);
     -+	dst->email = strdup(dst->email);
     -+	dst->name = strdup(dst->name);
     -+	dst->message = strdup(dst->message);
     ++	dst->ref_name = xstrdup(dst->ref_name);
     ++	dst->email = xstrdup(dst->email);
     ++	dst->name = xstrdup(dst->name);
     ++	dst->message = xstrdup(dst->message);
      +	if (dst->new_hash != NULL) {
      +		dst->new_hash = malloc(hash_size);
      +		memcpy(dst->new_hash, src->new_hash, hash_size);
     @@ -3371,7 +3308,7 @@
      +	return 1;
      +}
      +
     -+static byte zero[SHA256_SIZE] = {};
     ++static byte zero[SHA256_SIZE] = { 0 };
      +
      +static int log_record_encode(const void *rec, struct slice s, int hash_size)
      +{
     @@ -3421,7 +3358,7 @@
      +		return -1;
      +	}
      +
     -+	put_u16(s.buf, r->tz_offset);
     ++	put_be16(s.buf, r->tz_offset);
      +	s.buf += 2;
      +	s.len -= 2;
      +
     @@ -3442,7 +3379,7 @@
      +	struct log_record *r = (struct log_record *)rec;
      +	uint64_t max = 0;
      +	uint64_t ts = 0;
     -+	struct slice dest = {};
     ++	struct slice dest = { 0 };
      +	int n;
      +
      +	if (key.len <= 9 || key.buf[key.len - 9] != 0) {
     @@ -3451,7 +3388,7 @@
      +
      +	r->ref_name = realloc(r->ref_name, key.len - 8);
      +	memcpy(r->ref_name, key.buf, key.len - 8);
     -+	ts = get_u64(key.buf + key.len - 8);
     ++	ts = get_be64(key.buf + key.len - 8);
      +
      +	r->update_index = (~max) - ts;
      +
     @@ -3503,7 +3440,7 @@
      +		goto error;
      +	}
      +
     -+	r->tz_offset = get_u16(in.buf);
     ++	r->tz_offset = get_be16(in.buf);
      +	in.buf += 2;
      +	in.len -= 2;
      +
     @@ -3810,6 +3747,18 @@
      +{
      +	/* XXX */
      +	return false;
     ++}
     ++
     ++int hash_size(uint32_t id)
     ++{
     ++	switch (id) {
     ++	case 0:
     ++	case SHA1_ID:
     ++		return SHA1_SIZE;
     ++	case SHA256_ID:
     ++		return SHA256_SIZE;
     ++	}
     ++	abort();
      +}
      
       diff --git a/reftable/record.h b/reftable/record.h
     @@ -3842,7 +3791,7 @@
      +	void (*clear)(void *rec);
      +};
      +
     -+/* record is a generic wrapper for differnt types of records. */
     ++/* record is a generic wrapper for different types of records. */
      +struct record {
      +	void *data;
      +	struct record_vtable *ops;
     @@ -3863,8 +3812,8 @@
      +	       struct slice in);
      +
      +struct index_record {
     -+	struct slice last_key;
      +	uint64_t offset;
     ++	struct slice last_key;
      +};
      +
      +struct obj_record {
     @@ -3965,9 +3914,10 @@
      +	/* how often to write complete keys in each block. */
      +	int restart_interval;
      +
     -+	/* width of the hash. Should be 20 for SHA1 or 32 for SHA256. Defaults
     -+	 * to SHA1 if unset */
     -+	int hash_size;
     ++	/* 4-byte identifier ("sha1", "s256") of the hash.
     ++	 * Defaults to SHA1 if unset
     ++	 */
     ++	uint32_t hash_id;
      +};
      +
      +/* ref_record holds a ref database entry target_value */
     @@ -4102,6 +4052,9 @@
      +/* Decompression error */
      +#define ZLIB_ERROR -7
      +
     ++/* Wrote a table without blocks. */
     ++#define EMPTY_TABLE_ERROR -8
     ++
      +const char *error_str(int err);
      +
      +/* new_writer creates a new writer */
     @@ -4162,10 +4115,10 @@
      +   struct reader *r = NULL;
      +   int err = new_reader(&r, src, "filename");
      +   if (err < 0) { ... }
     -+   struct iterator it = {};
     ++   struct iterator it  = {0};
      +   err = reader_seek_ref(r, &it, "refs/heads/master");
      +   if (err < 0) { ... }
     -+   struct ref_record ref = {};
     ++   struct ref_record ref  = {0};
      +   while (1) {
      +     err = iterator_next_ref(it, &ref);
      +     if (err > 0) {
     @@ -4181,8 +4134,8 @@
      + */
      +int reader_seek_ref(struct reader *r, struct iterator *it, const char *name);
      +
     -+/* returns the hash size used in this table. */
     -+int reader_hash_size(struct reader *r);
     ++/* returns the hash ID used in this table. */
     ++uint32_t reader_hash_id(struct reader *r);
      +
      +/* seek to logs for the given name, older than update_index. */
      +int reader_seek_log_at(struct reader *r, struct iterator *it, const char *name,
     @@ -4211,10 +4164,10 @@
      +   array.
      +*/
      +int new_merged_table(struct merged_table **dest, struct reader **stack, int n,
     -+		     int hash_size);
     ++		     uint32_t hash_id);
      +
     -+/* returns the hash size used in this merged table. */
     -+int merged_hash_size(struct merged_table *mt);
     ++/* returns the hash id used in this merged table. */
     ++uint32_t merged_hash_id(struct merged_table *mt);
      +
      +/* returns an iterator positioned just before 'name' */
      +int merged_table_seek_ref(struct merged_table *mt, struct iterator *it,
     @@ -4403,7 +4356,7 @@
      +/* return a newly malloced string for this slice */
      +char *slice_to_string(struct slice in)
      +{
     -+	struct slice s = {};
     ++	struct slice s = { 0 };
      +	slice_resize(&s, in.len + 1);
      +	s.buf[in.len] = 0;
      +	memcpy(s.buf, in.buf, in.len);
     @@ -4585,8 +4538,8 @@
      +	struct stack *p = calloc(sizeof(struct stack), 1);
      +	int err = 0;
      +	*dest = NULL;
     -+	p->list_file = strdup(list_file);
     -+	p->reftable_dir = strdup(dir);
     ++	p->list_file = xstrdup(list_file);
     ++	p->reftable_dir = xstrdup(dir);
      +	p->config = config;
      +
      +	err = stack_reload(p);
     @@ -4690,7 +4643,7 @@
      +	int new_tables_len = 0;
      +	struct merged_table *new_merged = NULL;
      +
     -+	struct slice table_path = {};
     ++	struct slice table_path = { 0 };
      +
      +	while (*names) {
      +		struct reader *rd = NULL;
     @@ -4708,7 +4661,7 @@
      +		}
      +
      +		if (rd == NULL) {
     -+			struct block_source src = {};
     ++			struct block_source src = { 0 };
      +			slice_set_string(&table_path, st->reftable_dir);
      +			slice_append_string(&table_path, "/");
      +			slice_append_string(&table_path, name);
     @@ -4730,7 +4683,7 @@
      +
      +	/* success! */
      +	err = new_merged_table(&new_merged, new_tables, new_tables_len,
     -+			       st->config.hash_size);
     ++			       st->config.hash_id);
      +	if (err < 0) {
      +		goto exit;
      +	}
     @@ -4780,7 +4733,7 @@
      +
      +static int stack_reload_maybe_reuse(struct stack *st, bool reuse_open)
      +{
     -+	struct timeval deadline = {};
     ++	struct timeval deadline = { 0 };
      +	int err = gettimeofday(&deadline, NULL);
      +	int64_t delay = 0;
      +	int tries = 0;
     @@ -4792,7 +4745,7 @@
      +	while (true) {
      +		char **names = NULL;
      +		char **names_after = NULL;
     -+		struct timeval now = {};
     ++		struct timeval now = { 0 };
      +		int err = gettimeofday(&now, NULL);
      +		if (err < 0) {
      +			return err;
     @@ -4904,11 +4857,11 @@
      +int stack_try_add(struct stack *st,
      +		  int (*write_table)(struct writer *wr, void *arg), void *arg)
      +{
     -+	struct slice lock_name = {};
     -+	struct slice temp_tab_name = {};
     -+	struct slice tab_name = {};
     -+	struct slice next_name = {};
     -+	struct slice table_list = {};
     ++	struct slice lock_name = { 0 };
     ++	struct slice temp_tab_name = { 0 };
     ++	struct slice tab_name = { 0 };
     ++	struct slice next_name = { 0 };
     ++	struct slice table_list = { 0 };
      +	struct writer *wr = NULL;
      +	int err = 0;
      +	int tab_fd = 0;
     @@ -4962,6 +4915,10 @@
      +	}
      +
      +	err = writer_close(wr);
     ++	if (err == EMPTY_TABLE_ERROR) {
     ++		err = 0;
     ++		goto exit;
     ++	}
      +	if (err < 0) {
      +		goto exit;
      +	}
     @@ -5062,7 +5019,7 @@
      +				struct slice *temp_tab,
      +				struct log_expiry_config *config)
      +{
     -+	struct slice next_name = {};
     ++	struct slice next_name = { 0 };
      +	int tab_fd = -1;
      +	struct writer *wr = NULL;
      +	int err = 0;
     @@ -5113,9 +5070,9 @@
      +		calloc(sizeof(struct reader *), last - first + 1);
      +	struct merged_table *mt = NULL;
      +	int err = 0;
     -+	struct iterator it = {};
     -+	struct ref_record ref = {};
     -+	struct log_record log = {};
     ++	struct iterator it = { 0 };
     ++	struct ref_record ref = { 0 };
     ++	struct log_record log = { 0 };
      +
      +	int i = 0, j = 0;
      +	for (i = first, j = 0; i <= last; i++) {
     @@ -5126,7 +5083,7 @@
      +	writer_set_limits(wr, st->merged->stack[first]->min_update_index,
      +			  st->merged->stack[last]->max_update_index);
      +
     -+	err = new_merged_table(&mt, subtabs, subtabs_len, st->config.hash_size);
     ++	err = new_merged_table(&mt, subtabs, subtabs_len, st->config.hash_id);
      +	if (err < 0) {
      +		free(subtabs);
      +		goto exit;
     @@ -5207,11 +5164,11 @@
      +static int stack_compact_range(struct stack *st, int first, int last,
      +			       struct log_expiry_config *expiry)
      +{
     -+	struct slice temp_tab_name = {};
     -+	struct slice new_table_name = {};
     -+	struct slice lock_file_name = {};
     -+	struct slice ref_list_contents = {};
     -+	struct slice new_table_path = {};
     ++	struct slice temp_tab_name = { 0 };
     ++	struct slice new_table_name = { 0 };
     ++	struct slice lock_file_name = { 0 };
     ++	struct slice ref_list_contents = { 0 };
     ++	struct slice new_table_path = { 0 };
      +	int err = 0;
      +	bool have_lock = false;
      +	int lock_file_fd = 0;
     @@ -5220,6 +5177,7 @@
      +	char **subtable_locks = calloc(sizeof(char *), compact_count + 1);
      +	int i = 0;
      +	int j = 0;
     ++	bool is_empty_table = false;
      +
      +	if (first > last || (expiry == NULL && first == last)) {
      +		err = 0;
     @@ -5248,8 +5206,8 @@
      +	}
      +
      +	for (i = first, j = 0; i <= last; i++) {
     -+		struct slice subtab_name = {};
     -+		struct slice subtab_lock = {};
     ++		struct slice subtab_name = { 0 };
     ++		struct slice subtab_lock = { 0 };
      +		slice_set_string(&subtab_name, st->reftable_dir);
      +		slice_append_string(&subtab_name, "/");
      +		slice_append_string(&subtab_name,
     @@ -5288,6 +5246,12 @@
      +	have_lock = false;
      +
      +	err = stack_compact_locked(st, first, last, &temp_tab_name, expiry);
     ++	/* Compaction + tombstones can create an empty table out of non-empty
     ++	 * tables. */
     ++	is_empty_table = (err == EMPTY_TABLE_ERROR);
     ++	if (is_empty_table) {
     ++		err = 0;
     ++	}
      +	if (err < 0) {
      +		goto exit;
      +	}
     @@ -5313,10 +5277,12 @@
      +
      +	slice_append(&new_table_path, new_table_name);
      +
     -+	err = rename(slice_as_string(&temp_tab_name),
     -+		     slice_as_string(&new_table_path));
     -+	if (err < 0) {
     -+		goto exit;
     ++	if (!is_empty_table) {
     ++		err = rename(slice_as_string(&temp_tab_name),
     ++			     slice_as_string(&new_table_path));
     ++		if (err < 0) {
     ++			goto exit;
     ++		}
      +	}
      +
      +	for (i = 0; i < first; i++) {
     @@ -5324,8 +5290,10 @@
      +				    st->merged->stack[i]->name);
      +		slice_append_string(&ref_list_contents, "\n");
      +	}
     -+	slice_append(&ref_list_contents, new_table_name);
     -+	slice_append_string(&ref_list_contents, "\n");
     ++	if (!is_empty_table) {
     ++		slice_append(&ref_list_contents, new_table_name);
     ++		slice_append_string(&ref_list_contents, "\n");
     ++	}
      +	for (i = last + 1; i < st->merged->stack_len; i++) {
      +		slice_append_string(&ref_list_contents,
      +				    st->merged->stack[i]->name);
     @@ -5351,18 +5319,26 @@
      +	}
      +	have_lock = false;
      +
     -+	for (char **p = delete_on_success; *p; p++) {
     -+		if (strcmp(*p, slice_as_string(&new_table_path))) {
     -+			unlink(*p);
     ++	{
     ++		char **p = delete_on_success;
     ++		while (*p) {
     ++			if (strcmp(*p, slice_as_string(&new_table_path))) {
     ++				unlink(*p);
     ++			}
     ++			p++;
      +		}
      +	}
      +
      +	err = stack_reload_maybe_reuse(st, first < last);
      +exit:
     -+	for (char **p = subtable_locks; *p; p++) {
     -+		unlink(*p);
     -+	}
      +	free_names(delete_on_success);
     ++	{
     ++		char **p = subtable_locks;
     ++		while (*p) {
     ++			unlink(*p);
     ++			p++;
     ++		}
     ++	}
      +	free_names(subtable_locks);
      +	if (lock_file_fd > 0) {
      +		close(lock_file_fd);
     @@ -5413,7 +5389,7 @@
      +{
      +	struct segment *segs = calloc(sizeof(struct segment), n);
      +	int next = 0;
     -+	struct segment cur = {};
     ++	struct segment cur = { 0 };
      +	int i = 0;
      +	for (i = 0; i < n; i++) {
      +		int log = fastlog2(sizes[i]);
     @@ -5501,7 +5477,7 @@
      +int stack_read_ref(struct stack *st, const char *refname,
      +		   struct ref_record *ref)
      +{
     -+	struct iterator it = {};
     ++	struct iterator it = { 0 };
      +	struct merged_table *mt = stack_merged_table(st);
      +	int err = merged_table_seek_ref(mt, &it, refname);
      +	if (err) {
     @@ -5526,7 +5502,7 @@
      +int stack_read_log(struct stack *st, const char *refname,
      +		   struct log_record *log)
      +{
     -+	struct iterator it = {};
     ++	struct iterator it = { 0 };
      +	struct merged_table *mt = stack_merged_table(st);
      +	int err = merged_table_seek_log(mt, &it, refname);
      +	if (err) {
     @@ -5631,31 +5607,25 @@
      +#include <unistd.h>
      +#include <zlib.h>
      +
     -+#define ARRAY_SIZE(a) sizeof((a)) / sizeof((a)[0])
     -+#define FREE_AND_NULL(x)    \
     -+	do {                \
     -+		free(x);    \
     -+		(x) = NULL; \
     -+	} while (0)
     -+#define QSORT(arr, n, cmp) qsort(arr, n, sizeof(arr[0]), cmp)
     -+#define SWAP(a, b)                              \
     -+	{                                       \
     -+		char tmp[sizeof(a)];            \
     -+		assert(sizeof(a) == sizeof(b)); \
     -+		memcpy(&tmp[0], &a, sizeof(a)); \
     -+		memcpy(&a, &b, sizeof(a));      \
     -+		memcpy(&b, &tmp[0], sizeof(a)); \
     -+	}
     ++#include "compat.h"
     ++
      +#endif /* REFTABLE_IN_GITCORE */
      +
     ++#define SHA1_ID 0x73686131
     ++#define SHA256_ID 0x73323536
     ++#define SHA1_SIZE 20
     ++#define SHA256_SIZE 32
     ++
      +typedef uint8_t byte;
      +typedef int bool;
      +
     ++/* This is uncompress2, which is only available in zlib as of 2017.
     ++ *
     ++ * TODO: in git-core, this should fallback to uncompress2 if it is available.
     ++ */
      +int uncompress_return_consumed(Bytef *dest, uLongf *destLen,
      +			       const Bytef *source, uLong *sourceLen);
     -+
     -+#define SHA1_SIZE 20
     -+#define SHA256_SIZE 32
     ++int hash_size(uint32_t id);
      +
      +#endif
      
     @@ -5761,6 +5731,25 @@
      +
      +#endif
      
     + diff --git a/reftable/update.sh b/reftable/update.sh
     + new file mode 100644
     + --- /dev/null
     + +++ b/reftable/update.sh
     +@@
     ++#!/bin/sh
     ++
     ++set -eux
     ++
     ++((cd reftable-repo && git fetch origin && git checkout origin/master ) ||
     ++git clone https://github.com/google/reftable reftable-repo) && \
     ++cp reftable-repo/c/*.[ch] reftable/ && \
     ++cp reftable-repo/LICENSE reftable/ &&
     ++git --git-dir reftable-repo/.git show --no-patch origin/master \
     ++> reftable/VERSION && \
     ++sed -i~ 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|' reftable/system.h
     ++rm reftable/*_test.c reftable/test_framework.* reftable/compat.*
     ++git add reftable/*.[ch]
     +
       diff --git a/reftable/writer.c b/reftable/writer.c
       new file mode 100644
       --- /dev/null
     @@ -5831,8 +5820,8 @@
      +		opts->restart_interval = 16;
      +	}
      +
     -+	if (opts->hash_size == 0) {
     -+		opts->hash_size = SHA1_SIZE;
     ++	if (opts->hash_id == 0) {
     ++		opts->hash_id = SHA1_ID;
      +	}
      +	if (opts->block_size == 0) {
      +		opts->block_size = DEFAULT_BLOCK_SIZE;
     @@ -5842,11 +5831,14 @@
      +static int writer_write_header(struct writer *w, byte *dest)
      +{
      +	memcpy((char *)dest, "REFT", 4);
     -+	dest[4] = (w->hash_size == SHA1_SIZE) ? 1 : 2; /* version */
      +
     -+	put_u24(dest + 5, w->opts.block_size);
     -+	put_u64(dest + 8, w->min_update_index);
     -+	put_u64(dest + 16, w->max_update_index);
     ++	/* DO NOT SUBMIT.  This has not been encoded in the standard yet. */
     ++	dest[4] = (hash_size(w->opts.hash_id) == SHA1_SIZE) ? 1 : 2; /* version
     ++								      */
     ++
     ++	put_be24(dest + 5, w->opts.block_size);
     ++	put_be64(dest + 8, w->min_update_index);
     ++	put_be64(dest + 16, w->max_update_index);
      +	return 24;
      +}
      +
     @@ -5858,7 +5850,8 @@
      +	}
      +
      +	block_writer_init(&w->block_writer_data, typ, w->block,
     -+			  w->opts.block_size, block_start, w->hash_size);
     ++			  w->opts.block_size, block_start,
     ++			  hash_size(w->opts.hash_id));
      +	w->block_writer = &w->block_writer_data;
      +	w->block_writer->restart_interval = w->opts.restart_interval;
      +}
     @@ -5872,7 +5865,6 @@
      +		/* TODO - error return? */
      +		abort();
      +	}
     -+	wp->hash_size = opts->hash_size;
      +	wp->block = calloc(opts->block_size, 1);
      +	wp->write = writer_func;
      +	wp->write_arg = writer_arg;
     @@ -5941,7 +5933,7 @@
      +static int writer_add_record(struct writer *w, struct record rec)
      +{
      +	int result = -1;
     -+	struct slice key = {};
     ++	struct slice key = { 0 };
      +	int err = 0;
      +	record_key(rec, &key);
      +	if (slice_compare(w->last_key, key) >= 0) {
     @@ -5981,7 +5973,7 @@
      +
      +int writer_add_ref(struct writer *w, struct ref_record *ref)
      +{
     -+	struct record rec = {};
     ++	struct record rec = { 0 };
      +	struct ref_record copy = *ref;
      +	int err = 0;
      +
     @@ -6003,7 +5995,7 @@
      +	if (!w->opts.skip_index_objects && ref->value != NULL) {
      +		struct slice h = {
      +			.buf = ref->value,
     -+			.len = w->hash_size,
     ++			.len = hash_size(w->opts.hash_id),
      +		};
      +
      +		writer_index_hash(w, h);
     @@ -6011,7 +6003,7 @@
      +	if (!w->opts.skip_index_objects && ref->target_value != NULL) {
      +		struct slice h = {
      +			.buf = ref->target_value,
     -+			.len = w->hash_size,
     ++			.len = hash_size(w->opts.hash_id),
      +		};
      +		writer_index_hash(w, h);
      +	}
     @@ -6047,7 +6039,7 @@
      +	w->pending_padding = 0;
      +
      +	{
     -+		struct record rec = {};
     ++		struct record rec = { 0 };
      +		int err;
      +		record_from_log(&rec, log);
      +		err = writer_add_record(w, rec);
     @@ -6094,7 +6086,7 @@
      +		w->index_len = 0;
      +		w->index_cap = 0;
      +		for (i = 0; i < idx_len; i++) {
     -+			struct record rec = {};
     ++			struct record rec = { 0 };
      +			record_from_index(&rec, idx + i);
      +			if (block_writer_add(w->block_writer, rec) == 0) {
      +				continue;
     @@ -6172,7 +6164,7 @@
      +		.offsets = entry->offsets,
      +		.offset_len = entry->offset_len,
      +	};
     -+	struct record rec = {};
     ++	struct record rec = { 0 };
      +	if (arg->err < 0) {
      +		goto exit;
      +	}
     @@ -6214,7 +6206,7 @@
      +static int writer_dump_object_index(struct writer *w)
      +{
      +	struct write_record_arg closure = { .w = w };
     -+	struct common_prefix_arg common = {};
     ++	struct common_prefix_arg common = { 0 };
      +	if (w->obj_index_tree != NULL) {
      +		infix_walk(w->obj_index_tree, &update_common, &common);
      +	}
     @@ -6271,39 +6263,43 @@
      +
      +	int err = writer_finish_public_section(w);
      +	if (err != 0) {
     -+		return err;
     ++		goto exit;
      +	}
      +
      +	writer_write_header(w, footer);
      +	p += 24;
     -+	put_u64(p, w->stats.ref_stats.index_offset);
     ++	put_be64(p, w->stats.ref_stats.index_offset);
      +	p += 8;
     -+	put_u64(p, (w->stats.obj_stats.offset) << 5 | w->stats.object_id_len);
     ++	put_be64(p, (w->stats.obj_stats.offset) << 5 | w->stats.object_id_len);
      +	p += 8;
     -+	put_u64(p, w->stats.obj_stats.index_offset);
     ++	put_be64(p, w->stats.obj_stats.index_offset);
      +	p += 8;
      +
     -+	put_u64(p, w->stats.log_stats.offset);
     ++	put_be64(p, w->stats.log_stats.offset);
      +	p += 8;
     -+	put_u64(p, w->stats.log_stats.index_offset);
     ++	put_be64(p, w->stats.log_stats.index_offset);
      +	p += 8;
      +
     -+	put_u32(p, crc32(0, footer, p - footer));
     ++	put_be32(p, crc32(0, footer, p - footer));
      +	p += 4;
      +	w->pending_padding = 0;
      +
     -+	{
     -+		int n = padded_write(w, footer, sizeof(footer), 0);
     -+		if (n < 0) {
     -+			return n;
     -+		}
     ++	err = padded_write(w, footer, sizeof(footer), 0);
     ++	if (err < 0) {
     ++		goto exit;
     ++	}
     ++
     ++	if (w->stats.log_stats.entries + w->stats.ref_stats.entries == 0) {
     ++		err = EMPTY_TABLE_ERROR;
     ++		goto exit;
      +	}
      +
     ++exit:
      +	/* free up memory. */
      +	block_writer_clear(&w->block_writer_data);
      +	writer_clear_index(w);
      +	free(slice_yield(&w->last_key));
     -+	return 0;
     ++	return err;
      +}
      +
      +void writer_clear_index(struct writer *w)
     @@ -6348,7 +6344,7 @@
      +	if (debug) {
      +		fprintf(stderr, "block %c off %" PRIu64 " sz %d (%d)\n", typ,
      +			w->next, raw_bytes,
     -+			get_u24(w->block + w->block_writer->header_off + 1));
     ++			get_be24(w->block + w->block_writer->header_off + 1));
      +	}
      +
      +	if (w->next == 0) {
     @@ -6423,7 +6419,6 @@
      +	int (*write)(void *, byte *, int);
      +	void *write_arg;
      +	int pending_padding;
     -+	int hash_size;
      +	struct slice last_key;
      +
      +	uint64_t next;
 5:  8d95ab52f75 ! 6:  a622d8066c7 Reftable support for git-core
     @@ -9,32 +9,7 @@
           * Resolve spots marked with XXX
           * Test strategy?
      
     -    Example use:
     -
     -      $ ~/vc/git/git init --reftable
     -      warning: templates not found in /usr/local/google/home/hanwen/share/git-core/templates
     -      Initialized empty Git repository in /tmp/qz/.git/
     -      $ echo q > a
     -      $ ~/vc/git/git add a
     -      $ ~/vc/git/git commit -mx
     -      fatal: not a git repository (or any of the parent directories): .git
     -      [master (root-commit) 373d969] x
     -       1 file changed, 1 insertion(+)
     -       create mode 100644 a
     -      $ ~/vc/git/git show-ref
     -      373d96972fca9b63595740bba3898a762778ba20 HEAD
     -      373d96972fca9b63595740bba3898a762778ba20 refs/heads/master
     -      $ ls -l .git/reftable/
     -      total 12
     -      -rw------- 1 hanwen primarygroup  126 Jan 23 20:08 000000000001-000000000001.ref
     -      -rw------- 1 hanwen primarygroup 4277 Jan 23 20:08 000000000002-000000000002.ref
     -      $ go run ~/vc/reftable/cmd/dump.go  -table /tmp/qz/.git/reftable/000000000002-000000000002.ref
     -      ** DEBUG **
     -      name /tmp/qz/.git/reftable/000000000002-000000000002.ref, sz 4209: 'r' reftable.readerOffsets{Present:true, Offset:0x0, IndexOffset:0x0}, 'o' reftable.readerOffsets{Present:false, Offset:0x0, IndexOffset:0x0} 'g' reftable.readerOffsets{Present:true, Offset:0x1000, IndexOffset:0x0}
     -      ** REFS **
     -      reftable.RefRecord{RefName:"refs/heads/master", UpdateIndex:0x2, Value:[]uint8{0x37, 0x3d, 0x96, 0x97, 0x2f, 0xca, 0x9b, 0x63, 0x59, 0x57, 0x40, 0xbb, 0xa3, 0x89, 0x8a, 0x76, 0x27, 0x78, 0xba, 0x20}, TargetValue:[]uint8(nil), Target:""}
     -      ** LOGS **
     -      reftable.LogRecord{RefName:"HEAD", UpdateIndex:0x2, New:[]uint8{0x37, 0x3d, 0x96, 0x97, 0x2f, 0xca, 0x9b, 0x63, 0x59, 0x57, 0x40, 0xbb, 0xa3, 0x89, 0x8a, 0x76, 0x27, 0x78, 0xba, 0x20}, Old:[]uint8{0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, Name:"Han-Wen Nienhuys", Email:"hanwen@google.com", Time:0x5e29ef27, TZOffset:100, Message:"commit (initial): x\n"}
     +    Example use: see t/t0031-reftable.sh
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
          Co-authored-by: Jeff King <peff@peff.net>
     @@ -463,7 +438,7 @@ $^
      +	struct ref_store *ref_store = (struct ref_store *)refs;
      +	struct write_options cfg = {
      +		.block_size = 4096,
     -+		.hash_size = the_hash_algo->rawsz,
     ++		.hash_id = the_hash_algo->format_id,
      +	};
      +	struct strbuf sb = STRBUF_INIT;
      +
     @@ -610,11 +585,13 @@ $^
      +	struct reftable_iterator *ri = xcalloc(1, sizeof(*ri));
      +	struct merged_table *mt = NULL;
      +
     -+	mt = stack_merged_table(refs->stack);
     -+	ri->err = refs->err;
     -+	if (ri->err == 0) {
     ++	if (refs->err < 0) {
     ++		ri->err = refs->err;
     ++	} else {
     ++		mt = stack_merged_table(refs->stack);
      +		ri->err = merged_table_seek_ref(mt, &ri->iter, prefix);
      +	}
     ++
      +	base_ref_iterator_init(&ri->base, &reftable_ref_iterator_vtable, 1);
      +	ri->base.oid = &ri->oid;
      +	ri->flags = flags;
     @@ -739,7 +716,12 @@ $^
      +{
      +	struct reftable_ref_store *refs =
      +		(struct reftable_ref_store *)ref_store;
     -+	int err = stack_add(refs->stack, &write_transaction_table, transaction);
     ++	int err = 0;
     ++	if (refs->err < 0) {
     ++		return refs->err;
     ++	}
     ++
     ++	err = stack_add(refs->stack, &write_transaction_table, transaction);
      +	if (err < 0) {
      +		strbuf_addf(errmsg, "reftable: transaction failure %s",
      +			    error_str(err));
     @@ -819,6 +801,10 @@ $^
      +		.logmsg = msg,
      +		.flags = flags,
      +	};
     ++	if (refs->err < 0) {
     ++		return refs->err;
     ++	}
     ++
      +	return stack_add(refs->stack, &write_delete_refs_table, &arg);
      +}
      +
     @@ -826,6 +812,9 @@ $^
      +{
      +	struct reftable_ref_store *refs =
      +		(struct reftable_ref_store *)ref_store;
     ++	if (refs->err < 0) {
     ++		return refs->err;
     ++	}
      +	return stack_compact_all(refs->stack, NULL);
      +}
      +
     @@ -896,6 +885,9 @@ $^
      +					       .refname = refname,
      +					       .target = target,
      +					       .logmsg = logmsg };
     ++	if (refs->err < 0) {
     ++		return refs->err;
     ++	}
      +	return stack_add(refs->stack, &write_create_symref_table, &arg);
      +}
      +
     @@ -912,6 +904,7 @@ $^
      +	uint64_t ts = stack_next_update_index(arg->stack);
      +	struct ref_record ref = {};
      +	int err = stack_read_ref(arg->stack, arg->oldname, &ref);
     ++
      +	if (err) {
      +		goto exit;
      +	}
     @@ -987,6 +980,10 @@ $^
      +		.newname = newrefname,
      +		.logmsg = logmsg,
      +	};
     ++	if (refs->err < 0) {
     ++		return refs->err;
     ++	}
     ++
      +	return stack_add(refs->stack, &write_rename_table, &arg);
      +}
      +
     @@ -1083,10 +1080,16 @@ $^
      +	struct iterator it = {};
      +	struct reftable_ref_store *refs =
      +		(struct reftable_ref_store *)ref_store;
     -+	struct merged_table *mt = stack_merged_table(refs->stack);
     -+	int err = merged_table_seek_log(mt, &it, refname);
     ++	struct merged_table *mt = NULL;
     ++	int err = 0;
      +	struct log_record log = {};
      +
     ++	if (refs->err < 0) {
     ++		return refs->err;
     ++	}
     ++
     ++	mt = stack_merged_table(refs->stack);
     ++	err = merged_table_seek_log(mt, &it, refname);
      +	while (err == 0) {
      +		err = iterator_next_log(it, &log);
      +		if (err != 0) {
     @@ -1133,12 +1136,17 @@ $^
      +	struct iterator it = {};
      +	struct reftable_ref_store *refs =
      +		(struct reftable_ref_store *)ref_store;
     -+	struct merged_table *mt = stack_merged_table(refs->stack);
     -+	int err = merged_table_seek_log(mt, &it, refname);
     -+
     ++	struct merged_table *mt = NULL;
      +	struct log_record *logs = NULL;
      +	int cap = 0;
      +	int len = 0;
     ++	int err = 0;
     ++
     ++	if (refs->err < 0) {
     ++		return refs->err;
     ++	}
     ++	mt = stack_merged_table(refs->stack);
     ++	err = merged_table_seek_log(mt, &it, refname);
      +
      +	while (err == 0) {
      +		struct log_record log = {};
     @@ -1280,13 +1288,19 @@ $^
      +	*/
      +	struct reftable_ref_store *refs =
      +		(struct reftable_ref_store *)ref_store;
     -+	struct merged_table *mt = stack_merged_table(refs->stack);
     ++	struct merged_table *mt = NULL;
      +	struct reflog_expiry_arg arg = {
      +		.refs = refs,
      +	};
      +	struct log_record log = {};
      +	struct iterator it = {};
     -+	int err = merged_table_seek_log(mt, &it, refname);
     ++	int err = 0;
     ++	if (refs->err < 0) {
     ++		return refs->err;
     ++	}
     ++
     ++	mt = stack_merged_table(refs->stack);
     ++	err = merged_table_seek_log(mt, &it, refname);
      +	if (err < 0) {
      +		return err;
      +	}
     @@ -1326,7 +1340,12 @@ $^
      +	struct reftable_ref_store *refs =
      +		(struct reftable_ref_store *)ref_store;
      +	struct ref_record ref = {};
     -+	int err = stack_read_ref(refs->stack, refname, &ref);
     ++	int err = 0;
     ++	if (refs->err < 0) {
     ++		return refs->err;
     ++	}
     ++
     ++	err = stack_read_ref(refs->stack, refname, &ref);
      +	if (err) {
      +		goto exit;
      +	}
     @@ -1436,3 +1455,40 @@ $^
       	}
       
       	strbuf_release(&dir);
     +
     + diff --git a/t/t0031-reftable.sh b/t/t0031-reftable.sh
     + new file mode 100755
     + --- /dev/null
     + +++ b/t/t0031-reftable.sh
     +@@
     ++#!/bin/sh
     ++#
     ++# Copyright (c) 2020 Google LLC
     ++#
     ++
     ++test_description='reftable basics'
     ++
     ++. ./test-lib.sh
     ++
     ++test_expect_success 'basic operation of reftable storage' '
     ++        git init --ref-storage=reftable repo &&
     ++        cd repo &&
     ++        echo "hello" > world.txt &&
     ++        git add world.txt &&
     ++        git commit -m "first post" &&
     ++        printf "HEAD\nrefs/heads/master\n" > want &&
     ++        git show-ref | cut -f2 -d" " > got &&
     ++        test_cmp got want &&
     ++        for count in $(test_seq 1 10); do
     ++                echo "hello" >> world.txt
     ++                git commit -m "number ${count}" world.txt
     ++        done &&
     ++        git gc &&
     ++        nfiles=$(ls -1 .git/reftable | wc -l | tr -d "[ \t]" ) &&
     ++        test "${nfiles}" = "2" &&
     ++        git reflog refs/heads/master > output &&
     ++        grep "commit (initial): first post" output &&
     ++        grep "commit: number 10" output
     ++'
     ++
     ++test_done

-- 
gitgitgadget
