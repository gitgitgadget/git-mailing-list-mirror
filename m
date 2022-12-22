Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA19C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 16:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiLVQB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 11:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLVQB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 11:01:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A4BF0D
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 08:01:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso4202134wme.5
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YRN7CcAm4TVNaK4Im3gejxt3NtcdUfoNjWNTpfIul4=;
        b=DSv9VRWZAkp3pcwpundLCjrRaOYcDTRGaYTH++ulM1dM+nqL5ESo89UV9X2Eusxf7g
         gCTzWGACL//9CmKRhPG1Ni9sVrpCVWzU/RMhHTEgCr7utfeE+0rj4Zu5Vn7b49vTC1VE
         fkOBk46tcuD2ESSdp9ZEDL/TZ7BO7bfq8yz/JP+BxQy+XtpKTtKDLUipKOA9A9cac3kz
         tTYxPBP2sFbu3BRNiIT9hFnQdS2YYapy/8jwdUkDvwRx+Xo/79tXON2oTEZ9itpJ+wJf
         Df0bD1VZ0989OnEOLnNBcSJMYbcg6OU+QsvxV2GHSUWswK7XUQwZnGeIL5mewQZd50pZ
         6Hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YRN7CcAm4TVNaK4Im3gejxt3NtcdUfoNjWNTpfIul4=;
        b=IJ5dxui+808cf8q8LA+ZvncJhKQyYL53g966h6a/Cb9NYWo3n22A/hzvD5Z2WQxE9z
         xEZT9wJ6rR4zhDIQBqwa+20zR9JZbFeo8Z+QyPqiqgjSNJgzhKcT0pE+BF3v58StK9OS
         kDefcN5wTXmBYcZHfJwQOGpE+xuDV1/eJrn+XYnuGrKK+PgUY2924T8CcghMTHMu+4sR
         L1VQz4YnwOaxd21wCL6vknEWLWIqHOCVBKwO6dhhole6YJQMjdg6d282uEBf9CAvTgjt
         A5F55ZrTWiKmS8mqwyQ3Pf7rylIudOtitz/gAEzQGPYg6vin4IEs5GnjG4PezTHTHsCC
         k9Kw==
X-Gm-Message-State: AFqh2krGKQClaOAUmLR/EhzbhiF5of3v7mxcXC13b9xeZM6+FtjgwiqO
        9jOz6y2h0p8QWKO03Sib5mDr+jhSaTU=
X-Google-Smtp-Source: AMrXdXv3RkiEKWaS/yubNM0fxi21u7s5kcwHbXFR+rfHd6x09rVpC8LVHfzH03i+p+MIS1kLGVEjlg==
X-Received: by 2002:a05:600c:22c7:b0:3d1:cf66:3afa with SMTP id 7-20020a05600c22c700b003d1cf663afamr4801643wmg.19.1671724912509;
        Thu, 22 Dec 2022 08:01:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16-20020adffe50000000b00241bd7a7165sm1093394wrs.82.2022.12.22.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 08:01:52 -0800 (PST)
Message-Id: <pull.1406.v8.git.git.1671724911188.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v7.git.git.1671598008.gitgitgadget@gmail.com>
References: <pull.1406.v7.git.git.1671598008.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 16:01:51 +0000
Subject: [PATCH v8] win32: close handles of threads that have been joined
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

After the thread terminates, the handle to the
original thread should be closed.

This change makes win32_pthread_join POSIX compliant.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: close handles of threads that have been joined
    
    After joining threads, the handle to the original thread should be
    closed as it no longer needs to be open.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v8
Pull-Request: https://github.com/git/git/pull/1406

Range-diff vs v7:

 1:  b40287508df = 1:  70588032eb3 win32: close handles of threads that have been joined
 2:  f780ed525eb < -:  ----------- prep


 compat/win32/pthread.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 2e7eead42cb..21c705778b6 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -42,10 +42,13 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
 		case WAIT_OBJECT_0:
 			if (value_ptr)
 				*value_ptr = thread->arg;
+			CloseHandle(thread->handle);
 			return 0;
 		case WAIT_ABANDONED:
+			CloseHandle(thread->handle);
 			return EINVAL;
 		default:
+			/* the function failed, so do not detach */
 			return err_win_to_posix(GetLastError());
 	}
 }

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
