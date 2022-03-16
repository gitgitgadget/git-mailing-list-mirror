Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D69C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 18:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357804AbiCPSzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353551AbiCPSz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 14:55:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FA721806
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:54:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j26so4312357wrb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=a99DTiyebHzumtArYWAw5QFtDcxbm+7E/kL+LkfoINs=;
        b=Dmuin9tZT1h6wgQwPsmUUK4Zw9zizdFeWmDSnmNRRMOC9G96UBQDQJxFQh5BUm4fr8
         IJSPAZVHZdEHw7XAYdnBaL3KdMJr6FuV+ZIT6citki3dD2qzin6k6D/49ZpBNbldgQiT
         BQvxWMLko37jOTihIPuflpJZ0LCLUQLSomJ+GI29tcJNwm4UsKZv/HabNC8pwbl+hn1J
         ZQVKLxPW1n5NPUxEm8o4YrjvA0hT3zi0CEbjEWvP5PNLBnRbSbFflHXvWtQHY55wMkoa
         pbJdwNlrA+Z0EQTGiEKf77PogGkYoSgDKWR1UT41ddSZUTuYjT+DGVA1qo2FTv+nV4Dc
         +eSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=a99DTiyebHzumtArYWAw5QFtDcxbm+7E/kL+LkfoINs=;
        b=c6ZnNSB8HsUxiHucH0KEFFbofy75InvbNszWvEnyOQaVFGD4S+It3nTgC+qhx0fjrr
         Uv5IHs88mIihmfW8dmHBD+CRn514Tl856QYvA6Z1ew+8nJpeit0Z3NgUnrjnUv0J94d7
         Jac7BpCIRneeITRUBm5wjNfQlvCpO+aV8z/EZTUpx2Qw+cRudfa931sCIJBGAWepXuEZ
         mn8Q3sNTyaRVzXstrRUyUqq/XRNFVOo/Jal6+wWS74ebdnGBKgive1o1QLn4R0RmC09U
         hQ7MNXQmJw2aqvhNU1UJ+v7JrEZj9sVfhFuhKlHynUwRrzl8EvOnPWE45LOlFYoB32R4
         nF7g==
X-Gm-Message-State: AOAM533Jn1uHH2Zp6vXgSh6AxvMJTP+/+W93f8IizKjfTk5UveSp3VQ3
        3jAwgmmHSb2SjbdnoWVEomaQYUetIVMhaw==
X-Google-Smtp-Source: ABdhPJzy9++qvQ6fs1yAgnhKYgdST2k+AWvcREkSA2sCsccdYvqGDDgUxK/WptPC6+jAZMH3SSTHzw==
X-Received: by 2002:adf:fcce:0:b0:203:dcdb:dd80 with SMTP id f14-20020adffcce000000b00203dcdbdd80mr992832wrs.455.1647456853067;
        Wed, 16 Mar 2022 11:54:13 -0700 (PDT)
Received: from localhost.localdomain (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm2409144wrw.91.2022.03.16.11.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 11:54:12 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 1/4] terminal: use flags for save_term()
Date:   Wed, 16 Mar 2022 18:54:02 +0000
Message-Id: <20220316185405.29551-2-phillip.wood123@gmail.com>
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
index 3620184e79..da2f788137 100644
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
index 0fb9fa147c..aeb24c9478 100644
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
+int save_term(enum save_term_flags flags);
 /* Restore the terminal attributes that were saved with save_term() */
 void restore_term(void);
 
-- 
2.35.1

