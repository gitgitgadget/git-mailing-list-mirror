Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A31C433FE
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 07:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB5822D6F
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 07:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbgLMHr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 02:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLMHr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 02:47:58 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07726C0613CF
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 23:47:18 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id q25so15479118oij.10
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 23:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHa0BLEIj3XhvhsmZXwiW6T0oegXLXM/2L0zkjZJy2s=;
        b=Ob31tqLH8V0RQcERwLyzAZN/s1+IvVvgK6ZHCQM1DiWlEJxatGfPwIK/fFOQCHf5l1
         0dsuEBThhvcBfX2pIfJiWTp1NsJWnFlbQ6Ia9fF/w0xujren4dFurKYZbQBksj9L8kSW
         B+C8oC/hx/aCuabbmEoiNTS2pOPODpuXv/cevme/xEzR45CTQCbHzNJ+yVBF272tMGch
         xPl6FCnDZ1iGdrw9QlZJQj7iNw3xcmkmCGo/2pyYGkNA8I2fCJ/QfTiWfji0ib9kiVF/
         UMd4MDqrL32jVD3vsoU/xJ9FmVG7DfCf7ectFj8KlPeGDcr18luyK9Wt5qmqPuvmFOMO
         Lrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHa0BLEIj3XhvhsmZXwiW6T0oegXLXM/2L0zkjZJy2s=;
        b=PeRbtrXtGmoCjKfFPimxfkEfGhWCUkw+L+X3e1CO8ToGoL12vtQbJm6mTJIv6OLLm7
         iMrPPnLt+w4LJpepnqOINlNgJ1KEB5KG/LsSM9xLRrM/FdxUclhABz+wCMgHyErJY597
         BiCISVdP1s9Jxvy75J1KteKZ04kVfVviWdKs0opaf9qO2kCwfgjNOZFWFYrEQeHmIdOu
         jHqe6LTe8eig1ohF2bFdw2AkE9ORocayYulcvxAC+RlQsMlcmunDtYmiJlyeZgNg7TDJ
         +tvSR/WHOQnjq6bQgG7QDCctG2JFJXjOt6pIYVy448D98Y566Yc6V89fqW8AbC8AvURn
         4WyA==
X-Gm-Message-State: AOAM532BGhNcVU5KaV+xXhUMzgnQmlngKEi8cB3AECpAVwzpPK6os0Xq
        cgPrw7zWNjtvCXBSNxudFJNA+QYymuuxVg/4E0cjYLdAzsMmMQ==
X-Google-Smtp-Source: ABdhPJxCMO6ff2Q+Zskt2MrIORfv3dtlKZ+6Wk1vVXIoVfbTBupLBmrFmapHaWt6xaX2i+oM6tQ6VRcvtjfxxIyL0hY=
X-Received: by 2002:a05:6808:991:: with SMTP id a17mr14550459oic.167.1607845637167;
 Sat, 12 Dec 2020 23:47:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <b9e0e1a60b92a6a220193bf9fe80796df91126a7.1607542887.git.gitgitgadget@gmail.com>
 <84a4d97b-8496-4c83-5d32-19f57e17a871@gmail.com>
In-Reply-To: <84a4d97b-8496-4c83-5d32-19f57e17a871@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 12 Dec 2020 23:47:06 -0800
Message-ID: <CABPp-BHa0zehQd-axmb4bF6fR4PTWwGu9uLjOzgTW8_Gu12iZA@mail.gmail.com>
Subject: Re: [PATCH 02/11] merge-ort: add initial outline for basic rename detection
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for two different email responses to the same email...

Addressing the comments on this patchset mean re-submitting
en/merge-ort-impl, and causing conflicts in en/merge-ort-2 and this
series en/merge-ort-3.  Since gitgitgadget will not allow me to submit
patches against a series that isn't published by Junio, I'll need to
ask Junio to temporarily drop both of these series, then later
resubmit en/merge-ort-2 after he publishes my updates to
en/merge-ort-impl.  Then when he publishes my updates to
en/merge-ort-2, I'll be able to submit my already-rebased patches for
en/merge-ort-3.

A couple extra comments below...

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
>
> enum merge_side {
>         MERGE_SIDE1 = 0,
>         MERGE_SIDE2 = 1,
> };
>
> (Note, I shift these values to 0 and 1, respectively, allowing
> us to truncate the pairs array to two entries while still
> being mentally clear.)

So, after mulling it over for a while, I created a

enum merge_side {
    MERGE_BASE = 0,
    MERGE_SIDE1 = 1,
    MERGE_SIDE2 = 2
};

and I made use of it in several places.  I just avoided going to an
extreme with it (e.g. adding another enum for masks or changing all
possibly relevant variables from ints to enum merge_side), and used it
more as a document-when-values-are-meant-to-refer-to-sides-of-the-merge
kind of thing.  Of course, this affects two previous patchsets and not
just this one, so I'll have to post a _lot_ of new patches...   :-)

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

Something I missed in my reply yesterday...

Note that mi->clean is NOT from struct merge_result.  It is from
struct merged_info, and in that struct it IS defined as "unsigned
clean:1", i.e. it is a true boolean.  The merged_info.clean field is
used to determine whether a specific path merged cleanly.

"clean" from struct merge_result is whether the entirety of the merge
was clean or not.  It's almost a boolean, but allows for a
"catastrophic problem encountered" value.  I added the following
comment:
/*
* Whether the merge is clean; possible values:
*    1: clean
*    0: not clean (merge conflicts)
*   <0: operation aborted prematurely.  (object database
*       unreadable, disk full, etc.)  Worktree may be left in an
*       inconsistent state if operation failed near the end.
*/

This also means that I either abort and return a negative value, or I
can continue treating merge_result's "clean" field as a boolean.

But again, this isn't new to this patchset; it affects the patchset
before the patchset before this one.

> If there is more meaning to values other than "clean" or
> "!clean", then an enum might be valuable.
>
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
>
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
>
> Thanks,
> -Stolee
