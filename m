Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBBAC433FE
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 07:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhLYH70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 02:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhLYH7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 02:59:25 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB460C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 23:59:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so5817229wmb.0
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 23:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TCyLTlWR7U3DhljPOk6kyE+9M7jb4KBMEhV4G8WHvfo=;
        b=G0bPq6p8sRSd095jkz++1a5SS9g0uTykMMRi/kwwapx6SPuKgkmwp6LRW1A62rXE30
         WfBJS2l6pdDLAaaWdNDDq1ieDkASprb+P3vhX3Ywu33uS/QNi7E0B8qK6EBGjW5oLCp9
         60OQIUd5E6PBb42t7TkRBHLypcWIQpeodetVlCXJbvlWMUxrAip/C6Mcj5zXaADEIDEW
         ejo+dD5mfRrvJ9daxJ4ipMcYwtUFXEQ5wgZJ/ttT3/bTauQxbKfv5czUoKaxcy8qOfU+
         e39tH1SKypHikq1PiIcEWOitsMMdWJFcOtmY/jkGW+OL2GVsqTLO3vYjPQAXAYRUy1mJ
         nrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TCyLTlWR7U3DhljPOk6kyE+9M7jb4KBMEhV4G8WHvfo=;
        b=PK6K6wy7D6jHGR/BLx+PApsXz9Vy7y+/qsMeaE52ohxlseoDtvKU6J1D3B8c5N4X4v
         zmqIReu8FiQnLo217zuVFDtXzO4RmLLBRjyGpWS85++EbA4FSk637Re+BqXA+SNASxzV
         f7o65VSHw1X5SnzwPsJJER0FuA56qKDTxTRkU6HI/16l6sNShNyjnRuZVW2Xl8TQShdw
         ijxv68lXp1XfonPLx6WM9rcPjEIVYR9lK/qaEk3mgu6zlMecQ8HxMZSbsTVr8ebcK5kv
         rhwU5qlkQegxzB2hDzFRApBfi9VWoi8hpaE0MC0h2Q5doHeE9XE3x2pentDtAe98b1qK
         xR7g==
X-Gm-Message-State: AOAM531K22CHqBrT40lgEriNInjcKt2qCmo2ZxfeHAdvUgqzrc7oa8ms
        9NDXDS7BJvw1RjcVQMA9UlA4wO82h+4=
X-Google-Smtp-Source: ABdhPJyunwoDnDm963z/a0xUUTuEuGUARHDvjvM+OtIvdM759zxOYkDCzVyBDWeWRywIlvYhYUxOWg==
X-Received: by 2002:a05:600c:1da3:: with SMTP id p35mr6717903wms.9.1640419162394;
        Fri, 24 Dec 2021 23:59:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d22sm9895720wmq.17.2021.12.24.23.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 23:59:21 -0800 (PST)
Message-Id: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Dec 2021 07:59:11 +0000
Subject: [PATCH v2 0/8] Add a new --remerge-diff capability to show & log
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are some patches to add a --remerge-diff capability to show & log,
which works by comparing merge commits to an automatic remerge (note that
the automatic remerge tree can contain files with conflict markers).

Changes since v1 (of the restarted submission, which technically was v2):

 * Restructured the series, so the first patch introduces the feature --
   with a bunch of caveats. Subsequent patches clean up those caveats. This
   avoids introducing not-yet-used functions, and hopefully makes review
   easier.
 * added testcases
 * numerous small improvements suggested by Ævar and Junio

Changes since original submission[1]:

 * Rebased on top of the version of ns/tmp-objdir that Neeraj submitted
   (Neeraj's patches were based on v2.34, but ns/tmp-objdir got applied on
   an old commit and does not even build because of that).
 * Modify ll-merge API to return a status, instead of printing "Cannot merge
   binary files" on stdout[2] (as suggested by Peff)
 * Make conflict messages and other such warnings into diff headers of the
   subsequent remerge-diff rather than appearing in the diff as file content
   of some funny looking filenames (as suggested by Peff[3] and Junio[4])
 * Sergey ack'ed the diff-merges.c portion of the patches, but that wasn't
   limited to one patch so not sure where to record that ack.

[1]
https://lore.kernel.org/git/pull.1080.git.git.1630376800.gitgitgadget@gmail.com/;
GitHub wouldn't let me change the target branch for the PR, so I had to
create a new one with the new base and thus the reason for not sending this
as v2 even though it is. [2]
https://lore.kernel.org/git/YVOZRhWttzF18Xql@coredump.intra.peff.net/,
https://lore.kernel.org/git/YVOZty9D7NRbzhE5@coredump.intra.peff.net/ [3]
https://lore.kernel.org/git/YVOXPTjsp9lrxmS6@coredump.intra.peff.net/ [4]
https://lore.kernel.org/git/xmqqr1d7e4ug.fsf@gitster.g/

=== FURTHER BACKGROUND (original cover letter material) ==

Here are some example commits you can try this out on (with git show
--remerge-diff $COMMIT):

 * git.git conflicted merge: 07601b5b36
 * git.git non-conflicted change: bf04590ecd
 * linux.git conflicted merge: eab3540562fb
 * linux.git non-conflicted change: 223cea6a4f05

Many more can be found by just running git log --merges --remerge-diff in
your repository of choice and searching for diffs (most merges tend to be
clean and unmodified and thus produce no diff but a search of '^diff' in the
log output tends to find the examples nicely).

Some basic high level details about this new option:

 * This option is most naturally compared to --cc, though the output seems
   to be much more understandable to most users than --cc output.
 * Since merges are often clean and unmodified, this new option results in
   an empty diff for most merges.
 * This new option shows things like the removal of conflict markers, which
   hunks users picked from the various conflicted sides to keep or remove,
   and shows changes made outside of conflict markers (which might reflect
   changes needed to resolve semantic conflicts or cleanups of e.g.
   compilation warnings or other additional changes an integrator felt
   belonged in the merged result).
 * This new option does not (currently) work for octopus merges, since
   merge-ort is specific to two-parent merges[1].
 * This option will not work on a read-only or full filesystem[2].
 * We discussed this capability at Git Merge 2020, and one of the
   suggestions was doing a periodic git gc --auto during the operation (due
   to potential new blobs and trees created during the operation). I found a
   way to avoid that; see [2].
 * This option is faster than you'd probably expect; it handles 33.5 merge
   commits per second in linux.git on my computer; see below.

In regards to the performance point above, the timing for running the
following command:

time git log --min-parents=2 --max-parents=2 $DIFF_FLAG | wc -l


in linux.git (with v5.4 checked out, since my copy of linux is very out of
date) is as follows:

DIFF_FLAG=--cc:            71m 31.536s
DIFF_FLAG=--remerge-diff:  31m  3.170s


Note that there are 62476 merges in this history. Also, output size is:

DIFF_FLAG=--cc:            2169111 lines
DIFF_FLAG=--remerge-diff:  2458020 lines


So roughly the same amount of output as --cc, as you'd expect.

As a side note: git log --remerge-diff, when run in various repositories and
allowed to run all the way back to the beginning(s) of history, is a nice
stress test of sorts for merge-ort. Especially when users run it for you on
their repositories they are working on, whether intentionally or via a bug
in a tool triggering that command to be run unexpectedly. Long story short,
such a bug in an internal tool existed last December and this command was
run on an internal repository and found a platform-specific bug in merge-ort
on some really old merge commit from that repo. I fixed that bug (a
STABLE_QSORT thing) while upstreaming all the merge-ort patches in the mean
time, but it was nice getting extra testing. Having more folks run this on
their repositories might be useful extra testing of the new merge strategy.

Also, I previously mentioned --remerge-diff-only (a flag to show how
cherry-picks or reverts differ from an automatic cherry-pick or revert, in
addition to showing how merges differ from an automatic merge). This series
does not include the patches to introduce that option; I'll submit them
later.

Two other things that might be interesting but are not included and which I
haven't investigated:

 * some mechanism for passing extra merge options through (e.g.
   -Xignore-space-change)
 * a capability to compare the automatic merge to a second automatic merge
   done with different merge options. (Not sure if this would be of interest
   to end users, but might be interesting while developing new a
   --strategy-option, or maybe checking how changing some default in the
   merge algorithm would affect historical merges in various repositories).

[1] I have nebulous ideas of how an Octopus-centric ORT strategy could be
written -- basically, just repeatedly invoking ort and trying to make sure
nested conflicts can be differentiated. For now, though, a simple warning is
printed that octopus merges are not handled and no diff will be shown. [2]
New blobs/trees can be written by the three-way merging step. These are
written to a temporary area (via tmp-objdir.c) under the git object store
that is cleaned up at the end of the operation, with the new loose objects
from the remerge being cleaned up after each individual merge.

Elijah Newren (8):
  show, log: provide a --remerge-diff capability
  log: clean unneeded objects during `log --remerge-diff`
  ll-merge: make callers responsible for showing warnings
  merge-ort: capture and print ll-merge warnings in our preferred
    fashion
  merge-ort: mark a few more conflict messages as omittable
  merge-ort: format messages slightly different for use in headers
  diff: add ability to insert additional headers for paths
  show, log: include conflict/warning messages in --remerge-diff headers

 Documentation/diff-options.txt |   8 ++
 apply.c                        |   5 +-
 builtin/checkout.c             |  12 ++-
 builtin/log.c                  |  15 +++
 diff-merges.c                  |  12 +++
 diff.c                         | 116 +++++++++++++++++++++-
 diff.h                         |   3 +-
 ll-merge.c                     |  40 ++++----
 ll-merge.h                     |   9 +-
 log-tree.c                     |  70 +++++++++++++-
 merge-blobs.c                  |   5 +-
 merge-ort.c                    |  47 ++++++++-
 merge-ort.h                    |  10 ++
 merge-recursive.c              |   8 +-
 merge-recursive.h              |   1 +
 notes-merge.c                  |   5 +-
 rerere.c                       |  12 ++-
 revision.h                     |   6 +-
 t/t4069-remerge-diff.sh        | 172 +++++++++++++++++++++++++++++++++
 t/t6404-recursive-merge.sh     |   9 +-
 t/t6406-merge-attr.sh          |   9 +-
 tmp-objdir.c                   |   5 +
 tmp-objdir.h                   |   6 ++
 23 files changed, 538 insertions(+), 47 deletions(-)
 create mode 100755 t/t4069-remerge-diff.sh


base-commit: 4e44121c2d7bced65e25eb7ec5156290132bec94
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1103%2Fnewren%2Fremerge-diff-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1103/newren/remerge-diff-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1103

Range-diff vs v1:

  8:  5d5846be0bd !  1:  b3ae62083e1 show, log: provide a --remerge-diff capability
     @@ Commit message
          possibly, just to hide other random changes).
      
          This capability works by creating a temporary object directory and
     -    marking it as the primary object store, so that any blobs or trees
     -    created during the automatic merge, can be easily removed afterwards by
     -    just deleting all objects from the temporary object directory.  We can
     -    do this after handling each merge commit, in order to avoid the need to
     -    worry about doing `git gc --auto` runs while running `git log
     -    --remerge-diff`.
     +    marking it as the primary object store.  This makes it so that any blobs
     +    or trees created during the automatic merge easily removable afterwards
     +    by just deleting all objects from the temporary object directory.
     +
     +    There are a few ways that this implementation is suboptimal:
     +      * `log --remerge-diff` becomes slow, because the temporary object
     +        directory can fills with many loose objects while running
     +      * the log output can be muddied with misplaced "warning: cannot merge
     +        binary files" messages, since ll-merge.c unconditionally writes those
     +        messages to stderr while running instead of allowing callers to
     +        manage them.
     +      * important conflict and warning messages are simply dropped; thus for
     +        conflicts like modify/delete or rename/rename or file/directory which
     +        are not representable with content conflict markers, there may be no
     +        way for a user of --remerge-diff to know that there had been a
     +        conflict which was resolved (and which possibly motivated other
     +        changes in the merge commit).
     +    Subsequent commits will address these issues.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     + ## Documentation/diff-options.txt ##
     +@@ Documentation/diff-options.txt: ifdef::git-log[]
     + 	each of the parents. Separate log entry and diff is generated
     + 	for each parent.
     + +
     ++--diff-merges=remerge:::
     ++--diff-merges=r:::
     ++--remerge-diff:::
     ++	With this option, two-parent merge commits are remerged to
     ++	create a temporary tree object -- potentially containing files
     ++	with conflict markers and such.  A diff is then shown between
     ++	that temporary tree and the actual merge commit.
     +++
     + --diff-merges=combined:::
     + --diff-merges=c:::
     + -c:::
     +
       ## builtin/log.c ##
      @@
       #include "repository.h"
       #include "commit-reach.h"
       #include "range-diff.h"
     -+#include "dir.h"
      +#include "tmp-objdir.h"
       
       #define MAIL_DEFAULT_WRAP 72
       #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
      @@ builtin/log.c: static int cmd_log_walk(struct rev_info *rev)
     + 	struct commit *commit;
       	int saved_nrl = 0;
       	int saved_dcctc = 0;
     - 
     ++	struct tmp_objdir *remerge_objdir = NULL;
     ++
      +	if (rev->remerge_diff) {
     -+		rev->remerge_objdir = tmp_objdir_create("remerge-diff");
     -+		if (!rev->remerge_objdir)
     -+			die(_("unable to create temporary object directory"));
     -+		tmp_objdir_replace_primary_odb(rev->remerge_objdir, 1);
     ++		remerge_objdir = tmp_objdir_create("remerge-diff");
     ++		if (!remerge_objdir)
     ++			die_errno(_("unable to create temporary object directory"));
     ++		tmp_objdir_replace_primary_odb(remerge_objdir, 1);
      +	}
     -+
     + 
       	if (rev->early_output)
       		setup_early_output();
     - 
      @@ builtin/log.c: static int cmd_log_walk(struct rev_info *rev)
       	rev->diffopt.no_free = 0;
       	diff_free(&rev->diffopt);
       
     -+	if (rev->remerge_diff) {
     -+		tmp_objdir_destroy(rev->remerge_objdir);
     -+		rev->remerge_objdir = NULL;
     -+	}
     ++	if (rev->remerge_diff)
     ++		tmp_objdir_destroy(remerge_objdir);
      +
       	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
       	    rev->diffopt.flags.check_failed) {
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
       		die(_("--check does not make sense"));
      +	if (rev.remerge_diff)
     -+		die(_("--remerge_diff does not make sense"));
     ++		die(_("--remerge-diff does not make sense"));
       
       	if (!use_patch_format &&
       		(!rev.diffopt.output_format ||
     @@ log-tree.c
       #include "config.h"
       #include "diff.h"
       #include "object-store.h"
     - #include "repository.h"
     -+#include "tmp-objdir.h"
     - #include "commit.h"
     +@@
       #include "tag.h"
       #include "graph.h"
       #include "log-tree.h"
     @@ log-tree.c
       #include "reflog-walk.h"
       #include "refs.h"
       #include "string-list.h"
     -@@
     - #include "line-log.h"
     - #include "help.h"
     - #include "range-diff.h"
     -+#include "dir.h"
     - 
     - static struct decoration name_decoration = { "object names" };
     - static int decoration_loaded;
      @@ log-tree.c: static int do_diff_combined(struct rev_info *opt, struct commit *commit)
       	return !opt->loginfo;
       }
     @@ log-tree.c: static int do_diff_combined(struct rev_info *opt, struct commit *com
      +{
      +	struct merge_options o;
      +	struct commit_list *bases;
     -+	struct merge_result res;
     ++	struct merge_result res = {0};
      +	struct pretty_print_context ctx = {0};
     -+	struct strbuf commit1 = STRBUF_INIT;
     -+	struct strbuf commit2 = STRBUF_INIT;
     ++	struct commit *parent1 = parents->item;
     ++	struct commit *parent2 = parents->next->item;
     ++	struct strbuf parent1_desc = STRBUF_INIT;
     ++	struct strbuf parent2_desc = STRBUF_INIT;
      +
      +	/* Setup merge options */
      +	init_merge_options(&o, the_repository);
     -+	memset(&res, 0, sizeof(res));
      +	o.show_rename_progress = 0;
      +
      +	ctx.abbrev = DEFAULT_ABBREV;
     -+	format_commit_message(parents->item,       "%h (%s)", &commit1, &ctx);
     -+	format_commit_message(parents->next->item, "%h (%s)", &commit2, &ctx);
     -+	o.branch1 = commit1.buf;
     -+	o.branch2 = commit2.buf;
     -+	o.record_conflict_msgs_as_headers = 1;
     ++	format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
     ++	format_commit_message(parent2, "%h (%s)", &parent2_desc, &ctx);
     ++	o.branch1 = parent1_desc.buf;
     ++	o.branch2 = parent2_desc.buf;
      +
      +	/* Parse the relevant commits and get the merge bases */
     -+	parse_commit_or_die(parents->item);
     -+	parse_commit_or_die(parents->next->item);
     -+	bases = get_merge_bases(parents->item, parents->next->item);
     ++	parse_commit_or_die(parent1);
     ++	parse_commit_or_die(parent2);
     ++	bases = get_merge_bases(parent1, parent2);
      +
      +	/* Re-merge the parents */
     -+	merge_incore_recursive(&o,
     -+			       bases, parents->item, parents->next->item,
     -+			       &res);
     ++	merge_incore_recursive(&o, bases, parent1, parent2, &res);
      +
      +	/* Show the diff */
     -+	opt->diffopt.additional_path_headers = res.path_messages;
      +	diff_tree_oid(&res.tree->object.oid, oid, "", &opt->diffopt);
      +	log_tree_diff_flush(opt);
      +
      +	/* Cleanup */
     -+	opt->diffopt.additional_path_headers = NULL;
     -+	strbuf_release(&commit1);
     -+	strbuf_release(&commit2);
     ++	strbuf_release(&parent1_desc);
     ++	strbuf_release(&parent2_desc);
      +	merge_finalize(&o, &res);
     -+
     -+	/* Clean up the temporary object directory */
     -+	if (opt->remerge_objdir != NULL)
     -+		tmp_objdir_discard_objects(opt->remerge_objdir);
     -+	else
     -+		BUG("unable to remove temporary object directory");
     ++	/* TODO: clean up the temporary object directory */
      +
      +	return !opt->loginfo;
      +}
     @@ revision.h: struct rev_info {
       
       	/* Format info */
       	int		show_notes;
     -@@ revision.h: struct rev_info {
     - 
     - 	/* misc. flags related to '--no-kept-objects' */
     - 	unsigned keep_pack_cache_flags;
     +
     + ## t/t4069-remerge-diff.sh (new) ##
     +@@
     ++#!/bin/sh
      +
     -+	/* Location where temporary objects for remerge-diff are written. */
     -+	struct tmp_objdir *remerge_objdir;
     - };
     - 
     - int ref_excluded(struct string_list *, const char *path);
     ++test_description='remerge-diff handling'
     ++
     ++. ./test-lib.sh
     ++
     ++test_expect_success 'setup basic merges' '
     ++	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
     ++	git add numbers &&
     ++	git commit -m base &&
     ++
     ++	git branch feature_a &&
     ++	git branch feature_b &&
     ++	git branch feature_c &&
     ++
     ++	git branch ab_resolution &&
     ++	git branch bc_resolution &&
     ++
     ++	git checkout feature_a &&
     ++	test_write_lines 1 2 three 4 5 6 7 eight 9 >numbers &&
     ++	git commit -a -m change_a &&
     ++
     ++	git checkout feature_b &&
     ++	test_write_lines 1 2 tres 4 5 6 7 8 9 >numbers &&
     ++	git commit -a -m change_b &&
     ++
     ++	git checkout feature_c &&
     ++	test_write_lines 1 2 3 4 5 6 7 8 9 10 >numbers &&
     ++	git commit -a -m change_c &&
     ++
     ++	git checkout bc_resolution &&
     ++	# fast forward
     ++	git merge feature_b &&
     ++	# no conflict
     ++	git merge feature_c &&
     ++
     ++	git checkout ab_resolution &&
     ++	# fast forward
     ++	git merge feature_a &&
     ++	# conflicts!
     ++	test_must_fail git merge feature_b &&
     ++	# Resolve conflict...and make another change elsewhere
     ++	test_write_lines 1 2 drei 4 5 6 7 acht 9 >numbers &&
     ++	git add numbers &&
     ++	git merge --continue
     ++'
     ++
     ++test_expect_success 'remerge-diff on a clean merge' '
     ++	git log -1 --oneline bc_resolution >expect &&
     ++	git show --oneline --remerge-diff bc_resolution >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'remerge-diff with both a resolved conflict and an unrelated change' '
     ++	git log -1 --oneline ab_resolution >tmp &&
     ++	cat <<-EOF >>tmp &&
     ++	diff --git a/numbers b/numbers
     ++	index a1fb731..6875544 100644
     ++	--- a/numbers
     ++	+++ b/numbers
     ++	@@ -1,13 +1,9 @@
     ++	 1
     ++	 2
     ++	-<<<<<<< b0ed5cb (change_a)
     ++	-three
     ++	-=======
     ++	-tres
     ++	->>>>>>> 6cd3f82 (change_b)
     ++	+drei
     ++	 4
     ++	 5
     ++	 6
     ++	 7
     ++	-eight
     ++	+acht
     ++	 9
     ++	EOF
     ++	# Hashes above are sha1; rip them out so test works with sha256
     ++	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
     ++
     ++	git show --oneline --remerge-diff ab_resolution >tmp &&
     ++	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_done
  1:  fab1b2c69ea !  2:  54f1fb31d04 tmp_objdir: add a helper function for discarding all contained objects
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    tmp_objdir: add a helper function for discarding all contained objects
     +    log: clean unneeded objects during `log --remerge-diff`
     +
     +    The --remerge-diff option will need to create new blobs and trees
     +    representing the "automatic merge" state.  If one is traversing a
     +    long project history, one can easily get hundreds of thousands of
     +    loose objects generated during `log --remerge-diff`.  However, none of
     +    those loose objects are needed after we have completed our diff
     +    operation; they can be summarily deleted.
     +
     +    Add a new helper function to tmp_objdir to discard all the contained
     +    objects, and call it after each merge is handled.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     + ## builtin/log.c ##
     +@@ builtin/log.c: static int cmd_log_walk(struct rev_info *rev)
     + 	struct commit *commit;
     + 	int saved_nrl = 0;
     + 	int saved_dcctc = 0;
     +-	struct tmp_objdir *remerge_objdir = NULL;
     + 
     + 	if (rev->remerge_diff) {
     +-		remerge_objdir = tmp_objdir_create("remerge-diff");
     +-		if (!remerge_objdir)
     ++		rev->remerge_objdir = tmp_objdir_create("remerge-diff");
     ++		if (!rev->remerge_objdir)
     + 			die_errno(_("unable to create temporary object directory"));
     +-		tmp_objdir_replace_primary_odb(remerge_objdir, 1);
     ++		tmp_objdir_replace_primary_odb(rev->remerge_objdir, 1);
     + 	}
     + 
     + 	if (rev->early_output)
     +@@ builtin/log.c: static int cmd_log_walk(struct rev_info *rev)
     + 	rev->diffopt.no_free = 0;
     + 	diff_free(&rev->diffopt);
     + 
     +-	if (rev->remerge_diff)
     +-		tmp_objdir_destroy(remerge_objdir);
     ++	if (rev->remerge_diff) {
     ++		tmp_objdir_destroy(rev->remerge_objdir);
     ++		rev->remerge_objdir = NULL;
     ++	}
     + 
     + 	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
     + 	    rev->diffopt.flags.check_failed) {
     +
     + ## log-tree.c ##
     +@@
     + #include "diff.h"
     + #include "object-store.h"
     + #include "repository.h"
     ++#include "tmp-objdir.h"
     + #include "commit.h"
     + #include "tag.h"
     + #include "graph.h"
     +@@ log-tree.c: static int do_remerge_diff(struct rev_info *opt,
     + 	strbuf_release(&parent1_desc);
     + 	strbuf_release(&parent2_desc);
     + 	merge_finalize(&o, &res);
     +-	/* TODO: clean up the temporary object directory */
     ++
     ++	/* Clean up the contents of the temporary object directory */
     ++	if (opt->remerge_objdir)
     ++		tmp_objdir_discard_objects(opt->remerge_objdir);
     ++	else
     ++		BUG("unable to remove temporary object directory");
     + 
     + 	return !opt->loginfo;
     + }
     +
     + ## revision.h ##
     +@@ revision.h: struct rev_info {
     + 
     + 	/* misc. flags related to '--no-kept-objects' */
     + 	unsigned keep_pack_cache_flags;
     ++
     ++	/* Location where temporary objects for remerge-diff are written. */
     ++	struct tmp_objdir *remerge_objdir;
     + };
     + 
     + int ref_excluded(struct string_list *, const char *path);
     +
       ## tmp-objdir.c ##
      @@ tmp-objdir.c: static void remove_tmp_objdir_on_signal(int signo)
       	raise(signo);
  2:  d022176618d !  3:  d5566f5d136 ll-merge: make callers responsible for showing warnings
     @@ Commit message
          from ll-merge and instead modify the return status of ll_merge() to
          indicate when a merge of binary files has occurred.
      
     +    This commit continues printing the message as-is; future changes will
     +    start handling the new commit differently in the merge-ort codepath.
     +
          Note that my methodology included first modifying ll_merge() to return
          a struct, so that the compiler would catch all the callers for me and
          ensure I had modified all of them.  After modifying all of them, I then
     @@ apply.c: static int three_way_merge(struct apply_state *state,
       			  NULL);
      +	if (status == LL_MERGE_BINARY_CONFLICT)
      +		warning("Cannot merge binary files: %s (%s vs. %s)",
     -+			"base", "ours", "theirs");
     ++			path, "ours", "theirs");
       	free(base_file.ptr);
       	free(our_file.ptr);
       	free(their_file.ptr);
     @@ rerere.c: static int try_merge(struct index_state *istate,
       	mmfile_t base = {NULL, 0}, other = {NULL, 0};
       
       	if (read_mmfile(&base, rerere_path(id, "preimage")) ||
     - 	    read_mmfile(&other, rerere_path(id, "postimage")))
     +-	    read_mmfile(&other, rerere_path(id, "postimage")))
      -		ret = 1;
      -	else
     ++	    read_mmfile(&other, rerere_path(id, "postimage"))) {
      +		ret = LL_MERGE_CONFLICT;
     -+	else {
     ++	} else {
       		/*
       		 * A three-way merge. Note that this honors user-customizable
       		 * low-level merge driver settings.
  3:  f36395fdee0 =  4:  a02845f12db merge-ort: capture and print ll-merge warnings in our preferred fashion
  4:  1e7eef7705e !  5:  000933c5d7f merge-ort: mark a few more conflict messages as omittable
     @@ Commit message
          are just noise when trying to see what changes users made to create a
          merge commit.  Mark them as omittable.
      
     +    Note that there were already a few messages marked as omittable in
     +    merge-ort when doing a remerge-diff, because the development of
     +    --remerge-diff preceded the upstreaming of merge-ort and I was trying to
     +    ensure merge-ort could handle all the necessary requirements.  See
     +    commit c5a6f65527 ("merge-ort: add modify/delete handling and delayed
     +    output processing", 2020-12-03) for the initial details.  For some
     +    examples of already-marked-as-omittable messages, see either
     +    "Auto-merging <path>" or some of the submodule update hints.  This
     +    commit just adds two more messages that should also be omittable.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
     @@ merge-ort.c: static void apply_directory_rename_modifications(struct merge_optio
       				 _("CONFLICT (file location): %s renamed to %s "
       				   "in %s, inside a directory that was renamed "
       				   "in %s, suggesting it should perhaps be "
     -@@ merge-ort.c: static void process_entry(struct merge_options *opt,
     - 				reason = _("add/add");
     - 			if (S_ISGITLINK(merged_file.mode))
     - 				reason = _("submodule");
     --			path_msg(opt, path, 0,
     -+			path_msg(opt, path, 1,
     - 				 _("CONFLICT (%s): Merge conflict in %s"),
     - 				 reason, path);
     - 		}
  7:  b307f63569f !  6:  887e46435c0 merge-ort: format messages slightly different for use in headers
     @@ Metadata
       ## Commit message ##
          merge-ort: format messages slightly different for use in headers
      
     -    We want to add an ability for users to run
     +    When users run
              git show --remerge-diff $MERGE_COMMIT
     -    or even
     +    or
              git log -p --remerge-diff ...
     -    and have git show the differences between where the merge machinery
     -    would stop and what is recorded in merge commits.  However, in such
     -    cases, stdout is not an appropriate location to dump conflict messages.
     -    We instead want these messages to appear as headers in the subsequent
     -    diff.  For them to work as headers, though, we need for any multiline
     +    stdout is not an appropriate location to dump conflict messages, but we
     +    do want to provide them to users.  We will include them in the diff
     +    headers instead...but for that to work, we need for any multiline
          messages to replace newlines with both a newline and a space.  Add a new
          flag to signal when we want these messages modified in such a fashion,
          and use it in path_msg() to modify these messages this way.
  6:  15600df925f !  7:  e9470651303 diff: add ability to insert additional headers for paths
     @@ Metadata
       ## Commit message ##
          diff: add ability to insert additional headers for paths
      
     -    In support of a remerge-diff ability we will add in a few commits, we
     -    want to be able to provide additional headers to show along with a diff.
     -    Add the plumbing necessary to enable this.
     +    When additional headers are provided, we need to
     +      * add diff_filepairs to diff_queued_diff for each paths in the
     +        additional headers map which, unless that path is part of
     +        another diff_filepair already found in diff_queued_diff
     +      * format the headers (colorization, line_prefix for --graph)
     +      * make sure the various codepaths that attempt to return early
     +        if there are "no changes" take into account the headers that
     +        need to be shown.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ diff.c: struct userdiff_driver *get_textconv(struct repository *r,
       	return userdiff_get_textconv(r, one->driver);
       }
       
     -+static struct strbuf* additional_headers(struct diff_options *o,
     ++static struct strbuf *additional_headers(struct diff_options *o,
      +					 const char *path)
      +{
      +	if (!o->additional_path_headers)
     @@ diff.c: struct userdiff_driver *get_textconv(struct repository *r,
      +{
      +	char *next, *newline;
      +
     -+	next = more_headers->buf;
     -+	while ((newline = strchr(next, '\n'))) {
     -+		*newline = '\0';
     -+		strbuf_addf(msg, "%s%s%s%s\n", line_prefix, meta, next, reset);
     -+		*newline = '\n';
     -+		next = newline + 1;
     ++	for (next = more_headers->buf; *next; next = newline) {
     ++		newline = strchrnul(next, '\n');
     ++		strbuf_addf(msg, "%s%s%.*s%s\n", line_prefix, meta,
     ++			    (int)(newline - next), next, reset);
     ++		if (*newline)
     ++			newline++;
      +	}
     -+	if (*next)
     -+		strbuf_addf(msg, "%s%s%s%s\n", line_prefix, meta, next, reset);
      +}
      +
       static void builtin_diff(const char *name_a,
       			 const char *name_b,
       			 struct diff_filespec *one,
     +@@ diff.c: static void builtin_diff(const char *name_a,
     + 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
     + 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
     + 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
     ++	if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two)) {
     ++		/*
     ++		 * We should only reach this point for pairs from
     ++		 * create_filepairs_for_header_only_notifications().  For
     ++		 * these, we should avoid the "/dev/null" special casing
     ++		 * above, meaning we avoid showing such pairs as either
     ++		 * "new file" or "deleted file" below.
     ++		 */
     ++		lbl[0] = a_one;
     ++		lbl[1] = b_two;
     ++	}
     + 	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, meta, a_one, b_two, reset);
     + 	if (lbl[0][0] == '/') {
     + 		/* /dev/null */
      @@ diff.c: static void fill_metainfo(struct strbuf *msg,
       	const char *set = diff_get_color(use_color, DIFF_METAINFO);
       	const char *reset = diff_get_color(use_color, DIFF_RESET);
     @@ diff.c: static void fill_metainfo(struct strbuf *msg,
       
       	*must_show_header = 1;
       	strbuf_init(msg, PATH_MAX * 2 + 300);
     -+	if ((more_headers = additional_headers(o, name)))
     +@@ diff.c: static void fill_metainfo(struct strbuf *msg,
     + 	default:
     + 		*must_show_header = 0;
     + 	}
     ++	if ((more_headers = additional_headers(o, name))) {
      +		add_formatted_headers(msg, more_headers,
      +				      line_prefix, set, reset);
     - 	switch (p->status) {
     - 	case DIFF_STATUS_COPIED:
     - 		strbuf_addf(msg, "%s%ssimilarity index %d%%",
     ++		*must_show_header = 1;
     ++	}
     + 	if (one && two && !oideq(&one->oid, &two->oid)) {
     + 		const unsigned hexsz = the_hash_algo->hexsz;
     + 		int abbrev = o->abbrev ? o->abbrev : DEFAULT_ABBREV;
      @@ diff.c: int diff_unmodified_pair(struct diff_filepair *p)
       
       static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
       {
      -	if (diff_unmodified_pair(p))
     ++	/*
     ++	 * Check if we can return early without showing a diff.  Note that
     ++	 * diff_filepair only stores {oid, path, mode, is_valid}
     ++	 * information for each path, and thus diff_unmodified_pair() only
     ++	 * considers those bits of info.  However, we do not want pairs
     ++	 * created by create_filepairs_for_header_only_notifications() to
     ++	 * be ignored, so return early if both p is unmodified AND
     ++	 * p->one->path is not in additional headers.
     ++	 */
      +	if (diff_unmodified_pair(p) && !additional_headers(o, p->one->path))
       		return;
       
     ++	/* Actually, we can also return early to avoid showing tree diffs */
       	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
     + 	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
     +-		return; /* no tree diffs in patch format */
     ++		return;
     + 
     + 	run_diff(p, o);
     + }
     +@@ diff.c: static void diff_flush_checkdiff(struct diff_filepair *p,
     + 	run_checkdiff(p, o);
     + }
     + 
     +-int diff_queue_is_empty(void)
     ++int diff_queue_is_empty(struct diff_options *o)
     + {
     + 	struct diff_queue_struct *q = &diff_queued_diff;
     + 	int i;
     ++
     ++	if (o->additional_path_headers &&
     ++	    !strmap_empty(o->additional_path_headers))
     ++		return 0;
     + 	for (i = 0; i < q->nr; i++)
     + 		if (!diff_unmodified_pair(q->queue[i]))
     + 			return 0;
     +@@ diff.c: void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
     + 		warning(_(rename_limit_advice), varname, needed);
     + }
     + 
     ++static void create_filepairs_for_header_only_notifications(struct diff_options *o)
     ++{
     ++	struct strset present;
     ++	struct diff_queue_struct *q = &diff_queued_diff;
     ++	struct hashmap_iter iter;
     ++	struct strmap_entry *e;
     ++	int i;
     ++
     ++	strset_init_with_options(&present, /*pool*/ NULL, /*strdup*/ 0);
     ++
     ++	/*
     ++	 * Find out which paths exist in diff_queued_diff, preferring
     ++	 * one->path for any pair that has multiple paths.
     ++	 */
     ++	for (i = 0; i < q->nr; i++) {
     ++		struct diff_filepair *p = q->queue[i];
     ++		char *path = p->one->path ? p->one->path : p->two->path;
     ++
     ++		if (strmap_contains(o->additional_path_headers, path))
     ++			strset_add(&present, path);
     ++	}
     ++
     ++	/*
     ++	 * Loop over paths in additional_path_headers; for each NOT already
     ++	 * in diff_queued_diff, create a synthetic filepair and insert that
     ++	 * into diff_queued_diff.
     ++	 */
     ++	strmap_for_each_entry(o->additional_path_headers, &iter, e) {
     ++		if (!strset_contains(&present, e->key)) {
     ++			struct diff_filespec *one, *two;
     ++			struct diff_filepair *p;
     ++
     ++			one = alloc_filespec(e->key);
     ++			two = alloc_filespec(e->key);
     ++			fill_filespec(one, null_oid(), 0, 0);
     ++			fill_filespec(two, null_oid(), 0, 0);
     ++			p = diff_queue(q, one, two);
     ++			p->status = DIFF_STATUS_MODIFIED;
     ++		}
     ++	}
     ++
     ++	/* Re-sort the filepairs */
     ++	diffcore_fix_diff_index();
     ++
     ++	/* Cleanup */
     ++	strset_clear(&present);
     ++}
     ++
     + static void diff_flush_patch_all_file_pairs(struct diff_options *o)
     + {
     + 	int i;
     +@@ diff.c: static void diff_flush_patch_all_file_pairs(struct diff_options *o)
     + 	if (o->color_moved)
     + 		o->emitted_symbols = &esm;
     + 
     ++	if (o->additional_path_headers)
     ++		create_filepairs_for_header_only_notifications(o);
     ++
     + 	for (i = 0; i < q->nr; i++) {
     + 		struct diff_filepair *p = q->queue[i];
     + 		if (check_pair_status(p))
     +@@ diff.c: void diff_flush(struct diff_options *options)
     + 	 * Order: raw, stat, summary, patch
     + 	 * or:    name/name-status/checkdiff (other bits clear)
     + 	 */
     +-	if (!q->nr)
     ++	if (!q->nr && !options->additional_path_headers)
     + 		goto free_queue;
     + 
     + 	if (output_format & (DIFF_FORMAT_RAW |
      
       ## diff.h ##
      @@ diff.h: struct diff_options {
     @@ diff.h: struct diff_options {
       
       	int no_free;
       };
     +@@ diff.h: void diffcore_fix_diff_index(void);
     + "                show all files diff when -S is used and hit is found.\n" \
     + "  -a  --text    treat all files as text.\n"
     + 
     +-int diff_queue_is_empty(void);
     ++int diff_queue_is_empty(struct diff_options*);
     + void diff_flush(struct diff_options*);
     + void diff_free(struct diff_options*);
     + void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
     +
     + ## log-tree.c ##
     +@@ log-tree.c: int log_tree_diff_flush(struct rev_info *opt)
     + 	opt->shown_dashes = 0;
     + 	diffcore_std(&opt->diffopt);
     + 
     +-	if (diff_queue_is_empty()) {
     ++	if (diff_queue_is_empty(&opt->diffopt)) {
     + 		int saved_fmt = opt->diffopt.output_format;
     + 		opt->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
     + 		diff_flush(&opt->diffopt);
  5:  dd5461d45de !  8:  4cc53c55a6e merge-ort: make path_messages available to external callers
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    merge-ort: make path_messages available to external callers
     +    show, log: include conflict/warning messages in --remerge-diff headers
      
     -    merge-ort is designed to be more flexible so that it could be called as
     -    more of a library function.  Part of that design is not writing to the
     -    working tree or index unless and until requested.  Part of it is
     -    returning tree objects (rather than creating commits and making them
     -    part of HEAD), and allowing callers to do their own special thing with
     -    that merged tree.  Along the same lines, we want to enable callers to do
     -    something special with output messages (conflicts and other warnings)
     -    besides just automatically displaying on stdout/stderr.  Do so by making
     -    the output path messages accessible via a new member of struct
     -    merge_result named path_messages.
     +    Conflicts such as modify/delete, rename/rename, or file/directory are
     +    not representable via content conflict markers, and the normal output
     +    messages notifying users about these were dropped with --remerge-diff.
     +    While we don't want these messages randomly shown before the commit
     +    and diff headers, we do want them to still be shown; include them as
     +    part of the diff headers instead.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     + ## log-tree.c ##
     +@@ log-tree.c: static int do_remerge_diff(struct rev_info *opt,
     + 	/* Setup merge options */
     + 	init_merge_options(&o, the_repository);
     + 	o.show_rename_progress = 0;
     ++	o.record_conflict_msgs_as_headers = 1;
     + 
     + 	ctx.abbrev = DEFAULT_ABBREV;
     + 	format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
     +@@ log-tree.c: static int do_remerge_diff(struct rev_info *opt,
     + 	merge_incore_recursive(&o, bases, parent1, parent2, &res);
     + 
     + 	/* Show the diff */
     ++	opt->diffopt.additional_path_headers = res.path_messages;
     + 	diff_tree_oid(&res.tree->object.oid, oid, "", &opt->diffopt);
     + 	log_tree_diff_flush(opt);
     + 
     + 	/* Cleanup */
     ++	opt->diffopt.additional_path_headers = NULL;
     + 	strbuf_release(&parent1_desc);
     + 	strbuf_release(&parent2_desc);
     + 	merge_finalize(&o, &res);
     +
       ## merge-ort.c ##
      @@ merge-ort.c: redo:
       	trace2_region_leave("merge", "process_entries", opt->repo);
     @@ merge-ort.h: struct merge_result {
       	/*
       	 * Additional metadata used by merge_switch_to_result() or future calls
       	 * to merge_incore_*().  Includes data needed to update the index (if
     +
     + ## t/t4069-remerge-diff.sh ##
     +@@ t/t4069-remerge-diff.sh: test_description='remerge-diff handling'
     + 
     + . ./test-lib.sh
     + 
     ++# --remerge-diff uses ort under the hood regardless of setting.  However,
     ++# we set up a file/directory conflict beforehand, and the different backends
     ++# handle the conflict differently, which would require separate code paths
     ++# to resolve.  There's not much point in making the code uglier to do that,
     ++# though, when the real thing we are testing (--remerge-diff) will hardcode
     ++# calls directly into the merge-ort API anyway.  So just force the use of
     ++# ort on the setup too.
     ++GIT_TEST_MERGE_ALGORITHM=ort
     ++
     + test_expect_success 'setup basic merges' '
     + 	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
     + 	git add numbers &&
     +@@ t/t4069-remerge-diff.sh: test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
     + 	git log -1 --oneline ab_resolution >tmp &&
     + 	cat <<-EOF >>tmp &&
     + 	diff --git a/numbers b/numbers
     ++	CONFLICT (content): Merge conflict in numbers
     + 	index a1fb731..6875544 100644
     + 	--- a/numbers
     + 	+++ b/numbers
     +@@ t/t4069-remerge-diff.sh: test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success 'setup non-content conflicts' '
     ++	git switch --orphan base &&
     ++
     ++	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
     ++	test_write_lines a b c d e f g h i >letters &&
     ++	test_write_lines in the way >content &&
     ++	git add numbers letters content &&
     ++	git commit -m base &&
     ++
     ++	git branch side1 &&
     ++	git branch side2 &&
     ++
     ++	git checkout side1 &&
     ++	test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
     ++	git mv letters letters_side1 &&
     ++	git mv content file_or_directory &&
     ++	git add numbers &&
     ++	git commit -m side1 &&
     ++
     ++	git checkout side2 &&
     ++	git rm numbers &&
     ++	git mv letters letters_side2 &&
     ++	mkdir file_or_directory &&
     ++	echo hello >file_or_directory/world &&
     ++	git add file_or_directory/world &&
     ++	git commit -m side2 &&
     ++
     ++	git checkout -b resolution side1 &&
     ++	test_must_fail git merge side2 &&
     ++	test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
     ++	git add numbers &&
     ++	git add letters_side1 &&
     ++	git rm letters &&
     ++	git rm letters_side2 &&
     ++	git add file_or_directory~HEAD &&
     ++	git mv file_or_directory~HEAD wanted_content &&
     ++	git commit -m resolved
     ++'
     ++
     ++test_expect_success 'remerge-diff with non-content conflicts' '
     ++	git log -1 --oneline resolution >tmp &&
     ++	cat <<-EOF >>tmp &&
     ++	diff --git a/file_or_directory~HASH (side1) b/wanted_content
     ++	similarity index 100%
     ++	rename from file_or_directory~HASH (side1)
     ++	rename to wanted_content
     ++	CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
     ++	diff --git a/letters b/letters
     ++	CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
     ++	diff --git a/letters_side2 b/letters_side2
     ++	deleted file mode 100644
     ++	index b236ae5..0000000
     ++	--- a/letters_side2
     ++	+++ /dev/null
     ++	@@ -1,9 +0,0 @@
     ++	-a
     ++	-b
     ++	-c
     ++	-d
     ++	-e
     ++	-f
     ++	-g
     ++	-h
     ++	-i
     ++	diff --git a/numbers b/numbers
     ++	CONFLICT (modify/delete): numbers deleted in HASH (side2) and modified in HASH (side1).  Version HASH (side1) of numbers left in tree.
     ++	EOF
     ++	# We still have some sha1 hashes above; rip them out so test works
     ++	# with sha256
     ++	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
     ++
     ++	git show --oneline --remerge-diff resolution >tmp &&
     ++	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     + test_done
  9:  4f21969e357 <  -:  ----------- doc/diff-options: explain the new --remerge-diff option

-- 
gitgitgadget
