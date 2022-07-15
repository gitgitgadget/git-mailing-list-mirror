Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0571FC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 22:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiGOWU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 18:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiGOWU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 18:20:26 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C99D5D0C0
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 15:20:25 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id y9so1461681qtv.5
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 15:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p1QklSYBCEKzWRlYNgUUL+MLZEZfGDd3CzZj5wbp3Z4=;
        b=7kpIqMOTK5ZD9+szTTOOmtu4lVk7yhkA754CY70dZPWITONMi9LTCKhLJYbkHSBCoA
         TPH/74njE8FpIX0S7CoilfR0zj5qia+9DMzk9YOGe+nVl3oe+4TSxxEJFu0KrLAgbkTM
         syvfAH25LOPKUVyXQW8DyO8J5se7u180nL/UCybtycan5yJHVFecSSBeWT0IutYF6BHE
         hPL4+UqW6OkX9qlNM7pjiCO9jmGGzLJ9IxM+dgJDrh7qIl2yFkV31XUr1Yt8VdfHVUx6
         HXXf98cKFvLqbyfXetY5BrMn0YdlEF7EcBZ4xTXIPIj4qQzyiHayNlcK440g2Q9mFDmP
         zcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p1QklSYBCEKzWRlYNgUUL+MLZEZfGDd3CzZj5wbp3Z4=;
        b=GZ0TzCm8sG3cf1OamGP7LCDbh2ZhzRWJxyxDojio2+KGAUYLP1TIXxu3cun5pSNHZ8
         CEH2wywwptnp3tUkWlsEbIKsHXWJ/uNTWFZlkMmNuLbhShrJtS3gDCvylVTGeO3PLvvw
         LFgZ/sdL3khB1uFiNQy2JV2zs12TjTYOctcbd9MBfQVgl7GWiRkaP+cWk0Hv/+mQP62S
         Ncg4XyrQdKrAs8KosM761/ZeAsysn3SV+GezYk8yQnb8u2ZOIlpEwnszZbZB1t8BLt5t
         qroo4Mj0RN4KShqtR8xbeKgkmrmFw4WC1PDaxuL05jM9K7OHVtkcQq2L5mCSqnG5bz+O
         NgYg==
X-Gm-Message-State: AJIora+i/t5SnmfeimdJidl6YhLOnbch0vqDnUkNnQL9eMPQmSByWVgq
        9FAZT8wWioufbbcxzQbD3psECA==
X-Google-Smtp-Source: AGRyM1up+/aVAHrHOqd41KOvKo0d25s7swvnDvp8Rxpuk1X5TxpV8vjmMKDSv7nS9dElyE190qiPvg==
X-Received: by 2002:a05:622a:448:b0:31d:3e0d:4527 with SMTP id o8-20020a05622a044800b0031d3e0d4527mr14251109qtx.354.1657923624338;
        Fri, 15 Jul 2022 15:20:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j13-20020ac806cd000000b00304efba3d84sm4273595qth.25.2022.07.15.15.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 15:20:23 -0700 (PDT)
Date:   Fri, 15 Jul 2022 18:20:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 4/6] pack-bitmap: prepare to read lookup table
 extension
Message-ID: <YtHoJ90N6rmDmn6M@nand.local>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
 <e64362621d235f2c79f52e984de7a2a2794e2842.1656924376.git.gitgitgadget@gmail.com>
 <YtDVDu7VKgAcvRse@nand.local>
 <CAPOJW5y+ywbiT2XBYYNN+y73+V98Ro33D1bgZQveQLTPfrgE_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPOJW5y+ywbiT2XBYYNN+y73+V98Ro33D1bgZQveQLTPfrgE_g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 15, 2022 at 10:08:17PM +0530, Abhradeep Chakraborty wrote:
> On Fri, Jul 15, 2022 at 8:16 AM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > On Mon, Jul 04, 2022 at 08:46:14AM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> > > +/*
> > > + * Searches for a matching triplet. `va` is a pointer
> > > + * to the wanted commit position value. `vb` points to
> > > + * a triplet in lookup table. The first 4 bytes of each
> > > + * triplet (pointed by `vb`) are compared with `*va`.
> > > + */
> > > +static int triplet_cmp(const void *va, const void *vb)
> > > +{
> > > +
> > > +     uint32_t a = *(uint32_t *)va;
> >
> > The comment you added is definitely helpful, but I still think that this
> > line is a little magical. `*va` isn't really a pointer to a `uint32_t`,
> > but a pointer to the start of a triplet, which just *happens* to have a
> > 4-byte integer at the beginning of it.
>
> Are you sure about this? As far as I know, the first parameter of such
> comparing functions is always a pointer to the given key that we need
> to search for and the second parameter points to each element of an
> array.
>
> I think "`va is a pointer to the wanted commit position value" is not
> that descriptive. Maybe "`va` is a pointer to the given key" is
> better. What do you think?

Yes, the first argument to the comparison function used in bsearch() is
a pointer to some element in the array. I just meant that that array is
the bitmap_git->table_lookup region, so each element isn't actually a
uint32_t array, but the whole thing is an array of (uint32_t, uint64_t,
uint32_t) triplets.

What you wrote here is fine, and I don't even think that the comment
needs updating. If you did want to clarify, I think you could say
something along the lines of what you wrote above ("`va` is a pointer to
an array element") and add something along the lines of "where the array
is the lookup table region of the .bitmap".

> > > +             ALLOC_ARRAY(xor_items, xor_items_alloc);
> >
> > This ALLOC_ARRAY() looks great to me. I wonder if we could amortize the
> > cost of allocating in this (somewhat) hot function by treating the
> > `xor_items` array as a reusable static buffer where we reset
> > xor_items_nr to 0 when entering this function.
> >
> > > +             while (xor_row != 0xffffffff) {
> > > +                     struct object_id xor_oid;
> > > +
> > > +                     if (xor_items_nr + 1 >= bitmap_git->entry_count) {
> > > +                             free(xor_items);
> > > +                             error(_("corrupt bitmap lookup table: xor chain exceed entry count"));
> >
> > I think we can probably `die()` here, we're pretty much out of luck in
> > this case.
> > ...
> > > +                             error(_("corrupt bitmap lookup table: commit index %u out of range"),
> > > +                                     triplet.commit_pos);
> >
> > Same here.
>
> I didn't use `die()` here because I thought returning NULL would be a
> better idea. In that case, Git can still do its job by using the
> traditional approach  - traversing  between objects.
> `load_bitmap_entries_v1` also returns NULL if an error occurs. What do
> you think?

Ah, I wasn't aware that our callers are graceful enough to handle this
like that. Yes, if we can fallback gracefully, we should, so I think
just error()-ing here (and above) is the right choice. Thanks for saying
so.

Thanks,
Taylor
