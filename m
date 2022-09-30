Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D036C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 16:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiI3QYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 12:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiI3QX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 12:23:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18C6129FEA
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 09:23:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y8so6638929edc.10
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zKUAf1WyUftUgmC8FSYyWlKYMJFTRynE63L38JCYMGw=;
        b=UkRvPKlwM57Y6ZgR9h8YqORagM056tvJkckMCFcFJfvePIIfm7tXlIOSIIw51cCu6m
         TttRf3cTst0yXW7j3efSFBfz9fVwEyn4+oS9Cm7jlPfpC5XUQuMVB7pBUI132cOID8my
         boDi5VIG45NdbFq3LGHUmSfPIHlaRgqwvM96dkl2OvuPzaIPmCh3GrX045GbxPzTJuE/
         zzpog1AUQAIomu2QLtnD2tMj3cvwz4ou+QmkAQ3dYxwalJBFKZKGyl3lGKcr3C7KOg9d
         9UtC1f/hIS81YpQx9yyJcZjS/8gUL4ncrGp9GUo2/SojLqKPXwgIl7rMdeQiMUTI/je5
         tWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zKUAf1WyUftUgmC8FSYyWlKYMJFTRynE63L38JCYMGw=;
        b=tX7Ioy3xBIGrfYYzVXewePza9ft9TiuB3/Uh4FTZC6quZauU3MUMTFj59r/1NRCDA2
         UXa+AxC7QBTuqWBpSa2XuJ/fjvKqxgIaS7OJrEsskJ4oxr8KweCBWsuL/yt60H83o7A0
         KGvzrWgi2zxWoZyQqcNTU6M5Xth1Fchf7HQnVFYcfnV8eFrZjjh6jxMLWjf7zzEwLP9y
         y56nDqpX3+Ztld7PFid8bnyO2DncHqo0pymk7NiCDk02Cs+xEHCcthNv51BxpDfOZAKM
         YhxPVUaJNCeRt8HadN0mqbJYQSmOuImB/ZhzfUfwcP//1FuVq3evh6Z21wJoNEmwoEZT
         UExQ==
X-Gm-Message-State: ACrzQf3AqyUXvDFEZJD6XxcnbnW1C9/4iwRFmgRZpPF0/kRQWOhxFBBV
        wW3HCpNGGKiy/qmvGzRVE1OR4vVdfpnun9jGLfckDizXRZn7Hw==
X-Google-Smtp-Source: AMsMyM6y1+4G5J01udoUjWLzbMXP1bQtHI93p4KXSo7Mbc4JTiRdY3nRoGxq7M8ziVYvtxQZjBBuVWkqsClh2tq99mU=
X-Received: by 2002:a05:6402:26d3:b0:451:6ca9:bc5e with SMTP id
 x19-20020a05640226d300b004516ca9bc5emr8307637edd.325.1664555037171; Fri, 30
 Sep 2022 09:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
 <4364224f9bddc8f1e40875ebc540b28225317176.1663609659.git.gitgitgadget@gmail.com>
 <xmqqczbdl6wl.fsf@gitster.g>
In-Reply-To: <xmqqczbdl6wl.fsf@gitster.g>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Fri, 30 Sep 2022 21:53:45 +0530
Message-ID: <CAPOJW5yxRETdVk014gQYFud9_Nrt+OQGSVNQ8Pw2wDEMMFMm1Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] roaring: teach Git to write roaring bitmaps
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2022 at 11:51 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> >
> > Roaring bitmaps are said to be more efficient (most of the time) than
> > ewah bitmaps. So Git might gain some optimization if it support roaring
> > bitmaps. As Roaring library has all the changes it needed to implement
> > roaring bitmaps in Git, Git can learn to write roaring bitmaps. However,
> > all the changes are backward-compatible.
> >
> > Teach Git to write roaring bitmaps.
>
> That is way underexplained.   At least cover what the plans are, so
> that readers do not have to ask these questions:
>
>  * When is the choice of bitmap type is made?  Is it fixed at
>    repository initialization time and once chosen other kinds cannot
>    be used?
>
>  * Is the bitmap file self describing?  How does a reader know
>    between ewah and roaring codepaths to use to read a given bitmap
>    file?  Is there enough room for extending the set of bitmap
>    formats, or we cannot add other formats easily?

Hey Junio,

First of all, sorry that the next version is taking so much time to
land. We have a festival ("Durga Puja"; it is the biggest festival for
Bengalis) going on here now. So I am not that active.

I will explain briefly in the next version.

>
> Do you really need the global variable that holds the bitmap type?
>
> Wouldn't it be easier to write code that needs to deal with both
> types (e.g. in a repository with existing ewah bitmap, you want to
> do a repack and index the result using the roaring bitmap) if you
> passed the type through the callchain as a parameter?

I didn't want to go for "passing the type through the callchain as a
parameter" because that would cause changes to every affected function
definition. I found the "global variable" approach simpler for this
reason. Here we have to initialize the type once and the affected
functions will work accordingly.

If you like the "callchain" approach, I have no problem to implement it.

> It may be that the codepath that reads from an existing bitmap file
> says "ah, the file given to us seems to be in format X (either EWAH
> or ROARING or perhaps something else), so let's call bitmap_init(X)
> to obtain the in-core data structure to deal with that file".  When
> that happens, you may probably need to have two cases in the default:
> arm of this switch statement, i.e. one to diagnose a BUG() to pass
> an uninitialized bitmap type to the codepath, and the other to
> diagnose a runtime error() to have read a bitmap file whose format
> this version of Git does not understand.

Ok, understood. Thanks.

> These repetitive patterns makes me wonder if void *bitmap
> is a good type to be passing around.  Shouldn't it be a struct with
> its first member being a bitmap_type, and another member being what
> these functions are passing to the underlying bitmap format specific
> functions as "bitmap"?  E.g.
>
>     void bitmap_unset(struct bitmap *bm, uint32_t i)
>     {
>         switch (bm->type) {
>         case EWAH:
>                 ewah_bitmap_remove(bm->u.ewah, i);
>                 break;
>         ...

Good idea! Thanks.

> > +
> > +enum bitmap_type {
> > +     INIT_BITMAP_TYPE = 0,
>
> "UNINITIALIZED_BITMAP_TYPE", probably.

Ok.

> > +void *roaring_or_ewah_bitmap_init(void);
>
> I would strongly suggest reconsider these names.  What if you later
> want to add the third variant?  roaring_or_ewah_or_xyzzy_bitmap_init()?
>
> Instead just use the most generic name, like "bitmap_init", perhaps
> something along the lines of ...
>
>     struct bitmap {
>         enum bitmap_type type;
>         union {
>             struct ewah_bitmap *ewah;
>             struct roaring_bitmap *roaring;
>         } u;
>     };
>
>     struct bitmap *bitmap_new(enum bitmap_type type)
>     {
>         struct bitmap *bm = xmalloc(sizeof(*bm));
>
>         bm->type = type;
>         switch (bm->type) {
>         case EWAH:
>             bm->u.ewah = ewah_new();
>             break;
>         case ROARING:
>             bm->u.roaring = roaring_bitmap_create();
>             break;
>         default:
>             die(_("unknown bitmap type %d"), (int)type);
>         }
>         return bm;
>     }

Got it. It seems a better option than the current one.

Thanks )
