Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398241C92
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726790432; cv=none; b=SF/15i5Oqq2+DNkB6lNOn/OBoHqgfNvEsE0pKm9ZxpheA5dBE1xA6dK//52Py331wqdNqyy1AhGyQMvagW7qhb0ARoewttjtOup4Yf0PiNU0P6QJ4m29hI8PzowkKalP1bZZ/fAxWnXIzdBRfCFKyeQkPiNtB40MxZVQ+JQD5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726790432; c=relaxed/simple;
	bh=bfOCKCTlFU6jon/tB4FzjZNEA3yxa8FbRy92NYJXXb4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NEztGrrdJ1endXAxjR7SPCKoU8B+chyYtBxym8f2D14SkrFnyhkYqRxZ0QGx+ZImDrnjhvVQxVoNp1RxTaLPfO7vo4dY1iJrJME1kAASwaMp5D0ZGBBbcyjYqNEmMlMcoeNCh298rhLNX2m5eYfQsmJsOVSFxCsyha1V38VjU7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNI9JSFk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNI9JSFk"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a90188ae58eso163590766b.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726790428; x=1727395228; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn2VvYMaX2jowQ9KvLyXF4ojiTu99UsbKunJ0nKqWrk=;
        b=gNI9JSFkaR91IfYrS1xPKboL/UFvRz+7LLoacX87QYzIEVwslNbry+mSpiunk2prBP
         jdIQR13KrJzdG489e1TJ6LcjPZyuGptHuhUYSR556wHKxDRh/bO7ybHxn7N6Qpb04g3V
         X3iZS+azjSQiz83eKcMytwqe2CS/ygmdGhw886aBw/JL9ctFe6M79LRUbK5+HYN5sz4C
         TUwmYUV1oJn2qeLWhZJ9ry52r2OM1ys8C+YuDd4BHskD+/sW89kxqN9eGFHL5oZ4Ujlf
         O6jIPFjszQ8/4Dqahv5mM/ogLp1hEpNmkQRkIw5HPloUd3aHsxCKUYKTMWGYq8E1nGuT
         oMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726790428; x=1727395228;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn2VvYMaX2jowQ9KvLyXF4ojiTu99UsbKunJ0nKqWrk=;
        b=og8FdxDIiMwsjwVfZdvSgZv6cuxdiW4cYEykKozVHM5BnRTSiPxQ+ycZser8D0Gc8K
         AYqWHnmlZZi5aHyp5amFttuHZ+qRNwZmuA8dkjjfwWzF9up1xr7NNQRPU8j3F0w9orP2
         jsMDy5BdrCdJiHFsBc9XjNcYUsZG4C9mQVbBBxCDJ3qW2MmdZYtZbOvgFn/hd3s/TVj4
         CdZ21cv+ebglincwFQoVUCSMoR2Rewx3SOZPb0OHnm1aIaQYVcuBgwTIGkrzcJ4wWr9h
         nULSUuWqZH49ycG3036wFajwRrvReunZrd/4TCpuV9zXzZA41mBHbXrFYSRlIluZhyDB
         E6Fg==
X-Gm-Message-State: AOJu0YzUjK/NuHXuoVzJg1Z4+pvtK948Q3AdrILByOHH9eK2DlB2twmd
	KQUDcPfnet2TGt1xfDwWH3mL9ouMVg8idTqSaLRDwYPG+I06UUYLliMMkg==
X-Google-Smtp-Source: AGHT+IEGLy56e0LMTafKUx1bzSBvnOED+5B0P3YTq6c02bnJ+FyGSDotmYR9pVyQ/60a/V3xShD++g==
X-Received: by 2002:a17:907:e248:b0:a86:a013:2161 with SMTP id a640c23a62f3a-a90d572c396mr54695266b.30.1726790427785;
        Thu, 19 Sep 2024 17:00:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612dfa6bsm778029066b.154.2024.09.19.17.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 17:00:27 -0700 (PDT)
Message-Id: <92ee323d31bf43decf0f230a7cc36b0f942bde6b.1726790424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1798.git.1726790423.gitgitgadget@gmail.com>
References: <pull.1798.git.1726790423.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Sep 2024 00:00:22 +0000
Subject: [PATCH 2/3] maintenance: add custom config to background jobs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    liuzhongbo.gg@gmail.com,
    Johannes.Schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

At the moment, some background jobs are getting blocked on credentials
during the 'prefetch' task. This leads to other tasks, such as
incremental repacks, getting blocked. Further, if a user manages to fix
their credentials, then they still need to cancel the background process
before their background maintenance can continue working.

Update the background schedules for our four scheduler integrations to
include these config options via '-c' options:

 * 'credential.interactive=false' will stop Git and some credential
   helpers from prompting in the UI (assuming the '-c' parameters are
   carried through and respected by GCM).

 * 'core.askPass=true' will replace the text fallback for a username
   and password into the 'true' command, which will return a success in
   its exit code, but Git will treat the empty string returned as an
   invalid password and move on.

We can do some testing that the credentials are passed, at least in the
systemd case due to writing the service files.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/gc.c           | 53 ++++++++++++++++++++++++++++++++++++------
 t/t7900-maintenance.sh |  3 +++
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 7dac9714054..fb1be542e06 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1766,6 +1766,42 @@ static const char *get_frequency(enum schedule_priority schedule)
 	}
 }
 
+static const char *extraconfig[] = {
+	"credential.interactive=false",
+	"core.askPass=true", /* 'true' returns success, but no output. */
+	NULL
+};
+
+static const char *get_extra_config_parameters(void) {
+	static const char *result = NULL;
+	struct strbuf builder = STRBUF_INIT;
+
+	if (result)
+		return result;
+
+	for (const char **s = extraconfig; s && *s; s++)
+		strbuf_addf(&builder, "-c %s ", *s);
+
+	result = strbuf_detach(&builder, NULL);
+	return result;
+}
+
+static const char *get_extra_launchctl_strings(void) {
+	static const char *result = NULL;
+	struct strbuf builder = STRBUF_INIT;
+
+	if (result)
+		return result;
+
+	for (const char **s = extraconfig; s && *s; s++) {
+		strbuf_addstr(&builder, "<string>-c</string>\n");
+		strbuf_addf(&builder, "<string>%s</string>\n", *s);
+	}
+
+	result = strbuf_detach(&builder, NULL);
+	return result;
+}
+
 /*
  * get_schedule_cmd` reads the GIT_TEST_MAINT_SCHEDULER environment variable
  * to mock the schedulers that `git maintenance start` rely on.
@@ -1972,6 +2008,7 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 		   "<array>\n"
 		   "<string>%s/git</string>\n"
 		   "<string>--exec-path=%s</string>\n"
+		   "%s" /* For extra config parameters. */
 		   "<string>for-each-repo</string>\n"
 		   "<string>--keep-going</string>\n"
 		   "<string>--config=maintenance.repo</string>\n"
@@ -1981,7 +2018,8 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 		   "</array>\n"
 		   "<key>StartCalendarInterval</key>\n"
 		   "<array>\n";
-	strbuf_addf(&plist, preamble, name, exec_path, exec_path, frequency);
+	strbuf_addf(&plist, preamble, name, exec_path, exec_path,
+		    get_extra_launchctl_strings(), frequency);
 
 	switch (schedule) {
 	case SCHEDULE_HOURLY:
@@ -2216,11 +2254,12 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	      "<Actions Context=\"Author\">\n"
 	      "<Exec>\n"
 	      "<Command>\"%s\\headless-git.exe\"</Command>\n"
-	      "<Arguments>--exec-path=\"%s\" for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=%s</Arguments>\n"
+	      "<Arguments>--exec-path=\"%s\" %s for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=%s</Arguments>\n"
 	      "</Exec>\n"
 	      "</Actions>\n"
 	      "</Task>\n";
-	fprintf(tfile->fp, xml, exec_path, exec_path, frequency);
+	fprintf(tfile->fp, xml, exec_path, exec_path,
+		get_extra_config_parameters(), frequency);
 	strvec_split(&child.args, cmd);
 	strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml",
 				  get_tempfile_path(tfile), NULL);
@@ -2361,8 +2400,8 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 			"# replaced in the future by a Git command.\n\n");
 
 		strbuf_addf(&line_format,
-			    "%%d %%s * * %%s \"%s/git\" --exec-path=\"%s\" for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=%%s\n",
-			    exec_path, exec_path);
+			    "%%d %%s * * %%s \"%s/git\" --exec-path=\"%s\" %s for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=%%s\n",
+			    exec_path, exec_path, get_extra_config_parameters());
 		fprintf(cron_in, line_format.buf, minute, "1-23", "*", "hourly");
 		fprintf(cron_in, line_format.buf, minute, "0", "1-6", "daily");
 		fprintf(cron_in, line_format.buf, minute, "0", "0", "weekly");
@@ -2562,7 +2601,7 @@ static int systemd_timer_write_service_template(const char *exec_path)
 	       "\n"
 	       "[Service]\n"
 	       "Type=oneshot\n"
-	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=%%i\n"
+	       "ExecStart=\"%s/git\" --exec-path=\"%s\" %s for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=%%i\n"
 	       "LockPersonality=yes\n"
 	       "MemoryDenyWriteExecute=yes\n"
 	       "NoNewPrivileges=yes\n"
@@ -2572,7 +2611,7 @@ static int systemd_timer_write_service_template(const char *exec_path)
 	       "RestrictSUIDSGID=yes\n"
 	       "SystemCallArchitectures=native\n"
 	       "SystemCallFilter=@system-service\n";
-	if (fprintf(file, unit, exec_path, exec_path) < 0) {
+	if (fprintf(file, unit, exec_path, exec_path, get_extra_config_parameters()) < 0) {
 		error(_("failed to write to '%s'"), filename);
 		fclose(file);
 		goto error;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index abae7a97546..3cd7e1fcacb 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -825,6 +825,9 @@ test_expect_success 'start and stop Linux/systemd maintenance' '
 	test_systemd_analyze_verify "systemd/user/git-maintenance@daily.service" &&
 	test_systemd_analyze_verify "systemd/user/git-maintenance@weekly.service" &&
 
+	grep "core.askPass=true" "systemd/user/git-maintenance@.service" &&
+	grep "credential.interactive=false" "systemd/user/git-maintenance@.service" &&
+
 	printf -- "--user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
 	test_cmp expect args &&
 
-- 
gitgitgadget

