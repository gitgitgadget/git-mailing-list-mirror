Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DDD21F406
	for <e@80x24.org>; Tue, 15 May 2018 23:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeEOXmm (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:42:42 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:38859 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeEOXmj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:39 -0400
Received: by mail-pf0-f179.google.com with SMTP id o76-v6so821153pfi.5
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dotVnaji/xc+4/r1R4qQPAlYMHtHqp/Ubw9rLvWbKeY=;
        b=sCdU5OvVslSf92+Tt2itHCJVsR/NcbqPcNHOU+q45yGG9Y+2YVqLEIEij5qJZcx5sv
         +MIP6NCwN/0tdbYPlXhCZ8npiU3LfhhSSI9YKMi3OGeUM8dTM31rukRZfxVsf9Dgotbm
         PPbn6xeIDL+mnO2xvsxcqh6oxP2D2jK2cQFwzKxpIMJHpItnroEtUH/cuRs0Q+A0T7rZ
         rt9mG1/UHz3VSfxzKcTV689XdUUYNeCLs3aZyaIkCfIXq/DO255TpDovI9D3OzCS69KP
         o+/+Sm4ip7Zaj2ZXP0qqN++QnRPE4b0qXSLUMyW5MbB5h7QoMweD29pqh3wTfm3t4DUw
         EJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dotVnaji/xc+4/r1R4qQPAlYMHtHqp/Ubw9rLvWbKeY=;
        b=nu16MSB3xAhhw/QxQVK7STfyRSqNN0dc9DSwnpY6JlvsTv0njmVpBbf7OjwciJmoC5
         2ov63c48YpnF0JuD+5DjoErC3Llsbuwo1/p75wBoBl9JW15T4M3VjUo/WGi2TInIB6LP
         Glnp3tHh4p3b7RwSBGVOIiRvAkPTb7M8u7fw00giSNpkTjcW4fj5JJJIhIKLWU71NeYV
         0piPRPbQZVC3/qFixBFzSxtMDjC4GjfthuKTBhl8T5ZzIxoOpujU1zvbDv3ISUja4j+O
         MUkd9+eGzhIzVjbXIWK7EHv4oOIysWtjkUbnnwL7n+S1i/BOHtSRk3Ke93X6EMhC2Ppy
         Z+Yw==
X-Gm-Message-State: ALKqPwcI5npJF90cZiXrGPBeRq+oDlV/NlzoUcRZ8cL8txarZvs/GGHG
        bXAgjKi3DISeaI1t3kAzlbTtlTZf2GY=
X-Google-Smtp-Source: AB8JxZpUui/uq0SpPf6ZGkgRu1DJ01xAbW6szeE2mbVFpd12YL4AWHH4yfupIyD+7S8SC0OAGeIg6Q==
X-Received: by 2002:a65:5042:: with SMTP id k2-v6mr9936897pgo.122.1526427757378;
        Tue, 15 May 2018 16:42:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r8-v6sm1409616pfk.179.2018.05.15.16.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/19] object-store: move object access functions to object-store.h
Date:   Tue, 15 May 2018 16:42:15 -0700
Message-Id: <20180515234233.143708-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This should make these functions easier to find and cache.h less
overwhelming to read.

In particular, this moves:
- read_object_file
- oid_object_info
- write_object_file

As a result, most of the codebase needs to #include object-store.h.
In this patch the #include is only added to files that would fail to
compile otherwise.  It would be better to #include wherever
identifiers from the header are used.  That can happen later
when we have better tooling for it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 apply.c                  |   1 +
 archive-tar.c            |   1 +
 archive-zip.c            |   1 +
 archive.c                |   1 +
 blame.c                  |   1 +
 builtin/blame.c          |   1 +
 builtin/cat-file.c       |   1 +
 builtin/checkout.c       |   1 +
 builtin/clone.c          |   1 +
 builtin/commit-tree.c    |   1 +
 builtin/describe.c       |   1 +
 builtin/difftool.c       |   1 +
 builtin/fast-export.c    |   1 +
 builtin/fetch.c          |   1 +
 builtin/fmt-merge-msg.c  |   1 +
 builtin/hash-object.c    |   1 +
 builtin/log.c            |   1 +
 builtin/ls-tree.c        |   1 +
 builtin/merge-tree.c     |   1 +
 builtin/mktag.c          |   1 +
 builtin/mktree.c         |   1 +
 builtin/notes.c          |   1 +
 builtin/prune.c          |   1 +
 builtin/receive-pack.c   |   1 +
 builtin/reflog.c         |   1 +
 builtin/remote.c         |   1 +
 builtin/rev-list.c       |   1 +
 builtin/show-ref.c       |   1 +
 builtin/tag.c            |   1 +
 builtin/unpack-file.c    |   1 +
 builtin/unpack-objects.c |   1 +
 builtin/verify-commit.c  |   1 +
 bulk-checkin.c           |   1 +
 bundle.c                 |   1 +
 cache-tree.c             |   1 +
 cache.h                  | 117 ---------------------------------------
 combine-diff.c           |   1 +
 commit.c                 |   1 +
 config.c                 |   1 +
 convert.c                |   1 +
 diff.c                   |   1 +
 diffcore-rename.c        |   1 +
 dir.c                    |   1 +
 entry.c                  |   1 +
 fetch-pack.c             |   1 +
 fsck.c                   |   1 +
 grep.c                   |   1 +
 list-objects-filter.c    |   1 +
 list-objects.c           |   1 +
 log-tree.c               |   1 +
 mailmap.c                |   1 +
 match-trees.c            |   1 +
 merge-blobs.c            |   1 +
 merge-recursive.c        |   1 +
 notes-cache.c            |   1 +
 notes-merge.c            |   1 +
 notes.c                  |   1 +
 object-store.h           | 117 +++++++++++++++++++++++++++++++++++++++
 object.c                 |   1 +
 pack-bitmap-write.c      |   1 +
 packfile.h               |   5 ++
 read-cache.c             |   1 +
 ref-filter.c             |   1 +
 refs.c                   |   1 +
 remote-testsvn.c         |   1 +
 remote.c                 |   1 +
 rerere.c                 |   1 +
 revision.c               |   1 +
 send-pack.c              |   1 +
 sequencer.c              |   1 +
 shallow.c                |   1 +
 submodule-config.c       |   1 +
 tag.c                    |   1 +
 tree-walk.c              |   1 +
 tree.c                   |   1 +
 unpack-trees.c           |   1 +
 upload-pack.c            |   1 +
 walker.c                 |   1 +
 xdiff-interface.c        |   1 +
 79 files changed, 198 insertions(+), 117 deletions(-)

diff --git a/apply.c b/apply.c
index 7e5792c996f..cbc45fa1b0e 100644
--- a/apply.c
+++ b/apply.c
@@ -9,6 +9,7 @@
 
 #include "cache.h"
 #include "config.h"
+#include "object-store.h"
 #include "blob.h"
 #include "delta.h"
 #include "diff.h"
diff --git a/archive-tar.c b/archive-tar.c
index f93409324f9..e38435eb4ef 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -5,6 +5,7 @@
 #include "config.h"
 #include "tar.h"
 #include "archive.h"
+#include "object-store.h"
 #include "streaming.h"
 #include "run-command.h"
 
diff --git a/archive-zip.c b/archive-zip.c
index 74f3fe91034..abc556e5a75 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -6,6 +6,7 @@
 #include "archive.h"
 #include "streaming.h"
 #include "utf8.h"
+#include "object-store.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
 
diff --git a/archive.c b/archive.c
index 93ab175b0b4..9da1e3664a6 100644
--- a/archive.c
+++ b/archive.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "refs.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tree-walk.h"
 #include "attr.h"
diff --git a/blame.c b/blame.c
index 3a11f1ce52b..f689bde31cd 100644
--- a/blame.c
+++ b/blame.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "refs.h"
+#include "object-store.h"
 #include "cache-tree.h"
 #include "mergesort.h"
 #include "diff.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index bfdf7cc1325..0ffd1d443ea 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -22,6 +22,7 @@
 #include "line-log.h"
 #include "dir.h"
 #include "progress.h"
+#include "object-store.h"
 #include "blame.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b8ecbea98e9..91e7764243e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -13,6 +13,7 @@
 #include "tree-walk.h"
 #include "sha1-array.h"
 #include "packfile.h"
+#include "object-store.h"
 
 struct batch_options {
 	int enabled;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b49b5820718..105e07981ff 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -4,6 +4,7 @@
 #include "lockfile.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 7df5932b855..29998c02ece 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -14,6 +14,7 @@
 #include "parse-options.h"
 #include "fetch-pack.h"
 #include "refs.h"
+#include "object-store.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index ecf42191da1..9fbd3529fb1 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tree.h"
 #include "builtin.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index 66c497f7896..65b0edc473c 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -13,6 +13,7 @@
 #include "hashmap.h"
 #include "argv-array.h"
 #include "run-command.h"
+#include "object-store.h"
 #include "revision.h"
 #include "list-objects.h"
 
diff --git a/builtin/difftool.c b/builtin/difftool.c
index ee8dce019e1..df7e75f797b 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -20,6 +20,7 @@
 #include "argv-array.h"
 #include "strbuf.h"
 #include "lockfile.h"
+#include "object-store.h"
 #include "dir.h"
 
 static char *diff_gui_tool;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 373c794873e..f593e57b9d4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "config.h"
 #include "refs.h"
+#include "object-store.h"
 #include "commit.h"
 #include "object.h"
 #include "tag.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 73be393b2ea..c1f2df97965 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -5,6 +5,7 @@
 #include "config.h"
 #include "repository.h"
 #include "refs.h"
+#include "object-store.h"
 #include "commit.h"
 #include "builtin.h"
 #include "string-list.h"
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index bd680be6874..1b526adb3a9 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "config.h"
 #include "refs.h"
+#include "object-store.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 526da5c1856..d5c018eabd5 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -6,6 +6,7 @@
  */
 #include "builtin.h"
 #include "config.h"
+#include "object-store.h"
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin/log.c b/builtin/log.c
index 71f68a3e4f5..9656578f58e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "config.h"
 #include "refs.h"
+#include "object-store.h"
 #include "color.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 409da4e8351..fe3b952cb30 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "object-store.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 32736e0b101..1b702d44c9f 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
+#include "object-store.h"
 #include "blob.h"
 #include "exec_cmd.h"
 #include "merge-blobs.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 82a6e860775..6fb7dc8578d 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "tag.h"
 #include "replace-object.h"
+#include "object-store.h"
 
 /*
  * A signature file has a very simple fixed format: four lines
diff --git a/builtin/mktree.c b/builtin/mktree.c
index bb76b469fd1..2dc4ad6ba8f 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -7,6 +7,7 @@
 #include "quote.h"
 #include "tree.h"
 #include "parse-options.h"
+#include "object-store.h"
 
 static struct treeent {
 	unsigned mode;
diff --git a/builtin/notes.c b/builtin/notes.c
index 921e08d5bf5..73b680ee13a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -11,6 +11,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "notes.h"
+#include "object-store.h"
 #include "blob.h"
 #include "pretty.h"
 #include "refs.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index 518ffbea139..8cc8659612f 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -6,6 +6,7 @@
 #include "reachable.h"
 #include "parse-options.h"
 #include "progress.h"
+#include "object-store.h"
 
 static const char * const prune_usage[] = {
 	N_("git prune [-n] [-v] [--progress] [--expire <time>] [--] [<head>...]"),
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c4272fbc96d..36906fd5e98 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -25,6 +25,7 @@
 #include "tmp-objdir.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "object-store.h"
 #include "protocol.h"
 
 static const char * const receive_pack_usage[] = {
diff --git a/builtin/reflog.c b/builtin/reflog.c
index a89bd1dd252..bee4795a936 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
+#include "object-store.h"
 #include "commit.h"
 #include "refs.h"
 #include "dir.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index 805ffc05cdb..9487c019092 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "refs.h"
+#include "object-store.h"
 #include "argv-array.h"
 
 static const char * const builtin_remote_usage[] = {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index fadd3ec14cb..e9bd4e378ad 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -6,6 +6,7 @@
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "object-store.h"
 #include "pack.h"
 #include "pack-bitmap.h"
 #include "builtin.h"
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index f2eb1a77240..2f13f1316fa 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "refs.h"
+#include "object-store.h"
 #include "object.h"
 #include "tag.h"
 #include "string-list.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 26d7729f57b..f872f14f65e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "refs.h"
+#include "object-store.h"
 #include "tag.h"
 #include "run-command.h"
 #include "parse-options.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 300eb59657e..58652229f27 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "object-store.h"
 
 static char *create_temp_file(struct object_id *oid)
 {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index cfe9019f800..ded798b72ff 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "object-store.h"
 #include "object.h"
 #include "delta.h"
 #include "pack.h"
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index dcdaada1110..f6922da16d6 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "object-store.h"
 #include "commit.h"
 #include "run-command.h"
 #include <signal.h>
diff --git a/bulk-checkin.c b/bulk-checkin.c
index de1f4040c78..918d58a7ebf 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -8,6 +8,7 @@
 #include "pack.h"
 #include "strbuf.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static struct bulk_checkin_state {
 	unsigned plugged:1;
diff --git a/bundle.c b/bundle.c
index 902c9b54485..00ada05f46c 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "lockfile.h"
 #include "bundle.h"
+#include "object-store.h"
 #include "object.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/cache-tree.c b/cache-tree.c
index 6a555f4d431..1c338c41f3a 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -3,6 +3,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
+#include "object-store.h"
 
 #ifndef DEBUG
 #define DEBUG 0
diff --git a/cache.h b/cache.h
index c75559b7d38..ab716011b7e 100644
--- a/cache.h
+++ b/cache.h
@@ -1183,32 +1183,6 @@ extern char *xdg_config_home(const char *filename);
  */
 extern char *xdg_cache_home(const char *filename);
 
-extern void *read_object_file_extended(const struct object_id *oid,
-				       enum object_type *type,
-				       unsigned long *size, int lookup_replace);
-static inline void *read_object_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
-{
-	return read_object_file_extended(oid, type, size, 1);
-}
-
-/* Read and unpack an object file into memory, write memory to an object file */
-int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
-
-extern int hash_object_file(const void *buf, unsigned long len,
-			    const char *type, struct object_id *oid);
-
-extern int write_object_file(const void *buf, unsigned long len,
-			     const char *type, struct object_id *oid);
-
-extern int hash_object_file_literally(const void *buf, unsigned long len,
-				      const char *type, struct object_id *oid,
-				      unsigned flags);
-
-extern int pretend_object_file(void *, unsigned long, enum object_type,
-			       struct object_id *oid);
-
-extern int force_object_loose(const struct object_id *oid, time_t mtime);
-
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
@@ -1218,43 +1192,6 @@ extern int check_object_signature(const struct object_id *oid, void *buf, unsign
 
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
-/*
- * Open the loose object at path, check its hash, and return the contents,
- * type, and size. If the object is a blob, then "contents" may return NULL,
- * to allow streaming of large blobs.
- *
- * Returns 0 on success, negative on error (details may be written to stderr).
- */
-int read_loose_object(const char *path,
-		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
-		      void **contents);
-
-/*
- * Convenience for sha1_object_info_extended() with a NULL struct
- * object_info. OBJECT_INFO_SKIP_CACHED is automatically set; pass
- * nonzero flags to also set other flags.
- */
-extern int has_sha1_file_with_flags(const unsigned char *sha1, int flags);
-static inline int has_sha1_file(const unsigned char *sha1)
-{
-	return has_sha1_file_with_flags(sha1, 0);
-}
-
-/* Same as the above, except for struct object_id. */
-extern int has_object_file(const struct object_id *oid);
-extern int has_object_file_with_flags(const struct object_id *oid, int flags);
-
-/*
- * Return true iff an alternate object database has a loose object
- * with the specified name.  This function does not respect replace
- * references.
- */
-extern int has_loose_object_nonlocal(const unsigned char *sha1);
-
-extern void assert_oid_type(const struct object_id *oid, enum object_type expect);
-
 /* Helper to check and "touch" a file */
 extern int check_and_freshen_file(const char *fn, int freshen);
 
@@ -1624,60 +1561,6 @@ int for_each_loose_file_in_objdir_buf(struct strbuf *path,
 #define FOR_EACH_OBJECT_LOCAL_ONLY 0x1
 extern int for_each_loose_object(each_loose_object_fn, void *, unsigned flags);
 
-struct object_info {
-	/* Request */
-	enum object_type *typep;
-	unsigned long *sizep;
-	off_t *disk_sizep;
-	unsigned char *delta_base_sha1;
-	struct strbuf *type_name;
-	void **contentp;
-
-	/* Response */
-	enum {
-		OI_CACHED,
-		OI_LOOSE,
-		OI_PACKED,
-		OI_DBCACHED
-	} whence;
-	union {
-		/*
-		 * struct {
-		 * 	... Nothing to expose in this case
-		 * } cached;
-		 * struct {
-		 * 	... Nothing to expose in this case
-		 * } loose;
-		 */
-		struct {
-			struct packed_git *pack;
-			off_t offset;
-			unsigned int is_delta;
-		} packed;
-	} u;
-};
-
-/*
- * Initializer for a "struct object_info" that wants no items. You may
- * also memset() the memory to all-zeroes.
- */
-#define OBJECT_INFO_INIT {NULL}
-
-/* Invoke lookup_replace_object() on the given hash */
-#define OBJECT_INFO_LOOKUP_REPLACE 1
-/* Allow reading from a loose object file of unknown/bogus type */
-#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
-/* Do not check cached storage */
-#define OBJECT_INFO_SKIP_CACHED 4
-/* Do not retry packed storage after checking packed and loose storage */
-#define OBJECT_INFO_QUICK 8
-/* Do not check loose object */
-#define OBJECT_INFO_IGNORE_LOOSE 16
-
-int oid_object_info_extended(struct repository *r,
-			     const struct object_id *,
-			     struct object_info *, unsigned flags);
-
 /*
  * Set this to 0 to prevent sha1_object_info_extended() from fetching missing
  * blobs. This has a difference only if extensions.partialClone is set.
diff --git a/combine-diff.c b/combine-diff.c
index 2ef495963fc..de7695e7282 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "object-store.h"
 #include "commit.h"
 #include "blob.h"
 #include "diff.h"
diff --git a/commit.c b/commit.c
index 5eb4d2f08f8..b053f07f305 100644
--- a/commit.c
+++ b/commit.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tag.h"
 #include "commit.h"
+#include "object-store.h"
 #include "pkt-line.h"
 #include "utf8.h"
 #include "diff.h"
diff --git a/config.c b/config.c
index c698988f5e1..041db3ce7d4 100644
--- a/config.c
+++ b/config.c
@@ -14,6 +14,7 @@
 #include "quote.h"
 #include "hashmap.h"
 #include "string-list.h"
+#include "object-store.h"
 #include "utf8.h"
 #include "dir.h"
 
diff --git a/convert.c b/convert.c
index c480097a2a0..7f5afd6dd66 100644
--- a/convert.c
+++ b/convert.c
@@ -1,6 +1,7 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
+#include "object-store.h"
 #include "attr.h"
 #include "run-command.h"
 #include "quote.h"
diff --git a/diff.c b/diff.c
index 4753170fe12..18d478c5190 100644
--- a/diff.c
+++ b/diff.c
@@ -13,6 +13,7 @@
 #include "attr.h"
 #include "run-command.h"
 #include "utf8.h"
+#include "object-store.h"
 #include "userdiff.h"
 #include "submodule-config.h"
 #include "submodule.h"
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 0b7e4989a87..d775183c2fd 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "object-store.h"
 #include "hashmap.h"
 #include "progress.h"
 
diff --git a/dir.c b/dir.c
index 63a917be45d..9e7c90cf50b 100644
--- a/dir.c
+++ b/dir.c
@@ -11,6 +11,7 @@
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
+#include "object-store.h"
 #include "attr.h"
 #include "refs.h"
 #include "wildmatch.h"
diff --git a/entry.c b/entry.c
index 2101201a111..b5d1d3cf231 100644
--- a/entry.c
+++ b/entry.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "blob.h"
+#include "object-store.h"
 #include "dir.h"
 #include "streaming.h"
 #include "submodule.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index adc1b68dd3a..a1535b37b9b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -19,6 +19,7 @@
 #include "sha1-array.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
diff --git a/fsck.c b/fsck.c
index 9218c2a643b..59b0c7d640e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "object-store.h"
 #include "object.h"
 #include "blob.h"
 #include "tree.h"
diff --git a/grep.c b/grep.c
index 65b90c10a38..438987220ea 100644
--- a/grep.c
+++ b/grep.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "grep.h"
+#include "object-store.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
 #include "diff.h"
diff --git a/list-objects-filter.c b/list-objects-filter.c
index ea94fe8af28..44b3a49bdb3 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -11,6 +11,7 @@
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "oidset.h"
+#include "object-store.h"
 
 /* Remember to update object flag allocation in object.h */
 /*
diff --git a/list-objects.c b/list-objects.c
index 168bef688a8..7ae0eb8ebc7 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -10,6 +10,7 @@
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static void process_blob(struct rev_info *revs,
 			 struct blob *blob,
diff --git a/log-tree.c b/log-tree.c
index d1c0bedf244..5660ee7c785 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tag.h"
 #include "graph.h"
diff --git a/mailmap.c b/mailmap.c
index 13f0d2884e2..962fd86d6d7 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "string-list.h"
 #include "mailmap.h"
+#include "object-store.h"
 
 #define DEBUG_MAILMAP 0
 #if DEBUG_MAILMAP
diff --git a/match-trees.c b/match-trees.c
index 72cc2baa3f9..4cdeff53e1e 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tree.h"
 #include "tree-walk.h"
+#include "object-store.h"
 
 static int score_missing(unsigned mode, const char *path)
 {
diff --git a/merge-blobs.c b/merge-blobs.c
index fa49c17287f..fabb8c19ce9 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -4,6 +4,7 @@
 #include "ll-merge.h"
 #include "blob.h"
 #include "merge-blobs.h"
+#include "object-store.h"
 
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
diff --git a/merge-recursive.c b/merge-recursive.c
index cbded673c28..455f59d21ac 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -8,6 +8,7 @@
 #include "advice.h"
 #include "lockfile.h"
 #include "cache-tree.h"
+#include "object-store.h"
 #include "commit.h"
 #include "blob.h"
 #include "builtin.h"
diff --git a/notes-cache.c b/notes-cache.c
index e61988e503b..d5770031776 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "notes-cache.h"
+#include "object-store.h"
 #include "commit.h"
 #include "refs.h"
 
diff --git a/notes-merge.c b/notes-merge.c
index 8e0726a9418..fd96c5ab3d6 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "refs.h"
+#include "object-store.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "xdiff-interface.h"
diff --git a/notes.c b/notes.c
index a386d450c4c..32d3dbcc1e7 100644
--- a/notes.c
+++ b/notes.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "notes.h"
+#include "object-store.h"
 #include "blob.h"
 #include "tree.h"
 #include "utf8.h"
diff --git a/object-store.h b/object-store.h
index 1ff862c7f93..695266891bf 100644
--- a/object-store.h
+++ b/object-store.h
@@ -137,4 +137,121 @@ void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned cha
 
 void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
+extern void *read_object_file_extended(const struct object_id *oid,
+				       enum object_type *type,
+				       unsigned long *size, int lookup_replace);
+static inline void *read_object_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
+{
+	return read_object_file_extended(oid, type, size, 1);
+}
+
+/* Read and unpack an object file into memory, write memory to an object file */
+int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
+
+extern int hash_object_file(const void *buf, unsigned long len,
+			    const char *type, struct object_id *oid);
+
+extern int write_object_file(const void *buf, unsigned long len,
+			     const char *type, struct object_id *oid);
+
+extern int hash_object_file_literally(const void *buf, unsigned long len,
+				      const char *type, struct object_id *oid,
+				      unsigned flags);
+
+extern int pretend_object_file(void *, unsigned long, enum object_type,
+			       struct object_id *oid);
+
+extern int force_object_loose(const struct object_id *oid, time_t mtime);
+
+/*
+ * Open the loose object at path, check its hash, and return the contents,
+ * type, and size. If the object is a blob, then "contents" may return NULL,
+ * to allow streaming of large blobs.
+ *
+ * Returns 0 on success, negative on error (details may be written to stderr).
+ */
+int read_loose_object(const char *path,
+		      const struct object_id *expected_oid,
+		      enum object_type *type,
+		      unsigned long *size,
+		      void **contents);
+
+/*
+ * Convenience for sha1_object_info_extended() with a NULL struct
+ * object_info. OBJECT_INFO_SKIP_CACHED is automatically set; pass
+ * nonzero flags to also set other flags.
+ */
+extern int has_sha1_file_with_flags(const unsigned char *sha1, int flags);
+static inline int has_sha1_file(const unsigned char *sha1)
+{
+	return has_sha1_file_with_flags(sha1, 0);
+}
+
+/* Same as the above, except for struct object_id. */
+extern int has_object_file(const struct object_id *oid);
+extern int has_object_file_with_flags(const struct object_id *oid, int flags);
+
+/*
+ * Return true iff an alternate object database has a loose object
+ * with the specified name.  This function does not respect replace
+ * references.
+ */
+extern int has_loose_object_nonlocal(const unsigned char *sha1);
+
+extern void assert_oid_type(const struct object_id *oid, enum object_type expect);
+
+struct object_info {
+	/* Request */
+	enum object_type *typep;
+	unsigned long *sizep;
+	off_t *disk_sizep;
+	unsigned char *delta_base_sha1;
+	struct strbuf *type_name;
+	void **contentp;
+
+	/* Response */
+	enum {
+		OI_CACHED,
+		OI_LOOSE,
+		OI_PACKED,
+		OI_DBCACHED
+	} whence;
+	union {
+		/*
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } cached;
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } loose;
+		 */
+		struct {
+			struct packed_git *pack;
+			off_t offset;
+			unsigned int is_delta;
+		} packed;
+	} u;
+};
+
+/*
+ * Initializer for a "struct object_info" that wants no items. You may
+ * also memset() the memory to all-zeroes.
+ */
+#define OBJECT_INFO_INIT {NULL}
+
+/* Invoke lookup_replace_object() on the given hash */
+#define OBJECT_INFO_LOOKUP_REPLACE 1
+/* Allow reading from a loose object file of unknown/bogus type */
+#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
+/* Do not check cached storage */
+#define OBJECT_INFO_SKIP_CACHED 4
+/* Do not retry packed storage after checking packed and loose storage */
+#define OBJECT_INFO_QUICK 8
+/* Do not check loose object */
+#define OBJECT_INFO_IGNORE_LOOSE 16
+
+int oid_object_info_extended(struct repository *r,
+			     const struct object_id *,
+			     struct object_info *, unsigned flags);
+
 #endif /* OBJECT_STORE_H */
diff --git a/object.c b/object.c
index 8e29f63bf23..0116ed6529a 100644
--- a/object.c
+++ b/object.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "object.h"
 #include "replace-object.h"
+#include "object-store.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index cd1903e717a..f7fac9d0f24 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tag.h"
 #include "diff.h"
diff --git a/packfile.h b/packfile.h
index fdfddb89b53..1abbc2c07c8 100644
--- a/packfile.h
+++ b/packfile.h
@@ -3,6 +3,11 @@
 
 #include "oidset.h"
 
+/* in object-store.h */
+struct packed_git;
+struct object_info;
+enum object_type;
+
 /*
  * Generate the filename to be used for a pack file with checksum "sha1" and
  * extension "ext". The result is written into the strbuf "buf", overwriting
diff --git a/read-cache.c b/read-cache.c
index 10f1c6bb8a3..7f10d9ffff9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -11,6 +11,7 @@
 #include "cache-tree.h"
 #include "refs.h"
 #include "dir.h"
+#include "object-store.h"
 #include "tree.h"
 #include "commit.h"
 #include "blob.h"
diff --git a/ref-filter.c b/ref-filter.c
index 9a333e21b51..e2ae1f47fee 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3,6 +3,7 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "wildmatch.h"
+#include "object-store.h"
 #include "commit.h"
 #include "remote.h"
 #include "color.h"
diff --git a/refs.c b/refs.c
index 27c88ba7689..2361ba9c6ee 100644
--- a/refs.c
+++ b/refs.c
@@ -9,6 +9,7 @@
 #include "iterator.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
+#include "object-store.h"
 #include "object.h"
 #include "tag.h"
 #include "submodule.h"
diff --git a/remote-testsvn.c b/remote-testsvn.c
index c4bb9a8ba92..515b922b503 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "refs.h"
 #include "remote.h"
+#include "object-store.h"
 #include "strbuf.h"
 #include "url.h"
 #include "exec_cmd.h"
diff --git a/remote.c b/remote.c
index 481bf933f39..db438cfbc56 100644
--- a/remote.c
+++ b/remote.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "remote.h"
 #include "refs.h"
+#include "object-store.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/rerere.c b/rerere.c
index 18cae2d11c9..fcb99cc9542 100644
--- a/rerere.c
+++ b/rerere.c
@@ -9,6 +9,7 @@
 #include "ll-merge.h"
 #include "attr.h"
 #include "pathspec.h"
+#include "object-store.h"
 #include "sha1-lookup.h"
 
 #define RESOLVED 0
diff --git a/revision.c b/revision.c
index 1cff11833e7..260b9c276c7 100644
--- a/revision.c
+++ b/revision.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "object-store.h"
 #include "tag.h"
 #include "blob.h"
 #include "tree.h"
diff --git a/send-pack.c b/send-pack.c
index 19025a7aca8..71600028cdd 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "commit.h"
 #include "refs.h"
+#include "object-store.h"
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
diff --git a/sequencer.c b/sequencer.c
index 44f0518b9c4..cf6456ab75d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "lockfile.h"
 #include "dir.h"
+#include "object-store.h"
 #include "object.h"
 #include "commit.h"
 #include "sequencer.h"
diff --git a/shallow.c b/shallow.c
index df4d44ea7a3..c2f81a5a5a8 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tempfile.h"
 #include "lockfile.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tag.h"
 #include "pkt-line.h"
diff --git a/submodule-config.c b/submodule-config.c
index 3f2075764fe..a1e57c33339 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -4,6 +4,7 @@
 #include "submodule-config.h"
 #include "submodule.h"
 #include "strbuf.h"
+#include "object-store.h"
 #include "parse-options.h"
 
 /*
diff --git a/tag.c b/tag.c
index 7c12426b4ea..3be7206e920 100644
--- a/tag.c
+++ b/tag.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tag.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
diff --git a/tree-walk.c b/tree-walk.c
index e11b3063afa..cd428a1ee53 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -2,6 +2,7 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "dir.h"
+#include "object-store.h"
 #include "tree.h"
 #include "pathspec.h"
 
diff --git a/tree.c b/tree.c
index 8f8ef3189af..dc20a2693fd 100644
--- a/tree.c
+++ b/tree.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "cache-tree.h"
 #include "tree.h"
+#include "object-store.h"
 #include "blob.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index e73745051e5..e3f95cc6f95 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -15,6 +15,7 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "fsmonitor.h"
+#include "object-store.h"
 #include "fetch-object.h"
 
 /*
diff --git a/upload-pack.c b/upload-pack.c
index 4a82602be5d..a11c6d192ce 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -3,6 +3,7 @@
 #include "refs.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "object-store.h"
 #include "tag.h"
 #include "object.h"
 #include "commit.h"
diff --git a/walker.c b/walker.c
index dffb9c8e37c..3fb5fb2a0be 100644
--- a/walker.c
+++ b/walker.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "walker.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 9315bc0ede1..ec6e574e4aa 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "object-store.h"
 #include "xdiff-interface.h"
 #include "xdiff/xtypes.h"
 #include "xdiff/xdiffi.h"
-- 
2.17.0.582.gccdcbd54c44.dirty

