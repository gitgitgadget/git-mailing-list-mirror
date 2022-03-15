Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35E9C433FE
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 10:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347670AbiCOK7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348038AbiCOK6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 06:58:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421B531DC1
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:57:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r7so432524wmq.2
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=a99DTiyebHzumtArYWAw5QFtDcxbm+7E/kL+LkfoINs=;
        b=asyH8zENqeZInonmw0zb6CmwYvafFYG+bvzVDl9fXr6NEvBybEAutSd7SwRrv2fojC
         0+cgZFm3NQeFzutrtZpq0z7dRlZ9jnZHAF4q51HEvP3d6FHTVKbkMkKITAbsXtIfura3
         Oe/gD/wqn9VehzLaJlb92XZKylVXDC9f6xaIhfyZfmQtNfxQk7ucIfPtmQ5uOWJE31XD
         5pyBdNj4sxiM8aTd8zMbzzE3dYaz8xe9qNrhb8agZWnXl/bVH6W6H3PHNEwIdt+8ef+9
         YUf1zJaNHEiEuuX6RIb4GNSSaBFsOdbnC5Dex9CUwNQxugKkcFQfEESYTvw9liiFZkBc
         X9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=a99DTiyebHzumtArYWAw5QFtDcxbm+7E/kL+LkfoINs=;
        b=Ry4MEoyhcaal5DoKdTr7IR0BDAss8HjlvIsEP+jYlXLbUDdQXImMhqhYGPG5ruvbtF
         vBE1FqBDHhcSZCpxh3hjAAINewy0EJ5SeeSyFcnpBUyyt+jVKXWwzW69D+VjteRg8G+c
         LbnmTEk2LDG/pA04X6eGrvaX7r+X3YVfzEL0wrye3N0HqSOATzclb3K/2ern6vZHncLL
         DXo6OEdFbYxiaxN+job0GENRm8ynwKnsUVozK4iuNPd3Asq7RgSTJ3pEWmE1gy20vU/4
         KhpD87KLu+DOQSjG+Bo71nyJdFClg+V9hxNTILvCtrhVac4sYYUqix4LDNFtB0HJlF6W
         IZ4Q==
X-Gm-Message-State: AOAM533y3F+iPZTsXJy01xS4hSpn0Ev8R0Ozz+XD6FbWjzVZiHhsfp6A
        Jxx9JZPpAB0gTj1SMb2XRubAA5NhJYfQ9Q==
X-Google-Smtp-Source: ABdhPJz+D/kQKQ8qCc7LPbpYGOOd0sop5iv5XQtjEcH7ZOre9o96jFIO/nlasN0/EkryEpEHxc3GaQ==
X-Received: by 2002:a05:600c:19d1:b0:389:7772:b21b with SMTP id u17-20020a05600c19d100b003897772b21bmr2860027wmq.118.1647341861635;
        Tue, 15 Mar 2022 03:57:41 -0700 (PDT)
Received: from localhost.localdomain (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id p16-20020adff210000000b001f062b80091sm15038530wro.34.2022.03.15.03.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 03:57:41 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 1/4] terminal: use flags for save_term()
Date:   Tue, 15 Mar 2022 10:57:20 +0000
Message-Id: <20220315105723.19398-2-phillip.wood123@gmail.com>
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

