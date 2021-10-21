Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E15C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4526120F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhJUO2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhJUO1m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B18C061231
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso7120884wmc.1
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=orcS20HyQshMeJHSd+FSsboNdrlRdyJhtA2p2iopyKM=;
        b=Z/t26iRTnYGitGgi6XLj/gBUn719dWbVpI7Gd2fuq+VKKHxHYVnH4RDXlmCYk9XLlJ
         f7nHWOpotcwyUwTJ7ZnbCIKOqNjSEGac6TV+7MMGgYjx4Iej1Tbj/9bVKhZv56t2FMKe
         mHE3y7O5RsnEnDu+m+HfwwyLBsZl9YR4/xP4MOtaOOV1gETO2TxP/WBLsLTNeuZI81GY
         REj6pdedq7TlJh4jfK2j36c5q40cl5tEG3TcfdPLN/t7FNrdRsp+xXCPfLoxNiw6y1E1
         hr3kkaez7e0JlhvYYuua9vk42o2KAvQDa6fL61xbhiyQuUgqjFZij55OrBWmPzKLQ9Fp
         QN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=orcS20HyQshMeJHSd+FSsboNdrlRdyJhtA2p2iopyKM=;
        b=vOVYCsz9crdYClnJg8cbU1GF+TNuNQNLzK/A97Ku9sTyXjoxCy+BJ8KlxZAWHMrCeg
         O3n99QtY80V7d2vIhQTnPlUwM7xJzIEEydi7lNaqTlyOqGO9JeLIVLAgq+ynMRQqN1vy
         V1mt0fzP+36HYMDDioY0heo1uqfiG8GVhdO1vDTH3DpsFJ+axZJjKGUNpqA0OXJVu28J
         0pBq2kXS1deN7rEQ7IF/QXKaO54kyEAaukmtI/rE7dRCzU366bXZ9PVBmzWDFnDuI1l0
         XG6Yfb2DF8Y0p79Vaj889xeSvjdXtr2XeOQr27RuejwtzNQdvZzqz+BBjddFdZ1td4kP
         pPkg==
X-Gm-Message-State: AOAM531imwVcGRXdklfzcpalVXN5nIoHq+h9zOdZX7h1UcHbXRXIJl2Y
        7dpS4KV1xJjJhIDoxgiNp1H7O0fA/O4=
X-Google-Smtp-Source: ABdhPJxxuddETzzoHZ82S8hl2/PAsw7nTJ3ywF4HLw/iqNMtyBpJ3wbx2PPSeRjWftW818sJ/7OX5Q==
X-Received: by 2002:a1c:3847:: with SMTP id f68mr6879643wma.152.1634826323393;
        Thu, 21 Oct 2021 07:25:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm6186113wrs.5.2021.10.21.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:23 -0700 (PDT)
Message-Id: <de6c72a9ce0ab09ea7b030852e2e894d6c6ec9b2.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:25:00 +0000
Subject: [PATCH v4 20/29] t/helper/fsmonitor-client: create IPC client to talk
 to FSMonitor Daemon
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

Create an IPC client to send query and flush commands to the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                         |   1 +
 t/helper/test-fsmonitor-client.c | 121 +++++++++++++++++++++++++++++++
 t/helper/test-tool.c             |   1 +
 t/helper/test-tool.h             |   1 +
 4 files changed, 124 insertions(+)
 create mode 100644 t/helper/test-fsmonitor-client.c

diff --git a/Makefile b/Makefile
index 8a26696c9ed..5ad0cef69f4 100644
--- a/Makefile
+++ b/Makefile
@@ -710,6 +710,7 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-fast-rebase.o
+TEST_BUILTINS_OBJS += test-fsmonitor-client.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
 TEST_BUILTINS_OBJS += test-getcwd.o
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
new file mode 100644
index 00000000000..f7a5b3a32fa
--- /dev/null
+++ b/t/helper/test-fsmonitor-client.c
@@ -0,0 +1,121 @@
+/*
+ * test-fsmonitor-client.c: client code to send commands/requests to
+ * a `git fsmonitor--daemon` daemon.
+ */
+
+#include "test-tool.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "fsmonitor-ipc.h"
+
+#ifndef HAVE_FSMONITOR_DAEMON_BACKEND
+int cmd__fsmonitor_client(int argc, const char **argv)
+{
+	die("fsmonitor--daemon not available on this platform");
+}
+#else
+
+/*
+ * Read the `.git/index` to get the last token written to the
+ * FSMonitor Index Extension.
+ */
+static const char *get_token_from_index(void)
+{
+	struct index_state *istate = the_repository->index;
+
+	if (do_read_index(istate, the_repository->index_file, 0) < 0)
+		die("unable to read index file");
+	if (!istate->fsmonitor_last_update)
+		die("index file does not have fsmonitor extension");
+
+	return istate->fsmonitor_last_update;
+}
+
+/*
+ * Send an IPC query to a `git-fsmonitor--daemon` daemon and
+ * ask for the changes since the given token or from the last
+ * token in the index extension.
+ *
+ * This will implicitly start a daemon process if necessary.  The
+ * daemon process will persist after we exit.
+ */
+static int do_send_query(const char *token)
+{
+	struct strbuf answer = STRBUF_INIT;
+	int ret;
+
+	if (!token || !*token)
+		token = get_token_from_index();
+
+	ret = fsmonitor_ipc__send_query(token, &answer);
+	if (ret < 0)
+		die(_("could not query fsmonitor--daemon"));
+
+	write_in_full(1, answer.buf, answer.len);
+	strbuf_release(&answer);
+
+	return 0;
+}
+
+/*
+ * Send a "flush" command to the `git-fsmonitor--daemon` (if running)
+ * and tell it to flush its cache.
+ *
+ * This feature is primarily used by the test suite to simulate a loss of
+ * sync with the filesystem where we miss kernel events.
+ */
+static int do_send_flush(void)
+{
+	struct strbuf answer = STRBUF_INIT;
+	int ret;
+
+	ret = fsmonitor_ipc__send_command("flush", &answer);
+	if (ret)
+		return ret;
+
+	write_in_full(1, answer.buf, answer.len);
+	strbuf_release(&answer);
+
+	return 0;
+}
+
+int cmd__fsmonitor_client(int argc, const char **argv)
+{
+	const char *subcmd;
+	const char *token = NULL;
+
+	const char * const fsmonitor_client_usage[] = {
+		N_("test-helper fsmonitor-client query [<token>]"),
+		N_("test-helper fsmonitor-client flush"),
+		NULL,
+	};
+
+	struct option options[] = {
+		OPT_STRING(0, "token", &token, N_("token"),
+			   N_("command token to send to the server")),
+		OPT_END()
+	};
+
+	if (argc < 2)
+		usage_with_options(fsmonitor_client_usage, options);
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(fsmonitor_client_usage, options);
+
+	subcmd = argv[1];
+	argv--;
+	argc++;
+
+	argc = parse_options(argc, argv, NULL, options, fsmonitor_client_usage, 0);
+
+	setup_git_directory();
+
+	if (!strcmp(subcmd, "query"))
+		return !!do_send_query(token);
+
+	if (!strcmp(subcmd, "flush"))
+		return !!do_send_flush();
+
+	die("Unhandled subcommand: '%s'", subcmd);
+}
+#endif
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 3ce5585e53a..39119844693 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -31,6 +31,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "example-decorate", cmd__example_decorate },
 	{ "fast-rebase", cmd__fast_rebase },
+	{ "fsmonitor-client", cmd__fsmonitor_client },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
 	{ "getcwd", cmd__getcwd },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 9f0f5228508..0f1074a32a6 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -21,6 +21,7 @@ int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__fast_rebase(int argc, const char **argv);
+int cmd__fsmonitor_client(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
 int cmd__getcwd(int argc, const char **argv);
-- 
gitgitgadget

