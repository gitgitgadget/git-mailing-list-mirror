Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87DAC04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjHJUkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbjHJUj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:39:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156CB273D
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c1d03e124so179382566b.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691699993; x=1692304793;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duEhc3o+W7MvFcEFf/jVdLaY6ZyFTD0tk+JaqYEJ/gs=;
        b=n/y1/K5/en6YYUNw2ZhlD8aT/xJw2ezWEY8cNLFxeAUd/BQL0jcMeRpL9vEIBucFjf
         OllrTNu+3zhK4M90t8NUUqT9Obl9M/Uzzz7T92ZDSDYH3OT0jt5bIiDcD+7R2af6uT3H
         JNCFHoU9j2sLEltBw0S7WMI6UO3jJttRqsENtCI21cVL2FBBSZjEZC8iDLV5h4ss1kzx
         EQQh4h3QT3VHfNIz7Cf6JZDHrz/iTOFSjJpDqXzUlkFZooiqDRsDLtfkfjBwXFs6V+3D
         /hAyVTyNJSqGbXhxVvLSs6avSbItGWMGc11N7zgRzwxjrAd7eholclXPTnq7diLVmN6i
         MyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699993; x=1692304793;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duEhc3o+W7MvFcEFf/jVdLaY6ZyFTD0tk+JaqYEJ/gs=;
        b=NZzEWT2ygCPbEogiYstYefSmOlRV9engPa0keh3DzsXotOXCtX9EjvSMI/RPBpiOVN
         gpzVE3ws9YFRnFSD4j6tEA+d9lo1VSIDpPWjSdtqXnlEKYGOFzz9uUKfcT4Ht5kyNZU1
         DHYtOQRTIeBo82DpJtlwGAuKWUgo9gYLR7Lmunv6x+SFYuGlodiudh2Yb8HNwBWc8v3s
         Nae4H/dPGbTuxXxFrd1pyvyEGv+Rd69OUL7vy0QTJG3FJnUF/9JfxJRcbSAz85WCyICD
         7vkag+g6o4zAVfDgala6l/Y5M+L9DewbOEq5pRextuilqxoigJssRjWe51B83AD918Dq
         N+Cw==
X-Gm-Message-State: AOJu0YycwQH1CupU6B2JnsrbU0zqcEy3H1vnzcEwq17Z1XATnKcLCUEy
        x+WKYt8KGYFYEkj1mtZMfcOTn7OEwuQ=
X-Google-Smtp-Source: AGHT+IERfVdjjzZwSDKeLXM61etrV7aqsbKEjR3KndkDjtnnpADhUOcEMAXmo2nFfilTJqafIC8H+w==
X-Received: by 2002:a17:907:7843:b0:99d:13f:d85f with SMTP id lb3-20020a170907784300b0099d013fd85fmr2961589ejc.61.1691699993312;
        Thu, 10 Aug 2023 13:39:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r5-20020a1709067fc500b0099bc80d5575sm1365554ejs.200.2023.08.10.13.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:39:52 -0700 (PDT)
Message-ID: <e43778d3e408f5a77b01bce13df6f8b037473cc3.1691699987.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
        <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 20:39:45 +0000
Subject: [PATCH v2 6/8] maintenance: use random minute in systemd scheduler
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
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
need to abandon the template model for the .timer files. We can still
use templates for the .service files. For this reason, we split these
writes into two methods.

Modify the template with a custom schedule in the 'OnCalendar' setting.
This schedule has some interesting differences from cron-like patterns,
but is relatively easy to figure out from context. The one that might be
confusing is that '*-*-*' is a date-based pattern, but this must be
omitted when using 'Mon' to signal that we care about the day of the
week. Monday is used since that matches the day used for the 'weekly'
schedule used previously.

Now that the timer files are not templates, we might want to abandon the
'@' symbol in the file names. However, this would cause users with
existing schedules to get two competing schedules due to different
names. The work to remove the old schedule name is one thing that we can
avoid by keeping the '@' symbol in our unit names. Since we are locked
into this name, it makes sense that we keep the template model for the
.service files.

The rest of the change involves making sure we are writing these .timer
and .service files before initializing the schedule with 'systemctl' and
deleting the files when we are done. Some changes are also made to share
the random minute along with a single computation of the execution path
of the current Git executable.

In addition, older Git versions may have written a
'git-maintenance@.timer' template file. Be sure to remove this when
successfully enabling maintenance (or disabling maintenance).

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c           | 152 ++++++++++++++++++++++++++++++++++-------
 t/t7900-maintenance.sh |  15 +++-
 2 files changed, 142 insertions(+), 25 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e3819fc285a..e52129e485c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2292,29 +2292,54 @@ static char *xdg_config_home_systemd(const char *filename)
 	return xdg_config_home_for("systemd/user", filename);
 }
 
-static int systemd_timer_delete_unit_templates(void)
+#define SYSTEMD_UNIT_FORMAT "git-maintenance@%s.%s"
+
+static int systemd_timer_delete_timer_file(enum schedule_priority priority)
 {
 	int ret = 0;
-	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
+	const char *frequency = get_frequency(priority);
+	char *local_timer_name = xstrfmt(SYSTEMD_UNIT_FORMAT, frequency, "timer");
+	char *filename = xdg_config_home_systemd(local_timer_name);
+
 	if (unlink(filename) && !is_missing_file_error(errno))
 		ret = error_errno(_("failed to delete '%s'"), filename);
-	FREE_AND_NULL(filename);
 
-	filename = xdg_config_home_systemd("git-maintenance@.service");
+	free(filename);
+	free(local_timer_name);
+	return ret;
+}
+
+static int systemd_timer_delete_service_template(void)
+{
+	int ret = 0;
+	char *local_service_name = xstrfmt(SYSTEMD_UNIT_FORMAT, "", "service");
+	char *filename = xdg_config_home_systemd(local_service_name);
 	if (unlink(filename) && !is_missing_file_error(errno))
 		ret = error_errno(_("failed to delete '%s'"), filename);
 
 	free(filename);
+	free(local_service_name);
 	return ret;
 }
 
-static int systemd_timer_write_unit_templates(const char *exec_path)
+/*
+ * Write the schedule information into a git-maintenance@<schedule>.timer
+ * file using a custom minute. This timer file cannot use the templating
+ * system, so we generate a specific file for each.
+ */
+static int systemd_timer_write_timer_file(enum schedule_priority schedule,
+					  int minute)
 {
+	int res = -1;
 	char *filename;
 	FILE *file;
 	const char *unit;
+	char *schedule_pattern = NULL;
+	const char *frequency = get_frequency(schedule);
+	char *local_timer_name = xstrfmt(SYSTEMD_UNIT_FORMAT, frequency, "timer");
+
+	filename = xdg_config_home_systemd(local_timer_name);
 
-	filename = xdg_config_home_systemd("git-maintenance@.timer");
 	if (safe_create_leading_directories(filename)) {
 		error(_("failed to create directories for '%s'"), filename);
 		goto error;
@@ -2323,6 +2348,23 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
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
@@ -2331,12 +2373,12 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
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
@@ -2345,9 +2387,36 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
 		error_errno(_("failed to flush '%s'"), filename);
 		goto error;
 	}
+
+	res = 0;
+
+error:
+	free(schedule_pattern);
+	free(local_timer_name);
 	free(filename);
+	return res;
+}
 
-	filename = xdg_config_home_systemd("git-maintenance@.service");
+/*
+ * No matter the schedule, we use the same service and can make use of the
+ * templating system. When installing git-maintenance@<schedule>.timer,
+ * systemd will notice that git-maintenance@.service exists as a template
+ * and will use this file and insert the <schedule> into the template at
+ * the position of "%i".
+ */
+static int systemd_timer_write_service_template(const char *exec_path)
+{
+	int res = -1;
+	char *filename;
+	FILE *file;
+	const char *unit;
+	char *local_service_name = xstrfmt(SYSTEMD_UNIT_FORMAT, "", "service");
+
+	filename = xdg_config_home_systemd(local_service_name);
+	if (safe_create_leading_directories(filename)) {
+		error(_("failed to create directories for '%s'"), filename);
+		goto error;
+	}
 	file = fopen_or_warn(filename, "w");
 	if (!file)
 		goto error;
@@ -2380,17 +2449,18 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
 		error_errno(_("failed to flush '%s'"), filename);
 		goto error;
 	}
-	free(filename);
-	return 0;
+
+	res = 0;
 
 error:
+	free(local_service_name);
 	free(filename);
-	systemd_timer_delete_unit_templates();
-	return -1;
+	return res;
 }
 
 static int systemd_timer_enable_unit(int enable,
-				     enum schedule_priority schedule)
+				     enum schedule_priority schedule,
+				     int minute)
 {
 	const char *cmd = "systemctl";
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -2407,12 +2477,14 @@ static int systemd_timer_enable_unit(int enable,
 	 */
 	if (!enable)
 		child.no_stderr = 1;
+	else if (systemd_timer_write_timer_file(schedule, minute))
+		return -1;
 
 	get_schedule_cmd(&cmd, NULL);
 	strvec_split(&child.args, cmd);
 	strvec_pushl(&child.args, "--user", enable ? "enable" : "disable",
 		     "--now", NULL);
-	strvec_pushf(&child.args, "git-maintenance@%s.timer", frequency);
+	strvec_pushf(&child.args, SYSTEMD_UNIT_FORMAT, frequency, "timer");
 
 	if (start_command(&child))
 		return error(_("failed to start systemctl"));
@@ -2429,24 +2501,58 @@ static int systemd_timer_enable_unit(int enable,
 	return 0;
 }
 
+/*
+ * A previous version of Git wrote the timer units as template files.
+ * Clean these up, if they exist.
+ */
+static void systemd_timer_delete_stale_timer_templates(void)
+{
+	char *timer_template_name = xstrfmt(SYSTEMD_UNIT_FORMAT, "", "timer");
+	char *filename = xdg_config_home_systemd(timer_template_name);
+
+	if (unlink(filename) && !is_missing_file_error(errno))
+		warning(_("failed to delete '%s'"), filename);
+
+	free(filename);
+	free(timer_template_name);
+}
+
+static int systemd_timer_delete_unit_files(void)
+{
+	systemd_timer_delete_stale_timer_templates();
+
+	/* Purposefully not short-circuited to make sure all are called. */
+	return systemd_timer_delete_timer_file(SCHEDULE_HOURLY) |
+	       systemd_timer_delete_timer_file(SCHEDULE_DAILY) |
+	       systemd_timer_delete_timer_file(SCHEDULE_WEEKLY) |
+	       systemd_timer_delete_service_template();
+}
+
 static int systemd_timer_delete_units(void)
 {
-	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY) ||
-	       systemd_timer_enable_unit(0, SCHEDULE_DAILY) ||
-	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY) ||
-	       systemd_timer_delete_unit_templates();
+	int minute = get_random_minute();
+	/* Purposefully not short-circuited to make sure all are called. */
+	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY, minute) |
+	       systemd_timer_enable_unit(0, SCHEDULE_DAILY, minute) |
+	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY, minute) |
+	       systemd_timer_delete_unit_files();
 }
 
 static int systemd_timer_setup_units(void)
 {
+	int minute = get_random_minute();
 	const char *exec_path = git_exec_path();
 
-	int ret = systemd_timer_write_unit_templates(exec_path) ||
-		  systemd_timer_enable_unit(1, SCHEDULE_HOURLY) ||
-		  systemd_timer_enable_unit(1, SCHEDULE_DAILY) ||
-		  systemd_timer_enable_unit(1, SCHEDULE_WEEKLY);
+	int ret = systemd_timer_write_service_template(exec_path) ||
+		  systemd_timer_enable_unit(1, SCHEDULE_HOURLY, minute) ||
+		  systemd_timer_enable_unit(1, SCHEDULE_DAILY, minute) ||
+		  systemd_timer_enable_unit(1, SCHEDULE_WEEKLY, minute);
+
 	if (ret)
 		systemd_timer_delete_units();
+	else
+		systemd_timer_delete_stale_timer_templates();
+
 	return ret;
 }
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 487e326b3fa..9ffe76729e6 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -744,7 +744,15 @@ test_expect_success 'start and stop Linux/systemd maintenance' '
 	# start registers the repo
 	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
-	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" &&
+	for schedule in hourly daily weekly
+	do
+		test_path_is_file "systemd/user/git-maintenance@$schedule.timer" || return 1
+	done &&
+	test_path_is_file "systemd/user/git-maintenance@.service" &&
+
+	test_systemd_analyze_verify "systemd/user/git-maintenance@hourly.service" &&
+	test_systemd_analyze_verify "systemd/user/git-maintenance@daily.service" &&
+	test_systemd_analyze_verify "systemd/user/git-maintenance@weekly.service" &&
 
 	printf -- "--user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
 	test_cmp expect args &&
@@ -755,7 +763,10 @@ test_expect_success 'start and stop Linux/systemd maintenance' '
 	# stop does not unregister the repo
 	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
-	test_path_is_missing "systemd/user/git-maintenance@.timer" &&
+	for schedule in hourly daily weekly
+	do
+		test_path_is_missing "systemd/user/git-maintenance@$schedule.timer" || return 1
+	done &&
 	test_path_is_missing "systemd/user/git-maintenance@.service" &&
 
 	printf -- "--user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
-- 
gitgitgadget

