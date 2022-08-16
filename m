Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432A5C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 23:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbiHPX6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 19:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbiHPX6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 19:58:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5446533406
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 16:58:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so1285742wms.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 16:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=T51m18gM6jdCdci0G4hYfyGQ72rqihxSl/VeB8wRe4k=;
        b=qKAjf++NAMFIMSFX+C5VEAkBGet9yB6k8VrSc8Je5nAXxYrhJe9ooHJ0jO+AI00gMw
         /jB1pbZ0U4jpBG+jzPAsauRKTSfwbsQmtpBVEXCITTqTDkOvYOZJpMIxBFtDwHOYMW0x
         efjhkPkXVlwJ4nMTw0DIkeMEa15rdH0/CVtis2g4UtHMzhNKZODW20LCDAcT9vPTOp1h
         bU0l2BoRY8sIcdmrVCj0SbgOYeVo574fZYoVOdluV6ML4OHO/PYCsnb+c2k3eoEpd8p1
         twh9PJq8Cw7hRAm6gl/+BVYGN4Y/GCN5I868dl4YgHHoN6DPbNOoU9wrYb4Yjk5OofsK
         ebZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=T51m18gM6jdCdci0G4hYfyGQ72rqihxSl/VeB8wRe4k=;
        b=tqN0F+bGh985Nlzzv8f+ZSgj1GCdg2gUowd4VuS05B1rrLAw0gYW0GdnbSLv2X3hbc
         r3wnKDCh4KbqHvyfRPNgK7MlYjOLTQQ9k28m/tEkQMvummfSGRu1EBDof3QOLKhYw/NG
         9TAzatXJSxwVrqAEjGihE6fKr9HQeA3/DolLWWP9DYSDIn5JN4w/5HxacSiR5Tpf+9Qo
         F3EJDIhyEv99vN596FdOXWoq+nIbK5tlzByxS4+oY5TZgIrJILjgN8KhFijnXdIskjqA
         OtKAmPvay+VAxgZucm4abBc7P0vS9DKQEvSQSW5pV73oMHkTHk3ZeZhFoMhZwOfi3VMa
         BsrQ==
X-Gm-Message-State: ACgBeo1ZH86dAQygVwleXlncCMPkrzSU96Xl6HVAdC8d4UmyGaE25Xr1
        mTQ0SuYoV7GnWv0b9bm6XMCwCGLbI/Q=
X-Google-Smtp-Source: AA6agR4KqjILX9iohuga8+FaubMfUOoaOPnCRshP7x7ngiPuBIXAkMRBGXC3faFfID4M8J8aPynQpg==
X-Received: by 2002:a7b:c38e:0:b0:3a5:c383:c68 with SMTP id s14-20020a7bc38e000000b003a5c3830c68mr428130wmj.163.1660694293527;
        Tue, 16 Aug 2022 16:58:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b002206236ab3dsm11342955wrr.3.2022.08.16.16.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 16:58:13 -0700 (PDT)
Message-Id: <5fdf8337972d7092aba06a9c750f42cd5868e630.1660694290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
        <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 23:58:07 +0000
Subject: [PATCH v2 3/5] scalar: enable built-in FSMonitor on `register`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Using the built-in FSMonitor makes many common commands quite a bit
faster. So let's teach the `scalar register` command to enable the
built-in FSMonitor and kick-start the fsmonitor--daemon process (for
convenience).

For simplicity, we only support the built-in FSMonitor (and no external
file system monitor such as e.g. Watchman).

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c          | 21 +++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh | 11 +++++++++++
 2 files changed, 32 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 6025cd71604..28d915ec006 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -7,6 +7,8 @@
 #include "parse-options.h"
 #include "config.h"
 #include "run-command.h"
+#include "simple-ipc.h"
+#include "fsmonitor-ipc.h"
 #include "refs.h"
 #include "dir.h"
 #include "packfile.h"
@@ -169,6 +171,12 @@ static int set_recommended_config(int reconfigure)
 		{ "core.autoCRLF", "false" },
 		{ "core.safeCRLF", "false" },
 		{ "fetch.showForcedUpdates", "false" },
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+		/*
+		 * Enable the built-in FSMonitor on supported platforms.
+		 */
+		{ "core.fsmonitor", "true" },
+#endif
 		{ NULL, NULL },
 	};
 	int i;
@@ -236,6 +244,16 @@ static int add_or_remove_enlistment(int add)
 		       "scalar.repo", the_repository->worktree, NULL);
 }
 
+static int start_fsmonitor_daemon(void)
+{
+	assert(fsmonitor_ipc__is_supported());
+
+	if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
+		return run_git("fsmonitor--daemon", "start", NULL);
+
+	return 0;
+}
+
 static int register_dir(void)
 {
 	if (add_or_remove_enlistment(1))
@@ -247,6 +265,9 @@ static int register_dir(void)
 	if (toggle_maintenance(1))
 		return error(_("could not turn on maintenance"));
 
+	if (fsmonitor_ipc__is_supported() && start_fsmonitor_daemon())
+		return error(_("could not start the FSMonitor daemon"));
+
 	return 0;
 }
 
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 10b1172a8aa..526f64d001c 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -13,10 +13,21 @@ PATH=$PWD/..:$PATH
 GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt,launchctl:true,schtasks:true"
 export GIT_TEST_MAINT_SCHEDULER
 
+test_lazy_prereq BUILTIN_FSMONITOR '
+	git version --build-options | grep -q "feature:.*fsmonitor--daemon"
+'
+
 test_expect_success 'scalar shows a usage' '
 	test_expect_code 129 scalar -h
 '
 
+test_expect_success BUILTIN_FSMONITOR 'scalar register starts fsmon daemon' '
+	git init test/src &&
+	test_must_fail git -C test/src fsmonitor--daemon status &&
+	scalar register test/src &&
+	git -C test/src fsmonitor--daemon status
+'
+
 test_expect_success 'scalar unregister' '
 	git init vanish/src &&
 	scalar register vanish/src &&
-- 
gitgitgadget

