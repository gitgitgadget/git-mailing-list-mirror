Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F2F31F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeJOFzw (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36265 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOFzv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id c26-v6so16082588edt.3
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EaZ625wiDbKmez3JEnf4aaEdygBChuejD7j68euSA1s=;
        b=bTAMSNLoGs3RwN6kTpuoAHhy3FiUo/hVU1+38LFV7hYB6RHz3f2rO6K7fGx4elg6dQ
         8NKFERuJdVIs/WJU8Q5NSyQkAnaQdwZPK1sBdnceeZ9KctZAVw+qDJfQGhez4FZh9oP5
         axiWWYjK9o2PTT6VDX84GyiE4KgcR50CYNmLiHFtdzsUmo6W8v22bwthIpXarctMlRRi
         TnH3lCdU9S/KIhoFXZJ3H2FKFWqJkDHifY241NXqSUFmJHE3V2lLEOstQ3jj0uf8HRky
         5CaipzHoDSxbRNIKJVU+3nzn14YCW1QBYB6HeFiPWN2JQClica3P51qbtVtTRgNimt6B
         Xeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EaZ625wiDbKmez3JEnf4aaEdygBChuejD7j68euSA1s=;
        b=qJoxJtwEAeA/VHAxiEcfSjuh1BmehxnwH76HjUqZbYG6J50POxp7dcWm4/0u80AEVq
         PosU0w0QF1GzdzAM4f/NykekbNJc2dEa9sBu6+NburagMbyv2bTXK8TNv+gQBMB7I4Cr
         Re33a8cn58hRcztjHkIr34xXptaUpTlvna582yriS7smCah5FRWd2Q5vSuy9vXl/9iRE
         NFocD875vBlMab54DfUG+0Rnflws7GaOI2D+9vtNfx5kLp+OTSdQNs8p7GuUGRKINvzx
         rgEvzCkzufH/nNNDQRMNKj+6LgQ3Gj6nCULpoGuHfiARaOg4o4T/jvq7hY6944yjp32f
         vs7A==
X-Gm-Message-State: ABuFfogr6lYomzRxWQdEKroAvLW6XQVkr8bB+5JcFBq6NtR/Q4rkd56O
        MDmf/obT246cJ0tRfqhiUD+OMkRc
X-Google-Smtp-Source: ACcGV62608iTVBSor84ZGR9I0q6uEtLrZjYdT0PUwXA0IFEznuRRjsPDc66kR4UqPIJq4D+G6FmdpA==
X-Received: by 2002:aa7:d804:: with SMTP id v4-v6mr21067269edq.255.1539555203334;
        Sun, 14 Oct 2018 15:13:23 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:22 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 14/21] stash: convert store to builtin
Date:   Mon, 15 Oct 2018 01:11:20 +0300
Message-Id: <e8b49b0dc66380b047f06e41748cccfa136f8a18.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
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
index 3f7ace92f5..758a32572d 100644
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
 
@@ -732,6 +737,61 @@ static int show_stash(int argc, const char **argv, const char *prefix)
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
@@ -766,6 +826,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.0.rc0.23.g10a62394e7

