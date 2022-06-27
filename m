Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B56C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 16:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbiF0QFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 12:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbiF0QF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 12:05:28 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6274C18E38
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 09:05:26 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id cs6so15375550qvb.6
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jznosbk+IvMQ86tJDNfxxDdkfvTS4VhyDaND9F1p5WE=;
        b=bLXpkdhV/WGvSBQzeDtpB4PlKZ6Fnw2hGjWYcEoQ7FzyHDrML4RMM7aC9grkPLAWlk
         szKRXql0CKrhRniRfrAE8ygsYDboodaOCindx+fBvFy9zxgJtHVgBFRt4WewuN0zTl5I
         BoNx4P+1SlXFcsgOj0PgnX3VHcL5uDaBhVpoCSAATm43bGtvhhTcU7y55hrrPr6QeJ6b
         MNJQmLzoqLZVhsWgIQ58FhgPOFQEwQiWHQObq+aQdy9FyRJBNwYg4mEZJsW3BjqyJR26
         3D5acHhE/cFwY5AvG5pJ0OZVOjFn7ZEMmasjRdYr7QJf9EoFAS5ntAZkTnuqdnt8gDS2
         1mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jznosbk+IvMQ86tJDNfxxDdkfvTS4VhyDaND9F1p5WE=;
        b=IjVZBFyTBDbkay8SBl29lSOm43Zu87IKMM0zYlNB7Bkb6yUk6T+ebKa4hOlutGxNsF
         BK/0vyaecp+mv4p/qYd2qHXjIouF6LFH8oWps58cwrjCm7uERYwk3X9n5CCdYi040ZA7
         4G2c5FlMvs+Oe8sLI/KzdlxkvBVG4cYwO+5A37crXRlhzhlA7DQKbT2fdEJlJaoPv5lg
         PVSQxQNYWYK4QETMjQS6esjBphGfW2T3Drwj2vQGcRR14MRf/Bdbj0ALg59R6saBoT6a
         LqclfCDtAdL249f/+XTV2MhgAKxo71/6ytY6sdMZpF8wrdBbX+RY0XmUWzrUVe/8bufU
         ZWEQ==
X-Gm-Message-State: AJIora9Pzt8yc6dmQpkvoX+PwyEcBhtxA7+yRoDFLmRdXrODrpy3dz7G
        SqDdToTfLBQFya9d9C7KokVGwMEXakvI8w==
X-Google-Smtp-Source: AGRyM1tNAn0XJeoHnwWfjfxf1DGwN0rerPkwJDHU9BOGVxZDTcIs298R3OLO7uaPJ8iTGiATK8XSPA==
X-Received: by 2002:a05:622a:48d:b0:317:2f2:f4b with SMTP id p13-20020a05622a048d00b0031702f20f4bmr9737537qtx.422.1656345925385;
        Mon, 27 Jun 2022 09:05:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y11-20020a05620a44cb00b006a37eb728cfsm2599316qkp.1.2022.06.27.09.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:05:25 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:05:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 2/6] pack-bitmap-write.c: write lookup table extension
Message-ID: <YrnVRLvbG4TK8pXY@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <d118f1d45e6202925d4efd5435acdd08545bf132.1656249017.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d118f1d45e6202925d4efd5435acdd08545bf132.1656249017.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 26, 2022 at 01:10:13PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> The bitmap lookup table extension was documentated by an earlier
> change, but Git does not yet knowhow to write that extension.
>
> Teach git to write bitmap lookup table extension. The table contains
> the list of `N` <commit pos, offset, xor offset>` triplets. These
> triplets are sorted according to their commit pos (ascending order).
> The meaning of each data in the i'th triplet is given below:
>
>   - Commit pos is the position of the commit in the pack-index
>     (or midx) to which the i'th bitmap belongs. It is a 4 byte
>     network byte order integer.
>
>   - offset is the position of the i'th bitmap.
>
>   - xor offset denotes the position of the triplet with whose
>     bitmap the current triplet's bitmap need to xor with.
>
> Co-authored-by: Taylor Blau <me@ttaylorr.com>
> Mentored-by: Taylor Blau <me@ttaylorr.com>
> Co-mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  pack-bitmap-write.c | 72 +++++++++++++++++++++++++++++++++++++++++++--
>  pack-bitmap.h       |  5 ++--
>  2 files changed, 73 insertions(+), 4 deletions(-)
>
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index c43375bd344..899a4a941e1 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -650,7 +650,9 @@ static const struct object_id *oid_access(size_t pos, const void *table)
>
>  static void write_selected_commits_v1(struct hashfile *f,
>  				      struct pack_idx_entry **index,
> -				      uint32_t index_nr)
> +				      uint32_t index_nr,
> +				      uint64_t *offsets,

We should probably leave this as a pointer to an off_t, since that is a
more appropriate type for keeping track of an offset within a file (and
indeed it is the return type of hashfile_total()).

But since it's platform-dependent, we should make sure to cast it to a
uint64_t before writing it as part of the lookup table.

> +				      uint32_t *commit_positions)
>  {
>  	int i;
>
> @@ -663,6 +665,11 @@ static void write_selected_commits_v1(struct hashfile *f,
>  		if (commit_pos < 0)
>  			BUG("trying to write commit not in index");
>
> +		if (offsets)
> +			offsets[i] = hashfile_total(f);

This makes sense to store here, since we can't easily recover this
information later on.

> +		if (commit_positions)
> +			commit_positions[i] = commit_pos;

This one I'm not as sure about. It would be nice to not have
write_selected_commits_v1() be responsible for writing this down, too.
And I think it's easy enough to recover later on, since we're just doing
a search over "index" (see above the "oid_pos" call).

I think that oid_pos() call could be hidden behind a function that takes
an object_id pointer, an index (double pointer) of pack_idx_entry
structs, and a length.

Its implementation would be something like:

    static int commit_bitmap_writer_pos(struct object_id *oid,
                                        struct pack_idx_entry **index,
                                        uint32_t index_nr)
    {
        return oid_pos(oid, index, index_nr, oid_access);
    }

and then we could replace any calls like commit_positions[i] with one
that first takes `i` to the appropriate object_id in selected commit
order.

That would be strictly less efficient, but not in a way that I think
matters, and it would definitely be cleaner to not rely on a side-effect
of write_selected_commits_v1().

Something in the middle there would be to have write_lookup_table()
assemble that list of commit_positions itself, something like:

    uint32_t *commit_positions;

    ALLOC_ARRAY(commit_positions, writer.selected_nr);

    for (i = 0; i < writer.selected_nr; i++) {
        int pos = oid_pos(&writer.selected[i].commit->object.oid,
                          index, index_nr);
        if (pos < 0)
            BUG("trying to write commit not in index");
        commit_positions[i] = pos;
    }

    ...

    free(commit_positions);

That at least removes a side-effect from the implementation of
write_selected_commits_v1() and brings the creation of the
commit_positions array closer to where it's being used, while still
maintaining the constant-time lookups. So that may be a good
alternative, but I'm curious of your thoughts.

> +static int table_cmp(const void *_va, const void *_vb, void *commit_positions)

OK, so this is sorting the table in order of the commit positions. I
would rename the commit_positions parameter to something like "void
*_data", and then have commit_positions be the result of the cast, like
"uint32_t *commit_positions = _data";

> +{
> +	int8_t result = 0;

int8_t isn't an often used type in Git's codebase, but we can get rid of
this variable altogether and just return immediately from each case,
e.g.:

    if (a < b)
        return -1;
    else if (a > b)
        return 1;
    return 0;

or similar.

> +	uint32_t *positions = (uint32_t *) commit_positions;

Explicit cast isn't need here since you're going up from void*.

> +static void write_lookup_table(struct hashfile *f,
> +			       uint64_t *offsets,
> +			       uint32_t *commit_positions)
> +{
> +	uint32_t i;
> +	uint32_t *table, *table_inv;
> +
> +	ALLOC_ARRAY(table, writer.selected_nr);
> +	ALLOC_ARRAY(table_inv, writer.selected_nr);
> +
> +	for (i = 0; i < writer.selected_nr; i++)
> +		table[i] = i;
> +
> +	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);

I think the construction of table and table_inv could definitely benefit
from a comment here indicating what they're used for and what they
contain (e.g., "table maps abc to xyz").

> +	for (i = 0; i < writer.selected_nr; i++)
> +		table_inv[table[i]] = i;
> +
> +	for (i = 0; i < writer.selected_nr; i++) {
> +		struct bitmapped_commit *selected = &writer.selected[table[i]];
> +		uint32_t xor_offset = selected->xor_offset;
> +
> +		hashwrite_be32(f, commit_positions[table[i]]);
> +		hashwrite_be64(f, offsets[table[i]]);
> +		hashwrite_be32(f, xor_offset ?
> +				table_inv[table[i] - xor_offset]: 0xffffffff);

Nit: missing space before ':'.

Thanks,
Taylor
