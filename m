Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870A3C3DA7A
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 15:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjAEPon (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Jan 2023 10:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjAEPoj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2023 10:44:39 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D1C5C919
        for <git@vger.kernel.org>; Thu,  5 Jan 2023 07:44:38 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so1628514wms.4
        for <git@vger.kernel.org>; Thu, 05 Jan 2023 07:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0pKBDD2cFEcMLMyG95NYGpS2hFKDXbsupSJgR2jDfM=;
        b=FeyDsZETZQKqqScf47Ddww2uMtdFoqDExL+pQJ+hxEJkFr2LxJv7mGeGXgLVZ3TNQ5
         koZaY/uAoPlZHqeW53W+C12BsSkhT69ZDIfyVMMQ+/88cIlE1fmRLeKQtIC0JA3Iyz4F
         brYBktuUZXJjUe73PorAZiOTAb9Z/agvfZRzw3yzsmHsUzhayeDCnUn9m0/8iS776Sa9
         czc/wiN248LZ4v68XswZwCIdN8gZUt4lDxh+2z5ZezIbKQY7gP8HN3kpIzVibrYHmccn
         P24yjDVIeWkqoBCv3qYtDDwSc8ejytu3EPeWOXjE1kK9VQrZ1BVFCUmI1yQCHsdmb89f
         tRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0pKBDD2cFEcMLMyG95NYGpS2hFKDXbsupSJgR2jDfM=;
        b=hD26JAjyWqDbTOb8dyEe2uW+5SbKpZTt2wi2mtrPKRP8EVFAkuEBh7wfdzZy1anb6B
         TdD5GyvutJ/46RhMXAgzsQyry4tLH4od2b1yA+n89wR6Ypx8CKClCSIT/e30ObtUjtH9
         dkHfxiIoN5XIXiP44Bz7/KP6yZC2bITiXCU5mkJ972xdW33nnplor17Jmj4YRR6p7DMr
         JdhPTykJSsW60fTELi7bRPshu63sioWqi/Hu5Uy4ga5nPUInxQzTbR4ZyvXCRT8nHRK+
         rQ4tAFsxHz1t0Hz0Lg7DAoEVVqo+J/7UC7kUZczsOn+vV4vaBpIR9KF2feQkG6nFxva8
         IrjQ==
X-Gm-Message-State: AFqh2kogJ1nLepVjrvJP9Vv8FPbApgSOcm9Dq3NKzZYApZIuWani79Xw
        41BiZIKsox1X2RFabCR8ag0fnpiWjc4=
X-Google-Smtp-Source: AMrXdXssbZcgke6oZA2Y3VNrtkqgprR1cvejd7vws0SJInQHMMI0H/TcoWf8Q5N0sLTgTxHHe3s8Ag==
X-Received: by 2002:a1c:7c0f:0:b0:3d5:816e:2fb2 with SMTP id x15-20020a1c7c0f000000b003d5816e2fb2mr39564473wmc.14.1672933476691;
        Thu, 05 Jan 2023 07:44:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2-20020adff242000000b0023662245d3csm37384945wrp.95.2023.01.05.07.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 07:44:36 -0800 (PST)
Message-Id: <a20eafb954193fe5cd2bad2f65d86f6116339380.1672933474.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v14.git.git.1672933474.gitgitgadget@gmail.com>
References: <pull.1406.v13.git.git.1672762819.gitgitgadget@gmail.com>
        <pull.1406.v14.git.git.1672933474.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Jan 2023 15:44:33 +0000
Subject: [PATCH v14 1/2] win32: prepare pthread.c for change by formatting
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

