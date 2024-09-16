Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1AA156C6F
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487190; cv=none; b=YdiieouihzR0iwfXSUVEwiZGIgtVd/rkbxI0QtaJGLFpNOTYz8sY+pXrqIYz/e3x8Ynd1tgqBfKTnVstnVxdZ++aBPGCgqGXOQ3Y1sMdX8djEnHJ8rDz96ZJF1Mq96k9mGP+2NytkjvUKrGLjQPydtt7xSdG2BD0AaxHcKX/6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487190; c=relaxed/simple;
	bh=DaxCF4xjAwf0h5Eg/+2dvdwNImfb15LOASwkrJ+RLt4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpsYxYIEkGrQk3Iq4uooaHSUp7+c1nXIUndMyBk+xMON4LmqGbtxDtZ54B+mFItzp/9SzPxITmSjQOnS4eheHxE88eRltt91taTuEf5MM6EWRhsAmk8UEHcI1P9Oo+VUyX3Gu8fGQySlrsJQSbbHGgPwc4h5h0Fj1Q2oupkR4UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XPu5/9Nw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LqGU9CxX; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XPu5/9Nw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LqGU9CxX"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6BE4114007D
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Sep 2024 07:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726487187;
	 x=1726573587; bh=YJxC/3+AiuJXBl4sMMn9ExVuKgPZsltqb9yFQNZjp5k=; b=
	XPu5/9Nwx4PJ0h8azih+2dQWIi8mFT/YqpWGUU2xBheKEaNhO5yDg/KOz0vROMon
	cff2g2Ry1HjL8bDCvLO5VrOR/OJL15Z2o/9rYsa2bNaN4/7Nrta1KcDxoRelVMYT
	Jon/wv6TBzMbzK+PUfwGyw2P9GST/MZl3TjAAWXXyENGvmsN9+xXQyUjHc9NNyyl
	c3YWlnyFGPiJO9cFC3YViAQr7Mz1shI44Zmg8I1FkLMmOPd5sTJipGhapRhQ+bwB
	Y2xnR0U+SDZIbYImiNwZ6gFHy0nbrb0vEOrp/PGBUyTWGm6m21KjAOCum3nyPxOg
	BkNPO4HCRWNnvIoH2hP92A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726487187; x=
	1726573587; bh=YJxC/3+AiuJXBl4sMMn9ExVuKgPZsltqb9yFQNZjp5k=; b=L
	qGU9CxXKD3F1SNHvCGKLfXIRaWsqPNcbcTQKocob4HCEscQGKoYHNRbEzQ5Jm5Yk
	Ft3kT5cCTRm9BC09VAhxxzYGUu3WV5x5TZyeWddptZ8RDnTXoGVtVIqNF1PZ+8gi
	mvXWHTuWu+Wu0kLREhh0+Kj7UW63IwqyqEA/Bwdlm1Qn9kxNWZ3KDW0nq9wEb5ZH
	R6rN4RjhiWRyMgVIrL6xYT13lWSSKlKeICk3BzpHgk8r02ZpwlHUDNENN6wGCri8
	kocALA9ArLNz64e362uj6DL/L8LLMiOOKdRc0QG0OGGkxtW1SPmVOqAHE5JrCzCp
	3u6irUKPECYtxvwPtaEsA==
X-ME-Sender: <xms:kxroZtjquDr0FpXtI84yd3r-iYHJCMtojvnNSERkBlJWglZ_rTlfLA>
    <xme:kxroZiAq0DrZpmArz3rVYneGYCrO3c2uQYAxpaEXUL-x-M-JLSeoh5yMo3VGTy4p7
    TqoEh2ubQ1yFh4LWA>
X-ME-Received: <xmr:kxroZtEHW50ybTcg5TAQF3KRyjSZMiEDExWDghQhNnsTR4OPdny6iSCmDdQUCZTcpUHdpqo8OgZmnWQH5VDVznIepMCdadLp0IRIw6yK2b0tfj4B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeikeehffdvtd
    ekvdeuveefjeeigfethfeiteduieegkeeuleefteevteehfeevgfenucffohhmrghinhep
    rghpphhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kxroZiSGV4BmFjbMVu8xvZUmS8EWRY5ZrbYiJ0OcLjpsS_KcRFejOg>
    <xmx:kxroZqw5PGVuq4zKHAG67jbEr7AYEjFlicda-rxwa_6Z4EBc4fxPXA>
    <xmx:kxroZo6y6wlIemA2J8QNPgfE8tGcSA9l9S4pq9Y2WKsxap_V7liiHA>
    <xmx:kxroZvwrTC1PxkBcTej1xqzb09Q_4vCwfkgwVfD-GeRvzYeZvF1t2Q>
    <xmx:kxroZvqxI8KXsnlbSRlVAKogdTn18SK722xjDAdnGyjDHoR-ywzAKf9b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ffa49a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:46:09 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:46:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 21/23] builtin/maintenance: fix leak in `get_schedule_cmd()`
Message-ID: <46956bd8fbda45a9e2115e2b3b40c1ab20ea3eee.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1726484308.git.ps@pks.im>

The `get_schedule_cmd()` function allows us to override the schedule
command with a specific test command such that we can verify the
underlying logic in a platform-independent way. Its memory management is
somewhat wild though, because it basically gives up and assigns an
allocated string to the string constant output pointer. While this part
is marked with `UNLEAK()` to mask this, we also leak the local string
lists.

Rework the function such that it has a separate out parameter. If set,
we will assign it the final allocated command. Plug the other memory
leaks and create a common exit path.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           | 127 ++++++++++++++++++++++++++---------------
 t/t7900-maintenance.sh |   1 +
 2 files changed, 81 insertions(+), 47 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3acfa367ad1..b68a0be62c1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1780,32 +1780,33 @@ static const char *get_frequency(enum schedule_priority schedule)
  * * If $GIT_TEST_MAINT_SCHEDULER is set, return true.
  *   In this case, the *cmd value is read as input.
  *
- *   * if the input value *cmd is the key of one of the comma-separated list
- *     item, then *is_available is set to true and *cmd is modified and becomes
+ *   * if the input value cmd is the key of one of the comma-separated list
+ *     item, then *is_available is set to true and *out is set to
  *     the mock command.
  *
  *   * if the input value *cmd isn’t the key of any of the comma-separated list
- *     item, then *is_available is set to false.
+ *     item, then *is_available is set to false and *out is set to the original
+ *     command.
  *
  * Ex.:
  *   GIT_TEST_MAINT_SCHEDULER not set
  *     +-------+-------------------------------------------------+
  *     | Input |                     Output                      |
- *     | *cmd  | return code |       *cmd        | *is_available |
+ *     | *cmd  | return code |       *out        | *is_available |
  *     +-------+-------------+-------------------+---------------+
- *     | "foo" |    false    | "foo" (unchanged) |  (unchanged)  |
+ *     | "foo" |    false    | NULL              |  (unchanged)  |
  *     +-------+-------------+-------------------+---------------+
  *
  *   GIT_TEST_MAINT_SCHEDULER set to “foo:./mock_foo.sh,bar:./mock_bar.sh”
  *     +-------+-------------------------------------------------+
  *     | Input |                     Output                      |
- *     | *cmd  | return code |       *cmd        | *is_available |
+ *     | *cmd  | return code |       *out        | *is_available |
  *     +-------+-------------+-------------------+---------------+
  *     | "foo" |    true     |  "./mock.foo.sh"  |     true      |
- *     | "qux" |    true     | "qux" (unchanged) |     false     |
+ *     | "qux" |    true     | "qux" (allocated) |     false     |
  *     +-------+-------------+-------------------+---------------+
  */
-static int get_schedule_cmd(const char **cmd, int *is_available)
+static int get_schedule_cmd(const char *cmd, int *is_available, char **out)
 {
 	char *testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
 	struct string_list_item *item;
@@ -1824,16 +1825,22 @@ static int get_schedule_cmd(const char **cmd, int *is_available)
 		if (string_list_split_in_place(&pair, item->string, ":", 2) != 2)
 			continue;
 
-		if (!strcmp(*cmd, pair.items[0].string)) {
-			*cmd = pair.items[1].string;
+		if (!strcmp(cmd, pair.items[0].string)) {
+			if (out)
+				*out = xstrdup(pair.items[1].string);
 			if (is_available)
 				*is_available = 1;
-			string_list_clear(&list, 0);
-			UNLEAK(testing);
-			return 1;
+			string_list_clear(&pair, 0);
+			goto out;
 		}
+
+		string_list_clear(&pair, 0);
 	}
 
+	if (out)
+		*out = xstrdup(cmd);
+
+out:
 	string_list_clear(&list, 0);
 	free(testing);
 	return 1;
@@ -1850,9 +1857,8 @@ static int get_random_minute(void)
 
 static int is_launchctl_available(void)
 {
-	const char *cmd = "launchctl";
 	int is_available;
-	if (get_schedule_cmd(&cmd, &is_available))
+	if (get_schedule_cmd("launchctl", &is_available, NULL))
 		return is_available;
 
 #ifdef __APPLE__
@@ -1890,12 +1896,12 @@ static char *launchctl_get_uid(void)
 
 static int launchctl_boot_plist(int enable, const char *filename)
 {
-	const char *cmd = "launchctl";
+	char *cmd;
 	int result;
 	struct child_process child = CHILD_PROCESS_INIT;
 	char *uid = launchctl_get_uid();
 
-	get_schedule_cmd(&cmd, NULL);
+	get_schedule_cmd("launchctl", NULL, &cmd);
 	strvec_split(&child.args, cmd);
 	strvec_pushl(&child.args, enable ? "bootstrap" : "bootout", uid,
 		     filename, NULL);
@@ -1908,6 +1914,7 @@ static int launchctl_boot_plist(int enable, const char *filename)
 
 	result = finish_command(&child);
 
+	free(cmd);
 	free(uid);
 	return result;
 }
@@ -1959,10 +1966,10 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 	static unsigned long lock_file_timeout_ms = ULONG_MAX;
 	struct strbuf plist = STRBUF_INIT, plist2 = STRBUF_INIT;
 	struct stat st;
-	const char *cmd = "launchctl";
+	char *cmd;
 	int minute = get_random_minute();
 
-	get_schedule_cmd(&cmd, NULL);
+	get_schedule_cmd("launchctl", NULL, &cmd);
 	preamble = "<?xml version=\"1.0\"?>\n"
 		   "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
 		   "<plist version=\"1.0\">"
@@ -2052,6 +2059,7 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 
 	free(filename);
 	free(name);
+	free(cmd);
 	strbuf_release(&plist);
 	strbuf_release(&plist2);
 	return 0;
@@ -2076,9 +2084,8 @@ static int launchctl_update_schedule(int run_maintenance, int fd UNUSED)
 
 static int is_schtasks_available(void)
 {
-	const char *cmd = "schtasks";
 	int is_available;
-	if (get_schedule_cmd(&cmd, &is_available))
+	if (get_schedule_cmd("schtasks", &is_available, NULL))
 		return is_available;
 
 #ifdef GIT_WINDOWS_NATIVE
@@ -2097,15 +2104,16 @@ static char *schtasks_task_name(const char *frequency)
 
 static int schtasks_remove_task(enum schedule_priority schedule)
 {
-	const char *cmd = "schtasks";
+	char *cmd;
 	struct child_process child = CHILD_PROCESS_INIT;
 	const char *frequency = get_frequency(schedule);
 	char *name = schtasks_task_name(frequency);
 
-	get_schedule_cmd(&cmd, NULL);
+	get_schedule_cmd("schtasks", NULL, &cmd);
 	strvec_split(&child.args, cmd);
 	strvec_pushl(&child.args, "/delete", "/tn", name, "/f", NULL);
 	free(name);
+	free(cmd);
 
 	return run_command(&child);
 }
@@ -2119,7 +2127,7 @@ static int schtasks_remove_tasks(void)
 
 static int schtasks_schedule_task(const char *exec_path, enum schedule_priority schedule)
 {
-	const char *cmd = "schtasks";
+	char *cmd;
 	int result;
 	struct child_process child = CHILD_PROCESS_INIT;
 	const char *xml;
@@ -2129,7 +2137,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	struct strbuf tfilename = STRBUF_INIT;
 	int minute = get_random_minute();
 
-	get_schedule_cmd(&cmd, NULL);
+	get_schedule_cmd("schtasks", NULL, &cmd);
 
 	strbuf_addf(&tfilename, "%s/schedule_%s_XXXXXX",
 		    get_git_common_dir(), frequency);
@@ -2235,6 +2243,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 
 	delete_tempfile(&tfile);
 	free(name);
+	free(cmd);
 	return result;
 }
 
@@ -2276,21 +2285,28 @@ static int check_crontab_process(const char *cmd)
 
 static int is_crontab_available(void)
 {
-	const char *cmd = "crontab";
+	char *cmd;
 	int is_available;
+	int ret;
 
-	if (get_schedule_cmd(&cmd, &is_available))
-		return is_available;
+	if (get_schedule_cmd("crontab", &is_available, &cmd)) {
+		ret = is_available;
+		goto out;
+	}
 
 #ifdef __APPLE__
 	/*
 	 * macOS has cron, but it requires special permissions and will
 	 * create a UI alert when attempting to run this command.
 	 */
-	return 0;
+	ret = 0;
 #else
-	return check_crontab_process(cmd);
+	ret = check_crontab_process(cmd);
 #endif
+
+out:
+	free(cmd);
+	return ret;
 }
 
 #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
@@ -2298,7 +2314,7 @@ static int is_crontab_available(void)
 
 static int crontab_update_schedule(int run_maintenance, int fd)
 {
-	const char *cmd = "crontab";
+	char *cmd;
 	int result = 0;
 	int in_old_region = 0;
 	struct child_process crontab_list = CHILD_PROCESS_INIT;
@@ -2308,15 +2324,17 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 	struct tempfile *tmpedit = NULL;
 	int minute = get_random_minute();
 
-	get_schedule_cmd(&cmd, NULL);
+	get_schedule_cmd("crontab", NULL, &cmd);
 	strvec_split(&crontab_list.args, cmd);
 	strvec_push(&crontab_list.args, "-l");
 	crontab_list.in = -1;
 	crontab_list.out = dup(fd);
 	crontab_list.git_cmd = 0;
 
-	if (start_command(&crontab_list))
-		return error(_("failed to run 'crontab -l'; your system might not support 'cron'"));
+	if (start_command(&crontab_list)) {
+		result = error(_("failed to run 'crontab -l'; your system might not support 'cron'"));
+		goto out;
+	}
 
 	/* Ignore exit code, as an empty crontab will return error. */
 	finish_command(&crontab_list);
@@ -2386,8 +2404,10 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 		result = error(_("'crontab' died"));
 	else
 		fclose(cron_list);
+
 out:
 	delete_tempfile(&tmpedit);
+	free(cmd);
 	return result;
 }
 
@@ -2410,10 +2430,9 @@ static int real_is_systemd_timer_available(void)
 
 static int is_systemd_timer_available(void)
 {
-	const char *cmd = "systemctl";
 	int is_available;
 
-	if (get_schedule_cmd(&cmd, &is_available))
+	if (get_schedule_cmd("systemctl", &is_available, NULL))
 		return is_available;
 
 	return real_is_systemd_timer_available();
@@ -2594,9 +2613,10 @@ static int systemd_timer_enable_unit(int enable,
 				     enum schedule_priority schedule,
 				     int minute)
 {
-	const char *cmd = "systemctl";
+	char *cmd = NULL;
 	struct child_process child = CHILD_PROCESS_INIT;
 	const char *frequency = get_frequency(schedule);
+	int ret;
 
 	/*
 	 * Disabling the systemd unit while it is already disabled makes
@@ -2607,20 +2627,25 @@ static int systemd_timer_enable_unit(int enable,
 	 * On the other hand, enabling a systemd unit which is already enabled
 	 * produces no error.
 	 */
-	if (!enable)
+	if (!enable) {
 		child.no_stderr = 1;
-	else if (systemd_timer_write_timer_file(schedule, minute))
-		return -1;
+	} else if (systemd_timer_write_timer_file(schedule, minute)) {
+		ret = -1;
+		goto out;
+	}
 
-	get_schedule_cmd(&cmd, NULL);
+	get_schedule_cmd("systemctl", NULL, &cmd);
 	strvec_split(&child.args, cmd);
 	strvec_pushl(&child.args, "--user", enable ? "enable" : "disable",
 		     "--now", NULL);
 	strvec_pushf(&child.args, SYSTEMD_UNIT_FORMAT, frequency, "timer");
 
-	if (start_command(&child))
-		return error(_("failed to start systemctl"));
-	if (finish_command(&child))
+	if (start_command(&child)) {
+		ret = error(_("failed to start systemctl"));
+		goto out;
+	}
+
+	if (finish_command(&child)) {
 		/*
 		 * Disabling an already disabled systemd unit makes
 		 * systemctl fail.
@@ -2628,9 +2653,17 @@ static int systemd_timer_enable_unit(int enable,
 		 *
 		 * Enabling an enabled systemd unit doesn't fail.
 		 */
-		if (enable)
-			return error(_("failed to run systemctl"));
-	return 0;
+		if (enable) {
+			ret = error(_("failed to run systemctl"));
+			goto out;
+		}
+	}
+
+	ret = 0;
+
+out:
+	free(cmd);
+	return ret;
 }
 
 /*
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index abae7a97546..c62c42848a2 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -2,6 +2,7 @@
 
 test_description='git maintenance builtin'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_COMMIT_GRAPH=0
-- 
2.46.0.551.gc5ee8f2d1c.dirty

