Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2865C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7463364ECE
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhCKREu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhCKREi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:04:38 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBE6C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:04:36 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a11so1657897qto.2
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XAMdtm/Mkz1ov4QIWF89cZ5TLfXaK4FkFxcKFN6Mutw=;
        b=whvV6P6FIwmgMtXG8Wvx2aF6+oQJ96vM4CxMGKiFtc31sz+fS8ol825JQmJmcceDhW
         uQQlviE2LVJmS5xQ3Tt6USmNUl8bvHBZ3vQyrkNbRMTFy7qixdZGIEKzUhGTUIdgyV2r
         IGF65wfKFq3BasXmfHDzY416wiAvKT4sp2H5EIf7SPgbg9tReiWo8UcAUBjhmGyLmx9Z
         hU+0586mcfBTfHG5e+aThJVgZ9/vUUSVXnmoAeFg/0ubW6oy5mLV9WjMYfxVzKBKfqRp
         bd+nv3N/rOTqPe4/yeSy3DCVZOU3sJhjWTDdTaXag552oOShzCwDHxBqACNcL28gMKCJ
         EfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XAMdtm/Mkz1ov4QIWF89cZ5TLfXaK4FkFxcKFN6Mutw=;
        b=gUJ+oqKQvk+xfjineFb2F8Z7FplPcR9/e567tjQOs77/CFMacME996f9T+242Ju8ry
         8LTMSr4AVUlBlUuTPy0ar++kPJzg+rswLItyjcu81zbAPMJg6YAYTSDrkDLAiQWHQPd3
         n/8HXcKGuVL/WJGyno0ZS50zn+ge0nwr7461CdV35msKkWtIk9J2X3tfz4S+oehpMF/S
         gG8j+Xuw65qM2nRNpBIE668C8acwvdZOrLmda2RejtzU3rIaiC2ilYiZfxmNqj4jQshO
         xkRJ9guI6toBddmmTN8te65RbGsoJeCJbFglaNihIafCt6qmrsj1yMYYG5mRq+1UdK76
         qFBQ==
X-Gm-Message-State: AOAM533Sif01BEnP2JtrUAfcaIkNndeb7LY5Az4tHPhJBHPMjwiisuuO
        3BfxIJfLt3XlfpWnhv6vuJPMIggAzQoCF2W4
X-Google-Smtp-Source: ABdhPJxNMj1PTaV2OPmc7O+NKiXDlBFFG7EVgF6vN5kSztWR6YMhfqaeP+tGqvKwXoezvP/Rn27f5g==
X-Received: by 2002:aed:3105:: with SMTP id 5mr7816356qtg.123.1615482274895;
        Thu, 11 Mar 2021 09:04:34 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id y19sm2333240qky.111.2021.03.11.09.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:04:34 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:04:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 00/16] midx: implement a multi-pack reverse index
Message-ID: <cover.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612998106.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another reroll of my series to implement a reverse index in
preparation for multi-pack reachability bitmaps. The previous version
was based on 'ds/chunked-file-api', but that topic has since been merged
to 'master'. This series is now built directly on top of 'master'.

Not much has changed since last time. Jonathan Tan reviewed the previous
version, and I incorporated feedback from his review:

  - The usage macros in builtin/multi-pack-index.c were pulled out and
    defined separately.
  - Some sloppiness with converting a signed index referring to the
    preferred pack into an unsigned value was cleaned up.
  - Documentation clean-up, particularly in patches 12 and 13.

There are a couple of new things that we found while testing this out at
GitHub.

  - We now call finalize_object_file() on the multi-pack reverse index
    to set the correct permissions.
  - Patch 14 removed a stray hunk that introduced a memory leak.
  - Patch 16 (courtesy of Peff) is new. It improves the cache locality
    of midx_pack_order_cmp(), which has a substantial impact on
    repositories with many objects.

Thanks in advance for your review.

Jeff King (1):
  midx.c: improve cache locality in midx_pack_order_cmp()

Taylor Blau (15):
  builtin/multi-pack-index.c: inline 'flags' with options
  builtin/multi-pack-index.c: don't handle 'progress' separately
  builtin/multi-pack-index.c: define common usage with a macro
  builtin/multi-pack-index.c: split sub-commands
  builtin/multi-pack-index.c: don't enter bogus cmd_mode
  builtin/multi-pack-index.c: display usage on unrecognized command
  t/helper/test-read-midx.c: add '--show-objects'
  midx: allow marking a pack as preferred
  midx: don't free midx_name early
  midx: keep track of the checksum
  midx: make some functions non-static
  Documentation/technical: describe multi-pack reverse indexes
  pack-revindex: read multi-pack reverse indexes
  pack-write.c: extract 'write_rev_file_order'
  pack-revindex: write multi-pack reverse indexes

 Documentation/git-multi-pack-index.txt       |  14 +-
 Documentation/technical/multi-pack-index.txt |   5 +-
 Documentation/technical/pack-format.txt      |  83 +++++++
 builtin/multi-pack-index.c                   | 182 ++++++++++++---
 builtin/repack.c                             |   2 +-
 midx.c                                       | 229 +++++++++++++++++--
 midx.h                                       |  11 +-
 pack-revindex.c                              | 127 ++++++++++
 pack-revindex.h                              |  53 +++++
 pack-write.c                                 |  36 ++-
 pack.h                                       |   1 +
 packfile.c                                   |   3 +
 t/helper/test-read-midx.c                    |  24 +-
 t/t5319-multi-pack-index.sh                  |  39 ++++
 14 files changed, 740 insertions(+), 69 deletions(-)

Range-diff against v2:
 1:  0527fa89a9 =  1:  43fc0ad276 builtin/multi-pack-index.c: inline 'flags' with options
 2:  a4e107b1f8 =  2:  181f11e4c5 builtin/multi-pack-index.c: don't handle 'progress' separately
 3:  8679dfd212 =  3:  94c498f0e2 builtin/multi-pack-index.c: define common usage with a macro
 4:  bc42b56ea2 !  4:  d084f90466 builtin/multi-pack-index.c: split sub-commands
    @@ Commit message
     
      ## builtin/multi-pack-index.c ##
     @@
    - #include "midx.h"
    - #include "trace2.h"
    + #define BUILTIN_MIDX_REPACK_USAGE \
    + 	N_("git multi-pack-index [<options>] repack [--batch-size=<size>]")
      
     +static char const * const builtin_multi_pack_index_write_usage[] = {
    - #define BUILTIN_MIDX_WRITE_USAGE \
    - 	N_("git multi-pack-index [<options>] write")
     +	BUILTIN_MIDX_WRITE_USAGE,
     +	NULL
     +};
    - 
     +static char const * const builtin_multi_pack_index_verify_usage[] = {
    - #define BUILTIN_MIDX_VERIFY_USAGE \
    - 	N_("git multi-pack-index [<options>] verify")
     +	BUILTIN_MIDX_VERIFY_USAGE,
     +	NULL
     +};
    - 
     +static char const * const builtin_multi_pack_index_expire_usage[] = {
    - #define BUILTIN_MIDX_EXPIRE_USAGE \
    - 	N_("git multi-pack-index [<options>] expire")
     +	BUILTIN_MIDX_EXPIRE_USAGE,
     +	NULL
     +};
    - 
     +static char const * const builtin_multi_pack_index_repack_usage[] = {
    - #define BUILTIN_MIDX_REPACK_USAGE \
    - 	N_("git multi-pack-index [<options>] repack [--batch-size=<size>]")
     +	BUILTIN_MIDX_REPACK_USAGE,
     +	NULL
     +};
    - 
      static char const * const builtin_multi_pack_index_usage[] = {
      	BUILTIN_MIDX_WRITE_USAGE,
    + 	BUILTIN_MIDX_VERIFY_USAGE,
     @@ builtin/multi-pack-index.c: static struct opts_multi_pack_index {
      	unsigned flags;
      } opts;
 5:  5daa2946d3 =  5:  bc3b6837f2 builtin/multi-pack-index.c: don't enter bogus cmd_mode
 6:  98d9ea0770 =  6:  f117e442c3 builtin/multi-pack-index.c: display usage on unrecognized command
 7:  2fd9f4debf =  7:  ae85a68ef2 t/helper/test-read-midx.c: add '--show-objects'
 8:  223b899094 !  8:  30194a6786 midx: allow marking a pack as preferred
    @@ builtin/multi-pack-index.c
      #include "trace2.h"
     +#include "object-store.h"
      
    - static char const * const builtin_multi_pack_index_write_usage[] = {
      #define BUILTIN_MIDX_WRITE_USAGE \
     -	N_("git multi-pack-index [<options>] write")
     +	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]")
    - 	BUILTIN_MIDX_WRITE_USAGE,
    - 	NULL
    - };
    + 
    + #define BUILTIN_MIDX_VERIFY_USAGE \
    + 	N_("git multi-pack-index [<options>] verify")
     @@ builtin/multi-pack-index.c: static char const * const builtin_multi_pack_index_usage[] = {
      
      static struct opts_multi_pack_index {
    @@ midx.c: static void fill_pack_entry(uint32_t pack_int_id,
      						  uint32_t nr_packs,
     -						  uint32_t *nr_objects)
     +						  uint32_t *nr_objects,
    -+						  uint32_t preferred_pack)
    ++						  int preferred_pack)
      {
      	uint32_t cur_fanout, cur_pack, cur_object;
      	uint32_t alloc_fanout, alloc_objects, total_objects = 0;
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
      		goto cleanup;
      
     -	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr);
    ++	ctx.preferred_pack_idx = -1;
     +	if (preferred_pack_name) {
     +		for (i = 0; i < ctx.nr; i++) {
     +			if (!cmp_idx_or_pack_name(preferred_pack_name,
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
     +				break;
     +			}
     +		}
    -+	} else
    -+		ctx.preferred_pack_idx = -1;
    ++	}
     +
     +	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr,
     +					 ctx.preferred_pack_idx);
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
      			pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
      	}
      
    -+	/*
    -+	 * Recompute the preferred_pack_idx (if applicable) according to the
    -+	 * permuted pack order.
    -+	 */
    -+	ctx.preferred_pack_idx = -1;
    ++	/* Check that the preferred pack wasn't expired (if given). */
     +	if (preferred_pack_name) {
    -+		ctx.preferred_pack_idx = lookup_idx_or_pack_name(ctx.info,
    -+							     ctx.nr,
    -+							     preferred_pack_name);
    -+		if (ctx.preferred_pack_idx < 0)
    ++		int preferred_idx = lookup_idx_or_pack_name(ctx.info,
    ++							    ctx.nr,
    ++							    preferred_pack_name);
    ++		if (preferred_idx < 0)
     +			warning(_("unknown preferred pack: '%s'"),
     +				preferred_pack_name);
     +		else {
    -+			uint32_t orig = ctx.info[ctx.preferred_pack_idx].orig_pack_int_id;
    ++			uint32_t orig = ctx.info[preferred_idx].orig_pack_int_id;
     +			uint32_t perm = ctx.pack_perm[orig];
     +
    -+			if (perm == PACK_EXPIRED) {
    ++			if (perm == PACK_EXPIRED)
     +				warning(_("preferred pack '%s' is expired"),
     +					preferred_pack_name);
    -+				ctx.preferred_pack_idx = -1;
    -+			} else
    -+				ctx.preferred_pack_idx = perm;
     +		}
     +	}
     +
 9:  976848bc4b =  9:  5c5aca761a midx: don't free midx_name early
10:  5ed47f7e3a = 10:  a22a1463a5 midx: keep track of the checksum
11:  0292508e12 = 11:  efa54479b1 midx: make some functions non-static
12:  404d730498 ! 12:  4745bb8590 Documentation/technical: describe multi-pack reverse indexes
    @@ Documentation/technical/pack-format.txt: CHUNK DATA:
     +
     +Instead of mapping between offset, pack-, and index position, this
     +reverse index maps between an object's position within the MIDX, and
    -+that object's position within a pseudo-pack that the MIDX describes.
    ++that object's position within a pseudo-pack that the MIDX describes
    ++(i.e., the ith entry of the multi-pack reverse index holds the MIDX
    ++position of ith object in pseudo-pack order).
     +
    -+To clarify these three orderings, consider a multi-pack reachability
    -+bitmap (which does not yet exist, but is what we are building towards
    -+here). Each bit needs to correspond to an object in the MIDX, and so we
    -+need an efficient mapping from bit position to MIDX position.
    ++To clarify the difference between these orderings, consider a multi-pack
    ++reachability bitmap (which does not yet exist, but is what we are
    ++building towards here). Each bit needs to correspond to an object in the
    ++MIDX, and so we need an efficient mapping from bit position to MIDX
    ++position.
     +
     +One solution is to let bits occupy the same position in the oid-sorted
     +index stored by the MIDX. But because oids are effectively random, there
13:  d4e01a44e7 ! 13:  a6ebd4be91 pack-revindex: read multi-pack reverse indexes
    @@ Commit message
         position in the psuedo-pack order, but that order can only be recovered
         in the .rev file itself. This mapping can be implemented with a binary
         search, but note that the thing we're binary searching over isn't an
    -    array, but rather a _permutation_.
    +    array of values, but rather a permuted order of those values.
     
         So, when comparing two items, it's helpful to keep in mind the
         difference. Instead of a traditional binary search, where you are
14:  ab7012b283 ! 14:  f5314f1822 pack-write.c: extract 'write_rev_file_order'
    @@ pack-write.c: const char *write_rev_file(const char *rev_name,
     +		pack_order[i] = i;
     +	QSORT_S(pack_order, nr_objects, pack_order_cmp, objects);
     +
    -+	if (!(flags & (WRITE_REV | WRITE_REV_VERIFY)))
    -+		return NULL;
    -+
     +	ret = write_rev_file_order(rev_name, pack_order, nr_objects, hash,
     +				   flags);
     +
15:  01bd6a35c6 ! 15:  fa3acb5d5a pack-revindex: write multi-pack reverse indexes
    @@ Commit message
         for long, since subsequent patches will introduce the multi-pack bitmap,
         which will begin passing this field.
     
    +    (In midx.c:write_midx_internal(), the two adjacent if statements share a
    +    conditional, but are written separately since the first one will
    +    eventually also handle the MIDX_WRITE_BITMAP flag, which does not yet
    +    exist.)
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## midx.c ##
    @@ midx.c: static int write_midx_large_offsets(struct hashfile *f,
     +				     struct write_midx_context *ctx)
     +{
     +	struct strbuf buf = STRBUF_INIT;
    ++	const char *tmp_file;
     +
     +	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
     +
    -+	write_rev_file_order(buf.buf, ctx->pack_order, ctx->entries_nr,
    -+			     midx_hash, WRITE_REV);
    ++	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
    ++					midx_hash, WRITE_REV);
    ++
    ++	if (finalize_object_file(tmp_file, buf.buf))
    ++		die(_("cannot store reverse index file"));
     +
     +	strbuf_release(&buf);
     +}
 -:  ---------- > 16:  550e785f10 midx.c: improve cache locality in midx_pack_order_cmp()
-- 
2.30.0.667.g81c0cbc6fd
