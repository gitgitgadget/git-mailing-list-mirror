Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673E8C678D5
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 20:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCDUcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 15:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDUcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 15:32:16 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755E31BAFA
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 12:32:05 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s22so7851495lfi.9
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 12:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677961924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRnbIlJUmURM+CtborCtLzboO1TWrpgG0Z2dV1/fMPM=;
        b=SJhUsG2qbg7E5s1c/WP/66CyJQitqQp+NY4dN61k2/pAaDJd/5dBkrFAok7DC8vPXO
         oAT3SamO7KpE2qZyPdd5yvbwsOe2StkMB15ionv0lyRrOhgJswbJ+L9HZR68cPqg/Jzn
         NPGqF6pHCSughasv+zOF+x5rJip9Ql/DtkY2u7nqEi/cpfIuKJGzvYtNxItsVfRPSaof
         NDeMaFXXz7xcBAe5F0N7sAL4k4Fek6hTcuUjNCi3UIRSUE1j04EE1SbWRfZasDwwXCGZ
         vBQ4e/33nsmZj/DHhgfJMAKtOK7itURXdgkhB0QTvz2gZSyEYB64nVDNbd0i+VsAyQTD
         Pb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677961924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRnbIlJUmURM+CtborCtLzboO1TWrpgG0Z2dV1/fMPM=;
        b=42MQItxAJUK7leuTypBBI8jZIU5cLcY7ulN8fpPMpm6DH2dIxOucK0zp6qT1/3Mrul
         8Jpe25bZ1Nynjv7SSfl09+OVptQNwvM+73DLMTSXrk4gXJLX835wYPQpLGWKYrGVj1AP
         X8g/Tc1rCFZAZhDYhF09fGYttYFIE9MSdrYdDUNexU3TVqWpkEj9FtECQzN4+DrcB8Mi
         +0nNa6iO+QYJbJgObnU2WlRint6GkYqFhuJiJBir5c0X4GSsBs1cNzzD5LDakY8DXlIA
         2KpzoxBxQIaA7T5aM8jbB3Fpzb86YrJLCSV+8uDMdXoBEmmKEhWi6Ij4Gof2A0YaW9vV
         SbLg==
X-Gm-Message-State: AO0yUKWB1K0RPewAWs09aBr/pjv9jlfJ/VkcT2hDl8K6IEdNmzUwJOVe
        PTehxAGygP86x0kZRuZxY4b71DFThC3Lidn59Sk=
X-Google-Smtp-Source: AK7set9jJoY2pcdSmXqGnqyA7L4uFVZKFEa6lz4yRZKJq4EvYb1COsijxKCVaa9/h5Q+iWzoGTWB1WU5L8bvTv5LLSM=
X-Received: by 2002:ac2:5109:0:b0:4d8:50e1:8ba7 with SMTP id
 q9-20020ac25109000000b004d850e18ba7mr1771420lfb.2.1677961923238; Sat, 04 Mar
 2023 12:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20230303145311.513960-1-eantoranz@gmail.com>
In-Reply-To: <20230303145311.513960-1-eantoranz@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 4 Mar 2023 12:31:50 -0800
Message-ID: <CABPp-BGOtsjgfN5f=dSb0ZSEx8nzFs6SKrUm=2TtPPH5cKa4cA@mail.gmail.com>
Subject: Re: [RFC PATCH] sequencer - tipped merge strategy
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Edmundo,

On Fri, Mar 3, 2023 at 7:43=E2=80=AFAM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> When rebasing merge commits and dealing with conflicts, having the
> original merge commit as a reference can help us avoid some of
> them.
>
>
> With this patch, we leverage the original merge commit to handle the most
> obvious case:
> - HEAD tree has to match the tree of the first parent of the original mer=
ge
>   commit.
> - MERGE_HEAD tree has to match the tree of the second parent of the origi=
nal
>   merge commit.
> - At least one tree in the merge bases of HEAD/MERGE_HEAD has to match
>   a tree in the merge bases of the parent commits of the original merge
>   commit.
>
> If all of those conditions are met, we can safely use the tree of the
> original merge commit as the resulting tree of this merge that is being
> attempted at the time.

The conditions are quite specific, making one wonder what you are
trying to do, and yet also leave an obvious open hole that seems to be
inviting bugs.

Having read the rest of this thread, I notice you pointed out to Junio
that you want to amend a commit in the history of the merge,
suggesting you are just modifying the commit message (or maybe
author/committer info).  More generally, I _think_ your usecase and
justification for this patch could be worded something like:

"""
We often rebase with `--rebase-merges`, `--interactive`, and
`--keep-base` (or equivalent command line flags) and only modify
commit metadata during the rebase.  Since we do not modify any files,
we would like the rebase to proceed without conflicts.  However, since
--rebase-merges currently does not rebase merges but recreates them
from scratch (ignoring everything but the commit metadata of the old
merge), it forces users to redo conflict resolution.  Since the trees
of all relevant commits have not changed, this conflict resolution
feels unnecessary.  In this patch we do not try to solve the general
problem of rebasing merges, but instead introduce a narrow hack
specific to this particular scenario: we check that the trees of all
relevant commits involved in the new merge are the same as for the old
merge, and when that holds, use the tree from the original merge as
the merge resolution.  In more detail:
"""

which would be followed immediately by your text after "handle the
most obvious case:"

Am I reading your motivation correctly?

Also, as Junio highlighted, I don't believe it's safe to only require
that one tree of the merge bases match.  You should require having
both the same number of merge bases and that the set of trees for the
merge bases of both the old and new merge commits exactly match.

As a high level review, I personally tend to dislike piecemeal
solutions that only work for very specific cases.  However, others on
the list may decide to include it, so long as it doesn't actively hurt
other cases.  One request I would make, if it is to be included, is
that we design it such that we can easily jettison this code (& any
documentation it needs) later when we gain a more general solution for
rebasing merges.

> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
>  .gitignore          |   1 +
>  Makefile            |   1 +
>  builtin.h           |   1 +
>  builtin/merge-tms.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
>  git.c               |   1 +
>  sequencer.c         |  36 ++++++++++-
>  6 files changed, 187 insertions(+), 1 deletion(-)

I understand waiting to make documentation updates while your proposal
is just an RFC, but I think tests might help showcase how the strategy
is meant to be used and verify whether the behavior is sane when your
new strategy doesn't apply.

>  create mode 100644 builtin/merge-tms.c
>
> diff --git a/.gitignore b/.gitignore
> index e875c59054..8b534f98e6 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -103,6 +103,7 @@
>  /git-merge-recursive
>  /git-merge-resolve
>  /git-merge-subtree
> +/git-merge-tms
>  /git-mergetool
>  /git-mergetool--lib
>  /git-mktag
> diff --git a/Makefile b/Makefile
> index 50ee51fde3..10a3167c50 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1264,6 +1264,7 @@ BUILTIN_OBJS +=3D builtin/merge-file.o
>  BUILTIN_OBJS +=3D builtin/merge-index.o
>  BUILTIN_OBJS +=3D builtin/merge-ours.o
>  BUILTIN_OBJS +=3D builtin/merge-recursive.o
> +BUILTIN_OBJS +=3D builtin/merge-tms.o
>  BUILTIN_OBJS +=3D builtin/merge-tree.o
>  BUILTIN_OBJS +=3D builtin/merge.o
>  BUILTIN_OBJS +=3D builtin/mktag.o
> diff --git a/builtin.h b/builtin.h
> index 46cc789789..94dcb73f85 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -180,6 +180,7 @@ int cmd_merge_index(int argc, const char **argv, cons=
t char *prefix);
>  int cmd_merge_ours(int argc, const char **argv, const char *prefix);
>  int cmd_merge_file(int argc, const char **argv, const char *prefix);
>  int cmd_merge_recursive(int argc, const char **argv, const char *prefix)=
;
> +int cmd_merge_tms(int argc, const char **argv, const char *prefix);
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix);
>  int cmd_mktag(int argc, const char **argv, const char *prefix);
>  int cmd_mktree(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/merge-tms.c b/builtin/merge-tms.c
> new file mode 100644
> index 0000000000..37a2427757
> --- /dev/null
> +++ b/builtin/merge-tms.c
> @@ -0,0 +1,148 @@
> +/*
> + * Copyright (c) 2023 Edmundo Carmona Antoranz

I dislike having these in our files.  Despite the file being modified
later, they are virtually never updated to list the new authors and
new years.  Needing to always update these lines of code would
obviously be onerous, and is why we don't do that, but that just means
these lines always eventually become inaccurate and perhaps even
wildly misleading.  People can look at log/blame/etc. to find out the
_correct_ information, so what purpose does a line like this serve?

(I'm not a lawyer or anything close; I previously suggested ripping
these lines out of our codebase but people pointed out we can't rip
them out once put in.  But it'd be nice to avoid spreading the
problem.  Or maybe there are still lawyer-ish reasons for including
these that I'm not aware of?)

> + * Released under the terms of GPL2

That's automatic for anything in the project that doesn't explicitly
state otherwise; I'd rather not have this included for every file.

Tangential question for the list: If folks do want their contributions
to also be available under an alternate license (e.g. as done for
sha1dc or as done with
https://github.com/libgit2/libgit2/blob/main/git.git-authors), is
there a scheme for doing so?  Incidentally, my employer told me that
any new entire files or subsystems that I contributed should be
licensed under MIT (like sha1dc is).  I didn't want to have to deal
with that headache, but luckily I was copying a bunch of
merge-recursive.[ch] code into merge-ort.[ch], so I just did that in
the initial commits and side-stepped the whole question.  :-)  (But
really, if anyone wants any of the code I've contributed to Git under
MIT during my time at Palantir, that's what my employer
wanted/intended so you've got permission to do so.)

...and with these two first lines out of the way, I can stop
commenting on things I have a tenuous grasp on (copyright & licenses)
to things that I actually know something about...

> + *
> + * Tipped merge strategy.... a.k.a. fortune-teller merge strategy
> + *
> + * In cases like rebases, merge commits offer us the advantage of knowin=
g
> + * _before hand_ what the previous result of the _original_ branches
> + * involved was.
> + *
> + * This merge strategy tries to leverage this knowledge so that we can
> + * avoid at least the most obvious conflicts that have been solved in th=
e
> + * original merge commit.

Except it doesn't solve "the most obvious conflicts", it either solves
all of the conflicts or none of them.  Perhaps this wording can be fixed up=
?

> + *
> + * In the current state, the strategy works based on exact matches of th=
e trees
> + * involved:
> + * - HEAD tree has to match the tree of the first parent of the original=
 merge
> + *   commit.
> + * - MERGE_HEAD tree has to match the tree of the second parent of the o=
riginal
> + *   merge commit.
> + * - At least one tree in the merge bases of HEAD/MERGE_HEAD has to matc=
h
> + *   a tree in the merge bases of the parent commits of the original mer=
ge
> + *   commit.
> + * If all of those conditions are met, we can safely use the tree of the
> + * original merge commit as the resulting tree of this merge that is bei=
ng
> + * attempted at the time.
> + */
> +
> +#include "builtin.h"
> +#include "commit-reach.h"
> +#include "oid-array.h"
> +#include "parse-options.h"
> +#include "run-command.h"
> +
> +
> +struct tms_options {
> +       const char *tip;
> +       const char *merge_head;
> +} tms_options;
> +
> +static int restore(struct commit *commit)
> +{
> +       struct child_process cmd =3D CHILD_PROCESS_INIT;
> +
> +       strvec_push(&cmd.args, "restore");
> +       strvec_push(&cmd.args, "--worktree");
> +       strvec_push(&cmd.args, "--stage");
> +       strvec_pushf(&cmd.args, "--source=3D%s",
> +                    oid_to_hex(&commit->object.oid));
> +       strvec_push(&cmd.args, "--");
> +       strvec_push(&cmd.args, ".");
> +       cmd.git_cmd =3D 1;
> +       return run_command(&cmd);

We fork subprocesses a lot in git, but it was a horrible mistake.  It
hurts performance, it *really* hurts on Windows (or so I hear), it
hurts debuggability/maintainability in general, and we should be
removing this from our codebase rather than adding more.  As someone
who has put time into slowly eradicating this from our codebase,
please make library functions you can call instead.  (Actually, first
look and see if there are relevant library functions.
Rebase/sequencer probably already needed this and already wrote such a
function.)

> +}
> +
> +static void load_tree_oids(struct oid_array *oids, struct commit_list *b=
ases)
> +{
> +       struct commit_list *i;
> +
> +       for (i =3D bases; i; i =3D i->next)
> +               oid_array_append(oids, get_commit_tree_oid(i->item));
> +}
> +
> +static int find_oid(const struct object_id *oid,
> +               void *data)
> +{
> +       struct oid_array *other_list =3D (struct oid_array *) data;
> +       int pos =3D oid_array_lookup(other_list, oid);
> +       return pos >=3D 0 ? 1 : 0;
> +}
> +
> +static int base_match(struct commit *rebase_head,
> +               struct commit *head,
> +               struct commit *merge_head)
> +{
> +       struct commit_list *bases_current, *bases_tip;
> +       struct oid_array trees_current =3D OID_ARRAY_INIT;
> +       struct oid_array trees_tip =3D OID_ARRAY_INIT;
> +       int oid_match;
> +
> +       bases_current =3D get_merge_bases(head, merge_head);
> +       bases_tip =3D get_merge_bases(rebase_head->parents->item,
> +                                   rebase_head->parents->next->item);
> +       load_tree_oids(&trees_current, bases_current);
> +       load_tree_oids(&trees_tip, bases_tip);
> +
> +       oid_match =3D oid_array_for_each(&trees_current, find_oid, &trees=
_tip);
> +
> +       oid_array_clear(&trees_current);
> +       oid_array_clear(&trees_tip);
> +
> +       return oid_match;
> +}
> +
> +static int run_tms_merge(struct tms_options *options)
> +{
> +       struct commit *head, *merge_head, *tip;
> +       struct commit_list *i;
> +
> +       head =3D lookup_commit_reference_by_name("HEAD");
> +       merge_head =3D lookup_commit_reference_by_name(options->merge_hea=
d);
> +       tip =3D lookup_commit_reference_by_name(options->tip);
> +
> +       if (!(head && merge_head && tip)) {
> +               return 2;
> +       }
> +       if (commit_list_count(tip->parents) !=3D 2)
> +               return 2;
> +
> +       for (i =3D tip->parents; i; i =3D i->next)
> +               parse_commit(i->item);
> +       if (!oideq(get_commit_tree_oid(head),
> +                  get_commit_tree_oid(tip->parents->item)))
> +               return 2;
> +       if (!oideq(get_commit_tree_oid(merge_head),
> +                  get_commit_tree_oid(tip->parents->next->item)))
> +               return 2;
> +
> +       if (!base_match(tip, head, merge_head))
> +               return 2;
> +
> +       if (restore(tip))
> +               return 2;

So six different cases where this merge strategy can currently bail
and do nothing; I'll discuss this more below.

> +
> +       return 0;
> +}
> +
> +int cmd_merge_tms(int argc, const char **argv, const char *prefix)
> +{
> +
> +       struct option mt_options[] =3D {
> +               OPT_STRING(0, "tip", &tms_options.tip,
> +                           N_("tip-merge-commit"),
> +                           N_("merge commit being rebased used as a tip =
for conflict resolution.")),
> +               OPT_END()
> +       };
> +       argc =3D parse_options(argc, argv, NULL, mt_options,
> +                            NULL, 0);
> +
> +       if (argc !=3D 1)
> +               return 2;
> +       tms_options.merge_head =3D argv[0];
> +
> +       if (!tms_options.tip)
> +               return 2;

By creating a builtin named "merge-<foo>", you implicitly create a
`--strategy <foo>` option for git-merge, not just something for
git-rebase.  If we publish this new merge strategy in a released
version of Git, we'll have to support it for ~forever.  For something
that is meant as a short-term hack, I'd rather avoid that.  Further,
your merge strategy does not accept the normal arguments that a merge
strategy accepts, and will bail with an exit status of 2 if a "--tip"
is not specified.  Luckily, my comments elsewhere to make library
calls instead of forking subprocesses would also solve these issues
here.

I will also point out that this main function adds two more cases
where we can bail and do nothing, returning a status of 2, so now
we're up to eight cases.  Again, I'll discuss these more below.

> +
> +       return run_tms_merge(&tms_options);
> +}
> diff --git a/git.c b/git.c
> index 96b0a2837d..2e843731f1 100644
> --- a/git.c
> +++ b/git.c
> @@ -544,6 +544,7 @@ static struct cmd_struct commands[] =3D {
>         { "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_W=
ORK_TREE | NO_PARSEOPT },
>         { "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED=
_WORK_TREE | NO_PARSEOPT },
>         { "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TRE=
E | NO_PARSEOPT },
> +       { "merge-tms", cmd_merge_tms, RUN_SETUP },
>         { "merge-tree", cmd_merge_tree, RUN_SETUP },
>         { "mktag", cmd_mktag, RUN_SETUP },
>         { "mktree", cmd_mktree, RUN_SETUP },
> diff --git a/sequencer.c b/sequencer.c
> index 65a34f9676..559169814b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3833,6 +3833,21 @@ static int do_reset(struct repository *r,
>         return ret;
>  }
>
> +static int try_tms_merge(struct replay_opts *opts,
> +                        struct commit *rebase_head,
> +                        struct commit *merge_commit)
> +{
> +       struct child_process cmd =3D CHILD_PROCESS_INIT;
> +
> +       strvec_push(&cmd.args, "merge-tms");
> +       strvec_push(&cmd.args, "--tip");
> +       strvec_pushf(&cmd.args, "%s", oid_to_hex(&rebase_head->object.oid=
));
> +       strvec_pushf(&cmd.args, "%s", oid_to_hex(&merge_commit->object.oi=
d));
> +
> +       cmd.git_cmd =3D 1;
> +       return run_command(&cmd) ? 0 : 1;

Again, let's please not fork subprocesses for builtin code.

> +}
> +
>  static int do_merge(struct repository *r,
>                     struct commit *commit,
>                     const char *arg, int arg_len,
> @@ -3846,7 +3861,8 @@ static int do_merge(struct repository *r,
>         const char *strategy =3D !opts->xopts_nr &&
>                 (!opts->strategy ||
>                  !strcmp(opts->strategy, "recursive") ||
> -                !strcmp(opts->strategy, "ort")) ?
> +                !strcmp(opts->strategy, "ort") ||
> +                !strcmp(opts->strategy, "tms")) ?

So folks trigger this by passing `--strategy tms` to rebase.
Typically, all the --strategy options to rebase are also ones that
merge accepts.  So if we trigger via that method, we may need to
expose the strategy to merge as well...or update the documentation in
various places that talks about merge strategies to be more specific
about which ones apply where.

Also, what if the merge strategy is inappropriate for the case in
question?  "ort" and "recursive" are appropriate for all non-octopus
merges, and the code only gets to this point in sequencer if we have a
non-octopus merge to do.  But your strategy is inappropriate other
than in very specific circumstances that haven't yet been checked.
What will the code do if we're under one of the many cases where "tms"
isn't applicable?  More on this question below.

>                 NULL : opts->strategy;
>         struct merge_options o;
>         int merge_arg_len, oneline_offset, can_fast_forward, ret, k;
> @@ -4086,6 +4102,23 @@ static int do_merge(struct repository *r,
>         o.branch2 =3D ref_name.buf;
>         o.buffer_output =3D 2;
>
> +       if (!opts->strategy || !strcmp(opts->strategy, "tms")) {
> +               rollback_lock_file(&lock);
> +               ret =3D try_tms_merge(opts, commit, to_merge->item);
> +               if (ret) {
> +                       discard_index(r->index);
> +                       if (repo_read_index(r) < 0) {
> +                               ret =3D error(_("could not read index"));
> +                               goto leave_merge;
> +                       }
> +                       goto ran_merge;

We "goto ran_merge", which could be very misleading.  Under the 8
conditions given, we did not run a merge; we bailed early saying the
merge strategy was inappropriate for the conditions at hand.  For
those 8 cases, ret will be 2 and we will jump to...

> +               }
> +               // regain lock to go into recursive
> +               if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR=
) < 0) {
> +                       ret =3D -1;
> +                       goto leave_merge;
> +               }
> +       }
>         if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
>                 /*
>                  * TODO: Should use merge_incore_recursive() and
> @@ -4100,6 +4133,7 @@ static int do_merge(struct repository *r,
>                 ret =3D merge_recursive(&o, head_commit, merge_commit, ba=
ses,
>                                       &i);
>         }
> +ran_merge:
>         if (ret <=3D 0)
>                 fputs(o.obuf.buf, stdout);
>         strbuf_release(&o.obuf);

...here.  The code following this includes a check for ret < 0, and then ru=
ns:

    /*
     * The return value of merge_recursive() is 1 on clean, and 0 on
     * unclean merge.
     *
     * Let's reverse that, so that do_merge() returns 0 upon success and
     * 1 upon failed merge (keeping the return value -1 for the cases where
     * we will want to reschedule the `merge` command).
     */
    ret =3D !ret;

    if (r->index->cache_changed &&
        write_locked_index(r->index, &lock, COMMIT_LOCK)) {
        ret =3D error(_("merge: Unable to write new index file"));
        goto leave_merge;
    }

So, if I'm reading correctly (please double check me), since your
merge strategy made no changes to the index or working tree, and
returned a status of 2, and since !2 =3D=3D !1 =3D=3D 0, we'll treat this t=
he
same as a successful merge and commit the "results", i.e. the tree of
the first parent.  Doesn't this tipped merge strategy thus behave the
same as a `--strategy ours` merge when its preconditions are not
satisfied?  If it does, that would be horrifying.
