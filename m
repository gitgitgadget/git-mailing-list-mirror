Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4441FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 16:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932653AbeARQoO (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 11:44:14 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35516 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932640AbeARQoL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 11:44:11 -0500
Received: by mail-wm0-f68.google.com with SMTP id r78so24297500wme.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 08:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5z6KvwMEhG0yt7BQG728kNY/3Q7YHZZLAzScRvR+guM=;
        b=KLAyeJ/M2eQnVL/9GBeEVRZu/hma+kcGdrgdQwcXvb8fXjWhK6vP7MbB10sx5iMFzZ
         EaWEa9srfcNEtCmL+J6TEENxcQa2aP+wksLbHikxSkJaZskJPs3zun+1OlIhlQpwk7ZU
         xifJEOtBygl1L7H/TUUT+iyesXeKwOiCyDQCt+LMiDIlyGZvPx1YVhzpfCO7JP9FBZUw
         Pj5gpie6bjPhYRELkiW2mweK9JaeDUiHfuXbHTFgBeG3PE/oJ8uk9YQFNjl3YERJWLk5
         LRyrhKK5zaRLj5ETK7Wxmocdp1TBIYLET2k9Io4rocctQlINpRWfMtlAquIRG16/w9qI
         pmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5z6KvwMEhG0yt7BQG728kNY/3Q7YHZZLAzScRvR+guM=;
        b=YKAojvLv3rlJYgqliaJ+Lyz0QxTKnr/Gosjuof8sEkOdvdjgGBnXUMWHO7FGGkbtX9
         xpSVIJOw59ZfvPoG3ev2bB3rFMELoO+e7Mtw80XpVtJBqjCnLYl4h6iYsXxp9SAxtzl7
         3EqstshBUyX6se5ZhcmGAbJ8QYUDirx15uc95KH7HXh/IIgLVIncBmyRH+/pXinUcEaq
         8tDW2fC0lvm1mQgibmLYmECwuxW6p2C05M4TWS4pi+tRFCBLhO59K7s5jbAz1XJSLI2Q
         qn+h2WFFNMBsJOQy7r6CysRxvUJgPYxROk4Bkgz0z21BvNnhTzIABcPrdaq42/u3knV5
         PIGA==
X-Gm-Message-State: AKwxyteWD+8FdCeuT3C8i1ShXbD+bO2u9OiTsT0FgHism8be0OUuWcgS
        a3W8Kb0IA3VD4TbVUfEgvw06hB/i3jWCRVSQecY=
X-Google-Smtp-Source: ACJfBovacdK6d48wcNt7XnBzH64VAIKGKCcyiN9ft0jaPPGRje3+kJ/qt8LzF63sRdDitSjhlBhovUK9qEAyOxItAEc=
X-Received: by 10.80.241.89 with SMTP id z25mr9022197edl.104.1516293850020;
 Thu, 18 Jan 2018 08:44:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.212.44 with HTTP; Thu, 18 Jan 2018 08:43:49 -0800 (PST)
In-Reply-To: <219dbf95a8069190abe0986ca66b65a8ae3e670d.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <219dbf95a8069190abe0986ca66b65a8ae3e670d.1516225925.git.johannes.schindelin@gmx.de>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Jan 2018 08:43:49 -0800
Message-ID: <CA+P7+xr0FpgTUa9SgkXM1U86i8f0cParNqGkP=KNPOR_EqNHYg@mail.gmail.com>
Subject: Re: [PATCH 6/8] sequencer: handle autosquash and post-rewrite for
 merge commands
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 7:35 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> In the previous patches, we implemented the basic functionality of the
> `git rebase -i --recreate-merges` command, in particular the `merge`
> command to create merge commits in the sequencer.
>
> The interactive rebase is a lot more these days, though, than a simple
> cherry-pick in a loop. For example, it calls the post-rewrite hook (if
> any) after rebasing with a mapping of the old->new commits. And the
> interactive rebase also supports the autosquash mode, where commits
> whose oneline is of the form `fixup! <oneline>` or `squash! <oneline>`
> are rearranged to amend commits whose oneline they match.
>
> This patch implements the post-rewrite and autosquash handling for the
> `merge` command we just introduced. The other commands that were added
> recently (`label`, `reset` and `bud`) do not create new commits,
> therefore post-rewrite & autosquash do not need to handle them.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  refs.c                            |  3 ++-
>  sequencer.c                       | 10 +++++++---
>  t/t3430-rebase-recreate-merges.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 4 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 20ba82b4343..e8b84c189ff 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -600,7 +600,8 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
>  static int is_per_worktree_ref(const char *refname)
>  {
>         return !strcmp(refname, "HEAD") ||
> -               starts_with(refname, "refs/bisect/");
> +               starts_with(refname, "refs/bisect/") ||
> +               starts_with(refname, "refs/rewritten/");
>  }

Would this part make more sense to move into the commit that
introduces writing these refs, or does it only matter once you start
this step here?

>
>  static int is_pseudoref_syntax(const char *refname)
> diff --git a/sequencer.c b/sequencer.c
> index 1bef16647b4..b63bfb9a141 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2413,10 +2413,13 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>                         res = do_reset(item->arg, item->arg_len);
>                 else if (item->command == TODO_BUD)
>                         res = do_reset("onto", 4);
> -               else if (item->command == TODO_MERGE)
> +               else if (item->command == TODO_MERGE) {
>                         res = do_merge(item->commit,
>                                        item->arg, item->arg_len, opts);
> -               else if (!is_noop(item->command))
> +                       if (item->commit)
> +                               record_in_rewritten(&item->commit->object.oid,
> +                                                   peek_command(todo_list, 1));
> +               } else if (!is_noop(item->command))
>                         return error(_("unknown command %d"), item->command);
>
>                 todo_list->current++;
> @@ -3556,7 +3559,8 @@ int rearrange_squash(void)
>                 struct subject2item_entry *entry;
>
>                 next[i] = tail[i] = -1;
> -               if (item->command >= TODO_EXEC) {
> +               if (item->command >= TODO_EXEC &&
> +                   (item->command != TODO_MERGE || !item->commit)) {
>                         subjects[i] = NULL;
>                         continue;
>                 }
> diff --git a/t/t3430-rebase-recreate-merges.sh b/t/t3430-rebase-recreate-merges.sh
> index 46ae52f88b3..76e615bd7c1 100755
> --- a/t/t3430-rebase-recreate-merges.sh
> +++ b/t/t3430-rebase-recreate-merges.sh
> @@ -143,4 +143,43 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
>         EOF
>  '
>
> +test_expect_success 'refs/rewritten/* is worktree-local' '
> +       git worktree add wt &&
> +       cat >wt/script-from-scratch <<-\EOF &&
> +       label xyz
> +       exec GIT_DIR=../.git git rev-parse --verify refs/rewritten/xyz >a || :
> +       exec git rev-parse --verify refs/rewritten/xyz >b
> +       EOF
> +
> +       test_config -C wt sequence.editor \""$PWD"/replace-editor.sh\" &&
> +       git -C wt rebase -i HEAD &&
> +       test_must_be_empty wt/a &&
> +       test_cmp_rev HEAD "$(cat wt/b)"
> +'
> +

Same for the test here, I can't figure out why this is necessary in
this patch as opposed to the patch which first introduced the
refs/rewritten/<label> refs.

> +test_expect_success 'post-rewrite hook and fixups work for merges' '
> +       git checkout -b post-rewrite &&
> +       test_commit same1 &&
> +       git reset --hard HEAD^ &&
> +       test_commit same2 &&
> +       git merge -m "to fix up" same1 &&
> +       echo same old same old >same2.t &&
> +       test_tick &&
> +       git commit --fixup HEAD same2.t &&
> +       fixup="$(git rev-parse HEAD)" &&
> +
> +       mkdir -p .git/hooks &&
> +       test_when_finished "rm .git/hooks/post-rewrite" &&
> +       echo "cat >actual" | write_script .git/hooks/post-rewrite &&
> +
> +       test_tick &&
> +       git rebase -i --autosquash --recreate-merges HEAD^^^ &&
> +       printf "%s %s\n%s %s\n%s %s\n%s %s\n" >expect $(git rev-parse \
> +               $fixup^^2 HEAD^2 \
> +               $fixup^^ HEAD^ \
> +               $fixup^ HEAD \
> +               $fixup HEAD) &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.15.1.windows.2.1430.ga56c4f9e2a9
>
>
