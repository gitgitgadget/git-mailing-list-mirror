Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38615C3DA79
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 19:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiLWTTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Dec 2022 14:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiLWTTl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2022 14:19:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A65DC75F
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:19:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so1370844wms.0
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6GP/eZ3XXrZHZXftNTRfIXvKeFBn1NYVoQFNtA6JMQ=;
        b=nQmRa4rO4jBM5P1Ra6F7RUxeVEkyKz9+/qS9EAbM6RqII+3sQFsho4/L2NKweH7OHu
         yPa957+FFjXeIacE8K4bZXFA05NQmdwuZ6V3ByAgk8F+3DBUvtWJEKtN5W7GFxAGFuBZ
         OVNXDflxYIbyO9/tyqA7BClgr6JxMP/Si4ie7p5/bN30kY6fTVnzKZWYTYlpbS911o92
         W6cZ5tta4hznSgaxDiz2jRGaIZejzl7Fs5AO9nrUCTKECudGtoG/7J+x+UKroqKk/pBT
         SN+VDRZFkqfw34Ddi1JZtXxbopxP5zbTuUMVuk1+keY7Xy1unZeny0WsXGfiXQEEtPWT
         vtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6GP/eZ3XXrZHZXftNTRfIXvKeFBn1NYVoQFNtA6JMQ=;
        b=FN2jbvzBS/T2QmYW2M5L7CMqd5I8gMmxqxvN9+fA+OojkKV/Nar4sFOgnUxtD3FSvj
         PbpS8PyzJxG6AgzTJ5nxwsvkgqdQF+tif5svTI03giRX5/cd0/WzeFEWNFH1XIz5sAVQ
         gHFedF6FnNE3QZSusgfNd62GsBVAQAoWHTHIiz9cEcmZcPSZQJPe9aGAAUHRZvEUpKJj
         v8tUBEZuA3sM9oc0nOpPrd5kZ15Oj+sgGk3sZ8qRSoZt2pOxXYKRYlMo5jN0NkuiWDv7
         PWV8ULsTlXdrKBrePyYhewTt0xNgyerpCsOBIEqwcYewBiLz5vaFq8+CxHggniePyjHD
         ZSOA==
X-Gm-Message-State: AFqh2kp0zznTBigGKJd+zxv4pN32bwvHDrVa4v5i4zKcms1nD/yAEp4l
        X8VrR2EztCywcwpLfOA11cjeTFBR9EU=
X-Google-Smtp-Source: AMrXdXt8tbaVDSvrydyU/RcEkP3Gcvd0gSkuWcB6XPVJXMC9OvC+sh3tiEXzgGnvk5ZIIrMC6NdBOw==
X-Received: by 2002:a05:600c:3b82:b0:3cf:900c:de6b with SMTP id n2-20020a05600c3b8200b003cf900cde6bmr7959414wms.15.1671823178849;
        Fri, 23 Dec 2022 11:19:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b003d34f170487sm13092835wmo.0.2022.12.23.11.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 11:19:38 -0800 (PST)
Message-Id: <e0cc43efc6c498706559ae4fc71c597a6481f64c.1671823177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v11.git.git.1671823177.gitgitgadget@gmail.com>
References: <pull.1406.v10.git.git.1671822955.gitgitgadget@gmail.com>
        <pull.1406.v11.git.git.1671823177.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Dec 2022 19:19:36 +0000
Subject: [PATCH v11 1/2] win32-pthread: prepare pthread.c for change by
 formatting
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

File has been formatted to meet coding guidelines

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
 compat/win32/pthread.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 2e7eead42cb..65e15a560d5 100644
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
@@ -37,16 +37,15 @@ int pthread_create(pthread_t *thread, const void *unused,
 
 int win32_pthread_join(pthread_t *thread, void **value_ptr)
 {
-	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
-	switch (result) {
-		case WAIT_OBJECT_0:
-			if (value_ptr)
-				*value_ptr = thread->arg;
-			return 0;
-		case WAIT_ABANDONED:
-			return EINVAL;
-		default:
-			return err_win_to_posix(GetLastError());
+	switch (WaitForSingleObject(thread->handle, INFINITE)) {
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

