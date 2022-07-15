Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B88C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 16:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiGOQic (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 12:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGOQib (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 12:38:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C27339BB0
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 09:38:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w12so6959832edd.13
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfIhWrjmpl+BVpEbO4XLYZgQlFAcBCHq7TWZKr6mg9c=;
        b=cztUDTN0ykNbfFBXv/OarPkv3CQs/bXOwnKyll5ydR/O+oYPr9HohMi3xLv1qFMeaO
         Yln06WwgCgvIoWBeVFF0MI0zvaN2uIfk0WCkrqYmVVaWFzs8gd7FPlb37mcpYDUQERun
         7PnjHF6VuFNWpsZVDsRk2eU/zOiPKqMVQFLb21cHMucNA7a30ValTvbhBFI20ouOJDSc
         YQ2ddIT0E5VO4lXpYGMQTZNSr1sbaE1uAVmbGaHj7zBJliJgIm34v59pQufmX7zH2CBb
         OgFy2hYn8bndfeXmUy1TBsUiLT/3ft7SKiSLLAXrpIvl9sx4OxNzjCvZXHnSEgODgvk0
         rMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfIhWrjmpl+BVpEbO4XLYZgQlFAcBCHq7TWZKr6mg9c=;
        b=uyFk5q7sovNl4c6JBzHlAlSWTt5dw+jELy+wKbxPNJR6UOZRSRhpEf8bcHyQ9paMDM
         kglMLU41LYo7JhvGUI1xkuSVX6U7n/alLd5GXW3zxkaEUSszUwFMeZ7Z9UjgPrgCMXzE
         ypy89j96xcgYMMSMbheOYOelXf8t4sdJj0k8c9+D1WC9K2lHlp1qi16lU3hGflIE752V
         vgWNIP1y6cxXIcQz2v9TJUIVUYrw0QyM1jnmrshVhTQPAU2N5tkCVutZo6EOoNr0FiUL
         fZHL5g3IHOEj9AkULdCZNlpG3/vuYVCQueGWcX77UVbtLdXIrDzsQYbGO6S7ojxBmbQs
         LhRw==
X-Gm-Message-State: AJIora+kgqTF0SYr7z/aIzPDpuFN9b1UDdrplOx6emK5iwUC/ajyMCW9
        mrxjADKG9YE3HPA1os1dGLK/hsGMxDSZ/l5Tgyo=
X-Google-Smtp-Source: AGRyM1uh4lNDTT7NAEQgSBvDYR8neTyzrCmExUPGvtesdN/43r4NWtajCjRxmlcJ5IJQ9WcV3rWAozqVzRk29QPY3gc=
X-Received: by 2002:aa7:db50:0:b0:43a:6319:e2bc with SMTP id
 n16-20020aa7db50000000b0043a6319e2bcmr20239837edt.237.1657903108604; Fri, 15
 Jul 2022 09:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com> <e64362621d235f2c79f52e984de7a2a2794e2842.1656924376.git.gitgitgadget@gmail.com>
 <YtDVDu7VKgAcvRse@nand.local>
In-Reply-To: <YtDVDu7VKgAcvRse@nand.local>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Fri, 15 Jul 2022 22:08:17 +0530
Message-ID: <CAPOJW5y+ywbiT2XBYYNN+y73+V98Ro33D1bgZQveQLTPfrgE_g@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] pack-bitmap: prepare to read lookup table extension
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 15, 2022 at 8:16 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Jul 04, 2022 at 08:46:14AM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> > +/*
> > + * Searches for a matching triplet. `va` is a pointer
> > + * to the wanted commit position value. `vb` points to
> > + * a triplet in lookup table. The first 4 bytes of each
> > + * triplet (pointed by `vb`) are compared with `*va`.
> > + */
> > +static int triplet_cmp(const void *va, const void *vb)
> > +{
> > +
> > +     uint32_t a = *(uint32_t *)va;
>
> The comment you added is definitely helpful, but I still think that this
> line is a little magical. `*va` isn't really a pointer to a `uint32_t`,
> but a pointer to the start of a triplet, which just *happens* to have a
> 4-byte integer at the beginning of it.

Are you sure about this? As far as I know, the first parameter of such
comparing functions is always a pointer to the given key that we need
to search for and the second parameter points to each element of an
array.

I think "`va is a pointer to the wanted commit position value" is not
that descriptive. Maybe "`va` is a pointer to the given key" is
better. What do you think?

> > + * `bsearch_triplet` function searches for the raw triplet having
> > + * commit position same as `commit_pos` and fills `triplet`
> > + * object from the raw triplet. Returns 1 on success and 0
> > + * on failure.
> > + */
> > +static int bsearch_triplet(uint32_t *commit_pos,
> > +                        struct bitmap_index *bitmap_git,
> > +                        struct bitmap_lookup_table_triplet *triplet)
> > +{
> > +     unsigned char *p = bsearch(commit_pos, bitmap_git->table_lookup, bitmap_git->entry_count,
> > +                                BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH, triplet_cmp);
> > +
> > +     if (!p)
> > +             return 0;
> > +     triplet->commit_pos = get_be32(p);
> > +     p += sizeof(uint32_t);
> > +     triplet->offset = get_be64(p);
> > +     p += sizeof(uint64_t);
> > +     triplet->xor_row = get_be32(p);
> > +     return 1;
> > +}
>
> This implementation jumped out as being quite similar to
> `lookup_table_get_triplet()`. Ultimately they both end up filling a
> triplet struct based on some position `p` within the bitmap. The main
> difference being that in `lookup_table_get_triplet()`, `p` comes from a
> numeric position which indexes into the table, while in
> `bsearch_triplet()` the position `p` is given to us by a call to
> `bsearch()`.
>
> I wonder if it would be worth extracting the common part of: given a
> pointer `p` and a triplet struct, read the triplet beginning at `p` into
> the struct.
>
> `lookup_table_get_triplet()` could compute `p` and then return the
> result of calling the new auxiliary function with that `p`. Similarly
> for `bsearch_triplet()`, it would call that auxiliary function with the
> pointer it got from calling `bsearch()`, or return `0` if no match was
> found.
>
> It's a minor point, but I think it would help us clean up the
> implementation a little bit.

Sure! That would be a great idea!

> > +             ALLOC_ARRAY(xor_items, xor_items_alloc);
>
> This ALLOC_ARRAY() looks great to me. I wonder if we could amortize the
> cost of allocating in this (somewhat) hot function by treating the
> `xor_items` array as a reusable static buffer where we reset
> xor_items_nr to 0 when entering this function.
>
> > +             while (xor_row != 0xffffffff) {
> > +                     struct object_id xor_oid;
> > +
> > +                     if (xor_items_nr + 1 >= bitmap_git->entry_count) {
> > +                             free(xor_items);
> > +                             error(_("corrupt bitmap lookup table: xor chain exceed entry count"));
>
> I think we can probably `die()` here, we're pretty much out of luck in
> this case.
> ...
> > +                             error(_("corrupt bitmap lookup table: commit index %u out of range"),
> > +                                     triplet.commit_pos);
>
> Same here.

I didn't use `die()` here because I thought returning NULL would be a
better idea. In that case, Git can still do its job by using the
traditional approach  - traversing  between objects.
`load_bitmap_entries_v1` also returns NULL if an error occurs. What do
you think?

> > +                     ALLOC_GROW(xor_items, xor_items_nr + 1, xor_items_alloc);
> > +                     xor_items[xor_items_nr++] = (struct bitmap_lookup_table_xor_item) {.oid = xor_oid,
> > +                                                                                        .offset = offset_xor};
>
> This style of initialization is somewhat uncommon for Git's codebase. It
> might be a little more natural to write something like:
>
>     xor_items[xor_items_nr].oid = xor_oid;
>     xor_items[xor_items_nr].offset = offset_xor;
>     xor_items_nr++;
>
> But the struct-copying for `xor_oid` is definitely uncommon for us. We
> should use the `oidcpy()` helper there instead. Or better yet, pass a
> pointer to `&xor_items[xor_items_nr].oid` as the second argument to
> `nth_bitmap_object_oid()` to avoid the copy altogether.

Ok, got it.

> > +                     bitmap_git->map_pos = offset_xor;
> > +                     if (bitmap_git->map_size - bitmap_git->map_pos < 6) {
>
> Should we extract `6` out to a named constant?

Ok, sure!

Thanks :)

>
> Thanks,
> Taylor
