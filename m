Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB446C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1200206D8
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PshyA10m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLUWmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:42:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35812 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfLUWmF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:42:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so12074800edv.2
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 14:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SoINhosxY8bQOCleNIF9uXXAb4CbGyczHohOpNqVWPc=;
        b=PshyA10mtQdOpTKk9D17ZdTRUrGhmYfVbhqpXuf4Fj4yjNrmWN1XYBQMtB2ouWmb6s
         m9Qpeut2+VcWPlmdEn5iUbTDhKb/ct2bsWyemlEVBuZ+SOA11ICu7l6Z1QHTA1oHQXPB
         x33UK7BaExGej7UWhYGLeBxvW+qe7c+Eh2DIYxury2JdVsW0Wmax+pZkJoVZr4QauHj2
         S3o1+LvO4P3jonQviN6ndZyyY5JqMjMcJ/UxN+/2VWYdp5p12KqefmS4qn/fTMhbNu05
         kMg3TJC6oKllZITgcK3po3NxZiFt4hRD1jlhp8GfgzYafe7Lw3gogUkluXD3hnDG4r+S
         4kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SoINhosxY8bQOCleNIF9uXXAb4CbGyczHohOpNqVWPc=;
        b=XSrR6AWE6soaYVVvqZMD/8gBXFRydWRSiagHzmfHoUTTyxzou9ZAZ0RGNXNTs4PVgY
         p2JHy6d10iX0SIhrGKX1q2VZc3dqByDK8Mc0+U6NyUsCDIYAv+Vi9A/4lR9EXZdFX8DA
         CExY4lBA2F07JI/kssbkN0F2AAqtVm2AqUZbJhicXWBKJ5cbEnGt+QF56FTYr7fullvi
         UFm6aJ/OlFlgzpK9LZKYXfd7aQ2JLisFA4EUUXxiIkHoP1nxdtudtjdVbYsLgluKO1eL
         AwGjz8uM03lomO79pZtTaif4USfpYjcxp2x3KuRwzoZXQHRKlGox1scXJHZqYD7bD62+
         I4AA==
X-Gm-Message-State: APjAAAUnDBRLYtf22RUU+rjT1yBs/rnpnsDCJZpB7adKnilmyIFI2kjU
        AndyX5/ha1RuEamZvNNY6KyyM8lM
X-Google-Smtp-Source: APXvYqyp9oQCJ+evKzdf2vSaTSRNXoMu1qxpOjOUeT886U76H/1XhMKl99yC5Pptuw8802UJPDSM+A==
X-Received: by 2002:a05:6402:799:: with SMTP id d25mr24533336edy.221.1576968123943;
        Sat, 21 Dec 2019 14:42:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p24sm1570530eds.17.2019.12.21.14.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 14:42:03 -0800 (PST)
Message-Id: <7631c1ea8c82154581eaaed9dcc278a011897282.1576968120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.git.1576968120.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 22:41:54 +0000
Subject: [PATCH 3/9] terminal: make the code of disable_echo() reusable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to introduce the function `enable_non_canonical()`, which
shares almost the complete code with `disable_echo()`.

Let's prepare for that, by refactoring out that shared code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/terminal.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index fa13ee672d..1fb40b3a0a 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -32,7 +32,7 @@ static void restore_term(void)
 	term_fd = -1;
 }
 
-static int disable_echo(void)
+static int disable_bits(tcflag_t bits)
 {
 	struct termios t;
 
@@ -43,7 +43,7 @@ static int disable_echo(void)
 	old_term = t;
 	sigchain_push_common(restore_term_on_signal);
 
-	t.c_lflag &= ~ECHO;
+	t.c_lflag &= ~bits;
 	if (!tcsetattr(term_fd, TCSAFLUSH, &t))
 		return 0;
 
@@ -53,6 +53,11 @@ static int disable_echo(void)
 	return -1;
 }
 
+static int disable_echo(void)
+{
+	return disable_bits(ECHO);
+}
+
 #elif defined(GIT_WINDOWS_NATIVE)
 
 #define INPUT_PATH "CONIN$"
@@ -72,7 +77,7 @@ static void restore_term(void)
 	hconin = INVALID_HANDLE_VALUE;
 }
 
-static int disable_echo(void)
+static int disable_bits(DWORD bits)
 {
 	hconin = CreateFile("CONIN$", GENERIC_READ | GENERIC_WRITE,
 	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
@@ -82,7 +87,7 @@ static int disable_echo(void)
 
 	GetConsoleMode(hconin, &cmode);
 	sigchain_push_common(restore_term_on_signal);
-	if (!SetConsoleMode(hconin, cmode & (~ENABLE_ECHO_INPUT))) {
+	if (!SetConsoleMode(hconin, cmode & ~bits)) {
 		CloseHandle(hconin);
 		hconin = INVALID_HANDLE_VALUE;
 		return -1;
@@ -91,6 +96,12 @@ static int disable_echo(void)
 	return 0;
 }
 
+static int disable_echo(void)
+{
+	return disable_bits(ENABLE_ECHO_INPUT);
+}
+
+
 #endif
 
 #ifndef FORCE_TEXT
-- 
gitgitgadget

