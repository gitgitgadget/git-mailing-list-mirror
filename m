Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFAFC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382172AbiDTUqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382148AbiDTUqU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454573AA71
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so2037662wms.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k5ZREbqCqHvt+JSRQlVPZDSjI/JECTPQcuz7v45GQYU=;
        b=gdy3AStzP/Gu8DGxGjM9hIWp6/MRh3CYQvcSlFFkE8+cXL39QXJ/oRmlalOEEbXz8I
         L//Ox90ngch0vUcUHFvqg0w4VBQyLQ1lwCHCi0wMsiorqO7LOp1hTZ01UmO0gyY0br90
         s8QltV1bmF7EHkdYmXRE08Qi1Pc6A8i5TzydiKOb8spf+zoTTe13snWo/X9KKXLoYcL9
         1OMIV3eqQGoDVbeLJI8bQ4DNMN+pWeMg8c6udtmyN+U6O8LfkPn2Qe03oEM8RruOVrmO
         o4kf4Wj0N5B3RpKONbrJjyv4EGjOYN39xh31X4xlHoKgZpTtL7K/y/eHA6pWjulLitqY
         0uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k5ZREbqCqHvt+JSRQlVPZDSjI/JECTPQcuz7v45GQYU=;
        b=eE+0l9s9wNXEunZyJkKOode7tzwZrF2ups8HQQlxRX4KNDGtt4tyB5q4QF8De2eONA
         2paykcW0HekQ853GXOxqjbqidOAxWYn+u2jzANl1txLKe/jQ8qwuMXYhDojihRD0zQFU
         YcXmShHzdI5vaZUqQgNDC905VoUy2VkBmSuLQpKVVn1r0CxwddJpqnCQIdU0Wq3XZirb
         X30iVQiB5FJhJFlG5jRb8wFNiphShfhIFH9TN3O8Y9xP/azqGL8rZdE10uXsY9ogpR7b
         HROWfvO0v11o5AuapgFQyO97WbLOY+u0Hq9hus9KsYeAcBfrtaiHdy7g/48OnmCpP1Ef
         dvzA==
X-Gm-Message-State: AOAM530c02Z6Qdv2n1TYQPNeTlEi/t1NoemuKvfpx6ixC0x3MJXj6pwG
        5FcPwJnrDS2KsR09TggJrik5LeNrJu0=
X-Google-Smtp-Source: ABdhPJy9p0HIhyZiJ+UIUZNMiBtf/aJ7vnXmV3UgnEtgz+oXE5ZRYCWGTz3sdO5pcBCDfJWRnuFTlw==
X-Received: by 2002:a05:600c:1c1f:b0:38e:c425:5b1a with SMTP id j31-20020a05600c1c1f00b0038ec4255b1amr5343870wms.69.1650487411437;
        Wed, 20 Apr 2022 13:43:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d40c1000000b00207b49d3023sm640616wrq.44.2022.04.20.13.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:31 -0700 (PDT)
Message-Id: <b2ca6c1b201a5d0e54497b9ce091bae6b205f2c7.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:42:58 +0000
Subject: [PATCH v5 08/28] fsmonitor-settings: remote repos on macOS are
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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

