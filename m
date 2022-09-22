Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A22C6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 13:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiIVNi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiIVNiC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 09:38:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDA5EFF48
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 06:37:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n12so15565373wrx.9
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=qUq4NgjDUnbrks3rZFwnU7mmy3duTRI8+eqqxOpHrWM=;
        b=i20QQeqYUKXXSqt6wGzPegEmJDw+6BgHvPV9XTn2tCnHc5tiIMoRFOpJfZTFA3cMYV
         LVDGrj2z/sYgAou3vDqgep45GKtRFajnm9BCSuigv9jmpDLf+8pBW3RiAEaK8922p7ep
         7naYKt3Wz13cfTFwfQY1BjNRwSPytpCflU608Fk08PRRf6AfHktMEohIkG46Yka1/ovr
         rh7NawZ9iUmrXHzfjyC30DsEpN+T/F/APJIpTEw97NtKpsprH5NAMuDAOg2dk2PvUwmR
         Xg517kxFO1FUt1i7N0p8sHtErykdRFxdVGb1v0J3VSup8QqLM/tIYq67EFwEuBLC9X4C
         hnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qUq4NgjDUnbrks3rZFwnU7mmy3duTRI8+eqqxOpHrWM=;
        b=ZVrKmhWCz3kg/vqO9wYQIkAlRKTlnl0qwHT3lpb9j+a7saFBNlFe7+TY+QO2/P/fbS
         U0hBtqir/GJTd8kCtLt9SVlDOXn+dA/8J/qDyfF61RkuRhT5sMOMigubxJfO1QAfD/TP
         oDYVwjr6cX1NJwbyWoXmknWs6N3CANWcAQXSaoDI0B0bnLWGpZCFPiqLw87mGKsa7+Rv
         5c6O4zIJQ5Ci4IdYJQI+E08Jen3BBe4lE0sDBhTNhWFkFuG+IDRIx+SjlcgIclRYAW+N
         Xc17hq75py59Vb2aNCp7i+0g6iH2isktgECEd8QaWOHu+o9bVhLqhlV9qYuD+8VOPdqu
         AJ9w==
X-Gm-Message-State: ACrzQf0WQ6wPdil/79aT5+K4jOOoJdQE6rBPMuXpLUDtN76YD0VJk1JN
        Go/6sOBEeuyE5KNEcm7PtvKJE9rkAaQ=
X-Google-Smtp-Source: AMsMyM6I9OhREJ9as18HEYE5rt0FJcbSxcVDBF4NFn9m7bZCrpXXgF8dKnFtMFyErLc3qIwsEXrpkg==
X-Received: by 2002:a5d:6102:0:b0:228:811f:b496 with SMTP id v2-20020a5d6102000000b00228811fb496mr2194836wrt.404.1663853839761;
        Thu, 22 Sep 2022 06:37:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0022add371ed2sm5657188wrf.55.2022.09.22.06.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 06:37:19 -0700 (PDT)
Message-Id: <69c74f52eefd906c38494759a02e137e4d7c01d8.1663853837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
References: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
        <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Sep 2022 13:37:16 +0000
Subject: [PATCH v2 1/2] maintenance: add 'unregister --force'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'git maintenance unregister' subcommand has a step that removes the
current repository from the multi-valued maitenance.repo config key.
This fails if the repository is not listed in that key. This makes
running 'git maintenance unregister' twice result in a failure in the
second instance.

This failure exit code is helpful, but its message is not. Add a new
die() message that explicitly calls out the failure due to the
repository not being registered.

In some cases, users may want to run 'git maintenance unregister' just
to make sure that background jobs will not start on this repository, but
they do not want to check to see if it is registered first. Add a new
'--force' option that will siltently succeed if the repository is not
already registered.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-maintenance.txt |  6 +++++-
 builtin/gc.c                      | 31 +++++++++++++++++++++++++------
 t/t7900-maintenance.sh            |  6 +++++-
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 9c630efe19c..bb888690e4d 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git maintenance' run [<options>]
 'git maintenance' start [--scheduler=<scheduler>]
-'git maintenance' (stop|register|unregister)
+'git maintenance' (stop|register|unregister) [<options>]
 
 
 DESCRIPTION
@@ -79,6 +79,10 @@ unregister::
 	Remove the current repository from background maintenance. This
 	only removes the repository from the configured list. It does not
 	stop the background maintenance processes from running.
++
+The `unregister` subcommand will report an error if the current repository
+is not already registered. Use the `--force` option to return success even
+when the current repository is not registered.
 
 TASKS
 -----
diff --git a/builtin/gc.c b/builtin/gc.c
index 2753bd15a5e..3189b4ba2b1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1519,18 +1519,25 @@ done:
 }
 
 static char const * const builtin_maintenance_unregister_usage[] = {
-	"git maintenance unregister",
+	"git maintenance unregister [--force]",
 	NULL
 };
 
 static int maintenance_unregister(int argc, const char **argv, const char *prefix)
 {
+	int force = 0;
 	struct option options[] = {
+		OPT_BOOL(0, "force", &force,
+			 N_("return success even if repository was not registered")),
 		OPT_END(),
 	};
-	int rc;
+	const char *key = "maintenance.repo";
+	int rc = 0;
 	struct child_process config_unset = CHILD_PROCESS_INIT;
 	char *maintpath = get_maintpath();
+	int found = 0;
+	struct string_list_item *item;
+	const struct string_list *list = git_config_get_value_multi(key);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_maintenance_unregister_usage, 0);
@@ -1538,11 +1545,23 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
-	config_unset.git_cmd = 1;
-	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
-		     "--fixed-value", "maintenance.repo", maintpath, NULL);
+	for_each_string_list_item(item, list) {
+		if (!strcmp(maintpath, item->string)) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (found) {
+		config_unset.git_cmd = 1;
+		strvec_pushl(&config_unset.args, "config", "--global", "--unset",
+			     "--fixed-value", key, maintpath, NULL);
+
+		rc = run_command(&config_unset);
+	} else if (!force) {
+		die(_("repository '%s' is not registered"), maintpath);
+	}
 
-	rc = run_command(&config_unset);
 	free(maintpath);
 	return rc;
 }
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2724a44fe3e..cfe3236567a 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -493,7 +493,11 @@ test_expect_success 'register and unregister' '
 
 	git maintenance unregister &&
 	git config --global --get-all maintenance.repo >actual &&
-	test_cmp before actual
+	test_cmp before actual &&
+
+	test_must_fail git maintenance unregister 2>err &&
+	grep "is not registered" err &&
+	git maintenance unregister --force
 '
 
 test_expect_success !MINGW 'register and unregister with regex metacharacters' '
-- 
gitgitgadget

