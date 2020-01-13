Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2649CC33CB0
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2D5214D8
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5vxVHXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgAMI3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:29:46 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:34235 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbgAMI3l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 03:29:41 -0500
Received: by mail-wm1-f43.google.com with SMTP id w5so9203406wmi.1
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 00:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ocI02bHKxI6bqqVjgkc/ET4PWDrishuZmL3FurmFRns=;
        b=P5vxVHXLOSt2a007mkZe8iMJaD25V8H7PcaSysBCUi252kgT+isb+L9EnGnKMcbVYa
         6iG3BqqckTlA0Bhcsr9rATnaF4bbe6HTX/gDYCt2mBIIayzKi14OhJMhws5o+XFfb+kl
         3E/l3TZF6Yx1lONpRb8TjPBk8qMfzCaadx8/1sACnjB0vLyxwSDCjpTjVF7iNPLI1F7v
         sCKzCniMTUaK6DLIKLJmYUI1LF5cgD5O7EJgu/FPOj8/WyoxGdxlolYYEtnsW1rDCKJR
         yeXS4P++GhzheNyQ8f+7/Kply9Asr3fhHmfNR9wWobhW+ZuHSpYoAjoB+zWV8pj8beaH
         pnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ocI02bHKxI6bqqVjgkc/ET4PWDrishuZmL3FurmFRns=;
        b=EFE8d1nKJGwq2DkXpobHFOqqfy83tw9ry0xyLYAAbP2hbwFVa0W5B/pos9+yTs/DTj
         vgSobYow3Va4HKrr7HxnacGOHTh+b1H02NbtNt0CnF3CbrnXaGR7awc2OJjoTXUzkX76
         /dIzwJb+YVlGlo4c8KLnwCcQnkwhwOABBz8eTdEpw1Tg2A/DylKEF4Jr13xAOdg1Prhd
         9I8ZqUeCFiInRoBnGajACoGzSnFmyrpRp/CC0XQ2N0HFG9d75cUiRqYSBFlLNkJ9n6zs
         uGgsXeIqbjMApVE/aHorrm1UZCff0i+NEhMX8csbs/zZvx3qTVGKX97vtLSZPH8X5lYA
         CLkw==
X-Gm-Message-State: APjAAAXg6LjJrwA6pa3RthLGf7Mz7OlKi6VeOUEFq0mNhgIPHGDGehEf
        XwunsLagWfdQF91SbKS+lkgXKo88
X-Google-Smtp-Source: APXvYqwj3zAOyrpYK1So5eaP6ZIWB6P0qQJXxs8yznrmxPCL0UtIHo+5OZej5q/3BpDcvE9VY7AHWA==
X-Received: by 2002:a7b:cf26:: with SMTP id m6mr17509168wmg.17.1578904178589;
        Mon, 13 Jan 2020 00:29:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm14101555wrr.75.2020.01.13.00.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:29:38 -0800 (PST)
Message-Id: <9ab381d539584d4ddb854e6a7054cab90b5fdf16.1578904171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
        <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jan 2020 08:29:29 +0000
Subject: [PATCH v3 08/10] built-in add -p: handle Escape sequences in
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

