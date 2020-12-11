Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E586C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E4A23F34
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393798AbgLKJmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 04:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388383AbgLKJmB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 04:42:01 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E7CC0613D3
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:41:21 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id y24so7684750otk.3
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4q8ynOu0C2uUZvoUJ8DjZpmziVlrXzXl7gOKmk2f4s=;
        b=A9ciZZwAOmqudejfahOlwYtv7yBN8I3JAHW1bdQrLP7QK8FZk8zcX+h4lx5ztdEmbo
         tJystTp1Twa79gLBWBorXe/yI2SebW1HJ1nC5GOfPsgXicbM+gVZcbg99h4l3zHiHE6W
         Sy43Ed+zwIFFhlHWid0YNVvhsZNK3f30xgKtqG+z16IcTs2HESztTo3Jp9x+S6OgmIxe
         bOszWpQf6UyTwUAx4lhhz5NIMtRH05wAXBIB35B99tSay40s7cfPwCyAdcRmsgW+vnqr
         jEvgixIRLwtwoYlcwz3X//xvf3TBthSq4qiq6HE07ktl4c7eXaucLd1/V8bpAXIGXM/C
         BHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4q8ynOu0C2uUZvoUJ8DjZpmziVlrXzXl7gOKmk2f4s=;
        b=LLbSYGTKuQWMgbXZmTHG1YyVG8a5Dzz5YWJ/J4yeOo1dNTDSCdOsXSgxu4Q2hPOKNw
         ZtnCwPWB0BnEW5r/24QVrn9ayTkxmuJ1foY/uO50EdC5VWoMluWn3M9DDIQaPobikbsj
         glUytGC+C0rGKZBIWEhchbpQckZN21drCrjic1g+QUNebxYmE25A+J+LORRhYRnGnz+n
         SxFOVDFrVxGEDaPmLxcmaYO1G77G08gOWDN7p6uIhWKtJNKgAB6dFmSIMvxTm7u8AT+J
         psc8itxk2IjlpJWg7FBMeSH7D+PpmYxypmGqJUnyIiM/zg0g//EZB2Nm9w/MFBVNzNt8
         U6JA==
X-Gm-Message-State: AOAM532SCvu0QFqCMTNPhRYEQis5d/Y4yCGa55kkjLLpISNr34m2h9jN
        H/UFAR51ulLht61WDXrPrz6TBx2YHdJLfccMj8yvVosCl+8=
X-Google-Smtp-Source: ABdhPJzGy4XEMFWp6hacY0oKqBPb5wL3c72y9KWGODdQfMcvF/0knXpCf08pacMbfHreb8uTqWex07/OZIpmvhzFZcU=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr9149001otr.345.1607679680673;
 Fri, 11 Dec 2020 01:41:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <ef8f315f828319a3390fde14e3aee6c5e587405e.1607542887.git.gitgitgadget@gmail.com>
 <38f68a01-4d22-d88d-dfda-c85f67340819@gmail.com>
In-Reply-To: <38f68a01-4d22-d88d-dfda-c85f67340819@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Dec 2020 01:41:09 -0800
Message-ID: <CABPp-BG5_PzmKMV6YMs+fkTB-NFqDbJhduNoOWY5nt+wCE006Q@mail.gmail.com>
Subject: Re: [PATCH 01/11] merge-ort: add basic data structures for handling renames
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 6:03 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/9/2020 2:41 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > This will grow later, but we only need a few fields for basic rename
> > handling.
>
> Perhaps these things will be extremely clear as the patch
> series continues, but...
>
> > +struct rename_info {
> > +     /*
> > +      * pairs: pairing of filenames from diffcore_rename()
> > +      *
> > +      * Index 1 and 2 correspond to sides 1 & 2 as used in
> > +      * conflict_info.stages.  Index 0 unused.
>
> Hm. This seems wasteful. I'm sure that you have a reason to use
> index 0 in the future instead of just avoiding instances of [i-1]
> indexes.

Yes, it is...and it gets more wasteful when I increase the number of
fields that are arrays of size 3 with none of them using index 0.
Currently, there's only 1 such field; later there will be 10.

However, this does not scale with the number of files or size of the
repository or anything like that; it's a flat overhead.  At this point
in my patch submissions, that overhead is 16 bytes per merge.  Later
when I have 10 variables that are arrays of size three, it'll be 940
bytes per merge.

I'm not planning on using index 0 later; the reason for this really is
to avoid off-by-one errors (it's one of the two biggest problems in
computer science, right?).  The off-by-one problem becomes huge when
you consider all the references:

* The conflict_info type has stages which is an array of size three --
index 0 is always the base commit, index 1 is side1, and index 2 is
side2.  There is one of these per path involved in the merge, and are
used all over the place, so it's nice to think in terms of "1 is
side1, 2 is side2".  (There is also a pathnames variable of size three
with the same indexing rules, and a bunch of bitmasks that rely on
2<<0 == base, 2<<1 == side1, and 2<<2 == side2.)

* These other 10 variables that are arrays of size 3 in the
rename_info struct are all keeping track of information for side1 and
side2.  When you consider the number of references for all 10 of them
combined across the codebase, it adds up to quite a bit.

I'm certain that if I would have had to use off-by-one indexing for
these 10 variables, while using not-off-by-one indexing for the stages
and pathnames in conflict_info, I'm certain I would have messed it up
many dozen times and spent countless hours tracking down bugs.  And I
think the result would be a lot harder to review.  And future
developers would come along and fall into that trap and get various
indices off.

I'm willing to pay a one-time overhead of 940 bytes to avoid that.

> > +      */
> > +     struct diff_queue_struct pairs[3];
> > +
> > +     /*
> > +      * needed_limit: value needed for inexact rename detection to run
> > +      *
> > +      * If the current rename limit wasn't high enough for inexact
> > +      * rename detection to run, this records the limit needed.  Otherwise,
> > +      * this value remains 0.
> > +      */
> > +     int needed_limit;
> > +};
> > +
> >  struct merge_options_internal {
> >       /*
> >        * paths: primary data structure in all of merge ort.
> > @@ -96,6 +115,11 @@ struct merge_options_internal {
> >        */
> >       struct strmap output;
> >
> > +     /*
> > +      * renames: various data relating to rename detection
> > +      */
> > +     struct rename_info *renames;
> > +
>
> And here, you create this as a pointer, but...
> >       /* Initialization of opt->priv, our internal merge data */
> >       opt->priv = xcalloc(1, sizeof(*opt->priv));
> > +     opt->priv->renames = xcalloc(1, sizeof(*opt->priv->renames));
>
> ...unconditionally allocate it here. Perhaps there are other cases
> where 'struct merge_options_internal' is allocated without the renames
> member?
>
> Searching merge-ort.c at this point does not appear to have any
> other allocations of opt->priv or struct merge_options_internal.
> Perhaps it would be best to include struct rename_info not as a
> pointer?

That's a really good point; I'll try it out.

> If you do have a reason to keep it as a pointer, then perhaps it
> should be freed in clear_internal_opts()?

Eek.  It's there in my 'ort' branch, but one of the problems trying to
rearrange and clean things up to make nice digestible series is that
you sometimes forget to bring important parts along.  Whoops; good
catch.  I'm going to try just turning renames into an embedded struct
instead of a pointer, though.  If it doesn't work out, I'll make sure
to clear it.
