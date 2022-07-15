Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCA9C433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 02:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiGOCqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 22:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGOCqm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 22:46:42 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3693E51A26
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:46:41 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v28so1114543qkg.13
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vcXtxPvgyDKojSHrKcuHBBtv0Xuk5Qx3EURxpWO5D4U=;
        b=WSo3/NnfQsY/7nsVzoJDLmtb8MOYmP3AuuVGtLK2EGYovs325WvUxsoUGthv3mPEQd
         uGsZNMfChLjoic4fP8j5gynppVht3DsWUcZSgbehuWdEcC6sBo3kHEPpDm8nzfGl87Nf
         O7fW2F/Y4hmTwHFa2PWC9ngwtDHYezr0HFmKR3F5agYcSV1sfjA3XHEwwLdtdoCuAT5W
         SYEcWrFztREOIKABvERBf/Q5p+vH6W1J6z+mjc9TZgFe2gHM++W9jQrA/wBm4EaTFzwC
         /mv2SRfcXBUu/IJObnwzJC2MvNRwRSn570VjTbgM/EkwezqE08Ly622upD+NdpzIpHK9
         TscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vcXtxPvgyDKojSHrKcuHBBtv0Xuk5Qx3EURxpWO5D4U=;
        b=R7WLCPsdMCoILJSnJG/KAMzzBDRVyby+0fKWJrjF0Xy8nGQEcVp034QhvY9uL5tVd8
         p/nwtBa5bpFoU/YzaSoPw8+6IrYeZPKSqHqXPpRGf2qkSlS6NftupMHh7zQBP9wd4agZ
         gig81G+tgSPjhm62VxQkYKGOvR2VV98TVqLpnPh2wnZt9Ufg1JfoD86AoY0krTGsMJPs
         IUE400sKHCX3vxSelwQtBoaLru1ThsLT8mvYqcIawyt552MOxTIVXkQwcH0YDIKnYq8C
         2bpDEwAfBadKi7ixkWIEI7tLhUm1Qt8trLHiNm+gnO3WhpHrnWrg3aLfVkjoImX4KQ97
         zEkw==
X-Gm-Message-State: AJIora+Lu9L1/g3X1OJXSRRyFUl7jIzMbhjfLUogdYBL/yeX0yRBxmMU
        R3qhtz3NQ9Yfu8tEjCoY2gbyBQ==
X-Google-Smtp-Source: AGRyM1swA5JYU8DbZyEecUikaL2rQdCoLIkxf0NC8M3MlDa3XedxXVAFLubhBXTRfh6mKz0LmFxxIQ==
X-Received: by 2002:a05:620a:191d:b0:6b5:729e:ea18 with SMTP id bj29-20020a05620a191d00b006b5729eea18mr7640938qkb.683.1657853200237;
        Thu, 14 Jul 2022 19:46:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o2-20020ac841c2000000b0031eb65e1cb6sm2757543qtm.5.2022.07.14.19.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 19:46:39 -0700 (PDT)
Date:   Thu, 14 Jul 2022 22:46:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v3 4/6] pack-bitmap: prepare to read lookup table
 extension
Message-ID: <YtDVDu7VKgAcvRse@nand.local>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
 <e64362621d235f2c79f52e984de7a2a2794e2842.1656924376.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e64362621d235f2c79f52e984de7a2a2794e2842.1656924376.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 04, 2022 at 08:46:14AM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> +/*
> + * Searches for a matching triplet. `va` is a pointer
> + * to the wanted commit position value. `vb` points to
> + * a triplet in lookup table. The first 4 bytes of each
> + * triplet (pointed by `vb`) are compared with `*va`.
> + */
> +static int triplet_cmp(const void *va, const void *vb)
> +{
> +
> +	uint32_t a = *(uint32_t *)va;

The comment you added is definitely helpful, but I still think that this
line is a little magical. `*va` isn't really a pointer to a `uint32_t`,
but a pointer to the start of a triplet, which just *happens* to have a
4-byte integer at the beginning of it.

I don't think there's a way to improve this much more than we already
have, though. Populating a triplet struct to just dereference the first
field feels wasteful and slow. So I think what you have here makes sense
to me.

> +static uint32_t bsearch_pos(struct bitmap_index *bitmap_git,
> +			    struct object_id *oid,
> +			    uint32_t *result)
> +{
> +	int found;
> +
> +	if (bitmap_is_midx(bitmap_git))
> +		found = bsearch_midx(oid, bitmap_git->midx, result);
> +	else
> +		found = bsearch_pack(oid, bitmap_git->pack, result);
> +
> +	return found;
> +}
> +
> +/*
> + * `bsearch_triplet` function searches for the raw triplet having
> + * commit position same as `commit_pos` and fills `triplet`
> + * object from the raw triplet. Returns 1 on success and 0
> + * on failure.
> + */
> +static int bsearch_triplet(uint32_t *commit_pos,
> +			   struct bitmap_index *bitmap_git,
> +			   struct bitmap_lookup_table_triplet *triplet)
> +{
> +	unsigned char *p = bsearch(commit_pos, bitmap_git->table_lookup, bitmap_git->entry_count,
> +				   BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH, triplet_cmp);
> +
> +	if (!p)
> +		return 0;
> +	triplet->commit_pos = get_be32(p);
> +	p += sizeof(uint32_t);
> +	triplet->offset = get_be64(p);
> +	p += sizeof(uint64_t);
> +	triplet->xor_row = get_be32(p);
> +	return 1;
> +}

This implementation jumped out as being quite similar to
`lookup_table_get_triplet()`. Ultimately they both end up filling a
triplet struct based on some position `p` within the bitmap. The main
difference being that in `lookup_table_get_triplet()`, `p` comes from a
numeric position which indexes into the table, while in
`bsearch_triplet()` the position `p` is given to us by a call to
`bsearch()`.

I wonder if it would be worth extracting the common part of: given a
pointer `p` and a triplet struct, read the triplet beginning at `p` into
the struct.

`lookup_table_get_triplet()` could compute `p` and then return the
result of calling the new auxiliary function with that `p`. Similarly
for `bsearch_triplet()`, it would call that auxiliary function with the
pointer it got from calling `bsearch()`, or return `0` if no match was
found.

It's a minor point, but I think it would help us clean up the
implementation a little bit.

> +
> +static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
> +					  struct commit *commit)
> +{
> +	uint32_t commit_pos, xor_row;
> +	uint64_t offset;
> +	int flags;
> +	struct bitmap_lookup_table_triplet triplet;
> +	struct object_id *oid = &commit->object.oid;
> +	struct ewah_bitmap *bitmap;
> +	struct stored_bitmap *xor_bitmap = NULL;
> +
> +	int found = bsearch_pos(bitmap_git, oid, &commit_pos);
> +
> +	if (!found)
> +		return NULL;
> +
> +	if (!bsearch_triplet(&commit_pos, bitmap_git, &triplet))
> +		return NULL;
> +
> +	offset = triplet.offset;
> +	xor_row = triplet.xor_row;
> +
> +	if (xor_row != 0xffffffff) {
> +		int xor_flags;
> +		khiter_t hash_pos;
> +		uint64_t offset_xor;
> +		struct bitmap_lookup_table_xor_item *xor_items;
> +		struct bitmap_lookup_table_xor_item xor_item;
> +		size_t xor_items_nr = 0, xor_items_alloc = 64;
> +
> +		ALLOC_ARRAY(xor_items, xor_items_alloc);

This ALLOC_ARRAY() looks great to me. I wonder if we could amortize the
cost of allocating in this (somewhat) hot function by treating the
`xor_items` array as a reusable static buffer where we reset
xor_items_nr to 0 when entering this function.

> +		while (xor_row != 0xffffffff) {
> +			struct object_id xor_oid;
> +
> +			if (xor_items_nr + 1 >= bitmap_git->entry_count) {
> +				free(xor_items);
> +				error(_("corrupt bitmap lookup table: xor chain exceed entry count"));

I think we can probably `die()` here, we're pretty much out of luck in
this case.

> +				return NULL;
> +			}
> +
> +			if (lookup_table_get_triplet(bitmap_git, xor_row, &triplet) < 0)
> +				return NULL;
> +
> +			offset_xor = triplet.offset;
> +
> +			if (nth_bitmap_object_oid(bitmap_git, &xor_oid, triplet.commit_pos) < 0) {
> +				free(xor_items);
> +				error(_("corrupt bitmap lookup table: commit index %u out of range"),
> +					triplet.commit_pos);

Same here.

> +				return NULL;
> +			}
> +
> +			hash_pos = kh_get_oid_map(bitmap_git->bitmaps, xor_oid);
> +
> +			/*
> +			 * If desired bitmap is already stored, we don't need
> +			 * to iterate further. Because we know that bitmaps
> +			 * that are needed to be parsed to parse this bitmap
> +			 * has already been stored. So, assign this stored bitmap
> +			 * to the xor_bitmap.
> +			 */
> +			if (hash_pos < kh_end(bitmap_git->bitmaps) &&
> +			    (xor_bitmap = kh_value(bitmap_git->bitmaps, hash_pos)))
> +				break;
> +
> +			ALLOC_GROW(xor_items, xor_items_nr + 1, xor_items_alloc);
> +			xor_items[xor_items_nr++] = (struct bitmap_lookup_table_xor_item) {.oid = xor_oid,
> +											   .offset = offset_xor};

This style of initialization is somewhat uncommon for Git's codebase. It
might be a little more natural to write something like:

    xor_items[xor_items_nr].oid = xor_oid;
    xor_items[xor_items_nr].offset = offset_xor;
    xor_items_nr++;

But the struct-copying for `xor_oid` is definitely uncommon for us. We
should use the `oidcpy()` helper there instead. Or better yet, pass a
pointer to `&xor_items[xor_items_nr].oid` as the second argument to
`nth_bitmap_object_oid()` to avoid the copy altogether.

> +			xor_row = triplet.xor_row;
> +		}
> +
> +		while (xor_items_nr) {
> +			xor_item = xor_items[xor_items_nr - 1];
> +			offset_xor = xor_item.offset;
> +
> +			bitmap_git->map_pos = offset_xor;
> +			if (bitmap_git->map_size - bitmap_git->map_pos < 6) {

Should we extract `6` out to a named constant?

Thanks,
Taylor
