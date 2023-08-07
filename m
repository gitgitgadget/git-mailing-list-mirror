Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB1EC04A6A
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 18:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjHGSwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjHGSvw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 14:51:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CD1172B
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 11:51:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe1d9a8ec6so34440095e9.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691434306; x=1692039106;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQwFDcO2xXtiSTm+D4GflRxpp/4sU5imxOBud5LQH9Y=;
        b=b4nnqtcQYM+P8rNcAGL23DIwZQmaAF797VARtRsWkApiXkoU6XtFXXjBiE+Ax10thQ
         ntBiVeX+fPgZK32ckmdUOXuKsL6T8nr9yV4jwaXEoUQhWpjLI3mMpwztni8jyxOSqJz2
         7fGsqZ/k/LcKhadiDa08czvu71BFsXbBwZb9uJGpv/kpvV788WtgDwjJJxEUl9yDVwBE
         BjeyD+e4bj+kuYC6nhnxI7k/q2VrbHMSBqavuv4co1Hjms1V+16iTqk4A9bUPiR8Uoci
         DOOAE3nKz0U4LaJ98O1Npo+S7roASV4+KGuNUAYvhj+UbvJCirw7kh6GanPU+BluBy9C
         b5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691434306; x=1692039106;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQwFDcO2xXtiSTm+D4GflRxpp/4sU5imxOBud5LQH9Y=;
        b=TLXqPzAkPFhxULqSzYEYxNdYSuWoRQ59D3Jua3V3SI4q2JXGL7HBz6JULWil3u89sz
         h75J3XWOHX2JIFykmwV53sDCJGHawcuUUxTQ5zq3RB2SRDjpd9xzKItOQOZWLAJL+nWZ
         IeFsFFaW9V+0ZQZ+F4VAabvtL41Y+IOkP5i0NLqQcwlM0o0nA6vMw6QCe6P/e1Fo3X5+
         jCHf2KANqsqQMg+BOqvB7zH8TWnwOY+2pJQh5h0jRRfbtK1j/ft9qdI05cf2Xbv4FSPt
         8lvCtnQCykqG0ozNn6rCGtPddEkylvSobNbkMLVBQB7ACfb4i6jVAD8u+zox3eXMyp39
         ONQQ==
X-Gm-Message-State: AOJu0YwLJ7ldpvpAPuQe4Cp986oyqn9yVI9CTDa1sSNGc0N7boAllKkI
        JTXd8Yg5hWOb6Vdcik0+VnwHZKicwz4=
X-Google-Smtp-Source: AGHT+IHTA2gM3Wka6vMdyTNI9AQQo6WDOfnJJw477bp/DJ424jkqvjlrLFBZTTC2JS+LxnYtpXsZTA==
X-Received: by 2002:a05:600c:3799:b0:3fe:20f1:fb2 with SMTP id o25-20020a05600c379900b003fe20f10fb2mr6296145wmr.6.1691434305820;
        Mon, 07 Aug 2023 11:51:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8-20020a1c7208000000b003fe11148055sm11422648wmc.27.2023.08.07.11.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:51:45 -0700 (PDT)
Message-ID: <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Aug 2023 18:51:40 +0000
Subject: [PATCH 6/6] maintenance: use random minute in systemd scheduler
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The get_random_minute() method was created to allow maintenance
schedules to be fixed to a random minute of the hour. This randomness is
only intended to spread out the load from a number of clients, but each
client should have an hour between each maintenance cycle.

Add this random minute to the systemd integration.

This integration is more complicated than similar changes for other
schedulers because of a neat trick that systemd allows: templating.

The previous implementation generated two template files with names
of the form 'git-maintenance@.(timer|service)'. The '.timer' or
'.service' indicates that this is a template that is picked up when we
later specify '...@<schedule>.timer' or '...@<schedule>.service'. The
'<schedule>' string is then used to insert into the template both the
'OnCalendar' schedule setting and the '--schedule' parameter of the
'git maintenance run' command.

In order to set these schedules to a given minute, we can no longer use
the 'hourly', 'daily', or 'weekly' strings for '<schedule>' and instead
need to abandon the template model.

Modify the template with a custom schedule in the 'OnCalendar' setting.
This schedule has some interesting differences from cron-like patterns,
but is relatively easy to figure out from context. The one that might be
confusing is that '*-*-*' is a date-based pattern, but this must be
omitted when using 'Mon' to signal that we care about the day of the
week. Monday is used since that matches the day used for the 'weekly'
schedule used previously.

The rest of the change involves making sure we are writing these .timer
and .service files before initializing the schedule with 'systemctl' and
deleting the files when we are done. Some changes are also made to share
the random minute along with a single computation of the execution path
of the current Git executable.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c           | 82 ++++++++++++++++++++++++++++++++----------
 t/t7900-maintenance.sh |  4 ++-
 2 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index b3ef95b10aa..5f5bb95641f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2299,13 +2299,20 @@ static char *xdg_config_home_systemd(const char *filename)
 	return xdg_config_home_for("systemd/user", filename);
 }
 
-static int systemd_timer_write_unit_templates(const char *exec_path)
+static int systemd_timer_write_unit_template(enum schedule_priority schedule,
+					     const char *exec_path,
+					     int minute)
 {
 	char *filename;
 	FILE *file;
 	const char *unit;
+	char *schedule_pattern = NULL;
+	const char *frequency = get_frequency(schedule);
+	char *local_timer_name = xstrfmt("git-maintenance@%s.timer", frequency);
+	char *local_service_name = xstrfmt("git-maintenance@%s.service", frequency);
+
+	filename = xdg_config_home_systemd(local_timer_name);
 
-	filename = xdg_config_home_systemd("git-maintenance@.timer");
 	if (safe_create_leading_directories(filename)) {
 		error(_("failed to create directories for '%s'"), filename);
 		goto error;
@@ -2314,6 +2321,23 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
 	if (!file)
 		goto error;
 
+	switch (schedule) {
+	case SCHEDULE_HOURLY:
+		schedule_pattern = xstrfmt("*-*-* *:%02d:00", minute);
+		break;
+
+	case SCHEDULE_DAILY:
+		schedule_pattern = xstrfmt("*-*-* 0:%02d:00", minute);
+		break;
+
+	case SCHEDULE_WEEKLY:
+		schedule_pattern = xstrfmt("Mon 0:%02d:00", minute);
+		break;
+
+	default:
+		BUG("Unhandled schedule_priority");
+	}
+
 	unit = "# This file was created and is maintained by Git.\n"
 	       "# Any edits made in this file might be replaced in the future\n"
 	       "# by a Git command.\n"
@@ -2322,12 +2346,12 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
 	       "Description=Optimize Git repositories data\n"
 	       "\n"
 	       "[Timer]\n"
-	       "OnCalendar=%i\n"
+	       "OnCalendar=%s\n"
 	       "Persistent=true\n"
 	       "\n"
 	       "[Install]\n"
 	       "WantedBy=timers.target\n";
-	if (fputs(unit, file) == EOF) {
+	if (fprintf(file, unit, schedule_pattern) < 0) {
 		error(_("failed to write to '%s'"), filename);
 		fclose(file);
 		goto error;
@@ -2338,7 +2362,7 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
 	}
 	free(filename);
 
-	filename = xdg_config_home_systemd("git-maintenance@.service");
+	filename = xdg_config_home_systemd(local_service_name);
 	file = fopen_or_warn(filename, "w");
 	if (!file)
 		goto error;
@@ -2352,7 +2376,7 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
 	       "\n"
 	       "[Service]\n"
 	       "Type=oneshot\n"
-	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%i\n"
+	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%s\n"
 	       "LockPersonality=yes\n"
 	       "MemoryDenyWriteExecute=yes\n"
 	       "NoNewPrivileges=yes\n"
@@ -2362,7 +2386,7 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
 	       "RestrictSUIDSGID=yes\n"
 	       "SystemCallArchitectures=native\n"
 	       "SystemCallFilter=@system-service\n";
-	if (fprintf(file, unit, exec_path, exec_path) < 0) {
+	if (fprintf(file, unit, exec_path, exec_path, frequency) < 0) {
 		error(_("failed to write to '%s'"), filename);
 		fclose(file);
 		goto error;
@@ -2375,13 +2399,16 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
 	return 0;
 
 error:
+	free(schedule_pattern);
+	free(local_timer_name);
 	free(filename);
-	systemd_timer_delete_unit_templates();
 	return -1;
 }
 
 static int systemd_timer_enable_unit(int enable,
-				     enum schedule_priority schedule)
+				     enum schedule_priority schedule,
+				     const char *exec_path,
+				     int minute)
 {
 	const char *cmd = "systemctl";
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -2398,6 +2425,8 @@ static int systemd_timer_enable_unit(int enable,
 	 */
 	if (!enable)
 		child.no_stderr = 1;
+	else if (systemd_timer_write_unit_template(schedule, exec_path, minute))
+		return -1;
 
 	get_schedule_cmd(&cmd, NULL);
 	strvec_split(&child.args, cmd);
@@ -2420,38 +2449,53 @@ static int systemd_timer_enable_unit(int enable,
 	return 0;
 }
 
-static int systemd_timer_delete_unit_templates(void)
+static int systemd_timer_delete_unit_template(enum schedule_priority priority)
 {
+	const char *frequency = get_frequency(priority);
+	char *local_timer_name = xstrfmt("git-maintenance@%s.timer", frequency);
+	char *local_service_name = xstrfmt("git-maintenance@%s.service", frequency);
 	int ret = 0;
-	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
+	char *filename = xdg_config_home_systemd(local_timer_name);
 	if (unlink(filename) && !is_missing_file_error(errno))
 		ret = error_errno(_("failed to delete '%s'"), filename);
 	FREE_AND_NULL(filename);
 
-	filename = xdg_config_home_systemd("git-maintenance@.service");
+	filename = xdg_config_home_systemd(local_service_name);
 	if (unlink(filename) && !is_missing_file_error(errno))
 		ret = error_errno(_("failed to delete '%s'"), filename);
 
 	free(filename);
+	free(local_timer_name);
+	free(local_service_name);
 	return ret;
 }
 
+static int systemd_timer_delete_unit_templates(void)
+{
+	/* Purposefully not short-circuited to make sure all are called. */
+	return systemd_timer_delete_unit_template(SCHEDULE_HOURLY) |
+	       systemd_timer_delete_unit_template(SCHEDULE_DAILY) |
+	       systemd_timer_delete_unit_template(SCHEDULE_WEEKLY);
+}
+
 static int systemd_timer_delete_units(void)
 {
-	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY) ||
-	       systemd_timer_enable_unit(0, SCHEDULE_DAILY) ||
-	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY) ||
+	int minute = get_random_minute();
+	const char *exec_path = git_exec_path();
+	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY, exec_path, minute) ||
+	       systemd_timer_enable_unit(0, SCHEDULE_DAILY, exec_path, minute) ||
+	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY, exec_path, minute) ||
 	       systemd_timer_delete_unit_templates();
 }
 
 static int systemd_timer_setup_units(void)
 {
+	int minute = get_random_minute();
 	const char *exec_path = git_exec_path();
 
-	int ret = systemd_timer_write_unit_templates(exec_path) ||
-		  systemd_timer_enable_unit(1, SCHEDULE_HOURLY) ||
-		  systemd_timer_enable_unit(1, SCHEDULE_DAILY) ||
-		  systemd_timer_enable_unit(1, SCHEDULE_WEEKLY);
+	int ret = systemd_timer_enable_unit(1, SCHEDULE_HOURLY, exec_path, minute) ||
+		  systemd_timer_enable_unit(1, SCHEDULE_DAILY, exec_path, minute) ||
+		  systemd_timer_enable_unit(1, SCHEDULE_WEEKLY, exec_path, minute);
 	if (ret)
 		systemd_timer_delete_units();
 	return ret;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 487e326b3fa..f5a93f5aecf 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -744,7 +744,9 @@ test_expect_success 'start and stop Linux/systemd maintenance' '
 	# start registers the repo
 	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
-	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" &&
+	test_systemd_analyze_verify "systemd/user/git-maintenance@hourly.service" &&
+	test_systemd_analyze_verify "systemd/user/git-maintenance@daily.service" &&
+	test_systemd_analyze_verify "systemd/user/git-maintenance@weekly.service" &&
 
 	printf -- "--user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
 	test_cmp expect args &&
-- 
gitgitgadget
