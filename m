Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1E0C4332F
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 14:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiJIOiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiJIOhp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 10:37:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD3E2716B
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 07:37:43 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso3820737wmq.0
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIFY2Z/vJBuNXsR7F5iTNtyFHpmyCnaMLS0bQSwMfus=;
        b=USww/YSU0Nt0RWKPChu0jNGB0w6gAP6UzvPO/g9IZ+Bl6SPSludohIHeAwCX6Pjjbu
         7dOw4CyEn6W5OwMSs9xBf1fMmpgEzyfYuSXmL+RHAzjAGSItIoH78X2xf2lcdNFkKzp3
         7vbmd5AbI2jyx/0/7BPGIoCRjG93MqlxTMzOvuDEhnqYOGfkJ6FgEoJQNe3V24JTGbwe
         7th8/jtlUfC89SFmdy6Na9emcKMHPyyVxip/G9IRxRaHOtLQhgbvBO6EKLOEdjKSnzeE
         f8Dq0ynPBPfMJgqCY/Cus4lPR1lPimfN60whmwEZZHqVMhOonzBV9rumfDHXIHKSW9Sy
         v6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIFY2Z/vJBuNXsR7F5iTNtyFHpmyCnaMLS0bQSwMfus=;
        b=Cua1D+PcnV7km9ivwlvnck8vGSxeV3/zxASGNkLmSpG1drunxKSkR/0JBKnSYAM5J9
         j/lr9WOkQKVJ8r7Hxf8mS4om3u6nsgXXG7a9xbHKBU50IMlF88aqjwitEyZ8xfs8HmY/
         k94W1NR9uvq2flE9yPIJ9MyCoh0meitNltYlFLzfbekfZ/pgxYep10+ATmMmwOEOO1SX
         dYB6N4D4YbDETF/cskGXeSd8LMM5TX4BfcmIr0Ivsqp21Bpt/rD8g3tg30qwgpBJ2zE1
         IRyd1un8QxctjH8WbqEBls726nU9ScpNVRA6D8dD1hrwo5DfEXIpK7XzxjthOOaqD80f
         nAKA==
X-Gm-Message-State: ACrzQf1SfPdAoRgxYP06iWQ83n4FtUZCXrwX4Fy775C1u0kfjFpfjCZX
        9x5KXGp+1CU3yH8YcekHRZ1sAPlylFY=
X-Google-Smtp-Source: AMsMyM6F7bDtH/hnRYANAHWGtixrqlrpY/4Y/WKpSPIh+P+A6zrsxz9U9pJrA3fRUnhAaybkBIDDJw==
X-Received: by 2002:a7b:c303:0:b0:3b4:6e89:e5d5 with SMTP id k3-20020a7bc303000000b003b46e89e5d5mr9760832wmj.111.1665326260795;
        Sun, 09 Oct 2022 07:37:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3-20020adfdb03000000b0022e309d35f8sm6739851wri.12.2022.10.09.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 07:37:40 -0700 (PDT)
Message-Id: <ec49a74086dee4545a3bb7b24c8da22e77aef579.1665326258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Oct 2022 14:37:27 +0000
Subject: [PATCH 01/12] fsmonitor: refactor filesystem checks to common
 interface
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Provide a common interface for getting basic filesystem information
including filesystem type and whether the filesystem is remote.

Refactor existing code for getting basic filesystem info and detecting
remote file systems to the new interface.

Refactor filesystem checks to leverage new interface. For macOS,
error-out if the Unix Domain socket (UDS) file is on a remote
filesystem.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Makefile                                 |   1 +
 compat/fsmonitor/fsm-path-utils-darwin.c |  43 ++++++
 compat/fsmonitor/fsm-path-utils-win32.c  | 128 +++++++++++++++++
 compat/fsmonitor/fsm-settings-darwin.c   |  69 +++------
 compat/fsmonitor/fsm-settings-win32.c    | 172 +----------------------
 contrib/buildsystems/CMakeLists.txt      |   2 +
 fsmonitor-path-utils.h                   |  26 ++++
 fsmonitor-settings.c                     |  50 +++++++
 8 files changed, 272 insertions(+), 219 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
 create mode 100644 fsmonitor-path-utils.h

diff --git a/Makefile b/Makefile
index cac3452edb9..ffab427ea5b 100644
--- a/Makefile
+++ b/Makefile
@@ -2044,6 +2044,7 @@ endif
 ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
 	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
+	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
 endif
 
 ifeq ($(TCLTK_PATH),)
diff --git a/compat/fsmonitor/fsm-path-utils-darwin.c b/compat/fsmonitor/fsm-path-utils-darwin.c
new file mode 100644
index 00000000000..d46d7f13538
--- /dev/null
+++ b/compat/fsmonitor/fsm-path-utils-darwin.c
@@ -0,0 +1,43 @@
+#include "fsmonitor.h"
+#include "fsmonitor-path-utils.h"
+#include <sys/param.h>
+#include <sys/mount.h>
+
+int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
+{
+	struct statfs fs;
+	if (statfs(path, &fs) == -1) {
+		int saved_errno = errno;
+		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
+				 path, strerror(saved_errno));
+		errno = saved_errno;
+		return -1;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
+			 path, fs.f_type, fs.f_flags, fs.f_fstypename);
+
+	if (!(fs.f_flags & MNT_LOCAL))
+		fs_info->is_remote = 1;
+	else
+		fs_info->is_remote = 0;
+
+	fs_info->typename = xstrdup(fs.f_fstypename);
+
+	trace_printf_key(&trace_fsmonitor,
+				"'%s' is_remote: %d",
+				path, fs_info->is_remote);
+	return 0;
+}
+
+int fsmonitor__is_fs_remote(const char *path)
+{
+	struct fs_info fs;
+	if (fsmonitor__get_fs_info(path, &fs))
+		return -1;
+
+	free(fs.typename);
+
+	return fs.is_remote;
+}
diff --git a/compat/fsmonitor/fsm-path-utils-win32.c b/compat/fsmonitor/fsm-path-utils-win32.c
new file mode 100644
index 00000000000..a90b8f7925b
--- /dev/null
+++ b/compat/fsmonitor/fsm-path-utils-win32.c
@@ -0,0 +1,128 @@
+#include "cache.h"
+#include "fsmonitor.h"
+#include "fsmonitor-path-utils.h"
+
+/*
+ * Check remote working directory protocol.
+ *
+ * Return -1 if client machine cannot get remote protocol information.
+ */
+static int check_remote_protocol(wchar_t *wpath)
+{
+	HANDLE h;
+	FILE_REMOTE_PROTOCOL_INFO proto_info;
+
+	h = CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING,
+			FILE_FLAG_BACKUP_SEMANTICS, NULL);
+
+	if (h == INVALID_HANDLE_VALUE) {
+		error(_("[GLE %ld] unable to open for read '%ls'"),
+		      GetLastError(), wpath);
+		return -1;
+	}
+
+	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
+		&proto_info, sizeof(proto_info))) {
+		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
+		      GetLastError(), wpath);
+		CloseHandle(h);
+		return -1;
+	}
+
+	CloseHandle(h);
+
+	trace_printf_key(&trace_fsmonitor,
+				"check_remote_protocol('%ls') remote protocol %#8.8lx",
+				wpath, proto_info.Protocol);
+
+	return 0;
+}
+
+/*
+ * Notes for testing:
+ *
+ * (a) Windows allows a network share to be mapped to a drive letter.
+ *     (This is the normal method to access it.)
+ *
+ *     $ NET USE Z: \\server\share
+ *     $ git -C Z:/repo status
+ *
+ * (b) Windows allows a network share to be referenced WITHOUT mapping
+ *     it to drive letter.
+ *
+ *     $ NET USE \\server\share\dir
+ *     $ git -C //server/share/repo status
+ *
+ * (c) Windows allows "SUBST" to create a fake drive mapping to an
+ *     arbitrary path (which may be remote)
+ *
+ *     $ SUBST Q: Z:\repo
+ *     $ git -C Q:/ status
+ *
+ * (d) Windows allows a directory symlink to be created on a local
+ *     file system that points to a remote repo.
+ *
+ *     $ mklink /d ./link //server/share/repo
+ *     $ git -C ./link status
+ */
+int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
+{
+	wchar_t wpath[MAX_PATH];
+	wchar_t wfullpath[MAX_PATH];
+	size_t wlen;
+	UINT driveType;
+
+	/*
+	 * Do everything in wide chars because the drive letter might be
+	 * a multi-byte sequence.  See win32_has_dos_drive_prefix().
+	 */
+	if (xutftowcs_path(wpath, path) < 0) {
+		return -1;
+	}
+
+	/*
+	 * GetDriveTypeW() requires a final slash.  We assume that the
+	 * worktree pathname points to an actual directory.
+	 */
+	wlen = wcslen(wpath);
+	if (wpath[wlen - 1] != L'\\' && wpath[wlen - 1] != L'/') {
+		wpath[wlen++] = L'\\';
+		wpath[wlen] = 0;
+	}
+
+	/*
+	 * Normalize the path.  If nothing else, this converts forward
+	 * slashes to backslashes.  This is essential to get GetDriveTypeW()
+	 * correctly handle some UNC "\\server\share\..." paths.
+	 */
+	if (!GetFullPathNameW(wpath, MAX_PATH, wfullpath, NULL)) {
+		return -1;
+	}
+
+	driveType = GetDriveTypeW(wfullpath);
+	trace_printf_key(&trace_fsmonitor,
+			 "DriveType '%s' L'%ls' (%u)",
+			 path, wfullpath, driveType);
+
+	if (driveType == DRIVE_REMOTE) {
+		fs_info->is_remote = 1;
+		if (check_remote_protocol(wfullpath) < 0)
+			return -1;
+	} else {
+		fs_info->is_remote = 0;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+				"'%s' is_remote: %d",
+				path, fs_info->is_remote);
+
+	return 0;
+}
+
+int fsmonitor__is_fs_remote(const char *path)
+{
+	struct fs_info fs;
+	if (fsmonitor__get_fs_info(path, &fs))
+		return -1;
+	return fs.is_remote;
+}
diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index efc732c0f31..699f0b272e6 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -1,32 +1,10 @@
-#include "cache.h"
 #include "config.h"
-#include "repository.h"
-#include "fsmonitor-settings.h"
 #include "fsmonitor.h"
-#include <sys/param.h>
-#include <sys/mount.h>
+#include "fsmonitor-ipc.h"
+#include "fsmonitor-settings.h"
+#include "fsmonitor-path-utils.h"
 
-/*
- * [1] Remote working directories are problematic for FSMonitor.
- *
- * The underlying file system on the server machine and/or the remote
- * mount type (NFS, SAMBA, etc.) dictates whether notification events
- * are available at all to remote client machines.
- *
- * Kernel differences between the server and client machines also
- * dictate the how (buffering, frequency, de-dup) the events are
- * delivered to client machine processes.
- *
- * A client machine (such as a laptop) may choose to suspend/resume
- * and it is unclear (without lots of testing) whether the watcher can
- * resync after a resume.  We might be able to treat this as a normal
- * "events were dropped by the kernel" event and do our normal "flush
- * and resync" --or-- we might need to close the existing (zombie?)
- * notification fd and create a new one.
- *
- * In theory, the above issues need to be addressed whether we are
- * using the Hook or IPC API.
- *
+ /*
  * For the builtin FSMonitor, we create the Unix domain socket for the
  * IPC in the .git directory.  If the working directory is remote,
  * then the socket will be created on the remote file system.  This
@@ -38,42 +16,35 @@
  * be taken to ensure that $HOME is actually local and not a managed
  * file share.)
  *
- * So (for now at least), mark remote working directories as
- * incompatible.
- *
- *
- * [2] FAT32 and NTFS working directories are problematic too.
+ * FAT32 and NTFS working directories are problematic too.
  *
  * The builtin FSMonitor uses a Unix domain socket in the .git
  * directory for IPC.  These Windows drive formats do not support
  * Unix domain sockets, so mark them as incompatible for the daemon.
  *
  */
-static enum fsmonitor_reason check_volume(struct repository *r)
+static enum fsmonitor_reason check_uds_volume(struct repository *r)
 {
-	struct statfs fs;
+	struct fs_info fs;
+	const char *ipc_path = fsmonitor_ipc__get_path();
+	struct strbuf path = STRBUF_INIT;
+	strbuf_add(&path, ipc_path, strlen(ipc_path));
 
-	if (statfs(r->worktree, &fs) == -1) {
-		int saved_errno = errno;
-		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
-				 r->worktree, strerror(saved_errno));
-		errno = saved_errno;
+	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
+		strbuf_release(&path);
 		return FSMONITOR_REASON_ERROR;
 	}
 
-	trace_printf_key(&trace_fsmonitor,
-			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
-			 r->worktree, fs.f_type, fs.f_flags, fs.f_fstypename);
-
-	if (!(fs.f_flags & MNT_LOCAL))
-		return FSMONITOR_REASON_REMOTE;
+	strbuf_release(&path);
 
-	if (!strcmp(fs.f_fstypename, "msdos")) /* aka FAT32 */
-		return FSMONITOR_REASON_NOSOCKETS;
-
-	if (!strcmp(fs.f_fstypename, "ntfs"))
+	if (fs.is_remote ||
+		!strcmp(fs.typename, "msdos") ||
+		!strcmp(fs.typename, "ntfs")) {
+		free(fs.typename);
 		return FSMONITOR_REASON_NOSOCKETS;
+	}
 
+	free(fs.typename);
 	return FSMONITOR_REASON_OK;
 }
 
@@ -81,7 +52,7 @@ enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
 	enum fsmonitor_reason reason;
 
-	reason = check_volume(r);
+	reason = check_uds_volume(r);
 	if (reason != FSMONITOR_REASON_OK)
 		return reason;
 
diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index e5ec5b0a9f7..d88b06ae610 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -1,8 +1,9 @@
 #include "cache.h"
 #include "config.h"
 #include "repository.h"
-#include "fsmonitor-settings.h"
 #include "fsmonitor.h"
+#include "fsmonitor-settings.h"
+#include "fsmonitor-path-utils.h"
 
 /*
  * VFS for Git is incompatible with FSMonitor.
@@ -24,171 +25,6 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
-/*
- * Check if monitoring remote working directories is allowed.
- *
- * By default, monitoring remote working directories is
- * disabled.  Users may override this behavior in enviroments where
- * they have proper support.
- */
-static int check_config_allowremote(struct repository *r)
-{
-	int allow;
-
-	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
-		return allow;
-
-	return -1; /* fsmonitor.allowremote not set */
-}
-
-/*
- * Check remote working directory protocol.
- *
- * Error if client machine cannot get remote protocol information.
- */
-static int check_remote_protocol(wchar_t *wpath)
-{
-	HANDLE h;
-	FILE_REMOTE_PROTOCOL_INFO proto_info;
-
-	h = CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING,
-			FILE_FLAG_BACKUP_SEMANTICS, NULL);
-
-	if (h == INVALID_HANDLE_VALUE) {
-		error(_("[GLE %ld] unable to open for read '%ls'"),
-		      GetLastError(), wpath);
-		return -1;
-	}
-
-	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
-		&proto_info, sizeof(proto_info))) {
-		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
-		      GetLastError(), wpath);
-		CloseHandle(h);
-		return -1;
-	}
-
-	CloseHandle(h);
-
-	trace_printf_key(&trace_fsmonitor,
-				"check_remote_protocol('%ls') remote protocol %#8.8lx",
-				wpath, proto_info.Protocol);
-
-	return 0;
-}
-
-/*
- * Remote working directories are problematic for FSMonitor.
- *
- * The underlying file system on the server machine and/or the remote
- * mount type dictates whether notification events are available at
- * all to remote client machines.
- *
- * Kernel differences between the server and client machines also
- * dictate the how (buffering, frequency, de-dup) the events are
- * delivered to client machine processes.
- *
- * A client machine (such as a laptop) may choose to suspend/resume
- * and it is unclear (without lots of testing) whether the watcher can
- * resync after a resume.  We might be able to treat this as a normal
- * "events were dropped by the kernel" event and do our normal "flush
- * and resync" --or-- we might need to close the existing (zombie?)
- * notification fd and create a new one.
- *
- * In theory, the above issues need to be addressed whether we are
- * using the Hook or IPC API.
- *
- * So (for now at least), mark remote working directories as
- * incompatible.
- *
- * Notes for testing:
- *
- * (a) Windows allows a network share to be mapped to a drive letter.
- *     (This is the normal method to access it.)
- *
- *     $ NET USE Z: \\server\share
- *     $ git -C Z:/repo status
- *
- * (b) Windows allows a network share to be referenced WITHOUT mapping
- *     it to drive letter.
- *
- *     $ NET USE \\server\share\dir
- *     $ git -C //server/share/repo status
- *
- * (c) Windows allows "SUBST" to create a fake drive mapping to an
- *     arbitrary path (which may be remote)
- *
- *     $ SUBST Q: Z:\repo
- *     $ git -C Q:/ status
- *
- * (d) Windows allows a directory symlink to be created on a local
- *     file system that points to a remote repo.
- *
- *     $ mklink /d ./link //server/share/repo
- *     $ git -C ./link status
- */
-static enum fsmonitor_reason check_remote(struct repository *r)
-{
-	int ret;
-	wchar_t wpath[MAX_PATH];
-	wchar_t wfullpath[MAX_PATH];
-	size_t wlen;
-	UINT driveType;
-
-	/*
-	 * Do everything in wide chars because the drive letter might be
-	 * a multi-byte sequence.  See win32_has_dos_drive_prefix().
-	 */
-	if (xutftowcs_path(wpath, r->worktree) < 0)
-		return FSMONITOR_REASON_ERROR;
-
-	/*
-	 * GetDriveTypeW() requires a final slash.  We assume that the
-	 * worktree pathname points to an actual directory.
-	 */
-	wlen = wcslen(wpath);
-	if (wpath[wlen - 1] != L'\\' && wpath[wlen - 1] != L'/') {
-		wpath[wlen++] = L'\\';
-		wpath[wlen] = 0;
-	}
-
-	/*
-	 * Normalize the path.  If nothing else, this converts forward
-	 * slashes to backslashes.  This is essential to get GetDriveTypeW()
-	 * correctly handle some UNC "\\server\share\..." paths.
-	 */
-	if (!GetFullPathNameW(wpath, MAX_PATH, wfullpath, NULL))
-		return FSMONITOR_REASON_ERROR;
-
-	driveType = GetDriveTypeW(wfullpath);
-	trace_printf_key(&trace_fsmonitor,
-			 "DriveType '%s' L'%ls' (%u)",
-			 r->worktree, wfullpath, driveType);
-
-	if (driveType == DRIVE_REMOTE) {
-		trace_printf_key(&trace_fsmonitor,
-				 "check_remote('%s') true",
-				 r->worktree);
-
-		ret = check_remote_protocol(wfullpath);
-		if (ret < 0)
-			return FSMONITOR_REASON_ERROR;
-
-		switch (check_config_allowremote(r)) {
-		case 0: /* config overrides and disables */
-			return FSMONITOR_REASON_REMOTE;
-		case 1: /* config overrides and enables */
-			return FSMONITOR_REASON_OK;
-		default:
-			break; /* config has no opinion */
-		}
-
-		return FSMONITOR_REASON_REMOTE;
-	}
-
-	return FSMONITOR_REASON_OK;
-}
-
 enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
 	enum fsmonitor_reason reason;
@@ -197,9 +33,5 @@ enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 	if (reason != FSMONITOR_REASON_OK)
 		return reason;
 
-	reason = check_remote(r);
-	if (reason != FSMONITOR_REASON_OK)
-		return reason;
-
 	return FSMONITOR_REASON_OK;
 }
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index ea2a531be87..5482a04b3ce 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -308,6 +308,7 @@ if(SUPPORTS_SIMPLE_IPC)
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-win32.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
@@ -315,6 +316,7 @@ if(SUPPORTS_SIMPLE_IPC)
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
diff --git a/fsmonitor-path-utils.h b/fsmonitor-path-utils.h
new file mode 100644
index 00000000000..41edf5b934f
--- /dev/null
+++ b/fsmonitor-path-utils.h
@@ -0,0 +1,26 @@
+#ifndef FSM_PATH_UTILS_H
+#define FSM_PATH_UTILS_H
+
+struct fs_info {
+	int is_remote;
+	char *typename;
+};
+
+/*
+ * Get some basic filesystem informtion for the given path
+ *
+ * The caller owns the storage that is occupied by fs_info and
+ * is responsible for releasing it.
+ *
+ * Returns -1 on error, zero otherwise.
+ */
+int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info);
+
+/*
+ * Determines if the filesystem that path resides on is remote.
+ *
+ * Returns -1 on error, 0 if not remote, 1 if remote.
+ */
+int fsmonitor__is_fs_remote(const char *path);
+
+#endif
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 464424a1e92..d288cbad479 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "repository.h"
 #include "fsmonitor-settings.h"
+#include "fsmonitor-path-utils.h"
 
 /*
  * We keep this structure defintion private and have getters
@@ -13,6 +14,52 @@ struct fsmonitor_settings {
 	char *hook_path;
 };
 
+/*
+ * Remote working directories are problematic for FSMonitor.
+ *
+ * The underlying file system on the server machine and/or the remote
+ * mount type dictates whether notification events are available at
+ * all to remote client machines.
+ *
+ * Kernel differences between the server and client machines also
+ * dictate the how (buffering, frequency, de-dup) the events are
+ * delivered to client machine processes.
+ *
+ * A client machine (such as a laptop) may choose to suspend/resume
+ * and it is unclear (without lots of testing) whether the watcher can
+ * resync after a resume.  We might be able to treat this as a normal
+ * "events were dropped by the kernel" event and do our normal "flush
+ * and resync" --or-- we might need to close the existing (zombie?)
+ * notification fd and create a new one.
+ *
+ * In theory, the above issues need to be addressed whether we are
+ * using the Hook or IPC API.
+ *
+ * So (for now at least), mark remote working directories as
+ * incompatible unless 'fsmonitor.allowRemote' is true.
+ *
+ */
+#ifdef HAVE_FSMONITOR_OS_SETTINGS
+static enum fsmonitor_reason check_remote(struct repository *r)
+{
+	int allow_remote = -1; /* -1 unset, 0 not allowed, 1 allowed */
+	int is_remote = fsmonitor__is_fs_remote(r->worktree);
+
+	switch (is_remote) {
+		case 0:
+			return FSMONITOR_REASON_OK;
+		case 1:
+			repo_config_get_bool(r, "fsmonitor.allowremote", &allow_remote);
+			if (allow_remote < 1)
+				return FSMONITOR_REASON_REMOTE;
+			else
+				return FSMONITOR_REASON_OK;
+		default:
+			return FSMONITOR_REASON_ERROR;
+	}
+}
+#endif
+
 static enum fsmonitor_reason check_for_incompatible(struct repository *r)
 {
 	if (!r->worktree) {
@@ -27,6 +74,9 @@ static enum fsmonitor_reason check_for_incompatible(struct repository *r)
 	{
 		enum fsmonitor_reason reason;
 
+		reason = check_remote(r);
+		if (reason != FSMONITOR_REASON_OK)
+			return reason;
 		reason = fsm_os__incompatible(r);
 		if (reason != FSMONITOR_REASON_OK)
 			return reason;
-- 
gitgitgadget

