Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52132C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 18:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357806AbiCPSzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357793AbiCPSza (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 14:55:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4AA21818
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:54:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a1so2897483wrh.10
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=knoVMDKEHi1vepotLQ32wXGXLLrr3wy6O+9448po9Q8=;
        b=hzKQBtuHdiOu2fkFlZqjWBgbroN+1RRNDGzYfit1wppVivj5WpoxUbSzdKZi2F8KaD
         Ih9Y+S4w5QBVne2/ke1jtKFC4sfba5Kvr0goQCeXSy5UrbFbMV6xK5z6mR4JU9Ll/IDP
         thWYaKTtHrYYQuX4e5Tg2SeCUdB37lyTgpXCL1AhDpw9/Q44FtSINKqMaL7Dii8KiCLs
         tloxBqqLx46P1+TCX+sJ9La7KEY+cwgzo9juUmF6pDK6WgR3JKMDXWlr0HdpndP33LDS
         f+qmxW9rAHlwICKNGYZEn/NpHx2Xi8eLUnKdB1YB3gJ92b8bfSRQK7ee4t7oRKsIEQuj
         +71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=knoVMDKEHi1vepotLQ32wXGXLLrr3wy6O+9448po9Q8=;
        b=nZTX/TxQIkp2EIbnebjUIZM+wsTH6iuah2y/UIPz1O8EfaZ5h16FZ8L9/cvkUc9NFp
         VuSsjCfh4BZhgBr2xNYo4vtwK9c1okDYrxb9udjxZcfksO4VulcX0H+cjCuMNwBBgzlh
         g12222Gdrj0R0O7FyOrmuM1GfU9LNcxUk3djq9u/SOXWqBGtbfg65x2re1ZRhzc1AD/v
         ubepcZRQO/Et/B/6MoMSj2cXrnHvbIpBb7yGmj3Cbqqxnl629YT1ZrhQBZsneceRyV7Q
         LKYJImvop7e/t/U5ISIJWkgHysDGcVaIwZoGUr7DlCSsVNB9YKVILqdvEVf05ssW2wP8
         9V3w==
X-Gm-Message-State: AOAM531YQO9lMeNMQvPXDMoSZsJ/tR294MlaG4qyIy1F9fd68P3lWTTA
        gmafhbwIUifE+JJtdMGeXCANU5n7SwkIDw==
X-Google-Smtp-Source: ABdhPJwWBT51BLYo8HX6OmaWLLnXAnoLIBP2UPrgblBB2X4z/K9J6HiU3Heql1VLea2yEfFaR8gMEw==
X-Received: by 2002:adf:ec02:0:b0:203:e0c5:ab14 with SMTP id x2-20020adfec02000000b00203e0c5ab14mr1015532wrn.95.1647456853994;
        Wed, 16 Mar 2022 11:54:13 -0700 (PDT)
Received: from localhost.localdomain (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm2409144wrw.91.2022.03.16.11.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 11:54:13 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 2/4] terminal: don't assume stdin is /dev/tty
Date:   Wed, 16 Mar 2022 18:54:03 +0000
Message-Id: <20220316185405.29551-3-phillip.wood123@gmail.com>
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
 compat/terminal.c | 29 ++++++++++++++++++++---------
 compat/terminal.h |  2 ++
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index da2f788137..4893294eb6 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -20,28 +20,41 @@ static void restore_term_on_signal(int sig)
 #define INPUT_PATH "/dev/tty"
 #define OUTPUT_PATH "/dev/tty"
 
+static volatile sig_atomic_t term_fd_needs_closing;
 static int term_fd = -1;
 static struct termios old_term;
 
+static void close_term_fd(void)
+{
+	if (term_fd_needs_closing)
+		close(term_fd);
+	term_fd_needs_closing = 0;
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
+		term_fd = ((flags & SAVE_TERM_STDIN)
+			   ? 0
+			   : open("/dev/tty", O_RDWR));
 	if (term_fd < 0)
 		return -1;
-	if (tcgetattr(term_fd, &old_term) < 0)
+	term_fd_needs_closing = !(flags & SAVE_TERM_STDIN);
+	if (tcgetattr(term_fd, &old_term) < 0) {
+		close_term_fd();
 		return -1;
+	}
 	sigchain_push_common(restore_term_on_signal);
 
 	return 0;
@@ -52,7 +65,7 @@ static int disable_bits(enum save_term_flags flags, tcflag_t bits)
 	struct termios t;
 
 	if (save_term(flags) < 0)
-		goto error;
+		return -1;
 
 	t = old_term;
 
@@ -65,9 +78,7 @@ static int disable_bits(enum save_term_flags flags, tcflag_t bits)
 		return 0;
 
 	sigchain_pop_common();
-error:
-	close(term_fd);
-	term_fd = -1;
+	close_term_fd();
 	return -1;
 }
 
@@ -362,7 +373,7 @@ int read_key_without_echo(struct strbuf *buf)
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

