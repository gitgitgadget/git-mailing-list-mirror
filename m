Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E05C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 02:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243814AbiBBChm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 21:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiBBChl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 21:37:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB12C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 18:37:41 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k6-20020a05600c1c8600b003524656034cso2923184wms.2
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 18:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7Az0C1WStdk9jgQdH8cIbFc5CgfxqIuYseozqUILVnc=;
        b=R342BqDTesgaIT2ttf/eUiPDE4PLCpItrrcYYlPMxiGP0Nqb6N56iUjPZcAgPDXpBX
         hh2f6Nn9QylZPhontl6s9837VRjC/2YirfHlESgIrZifZUFlwz9RPFLxAJUosfXsdadq
         VyFJ1wDCg28j5A02DPn/1HucCvsv2y2N70qh1bcUaSJkwXbr1Ksay8aRWlbafjPiHsbB
         Yt86t8cNYqIcrX4jrDRqJTXKGqTkHJHx1hzwOPUD0JOIFAMptkk9r5sq3M963hxQWjyA
         qQhQ8KHZueAy0ykGXaPk8+VqSdZdNcrYXPpKMIvyq/HEhmALqjMUC630azo/BvauBJQI
         ilSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7Az0C1WStdk9jgQdH8cIbFc5CgfxqIuYseozqUILVnc=;
        b=aV65L2vGru2Vql4w5KtqJfaxADOPUSPo5oQwR/P/XxGIwDbB3Hnenr2U/wOs7RJObM
         eaAQfyl9Y/catBee6zT0PGfSl/IKDGhbAuVIIS2ykaaA71DL2FqZ9fbNi+jDxaNbODzn
         H4iGHIoMGPGkxGNPjN60vgEJscM6ZPMCq2m1Y2MZ4pJeMjvkkimndupiVfnKIWj3j5k+
         CBd/im4x2mOFFEz2Y4QxJhJ/VETy/lhmPDGMTpW+s3b/UBpEwQ73q52rMmethkqKA4Hq
         xn/tSS9taGQTemnFnGDy977T7lnU48Zqo/Wma6I74EwsFAq0MlDBjJmz57xrFmv2lkbw
         LGnw==
X-Gm-Message-State: AOAM531Elkc9AsCZFPWkQ4ElTaW/4wZgeVf9wscK3ybgaguXlgLKRRMx
        kYY8ANsWSpGF6xT1nHFAxEFo4nu/Jb0=
X-Google-Smtp-Source: ABdhPJw6QctUoW5CpLEhUkRnv/fdklFwxG5Mx8u/sZP0B/2nI9APpfC66I0uwR53YXAvdtYv6t0Hog==
X-Received: by 2002:a05:600c:27d2:: with SMTP id l18mr4099598wmb.176.1643769459226;
        Tue, 01 Feb 2022 18:37:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2sm3378225wmc.33.2022.02.01.18.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 18:37:38 -0800 (PST)
Message-Id: <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
References: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 02:37:27 +0000
Subject: [PATCH v5 00/10] Add a new --remerge-diff capability to show & log
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

Changes since v4:

 * Just a few minor tweaks -- comment on output being subject to change,
   simpler test skipping check, and improved bug message

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

 Documentation/diff-options.txt |  14 +-
 apply.c                        |   5 +-
 builtin/checkout.c             |  12 +-
 builtin/log.c                  |  15 ++
 diff-merges.c                  |  14 ++
 diff.c                         | 124 +++++++++++++-
 diff.h                         |   3 +-
 ll-merge.c                     |  40 +++--
 ll-merge.h                     |   9 +-
 log-tree.c                     | 118 ++++++++++++-
 merge-blobs.c                  |   5 +-
 merge-ort.c                    |  55 ++++++-
 merge-ort.h                    |  10 ++
 merge-recursive.c              |   9 +-
 merge-recursive.h              |   2 +
 notes-merge.c                  |   5 +-
 rerere.c                       |   9 +-
 revision.h                     |   6 +-
 t/t4069-remerge-diff.sh        | 291 +++++++++++++++++++++++++++++++++
 t/t6404-recursive-merge.sh     |   9 +-
 t/t6406-merge-attr.sh          |   9 +-
 tmp-objdir.c                   |   5 +
 tmp-objdir.h                   |   6 +
 23 files changed, 727 insertions(+), 48 deletions(-)
 create mode 100755 t/t4069-remerge-diff.sh


base-commit: 4e44121c2d7bced65e25eb7ec5156290132bec94
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1103%2Fnewren%2Fremerge-diff-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1103/newren/remerge-diff-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1103

Range-diff vs v4:

  1:  0b94724311d !  1:  0a260125266 show, log: provide a --remerge-diff capability
     @@ Documentation/diff-options.txt: ifdef::git-log[]
      +	create a temporary tree object -- potentially containing files
      +	with conflict markers and such.  A diff is then shown between
      +	that temporary tree and the actual merge commit.
     +++
     ++The output emitted when this option is used is subject to change, and
     ++so is its interaction with other options (unless explicitly
     ++documented).
      ++
       --diff-merges=combined:::
       --diff-merges=c:::
     @@ t/t4069-remerge-diff.sh (new)
      +. ./test-lib.sh
      +
      +# This test is ort-specific
     -+test "${GIT_TEST_MERGE_ALGORITHM:-ort}" = ort || {
     ++if test "${GIT_TEST_MERGE_ALGORITHM}" != ort
     ++then
      +	skip_all="GIT_TEST_MERGE_ALGORITHM != ort"
      +	test_done
     -+}
     ++fi
      +
      +test_expect_success 'setup basic merges' '
      +	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
  2:  f06de6c1b2f !  2:  ed0d60de24c log: clean unneeded objects during `log --remerge-diff`
     @@ log-tree.c: static int do_remerge_diff(struct rev_info *opt,
      +	if (opt->remerge_objdir)
      +		tmp_objdir_discard_objects(opt->remerge_objdir);
      +	else
     -+		BUG("unable to remove temporary object directory");
     ++		BUG("did a remerge diff without remerge_objdir?!?");
       
       	return !opt->loginfo;
       }
  3:  8d6c3d48f0e =  3:  ba4de88f2c4 ll-merge: make callers responsible for showing warnings
  4:  de8e8f88fa4 =  4:  d7a1f4e1f9f merge-ort: capture and print ll-merge warnings in our preferred fashion
  5:  6b535a4d55a =  5:  cbde4e5d372 merge-ort: mark a few more conflict messages as omittable
  6:  e2441608c63 =  6:  d3e4242a5bd merge-ort: format messages slightly different for use in headers
  7:  62734beb693 =  7:  4d79da6e20a diff: add ability to insert additional headers for paths
  8:  17eccf7e0d6 =  8:  ff9c14b0b7c show, log: include conflict/warning messages in --remerge-diff headers
  9:  b3e7656cfc6 =  9:  aa63860cd0f merge-ort: mark conflict/warning messages from inner merges as omittable
 10:  ea5df61cf35 = 10:  59d12f213b2 diff-merges: avoid history simplifications when diffing merges

-- 
gitgitgadget
