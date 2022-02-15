Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AB2C433FE
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbiBOQAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbiBOP75 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:59:57 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3827CBD8B4
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:47 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso1561354wmi.0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EE1kU+RonBw911SS5R75P4cGS7NU2tc6PRM8jsMPKG8=;
        b=kvCLeEEdYYl/Tf2U57F4VKLnLyFbwGFB05i9zTSYzopC7h7l+VyVWDsR26JAVjFV4z
         vt+wH5RCuiYdf1qKTovJJ1pR4xoQFcJ8ljlcJRrmCUexeem6z9pmW8P6+byKHInc8ciy
         Y+mO+7fL//0k19TXJXCDITtH3EbnBFHaPIFL03uVvfmjcG/K0wDUorDhwKBTUQwdbc/P
         bsBWXQVEGzy03Z+EjJVj13C/GWCXJTdmFpA/AhIsuAnr/wnm6/4EUpArWXm/XH7UyvgN
         7d5K/V9Adm+DULqkbjqjKRLtwgOTNUXH6n62WZABx9iV40S4+SF/dh3Ivd4Q7It5GZYz
         7COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EE1kU+RonBw911SS5R75P4cGS7NU2tc6PRM8jsMPKG8=;
        b=O+l3mX1+pLuLdtjtVl9w3ZLy388yLtQ8YdZTNjyzMMzdMvdsG9b55Js3ONvZOTmBXI
         pKc4c7JpL92X5pBdY8hesT5fNjlkHXVvt8gbq8XDWiFPeQnjbWPsH2dHhP2fl81Eh8Uo
         qxmutE/8te9oPJe+pYSCrVVYejrh4JjRXSLLUsRIRNPTn7WG080lSUkFHE9smflLEvcG
         qsP4HUJDP0y7KKu/q+gTnnq5G7zdgSwK8cRotW5FmHJrqSq1jEhpzPE8RwEDhc+l0tHd
         sfsg7757Ed5FLIgrUxRR0f9OzujcIJTKe4RhAdCwZAatZkPEPDS/xAn9cJ/JpZxT8hjC
         QEoQ==
X-Gm-Message-State: AOAM532GADzpAnwBOkBdaxDjteyzOfteV74/q1tszvaXPvmnHhAOrdNs
        hnLz5+Fyvsn0Q0flqOiBnSwyotDrMh8=
X-Google-Smtp-Source: ABdhPJzyKYBte6L9s+GMKAukn/q7+9Ff8Y17kuBgO0ZqRJa/7waEwxUgXKsz9m4XM8dH74MbY8BQEg==
X-Received: by 2002:a05:600c:3795:: with SMTP id o21mr3572744wmr.86.1644940785613;
        Tue, 15 Feb 2022 07:59:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm8719565wrd.30.2022.02.15.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:45 -0800 (PST)
Message-Id: <ae09fb10c3ad5ea129c88addd07ebe674a22793d.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:20 +0000
Subject: [PATCH 10/23] fsmonitor-settings: remote repos on Windows are
 incompatible with FSMonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach Git to detect remote working directories on Windows and mark them as
incompatible with FSMonitor.

With this `git fsmonitor--daemon run` will error out with a message like it
does for bare repos.

Client commands, such as `git status`, will not attempt to start the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-win32.c | 102 ++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index 7caa79570af..77156c0ca20 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "repository.h"
 #include "fsmonitor-settings.h"
+#include "fsmonitor.h"
 
 /*
  * GVFS (aka VFS for Git) is incompatible with FSMonitor.
@@ -23,6 +24,103 @@ static enum fsmonitor_reason is_virtual(struct repository *r)
 	return FSMONITOR_REASON_ZERO;
 }
 
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
+ * incompatible.
+ *
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
+static enum fsmonitor_reason is_remote(struct repository *r)
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
+	if (xutftowcs_path(wpath, r->worktree) < 0)
+		return FSMONITOR_REASON_ZERO;
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
+	if (!GetFullPathNameW(wpath, MAX_PATH, wfullpath, NULL))
+		return FSMONITOR_REASON_ZERO;
+
+	driveType = GetDriveTypeW(wfullpath);
+	trace_printf_key(&trace_fsmonitor,
+			 "DriveType '%s' L'%ls' (%u)",
+			 r->worktree, wfullpath, driveType);
+
+	if (driveType == DRIVE_REMOTE) {
+		trace_printf_key(&trace_fsmonitor,
+				 "is_remote('%s') true",
+				 r->worktree);
+		return FSMONITOR_REASON_REMOTE;
+	}
+
+	return FSMONITOR_REASON_ZERO;
+}
+
 enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
 	enum fsmonitor_reason reason;
@@ -31,5 +129,9 @@ enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 	if (reason)
 		return reason;
 
+	reason = is_remote(r);
+	if (reason)
+		return reason;
+
 	return FSMONITOR_REASON_ZERO;
 }
-- 
gitgitgadget

