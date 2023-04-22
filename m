Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDE9C77B78
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDVUR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDVURm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0A11BEB
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f086770a50so19370605e9.2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194656; x=1684786656;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLt7ZAyp4lGqSOzwltktMTXUOSW55vWpzzOMscqSYo4=;
        b=i2gLZD9h63p1lo9zMceH8kejhG+TSQTmJ6UYL4Y6ZHI+WH8kqF2X4jJkDD/pTsG5g0
         G5Yz4e/CytnPOm9duoxFv3fEFOtL+/ro6Bf/O5ik+dTMflnskXkb1fnQii2imZfRaZ0t
         c8gbGVEcCpYBY3qb7pBcLainDWgVmCw4WBU1gygEULZj1OZQdE1V4W6fAaNq+tDH2Dqy
         3nZowJ4fplpnyFGPStFj5N1NvSY3J7UymYzBUuuUwQi8JxNwXDWEWMSx41A5TcrLXGE2
         +dO1K8e0hxmGC0l/Gvg3VuiQI3Xcy1g9xnZikpE1v5MsuEYC3kPZDtYPh5TzgVgJXNu4
         LrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194656; x=1684786656;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLt7ZAyp4lGqSOzwltktMTXUOSW55vWpzzOMscqSYo4=;
        b=kwm4V0Ew7a7vUJPm/SAuxPIttXm6FS7lE4zlV1eB6sXW8fwK3lDvP2BrtPEn+9AXJk
         eGYttwNxdyZff37xuvvyylTuwfJyKQOzvrhJbRu8NBzPgaY2SuWGQfBurJl5qrQUeUmz
         0h1kLrzS/uTMIweNTpCMZ0VDP4em1WT2+t4cmkDnLnaz9VU4azmymWF+ipiI0njHp7wF
         AhiqTTR3PLyQp/h2+b9MVtwwLumMIfwwKG6NV0S4CteY8+P5GWKezO2yBCFPfY78ZCfi
         +AFogJjYSCs4T0AkZkAeuj0IRtHNc5Whbku7Nms/7l+YgzOwx1FKAmAeruFjCbxq718S
         DMwA==
X-Gm-Message-State: AAQBX9eKdEW68kw1TEj3532LkT8bJNjWDZKlQL6gmahpKK4CGDWBaAgC
        +jfKyi956M8wIBrwLMNlFvoYBv6uvzA=
X-Google-Smtp-Source: AKy350ZJrJ3V6NdJAle4AbeQSu+TbdEcmHe73tJ/ki00YAnVdVNPnT4vJdVFXp84sVrRYUVKlEjihQ==
X-Received: by 2002:a7b:cb8a:0:b0:3ee:1acd:b039 with SMTP id m10-20020a7bcb8a000000b003ee1acdb039mr4644081wmi.34.1682194654984;
        Sat, 22 Apr 2023 13:17:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c378300b003ef5f77901dsm7983906wmr.45.2023.04.22.13.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:34 -0700 (PDT)
Message-Id: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:07 +0000
Subject: [PATCH v2 00/22] Header cleanups (more splitting of cache.h and simplifying a few other deps)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

 * dropped the 3rd patch (it was pulled into the series this one depends
   upon to fix an issue in it)
 * redid the old patch 14 (new patch 13); moved the parts of hash.h not
   depending on repository.h into hash-ll.h so that other headers and files
   could depend upon just that part. (Are people happy with the hash-ll.h
   name or have alternate suggestions?)

Maintainer notes: (1) This series is based on en/header-split-cache-h (now
in next). (2) Although I've tweaked the series to minimize conflicts, there
is a semantic conflict with sl/sparse-write-tree in next; to resolve, add an
include of repository.h in builtin/write-tree.c.

This series continues to focus on splitting declarations from cache.h to
separate headers. This series also untangles some dependencies between
hash.h and repository.h, and between read-cache.c and tree.[ch], and cleans
up a few other headers. At the end of this series the number of cache.h
includes drops from 189 down to 149.

The series may appear to be long at first glance, but is filled with mostly
repetitive and simple changes similar to those from earlier series. An
overview:

 * Patch 1: files depending on strbuf.h should be explicit about it
 * Patches 2-13: move stuff out of cache.h into other more logical headers
 * Patch 14-16: move functions between hash<->repository and
   read-cache<->tree to simplify dependencies
 * Patch 17: remove includes of cache.h permitted by the previous 16 patches
 * Patches 18-22: clean up now-unnecessary includes in other headers
 * Patch 23: start enforcing git-compat-util.h is first include for reftable
   files as well.

And thanks once again to Dscho for gitgitgadget. Getting multiple platform
testing + all the special tests (sparse, cocci, hdr-check, etc.) really
helps clean out all the issues that would otherwise hit a series like this.

Elijah Newren (22):
  treewide: be explicit about dependence on strbuf.h
  symlinks.h: move declarations for symlinks.c functions from cache.h
  packfile.h: move pack_window and pack_entry from cache.h
  server-info.h: move declarations for server-info.c functions from
    cache.h
  copy.h: move declarations for copy.c functions from cache.h
  base85.h: move declarations for base85.c functions from cache.h
  pkt-line.h: move declarations for pkt-line.c functions from cache.h
  match-trees.h: move declarations for match-trees.c functions from
    cache.h
  ws.h: move declarations for ws.c functions from cache.h
  versioncmp.h: move declarations for versioncmp.c functions from
    cache.h
  dir.h: move DTYPE defines from cache.h
  tree-diff.c: move S_DIFFTREE_IFXMIN_NEQ define from cache.h
  hash-ll.h: split out of hash.h to remove dependency on repository.h
  cache,tree: move cmp_cache_name_compare from tree.[ch] to read-cache.c
  cache,tree: move basic name compare functions from read-cache to tree
  treewide: remove cache.h inclusion due to previous changes
  cache.h: remove unnecessary headers
  fsmonitor: reduce includes of cache.h
  commit.h: reduce unnecessary includes
  object-store.h: reduce unnecessary includes
  diff.h: reduce unnecessary includes
  reftable: ensure git-compat-util.h is the first (indirect) include

 add-interactive.c                            |   1 +
 alloc.c                                      |   1 +
 apply.c                                      |   3 +
 apply.h                                      |   2 +-
 archive-zip.c                                |   2 +-
 archive.c                                    |   2 +
 attr.c                                       |   1 +
 base85.c                                     |   3 +-
 base85.h                                     |   7 +
 bloom.c                                      |   1 +
 branch.c                                     |   1 +
 builtin/apply.c                              |   1 +
 builtin/archive.c                            |   1 +
 builtin/bisect.c                             |   1 +
 builtin/bundle.c                             |   2 +
 builtin/check-attr.c                         |   1 +
 builtin/check-ignore.c                       |   1 +
 builtin/checkout-index.c                     |   1 +
 builtin/checkout.c                           |   1 +
 builtin/clean.c                              |   1 +
 builtin/clone.c                              |   2 +
 builtin/config.c                             |   1 +
 builtin/credential-cache.c                   |   1 +
 builtin/credential-store.c                   |   1 +
 builtin/diff-tree.c                          |   1 +
 builtin/diff.c                               |   1 +
 builtin/difftool.c                           |   1 +
 builtin/fetch.c                              |   1 +
 builtin/for-each-repo.c                      |   2 +
 builtin/gc.c                                 |   1 +
 builtin/help.c                               |   1 +
 builtin/init-db.c                            |   2 +
 builtin/log.c                                |   1 +
 builtin/ls-remote.c                          |   1 +
 builtin/merge-index.c                        |   1 +
 builtin/merge-recursive.c                    |   2 +
 builtin/merge-tree.c                         |   1 +
 builtin/mv.c                                 |   1 +
 builtin/push.c                               |   2 +
 builtin/read-tree.c                          |   1 +
 builtin/receive-pack.c                       |   1 +
 builtin/repack.c                             |   1 +
 builtin/rerere.c                             |   1 +
 builtin/rm.c                                 |   2 +
 builtin/show-branch.c                        |   2 +
 builtin/show-index.c                         |   2 +
 builtin/update-index.c                       |   3 +
 builtin/update-ref.c                         |   2 +
 builtin/update-server-info.c                 |   1 +
 builtin/upload-archive.c                     |   1 +
 builtin/worktree.c                           |   2 +
 bundle-uri.c                                 |   3 +-
 cache.h                                      | 122 +-------
 checkout.c                                   |   1 +
 checkout.h                                   |   2 +-
 chunk-format.c                               |   1 +
 chunk-format.h                               |   2 +-
 color.c                                      |   3 +-
 combine-diff.c                               |   3 +-
 commit-graph.c                               |   1 +
 commit.c                                     |   1 +
 commit.h                                     |  11 +-
 common-main.c                                |   4 +-
 compat/fsmonitor/fsm-health-darwin.c         |   2 +-
 compat/fsmonitor/fsm-ipc-darwin.c            |   4 +-
 compat/fsmonitor/fsm-ipc-win32.c             |   1 +
 compat/fsmonitor/fsm-listen-darwin.c         |   3 +-
 compat/mingw.c                               |   1 +
 compat/precompose_utf8.c                     |   1 +
 compat/win32/trace2_win32_process_info.c     |   1 +
 config.c                                     |   3 +-
 convert.c                                    |   1 +
 convert.h                                    |   2 +-
 copy.c                                       |   4 +-
 copy.h                                       |  10 +
 credential.c                                 |   3 +-
 csum-file.c                                  |   1 +
 csum-file.h                                  |   2 +-
 daemon.c                                     |   3 +-
 date.c                                       |   3 +-
 diagnose.c                                   |   2 +-
 diff-lib.c                                   |   1 +
 diff.c                                       |   2 +
 diff.h                                       |   1 -
 diffcore.h                                   |   2 +-
 dir.c                                        |   2 +
 dir.h                                        |  15 +
 editor.c                                     |   1 +
 entry.c                                      |   1 +
 environment.c                                |   3 +-
 exec-cmd.c                                   |   1 +
 fetch-pack.c                                 |   1 +
 fsck.c                                       |   1 +
 fsmonitor--daemon.h                          |   1 -
 fsmonitor-ipc.c                              |   1 +
 gpg-interface.c                              |   2 +
 grep.c                                       |   1 +
 hash-ll.h                                    | 276 +++++++++++++++++++
 hash-lookup.c                                |   1 +
 hash.h                                       | 273 +-----------------
 hashmap.h                                    |   2 +-
 hex.c                                        |   1 +
 hex.h                                        |   2 +-
 hook.c                                       |   1 +
 http-push.c                                  |   2 +
 khash.h                                      |   1 +
 line-log.c                                   |   1 +
 ll-merge.c                                   |   3 +-
 log-tree.c                                   |   1 +
 ls-refs.c                                    |   1 +
 match-trees.c                                |   3 +-
 match-trees.h                                |  10 +
 merge-ort-wrappers.c                         |   2 +
 merge-ort.c                                  |   1 +
 merge-ort.h                                  |   2 +-
 merge-recursive.c                            |   2 +
 merge.c                                      |   1 +
 midx.c                                       |   2 +-
 negotiator/default.c                         |   1 +
 negotiator/skipping.c                        |   1 +
 notes-cache.c                                |   1 +
 notes-utils.c                                |   1 +
 object-file.c                                |   3 +-
 object-file.h                                |   2 +
 object-name.c                                |   2 +
 object-store.h                               |   8 +-
 object.h                                     |   3 +-
 oidmap.c                                     |   1 +
 oidtree.h                                    |   2 +-
 pack-bitmap-write.c                          |   2 +
 packfile.c                                   |   2 +-
 packfile.h                                   |  16 +-
 parallel-checkout.c                          |   2 +
 parse-options-cb.c                           |   1 +
 parse-options.c                              |   1 +
 pathspec.c                                   |   2 +
 pkt-line.c                                   |   3 +-
 pkt-line.h                                   |   2 +
 preload-index.c                              |   1 +
 progress.c                                   |   1 +
 protocol-caps.c                              |   2 +-
 range-diff.c                                 |   2 +-
 read-cache.c                                 |  81 +-----
 rebase-interactive.c                         |   1 +
 ref-filter.c                                 |   4 +-
 reflog.c                                     |   2 +
 refs/debug.c                                 |   1 +
 refs/files-backend.c                         |   2 +
 refs/packed-backend.c                        |   1 +
 refs/ref-cache.c                             |   2 +
 refs/ref-cache.h                             |   3 +-
 refspec.c                                    |   2 +
 reftable/dump.c                              |   2 +-
 reftable/error.c                             |   1 +
 reftable/publicbasics.c                      |   2 +-
 reftable/system.h                            |   2 +-
 reftable/tree.c                              |   2 +-
 reftable/tree_test.c                         |   1 +
 rerere.c                                     |   1 +
 reset.h                                      |   2 +-
 resolve-undo.c                               |   1 +
 resolve-undo.h                               |   2 +-
 revision.h                                   |   1 +
 run-command.c                                |   1 +
 send-pack.c                                  |   1 +
 sequencer.c                                  |   1 +
 server-info.c                                |   3 +-
 server-info.h                                |   7 +
 split-index.c                                |   2 +
 split-index.h                                |   2 +-
 strbuf.c                                     |   1 +
 submodule-config.c                           |   1 +
 symlinks.c                                   |   3 +-
 symlinks.h                                   |  28 ++
 t/helper/test-bloom.c                        |   1 +
 t/helper/test-cache-tree.c                   |   1 +
 t/helper/test-dump-cache-tree.c              |   2 +
 t/helper/test-dump-fsmonitor.c               |   1 +
 t/helper/test-dump-untracked-cache.c         |   1 +
 t/helper/test-example-decorate.c             |   1 +
 t/helper/test-fsmonitor-client.c             |   1 +
 t/helper/test-lazy-init-name-hash.c          |   1 +
 t/helper/test-match-trees.c                  |   3 +-
 t/helper/test-mergesort.c                    |   2 +-
 t/helper/test-oid-array.c                    |   2 +-
 t/helper/test-oidmap.c                       |   1 +
 t/helper/test-oidtree.c                      |   2 +-
 t/helper/test-parse-options.c                |   2 +-
 t/helper/test-path-utils.c                   |   1 +
 t/helper/test-read-cache.c                   |   1 +
 t/helper/test-read-midx.c                    |   2 +-
 t/helper/test-reftable.c                     |   1 +
 t/helper/test-scrap-cache-tree.c             |   1 +
 t/helper/test-string-list.c                  |   2 +-
 t/helper/test-submodule-config.c             |   2 +
 t/helper/test-submodule-nested-repo-config.c |   1 +
 t/helper/test-submodule.c                    |   1 +
 t/helper/test-trace2.c                       |   1 +
 t/helper/test-write-cache.c                  |   1 +
 trace2.c                                     |   1 +
 trace2/tr2_tgt_event.c                       |   1 +
 trace2/tr2_tgt_normal.c                      |   1 +
 trace2/tr2_tgt_perf.c                        |   1 +
 tree-diff.c                                  |  16 +-
 tree-walk.c                                  |   2 +-
 tree-walk.h                                  |   3 +-
 tree.c                                       |  72 ++++-
 tree.h                                       |  11 +-
 unpack-trees.c                               |   1 +
 versioncmp.c                                 |   3 +-
 versioncmp.h                                 |   6 +
 wrapper.c                                    |   5 +-
 ws.c                                         |   6 +-
 ws.h                                         |  33 +++
 wt-status.c                                  |   1 +
 xdiff-interface.h                            |   2 +-
 216 files changed, 785 insertions(+), 545 deletions(-)
 create mode 100644 base85.h
 create mode 100644 copy.h
 create mode 100644 hash-ll.h
 create mode 100644 match-trees.h
 create mode 100644 server-info.h
 create mode 100644 symlinks.h
 create mode 100644 versioncmp.h
 create mode 100644 ws.h


base-commit: 331b094eec6d4c937af6e59df2a537112e4d8205
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1517%2Fnewren%2Fheader-cleanup-4-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1517/newren/header-cleanup-4-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1517

Range-diff vs v1:

  1:  6d6b8099374 =  1:  1341ae8125e treewide: be explicit about dependence on strbuf.h
  2:  9f9a3561295 =  2:  4a1f197e1e0 symlinks.h: move declarations for symlinks.c functions from cache.h
  3:  003548de707 <  -:  ----------- protocol.h: move definition of DEFAULT_GIT_PORT from cache.h
  4:  cf28ce0ee20 =  3:  99dfc5eb5dc packfile.h: move pack_window and pack_entry from cache.h
  5:  e22c8f242f3 =  4:  b2ce7a17868 server-info.h: move declarations for server-info.c functions from cache.h
  6:  dbd08e60b58 =  5:  513ffafa597 copy.h: move declarations for copy.c functions from cache.h
  7:  9d9672ebf52 =  6:  c5831480855 base85.h: move declarations for base85.c functions from cache.h
  8:  e8efc37ecb2 =  7:  2d829783f30 pkt-line.h: move declarations for pkt-line.c functions from cache.h
  9:  11c6cd13e2b =  8:  0a321c41c3f match-trees.h: move declarations for match-trees.c functions from cache.h
 10:  e600309df1f =  9:  951eff98a4d ws.h: move declarations for ws.c functions from cache.h
 11:  07e5da241dc = 10:  ff99d0eb207 versioncmp.h: move declarations for versioncmp.c functions from cache.h
 12:  4c951a53737 = 11:  673a3ae4fe2 dir.h: move DTYPE defines from cache.h
 13:  dec377e17f5 = 12:  7b55f82e62e tree-diff.c: move S_DIFFTREE_IFXMIN_NEQ define from cache.h
 14:  1c6989ae456 ! 13:  d95f97f5e90 hash.h, repository.h: reverse the order of these dependencies
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    hash.h, repository.h: reverse the order of these dependencies
     +    hash-ll.h: split out of hash.h to remove dependency on repository.h
      
     -    Previously, hash.h depended upon and included repository.h, due to
     -    the definition and use of the_hash_algo (defined as
     -    the_repository->hash_algo).  Move this #define, and the associated
     -    inline functions that depend upon it, from hash.h to repository.h.
     -    Due to that movement, reverse the dependencies so repository.h includes
     -    hash.h.
     +    hash.h depends upon and includes repository.h, due to the definition and
     +    use of the_hash_algo (defined as the_repository->hash_algo).  However,
     +    most headers trying to include hash.h are only interested in the layout
     +    of the structs like object_id.  Move the parts of hash.h that do not
     +    depend upon repository.h into a new file hash-ll.h (the "low level"
     +    parts of hash.h), and adjust other files to use this new header where
     +    the convenience inline functions aren't needed.
      
          This allows hash.h and object.h to be fairly small, minimal headers.  It
          also exposes a lot of hidden dependencies on both path.h (which was
          brought in by repository.h) and repository.h (which was previously
     -    implicitly brought in by object.h).
     +    implicitly brought in by object.h), so also adjust other files to be
     +    more explicit about what they depend upon.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ alloc.c
       #include "alloc.h"
       
      
     + ## apply.h ##
     +@@
     + #ifndef APPLY_H
     + #define APPLY_H
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + #include "lockfile.h"
     + #include "string-list.h"
     + #include "strmap.h"
     +
       ## branch.c ##
      @@
       #include "refs.h"
     @@ builtin/clean.c
      
       ## builtin/config.c ##
      @@
     + #include "ident.h"
       #include "parse-options.h"
       #include "urlmatch.h"
     ++#include "path.h"
       #include "quote.h"
     -+#include "repository.h"
       #include "setup.h"
       #include "worktree.h"
     - #include "wrapper.h"
      
       ## builtin/credential-cache.c ##
      @@
       #include "builtin.h"
       #include "gettext.h"
       #include "parse-options.h"
     -+#include "repository.h"
     ++#include "path.h"
       #include "wrapper.h"
       #include "write-or-die.h"
       
     @@ builtin/merge-index.c
      
       ## builtin/merge-recursive.c ##
      @@
     + #include "advice.h"
     + #include "commit.h"
     + #include "gettext.h"
     ++#include "hash.h"
       #include "tag.h"
       #include "merge-recursive.h"
       #include "object-name.h"
     @@ builtin/rerere.c
      
       ## builtin/rm.c ##
      @@
     + #include "dir.h"
     + #include "cache-tree.h"
     + #include "gettext.h"
     ++#include "hash.h"
       #include "tree-walk.h"
       #include "object-name.h"
       #include "parse-options.h"
     @@ builtin/rm.c
       #include "submodule.h"
      
       ## builtin/show-branch.c ##
     +@@
     + #include "config.h"
     + #include "environment.h"
     + #include "gettext.h"
     ++#include "hash.h"
     + #include "hex.h"
     + #include "pretty.h"
     + #include "refs.h"
      @@
       #include "strvec.h"
       #include "object-name.h"
     @@ builtin/show-branch.c
      
       ## builtin/show-index.c ##
      @@
     + #include "builtin.h"
     + #include "cache.h"
     + #include "gettext.h"
     ++#include "hash.h"
       #include "hex.h"
       #include "pack.h"
       #include "parse-options.h"
     @@ builtin/show-index.c
       	"git show-index [--object-format=<hash-algorithm>]",
      
       ## builtin/update-index.c ##
     +@@
     + #include "config.h"
     + #include "environment.h"
     + #include "gettext.h"
     ++#include "hash.h"
     + #include "hex.h"
     + #include "lockfile.h"
     + #include "quote.h"
      @@
       #include "parse-options.h"
       #include "pathspec.h"
     @@ builtin/update-index.c
      
       ## builtin/update-ref.c ##
      @@
     + #include "cache.h"
     + #include "config.h"
     + #include "gettext.h"
     ++#include "hash.h"
     + #include "refs.h"
     + #include "builtin.h"
       #include "object-name.h"
       #include "parse-options.h"
       #include "quote.h"
     @@ checkout.c
       #include "config.h"
       #include "strbuf.h"
      
     + ## checkout.h ##
     +@@
     + #ifndef CHECKOUT_H
     + #define CHECKOUT_H
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + 
     + /*
     +  * Check if the branch name uniquely matches a branch name on a remote
     +
       ## chunk-format.c ##
      @@
       #include "chunk-format.h"
       #include "csum-file.h"
       #include "gettext.h"
     -+#include "repository.h"
     ++#include "hash.h"
       #include "trace2.h"
       
       /*
      
     + ## chunk-format.h ##
     +@@
     + #ifndef CHUNK_FORMAT_H
     + #define CHUNK_FORMAT_H
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + 
     + struct hashfile;
     + struct chunkfile;
     +
       ## common-main.c ##
      @@
       #include "exec-cmd.h"
     @@ compat/win32/trace2_win32_process_info.c
       #include "lazyload.h"
       #include <Psapi.h>
      
     + ## convert.h ##
     +@@
     + #ifndef CONVERT_H
     + #define CONVERT_H
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + #include "string-list.h"
     + 
     + struct index_state;
     +
       ## copy.c ##
      @@
       #include "cache.h"
     @@ csum-file.c
       #include "git-compat-util.h"
       #include "progress.h"
       #include "csum-file.h"
     -+#include "repository.h"
     ++#include "hash.h"
       #include "wrapper.h"
       
       static void verify_buffer_or_die(struct hashfile *f,
      
     + ## csum-file.h ##
     +@@
     + #ifndef CSUM_FILE_H
     + #define CSUM_FILE_H
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + #include "write-or-die.h"
     + 
     + struct progress;
     +
       ## daemon.c ##
      @@
       #include "alloc.h"
     @@ daemon.c
       #include "protocol.h"
       #include "run-command.h"
      
     + ## diffcore.h ##
     +@@
     + #ifndef DIFFCORE_H
     + #define DIFFCORE_H
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + 
     + struct diff_options;
     + struct mem_pool;
     +
       ## editor.c ##
      @@
       #include "environment.h"
     @@ gpg-interface.c
       #include "tempfile.h"
       #include "alias.h"
      
     + ## hash-ll.h (new) ##
     +@@
     ++#ifndef HASH_LL_H
     ++#define HASH_LL_H
     ++
     ++#if defined(SHA1_APPLE)
     ++#include <CommonCrypto/CommonDigest.h>
     ++#elif defined(SHA1_OPENSSL)
     ++#include <openssl/sha.h>
     ++#elif defined(SHA1_DC)
     ++#include "sha1dc_git.h"
     ++#else /* SHA1_BLK */
     ++#include "block-sha1/sha1.h"
     ++#endif
     ++
     ++#if defined(SHA256_NETTLE)
     ++#include "sha256/nettle.h"
     ++#elif defined(SHA256_GCRYPT)
     ++#define SHA256_NEEDS_CLONE_HELPER
     ++#include "sha256/gcrypt.h"
     ++#elif defined(SHA256_OPENSSL)
     ++#include <openssl/sha.h>
     ++#else
     ++#include "sha256/block/sha256.h"
     ++#endif
     ++
     ++#ifndef platform_SHA_CTX
     ++/*
     ++ * platform's underlying implementation of SHA-1; could be OpenSSL,
     ++ * blk_SHA, Apple CommonCrypto, etc...  Note that the relevant
     ++ * SHA-1 header may have already defined platform_SHA_CTX for our
     ++ * own implementations like block-sha1, so we list
     ++ * the default for OpenSSL compatible SHA-1 implementations here.
     ++ */
     ++#define platform_SHA_CTX	SHA_CTX
     ++#define platform_SHA1_Init	SHA1_Init
     ++#define platform_SHA1_Update	SHA1_Update
     ++#define platform_SHA1_Final    	SHA1_Final
     ++#endif
     ++
     ++#define git_SHA_CTX		platform_SHA_CTX
     ++#define git_SHA1_Init		platform_SHA1_Init
     ++#define git_SHA1_Update		platform_SHA1_Update
     ++#define git_SHA1_Final		platform_SHA1_Final
     ++
     ++#ifndef platform_SHA256_CTX
     ++#define platform_SHA256_CTX	SHA256_CTX
     ++#define platform_SHA256_Init	SHA256_Init
     ++#define platform_SHA256_Update	SHA256_Update
     ++#define platform_SHA256_Final	SHA256_Final
     ++#endif
     ++
     ++#define git_SHA256_CTX		platform_SHA256_CTX
     ++#define git_SHA256_Init		platform_SHA256_Init
     ++#define git_SHA256_Update	platform_SHA256_Update
     ++#define git_SHA256_Final	platform_SHA256_Final
     ++
     ++#ifdef platform_SHA256_Clone
     ++#define git_SHA256_Clone	platform_SHA256_Clone
     ++#endif
     ++
     ++#ifdef SHA1_MAX_BLOCK_SIZE
     ++#include "compat/sha1-chunked.h"
     ++#undef git_SHA1_Update
     ++#define git_SHA1_Update		git_SHA1_Update_Chunked
     ++#endif
     ++
     ++static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
     ++{
     ++	memcpy(dst, src, sizeof(*dst));
     ++}
     ++
     ++#ifndef SHA256_NEEDS_CLONE_HELPER
     ++static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *src)
     ++{
     ++	memcpy(dst, src, sizeof(*dst));
     ++}
     ++#endif
     ++
     ++/*
     ++ * Note that these constants are suitable for indexing the hash_algos array and
     ++ * comparing against each other, but are otherwise arbitrary, so they should not
     ++ * be exposed to the user or serialized to disk.  To know whether a
     ++ * git_hash_algo struct points to some usable hash function, test the format_id
     ++ * field for being non-zero.  Use the name field for user-visible situations and
     ++ * the format_id field for fixed-length fields on disk.
     ++ */
     ++/* An unknown hash function. */
     ++#define GIT_HASH_UNKNOWN 0
     ++/* SHA-1 */
     ++#define GIT_HASH_SHA1 1
     ++/* SHA-256  */
     ++#define GIT_HASH_SHA256 2
     ++/* Number of algorithms supported (including unknown). */
     ++#define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
     ++
     ++/* "sha1", big-endian */
     ++#define GIT_SHA1_FORMAT_ID 0x73686131
     ++
     ++/* The length in bytes and in hex digits of an object name (SHA-1 value). */
     ++#define GIT_SHA1_RAWSZ 20
     ++#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
     ++/* The block size of SHA-1. */
     ++#define GIT_SHA1_BLKSZ 64
     ++
     ++/* "s256", big-endian */
     ++#define GIT_SHA256_FORMAT_ID 0x73323536
     ++
     ++/* The length in bytes and in hex digits of an object name (SHA-256 value). */
     ++#define GIT_SHA256_RAWSZ 32
     ++#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
     ++/* The block size of SHA-256. */
     ++#define GIT_SHA256_BLKSZ 64
     ++
     ++/* The length in byte and in hex digits of the largest possible hash value. */
     ++#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
     ++#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
     ++/* The largest possible block size for any supported hash. */
     ++#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
     ++
     ++struct object_id {
     ++	unsigned char hash[GIT_MAX_RAWSZ];
     ++	int algo;	/* XXX requires 4-byte alignment */
     ++};
     ++
     ++#define GET_OID_QUIETLY           01
     ++#define GET_OID_COMMIT            02
     ++#define GET_OID_COMMITTISH        04
     ++#define GET_OID_TREE             010
     ++#define GET_OID_TREEISH          020
     ++#define GET_OID_BLOB             040
     ++#define GET_OID_FOLLOW_SYMLINKS 0100
     ++#define GET_OID_RECORD_PATH     0200
     ++#define GET_OID_ONLY_TO_DIE    04000
     ++#define GET_OID_REQUIRE_PATH  010000
     ++
     ++#define GET_OID_DISAMBIGUATORS \
     ++	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
     ++	GET_OID_TREE | GET_OID_TREEISH | \
     ++	GET_OID_BLOB)
     ++
     ++enum get_oid_result {
     ++	FOUND = 0,
     ++	MISSING_OBJECT = -1, /* The requested object is missing */
     ++	SHORT_NAME_AMBIGUOUS = -2,
     ++	/* The following only apply when symlinks are followed */
     ++	DANGLING_SYMLINK = -4, /*
     ++				* The initial symlink is there, but
     ++				* (transitively) points to a missing
     ++				* in-tree file
     ++				*/
     ++	SYMLINK_LOOP = -5,
     ++	NOT_DIR = -6, /*
     ++		       * Somewhere along the symlink chain, a path is
     ++		       * requested which contains a file as a
     ++		       * non-final element.
     ++		       */
     ++};
     ++
     ++/* A suitably aligned type for stack allocations of hash contexts. */
     ++union git_hash_ctx {
     ++	git_SHA_CTX sha1;
     ++	git_SHA256_CTX sha256;
     ++};
     ++typedef union git_hash_ctx git_hash_ctx;
     ++
     ++typedef void (*git_hash_init_fn)(git_hash_ctx *ctx);
     ++typedef void (*git_hash_clone_fn)(git_hash_ctx *dst, const git_hash_ctx *src);
     ++typedef void (*git_hash_update_fn)(git_hash_ctx *ctx, const void *in, size_t len);
     ++typedef void (*git_hash_final_fn)(unsigned char *hash, git_hash_ctx *ctx);
     ++typedef void (*git_hash_final_oid_fn)(struct object_id *oid, git_hash_ctx *ctx);
     ++
     ++struct git_hash_algo {
     ++	/*
     ++	 * The name of the algorithm, as appears in the config file and in
     ++	 * messages.
     ++	 */
     ++	const char *name;
     ++
     ++	/* A four-byte version identifier, used in pack indices. */
     ++	uint32_t format_id;
     ++
     ++	/* The length of the hash in binary. */
     ++	size_t rawsz;
     ++
     ++	/* The length of the hash in hex characters. */
     ++	size_t hexsz;
     ++
     ++	/* The block size of the hash. */
     ++	size_t blksz;
     ++
     ++	/* The hash initialization function. */
     ++	git_hash_init_fn init_fn;
     ++
     ++	/* The hash context cloning function. */
     ++	git_hash_clone_fn clone_fn;
     ++
     ++	/* The hash update function. */
     ++	git_hash_update_fn update_fn;
     ++
     ++	/* The hash finalization function. */
     ++	git_hash_final_fn final_fn;
     ++
     ++	/* The hash finalization function for object IDs. */
     ++	git_hash_final_oid_fn final_oid_fn;
     ++
     ++	/* The OID of the empty tree. */
     ++	const struct object_id *empty_tree;
     ++
     ++	/* The OID of the empty blob. */
     ++	const struct object_id *empty_blob;
     ++
     ++	/* The all-zeros OID. */
     ++	const struct object_id *null_oid;
     ++};
     ++extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
     ++
     ++/*
     ++ * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNOWN if
     ++ * the name doesn't match a known algorithm.
     ++ */
     ++int hash_algo_by_name(const char *name);
     ++/* Identical, except based on the format ID. */
     ++int hash_algo_by_id(uint32_t format_id);
     ++/* Identical, except based on the length. */
     ++int hash_algo_by_length(int len);
     ++/* Identical, except for a pointer to struct git_hash_algo. */
     ++static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
     ++{
     ++	return p - hash_algos;
     ++}
     ++
     ++const struct object_id *null_oid(void);
     ++
     ++static inline int hashcmp_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
     ++{
     ++	/*
     ++	 * Teach the compiler that there are only two possibilities of hash size
     ++	 * here, so that it can optimize for this case as much as possible.
     ++	 */
     ++	if (algop->rawsz == GIT_MAX_RAWSZ)
     ++		return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
     ++	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
     ++}
     ++
     ++static inline int hasheq_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
     ++{
     ++	/*
     ++	 * We write this here instead of deferring to hashcmp so that the
     ++	 * compiler can properly inline it and avoid calling memcmp.
     ++	 */
     ++	if (algop->rawsz == GIT_MAX_RAWSZ)
     ++		return !memcmp(sha1, sha2, GIT_MAX_RAWSZ);
     ++	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
     ++}
     ++
     ++static inline void oidcpy(struct object_id *dst, const struct object_id *src)
     ++{
     ++	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
     ++	dst->algo = src->algo;
     ++}
     ++
     ++static inline struct object_id *oiddup(const struct object_id *src)
     ++{
     ++	struct object_id *dst = xmalloc(sizeof(struct object_id));
     ++	oidcpy(dst, src);
     ++	return dst;
     ++}
     ++
     ++static inline void oid_set_algo(struct object_id *oid, const struct git_hash_algo *algop)
     ++{
     ++	oid->algo = hash_algo_by_ptr(algop);
     ++}
     ++
     ++const char *empty_tree_oid_hex(void);
     ++const char *empty_blob_oid_hex(void);
     ++
     ++#endif
     +
       ## hash-lookup.c ##
      @@
       #include "cache.h"
     ++#include "hash.h"
       #include "hash-lookup.h"
     -+#include "repository.h"
       
       static uint32_t take2(const struct object_id *oid, size_t ofs)
     - {
      
       ## hash.h ##
      @@
       #ifndef HASH_H
       #define HASH_H
       
     --#include "repository.h"
     ++#include "hash-ll.h"
     + #include "repository.h"
     + 
     +-#if defined(SHA1_APPLE)
     +-#include <CommonCrypto/CommonDigest.h>
     +-#elif defined(SHA1_OPENSSL)
     +-#include <openssl/sha.h>
     +-#elif defined(SHA1_DC)
     +-#include "sha1dc_git.h"
     +-#else /* SHA1_BLK */
     +-#include "block-sha1/sha1.h"
     +-#endif
      -
     - #if defined(SHA1_APPLE)
     - #include <CommonCrypto/CommonDigest.h>
     - #elif defined(SHA1_OPENSSL)
     -@@ hash.h: static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
     - 	return p - hash_algos;
     - }
     - 
     --#define the_hash_algo the_repository->hash_algo
     +-#if defined(SHA256_NETTLE)
     +-#include "sha256/nettle.h"
     +-#elif defined(SHA256_GCRYPT)
     +-#define SHA256_NEEDS_CLONE_HELPER
     +-#include "sha256/gcrypt.h"
     +-#elif defined(SHA256_OPENSSL)
     +-#include <openssl/sha.h>
     +-#else
     +-#include "sha256/block/sha256.h"
     +-#endif
      -
     - const struct object_id *null_oid(void);
     - 
     - static inline int hashcmp_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
     -@@ hash.h: static inline int hashcmp_algop(const unsigned char *sha1, const unsigned char *
     - 	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
     - }
     - 
     --static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
     --{
     --	return hashcmp_algop(sha1, sha2, the_hash_algo);
     --}
     +-#ifndef platform_SHA_CTX
     +-/*
     +- * platform's underlying implementation of SHA-1; could be OpenSSL,
     +- * blk_SHA, Apple CommonCrypto, etc...  Note that the relevant
     +- * SHA-1 header may have already defined platform_SHA_CTX for our
     +- * own implementations like block-sha1, so we list
     +- * the default for OpenSSL compatible SHA-1 implementations here.
     +- */
     +-#define platform_SHA_CTX	SHA_CTX
     +-#define platform_SHA1_Init	SHA1_Init
     +-#define platform_SHA1_Update	SHA1_Update
     +-#define platform_SHA1_Final    	SHA1_Final
     +-#endif
      -
     --static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
     --{
     --	const struct git_hash_algo *algop;
     --	if (!oid1->algo)
     --		algop = the_hash_algo;
     --	else
     --		algop = &hash_algos[oid1->algo];
     --	return hashcmp_algop(oid1->hash, oid2->hash, algop);
     --}
     +-#define git_SHA_CTX		platform_SHA_CTX
     +-#define git_SHA1_Init		platform_SHA1_Init
     +-#define git_SHA1_Update		platform_SHA1_Update
     +-#define git_SHA1_Final		platform_SHA1_Final
      -
     - static inline int hasheq_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
     - {
     - 	/*
     -@@ hash.h: static inline int hasheq_algop(const unsigned char *sha1, const unsigned char *s
     - 	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
     - }
     - 
     --static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
     +-#ifndef platform_SHA256_CTX
     +-#define platform_SHA256_CTX	SHA256_CTX
     +-#define platform_SHA256_Init	SHA256_Init
     +-#define platform_SHA256_Update	SHA256_Update
     +-#define platform_SHA256_Final	SHA256_Final
     +-#endif
     +-
     +-#define git_SHA256_CTX		platform_SHA256_CTX
     +-#define git_SHA256_Init		platform_SHA256_Init
     +-#define git_SHA256_Update	platform_SHA256_Update
     +-#define git_SHA256_Final	platform_SHA256_Final
     +-
     +-#ifdef platform_SHA256_Clone
     +-#define git_SHA256_Clone	platform_SHA256_Clone
     +-#endif
     +-
     +-#ifdef SHA1_MAX_BLOCK_SIZE
     +-#include "compat/sha1-chunked.h"
     +-#undef git_SHA1_Update
     +-#define git_SHA1_Update		git_SHA1_Update_Chunked
     +-#endif
     +-
     +-static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
      -{
     --	return hasheq_algop(sha1, sha2, the_hash_algo);
     +-	memcpy(dst, src, sizeof(*dst));
      -}
      -
     --static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
     +-#ifndef SHA256_NEEDS_CLONE_HELPER
     +-static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *src)
      -{
     --	const struct git_hash_algo *algop;
     --	if (!oid1->algo)
     --		algop = the_hash_algo;
     --	else
     --		algop = &hash_algos[oid1->algo];
     --	return hasheq_algop(oid1->hash, oid2->hash, algop);
     +-	memcpy(dst, src, sizeof(*dst));
      -}
     +-#endif
     +-
     +-/*
     +- * Note that these constants are suitable for indexing the hash_algos array and
     +- * comparing against each other, but are otherwise arbitrary, so they should not
     +- * be exposed to the user or serialized to disk.  To know whether a
     +- * git_hash_algo struct points to some usable hash function, test the format_id
     +- * field for being non-zero.  Use the name field for user-visible situations and
     +- * the format_id field for fixed-length fields on disk.
     +- */
     +-/* An unknown hash function. */
     +-#define GIT_HASH_UNKNOWN 0
     +-/* SHA-1 */
     +-#define GIT_HASH_SHA1 1
     +-/* SHA-256  */
     +-#define GIT_HASH_SHA256 2
     +-/* Number of algorithms supported (including unknown). */
     +-#define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
     +-
     +-/* "sha1", big-endian */
     +-#define GIT_SHA1_FORMAT_ID 0x73686131
     +-
     +-/* The length in bytes and in hex digits of an object name (SHA-1 value). */
     +-#define GIT_SHA1_RAWSZ 20
     +-#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
     +-/* The block size of SHA-1. */
     +-#define GIT_SHA1_BLKSZ 64
     +-
     +-/* "s256", big-endian */
     +-#define GIT_SHA256_FORMAT_ID 0x73323536
     +-
     +-/* The length in bytes and in hex digits of an object name (SHA-256 value). */
     +-#define GIT_SHA256_RAWSZ 32
     +-#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
     +-/* The block size of SHA-256. */
     +-#define GIT_SHA256_BLKSZ 64
     +-
     +-/* The length in byte and in hex digits of the largest possible hash value. */
     +-#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
     +-#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
     +-/* The largest possible block size for any supported hash. */
     +-#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
     +-
     +-struct object_id {
     +-	unsigned char hash[GIT_MAX_RAWSZ];
     +-	int algo;	/* XXX requires 4-byte alignment */
     +-};
      -
     --static inline int is_null_oid(const struct object_id *oid)
     +-#define GET_OID_QUIETLY           01
     +-#define GET_OID_COMMIT            02
     +-#define GET_OID_COMMITTISH        04
     +-#define GET_OID_TREE             010
     +-#define GET_OID_TREEISH          020
     +-#define GET_OID_BLOB             040
     +-#define GET_OID_FOLLOW_SYMLINKS 0100
     +-#define GET_OID_RECORD_PATH     0200
     +-#define GET_OID_ONLY_TO_DIE    04000
     +-#define GET_OID_REQUIRE_PATH  010000
     +-
     +-#define GET_OID_DISAMBIGUATORS \
     +-	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
     +-	GET_OID_TREE | GET_OID_TREEISH | \
     +-	GET_OID_BLOB)
     +-
     +-enum get_oid_result {
     +-	FOUND = 0,
     +-	MISSING_OBJECT = -1, /* The requested object is missing */
     +-	SHORT_NAME_AMBIGUOUS = -2,
     +-	/* The following only apply when symlinks are followed */
     +-	DANGLING_SYMLINK = -4, /*
     +-				* The initial symlink is there, but
     +-				* (transitively) points to a missing
     +-				* in-tree file
     +-				*/
     +-	SYMLINK_LOOP = -5,
     +-	NOT_DIR = -6, /*
     +-		       * Somewhere along the symlink chain, a path is
     +-		       * requested which contains a file as a
     +-		       * non-final element.
     +-		       */
     +-};
     +-
     +-/* A suitably aligned type for stack allocations of hash contexts. */
     +-union git_hash_ctx {
     +-	git_SHA_CTX sha1;
     +-	git_SHA256_CTX sha256;
     +-};
     +-typedef union git_hash_ctx git_hash_ctx;
     +-
     +-typedef void (*git_hash_init_fn)(git_hash_ctx *ctx);
     +-typedef void (*git_hash_clone_fn)(git_hash_ctx *dst, const git_hash_ctx *src);
     +-typedef void (*git_hash_update_fn)(git_hash_ctx *ctx, const void *in, size_t len);
     +-typedef void (*git_hash_final_fn)(unsigned char *hash, git_hash_ctx *ctx);
     +-typedef void (*git_hash_final_oid_fn)(struct object_id *oid, git_hash_ctx *ctx);
     +-
     +-struct git_hash_algo {
     +-	/*
     +-	 * The name of the algorithm, as appears in the config file and in
     +-	 * messages.
     +-	 */
     +-	const char *name;
     +-
     +-	/* A four-byte version identifier, used in pack indices. */
     +-	uint32_t format_id;
     +-
     +-	/* The length of the hash in binary. */
     +-	size_t rawsz;
     +-
     +-	/* The length of the hash in hex characters. */
     +-	size_t hexsz;
     +-
     +-	/* The block size of the hash. */
     +-	size_t blksz;
     +-
     +-	/* The hash initialization function. */
     +-	git_hash_init_fn init_fn;
     +-
     +-	/* The hash context cloning function. */
     +-	git_hash_clone_fn clone_fn;
     +-
     +-	/* The hash update function. */
     +-	git_hash_update_fn update_fn;
     +-
     +-	/* The hash finalization function. */
     +-	git_hash_final_fn final_fn;
     +-
     +-	/* The hash finalization function for object IDs. */
     +-	git_hash_final_oid_fn final_oid_fn;
     +-
     +-	/* The OID of the empty tree. */
     +-	const struct object_id *empty_tree;
     +-
     +-	/* The OID of the empty blob. */
     +-	const struct object_id *empty_blob;
     +-
     +-	/* The all-zeros OID. */
     +-	const struct object_id *null_oid;
     +-};
     +-extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
     +-
     +-/*
     +- * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNOWN if
     +- * the name doesn't match a known algorithm.
     +- */
     +-int hash_algo_by_name(const char *name);
     +-/* Identical, except based on the format ID. */
     +-int hash_algo_by_id(uint32_t format_id);
     +-/* Identical, except based on the length. */
     +-int hash_algo_by_length(int len);
     +-/* Identical, except for a pointer to struct git_hash_algo. */
     +-static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
      -{
     --	return oideq(oid, null_oid());
     +-	return p - hash_algos;
      -}
      -
     --static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
     + #define the_hash_algo the_repository->hash_algo
     + 
     +-const struct object_id *null_oid(void);
     +-
     +-static inline int hashcmp_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
      -{
     --	memcpy(sha_dst, sha_src, the_hash_algo->rawsz);
     +-	/*
     +-	 * Teach the compiler that there are only two possibilities of hash size
     +-	 * here, so that it can optimize for this case as much as possible.
     +-	 */
     +-	if (algop->rawsz == GIT_MAX_RAWSZ)
     +-		return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
     +-	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
      -}
      -
     - static inline void oidcpy(struct object_id *dst, const struct object_id *src)
     + static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
       {
     - 	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
     - 	dst->algo = src->algo;
     + 	return hashcmp_algop(sha1, sha2, the_hash_algo);
     +@@ hash.h: static inline int oidcmp(const struct object_id *oid1, const struct object_id *o
     + 	return hashcmp_algop(oid1->hash, oid2->hash, algop);
       }
       
     --/* Like oidcpy() but zero-pads the unused bytes in dst's hash array. */
     --static inline void oidcpy_with_padding(struct object_id *dst,
     --				       const struct object_id *src)
     +-static inline int hasheq_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
      -{
     --	size_t hashsz;
     --
     --	if (!src->algo)
     --		hashsz = the_hash_algo->rawsz;
     --	else
     --		hashsz = hash_algos[src->algo].rawsz;
     --
     --	memcpy(dst->hash, src->hash, hashsz);
     --	memset(dst->hash + hashsz, 0, GIT_MAX_RAWSZ - hashsz);
     --	dst->algo = src->algo;
     +-	/*
     +-	 * We write this here instead of deferring to hashcmp so that the
     +-	 * compiler can properly inline it and avoid calling memcmp.
     +-	 */
     +-	if (algop->rawsz == GIT_MAX_RAWSZ)
     +-		return !memcmp(sha1, sha2, GIT_MAX_RAWSZ);
     +-	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
      -}
      -
     - static inline struct object_id *oiddup(const struct object_id *src)
     + static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
       {
     - 	struct object_id *dst = xmalloc(sizeof(struct object_id));
     -@@ hash.h: static inline struct object_id *oiddup(const struct object_id *src)
     - 	return dst;
     + 	return hasheq_algop(sha1, sha2, the_hash_algo);
     +@@ hash.h: static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
     + 	memcpy(sha_dst, sha_src, the_hash_algo->rawsz);
       }
       
     --static inline void hashclr(unsigned char *hash)
     --{
     --	memset(hash, 0, the_hash_algo->rawsz);
     --}
     --
     --static inline void oidclr(struct object_id *oid)
     --{
     --	memset(oid->hash, 0, GIT_MAX_RAWSZ);
     --	oid->algo = hash_algo_by_ptr(the_hash_algo);
     --}
     --
     --static inline void oidread(struct object_id *oid, const unsigned char *hash)
     --{
     --	memcpy(oid->hash, hash, the_hash_algo->rawsz);
     --	oid->algo = hash_algo_by_ptr(the_hash_algo);
     --}
     --
     --static inline int is_empty_blob_sha1(const unsigned char *sha1)
     +-static inline void oidcpy(struct object_id *dst, const struct object_id *src)
      -{
     --	return hasheq(sha1, the_hash_algo->empty_blob->hash);
     +-	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
     +-	dst->algo = src->algo;
      -}
      -
     --static inline int is_empty_blob_oid(const struct object_id *oid)
     + /* Like oidcpy() but zero-pads the unused bytes in dst's hash array. */
     + static inline void oidcpy_with_padding(struct object_id *dst,
     + 				       const struct object_id *src)
     +@@ hash.h: static inline void oidcpy_with_padding(struct object_id *dst,
     + 	dst->algo = src->algo;
     + }
     + 
     +-static inline struct object_id *oiddup(const struct object_id *src)
      -{
     --	return oideq(oid, the_hash_algo->empty_blob);
     +-	struct object_id *dst = xmalloc(sizeof(struct object_id));
     +-	oidcpy(dst, src);
     +-	return dst;
      -}
      -
     --static inline int is_empty_tree_sha1(const unsigned char *sha1)
     + static inline void hashclr(unsigned char *hash)
     + {
     + 	memset(hash, 0, the_hash_algo->rawsz);
     +@@ hash.h: static inline int is_empty_tree_oid(const struct object_id *oid)
     + 	return oideq(oid, the_hash_algo->empty_tree);
     + }
     + 
     +-static inline void oid_set_algo(struct object_id *oid, const struct git_hash_algo *algop)
      -{
     --	return hasheq(sha1, the_hash_algo->empty_tree->hash);
     +-	oid->algo = hash_algo_by_ptr(algop);
      -}
      -
     --static inline int is_empty_tree_oid(const struct object_id *oid)
     --{
     --	return oideq(oid, the_hash_algo->empty_tree);
     --}
     +-const char *empty_tree_oid_hex(void);
     +-const char *empty_blob_oid_hex(void);
      -
     - static inline void oid_set_algo(struct object_id *oid, const struct git_hash_algo *algop)
     - {
     - 	oid->algo = hash_algo_by_ptr(algop);
     + #endif
     +
     + ## hashmap.h ##
     +@@
     + #ifndef HASHMAP_H
     + #define HASHMAP_H
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + 
     + /*
     +  * Generic implementation of hash-based key-value mappings.
      
       ## hex.c ##
      @@
       #include "git-compat-util.h"
     ++#include "hash.h"
       #include "hex.h"
     -+#include "repository.h"
       
       const signed char hexval_table[256] = {
     - 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
     +
     + ## hex.h ##
     +@@
     + #ifndef HEX_H
     + #define HEX_H
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + 
     + extern const signed char hexval_table[256];
     + static inline unsigned int hexval(unsigned char c)
      
       ## hook.c ##
      @@
     @@ khash.h
       #define __AC_KHASH_H
       
       #include "hashmap.h"
     -+#include "repository.h"
     ++#include "hash.h"
       
       #define AC_VERSION_KHASH_H "0.2.8"
       
      
     + ## ls-refs.c ##
     +@@
     + #include "git-compat-util.h"
     + #include "environment.h"
     + #include "gettext.h"
     ++#include "hash.h"
     + #include "hex.h"
     + #include "repository.h"
     + #include "refs.h"
     +
       ## merge-ort-wrappers.c ##
      @@
     + #include "cache.h"
       #include "gettext.h"
     ++#include "hash.h"
       #include "merge-ort.h"
       #include "merge-ort-wrappers.h"
     -+#include "repository.h"
       
     - #include "commit.h"
     +
     + ## merge-ort.h ##
     +@@
     + #define MERGE_ORT_H
     + 
     + #include "merge-recursive.h"
     +-#include "hash.h"
     ++#include "hash-ll.h"
       
     + struct commit;
     + struct tree;
      
       ## negotiator/default.c ##
      @@
     @@ object-file.h
      
       ## object.h ##
      @@
     - #include "hash.h"
     + #ifndef OBJECT_H
     + #define OBJECT_H
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
       
       struct buffer_slab;
      +struct repository;
     @@ object.h
       struct parsed_object_pool {
       	struct object **obj_hash;
      
     - ## oid-array.h ##
     -@@
     - #define OID_ARRAY_H
     - 
     - #include "hash.h"
     -+#include "repository.h"
     - 
     - /**
     -  * The API provides storage and manipulation of sets of object identifiers.
     -
       ## oidmap.c ##
      @@
       #include "git-compat-util.h"
     ++#include "hash.h"
       #include "oidmap.h"
     -+#include "repository.h"
       
       static int oidmap_neq(const void *hashmap_cmp_fn_data UNUSED,
     - 		      const struct hashmap_entry *e1,
      
     - ## oidtree.c ##
     + ## oidtree.h ##
      @@
     - #include "oidtree.h"
     - #include "alloc.h"
     - #include "hash.h"
     -+#include "repository.h"
     + #define OIDTREE_H
     + 
     + #include "cbtree.h"
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + #include "mem-pool.h"
       
     - struct oidtree_iter_data {
     - 	oidtree_iter fn;
     + struct oidtree {
      
       ## parallel-checkout.c ##
      @@
     + #include "config.h"
     + #include "entry.h"
     + #include "gettext.h"
     ++#include "hash.h"
     + #include "hex.h"
       #include "parallel-checkout.h"
       #include "pkt-line.h"
     - #include "progress.h"
     -+#include "repository.h"
     - #include "run-command.h"
     - #include "sigchain.h"
     - #include "streaming.h"
      
       ## pathspec.c ##
      @@
     @@ progress.c
       #include "trace.h"
       #include "trace2.h"
      
     + ## protocol-caps.c ##
     +@@
     + #include "hex.h"
     + #include "pkt-line.h"
     + #include "strvec.h"
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + #include "hex.h"
     + #include "object.h"
     + #include "object-store.h"
     +
       ## rebase-interactive.c ##
      @@
       #include "gettext.h"
     @@ rebase-interactive.c
      
       ## refs/files-backend.c ##
      @@
     - #include "../lockfile.h"
     - #include "../object.h"
     - #include "../object-file.h"
     -+#include "../repository.h"
     - #include "../dir.h"
     - #include "../chdir-notify.h"
     - #include "../setup.h"
     + #include "../copy.h"
     + #include "../environment.h"
     + #include "../gettext.h"
     ++#include "../hash.h"
     + #include "../hex.h"
     + #include "../refs.h"
     + #include "refs-internal.h"
      
       ## refs/packed-backend.c ##
      @@
     - #include "../iterator.h"
     - #include "../lockfile.h"
     - #include "../chdir-notify.h"
     -+#include "../repository.h"
     - #include "../wrapper.h"
     - #include "../write-or-die.h"
     - 
     + #include "../alloc.h"
     + #include "../config.h"
     + #include "../gettext.h"
     ++#include "../hash.h"
     + #include "../hex.h"
     + #include "../refs.h"
     + #include "refs-internal.h"
      
       ## refs/ref-cache.c ##
      @@
     + #include "../git-compat-util.h"
     + #include "../alloc.h"
     ++#include "../hash.h"
     + #include "../refs.h"
     ++#include "../repository.h"
       #include "refs-internal.h"
       #include "ref-cache.h"
       #include "../iterator.h"
     -+#include "../repository.h"
     - 
     - void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
     - {
      
       ## refs/ref-cache.h ##
      @@
     + #ifndef REFS_REF_CACHE_H
     + #define REFS_REF_CACHE_H
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
       
       struct ref_dir;
       struct ref_store;
     @@ refs/ref-cache.h
      
       ## refspec.c ##
      @@
     + #include "git-compat-util.h"
     + #include "alloc.h"
     + #include "gettext.h"
     ++#include "hash.h"
     + #include "hex.h"
       #include "strvec.h"
       #include "refs.h"
     - #include "refspec.h"
     -+#include "repository.h"
     +
     + ## reftable/dump.c ##
     +@@ reftable/dump.c: https://developers.google.com/open-source/licenses/bsd
     + */
       
     - static struct refspec_item s_tag_refspec = {
     - 	.force = 0,
     + #include "git-compat-util.h"
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + 
     + #include "reftable-blocksource.h"
     + #include "reftable-error.h"
      
     - ## repository.h ##
     -@@
     - #ifndef REPOSITORY_H
     - #define REPOSITORY_H
     + ## reftable/system.h ##
     +@@ reftable/system.h: https://developers.google.com/open-source/licenses/bsd
       
     -+#include "hash.h"
     - #include "path.h"
     + #include "git-compat-util.h"
     + #include "strbuf.h"
     +-#include "hash.h" /* hash ID, sizes.*/
     ++#include "hash-ll.h" /* hash ID, sizes.*/
     + #include "dir.h" /* remove_dir_recursively, for tests.*/
       
     - struct config_set;
     -@@ repository.h: void prepare_repo_settings(struct repository *r);
     -  */
     - int upgrade_repository_format(int target_version);
     + int hash_size(uint32_t id);
     +
     + ## reset.h ##
     +@@
     + #ifndef RESET_H
     + #define RESET_H
       
     -+#define the_hash_algo the_repository->hash_algo
     -+
     -+static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
     -+{
     -+	return hashcmp_algop(sha1, sha2, the_hash_algo);
     -+}
     -+
     -+static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
     -+{
     -+	const struct git_hash_algo *algop;
     -+	if (!oid1->algo)
     -+		algop = the_hash_algo;
     -+	else
     -+		algop = &hash_algos[oid1->algo];
     -+	return hashcmp_algop(oid1->hash, oid2->hash, algop);
     -+}
     -+
     -+static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
     -+{
     -+	return hasheq_algop(sha1, sha2, the_hash_algo);
     -+}
     -+
     -+static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
     -+{
     -+	const struct git_hash_algo *algop;
     -+	if (!oid1->algo)
     -+		algop = the_hash_algo;
     -+	else
     -+		algop = &hash_algos[oid1->algo];
     -+	return hasheq_algop(oid1->hash, oid2->hash, algop);
     -+}
     -+
     -+static inline int is_null_oid(const struct object_id *oid)
     -+{
     -+	return oideq(oid, null_oid());
     -+}
     -+
     -+static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
     -+{
     -+	memcpy(sha_dst, sha_src, the_hash_algo->rawsz);
     -+}
     -+
     -+/* Like oidcpy() but zero-pads the unused bytes in dst's hash array. */
     -+static inline void oidcpy_with_padding(struct object_id *dst,
     -+				       const struct object_id *src)
     -+{
     -+	size_t hashsz;
     -+
     -+	if (!src->algo)
     -+		hashsz = the_hash_algo->rawsz;
     -+	else
     -+		hashsz = hash_algos[src->algo].rawsz;
     -+
     -+	memcpy(dst->hash, src->hash, hashsz);
     -+	memset(dst->hash + hashsz, 0, GIT_MAX_RAWSZ - hashsz);
     -+	dst->algo = src->algo;
     -+}
     -+
     -+static inline void hashclr(unsigned char *hash)
     -+{
     -+	memset(hash, 0, the_hash_algo->rawsz);
     -+}
     -+
     -+static inline void oidclr(struct object_id *oid)
     -+{
     -+	memset(oid->hash, 0, GIT_MAX_RAWSZ);
     -+	oid->algo = hash_algo_by_ptr(the_hash_algo);
     -+}
     -+
     -+static inline void oidread(struct object_id *oid, const unsigned char *hash)
     -+{
     -+	memcpy(oid->hash, hash, the_hash_algo->rawsz);
     -+	oid->algo = hash_algo_by_ptr(the_hash_algo);
     -+}
     -+
     -+static inline int is_empty_blob_sha1(const unsigned char *sha1)
     -+{
     -+	return hasheq(sha1, the_hash_algo->empty_blob->hash);
     -+}
     -+
     -+static inline int is_empty_blob_oid(const struct object_id *oid)
     -+{
     -+	return oideq(oid, the_hash_algo->empty_blob);
     -+}
     -+
     -+static inline int is_empty_tree_sha1(const unsigned char *sha1)
     -+{
     -+	return hasheq(sha1, the_hash_algo->empty_tree->hash);
     -+}
     -+
     -+static inline int is_empty_tree_oid(const struct object_id *oid)
     -+{
     -+	return oideq(oid, the_hash_algo->empty_tree);
     -+}
     -+
     - #endif /* REPOSITORY_H */
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + #include "repository.h"
     + 
     + #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
      
       ## resolve-undo.c ##
      @@
       #include "cache.h"
       #include "dir.h"
     ++#include "hash.h"
       #include "resolve-undo.h"
     -+#include "repository.h"
       #include "string-list.h"
       
     - /* The only error case is to run out of memory in string-list */
     +
     + ## resolve-undo.h ##
     +@@ resolve-undo.h: struct index_state;
     + struct pathspec;
     + struct string_list;
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + 
     + struct resolve_undo_info {
     + 	unsigned int mode[3];
      
       ## split-index.c ##
      @@
     + #include "cache.h"
       #include "alloc.h"
       #include "gettext.h"
     ++#include "hash.h"
       #include "mem-pool.h"
     -+#include "repository.h"
       #include "split-index.h"
       #include "strbuf.h"
     - #include "ewah/ewok.h"
     +
     + ## split-index.h ##
     +@@
     + #ifndef SPLIT_INDEX_H
     + #define SPLIT_INDEX_H
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + 
     + struct index_state;
     + struct strbuf;
      
       ## strbuf.c ##
      @@
     @@ t/helper/test-cache-tree.c
      
       ## t/helper/test-dump-cache-tree.c ##
      @@
     + #define USE_THE_INDEX_VARIABLE
     + #include "test-tool.h"
     + #include "cache.h"
     ++#include "hash.h"
       #include "hex.h"
       #include "tree.h"
       #include "cache-tree.h"
     @@ t/helper/test-submodule-config.c
      @@
       #include "test-tool.h"
       #include "config.h"
     ++#include "hash.h"
       #include "object-name.h"
      +#include "repository.h"
       #include "setup.h"
     @@ trace2/tr2_tgt_perf.c
      
       ## tree-walk.h ##
      @@
     - #include "hash.h"
     + #ifndef TREE_WALK_H
     + #define TREE_WALK_H
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
       
       struct index_state;
      +struct repository;
     @@ wrapper.c
       #include "strbuf.h"
       #include "trace2.h"
       #include "wrapper.h"
     +
     + ## xdiff-interface.h ##
     +@@
     + #ifndef XDIFF_INTERFACE_H
     + #define XDIFF_INTERFACE_H
     + 
     +-#include "hash.h"
     ++#include "hash-ll.h"
     + #include "xdiff/xdiff.h"
     + 
     + /*
 15:  e1983d51c05 = 14:  5ef0e17d0aa cache,tree: move cmp_cache_name_compare from tree.[ch] to read-cache.c
 16:  c72cc0dab90 = 15:  cc286133513 cache,tree: move basic name compare functions from read-cache to tree
 17:  1edd8fd72a7 = 16:  960b5438ce4 treewide: remove cache.h inclusion due to previous changes
 18:  34c9034e8ed = 17:  b459b60de89 cache.h: remove unnecessary headers
 19:  8e747e889fb = 18:  80ebd46c862 fsmonitor: reduce includes of cache.h
 20:  c6d58573661 ! 19:  7479e72ffd6 commit.h: reduce unnecessary includes
     @@ log-tree.c
      
       ## merge-ort-wrappers.c ##
      @@
     + #include "hash.h"
       #include "merge-ort.h"
       #include "merge-ort-wrappers.h"
     - #include "repository.h"
      +#include "tree.h"
       
       #include "commit.h"
     @@ refs/debug.c
      
       ## refspec.c ##
      @@
     + #include "strvec.h"
       #include "refs.h"
       #include "refspec.h"
     - #include "repository.h"
      +#include "strbuf.h"
       
       static struct refspec_item s_tag_refspec = {
 21:  1aa36d91b59 = 20:  7705cbc2733 object-store.h: reduce unnecessary includes
 22:  d70e3b99dae = 21:  b7a96a08d14 diff.h: reduce unnecessary includes
 23:  f32d4fa3dbf = 22:  67d52c6e751 reftable: ensure git-compat-util.h is the first (indirect) include

-- 
gitgitgadget
