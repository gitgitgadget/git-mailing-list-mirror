Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0EF620248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfBYXRe (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37276 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfBYXRd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id w6so8567847wrs.4
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ha7Uj78+YD9//KMLVopu4hQYIuoKXC8X6CxNmCQ7NyA=;
        b=udCdJGkDqzwmDLg9r6ezJMVQ+eoNL66By/bgVSQ78SZy/w16TGne9RfPzTD3hrvTUH
         wDa1W9voGR71jn1if9HmMHE6ct8x3MwFW6sufieK3d9flW22qnA9UglDauzYq10Tt7Cq
         boKX1DI33Pr3WJc9V3IREVOeNqzkWPLywQMuWlNpiZyCGQ8M3RkbbZkz+p2odVayjZkO
         liy4EvROLM0RLQmaAuiLYvZ1puC0JMT4I3UppKq1upGozswLZU7wcWb1TiklRMXkhTQF
         izXD9g2E8VhZvK/oJQQw+lUZ6PCKqb16GRpB/ne3cGvWin2Bckv9vzQL7X0r7WUybRyx
         OfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ha7Uj78+YD9//KMLVopu4hQYIuoKXC8X6CxNmCQ7NyA=;
        b=rJCp6jlbWfZtGqpjcVduxx2dwIv6nGnCnLF3WiQg4A/Wrp8KiKEuiGj3w+2TC3tP8u
         I3vEp2KgsZ8pFR3nYCnSN+rllMpPPssXP2XnC/qqKuy50xzXKZVR2/6C7JJ//ZT0li79
         RH2+GovrK3FPClZHACMsTXjkAQg+/1S3+mw6aBsqXfEWooD4kNfPrTZmeuYkFncfFPME
         QgHCHNZIaAp8yCwHqaOBaj1dKF53PT+iYP4N74O4sbTwNylHEYScM+wFtNnG+R121xvL
         JDoNuREXCjjzGmM1ougJSpcF3dei1GqgOozauUjBvLliDQSYVwHJIKZlSrKz7POqa6bq
         ctfg==
X-Gm-Message-State: AHQUAuYdITM22v95Gqh2PNwp7jGAewBCFKOHWSyLAt0onxAWH/4337oi
        jwNHUcbZDfRHLKarIRL2aTN9oC/8
X-Google-Smtp-Source: AHgI3IZRFL599esNbFDFxZ56rklHMkQzar5inGcOVovMvYAeJTiGYjAryZ80t7sR2rQgXg9ep7hicA==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr13970308wrs.170.1551136651219;
        Mon, 25 Feb 2019 15:17:31 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id f68sm18544119wmg.5.2019.02.25.15.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:30 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 26/27] stash: optionally use the scripted version again
Date:   Mon, 25 Feb 2019 23:16:30 +0000
Message-Id: <20190225231631.30507-27-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We recently converted the `git stash` command from Unix shell scripts
to builtins.

Let's end users a way out when they discover a bug in the
builtin command: `stash.useBuiltin`.

As the file name `git-stash` is already in use, let's rename the
scripted backend to `git-legacy-stash`.

To make the test suite pass with `stash.useBuiltin=false`, this commit
also backports rudimentary support for `-q` (but only *just* enough
to appease the test suite), and adds a super-ugly hack to force exit
code 129 for `git stash -h`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 .gitignore                          |  1 +
 Makefile                            |  1 +
 builtin/stash.c                     | 35 +++++++++++++++++++++++++++++
 git-stash.sh => git-legacy-stash.sh | 34 +++++++++++++++++++++++++---
 git-sh-setup.sh                     |  1 +
 git.c                               |  7 +++++-
 6 files changed, 75 insertions(+), 4 deletions(-)
 rename git-stash.sh => git-legacy-stash.sh (97%)

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..7b0164675e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -82,6 +82,7 @@
 /git-interpret-trailers
 /git-instaweb
 /git-legacy-rebase
+/git-legacy-stash
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Makefile b/Makefile
index 8cee2731aa..810231a0b5 100644
--- a/Makefile
+++ b/Makefile
@@ -617,6 +617,7 @@ SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-legacy-rebase.sh
+SCRIPT_SH += git-legacy-stash.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-submodule.sh
diff --git a/builtin/stash.c b/builtin/stash.c
index d9f3956ef5..49c6d7948a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -13,6 +13,7 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "diffcore.h"
+#include "exec-cmd.h"
 
 #define INCLUDE_ALL_FILES 2
 
@@ -1510,6 +1511,26 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int use_builtin_stash(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+	int ret;
+
+	argv_array_pushl(&cp.args,
+			 "config", "--bool", "stash.usebuiltin", NULL);
+	cp.git_cmd = 1;
+	if (capture_command(&cp, &out, 6)) {
+		strbuf_release(&out);
+		return 1;
+	}
+
+	strbuf_trim(&out);
+	ret = !strcmp("true", out.buf);
+	strbuf_release(&out);
+	return ret;
+}
+
 int cmd_stash(int argc, const char **argv, const char *prefix)
 {
 	int i = -1;
@@ -1521,6 +1542,20 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	if (!use_builtin_stash()) {
+		const char *path = mkpath("%s/git-legacy-stash",
+					  git_exec_path());
+
+		if (sane_execvp(path, (char **)argv) < 0)
+			die_errno(_("could not exec %s"), path);
+		else
+			BUG("sane_execvp() returned???");
+	}
+
+	prefix = setup_git_directory();
+	trace_repo_setup(prefix);
+	setup_work_tree();
+
 	git_config(git_diff_basic_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
diff --git a/git-stash.sh b/git-legacy-stash.sh
similarity index 97%
rename from git-stash.sh
rename to git-legacy-stash.sh
index 789ce2f41d..8a8c4a9270 100755
--- a/git-stash.sh
+++ b/git-legacy-stash.sh
@@ -80,6 +80,28 @@ clear_stash () {
 	fi
 }
 
+maybe_quiet () {
+	case "$1" in
+	--keep-stdout)
+		shift
+		if test -n "$GIT_QUIET"
+		then
+			eval "$@" 2>/dev/null
+		else
+			eval "$@"
+		fi
+		;;
+	*)
+		if test -n "$GIT_QUIET"
+		then
+			eval "$@" >/dev/null 2>&1
+		else
+			eval "$@"
+		fi
+		;;
+	esac
+}
+
 create_stash () {
 
 	prepare_fallback_ident
@@ -112,15 +134,18 @@ create_stash () {
 	done
 
 	git update-index -q --refresh
-	if no_changes "$@"
+	if maybe_quiet no_changes "$@"
 	then
 		exit 0
 	fi
 
 	# state of the base commit
-	if b_commit=$(git rev-parse --verify HEAD)
+	if b_commit=$(maybe_quiet --keep-stdout git rev-parse --verify HEAD)
 	then
 		head=$(git rev-list --oneline -n 1 HEAD --)
+	elif test -n "$GIT_QUIET"
+	then
+		exit 1
 	else
 		die "$(gettext "You do not have the initial commit yet")"
 	fi
@@ -315,7 +340,7 @@ push_stash () {
 	test -n "$untracked" || git ls-files --error-unmatch -- "$@" >/dev/null || exit 1
 
 	git update-index -q --refresh
-	if no_changes "$@"
+	if maybe_quiet no_changes "$@"
 	then
 		say "$(gettext "No local changes to save")"
 		exit 0
@@ -370,6 +395,9 @@ save_stash () {
 	while test $# != 0
 	do
 		case "$1" in
+		-q|--quiet)
+			GIT_QUIET=t
+			;;
 		--)
 			shift
 			break
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 378928518b..10d9764185 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -101,6 +101,7 @@ $LONG_USAGE")"
 	case "$1" in
 		-h)
 		echo "$LONG_USAGE"
+		case "$0" in *git-legacy-stash) exit 129;; esac
 		exit
 	esac
 fi
diff --git a/git.c b/git.c
index 49ab91b4ec..8de729c9e6 100644
--- a/git.c
+++ b/git.c
@@ -554,7 +554,12 @@ static struct cmd_struct commands[] = {
 	{ "show-index", cmd_show_index },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
+	/*
+	 * NEEDSWORK: Until the builtin stash is thoroughly robust and no
+	 * longer needs redirection to the stash shell script this is kept as
+	 * is, then should be changed to RUN_SETUP | NEED_WORK_TREE
+	 */
+	{ "stash", cmd_stash },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
-- 
2.21.0.rc2.291.g17236886c5

