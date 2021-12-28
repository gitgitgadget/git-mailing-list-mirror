Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F09CC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 22:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhL1WeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 17:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhL1WeR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 17:34:17 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835CEC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 14:34:16 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f5so79090518edq.6
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 14:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3gVzcH+bTp43UA3X7npPzHWI8hs6PGPLkAn6M2hMURs=;
        b=KRqY736lBeoZKIiBSiaQ4vhzg5W6kowtwzIvPD3lq3CYol8SWodqyy165nv+dQ8nZV
         QjZbcL757/YOaOGvHDNb5C4/TCN3TVY36dRJUHxAwg/JP5qMV7XXGTWkLzQqPX/NhJ8a
         uWPbbxvXqcYdzJHbRPec34/RlbtAxF/WSI0JeKZbF3irOyKL7Z3qniJqXS9njM+eQ78n
         hEwxB8Hfubx8znyIXRiFlpEzsY0mro23uAridFail3o8lKmZWv/qWfzn+dKae1KUsrUf
         h34y6KRUuUWGQivgYNRzAwKsaYnj7ll8K7qC2PZYcST3zkDuWPano/wYcJzilgV8fFSH
         7tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gVzcH+bTp43UA3X7npPzHWI8hs6PGPLkAn6M2hMURs=;
        b=HMqFmG9XDPZfK4hcDwMpfJij94yXSSXSoLEctTGQqx3LmAVKG4uw/yrJCSoxBvSaKb
         gD/Vy0bizLmJ6glXWWMKCMfqsk1V7VXFzqx31miu7mtq2zmYIWZBrysdKj+i6EZVG5TM
         6w5ICA4CkhFgZwwnhX5lyA57ke3zcPzkZ4f+hBws8xaQN804eOeuqDMPOc03frZx/icF
         /Mzbxr+t7AwH0iqhBsruVqHDrvBhkcZj4HL3bZwTz9JHx8wBI3zQYDk1YJ5j8aRM4OIL
         bYZotNRP9rLy1+ut2mVBuAdL5EYjQIWRNH12y6SGJZcbSK4tbG03Xzt4GqWVqgYrkXhs
         i1Mw==
X-Gm-Message-State: AOAM532iYaqRRVBlymEqe7mJQ/5bOR38CCMxGv8biD4KJQ1tklyK9thv
        d3+FkNg/yHP58WOGuJvLHxhcMNL+8ccjHIWpcB4=
X-Google-Smtp-Source: ABdhPJwqzVwLLsCl9pKHc4mkhluGH2aBjTlbOFQbLpPOW0vN2rkm4o6uOZ8PtT5RaTFclgTauJJQCwGXqPSw8bfAv5k=
X-Received: by 2002:a17:907:2d0c:: with SMTP id gs12mr18944106ejc.100.1640730854811;
 Tue, 28 Dec 2021 14:34:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com> <b3ae62083e14aecdfe909735b4daf0a36fa5e48c.1640419159.git.gitgitgadget@gmail.com>
 <20211228105600.h32jl5iwot3munww@gmail.com>
In-Reply-To: <20211228105600.h32jl5iwot3munww@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Dec 2021 14:34:03 -0800
Message-ID: <CABPp-BEJ+RiripJSonrOcJfRWKZDeoL83PDqE6beWwFqs1HxTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] show, log: provide a --remerge-diff capability
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CC'ing brian in case he has comments on the sha256 stuff and whether
he thinks there's a cleaner way to make my tests work with sha256.
(brian: See the very end of the email.)

On Tue, Dec 28, 2021 at 2:56 AM Johannes Altmanninger <aclopte@gmail.com> wrote:
>
> On Sat, Dec 25, 2021 at 07:59:12AM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > When this option is specified, we remerge all (two parent) merge commits
> > and diff the actual merge commit to the automatically created version,
> > in order to show how users removed conflict markers, resolved the
> > different conflict versions, and potentially added new changes outside
> > of conflict regions in order to resolve semantic merge problems (or,
> > possibly, just to hide other random changes).
> >
> > This capability works by creating a temporary object directory and
> > marking it as the primary object store.  This makes it so that any blobs
> > or trees created during the automatic merge easily removable afterwards
>
> s/easily/are easily/ ?

sure

> > by just deleting all objects from the temporary object directory.
> >
> > There are a few ways that this implementation is suboptimal:
> >   * `log --remerge-diff` becomes slow, because the temporary object
> >     directory can fills with many loose objects while running
>
> s/can fills/can fill/

Thanks.

>
> >   * the log output can be muddied with misplaced "warning: cannot merge
> >     binary files" messages, since ll-merge.c unconditionally writes those
> >     messages to stderr while running instead of allowing callers to
> >     manage them.
> >   * important conflict and warning messages are simply dropped; thus for
> >     conflicts like modify/delete or rename/rename or file/directory which
> >     are not representable with content conflict markers, there may be no
> >     way for a user of --remerge-diff to know that there had been a
> >     conflict which was resolved (and which possibly motivated other
> >     changes in the merge commit).
> > Subsequent commits will address these issues.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/diff-options.txt |  8 ++++
> >  builtin/log.c                  | 14 ++++++
> >  diff-merges.c                  | 12 +++++
> >  log-tree.c                     | 59 +++++++++++++++++++++++
> >  revision.h                     |  3 +-
> >  t/t4069-remerge-diff.sh        | 86 ++++++++++++++++++++++++++++++++++
> >  6 files changed, 181 insertions(+), 1 deletion(-)
> >  create mode 100755 t/t4069-remerge-diff.sh
> >
> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> > index c89d530d3d1..b05f1c9f1c9 100644
> > --- a/Documentation/diff-options.txt
> > +++ b/Documentation/diff-options.txt
> > @@ -64,6 +64,14 @@ ifdef::git-log[]
> >       each of the parents. Separate log entry and diff is generated
> >       for each parent.
> >  +
> > +--diff-merges=remerge:::
> > +--diff-merges=r:::
> > +--remerge-diff:::
>
> The synopsis above needs an update, too:
>
>         diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>         index c89d530d3d..7a98ab3f85 100644
>         --- a/Documentation/diff-options.txt
>         +++ b/Documentation/diff-options.txt
>         @@ -36,3 +36,3 @@ endif::git-format-patch[]
>          ifdef::git-log[]
>         ---diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc)::
>         +--diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r)::
>          --no-diff-merges::

Ah, good catch.

> > +     With this option, two-parent merge commits are remerged to
> > +     create a temporary tree object -- potentially containing files
> > +     with conflict markers and such.  A diff is then shown between
> > +     that temporary tree and the actual merge commit.
>
> I had not really looked at any of the --diff-merges options before.  The term
> "remerge" felt a bit opaque at first, because I didn't know what the diff
> would look like. I might have found this easier:
>
> --diff-merges=resolution:::
> --diff-merges=r:::
> --resolution-diff:::
>         This makes two-parent merge commits show the diff with respect to
>         a mechanical merge of their parents -- potentially containing files
>         with conflict markers and such.
>
> But on a second thought, remerge is actually consistent with the rest,
> because it states _what_ we compare to the merge commit, so nevermind.
>
> > ++
> >  --diff-merges=combined:::
> >  --diff-merges=c:::
> >  -c:::
> > diff --git a/builtin/log.c b/builtin/log.c
> > index f75d87e8d7f..d053418fddd 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -35,6 +35,7 @@
> >  #include "repository.h"
> >  #include "commit-reach.h"
> >  #include "range-diff.h"
> > +#include "tmp-objdir.h"
> >
> >  #define MAIL_DEFAULT_WRAP 72
> >  #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
> > @@ -406,6 +407,14 @@ static int cmd_log_walk(struct rev_info *rev)
> >       struct commit *commit;
> >       int saved_nrl = 0;
> >       int saved_dcctc = 0;
> > +     struct tmp_objdir *remerge_objdir = NULL;
> > +
> > +     if (rev->remerge_diff) {
> > +             remerge_objdir = tmp_objdir_create("remerge-diff");
> > +             if (!remerge_objdir)
> > +                     die_errno(_("unable to create temporary object directory"));
> > +             tmp_objdir_replace_primary_odb(remerge_objdir, 1);
> > +     }
> >
> >       if (rev->early_output)
> >               setup_early_output();
> > @@ -449,6 +458,9 @@ static int cmd_log_walk(struct rev_info *rev)
> >       rev->diffopt.no_free = 0;
> >       diff_free(&rev->diffopt);
> >
> > +     if (rev->remerge_diff)
> > +             tmp_objdir_destroy(remerge_objdir);
> > +
> >       if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
> >           rev->diffopt.flags.check_failed) {
> >               return 02;
> > @@ -1943,6 +1955,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> >               die(_("--name-status does not make sense"));
> >       if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
> >               die(_("--check does not make sense"));
> > +     if (rev.remerge_diff)
> > +             die(_("--remerge-diff does not make sense"));
> >
> >       if (!use_patch_format &&
> >               (!rev.diffopt.output_format ||
> > diff --git a/diff-merges.c b/diff-merges.c
> > index 5060ccd890b..0af4b3f9191 100644
> > --- a/diff-merges.c
> > +++ b/diff-merges.c
> > @@ -17,6 +17,7 @@ static void suppress(struct rev_info *revs)
> >       revs->combined_all_paths = 0;
> >       revs->merges_imply_patch = 0;
> >       revs->merges_need_diff = 0;
> > +     revs->remerge_diff = 0;
> >  }
> >
> >  static void set_separate(struct rev_info *revs)
> > @@ -45,6 +46,12 @@ static void set_dense_combined(struct rev_info *revs)
> >       revs->dense_combined_merges = 1;
> >  }
> >
> > +static void set_remerge_diff(struct rev_info *revs)
> > +{
> > +     suppress(revs);
> > +     revs->remerge_diff = 1;
> > +}
> > +
> >  static diff_merges_setup_func_t func_by_opt(const char *optarg)
> >  {
> >       if (!strcmp(optarg, "off") || !strcmp(optarg, "none"))
> > @@ -57,6 +64,8 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
> >               return set_combined;
> >       else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
> >               return set_dense_combined;
> > +     else if (!strcmp(optarg, "r") || !strcmp(optarg, "remerge"))
> > +             return set_remerge_diff;
> >       else if (!strcmp(optarg, "m") || !strcmp(optarg, "on"))
> >               return set_to_default;
> >       return NULL;
> > @@ -110,6 +119,9 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
> >       } else if (!strcmp(arg, "--cc")) {
> >               set_dense_combined(revs);
> >               revs->merges_imply_patch = 1;
> > +     } else if (!strcmp(arg, "--remerge-diff")) {
> > +             set_remerge_diff(revs);
> > +             revs->merges_imply_patch = 1;
> >       } else if (!strcmp(arg, "--no-diff-merges")) {
> >               suppress(revs);
> >       } else if (!strcmp(arg, "--combined-all-paths")) {
> > diff --git a/log-tree.c b/log-tree.c
> > index 644893fd8cf..84ed864fc81 100644
> > --- a/log-tree.c
> > +++ b/log-tree.c
> > @@ -1,4 +1,5 @@
> >  #include "cache.h"
> > +#include "commit-reach.h"
> >  #include "config.h"
> >  #include "diff.h"
> >  #include "object-store.h"
> > @@ -7,6 +8,7 @@
> >  #include "tag.h"
> >  #include "graph.h"
> >  #include "log-tree.h"
> > +#include "merge-ort.h"
> >  #include "reflog-walk.h"
> >  #include "refs.h"
> >  #include "string-list.h"
> > @@ -902,6 +904,51 @@ static int do_diff_combined(struct rev_info *opt, struct commit *commit)
> >       return !opt->loginfo;
> >  }
> >
> > +static int do_remerge_diff(struct rev_info *opt,
> > +                        struct commit_list *parents,
> > +                        struct object_id *oid,
> > +                        struct commit *commit)
> > +{
> > +     struct merge_options o;
> > +     struct commit_list *bases;
> > +     struct merge_result res = {0};
> > +     struct pretty_print_context ctx = {0};
> > +     struct commit *parent1 = parents->item;
> > +     struct commit *parent2 = parents->next->item;
> > +     struct strbuf parent1_desc = STRBUF_INIT;
> > +     struct strbuf parent2_desc = STRBUF_INIT;
> > +
> > +     /* Setup merge options */
> > +     init_merge_options(&o, the_repository);
> > +     o.show_rename_progress = 0;
>
> Is there a reason why we are repeating the default here (but not anywhere else)?
> For example sequencer.c::do_merge() and builtin/am.c::fall_back_threeway()
> don't, and probably also rely on this being disabled(?).

No, I think each of rebase, am, and merge could sensibly have progress
output be shown -- whether or not they do currently.  Whether or not
showing progress is the default now or in the future, though, we don't
want it for remerge diff.  So, yes, I explicitly made sure to turn it
off.

> > +
> > +     ctx.abbrev = DEFAULT_ABBREV;
> > +     format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
> > +     format_commit_message(parent2, "%h (%s)", &parent2_desc, &ctx);
> > +     o.branch1 = parent1_desc.buf;
> > +     o.branch2 = parent2_desc.buf;
> > +
> > +     /* Parse the relevant commits and get the merge bases */
> > +     parse_commit_or_die(parent1);
> > +     parse_commit_or_die(parent2);
> > +     bases = get_merge_bases(parent1, parent2);
> > +
> > +     /* Re-merge the parents */
> > +     merge_incore_recursive(&o, bases, parent1, parent2, &res);
> > +
> > +     /* Show the diff */
> > +     diff_tree_oid(&res.tree->object.oid, oid, "", &opt->diffopt);
> > +     log_tree_diff_flush(opt);
> > +
> > +     /* Cleanup */
> > +     strbuf_release(&parent1_desc);
> > +     strbuf_release(&parent2_desc);
> > +     merge_finalize(&o, &res);
> > +     /* TODO: clean up the temporary object directory */
> > +
> > +     return !opt->loginfo;
> > +}
> > +
> >  /*
> >   * Show the diff of a commit.
> >   *
> > @@ -936,6 +983,18 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
> >       }
> >
> >       if (is_merge) {
> > +             int octopus = (parents->next->next != NULL);
> > +
> > +             if (opt->remerge_diff) {
> > +                     if (octopus) {
> > +                             show_log(opt);
> > +                             fprintf(opt->diffopt.file,
> > +                                     "diff: warning: Skipping remerge-diff "
> > +                                     "for octopus merges.\n");
> > +                             return 1;
> > +                     }
> > +                     return do_remerge_diff(opt, parents, oid, commit);
> > +             }
> >               if (opt->combine_merges)
> >                       return do_diff_combined(opt, commit);
> >               if (opt->separate_merges) {
> > diff --git a/revision.h b/revision.h
> > index 5578bb4720a..13178e6b8f3 100644
> > --- a/revision.h
> > +++ b/revision.h
> > @@ -195,7 +195,8 @@ struct rev_info {
> >                       combine_merges:1,
> >                       combined_all_paths:1,
> >                       dense_combined_merges:1,
> > -                     first_parent_merges:1;
> > +                     first_parent_merges:1,
> > +                     remerge_diff:1;
> >
> >       /* Format info */
> >       int             show_notes;
> > diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
> > new file mode 100755
> > index 00000000000..192dbce2bfe
> > --- /dev/null
> > +++ b/t/t4069-remerge-diff.sh
> > @@ -0,0 +1,86 @@
> > +#!/bin/sh
> > +
> > +test_description='remerge-diff handling'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup basic merges' '
> > +     test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
> > +     git add numbers &&
> > +     git commit -m base &&
> > +
> > +     git branch feature_a &&
> > +     git branch feature_b &&
> > +     git branch feature_c &&
> > +
> > +     git branch ab_resolution &&
> > +     git branch bc_resolution &&
> > +
> > +     git checkout feature_a &&
> > +     test_write_lines 1 2 three 4 5 6 7 eight 9 >numbers &&
> > +     git commit -a -m change_a &&
> > +
> > +     git checkout feature_b &&
> > +     test_write_lines 1 2 tres 4 5 6 7 8 9 >numbers &&
> > +     git commit -a -m change_b &&
> > +
> > +     git checkout feature_c &&
> > +     test_write_lines 1 2 3 4 5 6 7 8 9 10 >numbers &&
> > +     git commit -a -m change_c &&
> > +
> > +     git checkout bc_resolution &&
> > +     # fast forward
> > +     git merge feature_b &&
>
> maybe use --ff-only instead of the comment? Same below.

That'd be fine.

> (But if we did that we probably want to drop the "no conflict" comment too.)

Nah, I'd rather keep it.

> > +     # no conflict
> > +     git merge feature_c &&
> > +
> > +     git checkout ab_resolution &&
> > +     # fast forward
> > +     git merge feature_a &&
> > +     # conflicts!
> > +     test_must_fail git merge feature_b &&
> > +     # Resolve conflict...and make another change elsewhere
> > +     test_write_lines 1 2 drei 4 5 6 7 acht 9 >numbers &&
> > +     git add numbers &&
> > +     git merge --continue
> > +'
> > +
> > +test_expect_success 'remerge-diff on a clean merge' '
> > +     git log -1 --oneline bc_resolution >expect &&
> > +     git show --oneline --remerge-diff bc_resolution >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'remerge-diff with both a resolved conflict and an unrelated change' '
> > +     git log -1 --oneline ab_resolution >tmp &&
> > +     cat <<-EOF >>tmp &&
> > +     diff --git a/numbers b/numbers
> > +     index a1fb731..6875544 100644
> > +     --- a/numbers
> > +     +++ b/numbers
> > +     @@ -1,13 +1,9 @@
> > +      1
> > +      2
> > +     -<<<<<<< b0ed5cb (change_a)
> > +     -three
> > +     -=======
> > +     -tres
> > +     ->>>>>>> 6cd3f82 (change_b)
> > +     +drei
>
> nice
>
> > +      4
> > +      5
> > +      6
> > +      7
> > +     -eight
> > +     +acht
> > +      9
> > +     EOF
> > +     # Hashes above are sha1; rip them out so test works with sha256
> > +     sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
>
> Right, sha256 could cause many noisy test changes. I wonder if there is a
> more general way to avoid this; maybe default to SHA1 for existing tests?

Not "could", but "does".  And this is not something to be avoided.
The default testsuite we run in CI involves a run of
GIT_TEST_DEFAULT_HASH=sha256 under linux-clang.  Making these tests
SHA1-only just reduces our coverage and makes the transition to SHA256
harder; I think that's the opposite of the direction we want to go.

These changes I've made here are sufficient to make these tests work
under sha256; you can see the test results here:
https://github.com/gitgitgadget/git/runs/4646949283?check_suite_focus=true.
Under "Run ci/run-build-and-tests.sh" note that there are two runs of
tests, and the second has "export GIT_TEST_DEFAULT_HASH=sha256"
preceding it.

There might be a cleaner way to make these tests sha256-compatible,
but this seemed like a pretty simple way to me.
