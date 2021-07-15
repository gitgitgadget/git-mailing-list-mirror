Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEECDC07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A4F613F9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhGOQ4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbhGOQ4y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 12:56:54 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE82C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:54:01 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id e11so4358078oii.9
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Yu4Q1hWxr6JTSOgfKvXAV1wkRtRaIUmFCYRqrKizZA=;
        b=dzK7yNp+PImqc67JLRF+sl9BsQBWy7RPcLOnimIaRlw7wOuDLdBV6U9JRHowvVuge/
         2AYYmYIBcInmLX+FPc/zofoMJGCDJvIV9DpOZ95ckmPYM6I1cZ3JDYPh+xn+Fitclv83
         zRw13RlgphDnCC9lKBxFy2h/69gkWHOW5P1bUO+U+uHWm9AAn/gQLjvvkUJuZbtQ75Df
         A25TASst2uYJB3tmE/QQ+l9uX9nLYB20IJYeKQU3bKmVKua8hGunMngO3FYttSIBQ+Ma
         cMxh3pNK0HoGbcQy1n48LJ/rX4zUUFrxjhe9MVBXMoVygP7UdJ84xkEmswANw+rIfyla
         jHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Yu4Q1hWxr6JTSOgfKvXAV1wkRtRaIUmFCYRqrKizZA=;
        b=O+QxxAwkUFvzx5bXvyjPQQtHj5QaJaSeSV+9PDCVIAAtszwHiKpv1IDqOhhDkPHEY4
         T3C1SXW4tV4/wqj+yLMJkJLl88n+u0SRYwAmZh2A1ufWssR3XpIZPaDTwCw6JyAEtZuX
         MxTwPG4zI4P1r0T5l8Cr7GMvqNO75p7+BSvAHFZRat/zrYsEcjYnZGjdfFmLh6WU4Rgr
         gsj9UJqZWnM3N1n8LHiS416+lHhjT4huhCfMQZOqYuFFKJeh5dLfgPNitrDwo7IKJo4z
         3PpCw2KWcj8nndx+8eAZkF5hzYgNpEQ/pfNfS4iOqZ8iPcVpkNClDLfnDtCaXQyPVggJ
         kHtQ==
X-Gm-Message-State: AOAM531DNIc0OWDbQaP6UsgWJ5JRQHC9DThdouQzzETXdxfEhcuQwBJU
        BwHEf3L5gVRmyH33cAOMXs1nv6EXO8MHtVrwWaM=
X-Google-Smtp-Source: ABdhPJzw1AeIv8m+drixTj1uXX6SfpEeMgBHpqw9coAmMoKC7JoxKMNg6Pw6K6RujITlOolZM2J9h4ereMWvb9vjP/s=
X-Received: by 2002:aca:38c3:: with SMTP id f186mr1117499oia.39.1626368040676;
 Thu, 15 Jul 2021 09:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com> <7133f0efa520b3d0cadb059151daa12484fdb003.1626204784.git.gitgitgadget@gmail.com>
 <d91ed8a0-b37b-7dfa-10bf-e068f30e9691@gmail.com>
In-Reply-To: <d91ed8a0-b37b-7dfa-10bf-e068f30e9691@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 15 Jul 2021 09:53:49 -0700
Message-ID: <CABPp-BF+gR8WtpWt_DVDoWe16R4B65h-59zGOZ5j4vUJKp_Nuw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] merge-ort: restart merge with cached renames to
 reduce process entry cost
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 8:10 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/13/2021 3:33 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> ...
> > Often, I noticed that when the optimization does not apply, it is
> > because there are a handful of relevant sources -- maybe even only one.
> > It felt frustrating to need to recurse into potentially hundreds or even
> > thousands of directories just for a single rename, but it was needed for
> > correctness.
> >
> > However, staring at this list of functions and noticing that
> > process_entries() is the most expensive and knowing I could avoid it if
> > I had cached renames suggested a simple idea: change
> >    collect_merge_info()
> >    detect_and_process_renames()
> >    process_entries()
> > into
> >    collect_merge_info()
> >    detect_and_process_renames()
> >    <cache all the renames, and restart>
> >    collect_merge_info()
> >    detect_and_process_renames()
> >    process_entries()
> >
> > This may seem odd and look like more work.  However, note that although
> > we run collect_merge_info() twice, the second time we get to employ
> > trivial directory resolves, which makes it much faster, so the increased
> > time in collect_merge_info() is small.  While we run
> > detect_and_process_renames() again, all renames are cached so it's
> > nearly a no-op (we don't call into diffcore_rename_extended() but we do
> > have a little bit of data structure checking and fixing up).  And the
> > big payoff comes from the fact that process_entries(), will be much
> > faster due to having far fewer entries to process.
>
> I enjoyed the story you tell here.

:-)

> > +     if (path_count_after) {
> > +             /*
> > +              * Not sure were the right cut-off is for the optimization
> > +              * to redo collect_merge_info after we've cached the
> > +              * regular renames is.  Basically, collect_merge_info(),
> > +              * detect_regular_renames(), and process_entries() are
> > +              * similar costs and all big tent poles.  Caching the
> > +              * result of detect_regular_renames() means that redoing
> > +              * that one function will cost us virtually 0 extra, so it
> > +              * depends on the other two functions, which are both O(N)
> > +              * cost in the number of paths.  Thus, it makes sense that
> > +              * if we can cut the number of paths in half, then redoing
> > +              * collect_merge_info() at half cost in order to get
> > +              * process_entries() at half cost should be about equal
> > +              * cost.  If we can cut by more than half, then we would
> > +              * win.  The fact that process_entries() is about 10%-20%
> > +              * more expensive than collect_merge_info() suggests we
> > +              * could make the factor be less than two.  The fact that
> > +              * even when we have renames cached, we still have to
> > +              * traverse down to the individual (relevant) renames,
> > +              * which suggests we should perhaps use a bigger factor.
> > +              *
> > +              * The exact number isn't critical, since the code will
> > +              * work even if we get the factor wrong -- it just might be
> > +              * slightly slower if we're a bit off.  For now, just error
> > +              * on the side of a bigger fudge.  For the linux kernel
>
> super-nit: s/linux/Linux/

Yeah, I tend to refer to projects by the name of their repository
instead of their proper name.  (I do it with git too.)  Bad habit.
Will fix.  That is, I will fix this instance.  Not sure I can fix the
habit.

> > +              * testcases I was looking at with massive renames, the
> > +              * ratio came in around 50 to 250, which clearly would
> > +              * trigger this optimization and provided some *very* nice
> > +              * speedups.
>
> This bit of your testing might be more appropriate for your commit
> message. This discussion of a test made at a certain point in time
> is more likely to go stale than the description of how this factor
> does not change correctness, only performance.

The commit message does include discussion on how this factor only
changes performance, not correctness.  I left this comment in the code
because I figured it looked weird and magic and deserved an
explanation without resorting to git-log or git-blame.  Granted, I
wrote this comment and the commit message at much different times (I
wrote the comment first, then the commit message many months later)
and thus summarized a bit differently.  But I thought I had the same
relevant content in both places.

Are there pieces you feel are missing from the commit message?  Should
I trim this comment down in the code and just let people look for the
commit message for more details?

> > +              */
> > +             int wanted_factor = 3;
>
> and perhaps make it 'const'?

Sure, will do.

> > +
> > +             /* We should only redo collect_merge_info one time */
> > +             assert(renames->redo_after_renames == 0);
> > +
> > +             if (path_count_after / path_count_before > wanted_factor) {
>
> With truncation from integer division, this condition is equivalent* to
>
>         path_count_after >= 4 * path_count_before
>
> Or, do you want to change this to a ">=" so that the factor of 3 seems
> more accurate?
>
> *I understand the intention of using division to avoid (unlikely)
> overflow via multiplication. The truncation is causing some confusion.

Good catch; I'll fix it up to use ">=".

> > -test_expect_merge_algorithm failure failure '12f: Trivial directory resolve, caching, all kinds of fun' '
> > +test_expect_merge_algorithm failure success '12f: Trivial directory resolve, caching, all kinds of fun' '
> >       test_setup_12f &&
> >       (
> >               cd 12f &&
> >
>
> Oh, and a bonus test success! Excellent.

Yeah, this testcase was slightly weird in the order I sent it
upstream.  12f was written specifically with this optimization in mind
as a way of ensuring code coverage of the restart logic.  I would have
waited to submit the 12f testcase with this series, but the testcase
also demonstrated an important directory rename detection bug that I
found existed in both merge-recursive and merge-ort at the time.  See
commit 902c521a35 ("t6423: more involved directory rename test",
2020-10-15)

The merge-ort bug was fixed with commit 203c872c4f ("merge-ort: fix a
directory rename detection bug", 2021-01-19).  The merge-recursive bug
still exists.

So, this series just fixed up the final thing that 12f was testing for
-- namely that it included two collect_merge_info() region_enter
trace2 calls per commit instead of just one.

Perhaps I could have split the test, but both things require a
relatively big set of files which makes the test a bit more expensive
so I didn't want to duplicate it.  Besides, having both factors
involved makes it a better stress test of the restart logic.
