Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27E4C53210
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 16:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbjACQUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 11:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbjACQU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 11:20:26 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A873C10B49
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 08:20:24 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so23706188wms.2
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 08:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LALDJalj/jWAGbQui/a9xb6Cxuxb09zTIcklilPVUu8=;
        b=MwT3x5Ets76zXmagbBR68P649JptyvUC0xa9NG9j9+djDREGZR6OPdz6EpSIDIOMnZ
         BV35tXGqn9+Y1xomIFYy+AN6i+dRirY2g3JyTpZU9bMmkbRRwksCZSosMAQRJPekyk65
         YwyvBUNCg6y8X9qcRrq0DWHrnn0VyON2XIacyfhHFIDJru9gT4aAbv4VhUt8eRvyC9+U
         U1BBKPMxhcaQSYQ+Y5lzHE3/dHCGzgJaALmDohbb5tjTNJofKSQsNjWWb2g/a5ceb8ls
         BklvHRyd12KinM22774lM+d9GeUOJjIy4ia4Y2RGTqbDvYXsu4CzDQRe3c20aikjeDpI
         GrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LALDJalj/jWAGbQui/a9xb6Cxuxb09zTIcklilPVUu8=;
        b=Dc+nNJInkTEc+/SVfjO//LmxSVcv0wLLboqyEZgqAhFq1q6p5ssNJ/Y+AWp6PSK+zZ
         V99nceeJfRE+U4d6y5p5FB1Ce1VwhXH1qpQO4J8x0UZRHk659Y+g9xMOBWOwc0ldzsve
         2RQznBre+NiIrkjnY+0YnMHIWbriBR4Gx9ztcfJw1JtYZgLv6TWnCd2MoJ+y0Jc7DpY3
         ey1BhjRWxXM6ToH2hZkjg02sK9LelVq6XGAFsRzlna7uIqNblwoeR8T2g4EP9wkpNu1c
         RD3hGoFuYv70gF/3LnoCoITGWk9m+GwfmD9r8Ogmow3EmRfVcMAokMkLLepZFsI7VssY
         VNVw==
X-Gm-Message-State: AFqh2kpq1W0HO01UJVA6yHBcr8YKRKpx0d6x5MDOsPNA3c/frxKopHNi
        l7e3cBgLw6NLPGUc8KipAV0eXaiHqDw=
X-Google-Smtp-Source: AMrXdXvHJO1BF70er1wY/43ZX6V86BxpypwZuPvAJiunYf3nJku/DAivRL3/bbrOQ0Rz7hZQGJZoDQ==
X-Received: by 2002:a05:600c:3b95:b0:3d9:baf2:315b with SMTP id n21-20020a05600c3b9500b003d9baf2315bmr3966036wms.11.1672762823009;
        Tue, 03 Jan 2023 08:20:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003cfbbd54178sm70214766wms.2.2023.01.03.08.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 08:20:22 -0800 (PST)
Message-Id: <f126d6416d5eb00f3051c5dfd6f16d013d708caa.1672762819.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v13.git.git.1672762819.gitgitgadget@gmail.com>
References: <pull.1406.v12.git.git.1671932405.gitgitgadget@gmail.com>
        <pull.1406.v13.git.git.1672762819.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Jan 2023 16:20:19 +0000
Subject: [PATCH v13 2/2] win32: close handles of threads that have been joined
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
index cf53bc61d82..85f8f7920ce 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -42,10 +42,13 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
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
