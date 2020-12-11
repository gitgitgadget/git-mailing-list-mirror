Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C497C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADA823ECD
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392137AbgLKJlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 04:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgLKJlk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 04:41:40 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E49C0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:41:00 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f16so7656516otl.11
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkT/RFEhwTfQzYmvBf9MdTUDsPibo5q7mIq3GtzSxgw=;
        b=FPEkG1Ax/GjBtIh/wy3PRk5ypc2BE7FCVpmqqN4qJW6toWbERT+s9F353Tbx4uWi+p
         IiE2HvpIrn6qYhYUJyDvQR5Yo1cxOEv4pQXVtE36xyQkIF73R072A/vUoNoQzgCprPNz
         arTZ2yRr1JVqSV6jxzEMoyPyJXrbqJXXCUxyn/8mZ8JU796JZgeMuzy2RSasT8KssMRB
         IPAKFoso+06j3uWFjh6D/H1XM9DsqQobnPuR0BNPgAcxHVgImIMFUcDBVW2CaeJKdrPH
         hA4zp9XCvIB2H+vz5Y2lKPgpzBP+W9DUXxhXRQsYHjSf7zrk/omHFk0nV407TqqXdHA8
         4Tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkT/RFEhwTfQzYmvBf9MdTUDsPibo5q7mIq3GtzSxgw=;
        b=IjDuShtygcLVtbKwiLDhdWK7PuoFws5MuC+NPgVU+Pvl0SLsqbqq8LNS31ts+0Z/B/
         VQJ0mn6A7jDjTBDlOHePEJqdSBGBlrNdZUJwI+YvsPl1tgE5OPFa+7slaVaDK/Y1MlTe
         UTHEnM4vkrMkyR7B7LUlO5MaL/pA4RwLWRRKvUacuGZosh0D2+/eZDstaMNSp00+3TkQ
         69aYArFFMCj/1ziV0KYqCa5RcsLZaTAEQywrXlLTh/ERaUcPrD51DEPWCfFat6rymwxC
         kMUvB9A4aOe/UzsoBSepocRlfDMdjnwDf8pTdRLD7DDSaEhpuvOAEk6rgnSOudHSLq2M
         Epcg==
X-Gm-Message-State: AOAM530PXjL/OKzgWAH2jTQGsi3mDDTameJCYN1uChecIb7+MFm4kJCp
        wgSc0WgMn1NkR1ST1t6CJiEgLjAyyf04bgBwcKc=
X-Google-Smtp-Source: ABdhPJx7AcdqBWIuugETw5BVX/lCdnq/6OQCPAMYc4Bmq0Q0q3VLznw+YYU2hhK1ht67/oJgyN+T6pUYhQjyGs624Ms=
X-Received: by 2002:a05:6830:10:: with SMTP id c16mr9037078otp.162.1607679659325;
 Fri, 11 Dec 2020 01:40:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <b9e0e1a60b92a6a220193bf9fe80796df91126a7.1607542887.git.gitgitgadget@gmail.com>
 <84a4d97b-8496-4c83-5d32-19f57e17a871@gmail.com>
In-Reply-To: <84a4d97b-8496-4c83-5d32-19f57e17a871@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Dec 2020 01:40:48 -0800
Message-ID: <CABPp-BGNvZv9KNnnwGEz_sv9MV8zNTRjXGQ=gBd6kEy+NuEJbg@mail.gmail.com>
Subject: Re: [PATCH 02/11] merge-ort: add initial outline for basic rename detection
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 6:39 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/9/2020 2:41 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 60 insertions(+), 8 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 90baedac407..92b765dd3f0 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -617,20 +617,72 @@ static int handle_content_merge(struct merge_options *opt,
> >
> >  /*** Function Grouping: functions related to regular rename detection ***/
> >
> > +static int process_renames(struct merge_options *opt,
> > +                        struct diff_queue_struct *renames)
> > +static int compare_pairs(const void *a_, const void *b_)
> > +/* Call diffcore_rename() to compute which files have changed on given side */
> > +static void detect_regular_renames(struct merge_options *opt,
> > +                                struct tree *merge_base,
> > +                                struct tree *side,
> > +                                unsigned side_index)
> > +static int collect_renames(struct merge_options *opt,
> > +                        struct diff_queue_struct *result,
> > +                        unsigned side_index)
>
> standard "I promise this will follow soon!" strategy, OK.
>
> >  static int detect_and_process_renames(struct merge_options *opt,
> >                                     struct tree *merge_base,
> >                                     struct tree *side1,
> >                                     struct tree *side2)
> >  {
> > -     int clean = 1;
> > +     struct diff_queue_struct combined;
> > +     struct rename_info *renames = opt->priv->renames;
>
> (Re: my concerns that we don't need 'renames' to be a pointer,
> this could easily be "renames = &opt->priv.renames;")

Yeah, there'll be a lot of these...

>
> > +     int s, clean = 1;
> > +
> > +     memset(&combined, 0, sizeof(combined));
> > +
> > +     detect_regular_renames(opt, merge_base, side1, 1);
> > +     detect_regular_renames(opt, merge_base, side2, 2);
>
> Find the renames in each side's diff.
>
> I think the use of "1" and "2" here might be better situated
> for an enum. Perhaps:

I can see where you're coming from...but that's a monumentally huge
shift.  What about all my "loops over the sides"?  Sure, the ones that
are only two lines long could be just turned into code without a loop,
but when the loop is 140 lines long, that doesn't make much sense.
Loop over enum ranges?

Are all the variables that track an index still okay?    Do I need to
also introduce an enum for all the filemask/dirmask/match_mask/etc.
variables:

enum merge_mask {
     MERGE_JUST_BASE = 1,
     MERGE_JUST_SIDE1 = 2,
     MERGE_BASE_AND_SIDE1 = 3,
     MERGE_JUST_SIDE2 = 4,
     MERGE_BASE_AND_SIDE2 = 5,
     MERGE_SIDE1_AND_SIDE2 = 6,
     MERGE_BASE_AND_SIDE1_AND_SIDE2 = 7
}

?  That seems like a pretty big pain to use.

Also, what about the code that uses a side index to get the other side
index?  Or my conversions from side indices to masks (or vice versa)?
I tend to put comments by these, but there's a _lot_ of them.


I suspect this one would take a week to change, and I'd miss several
locations, and....some cases would certainly look cleaner but I
suspect some would be far uglier and end up being unchanged and then
leave us with a mess of trying to understand both.

What if I added a big comment near the top of the file that we've got
dozens of variables that are arrays of size 3 which are meant to be
indexed by the "side" of the three-way merge that it is tracking
information for:
    0: merge_base
    1: side1
    2: side2
(though several of the variables might have index 0 unused since it
doesn't track anything specifically for the merge base), and further
that masks are used in certain variables which try to track which
sides are present or match, with 2<<SIDE being the bit to track that a
given side is present/relevant.

I mean, this stuff is all over the place throughout the 4500 line
merge-ort.c file.  And it is in lots of diffcore-rename.c (which will
grow by about 1K lines as well).

> enum merge_side {
>         MERGE_SIDE1 = 0,
>         MERGE_SIDE2 = 1,
> };
>
> (Note, I shift these values to 0 and 1, respectively, allowing
> us to truncate the pairs array to two entries while still
> being mentally clear.)

As mentioned in the previous patch, the shift of the indices would
cause me at least a large amount of mental confusion and I suspect it
would for others too.  Both conflict_info.stages[] and
conflict_info.pathnames[] are meant to be indexed by the side of the
merge (or the base), but using conflict_info.stages[MERGE_SIDE1] or
conflict_info.pathnames[MERGE_SIDE2] as you have them defined here
would provide the wrong answer.  Since there's a conflict_info per
file and it is used all over the code, this would just be ripe for
off-by-one errors.

Since both conflict_info.stages[] and renames->pairs[] are meant to be
indexed by the merge side, this kind of conflict is inevitable.  The
only clean solution is making both be arrays of size three, and just
skipping index 0 in the variables that don't need to track something
for the merge_base.

> > +
> > +     ALLOC_GROW(combined.queue,
> > +                renames->pairs[1].nr + renames->pairs[2].nr,
> > +                combined.alloc);
> > +     clean &= collect_renames(opt, &combined, 1);
> > +     clean &= collect_renames(opt, &combined, 2);
>
> Magic numbers again.
>
> > +     QSORT(combined.queue, combined.nr, compare_pairs);
> > +
> > +     clean &= process_renames(opt, &combined);
>
> I need to mentally remember that "clean" is a return state,
> but _not_ a fail/success result. Even though we are using
> "&=" here, it shouldn't be "&&=" or even "if (method()) return 1;"
>
> Looking at how "clean" is used in struct merge_result, I
> wonder if there is a reason to use an "int" over a simple
> "unsigned" or even "unsigned clean:1;" You use -1 in places
> as well as a case of "mi->clean = !!resolved;"

Heh, when I used an unsigned for a boolean, Jonathan Tan asked why I
didn't use an int.  When I use an int for a boolean, you ask why I
don't use an unsigned.  I think my stock answer should just be that
the other reviewer suggested it.  ;-)

> If there is more meaning to values other than "clean" or
> "!clean", then an enum might be valuable.

Yeah, this came from unpack-trees.c and merge-recursive.c, where the
value is usually 1 (clean) or 0 (not clean), but the special value of
-1 signals something went wrong enough that we need to stop further
processing and return up the call chain for any necessary cleanup
(e.g. removal of lock files).  The value of -1 is only used for things
like "disk-is-full, can't write any more files to the working
directory", or "failed to read one of the trees involved in the merge
from the git object store".

-1, though, is the return value from unpack_trees(), traverse_trees(),
and perhaps other places in the code, so I'd be worried about
attempting to use a different special value for fear that I'd miss
converting the return value I got from one of those to the new special
value.

merge-ort has far fewer locations where -1 appears (in part because
the checkout() code is an external function rather than being
sprinkled everywhere), and it tends to cause the code to return
immediately, so most all call sites can assume a simple boolean value
of either 0 or 1.

> > +     /* Free memory for renames->pairs[] and combined */
> > +     for (s = 1; s <= 2; s++) {
> > +             free(renames->pairs[s].queue);
> > +             DIFF_QUEUE_CLEAR(&renames->pairs[s]);
> > +     }
>
> This loop is particularly unusual. Perhaps it would be
> better to do this instead:
>
>         free(renames->pairs[MERGE_SIDE1].queue);
>         free(renames->pairs[MERGE_SIDE2].queue);
>         DIFF_QUEUE_CLEAR(&renames->pairs[MERGE_SIDE1]);
>         DIFF_QUEUE_CLEAR(&renames->pairs[MERGE_SIDE2]);

If this were the only one, then I'd absolutely agree.  There's 7 such
loops in the version of merge-ort.c in the 'ort' branch.  I can't get
rid of all of them, because even though some are short, some of those
are very long for-loops.  (The long ones use "side" for the loop
counter instead of "s" -- maybe I should use "side" even on the short
ones?)

There's also another 6 that loop over the sides including the
merge-base (thus including index 0).  If those count, it's closer to
13.

> > +     if (combined.nr) {
> > +             int i;
> > +             for (i = 0; i < combined.nr; i++)
> > +                     diff_free_filepair(combined.queue[i]);
> > +             free(combined.queue);
> > +     }
> >
> > -     /*
> > -      * Rename detection works by detecting file similarity.  Here we use
> > -      * a really easy-to-implement scheme: files are similar IFF they have
> > -      * the same filename.  Therefore, by this scheme, there are no renames.
> > -      *
> > -      * TODO: Actually implement a real rename detection scheme.
> > -      */
> >       return clean;
>
> I notice that this change causes detect_and_process_renames() to
> change from an "unhelpful result, but success" to "die() always".
>
> I wonder if there is value in swapping the order of the patches
> to implement the static methods first. Of course, you hit the
> "unreferenced static method" problem, so maybe your strategy is
> better after all.

I used to do that kind of thing, but the unreferenced static method
problem is really annoying.  It means the code doesn't even compile,
which is a bad state to submit patches in.  I can work around that by
adding "(void)unused_funcname;" expressions somewhere in the code, but
reviewers tend to be even more surprised by those.
