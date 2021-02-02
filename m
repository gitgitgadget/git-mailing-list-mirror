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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1803BC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB95E64E9C
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhBBDMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhBBDMT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:12:19 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8BCC061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 19:11:38 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id t25so8394671otc.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x4IVUhWa4lm89gEQtsk+99IIRnhPeDfkesEYTXBJgt0=;
        b=VHaqwltBCE6bk93/D3KlaYP9BCUPbatsl3t5jrQNAPYxCNGL9bqG7AotshHhTZ+wtu
         DtnYCSl9TI0UEkvtNaaZnojXYAM38hd0VPn1gv4c/2ZN5opzY9GxTK6djwXBytVmGsP+
         z9pnCex49F98oM8+5QbdT4thvKbqho4LxlfACCGACrO7Vlw06SdVyyQ6pMEUEDDxQce4
         XaAUfae9Uvg1Nf3JtX8jSVCafhmVNdZR0YYNi+G/p8bqthHOt14nZaN9Hcf2vaHs64i6
         r+8K19xbU85rsdmWDrkGUNqBwxaxRWufUGGozgukHgnEOxCE3j0lpsPlPPYTeZnGCl+W
         dNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x4IVUhWa4lm89gEQtsk+99IIRnhPeDfkesEYTXBJgt0=;
        b=dLX+VyqtR1xJUYcgtr8GHIJg0iRoaQk1vnNvr4A6hJS31p4E0lR9S9TbeRYTXUl9VH
         s4hfWWAD7NVZJUKlfyzu03YDpwurzN8rojbWiaJ0/2xcB80ugkzL0lGqOTTl2qzOL9L/
         EU9CMEVIG8S4fr2GJ10mPn/KNlc7Jvw0CPRF+FtRWhAa9m56E3CPbb7AXetHsiXpHeh7
         W/hLIed4U1jscZsbZC07eiVqTTle7i2qgpH8uKr3NkEzs6NpK2ubhFZ2UD2S+fOlShwv
         9Fle9T2sYmteOii/fdS2UfNvfhHtxP9wi/kpMrNXk9HjBOD99dfXjlfZXWEt4//VhKvC
         QqNw==
X-Gm-Message-State: AOAM532e+a8ggqhHC+4mvzrLCLIEpTQbiVma92PH7OWD+PrvfXKCQVAQ
        hTVMxDU5GsYcHJ5nGr7l8br03qjBDRFwu6YvA8cT6CseDAM=
X-Google-Smtp-Source: ABdhPJzx+SNvIeLdV5jTh4Tvf1tkLgs4wkj6H8b3NphTTfXOz6s13W3IyTO0UsWCAtl4K+pLiAgdzEnMmvTG0dvU7Pw=
X-Received: by 2002:a9d:506:: with SMTP id 6mr13565909otw.162.1612235498189;
 Mon, 01 Feb 2021 19:11:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Feb 2021 19:11:27 -0800
Message-ID: <CABPp-BGy6Nt0b0n2=Z9Qzc+LcQtZ64R9nXqaZA8qmQBjd9gOow@mail.gmail.com>
Subject: Re: [PATCH 00/27] [RFC] Sparse Index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is based on ds/more-index-cleanups also available as GitGitGadget PR
> #839.
>
> The sparse checkout feature allows users to specify a "populated set" tha=
t
> is smaller than the full list of files at HEAD. Files outside the sparse
> checkout definition are not present in the working directory, but are sti=
ll
> present in the index (and marked with the CE_SKIP_WORKTREE bit).
>
> This means that the working directory has size O(populated), and commands
> like "git status" or "git checkout" operate using an O(populated) number =
of
> filesystem operations. However, parsing the index still operates on the
> scale of O(HEAD).
>
> This can be particularly jarring if you are merging a small repository wi=
th
> a large monorepo for the purpose of simplifying dependency management. Ev=
en
> if users have nothing more in their working directory than they had befor=
e,
> they suddenly see a significant increase in their "git status" or "git ad=
d"
> times. In these cases, simply parsing the index can be a huge portion of =
the
> command time.
>
> This RFC proposes an update to the index formats to allow "sparse directo=
ry
> entries". These entries correspond to directories that are completely
> excluded from the sparse checkout definition. We can detect that a direct=
ory
> is excluded when using "cone mode" patterns.
>
> Since having directory entries is a radical departure from the existing
> index format, a new extension "extensions.sparseIndex" is added. Using a
> sparse index should cause incompatible tools to fail because they do not
> understand this extension.
>
> The index is a critical data structure, so making such a drastic change m=
ust
> be handled carefully. This RFC does only enough adjustments to demonstrat=
e
> performance improvements for "git status" and "git add." Other commands
> should operate identically to before, since the other commands will expan=
d a
> sparse index into a full index by parsing trees.
>
> WARNING: I'm getting a failure on the FreeBSD build with my sparse-checko=
ut
> tests. I'm not sure what is causing these failures, but I will explore wh=
ile
> we discuss the possibility of the feature as a whole.
>
> Here is an outline for this RFC:
>
>  * Patches 1-14: create and test the sparse index format. This is just
>    enough to start writing the format, but all Git commands become slower
>    for using it. This is because everything is guarded to expand to a ful=
l
>    index before actually operating on the cache entries.
>
>  * Patch 15: This massive patch is actually a bunch of patches squashed
>    together. I have a branch that adds "ensure_full_index()" guards in ea=
ch
>    necessary file along with some commentary about how the index is being
>    used. This patch is presented here as one big dump because that
>    commentary isn't particularly interesting if the RFC leads to a very
>    different approach.
>
>  * Patches 16-27: These changes make enough code "sparse aware" such that
>    "git status" and "git add" start operating in time O(populated) instea=
d
>    of O(HEAD).
>
> Performance numbers are given in patch 27, but repeated somewhat here. Th=
e
> test environment I use has ~2.1 million paths at HEAD, but only 68,000
> populated paths given the sparse-checkout I'm using. The sparse index has
> about 2,000 sparse directory entries.
>
>  1. Use the full index. The index size is ~186 MB.
>  2. Use the sparse index. The index size is ~5.5 MB.
>  3. Use a commit where HEAD matches the populated set. The full index siz=
e
>     is ~5.3MB.
>
> The third benchmark is included as a theoretical optimum for a repository=
 of
> the same object database.
>
> First, a clean 'git status' improves from 3.1s to 240ms.
>
> Benchmark #1: full index (git status) Time (mean =C2=B1 =CF=83): 3.167 s =
=C2=B1 0.036 s
> [User: 2.006 s, System: 1.078 s] Range (min =E2=80=A6 max): 3.100 s =E2=
=80=A6 3.208 s 10
> runs
>
> Benchmark #2: sparse index (git status) Time (mean =C2=B1 =CF=83): 239.5 =
ms =C2=B1 8.1 ms
> [User: 189.4 ms, System: 226.8 ms] Range (min =E2=80=A6 max): 226.0 ms =
=E2=80=A6 251.9 ms 13
> runs
>
> Benchmark #3: small tree (git status) Time (mean =C2=B1 =CF=83): 195.3 ms=
 =C2=B1 4.5 ms
> [User: 116.5 ms, System: 84.4 ms] Range (min =E2=80=A6 max): 188.8 ms =E2=
=80=A6 202.8 ms 15
> runs
>
> The performance numbers for 'git add .' are much closer to optimal:
>
> Benchmark #1: full index (git add .) Time (mean =C2=B1 =CF=83): 3.076 s =
=C2=B1 0.022 s
> [User: 2.065 s, System: 0.943 s] Range (min =E2=80=A6 max): 3.044 s =E2=
=80=A6 3.116 s 10
> runs
>
> Benchmark #2: sparse index (git add .) Time (mean =C2=B1 =CF=83): 218.0 m=
s =C2=B1 6.6 ms
> [User: 195.7 ms, System: 206.6 ms] Range (min =E2=80=A6 max): 209.8 ms =
=E2=80=A6 228.2 ms 13
> runs
>
> Benchmark #3: small tree (git add .) Time (mean =C2=B1 =CF=83): 217.6 ms =
=C2=B1 5.4 ms
> [User: 131.9 ms, System: 86.7 ms] Range (min =E2=80=A6 max): 212.1 ms =E2=
=80=A6 228.4 ms 14
> runs
>
> I expect that making a sparse index work optimally through the most commo=
n
> Git commands will take a year of effort. During this process, I expect to
> add a lot of testing infrastructure around the sparse-checkout feature,
> especially in corner cases. (This RFC focuses on the happy paths of
> operating only within the sparse cone, but that will change in the future=
.)
>
> If this general approach is acceptable, then I would follow it with a
> sequence of patch submissions that follow this approach:
>
>  1. Basics of the format. (Patches 1-14)
>  2. Add additional guards around index interactions (Patch 15, but split
>     appropriately.)
>  3. Speed up "git status" and "git add" (Patches 16-27)
>
> After those three items that are represented in this RFC, the work starts=
 to
> parallelize a bit. My basic ideas for moving forward from this point are =
to
> do these basic steps:
>
>  * Add new index API abstractions where appropriate, make them sparse-awa=
re.
>  * Add new tests around sparse-checkout corner cases. Ensure the sparse
>    index works correctly.
>  * For a given builtin, add extra testing for sparse-checkouts then it th=
em
>    sparse-aware.
>
> Here are some specific questions I'm hoping to answer in this RFC period:
>
>  1. Are these sparse directory entries an appropriate way to extend the
>     index format?
>  2. Is extensions.sparseIndex a good way to signal that these entries can
>     exist?
>  3. Is git sparse-checkout init --cone --sparse-index an appropriate way =
to
>     toggle the format?
>  4. Are there specific areas that I should target to harden the index API
>     before I submit this work?
>  5. Does anyone have a good idea how to test a large portion of the test
>     suite with sparse-index enabled? The problem I see is that most tests
>     don't use sparse-checkout, so the sparse index is identical to the fu=
ll
>     index. Would it be interesting to enable the test setup to add such
>     "extra" directories during the test setup?
>
> Thanks, -Stolee

Thanks for working on this.  It's very exciting seeing this idea come
alive.  I had lots of little nitpicks and questions and whatnot here
and there, but that almost feels like a diversion.  Overall, I think
you divided up the series in a very logical and easy to follow
fashion, and actually achieved quite a bit already.

I suspect I have partially answered some of your questions above among
all my comments, and left others unanswered or worse, just re-asked
the same question(s) myself.  Feel free to ping again with the next
round and I'll see if I can dodge your questions again...er, I mean,
try to think of something helpful to say.  :-)

>
> Derrick Stolee (27):
>   sparse-index: add guard to ensure full index
>   sparse-index: implement ensure_full_index()
>   t1092: compare sparse-checkout to sparse-index
>   test-read-cache: print cache entries with --table
>   test-tool: read-cache --table --no-stat
>   test-tool: don't force full index
>   unpack-trees: ensure full index
>   sparse-checkout: hold pattern list in index
>   sparse-index: convert from full to sparse
>   submodule: sparse-index should not collapse links
>   unpack-trees: allow sparse directories
>   sparse-index: check index conversion happens
>   sparse-index: create extension for compatibility
>   sparse-checkout: toggle sparse index from builtin
>   [RFC-VERSION] *: ensure full index
>   unpack-trees: make sparse aware
>   dir.c: accept a directory as part of cone-mode patterns
>   status: use sparse-index throughout
>   status: skip sparse-checkout percentage with sparse-index
>   sparse-index: expand_to_path() trivial implementation
>   sparse-index: expand_to_path no-op if path exists
>   add: allow operating on a sparse-only index
>   submodule: die_path_inside_submodule is sparse aware
>   dir: use expand_to_path in add_patterns()
>   fsmonitor: disable if index is sparse
>   pathspec: stop calling ensure_full_index
>   cache-tree: integrate with sparse directory entries
>
>  Documentation/config/extensions.txt      |   7 +
>  Documentation/git-sparse-checkout.txt    |  14 +
>  Makefile                                 |   1 +
>  apply.c                                  |  10 +-
>  blame.c                                  |   7 +-
>  builtin/add.c                            |   3 +
>  builtin/checkout-index.c                 |   5 +-
>  builtin/commit.c                         |   3 +
>  builtin/grep.c                           |   2 +
>  builtin/ls-files.c                       |   9 +-
>  builtin/merge-index.c                    |   2 +
>  builtin/mv.c                             |   2 +
>  builtin/rm.c                             |   2 +
>  builtin/sparse-checkout.c                |  35 ++-
>  builtin/update-index.c                   |   2 +
>  cache-tree.c                             |  21 ++
>  cache.h                                  |  15 +-
>  diff.c                                   |   2 +
>  dir.c                                    |  19 +-
>  dir.h                                    |   2 +-
>  entry.c                                  |   2 +
>  fsmonitor.c                              |  18 +-
>  merge-recursive.c                        |  22 +-
>  name-hash.c                              |  10 +
>  pathspec.c                               |   4 +-
>  pathspec.h                               |   4 +-
>  preload-index.c                          |   2 +
>  read-cache.c                             |  51 +++-
>  repo-settings.c                          |  15 +
>  repository.c                             |  11 +-
>  repository.h                             |   3 +
>  rerere.c                                 |   2 +
>  resolve-undo.c                           |   6 +
>  setup.c                                  |   3 +
>  sha1-name.c                              |   3 +
>  sparse-index.c                           | 360 +++++++++++++++++++++++
>  sparse-index.h                           |  23 ++
>  split-index.c                            |   2 +
>  submodule.c                              |  22 +-
>  submodule.h                              |   6 +-
>  t/helper/test-read-cache.c               |  77 ++++-
>  t/t1092-sparse-checkout-compatibility.sh | 130 +++++++-
>  tree.c                                   |   2 +
>  unpack-trees.c                           |  40 ++-
>  wt-status.c                              |  21 +-
>  wt-status.h                              |   1 +
>  46 files changed, 942 insertions(+), 61 deletions(-)
>  create mode 100644 sparse-index.c
>  create mode 100644 sparse-index.h
>
>
> base-commit: 2271fe7848aa11b30e5313d95d9caebc2937fce5
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-847%2Fd=
errickstolee%2Fsparse-index%2Frfc-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-847/derric=
kstolee/sparse-index/rfc-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/847
> --
> gitgitgadget
