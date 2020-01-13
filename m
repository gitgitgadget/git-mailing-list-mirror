Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A402C33CAB
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAE421569
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO3WaX7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgAMI3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:29:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39634 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgAMI3i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 03:29:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so7552587wrt.6
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 00:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=piNb8ps1Uqk/dtptwShlXphncXbdxXOUBitj8rIWJ6o=;
        b=QO3WaX7a5rlYVMGLpeXG3gNzb1cmGRsNTNTWMNk7Ri/Dx+yRxR4tIMDeh9La36hPdP
         /K+ny9eMHsh/QOCA1yY0s2DJ5E6UXVEft7nz+RC+d9NssJzpaGrYFlisFVajrmH01lhw
         NU0bSu+rzrfrWA6p6V3aCsgObSJX36D51A0XG7mGIiGvK+XEj5ipvrXwVYcI9fZVyMxf
         MwAjNh/C0/jMP+CSQofZWK3xAA/zXGFj21Igz42hgr0Y2RWjrZHJ4vnLA/1fkkmxHKi9
         7WqaEyZimKIJUidf3PKIPEK1jsbmCcLfxyaq6KE3eO+TRTp0uXOHiwD+0z0ZmEi3tkCG
         2R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=piNb8ps1Uqk/dtptwShlXphncXbdxXOUBitj8rIWJ6o=;
        b=aeR4lbQMrN7SUOKU0bwLMJBAuSJ6yS9m4+P5n0Q2Q5CwJnZSWyx1F5nFhyqW/9x0fI
         jANC3gju9qQ1J8LK4G4purdV9tSCV7eDQx4kzLuKKHujs674P7lrAiRLGxjcruhhFGG5
         bw0uUQ0+4RaZRUJwElbakT2OIlLnP3JASgLC1xYUCVOpbnqlmW37WIywxtIP9bHD0yZ7
         u3zYh9N7b+PBW/hTJXnF5ZsOv5pfOK//D2lK7LT3PaPWTp6n+tYa6R6X8jD+dc0zSjhE
         NJ0+MFi/HhoMNlm/TgFrOP0uw+qj+WjDrpDySxpFV7qQdVZyn4kvXAn1tqyZ4Tnn+Hyk
         qQig==
X-Gm-Message-State: APjAAAUJLvyelPXEje3cQ6HfCZM7F1Zl+f18J8lDF0r58KOqZqSHIILO
        SSpMeqY/hPt0Hbovdzemhd5tyNll
X-Google-Smtp-Source: APXvYqzQHgfz2E5/sq5olRmE1Alx8krVia9nMjYD/kJ/7Kwd3cTFb4NjF4S3UXRmrMcShiYDLoQKww==
X-Received: by 2002:adf:f311:: with SMTP id i17mr17036319wro.81.1578904177021;
        Mon, 13 Jan 2020 00:29:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm13350631wmm.15.2020.01.13.00.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:29:36 -0800 (PST)
Message-Id: <74593b51157c49f1785e217446f3af0889b0fdf2.1578904171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
        <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jan 2020 08:29:27 +0000
Subject: [PATCH v3 06/10] terminal: add a new function to read a single
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

