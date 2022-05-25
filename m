Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6957C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245021AbiEYPBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244924AbiEYPBI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846622E4
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso3513233wmn.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KflqYF0+S7RB9kOFxgFWU4lLQFA5eX5O/Scn3B7vbzU=;
        b=n08b//KAOZrttEBN+2A7dqXh6nbWbBaBcKA4z/1zviqTWQ8/dZGsjPIFprdNwQhoZx
         4hQ1xi0W08QSV45VPK3I47VGt+g3xOKX4AsSHM4+AdWjO9KkOuThvlPTcoFTdGMUT0Yk
         FIMHd4HlBd8e7gn53Wr6SJRn5pLHco9MJA7JhyoaJiTq6T1LdMcdqBVevWJ0x9GAovFc
         ibkM64rRNsWMUVdp+7+gyvA1z24jGJmEEYGQMsRJzRh55ZlxpSmdjWWKdvM6Z7a9WGqV
         d9NESC9bOVYByyr/L9j0fFdE3ST/fADuFMfDhEQANNiw9WcKrXkJlF6Ho+6wUZMT55Uy
         sLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KflqYF0+S7RB9kOFxgFWU4lLQFA5eX5O/Scn3B7vbzU=;
        b=qU8yBVelPwV60KiL/gkjAJ4mxvtQJCm8TitspBP8j6rIPpJ+1vB/yRINBWXfGjSiUs
         AYCUyz4ioCwkCRTNKNTdvjFlkE5uc2neVQ4WBNu9/m7NDSMfY7h5Ff9Jmi2dCiD9XcM3
         azXJXHn3ed/UhUsVC8r72vZBf5rkLDfjyHZUE9+4qLPIz2LFrJp6+OeY7fojiomiFoK8
         ovEnQEV+OzEeM2v/TkOJHjES1o+WAe5ILe9SalphHipZxDy+jMt/TJlvcpJnAtVfqZOW
         xq/sM9D74KMUnRqHXrmtmuUvKFFDqxh8TY+mC71sFFKSm17dBJu+7empmp4xF8n1eDXn
         E9Bw==
X-Gm-Message-State: AOAM532n3c0uhF/httkqunyRDgbLgMut5J8gGghe2n2Ja33aXfJUWlE+
        wZuA0KMlTz3pvpMSVNF7y4n6hv1UUGQ=
X-Google-Smtp-Source: ABdhPJzB6aWkpwbUdD/8Nq1sXnIOKYWIp94WlSLWKBQ6VIN352BlHHdKqJN8tSaFtCUnvaGyKWxlJQ==
X-Received: by 2002:a05:600c:3ba4:b0:397:49b8:262 with SMTP id n36-20020a05600c3ba400b0039749b80262mr8582179wms.77.1653490864660;
        Wed, 25 May 2022 08:01:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t22-20020a1c7716000000b00397381a7ae8sm1960053wmi.30.2022.05.25.08.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:04 -0700 (PDT)
Message-Id: <9774faddc45cd33362aeb1e3ea80125bc496cbc9.1653490852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:28 +0000
Subject: [PATCH v8 06/30] fsmonitor-settings: VFS for Git virtual repos are
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
index 6cb0d8e7d9f..a48802cde9c 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -17,6 +17,7 @@ enum fsmonitor_reason {
 	FSMONITOR_REASON_UNTESTED = 0,
 	FSMONITOR_REASON_OK, /* no incompatibility or when disabled */
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

