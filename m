Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DDFC001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 18:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjHGSv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjHGSvs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 14:51:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D746F171C
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 11:51:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe4b95c371so18599605e9.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691434305; x=1692039105;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Una1H32ohwMz7Z87OhdeB+5FsTi1i+P9igdRRxpApuw=;
        b=Lmf1RvlW4uIJcyeYmBnCbnkyHR+MdP4CW+4l2wLUbV+sZlLOsR/C8wkHQGG2K9RrN1
         LXt+keECmCUpjlY1fzyWrpH8KS6ONvgYrvayfYISGLvlNtjIZFHVEl3AGKxEFg1ih1u3
         tUpzd8GVe9xdiQOo8oPIvsHpjqUm2PVkrsxXdV5UhjiCMjqnIbJD7n+Jk7je64/Dysiu
         qQuWHfhIh8BuRsG0rsuCurUexrz+xfGI+GF5+fv+7VBroeEPzWMOdQnQaEBzr9H/gYFj
         bLRvMJX9Ajcytm1BZMWgb0M2ihkDhgQBXp8zeFettpcmyj2Wx5XylkimWgIbg2gbNh9b
         DOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691434305; x=1692039105;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Una1H32ohwMz7Z87OhdeB+5FsTi1i+P9igdRRxpApuw=;
        b=gARzIp2mvK9HMf6W/sqr0O86DYoANv97RejneZy1EcCe6O00xep9sHU95iKkL3xFdn
         qtf60OAe2xbuaSv4nSeAV9iRTI0lLxlNEizxtFmnpT6JxbqHeBg0IvBW+MjAT+FD2dsW
         kV2hZygG3c4hhG2pWJxwqp9kdwvucvWhaSrTno7e7ukD3AnkjI445tmfBwgWOYBv2ZdM
         nBaYQ+ofMFNhN8/kNpv+lVxP48Yi+gNyUFYsYqaQhwH3zqEyi1M4VZfj2v+kE/vbDRUH
         wVLXzZlnwPoafuCEJroimvOR56m+8+wVnHtvQK/WM/BxXSFksix1ewAkyYXZm9ZH/1pN
         iFLg==
X-Gm-Message-State: AOJu0YxblAzYUBOO/WgJPAiJevoF2bctOdzNiN9Z7b34rSyq8gnwlvc7
        +wOVaxU8yiXvnMOgIiadZjpHH6C7HIQ=
X-Google-Smtp-Source: AGHT+IGQKif1oOCj6l+ocyok4+g9vYQ6/w0aKROhHVzpRZGQX+R6wn2bUbk2erqDnQe3ah7+RqShTw==
X-Received: by 2002:a7b:c8c4:0:b0:3fe:1c57:3be with SMTP id f4-20020a7bc8c4000000b003fe1c5703bemr6414722wml.8.1691434305091;
        Mon, 07 Aug 2023 11:51:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d40c7000000b0031423a8f4f7sm11361229wrq.56.2023.08.07.11.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:51:44 -0700 (PDT)
Message-ID: <37f96b6b619d2d3eecd9c2b35483b2d61083603b.1691434300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Aug 2023 18:51:39 +0000
Subject: [PATCH 5/6] maintenance: swap method locations
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

The systemd_timer_write_unit_templates() method writes a single template
that is then used to start the hourly, daily, and weekly schedules with
systemd.

However, in order to schedule systemd maintenance on a given minute,
these templates need to be replaced with specific schedules for each of
these jobs.

Before modifying the schedules, move the writing method above the
systemd_timer_enable_unit() method, so we can write a specific schedule
for each unit.

The diff is computed smaller by showing systemd_timer_enable_unit() move
instead of systemd_timer_write_unit_templates().

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c | 128 +++++++++++++++++++++++++--------------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index be47000ed36..b3ef95b10aa 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2299,70 +2299,6 @@ static char *xdg_config_home_systemd(const char *filename)
 	return xdg_config_home_for("systemd/user", filename);
 }
 
-static int systemd_timer_enable_unit(int enable,
-				     enum schedule_priority schedule)
-{
-	const char *cmd = "systemctl";
-	struct child_process child = CHILD_PROCESS_INIT;
-	const char *frequency = get_frequency(schedule);
-
-	/*
-	 * Disabling the systemd unit while it is already disabled makes
-	 * systemctl print an error.
-	 * Let's ignore it since it means we already are in the expected state:
-	 * the unit is disabled.
-	 *
-	 * On the other hand, enabling a systemd unit which is already enabled
-	 * produces no error.
-	 */
-	if (!enable)
-		child.no_stderr = 1;
-
-	get_schedule_cmd(&cmd, NULL);
-	strvec_split(&child.args, cmd);
-	strvec_pushl(&child.args, "--user", enable ? "enable" : "disable",
-		     "--now", NULL);
-	strvec_pushf(&child.args, "git-maintenance@%s.timer", frequency);
-
-	if (start_command(&child))
-		return error(_("failed to start systemctl"));
-	if (finish_command(&child))
-		/*
-		 * Disabling an already disabled systemd unit makes
-		 * systemctl fail.
-		 * Let's ignore this failure.
-		 *
-		 * Enabling an enabled systemd unit doesn't fail.
-		 */
-		if (enable)
-			return error(_("failed to run systemctl"));
-	return 0;
-}
-
-static int systemd_timer_delete_unit_templates(void)
-{
-	int ret = 0;
-	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
-	if (unlink(filename) && !is_missing_file_error(errno))
-		ret = error_errno(_("failed to delete '%s'"), filename);
-	FREE_AND_NULL(filename);
-
-	filename = xdg_config_home_systemd("git-maintenance@.service");
-	if (unlink(filename) && !is_missing_file_error(errno))
-		ret = error_errno(_("failed to delete '%s'"), filename);
-
-	free(filename);
-	return ret;
-}
-
-static int systemd_timer_delete_units(void)
-{
-	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY) ||
-	       systemd_timer_enable_unit(0, SCHEDULE_DAILY) ||
-	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY) ||
-	       systemd_timer_delete_unit_templates();
-}
-
 static int systemd_timer_write_unit_templates(const char *exec_path)
 {
 	char *filename;
@@ -2444,6 +2380,70 @@ error:
 	return -1;
 }
 
+static int systemd_timer_enable_unit(int enable,
+				     enum schedule_priority schedule)
+{
+	const char *cmd = "systemctl";
+	struct child_process child = CHILD_PROCESS_INIT;
+	const char *frequency = get_frequency(schedule);
+
+	/*
+	 * Disabling the systemd unit while it is already disabled makes
+	 * systemctl print an error.
+	 * Let's ignore it since it means we already are in the expected state:
+	 * the unit is disabled.
+	 *
+	 * On the other hand, enabling a systemd unit which is already enabled
+	 * produces no error.
+	 */
+	if (!enable)
+		child.no_stderr = 1;
+
+	get_schedule_cmd(&cmd, NULL);
+	strvec_split(&child.args, cmd);
+	strvec_pushl(&child.args, "--user", enable ? "enable" : "disable",
+		     "--now", NULL);
+	strvec_pushf(&child.args, "git-maintenance@%s.timer", frequency);
+
+	if (start_command(&child))
+		return error(_("failed to start systemctl"));
+	if (finish_command(&child))
+		/*
+		 * Disabling an already disabled systemd unit makes
+		 * systemctl fail.
+		 * Let's ignore this failure.
+		 *
+		 * Enabling an enabled systemd unit doesn't fail.
+		 */
+		if (enable)
+			return error(_("failed to run systemctl"));
+	return 0;
+}
+
+static int systemd_timer_delete_unit_templates(void)
+{
+	int ret = 0;
+	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
+	if (unlink(filename) && !is_missing_file_error(errno))
+		ret = error_errno(_("failed to delete '%s'"), filename);
+	FREE_AND_NULL(filename);
+
+	filename = xdg_config_home_systemd("git-maintenance@.service");
+	if (unlink(filename) && !is_missing_file_error(errno))
+		ret = error_errno(_("failed to delete '%s'"), filename);
+
+	free(filename);
+	return ret;
+}
+
+static int systemd_timer_delete_units(void)
+{
+	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY) ||
+	       systemd_timer_enable_unit(0, SCHEDULE_DAILY) ||
+	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY) ||
+	       systemd_timer_delete_unit_templates();
+}
+
 static int systemd_timer_setup_units(void)
 {
 	const char *exec_path = git_exec_path();
-- 
gitgitgadget

