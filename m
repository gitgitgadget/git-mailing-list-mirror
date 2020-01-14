Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F99DC33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE26224670
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC5LYuk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgANSoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:44:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51720 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbgANSoB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 13:44:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so15044134wmd.1
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 10:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=piNb8ps1Uqk/dtptwShlXphncXbdxXOUBitj8rIWJ6o=;
        b=aC5LYuk/0hYGsicrYyBsHuPx3FhdZEM9zqUx5LXeYch3R/lG4G3N0RyZC+8xY5TKeq
         z3mhkQ+VAJH99gKIPj6yKH0WWtN5O0DKRebpW2hH29mBrG7PpxikujYDm87MGYrp3Mah
         /FVIM/ubPRZl+CPmMTe7EuIJBgIaJUo+2B54erkIwktU8KnPyV07XmQuxDnViPf+fgBD
         vtHNxezYIcDaCHzA34JL5901DY1hChuz1gzPgZOy8mLWjK8X9Yxob/9t3tbj7ZCd+tzL
         Td0mM5OQc5QsCKK34W7qAjbhI2oNix7RflodSDBbNiagyWo6YRZ2Ddo7AtnwO1/ziatW
         UipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=piNb8ps1Uqk/dtptwShlXphncXbdxXOUBitj8rIWJ6o=;
        b=niTEXLPVRk1zKIcOnE/vSlCa2GS5iTh5UtTdb9tzNXv4ynnFmZElI53rkm3UxTB6s+
         apQ2QjOi7ax1/lKzZR5jzyXMIDATo9a6bbZC1I9Xe6Cz95LKlLz/5kyMHCpQRggRDSTt
         chOn8sowjBUb7K9KaLWYRwd7qQZ6HIj236l3zjl7fGyCjJepilXdyCUdgbBH1b4yG63e
         rahCfs0XflOFmnmAJqur2kXIEkhldZyeubpqgK+r2qv6gN1w8nmsGPaHB17AhuBqDTJ+
         PCYNeYRo7K8IyA/oOxeejiX0XsgJju8SjDBKG/4x2h4AlpLmCbpNx3QQhocVLN/osPYe
         dMYA==
X-Gm-Message-State: APjAAAXy9WKaTpsivaLCjZAzrk6rQH18zlOCrb0hW8OET9emUKqtsJRs
        rLXoI1ggpcDZiiS/2hSYlSSxxsQ7
X-Google-Smtp-Source: APXvYqwz1gtx4elFsv5KGLaobfFzQl8ybln6zArtmn6gc/U+bTgppJOZLF/eVMzKPRKNKEB9Le+hiA==
X-Received: by 2002:a05:600c:2409:: with SMTP id 9mr27037830wmp.109.1579027439997;
        Tue, 14 Jan 2020 10:43:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm20978096wrq.61.2020.01.14.10.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:43:59 -0800 (PST)
Message-Id: <8d9c703f3b02cd784025dec5c0be682ea25811de.1579027433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
References: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
        <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 18:43:49 +0000
Subject: [PATCH v4 06/10] terminal: add a new function to read a single
 keystroke
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

