Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CD5C433FE
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 11:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiCILFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 06:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCILFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 06:05:09 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFA1C6821
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 03:04:10 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p9so2378800wra.12
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 03:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=2mqmskBG2Ee9f/l9FxQefhYnj2kroD5St/4wlTzv3PY=;
        b=U35ivG7bj1Of70E/p49O7fzN//TWo8w6gyKeZWJjZJaTYcxx16TnThUHuFJUlVfnBv
         05gENrzFn3EQEP8wA5q6GvPXztbG0qp9nmDeF1EsXdss/PdtA/5AcO35xBfCLleOFnUj
         69vY2rRweJBWeP2pHvVjBWOX55qVdlVV+7vUyTNOqsjAg6hi1FIlvfkqGqJMTrhxS4pY
         24OEdtc+NUZy55GEQwucpoSINs0OODlNERADOaM1KfYR9oQKbI7YyiAbxKneMH+nkL7d
         inxvNwQo1+vywZ2Cm1Xf3c9nvKsEQUr7C0zwAniQDHBgnH8UVsXrFmXh34Eu28oQRw1b
         8Wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=2mqmskBG2Ee9f/l9FxQefhYnj2kroD5St/4wlTzv3PY=;
        b=TLta6T1LHorPdsY0mUEu8DPciACz0JBz9hZg5BGOJhe7Nss5nmm3DE3bfuVM+YrUfV
         m+X9XO/Gc9a/BHtp6TRzRN4f85dJbbIjQkXknT6D7+IhAl8JmqA6uR2gGyUQyb5e64E6
         PEHrqYIcNdt5kU1P3QUIrib6IGB/9HQ9KQOi+/sAWlJ6MVGNBYaUN665TOo2+7zMbmYI
         rgEAD2jPDN0YokoZqyLM3UhJg0azKPStY+YN7xD6Y58LezJHdj9WXg7TJfbopPxOpl0w
         zo0I/ZqsIyEbYj84sMVTcezRElSbBcfhdWDI40OQC8Wn0+cvBnTnfC5Aa4nQiUoiWpQ+
         H0fg==
X-Gm-Message-State: AOAM530ib+OqZ3ATNMdfg83eeWBwDoD/P77d4zlWURrELZiT0g4b4QXp
        e+L6Gj03QUF+FQMNVE2xHDOSpy5PrhQ=
X-Google-Smtp-Source: ABdhPJzlpjFXATZ+BvV3jJ0cfcqq/3VMbgfrGeq7BU+TyfO1zCeg7wNYHOwN/OcSNn5nymcC3WV4BQ==
X-Received: by 2002:a5d:6da5:0:b0:1f1:f958:46fa with SMTP id u5-20020a5d6da5000000b001f1f95846famr10032188wrs.622.1646823849436;
        Wed, 09 Mar 2022 03:04:09 -0800 (PST)
Received: from localhost.localdomain (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm2072203wrt.63.2022.03.09.03.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:04:09 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 1/4] terminal: use flags for save_term()
Date:   Wed,  9 Mar 2022 11:03:22 +0000
Message-Id: <20220309110325.36917-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309110325.36917-1-phillip.wood123@gmail.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220309110325.36917-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The next commit will add another flag in addition to the existing
full_duplex so change the function signature to take a flags
argument. Also alter the functions that call save_term() so that they
can pass flags down to it.

The choice to use an enum for tho bitwise flags is because gdb will
display the symbolic names of all the flags that are set rather than
the integer value.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 compat/terminal.c | 41 +++++++++++++++++++++--------------------
 compat/terminal.h |  7 ++++++-
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index d882dfa06e..9392b068b1 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -34,7 +34,7 @@ void restore_term(void)
 	sigchain_pop_common();
 }
 
-int save_term(int full_duplex)
+int save_term(enum save_term_flags flags)
 {
 	if (term_fd < 0)
 		term_fd = open("/dev/tty", O_RDWR);
@@ -47,11 +47,11 @@ int save_term(int full_duplex)
 	return 0;
 }
 
-static int disable_bits(tcflag_t bits)
+static int disable_bits(enum save_term_flags flags, tcflag_t bits)
 {
 	struct termios t;
 
-	if (save_term(0) < 0)
+	if (save_term(flags) < 0)
 		goto error;
 
 	t = old_term;
@@ -71,14 +71,14 @@ static int disable_bits(tcflag_t bits)
 	return -1;
 }
 
-static int disable_echo(void)
+static int disable_echo(enum save_term_flags flags)
 {
-	return disable_bits(ECHO);
+	return disable_bits(flags, ECHO);
 }
 
-static int enable_non_canonical(void)
+static int enable_non_canonical(enum save_term_flags flags)
 {
-	return disable_bits(ICANON | ECHO);
+	return disable_bits(flags, ICANON | ECHO);
 }
 
 #elif defined(GIT_WINDOWS_NATIVE)
@@ -126,15 +126,15 @@ void restore_term(void)
 	hconin = hconout = INVALID_HANDLE_VALUE;
 }
 
-int save_term(int full_duplex)
+int save_term(enum save_term_flags flags)
 {
 	hconin = CreateFileA("CONIN$", GENERIC_READ | GENERIC_WRITE,
 	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
 	    FILE_ATTRIBUTE_NORMAL, NULL);
 	if (hconin == INVALID_HANDLE_VALUE)
 		return -1;
 
-	if (full_duplex) {
+	if (flags & SAVE_TERM_DUPLEX) {
 		hconout = CreateFileA("CONOUT$", GENERIC_READ | GENERIC_WRITE,
 			FILE_SHARE_WRITE, NULL, OPEN_EXISTING,
 			FILE_ATTRIBUTE_NORMAL, NULL);
@@ -154,7 +154,7 @@ int save_term(int full_duplex)
 	return -1;
 }
 
-static int disable_bits(DWORD bits)
+static int disable_bits(enum save_term_flags flags, DWORD bits)
 {
 	if (use_stty) {
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -191,7 +191,7 @@ static int disable_bits(DWORD bits)
 		use_stty = 0;
 	}
 
-	if (save_term(0) < 0)
+	if (save_term(flags) < 0)
 		return -1;
 
 	if (!SetConsoleMode(hconin, cmode_in & ~bits)) {
@@ -204,14 +204,15 @@ static int disable_bits(DWORD bits)
 	return 0;
 }
 
-static int disable_echo(void)
+static int disable_echo(enum save_term_flags flags)
 {
-	return disable_bits(ENABLE_ECHO_INPUT);
+	return disable_bits(flags, ENABLE_ECHO_INPUT);
 }
 
-static int enable_non_canonical(void)
+static int enable_non_canonical(enum save_term_flags flags)
 {
-	return disable_bits(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT);
+	return disable_bits(flags,
+			    ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT);
 }
 
 /*
@@ -267,7 +268,7 @@ char *git_terminal_prompt(const char *prompt, int echo)
 		return NULL;
 	}
 
-	if (!echo && disable_echo()) {
+	if (!echo && disable_echo(0)) {
 		fclose(input_fh);
 		fclose(output_fh);
 		return NULL;
@@ -361,7 +362,7 @@ int read_key_without_echo(struct strbuf *buf)
 	static int warning_displayed;
 	int ch;
 
-	if (warning_displayed || enable_non_canonical() < 0) {
+	if (warning_displayed || enable_non_canonical(0) < 0) {
 		if (!warning_displayed) {
 			warning("reading single keystrokes not supported on "
 				"this platform; reading line instead");
@@ -413,10 +414,10 @@ int read_key_without_echo(struct strbuf *buf)
 
 #else
 
-int save_term(int full_duplex)
+int save_term(enum save_term_flags flags)
 {
-	/* full_duplex == 1, but no support available */
-	return -full_duplex;
+	/* no duplex support available */
+	return -!!(flags & SAVE_TERM_DUPLEX);
 }
 
 void restore_term(void)
diff --git a/compat/terminal.h b/compat/terminal.h
index 0fb9fa147c..24c4df4c0e 100644
--- a/compat/terminal.h
+++ b/compat/terminal.h
@@ -1,14 +1,19 @@
 #ifndef COMPAT_TERMINAL_H
 #define COMPAT_TERMINAL_H
 
+enum save_term_flags {
+	/* Save input and output settings */
+	SAVE_TERM_DUPLEX = 1 << 0,
+};
+
 /*
  * Save the terminal attributes so they can be restored later by a
  * call to restore_term(). Note that every successful call to
  * save_term() must be matched by a call to restore_term() even if the
  * attributes have not been changed. Returns 0 on success, -1 on
  * failure.
  */
-int save_term(int full_duplex);
+int save_term(unsigned flags);
 /* Restore the terminal attributes that were saved with save_term() */
 void restore_term(void);
 
-- 
2.35.1

