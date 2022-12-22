Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01A4C4167B
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 17:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLVRRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 12:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLVRRi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 12:17:38 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD7E140D0
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 09:17:37 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ay40so1919836wmb.2
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 09:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5M+ztR5Lzk/WKMqBRcgXTwHixFN1UErlOmmw73fm9o=;
        b=JkvgjT888xGiNzcB+UPt7+dMdsPTAqORFC19y73l8hJvac6hnrORazAPDUb+r4VkT0
         3ayIXOIo/owqbLfgYBL+KtkR/zgi77PpUmShOM0u4VqU0gzpX4+H909deK9OQdE6zPA2
         wuVwXe7kSHALzyhYSELn5Y8mDz6KvtdMTDQ+T7vSP1vBEgd+lBf2Q5/dCjHHRXIhxTNu
         B7q4/Q19DnLFxqpiXJYr7fQqjECO6fKhLNTgTA6XUYQxRyTDKbTBnTDOv+UnB6uR8AG9
         edI27UhKnBfBWtNCouaRpuBGcXBZTyQRPxYPGtGRR3NjoNy5ApufmgXMHIFuLQFmntqF
         UdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5M+ztR5Lzk/WKMqBRcgXTwHixFN1UErlOmmw73fm9o=;
        b=NmmPdpOeiC8CqX5BFdl1gRgiAbDyCzwhZf5GTeXufaqFuNJ6rFLQV8bimuUqexRd4u
         YR2HpTHpBL8xKIygbdgQ1MwI0c1HHevQ2seAUs7DDOlZ/6DuuKTRhn+sZxfNIPTUk8Gk
         dc0sC5uHs6GBfr0tjfcb1qoe/85CZRBbDRiewylmtEHqLvrWX4RATYPUEs5s5Mjyhcn5
         s81gtJwYL8fUAUPiJ+/ddsWN1j7aZiOoo/2PNz06Ym/WiL47umYtXMtfRXqxyc4wUmqr
         cp8zMv/yGCfm4Q1tolJ+pWLXE7rCX46+1o+cAqFwhRlqzoHfPCH6LED5RA9/FjpgY7qa
         3Nfg==
X-Gm-Message-State: AFqh2kr4wN4KNHe+nkx15spFeohW7ijfq8ldxDgijgcm3Rvbj90pvE2e
        zomKmI1WPmWI+MBDXO7raneNp/5T7i4=
X-Google-Smtp-Source: AMrXdXu3LJRPAbHeUvDAsNClL0+IcGqVSmzioyD1eE9MYP3plLyMuf/KJLHGyOOgA/7wEFpHjsY7ZQ==
X-Received: by 2002:a05:600c:4191:b0:3d7:9ae7:e4f2 with SMTP id p17-20020a05600c419100b003d79ae7e4f2mr5138201wmh.35.1671729456062;
        Thu, 22 Dec 2022 09:17:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16-20020adffe50000000b00241bd7a7165sm1288837wrs.82.2022.12.22.09.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 09:17:35 -0800 (PST)
Message-Id: <4c82a16a9950b67416530249157332a6b2afa839.1671729453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v9.git.git.1671729453.gitgitgadget@gmail.com>
References: <pull.1406.v8.git.git.1671724911188.gitgitgadget@gmail.com>
        <pull.1406.v9.git.git.1671729453.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 17:17:33 +0000
Subject: [PATCH v9 2/2] prep: reformat pthread.c to fit coding guidelines
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

The motivation for this change is that
the post-image better fits the coding
guidelines, especially since this file
was changed.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
 compat/win32/pthread.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 81178ed93b7..83e088dff0a 100644
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
-			/* the wait failed, so do not detach */
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
+		/* the wait failed, so do not detach */
+		return err_win_to_posix(GetLastError());
 	}
 }
 
-- 
gitgitgadget
