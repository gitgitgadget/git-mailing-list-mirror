From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: [PATCH v4 1/2] add: add --ignore-submodules[=<when>] parameter
Date: Sun, 13 Apr 2014 00:45:58 +0200
Message-ID: <5349C226.9090709@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com> <53432EA5.5060102@gmail.com> <53444368.9050607@web.de> <5349BC2C.9030509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 00:46:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ6gb-0000iK-LH
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 00:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbaDLWqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 18:46:05 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:52380 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaDLWqD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 18:46:03 -0400
Received: by mail-ee0-f48.google.com with SMTP id b57so5201586eek.7
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LLZybHFlQbfwuNn4Y8uyFUcF+N/uN+zHZGVu46XvwGQ=;
        b=vDLuMIAEHwLz+tuldIta3QBGLdvB14F5XB1CPwLOV2XWpcThLUuEAZVVyH6NIZ90xv
         uYw1K4jykxBlpwTeuUh48bWXx8APvHKhp1fLwJr9GBYz6FhuhnyIJeK9wpW1raJUfwQr
         x/blO/pfd6VKcKGffhte23oQ1H32suWkeS+ZeQHdeTBBsEMfTp0UuG6TKGkXQW/UtAXd
         6j86/cUWXFpf9OgopDxR1JYRk0VocJLMUmpmwzbHXKgQilt0igDvU6moVbYgwz4lz2J7
         wUe7nW6lFcBo4GYxaLXNxg6xnj5mbEb97ka612SM2keXw+CWDEGF1eTyCt4A3AjakrQR
         AjHg==
X-Received: by 10.14.206.137 with SMTP id l9mr39928197eeo.40.1397342760928;
        Sat, 12 Apr 2014 15:46:00 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id 4sm28522130eeq.33.2014.04.12.15.45.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 15:46:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5349BC2C.9030509@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246200>

Allow ignoring submodules (or not) by command line switch, like diff
and status do.

Git add currently doesn't honor ignore from .gitmodules or .git/config,
which is related functionality, however I'd like to change that in
another patch, coming soon.

This commit is also a prerequisite for the next one in series, which
adds the --ignore-submodules switch to git commit. That's why signature
of function add_files_to_cache was changed. That also requires compilo
fixes in checkout.c and commit.c

Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
---
 Documentation/git-add.txt        |  7 ++++++-
 builtin/add.c                    | 16 ++++++++++++--
 builtin/checkout.c               |  2 +-
 builtin/commit.c                 |  2 +-
 cache.h                          |  2 +-
 t/t3704-add-ignore-submodules.sh | 45 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 68 insertions(+), 6 deletions(-)
 create mode 100644 t/t3704-add-ignore-submodules.sh

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 9631526..b2c936f 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
 	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
-	  [--] [<pathspec>...]
+	  [--ignore-submodules[=<when>]] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -164,6 +164,11 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	be ignored, no matter if they are already present in the work
 	tree or not.
 
+--ignore-submodules[=<when>]::
+	Can be used to override any settings of the 'submodule.*.ignore'
+	option in linkgit:git-config[1] or linkgit:gitmodules[5].
+	<when> can be either "none" or "all", which is the default.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
diff --git a/builtin/add.c b/builtin/add.c
index 459208a..85f2110 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -83,7 +83,8 @@ static void update_callback(struct diff_queue_struct *q,
 }
 
 int add_files_to_cache(const char *prefix,
-		       const struct pathspec *pathspec, int flags)
+		       const struct pathspec *pathspec, int flags,
+		       const char *ignore_submodules_arg)
 {
 	struct update_callback_data data;
 	struct rev_info rev;
@@ -99,6 +100,12 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
+
+	if (ignore_submodules_arg) {
+		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+		handle_ignore_submodules_arg(&rev.diffopt, ignore_submodules_arg);
+	}
+
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	return !!data.add_errors;
 }
@@ -237,6 +244,8 @@ static int ignore_add_errors, intent_to_add, ignore_missing;
 static int addremove = ADDREMOVE_DEFAULT;
 static int addremove_explicit = -1; /* unspecified */
 
+static char *ignore_submodule_arg;
+
 static int ignore_removal_cb(const struct option *opt, const char *arg, int unset)
 {
 	/* if we are told to ignore, we are not adding removals */
@@ -262,6 +271,9 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
+	{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
+	  N_("ignore changes to submodules, optional when: all, none. (Default: all)"),
+	  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	OPT_END(),
 };
 
@@ -434,7 +446,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	plug_bulk_checkin();
 
-	exit_status |= add_files_to_cache(prefix, &pathspec, flags);
+	exit_status |= add_files_to_cache(prefix, &pathspec, flags, ignore_submodule_arg);
 
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 07cf555..607af47 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -525,7 +525,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * entries in the index.
 			 */
 
-			add_files_to_cache(NULL, NULL, 0);
+			add_files_to_cache(NULL, NULL, 0, NULL);
 			/*
 			 * NEEDSWORK: carrying over local changes
 			 * when branches have different end-of-line
diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..a148e28 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -361,7 +361,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	 */
 	if (all || (also && pathspec.nr)) {
 		fd = hold_locked_index(&index_lock, 1);
-		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
+		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, NULL);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
diff --git a/cache.h b/cache.h
index 107ac61..a6cedc0 100644
--- a/cache.h
+++ b/cache.h
@@ -1370,7 +1370,7 @@ void packet_trace_identity(const char *prog);
  * return 0 if success, 1 - if addition of a file failed and
  * ADD_FILES_IGNORE_ERRORS was specified in flags
  */
-int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags);
+int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags, const char *ignore_submodules_arg);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
diff --git a/t/t3704-add-ignore-submodules.sh b/t/t3704-add-ignore-submodules.sh
new file mode 100644
index 0000000..db58f0c
--- /dev/null
+++ b/t/t3704-add-ignore-submodules.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Ronald Weiss
+#
+
+test_description='Test of git add with ignoring submodules'
+
+. ./test-lib.sh
+
+test_expect_success 'create dirty submodule' '
+	test_create_repo sm && (
+		cd sm &&
+		>foo &&
+		git add foo &&
+		git commit -m "Add foo"
+	) &&
+	git submodule add ./sm &&
+	git commit -m "Add sm" && (
+		cd sm &&
+		echo bar >> foo &&
+		git add foo &&
+		git commit -m "Update foo"
+	)
+'
+
+test_expect_success 'add --ignore-submodules ignores submodule' '
+	git reset &&
+	git add -u --ignore-submodules &&
+	git diff --cached --exit-code --ignore-submodules=none
+'
+
+test_expect_success 'add --ignore-submodules=all ignores submodule' '
+	git reset &&
+	git add -u --ignore-submodules=all &&
+	git diff --cached --exit-code --ignore-submodules=none
+'
+
+test_expect_success 'add --ignore-submodules=none overrides ignore=all from config' '
+	git reset &&
+	git config submodule.sm.ignore all &&
+	git add -u --ignore-submodules=none &&
+	test_must_fail git diff --cached --exit-code --ignore-submodules=none
+'
+
+test_done
-- 
1.9.1.3.g7790cde.dirty
 
