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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC177C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4E823443
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbhAGUBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGUBq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:01:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA69C0612F5
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:30 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 91so6831942wrj.7
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=SdrSdTzEIutmWUiv9EhRLfX/FvXp2WtwaB5DX/FVMgc=;
        b=VXhJdk6BEWUrKIM7U4FTSkJvDdcNmNuNiD4bbN0WAJoXRO8uXt2KbViVaY1Z1olwdn
         aZ4UyC1sEC9iY7GPSyTFapRnrgUrEv9N6dE9lZCoCTbkye0R0Zfzi6b59AU2CMtfoxsS
         6CmkngWtsdlgIBSb4dXkqp8yva7KnvkddsvDQUS84M3Jd5N7yRmb2TurzB5tpVVP9xIQ
         Zm2tfTVwKLev09FUj2K7fML98CUHYiUX7+OsGDn3nzseaOZcKcS1UoLZDEWOp+OKWgkF
         NZgEKjC8dfYZ+aMzmLE9OpGyYU9G3mOAhaCjfc0OLAD1qEe7wLZXKON5irffe0EA/QQF
         q1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SdrSdTzEIutmWUiv9EhRLfX/FvXp2WtwaB5DX/FVMgc=;
        b=TwrYm2ktxiCdTZv/2hmotWNxnV8GuhKva+5pm8xQ33yeSJ90vNB28G8RYJ1Emy04df
         qZoV8+Vh7n8dJ3NoZ8ZWlWG53hAxHghvvrl5FzaiSdkiQBExIObRcbhssisHnoQnE52L
         9ujx+PrzDHENdyRoaRKfaHgDnE5QWIqJEdEGNwHbKmHEZQHPXWERzDDPmwlt5DILIgId
         br8uph9dMU+0rBC9syUpef57KBryVyNOYyIpDFi+c0tpozbDMoRRUNRuMevOYbd4KFM+
         IrU8F3C01DkkXUdBWenT7WlvfUscoLls4fzj9F/bDLJo6w/egUEMeg3RHXlVIFCw5cma
         6Y8g==
X-Gm-Message-State: AOAM5312n9LkbdRxn8OyeGJoNlx6IrItDYPbo2Qs/xcD6QQpXPA46l89
        dCNmq9PMFRlJcNecgIYu93F9Wps5gpw=
X-Google-Smtp-Source: ABdhPJyLCFiQdPhijjdZ/eB4iJXHBO6CUMtZ6zr4C7irosgcGFrilVhT6zoGIy4SzvDdpzK+kDqkTw==
X-Received: by 2002:adf:f88d:: with SMTP id u13mr269072wrp.161.1610049688982;
        Thu, 07 Jan 2021 12:01:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h29sm10561887wrc.68.2021.01.07.12.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:28 -0800 (PST)
Message-Id: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:09 +0000
Subject: [PATCH 00/18] Add directory rename detection to merge-ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[This is a resend of
https://lore.kernel.org/git/20210104235006.2867404-1-newren@gmail.com/ from
Monday without any changes; I wanted to move it to gitgitgadget for testing
and such after I remembered I had perms to create temporary branches for the
pull request base.]

This series depends on a merge of en/merge-ort-3 and en/merge-ort-recursive.
It does not depend on the en/ort-conflict-handling.

This series mostly implements directory rename detection for merge-ort; I'll
cover the "mostly" bit below. If one merges this series with en/merge-tests
and en/ort-conflict-handling, then this series drops the number of failing
tests in the testsuite under GIT_TEST_MERGE_ALGORITHM=ort from 60 down to 8.

There's a lot of code here, but almost all of the logic is just copied over
from similarly named functions in merge-recursive.c, as repeatedly noted in
the commit messages. There are several minor differences spread throughout
that make it not be a direct copy:

 * using strmap API instead of direct hashmap calls
 * ort keeps track of all files and directories and their shas in
   opt->priv->paths; no need to re-walk tree objects
 * keeping the necessary invariants for opt->priv->paths
 * we can pre-compute which directories are removed (stored in
   dirs_removed), avoiding the need for some post-processing
 * since ort already has struct rename_info, add the extra data there and
   allocate/free it with the rest of the rename_info
 * no non_unique_new_dir field, leading to the failure of test 2b; this will
   be addressed in a different way with upcoming performance work.

These differences make a direct comparison difficult, but there's not really
any new or novel logic; the logic for how directory rename detection is
performed is identical to what is found in merge-recursive; it's just
packaged slightly differently.

...with one exception -- the final patch in the series modifies the logic
and makes it different than merge-recursive in order to fix a known bug
(testcase 12f of t6423).

There are still four failing tests in t6423 (directory rename tests) after
this series:

 * one test (2b) where merge-ort erroneously prints a "directory rename
   split" conflict message, despite the fact that there is no new file and
   thus no need for a directory rename to be detected. This comes from the
   lack of a non_unique_new_dir field that I didn't bother copying, since
   performance work will address it in a completely different way.

 * two tests (12b1 and 12c1) where merge-ort produces the same result at
   merge-recursive (these tests are marked as test_expect_failure for
   merge-recursive). Some performance work will fix these two tests.

 * one test (12f) where merge-ort produces a better result than
   merge-recursive.c (this test is marked as test_expect_failure for
   merge-recursive), but where merge-ort does not yet manage to pass the
   final four lines of the test related to performance checking.

Elijah Newren (18):
  merge-ort: add new data structures for directory rename detection
  merge-ort: initialize and free new directory rename data structures
  merge-ort: collect which directories are removed in dirs_removed
  merge-ort: add outline for computing directory renames
  merge-ort: add outline of get_provisional_directory_renames()
  merge-ort: copy get_renamed_dir_portion() from merge-recursive.c
  merge-ort: implement compute_rename_counts()
  merge-ort: implement handle_directory_level_conflicts()
  merge-ort: modify collect_renames() for directory rename handling
  merge-ort: implement compute_collisions()
  merge-ort: implement apply_dir_rename() and check_dir_renamed()
  merge-ort: implement check_for_directory_rename()
  merge-ort: implement handle_path_level_conflicts()
  merge-ort: add a new toplevel_dir field
  merge-ort: implement apply_directory_rename_modifications()
  merge-ort: process_renames() now needs more defensiveness
  merge-ort: fix a directory rename detection bug
  DO NOT SUBMIT: directory rename stuff for redo_after_renames

 merge-ort.c | 876 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 857 insertions(+), 19 deletions(-)


base-commit: 9c85b62e817e83401855e4f2e11283be8386739e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-835%2Fnewren%2Fort-directory-renames-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-835/newren/ort-directory-renames-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/835
-- 
gitgitgadget
