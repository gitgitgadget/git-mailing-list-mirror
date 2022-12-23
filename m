Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9E5C4332F
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 19:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiLWTQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Dec 2022 14:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiLWTQB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2022 14:16:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2933965AB
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:16:00 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso4109935wmo.1
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvqIZ7BIn8NhYm+4K3t83g9kGNtgRI1u489l/jGCrmY=;
        b=ggsBPTp9pDhSOQyusFOKnvKRyXoUHJsG2CJH8RXk7u96t4iktjU/shF/XIenOmYz2/
         2N/PLlLMm5BpQr8HRXnkSaI0rf+KxeDZKcyk5ay54QR9XbiF7pLybxcXArLw0J1EnetO
         1pAGNF42e+/Qr+qzcQOVl5jHq7r5gEUiqn7szxFSCLiiSTclm9F0I1QUdB3gmoVTfq/s
         agXco4qin0X9baZhRoRz69hXuEQ7Ef6QXZshWn3sjOVSqrFGQrDhDsK4l40iINdv2wam
         VXJ9VcDvRVebgoGZMqPquKWlLqc4las7D8rkAUVsrza2VPujeAg97WObMEuelTyvB+k4
         DVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvqIZ7BIn8NhYm+4K3t83g9kGNtgRI1u489l/jGCrmY=;
        b=7dX/CwbLsif9VJy+OiF/rRHGpMQjkG2YIlZx2KJsa/E6s+jTjwksUvDQoThslxipLE
         KxX4JjtMv9P/StUmT1tBzjVlLppfUf6HUJVgYbLsAV8fnfWw1KMAUBBGzpp1ZBT7yrMT
         /ma9km+jkVsQdp1n76rlmtjJ25pKmZEZDV9B4VvCjjZfDn9/yqZbLR/EAo77c3UWpyZw
         JGVBI8EmwyiUMJ9rCWRLKV6QQEjE3pSWknVnNo5OYBUX5wl8K2S+xzOElzj5FMFKtJpc
         UU7vr2Y9qV1WxUrUyuPN7GlJ1F781/JbeYc2iBTD+POWjUDHIZ61ZWebvSBInd4bGTBG
         vAwg==
X-Gm-Message-State: AFqh2koGJQW4VT6f+abDLXK7JyhWOvP9oDGpfeehI06KgmKU7Oeu+TCf
        IoP6dqqVdOKDcuYYITGYLenS+MNMErM=
X-Google-Smtp-Source: AMrXdXux9SlynfqGG3ZluOQ9flQnbBE3uAaIUIA3Z5pWFLfpAa9ICK8QaePZ8+Lkzu/7KrSGCUYPdw==
X-Received: by 2002:a05:600c:3ac3:b0:3d1:cfcb:7d19 with SMTP id d3-20020a05600c3ac300b003d1cfcb7d19mr9054538wms.32.1671822958498;
        Fri, 23 Dec 2022 11:15:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi20-20020a05600c3d9400b003c6c5a5a651sm5204339wmb.28.2022.12.23.11.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 11:15:58 -0800 (PST)
Message-Id: <d05d4c2e4b2e84dc8432ddf116fbcee14b0cf7e8.1671822955.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v10.git.git.1671822955.gitgitgadget@gmail.com>
References: <pull.1406.v9.git.git.1671729453.gitgitgadget@gmail.com>
        <pull.1406.v10.git.git.1671822955.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Dec 2022 19:15:55 +0000
Subject: [PATCH v10 2/2] win32: close handles of threads that have been joined
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
 compat/win32/pthread.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 65e15a560d5..83e088dff0a 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -41,10 +41,13 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
 	case WAIT_OBJECT_0:
 		if (value_ptr)
 			*value_ptr = thread->arg;
+		CloseHandle(thread->handle);
 		return 0;
 	case WAIT_ABANDONED:
+		CloseHandle(thread->handle);
 		return EINVAL;
 	default:
+		/* the wait failed, so do not detach */
 		return err_win_to_posix(GetLastError());
 	}
 }
-- 
gitgitgadget
