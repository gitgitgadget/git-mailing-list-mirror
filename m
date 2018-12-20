Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DD51F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389460AbeLTTpH (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53453 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389401AbeLTTpG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so3236887wmb.3
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHJbCaWpESaDvn0w0KAdTlXNUSuNsDwO4zlh31wAvHc=;
        b=PzwbzHtJxu51ciM13HGPoALMrh8w9jLmpCbbACMCs78R1GdqO0iaPk3/fQFQVl4q3s
         EUC8wVCnof+gl0EKpNKrY1w48W/yEa7NuM0t5ZkoYz6wYo1xTlgSLoZi0N9eqkUFuk8W
         P9ET67H9eqKWjEz0AGzHEhz3f3Vr0ePXda3i7BCjT1BWaSl83az4d3xcxcP8hpV/exrv
         G8WtYuOMTkeTWmfqg+cpKZbeVzaJ8KJPuR/sBuxem1roRNTeW7f2MgUVPMQ6Zp1QFRBa
         NH+jssu4kLBwTHkTCv5zcZoHbsrqZFSTm4nMSieBb5QaT7vB4uV1pjhWGnZy1Qsdg30o
         rxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHJbCaWpESaDvn0w0KAdTlXNUSuNsDwO4zlh31wAvHc=;
        b=j+I/Jx4DyqwfEGODnUxULpVNZKl7OmkkfLEQkT4Sb1gySCOC/yVrzsqhqFe6N2PumK
         FeUHPGAby+ZuXF3u6GVboQ/EFaCLkZzTZDQxPHCTxdZA+22rjU0eXcVZMDTNgdScqWi7
         0H049zVrDnF4LikWELtnG8Y4iCWFgEhgpa2tuToZSkZQXSrr6XHV579XU1wF5CYHa6C9
         /U2IKZteTYc+MarZ35r8WAtWA1q/Na0BIFm0FmOe+oXFfkCcxBun5Kb8noL/z9V4Qlp+
         U6imbiLTft4Py+7c9I+K5Xvqzvddu/+eH1jTj13fyUvDP8Hrw0wbPHseREVKjskfC2hI
         qmkA==
X-Gm-Message-State: AJcUukcF2hXTyFcgE2uq+hhW9O9O1Xmdb3MDH7lFiIPtDPF8hgFy6aJo
        B01hD/PXQc/8l+Aj51fxDFN7PgBwnT4=
X-Google-Smtp-Source: ALg8bN6FGYZmJRCk3U1t0BS5brOZrbsfm0jGKeEG23sRXwwJQ12haHN+t2H7IOF7xwPueKuhzKTYoA==
X-Received: by 2002:a1c:8d49:: with SMTP id p70mr18872wmd.68.1545335103603;
        Thu, 20 Dec 2018 11:45:03 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:45:03 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 16/26] stash: convert store to builtin
Date:   Thu, 20 Dec 2018 21:44:32 +0200
Message-Id: <db883e70689a63918cf28710277b560d07091c67.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
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
index d0318f859e..ff5556ccb0 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -208,45 +208,6 @@ create_stash () {
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
@@ -325,7 +286,7 @@ push_stash () {
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
 	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
-	store_stash -m "$stash_msg" -q $w_commit ||
+	git stash--helper store -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
 
@@ -485,7 +446,7 @@ create)
 	;;
 store)
 	shift
-	store_stash "$@"
+	git stash--helper store "$@"
 	;;
 drop)
 	shift
-- 
2.20.1.441.g764a526393

