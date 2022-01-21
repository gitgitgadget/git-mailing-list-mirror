Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67069C433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 19:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiAUTMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 14:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiAUTMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 14:12:25 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DD2C06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:24 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso20091974wmf.1
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JDQcvz53cPl0YyM23LmjbtOknwn6y/9GiRpcVoJok3c=;
        b=jyQPAp4L33o+vtqyqmAu93lT/8p4alBWbgTHDyWSG5LaCBkhXfSA34uE3UkJfPxnSk
         wK/CIpRhlU9PGT/ogMN5lIHUA7HjS8SbgmeZvwjLrg6md8traGTzH6w8mBpNhRk4HcYU
         tYM5Va0S2wuqRFEEWd12qGvkP3tK4SThD76ZkbrufS2ORQ3+q0cTwp5tqilsEqi+REGR
         pZnUf1AcH7o7ZaioFrNizO3GsRcPRja5N/ZeRQka/XEO2Bfor6UthYtDx1+/H4NQlBvw
         W893AxgBZKzys5tr7fycqHcFqCIqVelqB1xloQIqciRpD4VKlX+Fd027Vs8pQpIMvp8o
         QykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JDQcvz53cPl0YyM23LmjbtOknwn6y/9GiRpcVoJok3c=;
        b=tMVW6I3H3vU1u7z9VkqSpBvyFxJweY7eXXQdPVtfwZ7yUfTS3V0DDE/Gctng3QT4ay
         bob1uieCJu0Kyq1boEX1yXHeAYDQtvIgcxHVqkY34bz1YxhrGMb3FAlcJ4iOLc/8tfyT
         7jYXOcPTLKV1DEFbwDtxxkyIKkmSrIsjCqR/AYYoR5qszljayOl3DmdjAmpniJLE7yBS
         uw9SCghbRRHL9HAmwkfcgTaZ4rKqTuhcAALATRRi8slj3nHpsZSy7v94G+b2dH52LhTx
         N/+m1laRDy9N+hk+Q6W28iISJ4i7lhb5TfpcpRrOKjD/Y9dv+a7BvylOUi0Qj0TU2M5j
         exRw==
X-Gm-Message-State: AOAM530oGhI7Oh+zbQ+a/6sv4e2FlWFXm9D2MSLzxtHOWBv+qA5bF5dD
        Pst02x+0dd6pr7tGdJHawqqTmNv+yh8=
X-Google-Smtp-Source: ABdhPJw91fhFRpTC/P7NyqThdpx0MqZzr0aD0lWXB7ptGSUxBCLlh64i97OMOkJcRk8l7IjnnuH7yQ==
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr1178619wmj.23.1642792342611;
        Fri, 21 Jan 2022 11:12:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10sm8858207wrq.52.2022.01.21.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:12:21 -0800 (PST)
Message-Id: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
References: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Jan 2022 19:12:10 +0000
Subject: [PATCH v4 00/10] Add a new --remerge-diff capability to show & log
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
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are some patches to add a --remerge-diff capability to show & log,
which works by comparing merge commits to an automatic remerge (note that
the automatic remerge tree can contain files with conflict markers).

Changes since v3:

 * Filter conflict headers according to pathspecs
 * Instead of always including conflict headers for all diff types, only
   select them with --diff-filter=U OR whenever the associated diff in
   question is selected
 * New testcases dealing with --diff-filter, pathspecs, and default history
   simplification
 * Switched back from die_errno() to die()

Changes NOT included (mostly because I'm not sure what to add or where):

 * Johannes Altimanninger suggested changing the ordering of the new headers
   relative to other headers. He made a good point, but I also like having
   the conflict messages next to the text, so I'm conflicted about what's
   best.
 * (Technically not part of this feature, but kind of related.) Months ago,
   Junio suggested documenting ${GIT_DIR}/AUTO_MERGE better
   (https://lore.kernel.org/git/xmqqtuj4nepe.fsf@gitster.g/). I looked at
   the time, but couldn't find a place to put it that made sense to me.

Changes since v2 (of the restarted submission):

 * Numerous small improvements suggested by Johannes Altmanninger
 * Avoid including conflict messages from inner merges (due to example
   pointed out by Ævar).
 * Added a "remerge" prefix to all the new diff headers (suggested by Junio
   in a previous round, but I couldn't come up with a good name before. It
   suddenly hit me that "remerge" is an obvious prefix to use, and even
   helps explain what the rest of the line is for.)

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
such a bug in an internal tool existed in December 2020 and this command was
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

Elijah Newren (10):
  show, log: provide a --remerge-diff capability
  log: clean unneeded objects during `log --remerge-diff`
  ll-merge: make callers responsible for showing warnings
  merge-ort: capture and print ll-merge warnings in our preferred
    fashion
  merge-ort: mark a few more conflict messages as omittable
  merge-ort: format messages slightly different for use in headers
  diff: add ability to insert additional headers for paths
  show, log: include conflict/warning messages in --remerge-diff headers
  merge-ort: mark conflict/warning messages from inner merges as
    omittable
  diff-merges: avoid history simplifications when diffing merges

 Documentation/diff-options.txt |  10 +-
 apply.c                        |   5 +-
 builtin/checkout.c             |  12 +-
 builtin/log.c                  |  15 ++
 diff-merges.c                  |  14 ++
 diff.c                         | 124 +++++++++++++-
 diff.h                         |   3 +-
 ll-merge.c                     |  40 +++--
 ll-merge.h                     |   9 +-
 log-tree.c                     | 118 +++++++++++++-
 merge-blobs.c                  |   5 +-
 merge-ort.c                    |  55 ++++++-
 merge-ort.h                    |  10 ++
 merge-recursive.c              |   9 +-
 merge-recursive.h              |   2 +
 notes-merge.c                  |   5 +-
 rerere.c                       |   9 +-
 revision.h                     |   6 +-
 t/t4069-remerge-diff.sh        | 290 +++++++++++++++++++++++++++++++++
 t/t6404-recursive-merge.sh     |   9 +-
 t/t6406-merge-attr.sh          |   9 +-
 tmp-objdir.c                   |   5 +
 tmp-objdir.h                   |   6 +
 23 files changed, 722 insertions(+), 48 deletions(-)
 create mode 100755 t/t4069-remerge-diff.sh


base-commit: 4e44121c2d7bced65e25eb7ec5156290132bec94
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1103%2Fnewren%2Fremerge-diff-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1103/newren/remerge-diff-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1103

Range-diff vs v3:

  1:  d57ae218cf9 !  1:  0b94724311d show, log: provide a --remerge-diff capability
     @@ builtin/log.c: static int cmd_log_walk(struct rev_info *rev)
      +	if (rev->remerge_diff) {
      +		remerge_objdir = tmp_objdir_create("remerge-diff");
      +		if (!remerge_objdir)
     -+			die_errno(_("unable to create temporary object directory"));
     ++			die(_("unable to create temporary object directory"));
      +		tmp_objdir_replace_primary_odb(remerge_objdir, 1);
      +	}
       
     @@ t/t4069-remerge-diff.sh (new)
      +
      +. ./test-lib.sh
      +
     ++# This test is ort-specific
     ++test "${GIT_TEST_MERGE_ALGORITHM:-ort}" = ort || {
     ++	skip_all="GIT_TEST_MERGE_ALGORITHM != ort"
     ++	test_done
     ++}
     ++
      +test_expect_success 'setup basic merges' '
      +	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
      +	git add numbers &&
  2:  798625b53f2 !  2:  f06de6c1b2f log: clean unneeded objects during `log --remerge-diff`
     @@ builtin/log.c: static int cmd_log_walk(struct rev_info *rev)
      -		if (!remerge_objdir)
      +		rev->remerge_objdir = tmp_objdir_create("remerge-diff");
      +		if (!rev->remerge_objdir)
     - 			die_errno(_("unable to create temporary object directory"));
     + 			die(_("unable to create temporary object directory"));
      -		tmp_objdir_replace_primary_odb(remerge_objdir, 1);
      +		tmp_objdir_replace_primary_odb(rev->remerge_objdir, 1);
       	}
  3:  b952f674df1 =  3:  8d6c3d48f0e ll-merge: make callers responsible for showing warnings
  4:  e8cf1626960 =  4:  de8e8f88fa4 merge-ort: capture and print ll-merge warnings in our preferred fashion
  5:  4d1848c8a29 =  5:  6b535a4d55a merge-ort: mark a few more conflict messages as omittable
  6:  81e736b847e =  6:  e2441608c63 merge-ort: format messages slightly different for use in headers
  7:  5000a94aa98 !  7:  62734beb693 diff: add ability to insert additional headers for paths
     @@ diff.c: int diff_unmodified_pair(struct diff_filepair *p)
       static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
       {
      -	if (diff_unmodified_pair(p))
     ++	int include_conflict_headers =
     ++	    (additional_headers(o, p->one->path) &&
     ++	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
     ++
      +	/*
      +	 * Check if we can return early without showing a diff.  Note that
      +	 * diff_filepair only stores {oid, path, mode, is_valid}
      +	 * information for each path, and thus diff_unmodified_pair() only
      +	 * considers those bits of info.  However, we do not want pairs
     -+	 * created by create_filepairs_for_header_only_notifications() to
     -+	 * be ignored, so return early if both p is unmodified AND
     -+	 * p->one->path is not in additional headers.
     ++	 * created by create_filepairs_for_header_only_notifications()
     ++	 * (which always look like unmodified pairs) to be ignored, so
     ++	 * return early if both p is unmodified AND we don't want to
     ++	 * include_conflict_headers.
      +	 */
     -+	if (diff_unmodified_pair(p) && !additional_headers(o, p->one->path))
     ++	if (diff_unmodified_pair(p) && !include_conflict_headers)
       		return;
       
      +	/* Actually, we can also return early to avoid showing tree diffs */
     @@ diff.c: static void diff_flush_checkdiff(struct diff_filepair *p,
       {
       	struct diff_queue_struct *q = &diff_queued_diff;
       	int i;
     ++	int include_conflict_headers =
     ++	    (o->additional_path_headers &&
     ++	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
      +
     -+	if (o->additional_path_headers &&
     -+	    !strmap_empty(o->additional_path_headers))
     ++	if (include_conflict_headers)
      +		return 0;
     ++
       	for (i = 0; i < q->nr; i++)
       		if (!diff_unmodified_pair(q->queue[i]))
       			return 0;
     @@ diff.h: void diffcore_fix_diff_index(void);
       "  -a  --text    treat all files as text.\n"
       
      -int diff_queue_is_empty(void);
     -+int diff_queue_is_empty(struct diff_options*);
     ++int diff_queue_is_empty(struct diff_options *o);
       void diff_flush(struct diff_options*);
       void diff_free(struct diff_options*);
       void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
  8:  78ec1f44e4e !  8:  17eccf7e0d6 show, log: include conflict/warning messages in --remerge-diff headers
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## log-tree.c ##
     +@@
     + #include "line-log.h"
     + #include "help.h"
     + #include "range-diff.h"
     ++#include "strmap.h"
     + 
     + static struct decoration name_decoration = { "object names" };
     + static int decoration_loaded;
     +@@ log-tree.c: static int do_diff_combined(struct rev_info *opt, struct commit *commit)
     + 	return !opt->loginfo;
     + }
     + 
     ++static void setup_additional_headers(struct diff_options *o,
     ++				     struct strmap *all_headers)
     ++{
     ++	struct hashmap_iter iter;
     ++	struct strmap_entry *entry;
     ++
     ++	/*
     ++	 * Make o->additional_path_headers contain the subset of all_headers
     ++	 * that match o->pathspec.  If there aren't any that match o->pathspec,
     ++	 * then make o->additional_path_headers be NULL.
     ++	 */
     ++
     ++	if (!o->pathspec.nr) {
     ++		o->additional_path_headers = all_headers;
     ++		return;
     ++	}
     ++
     ++	o->additional_path_headers = xmalloc(sizeof(struct strmap));
     ++	strmap_init_with_options(o->additional_path_headers, NULL, 0);
     ++	strmap_for_each_entry(all_headers, &iter, entry) {
     ++		if (match_pathspec(the_repository->index, &o->pathspec,
     ++				   entry->key, strlen(entry->key),
     ++				   0 /* prefix */, NULL /* seen */,
     ++				   0 /* is_dir */))
     ++			strmap_put(o->additional_path_headers,
     ++				   entry->key, entry->value);
     ++	}
     ++	if (!strmap_get_size(o->additional_path_headers)) {
     ++		strmap_clear(o->additional_path_headers, 0);
     ++		FREE_AND_NULL(o->additional_path_headers);
     ++	}
     ++}
     ++
     ++static void cleanup_additional_headers(struct diff_options *o)
     ++{
     ++	if (!o->pathspec.nr) {
     ++		o->additional_path_headers = NULL;
     ++		return;
     ++	}
     ++	if (!o->additional_path_headers)
     ++		return;
     ++
     ++	strmap_clear(o->additional_path_headers, 0);
     ++	FREE_AND_NULL(o->additional_path_headers);
     ++}
     ++
     + static int do_remerge_diff(struct rev_info *opt,
     + 			   struct commit_list *parents,
     + 			   struct object_id *oid,
      @@ log-tree.c: static int do_remerge_diff(struct rev_info *opt,
       	/* Setup merge options */
       	init_merge_options(&o, the_repository);
     @@ log-tree.c: static int do_remerge_diff(struct rev_info *opt,
       	merge_incore_recursive(&o, bases, parent1, parent2, &res);
       
       	/* Show the diff */
     -+	opt->diffopt.additional_path_headers = res.path_messages;
     ++	setup_additional_headers(&opt->diffopt, res.path_messages);
       	diff_tree_oid(&res.tree->object.oid, oid, "", &opt->diffopt);
       	log_tree_diff_flush(opt);
       
       	/* Cleanup */
     -+	opt->diffopt.additional_path_headers = NULL;
     ++	cleanup_additional_headers(&opt->diffopt);
       	strbuf_release(&parent1_desc);
       	strbuf_release(&parent2_desc);
       	merge_finalize(&o, &res);
     @@ merge-ort.h: struct merge_result {
       	 * to merge_incore_*().  Includes data needed to update the index (if
      
       ## t/t4069-remerge-diff.sh ##
     -@@ t/t4069-remerge-diff.sh: test_description='remerge-diff handling'
     - 
     - . ./test-lib.sh
     - 
     -+# --remerge-diff uses ort under the hood regardless of setting.  However,
     -+# we set up a file/directory conflict beforehand, and the different backends
     -+# handle the conflict differently, which would require separate code paths
     -+# to resolve.  There's not much point in making the code uglier to do that,
     -+# though, when the real thing we are testing (--remerge-diff) will hardcode
     -+# calls directly into the merge-ort API anyway.  So just force the use of
     -+# ort on the setup too.
     -+GIT_TEST_MERGE_ALGORITHM=ort
     -+
     - test_expect_success 'setup basic merges' '
     - 	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
     - 	git add numbers &&
      @@ t/t4069-remerge-diff.sh: test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
       	git log -1 --oneline ab_resolution >tmp &&
       	cat <<-EOF >>tmp &&
     @@ t/t4069-remerge-diff.sh: test_expect_success 'remerge-diff with both a resolved
      +	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success 'remerge-diff w/ diff-filter=U: all conflict headers, no diff content' '
     ++	git log -1 --oneline resolution >tmp &&
     ++	cat <<-EOF >>tmp &&
     ++	diff --git a/file_or_directory~HASH (side1) b/file_or_directory~HASH (side1)
     ++	remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
     ++	diff --git a/letters b/letters
     ++	remerge CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
     ++	diff --git a/numbers b/numbers
     ++	remerge CONFLICT (modify/delete): numbers deleted in HASH (side2) and modified in HASH (side1).  Version HASH (side1) of numbers left in tree.
     ++	EOF
     ++	# We still have some sha1 hashes above; rip them out so test works
     ++	# with sha256
     ++	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
     ++
     ++	git show --oneline --remerge-diff --diff-filter=U resolution >tmp &&
     ++	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'remerge-diff w/ diff-filter=R: relevant file + conflict header' '
     ++	git log -1 --oneline resolution >tmp &&
     ++	cat <<-EOF >>tmp &&
     ++	diff --git a/file_or_directory~HASH (side1) b/wanted_content
     ++	similarity index 100%
     ++	rename from file_or_directory~HASH (side1)
     ++	rename to wanted_content
     ++	remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
     ++	EOF
     ++	# We still have some sha1 hashes above; rip them out so test works
     ++	# with sha256
     ++	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
     ++
     ++	git show --oneline --remerge-diff --diff-filter=R resolution >tmp &&
     ++	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'remerge-diff w/ pathspec: limits to relevant file including conflict header' '
     ++	git log -1 --oneline resolution >tmp &&
     ++	cat <<-EOF >>tmp &&
     ++	diff --git a/letters b/letters
     ++	remerge CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
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
     ++	EOF
     ++	# We still have some sha1 hashes above; rip them out so test works
     ++	# with sha256
     ++	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
     ++
     ++	git show --oneline --remerge-diff --full-history resolution -- "letters*" >tmp &&
     ++	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
     ++	test_cmp expect actual
     ++'
      +
       test_done
  9:  64b44ee84f3 =  9:  b3e7656cfc6 merge-ort: mark conflict/warning messages from inner merges as omittable
  -:  ----------- > 10:  ea5df61cf35 diff-merges: avoid history simplifications when diffing merges

-- 
gitgitgadget
