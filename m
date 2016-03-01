From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv21 10/10] clone: allow an explicit argument for parallel submodule clones
Date: Mon, 29 Feb 2016 18:07:20 -0800
Message-ID: <1456798040-30129-11-git-send-email-sbeller@google.com>
References: <1456798040-30129-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 03:07:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZj6-00034x-Py
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 03:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbcCACHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 21:07:46 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33084 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbcCACHk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 21:07:40 -0500
Received: by mail-pf0-f169.google.com with SMTP id 124so41178594pfg.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iQkIWuK6T8YqNPwHvJmW+2nJO3vwoF8f947VD1brRE4=;
        b=D8yGaAXgcw46IRmN0dx065GNuqhw1hJyI6e/97tYhETCHPuzby8+STkqU3L3jIUjaL
         Jz5+xaqKTXC6t7qfpqfAuWhzT4Ci8i2SxqtosVuaSLDleIlj4VrL1EcOqT3gje/W/OIE
         mzyFAlBQok4XoKRvCPsq1a4c/AzRvZLjJVQFAe0V43mLuBSVCk1eeClHV4geob+T+PeR
         TIIWiQ5lNGh/FopY8CZoCWfBXlx8BeGgbZTvZ0MbYlvXOiFk3dBtIkWmCRBkWqzDrMs3
         q6kl66odsPKiRLlpD1a3BMQ/sBGcV0fXDObSG9Pw5AXOZ78x+Ru9AOgPEVOGltyg2C5q
         zB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iQkIWuK6T8YqNPwHvJmW+2nJO3vwoF8f947VD1brRE4=;
        b=ayw2aNk4g+hA6YBzcq7k9b8f94nLLBY+O8I2fHBKI5Cwd2nEs+56QN/u5zrcH/Lox2
         bDD/bUaZ13/0dyFjScvoABK/SZPtpmFqSiHcEMGMFTHQn3FsWBMBHoCrSKAEiGUWa5Gw
         zGpjVEaAXgBvqbyWwfrAZfZEjXKl4Lkkg7yqrQP09VVia1QEiDxxFHPck5o4v7z3VNtL
         VPrBlHGs+XwYrsaW77RTA2TFa2wRQT/ZHvxsqBDMjMe5jIsKogGMesekJaGv3eo/z89w
         UvBQi94lCfDwvvTRQUfNdMZa2ZiVF43w+mf4FjDKewAVnYs6FqsK7R2+D9BrtQUxdK8V
         ONVw==
X-Gm-Message-State: AD7BkJJfepGxBqWwwWSqfpWe2qO+CF1FsVzKF1v9Cfy659P0b0mIbqVGKGWeBgrs1uRJxTX6
X-Received: by 10.98.73.198 with SMTP id r67mr5040099pfi.140.1456798059405;
        Mon, 29 Feb 2016 18:07:39 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id fn3sm40972228pab.20.2016.02.29.18.07.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 18:07:38 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.1.g68b4e3f
In-Reply-To: <1456798040-30129-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287992>

Just pass it along to "git submodule update", which may pick reasonable
defaults if you don't specify an explicit number.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.8.0.rc0.1.g68b4e3f
