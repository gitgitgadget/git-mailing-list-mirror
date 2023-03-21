Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B7DC74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 06:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCUG1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCUG0f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 02:26:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D1638475
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o7so12507856wrg.5
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679379989;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsjTwwbJVepe4/+op9TIP0CLIGmHderIM5+u3c4gkhA=;
        b=VWUjW+3xN7zFI82mvmOqCJL1F8YN94dMvOGkrSm5lD4Mtg/Wd6aOT2EcPafu6Ilwjv
         xtQuZNxuH+Lz2+Dtai73VaWD0lo3h2Ir9chdHxxRZnvkQP2We+LPZaV8ABy2pVDFOMEV
         JEN6oPrAWUzJbDeWN1O97SgNRbVTrjSoXdAeARAv6rXEsQAmIBOEL8/TzcpBr4yWIr/h
         UUzhqI6Zq45tuU96NRBaE0HgbN4OcZOpioJViUOCZIfKdISahW7egjiOemCyCr5MqHlo
         7JgUkKYVqAC7HD7JwFQ38v5SlNI70GdfYlvyy3YqAGUu4GCxEzjhdbOU/1P40Tm1Q0Le
         ejRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379989;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsjTwwbJVepe4/+op9TIP0CLIGmHderIM5+u3c4gkhA=;
        b=3a770oZALG0n+OXfGH+YEHbBp5zlCdreAc8QPFsCVhBdacxsaogPWp4vNpy0UDuHK7
         bkKE93W0vm9BxgT4D9jUBI8PrzsywX9qSPfm4qO20gQMOWqwIHk4ADZZpsmGjTd+aWqC
         1omMaPgbgSj8i4LlnDcw3Kj0yONUL+C8y45V9INqmptudk2IAS4GssL31UL0dH62jgxW
         GxBiFT7rutygTVzfTu7wT/SCkt5lKSHinW9rpIpo4Mez8/l7t43fG699d0penHvxl5pQ
         CA48VLw3/zuFK0Vdmf/w8izm4xcqiVECsQlYkTdRkYH7+RIRTC7Yyn1x0Vtdqa6VUzXl
         lPCA==
X-Gm-Message-State: AO0yUKXe3ZKEgqbTiVMmjac6tgv4ONoTdd8JxjZGVRLi1eA0CDxUIkkV
        l0O6NatwK12UxZXUNsd+SSm4DjrRmT0=
X-Google-Smtp-Source: AK7set/Aq5rU4j38RNvgLq0C54saAsAwVingmCDWydzfkGND529qwgLSxatqMBBGJSX8dOl4SJwZyQ==
X-Received: by 2002:adf:e849:0:b0:2d1:9b6b:92a with SMTP id d9-20020adfe849000000b002d19b6b092amr11350517wrn.23.1679379988639;
        Mon, 20 Mar 2023 23:26:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000100600b002c8ed82c56csm10502389wrx.116.2023.03.20.23.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:26:28 -0700 (PDT)
Message-Id: <6e40d1d783d8643da23b5f1a524ebdba12f7e7dc.1679379973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
        <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Mar 2023 06:26:07 +0000
Subject: [PATCH v2 15/16] write-or-die.h: move declarations for write-or-die.c
 functions from cache.h
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 archive-tar.c              |  1 +
 archive-zip.c              |  1 +
 builtin/blame.c            |  1 +
 builtin/cat-file.c         |  1 +
 builtin/check-attr.c       |  1 +
 builtin/check-ignore.c     |  1 +
 builtin/check-mailmap.c    |  1 +
 builtin/credential-cache.c |  1 +
 builtin/credential-store.c |  1 +
 builtin/grep.c             |  1 +
 builtin/hash-object.c      |  1 +
 builtin/log.c              |  1 +
 builtin/notes.c            |  1 +
 builtin/send-pack.c        |  1 +
 builtin/stripspace.c       |  1 +
 builtin/tag.c              |  1 +
 builtin/update-index.c     |  1 +
 bundle.c                   |  1 +
 cache.h                    | 74 ------------------------------------
 config.c                   |  1 +
 csum-file.h                |  1 +
 diagnose.c                 |  1 +
 environment.c              |  1 +
 http-backend.c             |  1 +
 log-tree.c                 |  1 +
 pkt-line.c                 |  1 +
 refs/files-backend.c       |  1 +
 refs/packed-backend.c      |  1 +
 remote-curl.c              |  1 +
 send-pack.c                |  3 +-
 sideband.c                 |  1 +
 t/helper/test-pkt-line.c   |  3 +-
 upload-pack.c              |  1 +
 write-or-die.c             |  3 +-
 write-or-die.h             | 78 ++++++++++++++++++++++++++++++++++++++
 35 files changed, 114 insertions(+), 77 deletions(-)
 create mode 100644 write-or-die.h

diff --git a/archive-tar.c b/archive-tar.c
index 16ee133bbf5..497dad0b3af 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -11,6 +11,7 @@
 #include "object-store.h"
 #include "streaming.h"
 #include "run-command.h"
+#include "write-or-die.h"
 
 #define RECORDSIZE	(512)
 #define BLOCKSIZE	(RECORDSIZE * 20)
diff --git a/archive-zip.c b/archive-zip.c
index c02dc33e406..e6f5c10a14f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -10,6 +10,7 @@
 #include "utf8.h"
 #include "object-store.h"
 #include "userdiff.h"
+#include "write-or-die.h"
 #include "xdiff-interface.h"
 #include "date.h"
 
diff --git a/builtin/blame.c b/builtin/blame.c
index fb271bae70e..0a3cc019059 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -33,6 +33,7 @@
 #include "refs.h"
 #include "setup.h"
 #include "tag.h"
+#include "write-or-die.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
 static char annotate_usage[] = N_("git annotate [<options>] [<rev-opts>] [<rev>] [--] <file>");
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 365d9234bdb..cf73d187912 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -23,6 +23,7 @@
 #include "replace-object.h"
 #include "promisor-remote.h"
 #include "mailmap.h"
+#include "write-or-die.h"
 
 enum batch_mode {
 	BATCH_MODE_CONTENTS,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index ec37b8164af..1dbe9d6ca88 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -8,6 +8,7 @@
 #include "quote.h"
 #include "setup.h"
 #include "parse-options.h"
+#include "write-or-die.h"
 
 static int all_attrs;
 static int cached_attrs;
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index a45d001e353..9401dad0070 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -8,6 +8,7 @@
 #include "pathspec.h"
 #include "parse-options.h"
 #include "submodule.h"
+#include "write-or-die.h"
 
 static int quiet, verbose, stdin_paths, show_non_matching, no_index;
 static const char * const check_ignore_usage[] = {
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index fa86fd9423d..002d2941e93 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -5,6 +5,7 @@
 #include "mailmap.h"
 #include "parse-options.h"
 #include "string-list.h"
+#include "write-or-die.h"
 
 static int use_stdin;
 static const char * const check_mailmap_usage[] = {
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index af56a44923d..508da4c6e4d 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -2,6 +2,7 @@
 #include "gettext.h"
 #include "parse-options.h"
 #include "wrapper.h"
+#include "write-or-die.h"
 
 #ifndef NO_UNIX_SOCKETS
 
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index da32cfd89e2..8977604eb9d 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -5,6 +5,7 @@
 #include "credential.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "write-or-die.h"
 
 static struct lock_file credential_lock;
 
diff --git a/builtin/grep.c b/builtin/grep.c
index b8ebf014f40..d858bf0bea6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -28,6 +28,7 @@
 #include "submodule-config.h"
 #include "object-store.h"
 #include "packfile.h"
+#include "write-or-die.h"
 
 static const char *grep_prefix;
 
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index a2e160db026..a15fe4fd3f4 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -15,6 +15,7 @@
 #include "parse-options.h"
 #include "exec-cmd.h"
 #include "setup.h"
+#include "write-or-die.h"
 
 /*
  * This is to create corrupt objects for debugging and as such it
diff --git a/builtin/log.c b/builtin/log.c
index 1b92dee196e..b28a24c3093 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -40,6 +40,7 @@
 #include "commit-reach.h"
 #include "range-diff.h"
 #include "tmp-objdir.h"
+#include "write-or-die.h"
 
 #define MAIL_DEFAULT_WRAP 72
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
diff --git a/builtin/notes.c b/builtin/notes.c
index 8e9be33ddbb..26cbb564a8e 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -25,6 +25,7 @@
 #include "notes-merge.h"
 #include "notes-utils.h"
 #include "worktree.h"
+#include "write-or-die.h"
 
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index fb5b2bad2cc..2b360fee426 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -16,6 +16,7 @@
 #include "gpg-interface.h"
 #include "gettext.h"
 #include "protocol.h"
+#include "write-or-die.h"
 
 static const char * const send_pack_usage[] = {
 	N_("git send-pack [--mirror] [--dry-run] [--force]\n"
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 53930458ffa..9451eb69ff4 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
 #include "setup.h"
 #include "strbuf.h"
+#include "write-or-die.h"
 
 static void comment_lines(struct strbuf *buf)
 {
diff --git a/builtin/tag.c b/builtin/tag.c
index 0611b3bd600..531631a36c2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -24,6 +24,7 @@
 #include "column.h"
 #include "ref-filter.h"
 #include "date.h"
+#include "write-or-die.h"
 
 static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index f97f8d4c9d5..03cda5e60d2 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -23,6 +23,7 @@
 #include "setup.h"
 #include "split-index.h"
 #include "fsmonitor.h"
+#include "write-or-die.h"
 
 /*
  * Default to not allowing changes to the list of files. The
diff --git a/bundle.c b/bundle.c
index efeaf6f7151..dac82e2f2d9 100644
--- a/bundle.c
+++ b/bundle.c
@@ -16,6 +16,7 @@
 #include "strvec.h"
 #include "list-objects-filter-options.h"
 #include "connected.h"
+#include "write-or-die.h"
 
 static const char v2_bundle_signature[] = "# v2 git bundle\n";
 static const char v3_bundle_signature[] = "# v3 git bundle\n";
diff --git a/cache.h b/cache.h
index bffedd240e7..c43051d7928 100644
--- a/cache.h
+++ b/cache.h
@@ -686,63 +686,6 @@ extern int verify_ce_order;
 
 extern int quote_path_fully;
 
-/*
- * These values are used to help identify parts of a repository to fsync.
- * FSYNC_COMPONENT_NONE identifies data that will not be a persistent part of the
- * repository and so shouldn't be fsynced.
- */
-enum fsync_component {
-	FSYNC_COMPONENT_NONE,
-	FSYNC_COMPONENT_LOOSE_OBJECT		= 1 << 0,
-	FSYNC_COMPONENT_PACK			= 1 << 1,
-	FSYNC_COMPONENT_PACK_METADATA		= 1 << 2,
-	FSYNC_COMPONENT_COMMIT_GRAPH		= 1 << 3,
-	FSYNC_COMPONENT_INDEX			= 1 << 4,
-	FSYNC_COMPONENT_REFERENCE		= 1 << 5,
-};
-
-#define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
-				  FSYNC_COMPONENT_PACK)
-
-#define FSYNC_COMPONENTS_DERIVED_METADATA (FSYNC_COMPONENT_PACK_METADATA | \
-					   FSYNC_COMPONENT_COMMIT_GRAPH)
-
-#define FSYNC_COMPONENTS_DEFAULT ((FSYNC_COMPONENTS_OBJECTS | \
-				   FSYNC_COMPONENTS_DERIVED_METADATA) & \
-				  ~FSYNC_COMPONENT_LOOSE_OBJECT)
-
-#define FSYNC_COMPONENTS_COMMITTED (FSYNC_COMPONENTS_OBJECTS | \
-				    FSYNC_COMPONENT_REFERENCE)
-
-#define FSYNC_COMPONENTS_ADDED (FSYNC_COMPONENTS_COMMITTED | \
-				FSYNC_COMPONENT_INDEX)
-
-#define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
-			      FSYNC_COMPONENT_PACK | \
-			      FSYNC_COMPONENT_PACK_METADATA | \
-			      FSYNC_COMPONENT_COMMIT_GRAPH | \
-			      FSYNC_COMPONENT_INDEX | \
-			      FSYNC_COMPONENT_REFERENCE)
-
-#ifndef FSYNC_COMPONENTS_PLATFORM_DEFAULT
-#define FSYNC_COMPONENTS_PLATFORM_DEFAULT FSYNC_COMPONENTS_DEFAULT
-#endif
-
-/*
- * A bitmask indicating which components of the repo should be fsynced.
- */
-extern enum fsync_component fsync_components;
-extern int fsync_object_files;
-extern int use_fsync;
-
-enum fsync_method {
-	FSYNC_METHOD_FSYNC,
-	FSYNC_METHOD_WRITEOUT_ONLY,
-	FSYNC_METHOD_BATCH,
-};
-
-extern enum fsync_method fsync_method;
-
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
 #define OWNER_CHANGED	0x0004
@@ -1045,29 +988,12 @@ int update_server_info(int);
 extern const char *git_mailmap_file;
 extern const char *git_mailmap_blob;
 
-/* IO helper functions */
-void maybe_flush_or_die(FILE *, const char *);
-__attribute__((format (printf, 2, 3)))
-void fprintf_or_die(FILE *, const char *fmt, ...);
-void fwrite_or_die(FILE *f, const void *buf, size_t count);
-void fflush_or_die(FILE *f);
-
 #define COPY_READ_ERROR (-2)
 #define COPY_WRITE_ERROR (-3)
 int copy_fd(int ifd, int ofd);
 int copy_file(const char *dst, const char *src, int mode);
 int copy_file_with_time(const char *dst, const char *src, int mode);
 
-void write_or_die(int fd, const void *buf, size_t count);
-void fsync_or_die(int fd, const char *);
-int fsync_component(enum fsync_component component, int fd);
-void fsync_component_or_die(enum fsync_component component, int fd, const char *msg);
-
-static inline int batch_fsync_enabled(enum fsync_component component)
-{
-	return (fsync_components & component) && (fsync_method == FSYNC_METHOD_BATCH);
-}
-
 /* pager.c */
 void setup_pager(void);
 int pager_in_use(void);
diff --git a/config.c b/config.c
index 03a4fcaba5b..5ad9ae91436 100644
--- a/config.c
+++ b/config.c
@@ -30,6 +30,7 @@
 #include "setup.h"
 #include "worktree.h"
 #include "wrapper.h"
+#include "write-or-die.h"
 
 struct config_source {
 	struct config_source *prev;
diff --git a/csum-file.h b/csum-file.h
index 793a59da12b..4cd9014e367 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -3,6 +3,7 @@
 
 #include "cache.h"
 #include "hash.h"
+#include "write-or-die.h"
 
 struct progress;
 
diff --git a/diagnose.c b/diagnose.c
index 169a55407fd..f9a2496c7ff 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -9,6 +9,7 @@
 #include "strvec.h"
 #include "object-store.h"
 #include "packfile.h"
+#include "write-or-die.h"
 
 struct archive_dir {
 	const char *path;
diff --git a/environment.c b/environment.c
index 649d16ac27c..63c697e7e97 100644
--- a/environment.c
+++ b/environment.c
@@ -25,6 +25,7 @@
 #include "setup.h"
 #include "shallow.h"
 #include "wrapper.h"
+#include "write-or-die.h"
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
diff --git a/http-backend.c b/http-backend.c
index 042ccf12e8c..89aad1b42c7 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -18,6 +18,7 @@
 #include "protocol.h"
 #include "date.h"
 #include "wrapper.h"
+#include "write-or-die.h"
 
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
diff --git a/log-tree.c b/log-tree.c
index e2bf8d6df75..ba7b885984f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -23,6 +23,7 @@
 #include "help.h"
 #include "range-diff.h"
 #include "strmap.h"
+#include "write-or-die.h"
 
 static struct decoration name_decoration = { "object names" };
 static int decoration_loaded;
diff --git a/pkt-line.c b/pkt-line.c
index 30469eb4d8d..36ae0fea4a3 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -4,6 +4,7 @@
 #include "hex.h"
 #include "run-command.h"
 #include "wrapper.h"
+#include "write-or-die.h"
 
 char packet_buffer[LARGE_PACKET_MAX];
 static const char *packet_trace_prefix = "git";
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d2b8925ebd0..e6a6971381e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -17,6 +17,7 @@
 #include "../setup.h"
 #include "../worktree.h"
 #include "../wrapper.h"
+#include "../write-or-die.h"
 
 /*
  * This backend uses the following flags in `ref_update::flags` for
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3334c07003c..1eba1015dd5 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -9,6 +9,7 @@
 #include "../iterator.h"
 #include "../lockfile.h"
 #include "../chdir-notify.h"
+#include "../write-or-die.h"
 
 enum mmap_strategy {
 	/*
diff --git a/remote-curl.c b/remote-curl.c
index 260ea200bb0..0f2410da8e7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -22,6 +22,7 @@
 #include "protocol.h"
 #include "quote.h"
 #include "transport.h"
+#include "write-or-die.h"
 
 static struct remote *remote;
 /* always ends with a trailing slash */
diff --git a/send-pack.c b/send-pack.c
index f531cb48212..11f41a8d81e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -16,8 +16,9 @@
 #include "version.h"
 #include "oid-array.h"
 #include "gpg-interface.h"
-#include "cache.h"
 #include "shallow.h"
+#include "trace2.h"
+#include "write-or-die.h"
 
 int option_parse_push_signed(const struct option *opt,
 			     const char *arg, int unset)
diff --git a/sideband.c b/sideband.c
index 4905cf9b32a..0af582858bf 100644
--- a/sideband.c
+++ b/sideband.c
@@ -5,6 +5,7 @@
 #include "sideband.h"
 #include "help.h"
 #include "pkt-line.h"
+#include "write-or-die.h"
 
 struct keyword_entry {
 	/*
diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index c5e052e5378..f4d134a1452 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -1,6 +1,7 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "test-tool.h"
 #include "pkt-line.h"
+#include "write-or-die.h"
 
 static void pack_line(const char *line)
 {
diff --git a/upload-pack.c b/upload-pack.c
index 1155f795382..eb3d0b3fa36 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -30,6 +30,7 @@
 #include "commit-graph.h"
 #include "commit-reach.h"
 #include "shallow.h"
+#include "write-or-die.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
diff --git a/write-or-die.c b/write-or-die.c
index a7afc303db2..cc9e0787a1d 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -1,7 +1,8 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "run-command.h"
 #include "wrapper.h"
+#include "write-or-die.h"
 
 /*
  * Some cases use stdio, but want to flush after the write
diff --git a/write-or-die.h b/write-or-die.h
new file mode 100644
index 00000000000..65a5c42a47a
--- /dev/null
+++ b/write-or-die.h
@@ -0,0 +1,78 @@
+#ifndef WRITE_OR_DIE_H
+#define WRITE_OR_DIE_H
+
+void maybe_flush_or_die(FILE *, const char *);
+__attribute__((format (printf, 2, 3)))
+void fprintf_or_die(FILE *, const char *fmt, ...);
+void fwrite_or_die(FILE *f, const void *buf, size_t count);
+void fflush_or_die(FILE *f);
+void write_or_die(int fd, const void *buf, size_t count);
+
+/*
+ * These values are used to help identify parts of a repository to fsync.
+ * FSYNC_COMPONENT_NONE identifies data that will not be a persistent part of the
+ * repository and so shouldn't be fsynced.
+ */
+enum fsync_component {
+	FSYNC_COMPONENT_NONE,
+	FSYNC_COMPONENT_LOOSE_OBJECT		= 1 << 0,
+	FSYNC_COMPONENT_PACK			= 1 << 1,
+	FSYNC_COMPONENT_PACK_METADATA		= 1 << 2,
+	FSYNC_COMPONENT_COMMIT_GRAPH		= 1 << 3,
+	FSYNC_COMPONENT_INDEX			= 1 << 4,
+	FSYNC_COMPONENT_REFERENCE		= 1 << 5,
+};
+
+#define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
+				  FSYNC_COMPONENT_PACK)
+
+#define FSYNC_COMPONENTS_DERIVED_METADATA (FSYNC_COMPONENT_PACK_METADATA | \
+					   FSYNC_COMPONENT_COMMIT_GRAPH)
+
+#define FSYNC_COMPONENTS_DEFAULT ((FSYNC_COMPONENTS_OBJECTS | \
+				   FSYNC_COMPONENTS_DERIVED_METADATA) & \
+				  ~FSYNC_COMPONENT_LOOSE_OBJECT)
+
+#define FSYNC_COMPONENTS_COMMITTED (FSYNC_COMPONENTS_OBJECTS | \
+				    FSYNC_COMPONENT_REFERENCE)
+
+#define FSYNC_COMPONENTS_ADDED (FSYNC_COMPONENTS_COMMITTED | \
+				FSYNC_COMPONENT_INDEX)
+
+#define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
+			      FSYNC_COMPONENT_PACK | \
+			      FSYNC_COMPONENT_PACK_METADATA | \
+			      FSYNC_COMPONENT_COMMIT_GRAPH | \
+			      FSYNC_COMPONENT_INDEX | \
+			      FSYNC_COMPONENT_REFERENCE)
+
+#ifndef FSYNC_COMPONENTS_PLATFORM_DEFAULT
+#define FSYNC_COMPONENTS_PLATFORM_DEFAULT FSYNC_COMPONENTS_DEFAULT
+#endif
+
+/* IO helper functions */
+void fsync_or_die(int fd, const char *);
+int fsync_component(enum fsync_component component, int fd);
+void fsync_component_or_die(enum fsync_component component, int fd, const char *msg);
+
+/*
+ * A bitmask indicating which components of the repo should be fsynced.
+ */
+extern enum fsync_component fsync_components;
+extern int fsync_object_files;
+extern int use_fsync;
+
+enum fsync_method {
+	FSYNC_METHOD_FSYNC,
+	FSYNC_METHOD_WRITEOUT_ONLY,
+	FSYNC_METHOD_BATCH,
+};
+
+extern enum fsync_method fsync_method;
+
+static inline int batch_fsync_enabled(enum fsync_component component)
+{
+	return (fsync_components & component) && (fsync_method == FSYNC_METHOD_BATCH);
+}
+
+#endif /* WRITE_OR_DIE_H */
-- 
gitgitgadget

