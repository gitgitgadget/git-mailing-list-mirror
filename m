Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0643FC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350698AbiCHWRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350660AbiCHWQl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6459F5749B
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:41 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so409170wmq.2
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sjfx7SFJhNxZLXokVMmn8yqRtBoQjZzh8JIwTJB3LAY=;
        b=LFpXr4G90Vyrm+x5T33AGdhCZ/3XXJ7/vXfCp/KMlLlK9pvy+S7bKliFqzFa8ojbi0
         44086TM3we5PpB5N6n6vuQz4gqJYCW63/xWnNGFoUcGZ8z73vQRdIcDFUnO1AJt+0EY4
         EBmNcIf4ezCh3o6t40Id7/71XneB4YlKDQf5rKaJFwY7nqzsJOri+Ny0f5iBWY//QdNn
         QPmEs08jN2ygtzuI7Em3sm8RBMPuNdsSHTXUjFS8/kxtGiKaiNfSRtiIv3QS2GEtdMsD
         zMEWNi4nOpDqEA7y0+81JSrJ2lF5tznN4v71tLExpb1sfsMMQd8y6D8fYE0c6bHxw68Q
         j7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sjfx7SFJhNxZLXokVMmn8yqRtBoQjZzh8JIwTJB3LAY=;
        b=FVvu4cyFWW/gOkrKdyfN2XkHrOIiw1HlA/SnJXySSFTxtBRgUHF8Kzpe3t86nKGmrc
         VEpfeYxr6o2quj/zqSgDLbu/74CDRhTBDfFazs08xKy2ICUSrzZeZQ2Mxtt8pWK6zE98
         +cjtkdBQqit2JBUy/eFXB6Jt+Dea0J0luTtjs4l4qQaMG0+sFVJ30flLifrP6foyU/dK
         zJagDbYrKRWizIm7hBnrp9zq1KI8sbYQHizWU2R6ypLtfsM4fvlTTwtYESAk1KyZM2B8
         seiQaQgHld+PP9WyNZvPh+qHwDHeEFL0mssun4tQeLXqpDIxE1gFbJdz1kmFxA3OZiz8
         jKKw==
X-Gm-Message-State: AOAM533FT9Z3huvXVCjypzJYA2xqJatfCfOoKJISh4GekvcRhb0jC4bH
        TvEzqDWZuIwE0lcHsZPf5A9o7fPZxuo=
X-Google-Smtp-Source: ABdhPJxbedPAW0rSfyj5StRBowJm8BAcN3397KsVBu3iWHimNNdDHE5IoF/PRUgwLSAOqPpnGlH3bg==
X-Received: by 2002:a1c:acc6:0:b0:380:e35f:ff1f with SMTP id v189-20020a1cacc6000000b00380e35fff1fmr5331355wme.52.1646777739771;
        Tue, 08 Mar 2022 14:15:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b00386744cb31bsm3551412wmq.35.2022.03.08.14.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:39 -0800 (PST)
Message-Id: <e32da3118fb9a4e55989ab24a58183c81d720523.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:09 +0000
Subject: [PATCH v2 09/27] fsmonitor-settings: remote repos on Windows are
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
        Jeff Hostetler <jeffhost@microsoft.com>,
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
index ee78bba38e3..907655720bb 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "repository.h"
 #include "fsmonitor-settings.h"
+#include "fsmonitor.h"
 
 /*
  * VFS for Git is incompatible with FSMonitor.
@@ -23,6 +24,103 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 	return FSMONITOR_REASON_OK;
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
+static enum fsmonitor_reason check_remote(struct repository *r)
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
+		return FSMONITOR_REASON_ERROR;
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
+		return FSMONITOR_REASON_ERROR;
+
+	driveType = GetDriveTypeW(wfullpath);
+	trace_printf_key(&trace_fsmonitor,
+			 "DriveType '%s' L'%ls' (%u)",
+			 r->worktree, wfullpath, driveType);
+
+	if (driveType == DRIVE_REMOTE) {
+		trace_printf_key(&trace_fsmonitor,
+				 "check_remote('%s') true",
+				 r->worktree);
+		return FSMONITOR_REASON_REMOTE;
+	}
+
+	return FSMONITOR_REASON_OK;
+}
+
 enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
 	enum fsmonitor_reason reason;
@@ -31,5 +129,9 @@ enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 	if (reason != FSMONITOR_REASON_OK)
 		return reason;
 
+	reason = check_remote(r);
+	if (reason != FSMONITOR_REASON_OK)
+		return reason;
+
 	return FSMONITOR_REASON_OK;
 }
-- 
gitgitgadget

