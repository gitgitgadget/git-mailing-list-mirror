Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E18C33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1282187F
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ohiil9Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgAMI3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:29:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46193 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgAMI3h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 03:29:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so7517942wrl.13
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 00:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pd7gm9sA8KWwnCXzcqZeBD0/pHyKhrgKove5Fa6H3tg=;
        b=Ohiil9RojRbraFNSJlv4OBUHQLV7lTdYs+qiHaEjlxBavzwpMWNCd67y7qjd9KDt05
         cRGhhg9Jb5U8JZLGJ7P6gXw3/oIngn1ZBoqrUy1mZhFnzP0iwLSVrhRFScjex2PlL53i
         4iQnkMl1Bfeqw+vk/6bYvK6YIm9F+VGt7k4ojq4EeEjj30LlNh9j3wLqQt9sKy7xkH3T
         3iiAvwzAGcwMnfiYDU5u0mQI21KG+3AgK941U4eiwQSrRgx+lVXHvnuqv8hkMP+qAtYc
         7yxqyBOJ5nxlaQCa61aMJ/O+bpuclmpOM0im5XvnQYEjRuUgaO3xtsNcR7gD0y/cyNrY
         IuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pd7gm9sA8KWwnCXzcqZeBD0/pHyKhrgKove5Fa6H3tg=;
        b=MFWtt2v4bzkVo5g9clYwsUeubyHDSsDocKTLbeO7i1VZKc+vST1VBMCUCOfIdm8aR+
         hkyOLoZf7gNrxZLCZEoflKuz499VFSyRMCUrCr0OMge1euW5M/yR+a/vTLs77xwBv04k
         eA5XoJ+qYzx4MhnlaOJGXhyT+2WP+hlQiZRE7mAgK7g1WOYoi2doL51milFPb8Iy38Ep
         fZkPWZCwRgdqB946YmbjnoHR/ZbzYXs681+inSi7K7xZHIJcHWkKclZHfdb/+/09WIjD
         T/KWrobWKI4eYCK5Snw9DhKqchB/2xzeHNOCVF3cLFRAGu7k4bhqqmDQ/O0O/MD4ncDx
         gIcw==
X-Gm-Message-State: APjAAAWXyhlYW6NfMYSzApo4fh+FqzrtjRaoCo59M1g3xOE9udfK6MIP
        iqt+cEvQcz202geVR/Ct332cI7SZ
X-Google-Smtp-Source: APXvYqzveV+Ek+FganPupfUmZxuYkIJ7P7Z0saX/s39CcHb/XqlY58LU1hjOPm4zImgBx+pR3qM9aQ==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr16523783wro.375.1578904176272;
        Mon, 13 Jan 2020 00:29:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm13494753wme.30.2020.01.13.00.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:29:35 -0800 (PST)
Message-Id: <233f23791caaca5dee6b227520560f53977c8ea7.1578904171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
        <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jan 2020 08:29:26 +0000
Subject: [PATCH v3 05/10] terminal: accommodate Git for Windows' default
 terminal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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

