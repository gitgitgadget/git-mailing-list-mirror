Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764D6C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20DDD22255
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5hgez7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbgJOBzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732444AbgJOByk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:54:40 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59377C08EA7E
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:25:00 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d22so797662qtn.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/7ik1i6dyouAjukNwAvYq0ihQd6vAXvoJNVKvCCMTuo=;
        b=C5hgez7aqMtsUBMRWo7yXWrQIJEJI7OJ/KpzNwPbQSEJc0++Sd5MyfJUn0l3x2tqqS
         dinbyAGhmXbVvwclQWAMAeAlDm8Np46/CtSk0yJXwhjVcnwwEvOXtT2UMxFzkVfGBz1I
         V/LVQHbmdEG6CTFK5WxO0rddNO+djyCQ2nLwDAL6PDTzwmBz6o6dUTgEoPFpXwdlnSoN
         RMd6miE6XqwH4jLeiJVcVcHqeCTUsEpgC46DiKye9eIlo2QthzJL4f53UARAmxHpxvGQ
         4SdoaV+77NjDj91eRLp5VtRylQYJ0yRPOeB6lq6xDY8lxAAUm9MEkVEUnwit/uMovitw
         Tgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/7ik1i6dyouAjukNwAvYq0ihQd6vAXvoJNVKvCCMTuo=;
        b=GcvDIobAULt1o7DVdrSrJR9kX8EGK6lKx0JdviE9j2lYJ5DZr6OIFLRfCmBzGe7TCs
         6P+dGO4bhHdpkKQla6jbFdoUYH4WSdPIBKZ0C2DTKbqw9eZFjkwjZEGhnL4F9RUQOOSD
         awVWVexI7pcAQO4mID8d28EaV8IaBs2fgEZxTFMlUK5dn51o89EjIvhXKJSywj0mXNJj
         o2Gw8UIscRPgCG0i121VACokdNtS8qQwnIOfo7aHb+U1WkSABynnNObZ8zJSOdGqCuJN
         m1xFgXQgXjj8OBCbPBWRuvEbDIcOGubX0eIk2YVWoJVf4rDIaiAOCvkZXiCoz3zBVeuV
         LHWA==
X-Gm-Message-State: AOAM532df6MxaeehFnLIRPKda4AB4W0FgP6rdRc5Cqf13y9h3npyx2TI
        PIwEC+AMgH7I6uk6olnuT3m88/lZTGczdvuTq92cJ4Ob1lhKrSAQR5+KOlrSuv1zyTYF/z3wfQz
        QsXpqT674odQ0kz+3i9IdvsrNX1ErQOlGgrM8IKVRpZWT3Q6W3k1lIWwepKcRSr4Kv5Ak2wynCg
        ==
X-Google-Smtp-Source: ABdhPJwAY00nkB9DeUnPTZcv15cORU/7PcJ1BBcs5zgocMm0NQoBjbkrXFiNwRN/joGUpMK+UEedI+5SvpIKHJX3JNI=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:11b3:: with SMTP id
 u19mr1993403qvv.51.1602717899344; Wed, 14 Oct 2020 16:24:59 -0700 (PDT)
Date:   Wed, 14 Oct 2020 16:24:41 -0700
In-Reply-To: <20201014232447.3050579-1-emilyshaffer@google.com>
Message-Id: <20201014232447.3050579-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201014232447.3050579-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH v5 2/8] hook: scaffolding for git-hook subcommand
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce infrastructure for a new subcommand, git-hook, which will be
used to ease config-based hook management. This command will handle
parsing configs to compose a list of hooks to run for a given event, as
well as adding or modifying hook configs in an interactive fashion.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Since v4, mainly changed to RUN_SETUP_GENTLY so that 'git hook list' can
    be executed outside of a repo.

 .gitignore                    |  1 +
 Documentation/git-hook.txt    | 20 ++++++++++++++++++++
 Makefile                      |  1 +
 builtin.h                     |  1 +
 builtin/hook.c                | 21 +++++++++++++++++++++
 git.c                         |  1 +
 t/t1360-config-based-hooks.sh | 11 +++++++++++
 7 files changed, 56 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1360-config-based-hooks.sh

diff --git a/.gitignore b/.gitignore
index 6232d33924..432e0b11cb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,6 +75,7 @@
 /git-grep
 /git-hash-object
 /git-help
+/git-hook
 /git-http-backend
 /git-http-fetch
 /git-http-push
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
new file mode 100644
index 0000000000..9eeab0009d
--- /dev/null
+++ b/Documentation/git-hook.txt
@@ -0,0 +1,20 @@
+git-hook(1)
+===========
+
+NAME
+----
+git-hook - Manage configured hooks
+
+SYNOPSIS
+--------
+[verse]
+'git hook'
+
+DESCRIPTION
+-----------
+A placeholder command. Later, you will be able to list, add, and modify hooks
+with this command.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 5311b1d2c4..9152f6d7c8 100644
--- a/Makefile
+++ b/Makefile
@@ -1095,6 +1095,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
diff --git a/builtin.h b/builtin.h
index 53fb290963..3b20689d1a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -162,6 +162,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 int cmd_grep(int argc, const char **argv, const char *prefix);
 int cmd_hash_object(int argc, const char **argv, const char *prefix);
 int cmd_help(int argc, const char **argv, const char *prefix);
+int cmd_hook(int argc, const char **argv, const char *prefix);
 int cmd_index_pack(int argc, const char **argv, const char *prefix);
 int cmd_init_db(int argc, const char **argv, const char *prefix);
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
diff --git a/builtin/hook.c b/builtin/hook.c
new file mode 100644
index 0000000000..b2bbc84d4d
--- /dev/null
+++ b/builtin/hook.c
@@ -0,0 +1,21 @@
+#include "cache.h"
+
+#include "builtin.h"
+#include "parse-options.h"
+
+static const char * const builtin_hook_usage[] = {
+	N_("git hook"),
+	NULL
+};
+
+int cmd_hook(int argc, const char **argv, const char *prefix)
+{
+	struct option builtin_hook_options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, builtin_hook_options,
+			     builtin_hook_usage, 0);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index f1e8b56d99..caad1c877f 100644
--- a/git.c
+++ b/git.c
@@ -524,6 +524,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
+	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
new file mode 100755
index 0000000000..34b0df5216
--- /dev/null
+++ b/t/t1360-config-based-hooks.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+test_description='config-managed multihooks, including git-hook command'
+
+. ./test-lib.sh
+
+test_expect_success 'git hook command does not crash' '
+	git hook
+'
+
+test_done
-- 
2.28.0.rc0.142.g3c755180ce-goog

