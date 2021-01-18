Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765F9C433E6
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F75A22E00
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437932AbhARUQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 15:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437923AbhARUQD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 15:16:03 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0576C0613C1
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:15:22 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id o11so17549398ote.4
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rE0P6DrNTY+/mA3g4wpSf62T6yMIjk0+U/GO/rgq4E=;
        b=a0ZE+b31c6qssvCzH81jzRRZ/gw+SNpdMObF3z2y4RduNuXMk0cRP+JNTV9PFfUKeP
         YPfmfBQ0De74cjgWd/j98QmwOtKA/YQVWZJkYWJj3CLfS8+oyolvQL8ZMZcHT7xF2wj1
         iDN3Ix4dkxuEXenph9xwYduMhHCNLBO3jOmpXaoK3qXFFanS64ytGcc+Q89bsyjxEGaW
         pRCWTMgICxXq1/xzQMqTtw5D5QTL50zEPcfX9XGydUjG+EFdYgBsdmWzAHONf50kKZ4f
         Jyh6eiVU3QxD8TPXnT0TEudHuabtEQh7KFPPYuOR+LRC7Mbf3jZkIVbVZDNS6mC4MGa2
         jkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rE0P6DrNTY+/mA3g4wpSf62T6yMIjk0+U/GO/rgq4E=;
        b=TMvac6Ry6t8KujSpMsfk+tQe3875xsSgQCNwPgvrydaShrZXn9sIPxgbwZ5gH4vJas
         zYZAqDElsqZ5Eb7W1C8sUbnAo/7VvgYmrC7CAzCUkxh2zedVJg2l4G3Z0stlni0X/Ii3
         WO3oZr5EfzKQWNbg0q1gdXn8N+zeCpHn0iS/AVWG6cGWoQvP3UqKxCHM9HRczyWf66+5
         g4TvkNBLtv6Lt4CqpS+SkGpwTVo4AgOpJ+cyOIQRVm/19bBLZjfo2Us0sIqRCMYskzlM
         dcl+PQFwxjZncU0+td1JxPJD+jTa55bCo0FrG2+QHP7V6Ph7hgI089Gj5RlCr06N1ryX
         QU7g==
X-Gm-Message-State: AOAM531K/wcJyEc/DBpUh3032EWCPqZapPOpXylWWHZImLdXigRF4ecz
        yRhYmxRUNtKWCNn1D505g8wCiNmtMumaVEtN3EQ=
X-Google-Smtp-Source: ABdhPJz0s+E1/mvrTAGtDdvOp78EDLkYznmlCjuiM4RIUASsiWfqpaS4bAPnCQqtautjcQxxl9FVeVXMtD6dNuY4Muc=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr910853otr.345.1611000922021;
 Mon, 18 Jan 2021 12:15:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
 <pull.835.v2.git.1610055365.gitgitgadget@gmail.com> <ccb30dfc3c4c9ad2fc7cd33dc72ecf768827ed9f.1610055365.git.gitgitgadget@gmail.com>
 <YAXnfwGpvhtxbQhF@nand.local>
In-Reply-To: <YAXnfwGpvhtxbQhF@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Jan 2021 12:15:11 -0800
Message-ID: <CABPp-BE+NmuFE-Vj8dAzs-Jdsz_ruDE6P_GhAKfrFAe-sJcNEg@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] merge-ort: add outline for computing directory renames
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 18, 2021 at 11:54 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Jan 07, 2021 at 09:35:52PM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Port some directory rename handling changes from merge-recursive.c's
> > detect_and_process_renames() to the same-named function of merge-ort.c.
>
> Thanks, having the source be explicitly named makes it much easier to
> check over the reimplementation.
>
> > This does not yet add any use or handling of directory renames, just the
> > outline for where we start to compute them.  Thus, a future patch will
> > add port additional changes to merge-ort's detect_and_process_renames().
>
> Noted.
>
> > @@ -1086,13 +1098,24 @@ static int detect_and_process_renames(struct merge_options *opt,
> >  {
> >       struct diff_queue_struct combined;
> >       struct rename_info *renames = &opt->priv->renames;
> > -     int s, clean = 1;
> > +     int need_dir_renames, s, clean = 1;
> >
> >       memset(&combined, 0, sizeof(combined));
> >
> >       detect_regular_renames(opt, merge_base, side1, MERGE_SIDE1);
> >       detect_regular_renames(opt, merge_base, side2, MERGE_SIDE2);
> >
> > +     need_dir_renames =
> > +       !opt->priv->call_depth &&
> > +       (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE ||
> > +        opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT);
>
> Would it be worth it to DRY up this and merge-recursive.c's
> implementation, perhaps:
>
>   int needs_dir_renames(struct merge_options *opt)
>   {
>     return !opt->priv->call_depth &&
>       (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE ||
>        opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT);
>   }
>
> and then calling that in both places?

If the intent was to keep merge-recursive.c indefinitely, then yes it
would.  However, the intent is to (1) avoid touching merge-recursive.c
so I don't destabilize it and so folks can fall back to it, (2) get
merge-ort.c completed, and people to adopt and feel confident in it,
(3) delete merge-recursive.[ch].

This has come up a few other times in a review on the series, because
there are even examples of copied-and-unmodified functions; see
https://lore.kernel.org/git/CABPp-BGtpXRSz+ngFz20j8W4qgpb8juogsLf6HF7b0-Pt=s6=g@mail.gmail.com/
and https://lore.kernel.org/git/CABPp-BEEoqOer11BYrqSVE9E4HcT5MNWcRm7ZHBQ7MVZRUDVXw@mail.gmail.com/.
I know it seems weird to intentionally repeat, but since the goal is
to nuke merge-recursive.c, I'm doing it as a temporary measure.

>
> > +     if (need_dir_renames) {
> > +             for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++)
> > +                     get_provisional_directory_renames(opt, s, &clean);
>
> Not necessarily related to this patch, but just something that I noticed
> while reading the series: I don't find this for-loop to be any clearer
> than:
>
>   if (need_dir_renames) {
>     get_provisional_directory_renames(opt, MERGE_SIDE1, &clean);
>     get_provisional_directory_renames(opt, MERGE_SIDE2, &clean);
>     /* ... */
>   }
>

That also makes it more similar to the calls I make to
detect_regular_renames() above, where I explicitly called it twice
instead of using a loop.  I like the suggested change; I'll update it.

> In fact, I think that I find the above clearer than the for-loop.
> There's no opportunity to write (...; s < MERGE_SIDE2) when you meant
> (...; s <= MERGE_SIDE2), and seeing two lines explicitly makes it
> clearer that you're really doing the same thing to each side of the
> merge.
>
> Anyway, I may feel totally different than others, and of course I
> haven't read many of the previous series as closely as this (and so this
> may already be an established pattern and I'm just cutting against the
> grain here), but those are my $.02.
>
> Thanks,
> Taylor

As always, thanks for the review!
