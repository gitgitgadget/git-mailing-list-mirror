Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A148BC6FA99
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 14:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCFOH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCFOHM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 09:07:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1898303E4
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 06:06:46 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k37so5762896wms.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 06:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678111600;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RqBvXxA7E+8niXoEzgIhpGjPfHyTngb6xSDCARLi3Q=;
        b=eil7+h0GsBZSwlQgvsI1NMUFOgaWy+rh46nyAiNqAPxirkpTcjwhQ5MhbwKtIzfUlB
         bRi7cpWIBjqjDEVNveMjfXUFH7tOOMAIEg3BMk9JXNaeE5D+bScLXiuDCaUiNpzsPcyc
         dt41R7Zj70ZmzYubXCW67d35baLjmdMPJkDsYfQP/QZTe6NgCtEBjanJnem0GNz46r7A
         teo6mMpQAC7fxxUZOOIe4hZ3PTdfFHYPPLC2uakmAa7lIQbjvFN8C+pgvwfxTHVhWkIJ
         oVgTwaj5RKTU18+mOZtajELjrakCW+u3t3I8/S6sN6rz06hDA9XoRoXrWjWqkUT00btx
         56Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111600;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RqBvXxA7E+8niXoEzgIhpGjPfHyTngb6xSDCARLi3Q=;
        b=or8b4MvZSEeH+8J8YifxsEkSPkUunnPi9bQiiF1fYkHtYymqcLs00fNJxE3nk0ivlR
         1gCOIf836ZuAXo/FYr9VJGh8SvrMzJ5lIJKFZsjm3QJRkDEq0hWjUphiPSTT1DQw/pPC
         Yzhe9FX0mh823HTz4LtIMipYWlvFMncfNHkkTRRBfE1pqn7nopHSBehfWK6RF7stMVpU
         nf88hZOJVSzEZBa6PgVRHCxLmlfQSevMhUYAEwuOyDSQYfTOekv6vxKSDJRdwRb63XCJ
         Evyjthvx9tS3UsnvF5R8vfkOX4V3p4saZhKDatbzzyf0H7AgQMU0Asq0kvjz9GLpIDTh
         XKMQ==
X-Gm-Message-State: AO0yUKVC2fC5yTcpLoth4v4WsnSaOHoyJe7L3q9GfGKSp5LiT6Yodf5G
        x1LEDwRr8PJ+LVbUuG3o6uVgMbP5SAM=
X-Google-Smtp-Source: AK7set+jAEzPptJjl9JHSWIwTgBHrn/3m9zU21cSlgfR/93Ej/p6CQhvLk5jej0uzxVt2YX1fugT7w==
X-Received: by 2002:a05:600c:3548:b0:3dc:5390:6499 with SMTP id i8-20020a05600c354800b003dc53906499mr9701462wmq.1.1678111600461;
        Mon, 06 Mar 2023 06:06:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e41-20020a05600c4ba900b003e1f2e43a1csm9960205wmp.48.2023.03.06.06.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:06:40 -0800 (PST)
Message-Id: <0fd18b6d740f1e8a6f62a25947bc3ad49c2674a6.1678111599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 14:06:31 +0000
Subject: [PATCH 1/8] ahead-behind: create empty builtin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'git ahead-behind' builtin _will_ allow users to specify multiple
tip revisions relative to a common base and _will_ report the number of
commits on each side of the symmetric difference between each tip and
the base. However, that algorithm is not implemented yet and instead
this change introduces the builtin and the basic boilerplate for a new
builtin.

This builtin could be replaced with multiple invocations of 'git
rev-list --count <base>..<tip>' (for ahead values) and 'git rev-list
--count <tip>..<base>' (for behind values). However, it is important to
be able to batch these calls into a single process.

For example, we will be able to track all local branches relative to an
upstream branch using an invocation such as

  git for-each-ref --format=%(refname) refs/heads/* |
    git ahead-behind --base=origin/main --stdin

This would report each local branch and how far ahead or behind it is
relative to the remote branch 'origin/main'. This could be used to
signal some branches are very old and need to be updated via 'git
rebase' or deleted. We will see in future changes how such commit
counting can be done efficiently within a single process (and a single
commit walk) instead of multiple processes.

For now, only 'git ahead-behind -h' works, and the builtin reports
failure and shows the usage if the '--base' option is skipped. The
documentation is light. These will be updated in the coming changes.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 .gitignore                         |  1 +
 Documentation/git-ahead-behind.txt | 62 ++++++++++++++++++++++++++++++
 Makefile                           |  1 +
 builtin.h                          |  1 +
 builtin/ahead-behind.c             | 30 +++++++++++++++
 git.c                              |  1 +
 t/t4218-ahead-behind.sh            | 17 ++++++++
 7 files changed, 113 insertions(+)
 create mode 100644 Documentation/git-ahead-behind.txt
 create mode 100644 builtin/ahead-behind.c
 create mode 100755 t/t4218-ahead-behind.sh

diff --git a/.gitignore b/.gitignore
index e875c590545..cc064a4817a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -14,6 +14,7 @@
 /bin-wrappers/
 /git
 /git-add
+/git-ahead-behind
 /git-am
 /git-annotate
 /git-apply
diff --git a/Documentation/git-ahead-behind.txt b/Documentation/git-ahead-behind.txt
new file mode 100644
index 00000000000..0e2f989a1a0
--- /dev/null
+++ b/Documentation/git-ahead-behind.txt
@@ -0,0 +1,62 @@
+git-ahead-behind(1)
+===================
+
+NAME
+----
+git-ahead-behind - Count the commits on each side of a revision range
+
+SYNOPSIS
+--------
+[verse]
+'git ahead-behind' --base=<ref> [ --stdin | <revs> ]
+
+DESCRIPTION
+-----------
+
+Given a list of commit ranges, report the number of commits reachable from
+each of the sides of the range, but not the other. Consider a commit range
+specified as `<base>...<tip>`, allowing for the following definitions:
+
+* The `<tip>` is *ahead* of `<base>` by the number of commits reachable
+  from `<tip>` but not reachable from `<base>`. This is the same as the
+  number of the commits in the range `<base>..<tip>`.
+
+* The `<tip>` is *behind* `<base>` by the number of commits reachable from
+  `<base>` but not reachble from `<tip>`. This is the same as the number
+  of commits in the range `<tip>..<base>`.
+
+The sum of the ahead and behind counts equals the number of commits in the
+symmetric difference, the range `<base>...<tip>`.
+
+Multiple revisions may be specified, and they are all compared against a
+common base revision, as specified by the `--base` option. The values are
+reported to stdout one line at a time as follows:
+
+---
+  <rev> <ahead> <behind>
+---
+
+There will be exactly one line per input revision, but the lines may be
+in an arbitrary order.
+
+
+OPTIONS
+-------
+--base=<ref>::
+	Specify that `<ref>` should be used as a common base for all
+	provided revisions that are not specified in the form of a range.
+
+--stdin::
+	Read revision tips and ranges from stdin instead of from the
+	command-line.
+
+
+SEE ALSO
+--------
+linkgit:git-branch[1]
+linkgit:git-rev-list[1]
+linkgit:git-tag[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 50ee51fde32..691f84e8d4e 100644
--- a/Makefile
+++ b/Makefile
@@ -1199,6 +1199,7 @@ LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
+BUILTIN_OBJS += builtin/ahead-behind.o
 BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
diff --git a/builtin.h b/builtin.h
index 46cc7897898..1ae168fa3e3 100644
--- a/builtin.h
+++ b/builtin.h
@@ -108,6 +108,7 @@ void setup_auto_pager(const char *cmd, int def);
 int is_builtin(const char *s);
 
 int cmd_add(int argc, const char **argv, const char *prefix);
+int cmd_ahead_behind(int argc, const char **argv, const char *prefix);
 int cmd_am(int argc, const char **argv, const char *prefix);
 int cmd_annotate(int argc, const char **argv, const char *prefix);
 int cmd_apply(int argc, const char **argv, const char *prefix);
diff --git a/builtin/ahead-behind.c b/builtin/ahead-behind.c
new file mode 100644
index 00000000000..a56cc565def
--- /dev/null
+++ b/builtin/ahead-behind.c
@@ -0,0 +1,30 @@
+#include "builtin.h"
+#include "parse-options.h"
+#include "config.h"
+
+static const char * const ahead_behind_usage[] = {
+	N_("git ahead-behind --base=<ref> [ --stdin | <revs> ]"),
+	NULL
+};
+
+int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
+{
+	const char *base_ref = NULL;
+	int from_stdin = 0;
+
+	struct option ahead_behind_opts[] = {
+		OPT_STRING('b', "base", &base_ref, N_("base"), N_("base reference to process")),
+		OPT_BOOL(0 , "stdin", &from_stdin, N_("read rev names from stdin")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, ahead_behind_opts,
+			     ahead_behind_usage, PARSE_OPT_KEEP_UNKNOWN_OPT);
+
+	if (!base_ref)
+		usage_with_options(ahead_behind_usage, ahead_behind_opts);
+
+	git_config(git_default_config, NULL);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 6171fd6769d..64e3d493561 100644
--- a/git.c
+++ b/git.c
@@ -467,6 +467,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "ahead-behind", cmd_ahead_behind, RUN_SETUP },
 	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
diff --git a/t/t4218-ahead-behind.sh b/t/t4218-ahead-behind.sh
new file mode 100755
index 00000000000..bc08f1207a0
--- /dev/null
+++ b/t/t4218-ahead-behind.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='git ahead-behind command-line options'
+
+. ./test-lib.sh
+
+test_expect_success 'git ahead-behind -h' '
+	test_must_fail git ahead-behind -h >out &&
+	grep "usage:" out
+'
+
+test_expect_success 'git ahead-behind without --base' '
+	test_must_fail git ahead-behind HEAD 2>err &&
+	grep "usage:" err
+'
+
+test_done
-- 
gitgitgadget

