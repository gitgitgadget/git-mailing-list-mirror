Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199A1C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED08C24658
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcePuJkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgANSoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:44:06 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38770 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgANSoD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 13:44:03 -0500
Received: by mail-wr1-f47.google.com with SMTP id y17so13273166wrh.5
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 10:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ocI02bHKxI6bqqVjgkc/ET4PWDrishuZmL3FurmFRns=;
        b=EcePuJkDO3pTnQgIWlEOZw9xYx8Fyfiofo0GYeCzl5SdrkzyC5BpmTAHKFPP6XOOW2
         Ivo8q3fBrs+VE9poX9WWw+BzTMo0FxR3KufA36op+vr+CbFLNGXKD7n43PanrPNoV93s
         u5bPbyCjO0LlFm8s44PATwsRKCiPdisg59jQA9wUK+7LXnhxwlFmM3GUnBhzXbeaDw07
         8FYVpVqd2G74HLtdDDJOUGn8OCwCtA1amvcdq6DuykF07yBdyfjv+HIq6vE27ZluRhqs
         /i2H3gC0cWr0cTK0XdXgWqVmIWFPsAfd+zqXneoRYM82oyq98fNJGtF5jUwRY2VRog2k
         i9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ocI02bHKxI6bqqVjgkc/ET4PWDrishuZmL3FurmFRns=;
        b=mltjC0E/uG97O55DQaG5vXqhLebKd+TJBPVwEDqekdDzfGk5dUxKM3mz3sgY+pU5XA
         jpp48tkkYUP3nmZo2CxoLUYR52k6VHoDkuD0V2leJ5t2QG5AElP2YOpih2CgeddMtOfQ
         k/w+8vfRxxCmu4WRcEPsHeMxavSD7ibh/xrYmhG44499CPKNKWeA1YuDrDCU4/ju1Qx/
         Fxe0GUuNeAlQwbHU6CWwr+U72hjmhaGM/4n3rvHKoh6SuDwGsiv/h4UlTsNj6vcJFaiz
         2JzH8fPd5LuDttAVq94KFXPy4rvztLDu7wOQjcBSthzX4B2YJIhI4AiaAAQnwmLZan+o
         Xb0w==
X-Gm-Message-State: APjAAAXUSAuhDJdR+fACSh88j1+O4VOuNUlajEn28mfn4kI6HK4tgDWs
        kNSa/81jLRQZ11EUQauAODpAZkPU
X-Google-Smtp-Source: APXvYqyV0mBqhgXiWoSRXLP2iYHEWbFv8GYIFPPaIX/kyCdWmd8mbtMRd3VmwIBm7sQupD2JhYNAyg==
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr26873959wrs.92.1579027441419;
        Tue, 14 Jan 2020 10:44:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm18971769wmm.15.2020.01.14.10.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:44:01 -0800 (PST)
Message-Id: <cdc609f8fa349b9ffada68dfd6fd183365222ba7.1579027433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
References: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
        <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 18:43:51 +0000
Subject: [PATCH v4 08/10] built-in add -p: handle Escape sequences in
 interactive.singlekey mode
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

This recapitulates part of b5cc003253c8 (add -i: ignore terminal escape
sequences, 2011-05-17):

    add -i: ignore terminal escape sequences

    On the author's terminal, the up-arrow input sequence is ^[[A, and
    thus fat-fingering an up-arrow into 'git checkout -p' is quite
    dangerous: git-add--interactive.perl will ignore the ^[ and [
    characters and happily treat A as "discard everything".

    As a band-aid fix, use Term::Cap to get all terminal capabilities.
    Then use the heuristic that any capability value that starts with ^[
    (i.e., \e in perl) must be a key input sequence.  Finally, given an
    input that starts with ^[, read more characters until we have read a
    full escape sequence, then return that to the caller.  We use a
    timeout of 0.5 seconds on the subsequent reads to avoid getting stuck
    if the user actually input a lone ^[.

    Since none of the currently recognized keys start with ^[, the net
    result is that the sequence as a whole will be ignored and the help
    displayed.

Note that we leave part for later which uses "Term::Cap to get all
terminal capabilities", for several reasons:

1. it is actually not really necessary, as the timeout of 0.5 seconds
   should be plenty sufficient to catch Escape sequences,

2. it is cleaner to keep the change to special-case Escape sequences
   separate from the change that reads all terminal capabilities to
   speed things up, and

3. in practice, relying on the terminal capabilities is a bit overrated,
   as the information could be incomplete, or plain wrong. For example,
   in this developer's tmux sessions, the terminal capabilities claim
   that the "cursor up" sequence is ^[M, but the actual sequence
   produced by the "cursor up" key is ^[[A.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/terminal.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 1b2564042a..b7f58d1781 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -161,6 +161,37 @@ static int enable_non_canonical(void)
 	return disable_bits(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT);
 }
 
+/*
+ * Override `getchar()`, as the default implementation does not use
+ * `ReadFile()`.
+ *
+ * This poses a problem when we want to see whether the standard
+ * input has more characters, as the default of Git for Windows is to start the
+ * Bash in a MinTTY, which uses a named pipe to emulate a pty, in which case
+ * our `poll()` emulation calls `PeekNamedPipe()`, which seems to require
+ * `ReadFile()` to be called first to work properly (it only reports 0
+ * available bytes, otherwise).
+ *
+ * So let's just override `getchar()` with a version backed by `ReadFile()` and
+ * go our merry ways from here.
+ */
+static int mingw_getchar(void)
+{
+	DWORD read = 0;
+	unsigned char ch;
+
+	if (!ReadFile(GetStdHandle(STD_INPUT_HANDLE), &ch, 1, &read, NULL))
+		return EOF;
+
+	if (!read) {
+		error("Unexpected 0 read");
+		return EOF;
+	}
+
+	return ch;
+}
+#define getchar mingw_getchar
+
 #endif
 
 #ifndef FORCE_TEXT
@@ -228,8 +259,31 @@ int read_key_without_echo(struct strbuf *buf)
 		restore_term();
 		return EOF;
 	}
-
 	strbuf_addch(buf, ch);
+
+	if (ch == '\033' /* ESC */) {
+		/*
+		 * We are most likely looking at an Escape sequence. Let's try
+		 * to read more bytes, waiting at most half a second, assuming
+		 * that the sequence is complete if we did not receive any byte
+		 * within that time.
+		 *
+		 * Start by replacing the Escape byte with ^[ */
+		strbuf_splice(buf, buf->len - 1, 1, "^[", 2);
+
+		for (;;) {
+			struct pollfd pfd = { .fd = 0, .events = POLLIN };
+
+			if (poll(&pfd, 1, 500) < 1)
+				break;
+
+			ch = getchar();
+			if (ch == EOF)
+				return 0;
+			strbuf_addch(buf, ch);
+		}
+	}
+
 	restore_term();
 	return 0;
 }
-- 
gitgitgadget

