Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BDCC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350662AbiCHWQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350643AbiCHWQd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:33 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B6C56220
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h15so249007wrc.6
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tYMNxNOQocQ5cxp9AH3AWwQ4szZPjiifBMV3x37TQAg=;
        b=Ia/De43UM+wILTZoUl8LBsC3Q20B9/qp2kTJ9c0G0I+8yi+QJ7mLUV741w6pmj/ahQ
         ByQvpNyf8zRHiy5UatqO/aBqe7zO/Urw/v5pyG21loENY9ayRMZIPGyaNfB/qzrs9JGe
         m1AN05dDLPCwAVfTOq3imCCVnnaUiCKpYiJWADesVks9B/0DcSWVAkAZ7Hoyb8KgRqxH
         WQLP1OeBpQynon5SXfzYmN8Yjs439JiLaLdJRB7C/93xldTGhZZRwybkuda6R9GHi6bk
         tzrfIAX8hisOFvqyyVQW1o7Uqh1Vq6CVpYzcqoqK2Lun4ILghVlAIu+yrusAVmO1Ml7z
         yADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tYMNxNOQocQ5cxp9AH3AWwQ4szZPjiifBMV3x37TQAg=;
        b=BGvahRL0qeigGxtksaTE4YWms6TzdTN7KrBlVuqDGbQUNR0EhKq9tHTTBnh9yz4Zl7
         Qfkjhw/8XB6HFu4f0h0IZQWXgbVnDoWETIdbR0k+iyQt1Xiqe/hwfKyssxj+qvuzk93F
         W7/w1PurUsX+U4xVIPOLGBWLikSCCRL6JvX0tezLjIJj30GjWqdBYVAHAPyC8b69s00k
         VrBlQghFu3RO8L7SchMW8HQF3tgXVAKFrc70NqKfwMm3SZ31o7PkbGb8+Xgo1jZXZ9De
         eXRIovj9WQmWxR3PJCRSrocomccFoiRpvELVQ41a0Hg5dXux/kzmFwVX3D88UTbOTD0L
         ELfw==
X-Gm-Message-State: AOAM530rak3S4xtOgeXgKABLKxZHKwcdb8H/PWwK08TLz7wEjxRCvIkE
        f6pzuCK7UoSYzaoW9JX8+mxqa0Ax3Is=
X-Google-Smtp-Source: ABdhPJwhRmKIz39e+uQtdDVwpkvOp7xuB66Wo7QUCcGzVSlibw6DLPgkqH6+x1YBgkvpPFoSzkvD/w==
X-Received: by 2002:a05:6000:1204:b0:1f1:e689:4c88 with SMTP id e4-20020a056000120400b001f1e6894c88mr11422530wrx.140.1646777734716;
        Tue, 08 Mar 2022 14:15:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15-20020adfc74f000000b001e888b871a0sm89780wrh.87.2022.03.08.14.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:34 -0800 (PST)
Message-Id: <8c4f90ae4fd5d9fbac9acb9307ee82ceffc7df08.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:04 +0000
Subject: [PATCH v2 04/27] fsmonitor-settings: bare repos are incompatible with
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
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Bare repos do not have a worktree, so there is nothing for the
daemon watch.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c |  9 ++++++
 builtin/update-index.c      |  7 +++++
 fsmonitor-settings.c        | 57 +++++++++++++++++++++++++++++++++++++
 fsmonitor-settings.h        | 12 ++++++++
 t/t7519-status-fsmonitor.sh | 23 +++++++++++++++
 5 files changed, 108 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 97ca2a356e5..00eaffbb945 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1443,6 +1443,15 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		die(_("invalid 'ipc-threads' value (%d)"),
 		    fsmonitor__ipc_threads);
 
+	prepare_repo_settings(the_repository);
+	fsm_settings__set_ipc(the_repository);
+
+	if (fsm_settings__get_mode(the_repository) == FSMONITOR_MODE_INCOMPATIBLE) {
+		const char *msg = fsm_settings__get_reason_msg(the_repository);
+
+		return error("%s '%s'", msg ? msg : "???", xgetcwd());
+	}
+
 	if (!strcmp(subcmd, "start"))
 		return !!try_to_start_background_daemon();
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index d335f1ac72a..8f460e7195f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1237,6 +1237,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	if (fsmonitor > 0) {
 		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+
+		if (fsm_mode == FSMONITOR_MODE_INCOMPATIBLE) {
+			const char *msg = fsm_settings__get_reason_msg(r);
+
+			return error("%s '%s'", msg ? msg : "???", xgetcwd());
+		}
+
 		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
 			advise(_("core.fsmonitor is unset; "
 				 "set it if you really want to "
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 3b54e7a51f6..8410cc73404 100644
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
@@ -87,6 +111,9 @@ void fsm_settings__set_ipc(struct repository *r)
 
 	lookup_fsmonitor_settings(r);
 
+	if (check_for_incompatible(r))
+		return;
+
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_IPC;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 }
@@ -98,6 +125,9 @@ void fsm_settings__set_hook(struct repository *r, const char *path)
 
 	lookup_fsmonitor_settings(r);
 
+	if (check_for_incompatible(r))
+		return;
+
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_HOOK;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 	r->settings.fsmonitor->hook_path = strdup(path);
@@ -111,5 +141,32 @@ void fsm_settings__set_disabled(struct repository *r)
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
+const char *fsm_settings__get_reason_msg(struct repository *r)
+{
+	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
+
+	switch (reason) {
+	case FSMONITOR_REASON_OK:
+		return NULL;
+
+	case FSMONITOR_REASON_BARE:
+		return _("bare repos are incompatible with fsmonitor");
+	}
+
+	BUG("Unhandled case in fsm_settings__get_reason_msg '%d'",
+	    reason);
+}
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index a4c5d7b4889..a1af058a287 100644
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
+const char *fsm_settings__get_reason_msg(struct repository *r);
+
 struct fsmonitor_settings;
 
 #endif /* FSMONITOR_SETTINGS_H */
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index a6308acf006..cf258d88f04 100755
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
+	grep "bare repos are incompatible with fsmonitor" actual &&
+
+	test_must_fail \
+		git -C ./bare-clone -c core.fsmonitor=true \
+			update-index --fsmonitor 2>actual &&
+	grep "bare repos are incompatible with fsmonitor" actual
+'
+
+test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
+	test_when_finished "rm -rf ./bare-clone actual" &&
+	git init --bare bare-clone &&
+	test_must_fail git -C ./bare-clone fsmonitor--daemon run 2>actual &&
+	grep "bare repos are incompatible with fsmonitor" actual
+'
+
 test_expect_success 'setup' '
 	mkdir -p .git/hooks &&
 	: >tracked &&
-- 
gitgitgadget

