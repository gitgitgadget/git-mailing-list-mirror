Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0C1C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 10:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242648AbiCOK7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348039AbiCOK6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 06:58:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8E535269
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:57:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b19so5992839wrh.11
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=lnnWJ4rUdFcclnTXVMW9FMPghhyIQq8RedCrWKs8LIY=;
        b=H5mN95vq9qNLaKb4TPYSncZb/SZc6fjAszfZkxSqKpEuk4W8oVed+i+awvFkJ4QU1/
         tFO9k0LwIGy/DZ5/w4Ge+T82auBKN4ckJ6WFhWrFE88eRAQVJnlz4X+6EEXDu6Qu/TIO
         RJG/1jU+PxKGWndqLBP+0ppUVWTxUBA68gWvDapXRfZxcjPmuRH7njCV1SkoIclbxjhN
         M2chxDkqW2os8pmyepY1Ww9SbcoNhN3z2cSYHDXgXJRuPY7O3KxpkUKLFh72I28Q8HOT
         veLUHig4J7topCHJM9opw1cjcTwzUgcw/3rOp5P8e7uAr1RrOnrTo4cl1o2PlmuZ/0fa
         l5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=lnnWJ4rUdFcclnTXVMW9FMPghhyIQq8RedCrWKs8LIY=;
        b=saH/Zo7kk6MBP8SJttgIQC+/Ts63IWU+zCKdOAC5/YbbzxkOBqQOyYp7tQhsCyVYG2
         /veBAfV4275iCNd8ZWTX2WZNd0SxnT0ZXmYUNef80Rwer5j24RPPjGBPvxkF12ZB2hTd
         v67UTGKKeAyh4LB7lW6Q378lHa1bQHh4W5yfoHvV2S2wH+GqrvYhZbzIxF8aegUX3jAq
         84v2VTUcVPFWiSdkWc4aPESwa+YZJIQKCeh8lq+Et+a3Y0B6qdEk0vF5RAmfkM201Ktt
         PvIS2JqCa/P9motdPUMASjFOVjrv2I1Dy3zsKzp7qZGDLzailtWlfBuwu7/dVqaU9yJ7
         Mmyg==
X-Gm-Message-State: AOAM530/j5/hbfgdMQ11x0P07RCo4UsnkxltGUDe0PPibQ6/Z04HKNYe
        qKWd6nBzW8rxi9xOdV9hsrMGjJvjo/p02A==
X-Google-Smtp-Source: ABdhPJy9lufaIicKE7IwdPcTZbTQH7uqpWBeRk3bQxsnbWfR6JtarZpMbdVAJeBC2IXjfr+10G8NGQ==
X-Received: by 2002:adf:ff92:0:b0:1f1:1754:b3c2 with SMTP id j18-20020adfff92000000b001f11754b3c2mr20414900wrr.655.1647341862559;
        Tue, 15 Mar 2022 03:57:42 -0700 (PDT)
Received: from localhost.localdomain (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id p16-20020adff210000000b001f062b80091sm15038530wro.34.2022.03.15.03.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 03:57:42 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 2/4] terminal: don't assume stdin is /dev/tty
Date:   Tue, 15 Mar 2022 10:57:21 +0000
Message-Id: <20220315105723.19398-3-phillip.wood123@gmail.com>
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

read_key_without_echo() reads from stdin but uses /dev/tty when it
disables echo. This is unfortunate as there no guarantee that stdin is
the same device as /dev/tty. The perl version of "add -p" uses stdin
when it sets the terminal mode, this commit does the same for the
builtin version. There is still a difference between the perl and
builtin versions though - the perl version will ignore any errors when
setting the terminal mode[1] and will still read single bytes when
stdin is not a terminal. The builtin version displays a warning if
setting the terminal mode fails and switches to reading a line at a
time.

[1] https://github.com/jonathanstowe/TermReadKey/blob/b061c913bbf7ff9bad9b4eea6caae189eacd6063/ReadKey.xs#L1090

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 compat/terminal.c | 18 ++++++++++++------
 compat/terminal.h |  2 ++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index da2f788137..bfbde3c1af 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -23,21 +23,28 @@ static void restore_term_on_signal(int sig)
 static int term_fd = -1;
 static struct termios old_term;
 
+static void close_term_fd(void)
+{
+	if (term_fd)
+		close(term_fd);
+	term_fd = -1;
+}
+
 void restore_term(void)
 {
 	if (term_fd < 0)
 		return;
 
 	tcsetattr(term_fd, TCSAFLUSH, &old_term);
-	close(term_fd);
-	term_fd = -1;
+	close_term_fd();
 	sigchain_pop_common();
 }
 
 int save_term(enum save_term_flags flags)
 {
 	if (term_fd < 0)
-		term_fd = open("/dev/tty", O_RDWR);
+		term_fd = (flags & SAVE_TERM_STDIN) ? 0
+						    : open("/dev/tty", O_RDWR);
 	if (term_fd < 0)
 		return -1;
 	if (tcgetattr(term_fd, &old_term) < 0)
@@ -66,8 +73,7 @@ static int disable_bits(enum save_term_flags flags, tcflag_t bits)
 
 	sigchain_pop_common();
 error:
-	close(term_fd);
-	term_fd = -1;
+	close_term_fd();
 	return -1;
 }
 
@@ -362,7 +368,7 @@ int read_key_without_echo(struct strbuf *buf)
 	static int warning_displayed;
 	int ch;
 
-	if (warning_displayed || enable_non_canonical(0) < 0) {
+	if (warning_displayed || enable_non_canonical(SAVE_TERM_STDIN) < 0) {
 		if (!warning_displayed) {
 			warning("reading single keystrokes not supported on "
 				"this platform; reading line instead");
diff --git a/compat/terminal.h b/compat/terminal.h
index aeb24c9478..79ed00cf61 100644
--- a/compat/terminal.h
+++ b/compat/terminal.h
@@ -4,6 +4,8 @@
 enum save_term_flags {
 	/* Save input and output settings */
 	SAVE_TERM_DUPLEX = 1 << 0,
+	/* Save stdin rather than /dev/tty (fails if stdin is not a terminal) */
+	SAVE_TERM_STDIN  = 1 << 1,
 };
 
 /*
-- 
2.35.1

