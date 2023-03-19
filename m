Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C627CC6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCSG2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCSG2U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:28:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F31B2D0
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p16so5577009wmq.5
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679207294;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aL+JRPXPgP8w/g/8ROoSrytrumFSDpJSo9o55es+Rg=;
        b=S17UNy5F7GxuxW00CqbVE/afiugIfRIh1PgH0gBPAuLby+DbMLET/b2o9g/pH68qRU
         nEQp0NGt+ITrZ2gCYN1cFUI5/HfGWpcP0Neub81FoHcC0nCLCByKx0TmIsVTfnh6UMmJ
         z1uqyzoCTMcRBnR3h1iFZ1eJJ6WMbE1Z/WEGTycf1nW1cJ4r0CSnkhxlH9nFzhrQS2bg
         E8P8mDfiTTvXa/3RFfWPk5Pu0N+8uEJtY88i/a86P4UafCczRhEIBi1mEqMcIYD+9/lE
         713UA/OkxA98SR4GEusBvI5n0buInyawkHuTiUv1HjL7t25CckjX9WsnrQ6DTKzn3K0P
         JP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679207294;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aL+JRPXPgP8w/g/8ROoSrytrumFSDpJSo9o55es+Rg=;
        b=G6OBFI66RziC7Riu/+KExZ9lO/ScTFXKa71BbDvElftMJrImyDJ9sL7ceA+jzKONFZ
         R0iV3wKfAuA82BEff28W5W/ZrVBJimzKBZXzMH6d82GAT3MbluG5cj3H1tzsA3WiCdIs
         a0WDVV6t3LhAEJYrM2FzlzfT2NtWp88OKGnf6aiT1avJSft0PinHAF4CvxlV0GVrBcU9
         p1xgeg3YSCFdCe6bpWMUxk6cghnEgxOJnI97sXxnztMBd3O269+Hh72jvktwTeFjjjAQ
         pxlKIxNYj8RLLZw61d+2dN6rIwJ1Ichj4kbnXsJu1kQ9CDV4BUN3owiBKg3+cmjwWfKX
         018g==
X-Gm-Message-State: AO0yUKWLDhHNpX6vV1Gm5gJa8N9JYmHzVZ0IYo5DLHQ+G6a2jakETu0S
        tKOwYObQwycm5CqaLnXz4/szQ7/+Fl8=
X-Google-Smtp-Source: AK7set8w1nz7GV4BZpwscVdRuJZoUb4QnhsvwXvmCuxNhJgzncw4BXGC3HLngYI4zEllfAAMnp/BhA==
X-Received: by 2002:a05:600c:a41:b0:3eb:9822:f0 with SMTP id c1-20020a05600c0a4100b003eb982200f0mr30511333wmq.30.1679207293753;
        Sat, 18 Mar 2023 23:28:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c468900b003ed5909aab2sm9341983wmo.25.2023.03.18.23.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:28:13 -0700 (PDT)
Message-Id: <66f06731cab2aed5f121fb0f43bc8f0f00984cb8.1679207284.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 06:27:55 +0000
Subject: [PATCH 09/16] wrapper.h: move declarations for wrapper.c functions
 from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 apply.c                          |  1 +
 builtin/am.c                     |  1 +
 builtin/bisect.c                 |  1 +
 builtin/branch.c                 |  1 +
 builtin/bugreport.c              |  2 +-
 builtin/config.c                 |  1 +
 builtin/credential-cache.c       |  1 +
 builtin/difftool.c               |  1 +
 builtin/fast-import.c            |  1 +
 builtin/fmt-merge-msg.c          |  1 +
 builtin/gc.c                     |  1 +
 builtin/get-tar-commit-id.c      |  1 +
 builtin/index-pack.c             |  1 +
 builtin/init-db.c                |  1 +
 builtin/merge.c                  |  1 +
 builtin/pack-objects.c           |  1 +
 builtin/rebase.c                 |  1 +
 builtin/receive-pack.c           |  1 +
 builtin/rerere.c                 |  1 +
 builtin/unpack-file.c            |  1 +
 builtin/worktree.c               |  1 +
 cache.h                          | 32 ----------------------------
 commit-graph.c                   |  1 +
 compat/mingw.c                   |  1 +
 compat/terminal.c                |  1 +
 config.c                         |  1 +
 convert.c                        |  1 +
 copy.c                           |  1 +
 csum-file.c                      |  1 +
 daemon.c                         |  1 +
 diff.c                           |  1 +
 dir.c                            |  1 +
 entry.c                          |  1 +
 environment.c                    |  1 +
 fetch-pack.c                     |  1 +
 gpg-interface.c                  |  1 +
 http-backend.c                   |  1 +
 imap-send.c                      |  1 +
 ll-merge.c                       |  1 +
 merge-recursive.c                |  1 +
 notes-merge.c                    |  1 +
 object-file.c                    |  1 +
 packfile.c                       |  1 +
 parallel-checkout.c              |  1 +
 pkt-line.c                       |  1 +
 read-cache.c                     |  1 +
 rebase-interactive.c             |  1 +
 refs.c                           |  1 +
 refs/files-backend.c             |  3 ++-
 rerere.c                         |  1 +
 sequencer.c                      |  1 +
 server-info.c                    |  1 +
 shallow.c                        |  1 +
 strbuf.c                         |  1 +
 streaming.c                      |  1 +
 t/helper/test-delta.c            |  1 +
 t/helper/test-fsmonitor-client.c |  1 +
 t/helper/test-read-cache.c       |  1 +
 tag.c                            |  1 +
 tempfile.c                       |  1 +
 trace.c                          |  1 +
 transport-helper.c               |  1 +
 transport.c                      |  1 +
 usage.c                          |  1 +
 worktree.c                       |  1 +
 wrapper.c                        |  1 +
 wrapper.h                        | 36 ++++++++++++++++++++++++++++++++
 write-or-die.c                   |  1 +
 68 files changed, 103 insertions(+), 34 deletions(-)
 create mode 100644 wrapper.h

diff --git a/apply.c b/apply.c
index e5e11b85793..373565a7baf 100644
--- a/apply.c
+++ b/apply.c
@@ -26,6 +26,7 @@
 #include "rerere.h"
 #include "apply.h"
 #include "entry.h"
+#include "wrapper.h"
 
 struct gitdiff_data {
 	struct strbuf *root;
diff --git a/builtin/am.c b/builtin/am.c
index 14347ecf9aa..37f82b3eb42 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -38,6 +38,7 @@
 #include "packfile.h"
 #include "repository.h"
 #include "pretty.h"
+#include "wrapper.h"
 
 /**
  * Returns the length of the first line of msg.
diff --git a/builtin/bisect.c b/builtin/bisect.c
index c2e614c2890..2db46b04c97 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -11,6 +11,7 @@
 #include "prompt.h"
 #include "quote.h"
 #include "revision.h"
+#include "wrapper.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
diff --git a/builtin/branch.c b/builtin/branch.c
index 56dbee97d20..98475ea5325 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -26,6 +26,7 @@
 #include "worktree.h"
 #include "help.h"
 #include "commit-reach.h"
+#include "wrapper.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index b5dfad4e12a..160590e4ef6 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -8,7 +8,7 @@
 #include "hook.h"
 #include "hook-list.h"
 #include "diagnose.h"
-
+#include "wrapper.h"
 
 static void get_system_info(struct strbuf *sys_info)
 {
diff --git a/builtin/config.c b/builtin/config.c
index 42e6b8d3481..1c1e006ff3f 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -9,6 +9,7 @@
 #include "urlmatch.h"
 #include "quote.h"
 #include "worktree.h"
+#include "wrapper.h"
 
 static const char *const builtin_config_usage[] = {
 	N_("git config [<options>]"),
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 25f2f71c216..af56a44923d 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "wrapper.h"
 
 #ifndef NO_UNIX_SOCKETS
 
diff --git a/builtin/difftool.c b/builtin/difftool.c
index ed06db12085..59465c39f1d 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -27,6 +27,7 @@
 #include "object-store.h"
 #include "dir.h"
 #include "entry.h"
+#include "wrapper.h"
 
 static int trust_exit_code;
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 7307c4657f2..3300b7f30f0 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -23,6 +23,7 @@
 #include "commit-reach.h"
 #include "khash.h"
 #include "date.h"
+#include "wrapper.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 0f9855b680e..cc812416420 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -3,6 +3,7 @@
 #include "fmt-merge-msg.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "wrapper.h"
 
 static const char * const fmt_merge_msg_usage[] = {
 	N_("git fmt-merge-msg [-m <message>] [--log[=<n>] | --no-log] [--file <file>]"),
diff --git a/builtin/gc.c b/builtin/gc.c
index ef063fc828c..2107e3d1f2c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -35,6 +35,7 @@
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "hook.h"
+#include "wrapper.h"
 
 #define FAILED_RUN "failed to run %s"
 
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 491af9202dc..67457969986 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -6,6 +6,7 @@
 #include "tar.h"
 #include "builtin.h"
 #include "quote.h"
+#include "wrapper.h"
 
 static const char builtin_get_tar_commit_id_usage[] =
 "git get-tar-commit-id";
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bae5b054039..2393897cb88 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -19,6 +19,7 @@
 #include "object-store.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
+#include "wrapper.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6f724f694f4..a5d4f5c8ece 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -12,6 +12,7 @@
 #include "exec-cmd.h"
 #include "parse-options.h"
 #include "worktree.h"
+#include "wrapper.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
diff --git a/builtin/merge.c b/builtin/merge.c
index 38243e55c5f..f4f4a220f30 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -49,6 +49,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "wrapper.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ca800c7c50..8b55a088a7c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -40,6 +40,7 @@
 #include "shallow.h"
 #include "promisor-remote.h"
 #include "pack-mtimes.h"
+#include "wrapper.h"
 
 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index a3f8be88882..d2f8f703d67 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -32,6 +32,7 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "hook.h"
+#include "wrapper.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] "
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5fab0aed533..e954c85ce3d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -33,6 +33,7 @@
 #include "commit-reach.h"
 #include "worktree.h"
 #include "shallow.h"
+#include "wrapper.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 24c78755723..d4a03707b1a 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -6,6 +6,7 @@
 #include "parse-options.h"
 #include "string-list.h"
 #include "rerere.h"
+#include "wrapper.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 #include "pathspec.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index e9b105a5397..4cbb4039293 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "hex.h"
 #include "object-store.h"
+#include "wrapper.h"
 
 static char *create_temp_file(struct object_id *oid)
 {
diff --git a/builtin/worktree.c b/builtin/worktree.c
index ed614ffddcb..1533b4ab43c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -16,6 +16,7 @@
 #include "submodule.h"
 #include "utf8.h"
 #include "worktree.h"
+#include "wrapper.h"
 #include "quote.h"
 
 #define BUILTIN_WORKTREE_ADD_USAGE \
diff --git a/cache.h b/cache.h
index 705c41992bc..31c722533f9 100644
--- a/cache.h
+++ b/cache.h
@@ -1085,10 +1085,6 @@ const char *repo_find_unique_abbrev(struct repository *r, const struct object_id
 int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
 #define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(the_repository, hex, oid, len)
 
-/* set default permissions by passing mode arguments to open(2) */
-int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
-int git_mkstemp_mode(char *pattern, int mode);
-
 /*
  * NOTE NOTE NOTE!!
  *
@@ -1423,31 +1419,6 @@ static inline int batch_fsync_enabled(enum fsync_component component)
 	return (fsync_components & component) && (fsync_method == FSYNC_METHOD_BATCH);
 }
 
-ssize_t read_in_full(int fd, void *buf, size_t count);
-ssize_t write_in_full(int fd, const void *buf, size_t count);
-ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
-
-static inline ssize_t write_str_in_full(int fd, const char *str)
-{
-	return write_in_full(fd, str, strlen(str));
-}
-
-/**
- * Open (and truncate) the file at path, write the contents of buf to it,
- * and close it. Dies if any errors are encountered.
- */
-void write_file_buf(const char *path, const char *buf, size_t len);
-
-/**
- * Like write_file_buf(), but format the contents into a buffer first.
- * Additionally, write_file() will append a newline if one is not already
- * present, making it convenient to write text files:
- *
- *   write_file(path, "counter: %d", ctr);
- */
-__attribute__((format (printf, 2, 3)))
-void write_file(const char *path, const char *fmt, ...);
-
 /* pager.c */
 void setup_pager(void);
 int pager_in_use(void);
@@ -1571,7 +1542,4 @@ int versioncmp(const char *s1, const char *s2);
  */
 int print_sha1_ellipsis(void);
 
-/* Return 1 if the file is empty or does not exists, 0 otherwise. */
-int is_empty_or_missing_file(const char *filename);
-
 #endif /* CACHE_H */
diff --git a/commit-graph.c b/commit-graph.c
index 8f21a0a0c20..5481736c76c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -22,6 +22,7 @@
 #include "json-writer.h"
 #include "trace2.h"
 #include "chunk-format.h"
+#include "wrapper.h"
 
 void git_test_write_commit_graph_or_die(void)
 {
diff --git a/compat/mingw.c b/compat/mingw.c
index cbcd03aea9b..d48899bf7b4 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -11,6 +11,7 @@
 #include "../alloc.h"
 #include "win32/lazyload.h"
 #include "../config.h"
+#include "../wrapper.h"
 #include "dir.h"
 #include "gettext.h"
 #define SECURITY_WIN32
diff --git a/compat/terminal.c b/compat/terminal.c
index afebe6b2496..ed2b30b38f7 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -6,6 +6,7 @@
 #include "run-command.h"
 #include "string-list.h"
 #include "hashmap.h"
+#include "wrapper.h"
 
 #if defined(HAVE_DEV_TTY) || defined(GIT_WINDOWS_NATIVE)
 
diff --git a/config.c b/config.c
index 6815919ec30..5b1a5d52052 100644
--- a/config.c
+++ b/config.c
@@ -28,6 +28,7 @@
 #include "replace-object.h"
 #include "refs.h"
 #include "worktree.h"
+#include "wrapper.h"
 
 struct config_source {
 	struct config_source *prev;
diff --git a/convert.c b/convert.c
index 2bd54244b55..da06e2f51cb 100644
--- a/convert.c
+++ b/convert.c
@@ -11,6 +11,7 @@
 #include "sub-process.h"
 #include "utf8.h"
 #include "ll-merge.h"
+#include "wrapper.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
diff --git a/copy.c b/copy.c
index 4de6a110f09..c3250f08221 100644
--- a/copy.c
+++ b/copy.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "wrapper.h"
 
 int copy_fd(int ifd, int ofd)
 {
diff --git a/csum-file.c b/csum-file.c
index cce13c0f047..2d22f80d901 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "progress.h"
 #include "csum-file.h"
+#include "wrapper.h"
 
 static void verify_buffer_or_die(struct hashfile *f,
 				 const void *buf,
diff --git a/daemon.c b/daemon.c
index bb795ca3ca9..e35604e194c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -6,6 +6,7 @@
 #include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "wrapper.h"
 
 #ifdef NO_INITGROUPS
 #define initgroups(x, y) (0) /* nothing */
diff --git a/diff.c b/diff.c
index 1b0be99c065..1b0b24c21c3 100644
--- a/diff.c
+++ b/diff.c
@@ -33,6 +33,7 @@
 #include "promisor-remote.h"
 #include "dir.h"
 #include "strmap.h"
+#include "wrapper.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
diff --git a/dir.c b/dir.c
index c72481c60ee..b57c770e68b 100644
--- a/dir.c
+++ b/dir.c
@@ -21,6 +21,7 @@
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
 #include "submodule-config.h"
+#include "wrapper.h"
 
 /*
  * Tells read_directory_recursive how a file or directory should be treated.
diff --git a/entry.c b/entry.c
index acb76a61aca..70212af260b 100644
--- a/entry.c
+++ b/entry.c
@@ -10,6 +10,7 @@
 #include "fsmonitor.h"
 #include "entry.h"
 #include "parallel-checkout.h"
+#include "wrapper.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
diff --git a/environment.c b/environment.c
index c69571f0b29..bf02f3cf487 100644
--- a/environment.c
+++ b/environment.c
@@ -23,6 +23,7 @@
 #include "tmp-objdir.h"
 #include "chdir-notify.h"
 #include "shallow.h"
+#include "wrapper.h"
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
diff --git a/fetch-pack.c b/fetch-pack.c
index 359dce6afed..c1190801405 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -30,6 +30,7 @@
 #include "commit-graph.h"
 #include "sigchain.h"
 #include "mergesort.h"
+#include "wrapper.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
diff --git a/gpg-interface.c b/gpg-interface.c
index f9c5b6c3f53..6644701fda0 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -10,6 +10,7 @@
 #include "sigchain.h"
 #include "tempfile.h"
 #include "alias.h"
+#include "wrapper.h"
 
 static int git_gpg_config(const char *, const char *, void *);
 
diff --git a/http-backend.c b/http-backend.c
index 7e7c19e66b3..42e6c2596e9 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -16,6 +16,7 @@
 #include "object-store.h"
 #include "protocol.h"
 #include "date.h"
+#include "wrapper.h"
 
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
diff --git a/imap-send.c b/imap-send.c
index c65a27219c6..aa5b2f252d2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -28,6 +28,7 @@
 #include "gettext.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "wrapper.h"
 #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
 typedef void *SSL;
 #endif
diff --git a/ll-merge.c b/ll-merge.c
index 130d26501c6..8be38d3bd41 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -11,6 +11,7 @@
 #include "run-command.h"
 #include "ll-merge.h"
 #include "quote.h"
+#include "wrapper.h"
 
 struct ll_merge_driver;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 0b0255ebc80..f918cea4c69 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -30,6 +30,7 @@
 #include "tag.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
+#include "wrapper.h"
 #include "xdiff-interface.h"
 
 struct merge_options_internal {
diff --git a/notes-merge.c b/notes-merge.c
index c8d0020b1a2..ba2970f0702 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -15,6 +15,7 @@
 #include "strbuf.h"
 #include "notes-utils.h"
 #include "commit-reach.h"
+#include "wrapper.h"
 
 struct notes_merge_pair {
 	struct object_id obj, base, local, remote;
diff --git a/object-file.c b/object-file.c
index bee41b30474..bdf68763a50 100644
--- a/object-file.c
+++ b/object-file.c
@@ -38,6 +38,7 @@
 #include "promisor-remote.h"
 #include "submodule.h"
 #include "fsck.h"
+#include "wrapper.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
diff --git a/packfile.c b/packfile.c
index b1718b93d4b..0fe844f2075 100644
--- a/packfile.c
+++ b/packfile.c
@@ -20,6 +20,7 @@
 #include "midx.h"
 #include "commit-graph.h"
 #include "promisor-remote.h"
+#include "wrapper.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *hash,
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 38c4dc665d5..50fd7fe31ef 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -12,6 +12,7 @@
 #include "streaming.h"
 #include "thread-utils.h"
 #include "trace2.h"
+#include "wrapper.h"
 
 struct pc_worker {
 	struct child_process cp;
diff --git a/pkt-line.c b/pkt-line.c
index c8b90b2242e..30469eb4d8d 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "run-command.h"
+#include "wrapper.h"
 
 char packet_buffer[LARGE_PACKET_MAX];
 static const char *packet_trace_prefix = "git";
diff --git a/read-cache.c b/read-cache.c
index 63789ea5e21..9a8d5fe97ed 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -32,6 +32,7 @@
 #include "csum-file.h"
 #include "promisor-remote.h"
 #include "hook.h"
+#include "wrapper.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 649c94e69a6..7c885c35bfd 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -7,6 +7,7 @@
 #include "commit-slab.h"
 #include "config.h"
 #include "dir.h"
+#include "wrapper.h"
 
 static const char edit_todo_list_advice[] =
 N_("You can fix this with 'git rebase --edit-todo' "
diff --git a/refs.c b/refs.c
index 8684f4610f5..385051752f1 100644
--- a/refs.c
+++ b/refs.c
@@ -24,6 +24,7 @@
 #include "sigchain.h"
 #include "date.h"
 #include "commit.h"
+#include "wrapper.h"
 
 /*
  * List of all available backends
diff --git a/refs/files-backend.c b/refs/files-backend.c
index de3628ff3f1..eb14d124e3f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -13,7 +13,8 @@
 #include "../object.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
-#include "worktree.h"
+#include "../worktree.h"
+#include "../wrapper.h"
 
 /*
  * This backend uses the following flags in `ref_update::flags` for
diff --git a/rerere.c b/rerere.c
index c3258e13902..b5ccbecdcd2 100644
--- a/rerere.c
+++ b/rerere.c
@@ -16,6 +16,7 @@
 #include "object-store.h"
 #include "hash-lookup.h"
 #include "strmap.h"
+#include "wrapper.h"
 
 #define RESOLVED 0
 #define PUNTED 1
diff --git a/sequencer.c b/sequencer.c
index f5fe0df2689..c1ff319cfc1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -41,6 +41,7 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "branch.h"
+#include "wrapper.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
diff --git a/server-info.c b/server-info.c
index 78643377057..ae96d784e53 100644
--- a/server-info.c
+++ b/server-info.c
@@ -10,6 +10,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "strbuf.h"
+#include "wrapper.h"
 
 struct update_info_ctx {
 	FILE *cur_fp;
diff --git a/shallow.c b/shallow.c
index c5433a4fd30..7fcba5f6d06 100644
--- a/shallow.c
+++ b/shallow.c
@@ -17,6 +17,7 @@
 #include "list-objects.h"
 #include "commit-reach.h"
 #include "shallow.h"
+#include "wrapper.h"
 
 void set_alternate_shallow_file(struct repository *r, const char *path, int override)
 {
diff --git a/strbuf.c b/strbuf.c
index 9633e37b62f..70a83e7980e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -8,6 +8,7 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "date.h"
+#include "wrapper.h"
 
 int starts_with(const char *str, const char *prefix)
 {
diff --git a/streaming.c b/streaming.c
index 27841dc1d9e..6c69f595045 100644
--- a/streaming.c
+++ b/streaming.c
@@ -7,6 +7,7 @@
 #include "object-store.h"
 #include "replace-object.h"
 #include "packfile.h"
+#include "wrapper.h"
 
 typedef int (*open_istream_fn)(struct git_istream *,
 			       struct repository *,
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index b15481ea596..6609fcbc12e 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -12,6 +12,7 @@
 #include "git-compat-util.h"
 #include "delta.h"
 #include "cache.h"
+#include "wrapper.h"
 
 static const char usage_str[] =
 	"test-tool delta (-d|-p) <from_file> <data_file> <out_file>";
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index 54a4856c48c..c43fc976b82 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -9,6 +9,7 @@
 #include "fsmonitor-ipc.h"
 #include "thread-utils.h"
 #include "trace2.h"
+#include "wrapper.h"
 
 #ifndef HAVE_FSMONITOR_DAEMON_BACKEND
 int cmd__fsmonitor_client(int argc, const char **argv)
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 23e9e27109f..84818363d5b 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "config.h"
+#include "wrapper.h"
 
 int cmd__read_cache(int argc, const char **argv)
 {
diff --git a/tag.c b/tag.c
index 18b718cca66..3408bb9433f 100644
--- a/tag.c
+++ b/tag.c
@@ -8,6 +8,7 @@
 #include "gpg-interface.h"
 #include "hex.h"
 #include "packfile.h"
+#include "wrapper.h"
 
 const char *tag_type = "tag";
 
diff --git a/tempfile.c b/tempfile.c
index e27048f970b..cdd2cab3bad 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -45,6 +45,7 @@
 #include "cache.h"
 #include "tempfile.h"
 #include "sigchain.h"
+#include "wrapper.h"
 
 static VOLATILE_LIST_HEAD(tempfile_list);
 
diff --git a/trace.c b/trace.c
index 2b41c683fc8..de004f62988 100644
--- a/trace.c
+++ b/trace.c
@@ -24,6 +24,7 @@
 #include "cache.h"
 #include "abspath.h"
 #include "quote.h"
+#include "wrapper.h"
 
 struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
 struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
diff --git a/transport-helper.c b/transport-helper.c
index 105bb801c21..09048eab484 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -16,6 +16,7 @@
 #include "refspec.h"
 #include "transport-internal.h"
 #include "protocol.h"
+#include "wrapper.h"
 
 static int debug;
 
diff --git a/transport.c b/transport.c
index 80059124c0a..c6179b801e8 100644
--- a/transport.c
+++ b/transport.c
@@ -26,6 +26,7 @@
 #include "object-store.h"
 #include "color.h"
 #include "bundle-uri.h"
+#include "wrapper.h"
 
 static int transport_use_color = -1;
 static char transport_colors[][COLOR_MAXLEN] = {
diff --git a/usage.c b/usage.c
index 40a1c5a4339..b53c99dbe5b 100644
--- a/usage.c
+++ b/usage.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "gettext.h"
+#include "wrapper.h"
 
 static void vreportf(const char *prefix, const char *err, va_list params)
 {
diff --git a/worktree.c b/worktree.c
index d87141f694e..64c96605e53 100644
--- a/worktree.c
+++ b/worktree.c
@@ -9,6 +9,7 @@
 #include "dir.h"
 #include "wt-status.h"
 #include "config.h"
+#include "wrapper.h"
 
 void free_worktrees(struct worktree **worktrees)
 {
diff --git a/wrapper.c b/wrapper.c
index df1fa6286d0..ee837575902 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -5,6 +5,7 @@
 #include "abspath.h"
 #include "config.h"
 #include "gettext.h"
+#include "wrapper.h"
 
 static intmax_t count_fsync_writeout_only;
 static intmax_t count_fsync_hardware_flush;
diff --git a/wrapper.h b/wrapper.h
new file mode 100644
index 00000000000..f0c7d0616d6
--- /dev/null
+++ b/wrapper.h
@@ -0,0 +1,36 @@
+#ifndef WRAPPER_H
+#define WRAPPER_H
+
+/* set default permissions by passing mode arguments to open(2) */
+int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
+int git_mkstemp_mode(char *pattern, int mode);
+
+ssize_t read_in_full(int fd, void *buf, size_t count);
+ssize_t write_in_full(int fd, const void *buf, size_t count);
+ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
+
+static inline ssize_t write_str_in_full(int fd, const char *str)
+{
+	return write_in_full(fd, str, strlen(str));
+}
+
+/**
+ * Open (and truncate) the file at path, write the contents of buf to it,
+ * and close it. Dies if any errors are encountered.
+ */
+void write_file_buf(const char *path, const char *buf, size_t len);
+
+/**
+ * Like write_file_buf(), but format the contents into a buffer first.
+ * Additionally, write_file() will append a newline if one is not already
+ * present, making it convenient to write text files:
+ *
+ *   write_file(path, "counter: %d", ctr);
+ */
+__attribute__((format (printf, 2, 3)))
+void write_file(const char *path, const char *fmt, ...);
+
+/* Return 1 if the file is empty or does not exists, 0 otherwise. */
+int is_empty_or_missing_file(const char *filename);
+
+#endif /* WRAPPER_H */
diff --git a/write-or-die.c b/write-or-die.c
index aaa0318e824..a7afc303db2 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "run-command.h"
+#include "wrapper.h"
 
 /*
  * Some cases use stdio, but want to flush after the write
-- 
gitgitgadget

