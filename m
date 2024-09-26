Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B2518595A
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351230; cv=none; b=t68OFEDMURB6YiHIYmlYuzj9Elv8Hpus2AQqksyaLQ6ATetZGabMclse3+z8xIYW6zTnPUGKgnzJpFnwjwjjTfGUqmUFCC2+eIxJJDELARIcxgpOq0rkhE9xKcxcAD2o+kpzAqzgHhi5LiDyK34j4NtoWwydIeFagVpQqbMlw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351230; c=relaxed/simple;
	bh=nQVqt3mCduKDWQlSwK6KSHlIq3XpyI649br/VXvAW50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZfDizarWEWLDTZSFyCSxGulrIvc6GPmQXPJEvd9jnZhdZ1il5Dq/Nfb/L2VLflZU2+hntXcuWpGvTlBzvx0fJshlXDcvYrnDx7f3YT3NqO1USPodazmW9WB2YpQoIRAb4UpdV4dLwUbpSLBypfFy4Y87jwNeKD6rPlLCFz1pRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R19pXNNT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iRTWMKtS; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R19pXNNT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iRTWMKtS"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 669D111401B1;
	Thu, 26 Sep 2024 07:47:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 26 Sep 2024 07:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727351227;
	 x=1727437627; bh=yKChMOyx+eRcJ21TemwCXXrtJvoud9vu4FE0G5eGenE=; b=
	R19pXNNTWQsCpkR40pXVEp6RR5BPhNtpwfS90zhQaBsLu7mctfpFId1603X5HBTu
	Jpwzt0SVM3a4QW16BUgSGlqSg32sFjeIDqhG/gcAU8oSZOrQBYEOxDSeKG66BoD6
	QMMkj6//iYSLiDlXiaqFQ2PW4uL9cZiDJYVUo3AYJznGAveZAhBs8dt9bNGarMkR
	WS2sTsAnyoPIZOulbvUtrBqraDsv2el8Y38gjYWYodh6D+isdTxJozSTai9YKAfj
	5QSmVHKXBbz3ELxfNrSLmly71G9Y4YxZ7XKOXF+DTq7yUwMrTplqS+zuKErPUw6W
	9oimOAphSThc+2hJTin4JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727351227; x=
	1727437627; bh=yKChMOyx+eRcJ21TemwCXXrtJvoud9vu4FE0G5eGenE=; b=i
	RTWMKtSxfJb/r/8yxxsTPwWAhSbDl+xocwJpR0PG5Hhx+7Mprpi/XddVmfuS8SYc
	hOoFw5ZGDbs4J8Qm0BrYWDf9v4CShhuv3F7J5PJTlqbY7tXo55g5FKF0R3D+NchG
	PJ7Lu4ZtpMKin5+t+eSwB2NKy4QehWanYKxr8S0N+g4JAOz6hfTevpGwh5SdRUMk
	Tt/qy31nhHnUfJG3sRPtrNAeIZAmpji3IMPLCPSHC15ltsLI2AMNzEHBY0vSnGiY
	iZ6XgjjGATdPFdPE/hl5zKb4jlzzn7qwu7dqCK4WPMOUakNHn+YHcDOjRBSRtjxw
	P1bYD0HW4XdA6xZtvcH0g==
X-ME-Sender: <xms:u0n1ZkbuLUf0fDkivy3DIfSWgZAKiMkR5JnyordKoSqIcNAx6Mo8hQ>
    <xme:u0n1ZvZzHzdD_uQ2TTnt7etNsg5Tt-ztMWHVEjUqVRgqjvDUiIT3y9DMPVMrcqNkt
    p_u5GPDvCDUzJFEiA>
X-ME-Received: <xmr:u0n1Zu-7u-wvRobdRPkOL-d5LS5Vz7pP9mPabQ8hLTi0yLvBzlFOUu2RLqpA6oq8EvQVtZGKB2lRBMotdbQ3HOC_hIsR6xS1ZocgSrrgphuG1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvvdejheeiffelgfeifedvgfehvdeileeuhfegudeu
    udeljeekieduiefhgeeggfenucffohhmrghinheprghpphhlvgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:u0n1Zuoq_z30ZJ1ITMZwpHi9AdNm7epM0qmgB9LIDQUge3Hgrj7AXg>
    <xmx:u0n1ZvpFL16PDWMTvpuCstlYTtHZjT5c4lINZbiy5F0Yz5fcxWL5yA>
    <xmx:u0n1ZsQDXmJt0xRld4FiVQG-mDpz2xz8rS6OlL2k23KG9X29Wz0Qxg>
    <xmx:u0n1ZvpDtzwMyUt9j1R1IfRpXlFk52sWmQec5gjLc7ia8xeWshi-XA>
    <xmx:u0n1ZuWdcT8ZMQ8l8XBIU_gGs4mYn6Wa3cZ6KLa6HZTssKS6bY17ThPn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:47:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 78da665d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:46:28 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:47:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 21/23] builtin/maintenance: fix leak in
 `get_schedule_cmd()`
Message-ID: <95200b8a766e2ba7a971ab79b6d13f03bfa3b8ac.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1727351062.git.ps@pks.im>

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
index 3acfa367ad..b68a0be62c 100644
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
index abae7a9754..c62c42848a 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -2,6 +2,7 @@
 
 test_description='git maintenance builtin'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_COMMIT_GRAPH=0
-- 
2.46.2.852.g229c0bf0e5.dirty

