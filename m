Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54988C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 10:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347253AbiCOK7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348053AbiCOK66 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 06:58:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813DE0C6
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:57:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b19so5992979wrh.11
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=2Dz0Cg11TBTd3hbbW9Jl0JfyYu6ZMfBwRlrVF6zr67E=;
        b=CbBCtHx4Qy80jshwzDkGfjS0mmIaT7169rHXXj7FBvGqhSAo7q7iYOaQ3pDvgzs1ed
         TBZ1OOk753XuOhG9O2Qvs2lDHwn1BeD0lBkK97IDh45wedxng4f8Kk3zaY7DpG3XXmWq
         iJodasGLJYcV2AZdgHbLATtBJr7yHE3ps9j4iKAt/tNC/95IA8ZsVmbtQU3vRNhaG8oh
         wYlfgMLcKWQVTgHbKf49RGj9zFssEo2JJKy7408GoUdexRi5U+6yF4qH4t9jtP06/zPO
         KKCL97e7tytW2x8aRjfteUjMmoKnVar/egz7tIdc8LlHPuZwWvkKD5MVosZhOVKJurIw
         0+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=2Dz0Cg11TBTd3hbbW9Jl0JfyYu6ZMfBwRlrVF6zr67E=;
        b=L4+Omn1QuT6sLG2mgacZH/iU2uIRFSPxAgUVmk86z/ZD4a/z9s4pe7Eb9NRZ7nYOkk
         PoAF9PAEnF9Tpqxz3bLqy8nekS64uhibd8WNyUTVAgXDmZ02v+imxZU7HwMxgwNQN/gG
         htz/Y9bsCcTd+G5ZiAlLVdg+4lOI4ujKzj1gMdgtFaCZt8ElJoL2VSt77XQH0qHpONtP
         H07G8ZO1tJhKruyVJHsNRKYbFU/IVqovqbOIe/32r/38Iz31Z4CpXXeLaP2xFDTFfvGY
         boBOtnCw0sta8kkaoQIfd5mbTpnbRudTFeFM1rWj8e17NM9jvjzNpC1Ihn3rZXLO9DKG
         cXwg==
X-Gm-Message-State: AOAM532zXHenYqLj4+1nau5/TRt1xs9sogrkXznwwdmqMneOBxtzgllA
        NazNo9jkhCv7dS0+0QAOHZgZ5snHKk7y5Q==
X-Google-Smtp-Source: ABdhPJyXJrb8lV3HHaGf8eGB/JitYqz1djkutFaTtS0qhKuKyILIiWfJZODHi7WAdgSg8G3lzf0fOA==
X-Received: by 2002:a5d:6746:0:b0:203:d6c1:9c5b with SMTP id l6-20020a5d6746000000b00203d6c19c5bmr1615288wrw.446.1647341864321;
        Tue, 15 Mar 2022 03:57:44 -0700 (PDT)
Received: from localhost.localdomain (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id p16-20020adff210000000b001f062b80091sm15038530wro.34.2022.03.15.03.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 03:57:44 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 4/4] terminal: restore settings on SIGTSTP
Date:   Tue, 15 Mar 2022 10:57:23 +0000
Message-Id: <20220315105723.19398-5-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315105723.19398-1-phillip.wood123@gmail.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220315105723.19398-1-phillip.wood123@gmail.com>
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
 compat/terminal.c | 131 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 128 insertions(+), 3 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 89f326adc1..45a9084bb3 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "compat/terminal.h"
 #include "sigchain.h"
 #include "strbuf.h"
@@ -23,6 +23,101 @@ static void restore_term_on_signal(int sig)
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
+static void reset_job_signals(void)
+{
+	if (restore_error_msg) {
+		signal(SIGTTIN, SIG_DFL);
+		signal(SIGTTOU, SIG_DFL);
+		signal(SIGTSTP, SIG_DFL);
+		restore_error_msg = NULL;
+		background_resume_msg = NULL;
+	}
+}
+
 static void close_term_fd(void)
 {
 	if (term_fd)
@@ -38,10 +133,13 @@ void restore_term(void)
 	tcsetattr(term_fd, TCSAFLUSH, &old_term);
 	close_term_fd();
 	sigchain_pop_common();
+	reset_job_signals();
 }
 
 int save_term(enum save_term_flags flags)
 {
+	struct sigaction sa;
+
 	if (term_fd < 0)
 		term_fd = (flags & SAVE_TERM_STDIN) ? 0
 						    : open("/dev/tty", O_RDWR);
@@ -50,6 +148,26 @@ int save_term(enum save_term_flags flags)
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
@@ -72,6 +190,7 @@ static int disable_bits(enum save_term_flags flags, tcflag_t bits)
 		return 0;
 
 	sigchain_pop_common();
+	reset_job_signals();
 error:
 	close_term_fd();
 	return -1;
@@ -97,6 +216,7 @@ static int getchar_with_timeout(int timeout)
 	fd_set readfds;
 	int res;
 
+ again:
 	if (timeout >= 0) {
 		tv.tv_sec = timeout / 1000;
 		tv.tv_usec = (timeout % 1000) * 1000;
@@ -106,9 +226,14 @@ static int getchar_with_timeout(int timeout)
 	FD_ZERO(&readfds);
 	FD_SET(0, &readfds);
 	res = select(1, &readfds, NULL, NULL, tvp);
-	if (res <= 0)
+	if (!res)
 		return EOF;
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

