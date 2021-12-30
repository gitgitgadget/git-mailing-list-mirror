Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4961BC433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242351AbhL3XgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbhL3XgN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:36:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54DDC061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so14052627wmb.0
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I58iqdCpIGawfEIlHWHtIbP4elOFl2AUQnx2rwRDRAQ=;
        b=ZTOcbYOkPY3yy20Ih4qSv4Xhip+tcTWABlh5ZV8gBGQirveMkOlxDeRc5pr5BZsNA/
         J7Xk7k6gpSaEWRZBlHL/NFP36TxRLjUpBqZFLx6hgIiSPrxRQqDEP1qgOrBVrDDuoRI8
         sBfqvrfiFQ0Hraw4/wCGRaKyEVbHfh5E22SBNI+duP5r6whXcJKp2iP2YJl3gg7WGvQo
         eIISPea/o6vyrWDGhZ0U3Frn/E/TX6sVbneSAD7hSktb/wbW0SmVkh1Go44rs/pS+H7y
         zQXCK3oT0svUemuyv/cYwVrm1Tp2+BN5hS2Intj22ceUfK4rjm716+iflHhOxC67LAzK
         PI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I58iqdCpIGawfEIlHWHtIbP4elOFl2AUQnx2rwRDRAQ=;
        b=Lu8SGb6H1gCiE2KvtIfWtSPSAwv6HS1r6wq1HZDLumnVTEOyLbWy2ZKZg8nqmwly/U
         TLOugTe45mBRcScv3/RI7ceSQBz7JfDmrctS7dY46PPoMWpVpk4R9d2ArnaFzTZqkwRU
         cn+semtFUev5/cf+YbrH8d3DKYpQO+XRz+iwHSwTPaCi6Cp9twv1ULHtig9Z7/WjHciy
         N0/r4wNxB1faJA4TFg8p5RRbgC2FLEZ21FmkN+/blYF+E4uOgC1ftb4mMGVNLRfQjbne
         LQA4COFyV74DGbjBTdZVnb9/FAFHQK41D5ABJxApIyAERLmkhWtNdcVzJVwDp/PJ3npj
         o91A==
X-Gm-Message-State: AOAM531QQnDkwWlxDPAdyzdSkQb+b9WGR8a++G2TQrOo+Pf/+705G18+
        NZaEgVcP2HLqZ2ltFQrpNh/k95gXUUc=
X-Google-Smtp-Source: ABdhPJw50U4k1He6YE0CnfZCEveFYDXrb/fTbCCPnc9xmpuCwcOUAHoHEWyvMcVGHU6X5/7bmpPXxA==
X-Received: by 2002:a05:600c:35d4:: with SMTP id r20mr28540985wmq.190.1640907370626;
        Thu, 30 Dec 2021 15:36:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z22sm25687450wmp.40.2021.12.30.15.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 15:36:10 -0800 (PST)
Message-Id: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 23:36:00 +0000
Subject: [PATCH v3 0/9] Add a new --remerge-diff capability to show & log
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

Changes NOT included (mostly because I'm not sure what to add or where):

 * Ævar suggested also extending the docs with usage guidelines, but the
   example he picked was IMO best handled by just add --remerge-diff, so I'm
   not sure what to add to the docs. Maybe the log -S<string> --remerge-diff
   example as a way to more reliably determine when a string was added to or
   removed from the codebase? Where would that go anyway?
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

Elijah Newren (9):
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

 Documentation/diff-options.txt |  10 +-
 apply.c                        |   5 +-
 builtin/checkout.c             |  12 ++-
 builtin/log.c                  |  15 +++
 diff-merges.c                  |  12 +++
 diff.c                         | 116 +++++++++++++++++++++-
 diff.h                         |   3 +-
 ll-merge.c                     |  40 ++++----
 ll-merge.h                     |   9 +-
 log-tree.c                     |  71 +++++++++++++-
 merge-blobs.c                  |   5 +-
 merge-ort.c                    |  55 ++++++++++-
 merge-ort.h                    |  10 ++
 merge-recursive.c              |   9 +-
 merge-recursive.h              |   2 +
 notes-merge.c                  |   5 +-
 rerere.c                       |   9 +-
 revision.h                     |   6 +-
 t/t4069-remerge-diff.sh        | 170 +++++++++++++++++++++++++++++++++
 t/t6404-recursive-merge.sh     |   9 +-
 t/t6406-merge-attr.sh          |   9 +-
 tmp-objdir.c                   |   5 +
 tmp-objdir.h                   |   6 ++
 23 files changed, 545 insertions(+), 48 deletions(-)
 create mode 100755 t/t4069-remerge-diff.sh


base-commit: 4e44121c2d7bced65e25eb7ec5156290132bec94
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1103%2Fnewren%2Fremerge-diff-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1103/newren/remerge-diff-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1103

Range-diff vs v2:

  1:  b3ae62083e1 !  1:  d57ae218cf9 show, log: provide a --remerge-diff capability
     @@ Commit message
      
          This capability works by creating a temporary object directory and
          marking it as the primary object store.  This makes it so that any blobs
     -    or trees created during the automatic merge easily removable afterwards
     -    by just deleting all objects from the temporary object directory.
     +    or trees created during the automatic merge are easily removable
     +    afterwards by just deleting all objects from the temporary object
     +    directory.
      
          There are a few ways that this implementation is suboptimal:
            * `log --remerge-diff` becomes slow, because the temporary object
     -        directory can fills with many loose objects while running
     +        directory can fill with many loose objects while running
            * the log output can be muddied with misplaced "warning: cannot merge
              binary files" messages, since ll-merge.c unconditionally writes those
              messages to stderr while running instead of allowing callers to
     @@ Commit message
              way for a user of --remerge-diff to know that there had been a
              conflict which was resolved (and which possibly motivated other
              changes in the merge commit).
     +      * when fixing the previous issue, note that some unimportant conflict
     +        and warning messages might start being included.  We should instead
     +        make sure these remain dropped.
          Subsequent commits will address these issues.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/diff-options.txt ##
     +@@ Documentation/diff-options.txt: endif::git-diff[]
     + endif::git-format-patch[]
     + 
     + ifdef::git-log[]
     +---diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc)::
     ++--diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r)::
     + --no-diff-merges::
     + 	Specify diff format to be used for merge commits. Default is
     + 	{diff-merges-default} unless `--first-parent` is in use, in which case
      @@ Documentation/diff-options.txt: ifdef::git-log[]
       	each of the parents. Separate log entry and diff is generated
       	for each parent.
     @@ t/t4069-remerge-diff.sh (new)
      +	git commit -a -m change_c &&
      +
      +	git checkout bc_resolution &&
     -+	# fast forward
     -+	git merge feature_b &&
     ++	git merge --ff-only feature_b &&
      +	# no conflict
      +	git merge feature_c &&
      +
      +	git checkout ab_resolution &&
     -+	# fast forward
     -+	git merge feature_a &&
     ++	git merge --ff-only feature_a &&
      +	# conflicts!
      +	test_must_fail git merge feature_b &&
      +	# Resolve conflict...and make another change elsewhere
  2:  54f1fb31d04 =  2:  798625b53f2 log: clean unneeded objects during `log --remerge-diff`
  3:  d5566f5d136 !  3:  b952f674df1 ll-merge: make callers responsible for showing warnings
     @@ Commit message
          Since some callers may want to send warning messages to somewhere other
          than stdout/stderr, stop printing "warning: Cannot merge binary files"
          from ll-merge and instead modify the return status of ll_merge() to
     -    indicate when a merge of binary files has occurred.
     +    indicate when a merge of binary files has occurred.  Message printing
     +    probably does not belong in a "low-level merge" anyway.
      
     -    This commit continues printing the message as-is; future changes will
     -    start handling the new commit differently in the merge-ort codepath.
     +    This commit continues printing the message as-is, just from the callers
     +    instead of within ll_merge().  Future changes will start handling the
     +    message differently in the merge-ort codepath.
     +
     +    There was one special case here: the callers in rerere.c do NOT check
     +    for and print such a message; since those code paths explicitly skip
     +    over binary files, there is no reason to check for a return status of
     +    LL_MERGE_BINARY_CONFLICT or print the related message.
      
          Note that my methodology included first modifying ll_merge() to return
          a struct, so that the compiler would catch all the callers for me and
     @@ ll-merge.c: static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
       	xmp.file2 = name2;
      -	return xdl_merge(orig, src1, src2, &xmp, result);
      +	status = xdl_merge(orig, src1, src2, &xmp, result);
     -+	ret = (status > 1 ) ? LL_MERGE_CONFLICT : status;
     ++	ret = (status > 0) ? LL_MERGE_CONFLICT : status;
      +	return ret;
       }
       
     @@ ll-merge.c: static int ll_ext_merge(const struct ll_merge_driver *fn,
       	strbuf_release(&cmd);
       	strbuf_release(&path_sq);
      -	return status;
     -+	ret = (status > 1) ? LL_MERGE_CONFLICT : status;
     ++	ret = (status > 0) ? LL_MERGE_CONFLICT : status;
      +	return ret;
       }
       
     @@ rerere.c: static int try_merge(struct index_state *istate,
       		 */
       		ret = ll_merge(result, path, &base, NULL, cur, "", &other, "",
       			       istate, NULL);
     -+		if (ret == LL_MERGE_BINARY_CONFLICT)
     -+			warning("Cannot merge binary files: %s (%s vs. %s)",
     -+				path, "", "");
      +	}
       
       	free(base.ptr);
  4:  a02845f12db =  4:  e8cf1626960 merge-ort: capture and print ll-merge warnings in our preferred fashion
  5:  000933c5d7f =  5:  4d1848c8a29 merge-ort: mark a few more conflict messages as omittable
  6:  887e46435c0 !  6:  81e736b847e merge-ort: format messages slightly different for use in headers
     @@ Commit message
          headers instead...but for that to work, we need for any multiline
          messages to replace newlines with both a newline and a space.  Add a new
          flag to signal when we want these messages modified in such a fashion,
     -    and use it in path_msg() to modify these messages this way.
     +    and use it in path_msg() to modify these messages this way.  Also, allow
     +    a special prefix to be specified for these headers.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ merge-ort.c: static void path_msg(struct merge_options *opt,
      +	if (opt->record_conflict_msgs_as_headers) {
      +		int i_sb = 0, i_tmp = 0;
      +
     ++		/* Start with the specified prefix */
     ++		if (opt->msg_header_prefix)
     ++			strbuf_addf(sb, "%s ", opt->msg_header_prefix);
     ++
      +		/* Copy tmp to sb, adding spaces after newlines */
     -+		strbuf_grow(sb, 2*tmp.len); /* more than sufficient */
     ++		strbuf_grow(sb, sb->len + 2*tmp.len); /* more than sufficient */
      +		for (; i_tmp < tmp.len; i_tmp++, i_sb++) {
      +			/* Copy next character from tmp to sb */
      +			sb->buf[sb->len + i_sb] = tmp.buf[i_tmp];
     @@ merge-ort.c: static void path_msg(struct merge_options *opt,
      +		sb->len += i_sb;
      +		sb->buf[sb->len] = '\0';
      +
     -+		/* Clean up tmp */
      +		strbuf_release(&tmp);
      +	}
      +
     @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
       		trace2_region_enter("merge", "display messages", opt->repo);
       
       		/* Hack to pre-allocate olist to the desired size */
     +@@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_result *result)
     + 	assert(opt->recursive_variant >= MERGE_VARIANT_NORMAL &&
     + 	       opt->recursive_variant <= MERGE_VARIANT_THEIRS);
     + 
     ++	if (opt->msg_header_prefix)
     ++		assert(opt->record_conflict_msgs_as_headers);
     ++
     + 	/*
     + 	 * detect_renames, verbosity, buffer_output, and obuf are ignored
     + 	 * fields that were used by "recursive" rather than "ort" -- but
      
       ## merge-recursive.c ##
      @@ merge-recursive.c: static int merge_start(struct merge_options *opt, struct tree *head)
     @@ merge-recursive.c: static int merge_start(struct merge_options *opt, struct tree
       
      +	/* Not supported; option specific to merge-ort */
      +	assert(!opt->record_conflict_msgs_as_headers);
     ++	assert(!opt->msg_header_prefix);
      +
       	/* Sanity check on repo state; index must match head */
       	if (repo_index_has_changes(opt->repo, head, &sb)) {
     @@ merge-recursive.h: struct merge_options {
       	const char *subtree_shift;
       	unsigned renormalize : 1;
      +	unsigned record_conflict_msgs_as_headers : 1;
     ++	const char *msg_header_prefix;
       
       	/* internal fields used by the implementation */
       	struct merge_options_internal *priv;
  7:  e9470651303 =  7:  5000a94aa98 diff: add ability to insert additional headers for paths
  8:  4cc53c55a6e !  8:  78ec1f44e4e show, log: include conflict/warning messages in --remerge-diff headers
     @@ log-tree.c: static int do_remerge_diff(struct rev_info *opt,
       	init_merge_options(&o, the_repository);
       	o.show_rename_progress = 0;
      +	o.record_conflict_msgs_as_headers = 1;
     ++	o.msg_header_prefix = "remerge";
       
       	ctx.abbrev = DEFAULT_ABBREV;
       	format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
     @@ t/t4069-remerge-diff.sh: test_expect_success 'remerge-diff with both a resolved
       	git log -1 --oneline ab_resolution >tmp &&
       	cat <<-EOF >>tmp &&
       	diff --git a/numbers b/numbers
     -+	CONFLICT (content): Merge conflict in numbers
     ++	remerge CONFLICT (content): Merge conflict in numbers
       	index a1fb731..6875544 100644
       	--- a/numbers
       	+++ b/numbers
     @@ t/t4069-remerge-diff.sh: test_expect_success 'remerge-diff with both a resolved
      +	similarity index 100%
      +	rename from file_or_directory~HASH (side1)
      +	rename to wanted_content
     -+	CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
     ++	remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
      +	diff --git a/letters b/letters
     -+	CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
     ++	remerge CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
      +	diff --git a/letters_side2 b/letters_side2
      +	deleted file mode 100644
      +	index b236ae5..0000000
     @@ t/t4069-remerge-diff.sh: test_expect_success 'remerge-diff with both a resolved
      +	-h
      +	-i
      +	diff --git a/numbers b/numbers
     -+	CONFLICT (modify/delete): numbers deleted in HASH (side2) and modified in HASH (side1).  Version HASH (side1) of numbers left in tree.
     ++	remerge CONFLICT (modify/delete): numbers deleted in HASH (side2) and modified in HASH (side1).  Version HASH (side1) of numbers left in tree.
      +	EOF
      +	# We still have some sha1 hashes above; rip them out so test works
      +	# with sha256
  -:  ----------- >  9:  64b44ee84f3 merge-ort: mark conflict/warning messages from inner merges as omittable

-- 
gitgitgadget
