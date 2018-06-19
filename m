Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3841F403
	for <e@80x24.org>; Tue, 19 Jun 2018 14:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757289AbeFSO3Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 10:29:16 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42416 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757224AbeFSO3N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 10:29:13 -0400
Received: by mail-vk0-f66.google.com with SMTP id s187-v6so11765587vke.9
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 07:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gYgNYKUGP6/Esm5DE/sxAQ+/eTC5o7aiErlkJ8XT1zg=;
        b=RcDb+wowboJGvZWHfC6Cg0EdpSsffG7e+4BZT4ggrFcGCn0z+0rAsXQ8iOBgcGfmUK
         vwawfaPAPkfIa7s4HC0q7Ve9JXHgn44a0/H0v12NTI3BYAJLzl4/vlmZVC+Ag+1N/eAh
         T+jX5AFDrRwWwwt1NMzRx1lC72y0UI9d1oyMwCwayhfRVAnJzn+GLOQE6arBvRqDgZUi
         VfsIYY8dz8Vt4ETXQVvw7xdGAAbL2GnP1TE4+DXZczloDlIPrAPYnWU7h32SdZ/9F7Hb
         /skB4qIZsebw+/b48on25IdXcRTp+hwNmjm1DvOH94QzMh6XzrwJL3KvGmtVsPUbENns
         wCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gYgNYKUGP6/Esm5DE/sxAQ+/eTC5o7aiErlkJ8XT1zg=;
        b=j2xnEtXlDEGUOY0CS5DlwOedeWL9c4wLox/iuYrYxPMkvuIfeqK4ZJ0QdB54+VrN6z
         MRQUnr1RfnxfsHUvwVy65/mOBlGei523YbMqsEohJAqrC1XFH5PEHFKuNzdYmzQJIMOz
         77gLq59oTqnUrfo7JA7g05lThnuvILPsK75JvAvdHooWxc+b09uJCUgMjsOX8c8U4ALo
         ifsqHQLBkWhPgWoJRp4FApPl9l0ocmTjE3LJtLHuauW5/8LxEBx3Gib+Co8C5KjSjuhn
         UYR8YXMeO5HvwOPAX0kSyQZ7dbBqu1hdrRTA93aUNq1skypWvwx7tgjUmNOtjjIRc/s3
         BCXQ==
X-Gm-Message-State: APt69E0fH/CvP4O2ebqObc1vHV/1oF/FGBpmVlkZZB2O5oCpaKZiHlMd
        F0igxtX00ETRD2/0oRFH/4fq+q7SZpdpVnP6i/I=
X-Google-Smtp-Source: ADUXVKKJv/b13uoEGuwgajygqjhyY+8PFHUpqMOj7qpQn0VyE7UIMCDpg+dXa8j2Mjkd7u1rot28MUhNt3C7oEjr62M=
X-Received: by 2002:a1f:82c7:: with SMTP id e190-v6mr9802972vkd.187.1529418552743;
 Tue, 19 Jun 2018 07:29:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 07:29:12
 -0700 (PDT)
In-Reply-To: <20180619124651.17425-1-phillip.wood@talktalk.net>
References: <nycvar.QRO.7.76.6.1806182326420.77@tvgsbejvaqbjf.bet> <20180619124651.17425-1-phillip.wood@talktalk.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 19 Jun 2018 07:29:12 -0700
Message-ID: <CABPp-BHFuqh1KVPod+chZD=AKGVBd_apOt6F9oTaZ0ZA66G03Q@mail.gmail.com>
Subject: Re: [PATCH v3] sequencer: do not squash 'reword' commits when we hit conflicts
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>, ch <cr@onlinehome.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 5:46 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Ever since commit 18633e1a22 ("rebase -i: use the rebase--helper builtin",
> 2017-02-09), when a commit marked as 'reword' in an interactive rebase
> has conflicts and fails to apply, when the rebase is resumed that commit
> will be squashed into its parent with its commit message taken.
>
> The issue can be understood better by looking at commit 56dc3ab04b
> ("sequencer (rebase -i): implement the 'edit' command", 2017-01-02), which
> introduced error_with_patch() for the edit command.  For the edit command,
> it needs to stop the rebase whether or not the patch applies cleanly.  If
> the patch does apply cleanly, then when it resumes it knows it needs to
> amend all changes into the previous commit.  If it does not apply cleanly,
> then the changes should not be amended.  Thus, it passes !res (success of
> applying the 'edit' commit) to error_with_patch() for the to_amend flag.
>
> The problematic line of code actually came from commit 04efc8b57c
> ("sequencer (rebase -i): implement the 'reword' command", 2017-01-02).
> Note that to get to this point in the code:
>   * !!res (i.e. patch application failed)
>   * item->command < TODO_SQUASH
>   * item->command != TODO_EDIT
>   * !is_fixup(item->command) [i.e. not squash or fixup]
> So that means this can only be a failed patch application that is either a
> pick, revert, or reword.  We only need to amend HEAD when rewording the
> root commit or a commit that has been fast-forwarded, for any of the other
> cases we want a new commit, so we should not set the to_amend flag.
>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Original-patch-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>
> I wasn't really sure what to do about the authorship.  This is
> Elijah's patch, with the message tweaked, fixed up with a corrected
> version of Johannes' code and a couple of new tests by my for picking
> and rewording the root commit when it has untracked file confilcts.

Yeah, this one was a little challenging on authorship.  What you've
done here is fine from my angle; thanks for catching the other
important cases I missed.

Junio: As a reminder, this is a bugfix for a regression that appeared
in git 2.13.0; it is not new to the 2.18 cycle.

[As an aside, I know there are multiple other outstanding emails for
me to respond to, unrelated to this patch.  I'll try to get some time
in the next day or two to respond.  Just responding to this one since
Junio mentioned picking it up for 2.18.]

>  sequencer.c                   | 23 ++++++++++++++---
>  t/t3404-rebase-interactive.sh | 28 ++++++++++++++++++++
>  t/t3423-rebase-reword.sh      | 48 +++++++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+), 3 deletions(-)
>  create mode 100755 t/t3423-rebase-reword.sh
>
> diff --git a/sequencer.c b/sequencer.c
> index 4034c0461b..7bf2b62727 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3214,10 +3214,27 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>                                         intend_to_amend();
>                                 return error_failed_squash(item->commit, opts,
>                                         item->arg_len, item->arg);
> -                       } else if (res && is_rebase_i(opts) && item->commit)
> +                       } else if (res && is_rebase_i(opts) && item->commit) {
> +                               int to_amend = 0;
> +                               struct object_id oid;
> +
> +                               /*
> +                                * If we are rewording and have either
> +                                * fast-forwarded already, or are about to
> +                                * create a new root commit, we want to amend,
> +                                * otherwise we do not.
> +                                */
> +                               if (item->command == TODO_REWORD &&
> +                                   !get_oid("HEAD", &oid) &&
> +                                   (!oidcmp(&item->commit->object.oid, &oid) ||
> +                                    (opts->have_squash_onto &&
> +                                     !oidcmp(&opts->squash_onto, &oid))))
> +                                       to_amend = 1;
> +
>                                 return res | error_with_patch(item->commit,
> -                                       item->arg, item->arg_len, opts, res,
> -                                       item->command == TODO_REWORD);
> +                                               item->arg, item->arg_len, opts,
> +                                               res, to_amend);
> +                       }
>                 } else if (item->command == TODO_EXEC) {
>                         char *end_of_arg = (char *)(item->arg + item->arg_len);
>                         int saved = *end_of_arg;
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index e500d7c320..3786879e80 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -980,7 +980,35 @@ test_expect_success 'rebase -i --root reword root commit' '
>         git show HEAD^ | grep "A changed"
>  '
>
> +test_expect_success 'rebase -i --root when root has untracked file confilct' '
> +       test_when_finished "reset_rebase" &&
> +       git checkout -b failing-root-pick A &&
> +       echo x >file2 &&
> +       git rm file1 &&
> +       git commit -m "remove file 1 add file 2" &&
> +       echo z >file1 &&
> +       set_fake_editor &&
> +       test_must_fail env FAKE_LINES="1 2" git rebase -i --root &&
> +       rm file1 &&
> +       git rebase --continue &&
> +       test "$(git log -1 --format=%B)" = "remove file 1 add file 2" &&
> +       test "$(git rev-list --count HEAD)" = 2
> +'
> +
> +test_expect_success 'rebase -i --root reword root when root has untracked file conflict' '
> +       test_when_finished "reset_rebase" &&
> +       echo z>file1 &&
> +       set_fake_editor &&
> +       test_must_fail env FAKE_LINES="reword 1 2" \
> +               FAKE_COMMIT_MESSAGE="Modified A" git rebase -i --root &&
> +       rm file1 &&
> +       FAKE_COMMIT_MESSAGE="Reworded A" git rebase --continue &&
> +       test "$(git log -1 --format=%B HEAD^)" = "Reworded A" &&
> +       test "$(git rev-list --count HEAD)" = 2
> +'
> +
>  test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-interactive rebase' '
> +       git checkout reword-root-branch &&
>         git reset --hard &&
>         git checkout conflict-branch &&
>         set_fake_editor &&
> diff --git a/t/t3423-rebase-reword.sh b/t/t3423-rebase-reword.sh
> new file mode 100755
> index 0000000000..6963750794
> --- /dev/null
> +++ b/t/t3423-rebase-reword.sh
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +
> +test_description='git rebase interactive with rewording'
> +
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +test_expect_success 'setup' '
> +       test_commit master file-1 test &&
> +
> +       git checkout -b stuff &&
> +
> +       test_commit feature_a file-2 aaa &&
> +       test_commit feature_b file-2 ddd
> +'
> +
> +test_expect_success 'reword without issues functions as intended' '
> +       test_when_finished "reset_rebase" &&
> +
> +       git checkout stuff^0 &&
> +
> +       set_fake_editor &&
> +       FAKE_LINES="pick 1 reword 2" FAKE_COMMIT_MESSAGE="feature_b_reworded" \
> +               git rebase -i -v master &&
> +
> +       test "$(git log -1 --format=%B)" = "feature_b_reworded" &&
> +       test $(git rev-list --count HEAD) = 3
> +'
> +
> +test_expect_success 'reword after a conflict preserves commit' '
> +       test_when_finished "reset_rebase" &&
> +
> +       git checkout stuff^0 &&
> +
> +       set_fake_editor &&
> +       test_must_fail env FAKE_LINES="reword 2" \
> +               git rebase -i -v master &&
> +
> +       git checkout --theirs file-2 &&
> +       git add file-2 &&
> +       FAKE_COMMIT_MESSAGE="feature_b_reworded" git rebase --continue &&
> +
> +       test "$(git log -1 --format=%B)" = "feature_b_reworded" &&
> +       test $(git rev-list --count HEAD) = 2
> +'
> +
> +test_done
> --
> 2.17.1
>
