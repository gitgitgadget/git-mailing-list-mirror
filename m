Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3459BC77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjEGDqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjEGDp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:45:59 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13CF2D6D
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:45:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so4649645e9.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431155; x=1686023155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=86OeZmTyNjW6YGq9xQK6BzaslXelwgWUU+RT3F5DGZQ=;
        b=g+W9EpKuWsw+j1pDiMX13wPJq+M4HgY5LlfdCpViJgjHzRT4UfWLcsl09HT37C6r8J
         XBF3Oq4lEpXercl04XW+3IgVIz3t2VrVmvawBmbf1CGoBu2uFrd5Yi5TPHQ+8IwoPHng
         NtdEkX8NxVuB3LYsarCWzpbWcvAfpVWlNJJ4DKWUegfBmRaFuMyHPxseBicdFcW0u/01
         eLx3gL/MyXlLnR6Pc4GHJKbOOiKNjgOIoGDU+WjVDZaoCofPPw+EV4qzNbf8Ux3qRxKP
         rSZHyYmg9XqaNbfdF+2btEUq+JPQDmNZui5IKtLS+Kl2YSb3gfxDMj4SyDSLDD6onv1s
         0bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431155; x=1686023155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86OeZmTyNjW6YGq9xQK6BzaslXelwgWUU+RT3F5DGZQ=;
        b=XnPT2BDm8n9xs/uvn/CwXznX8LEYKWiXs+03yzg1wTSLeWAafYP97geLLvlj10H6t8
         v5onOIgo8dknc0LMD/oe5+Qd4ToDH7qFcJFtIGuNgiR6Yet61hfYGrWRlCbAqERQps2H
         PWYXpTUMbp56HYzrXz/0smcbOoBRqLvq62sZMBbdIAtU1TpQw2cRo86LsTsK4hCEqlaw
         DbPWCMm5zh3AfXH8Ls+MX3mEzagoBNH/YcnDWfo+VU8o2G0DzrzJq+jxLRLoT3Jm9HXR
         kP4L1X4AL41a2VZXAcX1GDPxE2C8EvtvznMfhkDoh/PW1vteOXpOM/3YyGMtAVSpFElR
         Pf/A==
X-Gm-Message-State: AC+VfDzQPbyZwEAiylv2sUhkEgdzPnX3uzkbXmcGc1XbknStWw0Fjw8t
        UngoussrLiYETG1OWGwnkWHXrjgaW2w=
X-Google-Smtp-Source: ACHHUZ73CoWyr6Q3j607QW/vWPxlhNgsOpCjT4rWFFBNQNwlYPeuWSlw8RLMrAccfP4Jq3cbHK2Dpg==
X-Received: by 2002:a1c:7308:0:b0:3ef:6819:b2ad with SMTP id d8-20020a1c7308000000b003ef6819b2admr4399232wmb.37.1683431154902;
        Sat, 06 May 2023 20:45:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7-20020a1cf207000000b003e91b9a92c9sm12535514wmc.24.2023.05.06.20.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:45:54 -0700 (PDT)
Message-Id: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:25 +0000
Subject: [PATCH 00/24] Header cleanups (final splitting of cache.h, and some splitting of other
 headers)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maintainer notes: (1) This series is built on top of a merge of
en/header-split-cache-h-part-2 into master, (2) This series has no conflicts
with next, but has three simple & small conflicts with seen:

 * a textual conflict with tl/notes-separator (affecting builtin/notes.c; to
   address, nuke the conflict region and add an include of alloc.h after
   builtin.h)
 * a textual & semantic conflict with cw/strbuf-cleanup (affecting strbuf.c;
   to address, delete the conflict region and also delete the include of
   repository.h)
 * a semantic conflict with rn/sparse-diff-index (affecting
   builtin/diff-index.c; to address, add an include of sparse-index.h).

== Summary ==

This series continues to focus on splitting declarations from cache.h to
separate headers, and also cleans up some other small header issues. By
patch 16, cache.h is gone.

== Reviewer Focus (see also "Overview" section, below) ==

While the series may look long and big, it's really mostly just (a) moving
lots of code (so --color-moved is handy), and (b) adding (or removing)
includes repeatedly throughout the code. These are just more of the same
kinds of changes from the previous series.

However, there are a few exceptions that do not fit in these two categories,
which should be reviewed more closely:

 * Patches 1, 2, & 5
 * Patch 16, the Documentation and Makefile changes
 * Patch 23, the single modified line in khash.h

Patches 10 & 24 might also merit a little closer review.

== Impact; interesting stats ==

By way of impact, I created a small script which before this series reports:

Total include depth of .c files: 18340
Total include depth of .h files: 1385


After this series, I see:

Total include depth of .c files: 16155
Total include depth of .h files: 1206


The script computes the number of files transitively included by each file
(not perfect, e.g. only does textual search so if the include if ifdef'd,
it'll be counted anyway), and then sums the results. I think these numbers
represent one rough measure of overall complexity humans face in
understanding files in our project, and/or that compilers take to operate.
(For reference, the total include depths for v2.40.0 were 23114 and 2981;
we've come a long way in improving it, most of that through nuking cache.h.)

== Overview ==

An overview:

 * Patches 1-6: move shared code between various builtin/*.c files into
   alternate shared homes (setup.c, read-cache.c).
 * Patches 7-16: continue splitting declarations from cache.h into
   alternative headers associated with the actual implementation of those
   functions.
 * Patches 17-22: remove some unnecessary includes in other header files
 * Patches 23 & 24: do some header shuffling with hashmap/khash/hash, and
   fsmonitor to reduce include depths

I would have just lumped patches 1-6 in with 7-16, but patches 1, 2, & 5 did
some preliminary changes to allow the code movement.

== Acknowledgements ==

And thanks once again to Dscho for gitgitgadget. Getting multiple platform
testing + all the special tests (sparse, cocci, hdr-check, etc.) really
helps clean out all the issues that would otherwise hit a series like this.

Elijah Newren (24):
  init-db: remove unnecessary global variable & document existing bug
  init-db, clone: change unnecessary global into passed parameter
  setup: adopt shared init-db & clone code
  read-cache: move shared commit and ls-files code
  add: modify add_files_to_cache() to avoid globals
  read-cache: move shared add/checkout/commit code
  statinfo: move stat_{data,validity} functions from cache/read-cache
  run-command.h: move declarations for run-command.c from cache.h
  name-hash.h: move declarations for name-hash.c from cache.h
  sparse-index.h: move declarations for sparse-index.c from cache.h
  preload-index.h: move declarations for preload-index.c from elsewhere
  diff.h: move declaration for global in diff.c from cache.h
  merge.h: move declarations for merge.c from cache.h
  repository.h: move declaration of the_index from cache.h
  read-cache*.h: move declarations for read-cache.c functions from
    cache.h
  cache.h: remove this no-longer-used header
  log-tree: replace include of revision.h with simple forward
    declaration
  repository: remove unnecessary include of path.h
  diff.h: remove unnecessary include of oidset.h
  list-objects-filter-options.h: remove unneccessary include
  builtin.h: remove unneccessary includes
  git-compat-util.h: remove unneccessary include of wildmatch.h
  hash-ll, hashmap: move oidhash() to hash-ll
  fsmonitor-ll.h: split this header out of fsmonitor.h

 Documentation/CodingGuidelines           |   2 +-
 Documentation/MyFirstObjectWalk.txt      |   2 +-
 Documentation/user-manual.txt            |  18 +-
 Makefile                                 |   3 +-
 add-interactive.c                        |   6 +-
 add-patch.c                              |   4 +-
 apply.c                                  |   8 +-
 archive-tar.c                            |   2 +-
 archive-zip.c                            |   2 +-
 archive.c                                |   3 +-
 attr.c                                   |   6 +-
 bisect.c                                 |   3 +-
 blame.c                                  |   6 +-
 blame.h                                  |   1 +
 branch.c                                 |   1 +
 builtin.h                                |   3 -
 builtin/add.c                            | 105 +----
 builtin/am.c                             |   5 +-
 builtin/apply.c                          |   1 -
 builtin/archive.c                        |   1 -
 builtin/bisect.c                         |   2 +-
 builtin/blame.c                          |   2 +-
 builtin/branch.c                         |   4 +-
 builtin/bundle.c                         |   1 -
 builtin/cat-file.c                       |   5 +-
 builtin/check-attr.c                     |   1 -
 builtin/check-ignore.c                   |   1 -
 builtin/check-mailmap.c                  |   1 +
 builtin/check-ref-format.c               |   3 +-
 builtin/checkout--worker.c               |   1 +
 builtin/checkout-index.c                 |   2 +
 builtin/checkout.c                       |   7 +-
 builtin/clean.c                          |   3 +-
 builtin/clone.c                          |   6 +-
 builtin/column.c                         |   1 -
 builtin/commit-graph.c                   |   3 +-
 builtin/commit-tree.c                    |   5 +-
 builtin/commit.c                         |  10 +-
 builtin/config.c                         |   1 +
 builtin/count-objects.c                  |   6 +-
 builtin/credential-cache.c               |   1 +
 builtin/describe.c                       |   7 +-
 builtin/diff-files.c                     |   5 +-
 builtin/diff-index.c                     |   5 +-
 builtin/diff-tree.c                      |   5 +-
 builtin/diff.c                           |   5 +-
 builtin/difftool.c                       |   7 +-
 builtin/fast-export.c                    |   3 +-
 builtin/fast-import.c                    |   4 +-
 builtin/fetch.c                          |   6 +-
 builtin/for-each-ref.c                   |   2 +-
 builtin/for-each-repo.c                  |   3 +-
 builtin/fsck.c                           |   6 +-
 builtin/fsmonitor--daemon.c              |   4 +-
 builtin/gc.c                             |   3 +-
 builtin/get-tar-commit-id.c              |   3 +-
 builtin/grep.c                           |   7 +-
 builtin/hash-object.c                    |   3 +-
 builtin/help.c                           |   3 +-
 builtin/hook.c                           |   1 -
 builtin/index-pack.c                     |   3 +-
 builtin/init-db.c                        | 474 +-------------------
 builtin/interpret-trailers.c             |   1 -
 builtin/log.c                            |   2 +-
 builtin/ls-files.c                       | 143 +-----
 builtin/ls-remote.c                      |   2 +-
 builtin/ls-tree.c                        |   6 +-
 builtin/mailinfo.c                       |   3 +-
 builtin/mailsplit.c                      |   1 -
 builtin/merge-base.c                     |   1 -
 builtin/merge-file.c                     |   1 -
 builtin/merge-index.c                    |   2 +
 builtin/merge-ours.c                     |   1 +
 builtin/merge-recursive.c                |   1 -
 builtin/merge-tree.c                     |   2 +-
 builtin/merge.c                          |   5 +-
 builtin/mktag.c                          |   3 +-
 builtin/mktree.c                         |   3 +-
 builtin/multi-pack-index.c               |   4 +-
 builtin/mv.c                             |   2 +
 builtin/name-rev.c                       |   1 +
 builtin/notes.c                          |   6 +-
 builtin/pack-objects.c                   |   2 +-
 builtin/pack-redundant.c                 |   2 +-
 builtin/patch-id.c                       |   2 +-
 builtin/prune.c                          |   7 +-
 builtin/pull.c                           |   6 +-
 builtin/push.c                           |   3 +-
 builtin/range-diff.c                     |   2 +-
 builtin/read-tree.c                      |   4 +-
 builtin/rebase.c                         |   1 +
 builtin/receive-pack.c                   |   3 +-
 builtin/reflog.c                         |   2 +
 builtin/remote.c                         |   3 +-
 builtin/repack.c                         |   3 +-
 builtin/replace.c                        |   7 +-
 builtin/rerere.c                         |   1 -
 builtin/reset.c                          |   3 +
 builtin/rev-list.c                       |   5 +-
 builtin/rev-parse.c                      |   6 +-
 builtin/revert.c                         |   1 +
 builtin/rm.c                             |   2 +
 builtin/shortlog.c                       |   2 +-
 builtin/show-branch.c                    |   4 +-
 builtin/show-index.c                     |   1 -
 builtin/show-ref.c                       |   3 +-
 builtin/sparse-checkout.c                |   1 -
 builtin/stash.c                          |   4 +
 builtin/stripspace.c                     |   1 -
 builtin/submodule--helper.c              |   7 +-
 builtin/symbolic-ref.c                   |   1 -
 builtin/tag.c                            |   6 +-
 builtin/unpack-file.c                    |   2 +-
 builtin/unpack-objects.c                 |   3 +-
 builtin/update-index.c                   |   5 +-
 builtin/update-ref.c                     |   3 +-
 builtin/update-server-info.c             |   3 +-
 builtin/upload-archive.c                 |   2 +-
 builtin/upload-pack.c                    |   2 +-
 builtin/verify-commit.c                  |   5 +-
 builtin/verify-pack.c                    |   2 +-
 builtin/verify-tag.c                     |   3 +-
 builtin/worktree.c                       |   5 +-
 builtin/write-tree.c                     |   1 -
 bulk-checkin.c                           |   2 +-
 bundle-uri.c                             |   2 +-
 bundle.c                                 |   2 +-
 cache-tree.c                             |   5 +-
 combine-diff.c                           |   2 +-
 commit-graph.c                           |   3 +-
 commit-graph.h                           |   2 +-
 commit.c                                 |   2 +-
 compat/fsmonitor/fsm-health-darwin.c     |   2 +-
 compat/fsmonitor/fsm-health-win32.c      |   4 +-
 compat/fsmonitor/fsm-ipc-darwin.c        |   3 +-
 compat/fsmonitor/fsm-listen-darwin.c     |   3 +-
 compat/fsmonitor/fsm-listen-win32.c      |   4 +-
 compat/fsmonitor/fsm-path-utils-darwin.c |   4 +-
 compat/fsmonitor/fsm-path-utils-win32.c  |   5 +-
 compat/fsmonitor/fsm-settings-darwin.c   |   2 +-
 compat/fsmonitor/fsm-settings-win32.c    |   4 +-
 compat/mingw.c                           |   1 -
 compat/precompose_utf8.c                 |   3 +-
 compat/sha1-chunked.c                    |   3 +-
 compat/simple-ipc/ipc-win32.c            |   2 +-
 compat/win32/trace2_win32_process_info.c |   2 +-
 config.c                                 |   5 +-
 connect.c                                |   1 +
 connected.c                              |   2 +-
 convert.c                                |   5 +-
 decorate.c                               |   1 -
 diagnose.c                               |   2 +-
 diff-lib.c                               |   5 +-
 diff.c                                   |   5 +-
 diff.h                                   |   6 +-
 diffcore-break.c                         |   4 +-
 diffcore-order.c                         |   1 +
 diffcore-pickaxe.c                       |   1 +
 diffcore-rename.c                        |   2 +-
 dir.c                                    |   8 +-
 dir.h                                    |   1 +
 entry.c                                  |   6 +-
 environment.c                            |   5 +-
 environment.h                            |   3 +-
 exec-cmd.c                               |   3 +-
 fetch-pack.c                             |   3 +-
 fmt-merge-msg.c                          |   3 +-
 fsck.c                                   |   4 +-
 fsmonitor-ipc.c                          |   4 +-
 fsmonitor-ll.h                           |  52 +++
 fsmonitor.c                              |   2 +-
 fsmonitor.h                              |  49 +--
 git-compat-util.h                        |   2 -
 git.c                                    |   1 +
 grep.c                                   |   2 +-
 hash-ll.h                                |  19 +
 hash-lookup.c                            |   3 +-
 hashmap.h                                |  21 -
 http-backend.c                           |   3 +-
 http-push.c                              |   2 +-
 http-walker.c                            |   2 +-
 http.c                                   |   2 +-
 khash.h                                  |   3 +-
 line-log.c                               |   1 +
 list-objects-filter-options.h            |   1 -
 list-objects-filter.c                    |   2 +-
 list-objects.c                           |   2 +-
 log-tree.c                               |   4 +-
 log-tree.h                               |   2 +-
 mailmap.c                                |   2 +-
 match-trees.c                            |   3 +-
 merge-blobs.c                            |   2 +-
 merge-ort-wrappers.c                     |   3 +-
 merge-ort.c                              |   7 +-
 merge-recursive.c                        |   7 +-
 merge.c                                  |   5 +-
 merge.h                                  |  17 +
 midx.c                                   |   2 +-
 name-hash.c                              |   5 +-
 name-hash.h                              |  16 +
 notes-cache.c                            |   3 +-
 notes-merge.c                            |   3 +-
 notes.c                                  |   2 +-
 object-file.c                            |   1 +
 object-name.c                            |   5 +-
 object-store-ll.h                        | 533 +++++++++++++++++++++++
 object-store.h                           | 528 +---------------------
 object.c                                 |   3 +-
 oidmap.h                                 |   1 +
 oss-fuzz/fuzz-pack-idx.c                 |   2 +-
 pack-bitmap-write.c                      |   3 +-
 pack-bitmap.c                            |   2 +-
 pack-check.c                             |   2 +-
 pack-mtimes.c                            |   3 +-
 pack-objects.h                           |   2 +-
 pack-revindex.c                          |   3 +-
 pack-write.c                             |   2 +
 packfile.c                               |   2 +-
 parallel-checkout.c                      |   3 +-
 patch-ids.c                              |   1 +
 path.c                                   |   2 +-
 pathspec.c                               |   4 +-
 preload-index.c                          |   4 +-
 preload-index.h                          |  15 +
 pretty.c                                 |   1 +
 promisor-remote.c                        |   2 +-
 protocol-caps.c                          |   2 +-
 prune-packed.c                           |   2 +-
 range-diff.c                             |   1 +
 reachable.c                              |   2 +-
 cache.h => read-cache-ll.h               | 148 +------
 read-cache.c                             | 331 ++++++++++----
 read-cache.h                             |  45 ++
 ref-filter.c                             |   2 +-
 reflog-walk.c                            |   1 +
 reflog.c                                 |   2 +-
 refs.c                                   |   4 +-
 refs/files-backend.c                     |   3 +-
 refs/packed-backend.c                    |   3 +-
 remote.c                                 |   3 +-
 remote.h                                 |   1 +
 replace-object.c                         |   2 +-
 replace-object.h                         |   2 +-
 repository.c                             |   6 +-
 repository.h                             |   8 +-
 rerere.c                                 |   6 +-
 resolve-undo.c                           |   4 +-
 revision.c                               |   7 +-
 run-command.c                            |   2 +-
 run-command.h                            |   4 +-
 send-pack.c                              |   2 +-
 sequencer.c                              |   7 +-
 serve.c                                  |   1 +
 server-info.c                            |   3 +-
 setup.c                                  | 480 ++++++++++++++++++++
 setup.h                                  |   9 +
 shallow.c                                |   6 +-
 sparse-index.c                           |   6 +-
 sparse-index.h                           |   2 +
 split-index.c                            |   3 +-
 statinfo.c                               |  87 ++++
 statinfo.h                               |  51 +++
 strbuf.c                                 |   1 +
 strbuf.h                                 |   4 -
 streaming.c                              |   2 +-
 submodule-config.c                       |   3 +-
 submodule.c                              |   6 +-
 t/helper/test-cache-tree.c               |   2 +-
 t/helper/test-dump-cache-tree.c          |   2 +-
 t/helper/test-dump-fsmonitor.c           |   2 +-
 t/helper/test-dump-split-index.c         |   3 +-
 t/helper/test-dump-untracked-cache.c     |   2 +-
 t/helper/test-fast-rebase.c              |   3 +-
 t/helper/test-fsmonitor-client.c         |   2 +-
 t/helper/test-hash-speed.c               |   2 +-
 t/helper/test-index-version.c            |   2 +-
 t/helper/test-lazy-init-name-hash.c      |   3 +-
 t/helper/test-pack-mtimes.c              |   2 +-
 t/helper/test-partial-clone.c            |   2 +-
 t/helper/test-path-utils.c               |   2 +-
 t/helper/test-read-cache.c               |   2 +-
 t/helper/test-read-graph.c               |   2 +-
 t/helper/test-read-midx.c                |   2 +-
 t/helper/test-ref-store.c                |   4 +-
 t/helper/test-repository.c               |   2 +-
 t/helper/test-revision-walking.c         |   1 +
 t/helper/test-scrap-cache-tree.c         |   2 +-
 t/helper/test-sha1.c                     |   2 +-
 t/helper/test-sha256.c                   |   2 +-
 t/helper/test-strcmp-offset.c            |   2 +-
 t/helper/test-wildmatch.c                |   1 +
 t/helper/test-write-cache.c              |   2 +-
 t/t1301-shared-repo.sh                   |  22 +
 t/t5606-clone-options.sh                 |  10 +
 tag.c                                    |   2 +-
 tmp-objdir.c                             |   3 +-
 trace2/tr2_cfg.c                         |   1 +
 transport-helper.c                       |   1 +
 transport.c                              |   2 +-
 tree-diff.c                              |   1 +
 tree-walk.c                              |   2 +-
 tree.c                                   |   2 +-
 unpack-trees.c                           |   6 +-
 unpack-trees.h                           |   2 +-
 upload-pack.c                            |   2 +-
 walker.c                                 |   3 +-
 worktree.c                               |   1 +
 wt-status.c                              |   5 +-
 xdiff-interface.c                        |   3 +-
 309 files changed, 2149 insertions(+), 1882 deletions(-)
 create mode 100644 fsmonitor-ll.h
 create mode 100644 merge.h
 create mode 100644 name-hash.h
 create mode 100644 object-store-ll.h
 create mode 100644 preload-index.h
 rename cache.h => read-cache-ll.h (79%)
 create mode 100644 read-cache.h
 create mode 100644 statinfo.c


base-commit: ca06ff8883c0c6ae9135d64692f71b41c2493346
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1525%2Fnewren%2Fheader-cleanup-5-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1525/newren/header-cleanup-5-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1525
-- 
gitgitgadget
