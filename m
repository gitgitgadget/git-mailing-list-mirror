Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2AC1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbeHHVUY (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52199 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbeHHVUY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so3822527wma.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/UQFic3oRbAES7h5lSLE79hPMrLarMRgBzA//ysElCU=;
        b=CR0iuGLqSNbctxNLy1Rp1yI2Fb/M9hMWsLTL9q3rdilYgU+krQUbhjtYmE/0Wuu+Av
         YuejzPDjfTcAscRLw6XFO9DzFZ+/kacel4YhVZrzWivQax6LlsAr6Iip6RIEYSu3945d
         cvME38hOcWr1R9qkQYRkMARxAq02eAnctn5jNq+CDZzlowEr4nqD4EeDtxaJejrev/sM
         JsKrAcKeyjRrMZmykjgQEs4oZAEo+N385xpGq4llc7DWYTW7JAdVL92gKJic1V2szrbe
         EwBOCkKEpGi/pAiPWc/oDIZSnZCBh0yq+e0nDR4ZmKBwiOCa27lDHYAStIDkF/jfWoVt
         77jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/UQFic3oRbAES7h5lSLE79hPMrLarMRgBzA//ysElCU=;
        b=sNdN4R4I89BX01Co7KUsa3+WfvXCFnOdFDtWH56booG8PAl0OoLaBGre7Stlat7UTd
         wqudYI1O8lpmjtqs99/zw3JBdVAvlqjxICjSm/Sr0GEVBtFpN8+449J4ebzKhdfP1d78
         /RpzbdlrJG71N1piRRu99L4UkL8wVtiJZnwXq7mNVjyJVDpODaVGbRzGomw6fgUkWxf5
         HybF+mjbKCoyMc6OiIHbZEaeQnX5JmivRC9olfpmVHEtTOTnxCfqTV528I0PjFDeES+z
         uXinw7l28xbu38CixEsvStxuEPAszsy1xIBQQjjT8Y9GIpKNYx3wl9AoWGT6LR3bD8HW
         5ojg==
X-Gm-Message-State: AOUpUlHbmVYv8oGUqPjLpJjtatoOPryDzjMZ8GdYf1BJuEKqvlfhCWix
        W7g5jOL5j7aW0XhXdXcMlhHGOzSA
X-Google-Smtp-Source: AA+uWPxZVH1YdWvaNUTxXI4OI06PnAQ/tQnSoQRgMLiOhyx05mTq+ichu0YnGewxTVEDyIhAoTRhsw==
X-Received: by 2002:a1c:ea9c:: with SMTP id g28-v6mr2681497wmi.65.1533754761394;
        Wed, 08 Aug 2018 11:59:21 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.20
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:20 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 06/26] stash: convert drop and clear to builtin
Date:   Wed,  8 Aug 2018 21:58:45 +0300
Message-Id: <6831636969a588833f42530fda29602447085848.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
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
index ef6a9d30d..ae719b7fc 100644
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
+	if (argc != 0)
+		return error(_("git stash--helper clear with parameters is unimplemented"));
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
+			printf(_("Dropped %s (%s)\n"), info->revision.buf,
+			       oid_to_hex(&info->w_commit));
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
index 809b1c2d1..a99d5dc9e 100755
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
2.18.0.573.g56500d98f

