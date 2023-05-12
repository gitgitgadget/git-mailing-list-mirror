Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66056C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbjELHE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbjELHEo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:04:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA126E89
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so68143445e9.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875078; x=1686467078;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvF7JxdJFoBnmCF1EM2P0nTMQHUmijkCtVGLVQr4BOw=;
        b=nhVxNZYAayKJNajuvdyY3+W0AZeOGUub7FDUQiBiraeFhea2FnJ3vdV3MLYJUrTuVc
         0gIoK0uayRYSa92RviHSeiSouS7nBTazoFcSg7OSM4fOaShEGtbZL5yswLfP+ozMOgwC
         aJaYRECiqQbETevds4Z3xWBaBc6K8pLb4Y58jxmSqIz4FvVAwqoPYpW49IXSurt7yETk
         AAJjd3bfbqxb972gy5UpBNTQi1XIxpfVwKz5ctF0eazoM4sd3YB/5+WVW2Cr8kSxBvZS
         E1DTaKetH3e9ImarBz1d1qNLN8k2nXV2PPtVXML4jiGtFa6P1UajuWmeF1gsfXeptQ9M
         huXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875078; x=1686467078;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvF7JxdJFoBnmCF1EM2P0nTMQHUmijkCtVGLVQr4BOw=;
        b=g5jAXmCs7xmgFMsjb/Sitz7EuO4HyLTYvyz648tzKd2xyFOBS1AMB8eUZyO2vwtjfz
         f3Fs1vTqHMo4wi9H0XPITheJqFAbToctY9moYa+vmv+PIkC0bkvv9n055QMGaMf09aEs
         jW2h3sO5rThVPGdpb5x0pajxE5hCWQdJ6O3bXHV/SDe85wBLcY0fTj3S8Xl88ArLuX0y
         wsIBAaXhgvrgHcYsFsGFqyuR1OK+S7yLs76Uk7o+eTLLjHloEJGCoalVk9ZHo5/IwND1
         VH8DHaMB2v1EP31J+uckmp/dgQK5dNmeMQM/VTsmR3kTjPnTNdWgJ3yXyvjIMDOvjjpq
         3NEw==
X-Gm-Message-State: AC+VfDxiYEm6XjFL5frf2SpIXDdaRpBLCrv1J0fdqYMO8g3TsdpEgH3g
        CRVIS7u+iHY0LLHMZWqwouQ4b9vr3d8=
X-Google-Smtp-Source: ACHHUZ70be2/7Hc9lgxC6X6BBIVSUu9X/J+Doh1tlZbDkj+Z+/0VDbaRIlfnHW6BJ8RuvWZIiTyDNw==
X-Received: by 2002:adf:dbc7:0:b0:307:a5cb:fe69 with SMTP id e7-20020adfdbc7000000b00307a5cbfe69mr9377057wrj.57.1683875078147;
        Fri, 12 May 2023 00:04:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000050600b003079c402762sm13162537wrf.19.2023.05.12.00.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:37 -0700 (PDT)
Message-Id: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:01 +0000
Subject: [PATCH v2 00/27] Header cleanups (final splitting of cache.h, and some splitting of other
 headers)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Summary ==

This series continues to focus on splitting declarations from cache.h to
separate headers, and also cleans up some other small header issues. By
patch 17, cache.h is gone.

== Changes ==

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
 * Patch 24 & 25

Patches 11 & 26 might also merit a little closer review.

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
 * Patches 25-27: do some header shuffling with hashmap/khash/hash, and
   fsmonitor to reduce include depths

I would have just lumped patches 1-7 in with 8-17, but patches 1-3, & 6 did
some preliminary changes to allow the code movement.

== Acknowledgements ==

And thanks once again to Dscho for gitgitgadget. Getting multiple platform
testing + all the special tests (sparse, cocci, hdr-check, etc.) really
helps clean out all the issues that would otherwise hit a series like this.

Elijah Newren (27):
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1525%2Fnewren%2Fheader-cleanup-5-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1525/newren/header-cleanup-5-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1525

Range-diff vs v1:

  1:  12a251f77f6 !  1:  f7ee69e7e68 init-db: remove unnecessary global variable & document existing bug
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    init-db: remove unnecessary global variable & document existing bug
     +    init-db: document existing bug with core.bare in template config
      
     -    This commit was prompted by a desire to move the functions which
     -    builtin/init-db.c and builtin/clone.c share out of the former file and
     -    into setup.c.  One issue that made it difficult was the
     -    init_is_bare_repository global variable.
     +    The comments in create_default_files() talks about reading config from
     +    the config file in the specified `--templates` directory, which leads to
     +    the question of whether core.bare could be set in such a config file and
     +    thus whether the code is doing the right thing.  It turns out, that it
     +    doesn't; it unconditionally ignores core.bare in the config file in any
     +    --templates directory.  It is not clear to me that fixing it can be done
     +    within this function; it seems to occur too late:
     +      * create_default_files() is called by init_db()
     +      * init_db() is called by both builtin/{clone.c,init-db.c}
     +      * both callers of init_db() call set_git_work_tree() before init_db()
     +    and in order to actual affect whether a repository is bear, we'd need to
     +    somewhere reset these values, not just the is_bare_repository_cfg
     +    setting.
      
     -    init_is_bare_repository is actually not very useful.  It merely stores
     -    the return value from is_bare_repository() and only for the duration of
     -    a few additional function calls before its value is checked, and none of
     -    those functions do anything that could change is_bare_repository()'s
     -    return value.  So, we can simply dispense with the global by replacing
     -    it with is_bare_repository().
     -
     -    However, the intervening code does talk about reading config from the
     -    config file in the specified `--templates` directory, so touching this
     -    code does lead to the question of whether core.bare could be set in such
     -    a config file and thus whether the code is doing the right thing.  Long
     -    story short is that the templates directory might have a config file
     -    with core.bare set, but it has always been unconditionally ignored.
     -    While fixing that might be nice, it looks to be a can of worms, and
     -    cannot be fixed within this function anyway.  Instead of opening that
     -    can of worms, document the problem with a TODO comment and a couple
     -    test_expect_failure testcases.
     +    I do not want to open this can of worms at this time; I'm trying to
     +    clean up some headers, for which I need to move some functions, for
     +    which I need to clean up some globals, and that's far enough down the
     +    rabbit hole.  So, simply document the issue with a careful TODO comment
     +    and a few testcases.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/init-db.c ##
     -@@
     - 
     - #define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
     - 
     --static int init_is_bare_repository = 0;
     - static int init_shared_repository = -1;
     - 
     - static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
      @@ builtin/init-db.c: static int create_default_files(const char *template_path,
       	 * We must make sure command-line options continue to override any
       	 * values we might have just re-read from the config.
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
      +	/*
      +	 * TODO: heed core.bare from config file in templates if no
      +	 *       command-line override given
     ++	 */
     ++	is_bare_repository_cfg = init_is_bare_repository || !work_tree;
     ++	/* TODO (continued):
     ++	 *
     ++	 * Unfortunately, the line above is equivalent to
     ++	 *    is_bare_repository_cfg = !work_tree;
     ++	 * which ignores the config entirely even if no `--[no-]bare`
     ++	 * command line option was present.
      +	 *
     -+	 * Unfortunately, this location in the code is far too late to
     -+	 * allow this to happen; both builtin/init.db and
     -+	 * builtin/clone.c setup the new repository and call
     -+	 * set_git_work_tree() before this point.  (Note that both do
     -+	 * that repository setup before calling init_db(), which in
     -+	 * turn calls create_default_files().)  Fixing it would
     -+	 * require too much refactoring, and no one seems to have
     -+	 * wanted this behavior in 15+ years, so we'll continue
     -+	 * ignoring the config for now and just override
     -+	 * is_bare_repository_cfg unconditionally.
     ++	 * To see why, note that before this function, there was this call:
     ++	 *    init_is_bare_repository = is_bare_repository()
     ++	 * expanding the right hande side:
     ++	 *                 = is_bare_repository_cfg && !get_git_work_tree()
     ++	 *                 = is_bare_repository_cfg && !work_tree
     ++	 * note that the last simplification above is valid because nothing
     ++	 * calls repo_init() or set_git_work_tree() between any of the
     ++	 * relevant calls in the code, and thus the !get_git_work_tree()
     ++	 * calls will return the same result each time.  So, what we are
     ++	 * interested in computing is the right hand side of the line of
     ++	 * code just above this comment:
     ++	 *     init_is_bare_repository || !work_tree
     ++	 *        = is_bare_repository_cfg && !work_tree || !work_tree
     ++	 *        = !work_tree
     ++	 * because "A && !B || !B == !B" for all boolean values of A & B.
      +	 */
     -+	is_bare_repository_cfg = is_bare_repository() || !work_tree;
       
       	/*
       	 * We would have created the above under user's umask -- under
     -@@ builtin/init-db.c: int init_db(const char *git_dir, const char *real_git_dir,
     - 
     - 	safe_create_dir(git_dir, 0);
     - 
     --	init_is_bare_repository = is_bare_repository();
     --
     - 	/* Check to see if the repository version is right.
     - 	 * Note that a newly created repository does not have
     - 	 * config file, so this will not fail.  What we are catching
      
       ## t/t1301-shared-repo.sh ##
      @@ t/t1301-shared-repo.sh: test_expect_success 'shared=all' '
  -:  ----------- >  2:  5ba9d6e68ad init-db: remove unnecessary global variable
  2:  e3cc7eb145e !  3:  3bc4dfeea90 init-db, clone: change unnecessary global into passed parameter
     @@ builtin/init-db.c
       			     DIR *dir)
       {
      @@ builtin/init-db.c: static int create_default_files(const char *template_path,
     - 				const char *original_git_dir,
       				const char *initial_branch,
       				const struct repository_format *fmt,
     + 				int prev_bare_repository,
      +				int init_shared_repository,
       				int quiet)
       {
     @@ builtin/init-db.c: static void validate_hash_algorithm(struct repository_format
       	int reinit;
       	int exist_ok = flags & INIT_DB_EXIST_OK;
      @@ builtin/init-db.c: int init_db(const char *git_dir, const char *real_git_dir,
     - 
       	reinit = create_default_files(template_dir, original_git_dir,
       				      initial_branch, &repo_fmt,
     + 				      prev_bare_repository,
      +				      init_shared_repository,
       				      flags & INIT_DB_QUIET);
       	if (reinit && initial_branch)
  3:  dffbac9a494 !  4:  60d01387f41 setup: adopt shared init-db & clone code
     @@ builtin/init-db.c
      -				const char *original_git_dir,
      -				const char *initial_branch,
      -				const struct repository_format *fmt,
     +-				int prev_bare_repository,
      -				int init_shared_repository,
      -				int quiet)
      -{
     @@ builtin/init-db.c
      -	/*
      -	 * TODO: heed core.bare from config file in templates if no
      -	 *       command-line override given
     +-	 */
     +-	is_bare_repository_cfg = prev_bare_repository || !work_tree;
     +-	/* TODO (continued):
     +-	 *
     +-	 * Unfortunately, the line above is equivalent to
     +-	 *    is_bare_repository_cfg = !work_tree;
     +-	 * which ignores the config entirely even if no `--[no-]bare`
     +-	 * command line option was present.
      -	 *
     --	 * Unfortunately, this location in the code is far too late to
     --	 * allow this to happen; both builtin/init.db and
     --	 * builtin/clone.c setup the new repository and call
     --	 * set_git_work_tree() before this point.  (Note that both do
     --	 * that repository setup before calling init_db(), which in
     --	 * turn calls create_default_files().)  Fixing it would
     --	 * require too much refactoring, and no one seems to have
     --	 * wanted this behavior in 15+ years, so we'll continue
     --	 * ignoring the config for now and just override
     --	 * is_bare_repository_cfg unconditionally.
     +-	 * To see why, note that before this function, there was this call:
     +-	 *    prev_bare_repository = is_bare_repository()
     +-	 * expanding the right hande side:
     +-	 *                 = is_bare_repository_cfg && !get_git_work_tree()
     +-	 *                 = is_bare_repository_cfg && !work_tree
     +-	 * note that the last simplification above is valid because nothing
     +-	 * calls repo_init() or set_git_work_tree() between any of the
     +-	 * relevant calls in the code, and thus the !get_git_work_tree()
     +-	 * calls will return the same result each time.  So, what we are
     +-	 * interested in computing is the right hand side of the line of
     +-	 * code just above this comment:
     +-	 *     prev_bare_repository || !work_tree
     +-	 *        = is_bare_repository_cfg && !work_tree || !work_tree
     +-	 *        = !work_tree
     +-	 * because "A && !B || !B == !B" for all boolean values of A & B.
      -	 */
     --	is_bare_repository_cfg = is_bare_repository() || !work_tree;
      -
      -	/*
      -	 * We would have created the above under user's umask -- under
     @@ builtin/init-db.c
      -	int exist_ok = flags & INIT_DB_EXIST_OK;
      -	char *original_git_dir = real_pathdup(git_dir, 1);
      -	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
     +-	int prev_bare_repository;
      -
      -	if (real_git_dir) {
      -		struct stat st;
     @@ builtin/init-db.c
      -
      -	safe_create_dir(git_dir, 0);
      -
     +-	prev_bare_repository = is_bare_repository();
     +-
      -	/* Check to see if the repository version is right.
      -	 * Note that a newly created repository does not have
      -	 * config file, so this will not fail.  What we are catching
     @@ builtin/init-db.c
      -
      -	reinit = create_default_files(template_dir, original_git_dir,
      -				      initial_branch, &repo_fmt,
     +-				      prev_bare_repository,
      -				      init_shared_repository,
      -				      flags & INIT_DB_QUIET);
      -	if (reinit && initial_branch)
     @@ setup.c: int daemonize(void)
      +				const char *original_git_dir,
      +				const char *initial_branch,
      +				const struct repository_format *fmt,
     ++				int prev_bare_repository,
      +				int init_shared_repository,
      +				int quiet)
      +{
     @@ setup.c: int daemonize(void)
      +	/*
      +	 * TODO: heed core.bare from config file in templates if no
      +	 *       command-line override given
     ++	 */
     ++	is_bare_repository_cfg = prev_bare_repository || !work_tree;
     ++	/* TODO (continued):
     ++	 *
     ++	 * Unfortunately, the line above is equivalent to
     ++	 *    is_bare_repository_cfg = !work_tree;
     ++	 * which ignores the config entirely even if no `--[no-]bare`
     ++	 * command line option was present.
      +	 *
     -+	 * Unfortunately, this location in the code is far too late to
     -+	 * allow this to happen; both builtin/init.db and
     -+	 * builtin/clone.c setup the new repository and call
     -+	 * set_git_work_tree() before this point.  (Note that both do
     -+	 * that repository setup before calling init_db(), which in
     -+	 * turn calls create_default_files().)  Fixing it would
     -+	 * require too much refactoring, and no one seems to have
     -+	 * wanted this behavior in 15+ years, so we'll continue
     -+	 * ignoring the config for now and just override
     -+	 * is_bare_repository_cfg unconditionally.
     ++	 * To see why, note that before this function, there was this call:
     ++	 *    prev_bare_repository = is_bare_repository()
     ++	 * expanding the right hande side:
     ++	 *                 = is_bare_repository_cfg && !get_git_work_tree()
     ++	 *                 = is_bare_repository_cfg && !work_tree
     ++	 * note that the last simplification above is valid because nothing
     ++	 * calls repo_init() or set_git_work_tree() between any of the
     ++	 * relevant calls in the code, and thus the !get_git_work_tree()
     ++	 * calls will return the same result each time.  So, what we are
     ++	 * interested in computing is the right hand side of the line of
     ++	 * code just above this comment:
     ++	 *     prev_bare_repository || !work_tree
     ++	 *        = is_bare_repository_cfg && !work_tree || !work_tree
     ++	 *        = !work_tree
     ++	 * because "A && !B || !B == !B" for all boolean values of A & B.
      +	 */
     -+	is_bare_repository_cfg = is_bare_repository() || !work_tree;
      +
      +	/*
      +	 * We would have created the above under user's umask -- under
     @@ setup.c: int daemonize(void)
      +	int exist_ok = flags & INIT_DB_EXIST_OK;
      +	char *original_git_dir = real_pathdup(git_dir, 1);
      +	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
     ++	int prev_bare_repository;
      +
      +	if (real_git_dir) {
      +		struct stat st;
     @@ setup.c: int daemonize(void)
      +
      +	safe_create_dir(git_dir, 0);
      +
     ++	prev_bare_repository = is_bare_repository();
     ++
      +	/* Check to see if the repository version is right.
      +	 * Note that a newly created repository does not have
      +	 * config file, so this will not fail.  What we are catching
     @@ setup.c: int daemonize(void)
      +
      +	reinit = create_default_files(template_dir, original_git_dir,
      +				      initial_branch, &repo_fmt,
     ++				      prev_bare_repository,
      +				      init_shared_repository,
      +				      flags & INIT_DB_QUIET);
      +	if (reinit && initial_branch)
  4:  d5a5b511f6d =  5:  ced75f46444 read-cache: move shared commit and ls-files code
  5:  30989571ac3 =  6:  13d6dd1095c add: modify add_files_to_cache() to avoid globals
  6:  0205f716a5a =  7:  63058d44595 read-cache: move shared add/checkout/commit code
  7:  e7b5b66c10c =  8:  39e5f6ca470 statinfo: move stat_{data,validity} functions from cache/read-cache
  8:  7892ef891ed =  9:  f56714080b1 run-command.h: move declarations for run-command.c from cache.h
  9:  fe50a0d0e77 = 10:  7d48dbfe0aa name-hash.h: move declarations for name-hash.c from cache.h
 10:  a4998e88790 = 11:  f46aa5e73a1 sparse-index.h: move declarations for sparse-index.c from cache.h
 11:  c39e4bdbfaf = 12:  b16c4d3429e preload-index.h: move declarations for preload-index.c from elsewhere
 12:  41baa22c5d6 = 13:  c8f873d71f5 diff.h: move declaration for global in diff.c from cache.h
 13:  d56fc27c94b = 14:  77c3c5918b8 merge.h: move declarations for merge.c from cache.h
 14:  59dafa5eaa6 = 15:  abfb127b812 repository.h: move declaration of the_index from cache.h
 15:  986a056e580 = 16:  41183b7baed read-cache*.h: move declarations for read-cache.c functions from cache.h
 16:  2cf46f2fc8e = 17:  8f021be54e0 cache.h: remove this no-longer-used header
 17:  1786a64367a = 18:  ea21839a95a log-tree: replace include of revision.h with simple forward declaration
 18:  dfd1794592a = 19:  bd70d3fe730 repository: remove unnecessary include of path.h
 19:  69c07c6ebed = 20:  a438cfbb095 diff.h: remove unnecessary include of oidset.h
 20:  5e6ecb0256d = 21:  b8f302184fa list-objects-filter-options.h: remove unneccessary include
 21:  f0e69592be8 = 22:  1d3d33a843b builtin.h: remove unneccessary includes
 22:  7a9deb749e8 = 23:  7849fea5fa4 git-compat-util.h: remove unneccessary include of wildmatch.h
  -:  ----------- > 24:  97d04efde7b merge-ll: rename from ll-merge
  -:  ----------- > 25:  e0bfeb98556 khash: name the structs that khash declares
 23:  44a4027b240 ! 26:  41d48379b3d hash-ll, hashmap: move oidhash() to hash-ll
     @@ khash.h
       #include "hash.h"
       
       #define AC_VERSION_KHASH_H "0.2.8"
     -@@ khash.h: static inline khint_t __ac_X31_hash_string(const char *s)
     - static const double __ac_HASH_UPPER = 0.77;
     - 
     - #define __KHASH_TYPE(name, khkey_t, khval_t) \
     --	typedef struct { \
     -+	typedef struct kh_##name { \
     - 		khint_t n_buckets, size, n_occupied, upper_bound; \
     - 		khint32_t *flags; \
     - 		khkey_t *keys; \
      
       ## list-objects-filter.c ##
      @@
     @@ match-trees.c
      
       ## merge-blobs.c ##
      @@
     - #include "ll-merge.h"
     + #include "merge-ll.h"
       #include "blob.h"
       #include "merge-blobs.h"
      -#include "object-store.h"
 24:  152fb353475 = 27:  bbe64fccd52 fsmonitor-ll.h: split this header out of fsmonitor.h

-- 
gitgitgadget
