Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECBCA1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933391AbeFYQqx (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:46:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35712 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932936AbeFYQqt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:46:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id z137-v6so5062699wmc.0
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GX8ZetvLkI4kMSVSRTZrFECrPVGz9vFzUCLqWI67jAA=;
        b=MwYioR0LEbJwkMeX197KgWhLJyYebHow1Sso0jYKa5viHB5oLoUkUu+Za0pXRwoafm
         0UgBms2An4Luhw86e1XGO7h9kHJpF2+6dOJo0lQEraHSHPB82Y6h2XCs6H1FxJSgvidy
         BTbuBDPipH6n1gfAKfz/G4YsxQzUHUY7LG5mwd2UDwRWksdU4/nVnAC0n94r4u3woz4o
         GPkRqu3xIOjPxyRLFXreRznFvBpJUvQyvvNIeHY2oQkAuKYrm1oif0tN2jFr65goZUqT
         FvPHbtp/8QXt/NVyKiq91xKisMP4VCi13S+jOS19wLV6vbet96csfT1UOrGPAAwPaeX/
         ujHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GX8ZetvLkI4kMSVSRTZrFECrPVGz9vFzUCLqWI67jAA=;
        b=mnvANnANkmEthKhQHs+AnY5KQNZyHTXuWPGzm23q3qMVg6C/gZfoYDWUasF0xdZowX
         5dyopNx3/phIxFrdAFDyKx9Heec3QV92pMI+YMt8ZfaCXjhmQXLpEYg9a7uoCub9nhk8
         VN4lyMzcAbg9J/M34LCQNqST6WuB6P4rLQvjOEPDHmuaLPnuC1gL2AcrMVkGquE6nKyM
         AOFELMMh1oVB4qeIeWD0fHAnT+bouGdyYs26+TnHokLJ7U763Z2uw19M5scuYrWTMTJ/
         nGnxYg84bN+/HmbPbYM71r6c9CJYZcKP3yjA/8pVhTHVISGWM1oUyuh0bOFPS10FGWpF
         hAiQ==
X-Gm-Message-State: APt69E2qSYsaCIyfLXRk6rELbIBdlr9u7r0uFICsZsZBzEtrUQJKoy6B
        Ok1Kp4cgfmCeABUBLK3qX4/OZqYq
X-Google-Smtp-Source: AAOMgpdNtT3wRaPiCWP417vJpaIByQV6W/W2X2qf+psrmdzYy4YFLXpufOb7XsGm0GUhTzDk3cv2kQ==
X-Received: by 2002:a1c:aac5:: with SMTP id t188-v6mr1523796wme.109.1529945208083;
        Mon, 25 Jun 2018 09:46:48 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-160-71.residential.rdsnet.ro. [5.13.160.71])
        by smtp.gmail.com with ESMTPSA id v10-v6sm26419997wrn.97.2018.06.25.09.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:46:47 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, joel@teichroeb.net, gitster@pobox.com
Subject: [PATCH v6 2/6] stash: convert show to builtin
Date:   Mon, 25 Jun 2018 19:46:35 +0300
Message-Id: <b5c8ad3ae96a1464cf024cabc219d0191709715a.1529943789.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.13.g506fc12fb
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
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
 builtin/stash--helper.c |  77 +++++++++++++++++++++++
 git-stash.sh            | 132 +---------------------------------------
 2 files changed, 78 insertions(+), 131 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 2ed21f5d1..a7eba3fba 100644
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
@@ -626,6 +632,75 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 	return ret;
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
+	struct argv_array args = ARGV_ARRAY_INIT;
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
+	argv_array_push(&args, "diff");
+
+	/* Push args which are not options into args_refs. */
+	for (i = 0; i < argc; ++i) {
+		if (argv[i][0] == '-')
+			argv_array_push(&args, argv[i]);
+		else
+			argv_array_push(&args_refs, argv[i]);
+	}
+
+	if (get_stash_info(&info, args_refs.argc, args_refs.argv)) {
+		argv_array_clear(&args);
+		argv_array_clear(&args_refs);
+		return -1;
+	}
+
+	/*
+	 * The config settings are applied only if there are not passed
+	 * any flags.
+	 */
+	if (args.argc == 1) {
+		git_config(git_stash_config, NULL);
+		if (show_stat)
+			argv_array_push(&args, "--stat");
+
+		if (show_patch)
+			argv_array_push(&args, "-p");
+	}
+
+	argv_array_pushl(&args, oid_to_hex(&info.b_commit),
+			 oid_to_hex(&info.w_commit), NULL);
+
+	ret = cmd_diff(args.argc, args.argv, prefix);
+
+	free_stash_info(&info);
+	argv_array_clear(&args);
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -658,6 +733,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.18.0.rc2.13.g506fc12fb

