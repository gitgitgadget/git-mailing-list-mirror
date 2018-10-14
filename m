Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85A831F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbeJOFzq (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45686 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOFzp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id v18-v6so16052101edq.12
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LhOnbEhgnSrSkM7NuICujSTa4UmfYmyIpKvxgrHLHYw=;
        b=es082kPxS0IFJpOIVkt2AQtHgFAtHHQKE7ksBZtVftkeKViyXmPmnhRHTFgo3tBugy
         lCK+/JmgVRBysmiVcLs/2MlYwe9idEfBUjkOCKF2xiheJmKlAd2g2yR/FvJriUzN9Q6+
         IV3qJ2T10KmVMXjGFEUDDlw17+IfDe7DVOZRi234oh37TIjKlaUNlg8SQ9uC7QE7DNyb
         tBuftxaTBwTyzoXCFefIurqknn2Zz/uLELoLa+OI0g7v7xiQTZw2MhBvtPOSh6SZPfGY
         KlvnuXm3rRf565OTW5EbOnZblGWL8LCDj4juGGdoN7zshTww8/Gp8tBgUeBf7fF2RUzl
         udbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LhOnbEhgnSrSkM7NuICujSTa4UmfYmyIpKvxgrHLHYw=;
        b=OO4+XuTigU7s9JrYJ68L1JIW+Fm534yCuZ8fVKJotYPf5pHfsa2wYCF41ff5He3pwK
         KEisovRcc+g/x+9in1KYWkZEKFHhM+Vp/zYyqVVnMnLrp6yGtdnKFEidw+BF6YBsU7eb
         rUViZ/JBFQs0nCbZfToUpMQsKfLdKh2nTZbKKULsw3O68EWvhRiFcfapxhxc7ijDUGVl
         0OENeWFrSoyb/VSVB7yIiNHjk9EsXMCVxbINDGHWgGPuv0AotCigD/kmTQ40656jh+v4
         pBpOHY8PsgIvGGlj1w4D7eiWZzOHx+YpuSIo38E/22/Ot+G63aRTheuACspbdKCsG8pv
         3vxg==
X-Gm-Message-State: ABuFfogo8wJTkT7rXZxNcVgyG5/VRt9V8uNY4tYn/wD+zXgMCPhS+whR
        C3OXI7PkuAULENzBbAw7/Jzjw/PE
X-Google-Smtp-Source: ACcGV60zi4Or8VcrwZ8kj910fRhYaU9wf2raTBpHvSFWGv2JAOzLHcAgrEhJ/5nDY16wPV/q6OcQig==
X-Received: by 2002:a17:906:2899:: with SMTP id o25-v6mr16161823ejd.53.1539555198319;
        Sun, 14 Oct 2018 15:13:18 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:17 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 09/21] stash: convert drop and clear to builtin
Date:   Mon, 15 Oct 2018 01:11:15 +0300
Message-Id: <97e3fef686fdd1659f193819ec8c14bf753aa7cb.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
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
index c43e0aacbb..aff6cda4c9 100644
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
 
@@ -139,6 +151,32 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
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
@@ -426,6 +464,81 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
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
@@ -448,6 +561,10 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.0.rc0.23.g10a62394e7

