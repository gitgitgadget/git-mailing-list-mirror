Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8750FC53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 14:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjAHOdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 09:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHOdH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 09:33:07 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D4BFAEE
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 06:33:05 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m7so5722649wrn.10
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 06:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hmy6EhS9MeJBOFTnGIwlUmTlZJ4HFoRdT+v4I7H8V74=;
        b=KY0ksxWMIPEIwn9LtjTli2D10H05Jnbwd0pnH4H2ebYTV6aOWsm/djEQp0U7q36ihs
         OYrWcUyAC6KxwpHAkDDDpSnlApoITLYlw5ORM+JqgjoZ49cDeVq+dkPrM1WiNOy3ExG6
         D3rkqh9/cEFHY7mrGQaco3e6Bqf+0ngQJgQdW9aUiMWAQPmKmOjz8jYROFxlbhIX0RZ7
         5Tz/OKWd31fWiXV3V2xfZevUJj+kSPdPtbOpNRusAly/TndKUzL/kGUqLI1zRabF/9Dr
         gOBRGXr6D4ToXoKOmnNDuJ4iTXpnBv9rkmW4RVkOPLtItLzHE4aoDgCWlVnqjszQGvwW
         F2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hmy6EhS9MeJBOFTnGIwlUmTlZJ4HFoRdT+v4I7H8V74=;
        b=lkcFhqz4BT4fDXRExXWS3ydPaP/KZpsPezYl3sq+h3wEGE0DXS5qO0/wc/+5BXjeVL
         0XFwHSUJS0Y7kVD7nabGQQ7pTV24R9BLGc0habE1xtP7qxzhCfo5lTTDtOKCpITfCvYe
         rNl6nVR66v7yeoj7kfMLWStLoGp7xYU4+RwG3AhjY/MGw9rovdKvp6KPmpeF1uskfd2z
         VJXfTH4uoZHXPJux5MAup4etDBnuGBzh1FBjOHzOrkY4P6yomUGqTox8Er6RW2p2G1g5
         q3UJQuQ9XFS7wwTEBWqXASsL0p1qlttX59h12ukGFDNNYq6kkv/3kukVpllL8GiSq/5I
         B6+g==
X-Gm-Message-State: AFqh2kp74ulKuzZlE3AzOPFHEJLfojs4zlJvf1SQI/1td+6HIv3riKpu
        VRxVSXbs0SMozrAH0mpwJTjyvH7Q3D4=
X-Google-Smtp-Source: AMrXdXt6SwVXBuOvAN0ZbI5SCfcWO7/jN3kbFbYdVjsxiH/c72ahpPXOYprWuBnrcffBi15NDIVmiw==
X-Received: by 2002:adf:f011:0:b0:2ba:e2b3:118 with SMTP id j17-20020adff011000000b002bae2b30118mr6148943wro.44.1673188383551;
        Sun, 08 Jan 2023 06:33:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d404a000000b00275970a85f4sm6110030wrp.74.2023.01.08.06.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 06:33:03 -0800 (PST)
Message-Id: <pull.1423.v2.git.git.1673188382186.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.git.git.1672768772484.gitgitgadget@gmail.com>
References: <pull.1423.git.git.1672768772484.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Jan 2023 14:33:02 +0000
Subject: [PATCH v2] run-command: make async_exit usage consistent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Use async_exit instead of pthread_exit,
and make async_exit inline.

Functions were reordered
so that this would compile.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    run-command: make async_exit usage consistent
    
    Use async_exit instead of pthread_exit, and make async_exit inline.
    
    Finally, make the parameter an unsigned int, because the Win32 API uses
    unsigned int, and for other platforms, we cast to void anyway.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1423%2FAtariDreams%2Fconsistency-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1423/AtariDreams/consistency-v2
Pull-Request: https://github.com/git/git/pull/1423

Range-diff vs v1:

 1:  b5f29059d79 ! 1:  d4cf19107ed run-command: make async_exit usage consistent
     @@ Commit message
          Functions were reordered
          so that this would compile.
      
     -    Luckily, the order remains consistent.
     -
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
       ## run-command.c ##


 run-command.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/run-command.c b/run-command.c
index 756f1839aab..e1eab4cb69b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1030,6 +1030,18 @@ static void *run_thread(void *data)
 	return (void *)ret;
 }
 
+int in_async(void)
+{
+	if (!main_thread_set)
+		return 0; /* no asyncs started yet */
+	return !pthread_equal(main_thread, pthread_self());
+}
+
+static inline void NORETURN async_exit(int code)
+{
+	pthread_exit((void *)(intptr_t)code);
+}
+
 static NORETURN void die_async(const char *err, va_list params)
 {
 	report_fn die_message_fn = get_die_message_routine();
@@ -1042,7 +1054,7 @@ static NORETURN void die_async(const char *err, va_list params)
 			close(async->proc_in);
 		if (async->proc_out >= 0)
 			close(async->proc_out);
-		pthread_exit((void *)128);
+		async_exit(128);
 	}
 
 	exit(128);
@@ -1055,18 +1067,6 @@ static int async_die_is_recursing(void)
 	return ret != NULL;
 }
 
-int in_async(void)
-{
-	if (!main_thread_set)
-		return 0; /* no asyncs started yet */
-	return !pthread_equal(main_thread, pthread_self());
-}
-
-static void NORETURN async_exit(int code)
-{
-	pthread_exit((void *)(intptr_t)code);
-}
-
 #else
 
 static struct {
@@ -1112,7 +1112,7 @@ int in_async(void)
 	return process_is_async;
 }
 
-static void NORETURN async_exit(int code)
+static inline void NORETURN async_exit(int code)
 {
 	exit(code);
 }

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
