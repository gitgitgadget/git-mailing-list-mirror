Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D876C32772
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 18:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbiHPSJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbiHPSII (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 14:08:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48553857C9
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:07:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s23so5600098wmj.4
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=UO9PcLD3ZewJQ2fh2ag8Evl2SNpCJqXyIAqqormnVzM=;
        b=NNSb/Hkvn7l1rZt0colzmGQ1z5WuZqh7kp23SzMW1EOPI17cMYXpb0m0K474rvQgGM
         aS2uDwd0jk0a80YofbuWJcXwhxAKfIekO7fNLeCjKExSLbelTTwS2yiXCa1RJGFLmfE3
         7SqTszKwBz3YREorMGzO1Z5BWxJwdDuuBlwPjsEd1kbxXfcEy6p9pJUWpuV/mvtR2X/N
         4UzftIHTe0EaQfIupf79XRwv8rJU3fur9ROJ/QOzH++5ciCXgEcaTQmBcbfAuxFgQa06
         Zygs4Mq//p4Euve7egA/Xw+jWaxQ/fjviNHbBgRq8+poCSfSsjQAqGKVTY7zVIR5lHk3
         YeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=UO9PcLD3ZewJQ2fh2ag8Evl2SNpCJqXyIAqqormnVzM=;
        b=Ogm8pTTknBUpjCq02xecjZjR+R0qrYrJaRGJyKDni9wB+fV6rxikg/BR+8Jl58MjNM
         0nJvlHzHnmGDnHPLokeI71ifooDDbLpgYvUYTvOqRbYLBR5APXVTVR7ZGM6dFkTk9c8M
         pqR6YB6vERNmXY3iesczboM4t77my3wRrR3adrje15WWVOmsKFXcNiHYL6G/ZGqbOoUt
         NiTkKFQbHpNiAig62Li1UUpxGi4gDz+cDokE3uVPmFgoZlUb1avYQ0VqlkgrCkGrCjqE
         LOMgZilp1t79slCKYc2W0Xu+GDu81Kbsl4Xlp5eFv3ec01OHpLHYkJsiuQarb1Zb8NoH
         u5EA==
X-Gm-Message-State: ACgBeo2HLnlSilF9KPvBK83qSQES1BEL/w4sChhmDBTLNwMXpR+drfie
        GQpn6xGe4DLxNWMce1Ps8/ERytT0r24=
X-Google-Smtp-Source: AA6agR6cmqYKCdC+Mb9ZF6RafkSH4+wdrgHEnZBhDYOfl4XMZcBzUAdkz7ZUWpyehEvW2ZeZHkZilQ==
X-Received: by 2002:a7b:c852:0:b0:3a5:407a:76df with SMTP id c18-20020a7bc852000000b003a5407a76dfmr13708755wml.101.1660673271602;
        Tue, 16 Aug 2022 11:07:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b003a319bd3278sm14695786wmq.40.2022.08.16.11.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:07:51 -0700 (PDT)
Message-Id: <62682ccf6964d6eebb67491db4a9476dbab56671.1660673269.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 18:07:47 +0000
Subject: [PATCH 1/3] scalar: enable built-in FSMonitor on `register`
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

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c          | 39 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh | 11 +++++++++
 2 files changed, 50 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 97e71fe19cd..219e414ab4e 100644
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
@@ -236,6 +244,34 @@ static int add_or_remove_enlistment(int add)
 		       "scalar.repo", the_repository->worktree, NULL);
 }
 
+static int start_fsmonitor_daemon(void)
+{
+	int res = 0;
+	if (fsmonitor_ipc__is_supported() &&
+	    fsmonitor_ipc__get_state() != IPC_STATE__LISTENING) {
+		struct strbuf err = STRBUF_INIT;
+		struct child_process cp = CHILD_PROCESS_INIT;
+
+		/* Try to start the FSMonitor daemon */
+		cp.git_cmd = 1;
+		strvec_pushl(&cp.args, "fsmonitor--daemon", "start", NULL);
+		if (!pipe_command(&cp, NULL, 0, NULL, 0, &err, 0)) {
+			/* Successfully started FSMonitor */
+			strbuf_release(&err);
+			return 0;
+		}
+
+		/* If FSMonitor really hasn't started, emit error */
+		if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
+			res = error(_("could not start the FSMonitor daemon: %s"),
+				    err.buf);
+
+		strbuf_release(&err);
+	}
+
+	return res;
+}
+
 static int register_dir(void)
 {
 	int res = add_or_remove_enlistment(1);
@@ -246,6 +282,9 @@ static int register_dir(void)
 	if (!res)
 		res = toggle_maintenance(1);
 
+	if (!res)
+		res = start_fsmonitor_daemon();
+
 	return res;
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

