Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9264AC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiEWUOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiEWUNq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0C8A006E
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h205-20020a1c21d6000000b003972dda143eso222269wmh.3
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gagmQdnkju4spnOwYIMQ8SdkJsvAj1+kX3+WK6gVByM=;
        b=XDx+60e6xnXxx21OKauy86Kw++5a3D8EIcA495fNDvGmEhVL1bZLjLC9aFn8Y8gkxS
         HsHFdSfqggc9wxTW7fd/IuLxRuA1zybVgUUoPWzKPJXrZKNWNGLP7h9NouHbiWk+Sz8U
         6RU0Cn/rw9kast0JcnxLl02jwRevQB9QSTPT7eTbUzCmurG8lrDKdTohZflvacQepdl0
         EM8o+1SkMldheJDSXkdigcMeGMd5mn8BP9yS7TbcE/k5mCowTRiuPxgSwdY0dAWxULUT
         uwNtEK9cZuajkUvXkIQ57M47yU3vxq3fuiVzd4vWeWfLXRjkmdSvVLZB9PiEU/h4riXE
         Ojig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gagmQdnkju4spnOwYIMQ8SdkJsvAj1+kX3+WK6gVByM=;
        b=nZn0YjZ0AWLISXNzZpLPzzozaYwaxuAdMBg7t4hMYTFSP8FvfHcOzwgL7kIAhdUiXK
         T+L97gTlHLWACGHeduB11F5QY3wPdsaSyDt5ONeLWtWL6/C+VGemT9NCnCtRQQ92Xl5d
         vA0/sNPrzr9/q0wsbdhHmJG61Tnyeq93UB/PbwQWEb9plRYVZJiAT/9hytLEzvUF+13z
         xwgXSsd+aET87LrYSg8/txtn1w30gZAMoGe7t5zm7xWLr2QMKNASGAtd+bnMMUowdc+S
         YNLqqGSJtmtQmD6jC9JPgum+l4LhJh1pSBQ4hmDxazoxcD2EC9dHWe9DaMp3KR5AkIQe
         kqLA==
X-Gm-Message-State: AOAM532nAf+j85jarkPUDgh2aUSfz+JM6iV1bw6c3EF2+h+bEIn+ne/5
        NMWE6TcDPYql+ZcDmcgZfMJy8nxgqNw=
X-Google-Smtp-Source: ABdhPJy5dej6nIu8PiKMC9+uk58tGecuWfhByHGfm8eAJdetHvNWxP5J8HvAx5GrhAd2Z4S2FpNveA==
X-Received: by 2002:a05:600c:19c8:b0:394:7cb0:717b with SMTP id u8-20020a05600c19c800b003947cb0717bmr652754wmq.136.1653336782364;
        Mon, 23 May 2022 13:13:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w24-20020a7bc758000000b0039747cf8354sm169203wmk.39.2022.05.23.13.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:01 -0700 (PDT)
Message-Id: <9a12cc78b5d16a05d4ed76cdb2a1f634ed32ef8a.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:25 +0000
Subject: [PATCH v7 10/30] fsmonitor-settings: NTFS and FAT32 on MacOS are
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
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
index afd1b3874ac..d9c2605197f 100644
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

