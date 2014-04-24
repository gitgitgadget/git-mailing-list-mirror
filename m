From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: [PATCH v6 2/2] commit: add --ignore-submodules[=<when>] parameter
Date: Thu, 24 Apr 2014 21:42:57 +0200
Message-ID: <53596941.5050207@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de>	<CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com>	<5339F122.60801@gmail.com>	<5339FBB4.1010101@gmail.com>	<533B2036.3050506@web.de>	<533B36AA.3090600@gmail.com>	<533C5CBD.4050601@web.de>	<533C6B57.3080901@gmail.com>	<534180BC.308@web.de>	<53431CB8.2050600@gmail.com>	<53432EA5.5060102@gmail.com>	<53444368.9050607@web.de>	<5349BC2C.9030509@gmail.com>	<5349C314.50500@gmail.com>	<53511617.80506@web.de>	<535596D1.6070709@gmail.com>	<5356BF7C.1010200@web.de>	<5356DB37.8
 020209@gmail.com> <CAPig+cTyANC34jbeH1EzaWsJMnVemjSGEDB8b2s9VuRqAYwMng@mail.gmail.com> <53596756.7020306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 24 21:43:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdPY6-00015A-Cv
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 21:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbaDXTnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 15:43:04 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:51937 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbaDXTnB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 15:43:01 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so2211044eek.13
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TyIhykN3JIjWQtya8XKXP5s2qdYAxqt5zmkp6eUwdVE=;
        b=DY5T5cOjylg9+yC2zNeHJQSQw78X9UvuAoSmkDczlzTqdt9IUy8H+B4wpmKE58cgdt
         Bc55YIJrRnE3yADJ1EOuNYQVGojCzT1uoP2IhnZWRaiNIEzc2spltzSb4E1+MXn5pAG4
         j/kQeiF0qB7OtMV9E6rzCD85KZRaCG29qsECzdqxBnByT1r/TWyMhfxlq5a8xwU/VYJj
         FtcUCq4ibkqCHFdVJWIqjIuL6b9lefoGblUaRoumSSgO+3wpdLwBBfPafXXAbq1Fil5q
         DrruySNuV4H5hb8lUnCdYdezmfcaDEmgXOvjlp1nYua2dqdEroQgIpEyzZA9zl3ihQro
         gqdQ==
X-Received: by 10.14.4.201 with SMTP id 49mr4408078eej.13.1398368580118;
        Thu, 24 Apr 2014 12:43:00 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id y51sm18538839eeu.0.2014.04.24.12.42.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Apr 2014 12:42:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53596756.7020306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247005>

Allow ignoring submodules (or not) by command line switch, like diff
and status do.

Git commit honors the 'ignore' setting from .gitmodules or .git/config,
but didn't allow to override it from command line.

This patch depends on Jens Lehmann's patch "commit -m: commit staged
submodules regardless of ignore config". Without it,
"commit -m --ignore-submodules" would not work and tests introduced
here would fail.

Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
---
Patch changelog:
v6
* corrected wording and formatting errors (as pointed out by Eric Sunshine)
v5
* fixed file mode of added test script (644 -> 755)
* replaced test_might_fail with test_must_fail in test script

 Documentation/git-commit.txt        |  7 ++++
 builtin/commit.c                    |  8 +++-
 t/t7513-commit-ignore-submodules.sh | 80 +++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100755 t/t7513-commit-ignore-submodules.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0bbc8f5..55995be 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
+	   [--ignore-submodules[=<when>]]
 	   [-i | -o] [-S[<key-id>]] [--] [<file>...]
 
 DESCRIPTION
@@ -277,6 +278,12 @@ The possible options are:
 The default can be changed using the status.showUntrackedFiles
 configuration variable documented in linkgit:git-config[1].
 
+--ignore-submodules[=<when>]::
+	Can be used to override any settings of the 'submodule.*.ignore'
+	option in linkgit:git-config[1] or linkgit:gitmodules[5].
+	<when> can be either "none", "dirty, "untracked" or "all",
+	defaulting to "all".
+
 -v::
 --verbose::
 	Show unified diff between the HEAD commit and what
diff --git a/builtin/commit.c b/builtin/commit.c
index 5444111..dc1d8d0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -361,7 +361,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	 */
 	if (all || (also && pathspec.nr)) {
 		fd = hold_locked_index(&index_lock, 1);
-		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, NULL);
+		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, ignore_submodule_arg);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
@@ -1540,6 +1540,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
+		  N_("ignore changes to submodules, optional when: all, none. (Default: all)"),
+		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		/* end commit contents options */
 
 		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
@@ -1578,6 +1581,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
+
+	s.ignore_submodule_arg = ignore_submodule_arg;
+
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	index_file = prepare_index(argc, argv, prefix, current_head, 0);
diff --git a/t/t7513-commit-ignore-submodules.sh b/t/t7513-commit-ignore-submodules.sh
new file mode 100755
index 0000000..10ae178
--- /dev/null
+++ b/t/t7513-commit-ignore-submodules.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Ronald Weiss
+#
+
+test_description='Test of git commit --ignore-submodules'
+
+. ./test-lib.sh
+
+test_expect_success 'create submodule' '
+	test_create_repo sm &&
+	(
+		cd sm &&
+		>foo &&
+		git add foo &&
+		git commit -m "Add foo"
+	) &&
+	git submodule add ./sm &&
+	git commit -m "Add sm"
+'
+
+update_sm () {
+	(
+		cd sm &&
+		echo bar >>foo &&
+		git add foo &&
+		git commit -m "Updated foo"
+	)
+}
+
+test_expect_success 'commit -a --ignore-submodules=all ignores dirty submodule' '
+	update_sm &&
+	test_must_fail git commit -a --ignore-submodules=all -m "Update sm"
+'
+
+test_expect_success 'commit -a --ignore-submodules=none overrides ignore=all setting' '
+	update_sm &&
+	git config submodule.sm.ignore all &&
+	git commit -a --ignore-submodules=none -m "Update sm" &&
+	git diff --exit-code --ignore-submodules=none &&
+	git diff --cached --exit-code --ignore-submodules=none
+'
+
+test_expect_success 'commit --ignore-submodules status of submodule with untracked content' '
+	GIT_EDITOR=cat &&
+	export GIT_EDITOR &&
+	echo untracked >sm/untracked &&
+
+	test_must_fail git commit --ignore-submodules=none >output &&
+	test_i18ngrep modified output &&
+
+	test_must_fail git commit --ignore-submodules=untracked >output &&
+	test_must_fail test_i18ngrep modified output &&
+
+	test_must_fail git commit --ignore-submodules=dirty >output &&
+	test_must_fail test_i18ngrep modified output &&
+
+	test_must_fail git commit --ignore-submodules=all >output &&
+	test_must_fail test_i18ngrep modified output
+'
+
+test_expect_success 'commit --ignore-submodules status of dirty submodule' '
+	GIT_EDITOR=cat &&
+	export GIT_EDITOR &&
+	echo dirty >>sm/foo &&
+
+	test_must_fail git commit --ignore-submodules=none >output &&
+	test_i18ngrep modified output &&
+
+	test_must_fail git commit --ignore-submodules=untracked >output &&
+	test_i18ngrep modified output &&
+
+	test_must_fail git commit --ignore-submodules=dirty >output &&
+	test_must_fail test_i18ngrep modified output &&
+
+	test_must_fail git commit --ignore-submodules=all >output &&
+	test_must_fail test_i18ngrep modified output
+'
+
+test_done
-- 
2.0.0.rc0.3.gd50de04
