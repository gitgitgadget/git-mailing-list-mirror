Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1CBC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 11:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiCILFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 06:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiCILFM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 06:05:12 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D087CE902
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 03:04:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so3110208wms.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 03:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=gBBWGGf+ajwLZb9/2dlAU59Gd3RM6T/+YGhGYuEGcFI=;
        b=SGH3xrGXjcUfETq9gM9OSxiEmCVw4/uGlBPlemg/nIj9n27dIJuOkEZcESHrN816HT
         lHOL5WQ5dyFTM2fyiD/CRRYApmPnHqAsFlUUq/q3KvoHERFzhQb9LHp1gpvyrsb49+E/
         mxe9xH+3vmxLJ6B2h738uRKgxzjpncI+KfRiYY3sujyMryFe43UnfoVx506p5OV75Fp4
         /RCJ/Ouv9IzK/ISM4Boj399dF6orZ5pMJIH/+3kb/mzF0cGbwZXxyFj9t8A4dbixvXa8
         tHBwzr+wiRz5ezoKl5rdUJFjUsSlmlnvIRZs00LiS4SCzsghRwVLzY83cDr/i6jau76m
         OO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=gBBWGGf+ajwLZb9/2dlAU59Gd3RM6T/+YGhGYuEGcFI=;
        b=MMMGPRXAv+KP8+vajJWeSi3qoiB2n5QDL/WUNynH2oBqgB1t5mPW/laH6OAoJWuRz1
         tX5B+KZANwPhaG1y0qt4vJ/JnLMAnWWYrtfQBwWqAdNGv1vp0lzc+hy1RRUYgFG3p/ts
         brtFvf2kqNRXxggppPIFe+DgmCKuY/j5nmLQJDNu4T03OOFiRULB44z2c6ff4Sf1WsBB
         h0qumnLxg0/TuqfXb9dK0FCLMxurNQtlf2wlJKvpdrK+0taNpQuIZrVTcuryccD09r1M
         BrJtTAtWGAtmBr1ZeJhN59hZ3E/VFByW0ni7ytQeG6OI2l9Sxc1Un00/EmjwxdBDOZq6
         1TmQ==
X-Gm-Message-State: AOAM531+XjEDeYU1mKiNXKquRgeejw+KaYQdCbKTSCzE6RjqVeAhuUPI
        8+IBlDdH6kpP9dx3OPmeI1EsYCgQSZk=
X-Google-Smtp-Source: ABdhPJyj9Dd1Mh8Av/kLjTfxgcMujsHa+r3viBBW3OhKlZwEHUBraXkA2fRKzqMvL99B5avMx8kOug==
X-Received: by 2002:a05:600c:2056:b0:389:736a:5631 with SMTP id p22-20020a05600c205600b00389736a5631mr7225937wmg.120.1646823851707;
        Wed, 09 Mar 2022 03:04:11 -0800 (PST)
Received: from localhost.localdomain (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm2072203wrt.63.2022.03.09.03.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:04:11 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 4/4] terminal: restore settings on SIGTSTP
Date:   Wed,  9 Mar 2022 11:03:25 +0000
Message-Id: <20220309110325.36917-5-phillip.wood123@gmail.com>
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

If the user suspends git while it is waiting for a keypress reset the
terminal before stopping and restore the settings when git resumes. If
the user tries to resume in the background print an error
message (taking care to use async safe functions) before stopping
again. Ideally we would reprint the prompt for the user when git
resumes but this patch just restarts the read().

The signal handler is established with sigaction() rather than using
sigchain_push() as this allows us to control the signal mask when the
handler is invoked and ensure SA_RESTART is used to restart the
read() when resuming.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 compat/terminal.c | 125 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 4 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 4189cbb12c..f425f7b339 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "compat/terminal.h"
 #include "sigchain.h"
 #include "strbuf.h"
@@ -23,6 +23,90 @@ static void restore_term_on_signal(int sig)
 static int term_fd = -1;
 static struct termios old_term;
 
+static const char *background_resume_msg;
+static const char *restore_error_msg;
+static volatile sig_atomic_t ttou_received;
+
+static void write_err(const char *msg)
+{
+	write_in_full(2, "error: ", strlen("error: "));
+	write_in_full(2, msg, strlen(msg));
+	write_in_full(2, "\n", 1);
+}
+
+static void print_background_resume_msg(int signo)
+{
+	int saved_errno = errno;
+	sigset_t mask;
+	struct sigaction old_sa;
+	struct sigaction sa = { .sa_handler = SIG_DFL };
+
+	ttou_received = 1;
+	write_err(background_resume_msg);
+	sigaction(signo, &sa, &old_sa);
+	raise(signo);
+	sigemptyset(&mask);
+	sigaddset(&mask, signo);
+	sigprocmask(SIG_UNBLOCK, &mask, NULL);
+	/* Stopped here */
+	sigprocmask(SIG_BLOCK, &mask, NULL);
+	sigaction(signo, &old_sa, NULL);
+	errno = saved_errno;
+}
+
+static void restore_terminal_on_suspend(int signo)
+{
+	int saved_errno = errno;
+	int res;
+	struct termios t;
+	sigset_t mask;
+	struct sigaction old_sa;
+	struct sigaction sa = { .sa_handler = SIG_DFL };
+	int can_restore = 1;
+
+	if (tcgetattr(term_fd, &t) < 0)
+		can_restore = 0;
+
+	if (tcsetattr(term_fd, TCSAFLUSH, &old_term) < 0)
+		write_err(restore_error_msg);
+
+	sigaction(signo, &sa, &old_sa);
+	raise(signo);
+	sigemptyset(&mask);
+	sigaddset(&mask, signo);
+	sigprocmask(SIG_UNBLOCK, &mask, NULL);
+	/* Stopped here */
+	sigprocmask(SIG_BLOCK, &mask, NULL);
+	sigaction(signo, &old_sa, NULL);
+	if (!can_restore) {
+		write_err(restore_error_msg);
+		goto out;
+	}
+	/*
+	 * If we resume in the background then we receive SIGTTOU when calling
+	 * tcsetattr() below. Set up a handler to print an error message in that
+	 * case.
+	 */
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGTTOU);
+	sa.sa_mask = old_sa.sa_mask;
+	sa.sa_handler = print_background_resume_msg;
+	sa.sa_flags = SA_RESTART;
+	sigaction(SIGTTOU, &sa, &old_sa);
+ again:
+	ttou_received = 0;
+	sigprocmask(SIG_UNBLOCK, &mask, NULL);
+	res = tcsetattr(term_fd, TCSAFLUSH, &t);
+	sigprocmask(SIG_BLOCK, &mask, NULL);
+	if (ttou_received)
+		goto again;
+	else if (res < 0)
+		write_err(restore_error_msg);
+	sigaction(SIGTTOU, &old_sa, NULL);
+ out:
+	errno = saved_errno;
+}
+
 void restore_term(void)
 {
 	if (term_fd < 0)
@@ -32,10 +116,19 @@ void restore_term(void)
 	close(term_fd);
 	term_fd = -1;
 	sigchain_pop_common();
+	if (restore_error_msg) {
+		signal(SIGTTIN, SIG_DFL);
+		signal(SIGTTOU, SIG_DFL);
+		signal(SIGTSTP, SIG_DFL);
+		restore_error_msg = NULL;
+		background_resume_msg = NULL;
+	}
 }
 
 int save_term(enum save_term_flags flags)
 {
+	struct sigaction sa;
+
 	if (term_fd < 0)
 		term_fd = (flags & SAVE_TERM_STDIN) ? 0
 						    : open("/dev/tty", O_RDWR);
@@ -44,6 +137,26 @@ int save_term(enum save_term_flags flags)
 	if (tcgetattr(term_fd, &old_term) < 0)
 		return -1;
 	sigchain_push_common(restore_term_on_signal);
+	/*
+	 * If job control is disabled then the shell will have set the
+	 * disposition of SIGTSTP to SIG_IGN.
+	 */
+	sigaction(SIGTSTP, NULL, &sa);
+	if (sa.sa_handler == SIG_IGN)
+		return 0;
+
+	/* avoid calling gettext() from signal handler */
+	background_resume_msg = _("cannot resume in the background, please use 'fg' to resume");
+	restore_error_msg = _("cannot restore terminal settings");
+	sa.sa_handler = restore_terminal_on_suspend;
+	sa.sa_flags = SA_RESTART;
+	sigemptyset(&sa.sa_mask);
+	sigaddset(&sa.sa_mask, SIGTSTP);
+	sigaddset(&sa.sa_mask, SIGTTIN);
+	sigaddset(&sa.sa_mask, SIGTTOU);
+	sigaction(SIGTSTP, &sa, NULL);
+	sigaction(SIGTTIN, &sa, NULL);
+	sigaction(SIGTTOU, &sa, NULL);
 
 	return 0;
 }
@@ -93,6 +206,7 @@ static int getchar_with_timeout(int timeout)
 	fd_set readfds;
 	int res;
 
+ again:
 	if (timeout >= 0) {
 		tv.tv_sec = timeout / 1000;
 		tv.tv_usec = (timeout % 1000) * 1000;
@@ -102,9 +216,12 @@ static int getchar_with_timeout(int timeout)
 	FD_ZERO(&readfds);
 	FD_SET(0, &readfds);
 	res = select(1, &readfds, NULL, NULL, tvp);
-	if (res < 0)
-		return EOF;
-
+	if (res < 0) {
+		if (errno == EINTR)
+			goto again;
+		else
+			return EOF;
+	}
 	return getchar();
 }
 
-- 
2.35.1

