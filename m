Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0884C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbiCVSZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240305AbiCVSY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:24:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852E38F9A9
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t11so24662121wrm.5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k5ZREbqCqHvt+JSRQlVPZDSjI/JECTPQcuz7v45GQYU=;
        b=Z6O6+2J/GKtKKGGgNcdeBbf3VwknsQWq/limCUvp7M3y9JRKWaiiaYkt3m9bgKUQli
         iqm5LYz0jhu8p1ZPKTO5OByP0TrE8q8ezg5O7k/GzNbk5HtDCB9nhqupcE64+D4U3Kst
         ua9nttNnkskiDZ2jjxfFYyCT20BQ3Auv1DEKrBugZoJajydwy1GFyMkGoHcZfC/g3PLV
         a2ZOEi/4gqbgyN2q7vxq9HIhfaREzVYLxasedOTx+WYgZX9EpxbrVZ5ksJx3UZlpC55D
         ep/YG+KeCLf7iMH4b1cNsQB9WaN7WNUSjOP2eZNUy/L2hOATkQHihbwLLe3fbQ4SotXA
         2KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k5ZREbqCqHvt+JSRQlVPZDSjI/JECTPQcuz7v45GQYU=;
        b=WOgxZVU9l0gpqvyUEUX52Cd2CVYbUyaLpcAe6iO2zSuBUFULuLIVOGMlPFuiokSyBc
         YvTYXJp6+mH5uzw0PG1ldmqbnFBhNndubgHb20TkdPBMSQjHUuf4Zv2xYIeSFH0J29DC
         /cU/HU8baEh6W585BKWdJW9cKxZTWGq8cmxX1sUtzpLltoft9dkhZ/QhsIlwZea0tQgm
         +NzO5oQTaKSusJBeqPFDhZFXzsplAB2uAF4aATq1itrERtfwnqrZx6IZCpIq39DwfSlG
         1LWA+NiAvLQaDO5xmyig6uPTDUAAknnwuC7DP9gOIAdZrPuZWhVPhFTrYA1LEGs2wezU
         hO6w==
X-Gm-Message-State: AOAM530k7VkjysBfwFbQ/CTWULpG54fQpDfR9krWtjn4uLkG3xA/I74S
        6J3Vh3HJ8Drs1x7rdxW98Znhat1O7Zc=
X-Google-Smtp-Source: ABdhPJxQJSHQZVqixzGKg8cI8j0mhl5IVYkVzWSECntr+Ft+SeNiglGwPwL0otrJUvr1oD8D3Fabsw==
X-Received: by 2002:a5d:40ce:0:b0:203:f29f:7447 with SMTP id b14-20020a5d40ce000000b00203f29f7447mr19015087wrq.477.1647973403043;
        Tue, 22 Mar 2022 11:23:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k2-20020a1ca102000000b0038c78fdd59asm2389350wme.39.2022.03.22.11.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:21 -0700 (PDT)
Message-Id: <06d7f18676d311b2ae246f078239739c5d1aa787.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:41 +0000
Subject: [PATCH v3 08/27] fsmonitor-settings: remote repos on macOS are
 incompatible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach Git to detect remote working directories on macOS and mark them as
incompatible with FSMonitor.

With this, `git fsmonitor--daemon run` will error out with a message
like it does for bare repos.

Client commands, like `git status`, will not attempt to start the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-darwin.c | 66 ++++++++++++++++++++++++++
 fsmonitor-settings.c                   | 10 ++++
 fsmonitor-settings.h                   |  2 +
 3 files changed, 78 insertions(+)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 7fce32a3c5b..fdd762bf79d 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -2,8 +2,74 @@
 #include "config.h"
 #include "repository.h"
 #include "fsmonitor-settings.h"
+#include "fsmonitor.h"
+#include <sys/param.h>
+#include <sys/mount.h>
+
+/*
+ * Remote working directories are problematic for FSMonitor.
+ *
+ * The underlying file system on the server machine and/or the remote
+ * mount type (NFS, SAMBA, etc.) dictates whether notification events
+ * are available at all to remote client machines.
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
+ * So (for now at least), mark remote working directories as
+ * incompatible.
+ */
+static enum fsmonitor_reason check_remote(struct repository *r)
+{
+	struct statfs fs;
+
+	if (statfs(r->worktree, &fs) == -1) {
+		int saved_errno = errno;
+		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
+				 r->worktree, strerror(saved_errno));
+		errno = saved_errno;
+		return FSMONITOR_REASON_ERROR;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
+			 r->worktree, fs.f_type, fs.f_flags, fs.f_fstypename);
+
+	if (!(fs.f_flags & MNT_LOCAL))
+		return FSMONITOR_REASON_REMOTE;
+
+	return FSMONITOR_REASON_OK;
+}
 
 enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
+	enum fsmonitor_reason reason;
+
+	reason = check_remote(r);
+	if (reason != FSMONITOR_REASON_OK)
+		return reason;
+
 	return FSMONITOR_REASON_OK;
 }
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 1efb6e17a20..0a1811ff004 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -180,6 +180,16 @@ int fsm_settings__error_if_incompatible(struct repository *r)
 		      xgetcwd());
 		return 1;
 
+	case FSMONITOR_REASON_ERROR:
+		error(_("repository '%s' is incompatible with fsmonitor due to errors"),
+		      r->worktree);
+		return 1;
+
+	case FSMONITOR_REASON_REMOTE:
+		error(_("remote repository '%s' is incompatible with fsmonitor"),
+		      r->worktree);
+		return 1;
+
 	case FSMONITOR_REASON_VFS4GIT:
 		error(_("virtual repository '%s' is incompatible with fsmonitor"),
 		      r->worktree);
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index 6361fcbf6b0..34391b583b3 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -16,6 +16,8 @@ enum fsmonitor_mode {
 enum fsmonitor_reason {
 	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
 	FSMONITOR_REASON_BARE,
+	FSMONITOR_REASON_ERROR, /* FS error probing for compatibility */
+	FSMONITOR_REASON_REMOTE,
 	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
 };
 
-- 
gitgitgadget

