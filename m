Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ABAC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 21:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiGAVVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 17:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiGAVVK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 17:21:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246A151B2A
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 14:21:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ej4so4380709edb.7
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cXzUVnE8I7frxvId8xMkG2Nw9SCdVOQWyryePS/9ASQ=;
        b=XPiFYo5ldYkYMx2iyXVbwKsQ11+D8621PwLwBrbCwYSU16zlbf9yUzWlK89TqnRVTA
         sxtddrjtqsLFvRRVCoBRUEs/s3nKkgMdVAWmLEqFFGQJPN7G/oWhzGw7Y6otMMnvMEQa
         2H7ztqcqPYjNbixZRm+jSbgr2N+32yBLWizCW+UcFg3OhNJOJFfyrQkRWChluKjiBuZ3
         6ffjWPki0JIcP1Bl++6nvXgrEKz1uZNYz6uAKG+cgcXeRjXP0r7gI9cf4oq2bv5M1ZW9
         ekS5uFAs0h78uC4dSSJYbyDXeOjin0t5iFr7D1PRKsSGjKq37+Aqpeo/PTbl3JFqCt1T
         z9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXzUVnE8I7frxvId8xMkG2Nw9SCdVOQWyryePS/9ASQ=;
        b=TkKq5y/7Z4DgH3hTe7RAVd7Ev/KItwFvLOHP0kEn5cMjJWUCNgpNYTCQi6uKoBKc11
         V7wMur7zwzZNSNEk1nRP4A8YKyRrEiklE0APObJSjX+mmOz3NZpelbOxxCAhZ6wXn7On
         SsQMX3WCcl/jeJNNKSLzlSkEe/gfAtascNxV+IJt7fe/JK4jzidKuLj9z5dI0uO+riX9
         8u4o54BkomDds65YKgXaMQBCm9IY4XlkJ/kbWYwCmKuG0ztWEfe5PkISVTqsGu0YIWRd
         f+7ias31rKAcF8xFk5/6pdFWn7DdiEIK8d+J7XaNHRqHNOWDAbbMRPJiTYy4olDaeo3b
         zWFA==
X-Gm-Message-State: AJIora9s3x4Yx+4zCfyPCyNA24di/fJVjNZnzYgZm1mT+ghO5wexwu9k
        isnHDJEcwmoeRlzRpz2V2I6Ry4tUqt5rzhn/8momHQpp/K8=
X-Google-Smtp-Source: AGRyM1sJWQisknRu91+fttEo2dveK7EBz/vxajSbRD3Epi5xZt8zu6dhOsg7VvYH1ZQ4loQD1r/oNOgFb/e+ctc8UeY=
X-Received: by 2002:a05:6402:4242:b0:437:7771:982c with SMTP id
 g2-20020a056402424200b004377771982cmr22310176edb.146.1656710467516; Fri, 01
 Jul 2022 14:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com> <918b398d6a2264a99acadd319f780c796bbafc18.1656422759.git.gitgitgadget@gmail.com>
In-Reply-To: <918b398d6a2264a99acadd319f780c796bbafc18.1656422759.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Jul 2022 14:20:56 -0700
Message-ID: <CABPp-BFqLP51q9RkJr=16+Aqq7R=tYqL5mZGUq-dvfn8LL2AMQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] rebase: add --update-refs option
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2022 at 6:26 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <derrickstolee@github.com>
>
> When working on a large feature, it can be helpful to break that feature
> into multiple smaller parts that become reviewed in sequence. During
> development or during review, a change to one part of the feature could
> affect multiple of these parts. An interactive rebase can help adjust
> the multi-part "story" of the branch.
>
> However, if there are branches tracking the different parts of the
> feature, then rebasing the entire list of commits can create commits not
> reachable from those "sub branches". It can take a manual step to update
> those branches.
>
> Add a new --update-refs option to 'git rebase -i' that adds 'update-ref
> <ref>' steps to the todo file whenever a commit that is being rebased is
> decorated with that <ref>. At the very end, the rebase process updates
> all of the listed refs to the values stored during the rebase operation.
>
> Be sure to iterate after any squashing or fixups are placed. Update the
> branch only after those squashes and fixups are complete. This allows a
> --fixup commit at the tip of the feature to apply correctly to the sub
> branch, even if it is fixing up the most-recent commit in that part.
>
> One potential problem here is that refs decorating commits that are
> already marked as "fixup!" or "squash!" will not be included in this
> list. Generally, the reordering of the "fixup!" and "squash!" is likely
> to change the relative order of these refs, so it is not recommended.
> The workflow here is intended to allow these kinds of commits at the tip
> of the rebased branch while the other sub branches come along for the
> ride without intervention.
>
> This change update the documentation and builtin to accept the
> --update-refs option as well as updating the todo file with the
> 'update-ref' commands. Tests are added to ensure that these todo
> commands are added in the correct locations.
>
> A future change will update the behavior to actually update the refs
> at the end of the rebase sequence.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/git-rebase.txt  |   8 +++
>  builtin/rebase.c              |   5 ++
>  sequencer.c                   | 107 ++++++++++++++++++++++++++++++++++
>  sequencer.h                   |   1 +
>  t/t2407-worktree-heads.sh     |  17 ++++++
>  t/t3404-rebase-interactive.sh |  70 ++++++++++++++++++++++
>  6 files changed, 208 insertions(+)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 262fb01aec0..e7611b4089c 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -609,6 +609,13 @@ provided. Otherwise an explicit `--no-reschedule-failed-exec` at the
>  start would be overridden by the presence of
>  `rebase.rescheduleFailedExec=true` configuration.
>
> +--update-refs::
> +--no-update-refs::
> +       Automatically force-update any branches that point to commits that
> +       are being rebased. Any branches that are checked out in a worktree
> +       or point to a `squash! ...` or `fixup! ...` commit are not updated
> +       in this way.
> +
>  INCOMPATIBLE OPTIONS
>  --------------------
>
> @@ -632,6 +639,7 @@ are incompatible with the following options:
>   * --empty=
>   * --reapply-cherry-picks
>   * --edit-todo
> + * --update-refs
>   * --root when used in combination with --onto
>
>  In addition, the following pairs of options are incompatible:
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 7ab50cda2ad..56d82a52106 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -102,6 +102,7 @@ struct rebase_options {
>         int reschedule_failed_exec;
>         int reapply_cherry_picks;
>         int fork_point;
> +       int update_refs;
>  };
>
>  #define REBASE_OPTIONS_INIT {                          \
> @@ -298,6 +299,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>                 ret = complete_action(the_repository, &replay, flags,
>                         shortrevisions, opts->onto_name, opts->onto,
>                         &opts->orig_head, &commands, opts->autosquash,
> +                       opts->update_refs,
>                         &todo_list);
>         }
>
> @@ -1124,6 +1126,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                 OPT_BOOL(0, "autosquash", &options.autosquash,
>                          N_("move commits that begin with "
>                             "squash!/fixup! under -i")),
> +               OPT_BOOL(0, "update-refs", &options.update_refs,
> +                        N_("update local refs that point to commits "
> +                           "that are being rebased")),
>                 { OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
>                         N_("GPG-sign commits"),
>                         PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> diff --git a/sequencer.c b/sequencer.c
> index 0b61835d441..915d87a0336 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -35,6 +35,7 @@
>  #include "commit-reach.h"
>  #include "rebase-interactive.h"
>  #include "reset.h"
> +#include "branch.h"
>
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>
> @@ -5615,10 +5616,113 @@ static int skip_unnecessary_picks(struct repository *r,
>         return 0;
>  }
>
> +struct todo_add_branch_context {
> +       struct todo_item *items;
> +       size_t items_nr;
> +       size_t items_alloc;
> +       struct strbuf *buf;
> +       struct commit *commit;
> +       struct string_list refs_to_oids;
> +};
> +
> +static int add_decorations_to_list(const struct commit *commit,
> +                                  struct todo_add_branch_context *ctx)
> +{
> +       const struct name_decoration *decoration = get_name_decoration(&commit->object);
> +
> +       while (decoration) {
> +               struct todo_item *item;
> +               const char *path;
> +               size_t base_offset = ctx->buf->len;
> +
> +               ALLOC_GROW(ctx->items,
> +                       ctx->items_nr + 1,
> +                       ctx->items_alloc);
> +               item = &ctx->items[ctx->items_nr];
> +               memset(item, 0, sizeof(*item));
> +
> +               /* If the branch is checked out, then leave a comment instead. */
> +               if ((path = branch_checked_out(decoration->name))) {
> +                       item->command = TODO_COMMENT;
> +                       strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
> +                                   decoration->name, path);
> +               } else {
> +                       struct string_list_item *sti;
> +                       item->command = TODO_UPDATE_REF;
> +                       strbuf_addf(ctx->buf, "%s\n", decoration->name);
> +
> +                       sti = string_list_append(&ctx->refs_to_oids,
> +                                                decoration->name);
> +                       sti->util = oiddup(the_hash_algo->null_oid);
> +               }
> +
> +               item->offset_in_buf = base_offset;
> +               item->arg_offset = base_offset;
> +               item->arg_len = ctx->buf->len - base_offset;
> +               ctx->items_nr++;
> +
> +               decoration = decoration->next;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * For each 'pick' command, find out if the commit has a decoration in

Is this really limited to picks?  If someone uses --autosquash and has
a fixup or squash in the list, wouldn't this apply as well, or does
all of this apply before the transformations to fixup/squash?  Also,
what if the user is doing --rebase-merges and there's a merge commit
with a branch pointing at the merge.   Would that be included?

> + * refs/heads/. If so, then add a 'label for-update-refs/' command.
> + */
> +static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
> +{
> +       int i;
> +       static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
> +       static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
> +       static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
> +       struct decoration_filter decoration_filter = {
> +               .include_ref_pattern = &decorate_refs_include,
> +               .exclude_ref_pattern = &decorate_refs_exclude,
> +               .exclude_ref_config_pattern = &decorate_refs_exclude_config,
> +       };
> +       struct todo_add_branch_context ctx = {
> +               .buf = &todo_list->buf,
> +               .refs_to_oids = STRING_LIST_INIT_DUP,
> +       };
> +
> +       ctx.items_alloc = 2 * todo_list->nr + 1;
> +       ALLOC_ARRAY(ctx.items, ctx.items_alloc);
> +
> +       string_list_append(&decorate_refs_include, "refs/heads/");
> +       load_ref_decorations(&decoration_filter, 0);
> +
> +       for (i = 0; i < todo_list->nr; ) {
> +               struct todo_item *item = &todo_list->items[i];
> +
> +               /* insert ith item into new list */
> +               ALLOC_GROW(ctx.items,
> +                          ctx.items_nr + 1,
> +                          ctx.items_alloc);
> +
> +               ctx.items[ctx.items_nr++] = todo_list->items[i++];
> +
> +               if (item->commit) {
> +                       ctx.commit = item->commit;
> +                       add_decorations_to_list(item->commit, &ctx);
> +               }
> +       }
> +
> +       string_list_clear(&ctx.refs_to_oids, 1);
> +       free(todo_list->items);
> +       todo_list->items = ctx.items;
> +       todo_list->nr = ctx.items_nr;
> +       todo_list->alloc = ctx.items_alloc;
> +
> +       return 0;
> +}
> +
>  int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
>                     const char *shortrevisions, const char *onto_name,
>                     struct commit *onto, const struct object_id *orig_head,
>                     struct string_list *commands, unsigned autosquash,
> +                   unsigned update_refs,
>                     struct todo_list *todo_list)
>  {
>         char shortonto[GIT_MAX_HEXSZ + 1];
> @@ -5637,6 +5741,9 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>                 item->arg_len = item->arg_offset = item->flags = item->offset_in_buf = 0;
>         }
>
> +       if (update_refs && todo_list_add_update_ref_commands(todo_list))
> +               return -1;
> +
>         if (autosquash && todo_list_rearrange_squash(todo_list))
>                 return -1;
>
> diff --git a/sequencer.h b/sequencer.h
> index 2cf5c1b9a38..e671d7e0743 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -167,6 +167,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>                     const char *shortrevisions, const char *onto_name,
>                     struct commit *onto, const struct object_id *orig_head,
>                     struct string_list *commands, unsigned autosquash,
> +                   unsigned update_refs,
>                     struct todo_list *todo_list);
>  int todo_list_rearrange_squash(struct todo_list *todo_list);
>
> diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
> index f1e9e172a0c..203997d92c6 100755
> --- a/t/t2407-worktree-heads.sh
> +++ b/t/t2407-worktree-heads.sh
> @@ -151,4 +151,21 @@ test_expect_success 'refuse to overwrite when in error states' '
>         done
>  '
>
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +test_expect_success !SANITIZE_LEAK 'refuse to overwrite during rebase with --update-refs' '
> +       git commit --fixup HEAD~2 --allow-empty &&
> +       (
> +               set_cat_todo_editor &&
> +               test_must_fail git rebase -i --update-refs HEAD~3 >todo &&
> +               ! grep "update-refs" todo
> +       ) &&
> +       git branch -f allow-update HEAD~2 &&
> +       (
> +               set_cat_todo_editor &&
> +               test_must_fail git rebase -i --update-refs HEAD~3 >todo &&
> +               grep "update-ref refs/heads/allow-update" todo
> +       )
> +'
> +
>  test_done
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index f31afd4a547..3cd20733bc8 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1743,6 +1743,76 @@ test_expect_success 'ORIG_HEAD is updated correctly' '
>         test_cmp_rev ORIG_HEAD test-orig-head@{1}
>  '
>
> +test_expect_success '--update-refs adds label and update-ref commands' '
> +       git checkout -b update-refs no-conflict-branch &&
> +       git branch -f base HEAD~4 &&
> +       git branch -f first HEAD~3 &&
> +       git branch -f second HEAD~3 &&
> +       git branch -f third HEAD~1 &&
> +       git commit --allow-empty --fixup=third &&
> +       git branch -f shared-tip &&
> +       (
> +               set_cat_todo_editor &&
> +
> +               cat >expect <<-EOF &&
> +               pick $(git log -1 --format=%h J) J
> +               update-ref refs/heads/second
> +               update-ref refs/heads/first
> +               pick $(git log -1 --format=%h K) K
> +               pick $(git log -1 --format=%h L) L
> +               fixup $(git log -1 --format=%h update-refs) fixup! L # empty
> +               update-ref refs/heads/third
> +               pick $(git log -1 --format=%h M) M
> +               update-ref refs/heads/no-conflict-branch
> +               update-ref refs/heads/shared-tip
> +               EOF
> +
> +               test_must_fail git rebase -i --autosquash --update-refs primary >todo &&
> +               test_cmp expect todo
> +       )
> +'
> +
> +test_expect_success '--update-refs adds commands with --rebase-merges' '
> +       git checkout -b update-refs-with-merge no-conflict-branch &&
> +       git branch -f base HEAD~4 &&
> +       git branch -f first HEAD~3 &&
> +       git branch -f second HEAD~3 &&
> +       git branch -f third HEAD~1 &&
> +       git merge -m merge branch2 &&
> +       git branch -f merge-branch &&
> +       git commit --fixup=third --allow-empty &&
> +       (
> +               set_cat_todo_editor &&
> +
> +               cat >expect <<-EOF &&
> +               label onto
> +               reset onto
> +               pick $(git log -1 --format=%h branch2~1) F
> +               pick $(git log -1 --format=%h branch2) I
> +               update-ref refs/heads/branch2
> +               label merge
> +               reset onto
> +               pick $(git log -1 --format=%h refs/heads/second) J
> +               update-ref refs/heads/second
> +               update-ref refs/heads/first
> +               pick $(git log -1 --format=%h refs/heads/third~1) K
> +               pick $(git log -1 --format=%h refs/heads/third) L
> +               fixup $(git log -1 --format=%h update-refs-with-merge) fixup! L # empty
> +               update-ref refs/heads/third
> +               pick $(git log -1 --format=%h HEAD~2) M
> +               update-ref refs/heads/no-conflict-branch
> +               merge -C $(git log -1 --format=%h HEAD~1) merge # merge
> +               update-ref refs/heads/merge-branch
> +               EOF
> +
> +               test_must_fail git rebase -i --autosquash \
> +                                  --rebase-merges=rebase-cousins \
> +                                  --update-refs primary >todo &&
> +
> +               test_cmp expect todo
> +       )
> +'
> +
>  # This must be the last test in this file
>  test_expect_success '$EDITOR and friends are unchanged' '
>         test_editor_unchanged
> --
> gitgitgadget
>
