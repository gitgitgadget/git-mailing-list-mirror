Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F4A91F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbeHHVU1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35071 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbeHHVU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id g1-v6so2942757wru.2
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xtIiLRZyXbGgKfFhYw0cxn27I//18U7Y65xmJ0JQCHc=;
        b=dQn7y8mGD2m4OXNzS8CsfWurVPwNsZFaLxKXeMo1p4iO9s0nvroK+Zmd41PQfbfR6Z
         JiNfyNQd1PwAynP0LcxZs2GXalxOLltEgHRvNXEIh8py1jdgDV7n5Sbz/L4TCgMkVfpD
         FycXVh9FTBfjPiasMVlG/vS1yDPB5mtL3H2yu4ijpTRlywhDpw647wRQ5WivMsEInCkj
         LHYKJNlfVh6+iF/TLPatwmWWbcGBKlQTO1p5/RMKttZUmRVKZ875yO+NU0TorxO/u7RS
         cS5k8t5IYi9/9QjbJqbrjEAIhEVhQ2P6PGWLqUo4cw2cKIOdDDpE4NIZd9I8Skd4yvaQ
         yuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtIiLRZyXbGgKfFhYw0cxn27I//18U7Y65xmJ0JQCHc=;
        b=U7xPanPFlcNjNTJ59TIXirXL9jjZhdYf5m7vOI2wgnrQGQJCjr6Aer76gzTpzDxK7j
         YChNWK4+vjgDnPMJx8KYQ5ehLzpqCku3PnOLVGlpT0qDONFAwnDcsps6xbEJnr2Tysd3
         4chgD7xS7jASa5N71NWgAQ/iZSCMtibGmKfWlansMIeYJuEvav+305Sl3rIejTya+yIL
         Gt6TPRIL814ZgO3TxjtX2TOw+vtvJAOTXBPKQVYnzVBkUec/OtT4JhkAZcD2zCmZSfND
         zDLYBr4dZhxGMnEbXuby7bEaFx6hSGGCLW4Bo5SK2Km2lQrtnVZ9u/YomDogygPxz9iz
         A98Q==
X-Gm-Message-State: AOUpUlEV5JxXSvOWHuxzo8ZVWIKmRx0lVxittXr3Z2OdJ2roxPyQPn1E
        R+0BH9bjkXfVOD73KKprc2US4ejZ
X-Google-Smtp-Source: AA+uWPynHppNN61iMfGx5AY+jvxgE9gfrYEOFWOHSCIosDBoD4QsfxyAslpRZPdOvc+Up0m5HR2utw==
X-Received: by 2002:a5d:480d:: with SMTP id l13-v6mr2919048wrq.234.1533754765431;
        Wed, 08 Aug 2018 11:59:25 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:24 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 10/26] stash: convert show to builtin
Date:   Wed,  8 Aug 2018 21:58:49 +0300
Message-Id: <05246e813c810156c07385052ec59d6dec34623e.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash show to the helper and delete the show_stash, have_stash,
assert_stash_like, is_stash_like and parse_flags_and_rev functions
from the shell script now that they are no longer needed.

Before this commit, `git stash show` would ignore `--index` and
`--quiet` options. Now, `git stash show` errors out on `--index`
and does not display any message on `--quiet`, but errors out
if the stash is not empty.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c |  78 ++++++++++++++++++++++++
 git-stash.sh            | 132 +---------------------------------------
 2 files changed, 79 insertions(+), 131 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index daa4d0034..e764cd33e 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -13,6 +13,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper list [<options>]"),
+	N_("git stash--helper show [<stash>]"),
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
@@ -25,6 +26,11 @@ static const char * const git_stash_helper_list_usage[] = {
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
@@ -638,6 +644,76 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 	return run_command(&cp);
 }
 
+static int show_stat = 1;
+static int show_patch;
+
+static int git_stash_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "stash.showStat")) {
+		show_stat = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "stash.showPatch")) {
+		show_patch = git_config_bool(var, value);
+		return 0;
+	}
+	return git_default_config(var, value, cb);
+}
+
+static int show_stash(int argc, const char **argv, const char *prefix)
+{
+	int i, ret = 0;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct argv_array args_refs = ARGV_ARRAY_INIT;
+	struct stash_info info;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_show_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	cp.git_cmd = 1;
+	argv_array_push(&cp.args, "diff");
+
+	/* Push arguments which are not options into args_refs. */
+	for (i = 0; i < argc; ++i) {
+		if (argv[i][0] == '-')
+			argv_array_push(&cp.args, argv[i]);
+		else
+			argv_array_push(&args_refs, argv[i]);
+	}
+
+	if (get_stash_info(&info, args_refs.argc, args_refs.argv)) {
+		child_process_clear(&cp);
+		argv_array_clear(&args_refs);
+		return -1;
+	}
+
+	/*
+	 * The config settings are applied only if there are not passed
+	 * any flags.
+	 */
+	if (cp.args.argc == 1) {
+		git_config(git_stash_config, NULL);
+		if (show_stat)
+			argv_array_push(&cp.args, "--stat");
+
+		if (show_patch)
+			argv_array_push(&cp.args, "-p");
+	}
+
+	argv_array_pushl(&cp.args, oid_to_hex(&info.b_commit),
+			 oid_to_hex(&info.w_commit), NULL);
+
+	ret = run_command(&cp);
+
+	free_stash_info(&info);
+	argv_array_clear(&args_refs);
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -670,6 +746,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!branch_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "list"))
 		return !!list_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "show"))
+		return !!show_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 6052441aa..0d05cbc1e 100755
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
2.18.0.573.g56500d98f

