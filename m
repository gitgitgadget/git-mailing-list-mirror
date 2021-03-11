Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BC0C43381
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5483F64FCA
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhCKAIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhCKAHq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:07:46 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF48FC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:07:45 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id p24so4380687ota.11
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DOYL4SkwsEq5++appFYaUjVa7yks63jIfkcipfEjBE=;
        b=jLCB69U96de/K5A+Z3kddpvL9qMKOxOnykncGA27M5GDvR9fCykFf8MGOiPyK7+//C
         dLXNDm3I/6BwvFTKnSvbN9uQ8UkzFUkOv/a0AToJInN4/IBUSLoZUmlrnCzhRal1KoA2
         uSZXoZIMtTGpi4sLQPFB2vbqjWHAf6htj1dFWR2zXV04VFF2x6AQv6/Hpjann55yC42v
         FLcFi8+VUJOYejHFRqDqhYYAXMTxwKWwtI2M/n6WVxH/YgywJQlIy0kRKGP5n/eS0kjN
         /owWTWxPa4b6jCFvF1tPvTvIj29jIVLBqVzQSuG0/h6N6JiVn46tgkHSm9AperBFrnVd
         Z7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DOYL4SkwsEq5++appFYaUjVa7yks63jIfkcipfEjBE=;
        b=mGrjLubTKX7f4XB4oRgDXndnknU8K5+mrCtK9hlKz+6+VWNqerSHnh/AdX8vwfqIHz
         dWBR9oCjksCltKvcrWc/DvWF5nvjXP2qh7tiK8foHFMs51GrSqVvH2JA/45xKlRM+4UA
         VNygnmQSNKJBQanGNGFalpK/WOVzMddzf2DlpxJm/lNwgC+JiM2i69O9xttASIFoIA4C
         2I+vvaBRvWBCUdH5tBbmydx09GgYxYmD0jQF5tAeVIXWItRyd8Jstn2lUr8O12EnRXbw
         c77D/VK8O3JclmA6pK9SVZoh97+S0+82V2TFtDZbHsLT5AFTale5n71HZgaTU5ZQirTT
         XsuQ==
X-Gm-Message-State: AOAM532DMbJGSqtduyoEPdQa6YDMbwJ5nLKceifCzsMlDEwoXirAjK71
        PLVwdgEEbBN37jCxLmbFndbuRm1cqboVNHoC454=
X-Google-Smtp-Source: ABdhPJwy8gcFMA1DzefBHMHRVMrODzUE28/IoBAosOJuACIyMzOs8wMNm/Aja2WHPwkefk5r/fPMjgbJdvMt1o9R128=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr4587508otf.345.1615421265079;
 Wed, 10 Mar 2021 16:07:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com> <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Mar 2021 16:07:34 -0800
Message-ID: <CABPp-BGkr5D8bBgeeFob=j3p01_nJzUaQXDD=EGriUJ6XNX+Rw@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] Sparse Index: Design, Format, Tests
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Here is the first full patch series submission coming out of the
> sparse-index RFC [1].
>
> [1]
> https://lore.kernel.org/git/pull.847.git.1611596533.gitgitgadget@gmail.com/
>
> I won't waste too much space here, because PATCH 1 includes a sizeable
> design document that describes the feature, the reasoning behind it, and my
> plan for getting this implemented widely throughout the codebase.
>
> There are some new things here that were not in the RFC:
>
>  * Design doc and format updates. (Patch 1)
>  * Performance test script. (Patches 2 and 20)
>
> Notably missing in this series from the RFC:
>
>  * The mega-patch inserting ensure_full_index() throughout the codebase.
>    That will be a follow-up series to this one.
>  * The integrations with git status and git add to demonstrate the improved
>    performance. Those will also appear in their own series later.
>
> I plan to keep my latest work in this area in my 'sparse-index/wip' branch
> [2]. It includes all of the work from the RFC right now, updated with the
> work from this series.
>
> [2] https://github.com/derrickstolee/git/tree/sparse-index/wip
>
>
> Updates in V2
> =============
>
>  * Various typos and awkward grammar is fixed.
>  * Cleaned up unnecessary commands in p2000-sparse-operations.sh
>  * Added a comment to the sparse_index member of struct index_state.
>  * Used tree_type, commit_type, and blob_type in test-read-cache.c.

I read through the range-diff and comments from the previous series.
There's only a few things left (as I noted in comments), but they're
all pretty trivial so this one is:

Reviewed-by: Elijah Newren <newren@gmail.com>

>
> Thanks, -Stolee
>
> Derrick Stolee (20):
>   sparse-index: design doc and format update
>   t/perf: add performance test for sparse operations
>   t1092: clean up script quoting
>   sparse-index: add guard to ensure full index
>   sparse-index: implement ensure_full_index()
>   t1092: compare sparse-checkout to sparse-index
>   test-read-cache: print cache entries with --table
>   test-tool: don't force full index
>   unpack-trees: ensure full index
>   sparse-checkout: hold pattern list in index
>   sparse-index: convert from full to sparse
>   submodule: sparse-index should not collapse links
>   unpack-trees: allow sparse directories
>   sparse-index: check index conversion happens
>   sparse-index: create extension for compatibility
>   sparse-checkout: toggle sparse index from builtin
>   sparse-checkout: disable sparse-index
>   cache-tree: integrate with sparse directory entries
>   sparse-index: loose integration with cache_tree_verify()
>   p2000: add sparse-index repos
>
>  Documentation/config/extensions.txt      |   8 +
>  Documentation/git-sparse-checkout.txt    |  14 ++
>  Documentation/technical/index-format.txt |   7 +
>  Documentation/technical/sparse-index.txt | 173 ++++++++++++++
>  Makefile                                 |   1 +
>  builtin/sparse-checkout.c                |  44 +++-
>  cache-tree.c                             |  40 ++++
>  cache.h                                  |  18 +-
>  read-cache.c                             |  35 ++-
>  repo-settings.c                          |  15 ++
>  repository.c                             |  11 +-
>  repository.h                             |   3 +
>  setup.c                                  |   3 +
>  sparse-index.c                           | 290 +++++++++++++++++++++++
>  sparse-index.h                           |  11 +
>  t/README                                 |   3 +
>  t/helper/test-read-cache.c               |  66 +++++-
>  t/perf/p2000-sparse-operations.sh        | 102 ++++++++
>  t/t1091-sparse-checkout-builtin.sh       |  13 +
>  t/t1092-sparse-checkout-compatibility.sh | 136 +++++++++--
>  unpack-trees.c                           |  16 +-
>  21 files changed, 969 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/technical/sparse-index.txt
>  create mode 100644 sparse-index.c
>  create mode 100644 sparse-index.h
>  create mode 100755 t/perf/p2000-sparse-operations.sh
>
>
> base-commit: 966e671106b2fd38301e7c344c754fd118d0bb07
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-883%2Fderrickstolee%2Fsparse-index%2Fformat-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-883/derrickstolee/sparse-index/format-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/883
>
> Range-diff vs v1:
>
>   1:  daa9a6bcefbc !  1:  2fe413fdac80 sparse-index: design doc and format update
>      @@ Documentation/technical/sparse-index.txt (new)
>       +If we need to discover the details for paths within that directory, we
>       +can parse trees to find that list.
>       +
>      -+This addition of sparse-directory entries violates expectations about the
>      ++At time of writing, sparse-directory entries violate expectations about the
>       +index format and its in-memory data structure. There are many consumers in
>       +the codebase that expect to iterate through all of the index entries and
>       +see only files. In addition, they expect to see all files at `HEAD`. One
>      @@ Documentation/technical/sparse-index.txt (new)
>       +* `git merge`
>       +* `git rebase`
>       +
>      ++Hopefully, commands such as `git merge` and `git rebase` can benefit
>      ++instead from merge algorithms that do not use the index as a data
>      ++structure, such as the merge-ORT strategy. As these topics mature, we
>      ++may enalbe the ORT strategy by default for repositories using the
>      ++sparse-index feature.
>      ++
>       +Along with `git status` and `git add`, these commands cover the majority
>       +of users' interactions with the working directory. In addition, we can
>       +integrate with these commands:
>   2:  a8c6322a3dbe !  2:  540ab5495065 t/perf: add performance test for sparse operations
>      @@ t/perf/p2000-sparse-operations.sh (new)
>       + # Remove submodules from the example repo, because our
>       + # duplication of the entire repo creates an unlikly data shape.
>       + git config --file .gitmodules --get-regexp "submodule.*.path" >modules &&
>      -+ rm -f .gitmodules &&
>      -+ git add .gitmodules &&
>      ++ git rm -f .gitmodules &&
>       + for module in $(awk "{print \$2}" modules)
>       + do
>       +         git rm $module || return 1
>       + done &&
>      -+ git add . &&
>       + git commit -m "remove submodules" &&
>       +
>       + echo bogus >a &&
>   3:  6e783c88821e =  3:  5cbedb377b37 t1092: clean up script quoting
>   4:  01da4c48a1fa =  4:  6e21f776e883 sparse-index: add guard to ensure full index
>   5:  2b83989fbcd3 !  5:  399ddb0bad56 sparse-index: implement ensure_full_index()
>      @@ cache.h: struct index_state {
>                  updated_skipworktree : 1,
>       -          fsmonitor_has_run_once : 1;
>       +          fsmonitor_has_run_once : 1,
>      ++
>      ++          /*
>      ++           * sparse_index == 1 when sparse-directory
>      ++           * entries exist. Requires sparse-checkout
>      ++           * in cone mode.
>      ++           */
>       +          sparse_index : 1;
>         struct hashmap name_hash;
>         struct hashmap dir_hash;
>   6:  c9910a37579c =  6:  eac2db5efc22 t1092: compare sparse-checkout to sparse-index
>   7:  3d92df7a0cf9 !  7:  e9c82d2eda82 test-read-cache: print cache entries with --table
>      @@ Commit message
>
>        ## t/helper/test-read-cache.c ##
>       @@
>      + #include "test-tool.h"
>        #include "cache.h"
>        #include "config.h"
>      -
>      ++#include "blob.h"
>      ++#include "commit.h"
>      ++#include "tree.h"
>      ++
>       +static void print_cache_entry(struct cache_entry *ce)
>       +{
>      -+ printf("%06o ", ce->ce_mode & 0777777);
>      ++ const char *type;
>      ++ printf("%06o ", ce->ce_mode & 0177777);
>       +
>       + if (S_ISSPARSEDIR(ce->ce_mode))
>      -+         printf("tree ");
>      ++         type = tree_type;
>       + else if (S_ISGITLINK(ce->ce_mode))
>      -+         printf("commit ");
>      ++         type = commit_type;
>       + else
>      -+         printf("blob ");
>      ++         type = blob_type;
>       +
>      -+ printf("%s\t%s\n",
>      ++ printf("%s %s\t%s\n",
>      ++        type,
>       +        oid_to_hex(&ce->oid),
>       +        ce->name);
>       +}
>       +
>      -+static void print_cache(struct index_state *cache)
>      ++static void print_cache(struct index_state *istate)
>       +{
>       + int i;
>      -+ for (i = 0; i < the_index.cache_nr; i++)
>      -+         print_cache_entry(the_index.cache[i]);
>      ++ for (i = 0; i < istate->cache_nr; i++)
>      ++         print_cache_entry(istate->cache[i]);
>       +}
>      -+
>      +
>        int cmd__read_cache(int argc, const char **argv)
>        {
>       + struct repository *r = the_repository;
>   8:  94373e2bfbbc !  8:  243541fc5820 test-tool: don't force full index
>      @@ Commit message
>
>        ## t/helper/test-read-cache.c ##
>       @@
>      - #include "test-tool.h"
>      - #include "cache.h"
>      - #include "config.h"
>      + #include "blob.h"
>      + #include "commit.h"
>      + #include "tree.h"
>       +#include "sparse-index.h"
>
>        static void print_cache_entry(struct cache_entry *ce)
>   9:  e71f033c2871 =  9:  48f65093b3da unpack-trees: ensure full index
>  10:  f86d3dc154d1 ! 10:  83aac8b7a1ec sparse-checkout: hold pattern list in index
>      @@ Commit message
>           pattern set, we need access to that in-memory copy. Place a pointer to
>           a 'struct pattern_list' in the index so we can access this on-demand.
>           This will be used in the next change which uses the sparse-checkout
>      -    definition to filter out directories that are outsie the sparse cone.
>      +    definition to filter out directories that are outside the sparse cone.
>
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>  11:  a2d77c23a0cb ! 11:  f6db0c27a285 sparse-index: convert from full to sparse
>      @@ read-cache.c: int verify_path(const char *path, unsigned mode)
>                                 return 0;
>       +                 /*
>       +                  * allow terminating directory separators for
>      -+                  * sparse directory enries.
>      ++                  * sparse directory entries.
>       +                  */
>       +                 if (c == '\0')
>       +                         return S_ISDIR(mode);
>      @@ sparse-index.c
>       +         struct cache_entry *ce = istate->cache[i];
>       +
>       +         /*
>      -+          * Detect if this is a normal entry oustide of any subtree
>      ++          * Detect if this is a normal entry outside of any subtree
>       +          * entry.
>       +          */
>       +         base = ce->name + ct_pathlen;
>  12:  4405a9115c3b = 12:  f2a3e7298798 submodule: sparse-index should not collapse links
>  13:  fda23f07e6a2 ! 13:  6f1ebe6ccc08 unpack-trees: allow sparse directories
>      @@ Commit message
>           is possible to have a directory in a sparse index as long as that entry
>           is itself marked with the skip-worktree bit.
>
>      -    The negation of the 'pos' variable must be conditioned to only when it
>      -    starts as negative. This is identical behavior as before when the index
>      -    is full.
>      +    The 'pos' variable is assigned a negative value if an exact match is not
>      +    found. Since a directory name can be an exact match, it is no longer an
>      +    error to have a nonnegative 'pos' value.
>
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>  14:  7d4627574bb8 = 14:  3fa684b315fb sparse-index: check index conversion happens
>  15:  564503f78784 ! 15:  d74576d677f6 sparse-index: create extension for compatibility
>      @@ Commit message
>
>           We _could_ add a new index version that explicitly adds these
>           capabilities, but there are nuances to index formats 2, 3, and 4 that
>      -    are still valuable to select as options. For now, create a repo
>      -    extension, "extensions.sparseIndex", that specifies that the tool
>      -    reading this repository must understand sparse directory entries.
>      +    are still valuable to select as options. Until we add index format
>      +    version 5, create a repo extension, "extensions.sparseIndex", that
>      +    specifies that the tool reading this repository must understand sparse
>      +    directory entries.
>
>           This change only encodes the extension and enables it when
>           GIT_TEST_SPARSE_INDEX=1. Later, we will add a more user-friendly CLI
>      @@ Documentation/config/extensions.txt: extensions.objectFormat::
>       + When combined with `core.sparseCheckout=true` and
>       + `core.sparseCheckoutCone=true`, the index may contain entries
>       + corresponding to directories outside of the sparse-checkout
>      -+ definition. Versions of Git that do not understand this extension
>      -+ do not expect directory entries in the index.
>      ++ definition in lieu of containing each path under such directories.
>      ++ Versions of Git that do not understand this extension do not
>      ++ expect directory entries in the index.
>
>        ## cache.h ##
>       @@ cache.h: struct repository_format {
>  16:  6d6b230e3318 ! 16:  e530ca5f668d sparse-checkout: toggle sparse index from builtin
>      @@ Documentation/git-sparse-checkout.txt: To avoid interfering with other worktrees
>       +a sparse index until they are properly integrated with the feature.
>       ++
>       +**WARNING:** Using a sparse index requires modifying the index in a way
>      -+that is not completely understood by other tools. Enabling sparse index
>      -+enables the `extensions.spareseIndex` config value, which might cause
>      -+other tools to stop working with your repository. If you have trouble with
>      -+this compatibility, then run `git sparse-checkout sparse-index disable` to
>      -+remove this config and rewrite your index to not be sparse.
>      ++that is not completely understood by external tools. If you have trouble
>      ++with this compatibility, then run `git sparse-checkout sparse-index disable`
>      ++to rewrite your index to not be sparse. Older versions of Git will not
>      ++understand the `sparseIndex` repository extension and may fail to interact
>      ++with your repository until it is disabled.
>
>        'set'::
>         Write a set of patterns to the sparse-checkout file, as given as
>  17:  bcf960ef2362 = 17:  42d0da9c5def sparse-checkout: disable sparse-index
>  18:  e6afec58674e = 18:  6bb0976a6295 cache-tree: integrate with sparse directory entries
>  19:  2be4981fe698 = 19:  07f34e80609a sparse-index: loose integration with cache_tree_verify()
>  20:  a738b0ba8ab4 = 20:  41e3b56b9c17 p2000: add sparse-index repos
>
> --
> gitgitgadget
