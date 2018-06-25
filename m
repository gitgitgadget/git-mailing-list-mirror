Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19CFC1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeFYQq5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:46:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33256 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754496AbeFYQqy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:46:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so13031139wma.0
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x7ps7fLqcJfwLRpZOk6lUNYj9l1eWOLhyqbu1sAPoeM=;
        b=hEreZU5Eko6Gtw179Bs+qmw+PdPKGE8tYOgjfgDKJF2ROU0pkenqflCjk0gPNzoufa
         qrr6kFvEAsRFqPKMuyqh8ZY+OYQ9Saw4fPXWecuQvMpBwas5uPCXgH5lBUC7hcf7VTwM
         Cl4nuqsMQEiJFY00k2E33QGtbP5i46AgcVkM6wNnVhWArkTlE1YBezSSQ+6tA3ZRbw5F
         m5Jj84rFxzrCs8Flof7Xf7H4bBtuDSSRH8l+Ehann67yvGzT1EdSnBuwenNL2JrisrvW
         6UVRRnvk63q7fzFdJu2fXjB8sVjZrNQuaL+tufUJAjxjWoso5qThpq96VF16u8zjAYi3
         redw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x7ps7fLqcJfwLRpZOk6lUNYj9l1eWOLhyqbu1sAPoeM=;
        b=gdda1Pkj+CW+dhGhJtYTYiU4+tuCqYd1pA9Sq9VrFMyUJtshpW6NVc0GAwkTGoy2E/
         Pj3FW1qgVYd3PHo5MIg0h8G/V9JKoEywoWydhGzQQxHYZZDYPzOdVDC4hfX63zTJV6e3
         OIDiicI7lsXgB0ckgqmy0kJD6rxaSQIEVcqy6HRPmnJfE+UqRB2dwZWgBrvIbmMnk+/V
         5ZYnuPNaKjb9XpAG29xGIG/89+asHgMZprzOfVeHUIAe7XbnrGVEKN0KE+puV2g3c5Te
         GVYztSbmrzpkdOJfFMR+GtoB9sAH+aAodqhx7XfUrItka1w4tfE2ezf6DvvmFCEFE2Hb
         m8/w==
X-Gm-Message-State: APt69E2eBWo6A03XCD9IrsOuA6wtEH9NGEWhrDPt2DBJAtK5s3FkFy+2
        hN7fBYxxH9O9i+fxKuG2HoSfulSA
X-Google-Smtp-Source: AAOMgpded69Vd6LQ4A5yLhmmE1iDYQXMVmMC2c0zibxM4nhoW5ZUgmCvs75UfrXjEx3iKyqepzY0zQ==
X-Received: by 2002:a1c:9253:: with SMTP id u80-v6mr1709570wmd.52.1529945213375;
        Mon, 25 Jun 2018 09:46:53 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-160-71.residential.rdsnet.ro. [5.13.160.71])
        by smtp.gmail.com with ESMTPSA id v10-v6sm26419997wrn.97.2018.06.25.09.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:46:52 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, joel@teichroeb.net, gitster@pobox.com
Subject: [PATCH v6 6/6] stash: convert store to builtin
Date:   Mon, 25 Jun 2018 19:46:39 +0300
Message-Id: <a75e7208e62b9008524dbb993d692fb8d9604cbe.1529943789.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.13.g506fc12fb
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash store to the helper and delete the store_stash function
from the shell script.

Add the usage string which was forgotten in the shell script.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 48 +++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 43 ++----------------------------------
 2 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 4589e12d6..556d91b20 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -20,6 +20,7 @@ static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
+	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
 	NULL
 };
 
@@ -58,6 +59,11 @@ static const char * const git_stash_helper_clear_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_store_usage[] = {
+	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static int quiet;
 static struct strbuf stash_index_path = STRBUF_INIT;
@@ -719,6 +725,46 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int store_stash(int argc, const char **argv, const char *prefix)
+{
+	struct object_id obj;
+	int ret = 0;
+	const char *stash_msg = NULL;
+	const char *w_commit = NULL;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_STRING('m', "message", &stash_msg, "message", N_("stash message")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_store_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	if (argc != 1) {
+		fprintf(stderr, _("\"git stash--helper store\" requires one <commit> argument\n"));
+		return -1;
+	}
+
+	w_commit = argv[0];
+
+	if (!stash_msg)
+		stash_msg  = xstrdup("Created via \"git stash--helper store\".");
+
+	ret = get_oid(w_commit, &obj);
+	if (!ret) {
+		ret = update_ref(stash_msg, ref_stash, &obj, NULL,
+				 REF_FORCE_CREATE_REFLOG,
+				 quiet ? UPDATE_REFS_QUIET_ON_ERR :
+				 UPDATE_REFS_MSG_ON_ERR);
+	}
+
+	if (ret && !quiet)
+		fprintf_ln(stderr, _("Cannot update %s with %s"), ref_stash, w_commit);
+
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -753,6 +799,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!list_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "show"))
 		return !!show_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "store"))
+		return !!store_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 0d05cbc1e..5739c5152 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -191,45 +191,6 @@ create_stash () {
 	die "$(gettext "Cannot record working tree state")"
 }
 
-store_stash () {
-	while test $# != 0
-	do
-		case "$1" in
-		-m|--message)
-			shift
-			stash_msg="$1"
-			;;
-		-m*)
-			stash_msg=${1#-m}
-			;;
-		--message=*)
-			stash_msg=${1#--message=}
-			;;
-		-q|--quiet)
-			quiet=t
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-	test $# = 1 ||
-	die "$(eval_gettext "\"$dashless store\" requires one <commit> argument")"
-
-	w_commit="$1"
-	if test -z "$stash_msg"
-	then
-		stash_msg="Created via \"git stash store\"."
-	fi
-
-	git update-ref --create-reflog -m "$stash_msg" $ref_stash $w_commit
-	ret=$?
-	test $ret != 0 && test -z "$quiet" &&
-	die "$(eval_gettext "Cannot update \$ref_stash with \$w_commit")"
-	return $ret
-}
-
 push_stash () {
 	keep_index=
 	patch_mode=
@@ -308,7 +269,7 @@ push_stash () {
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
 	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
-	store_stash -m "$stash_msg" -q $w_commit ||
+	git stash--helper store -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
 
@@ -468,7 +429,7 @@ create)
 	;;
 store)
 	shift
-	store_stash "$@"
+	git stash--helper store "$@"
 	;;
 drop)
 	shift
-- 
2.18.0.rc2.13.g506fc12fb

