Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87BDC1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439045AbeKWJsJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:48:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34401 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439015AbeKWJsH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:48:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so10660505wrw.1
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BLrcBN8nCLZ3dL8s/i19Eq4ny00vWmFxreuQEA/H/SU=;
        b=sUA3NQCFQxBOWcBc1b+a66WNRNGWORScr3UqZPGN/7S3qiuu/Dt4y4wFrNHvV9NQwY
         jdDQkClvOjd+ZqhoMbrpzy0J+b+uQ86FwLD4TYTCB69Agv3Ab4R4pFi2bj3V0ZOZ0Pjg
         Fc+GmwZRk1ymjFz/l4vsqypnTubdhOPHNUk+gTNBLVrX5JEEgMp564xMmyqNPcTOo31n
         FkECV4o3WwB8tl94XLd+h/Bc1nKiKlKy0r6yD6VVtyXXNS5n45dCNZ6eO46FO8Q50mEO
         IPN23r5Jf6bhQ1n8nIJXAHG2ZrMk5qgAmR7jmdcMJlT2wYsgPShUvUHrObeo9uisNyfw
         OiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BLrcBN8nCLZ3dL8s/i19Eq4ny00vWmFxreuQEA/H/SU=;
        b=ileMHXjGFmDoL0pX3RkDlVPTEEByQhCBiTjB7CuyFU2IeCePvVuMsJMzIVQGZQd90c
         CYAPakYgbvGTzg13+tomKBAlAawTn6So3bSTNlEanxnQwgvJJST8awq9ycR/h03FyqTH
         T7H+rLl3orgELEXQGMGNC/QwkV01S/nyKySOHpRNqJxUSUYZS6woGC5l8fMxgI9ekgm8
         VS9LzCncP0MdT8B8Y0sRmgqssjs4oHgNh854Fjd9goEVawCnoT/MPrERVed8CGs8eZWI
         VL4Bp4GQxUzQljX+wN/B8IMaqW0RYyaMTqUiZGkiJkX5QoG6n1tEZMBIXkyykFJ2kRD3
         VWBg==
X-Gm-Message-State: AA+aEWba5ac0i7+mXo6CFyDs4A17Y9yr8mvObSRMcR7qnZ9mO8Ae43xG
        dD5T2JAFmIwgWtKKoiFKiE/8s96l
X-Google-Smtp-Source: AFSGD/V5LaWzF5MAks65EE9QAEAGG3iPWS9OKNpy94j1xBuGfGE9AKu/zZivMM++bW3DMD9CorZ1cw==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr7583444wrs.75.1542927985868;
        Thu, 22 Nov 2018 15:06:25 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:25 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 14/22] stash: convert show to builtin
Date:   Fri, 23 Nov 2018 01:05:34 +0200
Message-Id: <3e141cf7471ea0db65a5308105d549cd59388a6a.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash show to the helper and delete the show_stash, have_stash,
assert_stash_like, is_stash_like and parse_flags_and_rev functions
from the shell script now that they are no longer needed.

In shell version, although `git stash show` accepts `--index` and
`--quiet` options, it ignores them. In C, both options are passed
further to `git diff`.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c |  87 ++++++++++++++++++++++++++
 git-stash.sh            | 132 +---------------------------------------
 2 files changed, 88 insertions(+), 131 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index d66a4589a5..36651f745a 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -10,9 +10,12 @@
 #include "run-command.h"
 #include "dir.h"
 #include "rerere.h"
+#include "revision.h"
+#include "log-tree.h"
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper list [<options>]"),
+	N_("git stash--helper show [<options>] [<stash>]"),
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
@@ -25,6 +28,11 @@ static const char * const git_stash_helper_list_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_show_usage[] = {
+	N_("git stash--helper show [<options>] [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_drop_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	NULL
@@ -645,6 +653,83 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 	return run_command(&cp);
 }
 
+static int show_stat = 1;
+static int show_patch;
+
+static int git_stash_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "stash.showstat")) {
+		show_stat = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "stash.showpatch")) {
+		show_patch = git_config_bool(var, value);
+		return 0;
+	}
+	return git_default_config(var, value, cb);
+}
+
+static int show_stash(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	int opts = 0;
+	int ret = 0;
+	struct stash_info info;
+	struct rev_info rev;
+	struct argv_array stash_args = ARGV_ARRAY_INIT;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	init_diff_ui_defaults();
+	git_config(git_diff_ui_config, NULL);
+	init_revisions(&rev, prefix);
+
+	for (i = 1; i < argc; i++) {
+		if (argv[i][0] != '-')
+			argv_array_push(&stash_args, argv[i]);
+		else
+			opts++;
+	}
+
+	ret = get_stash_info(&info, stash_args.argc, stash_args.argv);
+	argv_array_clear(&stash_args);
+	if (ret)
+		return -1;
+
+	/*
+	 * The config settings are applied only if there are not passed
+	 * any options.
+	 */
+	if (!opts) {
+		git_config(git_stash_config, NULL);
+		if (show_stat)
+			rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT;
+
+		if (show_patch)
+			rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
+
+		if (!show_stat && !show_patch) {
+			free_stash_info(&info);
+			return 0;
+		}
+	}
+
+	argc = setup_revisions(argc, argv, &rev, NULL);
+	if (argc > 1) {
+		free_stash_info(&info);
+		usage_with_options(git_stash_helper_show_usage, options);
+	}
+
+	rev.diffopt.flags.recursive = 1;
+	setup_diff_pager(&rev.diffopt);
+	diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
+	log_tree_diff_flush(&rev);
+
+	free_stash_info(&info);
+	return diff_result_code(&rev.diffopt, 0);
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -677,6 +762,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!branch_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "list"))
 		return !!list_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "show"))
+		return !!show_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 6052441aa2..0d05cbc1e5 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -378,35 +378,6 @@ save_stash () {
 	fi
 }
 
-have_stash () {
-	git rev-parse --verify --quiet $ref_stash >/dev/null
-}
-
-show_stash () {
-	ALLOW_UNKNOWN_FLAGS=t
-	assert_stash_like "$@"
-
-	if test -z "$FLAGS"
-	then
-		if test "$(git config --bool stash.showStat || echo true)" = "true"
-		then
-			FLAGS=--stat
-		fi
-
-		if test "$(git config --bool stash.showPatch || echo false)" = "true"
-		then
-			FLAGS=${FLAGS}${FLAGS:+ }-p
-		fi
-
-		if test -z "$FLAGS"
-		then
-			return 0
-		fi
-	fi
-
-	git diff ${FLAGS} $b_commit $w_commit
-}
-
 show_help () {
 	exec git help stash
 	exit 1
@@ -448,107 +419,6 @@ show_help () {
 #   * unknown flags were set and ALLOW_UNKNOWN_FLAGS is not "t"
 #
 
-parse_flags_and_rev()
-{
-	test "$PARSE_CACHE" = "$*" && return 0 # optimisation
-	PARSE_CACHE="$*"
-
-	IS_STASH_LIKE=
-	IS_STASH_REF=
-	INDEX_OPTION=
-	s=
-	w_commit=
-	b_commit=
-	i_commit=
-	u_commit=
-	w_tree=
-	b_tree=
-	i_tree=
-	u_tree=
-
-	FLAGS=
-	REV=
-	for opt
-	do
-		case "$opt" in
-			-q|--quiet)
-				GIT_QUIET=-t
-			;;
-			--index)
-				INDEX_OPTION=--index
-			;;
-			--help)
-				show_help
-			;;
-			-*)
-				test "$ALLOW_UNKNOWN_FLAGS" = t ||
-					die "$(eval_gettext "unknown option: \$opt")"
-				FLAGS="${FLAGS}${FLAGS:+ }$opt"
-			;;
-			*)
-				REV="${REV}${REV:+ }'$opt'"
-			;;
-		esac
-	done
-
-	eval set -- $REV
-
-	case $# in
-		0)
-			have_stash || die "$(gettext "No stash entries found.")"
-			set -- ${ref_stash}@{0}
-		;;
-		1)
-			:
-		;;
-		*)
-			die "$(eval_gettext "Too many revisions specified: \$REV")"
-		;;
-	esac
-
-	case "$1" in
-		*[!0-9]*)
-			:
-		;;
-		*)
-			set -- "${ref_stash}@{$1}"
-		;;
-	esac
-
-	REV=$(git rev-parse --symbolic --verify --quiet "$1") || {
-		reference="$1"
-		die "$(eval_gettext "\$reference is not a valid reference")"
-	}
-
-	i_commit=$(git rev-parse --verify --quiet "$REV^2") &&
-	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" 2>/dev/null) &&
-	s=$1 &&
-	w_commit=$1 &&
-	b_commit=$2 &&
-	w_tree=$3 &&
-	b_tree=$4 &&
-	i_tree=$5 &&
-	IS_STASH_LIKE=t &&
-	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
-	IS_STASH_REF=t
-
-	u_commit=$(git rev-parse --verify --quiet "$REV^3") &&
-	u_tree=$(git rev-parse "$REV^3:" 2>/dev/null)
-}
-
-is_stash_like()
-{
-	parse_flags_and_rev "$@"
-	test -n "$IS_STASH_LIKE"
-}
-
-assert_stash_like() {
-	is_stash_like "$@" || {
-		args="$*"
-		die "$(eval_gettext "'\$args' is not a stash-like commit")"
-	}
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -573,7 +443,7 @@ list)
 	;;
 show)
 	shift
-	show_stash "$@"
+	git stash--helper show "$@"
 	;;
 save)
 	shift
-- 
2.19.1.878.g0482332a22

