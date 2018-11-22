Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF6A1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439042AbeKWJsI (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:48:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46383 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439039AbeKWJsI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:48:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so10627705wrt.13
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2T5Uayc6MnUVYzv8m/7ncE4zXMb4iU1dcWdyH0zOgI=;
        b=uVn7mYb4XBgKHcI14K1QxPc0M5WLO32w4hLc8ThVG90JACDoAGOhl3ezr+v5r/6kq0
         CHA3S5bNyYsJmEs4FNhqlLJISLyLPD3A8xNIgipmJEVEvx0UTma45gC/PPnEpkmqCO64
         2ETSk4nSEH7LhLO+QrdBTxwdUJGmUdnEDocYf20hGnScyR378BTJG1BtLLyL7aQNlACt
         97JF8GBXpvPF7VSeN8ttj1GrpjPNPpWiE4+z7bLMast9hlM7Tt1o6lmSadxXfr0arJ8/
         VoBe0l8dLLZHyVCVC6lkTAKSTxY0zry/MCy5XFmkO+nLiaMBKKrsrX/h7swkiw5pucQm
         nHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2T5Uayc6MnUVYzv8m/7ncE4zXMb4iU1dcWdyH0zOgI=;
        b=DX5JT3e8NQQXwaZQS4G3yrOMFVknTNxG3O2Sj5JOaCZXwmOHrbwi0fIaGCTeR7lMV0
         CTzDFht5P/zzsV+SR3JUg1T73V7u95o4RAb4pEl3Z3qM1Gxc2R+SyQnEfIf0R7U+v5ZS
         K/FEGLpH1zUSmtX0J6R/A6dfRZEMaPDEdtd0oiEREOyt/iLlnuFNVpGKFOw+p/riW/1I
         zM6VMqhRP4baAGA+5F12iUL1qkE2wq1aVjCHF5U1uUFXlhruHC7bH/Bfoft17wmYHHsR
         qfPD/TJOwQY9x91WsJs1RoikQhAko2dSf/oOWl7rvKDjg5n52j6Minw3Kal6EbU+pV8L
         DTlA==
X-Gm-Message-State: AA+aEWZqhonekQyhflr8r4d5KgHwQ5J/BkVfYshg78hPHiFPIZaCJe9/
        3jIbqPsXKPhqvdKDf6XF4y2hhO4L
X-Google-Smtp-Source: AFSGD/VkcySMBfeVnJ7+xXPeub0qxrPrHkKwGwa/5zWqYBxFF2Oq3XWGT2Xn+OHVnL7a61MsopkG5Q==
X-Received: by 2002:adf:8b8e:: with SMTP id o14-v6mr7795607wra.81.1542927986925;
        Thu, 22 Nov 2018 15:06:26 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:26 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 15/22] stash: convert store to builtin
Date:   Fri, 23 Nov 2018 01:05:35 +0200
Message-Id: <44347155280b80aa50599ba81fcadf9a25039fc5.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash store to the helper and delete the store_stash function
from the shell script.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 62 +++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 43 ++--------------------------
 2 files changed, 64 insertions(+), 41 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 36651f745a..5dc6c068d7 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -58,6 +58,11 @@ static const char * const git_stash_helper_clear_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_store_usage[] = {
+	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
@@ -730,6 +735,61 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	return diff_result_code(&rev.diffopt, 0);
 }
 
+static int do_store_stash(const struct object_id *w_commit, const char *stash_msg,
+			  int quiet)
+{
+	if (!stash_msg)
+		stash_msg = "Created via \"git stash store\".";
+
+	if (update_ref(stash_msg, ref_stash, w_commit, NULL,
+		       REF_FORCE_CREATE_REFLOG,
+		       quiet ? UPDATE_REFS_QUIET_ON_ERR :
+		       UPDATE_REFS_MSG_ON_ERR)) {
+		if (!quiet) {
+			fprintf_ln(stderr, _("Cannot update %s with %s"),
+				   ref_stash, oid_to_hex(w_commit));
+		}
+		return -1;
+	}
+
+	return 0;
+}
+
+static int store_stash(int argc, const char **argv, const char *prefix)
+{
+	int quiet = 0;
+	const char *stash_msg = NULL;
+	struct object_id obj;
+	struct object_context dummy;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet")),
+		OPT_STRING('m', "message", &stash_msg, "message",
+			   N_("stash message")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_store_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	if (argc != 1) {
+		if (!quiet)
+			fprintf_ln(stderr, _("\"git stash store\" requires one "
+					     "<commit> argument"));
+		return -1;
+	}
+
+	if (get_oid_with_context(argv[0], quiet ? GET_OID_QUIETLY : 0, &obj,
+				 &dummy)) {
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot update %s with %s"),
+					     ref_stash, argv[0]);
+		return -1;
+	}
+
+	return do_store_stash(&obj, stash_msg, quiet);
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -764,6 +824,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!list_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "show"))
 		return !!show_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "store"))
+		return !!store_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 0d05cbc1e5..5739c51527 100755
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
2.19.1.878.g0482332a22

