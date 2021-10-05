Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FE2C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 07:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3B261038
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 07:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhJEHsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 03:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJEHsv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 03:48:51 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69521C061745
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 00:47:01 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l13so18327782qtv.3
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNZUoeZVtRiLew/B7fEkYU1ykQVl0liTvhOa9hwHydM=;
        b=gi1wiSEFyn30hlQZih0IlnCiknHDVgsuTX8A/+quxO26i1WGzzN2dhhv+tyHyZZCzH
         Mz06ahT74rSLPVpnJ1yfZCuxAMCNR3IfrWHe39YuJjqwJEShIdGdk6uw0aECEWFqR/9L
         18gEWVskZNuE7ufUa65Qrrny2XXGLH7Zv21INweISDU2IIkZfLNiOTNODMiE/P1ogJOv
         K6RVI6np1g2s0JaeSTzAsho1T1aeHw/D2tpU8ZVp2TiTlng/jq8QynMuIozv8ETUSCOR
         g/2ucttUVh76pCaytIve+QbhQJJeyB5EwwI0pUN+vWAt19HJCmMxm/sywIsMo79LNWsK
         w2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNZUoeZVtRiLew/B7fEkYU1ykQVl0liTvhOa9hwHydM=;
        b=iFeQOyDqSZrQzgu3jGnWUnzzPPvK6/mvFXIiEFmdZjUzmsMS435zmcOhpD0Uo6Mw2G
         YpuUTSrEtipxsafhxcNXKiE7r6fBbR7uQoFDpq71q73uzn+orFb9sLYEpIFEuqLUg60c
         fRSbRwaxzVyCvFssyXO29S+UouSZELJ91bUEsSDQhiLz32MFj4KuTPAl6xtUaDS7uBvI
         XL4FfJdJMOiJm6e1TMLShVm3cNqG79bKpdPSfQ4j1/9oLfRLKZUSlbT7oPDhGlyPpQX4
         iaX7whaMSq86p826kaWntDBaqAvPze7ql2ASe0IfIQZ9t8BtM2qtlKpxZWssMAJ0pLdd
         wZWg==
X-Gm-Message-State: AOAM531PO3XlZ0YR/fK7L0j2iqU4NaL7CC/AyzTJ/C61KbyUG8D7RxIb
        RzLehHfvFrzaGC/vpCjmPIFIWtpQGFUsvg==
X-Google-Smtp-Source: ABdhPJxq6vS41POWtoXo26dGmym4749K9o12x4s427pIJTQPRmAyCuw6sCO2DmG+y5YGo5CNLBit+g==
X-Received: by 2002:ac8:1011:: with SMTP id z17mr18356660qti.388.1633420020005;
        Tue, 05 Oct 2021 00:47:00 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id c16sm8779285qkk.113.2021.10.05.00.46.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Oct 2021 00:46:59 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 1/2] terminal: teach git how to save/restore its terminal settings
Date:   Tue,  5 Oct 2021 00:46:47 -0700
Message-Id: <20211005074648.86032-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20211005074648.86032-1-carenas@gmail.com>
References: <20211004072600.74241-1-carenas@gmail.com>
 <20211005074648.86032-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, git will share its console with all its children (unless
they create their own), and is therefore possible that any of them
that might change the settings for it could affect its operations once
completed.

Refactor the platform specific functionality to save the terminal
settings and expand it to also do so for the output handler.

This will allow for the state of the terminal to be saved and
restored around a child that might misbehave (ex vi) which will
be implemented next.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v2:
- remove unnecessary forward declaration for restore_term per Junio
- reword first paragraph with hopefully better grammar

 compat/terminal.c | 75 +++++++++++++++++++++++++++++++++++++----------
 compat/terminal.h |  3 ++
 2 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 43b73ddc75..5b903e7c7e 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -8,8 +8,6 @@
 
 #if defined(HAVE_DEV_TTY) || defined(GIT_WINDOWS_NATIVE)
 
-static void restore_term(void);
-
 static void restore_term_on_signal(int sig)
 {
 	restore_term();
@@ -25,7 +23,7 @@ static void restore_term_on_signal(int sig)
 static int term_fd = -1;
 static struct termios old_term;
 
-static void restore_term(void)
+void restore_term(void)
 {
 	if (term_fd < 0)
 		return;
@@ -35,15 +33,22 @@ static void restore_term(void)
 	term_fd = -1;
 }
 
+int save_term(int full_duplex)
+{
+	if (term_fd < 0)
+		term_fd = open("/dev/tty", O_RDWR);
+
+	return (term_fd < 0) ? -1 : tcgetattr(term_fd, &old_term);
+}
+
 static int disable_bits(tcflag_t bits)
 {
 	struct termios t;
 
-	term_fd = open("/dev/tty", O_RDWR);
-	if (tcgetattr(term_fd, &t) < 0)
+	if (save_term(0) < 0)
 		goto error;
 
-	old_term = t;
+	t = old_term;
 	sigchain_push_common(restore_term_on_signal);
 
 	t.c_lflag &= ~bits;
@@ -75,9 +80,10 @@ static int enable_non_canonical(void)
 static int use_stty = 1;
 static struct string_list stty_restore = STRING_LIST_INIT_DUP;
 static HANDLE hconin = INVALID_HANDLE_VALUE;
-static DWORD cmode;
+static HANDLE hconout = INVALID_HANDLE_VALUE;
+static DWORD cmode_in, cmode_out;
 
-static void restore_term(void)
+void restore_term(void)
 {
 	if (use_stty) {
 		int i;
@@ -97,9 +103,42 @@ static void restore_term(void)
 	if (hconin == INVALID_HANDLE_VALUE)
 		return;
 
-	SetConsoleMode(hconin, cmode);
+	SetConsoleMode(hconin, cmode_in);
+	CloseHandle(hconin);
+	if (cmode_out) {
+		assert(hconout != INVALID_HANDLE_VALUE);
+		SetConsoleMode(hconout, cmode_out);
+		CloseHandle(hconout);
+	}
+
+	hconin = hconout = INVALID_HANDLE_VALUE;
+}
+
+int save_term(int full_duplex)
+{
+	hconin = CreateFileA("CONIN$", GENERIC_READ | GENERIC_WRITE,
+	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
+	    FILE_ATTRIBUTE_NORMAL, NULL);
+	if (hconin == INVALID_HANDLE_VALUE)
+		return -1;
+
+	if (full_duplex) {
+		hconout = CreateFileA("CONOUT$", GENERIC_READ | GENERIC_WRITE,
+			FILE_SHARE_WRITE, NULL, OPEN_EXISTING,
+			FILE_ATTRIBUTE_NORMAL, NULL);
+		if (hconout == INVALID_HANDLE_VALUE)
+			goto error;
+
+		GetConsoleMode(hconout, &cmode_out);
+	}
+
+	GetConsoleMode(hconin, &cmode_in);
+	use_stty = 0;
+	return 0;
+error:
 	CloseHandle(hconin);
 	hconin = INVALID_HANDLE_VALUE;
+	return -1;
 }
 
 static int disable_bits(DWORD bits)
@@ -135,15 +174,11 @@ static int disable_bits(DWORD bits)
 		use_stty = 0;
 	}
 
-	hconin = CreateFile("CONIN$", GENERIC_READ | GENERIC_WRITE,
-	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
-	    FILE_ATTRIBUTE_NORMAL, NULL);
-	if (hconin == INVALID_HANDLE_VALUE)
+	if (save_term(0) < 0)
 		return -1;
 
-	GetConsoleMode(hconin, &cmode);
 	sigchain_push_common(restore_term_on_signal);
-	if (!SetConsoleMode(hconin, cmode & ~bits)) {
+	if (!SetConsoleMode(hconin, cmode_in & ~bits)) {
 		CloseHandle(hconin);
 		hconin = INVALID_HANDLE_VALUE;
 		return -1;
@@ -361,6 +396,16 @@ int read_key_without_echo(struct strbuf *buf)
 
 #else
 
+int save_term(int full_duplex)
+{
+	/* full_duplex == 1, but no support available */
+	return -full_duplex;
+}
+
+void restore_term(void)
+{
+}
+
 char *git_terminal_prompt(const char *prompt, int echo)
 {
 	return getpass(prompt);
diff --git a/compat/terminal.h b/compat/terminal.h
index a9d52b8464..e1770c575b 100644
--- a/compat/terminal.h
+++ b/compat/terminal.h
@@ -1,6 +1,9 @@
 #ifndef COMPAT_TERMINAL_H
 #define COMPAT_TERMINAL_H
 
+int save_term(int full_duplex);
+void restore_term(void);
+
 char *git_terminal_prompt(const char *prompt, int echo);
 
 /* Read a single keystroke, without echoing it to the terminal */
-- 
2.33.0.955.gee03ddbf0e

