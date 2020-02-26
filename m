Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEA7C4BA21
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 19:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E5720838
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 19:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzdhtCXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgBZTpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:45:50 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45448 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgBZTpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 14:45:50 -0500
Received: by mail-oi1-f193.google.com with SMTP id v19so713179oic.12
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 11:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEZx8oc2F6R59rvUYQAxN8HF7hE7F2R6BHajhxUi+AU=;
        b=QzdhtCXhRG914BktjVvT/JHPdst5vIyQEooEsPp3z5Jr0mABUl3CfnUWMfUJiEoqIU
         Ex841n6XADMGHEcu35nvMIgZQPDPPUeQuUtky3qsdMlHttBXWg3MZCZH6f/oUxJsm6aJ
         5EvQQuCm1sd4dtBU1SjneNYySE4RrfKdG/My42FOcANBM7Z2IbtOYpCMGH4tcsbi/quK
         Lyy4sq242ogFl6Z+4o6qN21i9w9PoEbYi0xoCJgucjELeY2m37Xl9OuYglPpq+64Xxeu
         yU1aSDKXDNxLzN4EFv3ZUVQQ+LKuLYV4vzsrFASlrmwasXsujfulRKhxdsgGY/Tq85Q6
         k+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEZx8oc2F6R59rvUYQAxN8HF7hE7F2R6BHajhxUi+AU=;
        b=McsvS1WA8owyO3puTDg0MWLHmXNqLCNUk+/67r/6sYZP55sge7DDjtbWlvmZH9y5oL
         OwOid020reUNLsu5RxSB5S8Cf7PdYOD7ijvDGrmmugxDg0I2kGAMrH90MBnFLwKBZz35
         Ww/y1Xo088S7afZHxijRjpiVrUt6BXdDt3BbsWkWuhatfj3Gbmz68smdd7oUQe9MZZA0
         f+K4tm2oY6rjDOwAd2kJFXo8SxV0BP9KuZpG/8M23oyDH5hyE6TJaAlRzHGkMzsnmw0l
         6RVXIqPovz+lKvq5zvg+I/RsZRvI9HP26iBdgYNwEGy2G+9Ofc1RQU1RUOl89tIrCfCX
         kY2A==
X-Gm-Message-State: APjAAAXQRzC1clC4h4NoRFUCbN6m6NEQEvrsVKhkxeQM11VjFeB3GTUb
        2SmLifIdnzNDsjZrNexPfW91xGipL+IYR8YcqUY=
X-Google-Smtp-Source: APXvYqzR+FJwLAtTeDGtYt6HWWmekxg5eC9ElQrRX4A4OkTk2FjoZJNurCY2MBxX28R+WyhSlhy0/xkVH4DAVtfT1DA=
X-Received: by 2002:aca:b483:: with SMTP id d125mr486946oif.167.1582746348876;
 Wed, 26 Feb 2020 11:45:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
 <20191206160614.631724-1-phillip.wood123@gmail.com> <20191206160614.631724-9-phillip.wood123@gmail.com>
In-Reply-To: <20191206160614.631724-9-phillip.wood123@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 Feb 2020 11:45:36 -0800
Message-ID: <CABPp-BHbn=0UpR=0RWyxsX_zFEx0v1VUamA3vMcQgDY+2454aw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] [RFC] rebase: fix advice when a fixup creates an
 empty commit
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 6, 2019 at 8:10 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Add a specific message to advise the user what to do when a fixup or
> squash command would create an empty commit.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>
> Notes:
>     I'm slightly nervous of moving the call to determine_whence() to
>     finalized_deferred_config(). I think it is ok but need to do a more
>     thorough audit of the code to be sure.

Any update?

>
>  builtin/commit.c       | 32 ++++++++++++++++++++++++++++----
>  sequencer.c            | 31 ++++++++++++++++++++++++++++++-
>  sequencer.h            |  3 ++-
>  t/t3403-rebase-skip.sh | 18 ++++++++++++------
>  wt-status.h            |  5 +++--
>  5 files changed, 75 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index c3b6b8a6bd..4ae984c470 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -52,6 +52,20 @@ N_("You asked to amend the most recent commit, but doing so would make\n"
>  "it empty. You can repeat your command with --allow-empty, or you can\n"
>  "remove the commit entirely with \"git reset HEAD^\".\n");
>
> +static const char empty_rebase_fixup_advice[] =
> +N_("The fixup would make the commit empty\n"
> +"If you wish to commit it anyway use:\n"
> +"\n"
> +"    git commit --amend --allow-empty\n"
> +"    git rebase --continue\n"
> +"\n"
> +"To remove the commit entirely use:\n"
> +"\n"
> +"    git reset HEAD^\n"
> +"    git rebase --continue\n"
> +"\n"
> +"Otherwise, please use 'git rebase --skip' to skip it\n");

How does skipping differ from removing the commit entirely?  Which one
tosses just the changes from the fixup commit, and which tosses both
the fixup and the commit it is fixing?  Or do they both do the same
thing?

>  static const char empty_cherry_pick_advice[] =
>  N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\n"
>  "If you wish to commit it anyway, use:\n"
> @@ -181,8 +195,14 @@ static void determine_whence(struct wt_status *s)
>  {
>         if (file_exists(git_path_merge_head(the_repository)))
>                 whence = FROM_MERGE;
> -       else if (!sequencer_determine_whence(the_repository, &whence))
> -               whence = FROM_COMMIT;
> +       else {
> +               int res = sequencer_determine_whence(the_repository, &whence,
> +                                                    amend);
> +               if (res < 0)
> +                       die(_("could not read sequencer state"));

sequencer_determine_whence() tries to determine what type of sequencer
operation is in effect, and can return a range of values in whence.
It can also fail to determine which type of sequencer operation is in
effect -- in multiple ways.  And it distinguishes those with via res <
0 vs. res == 0.  I guess it makes sense, but it seems a bit weird.

Not sure what to suggest.  One possibly bad idea just to get the
creative juices flowing: Maybe change the call signature to

enum commit_whence sequencer_determine_whence(struct repository *r,
int amending, enum commit_whence default);

with callers passing default == FROM_COMMIT, and the function can
return FROM_COMMIT if there is no sequencer state, or FROM_ERROR
(FROM_INVALID? FROM_FAILURE?) if there is sequencer state but it
cannot be read.


(And maybe do something similar with patch 6?)

> +               else if (!res)
> +                       whence = FROM_COMMIT;
> +       }
>         if (s)
>                 s->whence = whence;
>  }
> @@ -192,7 +212,6 @@ static void status_init_config(struct wt_status *s, config_fn_t fn)
>         wt_status_prepare(the_repository, s);
>         init_diff_ui_defaults();
>         git_config(fn, s);
> -       determine_whence(s);
>         s->hints = advice_status_hints; /* must come after git_config() */
>  }
>
> @@ -943,9 +962,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>          */
>         if (!committable && whence != FROM_MERGE && !allow_empty &&
>             !(amend && is_a_merge(current_head))) {
> +               fprintf(stderr, "\nwhence = %d\n", whence);

Leftover debugging?

>                 s->display_comment_prefix = old_display_comment_prefix;
>                 run_status(stdout, index_file, prefix, 0, s);
> -               if (amend)
> +               if (whence == FROM_REBASE_FIXUP)
> +                       fputs(_(empty_rebase_fixup_advice), stderr);
> +               else if (amend)
>                         fputs(_(empty_amend_advice), stderr);
>                 else if (is_from_cherry_pick(whence) ||
>                          whence == FROM_REBASE_PICK) {
> @@ -1114,6 +1136,8 @@ static void finalize_deferred_config(struct wt_status *s)
>
>         if (s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
>                 s->ahead_behind_flags = AHEAD_BEHIND_FULL;
> +
> +       determine_whence(s);
>  }
>
>  static int parse_and_validate_options(int argc, const char *argv[],
> diff --git a/sequencer.c b/sequencer.c
> index 6e153fea76..64242f4ce7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5270,7 +5270,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>         return 0;
>  }
>
> -int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
> +int sequencer_determine_whence(struct repository *r, enum commit_whence *whence,
> +                              int amending)
>  {
>         if (file_exists(git_path_cherry_pick_head(r))) {
>                 struct object_id cherry_pick_head, rebase_head;
> @@ -5286,6 +5287,34 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
>                         *whence = FROM_CHERRY_PICK_SINGLE;
>
>                 return 1;
> +       } else if (amending && file_exists(rebase_path_current_fixups()) &&
> +                  (file_exists(git_path_squash_msg(r)) ||
> +                   file_exists(git_path_merge_msg(r)))) {
> +               /*
> +                * If rebase_path_amend() exists the user is running `git
> +                * commit`, if not we're committing a fixup/squash directly from
> +                * the sequencer
> +                */
> +               if (file_exists(rebase_path_amend())) {
> +                       struct strbuf rev = STRBUF_INIT;
> +                       struct object_id to_amend, head;
> +
> +                       if (get_oid("HEAD", &head))
> +                               return error(_("amending invalid head")); /* let commit deal with error */
> +                       if (!read_oneliner(&rev, rebase_path_amend(), 0))
> +                               return error(_("invalid file: '%s'"),
> +                                            rebase_path_amend());
> +                       if (get_oid_hex(rev.buf, &to_amend))
> +                               return error(_("invalid contents: '%s'"),
> +                                            rebase_path_amend());
> +                       if (oideq(&head, &to_amend)) {
> +                               *whence = FROM_REBASE_FIXUP;
> +                               return 1;
> +                       }
> +               } else {
> +                       *whence = FROM_REBASE_FIXUP;
> +                       return 1;
> +               }
>         }
>
>         return 0;
> diff --git a/sequencer.h b/sequencer.h
> index 8d451dbfcb..4e631900b4 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -202,5 +202,6 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>  void sequencer_post_commit_cleanup(struct repository *r);
>  int sequencer_get_last_command(struct repository* r,
>                                enum replay_action *action);
> -int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
> +int sequencer_determine_whence(struct repository *r, enum commit_whence *whence,
> +                              int amending);
>  #endif /* SEQUENCER_H */
> diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
> index a927774910..bc110b66b3 100755
> --- a/t/t3403-rebase-skip.sh
> +++ b/t/t3403-rebase-skip.sh
> @@ -164,22 +164,28 @@ test_expect_success 'correct advice upon multi cherry-pick picking an empty comm
>         test_i18ngrep "git cherry-pick --skip" err
>  '
>
> -test_expect_success 'fixup that empties commit fails' '
> +test_expect_success 'correct advice when fixup empties commit' '
>         test_when_finished "git rebase --abort" &&
>         (
>                 set_fake_editor &&
>                 test_must_fail env FAKE_LINES="1 fixup 2" git rebase -i \
> -                       goodbye^ reverted-goodbye
> -       )
> +                       goodbye^ reverted-goodbye 2>err
> +       ) &&
> +       test_i18ngrep "git rebase --skip" err &&
> +       test_must_fail git commit --amend --no-edit 2>err &&
> +       test_i18ngrep "git rebase --skip" err
>  '
>
> -test_expect_success 'squash that empties commit fails' '
> +test_expect_success 'correct advice when squash empties commit' '
>         test_when_finished "git rebase --abort" &&
>         (
>                 set_fake_editor &&
>                 test_must_fail env FAKE_LINES="1 squash 2" git rebase -i \
> -                       goodbye^ reverted-goodbye
> -       )
> +                       goodbye^ reverted-goodbye 2>err
> +       ) &&
> +       test_i18ngrep "git rebase --skip" err &&
> +       test_must_fail git commit --amend --no-edit 2>err &&
> +       test_i18ngrep "git rebase --skip" err
>  '
>
>  # Must be the last test in this file
> diff --git a/wt-status.h b/wt-status.h
> index 5f81bf7507..a4b7fe6de9 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -41,7 +41,8 @@ enum commit_whence {
>         FROM_MERGE,      /* commit came from merge */
>         FROM_CHERRY_PICK_SINGLE, /* commit came from cherry-pick */
>         FROM_CHERRY_PICK_MULTI, /* commit came from a sequence of cherry-picks */
> -       FROM_REBASE_PICK /* commit came from a pick/reword/edit */
> +       FROM_REBASE_PICK, /* commit came from a pick/reword/edit */
> +       FROM_REBASE_FIXUP /* commit came from fixup/squash */
>  };
>
>  static inline int is_from_cherry_pick(enum commit_whence whence)
> @@ -52,7 +53,7 @@ static inline int is_from_cherry_pick(enum commit_whence whence)
>
>  static inline int is_from_rebase(enum commit_whence whence)
>  {
> -       return whence == FROM_REBASE_PICK;
> +       return whence == FROM_REBASE_PICK || whence == FROM_REBASE_FIXUP;
>  }
>
>  struct wt_status_change_data {
> --
> 2.24.0
>
