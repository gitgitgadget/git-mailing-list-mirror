Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23931C4167D
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiDVWic (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiDVWiB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63487288EEF
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w4so12715905wrg.12
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X9HtE7n6rbhPOtuKToQxRM0ozLfIDJ9mhKlsuRDzMVQ=;
        b=Udh6MZi0d/ypCL2ETpBnA7DBsUIdqdvwH30nMI57A8kmfk4OQUJPsWJKhTArn64mNv
         jhGLzDKlz+oeo/zLn9PcWrXSzEjJRnoi/ZYbLHZACjNf0FzakDugOMf3txRFCzDkg7DI
         cAKUwF9JwNi3npHXdGcxN/YNCglJsxEls9RaDxekfbg0EtXkDnw0uIo6md03u2mW0mAS
         Jb0/wIs1rWqji8V7+QuxLj3DuBuEsGBQxU6sNJL1Q3ts3DDJH73666IqTmD4U1nXSxpL
         QgEFWzumMENZBoDl4Xl5O5EL8OFUemWmXAcUU5F8eirxVQlCr+Xd8SKgIYJEPhRuLYII
         ulqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X9HtE7n6rbhPOtuKToQxRM0ozLfIDJ9mhKlsuRDzMVQ=;
        b=G0foIpFLuRdE63q5V6FFoD0lquSQEcHdC8QvhfM3kdG21l9iDANDj4ilO+YhGlRPvA
         lcp51GFenE8KZLcJpYeUQKH7VX52NsWOLBhXQ3QJJQW8DXEfN4Ca58c2SevJHuwEMfwc
         qzBAm7yu/wOsWStGRmfU8Zdqsh5EDEKoysTxmbe2vJ2EVLrSzSRMmzZ5qpM468qAENkH
         iOow3Pdzt5QwkVoYyjNB4mZBrIdnZg4kN+V0EZX8HWB7Wl0z0BLyEZTdA2hmIShU6wjk
         oKxdEjbMGZ6DtXyS6o6v66+J+7o/zhqglvYxfTIshguDNVaUncgeIaboAcMhBgs4A4z1
         Ipfg==
X-Gm-Message-State: AOAM531twj0Ag8NeevxlgiMVN3+tCQYqiUayu3djaNm/hSN7iGqIGiAV
        qJZHhI3kHUJCRqKctrhcke0s4+s59es=
X-Google-Smtp-Source: ABdhPJw0oTzX1r1k2uuWz2qhmBF0075h+eqlaRdXjoS/IIfE7k6NDSVfhP70XS/EFjTzH040kg7nNA==
X-Received: by 2002:a05:6000:1005:b0:20a:ca74:b2c5 with SMTP id a5-20020a056000100500b0020aca74b2c5mr3725797wrx.149.1650663006665;
        Fri, 22 Apr 2022 14:30:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c4fcb00b00391447f7fd4sm2667315wmq.24.2022.04.22.14.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:06 -0700 (PDT)
Message-Id: <4b52083698cd556a05dea5ea8e18ba01ec923ffd.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:36 +0000
Subject: [PATCH v6 10/28] fsmonitor-settings: NTFS and FAT32 on MacOS are
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

On MacOS mark repos on NTFS or FAT32 volumes as incompatible.

The builtin FSMonitor used Unix domain sockets on MacOS for IPC
with clients.  These sockets are kept in the .git directory.
Unix sockets are not supported by NTFS and FAT32, so the daemon
cannot start up.

Test for this during our compatibility checking so that client
commands do not keep trying to start the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-darwin.c | 20 +++++++++++++++++---
 fsmonitor-settings.c                   |  6 ++++++
 fsmonitor-settings.h                   |  1 +
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index fdd762bf79d..efc732c0f31 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -7,7 +7,7 @@
 #include <sys/mount.h>
 
 /*
- * Remote working directories are problematic for FSMonitor.
+ * [1] Remote working directories are problematic for FSMonitor.
  *
  * The underlying file system on the server machine and/or the remote
  * mount type (NFS, SAMBA, etc.) dictates whether notification events
@@ -40,8 +40,16 @@
  *
  * So (for now at least), mark remote working directories as
  * incompatible.
+ *
+ *
+ * [2] FAT32 and NTFS working directories are problematic too.
+ *
+ * The builtin FSMonitor uses a Unix domain socket in the .git
+ * directory for IPC.  These Windows drive formats do not support
+ * Unix domain sockets, so mark them as incompatible for the daemon.
+ *
  */
-static enum fsmonitor_reason check_remote(struct repository *r)
+static enum fsmonitor_reason check_volume(struct repository *r)
 {
 	struct statfs fs;
 
@@ -60,6 +68,12 @@ static enum fsmonitor_reason check_remote(struct repository *r)
 	if (!(fs.f_flags & MNT_LOCAL))
 		return FSMONITOR_REASON_REMOTE;
 
+	if (!strcmp(fs.f_fstypename, "msdos")) /* aka FAT32 */
+		return FSMONITOR_REASON_NOSOCKETS;
+
+	if (!strcmp(fs.f_fstypename, "ntfs"))
+		return FSMONITOR_REASON_NOSOCKETS;
+
 	return FSMONITOR_REASON_OK;
 }
 
@@ -67,7 +81,7 @@ enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
 	enum fsmonitor_reason reason;
 
-	reason = check_remote(r);
+	reason = check_volume(r);
 	if (reason != FSMONITOR_REASON_OK)
 		return reason;
 
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index d2fb0141f8e..658cb79da01 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -225,6 +225,12 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
 			    _("virtual repository '%s' is incompatible with fsmonitor"),
 			    r->worktree);
 		goto done;
+
+	case FSMONITOR_REASON_NOSOCKETS:
+		strbuf_addf(&msg,
+			    _("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
+			    r->worktree);
+		goto done;
 	}
 
 	BUG("Unhandled case in fsm_settings__get_incompatible_msg: '%d'",
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index ed26ddd7ba9..2834296a1e3 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -20,6 +20,7 @@ enum fsmonitor_reason {
 	FSMONITOR_REASON_ERROR, /* FS error probing for compatibility */
 	FSMONITOR_REASON_REMOTE,
 	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
+	FSMONITOR_REASON_NOSOCKETS, /* NTFS,FAT32 do not support Unix sockets */
 };
 
 void fsm_settings__set_ipc(struct repository *r);
-- 
gitgitgadget

