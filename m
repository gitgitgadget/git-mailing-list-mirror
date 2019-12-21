Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2199CC4741C
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE3D206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii4YViYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLUWmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:42:12 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:40168 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfLUWmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:42:09 -0500
Received: by mail-ed1-f47.google.com with SMTP id b8so12058830edx.7
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 14:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ocI02bHKxI6bqqVjgkc/ET4PWDrishuZmL3FurmFRns=;
        b=ii4YViYrwh73VvCViD6r5AoD+Q+Q96/qeGvjnaWTCjVlt5m4Y+uc/rUmrpiKny3TUX
         HJVbJthdNBRuQhjxyU+BQSs4Y1+PtSLrKpNJuNbA0lYm/zBIWP2A6c2/ym/VZH5pjPTi
         zh6fgNMDyytcPGuzSlIliShTgLQ+BuSuypo0KY/obImgu1rnJ8UHffLheljmQqzAVG5u
         +PE4K31El13rKA6T4QtpUTkSW/mwulrtuCE/m1XTgS6zp0xrLnBm1exaWOVq0+V4U/LE
         CadZStu+/vGBD8g1AOWYEQbUd/5udu+8smWETCwwfPrZ/hRRkU5ZTEdOlw+b2ytzwlYF
         H00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ocI02bHKxI6bqqVjgkc/ET4PWDrishuZmL3FurmFRns=;
        b=II0fJ7XlNcvLLrrzMFY+8TNsXcpzkmNJ84Hd67yBM63IZqN9wlKrXpsDpsSIr4chmx
         Obc9YbGQTAKwssOC7nUPuKrxzbUsdo9o70GxilNDdQ2mKTpUZmJ441AlCRFtAlhMyR4x
         9Z/edk+qpbjPDVuzB+fNPAJkaS1sl9NMgs3n8Tg+I69cg5uI3jSkfIjgfBYAxxWu2tVD
         T+hz318vxAkHw/4qe4wlYfTasKTJpVXtsSicLtGIpaGAF1goqvqYWJ9cLHG8eI3hi6ON
         i2q4VZ0CSs4gB21jD8/KvnXBoigXhmbjV/AgQ5zCf0u1y2nuh5J9ZALUEX0HIV2Aw/aO
         4PMQ==
X-Gm-Message-State: APjAAAVRHIfLZOm6ANjsNWzd5ZMh0NbNushPxBTL2dWGrwdLVwV7GitI
        npycoaXGqKJQPHWPpCTYpTQ+X2AE
X-Google-Smtp-Source: APXvYqz9MkXmm3HGyM9FFFK3X5g0cOc/EHbKie4bhFGVi+UcgAqJpJJFqr4J6v4zRBmet4LDziFVQA==
X-Received: by 2002:a17:906:5808:: with SMTP id m8mr24639678ejq.1.1576968126928;
        Sat, 21 Dec 2019 14:42:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay24sm1558063edb.29.2019.12.21.14.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 14:42:06 -0800 (PST)
Message-Id: <fd5a12977609f69790fd2405baf5836add434cef.1576968120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.git.1576968120.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 22:41:58 +0000
Subject: [PATCH 7/9] built-in add -p: handle Escape sequences in
 interactive.singlekey mode
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

