Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB229C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 19:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbiLTTBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 14:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbiLTTAu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 14:00:50 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2D01145
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 11:00:47 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso9582244wmo.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 11:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eyo4GxE85HkYPho0u7BWtqa3pAqgn4NWzr+Dtrg9tlE=;
        b=k8UyLfuaXuPpHZHTGKjlegrRrdbGu/qKLHGOEIIdvGseKw9xiHqh7yO+/2CZG3wEiP
         f4kbwxan1d8ag4CiEWzZO7ZhFhbZxdXRQfpssoPfVj0RxGNV/+abJ4cggKN8U7H4B9IX
         GMCV5OU0WIuCbghZUAcDv0+AUJpKA3MCNJ2aFBbACwPvmaaOXl/4vN+rWMKnFoACyDi+
         k6Az/E//ATbblfVBOcO4KaGrBKXh8xdtYjAgK3tftJUUX9IQTLZXSGLM3TUVT/F12rbR
         CvU7YjxE4poVToLARII2Gf9xpFoKRgLnF9DIygtFfx8jpB/rpd0ThCK510HOvKYPr05g
         91Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eyo4GxE85HkYPho0u7BWtqa3pAqgn4NWzr+Dtrg9tlE=;
        b=Wv+pkGmskosuuWsuiOXFTXrAGbM+q5SQzfJVSN6mvjiLSe0usYuDLU4YDSej4djZvY
         tgUloNwKrUhZwHYJHRWghlu92NsvVV24Ya5Z+XC/aNAzYAxg0YCOFH5UpO7UVZFfC8FS
         MKumI5exTN6XjZG+9lJFR41gVSMjXGQXceONgHUdA5EfjE9RK4ciW6yGu3KdIcWWEHDl
         NhARWExEN84zYw0H5FeE59jDUwKHmve/iC/UP7M8KRTmA1KqR+UuGLKSJOSmJaLujBoe
         mFiGH2CZDdZcW6obMfTdQ1VKcyoUVLk8qcelTxDfQyZSju6beccHbC97ZIsI5t385a19
         AWTA==
X-Gm-Message-State: ANoB5pmmLexOcqLeJrOcqONV8lc9buWkDpLE/Wd/bq694/WvCSNS9Bu1
        nvq8wT1s7zXAYpFc2RHwZOfA8HVX3Ao=
X-Google-Smtp-Source: AA0mqf4JTvHZqb7fC1QUEXuohqaRkyPFMk7AxPeBz4mGA4lv+TuX6QZyq1Z8T7JNryWjnXj+Vtkhmg==
X-Received: by 2002:a05:600c:3847:b0:3d2:3d7b:6118 with SMTP id s7-20020a05600c384700b003d23d7b6118mr17631163wmr.24.1671562846062;
        Tue, 20 Dec 2022 11:00:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b003d069fc7372sm18669647wms.1.2022.12.20.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:00:45 -0800 (PST)
Message-Id: <pull.1406.v3.git.git.1671562845014.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v2.git.git.1671562663899.gitgitgadget@gmail.com>
References: <pull.1406.v2.git.git.1671562663899.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Dec 2022 19:00:44 +0000
Subject: [PATCH v3] win32: close handles of threads that have been joined
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

After joining threads, the handle to the original thread
should be closed as it no longer needs to be open.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: close handles of threads that have been joined
    
    After joining threads, the handle to the original thread should be
    closed as it no longer needs to be open.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v3
Pull-Request: https://github.com/git/git/pull/1406

Range-diff vs v2:

 1:  8b20c4149be ! 1:  2049576b193 win32: close handles of threads that have been joined
     @@ compat/win32/pthread.c: int win32_pthread_join(pthread_t *thread, void **value_p
      +		return EINVAL;
      +	case WAIT_FAILED:
      +	default:
     -+		/* the function failed so we do not detach */
     ++		/* the function failed, so do not detach */
      +		return err_win_to_posix(GetLastError());
       	}
       }


 compat/win32/pthread.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 2e7eead42cb..306834a7153 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -39,14 +39,20 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
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
+		/* detach the thread once the join succeeds */
+		CloseHandle(thread->handle);
+		return 0;
+	case WAIT_ABANDONED:
+		/* either thread is not joinable or another thread is waiting on
+		 * this, so do not detatch */
+		return EINVAL;
+	case WAIT_FAILED:
+	default:
+		/* the function failed, so do not detach */
+		return err_win_to_posix(GetLastError());
 	}
 }
 

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
