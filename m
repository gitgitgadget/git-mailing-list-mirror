Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D490C761AF
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjDDBWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDDBWl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:22:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB3B1FCD
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j24so31187971wrd.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571356;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2doNXuoiwXJryth6uc8PWqDCJRp8NAISQacQALTkno=;
        b=OFCjSVOFrk451vY/3qo1xiQq3enWTvyHtcKqbCe6OZMpAzUXUGeMBm6vV6//B2kTvP
         gNyyrhr3j1Z5eENhQR2TeJmdY9P0ywxe7fqQVbYirpOmKzsxPVOnz3PK/GDQU5UbtU/N
         4fYD3+2l0PbU/Asdai/JUgO3Lo5P149nBBYt8TjbWCNruncCUvt+FzGI7xGR5Wyx7SqZ
         nBtxunBtNGcweL7aiRiE1wso5CKcjZ0irZPMd8Amg5hyz2DXJXnw+SWV7nlX9aFd5GIU
         ydrpu4tMiO3kgdKBNx7XmZQRffmBRhLJpvqsC08n5qA9vQ0qgoTKcvi0K+4WP/PuhZ+3
         0faQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571356;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2doNXuoiwXJryth6uc8PWqDCJRp8NAISQacQALTkno=;
        b=NeOkmCEkdItRdirEP75oJlE5TNhVDKRzGZU21Fjp5LUIvP8jrb+jqSvyRZuRMaWgqW
         lMya1UGtSvwr7AqlF/mMXXzdFaVQtTus2f3SdxegoMBkbmEf90r1lWkBmqqnKbxRH9BV
         UNQCgQ+CyfCgQ9ICzA58kXfPDMNWISjVhzOJ3CqYygb3fBlTSzW0F64/4WpSumyhGCmh
         GOoupYZ2osg6+9OJz2e1jjZLCwlIXXqvuBhKvO6rC9DbXuAvd048bKAM//7/3s2RC9l9
         +WGE+of1x66yG7eGBix6EK9GbRakGtIm7ZY2b7U61AUlAZSCdaOld46Ht6ri86pnapW+
         5SjQ==
X-Gm-Message-State: AAQBX9ezK/ugs6bVcHD1pDmBUFEGrhTfvfPYmzP0AFYinUFP5Hq+iXWv
        vMrA/TjVkRl9VpHaAzQOmPH2uk90ov4=
X-Google-Smtp-Source: AKy350ZnXW0SmxprkP9PHv1kw5+VRxwHVSUxnL2/S9JE/Jhfu0sbOY1qKUdeVuAzsVZA2ZIMRAelLw==
X-Received: by 2002:adf:ec48:0:b0:2cf:ee9d:ce2f with SMTP id w8-20020adfec48000000b002cfee9dce2fmr317916wrn.19.1680571355798;
        Mon, 03 Apr 2023 18:22:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3-20020adfcd03000000b002d45575643esm10893656wrm.43.2023.04.03.18.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:35 -0700 (PDT)
Message-Id: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:04 +0000
Subject: [PATCH v2 00/24] Header cleanups (splitting up cache.h)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maintainer notes: (1) This series is based on a merge of
en/header-split-cleanup and ab/remove-implicit-use-of-the-repository (both
in next). (2) Although I've tweaked the series to minimize conflicts (and
this series merges syntactically cleanly with next and seen), there is a
semantic conflict with each of ja/worktree-orphan and
ab/tag-object-type-errors in seen; to correct, simply add an include of
advice.h in builtin/worktree.c and an include of gettext.h in tag.c,
respectively.

This series builds on en/header-cleanup
(https://lore.kernel.org/git/pull.1485.v2.git.1677197376.gitgitgadget@gmail.com/)
and en/header-split-cleanup
(https://lore.kernel.org/git/pull.1493.v2.git.1679379968.gitgitgadget@gmail.com/),
and continues to focus on splitting declarations from cache.h to separate
headers. This series continues dropping the number of cache.h includes; in
this series we go from 254 such includes to 190.

The series may appear to be long at first glance, but is repetitive and
simple. It should be relatively easy to review, and falls into roughly 3
categories. An overview:

 * Patches 1-6, 7: Being more explicit about dependencies. This was
   motivated by the fact that trying to find unnecessary dependencies on
   cache.h were being made harder by implicit dependencies on trace.h,
   trace2.h, and advice.h that were included via cache.h. (Similar to
   gettext.h handling in the previous series.) So I simply try to make
   dependencies more explicit, for both these headers and a few others. To
   make review easy, I split it into half a dozen patches, one header per
   patch (well, except that I handle trace.h and trace2.h together). Patch 7
   then removes several includes of cache.h that are no longer needed due to
   patches 1-6.
 * Patches 8-19: For several choices of FOO, move declarations of functions
   for FOO.c from cache.h to FOO.h. To simplify reviewing, each case is
   split into two patches, with the second patch cleaning up unnecessary
   includes of cache.h in other source files.
 * Patches 20-24: Other small manual cleanups noticed while doing above work

Since patches 1-15 & 17-19 are just more of the same types of patches
already reviewed in the last two series, it probably makes more sense for
reviewers to focus on the other patches: 16 + 20-24 (which also happen to be
smaller). I would particularly most like review of patches 16, 22, & 24
since they are the least like any previously reviewed patches.

Changes since v1:

 * Moved a few more things from cache.h to object.h, object-file.h, and
   object-name.h
 * Split the object.h changes into two patches to be more like all the other
   patches in 8-19
 * Squashed patches 22 & 23, since both were just manual replacements of
   cache.h inclusion with some other header
 * Removed a couple cases of duplicate inclusions of git-compat-util.h

There are more changes I plan to make after this series graduates (still
focused around splitting up cache.h), but this series was long enough.

And thanks once again to Dscho for gitgitgadget. Getting multiple platform
testing + all the special tests (sparse, cocci, hdr-check, etc.) really
helps clean out all the issues that would otherwise hit a series like this.

Elijah Newren (24):
  treewide: be explicit about dependence on trace.h & trace2.h
  treewide: be explicit about dependence on advice.h
  treewide: be explicit about dependence on convert.h
  treewide: be explicit about dependence on pack-revindex.h
  treewide: be explicit about dependence on oid-array.h
  treewide: be explicit about dependence on mem-pool.h
  treewide: remove unnecessary cache.h inclusion
  object-name.h: move declarations for object-name.c functions from
    cache.h
  treewide: remove cache.h inclusion due to object-name.h changes
  git-zlib: move declarations for git-zlib functions from cache.h
  treewide: remove cache.h inclusion due to git-zlib changes
  object-file.h: move declarations for object-file.c functions from
    cache.h
  treewide: remove cache.h inclusion due to object-file.h changes
  object.h: move some inline functions and defines from cache.h
  treewide: remove cache.h inclusion due to object.h changes
  editor: move editor-related functions and declarations into common
    file
  treewide: remove cache.h inclusion due to editor.h changes
  pager.h: move declarations for pager.c functions from cache.h
  treewide: remove cache.h inclusion due to pager.h changes
  cache.h: remove unnecessary includes
  strbuf: move forward declarations to beginning of file
  treewide: remove double forward declaration of read_in_full
  treewide: reduce includes of cache.h in other headers
  mailmap, quote: move declarations of global vars to correct unit

 Makefile                                 |   2 +-
 add-patch.c                              |   3 +
 apply.c                                  |   2 +
 archive-tar.c                            |   1 +
 archive-zip.c                            |   1 +
 archive.c                                |   1 +
 archive.h                                |   3 +-
 bisect.c                                 |   3 +-
 blame.c                                  |   2 +
 branch.c                                 |   3 +-
 builtin/add.c                            |   2 +
 builtin/am.c                             |   4 +
 builtin/bisect.c                         |   2 +
 builtin/blame.c                          |   2 +
 builtin/branch.c                         |   2 +
 builtin/bugreport.c                      |   2 +
 builtin/cat-file.c                       |   3 +
 builtin/check-attr.c                     |   1 +
 builtin/checkout.c                       |   3 +
 builtin/clone.c                          |   3 +
 builtin/commit-graph.c                   |   1 +
 builtin/commit-tree.c                    |   1 +
 builtin/commit.c                         |   3 +
 builtin/config.c                         |   1 +
 builtin/credential-cache--daemon.c       |   1 +
 builtin/describe.c                       |   1 +
 builtin/diagnose.c                       |   1 +
 builtin/difftool.c                       |   1 +
 builtin/fast-export.c                    |   1 +
 builtin/fast-import.c                    |   2 +
 builtin/fetch-pack.c                     |   1 +
 builtin/fetch.c                          |   6 +
 builtin/fsck.c                           |   2 +
 builtin/fsmonitor--daemon.c              |   1 +
 builtin/gc.c                             |   2 +
 builtin/grep.c                           |   3 +
 builtin/hash-object.c                    |   1 +
 builtin/help.c                           |   1 +
 builtin/index-pack.c                     |   3 +
 builtin/init-db.c                        |   1 +
 builtin/log.c                            |   4 +
 builtin/ls-files.c                       |   2 +
 builtin/ls-tree.c                        |   1 +
 builtin/merge-base.c                     |   1 +
 builtin/merge-recursive.c                |   2 +
 builtin/merge-tree.c                     |   1 +
 builtin/merge.c                          |   3 +
 builtin/mktag.c                          |   1 +
 builtin/mv.c                             |   2 +
 builtin/name-rev.c                       |   2 +
 builtin/notes.c                          |   2 +
 builtin/pack-objects.c                   |   1 +
 builtin/prune.c                          |   2 +
 builtin/pull.c                           |   2 +
 builtin/push.c                           |   2 +
 builtin/range-diff.c                     |   1 +
 builtin/read-tree.c                      |   1 +
 builtin/rebase.c                         |   3 +
 builtin/receive-pack.c                   |   3 +
 builtin/replace.c                        |   3 +
 builtin/reset.c                          |   4 +
 builtin/rev-list.c                       |   2 +
 builtin/rev-parse.c                      |   1 +
 builtin/rm.c                             |   1 +
 builtin/show-branch.c                    |   1 +
 builtin/show-ref.c                       |   1 +
 builtin/sparse-checkout.c                |   2 +
 builtin/stash.c                          |   1 +
 builtin/submodule--helper.c              |   2 +
 builtin/tag.c                            |   3 +
 builtin/unpack-file.c                    |   1 +
 builtin/unpack-objects.c                 |   1 +
 builtin/update-index.c                   |   1 +
 builtin/update-ref.c                     |   1 +
 builtin/var.c                            |   2 +
 builtin/verify-commit.c                  |   1 +
 builtin/verify-tag.c                     |   1 +
 builtin/worktree.c                       |   2 +
 bulk-checkin.c                           |   4 +-
 bundle.c                                 |   2 +-
 cache-tree.c                             |   3 +
 cache.h                                  | 330 -----------------------
 chdir-notify.c                           |   4 +-
 checkout.c                               |   4 +-
 color.c                                  |   2 +
 column.c                                 |   3 +-
 combine-diff.c                           |   3 +
 commit-graph.c                           |   4 +-
 commit.c                                 |   3 +-
 common-main.c                            |   1 +
 compat/fsmonitor/fsm-listen-win32.c      |   1 +
 compat/mingw.c                           |   1 +
 compat/pread.c                           |   1 +
 compat/simple-ipc/ipc-unix-socket.c      |   3 +-
 compat/simple-ipc/ipc-win32.c            |   2 +
 compat/win32/trace2_win32_process_info.c |   1 +
 config.c                                 |   6 +
 connect.c                                |   2 +-
 convert.c                                |   3 +
 date.c                                   |   1 +
 delta-islands.c                          |   2 +-
 diff-lib.c                               |   2 +
 diff-no-index.c                          |   2 +-
 diff.c                                   |   5 +
 dir.c                                    |   3 +
 editor.c                                 |  34 ++-
 editor.h                                 |  34 +++
 environment.c                            |   4 +-
 exec-cmd.c                               |   2 +
 fetch-pack.c                             |   3 +-
 fmt-merge-msg.c                          |   3 +-
 fsck.c                                   |   2 +-
 fsmonitor.c                              |   1 +
 fsmonitor.h                              |   1 +
 git-compat-util.h                        |   6 -
 zlib.c => git-zlib.c                     |   3 +-
 git-zlib.h                               |  28 ++
 git.c                                    |   3 +
 grep.c                                   |   1 +
 http-backend.c                           |   3 +-
 http-fetch.c                             |   2 +-
 http-push.c                              |   2 +-
 http-walker.c                            |   2 +-
 http.c                                   |   2 +
 http.h                                   |   4 +-
 list-objects-filter.c                    |   3 +-
 list-objects.c                           |   2 +-
 ll-merge.c                               |   1 +
 log-tree.c                               |   3 +-
 mailmap.c                                |   3 +-
 mailmap.h                                |   3 +
 merge-ort.c                              |   4 +
 merge-recursive.c                        |   2 +
 midx.c                                   |   1 +
 name-hash.c                              |   1 +
 notes-merge.c                            |   6 +-
 notes.c                                  |   3 +-
 object-file.c                            |   2 +
 object-file.h                            | 129 +++++++++
 object-name.c                            |   2 +
 object-name.h                            | 121 +++++++++
 object.c                                 |   1 +
 object.h                                 |  44 +++
 pack-bitmap-write.c                      |   2 +-
 pack-bitmap.c                            |   4 +-
 pack-check.c                             |   3 +-
 pack-mtimes.c                            |   3 +-
 pack-revindex.c                          |   4 +-
 pack-write.c                             |   4 +-
 packfile.c                               |   3 +
 pager.c                                  |   6 +-
 pager.h                                  |  17 ++
 parse-options-cb.c                       |   2 +-
 path.c                                   |   1 +
 pkt-line.c                               |   1 +
 preload-index.c                          |   1 +
 pretty.c                                 |   3 +-
 progress.c                               |   4 +-
 promisor-remote.c                        |   3 +-
 protocol.c                               |   3 +-
 quote.c                                  |   3 +-
 quote.h                                  |   2 +
 range-diff.c                             |   2 +
 read-cache.c                             |   5 +
 rebase-interactive.c                     |   4 +-
 ref-filter.c                             |   2 +
 refs.c                                   |   4 +-
 refs/files-backend.c                     |   1 +
 refs/packed-backend.c                    |   1 +
 refs/ref-cache.h                         |   2 +-
 remote-curl.c                            |   1 +
 remote.c                                 |   3 +-
 repository.c                             |   1 +
 rerere.c                                 |   3 +-
 reset.c                                  |   1 +
 resolve-undo.h                           |   7 +-
 revision.c                               |   5 +-
 run-command.c                            |   2 +
 scalar.c                                 |   3 +-
 send-pack.c                              |   1 +
 sequencer.c                              |   4 +
 server-info.c                            |   1 +
 setup.c                                  |   5 +-
 shallow.c                                |   1 +
 sideband.c                               |   3 +-
 split-index.c                            |   1 +
 split-index.h                            |   2 +-
 strbuf.c                                 |  31 +--
 strbuf.h                                 |  33 +--
 streaming.c                              |   4 +-
 submodule-config.c                       |   3 +-
 submodule.c                              |   3 +
 t/helper/test-date.c                     |   2 +-
 t/helper/test-fast-rebase.c              |   1 +
 t/helper/test-lazy-init-name-hash.c      |   1 +
 t/helper/test-match-trees.c              |   1 +
 t/helper/test-mergesort.c                |   1 +
 t/helper/test-oidmap.c                   |   2 +-
 t/helper/test-path-utils.c               |   1 +
 t/helper/test-reach.c                    |   2 +-
 t/helper/test-submodule-config.c         |   2 +-
 tag.c                                    |   3 +-
 tmp-objdir.c                             |   3 +-
 trace.c                                  |   3 +-
 trace2.c                                 |   1 +
 transport-helper.c                       |   3 +-
 transport.c                              |   5 +-
 tree-walk.c                              |   2 +
 tree.c                                   |   1 +
 unpack-trees.c                           |   2 +
 unpack-trees.h                           |   1 +
 upload-pack.c                            |   5 +-
 walker.c                                 |   2 +-
 wrapper.c                                |   1 +
 wt-status.c                              |   4 +
 215 files changed, 807 insertions(+), 465 deletions(-)
 create mode 100644 editor.h
 rename zlib.c => git-zlib.c (99%)
 create mode 100644 git-zlib.h
 create mode 100644 object-file.h
 create mode 100644 object-name.h
 create mode 100644 pager.h


base-commit: dc1c48a4a2bce29542f330137106c01daa728f9e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1509%2Fnewren%2Fheader-cleanup-3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1509/newren/header-cleanup-3-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1509

Range-diff vs v1:

  1:  6acf4eb2c77 =  1:  6acf4eb2c77 treewide: be explicit about dependence on trace.h & trace2.h
  2:  e163bed61ff =  2:  e163bed61ff treewide: be explicit about dependence on advice.h
  3:  4ef4ee9daf3 =  3:  4ef4ee9daf3 treewide: be explicit about dependence on convert.h
  4:  86b47be1776 =  4:  86b47be1776 treewide: be explicit about dependence on pack-revindex.h
  5:  81a9378be43 =  5:  81a9378be43 treewide: be explicit about dependence on oid-array.h
  6:  c6a561cf433 =  6:  c6a561cf433 treewide: be explicit about dependence on mem-pool.h
  7:  22709819107 !  7:  3c12d5ba6c3 treewide: remove unnecessary cache.h inclusion
     @@ connect.c
      @@
       #include "git-compat-util.h"
      -#include "cache.h"
     -+#include "git-compat-util.h"
       #include "config.h"
       #include "environment.h"
       #include "gettext.h"
  8:  b513a6711ff !  8:  1e2e60bffc7 object-name.h: move declarations for object-name.c functions from cache.h
     @@ archive.h
       
       struct repository;
      
     + ## bisect.c ##
     +@@
     + #include "strvec.h"
     + #include "commit-slab.h"
     + #include "commit-reach.h"
     ++#include "object-name.h"
     + #include "object-store.h"
     + #include "dir.h"
     + 
     +
       ## branch.c ##
      @@
       #include "environment.h"
     @@ cache.h: extern int quote_path_fully;
       /*
        * Create the directory containing the named path, using care to be
        * somewhat safe against races. Return one of the scld_error values to
     -@@ cache.h: struct object_context {
     - 	char *path;
     - };
     +@@ cache.h: int finalize_object_file(const char *tmpfile, const char *filename);
     + /* Helper to check and "touch" a file */
     + int check_and_freshen_file(const char *fn, int freshen);
       
     +-/* Convert to/from hex/sha1 representation */
     +-#define MINIMUM_ABBREV minimum_abbrev
     +-#define DEFAULT_ABBREV default_abbrev
     +-
     +-/* used when the code does not know or care what the default abbrev is */
     +-#define FALLBACK_DEFAULT_ABBREV 7
     +-
     +-struct object_context {
     +-	unsigned short mode;
     +-	/*
     +-	 * symlink_path is only used by get_tree_entry_follow_symlinks,
     +-	 * and only for symlinks that point outside the repository.
     +-	 */
     +-	struct strbuf symlink_path;
     +-	/*
     +-	 * If GET_OID_RECORD_PATH is set, this will record path (if any)
     +-	 * found when resolving the name. The caller is responsible for
     +-	 * releasing the memory.
     +-	 */
     +-	char *path;
     +-};
     +-
      -int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
      -__attribute__((format (printf, 2, 3)))
      -int get_oidf(struct object_id *oid, const char *fmt, ...);
     @@ merge-ort.c
       #include "oid-array.h"
       #include "promisor-remote.h"
      
     + ## merge-recursive.c ##
     +@@
     + #include "hex.h"
     + #include "ll-merge.h"
     + #include "lockfile.h"
     ++#include "object-name.h"
     + #include "object-store.h"
     + #include "repository.h"
     + #include "revision.h"
     +
       ## notes-merge.c ##
      @@
       #include "commit.h"
     @@ object-name.h (new)
      +#define OBJECT_NAME_H
      +
      +#include "object.h"
     ++#include "strbuf.h"
      +
     -+struct object_context;
      +struct object_id;
      +struct repository;
     -+struct strbuf;
     ++
     ++struct object_context {
     ++	unsigned short mode;
     ++	/*
     ++	 * symlink_path is only used by get_tree_entry_follow_symlinks,
     ++	 * and only for symlinks that point outside the repository.
     ++	 */
     ++	struct strbuf symlink_path;
     ++	/*
     ++	 * If GET_OID_RECORD_PATH is set, this will record path (if any)
     ++	 * found when resolving the name. The caller is responsible for
     ++	 * releasing the memory.
     ++	 */
     ++	char *path;
     ++};
      +
      +/*
      + * Return an abbreviated sha1 unique within this repository's object database.
     @@ object-name.h (new)
      +struct object *repo_peel_to_type(struct repository *r,
      +				 const char *name, int namelen,
      +				 struct object *o, enum object_type);
     ++
     ++/* Convert to/from hex/sha1 representation */
     ++#define MINIMUM_ABBREV minimum_abbrev
     ++#define DEFAULT_ABBREV default_abbrev
     ++
     ++/* used when the code does not know or care what the default abbrev is */
     ++#define FALLBACK_DEFAULT_ABBREV 7
     ++
      +#endif /* OBJECT_NAME_H */
      
       ## parse-options-cb.c ##
  9:  e3ec14f90a5 !  9:  62f61514e2f treewide: remove cache.h inclusion due to object-name.h changes
     @@ branch.c
      @@
       #include "git-compat-util.h"
      -#include "cache.h"
     -+#include "git-compat-util.h"
       #include "advice.h"
       #include "config.h"
       #include "branch.h"
 10:  2f240f07551 = 10:  54545bbb02c git-zlib: move declarations for git-zlib functions from cache.h
 11:  7c969dc801d = 11:  dbfe03129e3 treewide: remove cache.h inclusion due to git-zlib changes
 12:  7cd3acfdb86 ! 12:  5efd49df148 object-file.h: move declarations for object-file.c functions from cache.h
     @@ builtin/fast-import.c
       #include "object-store.h"
       #include "mem-pool.h"
      
     + ## builtin/fetch-pack.c ##
     +@@
     + #include "alloc.h"
     + #include "gettext.h"
     + #include "hex.h"
     ++#include "object-file.h"
     + #include "pkt-line.h"
     + #include "fetch-pack.h"
     + #include "remote.h"
     +
       ## builtin/fsck.c ##
      @@
       #include "streaming.h"
     @@ builtin/pack-objects.c
       #include "replace-object.h"
       #include "dir.h"
      
     + ## builtin/prune.c ##
     +@@
     + #include "progress.h"
     + #include "prune-packed.h"
     + #include "replace-object.h"
     ++#include "object-file.h"
     + #include "object-name.h"
     + #include "object-store.h"
     + #include "shallow.h"
     +
       ## builtin/rebase.c ##
      @@
       #include "cache-tree.h"
     @@ builtin/replace.c
       #include "object-store.h"
       #include "replace-object.h"
      
     + ## builtin/rev-list.c ##
     +@@
     + #include "list-objects-filter-options.h"
     + #include "object.h"
     + #include "object-name.h"
     ++#include "object-file.h"
     + #include "object-store.h"
     + #include "pack.h"
     + #include "pack-bitmap.h"
     +
       ## builtin/sparse-checkout.c ##
      @@
       #include "dir.h"
     @@ cache-tree.c
       #include "promisor-remote.h"
      
       ## cache.h ##
     +@@
     + 
     + #include "git-compat-util.h"
     + #include "strbuf.h"
     +-#include "git-zlib.h"
     + #include "hashmap.h"
     + #include "list.h"
     + #include "gettext.h"
      @@ cache.h: int has_racy_timestamp(struct index_state *istate);
       int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
       int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
     @@ cache.h: extern int quote_path_fully;
      -/* Helper to check and "touch" a file */
      -int check_and_freshen_file(const char *fn, int freshen);
      -
     - /* Convert to/from hex/sha1 representation */
     - #define MINIMUM_ABBREV minimum_abbrev
     - #define DEFAULT_ABBREV default_abbrev
     + int base_name_compare(const char *name1, size_t len1, int mode1,
     + 		      const char *name2, size_t len2, int mode2);
     + int df_name_compare(const char *name1, size_t len1, int mode1,
      @@ cache.h: int df_name_compare(const char *name1, size_t len1, int mode1,
       int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
       int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
     @@ cache.h: int df_name_compare(const char *name1, size_t len1, int mode1,
       const char *git_editor(void);
       const char *git_sequence_editor(void);
       const char *git_pager(int stdout_is_tty);
     +@@ cache.h: struct pack_entry {
     + 	struct packed_git *p;
     + };
     + 
     +-/*
     +- * Set this to 0 to prevent oid_object_info_extended() from fetching missing
     +- * blobs. This has a difference only if extensions.partialClone is set.
     +- *
     +- * Its default value is 1.
     +- */
     +-extern int fetch_if_missing;
     +-
     + /* Dumb servers support */
     + int update_server_info(int);
     + 
      
       ## commit-graph.c ##
      @@
     @@ merge-recursive.c
       #include "ll-merge.h"
       #include "lockfile.h"
      +#include "object-file.h"
     + #include "object-name.h"
       #include "object-store.h"
       #include "repository.h"
     - #include "revision.h"
      
       ## midx.c ##
      @@
     @@ object-file.h (new)
      +#include "git-zlib.h"
      +#include "object.h"
      +
     ++/*
     ++ * Set this to 0 to prevent oid_object_info_extended() from fetching missing
     ++ * blobs. This has a difference only if extensions.partialClone is set.
     ++ *
     ++ * Its default value is 1.
     ++ */
     ++extern int fetch_if_missing;
     ++
      +#define HASH_WRITE_OBJECT 1
      +#define HASH_FORMAT_CHECK 2
      +#define HASH_RENORMALIZE  4
     @@ rerere.c
       #include "hash-lookup.h"
       #include "strmap.h"
      
     + ## revision.c ##
     +@@
     + #include "gettext.h"
     + #include "hex.h"
     + #include "object-name.h"
     ++#include "object-file.h"
     + #include "object-store.h"
     + #include "tag.h"
     + #include "blob.h"
     +
       ## sequencer.c ##
      @@
       #include "hex.h"
 13:  c103d486b2a = 13:  1827ecb4d1d treewide: remove cache.h inclusion due to object-file.h changes
 14:  fa58cf82c66 ! 14:  8937f6d5ac5 object.h: move an inline function and some defines from cache.h
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    object.h: move an inline function and some defines from cache.h
     +    object.h: move some inline functions and defines from cache.h
      
          The object_type() inline function is very tied to the enum object_type
          declaration within object.h, and just seemed to make more sense to live
     -    there.  Move it, and as a side-effect, remove a bunch of dependencies
     -    on cache.h that are no longer needed.
     +    there.  That makes S_ISGITLINK and some other defines make sense to go
     +    with it, as well as the create_ce_mode() and canon_mode() inline
     +    functions.  Move all these inline functions and defines from cache.h to
     +    object.h.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     - ## bundle.c ##
     -@@
     --#include "cache.h"
     -+#include "git-compat-util.h"
     - #include "lockfile.h"
     - #include "bundle.h"
     - #include "environment.h"
     -
       ## cache.h ##
      @@
       #define DTYPE(de)	DT_UNKNOWN
     @@ cache.h: struct cache_entry {
       /* Forward structure decls */
       struct pathspec;
       struct child_process;
     +@@ cache.h: static inline unsigned create_ce_flags(unsigned stage)
     + #define ce_mark_uptodate(ce) ((ce)->ce_flags |= CE_UPTODATE)
     + #define ce_intent_to_add(ce) ((ce)->ce_flags & CE_INTENT_TO_ADD)
     + 
     +-#define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
     +-static inline unsigned int create_ce_mode(unsigned int mode)
     +-{
     +-	if (S_ISLNK(mode))
     +-		return S_IFLNK;
     +-	if (S_ISSPARSEDIR(mode))
     +-		return S_IFDIR;
     +-	if (S_ISDIR(mode) || S_ISGITLINK(mode))
     +-		return S_IFGITLINK;
     +-	return S_IFREG | ce_permissions(mode);
     +-}
     + static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
     + 					     unsigned int mode)
     + {
     +@@ cache.h: static inline int ce_to_dtype(const struct cache_entry *ce)
     + 	else
     + 		return DT_UNKNOWN;
     + }
     +-static inline unsigned int canon_mode(unsigned int mode)
     +-{
     +-	if (S_ISREG(mode))
     +-		return S_IFREG | ce_permissions(mode);
     +-	if (S_ISLNK(mode))
     +-		return S_IFLNK;
     +-	if (S_ISDIR(mode))
     +-		return S_IFDIR;
     +-	return S_IFGITLINK;
     +-}
     + 
     + static inline int ce_path_match(struct index_state *istate,
     + 				const struct cache_entry *ce,
      @@ cache.h: void prefetch_cache_entries(const struct index_state *istate,
       extern struct index_state the_index;
       #endif
     @@ cache.h: void prefetch_cache_entries(const struct index_state *istate,
       #define INIT_DB_EXIST_OK 0x0002
       
      
     - ## delta-islands.c ##
     -@@
     --#include "cache.h"
     -+#include "git-compat-util.h"
     - #include "alloc.h"
     - #include "attr.h"
     - #include "object.h"
     -
     - ## fsck.c ##
     -@@
     --#include "cache.h"
     -+#include "git-compat-util.h"
     - #include "alloc.h"
     - #include "hex.h"
     - #include "object-store.h"
     -
     - ## http-push.c ##
     -@@
     --#include "cache.h"
     -+#include "git-compat-util.h"
     - #include "environment.h"
     - #include "hex.h"
     - #include "repository.h"
     -
     - ## list-objects.c ##
     -@@
     --#include "cache.h"
     -+#include "git-compat-util.h"
     - #include "tag.h"
     - #include "commit.h"
     - #include "gettext.h"
     -
       ## object.h ##
      @@ object.h: enum object_type {
       	OBJ_MAX
     @@ object.h: enum object_type {
      +		S_ISGITLINK(mode) ? OBJ_COMMIT :
      +		OBJ_BLOB;
      +}
     ++
     ++#define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
     ++static inline unsigned int create_ce_mode(unsigned int mode)
     ++{
     ++	if (S_ISLNK(mode))
     ++		return S_IFLNK;
     ++	if (S_ISSPARSEDIR(mode))
     ++		return S_IFDIR;
     ++	if (S_ISDIR(mode) || S_ISGITLINK(mode))
     ++		return S_IFGITLINK;
     ++	return S_IFREG | ce_permissions(mode);
     ++}
     ++
     ++static inline unsigned int canon_mode(unsigned int mode)
     ++{
     ++	if (S_ISREG(mode))
     ++		return S_IFREG | ce_permissions(mode);
     ++	if (S_ISLNK(mode))
     ++		return S_IFLNK;
     ++	if (S_ISDIR(mode))
     ++		return S_IFDIR;
     ++	return S_IFGITLINK;
     ++}
      +
       /*
        * The object type is stored in 3 bits.
        */
     -
     - ## pack-bitmap-write.c ##
     -@@
     --#include "cache.h"
     -+#include "git-compat-util.h"
     - #include "alloc.h"
     - #include "environment.h"
     - #include "gettext.h"
     -
     - ## submodule-config.c ##
     -@@
     --#include "cache.h"
     -+#include "git-compat-util.h"
     - #include "alloc.h"
     - #include "dir.h"
     - #include "environment.h"
     -
     - ## walker.c ##
     -@@
     --#include "cache.h"
     -+#include "git-compat-util.h"
     - #include "gettext.h"
     - #include "hex.h"
     - #include "walker.h"
  -:  ----------- > 15:  c85f9baed8c treewide: remove cache.h inclusion due to object.h changes
 15:  1e0a9441e73 ! 16:  0ac095731a7 editor: move editor-related functions and declarations into common file
     @@ pager.c
      
       ## rebase-interactive.c ##
      @@
     - #include "cache.h"
     + #include "git-compat-util.h"
       #include "commit.h"
      +#include "editor.h"
       #include "environment.h"
 16:  4b41942a24e = 17:  9550d976141 treewide: remove cache.h inclusion due to editor.h changes
 17:  be8c5229baa ! 18:  d658ee210d9 pager.h: move declarations for pager.c functions from cache.h
     @@ builtin/var.c
       static const char var_usage[] = "git var (-l | <variable>)";
      
       ## cache.h ##
     +@@ cache.h: struct cache_entry {
     + 
     + /* Forward structure decls */
     + struct pathspec;
     +-struct child_process;
     + struct tree;
     + 
     + /*
      @@ cache.h: int df_name_compare(const char *name1, size_t len1, int mode1,
       int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
       int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 18:  ec79da0235e = 19:  07d1a65a0ec treewide: remove cache.h inclusion due to pager.h changes
 19:  c8f7559553f ! 20:  23e0a81e788 cache.h: remove unnecessary includes
     @@ Commit message
      
       ## cache.h ##
      @@
     + #include "git-compat-util.h"
       #include "strbuf.h"
     - #include "git-zlib.h"
       #include "hashmap.h"
      -#include "list.h"
       #include "gettext.h"
 20:  7c3235c7943 = 21:  47afc6a6c87 strbuf: move forward declarations to beginning of file
 21:  3a0d78e2f93 = 22:  6079c470cd1 treewide: remove double forward declaration of read_in_full
 22:  c4808cf9578 ! 23:  538d95833a2 treewide: reduce includes of cache.h in other headers
     @@ archive.h
       struct repository;
       struct pretty_print_context;
      
     + ## chdir-notify.c ##
     +@@
     +-#include "cache.h"
     ++#include "git-compat-util.h"
     + #include "abspath.h"
     + #include "chdir-notify.h"
     + #include "list.h"
     ++#include "path.h"
     + #include "strbuf.h"
     + #include "trace.h"
     + 
     +
     + ## quote.c ##
     +@@
     +-#include "cache.h"
     ++#include "git-compat-util.h"
     + #include "alloc.h"
     ++#include "path.h"
     + #include "quote.h"
     + #include "strbuf.h"
     + #include "strvec.h"
     +
       ## refs/ref-cache.h ##
      @@
       #ifndef REFS_REF_CACHE_H
 23:  50cbcacaad1 <  -:  ----------- chdir-notify, quote: replace cache.h include with path.h
 24:  2421bb380b1 ! 24:  30e37a37c12 mailmap, quote: move declarations of global vars to correct unit
     @@ cache.h: void set_alternate_index_output(const char *);
       #define MTIME_CHANGED	0x0001
       #define CTIME_CHANGED	0x0002
       #define OWNER_CHANGED	0x0004
     -@@ cache.h: extern int fetch_if_missing;
     +@@ cache.h: struct pack_entry {
       /* Dumb servers support */
       int update_server_info(int);
       

-- 
gitgitgadget
