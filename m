Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FADC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 04:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiLUEfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 23:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLUEfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 23:35:22 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6401DDCF
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:35:21 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y8so772614wrl.13
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jCFmtjFa6NkoEOvK0kAFkBDx50KDfl4QPayb9Wuu+c=;
        b=GinTDVUsb4PzN4++BMwH2/4oSF5TwCcDvzOITWAxjpPrVQ5+CRZRq27AIckZaDo1iH
         jG/ThHivmDSCCCWENvNF61OJH/dz1IlTgGb11GICV1T+BQxemD3ovlkUhMbjX1JpdzV/
         S8I3h9FUrCic0dNp38Lytk0E6BO8QwKMfmo4jex4nc6fTdBruKxprzAJmCbLvk+mrUEl
         dOege1xMfInz8ud0zLUwL5HOxFP/YEFmF4Mrt1lJ/E5bMjJIkQo7j0hJQ6GDxrjppKso
         GfqUpkoT8jId2JN7nRcn7u7dO5lEgFMA4q1c/PjQ/QAnrwiD1TvZc2JuCZI35cAvaMnq
         qmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jCFmtjFa6NkoEOvK0kAFkBDx50KDfl4QPayb9Wuu+c=;
        b=fEm3YwpyLUikawj36rdMrTWl6EdjmVkcPvvhtX9reP5CiJ3G2jABNtxJDRSli8R9Iy
         W3vKc4fE2oOxgBGr9CmXgoyN5qkZ+tMc+eMOUcAsXyjKYKKMOoyb+8yZdpZ9Ft1gGT8L
         Sp3KLNGI/O8OEJbcayt8DGKlcUxFNcSko3ltY4vyfP3xppAePd8RR1y6pKp/tekmv7Uc
         W/ZP9rpZrmJqkmw/ZNvnLREFDHg+z1SsuUjpL4mRy96e8+m1OjxH1PZ+s9tWJ+DEYmft
         B0yLBrSARlCbkhSmx38K++HvNeUYNNEUKkiC45lavvRpfTLpfLvhdthvMlc71ZC7rTI9
         t92g==
X-Gm-Message-State: AFqh2kp4jNaNTzaaybFNa8Dr3sQTqcUvYsZRALl1WU/lxe3ARYRFmr7A
        AYBfBP/DtynT0IRjiVekDe5+04ReiQk=
X-Google-Smtp-Source: AMrXdXsFqpBpKlm14MoVw+pvXjOIbN1zyqNDMBX2VYZQMjwQe8saP1r3iTK5rX5WlcY0K+kaI7g82g==
X-Received: by 2002:a05:6000:1378:b0:268:72d5:c8aa with SMTP id q24-20020a056000137800b0026872d5c8aamr121759wrz.23.1671597320004;
        Tue, 20 Dec 2022 20:35:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d4f87000000b00236576c8eddsm14106761wru.12.2022.12.20.20.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 20:35:19 -0800 (PST)
Message-Id: <5b35362e5d2d2a6883206bd21e95c1629127c9f8.1671597317.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v6.git.git.1671597317.gitgitgadget@gmail.com>
References: <pull.1406.v5.git.git.1671571084753.gitgitgadget@gmail.com>
        <pull.1406.v6.git.git.1671597317.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Dec 2022 04:35:17 +0000
Subject: [PATCH v6 2/2] prep
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
 compat/win32/pthread.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index cf94b4491f9..fc88ce20e2b 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -22,12 +22,12 @@ static unsigned __stdcall win32_start_routine(void *arg)
 }
 
 int pthread_create(pthread_t *thread, const void *unused,
-		   void *(*start_routine)(void*), void *arg)
+		   void *(*start_routine)(void *), void *arg)
 {
 	thread->arg = arg;
 	thread->start_routine = start_routine;
-	thread->handle = (HANDLE)
-		_beginthreadex(NULL, 0, win32_start_routine, thread, 0, NULL);
+	thread->handle = (HANDLE)_beginthreadex(NULL, 0, win32_start_routine,
+						thread, 0, NULL);
 
 	if (!thread->handle)
 		return errno;
-- 
gitgitgadget
