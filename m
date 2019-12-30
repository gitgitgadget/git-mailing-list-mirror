Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F7DC2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EA9206CB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exLHT3y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfL3TPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:15:36 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39027 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfL3TPe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 14:15:34 -0500
Received: by mail-ed1-f67.google.com with SMTP id t17so33601552eds.6
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 11:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ysy3N6u/y+85fvme0+TujrduOxksAAE+q8sl7qDmi2M=;
        b=exLHT3y5EDoa2Ns/QeAzxqXNB9HRbHFW9yepgdvqFt5XK6j8RZbExh/IfU0vRPWhtn
         H5GWAmQjFHOdRQaFkNjvbr20oAHSurDoVW9pU/GuKAwx3UgiwYnHBW4SVUzrMZtqjZ+3
         pxITJHX/ZYgXh/GUWog3MtuzcDlRx/FW+B1lgokPjhf8Z6rUtXnDpAu1h/Qcj8+rV0WH
         hGp+V4jTE0voKW4EbkP/sySSrs+5mDAhTf03xXfGx9VmzOMtC1SOjQokEDLhop0thBJe
         gzPEopyKr6BxpE/sDcZg/uLwVpKINCLBrv4BBTWcl5LoCmG5/LgIlfESYeSBBqP9V7vf
         f5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ysy3N6u/y+85fvme0+TujrduOxksAAE+q8sl7qDmi2M=;
        b=SLJ0h68i5nVo0/Kf3EIyrY6CVdiGlRQBjFxrB0gWfpQZGRfQe1OyqDYXu9sn5fy87M
         l72EgRqo83e1VAaKU8ZG5petfdEbE7HinEXIBkbYAuwqZ7NMILi7RU5ysjLrf6hCdrAQ
         sqA0CB5FdRa7Mu5h8p8MPjANFz+c7HmHOMeoQxzOcOZahtDPDpXMR3U+PbNF09xDVjts
         N7o3a5sWGoyo77F1smqUyekES0kTfgjzbvDGE7qDYMkRgMa/kig4WyhrQ9Qxz2YfeBxl
         NcU2wJ8A9M37DkmccBlu9Be7VnX1tNhWGL4aadhRTvXVefWUv4B+QZz8WIeMHvCrNNUN
         zBMA==
X-Gm-Message-State: APjAAAUXnd+Mxw48zg/KHLhLT1nFCx6V4KuZ5yb1VXMRtjfu42MYtZEJ
        1azN6KJzIPJun3nCdVlLrKnJqJpo
X-Google-Smtp-Source: APXvYqxCgj+70VWu4vn7nJIG3z2jFnRDvgM+fxxuXQF3ZqMcDZxckmL69o0LSXZ0yO1CXqoJfgUDFw==
X-Received: by 2002:a05:6402:1558:: with SMTP id p24mr72968222edx.120.1577733332281;
        Mon, 30 Dec 2019 11:15:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h61sm5418963edd.49.2019.12.30.11.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 11:15:31 -0800 (PST)
Message-Id: <ab449ac15a4fe792253430c7731a0707de51edeb.1577733329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.503.v2.git.1577733329.gitgitgadget@gmail.com>
References: <pull.503.git.1577727747.gitgitgadget@gmail.com>
        <pull.503.v2.git.1577733329.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 19:15:27 +0000
Subject: [PATCH v2 2/3] t: directly test parse_pathspec_file()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Previously, `parse_pathspec_file()` was tested indirectly by invoking
git commands with properly crafted inputs. As demonstrated by the
previous bugfix, testing complicated black boxes indirectly can lead to
tests that silently test the wrong thing.

Introduce direct tests for `parse_pathspec_file()`.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Makefile                            |   1 +
 t/helper/test-parse-pathspec-file.c |  33 +++++++++
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/t0067-parse_pathspec_file.sh      | 104 ++++++++++++++++++++++++++++
 5 files changed, 140 insertions(+)
 create mode 100644 t/helper/test-parse-pathspec-file.c
 create mode 100755 t/t0067-parse_pathspec_file.sh

diff --git a/Makefile b/Makefile
index 09f98b777c..0061f96e8a 100644
--- a/Makefile
+++ b/Makefile
@@ -721,6 +721,7 @@ TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-oidmap.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-parse-options.o
+TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
diff --git a/t/helper/test-parse-pathspec-file.c b/t/helper/test-parse-pathspec-file.c
new file mode 100644
index 0000000000..02f4ccfd2a
--- /dev/null
+++ b/t/helper/test-parse-pathspec-file.c
@@ -0,0 +1,33 @@
+#include "test-tool.h"
+#include "parse-options.h"
+#include "pathspec.h"
+#include "gettext.h"
+
+int cmd__parse_pathspec_file(int argc, const char **argv)
+{
+	struct pathspec pathspec;
+	const char *pathspec_from_file = 0;
+	int pathspec_file_nul = 0, i;
+
+	static const char *const usage[] = {
+		"test-tool parse-pathspec-file --pathspec-from-file [--pathspec-file-nul]",
+		NULL
+	};
+
+	struct option options[] = {
+		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
+		OPT_END()
+	};
+
+	parse_options(argc, argv, 0, options, usage, 0);
+
+	parse_pathspec_file(&pathspec, 0, 0, 0, pathspec_from_file,
+			    pathspec_file_nul);
+
+	for (i = 0; i < pathspec.nr; i++)
+		printf("%s\n", pathspec.items[i].original);
+
+	clear_pathspec(&pathspec);
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f20989d449..c9a232d238 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -39,6 +39,7 @@ static struct test_cmd cmds[] = {
 	{ "oidmap", cmd__oidmap },
 	{ "online-cpus", cmd__online_cpus },
 	{ "parse-options", cmd__parse_options },
+	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "path-utils", cmd__path_utils },
 	{ "pkt-line", cmd__pkt_line },
 	{ "prio-queue", cmd__prio_queue },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 8ed2af71d1..c8549fd87f 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -29,6 +29,7 @@ int cmd__mktemp(int argc, const char **argv);
 int cmd__oidmap(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
+int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
diff --git a/t/t0067-parse_pathspec_file.sh b/t/t0067-parse_pathspec_file.sh
new file mode 100755
index 0000000000..77b44f6702
--- /dev/null
+++ b/t/t0067-parse_pathspec_file.sh
@@ -0,0 +1,104 @@
+#!/bin/sh
+
+test_description='Test parse_pathspec_file()'
+
+. ./test-lib.sh
+
+test_expect_success 'one item from stdin' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	EOF
+
+	echo fileA.t |
+	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'one item from file' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	EOF
+
+	echo fileA.t >list &&
+	test-tool parse-pathspec-file --pathspec-from-file=list >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'NUL delimiters' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	fileB.t
+	EOF
+
+	printf "fileA.t\0fileB.t\0" |
+	test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'LF delimiters' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	fileB.t
+	EOF
+
+	printf "fileA.t\nfileB.t\n" |
+	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'no trailing delimiter' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	fileB.t
+	EOF
+
+	printf "fileA.t\nfileB.t" |
+	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'CRLF delimiters' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	fileB.t
+	EOF
+
+	printf "fileA.t\r\nfileB.t\r\n" |
+	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'quotes' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	EOF
+
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
+	# git    takes    \101 and spits     A
+	printf "\"file\\\\101.t\"" |
+	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success '--pathspec-file-nul takes quotes literally' '
+	cat >expect <<-\EOF &&
+	"file\101.t"
+	EOF
+
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
+	printf "\"file\\\\101.t\"" |
+	test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&
+
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget

