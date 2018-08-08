Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E781F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbeHHVUl (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33527 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbeHHVUk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so2946991wrp.0
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iT3PPweL8qcqZnR1Pow8a49vHwN1rU7Q3tJnV09XBJA=;
        b=FQNl0YIZskaujDtWjbUETb1gycIZHLFhYAg9991fYnpCWvgvQh4le53cANRfynPf1A
         OLGH3AbqkJ8YfI4sJ7u8e6XQUJvYclvkvo0MMSBMNzrxLgAH5ZBMu66Ut+qJGG5O61oJ
         HOtUBWMO0oroHH3LfXJQIUeYLVSS0hFSosLK//wOKViN9EZnxIf/1Lb0oeaOIoeKYjh6
         wMborvD0yNZIvOEB2qUjmjIwA8LCIM6kQtQD37FHnz7DBkyJ6xjV8aSnGTd3Dw33mGT3
         uvTTnCxjHji+Xskkvxa5sL37VoET+SNaD1I3qocaUjSCIjov/i8oqKpBNXLlTg46c9Z3
         cagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iT3PPweL8qcqZnR1Pow8a49vHwN1rU7Q3tJnV09XBJA=;
        b=pXNzL4x9hzK0+aiHo+zbSQUh7sXYYE60TFtEiCPTDTZ6+KGnO8cR2Wn+8AmimO97LN
         LmVjwhwmYzdMdXn3akTg36bcApqYeqJKqDVQy2Zf5Af4upwgGNai7+paFqHpE8PPwpsw
         2ch7K6a5o0uGtb/TGiYV1rfYrc5Pg9raaFYMwOrc0tfw1zCotONPmAoHdPUcpciAzn8W
         9rFj2AcUZwkXEvDOjLkvqW9fitVWTUo2mPCr/pA3ZESv+OH38RL/bVcGV/LsyBPAkpbn
         jj30BAymVOO+B7ssyeW2hgADTvA7JD5H+LuwDQsq0nvaSQ3h0U7l1nb168Qg83eLaSW3
         5x2g==
X-Gm-Message-State: AOUpUlHDNKU1Qf/SKU+F9aR5VohD9D9fgeCTMvqBSI9SFr0j4AAM9hai
        9hh78w/xROit4X7bo7O8HARD808n
X-Google-Smtp-Source: AA+uWPxniUT3th5xPdZJ0TW5INus2Qf02nL9pFO0TdIrXf3OndDB5bskTdPDO8RcmTm5E+hZY/xMmQ==
X-Received: by 2002:adf:96b2:: with SMTP id u47-v6mr2746108wrb.204.1533754777277;
        Wed, 08 Aug 2018 11:59:37 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:36 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 22/26] stash: convert save to builtin
Date:   Wed,  8 Aug 2018 21:59:01 +0300
Message-Id: <d39aca1880ccf94f9f207cd09b4a5cc2c3c233e7.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
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
---
 builtin/stash--helper.c |  48 +++++++
 git-stash.sh            | 311 +---------------------------------------
 2 files changed, 50 insertions(+), 309 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 5c27f5dcf..f54a476e3 100644
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
 static int quiet;
 static struct strbuf stash_index_path = STRBUF_INIT;
@@ -1445,6 +1453,44 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 			     include_untracked, quiet, stash_msg);
 }
 
+static int save_stash(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	int keep_index = -1;
+	int patch_mode = 0;
+	int include_untracked = 0;
+	int quiet = 0;
+	char *stash_msg = NULL;
+	struct strbuf alt_stash_msg = STRBUF_INIT;
+	struct option options[] = {
+		OPT_SET_INT('k', "keep-index", &keep_index,
+			N_("keep index"), 1),
+		OPT_BOOL('p', "patch", &patch_mode,
+			N_("stash in patch mode")),
+		OPT_BOOL('q', "quiet", &quiet,
+			N_("quiet mode")),
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			 N_("include untracked files in stash")),
+		OPT_SET_INT('a', "all", &include_untracked,
+			    N_("include ignore files"), 2),
+		OPT_STRING('m', "message", &stash_msg, N_("message"),
+			 N_("stash message")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_save_usage,
+			     0);
+
+	for (i = 0; i < argc; ++i)
+		strbuf_addf(&alt_stash_msg, "%s ", argv[i]);
+
+	stash_msg = strbuf_detach(&alt_stash_msg, NULL);
+
+	return do_push_stash(0, NULL, prefix, keep_index, patch_mode,
+			     include_untracked, quiet, stash_msg);
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -1485,6 +1531,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!create_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "push"))
 		return !!push_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "save"))
+		return !!save_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index c3146f62a..695f1feba 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -36,314 +36,6 @@ else
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
@@ -408,7 +100,8 @@ show)
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
2.18.0.573.g56500d98f

