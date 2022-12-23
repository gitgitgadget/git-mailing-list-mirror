Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADADC3DA79
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 19:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiLWTQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Dec 2022 14:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiLWTQA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2022 14:16:00 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A610659F
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:15:59 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i7so5320550wrv.8
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6GP/eZ3XXrZHZXftNTRfIXvKeFBn1NYVoQFNtA6JMQ=;
        b=jjdW5hD6ZWV5jvps2c7upLSThYQmn0flA0OBFpM3mAl6oJ8Oi4QjnBW3/BiM+lQdQI
         ud5dfVfFcLaoRQVOH8A2Smrn6Ik+g7Ayb/AMpN8lklQtNgTEJudQWN4CyedCvC5fuO04
         fI5b3lMeF/maS5QqgxF1pA0ZxRnv4vBhHU2HCQW9KP2h+/fD9YndQsVSRB/UAy+QEOuu
         H1q07P9qktI+Jhpa4lhnlqHLOijobpSHLoIINAMjK6hE4wcfuIZovjxoQSTV7wOVE2Tb
         m9Ivh8xM8Dih0hdqQ5QNu8YLoE2Du2NKb9dFYT5XfnjfjLA3I8P6EB93QTJH0G2FW76I
         Ai5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6GP/eZ3XXrZHZXftNTRfIXvKeFBn1NYVoQFNtA6JMQ=;
        b=VRojuCpQfA6DLLFyRpyBxBaygcdUuoq/T1NeAeZ0tyKk76cgTWN0weBSPR6o48huOj
         MYoQAvQ/xZNMtj7vDBieGzNPBHTldcA5xYxeyQH5ZsuJzDLaKyqzD8mdPlLGThT0VXQo
         hi2DpCeXL4uAqlfcca5BlyrTvsvKmNtHCJY4f3Mi4/mBf9eW2dGX5aa6V57cy6lyZflu
         SvLI4+YsyIWsXHdffNShrXgUoSgG3pZ+A8iDS+9yq7ABFxeSglNFrZkZqF7v0v81mObY
         C0blZFyKODiRJUII7oVbUy9R2lR2lxQe6aGI9w6NWo4aDoL9ADa8OhlpjJTKZD0/FvNV
         C3GQ==
X-Gm-Message-State: AFqh2kru/qmxt+fVTTb0boSWmzkNvocVMJ8GlKV1KG4AMtJEycgMnLl9
        +D4NchyRpFxIA5WgIPpt9wgYY9KAyCc=
X-Google-Smtp-Source: AMrXdXvkTtuh7k6HV4byjVRI4R2lxjW9Q0dql+owke5g/6svxmgP0hVPgyWOvQFWZBFIo9MMyTP0BA==
X-Received: by 2002:a5d:538a:0:b0:26f:dae9:2b1d with SMTP id d10-20020a5d538a000000b0026fdae92b1dmr5054940wrv.14.1671822957707;
        Fri, 23 Dec 2022 11:15:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5-20020a05600001c500b00242246c2f7csm3728644wrx.101.2022.12.23.11.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 11:15:56 -0800 (PST)
Message-Id: <e0cc43efc6c498706559ae4fc71c597a6481f64c.1671822955.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v10.git.git.1671822955.gitgitgadget@gmail.com>
References: <pull.1406.v9.git.git.1671729453.gitgitgadget@gmail.com>
        <pull.1406.v10.git.git.1671822955.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Dec 2022 19:15:54 +0000
Subject: [PATCH v10 1/2] win32-pthread: prepare pthread.c for change by
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

