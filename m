Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FE5C2D0DA
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FED22073B
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGla/nrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfLYL5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:57:15 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:42264 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfLYL5K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 06:57:10 -0500
Received: by mail-ed1-f41.google.com with SMTP id e10so19769590edv.9
        for <git@vger.kernel.org>; Wed, 25 Dec 2019 03:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ocI02bHKxI6bqqVjgkc/ET4PWDrishuZmL3FurmFRns=;
        b=TGla/nrpevhl1B1kD4hfTYrIxsBBwZGi2oMATScRnvE5msMSolkLY1gV/jDpQrslfh
         A9Tk5Bsu25ti692ZARie7GZuNt61gooTQuaVZQZRFLcfNsjWpdmA7V7MmuYnn2PRfzYE
         UVeo3N+cIoOccM4nK4r3TKuwMD+tqcnzUXUudGOOmWhs7SBFTopPBULqkpDTkLNfcYYJ
         jhYougHBUMM6IE15MivgDTuuEYcsWFC22+KIlYsnZJK6tjWng6S9HWZtFw+k5ojXug7I
         m3rf3oWILGvrn3ko67/Q5UnniLEcOtVDpJ9zeIE7Qzus6ubcdr5wPBdCIL1N9vUIElAL
         xZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ocI02bHKxI6bqqVjgkc/ET4PWDrishuZmL3FurmFRns=;
        b=IEr6K4scByRLsHDEjbteTIEwbqadotmeswAEjutzQ0gQDKoWAE+4Ud15BFXMbR4hUb
         RxNW1acws72D2i6l4NaktzeZsSPBK2Du6tydjrwHl7oImz7ZjlM1MSVVlI3dohIIuSh6
         kYUVmDcvFSPglyEZvnfIpYLZz2qasXUOz4oznkPq8pYR+6DsZm+jCtQiKej3nirT81SM
         bfK9+NyUBLAT+8VtAECdrJ1+GHO+Oqi4/gYYCEsgkNJt95Lgr7zBG/kekIdQ2xP1l987
         2V0kYD5YTVbWbhT/T80aEvH29Mg9vOHnaPwJyYR9FuGVr6VA8ccxQ2dBQr6Q2oluyXb0
         JwBg==
X-Gm-Message-State: APjAAAXe8ME4Tt/ESK8ZCCsb3vP8lcReNUIRf7gz/0TYvPxntiwN7kSY
        5GOBgAHghkcQ842MJsy+MvkarfKh
X-Google-Smtp-Source: APXvYqybP9+3wweeoeB9rBfMNpp62T9zANdOtdrOMmpweLxvgIIxSydcJt4njlfyBhGpvUsWAdRBVQ==
X-Received: by 2002:a17:906:8299:: with SMTP id h25mr12902996ejx.128.1577275027276;
        Wed, 25 Dec 2019 03:57:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k36sm3096708ede.57.2019.12.25.03.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 03:57:06 -0800 (PST)
Message-Id: <32067bebe87ab5e6ef35be930d722c7e50cf1da6.1577275020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
        <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Dec 2019 11:56:58 +0000
Subject: [PATCH v2 7/9] built-in add -p: handle Escape sequences in
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

