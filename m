Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A961AC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5FF600CD
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbhHaC1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbhHaC1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 22:27:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19886C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m2so10071195wmm.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=e0gxaza0j6Yq7lMixSv/8nE+qQxSBHMf3swRTAJ/vfU=;
        b=WdOsnL99NcnSD2/FV7iUcsqRHPL4QP+F5Y+MYcXZfoTjNJt8eooOkKIykn6F/Ocd6u
         S9/PxDyPmYdeuCuU6oCWLtsPD2Yrn9fpfFnYHbpKdIp6qXJ+dDzo+IRMJ01OEfTqwOrF
         oAIO1bghqXjnE5Kl96uPjCftwuj9yEWHzJ71uUVDqFTHBl9IrwY7ArpVGoevvXugMnAA
         TIuMP5NFKuoHCWk1kA8W+PlATVnNBk4+nItmGG9wByCK/olyAGliEDcnP7ljTzUNuFft
         WWC8Ty2OpQwKFBeACoOx7XvsTsvjUTHSMTY9bjgyyxrNlBjL94b9+nxf4T2dx7ppDi8r
         7u1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e0gxaza0j6Yq7lMixSv/8nE+qQxSBHMf3swRTAJ/vfU=;
        b=rSzgO6iokZBglIFJazWA1d91Bf3afsUtCCwEDdK+1Lp5eUoeaF6bzUZ/L/SXfBlq8K
         s8f4kJ+plJUTkrzLf7GkrZBBQzS8agvOagy4aFS0/dfsawS8Vg8JNYbs8NcZ7idiQGmD
         sqtL6ak27UsXmlc07pRnKVmqQ7eZyZ3jEQCyJKJ01iH1oKgzu8pzpPSOms1iCNTvFikS
         V4h41Glc/pVm1Zjd9PPIDP1Gr5Tcf0ckoLiBGD5CgBepqE7p2I1y31kr5ClZO/izhxtU
         rksnkA0FdxM5j+Foa1p7urBHYXhlH79tcQwT/YHKj/iUIKRTicGvXW1lHuqm1GODhowJ
         9lPg==
X-Gm-Message-State: AOAM533teR778egVBaS7tpu2Wh+fb41olSGgL2EZmuPrxtMQtdmEEz/e
        scbYYdeWVBnVxijsN7Rmc5NmK6SxBB0=
X-Google-Smtp-Source: ABdhPJyXuco3HGted4duxHfRrR4ZIV+FDYCkHFqA5B0AUIJoU48F/yjeoN2SCPCm9QfAEnQU8r2big==
X-Received: by 2002:a1c:2705:: with SMTP id n5mr1679998wmn.176.1630376801679;
        Mon, 30 Aug 2021 19:26:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 129sm1070902wmz.26.2021.08.30.19.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 19:26:41 -0700 (PDT)
Message-Id: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 02:26:33 +0000
Subject: [PATCH 0/7] Add a new --remerge-diff capability to show & log
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are some patches to add a --remerge-diff capability to show & log,
which works by comparing merge commits to an automatic remerge (note that
the automatic remerge tree can contain files with conflict markers).

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

Elijah Newren (7):
  merge-ort: mark a few more conflict messages as omittable
  merge-ort: add ability to record conflict messages in a file
  ll-merge: add API for capturing warnings in a strbuf instead of stderr
  merge-ort: capture and print ll-merge warnings in our preferred
    fashion
  tmp-objdir: new API for creating and removing primary object dirs
  show, log: provide a --remerge-diff capability
  doc/diff-options: explain the new --remerge-diff option

 Documentation/diff-options.txt |  8 +++
 builtin/log.c                  | 23 ++++++++
 diff-merges.c                  | 12 +++++
 ll-merge.c                     | 51 +++++++++++++-----
 ll-merge.h                     |  9 ++++
 log-tree.c                     | 69 ++++++++++++++++++++++++
 merge-ort.c                    | 96 +++++++++++++++++++++++++++++++---
 merge-recursive.c              |  3 ++
 merge-recursive.h              |  1 +
 revision.h                     |  6 ++-
 t/t6404-recursive-merge.sh     | 10 +++-
 t/t6406-merge-attr.sh          | 10 +++-
 tmp-objdir.c                   | 29 ++++++++++
 tmp-objdir.h                   | 16 ++++++
 14 files changed, 319 insertions(+), 24 deletions(-)


base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1080%2Fnewren%2Fremerge-diff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1080/newren/remerge-diff-v1
Pull-Request: https://github.com/git/git/pull/1080
-- 
gitgitgadget
