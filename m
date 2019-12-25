Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CFDC2D0DC
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E202075E
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxF5/5Uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLYL5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:57:16 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43549 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfLYL5H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 06:57:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so19749015edb.10
        for <git@vger.kernel.org>; Wed, 25 Dec 2019 03:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=piNb8ps1Uqk/dtptwShlXphncXbdxXOUBitj8rIWJ6o=;
        b=AxF5/5UfyUEK9yrjDO+MzGWgTD9iycEO9I937iKwuskklq7uVMiy1Rz28pvL47x/C1
         7jrVC19LMQNjBo3Hff5svuz8E+It6jPSdDcVuUr3RTOwo9mIJatBdUZ6cT+lZ4RTTnOf
         NT2StE5gG6gQRkblYB0dZBEJZ2gnY76mEP8O+fURlhaqjQ/fhSRKGwbb53GabYAwQTrs
         e885GPl+iyIfwNGTXs5dKs0jPccn03/I3cGvNvYBWUbdMB52Gcn79eBK6GA2aO3numOI
         Jr+W7uTGL8ZGHS1AlXXOMuOJntwX9MbRHC7JE2JNAYqlXyJeU9KiD8s1LZG3WmIfBQal
         NY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=piNb8ps1Uqk/dtptwShlXphncXbdxXOUBitj8rIWJ6o=;
        b=rCy+lYKqw84v5DeYjVMprWAq+4/Vj9YuJ6heMRJzrpVwz/ICfbIRgm1DKkOSrMEHur
         DisMVEv1y7hQMuFR5WPkQPoPpiJsnv7sNxikmaLWb7aFMKGei/npgGcgPnOi16CIEHSS
         kdhcWqeWpIZ5kBDGphydxXih5pMElNFNVxY50MpN7ORerP2jTbCCIBGBSwKvWorJHk/v
         h0g6bgyxeN5zmmX5HIOQEOJdyy2CCs+GY+8REOkIv/BEJm5nVuUcsRA01Gk44X7tas9W
         fFFh+ejeBMIqV7GiXo9sf8iBU6KJb8fHKMR2ecnymB/5WFoIIArPUFqkt4nBLU2XdPji
         ZcGg==
X-Gm-Message-State: APjAAAXT6hN1Bc+iQA4tEtT/x+OSC0J0Vmuu1xYg1ocE9L1HOQVwPJCr
        wosIsGqaZr/Z9a3aSCfG01JERhs4
X-Google-Smtp-Source: APXvYqxLOwA2s26p5VVVi1xxWzFRIw172LPlIIXkmY8oAYW1bf5JG7xDtMVDPxMpXGs5YocQ9NJ/1g==
X-Received: by 2002:a17:906:8299:: with SMTP id h25mr12902910ejx.128.1577275025840;
        Wed, 25 Dec 2019 03:57:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h61sm3053319edd.49.2019.12.25.03.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 03:57:05 -0800 (PST)
Message-Id: <190fb4f5e911aca494647c36c9b09ac0cd232170.1577275020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
        <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Dec 2019 11:56:56 +0000
Subject: [PATCH v2 5/9] terminal: add a new function to read a single
 keystroke
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

