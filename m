From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv11 7/7] clone: allow an explicit argument for parallel submodule clones
Date: Fri, 12 Feb 2016 15:34:40 -0800
Message-ID: <1455320080-14648-8-git-send-email-sbeller@google.com>
References: <1455320080-14648-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat Feb 13 00:35:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNEq-0005Uj-7V
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbcBLXe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:34:58 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36001 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbcBLXey (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:34:54 -0500
Received: by mail-pa0-f46.google.com with SMTP id yy13so53714553pab.3
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 15:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hVemXNoNwkblTupMuRIH3dd3sN4RDiiCn+0Y4o/gYhk=;
        b=Kc1yGHpIaHQtiOkjNWRSGpnQiJvzZ4/HKTl4KZ6POvoNdYbfcgW7b9dDPVKlt8S0z3
         bH39Sn0/3xF9ubSqpAdIPM2X3h3OnjHaC58up+dgLS/8I3mW8S1f5pgpfxSJbcQSx8pi
         zUMWg1O7R6IjRqbDMaCHExw4jj54NVJDDDHUINwcOPB9OExUWqLueRcaiMzuMeiK/gat
         +1EVJ0jSBW1upoHlrKeewWiSi9NPRc+cIk596uYQbXqZSy/HF7UaJVjqynRE3qVW8boy
         mREtgQAZsJF+Z3QasHrBOJ3jlqenkO+UsGllMlfYoiX6LClDcNN/LV+qDSOxi9fAgJDP
         H/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hVemXNoNwkblTupMuRIH3dd3sN4RDiiCn+0Y4o/gYhk=;
        b=mzs6WcUpHZ9ePAkTB13D/0k9XhumExqxbLHs4ECcHDJByx2BIs2c3HnLI192fch90b
         pSlQCPm4xk+iB+4P5USfVFvjJvr6ncpoNvxalJEjmDf/0gE5lvrb1RprSllZp7UV9CkS
         VHa9EaRly2vwLXHi6ZQYxsS724gyFiowTgBRcmaTf4iZB9eJCXTDtZTotYWI/HYLeLYN
         creHdw4O3yaNUGKcuBHr3cwjATUagjJS/5ZAPzGRS+uok9VfPUywEiSSLQTqH0NF0TM8
         /gvrG8fnrBhDoCGJB7tME4WI1UAGrjvpdjAk1wirIZEVvo8mTWR3GQhOKDSDZm0KV7Cc
         HAPA==
X-Gm-Message-State: AG10YOQPArEcowGWpo32g7TtMkzMnEv01P0qQ6nzG+HVA9DXmyp/P0tfqJPQn3jj92PryHu6
X-Received: by 10.66.191.225 with SMTP id hb1mr5979568pac.78.1455320093840;
        Fri, 12 Feb 2016 15:34:53 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f1e7:203f:9d1e:8193])
        by smtp.gmail.com with ESMTPSA id yh5sm21875881pab.13.2016.02.12.15.34.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 15:34:52 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
In-Reply-To: <1455320080-14648-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286087>

Just pass it along to "git submodule update", which may pick reasonable
defaults if you don't specify an explicit number.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt |  6 +++++-
 builtin/clone.c             | 19 +++++++++++++------
 t/t7406-submodule-update.sh | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 789b668..cb7966a 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
-	  [--recursive | --recurse-submodules] [--] <repository>
+	  [--recursive | --recurse-submodules] [--jobs <n>] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -220,6 +220,10 @@ objects from the source repository into a pack in the cloned repository.
 	The result is Git repository can be separated from working
 	tree.
 
+-j <n>::
+--jobs <n>::
+	The number of submodules fetched at the same time.
+	Defaults to the `submodule.fetchJobs` option.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin/clone.c b/builtin/clone.c
index bcba080..191f522 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -50,6 +50,7 @@ static int option_progress = -1;
 static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
+static int max_jobs = -1;
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -72,6 +73,8 @@ static struct option builtin_clone_options[] = {
 		    N_("initialize submodules in the clone")),
 	OPT_BOOL(0, "recurse-submodules", &option_recursive,
 		    N_("initialize submodules in the clone")),
+	OPT_INTEGER('j', "jobs", &max_jobs,
+		    N_("number of submodules cloned in parallel")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
 		   N_("directory from which templates will be used")),
 	OPT_STRING_LIST(0, "reference", &option_reference, N_("repo"),
@@ -95,10 +98,6 @@ static struct option builtin_clone_options[] = {
 	OPT_END()
 };
 
-static const char *argv_submodule[] = {
-	"submodule", "update", "--init", "--recursive", NULL
-};
-
 static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
 {
 	static char *suffix[] = { "/.git", "", ".git/.git", ".git" };
@@ -727,8 +726,16 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive)
-		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+	if (!err && option_recursive) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+
+		if (max_jobs != -1)
+			argv_array_pushf(&args, "--jobs=%d", max_jobs);
+
+		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
+		argv_array_clear(&args);
+	}
 
 	return err;
 }
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 815b4d1..0791df7 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -786,4 +786,19 @@ test_expect_success 'submodule update can be run in parallel' '
 	 grep "9 tasks" trace.out
 	)
 '
+
+test_expect_success 'git clone passes the parallel jobs config on to submodules' '
+	test_when_finished "rm -rf super4" &&
+	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules --jobs 7 . super4 &&
+	grep "7 tasks" trace.out &&
+	rm -rf super4 &&
+	git config --global submodule.fetchJobs 8 &&
+	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules . super4 &&
+	grep "8 tasks" trace.out &&
+	rm -rf super4 &&
+	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules --jobs 9 . super4 &&
+	grep "9 tasks" trace.out &&
+	rm -rf super4
+'
+
 test_done
-- 
2.7.1.292.g18a4ced.dirty
