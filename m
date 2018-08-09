Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983DE1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 17:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbeHIUBY (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 16:01:24 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39027 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbeHIUBY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 16:01:24 -0400
Received: by mail-pl0-f66.google.com with SMTP id w14-v6so2842273plp.6
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 10:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kRY6JxbE2faH2xffin3//J4SOU/zVDqISjGiJESOFko=;
        b=I+uVHDV8vSynQhw5sSCjE9xdVu9mrK5sp6GRDB9WfInWGxBsJVsA2SFIdHtnEcYK1s
         I+tiusyaW+RHsihMl3WKIYCcw+fWY4WO4tL7/YG4GI5jEKGhHnUA80401Ys7673FhH//
         2476x/QnFgaWcdH7CX1tLDGIpnQujpJlv+qy0PWUj4w3hsmP//5/cjOjfBl1wNMCmzg+
         3hpSvSBcZOurPTdzKRbcy3yxrQaDuY95LbwdU59s/cCPxOGKCgWJbjv484XPJSVTd62R
         YvQVP1cLUOmPBSlInKBbWe0hAFwe5vcwmUNy/yPm3YlAKowfRi5oHRAlqD9X1aMtKiOy
         U4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kRY6JxbE2faH2xffin3//J4SOU/zVDqISjGiJESOFko=;
        b=dlTIFnWD1Crhouik2cZM7qq0NJpA8o9TIxtJjBN3SV4fuQuwjUehIIm6rji7+0Qc6h
         FRuZobJiCNC8kdCeBQTDjs70o4LRfK7mip62HFeu+zEojypEUCoPf8/jFe0xToBifqby
         sEYjmTW3QeES+PHSizxmggDHp++EJflkJ/g4u9JxU73y/3dJniNZRZFfpoa51gS3nRrS
         wqX1DQf/5DD3wEyG3osEGcIztYg3o4MHo3BDfBHwcMHDGPYbIM3C1Hs/zmJLR+efyhKN
         Z9SeHiUCaKK2+FQU610PT3K4mB7CcB4axQYBG+YZCLlnfXNIo5JxiWfoykitO6cf7RSu
         HMnA==
X-Gm-Message-State: AOUpUlGhPpR+mvS81alu3EMkTzWMxbfu3cWxVMmXSW1r8vJiVSNanoA0
        xaDUv9LacFHzd58wfo07MCCBnvIZ
X-Google-Smtp-Source: AA+uWPyd0PPMHoLPhzR6MT9KwCmIJWPSyCFLyVb0lUeWyc7muj+PSdXpGgsaACiwxyekpv1sAU245A==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8-v6mr2068894plo.308.1533836130945;
        Thu, 09 Aug 2018 10:35:30 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id f75-v6sm28515670pfk.85.2018.08.09.10.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:35:30 -0700 (PDT)
Date:   Thu, 09 Aug 2018 10:35:30 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Aug 2018 17:35:21 GMT
Message-Id: <f57234154fb29d0b169442c44e4e683fe1cc3e6c.1533836122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.17.git.gitgitgadget@gmail.com>
References: <pull.17.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/4] trace: verify that locking works
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Recently, t5552 introduced a pattern where two processes try to write to
the same GIT_TRACE file in parallel. This is not safe, as the two
processes fighting over who gets to append to the file can cause garbled
lines and may even result in data loss on Windows (where buffers are
written to before they are flushed).

To remedy this, we introduced the lock_or_unlock_fd_for_appending()
function. And to make sure that this works, this commit introduces a
regression test.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile               |   1 +
 t/helper/test-tool.c   |   1 +
 t/helper/test-tool.h   |   1 +
 t/helper/test-trace.c  | 130 +++++++++++++++++++++++++++++++++++++++++
 t/t0070-fundamental.sh |   6 ++
 5 files changed, 139 insertions(+)
 create mode 100644 t/helper/test-trace.c

diff --git a/Makefile b/Makefile
index 617475622..2e3fb5b8d 100644
--- a/Makefile
+++ b/Makefile
@@ -729,6 +729,7 @@ TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
+TEST_BUILTINS_OBJS += test-trace.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-write-cache.o
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 805a45de9..7adce872b 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -39,6 +39,7 @@ static struct test_cmd cmds[] = {
 	{ "string-list", cmd__string_list },
 	{ "submodule-config", cmd__submodule_config },
 	{ "subprocess", cmd__subprocess },
+	{ "trace", cmd__trace },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
 	{ "wildmatch", cmd__wildmatch },
 	{ "write-cache", cmd__write_cache },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7116ddfb9..c462ac924 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -33,6 +33,7 @@ int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
+int cmd__trace(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
 int cmd__wildmatch(int argc, const char **argv);
 int cmd__write_cache(int argc, const char **argv);
diff --git a/t/helper/test-trace.c b/t/helper/test-trace.c
new file mode 100644
index 000000000..1cc88b030
--- /dev/null
+++ b/t/helper/test-trace.c
@@ -0,0 +1,130 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "run-command.h"
+
+static struct child_process children[2] = {
+	CHILD_PROCESS_INIT,
+	CHILD_PROCESS_INIT,
+};
+
+#define SAY(child, what) \
+	if (write_in_full(children[child].in, \
+			  what "\n", strlen(what) + 1) < 0) \
+		die("Failed to tell child process #%d to %s", child, what)
+
+#define LISTEN(child, what) \
+	if (strbuf_getwholeline_fd(&buf, children[child].out, '\n') < 0) \
+		die("Child process #%d failed to acknowledge %s", child, what)
+
+#define ACK(what) \
+	if (write_in_full(1, what ": ACK\n", strlen(what) + 6) < 0) \
+		die_errno("'%s': %s ACK", child_name, what)
+
+static void contention_orchestrator(const char *argv0)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int i;
+
+	/* Spawn two children and simulate write contention */
+	trace_printf("start");
+
+	for (i = 0; i < 2; i++) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "child #%d", i);
+		argv_array_pushl(&children[i].args,
+					argv0, "trace", "lock", buf.buf, NULL);
+		children[i].in = children[i].out = -1;
+		if (start_command(&children[i]) < 0)
+			die("Could not spawn child process #%d", i);
+	}
+
+	SAY(1, "lock");
+	LISTEN(1, "lock");
+
+	SAY(0, "trace delayed");
+	SAY(1, "trace while-locked");
+	LISTEN(1, "trace");
+
+	SAY(1, "unlock");
+	LISTEN(1, "unlock");
+	LISTEN(0, "trace");
+
+	SAY(0, "quit");
+	SAY(1, "quit");
+
+	if (finish_command(&children[0]) < 0 ||
+		finish_command(&children[1]) < 0)
+		die("Child process failed to finish");
+
+	strbuf_release(&buf);
+}
+
+static void child(const char *child_name)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int fd, locked = 0;
+	const char *p;
+
+	/* This is the child process */
+	trace_printf("child start: '%s'", child_name);
+	fd = trace_default_key.fd;
+	if (fd <= 0)
+		die("child process: not tracing...");
+	while (!strbuf_getwholeline_fd(&buf, 0, '\n')) {
+		strbuf_rtrim(&buf);
+		if (!strcmp("lock", buf.buf)) {
+			if (lock_or_unlock_fd_for_appending(fd, 1) < 0 &&
+			    errno != EBADF)
+				die_errno("'%s': lock", child_name);
+			ACK("lock");
+			locked = 1;
+		} else if (!strcmp("unlock", buf.buf)) {
+			if (lock_or_unlock_fd_for_appending(fd, 0) < 0 &&
+			    errno != EBADF)
+				die_errno("'%s': unlock", child_name);
+			ACK("unlock");
+			locked = 0;
+		} else if (skip_prefix(buf.buf, "trace ", &p)) {
+			if (!locked)
+				trace_printf("%s: %s", child_name, p);
+			else {
+				char *p2 = xstrdup(p);
+
+				/* Give the racy process a run for its money. */
+				sleep_millisec(50);
+
+				strbuf_reset(&buf);
+				strbuf_addf(&buf, "%s: %s\n",
+					    child_name, p2);
+				free(p2);
+
+				if (write_in_full(fd, buf.buf, buf.len) < 0)
+					die_errno("'%s': trace", child_name);
+			}
+			ACK("trace");
+		} else if (!strcmp("quit", buf.buf)) {
+			close(0);
+			close(1);
+			break;
+		} else
+			die("Unhandled command: '%s'", buf.buf);
+
+	}
+
+	strbuf_release(&buf);
+}
+
+int cmd__trace(int argc, const char **argv)
+{
+	const char *argv0 = argv[-1];
+
+	if (argc > 1 && !strcmp("lock", argv[1])) {
+		if (argc > 2)
+			child(argv[2]);
+		else
+			contention_orchestrator(argv0);
+	} else
+		die("Usage: %s %s lock [<child-name>]", argv0, argv[0]);
+
+	return 0;
+}
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 23fbe6434..57f7a1246 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -34,4 +34,10 @@ test_expect_success 'check for a bug in the regex routines' '
 	test-tool regex --bug
 '
 
+test_expect_success 'multiple processes can GIT_TRACE to the same file' '
+	GIT_TRACE="$(pwd)/trace" test-tool trace lock &&
+	sed -n "/while-locked/,\$s/.*delayed$/YES/p" <trace >actual &&
+	test YES = "$(cat actual)"
+'
+
 test_done
-- 
gitgitgadget
