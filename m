Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E65C433FE
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382153AbiDTUqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382127AbiDTUqP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886A938D8D
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so3826445wrg.12
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XEOJPlnBxdyHowBZdh3y4jZnw2C/J1d1GlvxDT+qV1c=;
        b=Yu8SNyL6RmGKK5hZjWU2AtOrvkeudmNaSOr1vSGy1yDsnHWdQx5FgU7c3bfL2hYSuQ
         +XE2A9X/pPY6N99qWoqXGrAhmSQPfbomrXucS+/Gy3NMm+OMt7w/lpdTyEaf/FJqdLzj
         4n4NZxKr21vDTV38WwIYylh1UKwhdy57B9jHG0fys5zRierXSSQfWOnUzcD9pxW7UomD
         A3Oo+wYHQcQ5uNA8eTlRCHTJ+zBGwVXjeePXzXknMLprk0RIduF6I8xNxrCtUDDUARn3
         TVG+rprO0TNOrR36x+lGM59uSj6osZ09pPmhBej4N2caqawfQNyMbHKVxL1kWf8YAeC4
         f8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XEOJPlnBxdyHowBZdh3y4jZnw2C/J1d1GlvxDT+qV1c=;
        b=Eeeq0SSStmygZNv2nXux0yg2wfZ6pp0XMcv3xL1vL+gk8I/DQ5rvOewq1EluHJSKxO
         iqtFx510nGnGq3p6Kb4NQx30V6rQSzF/qHg6bdJ58VjuNg05ZjEQ8m7N+xctvMhxjjYa
         0H3iD4oNOclbV+3lNvAPQX5xvRhjlLWQvQHtpqeMKbFHf6nkJJ4gfS58o0X6IXXmeTZM
         2wCKVchkww/0rUMuB8hUuDfYLNUwb3+cYmYn4oYaHbBmdP9yRN+QwkPT/LfbSEOWKnvQ
         5t2hiYpOCbGxQWbExvqB4pOil1Fa88RImGKM/aWoNlpG84CcUeGUCNiVrShs/r8IXgpv
         u0SA==
X-Gm-Message-State: AOAM533jh1mG7FGEgRQqVySBpPmHUmnHDUdFrk0my2OS9H0JWJTwO+M7
        rHVJrBj+rxaskVo96GGClbgvZH1rJ9U=
X-Google-Smtp-Source: ABdhPJzs3Syf64KliF9NpAZM1fb2gRIDrMDWtWZGjr9YpL4XDqvTzr6OSi/1aNUC+JyKO8OdaM1I5g==
X-Received: by 2002:adf:d235:0:b0:207:9c11:c8c7 with SMTP id k21-20020adfd235000000b002079c11c8c7mr16662267wrh.443.1650487406719;
        Wed, 20 Apr 2022 13:43:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b003928959f92dsm383615wmq.2.2022.04.20.13.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:26 -0700 (PDT)
Message-Id: <004b67b62e3717c9daeb6dcda1e9d84d44fa4984.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:42:54 +0000
Subject: [PATCH v5 04/28] fsmonitor-settings: bare repos are incompatible with
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
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
 builtin/fsmonitor--daemon.c |  6 ++++
 builtin/update-index.c      |  4 +++
 fsmonitor-settings.c        | 60 +++++++++++++++++++++++++++++++++++++
 fsmonitor-settings.h        | 12 ++++++++
 t/t7519-status-fsmonitor.sh | 23 ++++++++++++++
 5 files changed, 105 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 46be55a4618..50ae3cca575 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1449,6 +1449,12 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
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

