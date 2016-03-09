From: David Turner <dturner@twopensource.com>
Subject: [PATCH 18/19] index-helper: autorun
Date: Wed,  9 Mar 2016 13:36:21 -0500
Message-ID: <1457548582-28302-19-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:37:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adizG-0007mD-A9
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933885AbcCISh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:37:29 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34291 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933847AbcCISgu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:50 -0500
Received: by mail-qg0-f46.google.com with SMTP id w104so49422402qge.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JE2Bfa4sYJyH1ehUYUi4N6EB/VRYfuC+qwBAJDEE988=;
        b=lv3oMStRaQNg3Xll7iO3UcmJffj27DWZlEvsCOmWMIYIILB9ROhN/WFOZhkU2dM6EN
         9j05TYZTtMa6uGyiJdI+TemCWPGtn+1ZI/izfBoG6t+GsjjWszhNO2cAsubvQAvo7Seb
         XvFdF+UnFHZPo7YQK7YTPSKTTHGjyIw0G/FYQMn6v0zB80uXP0jBTmxMYzIKmRtbpxGp
         y1bi4JGaPqawuDqsxqGE/zHkxg8BycLX69lSta9qX3/ailyoPrf4rG6WLwp2LVBmDLCh
         ABhgt0mZHmyyfXIBM7Pyk2hnyua2HLLbOGzfGinp2rIVpkokt6pvB4FSzxqKebfYRDdF
         uxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JE2Bfa4sYJyH1ehUYUi4N6EB/VRYfuC+qwBAJDEE988=;
        b=eJcOFKqQYvGsPI1JLP0NU9MpZskDe0YxPIcEzRp1gJAQiL64vbFybCXZTCmWPkI+Or
         YsZn0C47rC1c1U7mqbQTeOG4DiEoJiaKTWpitySU0IPnAz3hDFc0BTWCrx3vnlJI2WtI
         OuzPYyGYyTHM225+9iKBhwy1n62OLJP7O9Bw1xNEX5TS9dBUyZpYnzD40uzgowaGDxfO
         wdFVy7WEUsJcG1GIw9+OpSvjcWi5trNiZc/zIlt2JCPUemUFPkkptzzgU+sBZj/Av576
         6ps0I6CAGkF/C5SS5bKqOQCwnuqdbZpxiPvB1qidPJJgUag5c0oltXO5tAy4FmvX5LSc
         x3yQ==
X-Gm-Message-State: AD7BkJK2wJV8z3yivXenH1NppA8mWuojAFPpKPPP4Smu0ocKneNW73LYBE+u6sRN1D13SQ==
X-Received: by 10.140.232.15 with SMTP id d15mr48472762qhc.87.1457548609921;
        Wed, 09 Mar 2016 10:36:49 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:49 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288566>

Introduce a new config option, indexhelper.autorun, to automatically
run git index-helper before starting up a builtin git command.  This
enables users to keep index-helper running without manual
intervention.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 git.c                   | 38 +++++++++++++++++++++++++++++++++++++-
 index-helper.c          | 11 ++++++++++-
 t/t7900-index-helper.sh | 10 ++++++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index a4f6f71..ccf04ab 100644
--- a/git.c
+++ b/git.c
@@ -521,6 +521,40 @@ static void strip_extension(const char **argv)
 #define strip_extension(cmd)
 #endif
 
+static int want_auto_index_helper(void)
+{
+	int want = -1;
+	const char *value = NULL;
+	const char *key = "indexhelper.autorun";
+
+	if (git_config_key_is_valid(key) &&
+	    !git_config_get_value(key, &value)) {
+		int b = git_config_maybe_bool(key, value);
+		want = b >= 0 ? b : 0;
+	}
+	return want;
+}
+
+static void maybe_run_index_helper(struct cmd_struct *cmd)
+{
+	const char *argv[] = {"git-index-helper", "--detach", "--auto", NULL};
+	int status;
+
+	if (!(cmd->option & NEED_WORK_TREE))
+		return;
+
+	if (want_auto_index_helper() <= 0)
+		return;
+
+	trace_argv_printf(argv, "trace: auto index-helper:");
+
+	status = run_command_v_opt(argv, RUN_SILENT_EXEC_FAILURE | RUN_CLEAN_ON_EXIT);
+
+	if (status) {
+		warning("You specified indexhelper.autorun, but running git-index-helper failed");
+	}
+}
+
 static void handle_builtin(int argc, const char **argv)
 {
 	const char *cmd;
@@ -536,8 +570,10 @@ static void handle_builtin(int argc, const char **argv)
 	}
 
 	builtin = get_builtin(cmd);
-	if (builtin)
+	if (builtin) {
+		maybe_run_index_helper(builtin);
 		exit(run_builtin(builtin, argc, argv));
+	}
 }
 
 static void execv_dashed_external(const char **argv)
diff --git a/index-helper.c b/index-helper.c
index a75da60..bc5c328 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -379,6 +379,7 @@ int main(int argc, char **argv)
 	int idle_in_minutes = 10, detach = 0;
 	int ignore_existing = 0;
 	int kill_existing = 0;
+	int nongit = 0, autorun = 0;
 	const char *pid_file;
 	struct option options[] = {
 		OPT_INTEGER(0, "exit-after", &idle_in_minutes,
@@ -388,6 +389,7 @@ int main(int argc, char **argv)
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_BOOL(0, "ignore-existing", &ignore_existing, "run even if another index-helper seems to be running for this repo"),
 		OPT_BOOL(0, "kill", &kill_existing, "kill any running index-helper for this repo"),
+		OPT_BOOL(0, "auto", &autorun, "this is an automatic run of git index-helper, so certain errors can be solved by silently exiting"),
 		OPT_END()
 	};
 
@@ -397,11 +399,18 @@ int main(int argc, char **argv)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(usage_text, options);
 
-	prefix = setup_git_directory();
+	prefix = setup_git_directory_gently(&nongit);
 	if (parse_options(argc, (const char **)argv, prefix,
 			  options, usage_text, 0))
 		die(_("too many arguments"));
 
+	if (nongit) {
+		if (autorun)
+			exit(0);
+		else
+			die("Not a git repository");
+	}
+
 	if (ignore_existing && kill_existing)
 		die(_("--ignore-existing and --kill don't make sense together"));
 
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 6708180..e4f9564 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -20,4 +20,14 @@ test_expect_success 'index-helper creates usable pid file and can be killed' '
 	! kill -0 $pid
 '
 
+test_expect_success 'index-helper autorun works' '
+	rm -f .git/index-helper.pid &&
+	git status &&
+	test_path_is_missing .git/index-helper.pid &&
+	test_config indexhelper.autorun true &&
+	git status &&
+	test_path_is_file .git/index-helper.pid &&
+	git index-helper --kill
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
