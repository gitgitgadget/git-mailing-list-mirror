Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1464BC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbiCASod (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiCASoX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:23 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8892E286D5
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:41 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so600602wms.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qHwl1k+mT7kL/vCpcTSTxB1s0NWzJtpH1afNGYRMp+8=;
        b=ArJm/gAqEL1QckNqcWc1v4x2lcQZgRGNiKp64EyqsL/q2TAnKK+BtGRcRHhGHuJwMm
         0ylcOcSh0h4HFJbTWLeRn0DW0uGX4mCf+lu+blK65e4BPBagFWr+7MOag3Z21pwnz7/i
         Mbqo9HndGgBMvZoQjxmM+4tyV5rrKZ/GKdhuCf5P47C93hyX6bkdpAZtqUkDw/X1hCqV
         ex2bcluuX1cCDsXQKBwOoMlxU4E5crNqLJFKpN1935UhbMIEafCq1s30xvFe9RVubbyW
         a8lM7kmMp6+sGaYxhiXU0TntSJDe3Z+KWWKIs8XNMDmDgtrbXWG9LuIFo+kHfYp7YVg8
         CAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qHwl1k+mT7kL/vCpcTSTxB1s0NWzJtpH1afNGYRMp+8=;
        b=uN2XD/CpPiRyKrRk5h2yXA3N1pt70Qpec7zcwOT7zejjR7jfAVFl1IO5A4LLngcH0/
         XK7tV7NM3QW6VzxJH9lzbuGnFg/fkbBwpgUnSu1Ml6X78mWGMXbwhB8vPPqVgQ8jb3uL
         ez81X268avIsHPTP/84KnwewHFV0XKSX7EGCE1vWqtPwDjl+kfrPl6IoR6hof6El8PDq
         KYrOv9U9n+Tlo3jGMMni8HKRyZLQRqkEMCup24kVumNQW2WST68kqf7MyWryedj9+LDg
         i7n40HTkZ3zdCwYh8oqNVjYBwpMYmwr95ksmHIn7Ag0EiOW7aujAXI0969pQxA1002o4
         0IxA==
X-Gm-Message-State: AOAM530xoOCdBhlZSknoVR+If0L8B7DiDPTMHtqyOfxiya880U7e6WBW
        PHVmlpvrF2XAcdzwG2OKYFZbcukgaCg=
X-Google-Smtp-Source: ABdhPJxQpIc5mw0FT5GeXHEI4RjofXpoNpndjJMKhpiaEgAqrw6biufZccPqaCRZhzTkOae12eAl1A==
X-Received: by 2002:a05:600c:14d5:b0:381:504f:ca91 with SMTP id i21-20020a05600c14d500b00381504fca91mr11691683wmh.93.1646160219944;
        Tue, 01 Mar 2022 10:43:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6-20020a05600018c600b001efe4a49566sm5985577wrq.78.2022.03.01.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:39 -0800 (PST)
Message-Id: <9ce938c69b5a3e47b8c0a68379892955c2d7da88.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:08 +0000
Subject: [PATCH v6 06/30] fsmonitor--daemon: add a built-in fsmonitor daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore                  |  1 +
 Makefile                    |  1 +
 builtin.h                   |  1 +
 builtin/fsmonitor--daemon.c | 46 +++++++++++++++++++++++++++++++++++++
 git.c                       |  1 +
 5 files changed, 50 insertions(+)
 create mode 100644 builtin/fsmonitor--daemon.c

diff --git a/.gitignore b/.gitignore
index f817c509ec0..e81de1063a4 100644
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
index 707a56d4c11..5af1d5b112e 100644
--- a/Makefile
+++ b/Makefile
@@ -1114,6 +1114,7 @@ BUILTIN_OBJS += builtin/fmt-merge-msg.o
 BUILTIN_OBJS += builtin/for-each-ref.o
 BUILTIN_OBJS += builtin/for-each-repo.o
 BUILTIN_OBJS += builtin/fsck.o
+BUILTIN_OBJS += builtin/fsmonitor--daemon.o
 BUILTIN_OBJS += builtin/gc.o
 BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
diff --git a/builtin.h b/builtin.h
index 83379f3832c..40e9ecc8485 100644
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
index a25940d72e8..3d8e48cf555 100644
--- a/git.c
+++ b/git.c
@@ -537,6 +537,7 @@ static struct cmd_struct commands[] = {
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
 	{ "fsck", cmd_fsck, RUN_SETUP },
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
+	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
-- 
gitgitgadget

