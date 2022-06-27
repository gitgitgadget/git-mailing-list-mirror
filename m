Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0BDC433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 21:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiF0VtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 17:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiF0VtR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 17:49:17 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759042734
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 14:49:16 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id cu16so17371245qvb.7
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 14:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GF1eF8TKsAB5MmMv1bugMUsWQz9Vv4AlIp81Oc0JFB0=;
        b=xgCaePnAnVrctnU07/M/eVL+dyZtSPN1AY+6m1Nr5utf3xvf2rxAjHose1wQ6fWQ7N
         D4hvLtWBrhJJDiSzaktnX3LDEmXIHRVOMKD6W/z125SwX2MlkLUOqZdz7Ix6rQFdGeVg
         qQRck1OjKnF0OY4fMaFOT8UcKE7/A9CnppFqYg/uf+DA/CyK2XtfWubzLkEQ9Ag1rVPg
         +NY//cBMEM2xPEP1rTUxETXHUbUq757KW7Ou/SxP++9mn4PpbDjqFl6pwmuvM/qGpHEn
         pjqKCnYAZyoQ001PjHTSsxinTUH9ZVjkjd5WoJgeUzJPbm2Tw5HG05KcsbGyTsHEhrYr
         jT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GF1eF8TKsAB5MmMv1bugMUsWQz9Vv4AlIp81Oc0JFB0=;
        b=fARVq54sfFUB34fgrtO9iapE/gfbAFalzsPEXsXuiR4kf0uGkZ8e2CuQQ+GK4smFK0
         HYMD3naIBYbol7mTeqY9bq6EQ1dmVs29ILe8hfvjI3Jv8CJLHB0uPotLAKmTb1RYODkx
         /ahLVxg6eG2JfWo18d5doEodB7DA6e7UkNv6m48iAodmZm/tRxmSbP4/vNJwqFY4uRJP
         RdpXTIzGTgV00Nyb666Xq2T81i7bZidpq7UuI9VtpQqZqDQEBmZgg1yu0ZfRCQdrRKTy
         UBDLQqZZEz4SaCbHLMgLvdw6PyXEn1GxLfJN3VrfzwjTAUhhd6om3Fu7W6TzsnShPjLW
         b3iA==
X-Gm-Message-State: AJIora/6MMPlLif1ZzWnsz/dAE7SOSGYj9iSleYl5lICvKZurtDu6jT0
        Xb1kZPfEzx3zTuqFQDc9BDH7cw==
X-Google-Smtp-Source: AGRyM1vk6moMZB2f2sHNPfodzRQSbiiN+yQeMnyDb0y4xCML316Su8mYi7Wwfca9vzmU6MTXORQEgw==
X-Received: by 2002:a05:622a:1c2:b0:319:75e2:6d3 with SMTP id t2-20020a05622a01c200b0031975e206d3mr7259702qtw.504.1656366555516;
        Mon, 27 Jun 2022 14:49:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id az16-20020a05620a171000b006af4a816963sm1121320qkb.133.2022.06.27.14.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:49:15 -0700 (PDT)
Date:   Mon, 27 Jun 2022 17:49:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 4/6] pack-bitmap: prepare to read lookup table
 extension
Message-ID: <Yrol2tY4emxmYh9n@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <4fbfcff8a208798146cd561b0185e094a116cf0e.1656249017.git.gitgitgadget@gmail.com>
 <cebad3da-5779-5908-15d5-63d4c590c20b@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cebad3da-5779-5908-15d5-63d4c590c20b@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 27, 2022 at 11:12:09AM -0400, Derrick Stolee wrote:
> On 6/26/2022 9:10 AM, Abhradeep Chakraborty via GitGitGadget wrote:
> > +			table_size = st_add(table_size,
> > +					st_mult(ntohl(header->entry_count),
> > +						triplet_sz));
>
> Here, we _do_ want to keep the st_mult(). Is the st_add() still necessary? It
> seems this is a leftover from the previous version that had the 4-byte flag
> data.
>
> We set table_size to zero above. We could drop that initialization and instead
> have this after the "size_t triplet_sz" definition:
>
> 			size_t table_size = st_mult(ntohl(header->entry_count),
> 						    triplet_sz));

Well put, thank you.

> > +			if (table_size > index_end - index->map - header_size)
> > +				return error("corrupted bitmap index file (too short to fit lookup table)");
>
> Please add "_(...)" around the error message so it can be translated.

I missed this in my own review, but yes: this is a good practice.

> > +	if (bitmap_git->midx)
> > +		found = bsearch_midx(oid, bitmap_git->midx, result);
> > +	else
> > +		found = bsearch_pack(oid, bitmap_git->pack, result);
> > +
> > +	return found;
>
> Here, we are doing a binary search on the entire list of packed objects, which could
> use quite a few more hops than a binary search on the bitmapped commits.

I think this is the best we can do if we make the key to our bsearch
through the lookup table be an index into the pack index / MIDX. But...

> > +static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
> > +					  struct commit *commit)
> ...
> > +	int found = bsearch_pos(bitmap_git, oid, &commit_pos);
> > +
> > +	if (!found)
> > +		return NULL;
> > +
> > +	triplet = bsearch(&commit_pos, bitmap_git->table_lookup, bitmap_git->entry_count,
> > +						triplet_sz, triplet_cmp);
>
> But I see, you are searching the pack-index for the position in the index, and _then_
> searching the bitmap lookup table based on that position value.
>
> I expected something different: binary search on the triplets where the comparison is
> made by looking up the OID from the [multi-]pack-index and comparing that OID to the
> commit OID we are looking for.
>
> I'm not convinced that the binary search I had in mind is meaningfully faster than
> what you've implemented here, so I'm happy to leave it as you have it. We can investigate
> if that full search on the pack-index matters at all (it probably doesn't).

...exactly my thoughts, too. It's possible that it would be faster to
key this search on the object_id "oid" above, and then convert each of
the entries in the lookup table from a uint32_t into an object_id by
calling nth_bitmap_object_oid() repeatedly.

I *think* that what Abhradeep wrote here is going to be faster more
often than not since it makes more efficient use of the page cache
rather than switching between reads across different memory mapped
regions at each point in the binary search.

But of course that depends on a number of factors. Abhradeep: if you're
up for it, I think it would be worth trying it both ways and seeing if
one produces a meaningful speed-up or slow-down over the other. Like I
said: my guess is that what you have now will be faster, but I don't
have a clear sense that that is true without trying it both ways ;-).

> > +	if (!triplet)
> > +		return NULL;
> > +
> > +	offset = triplet_get_offset(triplet);
> > +	xor_pos = triplet_get_xor_pos(triplet);
> > +
> > +	if (xor_pos != 0xffffffff) {
> > +		int xor_flags;
> > +		uint64_t offset_xor;
> > +		uint32_t *xor_positions;
> > +		struct object_id xor_oid;
> > +		size_t size = 0;
> > +
> > +		ALLOC_ARRAY(xor_positions, bitmap_git->entry_count);
>
> While there is potential that this is wasteful, it's probably not that huge,
> so we can start with the "maximum XOR depth" and then reconsider a smaller
> allocation in the future.

There is no maximum XOR depth, to my knowledge. We do have a maximum XOR
*offset*, which says we cannot XOR-compress a bitmap with an entry more
than 160 entries away from the current one. But in theory every commit
could be XOR compressed with the one immediately proceeding it, so the
maximum depth could be as long as the entry_count itself.

I think starting off with a small array and then letting it grow
according to alloc_nr() would be fine here, since it will grow more and
more each time, so the amount of times we have to reallocate the buffer
will tail off over time.

If we were really concerned about it, we could treat the buffer as a
static pointer and reuse it over time (making sure to clear out the
portions of it we're going to reuse, or otherwise ensuring that we don't
read old data). But I doubt it matters much either way in practice: the
individual records are small (at just 4 bytes each) and entry_count is
often less than 1,000, so I think this probably has a vanishingly small
impact.

Thanks,
Taylor
