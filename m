Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3794C1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439032AbeKWJsD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:48:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40495 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439027AbeKWJsC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:48:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so10637889wrt.7
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N5TS0jbvGTt6NrT69hdfYrqtl0L0Sv8q77P3ZmvsVJI=;
        b=ojleKSBXkpPRXmHHlsQKdGo4xT15AkCsHLH1POiHv6OxqU0VE00Xr8W0iLSZN74H+7
         9nd8Z5asp1qr0R96bBsQqQPOWiTTOJtgxLy+tnTFRC+f8OzmtwUO/S2iLLyik1WhQpdH
         3ar89Da/Fqsv0pTtZ/qF1cqlh7b3GrU9q2trVe5MvG7k3H/TJqBJrlBsT8LlGJV29Ena
         X1BoIi6+ErK5OkIpZg5E5DjlsHWozY07MS4FKUpbSSH6FGmkDa2uWHOtxvOu7Glk9u2v
         SWUdVOkLuF6uTis6jqOboDQTWmr9wbAYRgYrZkjUenZPp2N8S6fYnjGSrDBz2SAF/9Ey
         Qatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N5TS0jbvGTt6NrT69hdfYrqtl0L0Sv8q77P3ZmvsVJI=;
        b=TrkoJOau+Oc3PvJAWaw44o6nN6IdeoE45iDCq0gGd4+15F9mj6JnFZq1IAWI2bFFNU
         A6ub9tAE/pTc3XqU4lH64PX4KZGg2jeIx8OiHVJdmw1YBrjN9F5gX/ujOUlBdx4eGZFP
         TaBUe+xOBqeSt+hPntdaiOP3s8tZ7iWLv2/qWOB669N7MZVBFupF0lt26h8XZIfABhzO
         wRSOOlOFCo8R5oIHSYLR+670/mdgoOVuLEJSXnqfdk/uZC4uvoFc6DZlz+npy0kKP020
         ELcbsuzIxTQfAe70XnwTYqF6bNBUEAKAyTW7fMRCxQ6nZm4qZtko8UUUpxzBnWuQsSta
         kgrg==
X-Gm-Message-State: AA+aEWatoS1cVIeg61FxR3qMQXymqmnjG7L0FiI81xZO2ndnciWzuTc3
        WUVVHK2Sm6SLR0nGh+znqMOSC9Xp
X-Google-Smtp-Source: AFSGD/VnerFz8ckts/8qDU7DMhYoojH6efxbVnQEvlXXP9cLYfj//tFoNnNHd9kpRUJG+BrL7kJ3Dw==
X-Received: by 2002:adf:a50c:: with SMTP id i12mr10974067wrb.220.1542927981910;
        Thu, 22 Nov 2018 15:06:21 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:21 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 10/22] stash: convert drop and clear to builtin
Date:   Fri, 23 Nov 2018 01:05:30 +0200
Message-Id: <22ae2b44fc9c32f36050e5189f65307d66f31f96.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
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
 builtin/stash--helper.c | 117 ++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |   4 +-
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 997b1c0ecf..07b8ec5bcb 100644
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
 static struct strbuf stash_index_path = STRBUF_INIT;
 
@@ -137,6 +149,32 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
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
+		return error(_("git stash clear with parameters is "
+			       "unimplemented"));
+
+	return do_clear_stash();
+}
+
 static int reset_tree(struct object_id *i_tree, int update, int reset)
 {
 	int nr_trees = 1;
@@ -424,6 +462,81 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int do_drop_stash(const char *prefix, struct stash_info *info, int quiet)
+{
+	int ret;
+	struct child_process cp_reflog = CHILD_PROCESS_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
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
+	int ret;
+	int quiet = 0;
+	struct stash_info info;
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
+	ret = do_drop_stash(prefix, &info, quiet);
+	free_stash_info(&info);
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -446,6 +559,10 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.1.878.g0482332a22

