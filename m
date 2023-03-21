Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449E7C761AF
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 06:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCUG04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjCUG0c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 02:26:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927FD32E62
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l12so12496317wrm.10
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679379981;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILYYlRpKhdlMjpUZiIkKymAgnCvjFKRtF2mjs96KznE=;
        b=G5WtMzCoIjz/FgGxL0iz2hZLJzKcyYuD9tWy6ybBv6hK4qj8bnTH9rH5LgNp057pDj
         re0Mbr0ZbP4X7s9MuEb+7rILv7A43XOQ/13q6t+u82yx0fE7F9KZeAH8agmYNpYQD3rx
         utEAw9kOK9jOJWr4j9HtZJggeQQZAXDZOHluUf2rWgkAWGAVgAeZvF63SzzuwoYmgKjd
         SqKP23wzqlhcC/c2fqyQDeEFbkR+zFuEj7K4oV41711jIdcLnIbA5Cm+zOf4FqoQOjEL
         /D5Ix7+SVvDoPjP9k30n0DGZVilSvpioCILOfO/+gWeHeCCmk62PEdpjcxn0u5iGeYTW
         QlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379981;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILYYlRpKhdlMjpUZiIkKymAgnCvjFKRtF2mjs96KznE=;
        b=WVB83drL4mUWZamNXBUnLiogT0COSco9XRL7PhusRnWkjCxO87kIcwzDNVgIxEWt/h
         Br2Im4tLYwUDI7NwrogG3XL/JTeL+zk7yAv1KoRgmxW4I5T3VhYbCNjfzITtortrKcIn
         DfFRrnfPFo2GujkUu5jcMm/TxnQx8ec1+E6FmkYRA1caZwsixTAsw3RejoQVo4F3gpj1
         0OT7Z1gBBDjidsx0dVw7ODOTRuGVbs7HuuGOFiQ+niGFqI1+HY7H83hyl3GQrImhm9BU
         TucttWESnhSWPKtSREP5tRdcw3jTWUkDtXWOWBgRuhU893e/OzJwl0DexX4o8bGugyjq
         h59A==
X-Gm-Message-State: AO0yUKVpDrhrnsGEgflDdR/drKA8kwZVXjS31WY5umy57wZoRy/5rBwd
        QorkHodtiWzDxdWmixQX3pZSaHr1CqE=
X-Google-Smtp-Source: AK7set8RmnAZSJLc8LVQpD7B9XXyCOaW9GLBfDfjTxRfjniMzZ/b/X21lvTYz4exCbt8yXWrlyS62A==
X-Received: by 2002:a5d:62ca:0:b0:2ce:9f35:b645 with SMTP id o10-20020a5d62ca000000b002ce9f35b645mr1475102wrv.20.1679379979747;
        Mon, 20 Mar 2023 23:26:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020adffc07000000b002c5706f7c6dsm10476515wrr.94.2023.03.20.23.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:26:19 -0700 (PDT)
Message-Id: <6e80396e861177802a095fe4cb8289646699ed77.1679379970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
        <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Mar 2023 06:25:54 +0000
Subject: [PATCH v2 02/16] treewide: be explicit about dependence on gettext.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Dozens of files made use of gettext functions, without explicitly
including gettext.h.  This made it more difficult to find which files
could remove a dependence on cache.h.  Make C files explicitly include
gettext.h if they are using it.

However, while compat/fsmonitor/fsm-ipc-darwin.c should also gain an
include of gettext.h, it was left out to avoid conflicting with an
in-flight topic.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 add-interactive.c                        | 1 +
 add-patch.c                              | 1 +
 apply.c                                  | 1 +
 archive-tar.c                            | 1 +
 archive-zip.c                            | 1 +
 archive.c                                | 1 +
 attr.c                                   | 1 +
 bisect.c                                 | 1 +
 blame.c                                  | 1 +
 branch.c                                 | 1 +
 builtin/add.c                            | 1 +
 builtin/am.c                             | 1 +
 builtin/apply.c                          | 1 +
 builtin/archive.c                        | 1 +
 builtin/bisect.c                         | 1 +
 builtin/blame.c                          | 1 +
 builtin/branch.c                         | 1 +
 builtin/bugreport.c                      | 1 +
 builtin/bundle.c                         | 1 +
 builtin/cat-file.c                       | 1 +
 builtin/check-attr.c                     | 1 +
 builtin/check-ignore.c                   | 1 +
 builtin/check-mailmap.c                  | 1 +
 builtin/checkout--worker.c               | 1 +
 builtin/checkout-index.c                 | 1 +
 builtin/checkout.c                       | 1 +
 builtin/clean.c                          | 1 +
 builtin/clone.c                          | 1 +
 builtin/column.c                         | 1 +
 builtin/commit-graph.c                   | 1 +
 builtin/commit-tree.c                    | 1 +
 builtin/commit.c                         | 1 +
 builtin/config.c                         | 1 +
 builtin/count-objects.c                  | 1 +
 builtin/credential-cache--daemon.c       | 1 +
 builtin/credential-cache.c               | 1 +
 builtin/credential-store.c               | 1 +
 builtin/describe.c                       | 1 +
 builtin/diagnose.c                       | 1 +
 builtin/diff-tree.c                      | 1 +
 builtin/diff.c                           | 1 +
 builtin/difftool.c                       | 1 +
 builtin/fast-export.c                    | 1 +
 builtin/fast-import.c                    | 1 +
 builtin/fetch-pack.c                     | 1 +
 builtin/fetch.c                          | 1 +
 builtin/fmt-merge-msg.c                  | 1 +
 builtin/for-each-ref.c                   | 1 +
 builtin/for-each-repo.c                  | 1 +
 builtin/fsck.c                           | 1 +
 builtin/fsmonitor--daemon.c              | 1 +
 builtin/gc.c                             | 1 +
 builtin/grep.c                           | 1 +
 builtin/hash-object.c                    | 1 +
 builtin/help.c                           | 1 +
 builtin/hook.c                           | 1 +
 builtin/index-pack.c                     | 1 +
 builtin/init-db.c                        | 1 +
 builtin/interpret-trailers.c             | 1 +
 builtin/log.c                            | 1 +
 builtin/ls-files.c                       | 1 +
 builtin/ls-remote.c                      | 1 +
 builtin/ls-tree.c                        | 1 +
 builtin/mailinfo.c                       | 1 +
 builtin/mailsplit.c                      | 1 +
 builtin/merge-base.c                     | 1 +
 builtin/merge-file.c                     | 1 +
 builtin/merge-recursive.c                | 1 +
 builtin/merge-tree.c                     | 1 +
 builtin/merge.c                          | 1 +
 builtin/mktag.c                          | 1 +
 builtin/mktree.c                         | 1 +
 builtin/multi-pack-index.c               | 1 +
 builtin/mv.c                             | 1 +
 builtin/name-rev.c                       | 1 +
 builtin/notes.c                          | 1 +
 builtin/pack-objects.c                   | 1 +
 builtin/pack-redundant.c                 | 1 +
 builtin/pack-refs.c                      | 1 +
 builtin/patch-id.c                       | 1 +
 builtin/prune-packed.c                   | 1 +
 builtin/prune.c                          | 1 +
 builtin/pull.c                           | 1 +
 builtin/push.c                           | 1 +
 builtin/range-diff.c                     | 1 +
 builtin/read-tree.c                      | 1 +
 builtin/rebase.c                         | 1 +
 builtin/receive-pack.c                   | 1 +
 builtin/reflog.c                         | 1 +
 builtin/remote.c                         | 1 +
 builtin/repack.c                         | 1 +
 builtin/replace.c                        | 1 +
 builtin/rerere.c                         | 1 +
 builtin/reset.c                          | 1 +
 builtin/rev-list.c                       | 1 +
 builtin/rev-parse.c                      | 1 +
 builtin/revert.c                         | 1 +
 builtin/rm.c                             | 1 +
 builtin/shortlog.c                       | 1 +
 builtin/show-branch.c                    | 1 +
 builtin/show-index.c                     | 1 +
 builtin/show-ref.c                       | 1 +
 builtin/sparse-checkout.c                | 1 +
 builtin/stash.c                          | 1 +
 builtin/stripspace.c                     | 1 +
 builtin/submodule--helper.c              | 1 +
 builtin/symbolic-ref.c                   | 1 +
 builtin/tag.c                            | 1 +
 builtin/unpack-objects.c                 | 1 +
 builtin/update-index.c                   | 1 +
 builtin/update-ref.c                     | 1 +
 builtin/update-server-info.c             | 1 +
 builtin/upload-pack.c                    | 1 +
 builtin/verify-commit.c                  | 1 +
 builtin/verify-pack.c                    | 1 +
 builtin/verify-tag.c                     | 1 +
 builtin/worktree.c                       | 1 +
 builtin/write-tree.c                     | 1 +
 bulk-checkin.c                           | 1 +
 bundle-uri.c                             | 1 +
 bundle.c                                 | 1 +
 chunk-format.c                           | 1 +
 color.c                                  | 1 +
 commit-graph.c                           | 1 +
 commit.c                                 | 1 +
 common-main.c                            | 1 +
 compat/disk.h                            | 1 +
 compat/fsmonitor/fsm-health-win32.c      | 1 +
 compat/fsmonitor/fsm-listen-darwin.c     | 1 +
 compat/fsmonitor/fsm-listen-win32.c      | 1 +
 compat/fsmonitor/fsm-path-utils-darwin.c | 1 +
 compat/fsmonitor/fsm-path-utils-win32.c  | 1 +
 compat/mingw.c                           | 1 +
 compat/precompose_utf8.c                 | 1 +
 compat/simple-ipc/ipc-unix-socket.c      | 1 +
 compat/simple-ipc/ipc-win32.c            | 1 +
 compat/terminal.c                        | 1 +
 config.c                                 | 1 +
 connect.c                                | 1 +
 connected.c                              | 1 +
 convert.c                                | 1 +
 credential.c                             | 1 +
 date.c                                   | 1 +
 delta-islands.c                          | 1 +
 diagnose.c                               | 1 +
 diff-lib.c                               | 1 +
 diff-no-index.c                          | 1 +
 diff.c                                   | 1 +
 dir.c                                    | 1 +
 editor.c                                 | 1 +
 entry.c                                  | 1 +
 environment.c                            | 1 +
 exec-cmd.c                               | 1 +
 fetch-pack.c                             | 1 +
 fsmonitor-ipc.c                          | 1 +
 git.c                                    | 1 +
 gpg-interface.c                          | 1 +
 grep.c                                   | 1 +
 http-fetch.c                             | 1 +
 imap-send.c                              | 1 +
 list-objects-filter-options.h            | 1 +
 list-objects-filter.c                    | 1 +
 list-objects.c                           | 1 +
 lockfile.c                               | 1 +
 ls-refs.c                                | 1 +
 merge-ort-wrappers.c                     | 1 +
 merge-ort.c                              | 1 +
 merge-recursive.c                        | 1 +
 merge.c                                  | 1 +
 midx.c                                   | 1 +
 name-hash.c                              | 1 +
 notes-merge.c                            | 1 +
 notes-utils.c                            | 1 +
 object-file.c                            | 1 +
 object-name.c                            | 1 +
 object.c                                 | 1 +
 pack-bitmap-write.c                      | 1 +
 pack-bitmap.c                            | 1 +
 pack-mtimes.c                            | 1 +
 pack-revindex.c                          | 1 +
 pack-write.c                             | 1 +
 packfile.c                               | 1 +
 parallel-checkout.c                      | 1 +
 parse-options-cb.c                       | 1 +
 parse-options.c                          | 1 +
 parse-options.h                          | 2 ++
 path.c                                   | 1 +
 pathspec.c                               | 1 +
 pkt-line.c                               | 1 +
 preload-index.c                          | 1 +
 pretty.c                                 | 1 +
 promisor-remote.c                        | 1 +
 prune-packed.c                           | 1 +
 range-diff.c                             | 1 +
 reachable.c                              | 1 +
 read-cache.c                             | 1 +
 rebase-interactive.c                     | 1 +
 ref-filter.c                             | 1 +
 ref-filter.h                             | 1 +
 reflog.c                                 | 1 +
 refs.c                                   | 1 +
 refs/files-backend.c                     | 1 +
 refs/packed-backend.c                    | 1 +
 remote-curl.c                            | 1 +
 remote.c                                 | 1 +
 replace-object.c                         | 1 +
 rerere.c                                 | 1 +
 rerere.h                                 | 1 +
 reset.c                                  | 1 +
 revision.c                               | 1 +
 run-command.c                            | 1 +
 send-pack.c                              | 1 +
 sequencer.c                              | 1 +
 setup.c                                  | 1 +
 sideband.c                               | 1 +
 sparse-index.c                           | 1 +
 split-index.c                            | 1 +
 strbuf.c                                 | 1 +
 submodule-config.c                       | 1 +
 submodule.c                              | 1 +
 symlinks.c                               | 1 +
 t/helper/test-cache-tree.c               | 1 +
 t/helper/test-fast-rebase.c              | 1 +
 t/helper/test-reach.c                    | 1 +
 t/helper/test-serve-v2.c                 | 1 +
 trailer.c                                | 1 +
 transport-helper.c                       | 1 +
 tree-walk.c                              | 1 +
 unpack-trees.c                           | 1 +
 upload-pack.c                            | 1 +
 usage.c                                  | 2 +-
 walker.c                                 | 1 +
 worktree.c                               | 1 +
 wrapper.c                                | 1 +
 wt-status.c                              | 1 +
 235 files changed, 236 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index ae25ec50bce..b750543bd87 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -3,6 +3,7 @@
 #include "color.h"
 #include "config.h"
 #include "diffcore.h"
+#include "gettext.h"
 #include "hex.h"
 #include "revision.h"
 #include "refs.h"
diff --git a/add-patch.c b/add-patch.c
index e6c34b9c381..4c803a5f4db 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "add-interactive.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "strbuf.h"
 #include "run-command.h"
 #include "strvec.h"
diff --git a/apply.c b/apply.c
index 8776ab939ad..e0bdd43a68e 100644
--- a/apply.c
+++ b/apply.c
@@ -15,6 +15,7 @@
 #include "delta.h"
 #include "diff.h"
 #include "dir.h"
+#include "gettext.h"
 #include "hex.h"
 #include "xdiff-interface.h"
 #include "ll-merge.h"
diff --git a/archive-tar.c b/archive-tar.c
index ee27fa0b39b..16ee133bbf5 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "tar.h"
 #include "archive.h"
diff --git a/archive-zip.c b/archive-zip.c
index c5d1f72eb80..c02dc33e406 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "config.h"
 #include "archive.h"
+#include "gettext.h"
 #include "hex.h"
 #include "streaming.h"
 #include "utf8.h"
diff --git a/archive.c b/archive.c
index 1c2ca78e52a..2c3da1cff30 100644
--- a/archive.c
+++ b/archive.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "object-store.h"
diff --git a/attr.c b/attr.c
index 657ee52229e..48e2d646187 100644
--- a/attr.c
+++ b/attr.c
@@ -12,6 +12,7 @@
 #include "exec-cmd.h"
 #include "attr.h"
 #include "dir.h"
+#include "gettext.h"
 #include "utf8.h"
 #include "quote.h"
 #include "revision.h"
diff --git a/bisect.c b/bisect.c
index 1409150c5c3..5a3a8182d83 100644
--- a/bisect.c
+++ b/bisect.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "commit.h"
 #include "diff.h"
+#include "gettext.h"
 #include "hex.h"
 #include "revision.h"
 #include "refs.h"
diff --git a/blame.c b/blame.c
index e45d8a3bf92..b7cd849bb6b 100644
--- a/blame.c
+++ b/blame.c
@@ -5,6 +5,7 @@
 #include "mergesort.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "gettext.h"
 #include "hex.h"
 #include "tag.h"
 #include "blame.h"
diff --git a/branch.c b/branch.c
index eacef62b7c9..66d32c68564 100644
--- a/branch.c
+++ b/branch.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "config.h"
 #include "branch.h"
+#include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "refspec.h"
diff --git a/builtin/add.c b/builtin/add.c
index 61dd386d109..f12054d9be1 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -9,6 +9,7 @@
 #include "builtin.h"
 #include "lockfile.h"
 #include "dir.h"
+#include "gettext.h"
 #include "pathspec.h"
 #include "exec-cmd.h"
 #include "cache-tree.h"
diff --git a/builtin/am.c b/builtin/am.c
index 5e6b237c424..cc1fdf4f75d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -8,6 +8,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "exec-cmd.h"
+#include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "dir.h"
diff --git a/builtin/apply.c b/builtin/apply.c
index 555219de40f..fe72c0ec3eb 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "apply.h"
 
diff --git a/builtin/archive.c b/builtin/archive.c
index d0a583ea958..d13934f1a80 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -5,6 +5,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "archive.h"
+#include "gettext.h"
 #include "transport.h"
 #include "parse-options.h"
 #include "pkt-line.h"
diff --git a/builtin/bisect.c b/builtin/bisect.c
index c64c8d715a5..09188e554b3 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "bisect.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index fdd9f0c0fc7..21f6b523a6d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "color.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "commit.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb9..a67a8334d5c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -11,6 +11,7 @@
 #include "refs.h"
 #include "commit.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "remote.h"
 #include "parse-options.h"
 #include "branch.h"
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 5bc254be80f..b61cfa9464f 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "strbuf.h"
 #include "help.h"
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 666f01bccd0..de3898ffa41 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "gettext.h"
 #include "strvec.h"
 #include "parse-options.h"
 #include "cache.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9e7e03ade41..9f1bf8f0e96 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "diff.h"
+#include "gettext.h"
 #include "hex.h"
 #include "ident.h"
 #include "parse-options.h"
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index d7a40e674ca..ad27255e2cb 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "config.h"
 #include "attr.h"
+#include "gettext.h"
 #include "quote.h"
 #include "parse-options.h"
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index ab776061c7c..a45d001e353 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
+#include "gettext.h"
 #include "quote.h"
 #include "pathspec.h"
 #include "parse-options.h"
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 96db3ddb4bb..fa86fd9423d 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "gettext.h"
 #include "ident.h"
 #include "mailmap.h"
 #include "parse-options.h"
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index 0a7d762573c..2120dd1d300 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "entry.h"
+#include "gettext.h"
 #include "parallel-checkout.h"
 #include "parse-options.h"
 #include "pkt-line.h"
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index cf6fba97ba7..828c0363f8a 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -8,6 +8,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
+#include "gettext.h"
 #include "lockfile.h"
 #include "quote.h"
 #include "cache-tree.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 734d730980c..47d4c369a16 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "diff.h"
 #include "dir.h"
+#include "gettext.h"
 #include "hex.h"
 #include "hook.h"
 #include "ll-merge.h"
diff --git a/builtin/clean.c b/builtin/clean.c
index 10aaa8c603f..46c51029ab4 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -11,6 +11,7 @@
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "string-list.h"
 #include "quote.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 462c286274c..d605fcafa0f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -11,6 +11,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "parse-options.h"
diff --git a/builtin/column.c b/builtin/column.c
index 158fdf53d9f..de623a16c2d 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "strbuf.h"
 #include "parse-options.h"
 #include "string-list.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index d3be7f3b318..311e0106810 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "parse-options.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index e805da5bb1c..0ef55d83d49 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
 #include "repository.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index f71ed41bf59..25575435ad7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -16,6 +16,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "commit.h"
+#include "gettext.h"
 #include "revision.h"
 #include "wt-status.h"
 #include "run-command.h"
diff --git a/builtin/config.c b/builtin/config.c
index 49d832d4093..33b17b40b41 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "color.h"
+#include "gettext.h"
 #include "ident.h"
 #include "parse-options.h"
 #include "urlmatch.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index bb21bc43e42..48edc86c240 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
+#include "gettext.h"
 #include "repository.h"
 #include "builtin.h"
 #include "parse-options.h"
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 6e509d02c37..0f00ba4d741 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "parse-options.h"
 
 #ifndef NO_UNIX_SOCKETS
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 78c02ad5319..25f2f71c216 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "gettext.h"
 #include "parse-options.h"
 
 #ifndef NO_UNIX_SOCKETS
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 62a4f3c2653..da32cfd89e2 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "gettext.h"
 #include "lockfile.h"
 #include "credential.h"
 #include "string-list.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index 5b5930f5c8c..fcacdf8a693 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "commit.h"
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index d52015c67a4..5b12d1fb963 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "diagnose.h"
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index a393efa4f08..385c2d0230c 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "diff.h"
 #include "commit.h"
+#include "gettext.h"
 #include "hex.h"
 #include "log-tree.h"
 #include "builtin.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index 26f1e532c66..20bdb6e6cec 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -11,6 +11,7 @@
 #include "color.h"
 #include "commit.h"
 #include "blob.h"
+#include "gettext.h"
 #include "tag.h"
 #include "diff.h"
 #include "diff-merges.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 01681d0fb88..f7380dd1cc7 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -17,6 +17,7 @@
 #include "builtin.h"
 #include "run-command.h"
 #include "exec-cmd.h"
+#include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "strvec.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 78493c6d2bf..9ab2e34ef05 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -6,6 +6,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "refspec.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index f7548ff4a35..f3635c7aefd 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "config.h"
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 702c9a3397e..60e5a10ffc5 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "hex.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7221e57f352..990f81f6d1a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "refs.h"
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 8d8fd393f89..0f9855b680e 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "fmt-merge-msg.h"
+#include "gettext.h"
 #include "parse-options.h"
 
 static const char * const fmt_merge_msg_usage[] = {
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 6f62f40d126..7a8ff5902cf 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "refs.h"
 #include "object.h"
 #include "parse-options.h"
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 6aeac371488..27425c2fc9e 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "run-command.h"
 #include "string-list.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index c4a633c0329..1375e32d2a1 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "config.h"
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index cae804a1908..215e3813d7d 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index c58fe8c936c..32cabad7cf6 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "exec-cmd.h"
+#include "gettext.h"
 #include "hook.h"
 
 #define FAILED_RUN "failed to run %s"
diff --git a/builtin/grep.c b/builtin/grep.c
index c590fcb19dd..3c9c6b38031 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "config.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 1848768b97c..f233eda7590 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -6,6 +6,7 @@
  */
 #include "builtin.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
 #include "blob.h"
diff --git a/builtin/help.c b/builtin/help.c
index 53f2812dfb1..3fde5c4fd35 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -5,6 +5,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "exec-cmd.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "run-command.h"
 #include "config-list.h"
diff --git a/builtin/hook.c b/builtin/hook.c
index f95b7965c58..88051795c7f 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "config.h"
+#include "gettext.h"
 #include "hook.h"
 #include "parse-options.h"
 #include "strbuf.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b451755f405..bae5b054039 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "delta.h"
+#include "gettext.h"
 #include "hex.h"
 #include "pack.h"
 #include "csum-file.h"
diff --git a/builtin/init-db.c b/builtin/init-db.c
index dcaaf102eaf..e182bc7e839 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "refs.h"
 #include "builtin.h"
 #include "exec-cmd.h"
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index e58627c72a9..107ac28f0e8 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -7,6 +7,7 @@
 
 #include "cache.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "string-list.h"
 #include "trailer.h"
diff --git a/builtin/log.c b/builtin/log.c
index bc204ea76ff..e702cf126e5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -7,6 +7,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "object-store.h"
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a03b559ecaa..09deb752ab3 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -11,6 +11,7 @@
 #include "quote.h"
 #include "dir.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "strbuf.h"
 #include "tree.h"
 #include "cache-tree.h"
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 2dfbd8ed9b9..11d9424804a 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "transport.h"
 #include "ref-filter.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 64d8e54318c..b4835f1d4cc 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
 #include "blob.h"
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 01d16ef9e5a..e8bb011cfb4 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -4,6 +4,7 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "utf8.h"
 #include "strbuf.h"
 #include "mailinfo.h"
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 73509f651bd..b08069ce60a 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -6,6 +6,7 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "string-list.h"
 #include "strbuf.h"
 
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index be8f3b221c9..e0995f3219f 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "config.h"
 #include "commit.h"
+#include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "diff.h"
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index c923bbf2abb..ae45f523b95 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 #include "parse-options.h"
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index b9acbf5d342..a49fab9bcb1 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "commit.h"
+#include "gettext.h"
 #include "tag.h"
 #include "merge-recursive.h"
 #include "xdiff-interface.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index e7825181648..89b807388a4 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -3,6 +3,7 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "help.h"
+#include "gettext.h"
 #include "hex.h"
 #include "commit.h"
 #include "commit-reach.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 19c31d4ff48..a90ae5d2ddc 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "builtin.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 42c2457c705..e93aee72258 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "tag.h"
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 848c7b47476..09a7bd5c5c2 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -5,6 +5,7 @@
  */
 #include "builtin.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "hex.h"
 #include "quote.h"
 #include "tree.h"
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 9a18a82b057..e6757a44470 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "midx.h"
 #include "trace2.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index 81290503775..c02dddb72b5 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -7,6 +7,7 @@
 #include "builtin.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "pathspec.h"
 #include "lockfile.h"
 #include "dir.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 723ba616a88..6977a5f580b 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "config.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index 75ce7f3f574..8e9be33ddbb 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "hex.h"
 #include "notes.h"
 #include "object-store.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 545b8bddc8e..1ca800c7c50 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "config.h"
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 82115c5808c..3451971b564 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -7,6 +7,7 @@
 */
 
 #include "builtin.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "packfile.h"
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 27c2ca06acb..9833815fb30 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "repository.h"
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 338b15cd7b0..9d5585d3a72 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
+#include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index da3273a268b..ca3578e1588 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "prune-packed.h"
 
diff --git a/builtin/prune.c b/builtin/prune.c
index 119a253a2ad..ff62a0adb8f 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "diff.h"
+#include "gettext.h"
 #include "hex.h"
 #include "revision.h"
 #include "builtin.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index 56f679d94a0..1a1a89af055 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -9,6 +9,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "exec-cmd.h"
diff --git a/builtin/push.c b/builtin/push.c
index 12a402aea3d..2d76fa68376 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "branch.h"
 #include "config.h"
+#include "gettext.h"
 #include "refs.h"
 #include "refspec.h"
 #include "run-command.h"
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index aecfae12d3a..97724fd0ed7 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "range-diff.h"
 #include "config.h"
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 11759c415f3..ec66008d07e 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -7,6 +7,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "object.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index dd31d5ab91e..a2c68b8ff7b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -6,6 +6,7 @@
 
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
+#include "gettext.h"
 #include "hex.h"
 #include "run-command.h"
 #include "exec-cmd.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 6a24ab4f451..006565f8513 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "repository.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "pack.h"
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 270681dcdf4..0879d4d2246 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "gettext.h"
 #include "revision.h"
 #include "reachable.h"
 #include "worktree.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index 729f6f3643a..2074d6be28c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "transport.h"
 #include "remote.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index 87f73c8923a..771ca01527d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "dir.h"
+#include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "run-command.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index 71d8e949e35..cf85e590d9f 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -11,6 +11,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "parse-options.h"
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 94ffb8c21ab..24c78755723 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "string-list.h"
 #include "rerere.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 24b04aeecb9..4335c1a6e1b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -10,6 +10,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "tag.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 85e522dff8a..f2f6a0d3e67 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "commit.h"
 #include "diff.h"
+#include "gettext.h"
 #include "hex.h"
 #include "revision.h"
 #include "list-objects.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index e1fa9c6348c..5a932a861b4 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -8,6 +8,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "commit.h"
+#include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "quote.h"
diff --git a/builtin/revert.c b/builtin/revert.c
index 62986a7b1b0..dd6587a99d8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -4,6 +4,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "diff.h"
+#include "gettext.h"
 #include "revision.h"
 #include "rerere.h"
 #include "dir.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index dc198f79082..5982c3d8122 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -11,6 +11,7 @@
 #include "lockfile.h"
 #include "dir.h"
 #include "cache-tree.h"
+#include "gettext.h"
 #include "tree-walk.h"
 #include "parse-options.h"
 #include "string-list.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 27a87167e19..d8c4379ea16 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "commit.h"
 #include "diff.h"
+#include "gettext.h"
 #include "string-list.h"
 #include "revision.h"
 #include "utf8.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 8342b68aef7..8d569629726 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "pretty.h"
 #include "refs.h"
diff --git a/builtin/show-index.c b/builtin/show-index.c
index 98ec40ddf46..d4bbbbcd6ce 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "pack.h"
 #include "parse-options.h"
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 1f28d7fe4b9..a5df7587d51 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "object-store.h"
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8d5ae6f2a60..3976d8e86b8 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "pathspec.h"
 #include "repository.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index 6a12fed2713..65817d0b763 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "refs.h"
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 1e34cf2bebd..d8e61459333 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "strbuf.h"
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d05d1a84623..a4bdd44daa3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "cache.h"
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index e00768a8b7e..10198a74fae 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "cache.h"
+#include "gettext.h"
 #include "refs.h"
 #include "parse-options.h"
 
diff --git a/builtin/tag.c b/builtin/tag.c
index adcaa547b0d..c2ea89c4754 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -9,6 +9,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "object-store.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 1908dcfcffb..f7c4b531076 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "bulk-checkin.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
 #include "object.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 11dc1352716..ef78b2d28e1 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "bulk-checkin.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "quote.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index a84e7b47a20..fdf51495b51 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "refs.h"
 #include "builtin.h"
 #include "parse-options.h"
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index d2239c9ef4d..e7bff27ae40 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "parse-options.h"
 
 static const char * const update_server_info_usage[] = {
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 7a3c68720f1..beb9dd08610 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec-cmd.h"
+#include "gettext.h"
 #include "pkt-line.h"
 #include "parse-options.h"
 #include "protocol.h"
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 7aedf10e856..22e5afc069e 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "object-store.h"
 #include "repository.h"
 #include "commit.h"
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 27d6f75fd8a..190fd695409 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "run-command.h"
 #include "parse-options.h"
 
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 5c00b0b0f77..850e1a11c7b 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "gettext.h"
 #include "tag.h"
 #include "run-command.h"
 #include "parse-options.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 80d05e246d8..ed89b7e9725 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "dir.h"
+#include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "strvec.h"
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 7ad0d059453..7eec4e3cbd1 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -7,6 +7,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "tree.h"
 #include "cache-tree.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
index d64cd5c52d0..778ca1e0f4f 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "bulk-checkin.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "repository.h"
diff --git a/bundle-uri.c b/bundle-uri.c
index 177c1810402..2cc7d159bd6 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "bundle-uri.h"
 #include "bundle.h"
+#include "gettext.h"
 #include "object-store.h"
 #include "refs.h"
 #include "run-command.h"
diff --git a/bundle.c b/bundle.c
index 99d7de97f6c..f5b3643b17e 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "lockfile.h"
 #include "bundle.h"
+#include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
 #include "repository.h"
diff --git a/chunk-format.c b/chunk-format.c
index f65e9a1e429..6d1071729df 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "chunk-format.h"
 #include "csum-file.h"
+#include "gettext.h"
 
 /*
  * When writing a chunk-based file format, collect the chunks in
diff --git a/color.c b/color.c
index 6b577ce0a75..672dcbb73a6 100644
--- a/color.c
+++ b/color.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "color.h"
+#include "gettext.h"
 #include "hex.h"
 
 static int git_use_color_default = GIT_COLOR_AUTO;
diff --git a/commit-graph.c b/commit-graph.c
index 5e6098ff356..8f21a0a0c20 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "pack.h"
diff --git a/commit.c b/commit.c
index 7b63d3b0e1c..3fdfb325117 100644
--- a/commit.c
+++ b/commit.c
@@ -2,6 +2,7 @@
 #include "tag.h"
 #include "commit.h"
 #include "commit-graph.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "object-store.h"
diff --git a/common-main.c b/common-main.c
index 0a22861f1ce..184d1534d2d 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "exec-cmd.h"
+#include "gettext.h"
 #include "attr.h"
 
 /*
diff --git a/compat/disk.h b/compat/disk.h
index 50a32e3d8a4..a04a8d294af 100644
--- a/compat/disk.h
+++ b/compat/disk.h
@@ -2,6 +2,7 @@
 #define COMPAT_DISK_H
 
 #include "git-compat-util.h"
+#include "gettext.h"
 
 static int get_disk_info(struct strbuf *out)
 {
diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index 2ea08c1d4e8..fe11bdd9ce6 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -3,6 +3,7 @@
 #include "fsmonitor.h"
 #include "fsm-health.h"
 #include "fsmonitor--daemon.h"
+#include "gettext.h"
 
 /*
  * Every minute wake up and test our health.
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 97a55a6f0a4..5eb6402ab82 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -28,6 +28,7 @@
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
 #include "fsmonitor-path-utils.h"
+#include "gettext.h"
 
 struct fsm_listen_data
 {
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 03df8d951b8..7b07b74ba5b 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -3,6 +3,7 @@
 #include "fsmonitor.h"
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
+#include "gettext.h"
 
 /*
  * The documentation of ReadDirectoryChangesW() states that the maximum
diff --git a/compat/fsmonitor/fsm-path-utils-darwin.c b/compat/fsmonitor/fsm-path-utils-darwin.c
index ce5a8febe09..45eb4a9b9e7 100644
--- a/compat/fsmonitor/fsm-path-utils-darwin.c
+++ b/compat/fsmonitor/fsm-path-utils-darwin.c
@@ -1,5 +1,6 @@
 #include "fsmonitor.h"
 #include "fsmonitor-path-utils.h"
+#include "gettext.h"
 #include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/compat/fsmonitor/fsm-path-utils-win32.c b/compat/fsmonitor/fsm-path-utils-win32.c
index 0d95bbb416f..4024baafb97 100644
--- a/compat/fsmonitor/fsm-path-utils-win32.c
+++ b/compat/fsmonitor/fsm-path-utils-win32.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "fsmonitor.h"
 #include "fsmonitor-path-utils.h"
+#include "gettext.h"
 
 /*
  * Check remote working directory protocol.
diff --git a/compat/mingw.c b/compat/mingw.c
index 3afbde78944..a9e5570288c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -11,6 +11,7 @@
 #include "win32/lazyload.h"
 #include "../config.h"
 #include "dir.h"
+#include "gettext.h"
 #define SECURITY_WIN32
 #include <sspi.h>
 
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index cce1d57a464..56d36cdf22a 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -7,6 +7,7 @@
 
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "utf8.h"
 #include "precompose_utf8.h"
 
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 28a79289d4f..152db60a311 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "simple-ipc.h"
 #include "strbuf.h"
 #include "pkt-line.h"
diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 20ea7b65e0b..f011e5cead8 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "simple-ipc.h"
 #include "strbuf.h"
 #include "pkt-line.h"
diff --git a/compat/terminal.c b/compat/terminal.c
index ea490a7ced4..afebe6b2496 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "compat/terminal.h"
+#include "gettext.h"
 #include "sigchain.h"
 #include "strbuf.h"
 #include "run-command.h"
diff --git a/config.c b/config.c
index 983c45fc37b..f30a6d8e686 100644
--- a/config.c
+++ b/config.c
@@ -11,6 +11,7 @@
 #include "branch.h"
 #include "config.h"
 #include "environment.h"
+#include "gettext.h"
 #include "ident.h"
 #include "repository.h"
 #include "lockfile.h"
diff --git a/connect.c b/connect.c
index 000865bc33e..f3b159bf441 100644
--- a/connect.c
+++ b/connect.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "pkt-line.h"
 #include "quote.h"
diff --git a/connected.c b/connected.c
index 39cb1e1074d..a4c0aece757 100644
--- a/connected.c
+++ b/connected.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
 #include "run-command.h"
diff --git a/convert.c b/convert.c
index 349c7e4af15..2bd54244b55 100644
--- a/convert.c
+++ b/convert.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
 #include "attr.h"
diff --git a/credential.c b/credential.c
index ea40a2a410b..5244f3c12c0 100644
--- a/credential.c
+++ b/credential.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "credential.h"
+#include "gettext.h"
 #include "string-list.h"
 #include "run-command.h"
 #include "url.h"
diff --git a/date.c b/date.c
index 6f45eeb3568..1fb2cd1b538 100644
--- a/date.c
+++ b/date.c
@@ -6,6 +6,7 @@
 
 #include "cache.h"
 #include "date.h"
+#include "gettext.h"
 
 /*
  * This is like mktime, but without normalization of tm_wday and tm_yday.
diff --git a/delta-islands.c b/delta-islands.c
index fe12c93005b..1222b6a6cd1 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -4,6 +4,7 @@
 #include "object.h"
 #include "blob.h"
 #include "commit.h"
+#include "gettext.h"
 #include "hex.h"
 #include "tag.h"
 #include "tree.h"
diff --git a/diagnose.c b/diagnose.c
index 5b398f0cffc..169a55407fd 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -4,6 +4,7 @@
 #include "archive.h"
 #include "dir.h"
 #include "help.h"
+#include "gettext.h"
 #include "hex.h"
 #include "strvec.h"
 #include "object-store.h"
diff --git a/diff-lib.c b/diff-lib.c
index 70b3578b907..a7e04009873 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -6,6 +6,7 @@
 #include "commit.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "gettext.h"
 #include "hex.h"
 #include "revision.h"
 #include "cache-tree.h"
diff --git a/diff-no-index.c b/diff-no-index.c
index a3cf358baf0..287a113badd 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -11,6 +11,7 @@
 #include "tag.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "gettext.h"
 #include "revision.h"
 #include "log-tree.h"
 #include "parse-options.h"
diff --git a/diff.c b/diff.c
index 00d47281a1d..00746f2f86e 100644
--- a/diff.c
+++ b/diff.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "tempfile.h"
 #include "quote.h"
 #include "diff.h"
diff --git a/dir.c b/dir.c
index d5bb199f4b4..46f1bb6e5b7 100644
--- a/dir.c
+++ b/dir.c
@@ -9,6 +9,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "dir.h"
+#include "gettext.h"
 #include "object-store.h"
 #include "attr.h"
 #include "refs.h"
diff --git a/editor.c b/editor.c
index 008c04fe2f6..58e790548d2 100644
--- a/editor.c
+++ b/editor.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "strbuf.h"
 #include "strvec.h"
 #include "run-command.h"
diff --git a/entry.c b/entry.c
index c97cfa833bb..acb76a61aca 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,7 @@
 #include "blob.h"
 #include "object-store.h"
 #include "dir.h"
+#include "gettext.h"
 #include "hex.h"
 #include "streaming.h"
 #include "submodule.h"
diff --git a/environment.c b/environment.c
index 89d89110e41..82a1fc17d0b 100644
--- a/environment.c
+++ b/environment.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "branch.h"
 #include "environment.h"
+#include "gettext.h"
 #include "repository.h"
 #include "config.h"
 #include "refs.h"
diff --git a/exec-cmd.c b/exec-cmd.c
index 0232bbc9905..282d95af081 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "exec-cmd.h"
+#include "gettext.h"
 #include "quote.h"
 #include "strvec.h"
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 4ddabb4ec76..359dce6afed 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "repository.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "refs.h"
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 19d772f0f3a..866828e2992 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "fsmonitor.h"
+#include "gettext.h"
 #include "simple-ipc.h"
 #include "fsmonitor-ipc.h"
 #include "run-command.h"
diff --git a/git.c b/git.c
index ae2134f29a8..22ce4f14b65 100644
--- a/git.c
+++ b/git.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "exec-cmd.h"
+#include "gettext.h"
 #include "help.h"
 #include "run-command.h"
 #include "alias.h"
diff --git a/gpg-interface.c b/gpg-interface.c
index 855970bb939..632265691e5 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "config.h"
+#include "gettext.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "dir.h"
diff --git a/grep.c b/grep.c
index 68e9328dfd4..febb076a7e6 100644
--- a/grep.c
+++ b/grep.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "grep.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/http-fetch.c b/http-fetch.c
index 8db35b9767d..454933351b2 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "exec-cmd.h"
+#include "gettext.h"
 #include "hex.h"
 #include "http.h"
 #include "walker.h"
diff --git a/imap-send.c b/imap-send.c
index 93e9018439c..c65a27219c6 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -25,6 +25,7 @@
 #include "config.h"
 #include "credential.h"
 #include "exec-cmd.h"
+#include "gettext.h"
 #include "run-command.h"
 #include "parse-options.h"
 #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index ef03b45132e..65c6119e9d3 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -1,6 +1,7 @@
 #ifndef LIST_OBJECTS_FILTER_OPTIONS_H
 #define LIST_OBJECTS_FILTER_OPTIONS_H
 
+#include "gettext.h"
 #include "object.h"
 #include "parse-options.h"
 #include "string-list.h"
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 5d7b3316608..298ca08711e 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "dir.h"
+#include "gettext.h"
 #include "hex.h"
 #include "tag.h"
 #include "commit.h"
diff --git a/list-objects.c b/list-objects.c
index ab5745bbfe4..3906ac442dd 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tag.h"
 #include "commit.h"
+#include "gettext.h"
 #include "hex.h"
 #include "tree.h"
 #include "blob.h"
diff --git a/lockfile.c b/lockfile.c
index cc9a4b84283..ab6490a391d 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -3,6 +3,7 @@
  */
 
 #include "cache.h"
+#include "gettext.h"
 #include "lockfile.h"
 
 /*
diff --git a/ls-refs.c b/ls-refs.c
index 8091b0cca8c..ae38889bf04 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "refs.h"
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index 748924a69ba..c00dfbab1cd 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
 
diff --git a/merge-ort.c b/merge-ort.c
index 4c5be8ed910..a26cad5f910 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -26,6 +26,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "dir.h"
+#include "gettext.h"
 #include "hex.h"
 #include "entry.h"
 #include "ll-merge.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index 89731f40908..0b0255ebc80 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -17,6 +17,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "dir.h"
+#include "gettext.h"
 #include "hex.h"
 #include "ll-merge.h"
 #include "lockfile.h"
diff --git a/merge.c b/merge.c
index 2c8b8456842..da7fa652c27 100644
--- a/merge.c
+++ b/merge.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "commit.h"
diff --git a/midx.c b/midx.c
index 47989f7ea70..e132ef250e4 100644
--- a/midx.c
+++ b/midx.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "csum-file.h"
 #include "dir.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "packfile.h"
diff --git a/name-hash.c b/name-hash.c
index cd009c7c8ae..bb9eae55aca 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2008 Linus Torvalds
  */
 #include "cache.h"
+#include "gettext.h"
 #include "thread-utils.h"
 #include "trace2.h"
 #include "sparse-index.h"
diff --git a/notes-merge.c b/notes-merge.c
index 5b1a9ff13f7..c8d0020b1a2 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "gettext.h"
 #include "refs.h"
 #include "object-store.h"
 #include "repository.h"
diff --git a/notes-utils.c b/notes-utils.c
index d7d18e30f5a..da08e2e8e5c 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "commit.h"
+#include "gettext.h"
 #include "refs.h"
 #include "notes-utils.h"
 #include "repository.h"
diff --git a/object-file.c b/object-file.c
index 8fab8dbe80b..39660d49dbc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -9,6 +9,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "string-list.h"
 #include "lockfile.h"
diff --git a/object-name.c b/object-name.c
index 69db1ec498a..2c927bbded3 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "tag.h"
 #include "commit.h"
diff --git a/object.c b/object.c
index 609fed1b73d..45c9721b8c8 100644
--- a/object.c
+++ b/object.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "object.h"
 #include "replace-object.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 891d9d2772e..7dc7f0ba55e 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
 #include "commit.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index ca7c81b5c9f..241ac9166c1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "commit.h"
+#include "gettext.h"
 #include "hex.h"
 #include "strbuf.h"
 #include "tag.h"
diff --git a/pack-mtimes.c b/pack-mtimes.c
index cd92fc1d86c..afed6321906 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "pack-mtimes.h"
 #include "object-store.h"
 #include "packfile.h"
diff --git a/pack-revindex.c b/pack-revindex.c
index 08dc1601679..03c7e81f9da 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "pack-revindex.h"
 #include "object-store.h"
 #include "packfile.h"
diff --git a/pack-write.c b/pack-write.c
index 041e573bc16..87156f89d2b 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "pack.h"
 #include "csum-file.h"
diff --git a/packfile.c b/packfile.c
index 2023df1b75b..3290fde15a1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "hex.h"
 #include "list.h"
 #include "pack.h"
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 2455aa356db..38c4dc665d5 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "entry.h"
+#include "gettext.h"
 #include "hex.h"
 #include "parallel-checkout.h"
 #include "pkt-line.h"
diff --git a/parse-options-cb.c b/parse-options-cb.c
index d346dbe2100..fbf4b010195 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "color.h"
+#include "gettext.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "oid-array.h"
diff --git a/parse-options.c b/parse-options.c
index 6dd4c090e03..084b4f10621 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "commit.h"
 #include "color.h"
+#include "gettext.h"
 #include "utf8.h"
 
 static int disallow_abbreviated_options;
diff --git a/parse-options.h b/parse-options.h
index 50d852f2991..d57868eff93 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -1,6 +1,8 @@
 #ifndef PARSE_OPTIONS_H
 #define PARSE_OPTIONS_H
 
+#include "gettext.h"
+
 /**
  * Refer to Documentation/technical/api-parse-options.txt for the API doc.
  */
diff --git a/path.c b/path.c
index 632a051809a..3f2702cbe49 100644
--- a/path.c
+++ b/path.c
@@ -2,6 +2,7 @@
  * Utilities for paths and pathnames
  */
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "strbuf.h"
diff --git a/pathspec.c b/pathspec.c
index ab70fcbe613..868b4d280ca 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
+#include "gettext.h"
 #include "pathspec.h"
 #include "attr.h"
 #include "strvec.h"
diff --git a/pkt-line.c b/pkt-line.c
index 1ea7f8600ec..c8b90b2242e 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "pkt-line.h"
+#include "gettext.h"
 #include "hex.h"
 #include "run-command.h"
 
diff --git a/preload-index.c b/preload-index.c
index 100f7a374dc..4b45e1d6912 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -5,6 +5,7 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "fsmonitor.h"
+#include "gettext.h"
 #include "config.h"
 #include "progress.h"
 #include "thread-utils.h"
diff --git a/pretty.c b/pretty.c
index 05b557d0961..9d7922dcc60 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "commit.h"
+#include "gettext.h"
 #include "hex.h"
 #include "utf8.h"
 #include "diff.h"
diff --git a/promisor-remote.c b/promisor-remote.c
index 1db566982ec..a8dbb788e8f 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
 #include "promisor-remote.h"
diff --git a/prune-packed.c b/prune-packed.c
index e02f466c2ee..cff5ad569c7 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "object-store.h"
 #include "packfile.h"
 #include "progress.h"
diff --git a/range-diff.c b/range-diff.c
index 4bd65ab7496..1bfc612e274 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "range-diff.h"
 #include "string-list.h"
 #include "run-command.h"
diff --git a/reachable.c b/reachable.c
index c9dab2a66b9..b0f85046e9c 100644
--- a/reachable.c
+++ b/reachable.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "tag.h"
diff --git a/read-cache.c b/read-cache.c
index 1bcf6732718..63789ea5e21 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,6 +18,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "blob.h"
+#include "gettext.h"
 #include "resolve-undo.h"
 #include "run-command.h"
 #include "strbuf.h"
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 7407c593191..649c94e69a6 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "gettext.h"
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "strbuf.h"
diff --git a/ref-filter.c b/ref-filter.c
index 38141bce8db..9a830bedef0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "refs.h"
diff --git a/ref-filter.h b/ref-filter.h
index aa0eea4ecf5..cc811c2cadd 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -1,6 +1,7 @@
 #ifndef REF_FILTER_H
 #define REF_FILTER_H
 
+#include "gettext.h"
 #include "oid-array.h"
 #include "refs.h"
 #include "commit.h"
diff --git a/reflog.c b/reflog.c
index 04630f56ec6..d1c39374318 100644
--- a/reflog.c
+++ b/reflog.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "object-store.h"
 #include "reflog.h"
 #include "refs.h"
diff --git a/refs.c b/refs.c
index 4e5cc73fb10..8684f4610f5 100644
--- a/refs.c
+++ b/refs.c
@@ -6,6 +6,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "hashmap.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "iterator.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 31bc5c45ee6..de3628ff3f1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,5 +1,6 @@
 #include "../cache.h"
 #include "../config.h"
+#include "../gettext.h"
 #include "../hex.h"
 #include "../refs.h"
 #include "refs-internal.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 6f975185995..3334c07003c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,6 +1,7 @@
 #include "../cache.h"
 #include "../alloc.h"
 #include "../config.h"
+#include "../gettext.h"
 #include "../hex.h"
 #include "../refs.h"
 #include "refs-internal.h"
diff --git a/remote-curl.c b/remote-curl.c
index ed7e3a043ac..943cd6fe6cd 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "remote.h"
 #include "connect.h"
diff --git a/remote.c b/remote.c
index 2daddb85cb7..edb1e07497c 100644
--- a/remote.c
+++ b/remote.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "remote.h"
 #include "urlmatch.h"
diff --git a/replace-object.c b/replace-object.c
index 0cf056c4fbf..9e30e0362ba 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "oidmap.h"
 #include "object-store.h"
diff --git a/rerere.c b/rerere.c
index a67abaab077..9428cbca7b2 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "string-list.h"
diff --git a/rerere.h b/rerere.h
index c32d79c3bd8..7899dc21747 100644
--- a/rerere.h
+++ b/rerere.h
@@ -1,6 +1,7 @@
 #ifndef RERERE_H
 #define RERERE_H
 
+#include "gettext.h"
 #include "string-list.h"
 
 struct pathspec;
diff --git a/reset.c b/reset.c
index 58b3829ff73..604d9325b78 100644
--- a/reset.c
+++ b/reset.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "cache-tree.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "refs.h"
diff --git a/revision.c b/revision.c
index e4c066e90b7..7423e23327b 100644
--- a/revision.c
+++ b/revision.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
 #include "tag.h"
diff --git a/run-command.c b/run-command.c
index ba617655b23..2c8b4cd9bfc 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "exec-cmd.h"
+#include "gettext.h"
 #include "sigchain.h"
 #include "strvec.h"
 #include "thread-utils.h"
diff --git a/send-pack.c b/send-pack.c
index 423a5cfe22d..f531cb48212 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
+#include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "object-store.h"
diff --git a/sequencer.c b/sequencer.c
index 3be23d7ca20..0df51726306 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "dir.h"
diff --git a/setup.c b/setup.c
index cefd5f63c46..8a4ccee4c2c 100644
--- a/setup.c
+++ b/setup.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
diff --git a/sideband.c b/sideband.c
index 85bddfdcd4f..4905cf9b32a 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "color.h"
 #include "config.h"
+#include "gettext.h"
 #include "sideband.h"
 #include "help.h"
 #include "pkt-line.h"
diff --git a/sparse-index.c b/sparse-index.c
index 63216b3e57f..fdae9011b8e 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "repository.h"
 #include "sparse-index.h"
 #include "tree.h"
diff --git a/split-index.c b/split-index.c
index 95ecfa53195..c98807c655b 100644
--- a/split-index.c
+++ b/split-index.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "split-index.h"
 #include "ewah/ewok.h"
 
diff --git a/strbuf.c b/strbuf.c
index 8800830ebf8..15209777d5a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "string-list.h"
diff --git a/submodule-config.c b/submodule-config.c
index 89a7bf0a93d..38663801aa4 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "dir.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "config.h"
diff --git a/submodule.c b/submodule.c
index 0baf97cf770..8b551e53274 100644
--- a/submodule.c
+++ b/submodule.c
@@ -7,6 +7,7 @@
 #include "dir.h"
 #include "diff.h"
 #include "commit.h"
+#include "gettext.h"
 #include "hex.h"
 #include "revision.h"
 #include "run-command.h"
diff --git a/symlinks.c b/symlinks.c
index c667baa949b..c35c8d4408d 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 
 static int threaded_check_leading_path(struct cache_def *cache, const char *name,
 				       int len, int warn_on_lstat_err);
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index 615e648e555..8b7a8fce1ee 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "tree.h"
 #include "cache-tree.h"
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 1e975df9041..68bbc41b330 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -15,6 +15,7 @@
 #include "cache.h"
 #include "cache-tree.h"
 #include "commit.h"
+#include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "merge-ort.h"
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 05d56267a9f..09c711038ce 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "commit-reach.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "ref-filter.h"
diff --git a/t/helper/test-serve-v2.c b/t/helper/test-serve-v2.c
index 824e5c0a958..497d72058de 100644
--- a/t/helper/test-serve-v2.c
+++ b/t/helper/test-serve-v2.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "gettext.h"
 #include "parse-options.h"
 #include "serve.h"
 
diff --git a/trailer.c b/trailer.c
index 72c3fed5c6e..9eb1b761190 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "string-list.h"
 #include "run-command.h"
 #include "commit.h"
diff --git a/transport-helper.c b/transport-helper.c
index 82ac63e2609..105bb801c21 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -4,6 +4,7 @@
 #include "run-command.h"
 #include "commit.h"
 #include "diff.h"
+#include "gettext.h"
 #include "hex.h"
 #include "revision.h"
 #include "remote.h"
diff --git a/tree-walk.c b/tree-walk.c
index 0e2f5ceb71d..38b6556478d 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -2,6 +2,7 @@
 #include "tree-walk.h"
 #include "alloc.h"
 #include "dir.h"
+#include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
 #include "tree.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index a75fb9f05b4..84e0d2e8afe 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -3,6 +3,7 @@
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
+#include "gettext.h"
 #include "hex.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/upload-pack.c b/upload-pack.c
index 41b9362cf1b..eea9e6a6e8c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/usage.c b/usage.c
index 5a7c6c346c1..40a1c5a4339 100644
--- a/usage.c
+++ b/usage.c
@@ -3,8 +3,8 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "git-compat-util.h"
 #include "cache.h"
+#include "gettext.h"
 
 static void vreportf(const char *prefix, const char *err, va_list params)
 {
diff --git a/walker.c b/walker.c
index c0469363789..b642fd2c3bc 100644
--- a/walker.c
+++ b/walker.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "gettext.h"
 #include "hex.h"
 #include "walker.h"
 #include "repository.h"
diff --git a/worktree.c b/worktree.c
index cbb0db2d7cc..09eb522e5a9 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "repository.h"
 #include "refs.h"
 #include "strbuf.h"
diff --git a/wrapper.c b/wrapper.c
index 299d6489a6b..0d4ceba6fc5 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 
 static intmax_t count_fsync_writeout_only;
 static intmax_t count_fsync_hardware_flush;
diff --git a/wt-status.c b/wt-status.c
index 90525bd26fd..d15f2b0e7e8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -4,6 +4,7 @@
 #include "dir.h"
 #include "commit.h"
 #include "diff.h"
+#include "gettext.h"
 #include "hex.h"
 #include "revision.h"
 #include "diffcore.h"
-- 
gitgitgadget

