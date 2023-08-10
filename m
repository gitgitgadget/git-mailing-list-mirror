Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69F3C04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjHJUkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbjHJUjz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:39:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8054273C
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:54 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so20785631fa.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691699992; x=1692304792;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJogg69CvzVrRzoVEjvAs7MdyjeyecWSO/Rc55B2fhc=;
        b=CQmK+nBLSeL711cfgCZqqauYcGZwtyrZo7Sw02Ps7ZPBRMbYK7xE9kHMYWo/KuYFR6
         /w9px+HIeQ7q55cBQN0V4XFEVluPlHmtIxgxulbTEIuwndl4QlA28WOJefX8PgCBd52r
         mlx+0iLkk7Uvzv1zUVYAxLlQZVA5mxWKAjUE7ZbumzcknwoNdfh3kBI1rs7k25pcOp8v
         CbEryuUN0ML0RMpzB8B6AL+/bY/XNHkQycjLqgfUbGI6/O0t6IeRfsDPVxVwVDVhU3VM
         q2GneUNSSQc57UtsXiNq5PYTwkARG6N+TQbYu2Kr5WhTYLvDwk4HMTYx8lYpkPupxK+G
         /PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699992; x=1692304792;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJogg69CvzVrRzoVEjvAs7MdyjeyecWSO/Rc55B2fhc=;
        b=a8bQKyTCVYT2Ax5lu6tRuuGh075v5j0L1c7mZKuFmbSfhYLrKtwB8shorxOk0RriNs
         vJg3uMHuiLVlxpTGt4YPu5WNRJlrxXTOjC00ZrnC4AHF6u65knvk+tRGLYNAMM5M3jRo
         7d73IX9BT7H8Zq1iS2Jh1yUiWqcIEwk64MoIPQ2hE171Wf1HgoCDNvlGpL5+N3YZbJ8X
         oEnAdKgMOtDgs+yJ8X93WHi4nsO8+JLMfk05FBcpXebvx0NEwo+NwB2mLBylflYy/pZN
         5ExeoCeskUjbNavzml8LrZsAI3KV3AiR06stzxqFddfpJZF/C8ou6GbG4jrtEUlCtXhP
         y5XQ==
X-Gm-Message-State: AOJu0YwedzZ04lUHD7NL/uOgAPOAMG8i5HhM08zBU7nIsxxHUfLUtDiG
        u3egIe1Eve/9FkA1bOlkazcH+F9vDKU=
X-Google-Smtp-Source: AGHT+IFpnAqJdTZJPm2jYA9uV/CM+OtVM/QYWtUb3LB+ef4qfFzadPwcU/ONVhgUdlKl3+RH6Piupw==
X-Received: by 2002:a2e:9214:0:b0:2b6:e292:85ab with SMTP id k20-20020a2e9214000000b002b6e29285abmr82125ljg.25.1691699992547;
        Thu, 10 Aug 2023 13:39:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w20-20020a170906385400b0097404f4a124sm1387865ejc.2.2023.08.10.13.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:39:52 -0700 (PDT)
Message-ID: <88610437b4b53f584c540aca8ec26f40c0f0a426.1691699987.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
        <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 20:39:44 +0000
Subject: [PATCH v2 5/8] maintenance: swap method locations
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

The systemd_timer_write_unit_templates() method writes a single template
that is then used to start the hourly, daily, and weekly schedules with
systemd.

However, in order to schedule systemd maintenance on a given minute,
these templates need to be replaced with specific schedules for each of
these jobs.

Before modifying the schedules, move the writing method above the
systemd_timer_enable_unit() method, so we can write a specific schedule
for each unit.

The diff is computed smaller by showing systemd_timer_enable_unit() and
systemd_timer_delete_units()  move instead of
systemd_timer_write_unit_templates() and
systemd_timer_delete_unit_templates().

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c | 96 ++++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ef8bb772c38..e3819fc285a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2292,46 +2292,6 @@ static char *xdg_config_home_systemd(const char *filename)
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
 static int systemd_timer_delete_unit_templates(void)
 {
 	int ret = 0;
@@ -2348,14 +2308,6 @@ static int systemd_timer_delete_unit_templates(void)
 	return ret;
 }
 
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
@@ -2437,6 +2389,54 @@ error:
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

