Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78DDC2D0D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B293F206EF
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF7NN3jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfLUWmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:42:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34784 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfLUWmH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:42:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id l8so12074534edw.1
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 14:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=piNb8ps1Uqk/dtptwShlXphncXbdxXOUBitj8rIWJ6o=;
        b=DF7NN3jdFBa2uTnehbIL7QeChzBBXikqhiODUqgo83tpD5jMSEO9uVTcwmnWxmefDt
         ROjXj0U0P5ArIbqsEpFymjHDeJohUe0ijiW3j/xhdM76VDvXbB0Pr/c76BwtVB/ELKx0
         s7RnAwrhraAp/xAVwZ2jsPgLjevqV3CrxeJ3+o0GHcw/xmVa6yW64Bm3TjbgPOIZONUm
         NaoqrH2zMKIDP3BFxge13DwHus9eysm1SwsakTRMzYDJQ7urd+t7iMqfdH0YECSrJtH2
         kk0hcB3kIIQmDLtP/kCMePHTFFAcVakkh3S9pFeK1ZreEAthZqbJp8dRm+lKhuKPmrZH
         3jPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=piNb8ps1Uqk/dtptwShlXphncXbdxXOUBitj8rIWJ6o=;
        b=rPHkK+zhC2ibvAkhMPhsfcdmSgCBa8FIImL59DXS0HtB0Hy+xTMg66c3cB0NpXNwWR
         zIO3/JvW2eSl1Bcn7pg0Yttvu3gnNUZ+OxS4UbprvyWXE8Nzec2hEH4lenLzyffcBQ2i
         6lql5l1zlBh4rBYJpWbq9vTcQgM3ApyWgBBQQN7aIQQ/7jeauOzVuPeSsZ1qRRH/VL8/
         RVwtKiUoQm3+RZdruSUyShovdpjGlVq1+YIJPzVbnF96sZWfw8SxhuiynVJSTYv8OW7t
         +3wM93TLyTWLwcc9gxQZXHbwnrKiCJlg1T2vC0ZTSQylIbGg5ikDohEEUmLPp9XnyOtF
         Is6A==
X-Gm-Message-State: APjAAAWLo0sg4XQqpcplVSHtO7gSTp542lfN1nofYZvDGLRqa4++yeCR
        1BMH5KwTpet8spQZTw131KIMzUAC
X-Google-Smtp-Source: APXvYqy29sdAJKmwDzP1WULUrOZeT+XM49KFKovHmCdOcrIiL9ajei4N3ylLhF5WXqtES+Tk8urrOA==
X-Received: by 2002:aa7:d507:: with SMTP id y7mr24312122edq.267.1576968125549;
        Sat, 21 Dec 2019 14:42:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c19sm1692703ejm.47.2019.12.21.14.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 14:42:05 -0800 (PST)
Message-Id: <3996d7997a66aec61ebdd7831879aa8522f9938a.1576968120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.git.1576968120.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 22:41:56 +0000
Subject: [PATCH 5/9] terminal: add a new function to read a single keystroke
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

Typically, input on the command-line is line-based. It is actually not
really easy to get single characters (or better put: keystrokes).

We provide two implementations here:

- One that handles `/dev/tty` based systems as well as native Windows.
  The former uses the `tcsetattr()` function to put the terminal into
  "raw mode", which allows us to read individual keystrokes, one by one.
  The latter uses `stty.exe` to do the same, falling back to direct
  Win32 Console access.

  Thanks to the refactoring leading up to this commit, this is a single
  function, with the platform-specific details hidden away in
  conditionally-compiled code blocks.

- A fall-back which simply punts and reads back an entire line.

Note that the function writes the keystroke into an `strbuf` rather than
a `char`, in preparation for reading Escape sequences (e.g. when the
user hit an arrow key). This is also required for UTF-8 sequences in
case the keystroke corresponds to a non-ASCII letter.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/terminal.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 compat/terminal.h |  3 +++
 2 files changed, 58 insertions(+)

diff --git a/compat/terminal.c b/compat/terminal.c
index 16e9949da1..1b2564042a 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -60,6 +60,11 @@ static int disable_echo(void)
 	return disable_bits(ECHO);
 }
 
+static int enable_non_canonical(void)
+{
+	return disable_bits(ICANON | ECHO);
+}
+
 #elif defined(GIT_WINDOWS_NATIVE)
 
 #define INPUT_PATH "CONIN$"
@@ -151,6 +156,10 @@ static int disable_echo(void)
 	return disable_bits(ENABLE_ECHO_INPUT);
 }
 
+static int enable_non_canonical(void)
+{
+	return disable_bits(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT);
+}
 
 #endif
 
@@ -198,6 +207,33 @@ char *git_terminal_prompt(const char *prompt, int echo)
 	return buf.buf;
 }
 
+int read_key_without_echo(struct strbuf *buf)
+{
+	static int warning_displayed;
+	int ch;
+
+	if (warning_displayed || enable_non_canonical() < 0) {
+		if (!warning_displayed) {
+			warning("reading single keystrokes not supported on "
+				"this platform; reading line instead");
+			warning_displayed = 1;
+		}
+
+		return strbuf_getline(buf, stdin);
+	}
+
+	strbuf_reset(buf);
+	ch = getchar();
+	if (ch == EOF) {
+		restore_term();
+		return EOF;
+	}
+
+	strbuf_addch(buf, ch);
+	restore_term();
+	return 0;
+}
+
 #else
 
 char *git_terminal_prompt(const char *prompt, int echo)
@@ -205,4 +241,23 @@ char *git_terminal_prompt(const char *prompt, int echo)
 	return getpass(prompt);
 }
 
+int read_key_without_echo(struct strbuf *buf)
+{
+	static int warning_displayed;
+	const char *res;
+
+	if (!warning_displayed) {
+		warning("reading single keystrokes not supported on this "
+			"platform; reading line instead");
+		warning_displayed = 1;
+	}
+
+	res = getpass("");
+	strbuf_reset(buf);
+	if (!res)
+		return EOF;
+	strbuf_addstr(buf, res);
+	return 0;
+}
+
 #endif
diff --git a/compat/terminal.h b/compat/terminal.h
index 97db7cd69d..a9d52b8464 100644
--- a/compat/terminal.h
+++ b/compat/terminal.h
@@ -3,4 +3,7 @@
 
 char *git_terminal_prompt(const char *prompt, int echo);
 
+/* Read a single keystroke, without echoing it to the terminal */
+int read_key_without_echo(struct strbuf *buf);
+
 #endif /* COMPAT_TERMINAL_H */
-- 
gitgitgadget

