Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64E31F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbeJOFzv (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37102 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeJOFzu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id c22-v6so16072162edc.4
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LW51x1NUlRt2enBA8R9++4twfuG2b94JvQxGv4O02+U=;
        b=T6xQK24lGfh1NtI4EXhwbKBmkZDDLNzCYViuJXwWj8BbsuOwf1tGH4ryyjvswV5PlB
         76HNy/NW7hvww5sQA+03FUliZqC/8f0B9crdM7wsENJnGqnecKu0HKfB6qBVUji9T6u2
         4net48FbNYbATCjkUHILNqHI4icKexjaUxGXAKnpyCWBD0GZFIwDvd/2Du39meYnoZBB
         LqOAA72/c5blYocT++ZH5jkqGByMmd6gXGGWDkPo1EOPNBN+uDxbfFfRdkcbLMHu18fI
         TKyp3RBPj1tDRUv1kra/ZQscWJQHpPTYMe76csopqcdUp2Opqow3QlcOr/TrUlN5sPvn
         mjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LW51x1NUlRt2enBA8R9++4twfuG2b94JvQxGv4O02+U=;
        b=FzFyB8jLhQwOcXRH+fUzpkVZACsbsDpnn6MlwTpzdX9ykNYhyVlQIcohh739RUMv/S
         ceIXPDfE8F4k4efaq6HXT0VBQGOaV2RD7S/yRFNmqtV2w306Py0SGfJiVcABASeneW2n
         vx38p0pcm7QsiAE3UNxJxahLr4IRhQjzvnxdO2AQNM2Tm+nU4+M0SGyYPxneyvvLGJCd
         PEE+jh2Cr2ofxo0E7eDdJrYTs0HmF2wIY6ON6in27Ntn7R7cf1wKpXaeQE2IUj/p4SJu
         talTraqvm1+et7zpb/UnHbbIfOckRVOF8mYqZWNML648NImKrysenIiMk7J2+It0LAdt
         24Zw==
X-Gm-Message-State: ABuFfog92xjX2WaMJVqumV8ue0GI9c6NkJQL5nMUjK3P1lpTZlOxy2On
        zwYYt8a8tmFXGfZjV6GZ/93LYQoj
X-Google-Smtp-Source: ACcGV63fAc0DOEZrTN83Lqz1WhHdbb3TnWqVnigFQ+MclnNNzchBmDNtQJMsLZ9UzR0LtpOszYHQLg==
X-Received: by 2002:a17:906:128d:: with SMTP id k13-v6mr8621453ejb.59.1539555202287;
        Sun, 14 Oct 2018 15:13:22 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:21 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 13/21] stash: convert show to builtin
Date:   Mon, 15 Oct 2018 01:11:19 +0300
Message-Id: <e748881a4c9c1cebcd4034f6092b6b575d846c8b.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
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
index a1249f6b76..3f7ace92f5 100644
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
@@ -647,6 +655,83 @@ static int list_stash(int argc, const char **argv, const char *prefix)
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
@@ -679,6 +764,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.0.rc0.23.g10a62394e7

