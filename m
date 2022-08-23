Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D0EC32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 16:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244821AbiHWQcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242860AbiHWQcA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 12:32:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A36FEC6F
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 06:03:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so6457474wmk.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=1DXuvdwjfUb9+x0G0jwK0PdicjVVYpDtZrgZUeeuj2k=;
        b=XJgCgbW2p+rV5+sDDa7KI9o5Uh+pWO8cQ9bFSCX+Bn7fW/6RNtD6o1nyV60mhNIoEG
         1W4txIx0roWLrM7KMYJp+aAXosiRvv4dlLC2YZwzGs3ln6BewBLCb9828ihUR297He7A
         PYJ5Ovdz5yyTRzvlDE+6sxuDHTU2KnSvLmZDat4lhsEn3DvW7gUQmnFyyqUjnztxQRnu
         5Ljfs2V6EjjdUy/C0groPV7QtmXLjK0BGTd1srBz71NDsGLmN88Mloa5YO/OFVLImmKL
         vZTXC4IiY+ex7lpRlLz5vBL39gCVQb/6QSWu31T4MSoaZ+pZuD6jwVnp4mJgJjN3DX7C
         FLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=1DXuvdwjfUb9+x0G0jwK0PdicjVVYpDtZrgZUeeuj2k=;
        b=eYgTbRdPFqW1EZBE+VGudyj5oM1EgH9K59xp+XAHsXtfp/zR/szFCRlBNu4ez6+xX8
         hglrL3LJD5eenKllbp45ZQZYTVyOqHkKy+Nh/v/VbCLLEjtLxO3zKcArjwVIZD7B3Ift
         4/SBlCho81QeYsNqZlF6iAqBm4Dk50rGjQvXK81xT1u6lcW4GBF8bRFfbMBvA2gVPmOK
         K+27Ob/NLM4LgcF/vk2RY48JVMi6mCszaJfMPELwVZc1JYgc8oslLURS5Ch2WEOWjbxD
         7+hcRnlUFac/M/VIUtxqCMKMuFCcUMYRBJgiCppIrY63pEIFhztUkBjnZuRb706PEMQp
         iVwA==
X-Gm-Message-State: ACgBeo2M72ePTZSChGX6X4yCibcs3GdqjBN2wadwGw3IWjbz3D4qP4h8
        LzztUWnCSdONJZaO5jAqUyPLkkKO3bs=
X-Google-Smtp-Source: AA6agR7uoWkiSewKNqd6QOlW2KXUJ5cR+bjcwveaMaKnuwP8os4ggFLd2DgrwQHIsv7II6riLhlSlg==
X-Received: by 2002:a05:600c:1f0c:b0:3a5:d744:f837 with SMTP id bd12-20020a05600c1f0c00b003a5d744f837mr2237822wmb.40.1661259825968;
        Tue, 23 Aug 2022 06:03:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d6b44000000b002252d897876sm10525668wrw.32.2022.08.23.06.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:03:45 -0700 (PDT)
Message-Id: <9b128a981494f5aa7f60062caecc24ee6ea802ec.1661259820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
        <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
From:   "edecosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 13:03:39 +0000
Subject: [PATCH v2 3/4] Check working directory and Unix domain socket file
 for compatability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        edecosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: edecosta <edecosta@mathworks.com>

Perform separate checks for the working directory and Unix domain socket
(UDS) file location. The working directory may be located on a
network-mounted file system if 'fsmonitor.allowRemote' is true. The UDS
file may never be located on a network-mounted file system; additionally
it may not be located on FAT32 or NTFS file systems.

Signed-off-by: edecosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-settings-darwin.c | 72 +++++++++++++++++++-------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index efc732c0f31..dc79538607f 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -3,11 +3,12 @@
 #include "repository.h"
 #include "fsmonitor-settings.h"
 #include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
 #include <sys/param.h>
 #include <sys/mount.h>
 
 /*
- * [1] Remote working directories are problematic for FSMonitor.
+ * Remote working directories are problematic for FSMonitor.
  *
  * The underlying file system on the server machine and/or the remote
  * mount type (NFS, SAMBA, etc.) dictates whether notification events
@@ -27,26 +28,8 @@
  * In theory, the above issues need to be addressed whether we are
  * using the Hook or IPC API.
  *
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
  * So (for now at least), mark remote working directories as
- * incompatible.
- *
- *
- * [2] FAT32 and NTFS working directories are problematic too.
- *
- * The builtin FSMonitor uses a Unix domain socket in the .git
- * directory for IPC.  These Windows drive formats do not support
- * Unix domain sockets, so mark them as incompatible for the daemon.
+ * incompatible unless fsmonitor.allowRemote is true.
  *
  */
 static enum fsmonitor_reason check_volume(struct repository *r)
@@ -65,6 +48,51 @@ static enum fsmonitor_reason check_volume(struct repository *r)
 			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
 			 r->worktree, fs.f_type, fs.f_flags, fs.f_fstypename);
 
+	if (!(fs.f_flags & MNT_LOCAL)
+		&& (fsm_settings__get_allow_remote(r) < 1))
+			return FSMONITOR_REASON_REMOTE;
+
+	return FSMONITOR_REASON_OK;
+}
+
+/*
+ * For the builtin FSMonitor, we create the Unix domain socket (UDS)
+ * for the IPC in the .git directory by default or $HOME if
+ * fsmonitor.allowRemote is true.  If the directory is remote,
+ * then the socket will be created on the remote file system. This
+ * can fail if the remote file system does not support UDS file types
+ * (e.g. smbfs to a Windows server) or if the remote kernel does not
+ * allow a non-local process to bind() the socket.
+ *
+ * Therefore remote UDS locations are marked as incompatible.
+ *
+ * FAT32 and NTFS working directories are problematic too.
+ *
+ * These Windows drive formats do not support Unix domain sockets, so
+ * mark them as incompatible for the location of the UDS file.
+ *
+ */
+static enum fsmonitor_reason check_uds_volume(void)
+{
+	struct statfs fs;
+	struct strbuf path = STRBUF_INIT;
+	const char *ipc_path = fsmonitor_ipc__get_path();
+	strbuf_add(&path, ipc_path, strlen(ipc_path));
+
+	if (statfs(dirname(path.buf), &fs) == -1) {
+		int saved_errno = errno;
+		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
+				 path.buf, strerror(saved_errno));
+		errno = saved_errno;
+		strbuf_release(&path);
+		return FSMONITOR_REASON_ERROR;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
+			 path.buf, fs.f_type, fs.f_flags, fs.f_fstypename);
+	strbuf_release(&path);
+
 	if (!(fs.f_flags & MNT_LOCAL))
 		return FSMONITOR_REASON_REMOTE;
 
@@ -85,5 +113,9 @@ enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 	if (reason != FSMONITOR_REASON_OK)
 		return reason;
 
+	reason = check_uds_volume();
+	if (reason != FSMONITOR_REASON_OK)
+		return reason;
+
 	return FSMONITOR_REASON_OK;
 }
-- 
gitgitgadget

