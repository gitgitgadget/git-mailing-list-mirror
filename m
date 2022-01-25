Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784C8C5AC75
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 23:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiAYX7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 18:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiAYX7W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 18:59:22 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DE8C06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 15:59:21 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id o12so34494723eju.13
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 15:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lx05+RsmZ0lhj7kU5w2c2mtFyUb9xMsyD8ZYovcrNe8=;
        b=meEy21llnhNKM9EhlyPPKpK6Em6zk3ZM2y4VkkJ3PYId942FgoouLXdOtIuzDsE1TL
         uNacA97CFtSvwzo5Qq25INDmuq0pCfvL6BUGpAhZr9iBYUyV8TNjSzT4aVn+LuqL/fR2
         phnbO7ZW4e8d7YBahJO5zzsYWMiKhwzbvwL5hPLqHoOw/QhpX665gjyk8kakI9UkUrTe
         jEd99HaoCGIJ19HBeu0kd3FyI3v45lO4V6xKFitP6NXCtz7lEsMx42Q8LVZB8r/qzMM8
         BT4Z57anHXi3QQw686xMqMNC8t2UivxZq/xVoLJhG28N9qdHgzpkkKHXQrXUl84V0bu4
         EdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lx05+RsmZ0lhj7kU5w2c2mtFyUb9xMsyD8ZYovcrNe8=;
        b=IGoGiHLQbwxdtauIyz8AFqo4aGSPw7S04VJYOrZK8vEkhx4y9khjnNFI++u7WfGyDB
         TWTV97gnQuaW/58xks3TVLAq8akKkxet3UdyU4ZIvaUXqYUYl8ErsWhMF25ULsgcimHY
         duQguzwO4LvPWz4kH29Qge4vhHvkbOcxqAGuE+Duiw+g2F1nczErwsJKYFliL508K7+7
         zaJvsMgnhNv3p3LwV0GsTcIcAEd5eRV0cTO70PJJbEkg/vh56798ZwR8u33HqPKSOYmz
         vm6eyMEOxEevlfYn227HhjkaKduUUgP1wRbOtunM1+CDP0AzWcvpP89awai7ZIKGNefS
         kVWg==
X-Gm-Message-State: AOAM5337Qtz9MxZzo9FSKL2e/m1cpAT6jiN9+jUdGSUMKgvOX/O6k3+B
        zpZiohfY+kMCH3FgpcDhDJePvg+IDfkwVM8pgHLSmBnoyWc=
X-Google-Smtp-Source: ABdhPJwmjsavbaUaRT9WQbuC1FIWARCAf+uPGEC4EgjfZIRN4R0zV9xKgP2TnTNNtMTgwAPb7v8kPCofTGQoUKLQhfs=
X-Received: by 2002:a17:907:2dac:: with SMTP id gt44mr3685913ejc.493.1643155160220;
 Tue, 25 Jan 2022 15:59:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com> <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
 <kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 25 Jan 2022 15:59:08 -0800
Message-ID: <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com>
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

On Tue, Jan 25, 2022 at 12:27 PM Glen Choo <chooglen@google.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Since rebase spawns a `checkout` subprocess, make sure we run that from
> > the startup_info->original_cwd directory, so that the checkout process
> > knows to protect that directory.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  sequencer.c          | 2 ++
> >  t/t2501-cwd-empty.sh | 4 ++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index ea96837cde3..83f257e7fa4 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -4228,6 +4228,8 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
> >
> >       cmd.git_cmd = 1;
> >
> > +     if (startup_info->original_cwd)
> > +             cmd.dir = startup_info->original_cwd;
> >       strvec_push(&cmd.args, "checkout");
> >       strvec_push(&cmd.args, commit);
> >       strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
> > diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
> > index b1182390ba3..52335a8afe9 100755
> > --- a/t/t2501-cwd-empty.sh
> > +++ b/t/t2501-cwd-empty.sh
> > @@ -166,11 +166,11 @@ test_expect_success 'cherry-pick fails if cwd needs to be removed' '
> >  '
> >
> >  test_expect_success 'rebase does not clean cwd incidentally' '
> > -     test_incidental_dir_removal failure git rebase reverted
> > +     test_incidental_dir_removal success git rebase reverted
> >  '
> >
> >  test_expect_success 'rebase fails if cwd needs to be removed' '
> > -     test_required_dir_removal failure git rebase fd_conflict
> > +     test_required_dir_removal success git rebase fd_conflict
> >  '
> >
> >  test_expect_success 'revert does not clean cwd incidentally' '
> > --
> > gitgitgadget
>
> This commit (which is already in master) introduces a bug that breaks
> rebase when rebasing inside a subdirectory of a worktree. You can see
> that the below test fails with:
>
>   error: The following untracked working tree files would be overwritten by merge:
>           a/b/c
>   Please move or remove them before you merge.

Thanks for the detailed report -- with a full testcase!

> This only affects subdirectories in worktrees, i.e. rebasing anywhere in
> the `main-wt` directory is fine, and rebasing from the top of `other-wt`
> is fine, but `other-wt/any/other/dir` fails.
>
> I haven't tracked down the root cause yet, but judging from the commit,
> I would suppose that the checkout is being spawned in the wrong
> directory, causing the files to not be cleaned up.

There's nothing wrong with running checkout from a subdirectory.  It
is unfortunate that setup.c auto-discovers both the git directory and
the working tree, but sets GIT_DIR without setting GIT_WORK_TREE in
the case of a non-main worktree; it's not particularly friendly for
subcommands.  Of course, it's also unfortunate that sequencer still
forks subprocesses other than those requested by a user with e.g.
--exec.

But, anyway, I've got a patch that I'll send as soon as it passes CI
(https://github.com/git/git/pull/1205).

> ---
>  t/t3400-rebase.sh | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 23dbd3c82e..8b8b66538b 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -416,4 +416,33 @@ test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a symlink'
>         mv actual_logs .git/logs
>  '
>
> +test_expect_success 'rebase when inside worktree subdirectory' '
> +       git init main-wt &&
> +       (
> +               cd main-wt &&
> +               git commit --allow-empty -m "initial" &&
> +               # create commit with foo/bar/baz
> +               mkdir -p foo/bar &&
> +               touch foo/bar/baz &&
> +               git add foo/bar/baz &&
> +               git commit -m "add foo/bar/baz" &&
> +               # create commit with a/b/c
> +               mkdir -p a/b &&
> +               touch a/b/c &&
> +               git add a/b/c &&
> +               git commit -m "add a/b/c" &&
> +               # create another branch for our other worktree
> +               git branch other &&
> +               git worktree add ../other-wt other &&
> +               (
> +                       cd ../other-wt &&
> +                       mkdir -p random/dir &&
> +                       (
> +                               cd random/dir &&
> +                               git rebase --onto HEAD^^ HEAD^  # drops the HEAD^ commit
> +                       )
> +               )
> +       )
> +'
> +
>  test_done
> --
> 2.35.0.rc0.227.g00780c9af4-goog
