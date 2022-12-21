Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B045C4167B
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 04:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiLUErH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 23:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiLUEq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 23:46:56 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64686241
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:46:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r126-20020a1c4484000000b003d6b8e8e07fso457089wma.0
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3zKBFTVUE9gDFVffOIFuNxatHrDNo8Ku7oYShln0+c=;
        b=eVO5lUkh71kcKuMDhK47kqyWNR0Ti1DZYWoI7TgCjV22knd0o+rfDXfqxp2kfhGyMw
         v9eWEFPG5iOyjN2CFqHZEe/2J/ohbbnJUN1xGBLs0RhMn+k7V5rAa/Ee6adt+7stGdiw
         7j3gZFnwUksJgJnsKzkDVoeZt9sQ9LvTP9/dgp9Y0exId9m47XSVZtYXvz/Id2EwUP0n
         z1xy+i4Jp4tKHYLVRslTbWAvi3xBF42i9tampS1NsgzRAcwnQI067QLJfqUvPdihQRnt
         Zlq4SiAgIxLPinvTJV0wE1I8CuL1Oajy4sbVHL0IRWSobrfb92SxH6FxKNp+kshhXwWE
         Iicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3zKBFTVUE9gDFVffOIFuNxatHrDNo8Ku7oYShln0+c=;
        b=HJ/HJr5DPw6EsNmfALIB8HUOjHaQTL8O/aPdgAQa/KtnCKk7v/ItF2VMsPD6yfTonx
         JdmjaPv/iO0vvry4lCs1rd9WlYXeFIjFStLDu23elb/JZCa5BMKlDtuCW1RvNn7ZPfDM
         +71HbxRTBx2eXECysVd5IriSuDSM9Dbocw6OCeHM88iRSvjK+BVSBV3LcA89UluKZNvz
         EfsKG/yJkTpjBD4yPlfuMdGJ93JoC/g9qeyB0KMAtyPliF3+YyXQd0eyNewQHbhsN4m2
         CGi+Q90Ig76ZUW9mibzcGcXVYf/AssOW3zjFewuHADh3lKZHRmFrt4ttvnQPPkcEqlNW
         mzbg==
X-Gm-Message-State: AFqh2kqwOJJ1xP2jrqVSfAIsqmV+OuOuBYZrBZJWlYroics2Erv5VDLQ
        VQvbLvIyW0eUvZacUdo22dNPO421Jm4=
X-Google-Smtp-Source: AMrXdXtxOu/hFtgUE0QnXiI59cRRTTPuX6CqITojJdDkjQYL6HEVVxBqlG/tAR2xs6eVXm6ueqv1kQ==
X-Received: by 2002:a05:600c:22cc:b0:3d1:bd81:b1b1 with SMTP id 12-20020a05600c22cc00b003d1bd81b1b1mr496465wmg.18.1671598011147;
        Tue, 20 Dec 2022 20:46:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b003a3442f1229sm843229wmb.29.2022.12.20.20.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 20:46:50 -0800 (PST)
Message-Id: <f780ed525eb2db09a7e56efa98adae22d5a9f244.1671598008.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v7.git.git.1671598008.gitgitgadget@gmail.com>
References: <pull.1406.v6.git.git.1671597317.gitgitgadget@gmail.com>
        <pull.1406.v7.git.git.1671598008.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Dec 2022 04:46:48 +0000
Subject: [PATCH v7 2/2] prep
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
 compat/win32/pthread.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 21c705778b6..fc88ce20e2b 100644
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
@@ -37,19 +37,18 @@ int pthread_create(pthread_t *thread, const void *unused,
 
 int win32_pthread_join(pthread_t *thread, void **value_ptr)
 {
-	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
-	switch (result) {
-		case WAIT_OBJECT_0:
-			if (value_ptr)
-				*value_ptr = thread->arg;
-			CloseHandle(thread->handle);
-			return 0;
-		case WAIT_ABANDONED:
-			CloseHandle(thread->handle);
-			return EINVAL;
-		default:
-			/* the function failed, so do not detach */
-			return err_win_to_posix(GetLastError());
+	switch (WaitForSingleObject(thread->handle, INFINITE)) {
+	case WAIT_OBJECT_0:
+		if (value_ptr)
+			*value_ptr = thread->arg;
+		CloseHandle(thread->handle);
+		return 0;
+	case WAIT_ABANDONED:
+		CloseHandle(thread->handle);
+		return EINVAL;
+	default:
+		/* the function failed, so do not detach */
+		return err_win_to_posix(GetLastError());
 	}
 }
 
-- 
gitgitgadget
