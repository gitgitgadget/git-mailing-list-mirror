Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6E2C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2542F603E9
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbhJGNy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241611AbhJGNyu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 09:54:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0E7C061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 06:52:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m22so19466308wrb.0
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LDTU64WFptNk/iCaHfjIEBqLqjrKE0oTr84qceM5FAQ=;
        b=i2sXEosPvhrlwhwwNm1OuCO2Ob5sSOlGgz6ERCet1gPr2veAipmVu9IzYYHBdvc6PQ
         gjlj3Ecc2SAjZf6wl4EHB7ex+tQyfN0qQG3FawXb5fFIbslEJirJ/efQtc6/23td81Es
         C5WzS3Qbfj24pbN8TAjDEylMYhH4WvgH22Xwq0tLPddUmZTFSqcsChOLVXaXJPk0nf6e
         WIqtGaKee/KFe++t/cYCu58+M/18J3PCfKYmsT1vcd/FSJmhzdBt6hqkrFjteJGK4IwD
         avk1VfSoOuTzFHeCDUgH4QbCwQdXd+YSXpshStjnKAxi+vuWaIwmrUSWvqPGsWMyu9uI
         9zNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LDTU64WFptNk/iCaHfjIEBqLqjrKE0oTr84qceM5FAQ=;
        b=6zgT2Nig6ni7yba3oOY4Vxu1B5bGpTN/eerHMRodlAd+35E24aDAnNUyFD45bM/18g
         +cLZavk+WO0pdxsxlHU+0ArLELVdJFviqNrLuUrnl8bW+F74Kn6ueODnm2NkYZWaj7Ot
         I1bch1D09vzmmeWq2J+R6TR2hPFTEnEYc9xpITGjda/A3srxeO2Upzwx+QuIoG5vYdFG
         GSnqs3xXlgE5VvlwKGsicG1gGKfZsRQijbwJJJLW9hIZngU4CyE6hom2BuvsD+OBiFFf
         6PH/qJ6P8b7UB2sM/GskmXCOWoOs8hHXuf4bn2BORdmY437s7o4/bmTjoym/vuG8Pwn8
         YlaA==
X-Gm-Message-State: AOAM533grfa3YN28unbMIJ9d8f8xRPyGSlTYEWTt2femIW57yoJ0DdFZ
        PmLSSQWqKMrOho5urJO0LHEdfOH3i2I=
X-Google-Smtp-Source: ABdhPJwE859JpV6EEYKqXXAwZSblnq0fJpD1XCDvoREIAtUx5W4168/ibUa7yeLy1YzyD2Nckonzew==
X-Received: by 2002:a05:6000:18a2:: with SMTP id b2mr5648481wri.155.1633614775553;
        Thu, 07 Oct 2021 06:52:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm24737050wrt.67.2021.10.07.06.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 06:52:55 -0700 (PDT)
Message-Id: <df81a63aceec1b27efce7d7646afe9b0a48b8e59.1633614772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
        <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 13:52:49 +0000
Subject: [PATCH v2 2/5] fsmonitor-ipc: create client routines for
 git-fsmonitor--daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create fsmonitor_ipc__*() client routines to spawn the built-in file
system monitor daemon and send it an IPC request using the `Simple
IPC` API.

Stub in empty fsmonitor_ipc__*() functions for unsupported platforms.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile        |   1 +
 fsmonitor-ipc.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++
 fsmonitor-ipc.h |  48 +++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h

diff --git a/Makefile b/Makefile
index 381bed2c1d2..d51fd8b33ce 100644
--- a/Makefile
+++ b/Makefile
@@ -897,6 +897,7 @@ LIB_OBJS += fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
+LIB_OBJS += fsmonitor-ipc.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
new file mode 100644
index 00000000000..ccc32d2a17e
--- /dev/null
+++ b/fsmonitor-ipc.c
@@ -0,0 +1,176 @@
+#include "cache.h"
+#include "fsmonitor.h"
+#include "simple-ipc.h"
+#include "fsmonitor-ipc.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "trace2.h"
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+
+int fsmonitor_ipc__is_supported(void)
+{
+	return 1;
+}
+
+GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
+
+enum ipc_active_state fsmonitor_ipc__get_state(void)
+{
+	return ipc_get_active_state(fsmonitor_ipc__get_path());
+}
+
+static int spawn_daemon(void)
+{
+	const char *args[] = { "fsmonitor--daemon", "start", NULL };
+
+	return run_command_v_opt_tr2(args, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
+				    "fsmonitor");
+}
+
+int fsmonitor_ipc__send_query(const char *since_token,
+			      struct strbuf *answer)
+{
+	int ret = -1;
+	int tried_to_spawn = 0;
+	enum ipc_active_state state = IPC_STATE__OTHER_ERROR;
+	struct ipc_client_connection *connection = NULL;
+	struct ipc_client_connect_options options
+		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
+	const char *tok = since_token ? since_token : "";
+	size_t tok_len = since_token ? strlen(since_token) : 0;
+
+	options.wait_if_busy = 1;
+	options.wait_if_not_found = 0;
+
+	trace2_region_enter("fsm_client", "query", NULL);
+	trace2_data_string("fsm_client", NULL, "query/command", tok);
+
+try_again:
+	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
+				       &connection);
+
+	switch (state) {
+	case IPC_STATE__LISTENING:
+		ret = ipc_client_send_command_to_connection(
+			connection, tok, tok_len, answer);
+		ipc_client_close_connection(connection);
+
+		trace2_data_intmax("fsm_client", NULL,
+				   "query/response-length", answer->len);
+
+		if (fsmonitor_is_trivial_response(answer))
+			trace2_data_intmax("fsm_client", NULL,
+					   "query/trivial-response", 1);
+
+		goto done;
+
+	case IPC_STATE__NOT_LISTENING:
+	case IPC_STATE__PATH_NOT_FOUND:
+		if (tried_to_spawn)
+			goto done;
+
+		tried_to_spawn++;
+		if (spawn_daemon())
+			goto done;
+
+		/*
+		 * Try again, but this time give the daemon a chance to
+		 * actually create the pipe/socket.
+		 *
+		 * Granted, the daemon just started so it can't possibly have
+		 * any FS cached yet, so we'll always get a trivial answer.
+		 * BUT the answer should include a new token that can serve
+		 * as the basis for subsequent requests.
+		 */
+		options.wait_if_not_found = 1;
+		goto try_again;
+
+	case IPC_STATE__INVALID_PATH:
+		ret = error(_("fsmonitor_ipc__send_query: invalid path '%s'"),
+			    fsmonitor_ipc__get_path());
+		goto done;
+
+	case IPC_STATE__OTHER_ERROR:
+	default:
+		ret = error(_("fsmonitor_ipc__send_query: unspecified error on '%s'"),
+			    fsmonitor_ipc__get_path());
+		goto done;
+	}
+
+done:
+	trace2_region_leave("fsm_client", "query", NULL);
+
+	return ret;
+}
+
+int fsmonitor_ipc__send_command(const char *command,
+				struct strbuf *answer)
+{
+	struct ipc_client_connection *connection = NULL;
+	struct ipc_client_connect_options options
+		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
+	int ret;
+	enum ipc_active_state state;
+	const char *c = command ? command : "";
+	size_t c_len = command ? strlen(command) : 0;
+
+	strbuf_reset(answer);
+
+	options.wait_if_busy = 1;
+	options.wait_if_not_found = 0;
+
+	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
+				       &connection);
+	if (state != IPC_STATE__LISTENING) {
+		die("fsmonitor--daemon is not running");
+		return -1;
+	}
+
+	ret = ipc_client_send_command_to_connection(connection, c, c_len,
+						    answer);
+	ipc_client_close_connection(connection);
+
+	if (ret == -1) {
+		die("could not send '%s' command to fsmonitor--daemon", c);
+		return -1;
+	}
+
+	return 0;
+}
+
+#else
+
+/*
+ * A trivial implementation of the fsmonitor_ipc__ API for unsupported
+ * platforms.
+ */
+
+int fsmonitor_ipc__is_supported(void)
+{
+	return 0;
+}
+
+const char *fsmonitor_ipc__get_path(void)
+{
+	return NULL;
+}
+
+enum ipc_active_state fsmonitor_ipc__get_state(void)
+{
+	return IPC_STATE__OTHER_ERROR;
+}
+
+int fsmonitor_ipc__send_query(const char *since_token,
+			      struct strbuf *answer)
+{
+	return -1;
+}
+
+int fsmonitor_ipc__send_command(const char *command,
+				struct strbuf *answer)
+{
+	return -1;
+}
+
+#endif
diff --git a/fsmonitor-ipc.h b/fsmonitor-ipc.h
new file mode 100644
index 00000000000..b6a7067c3af
--- /dev/null
+++ b/fsmonitor-ipc.h
@@ -0,0 +1,48 @@
+#ifndef FSMONITOR_IPC_H
+#define FSMONITOR_IPC_H
+
+#include "simple-ipc.h"
+
+/*
+ * Returns true if built-in file system monitor daemon is defined
+ * for this platform.
+ */
+int fsmonitor_ipc__is_supported(void);
+
+/*
+ * Returns the pathname to the IPC named pipe or Unix domain socket
+ * where a `git-fsmonitor--daemon` process will listen.  This is a
+ * per-worktree value.
+ *
+ * Returns NULL if the daemon is not supported on this platform.
+ */
+const char *fsmonitor_ipc__get_path(void);
+
+/*
+ * Try to determine whether there is a `git-fsmonitor--daemon` process
+ * listening on the IPC pipe/socket.
+ */
+enum ipc_active_state fsmonitor_ipc__get_state(void);
+
+/*
+ * Connect to a `git-fsmonitor--daemon` process via simple-ipc
+ * and ask for the set of changed files since the given token.
+ *
+ * Spawn a daemon process in the background if necessary.
+ *
+ * Returns -1 on error; 0 on success.
+ */
+int fsmonitor_ipc__send_query(const char *since_token,
+			      struct strbuf *answer);
+
+/*
+ * Connect to a `git-fsmonitor--daemon` process via simple-ipc and
+ * send a command verb.  If no daemon is available, we DO NOT try to
+ * start one.
+ *
+ * Returns -1 on error; 0 on success.
+ */
+int fsmonitor_ipc__send_command(const char *command,
+				struct strbuf *answer);
+
+#endif /* FSMONITOR_IPC_H */
-- 
gitgitgadget

