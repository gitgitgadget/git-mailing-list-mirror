Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF70C54EBC
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 16:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbjACQUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 11:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbjACQUY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 11:20:24 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3860C9
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 08:20:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso21496263wmb.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 08:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0pKBDD2cFEcMLMyG95NYGpS2hFKDXbsupSJgR2jDfM=;
        b=gi1qc8g8243kXm+HK1ITsOeT5/aNSdB3FuQ+2yVWp8CaCeDxW3LNNaqlU8t4Ni+97v
         u8gXHAqTk8Ai1pNUptL29Dm6Fs7PIp9XLUKCsi+HIgKFBqyfShSMxMHkw+E/V4Oqt/S8
         7cyVzQLgiaEuwDPQvXpwrrFCJ4J+cvVlH94FxsfWpWMW5WBh24jfwqZ3RNkAoA1R74Cp
         tb38FaH74J9Zma/x2KRFIUc0QdiZeX9JfdfSGULBYZCFSWAVm+e5eB7iDPhMEXlO/fIR
         cvoYk0daYiF8W9AN9XK2nVIFBh9B5dijz1thDwCI16goqnvvTGh60kBZLRv9lwZFox4A
         CLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0pKBDD2cFEcMLMyG95NYGpS2hFKDXbsupSJgR2jDfM=;
        b=hgqmceKA6tbsBv5nLLefV8d0xOVgLSssE/oJ6KUWrkgWVwgiHRZ7EDN2f7ku12Q/f8
         3mETIlmtelOQOeDo5PM8N6wc5xSGH0oFLpw57BDx6dR8QlXDsbT+aCyTm8swxN96rtfh
         YVPjLxX53tEMb4159VdRxqK5GZu3on/6PZFFyh3juavhNzLlEcHNwobxZnUWxg4lKfsS
         CrjEbhb/x/8V51GB/z0giHDCfzvCqPvVdRynb8H2kAt8J/2L7tfPVwXs1gb+6sFcS5Rn
         V5Sy2Qy5sqB0sBPi2VGuKYI4mSur4z8ofepmulL/VrDindGbRQuieHW8ASRpFg1vgrgy
         c5Xg==
X-Gm-Message-State: AFqh2kr1AKZBc17XhuzNHjTflYApVtqZAT3qWQf+ED2FnT8gtYR05xYO
        Gj9aYocnArmzC4CPWV8PSY3mgFiMixo=
X-Google-Smtp-Source: AMrXdXtBx5S1oyaNimYAYgXS81yAJGJz8RWndr/Yd9fXggIKSAaeYxpZEgRakvZFsCX9fRB4vbolcA==
X-Received: by 2002:a05:600c:1e1e:b0:3d2:3b4d:d619 with SMTP id ay30-20020a05600c1e1e00b003d23b4dd619mr31603683wmb.15.1672762822284;
        Tue, 03 Jan 2023 08:20:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8-20020a05600c13c800b003cfd58409desm45671836wmg.13.2023.01.03.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 08:20:22 -0800 (PST)
Message-Id: <6f89b1206418771b5a7c9a5a79b91b0f21b516df.1672762819.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v13.git.git.1672762819.gitgitgadget@gmail.com>
References: <pull.1406.v12.git.git.1671932405.gitgitgadget@gmail.com>
        <pull.1406.v13.git.git.1672762819.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Jan 2023 16:20:18 +0000
Subject: [PATCH v13 1/2] win32: prepare pthread.c for change by formatting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

File has been formatted to meet coding guidelines.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
 compat/win32/pthread.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 2e7eead42cb..cf53bc61d82 100644
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
@@ -39,14 +39,14 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
 {
 	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
 	switch (result) {
-		case WAIT_OBJECT_0:
-			if (value_ptr)
-				*value_ptr = thread->arg;
-			return 0;
-		case WAIT_ABANDONED:
-			return EINVAL;
-		default:
-			return err_win_to_posix(GetLastError());
+	case WAIT_OBJECT_0:
+		if (value_ptr)
+			*value_ptr = thread->arg;
+		return 0;
+	case WAIT_ABANDONED:
+		return EINVAL;
+	default:
+		return err_win_to_posix(GetLastError());
 	}
 }
 
-- 
gitgitgadget

