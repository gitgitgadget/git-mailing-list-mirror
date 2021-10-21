Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32F4C433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E6A6120F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhJUO1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhJUO1f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D62C061225
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso4049321wmd.3
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qlr8XGX25vU/B7Q4JhkhD0z8VztTftBDg7B4Fap6LwE=;
        b=KCqO1Qli8ZCJVb6RHwvADb0ZfK0ETcU8HhTUMuWk2v4dxC/yBC3mmDGYf+Eg8K2fYA
         zoGmCGJ8WJ+NktDouUEVw3IIuqb+TtZbTUK4+NnZTkvPyv7QBpuckx/hLazC5ttMK+TU
         zZveyXBprFGKYNLoSQFBMuKKAb0GmotB4FNBrqeAeRoX1TQ0+D3s+/IX0GKXBhLIL8Xh
         Lihrh5mOgXMfrHkz03FtfjzHfAUkdTSEhw0U0BrAU1eBq91gnn5WMedQGBzDbGiKAQBh
         t9W48CsDVq14MBa5PkNHsIjUySRM/MZvjYoDutopxnuHbF8BZWKHVDYSEitS4QkUxwve
         zb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Qlr8XGX25vU/B7Q4JhkhD0z8VztTftBDg7B4Fap6LwE=;
        b=pP43X+jlxAe1cL6/4Wx6ud4Ce5VnWqqgyTpz027Oyl5/0Rfa0Eezy0lTJAaAylVHNJ
         6njn20NrBAm73kSq4T3JAthNxlUgdC02wQjR4JcI5Q6eezEgcZcJcul7UF5DarBrxXBB
         DDzuApEiCv1nC4tUK5BGEDC/A+wyN0q2Az7TP+V037DAvshtpL6W2N78ZwWCJ5aStoQr
         JREeabFErueT6FSoqaQhkF/MlEVywQlmLdlZNWAW/YKo+5vu0b/niWMkLMplPiN/zzQX
         eQh/OuCW2lPKjRhDg7LTuCAFF6+xALGXLY5NCX6c++sul5jWy9DGmQxBf+9TytuW1T8i
         9lOw==
X-Gm-Message-State: AOAM530+838OgoFAk3G0b3MA4J3BwPyjeGm65h1jw8bD1xX9L1LIuyOD
        bCQv+OGQrFamldulDALdwdNUxoMhnPY=
X-Google-Smtp-Source: ABdhPJzDsjIWT4jk35NOTtb+L4JWhp7PcdPWgUgSVxx5DXgyTNIHPI6jmcBT+Omkp5DTVUwMeoUY/g==
X-Received: by 2002:a05:600c:1550:: with SMTP id f16mr21844761wmg.5.1634826315066;
        Thu, 21 Oct 2021 07:25:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7sm6653797wmq.32.2021.10.21.07.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:14 -0700 (PDT)
Message-Id: <78e682fc5307087157ecb46848c01389885404d3.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:24:46 +0000
Subject: [PATCH v4 06/29] fsmonitor--daemon: add a built-in fsmonitor daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a built-in file system monitoring daemon that can be used by
the existing `fsmonitor` feature (protocol API and index extension)
to improve the performance of various Git commands, such as `status`.

The `fsmonitor--daemon` feature builds upon the `Simple IPC` API and
provides an alternative to hook access to existing fsmonitors such
as `watchman`.

This commit merely adds the new command without any functionality.

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 .gitignore                  |  1 +
 Makefile                    |  1 +
 builtin.h                   |  1 +
 builtin/fsmonitor--daemon.c | 46 +++++++++++++++++++++++++++++++++++++
 git.c                       |  1 +
 5 files changed, 50 insertions(+)
 create mode 100644 builtin/fsmonitor--daemon.c

diff --git a/.gitignore b/.gitignore
index 054249b20a8..e863add420a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -72,6 +72,7 @@
 /git-format-patch
 /git-fsck
 /git-fsck-objects
+/git-fsmonitor--daemon
 /git-gc
 /git-get-tar-commit-id
 /git-grep
diff --git a/Makefile b/Makefile
index 29ed7c4aba6..95ac224bc8d 100644
--- a/Makefile
+++ b/Makefile
@@ -1104,6 +1104,7 @@ BUILTIN_OBJS += builtin/fmt-merge-msg.o
 BUILTIN_OBJS += builtin/for-each-ref.o
 BUILTIN_OBJS += builtin/for-each-repo.o
 BUILTIN_OBJS += builtin/fsck.o
+BUILTIN_OBJS += builtin/fsmonitor--daemon.o
 BUILTIN_OBJS += builtin/gc.o
 BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
diff --git a/builtin.h b/builtin.h
index 8a58743ed63..837b9ede598 100644
--- a/builtin.h
+++ b/builtin.h
@@ -159,6 +159,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
 int cmd_for_each_repo(int argc, const char **argv, const char *prefix);
 int cmd_format_patch(int argc, const char **argv, const char *prefix);
 int cmd_fsck(int argc, const char **argv, const char *prefix);
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix);
 int cmd_gc(int argc, const char **argv, const char *prefix);
 int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 int cmd_grep(int argc, const char **argv, const char *prefix);
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
new file mode 100644
index 00000000000..f0498793379
--- /dev/null
+++ b/builtin/fsmonitor--daemon.c
@@ -0,0 +1,46 @@
+#include "builtin.h"
+#include "config.h"
+#include "parse-options.h"
+#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+#include "simple-ipc.h"
+#include "khash.h"
+
+static const char * const builtin_fsmonitor__daemon_usage[] = {
+	NULL
+};
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
+{
+	const char *subcmd;
+
+	struct option options[] = {
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_fsmonitor__daemon_usage, 0);
+	if (argc != 1)
+		usage_with_options(builtin_fsmonitor__daemon_usage, options);
+	subcmd = argv[0];
+
+	die(_("Unhandled subcommand '%s'"), subcmd);
+}
+
+#else
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_fsmonitor__daemon_usage, options);
+
+	die(_("fsmonitor--daemon not supported on this platform"));
+}
+#endif
diff --git a/git.c b/git.c
index 5ff21be21f3..28c8af6b795 100644
--- a/git.c
+++ b/git.c
@@ -533,6 +533,7 @@ static struct cmd_struct commands[] = {
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
 	{ "fsck", cmd_fsck, RUN_SETUP },
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
+	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
-- 
gitgitgadget

