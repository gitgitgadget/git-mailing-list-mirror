Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81850C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351882AbiCXQwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351883AbiCXQwD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:52:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5CCAF1F3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so7574556wmb.4
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ekpkFZZsg/xn+/xY3K+YVOvurMdWK/1l1/dNkxZdexU=;
        b=puSI9dZDOtCOPMUfhrUDyF3XPePvkNgc5yRYyWYOzcOqHH5Yz+06ch4Tx0t4EvmxFW
         eVozDHaTESyeqY0dQaIpbw05hgOJdTINz8xDNa3Onfr4GCztPPRk94kU5njLPeW3OKbd
         ho3Fh85RaBKxJL1r7IzLHadac8gdF9F22BqcKKLR/y/wFvss+ucw2eqvwWx+uS7kqwFY
         IHueE9WCxXNOzrSRdNLncWpIstJUUQ6m3Q5Ylu7bE2er2S9zSPMUXyiCHyIH3chMvM5R
         dO2PgxIosFGQVdEO+vuXnJ85xnsuQ90jIDuI1kv7b0STpexvqzsNfyDgKpVx5ytZxk1e
         OVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ekpkFZZsg/xn+/xY3K+YVOvurMdWK/1l1/dNkxZdexU=;
        b=kSx/+mIxUgxonnzZNq1T4hoLKoOxxpjud4zvebEwCYABbt/9Ex2GrjKxsK0pJsgP82
         pFZPebolx3SZ/VsU1bJYGUcOln7yBOnf87G0Mz485jGYXNNYvtrx3iJE2R7VyMqJPTzc
         WiweJZCMgQ8qYMDqc+z9xtQWhaXml/OXUrm5+sa+Lw/ileq7PN7wwZ5dwbwfnlzqE6Fy
         RHRJiJlWfvBvRbyyNNMWVczXFs1jr24Fu22DmqWB8UApwiNK9z0yevLRB/JqFbT17s6U
         vmV6mj2PhMEosfzAjFBK0etjywn4Fxnb+xLm7qgW5fhso81j0heEKI6T5HHS/AzTOGXJ
         /LNg==
X-Gm-Message-State: AOAM532yTRQIYwy+Q1+v4VoIR6bw3V25Kwn22oEgKEvFhLw17E+HE2ln
        27Kg0bJamhEJ+jfsGZ6AIe74rvdb+5I=
X-Google-Smtp-Source: ABdhPJxKDwFTBgXizx3A52KZcsTVLtp8thL2T04PHPUIeZZ3LNEdR5IJYqfPOtGSTnq6c9I8Lgw7nQ==
X-Received: by 2002:a05:600c:358f:b0:38c:c046:caef with SMTP id p15-20020a05600c358f00b0038cc046caefmr10999530wmq.202.1648140614526;
        Thu, 24 Mar 2022 09:50:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c34d400b0038caf684679sm8983068wmq.0.2022.03.24.09.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:50:13 -0700 (PDT)
Message-Id: <c99bac29d4233a2957bf0cfa7f2470798ae495ce.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:36 +0000
Subject: [PATCH v8 20/30] t/helper/fsmonitor-client: create IPC client to talk
 to FSMonitor Daemon
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

Create an IPC client to send query and flush commands to the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                         |   1 +
 t/helper/test-fsmonitor-client.c | 116 +++++++++++++++++++++++++++++++
 t/helper/test-tool.c             |   1 +
 t/helper/test-tool.h             |   1 +
 4 files changed, 119 insertions(+)
 create mode 100644 t/helper/test-fsmonitor-client.c

diff --git a/Makefile b/Makefile
index 26567d4f772..daa21bed6c3 100644
--- a/Makefile
+++ b/Makefile
@@ -716,6 +716,7 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-fast-rebase.o
+TEST_BUILTINS_OBJS += test-fsmonitor-client.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
 TEST_BUILTINS_OBJS += test-getcwd.o
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
new file mode 100644
index 00000000000..3062c8a3c2b
--- /dev/null
+++ b/t/helper/test-fsmonitor-client.c
@@ -0,0 +1,116 @@
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
+		die("could not query fsmonitor--daemon");
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
+		"test-tool fsmonitor-client query [<token>]",
+		"test-tool fsmonitor-client flush",
+		NULL,
+	};
+
+	struct option options[] = {
+		OPT_STRING(0, "token", &token, "token",
+			   "command token to send to the server"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options, fsmonitor_client_usage, 0);
+
+	if (argc != 1)
+		usage_with_options(fsmonitor_client_usage, options);
+
+	subcmd = argv[0];
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
index e6ec69cf326..0424f7adf5d 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -32,6 +32,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "example-decorate", cmd__example_decorate },
 	{ "fast-rebase", cmd__fast_rebase },
+	{ "fsmonitor-client", cmd__fsmonitor_client },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
 	{ "getcwd", cmd__getcwd },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 20756eefdda..c876e8246fb 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -23,6 +23,7 @@ int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__dump_reftable(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__fast_rebase(int argc, const char **argv);
+int cmd__fsmonitor_client(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
 int cmd__getcwd(int argc, const char **argv);
-- 
gitgitgadget

