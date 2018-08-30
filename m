Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49BF1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeHaBqD (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:46:03 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:52031 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbeHaBqC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:46:02 -0400
Received: by mail-wm0-f42.google.com with SMTP id y2-v6so3342788wma.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PMwA0+NRGFeXZpoNKpuZ7WYoJlVdPunX5Xg+zDd76vQ=;
        b=gStCYUWbWKt8mTazQsD4MIcd5YdpA968dnFUx1J8EFX3rN7GyFKqKY7ziR+GC4Rvm5
         bGydmTHtjGugcfFw4ZC8aiE0Z/6+QqQMDrz898Q8yzdGCqBl3giydSI/rBVw1JUlUR6S
         +Nb9/vXQbzVseIngniYbGipcdKnkUsEQiXBximEHteod0d3dKua/jG/E3AUArJo9U+jh
         5pWBwZGGJbZxFfJnctsmfWaaiE0ljqxGndiWnRiQwCFimGzVPycyU0qZj2Xv+KRP7guO
         3Du900Y0KxoxhfajavhMS/pq2YYEs6Lczg7dHGBsEFKCR+/5XVjavByV9FDvIUbRPoRH
         ZtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMwA0+NRGFeXZpoNKpuZ7WYoJlVdPunX5Xg+zDd76vQ=;
        b=eU9TXJVqIMMbYsBJEefKhiV9OS/QPliHD64cR6c75EEFltQTyM1ta9RYsn4mZHCzQ4
         X3MPEXzBfzERIT5+krW+aYhl72NM+pNpwfzWptTRcojSQpRDjqiPgQa9q8C4QHMCzfSV
         vpLkN/e53rNO5mA1eubJuBBA5DY8Fk9PDL1IfDNv+cq+Wxa7/BsMksMoB2bDMPx3nv0A
         5KVkoPOtFTxy93L5bCmikpd9vAU31GqVuWLGNZi5krL0FnX34qDpXRcRwq/dq6T/1/ok
         6AugTVJ5JiToZ9/xBfqyEQ2BsMkOHl5KNbFiNPXDczyhMffSY2em6H7RIrHTokvNmN3x
         wvBA==
X-Gm-Message-State: APzg51A+mEOTBcWvOAVitJuCKoSyZgzGau/dvkzqYZ7BxLNtHWO07eBu
        KtKx+SvmK6HnsxlCuu2xlayAvYM+
X-Google-Smtp-Source: ANB0Vda/HiPdOxf4U+yKhY1zdjbgXuLEeGUfHwZERSieUq3g3TUGdQZKnbO3Hb5fqP5V9ugQBGNcTQ==
X-Received: by 2002:a1c:28c2:: with SMTP id o185-v6mr2921772wmo.40.1535665308120;
        Thu, 30 Aug 2018 14:41:48 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.47
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:47 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 11/20] stash: convert show to builtin
Date:   Fri, 31 Aug 2018 00:40:41 +0300
Message-Id: <8d93bee7c627c5af94e6c35898e396b427db570f.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
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
index c42a297078..1dba7e6853 100644
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
+	N_("git stash--helper show [<stash>]"),
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
@@ -25,6 +28,11 @@ static const char * const git_stash_helper_list_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_show_usage[] = {
+	N_("git stash--helper show [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_drop_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	NULL
@@ -638,6 +646,83 @@ static int list_stash(int argc, const char **argv, const char *prefix)
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
+	for (i = 1; i < argc; ++i) {
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
@@ -670,6 +755,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.0.rc0.22.gc26283d74e

