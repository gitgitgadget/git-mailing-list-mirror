Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B77BC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 11:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiCILFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 06:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiCILFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 06:05:09 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465F5C625F
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 03:04:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so2381705wrg.11
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 03:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=Ot8JKa/CBd1MI9VYvNL2WL8Jebjor3qPtD+N51Q5Ozs=;
        b=CQfZCLjQ0KxflzB9+yKe9vMzKeGFsk0ILcWOtgbEzeq1gdFmxVLjzNI0YB4ZFfCvXH
         n2/mAFbzn6a0vPmeJdxco4bPSmn8Q0PzHcUYz1UlrNXUfxKmvzSCFlQGH2SuycR0zYJi
         v/LrVimuqPiCSkG2vAw0hWk5iyVYA5/319mNJE1xHA7uiWiL7gYNfTS4N7X/FnEvgQNq
         k81xPn7Wy+RpMLaasA/sdXOky/CRFsSgVuDMmtLGzZBwD7EEKdJgbiNTU0g3XIQ1Icr8
         yxVt9ADYRt86IYCho0L4j8jX8neFp73ZjS805ebpy4zsFiXKd9c6yAGC1+gVeGq7kiuH
         qOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=Ot8JKa/CBd1MI9VYvNL2WL8Jebjor3qPtD+N51Q5Ozs=;
        b=XYOn3lzX1JSyQrCsQNa8VGLE6NH52+XfMtG85DxuZ/IqQ5ypCaUlKaTkWyT4/wTQ1e
         yHpLW/lxlrebf9umG1IN9xFMORXnP8J9/R4Oiur0Dz18O6ReKNrgqKgi9M1h2muhlRpc
         82ftwAPH28XdD3j+6UIpGJ7p/nYpIGIZVLve4VHYuQGQR7VXBvDLYcemtSg+I/JG+T2x
         OZk7+vdsmOUpJDjm+nOp73p8cTkBuKur4OMUifKQ9QUaezdj04JbmUOCD9FgR2x+3EJx
         DIdco5e114LTD6lTSnrO6guKKlwbKuwgY7QlNf/etXF33Wq0ua7O5cCVCHriXUqmo/OF
         g+ow==
X-Gm-Message-State: AOAM530we/ipVmYkIMaUJTQ4wY6ZZQ6mlanPybv2jx22GKV4lBh7pZzt
        r/odPeEFWlb77gJlOt2sM4syjZtF4ks=
X-Google-Smtp-Source: ABdhPJwOb3hm7eD1VCmXh3qv8k3CxUuv74lVAZtHK3xiyMlh/LGuCUKe059vsgfwO5XMMGYrtMEFOA==
X-Received: by 2002:a5d:4a0f:0:b0:1ed:d377:288a with SMTP id m15-20020a5d4a0f000000b001edd377288amr15407940wrq.3.1646823848611;
        Wed, 09 Mar 2022 03:04:08 -0800 (PST)
Received: from localhost.localdomain (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm2072203wrt.63.2022.03.09.03.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:04:08 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 0/4] builtin add -p: hopefully final readkey fixes
Date:   Wed,  9 Mar 2022 11:03:21 +0000
Message-Id: <20220309110325.36917-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304131126.8293-1-phillip.wood123@gmail.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks to Ramsay and Ævar for their comments on V1.
Changes since V1:
 * Patch 1
   - use an enum for save_term()'s flags (suggested by Ævar)
   - fixed argument order in the windows code (thanks to Ramsay)
 * Patch 2
   - fixed a typo in a comment (thanks to Ramsay)
 * Patch 4
   - stopped duplicating the strings returned by gettext() (suggested by
     Ævar)
   - reworked error message handling in the signal handler to add an
     "error: " prefix (suggested by Ævar)
   - tweaked the background resume error message

V1 Cover Letter:

Fix the remaining issues that I'm aware of when using the built in
"add -p" with interactive.singlekey that are stopping it from being
merged to master. The first three patches make sure that we call
tcsetattr() and the same file descriptor that we use for read() and
work around poll() being broken when reading from terminals on
macos. The final patch is more of an improvement rather than a bug fix
(the same issue already exists in the perl version) and could proceed
separately.

Unfortunately these patches conflict with
'cb/save-term-across-editor-invocation' as well as the textual
conflicts there is a semantic conflict as the argument to save_term()
is changed so the code in editor.c will need updating.

These patches are based on 'pw/single-key-interactive'

Phillip Wood (4):
  terminal: use flags for save_term()
  terminal: don't assume stdin is /dev/tty
  terminal: work around macos poll() bug
  terminal: restore settings on SIGTSTP

 compat/terminal.c | 206 +++++++++++++++++++++++++++++++++++++++-------
 compat/terminal.h |   9 +-
 2 files changed, 186 insertions(+), 29 deletions(-)

Range-diff against v1:
1:  6961a4e0dc ! 1:  fac5a0f5b7 terminal: use flags for save_term()
    @@ Commit message
         terminal: use flags for save_term()
     
         The next commit will add another flag in addition to the existing
    -    full_duplex so change the function signature to take an unsigned flags
    +    full_duplex so change the function signature to take a flags
         argument. Also alter the functions that call save_term() so that they
         can pass flags down to it.
     
    +    The choice to use an enum for tho bitwise flags is because gdb will
    +    display the symbolic names of all the flags that are set rather than
    +    the integer value.
    +
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## compat/terminal.c ##
    @@ compat/terminal.c: void restore_term(void)
      }
      
     -int save_term(int full_duplex)
    -+int save_term(unsigned flags)
    ++int save_term(enum save_term_flags flags)
      {
      	if (term_fd < 0)
      		term_fd = open("/dev/tty", O_RDWR);
    @@ compat/terminal.c: int save_term(int full_duplex)
      }
      
     -static int disable_bits(tcflag_t bits)
    -+static int disable_bits(unsigned flags, tcflag_t bits)
    ++static int disable_bits(enum save_term_flags flags, tcflag_t bits)
      {
      	struct termios t;
      
    @@ compat/terminal.c: static int disable_bits(tcflag_t bits)
      }
      
     -static int disable_echo(void)
    -+static int disable_echo(unsigned flags)
    ++static int disable_echo(enum save_term_flags flags)
      {
     -	return disable_bits(ECHO);
     +	return disable_bits(flags, ECHO);
      }
      
     -static int enable_non_canonical(void)
    -+static int enable_non_canonical(unsigned flags)
    ++static int enable_non_canonical(enum save_term_flags flags)
      {
     -	return disable_bits(ICANON | ECHO);
     +	return disable_bits(flags, ICANON | ECHO);
    @@ compat/terminal.c: void restore_term(void)
      }
      
     -int save_term(int full_duplex)
    -+int save_term(unsigned flags)
    ++int save_term(enum save_term_flags flags)
      {
      	hconin = CreateFileA("CONIN$", GENERIC_READ | GENERIC_WRITE,
      	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
    @@ compat/terminal.c: int save_term(int full_duplex)
      }
      
     -static int disable_bits(DWORD bits)
    -+static int disable_bits(unsigned flags, DWORD bits)
    ++static int disable_bits(enum save_term_flags flags, DWORD bits)
      {
      	if (use_stty) {
      		struct child_process cp = CHILD_PROCESS_INIT;
    @@ compat/terminal.c: static int disable_bits(DWORD bits)
      }
      
     -static int disable_echo(void)
    -+static int disable_echo(unsigned flags)
    ++static int disable_echo(enum save_term_flags flags)
      {
     -	return disable_bits(ENABLE_ECHO_INPUT);
    -+	return disable_bits(ENABLE_ECHO_INPUT, flags);
    ++	return disable_bits(flags, ENABLE_ECHO_INPUT);
      }
      
     -static int enable_non_canonical(void)
    -+static int enable_non_canonical(unsigned flags)
    ++static int enable_non_canonical(enum save_term_flags flags)
      {
     -	return disable_bits(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT);
    -+	return disable_bits(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT,
    -+			    flags);
    ++	return disable_bits(flags,
    ++			    ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT);
      }
      
      /*
    @@ compat/terminal.c: int read_key_without_echo(struct strbuf *buf)
      #else
      
     -int save_term(int full_duplex)
    -+int save_term(unsigned flags)
    ++int save_term(enum save_term_flags flags)
      {
     -	/* full_duplex == 1, but no support available */
     -	return -full_duplex;
    @@ compat/terminal.h
      #ifndef COMPAT_TERMINAL_H
      #define COMPAT_TERMINAL_H
      
    -+/* Save input and output settings */
    -+#define SAVE_TERM_DUPLEX (1u << 0)
    ++enum save_term_flags {
    ++	/* Save input and output settings */
    ++	SAVE_TERM_DUPLEX = 1 << 0,
    ++};
     +
      /*
       * Save the terminal attributes so they can be restored later by a
2:  45315087d4 ! 2:  bf29460ec6 terminal: don't assume stdin is /dev/tty
    @@ Commit message
     
      ## compat/terminal.c ##
     @@ compat/terminal.c: void restore_term(void)
    - int save_term(unsigned flags)
    + int save_term(enum save_term_flags flags)
      {
      	if (term_fd < 0)
     -		term_fd = open("/dev/tty", O_RDWR);
    @@ compat/terminal.c: int read_key_without_echo(struct strbuf *buf)
     
      ## compat/terminal.h ##
     @@
    + enum save_term_flags {
    + 	/* Save input and output settings */
    + 	SAVE_TERM_DUPLEX = 1 << 0,
    ++	/* Save stdin rather than /dev/tty (fails if stdin is not a terminal) */
    ++	SAVE_TERM_STDIN  = 1 << 1,
    + };
      
    - /* Save input and output settings */
    - #define SAVE_TERM_DUPLEX (1u << 0)
    --
    -+/* Save stdin rather than /dev/tty (fails is stdin is not a terminal) */
    -+#define SAVE_TERM_STDIN  (1u << 1)
      /*
    -  * Save the terminal attributes so they can be restored later by a
    -  * call to restore_term(). Note that every successful call to
4:  62703be209 ! 4:  dd0e1fabb1 terminal: restore settings on SIGTSTP
    @@ compat/terminal.c: static void restore_term_on_signal(int sig)
      static int term_fd = -1;
      static struct termios old_term;
      
    -+static char *background_resume_msg;
    -+static char *restore_error_msg;
    ++static const char *background_resume_msg;
    ++static const char *restore_error_msg;
     +static volatile sig_atomic_t ttou_received;
     +
    -+static void write_msg(const char *msg)
    ++static void write_err(const char *msg)
     +{
    ++	write_in_full(2, "error: ", strlen("error: "));
     +	write_in_full(2, msg, strlen(msg));
     +	write_in_full(2, "\n", 1);
     +}
    @@ compat/terminal.c: static void restore_term_on_signal(int sig)
     +	struct sigaction sa = { .sa_handler = SIG_DFL };
     +
     +	ttou_received = 1;
    -+	write_msg(background_resume_msg);
    ++	write_err(background_resume_msg);
     +	sigaction(signo, &sa, &old_sa);
     +	raise(signo);
     +	sigemptyset(&mask);
    @@ compat/terminal.c: static void restore_term_on_signal(int sig)
     +		can_restore = 0;
     +
     +	if (tcsetattr(term_fd, TCSAFLUSH, &old_term) < 0)
    -+		write_msg(restore_error_msg);
    ++		write_err(restore_error_msg);
     +
     +	sigaction(signo, &sa, &old_sa);
     +	raise(signo);
    @@ compat/terminal.c: static void restore_term_on_signal(int sig)
     +	sigprocmask(SIG_BLOCK, &mask, NULL);
     +	sigaction(signo, &old_sa, NULL);
     +	if (!can_restore) {
    -+		write_msg(restore_error_msg);
    ++		write_err(restore_error_msg);
     +		goto out;
     +	}
     +	/*
    @@ compat/terminal.c: static void restore_term_on_signal(int sig)
     +	if (ttou_received)
     +		goto again;
     +	else if (res < 0)
    -+		write_msg(restore_error_msg);
    ++		write_err(restore_error_msg);
     +	sigaction(SIGTTOU, &old_sa, NULL);
     + out:
     +	errno = saved_errno;
    @@ compat/terminal.c: void restore_term(void)
     +		signal(SIGTTIN, SIG_DFL);
     +		signal(SIGTTOU, SIG_DFL);
     +		signal(SIGTSTP, SIG_DFL);
    -+		FREE_AND_NULL(restore_error_msg);
    -+		FREE_AND_NULL(background_resume_msg);
    ++		restore_error_msg = NULL;
    ++		background_resume_msg = NULL;
     +	}
      }
      
    - int save_term(unsigned flags)
    + int save_term(enum save_term_flags flags)
      {
     +	struct sigaction sa;
     +
      	if (term_fd < 0)
      		term_fd = (flags & SAVE_TERM_STDIN) ? 0
      						    : open("/dev/tty", O_RDWR);
    -@@ compat/terminal.c: int save_term(unsigned flags)
    +@@ compat/terminal.c: int save_term(enum save_term_flags flags)
      	if (tcgetattr(term_fd, &old_term) < 0)
      		return -1;
      	sigchain_push_common(restore_term_on_signal);
    @@ compat/terminal.c: int save_term(unsigned flags)
     +		return 0;
     +
     +	/* avoid calling gettext() from signal handler */
    -+	background_resume_msg = xstrdup(_("error: cannot resume in the background"));
    -+	restore_error_msg = xstrdup(_("error: cannot restore terminal settings"));
    ++	background_resume_msg = _("cannot resume in the background, please use 'fg' to resume");
    ++	restore_error_msg = _("cannot restore terminal settings");
     +	sa.sa_handler = restore_terminal_on_suspend;
     +	sa.sa_flags = SA_RESTART;
     +	sigemptyset(&sa.sa_mask);
-- 
2.35.1

