Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAF9C5AC75
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 00:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiAZAao (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 19:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiAZAan (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 19:30:43 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F2CC06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:30:43 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z29-20020a62d11d000000b004c8f0d5dec9so4350837pfg.4
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jbk2SIPgpawNRL2Z20sT7gIzaWp9hweuy0IX25FxoXk=;
        b=UYFViROATu8psTNi/fkdMfbJzFjdY+7XMTrUVOsID4At6urRlbI12Y7FmN8pubDKEE
         bVvGCg/dVSNEVQtIRqKu3LVCJHJgCCUSDNAzpBoJMXtJI5pWBZG+1yqEgtR7sPmi3fZJ
         Dzw/JO6YwrPlu3MXMZ+Tp2u57yLbI3RmwilEqXz1yzcbjQcfmaWwqaJr3VJczXOK7eXE
         vaev5rgIbtNopZADtGh3TNIeUMSata530Gse+Y74JvHxniqbwGZ2fwpSy5aMdDS6qRiy
         ZVRKDxjn2NKxcDKOiZnPk+FnU0s5+pzF1yMr8RElAaXWU6XtVwJP0PcRKxdRcIgHAEEy
         SGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jbk2SIPgpawNRL2Z20sT7gIzaWp9hweuy0IX25FxoXk=;
        b=0ldqPPHB7PSqFHl7XKmrh2K6obbdEANVhjFpHTsD6ZUG+4UCCD9sYKecKHx0ff2oHE
         7NMiL72FmG6bvuBHOX9jhzrKbXdbtMjvqP0Zwo77Wfuj3HFtpyccW69BNJsbNMfs+Cz/
         OrGcLaUl+YiPTRwbPRSGl+F3cfUXJXw0rQsLkPsVy5oedqiVOffB7uEopxBBPGvS05UD
         cezhhqNyD7aOopvfiqRCUjeqH9dIojRbY985ZKkC5jNhZZFIwZmzhdo+NBlE7p4jgibx
         VEFQyF5zDVOea78flIBAtW5wIaDtJo9ciavwiCNOHa5gfqU0TMLevr84EAjlhAfH1M/D
         L8cA==
X-Gm-Message-State: AOAM531btENrFDXiGeu2MlrkU47owmJXqkeEKGRPUrVJ8Le0xN/20vB2
        eB2yMj8Zkzjgb/D3NeHwFYUzM+IUWjly7g==
X-Google-Smtp-Source: ABdhPJw1PsTp+P4kHSK3sO6REJyQqwdzYXRUH2Dmxc+ITj1WQL9oR4+EJXhZGpnu+NScLZhr1OnBC/cCFUhfHw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c40e:b0:14b:8074:d71d with SMTP
 id k14-20020a170902c40e00b0014b8074d71dmr3359945plk.97.1643157042687; Tue, 25
 Jan 2022 16:30:42 -0800 (PST)
Date:   Tue, 25 Jan 2022 16:30:40 -0800
In-Reply-To: <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com>
Message-Id: <kl6la6fj1gpb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com> <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
 <kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com> <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com>
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5
 07/11] rebase: do not attempt to remove startup_info->original_cwd)
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "=?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe" <l.s.r@web.de>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Jan 25, 2022 at 12:27 PM Glen Choo <chooglen@google.com> wrote:
>>
>> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: Elijah Newren <newren@gmail.com>
>> >
>> > Since rebase spawns a `checkout` subprocess, make sure we run that from
>> > the startup_info->original_cwd directory, so that the checkout process
>> > knows to protect that directory.
>> >
>> > Signed-off-by: Elijah Newren <newren@gmail.com>
>> > ---
>> >  sequencer.c          | 2 ++
>> >  t/t2501-cwd-empty.sh | 4 ++--
>> >  2 files changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/sequencer.c b/sequencer.c
>> > index ea96837cde3..83f257e7fa4 100644
>> > --- a/sequencer.c
>> > +++ b/sequencer.c
>> > @@ -4228,6 +4228,8 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
>> >
>> >       cmd.git_cmd = 1;
>> >
>> > +     if (startup_info->original_cwd)
>> > +             cmd.dir = startup_info->original_cwd;
>> >       strvec_push(&cmd.args, "checkout");
>> >       strvec_push(&cmd.args, commit);
>> >       strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
>> > diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
>> > index b1182390ba3..52335a8afe9 100755
>> > --- a/t/t2501-cwd-empty.sh
>> > +++ b/t/t2501-cwd-empty.sh
>> > @@ -166,11 +166,11 @@ test_expect_success 'cherry-pick fails if cwd needs to be removed' '
>> >  '
>> >
>> >  test_expect_success 'rebase does not clean cwd incidentally' '
>> > -     test_incidental_dir_removal failure git rebase reverted
>> > +     test_incidental_dir_removal success git rebase reverted
>> >  '
>> >
>> >  test_expect_success 'rebase fails if cwd needs to be removed' '
>> > -     test_required_dir_removal failure git rebase fd_conflict
>> > +     test_required_dir_removal success git rebase fd_conflict
>> >  '
>> >
>> >  test_expect_success 'revert does not clean cwd incidentally' '
>> > --
>> > gitgitgadget
>>
>> This commit (which is already in master) introduces a bug that breaks
>> rebase when rebasing inside a subdirectory of a worktree. You can see
>> that the below test fails with:
>>
>>   error: The following untracked working tree files would be overwritten by merge:
>>           a/b/c
>>   Please move or remove them before you merge.
>
> Thanks for the detailed report -- with a full testcase!

Glad to be of help :)

>> This only affects subdirectories in worktrees, i.e. rebasing anywhere in
>> the `main-wt` directory is fine, and rebasing from the top of `other-wt`
>> is fine, but `other-wt/any/other/dir` fails.
>>
>> I haven't tracked down the root cause yet, but judging from the commit,
>> I would suppose that the checkout is being spawned in the wrong
>> directory, causing the files to not be cleaned up.
>
> There's nothing wrong with running checkout from a subdirectory.  It
> is unfortunate that setup.c auto-discovers both the git directory and
> the working tree, but sets GIT_DIR without setting GIT_WORK_TREE in
> the case of a non-main worktree; it's not particularly friendly for
> subcommands.  Of course, it's also unfortunate that sequencer still
> forks subprocesses other than those requested by a user with e.g.
> --exec.
>
> But, anyway, I've got a patch that I'll send as soon as it passes CI
> (https://github.com/git/git/pull/1205).

I wish I had seen this email before diving into debugging it myself
since your fix is more comprehensive, but it was a good learning
experience nonetheless.
