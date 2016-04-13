From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 15/16] index-helper: optionally automatically run
Date: Tue, 12 Apr 2016 20:33:08 -0400
Message-ID: <1460507589-25525-16-git-send-email-dturner@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:34:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8kt-0002sP-GG
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758972AbcDMAeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 20:34:00 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35607 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758903AbcDMAdn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:43 -0400
Received: by mail-qk0-f177.google.com with SMTP id o6so13627774qkc.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aP9ky1q9tmHz8xu22PnO4t4WaJzIADKGokES3lI+P2s=;
        b=A/kTgye3cBjJZI0RagT7K2PiNwkNsJIuLStX9YTxZpjl6/HiIZqacXjv1kjtBKK+2o
         hLvguxJvR5jF5ig6rxdFaQyAwMsExr7OuW3MelfCBFApaoCPhHVthwB+Mkst91SjhK3O
         +uD7xvNeczcAm4MGv5dguNFL7ae0eQAxAJYHTzPKjl3FjmNXwQ6H21gyuG4/IxplY/WQ
         EaqkpN1TBDj7WopKbxWNDx1fTgycEfsZugwNsWIC/L+3WiOs6/3lbSwo1xpYv+1GlHDJ
         2wwOG8wPTz3d0cBQc44lF+1v/ekQ7+2saC0rwGgG1SVoJgcdSAakh/X5dn8lou/DucjX
         dewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aP9ky1q9tmHz8xu22PnO4t4WaJzIADKGokES3lI+P2s=;
        b=DhbK+r430Hj8fIO9Bwf+nKsVLU2uBowOIlDLvCCERH2vVhN1Ghmx+/LhYM7uiH8i46
         CGcE+9LqJEEakWwJnSrLmckMtZgFRbVXrYWKTgwXqIHFF0rnSiCyXcU3UP/N3N9FGnlP
         O+8rf6Vo9v3L68xm3DnCr2XCB82ZJX87Ettj6Kql69Wp2hOUcO4SLtmDU+vPkDt8vhAb
         GmvggJW3t/zYoqooto4iq9xpoSi1U33gaKZSgDkEgtN5rsF83SimXiPmCH/zk8Zfc2m6
         woWJ1RhzXTC674r3mgKWBHCexdM7p/QY1UbQDkj4fLeOA770O9I7piNxhjciofVRzZm4
         4Lwg==
X-Gm-Message-State: AOPr4FVX3KdUKOxpEfMbnp7IVC6RJwcBg5GE4kl20C20PmbYC1XVnEWv3u/UQYi7vhxueA==
X-Received: by 10.55.221.8 with SMTP id n8mr7281618qki.50.1460507617575;
        Tue, 12 Apr 2016 17:33:37 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291350>

Introduce a new config option, indexhelper.autorun, to automatically
run git index-helper before starting up a builtin git command.  This
enables users to keep index-helper running without manual
intervention.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/config.txt |  4 ++++
 git.c                    | 35 ++++++++++++++++++++++++++++++++++-
 t/t7900-index-helper.sh  | 16 ++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..8ec8824 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1852,6 +1852,10 @@ index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
 
+indexhelper.autorun::
+	Automatically run git index-helper when any builtin git
+	command is run inside a repository.
+
 init.templateDir::
 	Specify the directory from which templates will be copied.
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
diff --git a/git.c b/git.c
index 6cc0c07..7d27782 100644
--- a/git.c
+++ b/git.c
@@ -521,6 +521,37 @@ static void strip_extension(const char **argv)
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
+	const char *argv[] = {"git-index-helper", "--detach", "--autorun", NULL};
+
+	if (!(cmd->option & NEED_WORK_TREE))
+		return;
+
+	if (want_auto_index_helper() <= 0)
+		return;
+
+	trace_argv_printf(argv, "trace: auto index-helper:");
+
+	if (run_command_v_opt(argv,
+			      RUN_SILENT_EXEC_FAILURE | RUN_CLEAN_ON_EXIT))
+		warning(_("You specified indexhelper.autorun, but running git-index-helper failed."));
+}
+
 static void handle_builtin(int argc, const char **argv)
 {
 	const char *cmd;
@@ -536,8 +567,10 @@ static void handle_builtin(int argc, const char **argv)
 	}
 
 	builtin = get_builtin(cmd);
-	if (builtin)
+	if (builtin) {
+		maybe_run_index_helper(builtin);
 		exit(run_builtin(builtin, argc, argv));
+	}
 }
 
 static void execv_dashed_external(const char **argv)
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index eeca483..8b969d3 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -49,4 +49,20 @@ test_expect_success 'index-helper is quiet with --autorun' '
 	git index-helper --autorun
 '
 
+test_expect_success 'index-helper autorun works' '
+	rm -f .git/index-helper.path &&
+	git status &&
+	test_path_is_missing .git/index-helper.path &&
+	test_config indexhelper.autorun true &&
+	git status &&
+	test -L .git/index-helper.path &&
+	git status 2>err &&
+	test -L .git/index-helper.path &&
+	! grep -q . err &&
+	git index-helper --kill &&
+	test_config indexhelper.autorun false &&
+	git status &&
+	test_path_is_missing .git/index-helper.path
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
