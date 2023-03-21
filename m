Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359E8C7619A
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 06:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCUG0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCUG0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 02:26:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9006931E02
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m2so12501546wrh.6
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679379978;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuCCrrgzHTGPf72Ir1K3LrAZR7X2BRD+KI7NiLsNL1U=;
        b=MiCDidMfLx5PQJnLSHuSUmXyHI2sv/0wsC1GI8736Pnhk6c5CciZq+OnuU4Xvt98ZM
         3PwlTs20HaZWRtBKcshL089JZ7aHJZJvgGnU8zAvugF2ErMp3qvyGYxD9zjlywCCp0F5
         45Gzgi4qZDuX8VUOHdDp8y8jITGc1BFeUwLqcn0h41Bq7Y6VQ8YURURwABdM7y3Bj73g
         E9+tJmr2XRQt+IJ0lRV7wfjE8lu+ZMS+RcPzMQHwv6On45EiL36noQ5Zrfi/KCmyCnhL
         EBVYP4VQ5x3vG8GOO2+kIeoSBG7FpIUOrm7WoSX9QoMK+Yo69DRq9v1YA1N6sN5oDu3Q
         n/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379978;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuCCrrgzHTGPf72Ir1K3LrAZR7X2BRD+KI7NiLsNL1U=;
        b=XbC0i3iYXYsxnnGFtd9GtYN/UeBEDw+hXmzokse8xUtlmvkMfllNENBOkzhXcZ9sQt
         +U/sLMQK1BKaa/A4BaWrDMIteCYPHqXzthE8Xfy0MhzfNtlHTqI5FmNEPO8lAmEWMcZZ
         ppjnep9K1UqiaL6NaExprD09JKYfSdzdqNoEl6lyKfQDYJtX90qMJmXMW8ECJuRc4VzU
         jdqEEwF8gBPmbK0TTe4z2a8LlwAJz9C/vb3RWs3x2t4lqVQ3x0rRvs15Se7Jp+Z4+XC7
         Wtk7DbvYJeq+n+1dkIHL2Pk6JlMSYCU/VMsqbCzm+W9gED2D3NTH2aJYttwUQQppuMcC
         slfQ==
X-Gm-Message-State: AO0yUKXU6RSvP+tvM4ccMCRg5wO4O8JRwq3Ca/EZEtQqB3qXPDPo6YNN
        j6sfFP7KOv7+PA0Dt1XxDvst+Tz5WB8=
X-Google-Smtp-Source: AK7set/Mm44eB9iyC9f8EhLX6nIajNVbX91pkq1Le6jd0Nnqessw9LQz0fe8si6THfVrQxOJ0L5I9Q==
X-Received: by 2002:adf:fa4b:0:b0:2cc:1935:1ae8 with SMTP id y11-20020adffa4b000000b002cc19351ae8mr1311284wrr.47.1679379978290;
        Mon, 20 Mar 2023 23:26:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10-20020adffa8a000000b002ce3d3d17e5sm10597067wrr.79.2023.03.20.23.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:26:17 -0700 (PDT)
Message-Id: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Mar 2023 06:25:52 +0000
Subject: [PATCH v2 00/16] Header cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maintainer note: I dropped multiple changes from this series to avoid
conflicts with other in-flight series, but has some small conflicts with
seen: one semantic conflict with ed/fsmonitor-inotify (correct resolution:
include abspath.h in the new file compat/fsmonitor/fsm-path-utils-linux.c)
and a few conflicts with sg/parse-options-h-users (which was submitted after
my series; correct resolution: just make sure all the headers are included
from both sides).

The motivating thrust of this series was trying to remove the inclusion of
cache.h from strbuf.c. This series doesn't quite achieve that, because I
dropped some changes to avoid conflicting with ed/fsmonitor-inotify, and to
avoid conflicting with Ævar's series on the_repository cleanup.

Overview of the series:

 * Patch 1: leftover cleanup from en/header-cleanups (now in master) that
   should have been included in that series
 * Patches 2-4: cleanups around gettext.h. Without these patches, many
   gettext inclusions would have to be squashed into later patches and make
   them harder to review. Also, the implicit dependency on gettext.h was
   making it much harder to find other dependencies.
 * Patch 5: move some global var declarations from cache.h into the header
   associated with where the vars are declared
 * Patches 6-16: move header declarations from cache.h into a header named
   the same as the source file containing the actual functions (e.g. move
   declarations for abspath.c functions from cache.h into abspath.h), and
   reduce the dependencies on cache.h accordingly.

Changes since v1:

 * rebased on main (to avoid conflict with jk/bundle-use-dash-for-stdfiles;
   no more conflicts with next!)
 * cleaned up the wording in patch 4
 * added more detail to this cover letter giving an overview of the series,
   and updating about conflicts

Changes not incorporated:

 * I left patch 1 before patches 2-4, since it's purpose (leftover cleanup
   from en/header-cleanups) just means it makes more sense there for me. I
   don't know how to explain it in a way that makes sense if I move it.

Notes:

 * As I mentioned in my last series, Dscho's gitgitgadget is super helpful
   for a series like this.
 * As with my previous series (en/header-cleanup), I used the scripts at my
   header-cleanup-scripts branch
   [https://github.com/newren/git/commit/db81c8d7fb554b3edf04320e218bddeb98bb6194],
   and some tweaks thereof, repeatedly while making this series (though they
   are prone to produce both false positive and false negatives, so if you
   use them, only use them to generate hints about which files to look at).

Elijah Newren (16):
  treewide: remove unnecessary cache.h inclusion from a few headers
  treewide: be explicit about dependence on gettext.h
  treewide: remove unnecessary inclusion of gettext.h
  treewide: remove unnecessary cache.h inclusion from several sources
  environment: move comment_line_char from cache.h
  abspath.h: move absolute path functions from cache.h
  cache.h: remove expand_user_path()
  path.h: move function declarations for path.c functions from cache.h
  wrapper.h: move declarations for wrapper.c functions from cache.h
  treewide: remove unnecessary includes of cache.h
  environment.h: move declarations for environment.c functions from
    cache.h
  treewide: remove cache.h inclusion due to environment.h changes
  setup.h: move declarations for setup.c functions from cache.h
  treewide: remove cache.h inclusion due to setup.h changes
  write-or-die.h: move declarations for write-or-die.c functions from
    cache.h
  csum-file.h: remove unnecessary inclusion of cache.h

 abspath.c                                    |   4 +-
 abspath.h                                    |  33 ++
 add-interactive.c                            |   1 +
 add-patch.c                                  |   2 +
 apply.c                                      |   5 +
 archive-tar.c                                |   2 +
 archive-zip.c                                |   2 +
 archive.c                                    |   4 +
 attr.c                                       |   3 +
 bisect.c                                     |   2 +
 blame.c                                      |   2 +
 branch.c                                     |   2 +
 builtin/add.c                                |   1 +
 builtin/am.c                                 |   4 +
 builtin/apply.c                              |   1 +
 builtin/archive.c                            |   1 +
 builtin/bisect.c                             |   3 +
 builtin/blame.c                              |   4 +
 builtin/branch.c                             |   3 +
 builtin/bugreport.c                          |   5 +-
 builtin/bundle.c                             |   3 +
 builtin/cat-file.c                           |   3 +
 builtin/check-attr.c                         |   4 +
 builtin/check-ignore.c                       |   2 +
 builtin/check-mailmap.c                      |   2 +
 builtin/check-ref-format.c                   |   1 +
 builtin/checkout--worker.c                   |   1 +
 builtin/checkout-index.c                     |   2 +
 builtin/checkout.c                           |   3 +
 builtin/clean.c                              |   3 +
 builtin/clone.c                              |   4 +
 builtin/column.c                             |   1 +
 builtin/commit-graph.c                       |   2 +
 builtin/commit-tree.c                        |   1 +
 builtin/commit.c                             |   2 +
 builtin/config.c                             |   5 +
 builtin/count-objects.c                      |   2 +
 builtin/credential-cache--daemon.c           |   2 +
 builtin/credential-cache.c                   |   3 +
 builtin/credential-store.c                   |   2 +
 builtin/describe.c                           |   3 +
 builtin/diagnose.c                           |   2 +
 builtin/diff-index.c                         |   1 +
 builtin/diff-tree.c                          |   1 +
 builtin/diff.c                               |   2 +
 builtin/difftool.c                           |   5 +
 builtin/fast-export.c                        |   1 +
 builtin/fast-import.c                        |   4 +
 builtin/fetch-pack.c                         |   1 +
 builtin/fetch.c                              |   2 +
 builtin/fmt-merge-msg.c                      |   2 +
 builtin/for-each-ref.c                       |   1 +
 builtin/for-each-repo.c                      |   1 +
 builtin/fsck.c                               |   1 +
 builtin/fsmonitor--daemon.c                  |   3 +
 builtin/gc.c                                 |   5 +
 builtin/get-tar-commit-id.c                  |   1 +
 builtin/grep.c                               |   3 +
 builtin/hash-object.c                        |   4 +
 builtin/help.c                               |   2 +
 builtin/hook.c                               |   1 +
 builtin/index-pack.c                         |   4 +
 builtin/init-db.c                            |   5 +
 builtin/interpret-trailers.c                 |   1 +
 builtin/log.c                                |   4 +
 builtin/ls-files.c                           |   2 +
 builtin/ls-remote.c                          |   1 +
 builtin/ls-tree.c                            |   1 +
 builtin/mailinfo.c                           |   3 +
 builtin/mailsplit.c                          |   1 +
 builtin/merge-base.c                         |   1 +
 builtin/merge-file.c                         |   3 +
 builtin/merge-recursive.c                    |   1 +
 builtin/merge-tree.c                         |   1 +
 builtin/merge.c                              |   4 +
 builtin/mktag.c                              |   1 +
 builtin/mktree.c                             |   1 +
 builtin/multi-pack-index.c                   |   3 +
 builtin/mv.c                                 |   4 +
 builtin/name-rev.c                           |   2 +
 builtin/notes.c                              |   2 +
 builtin/pack-objects.c                       |   3 +
 builtin/pack-redundant.c                     |   1 +
 builtin/pack-refs.c                          |   1 +
 builtin/patch-id.c                           |   1 +
 builtin/prune-packed.c                       |   1 +
 builtin/prune.c                              |   2 +
 builtin/pull.c                               |   1 +
 builtin/push.c                               |   2 +
 builtin/range-diff.c                         |   1 +
 builtin/read-tree.c                          |   2 +
 builtin/rebase.c                             |   4 +
 builtin/receive-pack.c                       |   4 +
 builtin/reflog.c                             |   1 +
 builtin/remote.c                             |   1 +
 builtin/repack.c                             |   2 +
 builtin/replace.c                            |   2 +
 builtin/rerere.c                             |   2 +
 builtin/reset.c                              |   3 +
 builtin/rev-list.c                           |   2 +
 builtin/rev-parse.c                          |   4 +
 builtin/revert.c                             |   1 +
 builtin/rm.c                                 |   2 +
 builtin/send-pack.c                          |   1 +
 builtin/shortlog.c                           |   3 +
 builtin/show-branch.c                        |   2 +
 builtin/show-index.c                         |   1 +
 builtin/show-ref.c                           |   1 +
 builtin/sparse-checkout.c                    |   3 +
 builtin/stash.c                              |   4 +
 builtin/stripspace.c                         |   3 +
 builtin/submodule--helper.c                  |   4 +
 builtin/symbolic-ref.c                       |   1 +
 builtin/tag.c                                |   3 +
 builtin/unpack-file.c                        |   1 +
 builtin/unpack-objects.c                     |   2 +
 builtin/update-index.c                       |   4 +
 builtin/update-ref.c                         |   1 +
 builtin/update-server-info.c                 |   1 +
 builtin/upload-pack.c                        |   1 +
 builtin/verify-commit.c                      |   1 +
 builtin/verify-pack.c                        |   1 +
 builtin/verify-tag.c                         |   1 +
 builtin/worktree.c                           |   4 +
 builtin/write-tree.c                         |   2 +
 bulk-checkin.c                               |   4 +-
 bulk-checkin.h                               |   2 +-
 bundle-uri.c                                 |   2 +
 bundle.c                                     |   3 +
 bundle.h                                     |   1 -
 cache-tree.c                                 |   3 +-
 cache.h                                      | 571 -------------------
 chdir-notify.c                               |   1 +
 chunk-format.c                               |   2 +
 color.c                                      |   1 +
 combine-diff.c                               |   1 +
 commit-graph.c                               |   4 +-
 commit.c                                     |   3 +
 common-main.c                                |   2 +
 compat/disk.h                                |   2 +
 compat/fsmonitor/fsm-health-win32.c          |   1 +
 compat/fsmonitor/fsm-listen-darwin.c         |   1 +
 compat/fsmonitor/fsm-listen-win32.c          |   1 +
 compat/fsmonitor/fsm-path-utils-darwin.c     |   1 +
 compat/fsmonitor/fsm-path-utils-win32.c      |   1 +
 compat/linux/procinfo.c                      |   2 +-
 compat/mingw.c                               |   4 +
 compat/precompose_utf8.c                     |   2 +
 compat/simple-ipc/ipc-shared.c               |   2 +-
 compat/simple-ipc/ipc-unix-socket.c          |   1 +
 compat/simple-ipc/ipc-win32.c                |   2 +
 compat/terminal.c                            |   4 +-
 config.c                                     |   7 +-
 connect.c                                    |   2 +
 connected.c                                  |   3 +-
 convert.c                                    |   2 +
 copy.c                                       |   1 +
 credential.c                                 |   2 +
 csum-file.c                                  |   3 +-
 csum-file.h                                  |   2 +-
 daemon.c                                     |   4 +
 date.c                                       |   1 +
 delta-islands.c                              |   3 +-
 diagnose.c                                   |   2 +
 diff-lib.c                                   |   1 +
 diff-no-index.c                              |   2 +
 diff.c                                       |   5 +
 dir.c                                        |   5 +
 editor.c                                     |   3 +
 entry.c                                      |   3 +
 environment.c                                |   5 +
 environment.h                                | 220 +++++++
 exec-cmd.c                                   |   3 +
 fetch-pack.c                                 |   5 +-
 fmt-merge-msg.c                              |   3 +-
 fsck.c                                       |   2 +-
 fsmonitor-ipc.c                              |   1 +
 fsmonitor.c                                  |   1 +
 gettext.c                                    |   4 +-
 git.c                                        |   3 +
 gpg-interface.c                              |   6 +-
 grep.c                                       |   3 +-
 http-backend.c                               |   5 +-
 http-fetch.c                                 |   2 +
 http-push.c                                  |   2 +
 imap-send.c                                  |   3 +
 line-log.c                                   |   2 +-
 list-objects-filter-options.h                |   1 +
 list-objects-filter.c                        |   1 +
 list-objects.c                               |   1 +
 ll-merge.c                                   |   1 +
 lockfile.c                                   |   4 +-
 log-tree.c                                   |   2 +
 ls-refs.c                                    |   4 +-
 mailmap.c                                    |   2 +
 merge-ort-wrappers.c                         |   1 +
 merge-ort.c                                  |   2 +
 merge-recursive.c                            |   3 +
 merge.c                                      |   1 +
 midx.c                                       |   4 +-
 name-hash.c                                  |   2 +
 negotiator/default.c                         |   2 +-
 negotiator/skipping.c                        |   2 +-
 notes-cache.c                                |   2 +-
 notes-merge.c                                |   2 +
 notes-utils.c                                |   4 +-
 notes.c                                      |   1 +
 object-file.c                                |   7 +-
 object-name.c                                |   3 +
 object.c                                     |   1 +
 pack-bitmap-write.c                          |   5 +-
 pack-bitmap.c                                |   3 +-
 pack-check.c                                 |   1 +
 pack-mtimes.c                                |   3 +-
 pack-revindex.c                              |   1 +
 pack-write.c                                 |   2 +
 pack.h                                       |   2 +
 packfile.c                                   |   5 +-
 packfile.h                                   |   4 +-
 parallel-checkout.c                          |   2 +
 parse-options-cb.c                           |   2 +
 parse-options.c                              |   3 +-
 parse-options.h                              |   2 +
 patch-ids.c                                  |   2 +-
 path.c                                       |   6 +-
 path.h                                       |  62 +-
 pathspec.c                                   |   4 +
 pkt-line.c                                   |   3 +
 preload-index.c                              |   2 +
 pretty.c                                     |   2 +
 progress.c                                   |   1 -
 promisor-remote.c                            |   1 +
 prompt.c                                     |   3 +-
 protocol.c                                   |   1 +
 prune-packed.c                               |   2 +
 range-diff.c                                 |   2 +
 reachable.c                                  |   3 +-
 read-cache.c                                 |   3 +
 rebase-interactive.c                         |   3 +
 ref-filter.c                                 |   4 +-
 ref-filter.h                                 |   1 +
 reflog.c                                     |   3 +-
 refs.c                                       |   6 +-
 refs.h                                       |   1 -
 refs/files-backend.c                         |   7 +-
 refs/iterator.c                              |   2 +-
 refs/packed-backend.c                        |   4 +-
 refspec.c                                    |   1 +
 remote-curl.c                                |   4 +
 remote.c                                     |   6 +-
 replace-object.c                             |   3 +-
 repository.c                                 |   2 +
 rerere.c                                     |   3 +
 rerere.h                                     |   1 +
 reset.c                                      |   1 +
 revision.c                                   |   3 +
 run-command.c                                |   2 +
 scalar.c                                     |   2 +
 send-pack.c                                  |   4 +-
 sequencer.c                                  |   4 +
 server-info.c                                |   4 +-
 setup.c                                      |   4 +
 setup.h                                      | 168 ++++++
 shallow.c                                    |   3 +-
 sideband.c                                   |   2 +
 sparse-index.c                               |   2 +
 split-index.c                                |   1 +
 strbuf.c                                     |   6 +-
 streaming.c                                  |   2 +
 streaming.h                                  |   4 +-
 submodule-config.c                           |   2 +
 submodule.c                                  |   6 +-
 symlinks.c                                   |   2 +
 t/helper/test-advise.c                       |   2 +-
 t/helper/test-bitmap.c                       |   3 +-
 t/helper/test-bloom.c                        |   4 +-
 t/helper/test-bundle-uri.c                   |   1 +
 t/helper/test-cache-tree.c                   |   2 +
 t/helper/test-config.c                       |   2 +-
 t/helper/test-delta.c                        |   2 +-
 t/helper/test-dump-cache-tree.c              |   2 +-
 t/helper/test-dump-fsmonitor.c               |   1 +
 t/helper/test-dump-split-index.c             |   1 +
 t/helper/test-dump-untracked-cache.c         |   1 +
 t/helper/test-fast-rebase.c                  |   5 +-
 t/helper/test-fsmonitor-client.c             |   2 +
 t/helper/test-hash.c                         |   1 -
 t/helper/test-lazy-init-name-hash.c          |   2 +
 t/helper/test-match-trees.c                  |   1 +
 t/helper/test-oid-array.c                    |   1 +
 t/helper/test-oidmap.c                       |   1 +
 t/helper/test-oidtree.c                      |   1 +
 t/helper/test-pack-mtimes.c                  |   2 +-
 t/helper/test-parse-pathspec-file.c          |   1 -
 t/helper/test-partial-clone.c                |   4 +-
 t/helper/test-path-utils.c                   |   3 +
 t/helper/test-pkt-line.c                     |   3 +-
 t/helper/test-proc-receive.c                 |   4 +-
 t/helper/test-progress.c                     |   1 -
 t/helper/test-reach.c                        |   3 +
 t/helper/test-read-cache.c                   |   2 +
 t/helper/test-read-graph.c                   |   2 +-
 t/helper/test-read-midx.c                    |   1 +
 t/helper/test-ref-store.c                    |   2 +-
 t/helper/test-repository.c                   |   3 +-
 t/helper/test-revision-walking.c             |   2 +-
 t/helper/test-run-command.c                  |   1 -
 t/helper/test-scrap-cache-tree.c             |   1 +
 t/helper/test-serve-v2.c                     |   3 +-
 t/helper/test-submodule-config.c             |   1 +
 t/helper/test-submodule-nested-repo-config.c |   2 +-
 t/helper/test-submodule.c                    |   2 +-
 t/helper/test-subprocess.c                   |   2 +-
 t/helper/test-trace2.c                       |   2 +-
 t/helper/test-userdiff.c                     |   2 +-
 t/helper/test-write-cache.c                  |   1 +
 tag.c                                        |   2 +
 tempfile.c                                   |   4 +-
 tmp-objdir.c                                 |   2 +
 trace.c                                      |   4 +
 trace2/tr2_cfg.c                             |   4 +-
 trace2/tr2_cmd_name.c                        |   3 +-
 trace2/tr2_dst.c                             |   4 +-
 trace2/tr2_sid.c                             |   3 +-
 trailer.c                                    |   4 +-
 transport-helper.c                           |   3 +
 transport.c                                  |   4 +-
 transport.h                                  |   1 -
 tree-walk.c                                  |   1 +
 unpack-trees.c                               |   3 +
 upload-pack.c                                |   3 +
 usage.c                                      |   4 +-
 walker.c                                     |   1 +
 worktree.c                                   |   5 +
 wrapper.c                                    |   3 +
 wrapper.h                                    |  36 ++
 write-or-die.c                               |   4 +-
 write-or-die.h                               |  78 +++
 wt-status.c                                  |   3 +
 xdiff-interface.c                            |   2 +-
 340 files changed, 1311 insertions(+), 669 deletions(-)
 create mode 100644 abspath.h
 create mode 100644 setup.h
 create mode 100644 wrapper.h
 create mode 100644 write-or-die.h


base-commit: e25cabbf6b34e4a6e903d65102d87055cc994778
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1493%2Fnewren%2Fheader-cleanup-2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1493/newren/header-cleanup-2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1493

Range-diff vs v1:

  1:  88959aba6f1 =  1:  a1be63930c4 treewide: remove unnecessary cache.h inclusion from a few headers
  2:  b771199fae3 =  2:  6e80396e861 treewide: be explicit about dependence on gettext.h
  3:  a31269a26b3 =  3:  644d305c669 treewide: remove unnecessary inclusion of gettext.h
  4:  3c193bef1d0 !  4:  95b86aecb43 treewide: remove unnecessary cache.h inclusion from several sources
     @@ Commit message
      
          A number of files were apparently including cache.h solely to get
          gettext.h.  By making those files explicitly include gettext.h, we can
     -    already drop the include of cache.h in these files.  Remove those now
     -    unnecessary includes.
     +    already drop the include of cache.h in these files.  On top of that,
     +    there were some files using cache.h that didn't need to for any reason.
     +    Remove these unnecessary includes.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
  5:  43457e44b4e =  5:  417b2ffa999 environment: move comment_line_char from cache.h
  6:  a0bbd2c9b48 !  6:  1fbd957047d abspath.h: move absolute path functions from cache.h
     @@ abspath.h (new)
      + */
      +char *prefix_filename(const char *prefix, const char *path);
      +
     ++/* Likewise, but path=="-" always yields "-" */
     ++char *prefix_filename_except_for_dash(const char *prefix, const char *path);
     ++
      +static inline int is_absolute_path(const char *path)
      +{
      +	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
     @@ cache.h: const char *setup_git_directory(void);
      - * prefix was empty).
      - */
      -char *prefix_filename(const char *prefix, const char *path);
     +-
     +-/* Likewise, but path=="-" always yields "-" */
     +-char *prefix_filename_except_for_dash(const char *prefix, const char *path);
      -
       int check_filename(const char *prefix, const char *name);
       void verify_filename(const char *prefix,
  7:  a0fc4aa2470 =  7:  805d0a86951 cache.h: remove expand_user_path()
  8:  0f48e561b79 =  8:  b0bfbe7f38c path.h: move function declarations for path.c functions from cache.h
  9:  66f06731cab =  9:  43a61845240 wrapper.h: move declarations for wrapper.c functions from cache.h
 10:  f4e15c9e5c2 = 10:  a6c7245219a treewide: remove unnecessary includes of cache.h
 11:  fa7449b5b99 = 11:  5ef1a4f1d6c environment.h: move declarations for environment.c functions from cache.h
 12:  4e6a4030b1e = 12:  496d36e4fd0 treewide: remove cache.h inclusion due to environment.h changes
 13:  9722988e537 = 13:  1d5cd115161 setup.h: move declarations for setup.c functions from cache.h
 14:  0e84202da90 = 14:  30b21691265 treewide: remove cache.h inclusion due to setup.h changes
 15:  626d089f10b = 15:  6e40d1d783d write-or-die.h: move declarations for write-or-die.c functions from cache.h
 16:  38af06f55bc = 16:  72d58b391a1 csum-file.h: remove unnecessary inclusion of cache.h

-- 
gitgitgadget
