Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C59C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960CB64E2F
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhBIRpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbhBIRm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:42:27 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E079BC061756
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:41:28 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 18so9175502oiz.7
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTG+UEIU22ryFEFd7Te9LdGSsf8L+8/9it2+Wg97MO0=;
        b=Md5xabTykyD8hIABBAMncTzlvSSJg3rrCiFtGxFNO8adci8RRyLAbQBgzQsI2HDzJ5
         HlxJmlhy21vzMjMEbAOT4dAoyNreXbnt69kApYhSl3isk6QSXnggRk1Up/a1TrR51Uqw
         S7Mqm6+yaz+w+m/2Hh3Y3IiHDExd1dfqYccw3HFAQITajLyAIZwyrxDQzdaQCYTvoCfY
         e+CViiCqjC6eJcLSGa8wnPhiq5BAYbHgyOqTpStFE69EpshCxBCtRAEYwwx8kwS2BzFg
         lSuDiCq9OE5Mm49zoMua0lZ9KFoIccBuMb2lG3RTuYpg4dWmZNRa2hMz65w7/rG9suUE
         PADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTG+UEIU22ryFEFd7Te9LdGSsf8L+8/9it2+Wg97MO0=;
        b=hv1vKiEpYwU50jeKLf2FOPQpiMZ4gNG18RTjpRX4T1raes/npiwXGvAisPsg3VisJa
         YbSQM6RL+GwLJsgNppmzj2CKxWCOvU2z4D+rvysdsfu40FJElxEeA2MstS/4Iegd3BHt
         YzHRJhSnESaNHKGEbux9fn24v+HvS/UgsKUm1pq1m94lxIy2Er+8d+kAYeVaF0ngAYy/
         YqfQBSy2EfAwJhm9+u1BsyQ4XdWb0hICgQRLgWno3N20RUlLoxlXTGdK4TwSpSlCzo8H
         8nSiCxpHet5CIwoH1X1ctfYkMvndlUhehGyZJlW98oz7AiWZ3xIHDhtASq0cPtprxOd2
         anig==
X-Gm-Message-State: AOAM530BqmheLl7STERH2QBWH9XSF17ty0WtpxF+O2giKea9D/4mG1HW
        wRwf7rZmW2NZOG4IMjNPsuRk+xv6RYZhs+FiLVM=
X-Google-Smtp-Source: ABdhPJzcGflT5u1IE3zwViTXTCL9zc6pofFitUa4U0ttvbcxA8LM2xds+AUBZp84LlvnNK1ik7oFZmJn9Y9QKy691uw=
X-Received: by 2002:aca:550e:: with SMTP id j14mr3292334oib.31.1612892488293;
 Tue, 09 Feb 2021 09:41:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <pull.843.v2.git.1612870326.gitgitgadget@gmail.com> <ce2173aa1fb7ac3830bf8856a14558446e16a3dd.1612870326.git.gitgitgadget@gmail.com>
 <48a208c2-75fe-773e-aa2a-12a90dd06ddd@gmail.com>
In-Reply-To: <48a208c2-75fe-773e-aa2a-12a90dd06ddd@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Feb 2021 09:41:16 -0800
Message-ID: <CABPp-BFfF5rxbHwP1xnr63fPmp2=NkTZ-r0=FVZ1oVhAZD_s9w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] diffcore-rename: guide inexact rename detection
 based on basenames
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 9, 2021 at 5:33 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/9/2021 6:32 AM, Elijah Newren via GitGitGadget wrote:
> > +     num_sources = rename_src_nr;
> > +
> > +     if (want_copies || break_idx) {
> > +             /*
> > +              * Cull sources:
> > +              *   - remove ones corresponding to exact renames
> > +              */
> > +             trace2_region_enter("diff", "cull after exact", options->repo);
> > +             remove_unneeded_paths_from_src(want_copies);
> > +             trace2_region_leave("diff", "cull after exact", options->repo);
>
> Isn't this the same as
>
> > +     } else {
> > +             /* Determine minimum score to match basenames */
> > +             int min_basename_score = (int)(5*minimum_score + 0*MAX_SCORE)/5;
> > +
> > +             /*
> > +              * Cull sources:
> > +              *   - remove ones involved in renames (found via exact match)
> > +              */
> > +             trace2_region_enter("diff", "cull exact", options->repo);
> > +             remove_unneeded_paths_from_src(want_copies);
> > +             trace2_region_leave("diff", "cull exact", options->repo);
>
> ...this? (except the regions are renamed)
>
> Could this be simplified as:
>
> +       num_sources = rename_src_nr;
> +
> +       trace2_region_enter("diff", "cull after exact", options->repo);
> +       remove_unneeded_paths_from_src(want_copies);
> +       trace2_region_leave("diff", "cull after exact", options->repo);
> +
> +       if (!want_copies && !break_idx) {
> +               /* Determine minimum score to match basenames */
>
> I realize you probably changed the region names on purpose to distinguish
> that there are two "cull" regions in the case of no copies, but I think
> that isn't really worth different names. Better to have a consistent region
> name around the same activity in both cases.

Actually, the reason they were split is because a later series has to
call remove_unneeded_paths_from_src() differently for the two
branches.  The patch history was so dirty that the easiest way to
clean things up was just to create completely new patches pulling off
relevant chunks of code and touching them up; while doing that, I
didn't notice that the changes I made to split out this early series
resulted in this near-duplication.

So, I can join them...but they would just need to be split back out in
my "Optimization batch 9" series.

I'm happy to fix the region name to make them the same.  Is that good
enough, or would you rather these common code regions combined for
this patch and then split out later?

>
> > +             int min_basename_score = (int)(5*minimum_score + 0*MAX_SCORE)/5;
>
> Did you intend for this to be 5*min + 0*MAX? This seems wrong if you want
> this value to be different from minimum_score.

In my cover letter I noted that I didn't know what to set this to and
wanted input; yesterday you said it wasn't worth worrying about using
a different value, but Junio suggested we should use one (but didn't
state how much higher it should be or whether it should be user input
driven).  This weird construct was here just to show that it is easy
to feed a different score into the basename comparison than what is
used elsewhere; I can fix it up once I get word on what Junio wants to
see.

Since I didn't know what to use, though, and I didn't want to get a
different set of numbers for the final commit message on the speedup
achieved if I'm just going to throw them away and recompute once I
find out what Junio wants here, I did intentionally set the
computation to just give us minimum_score, for now.

> > +
> > +             /* Utilize file basenames to quickly find renames. */
> > +             trace2_region_enter("diff", "basename matches", options->repo);
> > +             rename_count += find_basename_matches(options,
> > +                                                   min_basename_score,
> > +                                                   rename_src_nr);
> > +             trace2_region_leave("diff", "basename matches", options->repo);
> > +
> > +             /*
> > +              * Cull sources, again:
> > +              *   - remove ones involved in renames (found via basenames)
> > +              */
> > +             trace2_region_enter("diff", "cull basename", options->repo);
> > +             remove_unneeded_paths_from_src(want_copies);
> > +             trace2_region_leave("diff", "cull basename", options->repo);
> > +     }
> > +
>
> Thanks,
> -Stolee
