Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01A7C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 17:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiLVRRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 12:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLVRRi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 12:17:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED114D02
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 09:17:36 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o5so2335084wrm.1
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 09:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egx8Tc1dl4FS7rrBDx3AVHu2d0Z6g+EfiY3hLnF+dWE=;
        b=DoID0s0FX5p1xreohhe1SSl8hnzJ2QhKh3xxcf2bLqHTsoI+UlsVgb84MUXKH2IgCU
         wACjd+oawtMYiOeS792+xOT9hIn6sVWnJXmSu/GL7w23eO7xhXmqr4GSQNxO6bv9w8MZ
         K10yfOrkEdZpPQKqgJ+E7mmfeMz25IH09lRuFbztYCnW6zNUnWRdKDNwo6IxFYgBZMh/
         RgOfumxcx4KkhB+/kYzfCBUlT3DTQzY2mgVEVbmFlyY3uc1U3QUZGFOlUhoOAMur2imw
         IDsqXQV/xRJxwjPKn2V90W9sIWfLpGmXB1wj4Z3CCXlBv7FMAzcjrSNcCKETQ9e6hmZB
         hbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egx8Tc1dl4FS7rrBDx3AVHu2d0Z6g+EfiY3hLnF+dWE=;
        b=Yk2Rj5DHNcfNzJX3pKDkbVFQOSdwIXNmyAyCPMxlU8FoAoomq7WDHAK4paMalKyBF/
         VEe2ypQQ/kElYQLZXekjLSrr25VZgKNbBjIv8SXRUHsrCEXFdGa+8Jb0DxYDz4xP28vP
         Cs+rz8IxjKDto2m0u24HQCTTXx1WS59bB5XEazO3SFtj4NH7jNxsegbzswXs+VncaE04
         X6PXxzjFL8OS0R/V0pGyC/QjyT1ZKTt9ppH5MSgRFTeVEV+M2IDnjpmXSJAgVFk1JAEB
         N8Y3+0zlBP0YG/zT0czhIgVbcNGdOjXN2ggis/4ao+Wl0eIWCCAnjyuDXgxcJvQ/anTL
         HFQA==
X-Gm-Message-State: AFqh2kpfoaZrcvUSLNIjATWpA+1k66YyoEgOGORmSOh+c+fvKebEZlEy
        QaXJIchqqJ1gXqRYf2RvmN47vDU6wEM=
X-Google-Smtp-Source: AMrXdXuH5CVOa9uzVPtbiw2sg3pxoJizu4viCwbyegT5lRiu9UywxEr+rCt82C00FKEwW3tju45RAw==
X-Received: by 2002:a5d:4104:0:b0:268:cb75:53ee with SMTP id l4-20020a5d4104000000b00268cb7553eemr4488649wrp.37.1671729455329;
        Thu, 22 Dec 2022 09:17:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000008900b00225307f43fbsm1016676wrx.44.2022.12.22.09.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 09:17:34 -0800 (PST)
Message-Id: <d9b1df22e0390efef784ace62785dc5f8c248ed6.1671729453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v9.git.git.1671729453.gitgitgadget@gmail.com>
References: <pull.1406.v8.git.git.1671724911188.gitgitgadget@gmail.com>
        <pull.1406.v9.git.git.1671729453.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 17:17:32 +0000
Subject: [PATCH v9 1/2] win32: close handles of threads that have been joined
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
index 2e7eead42cb..81178ed93b7 100644
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
+			/* the wait failed, so do not detach */
 			return err_win_to_posix(GetLastError());
 	}
 }
-- 
gitgitgadget

