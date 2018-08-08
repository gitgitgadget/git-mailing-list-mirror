Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31A91208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeHHQLP (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 12:11:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47070 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeHHQLP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 12:11:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id o8-v6so1274452edt.13
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ltj4Ypxht+lzTgXCZEcrwAcbNsmKqqInH8vDQEwAfMs=;
        b=sYNlHC4+Xs4ykr1nvUxA2qDa2hxb8hfSZ7CwGpC93GL7UkNSFab4G5H6c2UTefEi4j
         IO/e1gcWFlTNjJndEvRPmx4dWB+9fsnsnpI2BgbJp2tcyhJ+VXRaShHPd+jd5Y+Go7Bm
         3N9zFVtBvklQtiTnH/ealwP0+nWshVMXhVlm4WQOvUEluUcAIYPNkgR6nBLslkkZISRH
         UuQR+GFeatofN0mRMVoMlTfPveSL24ItZNhAbsQc8yRjT1MJ0KhjEdU8fdMVIL4YUkXI
         VP5SVMrn6Hf0kj9VG1Qy7QT5JcAmB9j1l+mO2X9cupS3VCTxgmDudcr4Mju7CCcZsS+U
         YtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ltj4Ypxht+lzTgXCZEcrwAcbNsmKqqInH8vDQEwAfMs=;
        b=cMi4ibNaZ48WTyzDkHsDFXcMTXNAVkJ7w3sbDAIl3WVTWjXitlY901PzG/l2QMplCZ
         r4qNQuHxQLNQHJHB3ObA0P9dA7XMguht1VbUaeWYs4ExhZBE9X9CfUketyA2VAGWsFnh
         MJXQCEQF0FlJar/zJPAo8jz+dHp/nKDWPxQIvcF1jOzV6dQfzlzxw6b5tjhWOMCdSAqB
         HHVbEaKxgwrqCz4VlTwRzQvlJxOUNFfsOJTAAYKcBBJRUVe5iq5O9V4r/YH43oTCUOdl
         pNKSn/RYCXj9Wxq7c5OJ9OL8D4y0D3/LBWcWlYCuwSYYNMQxjjnE5tIxij9vSnvOUJtI
         IuVg==
X-Gm-Message-State: AOUpUlF7RgWLFNMzKnreub4WMmt7FEiiKNd96ChvNaJ0C3sEIc3H6/XW
        3lscYwHbjHy5JP9HxmG4hwGukxJc
X-Google-Smtp-Source: AA+uWPyGdfMSww4Ee1rzbnYJK5AvJqHb/E3WwAFcEUT3eRiByS0/+jjZdRjHb+DLBl2ZFOxt7iTehQ==
X-Received: by 2002:a50:f098:: with SMTP id v24-v6mr3392072edl.90.1533736287583;
        Wed, 08 Aug 2018 06:51:27 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1619420edo.44.2018.08.08.06.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 06:51:26 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 05/11] builtin rebase: support the `verbose` and `diffstat` options
Date:   Wed,  8 Aug 2018 19:33:24 +0545
Message-Id: <20180808134830.19949-6-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808134830.19949-1-predatoramigo@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit introduces support for the `-v` and `--stat` options of
rebase.

The --stat option can also be configured via the Git config setting
rebase.stat. To support this, we also add a custom rebase_config()
function in this commit that will be used instead of (and falls back to
calling) git_default_config().

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 19fa4d3fc4..2d3f1d65fb 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -18,6 +18,7 @@
 #include "lockfile.h"
 #include "parse-options.h"
 #include "commit.h"
+#include "diff.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
@@ -81,6 +82,8 @@ struct rebase_options {
 	int dont_finish_rebase;
 	enum {
 		REBASE_NO_QUIET = 1<<0,
+		REBASE_VERBOSE = 1<<1,
+		REBASE_DIFFSTAT = 1<<2,
 	} flags;
 	struct strbuf git_am_opt;
 };
@@ -166,6 +169,10 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "GIT_QUIET",
 		opts->flags & REBASE_NO_QUIET ? "" : "t");
 	add_var(&script_snippet, "git_am_opt", opts->git_am_opt.buf);
+	add_var(&script_snippet, "verbose",
+		opts->flags & REBASE_VERBOSE ? "t" : "");
+	add_var(&script_snippet, "diffstat",
+		opts->flags & REBASE_DIFFSTAT ? "t" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -311,6 +318,21 @@ static int reset_head(struct object_id *oid, const char *action,
 	return ret;
 }
 
+static int rebase_config(const char *var, const char *value, void *data)
+{
+	struct rebase_options *opts = data;
+
+	if (!strcmp(var, "rebase.stat")) {
+		if (git_config_bool(var, value))
+			opts->flags |= REBASE_DIFFSTAT;
+		else
+			opts->flags &= !REBASE_DIFFSTAT;
+		return 0;
+	}
+
+	return git_default_config(var, value, data);
+}
+
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = {
@@ -332,7 +354,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 N_("allow pre-rebase hook to run")),
 		OPT_NEGBIT('q', "quiet", &options.flags,
 			   N_("be quiet. implies --no-stat"),
-			   REBASE_NO_QUIET),
+			   REBASE_NO_QUIET| REBASE_VERBOSE | REBASE_DIFFSTAT),
+		OPT_BIT('v', "verbose", &options.flags,
+			N_("display a diffstat of what changed upstream"),
+			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
+		{OPTION_NEGBIT, 'n', "no-stat", &options.flags, NULL,
+			N_("do not show diffstat of what changed upstream"),
+			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_END(),
 	};
 
@@ -360,7 +388,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	trace_repo_setup(prefix);
 	setup_work_tree();
 
-	git_config(git_default_config, NULL);
+	git_config(rebase_config, &options);
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
@@ -456,6 +485,33 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			argc ? argv[0] : NULL, NULL))
 		die(_("The pre-rebase hook refused to rebase."));
 
+	if (options.flags & REBASE_DIFFSTAT) {
+		struct diff_options opts;
+
+		if (options.flags & REBASE_VERBOSE)
+			printf(_("Changes from %s to %s:\n"),
+				oid_to_hex(&merge_base),
+				oid_to_hex(&options.onto->object.oid));
+
+		/* We want color (if set), but no pager */
+		diff_setup(&opts);
+		opts.stat_width = -1; /* use full terminal width */
+		opts.stat_graph_width = -1; /* respect statGraphWidth config */
+		opts.output_format |=
+			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
+		opts.detect_rename = DIFF_DETECT_RENAME;
+		diff_setup_done(&opts);
+		diff_tree_oid(&merge_base, &options.onto->object.oid,
+			      "", &opts);
+		diffcore_std(&opts);
+		diff_flush(&opts);
+	}
+
+	/* Detach HEAD and reset the tree */
+	if (options.flags & REBASE_NO_QUIET)
+		printf(_("First, rewinding head to replay your work on top of "
+			 "it...\n"));
+
 	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1))
 		die(_("Could not detach HEAD"));
-- 
2.18.0

