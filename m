Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BFBC1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeIZEoZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:25 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:32856 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeIZEoY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:24 -0400
Received: by mail-ed1-f54.google.com with SMTP id g26-v6so212126edp.0
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YBoIpgwoN2dPVw4HJvXqxMCcFb/aUgb5+zuGt4ieX94=;
        b=f8KugH00dIaaPrzqJfxrVovsH+8M8I3dRQYv8awgXHUnHefs+bMXl9us9me2ca9z9A
         wRQqhXbayTkxZADDdyii4WgzYlwrxSOjINQBQHv1etZiR19TGRAZg3RFp95hJfkf9bIO
         kM3H/+CrQDYW3laX93IXvHLzvm1CjW85Vt2jZgWgzxJGpoOcoNzTXT3kwnpirXV8VfMt
         ujFx+sBS1jlGtOqKMLHvbHKMlRU+ogkq8CTa6ckcB014IeyYtVWz/NDYIa6qjQYeHKn8
         35K//g5bzB1UpIHO06x0Spiv+GgLj3rBms2utd9FcHtHHVTHOPfyts74sAObNVRMJKMo
         cSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YBoIpgwoN2dPVw4HJvXqxMCcFb/aUgb5+zuGt4ieX94=;
        b=BfK210XZJfJeMUPkbp0FGQLxQuGaLTE0B9erhyGkmXUQZ/sHI0uwlFp/Y051QJzzHz
         L6WFi1cWKLAEzUEh6UuFnm+GpVVMfUadEVcyYT+44wJS0RAI+3tIss34KNXyAeZ3tAac
         EJEmZvErlC4flAgBqP4Tx3AGGRCWLCCC8XGH3vV+JluAqp0WE6mVVVEBKo6VG17f3Iwx
         PcOB0OU4pOELvXKpmzKaiss59NjC2quYQ0PGatqOVELG+XxRtHbI/w2U5mqeV6nqxoNu
         I071my9ibWb1E+agv0WR4MnsmiW/RSsBHd76mtAws5Kw1e+ZpvRNgeFcJAHfjScGl18d
         NNfg==
X-Gm-Message-State: ABuFfojCd4W0/dsn6FOUvi4nQ1jAK4NWpbaaz7hkifNGh/gAaBhB4lEo
        /2R3k0LaoRZkHiqPrFoLum1CJ2FL
X-Google-Smtp-Source: ACcGV63IZY7eszEudMbjEOkJtLkCyEr/HbVI1OifJYMLJSlmo+GJcEvIj50L4pY0+4QitjmB0QkRDQ==
X-Received: by 2002:a50:8646:: with SMTP id 6-v6mr4979748edt.259.1537914877381;
        Tue, 25 Sep 2018 15:34:37 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:36 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 14/21] stash: convert store to builtin
Date:   Wed, 26 Sep 2018 01:33:30 +0300
Message-Id: <7e4450668b56c402729a843b6348d2b1450d14c0.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
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
 builtin/stash--helper.c | 60 +++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 43 ++---------------------------
 2 files changed, 62 insertions(+), 41 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 1f02f5f2e9..b7421b68aa 100644
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
 
@@ -728,6 +733,59 @@ static int show_stash(int argc, const char **argv, const char *prefix)
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
+		OPT_STRING('m', "message", &stash_msg, "message", N_("stash message")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_store_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	if (argc != 1) {
+		if (!quiet)
+			fprintf_ln(stderr, _("\"git stash store\" requires one <commit> argument"));
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
@@ -762,6 +820,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.0.rc0.23.g1fb9f40d88

