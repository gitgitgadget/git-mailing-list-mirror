Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232BAC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94DD22D04
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbhAYRwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbhAYRuH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:50:07 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E73C061786
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:17 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 7so13821680wrz.0
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=oMYmsE6liYqvPmUIvSIAEMo4O7BSg6tfnMXwWnnyvag=;
        b=RdUMTYQOFBr5MZFvoAa+SopahZBUdhVTLHAe8BXJdJna+u+UB4/MH86lcn/qbtDQQ9
         IvI2Ykst+3GlFyynLBFFcqtgpWXIH+qaFTk0KQElu2cIDiRUeRcfNA8xltU2fmf/koBY
         K2YooFEZtqmMTP77RaC7et1jOYKn2p4a/rWJjwBHs3CnLLdkVGxdn39xXgNPSd9vN7W1
         mbRKqocRArA+kLzcpcE8z7TCmf5dUT7fs7KKHFPZE1xFxYf7YmrfUJPuN+4UPZNBF035
         2PF7RPZhjaIcTlrLh6X++HygHg0vcomeLna1NMcMnZYa71QGAXYvPMik8FV6fpFLbtOB
         JYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=oMYmsE6liYqvPmUIvSIAEMo4O7BSg6tfnMXwWnnyvag=;
        b=FAJpLDsdLqN8b4k+ChC4F47bGA8K8wry4TpNXT3U7uSQhEdHKd0Ngybe2n0QFGknC8
         rQkxKlwx3JMDf7oUrJNNzcqQiFEw/J1GvIwnyPig+a925vmJGFEljugzY0e8CixAN0pt
         YePu1vIsNIweG4Ii0r239PUlA7SfxENbXdDFzpLHzbiNAfaHnmaab9qmqloJxik9gvMQ
         XIFL5e99xdwOiOcyjRNliwR1TSEjBi/P05MFEysfAq38z/sWGEAWiRF1mvLpVQVr6081
         L30Ln08OsVTqYd7MY2D0anbonfPoqrOoAeL1w/EhClSBUA52wflkGRsGYDgtVUQmlff+
         LFLg==
X-Gm-Message-State: AOAM530gOtobIso/gbVW23U7m/a9N0M19oQosxOLWua1vt1VUCeoPOYm
        t5fUExWoH9ZlQNDCRS51co0BakWZkq0=
X-Google-Smtp-Source: ABdhPJwDd/m9GShKpfIQJUtk7mwyOl6LeAH8EUVbfuArRGz+yGqT5DoVIs3Elck3DWttQqj/gsNXgQ==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr2303425wrd.118.1611596535848;
        Mon, 25 Jan 2021 09:42:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm13621wmc.31.2021.01.25.09.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:15 -0800 (PST)
Message-Id: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:41:46 +0000
Subject: [PATCH 00/27] [RFC] Sparse Index
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ds/more-index-cleanups also available as GitGitGadget PR
#839.

The sparse checkout feature allows users to specify a "populated set" that
is smaller than the full list of files at HEAD. Files outside the sparse
checkout definition are not present in the working directory, but are still
present in the index (and marked with the CE_SKIP_WORKTREE bit).

This means that the working directory has size O(populated), and commands
like "git status" or "git checkout" operate using an O(populated) number of
filesystem operations. However, parsing the index still operates on the
scale of O(HEAD).

This can be particularly jarring if you are merging a small repository with
a large monorepo for the purpose of simplifying dependency management. Even
if users have nothing more in their working directory than they had before,
they suddenly see a significant increase in their "git status" or "git add"
times. In these cases, simply parsing the index can be a huge portion of the
command time.

This RFC proposes an update to the index formats to allow "sparse directory
entries". These entries correspond to directories that are completely
excluded from the sparse checkout definition. We can detect that a directory
is excluded when using "cone mode" patterns.

Since having directory entries is a radical departure from the existing
index format, a new extension "extensions.sparseIndex" is added. Using a
sparse index should cause incompatible tools to fail because they do not
understand this extension.

The index is a critical data structure, so making such a drastic change must
be handled carefully. This RFC does only enough adjustments to demonstrate
performance improvements for "git status" and "git add." Other commands
should operate identically to before, since the other commands will expand a
sparse index into a full index by parsing trees.

WARNING: I'm getting a failure on the FreeBSD build with my sparse-checkout
tests. I'm not sure what is causing these failures, but I will explore while
we discuss the possibility of the feature as a whole.

Here is an outline for this RFC:

 * Patches 1-14: create and test the sparse index format. This is just
   enough to start writing the format, but all Git commands become slower
   for using it. This is because everything is guarded to expand to a full
   index before actually operating on the cache entries.

 * Patch 15: This massive patch is actually a bunch of patches squashed
   together. I have a branch that adds "ensure_full_index()" guards in each
   necessary file along with some commentary about how the index is being
   used. This patch is presented here as one big dump because that
   commentary isn't particularly interesting if the RFC leads to a very
   different approach.

 * Patches 16-27: These changes make enough code "sparse aware" such that
   "git status" and "git add" start operating in time O(populated) instead
   of O(HEAD).

Performance numbers are given in patch 27, but repeated somewhat here. The
test environment I use has ~2.1 million paths at HEAD, but only 68,000
populated paths given the sparse-checkout I'm using. The sparse index has
about 2,000 sparse directory entries.

 1. Use the full index. The index size is ~186 MB.
 2. Use the sparse index. The index size is ~5.5 MB.
 3. Use a commit where HEAD matches the populated set. The full index size
    is ~5.3MB.

The third benchmark is included as a theoretical optimum for a repository of
the same object database.

First, a clean 'git status' improves from 3.1s to 240ms.

Benchmark #1: full index (git status) Time (mean ± σ): 3.167 s ± 0.036 s
[User: 2.006 s, System: 1.078 s] Range (min … max): 3.100 s … 3.208 s 10
runs

Benchmark #2: sparse index (git status) Time (mean ± σ): 239.5 ms ± 8.1 ms
[User: 189.4 ms, System: 226.8 ms] Range (min … max): 226.0 ms … 251.9 ms 13
runs

Benchmark #3: small tree (git status) Time (mean ± σ): 195.3 ms ± 4.5 ms
[User: 116.5 ms, System: 84.4 ms] Range (min … max): 188.8 ms … 202.8 ms 15
runs

The performance numbers for 'git add .' are much closer to optimal:

Benchmark #1: full index (git add .) Time (mean ± σ): 3.076 s ± 0.022 s
[User: 2.065 s, System: 0.943 s] Range (min … max): 3.044 s … 3.116 s 10
runs

Benchmark #2: sparse index (git add .) Time (mean ± σ): 218.0 ms ± 6.6 ms
[User: 195.7 ms, System: 206.6 ms] Range (min … max): 209.8 ms … 228.2 ms 13
runs

Benchmark #3: small tree (git add .) Time (mean ± σ): 217.6 ms ± 5.4 ms
[User: 131.9 ms, System: 86.7 ms] Range (min … max): 212.1 ms … 228.4 ms 14
runs

I expect that making a sparse index work optimally through the most common
Git commands will take a year of effort. During this process, I expect to
add a lot of testing infrastructure around the sparse-checkout feature,
especially in corner cases. (This RFC focuses on the happy paths of
operating only within the sparse cone, but that will change in the future.)

If this general approach is acceptable, then I would follow it with a
sequence of patch submissions that follow this approach:

 1. Basics of the format. (Patches 1-14)
 2. Add additional guards around index interactions (Patch 15, but split
    appropriately.)
 3. Speed up "git status" and "git add" (Patches 16-27)

After those three items that are represented in this RFC, the work starts to
parallelize a bit. My basic ideas for moving forward from this point are to
do these basic steps:

 * Add new index API abstractions where appropriate, make them sparse-aware.
 * Add new tests around sparse-checkout corner cases. Ensure the sparse
   index works correctly.
 * For a given builtin, add extra testing for sparse-checkouts then it them
   sparse-aware.

Here are some specific questions I'm hoping to answer in this RFC period:

 1. Are these sparse directory entries an appropriate way to extend the
    index format?
 2. Is extensions.sparseIndex a good way to signal that these entries can
    exist?
 3. Is git sparse-checkout init --cone --sparse-index an appropriate way to
    toggle the format?
 4. Are there specific areas that I should target to harden the index API
    before I submit this work?
 5. Does anyone have a good idea how to test a large portion of the test
    suite with sparse-index enabled? The problem I see is that most tests
    don't use sparse-checkout, so the sparse index is identical to the full
    index. Would it be interesting to enable the test setup to add such
    "extra" directories during the test setup?

Thanks, -Stolee

Derrick Stolee (27):
  sparse-index: add guard to ensure full index
  sparse-index: implement ensure_full_index()
  t1092: compare sparse-checkout to sparse-index
  test-read-cache: print cache entries with --table
  test-tool: read-cache --table --no-stat
  test-tool: don't force full index
  unpack-trees: ensure full index
  sparse-checkout: hold pattern list in index
  sparse-index: convert from full to sparse
  submodule: sparse-index should not collapse links
  unpack-trees: allow sparse directories
  sparse-index: check index conversion happens
  sparse-index: create extension for compatibility
  sparse-checkout: toggle sparse index from builtin
  [RFC-VERSION] *: ensure full index
  unpack-trees: make sparse aware
  dir.c: accept a directory as part of cone-mode patterns
  status: use sparse-index throughout
  status: skip sparse-checkout percentage with sparse-index
  sparse-index: expand_to_path() trivial implementation
  sparse-index: expand_to_path no-op if path exists
  add: allow operating on a sparse-only index
  submodule: die_path_inside_submodule is sparse aware
  dir: use expand_to_path in add_patterns()
  fsmonitor: disable if index is sparse
  pathspec: stop calling ensure_full_index
  cache-tree: integrate with sparse directory entries

 Documentation/config/extensions.txt      |   7 +
 Documentation/git-sparse-checkout.txt    |  14 +
 Makefile                                 |   1 +
 apply.c                                  |  10 +-
 blame.c                                  |   7 +-
 builtin/add.c                            |   3 +
 builtin/checkout-index.c                 |   5 +-
 builtin/commit.c                         |   3 +
 builtin/grep.c                           |   2 +
 builtin/ls-files.c                       |   9 +-
 builtin/merge-index.c                    |   2 +
 builtin/mv.c                             |   2 +
 builtin/rm.c                             |   2 +
 builtin/sparse-checkout.c                |  35 ++-
 builtin/update-index.c                   |   2 +
 cache-tree.c                             |  21 ++
 cache.h                                  |  15 +-
 diff.c                                   |   2 +
 dir.c                                    |  19 +-
 dir.h                                    |   2 +-
 entry.c                                  |   2 +
 fsmonitor.c                              |  18 +-
 merge-recursive.c                        |  22 +-
 name-hash.c                              |  10 +
 pathspec.c                               |   4 +-
 pathspec.h                               |   4 +-
 preload-index.c                          |   2 +
 read-cache.c                             |  51 +++-
 repo-settings.c                          |  15 +
 repository.c                             |  11 +-
 repository.h                             |   3 +
 rerere.c                                 |   2 +
 resolve-undo.c                           |   6 +
 setup.c                                  |   3 +
 sha1-name.c                              |   3 +
 sparse-index.c                           | 360 +++++++++++++++++++++++
 sparse-index.h                           |  23 ++
 split-index.c                            |   2 +
 submodule.c                              |  22 +-
 submodule.h                              |   6 +-
 t/helper/test-read-cache.c               |  77 ++++-
 t/t1092-sparse-checkout-compatibility.sh | 130 +++++++-
 tree.c                                   |   2 +
 unpack-trees.c                           |  40 ++-
 wt-status.c                              |  21 +-
 wt-status.h                              |   1 +
 46 files changed, 942 insertions(+), 61 deletions(-)
 create mode 100644 sparse-index.c
 create mode 100644 sparse-index.h


base-commit: 2271fe7848aa11b30e5313d95d9caebc2937fce5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-847%2Fderrickstolee%2Fsparse-index%2Frfc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-847/derrickstolee/sparse-index/rfc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/847
-- 
gitgitgadget
