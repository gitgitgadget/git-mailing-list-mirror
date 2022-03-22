Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD02C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbiCVSZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbiCVSYz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:24:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7949E1FCE5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i186so2473274wma.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ekJrkqFg1yJzdNh+egoYJeP3EUXrY0TIhPEKqSMHHf8=;
        b=YEYQkxVEXHurfr0DMuHdVPtfOOMrXIk5ki9NQJSEA6hrd+Bi4dEXLP0u2OdrDPwCNN
         M2r4/ItkCl54aqAnCVxL4+pN9P4J/GD8RlkeHqRx5RDe5pHRe+1zJlHV88Gqwzl0D5kD
         9RevwAw/wvsjUCNYzmqZpf3r7zj5sHQ2B2QdaUBo4FG/LXD1jKU95w8uUt4DXN/8tWg0
         yepoSuyXUD3BnAAht/DD3EU9LcHP72n2IGJwLMDUt5apXA+x9CGUcTRrrQuDpSm/pZtg
         b33NjjNA8Ez81UrhX4tDx/1hn7f7DKmwtZvWd8c+F+QDR9jJHnhPaIlR+BlcFXOFujpc
         DfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ekJrkqFg1yJzdNh+egoYJeP3EUXrY0TIhPEKqSMHHf8=;
        b=CjuclAdzLVGWgrM98QogxfQCEN15vfvdsEEyxRMYlaIEw7WD5k4f/juEtSpeeT4pnC
         DwvODKzXVGmrgRJYO35GgCgemyq+8zVooJIhVuvaKQzNK1EGlpco49mmixkgGXr8JXQv
         DsU1uPzykX19jfEAtBncBS6qxKHmO03WjZImzvnmWOQQg7xMWnZNl59oKy++N7/2Otzq
         PfR573erqX10EIpXtDRML243nL/JaVNTwlhDr8l2JXpalDIjkrMFbuZKNfhqiSoVtzIR
         oEQi48zqcJVTe7LA1/dptwmjdxOZrMcE2xMlO/OHztBJoSJ6eI0/b1O/Nor3qLKB5PXf
         Ee1A==
X-Gm-Message-State: AOAM530KCdaGYfRfNPkVhk2Gj3xelqmMMJnYr9UW6+sYP5Yiwg3Tm9fF
        8d6EXyXsJCBJ58m/YjVdZa5RnxygkeI=
X-Google-Smtp-Source: ABdhPJwldKXQC5OZCvMEQmaQrrLyEhbs/oLuAEuJXWP5FVgbjiO97v9Cpr4st4HyMhrPqvNpz5z2dw==
X-Received: by 2002:a05:600c:ca:b0:38c:b426:3124 with SMTP id u10-20020a05600c00ca00b0038cb4263124mr5181052wmm.59.1647973398060;
        Tue, 22 Mar 2022 11:23:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b00203da1fa749sm28498072wry.72.2022.03.22.11.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:16 -0700 (PDT)
Message-Id: <5546339d963caf37828da4b32deb896162cd5db9.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:39 +0000
Subject: [PATCH v3 06/27] fsmonitor-settings: VFS for Git virtual repos are
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
 fsmonitor-settings.c                  |  5 +++++
 fsmonitor-settings.h                  |  1 +
 t/t7519-status-fsmonitor.sh           |  9 +++++++++
 4 files changed, 41 insertions(+)

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
index 8ff55f8c3fd..1efb6e17a20 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -179,6 +179,11 @@ int fsm_settings__error_if_incompatible(struct repository *r)
 		error(_("bare repository '%s' is incompatible with fsmonitor"),
 		      xgetcwd());
 		return 1;
+
+	case FSMONITOR_REASON_VFS4GIT:
+		error(_("virtual repository '%s' is incompatible with fsmonitor"),
+		      r->worktree);
+		return 1;
 	}
 
 	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index 4b35f051fb1..6361fcbf6b0 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -16,6 +16,7 @@ enum fsmonitor_mode {
 enum fsmonitor_reason {
 	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
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

