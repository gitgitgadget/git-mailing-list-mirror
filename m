Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693BBC6FA83
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 13:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiI0N5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 09:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiI0N5I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 09:57:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456A813D84E
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:57:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r7so15170943wrm.2
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=6zWWUieNznYFGW+w3HU3LbxlnW1fIMIzih90XGeB7WI=;
        b=PremNVakkPlkcciJIterT+ijoxoFyh7ioHOSicwLoAITggLekWzDPIjSBTEjChBVYl
         2cNsLX4zQ06MCVGyxiLkCgrpi6yngFrDwkf3+ifgOKoRY0wfKEA3JDyly4KGhVBUlSj0
         /5w3GmGuQgmH97sg+bbl0I7dXSfqPZvAcV6xwUsDXXexc00BwiIn9GByIrPvAnSBeeBI
         h2wEdz5zGE6FtlwTr7R4gssZx0gflnPjBV/RRXdFw8gCtp2uqwjIXWUAIvBIL6L7uDZL
         l9cI6/rFrzlYW7ziYAKibYvVzvwzWACnk9Iep8GFDZ/svTdTRraQC55fNiweILvyZDeS
         v2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6zWWUieNznYFGW+w3HU3LbxlnW1fIMIzih90XGeB7WI=;
        b=skY7Y21yg779Ewt0gkKRA3hVDUmO0+baz298pBHBCpa1fuv1srxz/UyOfafrMr8LsR
         cMM4MJYVW8FXuiLn6vzJQRUw59Tj1M+Oy3UueUxLGFQBY8Yl7PsEQRmuCWfuEwIS0x1y
         C6XwhBD+CsNb/mwU24QZoCeG+uFfqPLEgRj8yAbVu5eKGMgkyDJ4jnxaDOYJnBel1FIk
         Yugdr/NGxOap2smQz+lU/yccxefRt4e7fY89S4L0T9swtXTckxDSeTJHWnFIyt9HRTrV
         L1QnLEheTDSMSfWhyRP4Td0+o/lzrGiYpKYsNn/tykWu5cys5Cs+PBAttIneIGKEjlb3
         YUEw==
X-Gm-Message-State: ACrzQf03yC4Vd8eSGcpVq3JGZQI40eBXXdk1B6/LfK0YeoTLJF2T5qtZ
        iRw/JLNNA98WeFCjohRRo5S3RmlT5fU=
X-Google-Smtp-Source: AMsMyM74MaK1dAZYl8hDPnpDE8K+ltBuAsGwgzjM2iDBiYrPAo8ONaKh2g/9/D/ackfeo+xHOWIGSw==
X-Received: by 2002:a5d:5846:0:b0:22a:f7d2:9045 with SMTP id i6-20020a5d5846000000b0022af7d29045mr17687819wrf.250.1664287025389;
        Tue, 27 Sep 2022 06:57:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003b491f99a25sm15799023wmq.22.2022.09.27.06.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:57:04 -0700 (PDT)
Message-Id: <5aa9cc1d6b93b5ad3d66ac01a4518a91ced39bcb.1664287021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1358.v4.git.1664287021.gitgitgadget@gmail.com>
References: <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
        <pull.1358.v4.git.1664287021.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 13:57:00 +0000
Subject: [PATCH v4 3/4] gc: replace config subprocesses with API calls
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'git maintenance [un]register' commands set or unset the multi-
valued maintenance.repo config key with the absolute path of the current
repository. These are set in the global config file.

Instead of calling a subcommand and creating a new process, create the
proper API calls to git_config_set_multivar_in_file_gently(). It
requires loading the filename for the global config file (and erroring
out if now $HOME value is set). We also need to be careful about using
CONFIG_REGEX_NONE when adding the value and using
CONFIG_FLAGS_FIXED_VALUE when removing the value. In both cases, we
check that the value already exists (this check already existed for
'unregister').

Also, remove the transparent translation of the error code from the
config API to the exit code of 'git maintenance'. Instead, use die() to
recover from failures at that level. In the case of 'unregister
--force', allow the CONFIG_NOTHING_SET error code to be a success. This
allows a possible race where another process removes the config value.
The end result is that the config value is not set anymore, so we can
treat this as a success.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c | 75 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index dc0ba9e3648..7a585f0b71d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1470,11 +1470,12 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_END(),
 	};
-	int rc;
+	int found = 0;
+	const char *key = "maintenance.repo";
 	char *config_value;
-	struct child_process config_set = CHILD_PROCESS_INIT;
-	struct child_process config_get = CHILD_PROCESS_INIT;
 	char *maintpath = get_maintpath();
+	struct string_list_item *item;
+	const struct string_list *list;
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_maintenance_register_usage, 0);
@@ -1491,31 +1492,35 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	else
 		git_config_set("maintenance.strategy", "incremental");
 
-	config_get.git_cmd = 1;
-	strvec_pushl(&config_get.args, "config", "--global", "--get",
-		     "--fixed-value", "maintenance.repo", maintpath, NULL);
-	config_get.out = -1;
-
-	if (start_command(&config_get)) {
-		rc = error(_("failed to run 'git config'"));
-		goto done;
+	list = git_config_get_value_multi(key);
+	if (list) {
+		for_each_string_list_item(item, list) {
+			if (!strcmp(maintpath, item->string)) {
+				found = 1;
+				break;
+			}
+		}
 	}
 
-	/* We already have this value in our config! */
-	if (!finish_command(&config_get)) {
-		rc = 0;
-		goto done;
+	if (!found) {
+		int rc;
+		char *user_config, *xdg_config;
+		git_global_config(&user_config, &xdg_config);
+		if (!user_config)
+			die(_("$HOME not set"));
+		rc = git_config_set_multivar_in_file_gently(
+			user_config, "maintenance.repo", maintpath,
+			CONFIG_REGEX_NONE, 0);
+		free(user_config);
+		free(xdg_config);
+
+		if (rc)
+			die(_("unable to add '%s' value of '%s'"),
+			    key, maintpath);
 	}
 
-	config_set.git_cmd = 1;
-	strvec_pushl(&config_set.args, "config", "--add", "--global", "maintenance.repo",
-		     maintpath, NULL);
-
-	rc = run_command(&config_set);
-
-done:
 	free(maintpath);
-	return rc;
+	return 0;
 }
 
 static char const * const builtin_maintenance_unregister_usage[] = {
@@ -1533,8 +1538,6 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		OPT_END(),
 	};
 	const char *key = "maintenance.repo";
-	int rc = 0;
-	struct child_process config_unset = CHILD_PROCESS_INIT;
 	char *maintpath = get_maintpath();
 	int found = 0;
 	struct string_list_item *item;
@@ -1557,17 +1560,27 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 	}
 
 	if (found) {
-		config_unset.git_cmd = 1;
-		strvec_pushl(&config_unset.args, "config", "--global", "--unset",
-			     "--fixed-value", key, maintpath, NULL);
-
-		rc = run_command(&config_unset);
+		int rc;
+		char *user_config, *xdg_config;
+		git_global_config(&user_config, &xdg_config);
+		if (!user_config)
+			die(_("$HOME not set"));
+		rc = git_config_set_multivar_in_file_gently(
+			user_config, key, NULL, maintpath,
+			CONFIG_FLAGS_MULTI_REPLACE | CONFIG_FLAGS_FIXED_VALUE);
+		free(user_config);
+		free(xdg_config);
+
+		if (rc &&
+		    (!force || rc == CONFIG_NOTHING_SET))
+			die(_("unable to unset '%s' value of '%s'"),
+			    key, maintpath);
 	} else if (!force) {
 		die(_("repository '%s' is not registered"), maintpath);
 	}
 
 	free(maintpath);
-	return rc;
+	return 0;
 }
 
 static const char *get_frequency(enum schedule_priority schedule)
-- 
gitgitgadget

