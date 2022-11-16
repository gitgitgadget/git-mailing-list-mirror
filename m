Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2794C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 23:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiKPXXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 18:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiKPXXp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 18:23:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3215649B60
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:23:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g12so32493486wrs.10
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsP2VTFNE7ywAKYOQ/VT+mldhWLES67uQlxqgONwgL4=;
        b=pQ9bbY1suTu3hWAXDq9ZoJSBGwcLahA7AO7ywBps8Roe93f79Hjw/IYGZgMGILRoGL
         FDqiCf8Ux8nq7ku7VxchrIjyhi/Mkbac50it4ig+S47ArzI6t0fIqDDZrCblmXYi5ra/
         5MutsnOMaSusCPuAujpcrMHDHS74TOD4i4UY56OuZrhme45ZmgfqSnzyxuCy5hurpC+6
         HqRhoMKZvPkF3KJs2fojvuTmcf2KC4/ck2le6AlpLRXW37WQ178vo/2VFK7EaSXEuOzy
         ehYgcND3elyw5y4H5h7K/BFKRly6EL+6m0MmfA0bimYNIU19Gzcltjsj+Q0B+s1JIloq
         mXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsP2VTFNE7ywAKYOQ/VT+mldhWLES67uQlxqgONwgL4=;
        b=IdsSO9QVJVufsIbn2t9cx/RcIRARwFt01gi6OTuxoY3KA9o51jxiVxLOaf+7PmfBGc
         dLKTpZ94qOGveHKD/ss/+eBrQ7mu84YjthJJnmBt6iF6zGGQFJp19PTaFhxpUmI3qflp
         Rn8iTgSvxJqMmkxIha+Qh6qjc6rEpx6NDLJs1bH+bgy8sJNiMPgiHHQbcAUnpVPlnH/h
         ay+2RMlWylLcSoPzkRhsctmnQBFrmikRubbU5tKMpjW2tJBNFtIdEh3X4nzQ70nJA3ru
         k0HTlQpxc6mu8xarKwAch07l8EOa12xww/8Nwv0Z5/ejjxLP/Exul45VD1YIig6ozcwC
         /SnQ==
X-Gm-Message-State: ANoB5pkEI8KVeVWaBqk7E4Oe3/aCCaaGr5Nq2Morqy26SISbvmZ5ZiTk
        TinZ1jk152TYLIc3eWQhWB3okjzYs38=
X-Google-Smtp-Source: AA0mqf61rjUXAR3EeoDPerxMAzkcP0bpOAScZdkLWvGdFOZ5FCREp1ChuK4qvyGZnIYAafoPGxNw5A==
X-Received: by 2002:a5d:4846:0:b0:236:5aa8:a07e with SMTP id n6-20020a5d4846000000b002365aa8a07emr15561413wrs.437.1668641022499;
        Wed, 16 Nov 2022 15:23:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d458e000000b0022eafed36ebsm16184132wrq.73.2022.11.16.15.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:23:42 -0800 (PST)
Message-Id: <99d684c7bdfac9db9cbf74bae1d21f9dc20ac825.1668641019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Nov 2022 23:23:34 +0000
Subject: [PATCH v3 1/6] fsmonitor: prepare to share code between Mac OS and
 Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Linux and Mac OS can share some of the code originally developed for Mac OS.

Mac OS and Linux can share fsm-ipc-unix.c and fsm-settings-unix.c

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-health-linux.c    | 24 ++++++++++
 compat/fsmonitor/fsm-ipc-darwin.c      | 53 +---------------------
 compat/fsmonitor/fsm-ipc-linux.c       |  1 +
 compat/fsmonitor/fsm-ipc-unix.c        | 52 +++++++++++++++++++++
 compat/fsmonitor/fsm-settings-darwin.c | 63 +-------------------------
 compat/fsmonitor/fsm-settings-linux.c  |  1 +
 compat/fsmonitor/fsm-settings-unix.c   | 61 +++++++++++++++++++++++++
 7 files changed, 141 insertions(+), 114 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-unix.c
 create mode 100644 compat/fsmonitor/fsm-settings-linux.c
 create mode 100644 compat/fsmonitor/fsm-settings-unix.c

diff --git a/compat/fsmonitor/fsm-health-linux.c b/compat/fsmonitor/fsm-health-linux.c
new file mode 100644
index 00000000000..b9f709e8548
--- /dev/null
+++ b/compat/fsmonitor/fsm-health-linux.c
@@ -0,0 +1,24 @@
+#include "cache.h"
+#include "config.h"
+#include "fsmonitor.h"
+#include "fsm-health.h"
+#include "fsmonitor--daemon.h"
+
+int fsm_health__ctor(struct fsmonitor_daemon_state *state)
+{
+	return 0;
+}
+
+void fsm_health__dtor(struct fsmonitor_daemon_state *state)
+{
+	return;
+}
+
+void fsm_health__loop(struct fsmonitor_daemon_state *state)
+{
+	return;
+}
+
+void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
+{
+}
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
index d67b0ee50d3..4c3c92081ee 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -1,52 +1 @@
-#include "cache.h"
-#include "config.h"
-#include "strbuf.h"
-#include "fsmonitor.h"
-#include "fsmonitor-ipc.h"
-#include "fsmonitor-path-utils.h"
-
-static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
-
-const char *fsmonitor_ipc__get_path(struct repository *r)
-{
-	static const char *ipc_path = NULL;
-	git_SHA_CTX sha1ctx;
-	char *sock_dir = NULL;
-	struct strbuf ipc_file = STRBUF_INIT;
-	unsigned char hash[GIT_MAX_RAWSZ];
-
-	if (!r)
-		BUG("No repository passed into fsmonitor_ipc__get_path");
-
-	if (ipc_path)
-		return ipc_path;
-
-
-	/* By default the socket file is created in the .git directory */
-	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
-		ipc_path = fsmonitor_ipc__get_default_path();
-		return ipc_path;
-	}
-
-	git_SHA1_Init(&sha1ctx);
-	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
-	git_SHA1_Final(hash, &sha1ctx);
-
-	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
-
-	/* Create the socket file in either socketDir or $HOME */
-	if (sock_dir && *sock_dir) {
-		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
-					sock_dir, hash_to_hex(hash));
-	} else {
-		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
-	}
-	free(sock_dir);
-
-	ipc_path = interpolate_path(ipc_file.buf, 1);
-	if (!ipc_path)
-		die(_("Invalid path: %s"), ipc_file.buf);
-
-	strbuf_release(&ipc_file);
-	return ipc_path;
-}
+#include "fsm-ipc-unix.c"
diff --git a/compat/fsmonitor/fsm-ipc-linux.c b/compat/fsmonitor/fsm-ipc-linux.c
new file mode 100644
index 00000000000..4c3c92081ee
--- /dev/null
+++ b/compat/fsmonitor/fsm-ipc-linux.c
@@ -0,0 +1 @@
+#include "fsm-ipc-unix.c"
diff --git a/compat/fsmonitor/fsm-ipc-unix.c b/compat/fsmonitor/fsm-ipc-unix.c
new file mode 100644
index 00000000000..d67b0ee50d3
--- /dev/null
+++ b/compat/fsmonitor/fsm-ipc-unix.c
@@ -0,0 +1,52 @@
+#include "cache.h"
+#include "config.h"
+#include "strbuf.h"
+#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+#include "fsmonitor-path-utils.h"
+
+static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
+
+const char *fsmonitor_ipc__get_path(struct repository *r)
+{
+	static const char *ipc_path = NULL;
+	git_SHA_CTX sha1ctx;
+	char *sock_dir = NULL;
+	struct strbuf ipc_file = STRBUF_INIT;
+	unsigned char hash[GIT_MAX_RAWSZ];
+
+	if (!r)
+		BUG("No repository passed into fsmonitor_ipc__get_path");
+
+	if (ipc_path)
+		return ipc_path;
+
+
+	/* By default the socket file is created in the .git directory */
+	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
+		ipc_path = fsmonitor_ipc__get_default_path();
+		return ipc_path;
+	}
+
+	git_SHA1_Init(&sha1ctx);
+	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
+	git_SHA1_Final(hash, &sha1ctx);
+
+	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
+
+	/* Create the socket file in either socketDir or $HOME */
+	if (sock_dir && *sock_dir) {
+		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
+					sock_dir, hash_to_hex(hash));
+	} else {
+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
+	}
+	free(sock_dir);
+
+	ipc_path = interpolate_path(ipc_file.buf, 1);
+	if (!ipc_path)
+		die(_("Invalid path: %s"), ipc_file.buf);
+
+	strbuf_release(&ipc_file);
+	return ipc_path;
+}
diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 6abbc7af3ab..14baf9f0603 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -1,62 +1 @@
-#include "config.h"
-#include "fsmonitor.h"
-#include "fsmonitor-ipc.h"
-#include "fsmonitor-settings.h"
-#include "fsmonitor-path-utils.h"
-
- /*
- * For the builtin FSMonitor, we create the Unix domain socket for the
- * IPC in the .git directory.  If the working directory is remote,
- * then the socket will be created on the remote file system.  This
- * can fail if the remote file system does not support UDS file types
- * (e.g. smbfs to a Windows server) or if the remote kernel does not
- * allow a non-local process to bind() the socket.  (These problems
- * could be fixed by moving the UDS out of the .git directory and to a
- * well-known local directory on the client machine, but care should
- * be taken to ensure that $HOME is actually local and not a managed
- * file share.)
- *
- * FAT32 and NTFS working directories are problematic too.
- *
- * The builtin FSMonitor uses a Unix domain socket in the .git
- * directory for IPC.  These Windows drive formats do not support
- * Unix domain sockets, so mark them as incompatible for the daemon.
- *
- */
-static enum fsmonitor_reason check_uds_volume(struct repository *r)
-{
-	struct fs_info fs;
-	const char *ipc_path = fsmonitor_ipc__get_path(r);
-	struct strbuf path = STRBUF_INIT;
-	strbuf_add(&path, ipc_path, strlen(ipc_path));
-
-	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
-		strbuf_release(&path);
-		return FSMONITOR_REASON_ERROR;
-	}
-
-	strbuf_release(&path);
-
-	if (fs.is_remote ||
-		!strcmp(fs.typename, "msdos") ||
-		!strcmp(fs.typename, "ntfs")) {
-		free(fs.typename);
-		return FSMONITOR_REASON_NOSOCKETS;
-	}
-
-	free(fs.typename);
-	return FSMONITOR_REASON_OK;
-}
-
-enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
-{
-	enum fsmonitor_reason reason;
-
-	if (ipc) {
-		reason = check_uds_volume(r);
-		if (reason != FSMONITOR_REASON_OK)
-			return reason;
-	}
-
-	return FSMONITOR_REASON_OK;
-}
+#include "fsm-settings-unix.c"
diff --git a/compat/fsmonitor/fsm-settings-linux.c b/compat/fsmonitor/fsm-settings-linux.c
new file mode 100644
index 00000000000..14baf9f0603
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-linux.c
@@ -0,0 +1 @@
+#include "fsm-settings-unix.c"
diff --git a/compat/fsmonitor/fsm-settings-unix.c b/compat/fsmonitor/fsm-settings-unix.c
new file mode 100644
index 00000000000..a6ed32575a9
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-unix.c
@@ -0,0 +1,61 @@
+#include "config.h"
+#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+#include "fsmonitor-path-utils.h"
+
+ /*
+ * For the builtin FSMonitor, we create the Unix domain socket for the
+ * IPC in the .git directory.  If the working directory is remote,
+ * then the socket will be created on the remote file system.  This
+ * can fail if the remote file system does not support UDS file types
+ * (e.g. smbfs to a Windows server) or if the remote kernel does not
+ * allow a non-local process to bind() the socket.  (These problems
+ * could be fixed by moving the UDS out of the .git directory and to a
+ * well-known local directory on the client machine, but care should
+ * be taken to ensure that $HOME is actually local and not a managed
+ * file share.)
+ *
+ * FAT32 and NTFS working directories are problematic too.
+ *
+ * The builtin FSMonitor uses a Unix domain socket in the .git
+ * directory for IPC.  These Windows drive formats do not support
+ * Unix domain sockets, so mark them as incompatible for the daemon.
+ *
+ */
+static enum fsmonitor_reason check_uds_volume(struct repository *r)
+{
+	struct fs_info fs;
+	const char *ipc_path = fsmonitor_ipc__get_path(r);
+	struct strbuf path = STRBUF_INIT;
+	strbuf_addstr(&path, ipc_path);
+
+	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
+		strbuf_release(&path);
+		return FSMONITOR_REASON_ERROR;
+	}
+
+	strbuf_release(&path);
+
+	if (fs.is_remote ||
+		!strcmp(fs.typename, "msdos") ||
+		!strcmp(fs.typename, "ntfs")) {
+		free(fs.typename);
+		return FSMONITOR_REASON_NOSOCKETS;
+	}
+
+	free(fs.typename);
+	return FSMONITOR_REASON_OK;
+}
+
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
+{
+	enum fsmonitor_reason reason;
+
+	if (ipc) {
+		reason = check_uds_volume(r);
+		if (reason != FSMONITOR_REASON_OK)
+			return reason;
+	}
+
+	return FSMONITOR_REASON_OK;
+}
-- 
gitgitgadget

