Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27135C4332F
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 10:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiCOK7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348037AbiCOK6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 06:58:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7495F2C139
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:57:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d7so1297561wrb.7
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=w0qwFQfT1BZRPW3fR4lJeO50Re3yWhTEJ4yjVHkMpzU=;
        b=PrNPgpo1jvMgOvHpw9z6j9xQOQbIsseKOm4skwpdgMmEsv9+MYSBNNS4wmPh8ckb6N
         VnhIVmmcg4cFYu1evQPJwu2alVnuBSkpScvHhedVRtso60b6+sLocsjO42sMOJj5eYYS
         4cZmfrxHm2XM34HYhUIigJFNkadXfyWn5pfR3R65CoU8yP+E48a6QfJBSztXbzF1pByO
         Hey3J0Zm7TBKVhNIys8LcxdCWpWcET0DamG+hd27abuk7MwwE6dAFYmxOAyAtuBxbtdo
         WM6PC0BXAHjAnkBxGgUWH10Ex0K3PjHpvRIIMNxiIGj244rtU/4g6+FRhvKt+2/78WPl
         l7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=w0qwFQfT1BZRPW3fR4lJeO50Re3yWhTEJ4yjVHkMpzU=;
        b=iLLIE/PADBCNXbmKMEmApDxdwY2odazw6Ba5yY4ts961QXTdDSUTekGRv9/s+wMPge
         v4NntVBDKSgcQIjpAKB3fZAzY35PMCujvm9RMtlaqSLVwp59bYqgSxxwu9RQlrNJhQTk
         0sAsX+0f+/KEE5f/qLwNm2RfIDXmAVAAFhTi+82GiGFZzeiH0XH6wHJq+oWRggUD7s5o
         iKLMFsZ0sV9qJrW/5UBsisum0SEuNpB49oKmBQp6Geexluvvyo2hcO82swa0sTjMKlRL
         jtk9PF7egQd1kNzN38eGRbc4fs1JOUMqfaAaFENpRxloWYi9+mouWI1BK/sH3DQNVUwN
         5nSg==
X-Gm-Message-State: AOAM533KoodTqfUSOi5QiGE+DNftRY+vsR4lySBQKBYsPCywb9trIB3d
        nn/bRjfnPG2CXHPpUXR7EM4ZaMTX/GreIA==
X-Google-Smtp-Source: ABdhPJxrNJDWsbE8Fk5on45TwFbh2rXvQUHhtpMaCzkiW7Hu6TpQ9EX+whpu9aRjccvOYs/vzLijhQ==
X-Received: by 2002:a5d:590f:0:b0:203:7fca:72a8 with SMTP id v15-20020a5d590f000000b002037fca72a8mr19272444wrd.310.1647341860844;
        Tue, 15 Mar 2022 03:57:40 -0700 (PDT)
Received: from localhost.localdomain (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id p16-20020adff210000000b001f062b80091sm15038530wro.34.2022.03.15.03.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 03:57:40 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 0/4] builtin add -p: hopefully final readkey fixes
Date:   Tue, 15 Mar 2022 10:57:19 +0000
Message-Id: <20220315105723.19398-1-phillip.wood123@gmail.com>
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

Thanks to Ævar, Carlo and Dscho for their comments on V2.
Changes since V2:
 * Patch 1
   - fix save_term() prototype (thanks to Carlo)
 * Patch 2
   - avoid closing tty_fd if it is stdin
 * Patch 3
   - removed redundant #include (thanks to Ævar)
   - handle select() timeout correctly
 * Patch 4
   - reset job signals if settcattr() fails

These patches are based on a merge of pw/single-key-interactive and
master. There are a couple of simple textual conflicts with
'cb/save-term-across-editor-invocation' and unfortunately some
semantic conflicts as well. A diff on top of the textual resolution
which handles the semantic conflicts is given after the range-diff at
the end of this message.

V2 Cover Letter:

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

 compat/terminal.c | 226 +++++++++++++++++++++++++++++++++++++++-------
 compat/terminal.h |   9 +-
 2 files changed, 202 insertions(+), 33 deletions(-)

Range-diff against v2:
1:  fac5a0f5b7 ! 1:  2c4c5424d7 terminal: use flags for save_term()
    @@ compat/terminal.h
       * failure.
       */
     -int save_term(int full_duplex);
    -+int save_term(unsigned flags);
    ++int save_term(enum save_term_flags flags);
      /* Restore the terminal attributes that were saved with save_term() */
      void restore_term(void);
      
2:  bf29460ec6 ! 2:  cf9275c40c terminal: don't assume stdin is /dev/tty
    @@ Commit message
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## compat/terminal.c ##
    -@@ compat/terminal.c: void restore_term(void)
    +@@ compat/terminal.c: static void restore_term_on_signal(int sig)
    + static int term_fd = -1;
    + static struct termios old_term;
    + 
    ++static void close_term_fd(void)
    ++{
    ++	if (term_fd)
    ++		close(term_fd);
    ++	term_fd = -1;
    ++}
    ++
    + void restore_term(void)
    + {
    + 	if (term_fd < 0)
    + 		return;
    + 
    + 	tcsetattr(term_fd, TCSAFLUSH, &old_term);
    +-	close(term_fd);
    +-	term_fd = -1;
    ++	close_term_fd();
    + 	sigchain_pop_common();
    + }
    + 
      int save_term(enum save_term_flags flags)
      {
      	if (term_fd < 0)
    @@ compat/terminal.c: void restore_term(void)
      	if (term_fd < 0)
      		return -1;
      	if (tcgetattr(term_fd, &old_term) < 0)
    +@@ compat/terminal.c: static int disable_bits(enum save_term_flags flags, tcflag_t bits)
    + 
    + 	sigchain_pop_common();
    + error:
    +-	close(term_fd);
    +-	term_fd = -1;
    ++	close_term_fd();
    + 	return -1;
    + }
    + 
     @@ compat/terminal.c: int read_key_without_echo(struct strbuf *buf)
      	static int warning_displayed;
      	int ch;
3:  1815606e82 ! 3:  4828d63ce5 terminal: work around macos poll() bug
    @@ compat/terminal.c: static int enable_non_canonical(enum save_term_flags flags)
     + * On macos it is not possible to use poll() with a terminal so use select
     + * instead.
     + */
    -+#include <sys/select.h>
     +static int getchar_with_timeout(int timeout)
     +{
     +	struct timeval tv, *tvp = NULL;
    @@ compat/terminal.c: static int enable_non_canonical(enum save_term_flags flags)
     +	FD_ZERO(&readfds);
     +	FD_SET(0, &readfds);
     +	res = select(1, &readfds, NULL, NULL, tvp);
    -+	if (res < 0)
    ++	if (res <= 0)
     +		return EOF;
     +
     +	return getchar();
    @@ compat/terminal.c: int read_key_without_echo(struct strbuf *buf)
     -			ch = getchar();
     +			ch = getchar_with_timeout(500);
      			if (ch == EOF)
    - 				return 0;
    + 				break;
      			strbuf_addch(buf, ch);
4:  dd0e1fabb1 ! 4:  3185bc5223 terminal: restore settings on SIGTSTP
    @@ compat/terminal.c: static void restore_term_on_signal(int sig)
     +	errno = saved_errno;
     +}
     +
    - void restore_term(void)
    - {
    - 	if (term_fd < 0)
    -@@ compat/terminal.c: void restore_term(void)
    - 	close(term_fd);
    - 	term_fd = -1;
    - 	sigchain_pop_common();
    ++static void reset_job_signals(void)
    ++{
     +	if (restore_error_msg) {
     +		signal(SIGTTIN, SIG_DFL);
     +		signal(SIGTTOU, SIG_DFL);
     +		signal(SIGTSTP, SIG_DFL);
     +		restore_error_msg = NULL;
     +		background_resume_msg = NULL;
     +	}
    ++}
    ++
    + static void close_term_fd(void)
    + {
    + 	if (term_fd)
    +@@ compat/terminal.c: void restore_term(void)
    + 	tcsetattr(term_fd, TCSAFLUSH, &old_term);
    + 	close_term_fd();
    + 	sigchain_pop_common();
    ++	reset_job_signals();
      }
      
      int save_term(enum save_term_flags flags)
    @@ compat/terminal.c: int save_term(enum save_term_flags flags)
      
      	return 0;
      }
    +@@ compat/terminal.c: static int disable_bits(enum save_term_flags flags, tcflag_t bits)
    + 		return 0;
    + 
    + 	sigchain_pop_common();
    ++	reset_job_signals();
    + error:
    + 	close_term_fd();
    + 	return -1;
     @@ compat/terminal.c: static int getchar_with_timeout(int timeout)
      	fd_set readfds;
      	int res;
    @@ compat/terminal.c: static int getchar_with_timeout(int timeout)
      	FD_ZERO(&readfds);
      	FD_SET(0, &readfds);
      	res = select(1, &readfds, NULL, NULL, tvp);
    --	if (res < 0)
    --		return EOF;
    +-	if (res <= 0)
    ++	if (!res)
    + 		return EOF;
     -
     +	if (res < 0) {
     +		if (errno == EINTR)

Semantic conflict resolution:
---- >8 ----
diff --git a/compat/terminal.c b/compat/terminal.c
index bffb1340ab..9a64b9a431 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -150,9 +150,8 @@ int save_term(enum save_term_flags flags)
                                                    : open("/dev/tty", O_RDWR);
        if (term_fd < 0)
                return -1;
-       if (full_duplex && !is_controlling_terminal(term_fd)) {
-               close(term_fd);
-               term_fd = -1;
+       if (flags & SAVE_TERM_DUPLEX && !is_controlling_terminal(term_fd)) {
+               close_term_fd();
                return -1;
        }
        if (tcgetattr(term_fd, &old_term) < 0)
diff --git a/editor.c b/editor.c
index 6c5c95e6a2..192d6ea75d 100644
--- a/editor.c
+++ b/editor.c
@@ -55,7 +55,7 @@ static int prepare_term(const char *editor)

        git_config_get_bool("editor.stty", &need_saverestore);
        if (need_saverestore)
-               return save_term(1);
+               return save_term(SAVE_TERM_DUPLEX);
        return 0;
 }

-- 
2.35.1

