Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B93C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjEPGe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjEPGeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3FD1FE9
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so12812655e9.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218859; x=1686810859;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFuWRRlFmde+R3ayq93Lm5iYQmCCIC0i/ytoPZ8Tu+E=;
        b=GdO+oLwUNbKPUn4LVMSVUoA41Nh7gd+8QOnEHaMXcRyGjzM2qpzQI6AcEOpPo1Wpr3
         94IrVP08KISoobRFXP3kNs9Yc2/Unu5WF7THdw87vJBGTqP4CJNcE2enRYm2OoSfTSFg
         2aSGukcwUExCp0NcU0q018qpMSMl4pvjK64eE48AcqfTaNFRaH2/3PcKk6yBAfU8oAv/
         sToduehG4P92lobDw1WLwAae9CIQDnbkL7AKvp++7Dvit1b/CxwyWLuwV7iFIyoOV9uH
         ZOQ3uTmSituWYLr4mapxIPhEIe16jxkfEcOAUJpAA4Zfew+Of/gk5VQPe3MgAfSey+xm
         MG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218859; x=1686810859;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFuWRRlFmde+R3ayq93Lm5iYQmCCIC0i/ytoPZ8Tu+E=;
        b=GczYNzplosZ/UbTLWyL/NRWHWZEukFTlZKrcTazQq8xs7Ot79qVpWsvQcx/Rd8NXKq
         B547vRiV1TsHfInWAxFnzN1N0bTTGg7F9HGbPBkSWUS9qYNqAqyQ3m5fSumHGYXLvTyg
         TQmXI7kbJzPkTmBwTPgHo9TuYwgWbY4K1iG4bp4CYFM9PHMDHIKf/Ps6s4F/vebIb+8m
         0U8YvKtT6wEbdFYsPCoA9yMj6VGLwZik8VKnfTgB3oNHslQ10S5vF5qxmtYDbG+x8VhD
         ZXpCAh4qA7+dnnvSXFUHR+chyDP0OrZmiN/zHori65OFz5m6LyJqqlJkOd5pBYAey8/L
         l9Wg==
X-Gm-Message-State: AC+VfDwQGe7ITEI5quNUX9mXUWuu8C8bQtV5U6LeBjpxBLALu2miZVwY
        2DGt5AdUqXmqofNaAEJ3n8Zj/e//rHQ=
X-Google-Smtp-Source: ACHHUZ5Wn+Y9jpb65xPbmLTKDAEMv80VTP+DHZ/8H57pCiyKWYBY2O2qm56rpyIufvA2ZtITFXyB9A==
X-Received: by 2002:a05:600c:2197:b0:3f4:2158:28a0 with SMTP id e23-20020a05600c219700b003f4215828a0mr20125835wme.12.1684218858989;
        Mon, 15 May 2023 23:34:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x3-20020a1c7c03000000b003f180d5b145sm1094375wmc.40.2023.05.15.23.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:18 -0700 (PDT)
Message-Id: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:33:40 +0000
Subject: [PATCH v3 00/28] Header cleanups (final splitting of cache.h, and some splitting of other
 headers)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Summary ==

This series continues to focus on splitting declarations from cache.h to
separate headers, and also cleans up some other small header issues. By
patch 17, cache.h is gone.

== Changes ==

Since v2 (thanks to Jonathan Tan for feedback and suggestions!)

 * Wording fixes & improvements suggested by Jonathan
 * Pulled another line from the oidhash() patch (27) into the khash patch
   (25) to make it easier to review
 * Split the old patch 26 into two. Somehow my object-ll and hash-ll changes
   got smashed into the same patch (before v1), and I didn't notice until
   after v2 was sent out. Split them out two separate patches to make them
   easier to review.

Since v1 (thanks to Calvin, Glen, Junio, and Peff for feedback and
suggestions!)

 * Split the first patch into two, correct the explanation around existing
   bug, and tweak how global is removed
 * New patch 24 to rename ll-merge.[ch] to merge-ll.[ch]
 * Patch 25 split out of the old patch 23 to document the khash.h change in
   isolation

== Reviewer Focus (see also "Overview" section, below) ==

While the series may look long and big, it's really mostly just (a) moving
lots of code (so --color-moved is handy), and (b) adding (or removing)
includes repeatedly throughout the code. These are just more of the same
kinds of changes from the previous series.

However, there are a few exceptions that do not fit in these two categories,
which should be reviewed more closely:

 * Patches 1-3 & 6
 * Patch 17, the Documentation and Makefile changes
 * Patch 24 & 27

Patches 11 & 28 might also merit a little closer review.

== Maintainer notes from v1 ==

(1) This series is built on top of a merge of en/header-split-cache-h-part-2
into master, (2) This series has no conflicts with next, but has three
simple & small conflicts with seen:

 * a textual conflict with tl/notes-separator (affecting builtin/notes.c; to
   address, nuke the conflict region and add an include of alloc.h after
   builtin.h)
 * a textual & semantic conflict with cw/strbuf-cleanup (affecting strbuf.c;
   to address, delete the conflict region and also delete the include of
   repository.h)
 * a semantic conflict with rn/sparse-diff-index (affecting
   builtin/diff-index.c; to address, add an include of sparse-index.h).

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

 * Patches 1-7: move shared code between various builtin/*.c files into
   alternate shared homes (setup.c, read-cache.c).
 * Patches 8-17: continue splitting declarations from cache.h into
   alternative headers associated with the actual implementation of those
   functions.
 * Patches 18-23: remove some unnecessary includes in other header files
 * Patch 24: rename ll-merge for consistency, and to get a better name
 * Patches 25-28: do some header shuffling with hashmap/khash/hash, and
   fsmonitor to reduce include depths

I would have just lumped patches 1-7 in with 8-17, but patches 1-3, & 6 did
some preliminary changes to allow the code movement.

== Acknowledgements ==

And thanks once again to Dscho for gitgitgadget. Getting multiple platform
testing + all the special tests (sparse, cocci, hdr-check, etc.) really
helps clean out all the issues that would otherwise hit a series like this.

Elijah Newren (28):
  init-db: document existing bug with core.bare in template config
  init-db: remove unnecessary global variable
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
  merge-ll: rename from ll-merge
  khash: name the structs that khash declares
  object-store-ll.h: split this header out of object-store.h
  hash-ll, hashmap: move oidhash() to hash-ll
  fsmonitor-ll.h: split this header out of fsmonitor.h

 Documentation/CodingGuidelines           |   2 +-
 Documentation/MyFirstObjectWalk.txt      |   2 +-
 Documentation/technical/api-merge.txt    |   4 +-
 Documentation/user-manual.txt            |  18 +-
 Makefile                                 |   5 +-
 add-interactive.c                        |   6 +-
 add-patch.c                              |   4 +-
 apply.c                                  |  10 +-
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
 builtin/checkout.c                       |   9 +-
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
 convert.c                                |   7 +-
 decorate.c                               |   1 -
 diagnose.c                               |   2 +-
 diff-lib.c                               |   5 +-
 diff.c                                   |   7 +-
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
 merge-blobs.c                            |   4 +-
 ll-merge.c => merge-ll.c                 |   2 +-
 ll-merge.h => merge-ll.h                 |   0
 merge-ort-wrappers.c                     |   3 +-
 merge-ort.c                              |   9 +-
 merge-recursive.c                        |   9 +-
 merge.c                                  |   5 +-
 merge.h                                  |  17 +
 midx.c                                   |   2 +-
 name-hash.c                              |   5 +-
 name-hash.h                              |  16 +
 notes-cache.c                            |   3 +-
 notes-merge.c                            |   5 +-
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
 rerere.c                                 |   8 +-
 resolve-undo.c                           |   4 +-
 revision.c                               |   7 +-
 run-command.c                            |   2 +-
 run-command.h                            |   4 +-
 send-pack.c                              |   2 +-
 sequencer.c                              |   7 +-
 serve.c                                  |   1 +
 server-info.c                            |   3 +-
 setup.c                                  | 497 +++++++++++++++++++++
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
 312 files changed, 2179 insertions(+), 1895 deletions(-)
 create mode 100644 fsmonitor-ll.h
 rename ll-merge.c => merge-ll.c (99%)
 rename ll-merge.h => merge-ll.h (100%)
 create mode 100644 merge.h
 create mode 100644 name-hash.h
 create mode 100644 object-store-ll.h
 create mode 100644 preload-index.h
 rename cache.h => read-cache-ll.h (79%)
 create mode 100644 read-cache.h
 create mode 100644 statinfo.c


base-commit: ca06ff8883c0c6ae9135d64692f71b41c2493346
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1525%2Fnewren%2Fheader-cleanup-5-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1525/newren/header-cleanup-5-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1525

Range-diff vs v2:

  1:  f7ee69e7e68 !  1:  5b39c530f2a init-db: document existing bug with core.bare in template config
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
      +	 *
      +	 * To see why, note that before this function, there was this call:
      +	 *    init_is_bare_repository = is_bare_repository()
     -+	 * expanding the right hande side:
     ++	 * expanding the right hand side:
      +	 *                 = is_bare_repository_cfg && !get_git_work_tree()
      +	 *                 = is_bare_repository_cfg && !work_tree
      +	 * note that the last simplification above is valid because nothing
  2:  5ba9d6e68ad !  2:  93067838fb2 init-db: remove unnecessary global variable
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
       	 * To see why, note that before this function, there was this call:
      -	 *    init_is_bare_repository = is_bare_repository()
      +	 *    prev_bare_repository = is_bare_repository()
     - 	 * expanding the right hande side:
     + 	 * expanding the right hand side:
       	 *                 = is_bare_repository_cfg && !get_git_work_tree()
       	 *                 = is_bare_repository_cfg && !work_tree
      @@ builtin/init-db.c: static int create_default_files(const char *template_path,
  3:  3bc4dfeea90 !  3:  28c8f4a29a8 init-db, clone: change unnecessary global into passed parameter
     @@ Metadata
       ## Commit message ##
          init-db, clone: change unnecessary global into passed parameter
      
     -    Much like the former commit, this commit was prompted by a desire to
     +    Much like the parent commit, this commit was prompted by a desire to
          move the functions which builtin/init-db.c and builtin/clone.c share out
          of the former file and into setup.c.  A secondary issue that made it
          difficult was the init_shared_repository global variable; replace it
  4:  60d01387f41 !  4:  fc1272c981e setup: adopt shared init-db & clone code
     @@ builtin/init-db.c
      -	 *
      -	 * To see why, note that before this function, there was this call:
      -	 *    prev_bare_repository = is_bare_repository()
     --	 * expanding the right hande side:
     +-	 * expanding the right hand side:
      -	 *                 = is_bare_repository_cfg && !get_git_work_tree()
      -	 *                 = is_bare_repository_cfg && !work_tree
      -	 * note that the last simplification above is valid because nothing
     @@ setup.c: int daemonize(void)
      +	 *
      +	 * To see why, note that before this function, there was this call:
      +	 *    prev_bare_repository = is_bare_repository()
     -+	 * expanding the right hande side:
     ++	 * expanding the right hand side:
      +	 *                 = is_bare_repository_cfg && !get_git_work_tree()
      +	 *                 = is_bare_repository_cfg && !work_tree
      +	 * note that the last simplification above is valid because nothing
  5:  ced75f46444 =  5:  1979b5dbfd7 read-cache: move shared commit and ls-files code
  6:  13d6dd1095c =  6:  8f7d82ce1c8 add: modify add_files_to_cache() to avoid globals
  7:  63058d44595 =  7:  f95d5aebd4a read-cache: move shared add/checkout/commit code
  8:  39e5f6ca470 =  8:  fc6286718d4 statinfo: move stat_{data,validity} functions from cache/read-cache
  9:  f56714080b1 =  9:  706e02727fc run-command.h: move declarations for run-command.c from cache.h
 10:  7d48dbfe0aa = 10:  d8b396bd633 name-hash.h: move declarations for name-hash.c from cache.h
 11:  f46aa5e73a1 = 11:  18cdefc5667 sparse-index.h: move declarations for sparse-index.c from cache.h
 12:  b16c4d3429e = 12:  19226c30cdf preload-index.h: move declarations for preload-index.c from elsewhere
 13:  c8f873d71f5 = 13:  2be96fbbe56 diff.h: move declaration for global in diff.c from cache.h
 14:  77c3c5918b8 = 14:  8a940282299 merge.h: move declarations for merge.c from cache.h
 15:  abfb127b812 = 15:  c8d8032c75c repository.h: move declaration of the_index from cache.h
 16:  41183b7baed = 16:  117706f63d2 read-cache*.h: move declarations for read-cache.c functions from cache.h
 17:  8f021be54e0 = 17:  a9ceb3a122a cache.h: remove this no-longer-used header
 18:  ea21839a95a = 18:  beb4287dd65 log-tree: replace include of revision.h with simple forward declaration
 19:  bd70d3fe730 = 19:  3e8ae022927 repository: remove unnecessary include of path.h
 20:  a438cfbb095 = 20:  127f4fca309 diff.h: remove unnecessary include of oidset.h
 21:  b8f302184fa = 21:  b9231a414f2 list-objects-filter-options.h: remove unneccessary include
 22:  1d3d33a843b = 22:  452254dbce0 builtin.h: remove unneccessary includes
 23:  7849fea5fa4 = 23:  fe631d90b4f git-compat-util.h: remove unneccessary include of wildmatch.h
 24:  97d04efde7b = 24:  35703377580 merge-ll: rename from ll-merge
 25:  e0bfeb98556 ! 25:  6de1eebfea6 khash: name the structs that khash declares
     @@ khash.h: static inline khint_t __ac_X31_hash_string(const char *s)
       		khint_t n_buckets, size, n_occupied, upper_bound; \
       		khint32_t *flags; \
       		khkey_t *keys; \
     +
     + ## object-store.h ##
     +@@ object-store.h: struct raw_object_store {
     + 	 */
     + 	struct object_directory *odb;
     + 	struct object_directory **odb_tail;
     +-	kh_odb_path_map_t *odb_by_path;
     ++	struct kh_odb_path_map *odb_by_path;
     + 
     + 	int loaded_alternates;
     + 
 26:  41d48379b3d ! 26:  264d64011bd hash-ll, hashmap: move oidhash() to hash-ll
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    hash-ll, hashmap: move oidhash() to hash-ll
     +    object-store-ll.h: split this header out of object-store.h
      
     -    oidhash() was used by both hashmap and khash, which makes sense.
     -    However, the location of this function in hashmap.[ch] meant that
     -    khash.h had to depend upon hashmap.h, making people unfamiliar with
     -    khash think that it was built upon hashmap.  (Or at least, I personally
     -    was confused for a while about this in the past.)
     +    The vast majority of files including object-store.h did not need dir.h
     +    nor khash.h.  Split the header into two files, and let most just depend
     +    upon object-store-ll.h, while letting the two callers that need it
     +    depend on the full object-store.h.
      
     -    Move this function to hash-ll, so that khash.h can stop depending upon
     -    hashmap.h.
     +    After this patch:
     +        $ git grep -h include..object-store | sort | uniq -c
     +              2 #include "object-store.h"
     +            129 #include "object-store-ll.h"
      
     -    This has another benefit as well: it allows us to remove hashmap.h's
     -    dependency on hash-ll.h.  While some callers of hashmap.h were making
     -    use of oidhash, most were not, so this change provides another way to
     -    reduce the number of includes.
     -
     -    Diff best viewed with `--color-moved`.  Note that there's a small but
     -    important change to khash.h in this patch as well to allow this move,
     -    which is easy to overlook.
     +    Diff best viewed with `--color-moved`.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ convert.c
       #include "run-command.h"
       #include "quote.h"
      
     - ## decorate.c ##
     -@@
     -  * data.
     -  */
     - #include "git-compat-util.h"
     --#include "hashmap.h"
     - #include "object.h"
     - #include "decorate.h"
     - 
     -
       ## diagnose.c ##
      @@
       #include "gettext.h"
     @@ dir.c
       #include "attr.h"
       #include "refs.h"
      
     - ## dir.h ##
     -@@
     - #ifndef DIR_H
     - #define DIR_H
     - 
     -+#include "hash-ll.h"
     - #include "hashmap.h"
     - #include "pathspec.h"
     - #include "statinfo.h"
     -
       ## entry.c ##
      @@
       #include "git-compat-util.h"
     @@ grep.c
       #include "userdiff.h"
       #include "xdiff-interface.h"
      
     - ## hash-ll.h ##
     -@@ hash-ll.h: static inline void oid_set_algo(struct object_id *oid, const struct git_hash_alg
     - 	oid->algo = hash_algo_by_ptr(algop);
     - }
     - 
     -+/*
     -+ * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
     -+ * for use in hash tables. Cryptographic hashes are supposed to have
     -+ * uniform distribution, so in contrast to `memhash()`, this just copies
     -+ * the first `sizeof(int)` bytes without shuffling any bits. Note that
     -+ * the results will be different on big-endian and little-endian
     -+ * platforms, so they should not be stored or transferred over the net.
     -+ */
     -+static inline unsigned int oidhash(const struct object_id *oid)
     -+{
     -+	/*
     -+	 * Equivalent to 'return *(unsigned int *)oid->hash;', but safe on
     -+	 * platforms that don't support unaligned reads.
     -+	 */
     -+	unsigned int hash;
     -+	memcpy(&hash, oid->hash, sizeof(hash));
     -+	return hash;
     -+}
     -+
     - const char *empty_tree_oid_hex(void);
     - const char *empty_blob_oid_hex(void);
     - 
     -
     - ## hashmap.h ##
     -@@
     - #ifndef HASHMAP_H
     - #define HASHMAP_H
     - 
     --#include "hash-ll.h"
     --
     - /*
     -  * Generic implementation of hash-based key-value mappings.
     -  *
     -@@ hashmap.h: unsigned int memhash(const void *buf, size_t len);
     - unsigned int memihash(const void *buf, size_t len);
     - unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len);
     - 
     --/*
     -- * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
     -- * for use in hash tables. Cryptographic hashes are supposed to have
     -- * uniform distribution, so in contrast to `memhash()`, this just copies
     -- * the first `sizeof(int)` bytes without shuffling any bits. Note that
     -- * the results will be different on big-endian and little-endian
     -- * platforms, so they should not be stored or transferred over the net.
     -- */
     --static inline unsigned int oidhash(const struct object_id *oid)
     --{
     --	/*
     --	 * Equivalent to 'return *(unsigned int *)oid->hash;', but safe on
     --	 * platforms that don't support unaligned reads.
     --	 */
     --	unsigned int hash;
     --	memcpy(&hash, oid->hash, sizeof(hash));
     --	return hash;
     --}
     --
     - /*
     -  * struct hashmap_entry is an opaque structure representing an entry in the
     -  * hash table.
     -
       ## http-backend.c ##
      @@
       #include "url.h"
     @@ http.c
       static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
       static int trace_curl_data = 1;
      
     - ## khash.h ##
     -@@
     - #ifndef __AC_KHASH_H
     - #define __AC_KHASH_H
     - 
     --#include "hashmap.h"
     - #include "hash.h"
     - 
     - #define AC_VERSION_KHASH_H "0.2.8"
     -
       ## list-objects-filter.c ##
      @@
       #include "oidmap.h"
     @@ object-store.h
      -	 */
      -	struct object_directory *odb;
      -	struct object_directory **odb_tail;
     --	kh_odb_path_map_t *odb_by_path;
     +-	struct kh_odb_path_map *odb_by_path;
      -
      -	int loaded_alternates;
      -
     @@ remote.c
       #include "commit.h"
       #include "diff.h"
      
     - ## remote.h ##
     -@@
     - #ifndef REMOTE_H
     - #define REMOTE_H
     - 
     -+#include "hash-ll.h"
     - #include "hashmap.h"
     - #include "refspec.h"
     - 
     -
       ## replace-object.c ##
      @@
       #include "gettext.h"
     @@ sequencer.c
       #include "pager.h"
       #include "commit.h"
      
     - ## serve.c ##
     -@@
     - #include "git-compat-util.h"
     - #include "repository.h"
     - #include "config.h"
     -+#include "hash-ll.h"
     - #include "pkt-line.h"
     - #include "version.h"
     - #include "ls-refs.h"
     -
       ## server-info.c ##
      @@
       #include "packfile.h"
  -:  ----------- > 27:  d6057718fde hash-ll, hashmap: move oidhash() to hash-ll
 27:  bbe64fccd52 = 28:  7b853c9e440 fsmonitor-ll.h: split this header out of fsmonitor.h

-- 
gitgitgadget
