Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43D9C2D0DB
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB122073B
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzc6RJKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfLYL5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:57:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42186 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfLYL5H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 06:57:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id e10so19769534edv.9
        for <git@vger.kernel.org>; Wed, 25 Dec 2019 03:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pd7gm9sA8KWwnCXzcqZeBD0/pHyKhrgKove5Fa6H3tg=;
        b=bzc6RJKdS6rfo1XyAm08Id5e8cwQGOSTbdPfKkHA9Sue/8LV3HNzicsaOUNEDNtBsF
         jmjwcJlDIz2ZAGvzkfFMLbQtBFdaCTzjkw++JUTvibZqaNdt3j6s85a6k/WITzvFof2K
         pOK6VoHOTHxdLHgWzDP2hFzYj/FCBhzLYCgzPcfQULeO8w/4SD5dbOLWyjo7LDwEo4hV
         Zkxi3aEZ9C0FyFycYbtsPwSPK9/nJPVdKyZop+c4IK7X0uLC4ztdn6XbAcOv4ZogAGbJ
         /OXW1GYADXbuDJ/Qlq91i41fT0a4ZYtyD+ocEoIkBUizBT9KX/hD53qCg1pZA9MEO1d+
         bztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pd7gm9sA8KWwnCXzcqZeBD0/pHyKhrgKove5Fa6H3tg=;
        b=Aqyo1wLQ57okWJuWAIXGd7p8nlEk5s5htymJRSOZv/Ynpd116DStO2R8sjFPsXHDgO
         Vj1c6VVNJ1ipExApQvHK+zunbCLvXhPJSY3XebTPihpsPYY6rSiGQjJfSpq3AYWm2jAp
         HGjfhAmQfNpmEnAJexAqcpiNOsVSvGvRaPwl2/jgr9Vlrj1stkVBCbum18GFHSlSk2Yp
         rqt8oRfjIYkkPF37kld2lmq09szk8aX66Dmb3kwEa6V4AfjBWA/FT5poRifzDBPRpl4i
         SQt32luIEfOBXMuMpVxNyFi/mRhEwUbcECM+ZO8X4vI11JOypX1hyWTOSkRwyoKDy8LT
         W48g==
X-Gm-Message-State: APjAAAUFOeJomyW5I5N9evSnnYQIBseXHp7HGwQ/KlGN2CEa1bu4UhgE
        lfHXPdW35YWu/U5aWiAqwTe2C16Z
X-Google-Smtp-Source: APXvYqz6AVH+TfxQbbRbbykF+vkh/40WQMOLQJP/au+HLMc9dlCsv3DTNRdl4KZR/S6gs5wDIpB/TQ==
X-Received: by 2002:a17:906:2e46:: with SMTP id r6mr42717320eji.310.1577275025023;
        Wed, 25 Dec 2019 03:57:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d19sm2413156ejd.21.2019.12.25.03.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 03:57:04 -0800 (PST)
Message-Id: <bd2306c5d55986ad991f7a84982f84609f848842.1577275020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
        <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Dec 2019 11:56:55 +0000
Subject: [PATCH v2 4/9] terminal: accommodate Git for Windows' default
 terminal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows' Git Bash runs in MinTTY by default, which does not have
a Win32 Console instance, but uses MSYS2 pseudo terminals instead.

This is a problem, as Git for Windows does not want to use the MSYS2
emulation layer for Git itself, and therefore has no direct way to
interact with that pseudo terminal.

As a workaround, use the `stty` utility (which is included in Git for
Windows, and which *is* an MSYS2 program, so it knows how to deal with
the pseudo terminal).

Note: If Git runs in a regular CMD or PowerShell window, there *is* a
regular Win32 Console to work with. This is not a problem for the MSYS2
`stty`: it copes with this scenario just fine.

Also note that we introduce support for more bits than would be
necessary for a mere `disable_echo()` here, in preparation for the
upcoming `enable_non_canonical()` function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/terminal.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/compat/terminal.c b/compat/terminal.c
index 1fb40b3a0a..16e9949da1 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -2,6 +2,8 @@
 #include "compat/terminal.h"
 #include "sigchain.h"
 #include "strbuf.h"
+#include "run-command.h"
+#include "string-list.h"
 
 #if defined(HAVE_DEV_TTY) || defined(GIT_WINDOWS_NATIVE)
 
@@ -64,11 +66,28 @@ static int disable_echo(void)
 #define OUTPUT_PATH "CONOUT$"
 #define FORCE_TEXT "t"
 
+static int use_stty = 1;
+static struct string_list stty_restore = STRING_LIST_INIT_DUP;
 static HANDLE hconin = INVALID_HANDLE_VALUE;
 static DWORD cmode;
 
 static void restore_term(void)
 {
+	if (use_stty) {
+		int i;
+		struct child_process cp = CHILD_PROCESS_INIT;
+
+		if (stty_restore.nr == 0)
+			return;
+
+		argv_array_push(&cp.args, "stty");
+		for (i = 0; i < stty_restore.nr; i++)
+			argv_array_push(&cp.args, stty_restore.items[i].string);
+		run_command(&cp);
+		string_list_clear(&stty_restore, 0);
+		return;
+	}
+
 	if (hconin == INVALID_HANDLE_VALUE)
 		return;
 
@@ -79,6 +98,37 @@ static void restore_term(void)
 
 static int disable_bits(DWORD bits)
 {
+	if (use_stty) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+
+		argv_array_push(&cp.args, "stty");
+
+		if (bits & ENABLE_LINE_INPUT) {
+			string_list_append(&stty_restore, "icanon");
+			argv_array_push(&cp.args, "-icanon");
+		}
+
+		if (bits & ENABLE_ECHO_INPUT) {
+			string_list_append(&stty_restore, "echo");
+			argv_array_push(&cp.args, "-echo");
+		}
+
+		if (bits & ENABLE_PROCESSED_INPUT) {
+			string_list_append(&stty_restore, "-ignbrk");
+			string_list_append(&stty_restore, "intr");
+			string_list_append(&stty_restore, "^c");
+			argv_array_push(&cp.args, "ignbrk");
+			argv_array_push(&cp.args, "intr");
+			argv_array_push(&cp.args, "");
+		}
+
+		if (run_command(&cp) == 0)
+			return 0;
+
+		/* `stty` could not be executed; access the Console directly */
+		use_stty = 0;
+	}
+
 	hconin = CreateFile("CONIN$", GENERIC_READ | GENERIC_WRITE,
 	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
 	    FILE_ATTRIBUTE_NORMAL, NULL);
-- 
gitgitgadget

