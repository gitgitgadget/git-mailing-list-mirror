Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AEFC433FE
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiDVWjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiDVWh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9D71BA80B
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so6076419wms.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S8QsKgIt0qJeuNmuP99HHBXvJVsQfMKbSpDGpqET4/c=;
        b=m3ywAxwia5K62SCtl4YvsbKJ7NaKOpSpq1lPPLkhiKgCCPcWuiIDK7+z9FnHiYEOj1
         jlckAPmhX+Oj6eWpGruyTvW6m25G4AMWYq9+OEtK2hAQ34KuWvnQxcJyDB4HgS3+ond2
         38wjhb+QwuHeAfVFeKd7jKrm6Mts3vTHifF9A4+8MhOq6a+q/mWC7Ca9GmVYDbX8aBMg
         V5MJk4LlKhX3t9vglCKxSx7E2f9GlpBwloi0vz9sh/92dciKbWg2O9+Jn/8Wf7PIrf3Z
         1WC+aKakmOLBmG8C4uIZBsoM0J1AHpIaCpl9nO8SmsTy6r12MfbCGKQsXXGaZvo9b+4T
         kfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S8QsKgIt0qJeuNmuP99HHBXvJVsQfMKbSpDGpqET4/c=;
        b=i/MbsCi+jmPGo1lau0AS8e48o+9EjyzhRsNrRz2PWSkdK8QxGL5SFhjyycLFvGpjku
         FQRnejRJ5toQcH7L7oDmrVslJyAUbMl2yO1Ju/IJPgxd5NRIwCn5ERciKOg9GzM9bN5r
         nLph1nuYUSE6Jq9gqEAA3O1OWiJkzp9W3yPmmJVGCjI2Dp1IrkMU4qr2mTc40Mj26H0L
         5YQ8WIiIcyRK7HymRqXP4fwfGUkT6QfDBJxPkgD+hrnYAxlcKvJW7E/di9vmoj3XvWrh
         HZuEAjbLIjHF54rBQGpJEpm2sTged2iDJriZ2afFUqhnf1ypLqUStR+nOEKANHZdYQpV
         a9LQ==
X-Gm-Message-State: AOAM5329VVs6cPb9aNpUrjix9ydeiWaxSKkhV0/ZqPfbsCKNZi2sX5Y7
        I6LkjFPHN49b/JaVA+Z5xlHHpU9iSrM=
X-Google-Smtp-Source: ABdhPJxzzHo2PnMQ3LeF9Y7OVaE9SuU7ZRzLGx2JuMy2bN7B7pZdX8SHzoiJFMUCHTZbB4L5sBbF/g==
X-Received: by 2002:a05:600c:1e89:b0:390:ba57:81c6 with SMTP id be9-20020a05600c1e8900b00390ba5781c6mr5962860wmb.29.1650663002451;
        Fri, 22 Apr 2022 14:30:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3-20020a5d6c63000000b0020a94e82a3dsm2687379wrz.64.2022.04.22.14.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:01 -0700 (PDT)
Message-Id: <e0d3bdf7556f8315378c09f6d741a5f56c01c40c.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:32 +0000
Subject: [PATCH v6 06/28] fsmonitor-settings: VFS for Git virtual repos are
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

VFS for Git virtual repositories are incompatible with FSMonitor.

VFS for Git is a downstream fork of Git.  It contains its own custom
file system watcher that is aware of the virtualization.  If a working
directory is being managed by VFS for Git, we should not try to watch
it because we may get incomplete results.

We do not know anything about how VFS for Git works, but we do
know that VFS for Git working directories contain a well-defined
config setting.  If it is set, mark the working directory as
incompatible.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-win32.c | 26 ++++++++++++++++++++++++++
 fsmonitor-settings.c                  |  6 ++++++
 fsmonitor-settings.h                  |  1 +
 t/t7519-status-fsmonitor.sh           |  9 +++++++++
 4 files changed, 42 insertions(+)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index 7fce32a3c5b..ee78bba38e3 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -3,7 +3,33 @@
 #include "repository.h"
 #include "fsmonitor-settings.h"
 
+/*
+ * VFS for Git is incompatible with FSMonitor.
+ *
+ * Granted, core Git does not know anything about VFS for Git and we
+ * shouldn't make assumptions about a downstream feature, but users
+ * can install both versions.  And this can lead to incorrect results
+ * from core Git commands.  So, without bringing in any of the VFS for
+ * Git code, do a simple config test for a published config setting.
+ * (We do not look at the various *_TEST_* environment variables.)
+ */
+static enum fsmonitor_reason check_vfs4git(struct repository *r)
+{
+	const char *const_str;
+
+	if (!repo_config_get_value(r, "core.virtualfilesystem", &const_str))
+		return FSMONITOR_REASON_VFS4GIT;
+
+	return FSMONITOR_REASON_OK;
+}
+
 enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
+	enum fsmonitor_reason reason;
+
+	reason = check_vfs4git(r);
+	if (reason != FSMONITOR_REASON_OK)
+		return reason;
+
 	return FSMONITOR_REASON_OK;
 }
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index f67db913f57..600ae165ab1 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -207,6 +207,12 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
 			    _("bare repository '%s' is incompatible with fsmonitor"),
 			    xgetcwd());
 		goto done;
+
+	case FSMONITOR_REASON_VFS4GIT:
+		strbuf_addf(&msg,
+			    _("virtual repository '%s' is incompatible with fsmonitor"),
+			    r->worktree);
+		goto done;
 	}
 
 	BUG("Unhandled case in fsm_settings__get_incompatible_msg: '%d'",
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index 1694b7091a2..9e483c14513 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -17,6 +17,7 @@ enum fsmonitor_reason {
 	FSMONITOR_REASON_UNTESTED = 0,
 	FSMONITOR_REASON_OK, /* no incompatibility or when disbled */
 	FSMONITOR_REASON_BARE,
+	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
 };
 
 void fsm_settings__set_ipc(struct repository *r);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 9a8e21c5608..156895f9437 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -78,6 +78,15 @@ test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
 	grep "bare repository .* is incompatible with fsmonitor" actual
 '
 
+test_expect_success MINGW,FSMONITOR_DAEMON 'run fsmonitor-daemon in virtual repo' '
+	test_when_finished "rm -rf ./fake-virtual-clone actual" &&
+	git init fake-virtual-clone &&
+	test_must_fail git -C ./fake-virtual-clone \
+			   -c core.virtualfilesystem=true \
+			   fsmonitor--daemon run 2>actual &&
+	grep "virtual repository .* is incompatible with fsmonitor" actual
+'
+
 test_expect_success 'setup' '
 	mkdir -p .git/hooks &&
 	: >tracked &&
-- 
gitgitgadget

