Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A915C4332F
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 01:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiLYBkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Dec 2022 20:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLYBkN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2022 20:40:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D3F646D
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 17:40:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l26so4285786wme.5
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 17:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvqIZ7BIn8NhYm+4K3t83g9kGNtgRI1u489l/jGCrmY=;
        b=n1RF3b3CC0In/Gi+EM1TtGykXE0Av0M2lU3hilBBMCqMT7IoiSmTOrHpi/Yxg1Ki2z
         aWsDBsL0gQit+ZlipQcKwDOeShXv5HV7g2EX9bBQUPE/egA1KSnoxj/jQI5IdwXtkxBq
         ox9tWy3B+qQhqC7qXdYFpKzWcemjjJOJk+0qBljv9kLPM4Ty6LqgjPOl6EPIOOsn+0UC
         iik7M7lJORPe3JPnJqkB1C1oQUEA/1T7Tbj5JHT+3a6lu8ubiahZ7OPn4EA2M/l/dweV
         ck1DdA06EpaQJEioDYVZYDeRQnayBb3xsw3kZu4VvbjnrGq3EdCHEzx+mmRs/3FZj5L9
         Ltdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvqIZ7BIn8NhYm+4K3t83g9kGNtgRI1u489l/jGCrmY=;
        b=eweBqFWBVjYpvMMeEuJ4SOczvJ7+Cv0qsqMLjetyK2GeyorK9kC1lys+eAJIWLMcoT
         QbOo4NSkPtLxbycSAL+olGDF3cC7Jlv86uG2jdnreyBxL2djT+S1gy8nHWPs08yWzTM2
         MZtoWk+O4Ydsuxo9bYuoKON2rKPuBQhZ7a8ZE6dSHGkdG1dpMYqpQ51sIFg+ue5GZ5c2
         a/vETXfXBLIygdv721GGucW0JLYcYSGXJF71MMFegr/cZXRgjGmPIbp1BHGgHe2JMPO4
         bEXw5SCbPEblEAJjFqHPrwlk1ma9MjxYhRqlHv9W7T4l0iSri/ekkgjaSNjWF3wov9Dn
         3i/w==
X-Gm-Message-State: AFqh2krKVKjeQJxr/S1wdtnuwchln31iCU60t4KtwCuBV8Nq/HUpIK12
        9hu2Mw/d9rO5Kz+372RckktvLuAMLS8=
X-Google-Smtp-Source: AMrXdXtq0vZrlqRfG08DNB4xQ1kpW4IZ0KWsInTXHKC9fnPwk/n+1TfcUuJ4GPbqHmn7aedVNgJmlQ==
X-Received: by 2002:a05:600c:1d25:b0:3d3:50b9:b192 with SMTP id l37-20020a05600c1d2500b003d350b9b192mr12235415wms.18.1671932408434;
        Sat, 24 Dec 2022 17:40:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c358300b003d973e939d3sm3821430wmq.1.2022.12.24.17.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 17:40:08 -0800 (PST)
Message-Id: <fa5cbfa5e0ca86e2143346068c9b99856cdded0c.1671932405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v12.git.git.1671932405.gitgitgadget@gmail.com>
References: <pull.1406.v11.git.git.1671823177.gitgitgadget@gmail.com>
        <pull.1406.v12.git.git.1671932405.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Dec 2022 01:40:05 +0000
Subject: [PATCH v12 2/2] win32: close handles of threads that have been joined
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
