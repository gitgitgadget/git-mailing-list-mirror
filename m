Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A9C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 18:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357814AbiCPSzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357803AbiCPSzc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 14:55:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2723221E2C
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:54:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d7so4277157wrb.7
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=tw+9Nm2jbV7lxRhjbSy7DihHLfAAMIGRzwUVP1j4pyo=;
        b=baW1aeaLPnML0jJI/RuT8ky9c3soXQs25QCMHrlJFr8jclsQ2h8IY95rUIGJUyBg3E
         0vPt9bKzgocSU8IvHLqyiary3Wg9TwX9OEuUgCBW6irXACUnFEIQQSOnKUr7lpWmeNa2
         dSQusSCEu5gOYQvb4qWiXhVp6n6TysGc05UBToEe395FnRqTV2QR2A/pAnxJ4gM0jbD/
         TthvdTtJ75FvLbB14+t9HfVuHfFVqNlEwAI2qWyQakrs4s4O2zvQ7TPv+xxai7c+B1TS
         IfOy63vOBkjdYZ1guK8cuJzRs5/yqg9eH7HyBJnf2ko2rL092m+Wfrv3DI9Xa6rlbl+2
         Y4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=tw+9Nm2jbV7lxRhjbSy7DihHLfAAMIGRzwUVP1j4pyo=;
        b=cYZZz+enEGFqdcmopZsegtUv9BffinZVe0ISzxeH59zGhbNF1sdi2LUfzKQV90NPMF
         ozafkQvD/R3GjQYRtbW9d++pA0yGpH1tvR8PONRfW1/PtTSpe6DfEyx3HZbIYZjOTI00
         0Q2JfQ6Ch1oLSZZz2t7B7G8cxNncq+RvrcbxgUyEfrOA5TdVo4wzgk33RsBpmLgUTlf8
         LAJQllHA3ldDGZShd+JyDhA6FOZn6vMbRFiKYB5ZWIY8ql2icXLv7Aw8ST6lW/AgRBDG
         x1jo2uMV7lGxRmLHD6DCrBbMcYeEw6IrJclYq+bj5nrW9FPE0u9WyOsa1fDvfuh0iqA2
         YxAQ==
X-Gm-Message-State: AOAM532Pvpn7ijpVaMOLFF5MnVza42S0QRfhDmw9ZzgL+uy3wCU/VWj7
        0jlEjPTs/Psufz1tPRIU38y2Tr1+dQBS2A==
X-Google-Smtp-Source: ABdhPJyVanthhl7ljrXclKD7WQIK0qR9NGHAB2I4LVtAHHfjF/MeJWM1oCUR6uSZe8Hzj6zStVJNKg==
X-Received: by 2002:adf:fe81:0:b0:1f0:246e:ae5 with SMTP id l1-20020adffe81000000b001f0246e0ae5mr1035563wrr.652.1647456855700;
        Wed, 16 Mar 2022 11:54:15 -0700 (PDT)
Received: from localhost.localdomain (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm2409144wrw.91.2022.03.16.11.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 11:54:15 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 4/4] terminal: restore settings on SIGTSTP
Date:   Wed, 16 Mar 2022 18:54:05 +0000
Message-Id: <20220316185405.29551-5-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316185405.29551-1-phillip.wood123@gmail.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220316185405.29551-1-phillip.wood123@gmail.com>
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
 compat/terminal.c | 132 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 3 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 2ae8a6f13e..7db330c52d 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "compat/terminal.h"
 #include "sigchain.h"
 #include "strbuf.h"
@@ -24,6 +24,102 @@ static volatile sig_atomic_t term_fd_needs_closing;
 static int term_fd = -1;
 static struct termios old_term;
 
+static const char *background_resume_msg;
+static const char *restore_error_msg;
+static volatile sig_atomic_t ttou_received;
+
+/* async safe error function for use by signal handlers. */
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
 	if (term_fd_needs_closing)
@@ -40,10 +136,13 @@ void restore_term(void)
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
 		term_fd = ((flags & SAVE_TERM_STDIN)
 			   ? 0
@@ -56,6 +155,26 @@ int save_term(enum save_term_flags flags)
 		return -1;
 	}
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
@@ -78,6 +197,7 @@ static int disable_bits(enum save_term_flags flags, tcflag_t bits)
 		return 0;
 
 	sigchain_pop_common();
+	reset_job_signals();
 	close_term_fd();
 	return -1;
 }
@@ -102,6 +222,7 @@ static int getchar_with_timeout(int timeout)
 	fd_set readfds;
 	int res;
 
+ again:
 	if (timeout >= 0) {
 		tv.tv_sec = timeout / 1000;
 		tv.tv_usec = (timeout % 1000) * 1000;
@@ -111,9 +232,14 @@ static int getchar_with_timeout(int timeout)
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

