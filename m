Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7D9C2D0DA
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EBA2073B
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJFZlagn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLYL5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:57:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34905 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfLYL5F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 06:57:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so19799956edv.2
        for <git@vger.kernel.org>; Wed, 25 Dec 2019 03:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SoINhosxY8bQOCleNIF9uXXAb4CbGyczHohOpNqVWPc=;
        b=gJFZlagnC2IsuVPOAnt9ydtTJntEYwo16y87akXw4asDTTATPMot/mai2iTQ9QS8Mh
         W94O68mAT5kBVbEfkrVg3ubgq+wSjyexzEkgZuooQx3GzBBBbRV9CZBG0vek9PQrjo7G
         SjccLXVcvSWX/09yGp0fv4B1Tc9mlI/4cd5IYosO7bSCHojAturgQ5J/jP+9rL05t55Z
         ZX5mApdWqYOejMTCxHG1UcM3wt4M/Dp85XECKtAMoZ2NAVyRkTbPp46112TocYzNmTF6
         fX0T6Uh29tLsm7LRHFHNyguliyUC3Y5Wd3epvGPWuwaUp7oTPS4DH5JoHn3GhulUvflM
         SEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SoINhosxY8bQOCleNIF9uXXAb4CbGyczHohOpNqVWPc=;
        b=W4qSOPDA01OeHmyIiSZPZtCO+VMPSvviOz/J353zE2zVRaRVrE8UZPksFr2v/KyWPZ
         tUtPmUajGAkeLvPGdF6dJ4hUvwmoHXML7xzRHCAIiy4X+7XRY1VCwKArKDZ6UhvT+ECd
         /Ro5cojjfy03KpsBZEXj0OXzV5GRORcEyaw/IGi2ElWv76o/qq3IliSkBbSY4KlzbqK4
         hHbhBsbGRni9unJU4x8I8GARZqLGEpGds9QCBJ+1zTqOxXg8O+W4lhmFM4KGDkrhXv3x
         bAu1CD40zIADu2HzvB7nF7FpN5l4dgRQyZN07X9wOXuBAo2PA7g9EBMM9kdCO50weQ2J
         Cvgg==
X-Gm-Message-State: APjAAAXWPbVYBumQCw+DxrDAVlcr2gUS0TRm8icl9TjbJkcpbogelNjw
        5K2weiqYqt6ReoFnyTlaioOI+/jA
X-Google-Smtp-Source: APXvYqxXrHfMAMzThYCOGk6mZj5HamgzyUmaN2/nondKIJm2tWQkWpqBeMHgCk74uZFUm+6fGXuOmQ==
X-Received: by 2002:aa7:d415:: with SMTP id z21mr44325388edq.264.1577275024295;
        Wed, 25 Dec 2019 03:57:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm3058964edy.91.2019.12.25.03.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 03:57:03 -0800 (PST)
Message-Id: <e643554dba2b18259d097ee98a9aa1fbbdf8f8c7.1577275020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
        <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Dec 2019 11:56:54 +0000
Subject: [PATCH v2 3/9] terminal: make the code of disable_echo() reusable
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

