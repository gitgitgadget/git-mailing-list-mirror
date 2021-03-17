Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2AFC433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A4264F21
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhCQVK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhCQVKt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:10:49 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AD8C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:10:49 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v192so437584oia.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+5BowsUOy2YKvNZ2wVT7/EYvzfoywRgPgBDNuBWS5I=;
        b=fEwoKb24HZrpD4hh43wSHQvrnG7Qw2VbNLQ9D9rK8w5GOyYmzr3nN6Q4sSI5AJHCLR
         Wre1zmkAKbyNbgT+MoEA1Df5qegYgGaRWcmLiacewLxBNeJIQ9q63Tpitzxd8q2SKlDT
         9KEVINsz6p+U8AcDJPU0ws41RVoexrMbS0X4nREdOrJ60nc+1OYFPx9pTKyyRFMlBt2U
         e0jLrjxF4o0gQPJytggNh0u/BKaGMtv90ClFUcWqqn/s8q517l2Ddh6ktKNOlKjClG3G
         VvP1ZD0wAN0JInFDxNYEfgbaeNaYUoMS65ofVjjCJt2x6spztVoqmIHsVB9cJLm1SVKj
         bCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+5BowsUOy2YKvNZ2wVT7/EYvzfoywRgPgBDNuBWS5I=;
        b=sgVGL/qT9B46MF7XZjtYtqBoBEMag5myJrATPNKqfmERtCmMT52ojeDoTdoEjSbow0
         Kz3KALd7SmspEZRsmo+8M21oveIYB7ZTCOYR0XtWKV2/275j74Jh4+at7HxsXvJABzZh
         1U9L+mSprDqv6JVo0WQ8UwdBC559LLl/jDLK6qESj9rUDBCIeDa9FeVc5KJV5DVfG/j3
         ju2A+xVxFRE/HjKxpP3dghnvwevJAwkzf1SWQGTXHmraoaG+q4SLh8+7+BfSOVqiSPno
         EDtVsA9FBc8dEFbL9RKjEplDezgaTAJPAABl4s5lFgzXg70vnuCD0pV7Xu0uKUQrhKoB
         /HtA==
X-Gm-Message-State: AOAM5337oJ/u2kZvP6lSDzh1IhuoeWxvmI2JwXhnBBa9JvHMJQhmLGuh
        oQbOheAkGZkEvKtryKVzF1fsVk8+fV5kJOZrhvsosnxOre8=
X-Google-Smtp-Source: ABdhPJxcXzINmVCRwtzQ+1tG13wxMXuwR5oe3z9h9GBw6r3zRnjvXrq0T9XbHBHeuLv21OGD9cTK7i8yIozs131xkNc=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr572246oij.167.1616015448405;
 Wed, 17 Mar 2021 14:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <bfa0164cc3c167e383cdb5405526202432ae624e.1615929436.git.gitgitgadget@gmail.com>
 <CABPp-BF=-2qD9YodpnhYP49EnKEV=MOFDMUnB-agd-d69jVeQA@mail.gmail.com> <08ffff48-7b9c-7113-1a5a-557f3efff26f@gmail.com>
In-Reply-To: <08ffff48-7b9c-7113-1a5a-557f3efff26f@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 14:10:37 -0700
Message-ID: <CABPp-BH-c8gzrkOFFNb=8b8R+X+VRXsziKoE_RtcR4mh6zjR4g@mail.gmail.com>
Subject: Re: [PATCH 06/27] checkout-index: ensure full index
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 1:05 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/17/2021 1:50 PM, Elijah Newren wrote:
> > On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > With the caveat in the commit message, this change looks okay, but
> > checkout-index may be buggy regardless of the presence of
> > ensure_full_index().  If ensure_full_index() really is needed here
> > because it needs to operate on all SKIP_WORKTREE paths and not just
> > leading directories, that's because it's writing all those
> > SKIP_WORKTREE entries to the working tree.  When it writes them to the
> > working tree, is it clearing the SKIP_WORKTREE bit?  If not, we're in
> > a bit of a pickle...
>
> Perhaps I'm unclear in my intentions with this series: _every_
> insertion of ensure_full_index() is intended to be audited with
> tests in the future. Some might need behavior change, and others
> will not. In this series, I'm just putting in the protections so
> we don't accidentally trigger unexpected behavior.

I think this may be part of my qualms -- what do you mean by not
accidentally triggering unexpected behavior?  In particular, does your
statement imply that whatever behavior you get after putting in
ensure_full_index() is "expected"?  I think I'm reading that
implication into it, and objecting that the behavior with the
ensure_full_index() still isn't expected.  You've only removed a
certain class of unexpected behavior, namely code that wasn't written
to expect tree entries that suddenly gets them.  You haven't handled
the class of "user wants to work with a subset of files, why are all
these unrelated files being munged/updated/computed/shown/etc."
unexpected behavior.

I'm worrying that expectations are being set up such that working with
just a small section of the code will be unusably hard.  There may be
several commands/flags where it could make sense to operate on either
(a) all files in the repo or (b) just on files within your sparse
paths.  If, though, folks interpret operate-on-all-files as the
"normal" mode (and history suggests they will), then people start
adding all kinds of --no-do-this-sparsely flags to each command, and
then users who want sparse operation have to remember to type such a
flag with each and every command they ever run -- despite having taken
at least three steps already to get a sparse-index.

I believe the extended discussions (for _months_!) on just grep & rm,
plus watching a --sparse patch being floated just in the last day for
ls-files suggest to me that this is a _very_ likely outcome and I'm
worried about it.

> Since tests take time to write and review, I was hoping that these
> insertions were minimal enough to get us to a safe place where we
> can remove the guards carefully.
>
> So with that in mind...
>
> > Might be nice to add a
> > /* TODO: audit if this is needed; if it is, we may have other bugs... */
> > or something like that.  But then again, perhaps you're considering
> > all uses of ensure_full_index() to be need-to-be-reaudited codepaths?
> > If so, and we determine we really do need one and want to keep it
> > indefinitely, will we mark those with a comment about why it's
> > considered correct?
> >
> > I just want a way to know what still needs to be audited and what
> > doesn't without doing a lot of history spelunking...
>
> ...every insertion "needs to be audited" in the future. That's a
> big part of the next "phases" in the implementation plan.
>
> As you suggest, it might be a good idea to add a comment to every
> insertion, to mark it as un-audited, such as:
>
>         /* TODO: test if ensure_full_index() is necessary */
>
> We can come back later to delete the comment if it truly is
> necessary (and add tests to guarantee correct behavior). We can
> also remove the comment _and_ the call by modifying the loop
> behavior to do the right thing in some cases.

If it's "needs to be audited for both performance reasons (can we
operate on fewer entries as an invisible doesn't-change-results
optimization) and correctness reasons (should we operate on fewer
entries and given a modified result within a sparse-index because
users would expect that, but maybe provide a special flag for the
users who want to operate on all files in the repo)" and there's also
an agreement that either audited or unaudited ones will be marked (or
both), then great, I'm happy.  If not, can we discuss which part of my
performance/correctness/marking we aren't in agreement on?


Thanks,
Elijah
