Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A4F1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeHaBp7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:45:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42095 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeHaBp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:45:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id v17-v6so9367706wrr.9
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Tg1V0CBu/GdV139oBbxAcUOzrNLOP8oYPBJqg4UbMq4=;
        b=A9drC7kGR0uSbdeGX89caieHOhSo1Kk+P1GFHBqqb060NVnc0ak5WftBWm9Tp7tjT/
         U41mmn7jjeOBeCTmoYHZhY34nF/UK6ud/DYUIztoRc4fGa5uWNiip6okufvklshOzxTO
         w04flwpOUC5ZB/EBj/X2QCN2sGyZ8iI3q+Bd33Rtlurg8QxTMs320Mi3fgg6LBkV/TtB
         dTukarJu15xOWTHfDa+fqmDANX+5CEexv2cKUH5gDumrgx1k2O71wbvOeBzo0p1yxrZ6
         eO8bjCixgUZ8wzj50GZCxkbmpGd35kSRE3ZuFbQi8FbZbkZC/jvNyMWaOggaoNx4gtIP
         OrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tg1V0CBu/GdV139oBbxAcUOzrNLOP8oYPBJqg4UbMq4=;
        b=LmRjUedPlqaavcxgImWUS8eBPqQRCHD6o6IcoZ1B3LFXQzpCH3b6r4c9GJOUNx10tB
         v+lCG6DtacD7AqlKSNbAKFY/ZpB52V0q/axr9NJ4llPdTOAMvemu73DUSASW3Ds53Adv
         FkvnaY3veNc8pJar1mJUjLpN58NIrpSqkBbMTpTfJZuh1cRub+iw9uciSsjsOIMCmX66
         OVWnfivPitIMx9R4kQPJDc3DKmSY9INqq8nYOdMPZCwBOZ65Iz37sZtdbd8u6rDGnE25
         7MfOkGhOZ3Yeu96jb1ICho2+XW66vJ4VB5vVK4yXKKz8VKKPJ/PMx9FG1uNliot9hno0
         pqlg==
X-Gm-Message-State: APzg51CU4NAXAaJyrbR0thMFdwi5cOCxokvaF7UG7ppNaQL7ZMsTa+ye
        uR2HV7o8EhCqAHDYWtAo6K8GtNc8
X-Google-Smtp-Source: ANB0VdZNhU+mV8tZbsmnIxMpN0eAIy+zlbuD1bGQHmZgXKCQxHq/xlWr77eYJ6vhpBp6C/TI8z2yGw==
X-Received: by 2002:adf:8b98:: with SMTP id o24-v6mr8627935wra.110.1535665304558;
        Thu, 30 Aug 2018 14:41:44 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:43 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 07/20] stash: convert drop and clear to builtin
Date:   Fri, 31 Aug 2018 00:40:37 +0300
Message-Id: <8f8f25df2f68519533257b82af6a4b88e1e756cc.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

Add the drop and clear commands to the builtin helper. These two
are each simple, but are being added together as they are quite
related.

We have to unfortunately keep the drop and clear functions in the
shell script as functions are called with parameters internally
that are not valid when the commands are called externally. Once
pop is converted they can both be removed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 115 ++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |   4 +-
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index fde795a764..cbe23fef11 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,7 +12,14 @@
 #include "rerere.h"
 
 static const char * const git_stash_helper_usage[] = {
+	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper clear"),
+	NULL
+};
+
+static const char * const git_stash_helper_drop_usage[] = {
+	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	NULL
 };
 
@@ -21,6 +28,11 @@ static const char * const git_stash_helper_apply_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_clear_usage[] = {
+	N_("git stash--helper clear"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static int quiet;
 static struct strbuf stash_index_path = STRBUF_INIT;
@@ -140,6 +152,31 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	return !(ret == 0 || ret == 1);
 }
 
+static int do_clear_stash(void)
+{
+	struct object_id obj;
+	if (get_oid(ref_stash, &obj))
+		return 0;
+
+	return delete_ref(NULL, ref_stash, &obj, 0);
+}
+
+static int clear_stash(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_clear_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc)
+		return error(_("git stash clear with parameters is unimplemented"));
+
+	return do_clear_stash();
+}
+
 static int reset_tree(struct object_id *i_tree, int update, int reset)
 {
 	struct unpack_trees_options opts;
@@ -424,6 +461,80 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int do_drop_stash(const char *prefix, struct stash_info *info)
+{
+	struct child_process cp_reflog = CHILD_PROCESS_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int ret;
+
+	/*
+	 * reflog does not provide a simple function for deleting refs. One will
+	 * need to be added to avoid implementing too much reflog code here
+	 */
+
+	cp_reflog.git_cmd = 1;
+	argv_array_pushl(&cp_reflog.args, "reflog", "delete", "--updateref",
+			 "--rewrite", NULL);
+	argv_array_push(&cp_reflog.args, info->revision.buf);
+	ret = run_command(&cp_reflog);
+	if (!ret) {
+		if (!quiet)
+			printf_ln(_("Dropped %s (%s)"), info->revision.buf,
+				  oid_to_hex(&info->w_commit));
+	} else {
+		return error(_("%s: Could not drop stash entry"),
+			     info->revision.buf);
+	}
+
+	/*
+	 * This could easily be replaced by get_oid, but currently it will throw
+	 * a fatal error when a reflog is empty, which we can not recover from.
+	 */
+	cp.git_cmd = 1;
+	/* Even though --quiet is specified, rev-parse still outputs the hash */
+	cp.no_stdout = 1;
+	argv_array_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
+	argv_array_pushf(&cp.args, "%s@{0}", ref_stash);
+	ret = run_command(&cp);
+
+	/* do_clear_stash if we just dropped the last stash entry */
+	if (ret)
+		do_clear_stash();
+
+	return 0;
+}
+
+static void assert_stash_ref(struct stash_info *info)
+{
+	if (!info->is_stash_ref) {
+		free_stash_info(info);
+		error(_("'%s' is not a stash reference"), info->revision.buf);
+		exit(128);
+	}
+}
+
+static int drop_stash(int argc, const char **argv, const char *prefix)
+{
+	struct stash_info info;
+	int ret;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_drop_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	assert_stash_ref(&info);
+
+	ret = do_drop_stash(prefix, &info);
+	free_stash_info(&info);
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -446,6 +557,10 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_stash_helper_usage, options);
 	if (!strcmp(argv[0], "apply"))
 		return !!apply_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "clear"))
+		return !!clear_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "drop"))
+		return !!drop_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 809b1c2d1d..a99d5dc9e5 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -653,7 +653,7 @@ apply)
 	;;
 clear)
 	shift
-	clear_stash "$@"
+	git stash--helper clear "$@"
 	;;
 create)
 	shift
@@ -665,7 +665,7 @@ store)
 	;;
 drop)
 	shift
-	drop_stash "$@"
+	git stash--helper drop "$@"
 	;;
 pop)
 	shift
-- 
2.19.0.rc0.22.gc26283d74e

