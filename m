Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF7071F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbeLTTpQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33229 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389401AbeLTTpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so12682844wmh.0
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nke+nAq5QQPSe/It7C9Y7bmTueWz02m2VjOe5mfUz4Y=;
        b=J7vM2U8/ncvpu0LHA+tJp+EqsWk9dl8TEadlQXL0ChZYxQm/genlp6r2OjZSiroD1g
         MACelR2CY157V96girqJIGOLwSFNabH1rw1d9swvs4HH3bgWUAif2jRKcQSqEW3yiX3i
         96H378ob8CBKXmNeaHB/vwkeksvAyjUME2S49vcpqxbXnAeBQfvreX0nPG6w5cZX9GNM
         CbC1PaoEucWsP5z1DgRSc/mY5I4ShyHBxy2eQaV+QU1ryGFmp6qGKIc1zPXcIG6moiZQ
         ppLGPv6zT+zMv4IbpSnUt9sKqiY/+bDw7GGaXg+AVX4o7xX5/hDmlsAye2WyID6f6b3M
         C6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nke+nAq5QQPSe/It7C9Y7bmTueWz02m2VjOe5mfUz4Y=;
        b=B5qqiPGB0rWWTP+DMkmSZLqoeIlBlTO74cMNck2+rHnDopWUiiiM0j5/+uZk8Wb/TQ
         4z1qQpq3jjun3YYNrC1ZZMyFig7tq8meD3CdjkPI9/bo0yneAb7SDe8XfBQ11T8hp2Ak
         w8hI6iugo+IRIVk+aIjk7e/evRbEr49gvv+Cg4U9a6pYSO5S++B/1cHEVnyJHr0tNwPl
         ICJoprZyPphF8w2HavpAcdbGay8E+RzuHaWG84wRc180Urp1r9F03vVnlQAxy8Vm6tsg
         TZuLWsoaYOQHf9Xq6Gv5+vdd9oQM8H/3jGnUzOY+MNsAExBCiY4iCowYET6uTT/HcZWL
         3K2A==
X-Gm-Message-State: AA+aEWYert1K2iFvVsrd1JPRx24nQVpUqUT28BbIvCY135Mx72B8Ue76
        x9mlTXxMe6u9n9eCF0UZXVBV491XeAI=
X-Google-Smtp-Source: ALg8bN4QMwAUjcztbyMXlVhlqlUMBv2MShuhkthBQhw7BiVSnTVaunpQHkzhhAgFBmMaxxakRHRtPA==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr26843wmc.0.1545335107333;
        Thu, 20 Dec 2018 11:45:07 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:45:06 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 20/26] stash: convert save to builtin
Date:   Thu, 20 Dec 2018 21:44:36 +0200
Message-Id: <1b16cdb63b0d40161bf3b70480ff7177f14fd3bf.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash save to the helper and delete functions which are no
longer needed (`show_help()`, `save_stash()`, `push_stash()`,
`create_stash()`, `clear_stash()`, `untracked_files()` and
`no_changes()`).

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c |  50 ++++++
 git-stash.sh            | 328 +---------------------------------------
 2 files changed, 52 insertions(+), 326 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 5f9914ca27..19ead63c46 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -26,6 +26,8 @@ static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
 	   "          [--] [<pathspec>...]]"),
+	N_("git stash--helper save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
 	NULL
 };
 
@@ -81,6 +83,12 @@ static const char * const git_stash_helper_push_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_save_usage[] = {
+	N_("git stash--helper save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
@@ -1490,6 +1498,46 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 			     include_untracked);
 }
 
+static int save_stash(int argc, const char **argv, const char *prefix)
+{
+	int keep_index = -1;
+	int patch_mode = 0;
+	int include_untracked = 0;
+	int quiet = 0;
+	int ret = 0;
+	const char *stash_msg = NULL;
+	struct pathspec ps;
+	struct strbuf stash_msg_buf = STRBUF_INIT;
+	struct option options[] = {
+		OPT_BOOL('k', "keep-index", &keep_index,
+			 N_("keep index")),
+		OPT_BOOL('p', "patch", &patch_mode,
+			 N_("stash in patch mode")),
+		OPT__QUIET(&quiet, N_("quiet mode")),
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			 N_("include untracked files in stash")),
+		OPT_SET_INT('a', "all", &include_untracked,
+			    N_("include ignore files"), 2),
+		OPT_STRING('m', "message", &stash_msg, "message",
+			   N_("stash message")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_save_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc)
+		stash_msg = strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
+
+	memset(&ps, 0, sizeof(ps));
+	ret = do_push_stash(ps, stash_msg, quiet, keep_index,
+			    patch_mode, include_untracked);
+
+	strbuf_release(&stash_msg_buf);
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -1530,6 +1578,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!create_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "push"))
 		return !!push_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "save"))
+		return !!save_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 51d7a06601..695f1feba3 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -36,331 +36,6 @@ else
        reset_color=
 fi
 
-no_changes () {
-	git diff-index --quiet --cached HEAD --ignore-submodules -- "$@" &&
-	git diff-files --quiet --ignore-submodules -- "$@" &&
-	(test -z "$untracked" || test -z "$(untracked_files "$@")")
-}
-
-untracked_files () {
-	if test "$1" = "-z"
-	then
-		shift
-		z=-z
-	else
-		z=
-	fi
-	excl_opt=--exclude-standard
-	test "$untracked" = "all" && excl_opt=
-	git ls-files -o $z $excl_opt -- "$@"
-}
-
-prepare_fallback_ident () {
-	if ! git -c user.useconfigonly=yes var GIT_COMMITTER_IDENT >/dev/null 2>&1
-	then
-		GIT_AUTHOR_NAME="git stash"
-		GIT_AUTHOR_EMAIL=git@stash
-		GIT_COMMITTER_NAME="git stash"
-		GIT_COMMITTER_EMAIL=git@stash
-		export GIT_AUTHOR_NAME
-		export GIT_AUTHOR_EMAIL
-		export GIT_COMMITTER_NAME
-		export GIT_COMMITTER_EMAIL
-	fi
-}
-
-clear_stash () {
-	if test $# != 0
-	then
-		die "$(gettext "git stash clear with parameters is unimplemented")"
-	fi
-	if current=$(git rev-parse --verify --quiet $ref_stash)
-	then
-		git update-ref -d $ref_stash $current
-	fi
-}
-
-create_stash () {
-
-	prepare_fallback_ident
-
-	stash_msg=
-	untracked=
-	while test $# != 0
-	do
-		case "$1" in
-		-m|--message)
-			shift
-			stash_msg=${1?"BUG: create_stash () -m requires an argument"}
-			;;
-		-m*)
-			stash_msg=${1#-m}
-			;;
-		--message=*)
-			stash_msg=${1#--message=}
-			;;
-		-u|--include-untracked)
-			shift
-			untracked=${1?"BUG: create_stash () -u requires an argument"}
-			;;
-		--)
-			shift
-			break
-			;;
-		esac
-		shift
-	done
-
-	git update-index -q --refresh
-	if no_changes "$@"
-	then
-		exit 0
-	fi
-
-	# state of the base commit
-	if b_commit=$(git rev-parse --verify HEAD)
-	then
-		head=$(git rev-list --oneline -n 1 HEAD --)
-	else
-		die "$(gettext "You do not have the initial commit yet")"
-	fi
-
-	if branch=$(git symbolic-ref -q HEAD)
-	then
-		branch=${branch#refs/heads/}
-	else
-		branch='(no branch)'
-	fi
-	msg=$(printf '%s: %s' "$branch" "$head")
-
-	# state of the index
-	i_tree=$(git write-tree) &&
-	i_commit=$(printf 'index on %s\n' "$msg" |
-		git commit-tree $i_tree -p $b_commit) ||
-		die "$(gettext "Cannot save the current index state")"
-
-	if test -n "$untracked"
-	then
-		# Untracked files are stored by themselves in a parentless commit, for
-		# ease of unpacking later.
-		u_commit=$(
-			untracked_files -z "$@" | (
-				GIT_INDEX_FILE="$TMPindex" &&
-				export GIT_INDEX_FILE &&
-				rm -f "$TMPindex" &&
-				git update-index -z --add --remove --stdin &&
-				u_tree=$(git write-tree) &&
-				printf 'untracked files on %s\n' "$msg" | git commit-tree $u_tree  &&
-				rm -f "$TMPindex"
-		) ) || die "$(gettext "Cannot save the untracked files")"
-
-		untracked_commit_option="-p $u_commit";
-	else
-		untracked_commit_option=
-	fi
-
-	if test -z "$patch_mode"
-	then
-
-		# state of the working tree
-		w_tree=$( (
-			git read-tree --index-output="$TMPindex" -m $i_tree &&
-			GIT_INDEX_FILE="$TMPindex" &&
-			export GIT_INDEX_FILE &&
-			git diff-index --name-only -z HEAD -- "$@" >"$TMP-stagenames" &&
-			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
-			git write-tree &&
-			rm -f "$TMPindex"
-		) ) ||
-			die "$(gettext "Cannot save the current worktree state")"
-
-	else
-
-		rm -f "$TMP-index" &&
-		GIT_INDEX_FILE="$TMP-index" git read-tree HEAD &&
-
-		# find out what the user wants
-		GIT_INDEX_FILE="$TMP-index" \
-			git add--interactive --patch=stash -- "$@" &&
-
-		# state of the working tree
-		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
-		die "$(gettext "Cannot save the current worktree state")"
-
-		git diff-tree -p HEAD $w_tree -- >"$TMP-patch" &&
-		test -s "$TMP-patch" ||
-		die "$(gettext "No changes selected")"
-
-		rm -f "$TMP-index" ||
-		die "$(gettext "Cannot remove temporary index (can't happen)")"
-
-	fi
-
-	# create the stash
-	if test -z "$stash_msg"
-	then
-		stash_msg=$(printf 'WIP on %s' "$msg")
-	else
-		stash_msg=$(printf 'On %s: %s' "$branch" "$stash_msg")
-	fi
-	w_commit=$(printf '%s\n' "$stash_msg" |
-	git commit-tree $w_tree -p $b_commit -p $i_commit $untracked_commit_option) ||
-	die "$(gettext "Cannot record working tree state")"
-}
-
-push_stash () {
-	keep_index=
-	patch_mode=
-	untracked=
-	stash_msg=
-	while test $# != 0
-	do
-		case "$1" in
-		-k|--keep-index)
-			keep_index=t
-			;;
-		--no-keep-index)
-			keep_index=n
-			;;
-		-p|--patch)
-			patch_mode=t
-			# only default to keep if we don't already have an override
-			test -z "$keep_index" && keep_index=t
-			;;
-		-q|--quiet)
-			GIT_QUIET=t
-			;;
-		-u|--include-untracked)
-			untracked=untracked
-			;;
-		-a|--all)
-			untracked=all
-			;;
-		-m|--message)
-			shift
-			test -z ${1+x} && usage
-			stash_msg=$1
-			;;
-		-m*)
-			stash_msg=${1#-m}
-			;;
-		--message=*)
-			stash_msg=${1#--message=}
-			;;
-		--help)
-			show_help
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			option="$1"
-			eval_gettextln "error: unknown option for 'stash push': \$option"
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	eval "set $(git rev-parse --sq --prefix "$prefix" -- "$@")"
-
-	if test -n "$patch_mode" && test -n "$untracked"
-	then
-		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
-	fi
-
-	test -n "$untracked" || git ls-files --error-unmatch -- "$@" >/dev/null || exit 1
-
-	git update-index -q --refresh
-	if no_changes "$@"
-	then
-		say "$(gettext "No local changes to save")"
-		exit 0
-	fi
-
-	git reflog exists $ref_stash ||
-		clear_stash || die "$(gettext "Cannot initialize stash")"
-
-	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
-	git stash--helper store -m "$stash_msg" -q $w_commit ||
-	die "$(gettext "Cannot save the current status")"
-	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
-
-	if test -z "$patch_mode"
-	then
-		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
-		if test -n "$untracked" && test $# = 0
-		then
-			git clean --force --quiet -d $CLEAN_X_OPTION
-		fi
-
-		if test $# != 0
-		then
-			test -z "$untracked" && UPDATE_OPTION="-u" || UPDATE_OPTION=
-			test "$untracked" = "all" && FORCE_OPTION="--force" || FORCE_OPTION=
-			git add $UPDATE_OPTION $FORCE_OPTION -- "$@"
-			git diff-index -p --cached --binary HEAD -- "$@" |
-			git apply --index -R
-		else
-			git reset --hard -q
-		fi
-
-		if test "$keep_index" = "t" && test -n "$i_tree"
-		then
-			git read-tree --reset $i_tree
-			git ls-files -z --modified -- "$@" |
-			git checkout-index -z --force --stdin
-		fi
-	else
-		git apply -R < "$TMP-patch" ||
-		die "$(gettext "Cannot remove worktree changes")"
-
-		if test "$keep_index" != "t"
-		then
-			git reset -q -- "$@"
-		fi
-	fi
-}
-
-save_stash () {
-	push_options=
-	while test $# != 0
-	do
-		case "$1" in
-		--)
-			shift
-			break
-			;;
-		-*)
-			# pass all options through to push_stash
-			push_options="$push_options $1"
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	stash_msg="$*"
-
-	if test -z "$stash_msg"
-	then
-		push_stash $push_options
-	else
-		push_stash $push_options -m "$stash_msg"
-	fi
-}
-
-show_help () {
-	exec git help stash
-	exit 1
-}
-
 #
 # Parses the remaining options looking for flags and
 # at most one revision defaulting to ${ref_stash}@{0}
@@ -425,7 +100,8 @@ show)
 	;;
 save)
 	shift
-	save_stash "$@"
+	cd "$START_DIR"
+	git stash--helper save "$@"
 	;;
 push)
 	shift
-- 
2.20.1.441.g764a526393

