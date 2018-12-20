Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3B51F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbeLTTpL (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54698 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeLTTpD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so3242013wmh.4
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCt68U6JDmLabnJePwMoA9fxXTHaNM/GapwpHtuQfTU=;
        b=n4ak4kCIF9zS27nbqq6Ht/9qC3yW4QDIsatIr9+hZKPGYlc7eY5TUviRrUXiEe1j9+
         UbNPq/1BnSDtX1eI/lESU9/ah+/f5/34V30gnTtjQ2VzYN/PLmV2xSmgOgJZEpx1JhKW
         HsYdBzDzLzlhWLlG2iMGD9LsaasubIdRL17kRyM738cznz623qrbyLtr6cB65y2piooC
         QfToBIN4DZzpy/w+EHzN8+dDPnsNMR03b4wL1+ZzZ6aokTOntL2ZeouLgSozGV9MAIia
         z3w4xSkct+hF08TqV7CKcq+hlH+Hlfu+pJ5nqoeB39Qou+420bViXQcTgpx5V9MucRO5
         FOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCt68U6JDmLabnJePwMoA9fxXTHaNM/GapwpHtuQfTU=;
        b=RzQjeTc+xFb3SYhPeCklFpfDmfuamoa8KA4f2vJPFAvnq4nKqZzE9VZQTxpn+bbCt0
         hrghN8uuxxqQPShfTGcll7qrXjzTgKUEULkmube8xW0TNHPRtsdVtnSMhyqDqurUQ9LD
         2Zf1cr8gx1qgqfuysU2xMqdpwMf596ZsTdS/psa080wLKGaLJ9C9eBitiQwUhDN+Wlr6
         1gJZsCkVFIQP+2lxflaff/ut3h0Us1tzqEpm5OigMOKKVsoHGwoCR1vRN+eZn/cCYYsq
         opfXi+22/kB147xEjWx96YW9ApbNXHHyXPP8Z069UlZ7WD0NUcp0TVnm7rELbOTy6/HC
         gwNg==
X-Gm-Message-State: AA+aEWbwnVidjhT+GXxxVX8CvW7jvU/mgG6hmESDIPGCusR9HPDjjBdn
        igB/phu4TT5A9DcVqtW8+rAyACrAX5A=
X-Google-Smtp-Source: AFSGD/Vn7xzELw+IBjceqGqUkqBitRMSlMVlaHklmTeWxUmVfdKtJxECBeMoBYdZQrie/dJrRT/mBg==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr13003627wma.85.1545335099005;
        Thu, 20 Dec 2018 11:44:59 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:44:58 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 11/26] stash: convert drop and clear to builtin
Date:   Thu, 20 Dec 2018 21:44:27 +0200
Message-Id: <42af83890f1b85f4ae19fc68c26e6a3afb9062cd.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
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
index 366a082853..b8f70230f9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -670,7 +670,7 @@ apply)
 	;;
 clear)
 	shift
-	clear_stash "$@"
+	git stash--helper clear "$@"
 	;;
 create)
 	shift
@@ -682,7 +682,7 @@ store)
 	;;
 drop)
 	shift
-	drop_stash "$@"
+	git stash--helper drop "$@"
 	;;
 pop)
 	shift
-- 
2.20.1.441.g764a526393

