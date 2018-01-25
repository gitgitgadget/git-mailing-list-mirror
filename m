Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D58F1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeAYOCr (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:02:47 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44703 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeAYOCp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:45 -0500
Received: by mail-qt0-f193.google.com with SMTP id l20so19339801qtj.11
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kZIiLlz2L08FpHBGkY/LZh2Yt53niigrAyQla56admg=;
        b=paqZ2A/3w/cqN/cDjCRUjVKwLyK9C37nio0Ce3odYoNmjbl/qaDYINe5rfvc7ifbSn
         BtXtLoblG019uX1Ue9HYuCHsN4JVHH0SqIAajHsxijH7jIe2EngKi/2TKvRdsOEZLMaq
         1yWjMdjUYO1TrBFsBMjW0QSGBJangKUPxIU5uCnYPgWCwVlkrd0Up9H6tDqeX7idpdq0
         fzMj5MdTVAx+6Etjmat9IsiPF45vDix4gdvYdnQ0ZCb8f9LvCPrd1wAo7aPao7recYWZ
         +q3bcuIFhDZH1f8oNdGc79e0dE0zLhfT/k8FmkCbLOyFncPqFBX06vBIicKfCK3Bm7UG
         NFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kZIiLlz2L08FpHBGkY/LZh2Yt53niigrAyQla56admg=;
        b=a7udrJ1IxYsCcfWuU/R681/OC2ZXzqrWGWG6wTZfW7JK8jJxyTwYl8ONBxoDU6s2Wo
         whROs35+dZs9gB3vs8mUuyLXUgoDzHy+M6evwsWXHEGVTElyGAzeHFNt8iT1mWpfcFdl
         cvOV0Jf9pZ5JCf+wrs6uViARrhuSXXd9AUuBUonyHwaFDADWvNpKD1uoSqQ+6skiV84X
         4eAwn4LtCvPwFXsVJsAa1+58NqASbkgI6xhgXbopgkg3IBN7gUAty+KTsKhv3OZnCq+H
         P5z9lo5tWihxJaWjCjQ+fehXWve0sn4Xqj03s/+ex781tZ0CIQrdAd/HJwCFyw5+OcBb
         +vlQ==
X-Gm-Message-State: AKwxytfQyu9to3FOgIw8RCFI7SFyE28J2qUwr03vxt1XZdlzgkMQdqqj
        DHIxZb9cxY8SYFGAH+qV0gKcLRvy
X-Google-Smtp-Source: AH8x2261258VxZl1o1pcmNgbeYB9OvgZ3eTeFtS1TYpKbu/+l3KaAmyguYl17SXKDtVyRdKhWTjv2A==
X-Received: by 10.55.138.68 with SMTP id m65mr13842727qkd.166.1516888964599;
        Thu, 25 Jan 2018 06:02:44 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:43 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 03/14] packed-graph: create git-graph builtin
Date:   Thu, 25 Jan 2018 09:02:20 -0500
Message-Id: <20180125140231.65604-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180125140231.65604-1-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git the 'graph' builtin that will be used for writing and
reading packed graph files. The current implementation is mostly
empty, except for a check that the core.graph setting is enabled
and a '--pack-dir' option.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-graph.txt |  7 +++++++
 Makefile                    |  1 +
 builtin.h                   |  1 +
 builtin/graph.c             | 36 ++++++++++++++++++++++++++++++++++++
 command-list.txt            |  1 +
 git.c                       |  1 +
 6 files changed, 47 insertions(+)
 create mode 100644 Documentation/git-graph.txt
 create mode 100644 builtin/graph.c

diff --git a/Documentation/git-graph.txt b/Documentation/git-graph.txt
new file mode 100644
index 0000000000..de5a3c07e6
--- /dev/null
+++ b/Documentation/git-graph.txt
@@ -0,0 +1,7 @@
+git-graph(1)
+============
+
+NAME
+----
+git-graph - Write and verify Git commit graphs (.graph files)
+
diff --git a/Makefile b/Makefile
index 1a9b23b679..d8b0d0457a 100644
--- a/Makefile
+++ b/Makefile
@@ -965,6 +965,7 @@ BUILTIN_OBJS += builtin/for-each-ref.o
 BUILTIN_OBJS += builtin/fsck.o
 BUILTIN_OBJS += builtin/gc.o
 BUILTIN_OBJS += builtin/get-tar-commit-id.o
+BUILTIN_OBJS += builtin/graph.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
diff --git a/builtin.h b/builtin.h
index 42378f3aa4..ae7e816908 100644
--- a/builtin.h
+++ b/builtin.h
@@ -168,6 +168,7 @@ extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
 extern int cmd_fsck(int argc, const char **argv, const char *prefix);
 extern int cmd_gc(int argc, const char **argv, const char *prefix);
 extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
+extern int cmd_graph(int argc, const char **argv, const char *prefix);
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
 extern int cmd_hash_object(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
diff --git a/builtin/graph.c b/builtin/graph.c
new file mode 100644
index 0000000000..a902dc8646
--- /dev/null
+++ b/builtin/graph.c
@@ -0,0 +1,36 @@
+#include "builtin.h"
+#include "cache.h"
+#include "config.h"
+#include "dir.h"
+#include "git-compat-util.h"
+#include "lockfile.h"
+#include "packfile.h"
+#include "parse-options.h"
+
+static char const * const builtin_graph_usage[] ={
+	N_("git graph [--pack-dir <packdir>]"),
+	NULL
+};
+
+static struct opts_graph {
+	const char *pack_dir;
+} opts;
+
+int cmd_graph(int argc, const char **argv, const char *prefix)
+{
+	static struct option builtin_graph_options[] = {
+		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
+			N_("dir"),
+			N_("The pack directory to store the graph") },
+		OPT_END(),
+	};
+
+	if (!core_graph)
+		die("core.graph is false");
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_graph_usage, builtin_graph_options);
+
+	return 0;
+}
+
diff --git a/command-list.txt b/command-list.txt
index a1fad28fd8..d9c17cb9f8 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -61,6 +61,7 @@ git-format-patch                        mainporcelain
 git-fsck                                ancillaryinterrogators
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
+git-graph                               plumbingmanipulators
 git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
diff --git a/git.c b/git.c
index c870b9719c..29f8b6e7dd 100644
--- a/git.c
+++ b/git.c
@@ -408,6 +408,7 @@ static struct cmd_struct commands[] = {
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id },
+	{ "graph", cmd_graph, RUN_SETUP_GENTLY },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
-- 
2.16.0

