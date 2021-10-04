Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE73CC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF52E6126A
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhJDH2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 03:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhJDH2F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 03:28:05 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0313C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 00:26:16 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id a14so3145128qvb.6
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S7EKFJTWYATdp0Pfrg6F87HRI061/3Ln3bbjMAHqtTA=;
        b=ICkuwmf7fD2bGb1DS67E8thcaOtYckK113l2Yy96dwD+ZGyt9NEJ+yj+fmU9WJUe5a
         g0uKhrWu3IAkH/WNEy7avBu5Bz5t0dFUMvBmzZZWmvW35V7mSyAP+2j315KtODaNxNQ/
         6y5lbw0OXRK3BsBp9XlklJi2QJsVPHs5XCGNr8sfl8GGqJk8vqliF/1sNOtItMVTWzB1
         7Y21uLu0X8VmeEp8+UsJoRISpZskI8YsZzqo3z+nFmyUx7p+EJVmm8g6NFr4b/0GgqLK
         eYzU4jQF1Iaib8gxu9Zu8Lrf59vVZJ1ghbAlDsVoGr4G5bEfofIqaOn19tm1jfJUSLMV
         HXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S7EKFJTWYATdp0Pfrg6F87HRI061/3Ln3bbjMAHqtTA=;
        b=T9PFoWgOl2eYvyRAbyYpHAQeIsATi1GmgQvouS/u8sUp8vUfwbuGBkKthbYxn93BCE
         TDZE/xLM49TU8AigX3cHIxUUz8T46gtbDyBn6Z0NoEh+UArJrJQgnJUFWoTWXsg2qkCb
         kH1Rcgptbc/egKeiBmT6lp/xm2ygoAN2ZC3tFFolFvcHL8vKweAuLATyMno0+ZahOjDN
         pbaMeNAps0Tfvz9tVvdTdGqfp2LmjAbBMoytHWSscqdFvqlhVeKqgmyKrz/Pv6r3B7bJ
         7q0QGdmN81lHElMdnClIruEh0G8tgo/3sW0xed5BftAUDG1a4U1WmC5hM6y3TIvlHTmg
         ACLw==
X-Gm-Message-State: AOAM533GHpXFX4lMfpCETjdNIdFAtJP8J3a/02x3XMaNZmvalhMf4kSt
        GJM397lWYnTQ2tTLTww5l9NKtUsCseVH4A==
X-Google-Smtp-Source: ABdhPJznoZ36oBWAxfJyxdq/1PWKOLkKbnS1Dh+4O733LNpNzi3WNRgaYgzrWuCOYw9pHeoXmnrinA==
X-Received: by 2002:a0c:f588:: with SMTP id k8mr7584836qvm.48.1633332375814;
        Mon, 04 Oct 2021 00:26:15 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a3sm9015330qta.48.2021.10.04.00.26.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Oct 2021 00:26:15 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/2] terminal: teach git how to save/restore its terminal settings
Date:   Mon,  4 Oct 2021 00:25:59 -0700
Message-Id: <20211004072600.74241-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20211004072600.74241-1-carenas@gmail.com>
References: <20211002153654.52443-1-carenas@gmail.com>
 <20211004072600.74241-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, git will share its console with all its children (unless
they create their own), and is therefore possible that any of them
that might change settings of them could affect its operations once
completed.

Refactor the platform specific functionality to save the terminal
settings and expand it to also do so for the output handler.

This will allow for the state of the terminal to be saved and
restored around a child that might misbehave (ex vi) which will
be implemented next.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 compat/terminal.c | 75 ++++++++++++++++++++++++++++++++++++++---------
 compat/terminal.h |  3 ++
 2 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 43b73ddc75..1fadbfd6b6 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -8,7 +8,7 @@
 
 #if defined(HAVE_DEV_TTY) || defined(GIT_WINDOWS_NATIVE)
 
-static void restore_term(void);
+void restore_term(void);
 
 static void restore_term_on_signal(int sig)
 {
@@ -25,7 +25,7 @@ static void restore_term_on_signal(int sig)
 static int term_fd = -1;
 static struct termios old_term;
 
-static void restore_term(void)
+void restore_term(void)
 {
 	if (term_fd < 0)
 		return;
@@ -35,15 +35,22 @@ static void restore_term(void)
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
@@ -75,9 +82,10 @@ static int enable_non_canonical(void)
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
@@ -97,9 +105,42 @@ static void restore_term(void)
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
@@ -135,15 +176,11 @@ static int disable_bits(DWORD bits)
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
@@ -361,6 +398,16 @@ int read_key_without_echo(struct strbuf *buf)
 
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

