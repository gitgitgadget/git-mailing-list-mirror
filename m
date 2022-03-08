Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7018BC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350696AbiCHWQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350651AbiCHWQh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:37 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EF35748F
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:40 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r81-20020a1c4454000000b00389d0a5c511so54099wma.5
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9jAtXhyIq9laZUe81g2r33zWzWajDnpxHDHbIsehyl4=;
        b=Sxio4bVpe/abD8t0xrix8Hn8VTgqCvDT3WPXBBWG9NA1kHVCNUmu1m3ZIGgV8qKEgk
         2W1TtaFSbPQiQ2117X/8J9ivdii/2Ld6dkHO+Qum20FeNZ/EeO4YddTJKtk+RocQa7VR
         AhxpoIZIciWBaYWrPXsOLITJaiq0ZlAgvTY7M8uep7BmNqmVuWE7PjMQSo5E8/4klh10
         xAWXay2zNIy++W5dSewJQn3267JdvnmA0lm7QlAsYtV8hc3PqtiML8UBe1C2G94SgcUd
         qST9oQzo0S7GPZWLs6+GPED3rQBND4Pf5Ev9edQZX/pEfp13GgWmmnoUi+oIpsOGiIvH
         J38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9jAtXhyIq9laZUe81g2r33zWzWajDnpxHDHbIsehyl4=;
        b=GqQU7i4Lf9TOeFRJWUWwZk6jnp0PGzApCidOK2LRIWKoYbAiqdaZdHkiPY59XB7t6n
         E22HEVtTpMpVevOsqbR+CtxcqtQ4+b+hTUG8swCmSlkUiNjtiTvdmV+JjvOAvxoOJY0U
         87yvkn4dJO0YuaypPeVP4O/XwXTEyc57ND28v1KmqFYHgnxt6qvS2ChKl2CF5E6nwG2s
         iPTIV5pNcejFRFnJWboG8uE/G6oSoDzJSLb/aWpg1BCafRtKMyE6x/xH3pKsExz8UJWs
         b42OFyRL0cZvf513GJdNNGVQe9bkh76iNPu6UhdZEzXTLOIzBTdq/Qu1To2WyWUjBhjT
         dJnw==
X-Gm-Message-State: AOAM5316yVMzJzEQNTd2WNbc8Lf2hMOKIsBYuOWv97F8LUM9+7ZKL4Ak
        BgpErUdU9/UXT0xpjd0WBajQBt5/I1c=
X-Google-Smtp-Source: ABdhPJxamfBvMlA9tMR1ywqpVZOuO247EfpLzWZN/oPgU46XduE8ahFRLq3aMinouIARjuvNQs17jA==
X-Received: by 2002:a1c:7409:0:b0:389:9408:b3fa with SMTP id p9-20020a1c7409000000b003899408b3famr1056216wmc.122.1646777738626;
        Tue, 08 Mar 2022 14:15:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b001f1f7b814d7sm94713wru.69.2022.03.08.14.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:38 -0800 (PST)
Message-Id: <e3bfa0bd69d937efcf7f7bd879d3d372927ff06a.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:08 +0000
Subject: [PATCH v2 08/27] fsmonitor-settings: remote repos on macOS are
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

Teach Git to detect remote working directories on macOS and mark them as
incompatible with FSMonitor.

With this, `git fsmonitor--daemon run` will error out with a message
like it does for bare repos.

Client commands, like `git status`, will not attempt to start the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-darwin.c | 66 ++++++++++++++++++++++++++
 fsmonitor-settings.c                   |  6 +++
 fsmonitor-settings.h                   |  2 +
 3 files changed, 74 insertions(+)

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
index ea3e365dfc4..7ff3f98964d 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -178,6 +178,12 @@ const char *fsm_settings__get_reason_msg(struct repository *r)
 	case FSMONITOR_REASON_BARE:
 		return _("bare repos are incompatible with fsmonitor");
 
+	case FSMONITOR_REASON_ERROR:
+		return _("repo incompatible with fsmonitor due to errors");
+
+	case FSMONITOR_REASON_REMOTE:
+		return _("remote repos are incompatible with fsmonitor");
+
 	case FSMONITOR_REASON_VFS4GIT:
 		return _("virtual repos are incompatible with fsmonitor");
 	}
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index 7950529611b..6aa9a00379b 100644
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

