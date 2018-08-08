Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB78C1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbeHHVUc (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:32 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38169 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbeHHVUb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:31 -0400
Received: by mail-wm0-f41.google.com with SMTP id t25-v6so3812771wmi.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ckFbpUwpTmufPE4gauAPRMqTFysc6KlSpcFBwRB53RY=;
        b=ZAHsLtzzFh9lmZh/8iTHSCDHm7PM6QLARS3VFC/jbvACD4tpgatR6buKm7SckQLsdQ
         UVJtbL8+UOWXAMDHYth1lNHFiS1AfeAJ7yu5KDVV/U8ritPhFuR8OEQ/B7N2U00IJmQZ
         NY9scnZ2A8aGxgQ/x09LSf/cZ4seTfgyBjldzpbEru2FYN3McUHN4gIm+iRGddqrRLN2
         pOtHryTmwRIdOxe3FEVhfuMmlPS0G+2alyRGen4mphNgSBsef0j550fCKYKrjwz0a3eS
         vvxNCEudZL7CMODUTroNJMl27ilcM6LoCcl3rQ5uKgFP7gDfuXrzIRBlVz7bhzV6HuNz
         WU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ckFbpUwpTmufPE4gauAPRMqTFysc6KlSpcFBwRB53RY=;
        b=LXj+fx6T/3VIemrSqF6viTraH2Xlqg8zc0wTkx1IZWzYaek42SS2nOgvSa9dily/eN
         45KGAnDg7dROTKZdmukVOt0Y5Vb5nI3Em8TddSEnT4al556uKjlwOJwfKvyVZTjnOtxX
         VZkli9ysB+ac3PXOaJ+Y6+61UVnILOJ6wIehZkPBlqLXvE/O/7qW4qge+mHlRMk95qgY
         N3qM4O89iFUeTPidABw60Gdma1q2i+UxdaQwWe9q7Lmx7OUXRehMAYbJQrkPOJMLSgze
         /Meybk+lLUn1WEimDCnRvAdGXLJf0b2Een3MXgCubw8Ki9cuUBvCpBjLn20YbxAlsV/E
         YgQQ==
X-Gm-Message-State: AOUpUlEk6Qqn+tJnh23DgDp8JvnN1KfibERmX6e/DN78SKfuFFoax0rV
        CCLD5M7RGB9BmssgS+F/jCW1C1gA
X-Google-Smtp-Source: AA+uWPw4gj4y94ahyYPt+DI/EoXZTtn0w0G5D/BYFBVQkfBTxf+EZ9Ibcx7I9infrizjG0PgXTSvAQ==
X-Received: by 2002:a1c:415:: with SMTP id 21-v6mr2836975wme.128.1533754769195;
        Wed, 08 Aug 2018 11:59:29 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.28
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:28 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 14/26] stash: convert store to builtin
Date:   Wed,  8 Aug 2018 21:58:53 +0300
Message-Id: <84b0086287c683d33bd456957700199b22fd1c49.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash store to the helper and delete the store_stash function
from the shell script.

Add the usage string which was forgotten in the shell script.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 52 +++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 43 ++--------------------------------
 2 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index ec8c38c6f..5ff810f8c 100644
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
@@ -731,6 +737,50 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int do_store_stash(const char *w_commit, const char *stash_msg,
+			  int quiet)
+{
+	int ret = 0;
+	struct object_id obj;
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
+	if (ret && !quiet)
+		fprintf_ln(stderr, _("Cannot update %s with %s"),
+			   ref_stash, w_commit);
+
+	return ret;
+}
+
+static int store_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *stash_msg = NULL;
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
+	return do_store_stash(argv[0], stash_msg, quiet);
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -765,6 +815,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.18.0.573.g56500d98f

