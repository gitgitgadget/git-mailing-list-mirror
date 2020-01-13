Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24889C33CAF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E0921744
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nk5uoJJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAMI3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:29:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40653 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgAMI3h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 03:29:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so7545559wrn.7
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 00:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SoINhosxY8bQOCleNIF9uXXAb4CbGyczHohOpNqVWPc=;
        b=nk5uoJJt61o6d9de+Qyz6G13nUazFICoXsXzutKU6n+fimcO04Nj4MfGwU3XIEhuD4
         6EcK8zFqvbQNl6ozuWAy4EBIldOTNrh3P6TxijrEBsZmTkqmTIT+vHjxPg1rRkEiMgct
         fhtvKA5YcqCXKJB8HTufDO5fXbBQEFhw64t2o8RFOwj5rg5ejZw5SYhBnHwOEvBRDChm
         nbmt7B5yAaQQHXxsxsdmD9ct/wuxWYYLeCaNuQ2KjE90gc3iglCeN2IUwpZRYie0ucz0
         tlvTnncH3R8EEE+We/yEpE6XJ/MMwrf33HneJIVQRcWdnwnjwzbsevfPbtmfND3+BMhQ
         azaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SoINhosxY8bQOCleNIF9uXXAb4CbGyczHohOpNqVWPc=;
        b=BBUfFSXzqb8M3L111zetQdaHTsQCcFv+mfBlNKLSCOI2v8ZEUoPbC81mULjrDPXx1W
         q5q+NPLCRuYjQc9JN5c/c/oIMOGLz0nIgg084KzJ+Ddf2S5UiHpYih38pUdTQL3yS/ML
         zXXqWouP9ezN4oTOa6zgoOXmHRFskEwS1qmPVU70UCezB/gVS0NaqVEiAun0M33pp53B
         RMIW6htuw1Vz5Bmm/czXFgu4RisbmCsVp0nnmLIHnLzOBXLknLDiWxOS+/TQ7PH2gSsw
         wzreZEtqrI+5NNcPDLQlXrkxiEVGVMRVushMpmwfrhGYOlG5aGpZjX8RDBKfj1fHtI56
         PhSg==
X-Gm-Message-State: APjAAAXNk6BP0TWS+/U1w74CjbibV50uh5US44BusdQvxDYiVrpLRIfQ
        ijXm/eZlsRxP+w73/LnF9AwOFsUF
X-Google-Smtp-Source: APXvYqxu0jf2nu4IrhxJKEypMRH4bfsTu8QOF8G/OeOIpIyipd2kbEtqxkdGIovqkoAUqE2TbXRFWw==
X-Received: by 2002:adf:ee45:: with SMTP id w5mr16532774wro.352.1578904175572;
        Mon, 13 Jan 2020 00:29:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d14sm14629239wru.9.2020.01.13.00.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:29:35 -0800 (PST)
Message-Id: <be40a37c0c3b47e12ecb4423ea03f4592b8ea4ec.1578904171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
        <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jan 2020 08:29:25 +0000
Subject: [PATCH v3 04/10] terminal: make the code of disable_echo() reusable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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

