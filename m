Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E933C61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBXAJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBXAJt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:09:49 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE4819F0C
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:43 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id az36so733081wmb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqRRZRewSo5M5EowJrGXZQLdrmNYCiwTC0dA7P/eaFw=;
        b=TN1acJ93TsWdv1cjdkWhov0hoB6+kpw24XcaeMSJ9pysxHobxhMYC+DGbe/MgPTMwq
         HPLt0ty9sUUhAZDPD9XHqp4L2zkJth+CTe3ycqlZBGnogdHrMCZCvh5y+lvkKo19FBpy
         9F2Zxv27w/3mpF+fDb5/qiUNs6hhsJ+rUeS8yUgO9aVKW/G+D0JUcAWgO7BduStBihya
         fCFb3aSqoOlAsS7nzGsFKPR3ag28AhFIhUl+GsRv//kTzFXUztx2i7ELIwW5TzCdAoTV
         u9ZLha+iqi7adIo8v43VNlSPzr3TIGw8suCQpitaeAd0X+NMv93doP7LXNP31/9DVoy/
         MBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqRRZRewSo5M5EowJrGXZQLdrmNYCiwTC0dA7P/eaFw=;
        b=mmDxdVYZ/k0JHzjVwTsnXwmqaoPcKX4pBIvNbL3bkR2zHLfl6XHUwWA+d01p6gLnvp
         0hq/2+3RjDJUYPSGNeJODjp9+vV5fJYp5UanOxX3BooxEioJZQZbWz1y+0bCLmgjkWXJ
         besRcg8PvcKREAWr6qeJeNgE6HV9YIyfb7Gp/Ai9UEKzhZ4pkqUGbNI5yFMytoW4izWg
         +VIIRP00ZbRfx3LZOaUT0YwWYBTTtlTp8rvNw1bVFswVK7dqDJFx0m/1Cgy12slqhCgY
         lL/DswpyJn7NfdpB038UeVvwdh9MTf85JwhOwJuMbilCwACR+EpnA/HP6OvRXqAn2PWp
         5pWg==
X-Gm-Message-State: AO0yUKXWt4v7M0tZ7e3ppiftRXFDMT+Lp1AodxwfUiHt8z25O1akl3H6
        ERDAwhNaFJmR5M0wHczenkVVYTDAUP4=
X-Google-Smtp-Source: AK7set/sbQCwkKW8yA8PcQA+mLZQQruS4xtPtDdDhkIJVUATHFH9wBAwAvk3a59fj71HuxL/LA1qWw==
X-Received: by 2002:a05:600c:4da2:b0:3e2:19b0:887d with SMTP id v34-20020a05600c4da200b003e219b0887dmr11115165wmp.25.1677197381368;
        Thu, 23 Feb 2023 16:09:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c40c400b003db06224953sm814250wmh.41.2023.02.23.16.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:41 -0800 (PST)
Message-Id: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:19 +0000
Subject: [PATCH v2 00/17] Header cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maintainer note: This series cleanly merges with next, but has TWO minor
conflicts with ed/fsmonitor-inotify. The correct resolution is to take
ed/fsmonitor-inotify's copy of both compat/fsmonitor/fsm-settings-darwin.c
and compat/fsmonitor/fsm-ipc-darwin.c, but to add a #include
"git-compat-util.h" line at the top of compat/fsmonitor/fsm-settings-unix.c
and a #include "hex.h" somewhere near the top of
compat/fsmonitor/fsm-ipc-unix.c

Changes since v1:

 * Fixed a bad squash; moved the changes to the right commit
 * More thorough justification in the commit message for the 2nd commit
 * Removed an accidental added include of gettext.h (the file was used, but
   it makes it harder to review that patch)
 * Add some explanation of surprising changes to commit messages
 * Add a new commit which removes the include of hex.h from cache.h, and
   instead makes C files include it directly, as suggested by Stolee

This series cleans up headers a bit, trying to remove excessive dependency
on "cache.h". I created this series a while ago, but decided to clean it up
and submit it due to Emily's recent thread and suggestion that this might be
helpful to their efforts[1].

There are many more cleanups I could do in this area, but the series is
already a good size.

Notes:

 * Big props to Dscho for gitgitgadget; being able to test on a bunch of
   platforms with a variety of configurations easily is a big win in general
   but especially for series like this one.
 * I used the scripts at
   https://github.com/newren/git/commit/db81c8d7fb554b3edf04320e218bddeb98bb6194,
   and some tweaks thereof, repeatedly while making this series (though they
   are prone to produce both false positive and false negatives, so if you
   use them, only use them to generate hints about which files to look at).

[1] Search for "Extremely yes" in
https://lore.kernel.org/git/CAJoAoZm+TkCL0Jpg_qFgKottxbtiG2QOiY0qGrz3-uQy+=waPg@mail.gmail.com/

Elijah Newren (17):
  treewide: ensure one of the appropriate headers is sourced first
  treewide: remove unnecessary git-compat-util.h includes in headers
  treewide: remove unnecessary cache.h includes
  treewide: remove unnecessary cache.h includes in source files
  alloc.h: move ALLOC_GROW() functions from cache.h
  hash.h: move some oid-related declarations from cache.h
  hex.h: move some hex-related declarations from cache.h
  cache.h: remove dependence on hex.h; make other files include it
    explicitly
  pretty.h: move has_non_ascii() declaration from commit.h
  ident.h: move ident-related declarations out of cache.h
  object.h: stop depending on cache.h; make cache.h depend on object.h
  dir.h: refactor to no longer need to include cache.h
  object-store.h: move struct object_info from cache.h
  replace-object.h: move read_replace_refs declaration from cache.h to
    here
  treewide: replace cache.h with more direct headers, where possible
  Remove unnecessary includes of builtin.h
  diff.h: remove unnecessary include of object.h

 Documentation/CodingGuidelines               |   8 +-
 add-interactive.c                            |   1 +
 add-patch.c                                  |   1 +
 advice.c                                     |   4 +-
 advice.h                                     |   2 -
 alias.c                                      |   4 +-
 alloc.c                                      |   2 +-
 alloc.h                                      |  75 +++++
 apply.c                                      |   2 +
 archive-tar.c                                |   4 +-
 archive-zip.c                                |   1 +
 archive.c                                    |   4 +-
 attr.c                                       |   1 +
 bisect.c                                     |   1 +
 blame.c                                      |   1 +
 blame.h                                      |   1 -
 blob.c                                       |   2 +-
 branch.c                                     |   1 +
 builtin/am.c                                 |   1 +
 builtin/bisect.c                             |   1 +
 builtin/blame.c                              |   4 +-
 builtin/cat-file.c                           |   4 +
 builtin/check-mailmap.c                      |   1 +
 builtin/checkout--worker.c                   |   1 +
 builtin/checkout.c                           |   1 +
 builtin/clone.c                              |   1 +
 builtin/commit-graph.c                       |   2 +
 builtin/commit-tree.c                        |   1 +
 builtin/config.c                             |   3 +-
 builtin/credential-cache--daemon.c           |   1 +
 builtin/describe.c                           |   1 +
 builtin/diff-tree.c                          |   1 +
 builtin/difftool.c                           |   1 +
 builtin/fast-export.c                        |   1 +
 builtin/fast-import.c                        |   1 +
 builtin/fetch-pack.c                         |   2 +
 builtin/fetch.c                              |   1 +
 builtin/fsck.c                               |   2 +
 builtin/fsmonitor--daemon.c                  |   1 +
 builtin/gc.c                                 |   1 +
 builtin/grep.c                               |   2 +
 builtin/hash-object.c                        |   1 +
 builtin/index-pack.c                         |   3 +
 builtin/log.c                                |   4 +-
 builtin/ls-remote.c                          |   1 +
 builtin/ls-tree.c                            |   1 +
 builtin/merge-base.c                         |   1 +
 builtin/merge-index.c                        |   1 +
 builtin/merge-tree.c                         |   1 +
 builtin/merge.c                              |   2 +
 builtin/mktag.c                              |   1 +
 builtin/mktree.c                             |   2 +
 builtin/mv.c                                 |   1 +
 builtin/name-rev.c                           |   3 +-
 builtin/notes.c                              |   1 +
 builtin/pack-objects.c                       |   4 +-
 builtin/pack-redundant.c                     |   1 +
 builtin/patch-id.c                           |   1 +
 builtin/prune.c                              |   2 +
 builtin/pull.c                               |   1 +
 builtin/read-tree.c                          |   1 +
 builtin/rebase.c                             |   1 +
 builtin/receive-pack.c                       |   1 +
 builtin/repack.c                             |   3 +-
 builtin/replace.c                            |   2 +
 builtin/reset.c                              |   1 +
 builtin/rev-list.c                           |   1 +
 builtin/rev-parse.c                          |   2 +
 builtin/revert.c                             |   3 +-
 builtin/rm.c                                 |   1 +
 builtin/send-pack.c                          |   1 +
 builtin/show-branch.c                        |   1 +
 builtin/show-index.c                         |   1 +
 builtin/show-ref.c                           |   1 +
 builtin/stash.c                              |   1 +
 builtin/submodule--helper.c                  |   2 +
 builtin/tag.c                                |   1 +
 builtin/unpack-file.c                        |   1 +
 builtin/unpack-objects.c                     |   2 +
 builtin/update-index.c                       |   1 +
 builtin/upload-pack.c                        |   1 +
 builtin/var.c                                |   1 +
 builtin/worktree.c                           |   1 +
 builtin/write-tree.c                         |   1 +
 bulk-checkin.c                               |   4 +-
 bundle.c                                     |   1 +
 cache-tree.c                                 |   4 +-
 cache-tree.h                                 |   1 -
 cache.h                                      | 305 +------------------
 cbtree.c                                     |   1 +
 cbtree.h                                     |   2 -
 checkout.h                                   |   2 +-
 chunk-format.c                               |   3 +-
 chunk-format.h                               |   1 -
 color.c                                      |   1 +
 combine-diff.c                               |   1 +
 commit-graph.c                               |   1 +
 commit-graph.h                               |   1 -
 commit-reach.c                               |   4 +-
 commit-slab-impl.h                           |   2 -
 commit.c                                     |   1 +
 commit.h                                     |   1 -
 compat/fsmonitor/fsm-ipc-darwin.c            |   1 +
 compat/fsmonitor/fsm-ipc-win32.c             |   1 +
 compat/fsmonitor/fsm-settings-darwin.c       |   1 +
 compat/mingw.c                               |   1 +
 config.c                                     |   5 +-
 connect.c                                    |   1 +
 connected.c                                  |   1 +
 convert.c                                    |   1 +
 daemon.c                                     |   1 +
 decorate.c                                   |   3 +-
 delta-islands.c                              |   4 +-
 diagnose.c                                   |   1 +
 diff-lib.c                                   |   1 +
 diff-merges.c                                |   2 +
 diff-no-index.c                              |   1 -
 diff.c                                       |   2 +
 diff.h                                       |   3 +-
 diffcore-delta.c                             |   2 +-
 diffcore-order.c                             |   3 +-
 diffcore-pickaxe.c                           |   4 +-
 diffcore-rename.c                            |   7 +-
 diffcore-rotate.c                            |   3 +-
 diffcore.h                                   |   4 +-
 dir-iterator.c                               |   3 +-
 dir.c                                        |   3 +-
 dir.h                                        |  16 +-
 entry.c                                      |   1 +
 entry.h                                      |   4 +-
 environment.c                                |   1 +
 ewah/bitmap.c                                |   3 +-
 ewah/ewah_bitmap.c                           |   2 +-
 fetch-pack.c                                 |   4 +-
 fmt-merge-msg.c                              |   3 +
 fsck.c                                       |   4 +-
 fsck.h                                       |   1 +
 fsmonitor-settings.c                         |   3 +-
 git-compat-util.h                            |   1 +
 git.c                                        |   1 +
 gpg-interface.c                              |   1 +
 graph.c                                      |   3 +-
 grep.c                                       |   1 +
 hash.h                                       |  35 ++-
 hashmap.c                                    |   2 +-
 help.c                                       |   4 +-
 hex.c                                        |   3 +-
 hex.h                                        |  84 +++++
 hook.c                                       |   5 +-
 http-backend.c                               |   4 +-
 http-fetch.c                                 |   1 +
 http-push.c                                  |   1 +
 http-walker.c                                |   1 +
 http.c                                       |   1 +
 ident.c                                      |   5 +-
 ident.h                                      |  67 ++++
 imap-send.c                                  |   2 +-
 json-writer.c                                |   2 +-
 khash.h                                      |   1 -
 kwset.c                                      |   2 +-
 levenshtein.c                                |   2 +-
 line-log.c                                   |   2 +
 line-log.h                                   |   1 +
 linear-assignment.c                          |   2 +-
 list-objects-filter-options.c                |   4 +-
 list-objects-filter-options.h                |   3 +-
 list-objects-filter.c                        |   2 +
 list-objects.c                               |   1 +
 log-tree.c                                   |   2 +
 ls-refs.c                                    |   1 +
 mailinfo.c                                   |   4 +-
 match-trees.c                                |   1 +
 mem-pool.c                                   |   2 +-
 merge-blobs.c                                |   2 +-
 merge-ort.c                                  |   1 +
 merge-recursive.c                            |   2 +-
 merge.c                                      |   1 +
 midx.c                                       |   4 +-
 negotiator/noop.c                            |   2 +-
 negotiator/skipping.c                        |   1 +
 notes-merge.c                                |   1 +
 notes.c                                      |   1 +
 object-file.c                                |   4 +-
 object-name.c                                |   1 +
 object-store.h                               | 128 ++++----
 object.c                                     |   1 +
 object.h                                     |  22 +-
 oid-array.c                                  |   3 +-
 oidmap.c                                     |   2 +-
 oidmap.h                                     |   1 -
 oidset.c                                     |   4 +-
 oidtree.c                                    |   1 +
 oss-fuzz/fuzz-commit-graph.c                 |   1 +
 oss-fuzz/fuzz-pack-headers.c                 |   1 +
 oss-fuzz/fuzz-pack-idx.c                     |   1 +
 pack-bitmap-write.c                          |   4 +-
 pack-bitmap.c                                |   4 +-
 pack-check.c                                 |   1 +
 pack-mtimes.h                                |   2 -
 pack-objects.c                               |   3 +-
 pack-write.c                                 |   1 +
 packfile.c                                   |   4 +-
 parallel-checkout.c                          |   2 +
 patch-ids.c                                  |   1 +
 path.c                                       |   1 +
 pathspec.h                                   |   5 +
 pkt-line.c                                   |   1 +
 pkt-line.h                                   |   1 -
 pretty.c                                     |   2 +
 pretty.h                                     |   4 +-
 prio-queue.c                                 |   3 +-
 promisor-remote.c                            |   1 +
 protocol-caps.c                              |   2 +
 prune-packed.c                               |   1 +
 quote.c                                      |   2 +
 reachable.c                                  |   1 +
 read-cache.c                                 |   2 +
 rebase.c                                     |   1 +
 ref-filter.c                                 |   6 +-
 reflog-walk.c                                |   3 +-
 reflog-walk.h                                |   2 -
 refs.c                                       |   4 +-
 refs/debug.c                                 |   3 +-
 refs/files-backend.c                         |   2 +
 refs/packed-backend.c                        |   4 +-
 refs/ref-cache.c                             |   3 +-
 refs/refs-internal.h                         |   1 -
 refspec.c                                    |   4 +-
 remote-curl.c                                |   4 +-
 remote.c                                     |   4 +-
 remote.h                                     |   1 -
 replace-object.c                             |   1 +
 replace-object.h                             |   8 +
 repo-settings.c                              |   2 +-
 repository.h                                 |   1 -
 rerere.c                                     |   4 +-
 reset.c                                      |   1 +
 revision.c                                   |   4 +-
 revision.h                                   |   1 +
 send-pack.c                                  |   3 +-
 sequencer.c                                  |   2 +
 sequencer.h                                  |   2 +-
 serve.c                                      |   3 +-
 server-info.c                                |   4 +-
 sha1dc_git.c                                 |   4 +-
 shallow.c                                    |   4 +-
 shallow.h                                    |   2 +
 shell.c                                      |   2 +-
 sigchain.c                                   |   3 +-
 sparse-index.c                               |   1 +
 split-index.c                                |   1 +
 statinfo.h                                   |  24 ++
 strbuf.c                                     |   4 +-
 string-list.c                                |   3 +-
 strvec.c                                     |   4 +-
 sub-process.c                                |   1 +
 sub-process.h                                |   1 -
 submodule-config.c                           |   2 +
 submodule-config.h                           |   1 -
 submodule.c                                  |   5 +-
 t/helper/test-bloom.c                        |   3 +-
 t/helper/test-cache-tree.c                   |   1 +
 t/helper/test-crontab.c                      |   1 -
 t/helper/test-ctype.c                        |   1 -
 t/helper/test-dump-cache-tree.c              |   1 +
 t/helper/test-dump-split-index.c             |   1 +
 t/helper/test-dump-untracked-cache.c         |   1 +
 t/helper/test-example-decorate.c             |   2 +-
 t/helper/test-fast-rebase.c                  |   1 +
 t/helper/test-hash.c                         |   1 +
 t/helper/test-json-writer.c                  |   1 -
 t/helper/test-match-trees.c                  |   1 +
 t/helper/test-oid-array.c                    |   1 +
 t/helper/test-oidmap.c                       |   1 +
 t/helper/test-oidtree.c                      |   1 +
 t/helper/test-pack-mtimes.c                  |   1 +
 t/helper/test-partial-clone.c                |   1 +
 t/helper/test-pcre2-config.c                 |   1 -
 t/helper/test-prio-queue.c                   |   1 -
 t/helper/test-proc-receive.c                 |   1 +
 t/helper/test-reach.c                        |   3 +-
 t/helper/test-read-midx.c                    |   1 +
 t/helper/test-ref-store.c                    |   1 +
 t/helper/test-repository.c                   |   1 +
 t/helper/test-run-command.c                  |   2 -
 t/helper/test-sigchain.c                     |   1 -
 t/helper/test-simple-ipc.c                   |   3 +-
 t/helper/test-submodule-nested-repo-config.c |   1 +
 t/helper/test-wildmatch.c                    |   1 -
 tag.c                                        |   1 +
 thread-utils.c                               |   2 +-
 trace.h                                      |   1 -
 trace2.c                                     |   3 +-
 trace2/tr2_ctr.c                             |   2 +-
 trace2/tr2_sid.c                             |   1 +
 trace2/tr2_sysenv.c                          |   2 +-
 trace2/tr2_tbuf.c                            |   2 +-
 trace2/tr2_tgt_event.c                       |   2 +-
 trace2/tr2_tgt_normal.c                      |   2 +-
 trace2/tr2_tgt_perf.c                        |   2 +-
 trace2/tr2_tls.c                             |   4 +-
 trace2/tr2_tmr.c                             |   3 +-
 trailer.c                                    |   1 +
 transport-helper.c                           |   1 +
 transport.c                                  |   5 +-
 tree-walk.c                                  |   2 +
 tree-walk.h                                  |   4 +-
 tree.c                                       |   1 +
 unix-socket.c                                |   3 +-
 unix-stream-server.c                         |   2 +-
 unpack-trees.c                               |   1 +
 upload-pack.c                                |   1 +
 url.c                                        |   4 +-
 urlmatch.c                                   |   5 +-
 userdiff.c                                   |   4 +-
 walker.c                                     |   1 +
 wildmatch.c                                  |   2 +-
 worktree.c                                   |   3 +-
 worktree.h                                   |   1 -
 wt-status.c                                  |   1 +
 xdiff-interface.c                            |   1 +
 xdiff-interface.h                            |   2 +-
 322 files changed, 858 insertions(+), 529 deletions(-)
 create mode 100644 hex.h
 create mode 100644 ident.h
 create mode 100644 statinfo.h


base-commit: 06dd2baa8da4a73421b959ec026a43711b9d77f9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1485%2Fnewren%2Fheader-cleanups-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1485/newren/header-cleanups-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1485

Range-diff vs v1:

  1:  a143d624724 !  1:  aede32dcb30 treewide: ensure one of the appropriate headers is sourced first
     @@ cbtree.c
       
       static struct cb_node *cb_node_of(const void *p)
      
     + ## compat/fsmonitor/fsm-ipc-win32.c ##
     +@@
     ++#include "git-compat-util.h"
     + #include "config.h"
     + #include "fsmonitor-ipc.h"
     + 
     +
     + ## compat/fsmonitor/fsm-settings-darwin.c ##
     +@@
     ++#include "git-compat-util.h"
     + #include "config.h"
     + #include "fsmonitor.h"
     + #include "fsmonitor-ipc.h"
     +
       ## diff-merges.c ##
      @@
      +#include "git-compat-util.h"
  2:  adafa655432 !  2:  e1c2b55ac67 treewide: remove unnecessary git-compat-util.h includes in headers
     @@ Metadata
       ## Commit message ##
          treewide: remove unnecessary git-compat-util.h includes in headers
      
     -    Since git-compat-util.h needs to be included first in C files, having it
     -    appear in header files is unnecessary.  More importantly, having it
     -    included in header files seems to lead to folks leaving it out of C
     -    files, which makes it harder to verify that the rule is being followed.
     -    Remove it from header files, other than the ones that have been approved
     -    as alternate first includes.
     +    For sanity, we should probably do one of the following:
     +
     +    (a) make C and header files both depend upon everything they need
     +    (b) consistently exclude git-compat-util.h from headers and require it
     +        be the first include in C files
     +
     +    Currently, we have some of the headers following (a) and others
     +    following (b), which makes things messy.  In the past I was pushed
     +    towards (b), as per [1] and [2].  Further, during this series I
     +    discovered that this mixture empirically will mean that we end up with C
     +    files that do not directly include git-compat-util.h, and do include
     +    headers that don't include git-compat-util.h, with the result that we
     +    likely have headers included before an indirect inclusion of
     +    git-compat-util.h.  Since git-compat-util.h has tricky platform-specific
     +    stuff that is meant to be included before everything else, this state of
     +    affairs is risky and may lead to things breaking in subtle ways (and
     +    only on some platforms) as per [1] and [2].
     +
     +    Since including git-compat-util.h in existing header files makes it
     +    harder for us to catch C files that are missing that include, let's
     +    switch to (b) to make the enforcement of this rule easier.  Remove the
     +    inclusion of git-compat-util.h from header files other than the ones
     +    that have been approved as alternate first includes.
     +
     +    [1] https://lore.kernel.org/git/20180811173406.GA9119@sigill.intra.peff.net/
     +    [2] https://lore.kernel.org/git/20180811174301.GA9287@sigill.intra.peff.net/
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ commit-slab-impl.h
       	implement_commit_slab(slabname, elemtype, MAYBE_UNUSED static)
       
      
     - ## compat/fsmonitor/fsm-ipc-win32.c ##
     -@@
     -+#include "git-compat-util.h"
     - #include "config.h"
     - #include "fsmonitor-ipc.h"
     - 
     -
     - ## compat/fsmonitor/fsm-settings-darwin.c ##
     -@@
     -+#include "git-compat-util.h"
     - #include "config.h"
     - #include "fsmonitor.h"
     - #include "fsmonitor-ipc.h"
     -
       ## hash.h ##
      @@
       #ifndef HASH_H
  3:  73d012f631a =  3:  b9ffac2d122 treewide: remove unnecessary cache.h includes
  4:  bec6f89d82c =  4:  00dceb5b467 treewide: remove unnecessary cache.h includes in source files
  5:  ec6f2518b9d !  5:  9344a94fd92 alloc.h: move ALLOC_GROW() functions from cache.h
     @@ Metadata
       ## Commit message ##
          alloc.h: move ALLOC_GROW() functions from cache.h
      
     -    This allows us to replace includes of cache.h with includes
     -    of the much smaller alloc.h in many places.
     +    This allows us to replace includes of cache.h with includes of the much
     +    smaller alloc.h in many places.  It does mean that we also need to add
     +    includes of alloc.h in a number of C files.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ add-patch.c
       #include "cache.h"
       #include "add-interactive.h"
      +#include "alloc.h"
     -+#include "gettext.h"
       #include "strbuf.h"
       #include "run-command.h"
       #include "strvec.h"
  6:  9f78f0f2155 !  6:  b5046b7aaa6 hash.h: move some oid-related declarations from cache.h
     @@ Commit message
          more sense being included in hash.h.  Further, moving them there
          allows us to remove some includes of cache.h in other files.
      
     +    The change to line-log.h might look unrelated, but line-log.h includes
     +    diffcore.h, which previously included cache.h, which included the
     +    kitchen sink.  Since this patch makes diffcore.h no longer include
     +    cache.h, the compiler complains about the 'struct string_list *'
     +    function parameter.  Add a forward declaration for struct string_list to
     +    address this.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## cache.h ##
  7:  c9b1b278092 !  7:  6d5c13c4693 hex.h: move some hex-related declarations from cache.h
     @@ Commit message
          declarations into a hex.h header instead.
      
          This also allows us to remove includes of cache.h from a few C files.
     +    For now, we make cache.h include hex.h, so that it is easier to review
     +    the direct changes being made by this patch.  In the next patch, we will
     +    remove that, and add the necessary direct '#include "hex.h"' in the
     +    hundreds of C files that need it.
      
          Note that reviewing the header changes in this commit might be
          simplified via
  -:  ----------- >  8:  c23dd309ce3 cache.h: remove dependence on hex.h; make other files include it explicitly
  8:  a3759d887d2 =  9:  f1e9b324234 pretty.h: move has_non_ascii() declaration from commit.h
  9:  9fc48fe4844 ! 10:  de1e29132de ident.h: move ident-related declarations out of cache.h
     @@ Commit message
      
       ## builtin/cat-file.c ##
      @@
     - #include "config.h"
       #include "builtin.h"
       #include "diff.h"
     + #include "hex.h"
      +#include "ident.h"
       #include "parse-options.h"
       #include "userdiff.h"
 10:  1357f18db56 ! 11:  1636615ca73 object.h: stop depending on cache.h; make cache.h depend on object.h
     @@ Commit message
          Note that a couple files previously depended on things brought in
          through cache.h indirectly (revision.h -> commit.h -> object.h ->
          cache.h).  As such, this change requires making existing dependencies
     -    more explicit in two files.
     +    more explicit in half a dozen files.  The inclusion of strbuf.h in
     +    some headers if of particular note: these headers directly embedded a
     +    strbuf in some new structs, meaning they should have been including
     +    strbuf.h all along but were indirectly getting the necessary
     +    definitions.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ cache-tree.h
      
       ## cache.h ##
      @@
     + #include "pack-revindex.h"
       #include "hash.h"
     - #include "hex.h"
       #include "path.h"
      +#include "object.h"
       #include "oid-array.h"
     @@ t/helper/test-bloom.c
      -#include "git-compat-util.h"
      +#include "cache.h"
       #include "bloom.h"
     + #include "hex.h"
       #include "test-tool.h"
     - #include "commit.h"
      
       ## t/helper/test-example-decorate.c ##
      @@
 11:  0446ab61d6f ! 12:  856d3dbcc6e dir.h: refactor to no longer need to include cache.h
     @@ Commit message
      
       ## cache.h ##
      @@
     + #include "pack-revindex.h"
       #include "hash.h"
     - #include "hex.h"
       #include "path.h"
      +#include "pathspec.h"
       #include "object.h"
 12:  c42261483cf ! 13:  12eb68b1ba3 object-store.h: move struct object_info from cache.h
     @@ Commit message
          Move struct object_info, and a few related #define's from cache.h to
          object-store.h.
      
     +    A surprising effect of this change is that replace-object.h, which
     +    includes object-store.h, now needs to directly include cache.h since
     +    that is where read_replace_refs is declared and that variable is used
     +    in one of its inline functions.  The next commit will move that
     +    declaration and fix that unfortunate new direct inclusion of cache.h.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-blobs.c ##
 13:  1abea7621ee = 14:  c4f86b77e71 replace-object.h: move read_replace_refs declaration from cache.h to here
 14:  3d99495aff3 ! 15:  814d60ec94e treewide: replace cache.h with more direct headers, where possible
     @@ sha1dc_git.c
      -#include "cache.h"
      +#include "git-compat-util.h"
      +#include "sha1dc_git.h"
     -+#include "hex.h"
     + #include "hex.h"
       
       #ifdef DC_SHA1_EXTERNAL
     - /*
      
       ## unix-socket.c ##
      @@
     @@ url.c
      @@
      -#include "cache.h"
      +#include "git-compat-util.h"
     -+#include "hex.h"
     + #include "hex.h"
      +#include "strbuf.h"
       #include "url.h"
       
     @@ urlmatch.c
      -#include "cache.h"
      +#include "git-compat-util.h"
      +#include "gettext.h"
     -+#include "hex.h"
     + #include "hex.h"
      +#include "strbuf.h"
       #include "urlmatch.h"
       
 15:  2931a0a8c78 ! 16:  97d3032346f Remove unnecessary includes of builtin.h
     @@ send-pack.c
      +#include "git-compat-util.h"
       #include "config.h"
       #include "commit.h"
     - #include "refs.h"
     + #include "hex.h"
 16:  faeb191198a = 17:  a172801bbf0 diff.h: remove unnecessary include of object.h

-- 
gitgitgadget
