Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBB8C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 14:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90A4206C0
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 14:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpRAHJrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgD1Ozr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727929AbgD1Ozr (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 10:55:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE878C03C1AB
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 07:55:45 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a7so1239939pju.2
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZQaHg0fZ7c/L4P2Gni5MgwxkTXFHrS2lEeHy9tmtM6A=;
        b=HpRAHJrmQAKVkCVzBq+WIYDk9Lc67y+etWPmQETrmUSWL1UuRLwCHdBYouGz7ewAdA
         +FKHE8xkxqTndafKwVaq/Hdyf1HZzx1D+zEMCdeia7tp34jeJGy4YVe6EEbdqOBeJ7mN
         fD4vrrNQulXD/zqwKcd53Rz2qLlb7NncsdKTH0W8lU1+ZgvTnAkK63iASyujuTrnLCcM
         UxDa1XipcxRYZzhUd0QizQyDQffKYy9qmyij361nlyQyR8nXFQsF8WzizvdmGUoFpp2y
         XWAkueIDSPjBQaANzZpj/SaUyOT8tlUANoCjCQ+y4w/kcSX3fh9oO7iSatTdzg5/neJC
         Wnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZQaHg0fZ7c/L4P2Gni5MgwxkTXFHrS2lEeHy9tmtM6A=;
        b=UASEj70XV3EsusIhD8VkdiW0ckJT4ILFyEc6Iv73p1C7GXSckjEdtg37IEzBCEh8J7
         YyxSwMJPlMolA9NyxIV1YmIno6UN5kqx7xMuTJ99GoZmkR9SqfVY4eFN3mDWbmgB84i7
         ZJJtT51UYefgrcEDhYjyuUYHPBZx7oHzCCAzvEv5Gd/jpSgBeORZ80kvuDxX69xErEMl
         yP+agbtOVj99/dMmLrYXAfHBn59hzs2SQ8UQIh3nWYjSUHhjRlTQzwphU6uJi3w8fnhr
         dUYqF1B6WU+8a3BAVLUkWpk+w/WPN6tw+8k+odQ0H1edFNj9caC07YJCAw7HPz9YUoNP
         POAw==
X-Gm-Message-State: AGi0PuYBjgO61APwz+IMx3Mi6VAcGpLkCNclaHTVIvbtXD5JAf+O5uAj
        hBZ2E9q6SSkvulAoTnCjWQgEijzx
X-Google-Smtp-Source: APiQypIoeuLp2rVonRKneasWpTDSGGS6NWyn0fGXtk+Xydz1JFqm66voNoVDXuXDYjS9Dnh5VY68Mg==
X-Received: by 2002:a17:90b:3598:: with SMTP id mm24mr6020836pjb.132.1588085743765;
        Tue, 28 Apr 2020 07:55:43 -0700 (PDT)
Received: from localhost ([2402:800:6374:bf12:8518:c5e6:e4cc:3967])
        by smtp.gmail.com with ESMTPSA id y26sm14693952pfn.185.2020.04.28.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 07:55:43 -0700 (PDT)
Date:   Tue, 28 Apr 2020 21:55:41 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v10 09/12] Add reftable library
Message-ID: <20200428145541.GC31366@danh.dev>
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
 <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
 <59209a5ad39326cf88966715312922f08f149942.1588018418.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59209a5ad39326cf88966715312922f08f149942.1588018418.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-27 20:13:35+0000, Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com> wrote:
[..snip..]
> diff --git a/reftable/LICENSE b/reftable/LICENSE
> new file mode 100644
> index 00000000000..402e0f9356b
> --- /dev/null
> +++ b/reftable/LICENSE
> @@ -0,0 +1,31 @@
> +BSD License
> +
> +Copyright (c) 2020, Google LLC
> +All rights reserved.

Linking against GPLv2 code will make this code GPLv2, right?

> --- /dev/null
> +++ b/reftable/README.md
> @@ -0,0 +1,11 @@
> +
> +The source code in this directory comes from https://github.com/google/reftable.
> +
> +The VERSION file keeps track of the current version of the reftable library.
> +
> +To update the library, do:
> +
> +   sh reftable/update.sh

I agree with Dscho, we should do a git-subtree merge instead.

[..snip..]
> +#include "system.h"
> +
> +void put_be24(byte *out, uint32_t i)

So, we introduce a new type `byte`?

> +{
> +	out[0] = (byte)((i >> 16) & 0xff);
> +	out[1] = (byte)((i >> 8) & 0xff);
> +	out[2] = (byte)((i)&0xff);

At my first glance, I thought that code is:

	out[2] = (byte)( (i)(&0xff) )

It's totally un-parsable.

Anyway, we're gonna accept "expand tab to 4 spaces" in Git, now?

> +}
> +
> +uint32_t get_be24(byte *in)
> +{
> +	return (uint32_t)(in[0]) << 16 | (uint32_t)(in[1]) << 8 |
> +	       (uint32_t)(in[2]);

I don't think we need this much cast. One cast can rule them all.

> +}
> +
> +void put_be16(uint8_t *out, uint16_t i)
> +{
> +	out[0] = (uint8_t)((i >> 8) & 0xff);
> +	out[1] = (uint8_t)((i)&0xff);

This is un-parsable, see above.

> +}
> +
> +int binsearch(int sz, int (*f)(int k, void *args), void *args)

binary search?

I think we want all size to be `size_t`

> +{
> +	int lo = 0;
> +	int hi = sz;
> +
> +	/* invariant: (hi == sz) || f(hi) == true
> +	   (lo == 0 && f(0) == true) || fi(lo) == false
> +	 */

Comment style

> +	while (hi - lo > 1) {
> +		int mid = lo + (hi - lo) / 2;
> +
> +		int val = f(mid, args);
> +		if (val) {
> +			hi = mid;

But this line of code makes me think this function is binary partition
instead.

> +		} else {
> +			lo = mid;
> +		}

bracket style

> +	}
> +

[..snip..]

> diff --git a/reftable/basics.h b/reftable/basics.h
> new file mode 100644
> index 00000000000..6d89eb5d931
> --- /dev/null
> +++ b/reftable/basics.h
> @@ -0,0 +1,53 @@
[..snip..]
> +  find smallest index i in [0, sz) at which f(i) is true, assuming
> +  that f is ascending. Return sz if f(i) is false for all indices.
> +*/

So, this is about partitioning, not searching

> +int binsearch(int sz, int (*f)(int k, void *args), void *args);
> +
> +int block_writer_add(struct block_writer *w, struct record rec)

So, we're gonna pass a large structure into a function now?

> +{
> +	struct slice empty = { 0 };
> +	struct slice last = w->entries % w->restart_interval == 0 ? empty :
> +								    w->last_key;
> +	struct slice out = {
> +		.buf = w->buf + w->next,
> +		.len = w->block_size - w->next,
> +	};
> +
> +	struct slice start = out;
> +
> +	bool restart = false;

Do we want new type: bool?

> +	struct slice key = { 0 };
> +	int n = 0;
> +
> +	record_key(rec, &key);
> +	n = encode_key(&restart, out, last, key, record_val_type(rec));
> +	if (n < 0) {
> +		goto err;
> +	}
> +	slice_consume(&out, n);
> +
> +	n = record_encode(rec, out, w->hash_size);
> +	if (n < 0) {
> +		goto err;
> +	}
> +	slice_consume(&out, n);
> +
> +	if (block_writer_register_restart(w, start.len - out.len, restart,
> +					  key) < 0) {

Eh, naming is hard, and so does this function. It's overly verbose,
and long. I haven't go though all of this patch (because it's too
long), but I guess some of them can be made static and their name can
be shortened.

> +		goto err;
> +	}
> +
> +	slice_clear(&key);
> +	return 0;
> +
> +err:
> +	slice_clear(&key);
> +	return -1;
> +}

[..snip..]
> +		block_source_return_block(block->source, block);
> +		block->data = uncompressed.buf;
> +		block->len = dst_len; /* XXX: 4 bytes missing? */

Even this is a very lengthy patch, some bytes is missing but we
couldn't figured out.

> +		block->source = malloc_block_source();
> +		full_block_size = src_len + block_header_skip;
> +	} else if (full_block_size == 0) {
> +		full_block_size = sz;
> +	} else if (sz < full_block_size && sz < block->len &&
> +		   block->data[sz] != 0) {
> +		/* If the block is smaller than the full block size, it is
> +		   padded (data followed by '\0') or the next block is
> +		   unaligned. */
> +		full_block_size = sz;
> +	}
> +
> +	{

This cute curly braces is new to me

> +		uint16_t restart_count = get_be16(block->data + sz - 2);
> +		uint32_t restart_start = sz - 2 - 3 * restart_count;
> +
> +		byte *restart_bytes = block->data + restart_start;
> +
> +		/* transfer ownership. */
> +		br->block = *block;
> +		block->data = NULL;
> +		block->len = 0;
> +
> +		br->hash_size = hash_size;
> +		br->block_len = restart_start;
> +		br->full_block_size = full_block_size;
> +		br->header_off = header_off;
> +		br->restart_count = restart_count;
> +		br->restart_bytes = restart_bytes;
> +	}
> +
> +	return 0;
> +}
> +
> +static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
> +{
> +	return get_be24(br->restart_bytes + 3 * i);
> +}
> +
> +void block_reader_start(struct block_reader *br, struct block_iter *it)
> +{
> +	it->br = br;
> +	slice_resize(&it->last_key, 0);
> +	it->next_off = br->header_off + 4;
> +}
> +
> +struct restart_find_args {
> +	int error;
> +	struct slice key;
> +	struct block_reader *r;
> +};

I would like to see all structure declaration at top of file.

> +
> +static int restart_key_less(int idx, void *args)

idx? index? Shouldn't it be size_t?

> +{
> +	struct restart_find_args *a = (struct restart_find_args *)args;
> +	uint32_t off = block_reader_restart_offset(a->r, idx);
> +	struct slice in = {
> +		.buf = a->r->block.data + off,
> +		.len = a->r->block_len - off,

C99 designated initialisation.
We aren't ready, yet.

> +void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
> +{
> +	dest->br = src->br;
> +	dest->next_off = src->next_off;
> +	slice_copy(&dest->last_key, src->last_key);
> +}
> +
> +/* return < 0 for error, 0 for OK, > 0 for EOF. */
> +int block_iter_next(struct block_iter *it, struct record rec)

If this function is used only in this file, it should be static,
otherwise, the comment should go to header file

> diff --git a/reftable/block.h b/reftable/block.h
> new file mode 100644
> index 00000000000..62b2e0fec6d
> +/*
> +  Writes reftable blocks. The block_writer is reused across blocks to minimize
> +  allocation overhead.
> +*/
> +struct block_writer {
> +	byte *buf;
> +	uint32_t block_size;

I suppose this means 2^32 block should be enough for everyone?

> diff --git a/reftable/bytes.c b/reftable/bytes.c
> new file mode 100644
> index 00000000000..e69de29bb2d

Empty?

> diff --git a/reftable/config.h b/reftable/config.h
> new file mode 100644
> index 00000000000..40a8c178f10
> --- /dev/null
> +++ b/reftable/config.h
> @@ -0,0 +1 @@
> +/* empty */

Empty?

> diff --git a/reftable/dump.c b/reftable/dump.c
> new file mode 100644
> index 00000000000..c0065792a4f
> --- /dev/null
> +++ b/reftable/dump.c
> @@ -0,0 +1,97 @@
> +/*
> +Copyright 2020 Google LLC
> +
> +Use of this source code is governed by a BSD-style
> +license that can be found in the LICENSE file or at
> +https://developers.google.com/open-source/licenses/bsd
> +*/
> +
> +#include "system.h"
> +
> +#include "reftable.h"
> +
> +static int dump_table(const char *tablename)
> +{
> +	struct block_source src = { 0 };
> +	int err = block_source_from_file(&src, tablename);
> +	if (err < 0) {
> +		return err;
> +	}
> +
> +	struct reader *r = NULL;

-Wdeclaration-after-statement

> +	err = new_reader(&r, src, tablename);
> +	if (err < 0) {
> +		return err;
> +	}
> +
> +	{
> +		struct iterator it = { 0 };
> +		err = reader_seek_ref(r, &it, "");
> +		if (err < 0) {
> +			return err;
> +		}
> +
> +		struct ref_record ref = { 0 };
> +		while (1) {

In the same series, we see both `while (true)` and `while (1)`

> +int main(int argc, char *argv[])

Do we ship this file?
(I haven't checked change to Makefile, yet)

> +{
> +	int opt;
> +	const char *table = NULL;
> +	while ((opt = getopt(argc, argv, "t:")) != -1) {
> +		switch (opt) {
> +		case 't':
> +			table = xstrdup(optarg);
> +			break;
> +		case '?':

We uses "-h|--help" for usage.

> +			printf("usage: %s [-table tablefile]\n", argv[0]);
> +			return 2;
> +			break;

break after return

> diff --git a/reftable/iter.c b/reftable/iter.c
> new file mode 100644
> index 00000000000..747f3eae256
> --- /dev/null
> +++ b/reftable/iter.c
> @@ -0,0 +1,234 @@
> +/*
> +Copyright 2020 Google LLC
> +
> +Use of this source code is governed by a BSD-style
> +license that can be found in the LICENSE file or at
> +https://developers.google.com/open-source/licenses/bsd
> +*/
> +
> +#include "iter.h"
> +
> +#include "system.h"
> +
> +#include "block.h"
> +#include "constants.h"
> +#include "reader.h"
> +#include "reftable.h"
> +
> +bool iterator_is_null(struct reftable_iterator it)
> +{
> +	return it.ops == NULL;
> +}

Do we want this verbose?
Or it'll be use in some kind of vtable?

> +
> +static int filtering_ref_iterator_next(void *iter_arg, struct record rec)
> +{
> +	struct filtering_ref_iterator *fri =
> +		(struct filtering_ref_iterator *)iter_arg;
> +	struct reftable_ref_record *ref =
> +		(struct reftable_ref_record *)rec.data;

We're passing a pointer, references a member of a variable in local
scope around, this will ask for trouble if callee doesn't aware about
it, and save that pointer somewhere for later access.

I really think we shouldn't merge a big patch like this into Git,
it's too hard to follow and it's harder to reasoning.

> +
> +	while (true) {
> +		int err = reftable_iterator_next_ref(fri->it, ref);
> +		if (err != 0) {
> +			return err;
> +		}
> +
> +		if (fri->double_check) {
> +			struct reftable_iterator it = { 0 };
> +
> +			int err = reftable_reader_seek_ref(fri->r, &it,
> +							   ref->ref_name);
> +			if (err == 0) {
> +				err = reftable_iterator_next_ref(it, ref);
> +			}
> +
> +			reftable_iterator_destroy(&it);
> +
> +			if (err < 0) {
> +				return err;
> +			}
> +
> +			if (err > 0) {
> +				continue;
> +			}
> +		}
> +
> +		if ((ref->target_value != NULL &&
> +		     !memcmp(fri->oid.buf, ref->target_value, fri->oid.len)) ||
> +		    (ref->value != NULL &&
> +		     !memcmp(fri->oid.buf, ref->value, fri->oid.len))) {
> +			return 0;
> +		}
> +	}
> +}
> +
> +}
> +
> diff --git a/reftable/iter.h b/reftable/iter.h
> new file mode 100644
> index 00000000000..408b7f41a74

I stopped at this. It's too tiresome to read this patch.

Overall, I have those general comments, when I have _NOT_ read the
design:

* This patch introduce a total different coding style
* size should be in size_t, not int
* passing large structure around, and passing pointer to some member
  of that structure around, this will ask for trouble.
* Some code are un-parsable,
* I strongly agree with Dscho, we should merge this patch as subtree
  instead, or we should provide API so other party can provide plugin
  ref-backend.

-- 
Danh
