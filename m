Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AC5C433E9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6360C64FC5
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCKCLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhCKCLG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:06 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF07C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:10:55 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id bt20so5266329qvb.0
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hsejj3QOv3VNOHJVFzz1trgAk7BJM3wGQFZt6KLQh7g=;
        b=v7f/44R1N/z6muOWI9QV6DmRUcdbUNAgKTY42JgIj3k6PKXLDPOQNDi65wl8AUqIJ+
         UIuF9Xl1/+3hWKQ8KHR7UNRKgv5C2/Bf7zlz5UpDTXnou1oTb7Ij27mKSLMuHXbUFSPk
         qKcTyR00nxGmMwYzhKaSZZPCZ+TXmseY7K2+PVGdcwd0MlApoKYLs28DT1Qfknw2XMbV
         laef/B4E/N7ySZTUOOUkttlMxxElU8NdVsTPdp/i9NZrSl317jKDvnswZvyEG86IK463
         UcST90VCUngwsooRvS8EMTM4ux20xTrMyLiW52QRE8EzJzGyap0lROr+okiGHnB73FHN
         PAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hsejj3QOv3VNOHJVFzz1trgAk7BJM3wGQFZt6KLQh7g=;
        b=hFcHr2mCHVqWHs64EEFQmTXv+KFiIODHZIZnf1O9WpOB/zVPGXu8M7Vx/Nru4Udluk
         IofQx5xky0ttSGDg0vEi3Y8Zl6rwFNjJ2vH01AAMKEbbpnC50C3j9z8K+5+YzWjux8ZA
         0LaUXLieHRr4m+oe8RYTt5RSmvnvdfqSPKnP09IVadGy3tcApkS+23DhgE92cHxlI6wx
         81EEwzlD8KWRDlCxh8jbXXwsI4eied2SZjoaIkx/vZpcTM5uBIygUy6O4e7miI7nhZGu
         CtDvREgMsrD4nbf6Kf6RTIOjGi6IkRDk9R5ru3Qla8OucYCEoyOuGuQShI+QHe2Rrxki
         kJ7Q==
X-Gm-Message-State: AOAM531VTFSwZG0uYmbCkz6SyR6ClhDgBAP5JGNFclbz6YG8+qm4yZ4Y
        m20A8pa1OVm9pBKi67M0CawaqB6fGFEIgDtPcW20vGO7YlBARVGsgUCEAAtfwTX49FesMEiWdZ2
        AC8EsL3fsJ9/RHf/httAT8flbnVppnCRdf7Ld5nW2JXqDBsRKNLKHV2r0OMHl9jOqbbKgaYxbKw
        ==
X-Google-Smtp-Source: ABdhPJwVVgzr3qSJA7kFxqheVhZj1hoz1Y+SDwy53vRJW0QgYBb5MvmwaiEivay/T3Op/1A53zIh3PRebszsqCG2u8U=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:4904:: with SMTP id
 bh4mr5598311qvb.53.1615428654491; Wed, 10 Mar 2021 18:10:54 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:02 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 02/37] hook: scaffolding for git-hook subcommand
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
No change since v7.

 .gitignore                    |  1 +
 Documentation/git-hook.txt    | 20 ++++++++++++++++++++
 Makefile                      |  1 +
 builtin.h                     |  1 +
 builtin/hook.c                | 21 +++++++++++++++++++++
 command-list.txt              |  1 +
 git.c                         |  1 +
 t/t1360-config-based-hooks.sh | 11 +++++++++++
 8 files changed, 57 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1360-config-based-hooks.sh

diff --git a/.gitignore b/.gitignore
index 3dcdb6bb5a..3608c35b73 100644
--- a/.gitignore
+++ b/.gitignore
@@ -76,6 +76,7 @@
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
index dfb0f1000f..8e904a1ab5 100644
--- a/Makefile
+++ b/Makefile
@@ -1087,6 +1087,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
diff --git a/builtin.h b/builtin.h
index b6ce981b73..8df1d36a7a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -163,6 +163,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
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
diff --git a/command-list.txt b/command-list.txt
index a289f09ed6..9ccd8e5aeb 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -103,6 +103,7 @@ git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators          complete
+git-hook                                mainporcelain
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
diff --git a/git.c b/git.c
index 9bc077a025..14adac716f 100644
--- a/git.c
+++ b/git.c
@@ -528,6 +528,7 @@ static struct cmd_struct commands[] = {
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
2.31.0.rc2.261.g7f71774620-goog

