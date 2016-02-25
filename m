From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv19 11/11] clone: allow an explicit argument for parallel submodule clones
Date: Thu, 25 Feb 2016 15:48:39 -0800
Message-ID: <1456444119-6934-12-git-send-email-sbeller@google.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
 <1456444119-6934-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:49:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5ei-0008JG-CJ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbcBYXtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:49:08 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36823 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbcBYXtD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:49:03 -0500
Received: by mail-pa0-f45.google.com with SMTP id yy13so40219806pab.3
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bLU6ECR3DWFpadT8TcQlj+Egqjsn71XAaHnNAQNZayE=;
        b=bmcEU++5DtM+hHbhkRttxKopb24j0ZJRhp9fc+9bl/3vKirlI6w+yOrzJXWaeZw8nc
         5xV8wQw5oBxwR1mPXU0W22rFuS2NkQPckp1FyXObOx6lvAwDNrcZlVW3pqBme8MP4KDE
         qLSCk1qozx6fhgPWk+pyV4biKjT5hRquQypgmT0jRECr/c5uNLWltSaWQXTXCLM6eiRL
         UfF9CJSHSLwYdp5/vqZlhzqSNL7Cy1Q3kVe6G4Ul56MAYov9DemMs+Zw7emGZKDKTzq9
         OANlpJWzM6M8lhK+IVCdzmpEJAnX9j3akKzrnRJr5H5Ceyt9QB5FtPB6bmkwGRfHAaNl
         H2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bLU6ECR3DWFpadT8TcQlj+Egqjsn71XAaHnNAQNZayE=;
        b=MV9IWK7fxpmKnHzD1chh2J6ZekM4VScUsZy+9YWe7bUXMBiDDcHnv4iUP24x0LfvAQ
         /IT8cks1cYlWA7KBrcB8dfdbNV8KouRaYXoKhzefxIH6M9VxJZu6LgM3XxSGNeKH7EIY
         7fRN/evxMIF+jIL4NXTkRwjpqrsWFCBmjanj+jTp2Xu9EeSTs3YJg27baHpGh1sZsZOR
         mDDcL2yLXO6jzlPTVc2J+/rwSbhfF+Q7H/HVk1V6g9HZFbB0p9aRd2LWeGxbgi5/9v4x
         L78tgXbRfyA0La1zXSpKotrxA1ZBNG5cSKSf6Y3GMjwaxkc8kqViTeviNwdPFW62zpnR
         mvCw==
X-Gm-Message-State: AG10YOQEy2F437/9eqD9783FUKe1he3eCgkM2S5kT6wJqMdRB69qpOacicsr9vv8T531Tqz3
X-Received: by 10.66.158.232 with SMTP id wx8mr33321919pab.159.1456444141862;
        Thu, 25 Feb 2016 15:49:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id ux2sm14606505pac.46.2016.02.25.15.49.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:49:01 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456444119-6934-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287504>

Just pass it along to "git submodule update", which may pick reasonable
defaults if you don't specify an explicit number.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt |  6 +++++-
 builtin/clone.c             | 19 +++++++++++++------
 t/t7406-submodule-update.sh | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6bf000d..6db7b6d 100644
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
@@ -221,6 +221,10 @@ objects from the source repository into a pack in the cloned repository.
 	The result is Git repository can be separated from working
 	tree.
 
+-j <n>::
+--jobs <n>::
+	The number of submodules fetched at the same time.
+	Defaults to the `submodule.fetchJobs` option.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin/clone.c b/builtin/clone.c
index a0b3cd9..b004fb4 100644
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
@@ -724,8 +723,16 @@ static int checkout(void)
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
index 7fd5142..090891e 100755
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
2.7.0.rc0.36.g75877e4.dirty
