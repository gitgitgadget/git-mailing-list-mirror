Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550D9C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbiCVSY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbiCVSYz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:24:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DC76E4DE
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so3810098wme.5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f7rf5XJgM6jW8M+rq9uT0VeICIGviBdUswkTE7UTxew=;
        b=REW/s6QoTeKzFg+vOpnsintxevGtVpm5gY9YogExAdgUj5IuJ00WXU1dfN9ibObrxq
         tD0zPaMipiqWnHSATcYwKKa7u1pHl25qe4Bcu7/ly+UYRqhEPqdp5wD+a4febxYxmAX1
         r5AOBm9mQgQgYLcO7zjp8GaX6iO71/oBuLKbgCqCeDJ4MtTfGet7P4n8eijFwdSt2Hxb
         PabM6QGvsgb/hRHvDNHpu9/T3RyZVtbYz4jF+Dz/1xEDVRarSsOOLGjZiHGfGDXgsQK7
         u+3jIlHbYTaEHMnFgRCDcA0qI7JzyRJGxMHjRszd8g+dcnPX7TbQGbLkgoWiFPeMSf9m
         +IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f7rf5XJgM6jW8M+rq9uT0VeICIGviBdUswkTE7UTxew=;
        b=j9PJZLWWGP1cOB89cWT7/AzwncDD/ooJWLhTE0IEz9iiWit8+Bf+uSUuqHfGUIUrr+
         d0AsIY9lanDY2KPAXO60XXLxSwdvyRwQK2V3qYOHanzRTxFiFMrEoszvKICIWO2q7RsO
         pQ0IbBs9zR6mF3ZkPNRm4/TZTL/sQbHgxbBmG467np/EiaSsAEi9wEU+FI/cTi69Joq6
         4tnaFSC6wcxRNxQr1N3y08Jd+X1Pxza7D/NzFul5KIDINeczA5U6G0eXwHqIXhNWUyr/
         0DPKcMbDfleRN5zVaCvPjO8YttvYtWAp5VENeQh7l+o0xKiLkLk2AFttZEtGrKcCCa5L
         eZOw==
X-Gm-Message-State: AOAM533FAkr1feUCIwQBNsMllUwywrolMM0ToJNu1Kh0N8BlSh2RMkjL
        XpFrbeRRFu3tVP8Biow6L151oHrg1nU=
X-Google-Smtp-Source: ABdhPJzfyfdflDnh06QUVKHaunFq2pr0Ezb5785K+HvtnZsk4U8pMAiR9N1x7FJB3RNjNDf3HcU2TA==
X-Received: by 2002:a05:600c:3c8b:b0:37f:1546:40c9 with SMTP id bg11-20020a05600c3c8b00b0037f154640c9mr5019530wmb.161.1647973394784;
        Tue, 22 Mar 2022 11:23:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d4348000000b00203dbfa4ff2sm16198635wrr.34.2022.03.22.11.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:13 -0700 (PDT)
Message-Id: <a8f0b2a5256932e02469051ef5aa43445af5fc03.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:37 +0000
Subject: [PATCH v3 04/27] fsmonitor-settings: bare repos are incompatible with
 FSMonitor
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

Bare repos do not have a worktree, so there is nothing for the
daemon watch.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c |  6 ++++
 builtin/update-index.c      |  4 +++
 fsmonitor-settings.c        | 60 +++++++++++++++++++++++++++++++++++++
 fsmonitor-settings.h        | 12 ++++++++
 t/t7519-status-fsmonitor.sh | 23 ++++++++++++++
 5 files changed, 105 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index a30ecf6cfac..edca8a667ab 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1450,6 +1450,12 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		die(_("invalid 'ipc-threads' value (%d)"),
 		    fsmonitor__ipc_threads);
 
+	prepare_repo_settings(the_repository);
+	fsm_settings__set_ipc(the_repository);
+
+	if (fsm_settings__error_if_incompatible(the_repository))
+		return 1;
+
 	if (!strcmp(subcmd, "start"))
 		return !!try_to_start_background_daemon();
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 876112abb21..d29048f16f2 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1237,6 +1237,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	if (fsmonitor > 0) {
 		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+
+		if (fsm_settings__error_if_incompatible(the_repository))
+			return 1;
+
 		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
 			warning(_("core.fsmonitor is unset; "
 				"set it if you really want to "
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 757d230d538..86c09bd35fe 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -9,9 +9,33 @@
  */
 struct fsmonitor_settings {
 	enum fsmonitor_mode mode;
+	enum fsmonitor_reason reason;
 	char *hook_path;
 };
 
+static void set_incompatible(struct repository *r,
+			     enum fsmonitor_reason reason)
+{
+	struct fsmonitor_settings *s = r->settings.fsmonitor;
+
+	s->mode = FSMONITOR_MODE_INCOMPATIBLE;
+	s->reason = reason;
+}
+
+static int check_for_incompatible(struct repository *r)
+{
+	if (!r->worktree) {
+		/*
+		 * Bare repositories don't have a working directory and
+		 * therefore have nothing to watch.
+		 */
+		set_incompatible(r, FSMONITOR_REASON_BARE);
+		return 1;
+	}
+
+	return 0;
+}
+
 static void lookup_fsmonitor_settings(struct repository *r)
 {
 	struct fsmonitor_settings *s;
@@ -23,6 +47,7 @@ static void lookup_fsmonitor_settings(struct repository *r)
 
 	CALLOC_ARRAY(s, 1);
 	s->mode = FSMONITOR_MODE_DISABLED;
+	s->reason = FSMONITOR_REASON_OK;
 
 	r->settings.fsmonitor = s;
 
@@ -86,6 +111,9 @@ void fsm_settings__set_ipc(struct repository *r)
 
 	lookup_fsmonitor_settings(r);
 
+	if (check_for_incompatible(r))
+		return;
+
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_IPC;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 }
@@ -97,6 +125,9 @@ void fsm_settings__set_hook(struct repository *r, const char *path)
 
 	lookup_fsmonitor_settings(r);
 
+	if (check_for_incompatible(r))
+		return;
+
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_HOOK;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 	r->settings.fsmonitor->hook_path = strdup(path);
@@ -110,5 +141,34 @@ void fsm_settings__set_disabled(struct repository *r)
 	lookup_fsmonitor_settings(r);
 
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_DISABLED;
+	r->settings.fsmonitor->reason = FSMONITOR_REASON_OK;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 }
+
+enum fsmonitor_reason fsm_settings__get_reason(struct repository *r)
+{
+	if (!r)
+		r = the_repository;
+
+	lookup_fsmonitor_settings(r);
+
+	return r->settings.fsmonitor->reason;
+}
+
+int fsm_settings__error_if_incompatible(struct repository *r)
+{
+	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
+
+	switch (reason) {
+	case FSMONITOR_REASON_OK:
+		return 0;
+
+	case FSMONITOR_REASON_BARE:
+		error(_("bare repository '%s' is incompatible with fsmonitor"),
+		      xgetcwd());
+		return 1;
+	}
+
+	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
+	    reason);
+}
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index a4c5d7b4889..8654edf33d8 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -4,11 +4,20 @@
 struct repository;
 
 enum fsmonitor_mode {
+	FSMONITOR_MODE_INCOMPATIBLE = -1, /* see _reason */
 	FSMONITOR_MODE_DISABLED = 0,
 	FSMONITOR_MODE_HOOK = 1, /* core.fsmonitor=<hook_path> */
 	FSMONITOR_MODE_IPC = 2,  /* core.fsmonitor=<true> */
 };
 
+/*
+ * Incompatibility reasons.
+ */
+enum fsmonitor_reason {
+	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
+	FSMONITOR_REASON_BARE,
+};
+
 void fsm_settings__set_ipc(struct repository *r);
 void fsm_settings__set_hook(struct repository *r, const char *path);
 void fsm_settings__set_disabled(struct repository *r);
@@ -16,6 +25,9 @@ void fsm_settings__set_disabled(struct repository *r);
 enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
 const char *fsm_settings__get_hook_path(struct repository *r);
 
+enum fsmonitor_reason fsm_settings__get_reason(struct repository *r);
+int fsm_settings__error_if_incompatible(struct repository *r);
+
 struct fsmonitor_settings;
 
 #endif /* FSMONITOR_SETTINGS_H */
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index a6308acf006..9a8e21c5608 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -55,6 +55,29 @@ test_lazy_prereq UNTRACKED_CACHE '
 	test $ret -ne 1
 '
 
+# Test that we detect and disallow repos that are incompatible with FSMonitor.
+test_expect_success 'incompatible bare repo' '
+	test_when_finished "rm -rf ./bare-clone actual expect" &&
+	git init --bare bare-clone &&
+
+	test_must_fail \
+		git -C ./bare-clone -c core.fsmonitor=foo \
+			update-index --fsmonitor 2>actual &&
+	grep "bare repository .* is incompatible with fsmonitor" actual &&
+
+	test_must_fail \
+		git -C ./bare-clone -c core.fsmonitor=true \
+			update-index --fsmonitor 2>actual &&
+	grep "bare repository .* is incompatible with fsmonitor" actual
+'
+
+test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
+	test_when_finished "rm -rf ./bare-clone actual" &&
+	git init --bare bare-clone &&
+	test_must_fail git -C ./bare-clone fsmonitor--daemon run 2>actual &&
+	grep "bare repository .* is incompatible with fsmonitor" actual
+'
+
 test_expect_success 'setup' '
 	mkdir -p .git/hooks &&
 	: >tracked &&
-- 
gitgitgadget

