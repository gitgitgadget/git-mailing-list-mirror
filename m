Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 986A31F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbeLTTpG (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38565 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389375AbeLTTpF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so3516250wml.3
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Pf6CIX20kPZL9hb6fyLZ7eMiZZ108ucDKIaGVOrf9k=;
        b=exMlWNsSAv0hWIn8LSHpnDiK/l2QJ7TrTCAkTffsbokJ1TNI0dzPCoX00EgsaG5bFL
         gwp0HIzGen1u05ohsx6EHz12foi5RN+LPo3A3y6tcGWT+10BWgzXCUc74QNdCksmToQc
         ux8+gpXw7EsNwAoS0Q5wWP/xFHu8IG1WCwvXSlUOOSBLWmCCjW5EjB+4xY5FoIiIAoP+
         j9DgnJOddQtueBkbW9T3Jz21zzQEHT1wO9FOxLoaDY9t4E9O8pNVPnNpN7mylvm1xFwk
         dKuAQjod197dnKTuQ3YwMWLMlCW5eoTVRw6K5rfsGG+J4u/l2RDI8xF1Ubitfe8o1V3o
         f3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Pf6CIX20kPZL9hb6fyLZ7eMiZZ108ucDKIaGVOrf9k=;
        b=A38ALSC9f+35HXxBvx2EeWa0mjgJId0APN0fqhZ+6K3iUOSt80lU1isIuVGPQm+IYP
         zD7zIuCstAX0mkNZYlENLtp9k7KobZyaPaf8OrSojLprnfF8fwrEXkXhF7O47gklNS1F
         O93g5La6W/oVtkGGIt07cTSdjAAF2QqmCzH/8T7hd+H7jbkAwhlVsiradknxWgdkfWM2
         SeiReyU03LIA+ZV/yKQ4/0kOUSZzbNzcUP/+xnujQ4fwJ+Ui7+SP2naqQILvJALzwPpB
         lkRNOGymwuV+txt21/jq0Niqwe+6+cYcmjCl2KI+asixkADJZOrTMMe7x0rPsHbs1Dil
         rRnA==
X-Gm-Message-State: AJcUukdNM8Qz1C1h+RT9sFzC5SvzCqr6DB2AaUoERJnicG/lFjmgrLQd
        1qrjWLfMLSf7QG6htHtkwhW4aQiFvF0=
X-Google-Smtp-Source: ALg8bN6AoHCQ2lGhulAkCMevcDPni7h3emK3gl5z0F9JydN7xfY1y4r3FzTUL7p3ToK8jyJPQot1Jg==
X-Received: by 2002:a1c:541a:: with SMTP id i26mr6099wmb.128.1545335102731;
        Thu, 20 Dec 2018 11:45:02 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:45:02 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 15/26] stash: convert show to builtin
Date:   Thu, 20 Dec 2018 21:44:31 +0200
Message-Id: <28c03869f67c04eef446b8849ab7e3ddc1bbccb0.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
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
index ab3992b59d..d0318f859e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -395,35 +395,6 @@ save_stash () {
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
@@ -465,107 +436,6 @@ show_help () {
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
@@ -590,7 +460,7 @@ list)
 	;;
 show)
 	shift
-	show_stash "$@"
+	git stash--helper show "$@"
 	;;
 save)
 	shift
-- 
2.20.1.441.g764a526393

