Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12D0C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiLLV6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiLLV6L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:58:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7119FF9
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:58:10 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y16so13710093wrm.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QxLGIrf7ZezydGIYVxZq6+843MFS3cxN+vglb9fT4c=;
        b=V31r/u6bxkgFiFzT/xhy22lcszXwo75wUEG8T14mpaHiwryBkCQnfLfiOYSLIZmGuE
         RX/BYoy3FHK/oKpUlqRfBlYnWHdbBs+Sqlo0j+5SIKQRdVz2dHNwsamFdYby8SkgCbdI
         PJWirlgyoy1jWaJzs7RLUZ17koLIY0r//+IhzqkeEH9v6780Fnk43Ub7IegWMDMvsVoT
         lR+NErxebi4kwKqmu/vxYoPBTYcSZ0JD/SiFl50K5A8PzVuNP/kjFq65c3nRI8xwTA7P
         9j+bJRBS3qRkQc0NCh4lI2jzMF4XuQHl8lDG3E2tDi8Nzz2lLPAUxPj3xyxRvcfiyyiA
         TEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QxLGIrf7ZezydGIYVxZq6+843MFS3cxN+vglb9fT4c=;
        b=oieTFyQ71Ux+Kuchowv/LhIYBv48qS+jczX526jhk54SsKeDq4sRAD+HwS7SqWTbbZ
         365IwJCIaADemooKt1cm9+4/CjoGIlzN3RRfXnDVsZePAaI/1Ow0pMsUj6U8AixDlqaI
         HmE4ebOyvjhT31FMyTFWxun5YQUmD6k3vqhyPCTrifjn0wRUcWdTz1lNerOHAspXl+br
         woSrEX1ndArw08H8na8uyXiQc41ZQdZ9OdG9CLlheO1ZasIIhk+tdDyurpR3xpyMr9t3
         aHe74D4k5QYi5VH9T+SSyLTXvQ8MnmE9B97zbHV/Fb4TH1CpiQqKGkET0LFzEcSnCaUt
         GTvA==
X-Gm-Message-State: ANoB5pkBYr8I0V2Cq3rzkPNInDml5vXKdr3NzJJ3/mqDB844l5N4lTNM
        n/fwj3NysEgFCqvkHrGhRR+fK8W9tCw=
X-Google-Smtp-Source: AA0mqf5iwJEQ+uBaY12Aa6/x9m58Cay9V0Yqxba9o1fWgFbT8oQLWV50v5Q4Rj8I+G4hUS67uVrm0w==
X-Received: by 2002:a5d:43ca:0:b0:242:359b:415a with SMTP id v10-20020a5d43ca000000b00242359b415amr11009076wrr.69.1670882288405;
        Mon, 12 Dec 2022 13:58:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d54c9000000b00241cfa9333fsm9908739wrv.5.2022.12.12.13.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:58:08 -0800 (PST)
Message-Id: <7f659603c9ac1457ef581fb82d7fe411bdc7230f.1670882286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
        <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 21:58:00 +0000
Subject: [PATCH v5 1/6] fsmonitor: prepare to share code between Mac OS and
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
        Taylor Blau <me@ttaylorr.com>,
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
 compat/fsmonitor/fsm-settings-unix.c   | 62 +++++++++++++++++++++++++
 7 files changed, 142 insertions(+), 114 deletions(-)
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
index 00000000000..da23254be40
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-unix.c
@@ -0,0 +1,62 @@
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
+		free(fs.typename);
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

