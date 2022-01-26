Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C406C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 19:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiAZTFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 14:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiAZTFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 14:05:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF1C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 11:05:10 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id j2so634690ejk.6
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 11:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzrU26AdaFJTRp6Zninoqy7uAWSy6Vvcmv4Ix4vUbbw=;
        b=i4qdVm541RpIzQjuib6/o633/NnVIIFybm5r5ek93N1x03JIuYyPaQd8XEYGI4CTdC
         sKa8yLBzY5TlJIX1ZcCYwY8kx47DYEQOR5LGvL8aIQfFvSe5eAeK+DNJkunKfB6m7MMz
         8/TgmDDZX+sYlXtUlSO5AnmRzxu8TfW4A/uWWlB2LRnqekP3WP9d0mBVXd5tfMTDg1B3
         KI9DKQfp8/Wlll69QQpfMY7N4TaXd8QGOf9ZxMwEJBMbvwbCFqbSJQPlUHphupDcgt3a
         zaM3NkGuFR0dlVtGKitKb/2IzxRQ9Ng58MEAqqMhst0LBFUVogbyWuFr++mToGDwHszd
         pjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzrU26AdaFJTRp6Zninoqy7uAWSy6Vvcmv4Ix4vUbbw=;
        b=JZackl/uZgRkgYW7sHrpyyL+LWuhhBceCTU9+KscvJtFzgCn1KfByWeez2+OT9So4r
         T8uZ//VOPObAbJVqzfM4kAStq8ZbCykGTnov+R02bUTS3BrhHfekspq6G0e5Tt8jfltq
         DqyJlPfmIEcmgwLmc6hDbSI1XZtQW+GDkWcVclfKKtobLJcO1S0+w+R/xUOo6wlGi6N1
         53wiQpTBEYPAinLTzu0pGgY7kcpbil2jsqOPLqC6I1lnNgnq8tZvo8uxrvXQV+3eTDh5
         C57aHWGB0OlM2XflMJpU7VVdHLqCFfemBj5Shx3kLvQgWomHLA3xxO/jXsmjjhJAX+so
         NgXQ==
X-Gm-Message-State: AOAM533Y5znNdapngLM2vav5Vm5Aokr05rv+Mn7/k7ToWlHgXLIDf/X8
        m2EvN3LWOljdL1w3JSz9hHJKhylb22AC5dUaT7k=
X-Google-Smtp-Source: ABdhPJzh2W5dDEIq1t6gJ0vd7X9vH5r0acUxBTWhpSNBWT3zliCqPjjfAEtdMARXD5HjC1pyG9tpHf6PwFizkU8sOLI=
X-Received: by 2002:a17:907:608b:: with SMTP id ht11mr47402ejc.613.1643223908617;
 Wed, 26 Jan 2022 11:05:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com> <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
 <kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com> <kl6la6fj1gpb.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6la6fj1gpb.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 Jan 2022 11:04:57 -0800
Message-ID: <CABPp-BHH0d9evJ5n-njKkPPsTQrY9E4Sh4Yb+Nq_JiYffuHUBQ@mail.gmail.com>
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5
 07/11] rebase: do not attempt to remove startup_info->original_cwd)
To:     Glen Choo <chooglen@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 4:30 PM Glen Choo <chooglen@google.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Tue, Jan 25, 2022 at 12:27 PM Glen Choo <chooglen@google.com> wrote:
> >>
> >> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >> > From: Elijah Newren <newren@gmail.com>
> >> >
> >> > Since rebase spawns a `checkout` subprocess, make sure we run that from
> >> > the startup_info->original_cwd directory, so that the checkout process
> >> > knows to protect that directory.
> >> >
> >> > Signed-off-by: Elijah Newren <newren@gmail.com>
> >> > ---
> >> >  sequencer.c          | 2 ++
> >> >  t/t2501-cwd-empty.sh | 4 ++--
> >> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/sequencer.c b/sequencer.c
> >> > index ea96837cde3..83f257e7fa4 100644
> >> > --- a/sequencer.c
> >> > +++ b/sequencer.c
> >> > @@ -4228,6 +4228,8 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
> >> >
> >> >       cmd.git_cmd = 1;
> >> >
> >> > +     if (startup_info->original_cwd)
> >> > +             cmd.dir = startup_info->original_cwd;
> >> >       strvec_push(&cmd.args, "checkout");
> >> >       strvec_push(&cmd.args, commit);
> >> >       strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
> >> > diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
> >> > index b1182390ba3..52335a8afe9 100755
> >> > --- a/t/t2501-cwd-empty.sh
> >> > +++ b/t/t2501-cwd-empty.sh
> >> > @@ -166,11 +166,11 @@ test_expect_success 'cherry-pick fails if cwd needs to be removed' '
> >> >  '
> >> >
> >> >  test_expect_success 'rebase does not clean cwd incidentally' '
> >> > -     test_incidental_dir_removal failure git rebase reverted
> >> > +     test_incidental_dir_removal success git rebase reverted
> >> >  '
> >> >
> >> >  test_expect_success 'rebase fails if cwd needs to be removed' '
> >> > -     test_required_dir_removal failure git rebase fd_conflict
> >> > +     test_required_dir_removal success git rebase fd_conflict
> >> >  '
> >> >
> >> >  test_expect_success 'revert does not clean cwd incidentally' '
> >> > --
> >> > gitgitgadget
> >>
> >> This commit (which is already in master) introduces a bug that breaks
> >> rebase when rebasing inside a subdirectory of a worktree. You can see
> >> that the below test fails with:
> >>
> >>   error: The following untracked working tree files would be overwritten by merge:
> >>           a/b/c
> >>   Please move or remove them before you merge.
> >
> > Thanks for the detailed report -- with a full testcase!
>
> Glad to be of help :)
>
> >> This only affects subdirectories in worktrees, i.e. rebasing anywhere in
> >> the `main-wt` directory is fine, and rebasing from the top of `other-wt`
> >> is fine, but `other-wt/any/other/dir` fails.
> >>
> >> I haven't tracked down the root cause yet, but judging from the commit,
> >> I would suppose that the checkout is being spawned in the wrong
> >> directory, causing the files to not be cleaned up.
> >
> > There's nothing wrong with running checkout from a subdirectory.  It
> > is unfortunate that setup.c auto-discovers both the git directory and
> > the working tree, but sets GIT_DIR without setting GIT_WORK_TREE in
> > the case of a non-main worktree; it's not particularly friendly for
> > subcommands.  Of course, it's also unfortunate that sequencer still
> > forks subprocesses other than those requested by a user with e.g.
> > --exec.
> >
> > But, anyway, I've got a patch that I'll send as soon as it passes CI
> > (https://github.com/git/git/pull/1205).
>
> I wish I had seen this email before diving into debugging it myself
> since your fix is more comprehensive, but it was a good learning
> experience nonetheless.

Yeah, sorry, it took me quite a bit of debugging as well before
figuring all this stuff out, so I don't think I sent the email in time
to save you the work.
