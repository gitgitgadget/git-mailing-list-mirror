Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BB3C433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 20:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09282072E
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 20:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="GANYRG2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407143AbgFYUdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407140AbgFYUdK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 16:33:10 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1C6C08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 13:33:10 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i3so5762275qtq.13
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 13:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bnc+t4YwONAiHUY23n0I/z0J1VF6mvI+wvTSBvo23Bk=;
        b=GANYRG2dEVNMTAzTO7zKysntGMzc6B4oHEPEkdxEOMua5EzXnfhJy7NUI7jYF0UAyz
         OFDPdxJLI4O370zuSecVgQuSYUtdEQA0Gq+Anvj+fTuAUaoh9z0BTOKF39vpxQ4DBtt6
         ln+5ei8FEWtK8l74JrHYUnx74FrS+81+UW3Yt4GRWfYzEDGFzKSiqwgQokPcgBk9bfkG
         0XQ+QFz/QEMZSsyeDCh4b0kDDPEGGYLyjahEj3JpLmzSSaqfcsU7fKkfpBKPghAA9FEX
         nYAF1lllOUsF5h5FkNQo1FzGjpy3UKHZyiWRBI4Y4Mj3YUkXv2pzoqibv6e8mWGPpRk6
         U4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bnc+t4YwONAiHUY23n0I/z0J1VF6mvI+wvTSBvo23Bk=;
        b=QbJ/3SrsUWuoIYdxtG9UCl0PDcKL9D+gT8lTyapAI5bchL+0XgFqDEVH4g505erVvr
         69HVCOJCcCGBD8jZujXyecTapP7SuL/wKPBrwJ7tR4CVjM0KJxc0okF295TKedlqV9ZN
         U3VwrW9X7e3lNKlm4svbYgf1PwJRSnStp6lmfAGleoX+AtkofvgKJCjyS9dONBS6gZe9
         xA+NNMzRvZWp4cikAHkqXC++3M85DRyYvBBHnWzn1hL9V3z5Y7+SHRzP0RD0lw21MR6r
         K/jaIX9Q2D5RfPapGP9SHWc+8BraX3l9eKCkVeFOTCqQJbXThJOtd8c57GEFQ2Sj/h7V
         B30A==
X-Gm-Message-State: AOAM532D+0b2v6+svtAjOZPSg5r+UNFNwGft+Tcizu29Eycb06vN79Nc
        FfNESRuvAVRHzhoQdtGw9hhYdhxtxQ8=
X-Google-Smtp-Source: ABdhPJxdrOjkY3NbINpHeG13WS9Y+hhJbXcFLHILB+ZxhaFgEYcYKo5J3OeeQi+ko1FDkoinCddIiA==
X-Received: by 2002:ac8:2aa9:: with SMTP id b38mr15724067qta.49.1593117188995;
        Thu, 25 Jun 2020 13:33:08 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::4])
        by smtp.gmail.com with ESMTPSA id n63sm6745118qkn.104.2020.06.25.13.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:33:08 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, j6t@kdbg.org,
        jonathantanmy@google.com, peff@peff.net, Johannes.Schindelin@gmx.de
Subject: [PATCH 1/2] compat/win32/pthread: add pthread_once()
Date:   Thu, 25 Jun 2020 17:32:56 -0300
Message-Id: <e5a10d3f2152859b75bd815c37511975057d0ab0.1593115455.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593115455.git.matheus.bernardino@usp.br>
References: <cover.1593115455.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Note: the pthread_once() function is adapted from:
https://git.libav.org/?p=libav.git;a=commitdiff;h=b22693b06d1e5d73454a65c203b4d31c1ca5b69a

Which is LGPLv2.1. Should I add any notice/acknowledgment somewhere,
besides the comment I added above the function?

 compat/win32/pthread.c | 22 ++++++++++++++++++++++
 compat/win32/pthread.h |  5 +++++
 thread-utils.c         | 11 +++++++++++
 thread-utils.h         |  6 ++++++
 4 files changed, 44 insertions(+)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 2e7eead42c..5a7ecbd999 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -56,3 +56,25 @@ pthread_t pthread_self(void)
 	t.tid = GetCurrentThreadId();
 	return t;
 }
+
+/* Adapted from libav's compat/w32pthreads.h. */
+int pthread_once(pthread_once_t *once_control, void (*init_routine)(void))
+{
+	BOOL pending = FALSE;
+	int ret = 0;
+
+	if(!InitOnceBeginInitialize(once_control, 0, &pending, NULL)) {
+		ret = err_win_to_posix(GetLastError());
+		goto out;
+	}
+
+	if (pending)
+		init_routine();
+
+	if(!InitOnceComplete(once_control, 0, NULL))
+		ret = err_win_to_posix(GetLastError());
+
+out:
+	/* POSIX doesn't allow pthread_once() to return EINTR */
+	return ret == EINTR ? EIO : ret;
+}
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 737983d00b..c50f1e89c7 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -40,6 +40,11 @@ typedef int pthread_mutexattr_t;
 #define pthread_cond_signal WakeConditionVariable
 #define pthread_cond_broadcast WakeAllConditionVariable
 
+#define pthread_once_t INIT_ONCE
+
+#define PTHREAD_ONCE_INIT INIT_ONCE_STATIC_INIT
+int pthread_once(pthread_once_t *once_control, void (*init_routine)(void));
+
 /*
  * Simple thread creation implementation using pthread API
  */
diff --git a/thread-utils.c b/thread-utils.c
index 5329845691..937deb3f2e 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -122,4 +122,15 @@ int dummy_pthread_join(pthread_t pthread, void **retval)
 	return ENOSYS;
 }
 
+int nothreads_pthread_once(pthread_once_t *once_control,
+			   void (*init_routine)(void))
+{
+	if (*once_control == 1)
+		return 0;
+
+	init_routine();
+	*once_control = 1;
+	return 0;
+}
+
 #endif
diff --git a/thread-utils.h b/thread-utils.h
index 4961487ed9..bab9dc5e4d 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -19,6 +19,7 @@
 #define pthread_mutex_t int
 #define pthread_cond_t int
 #define pthread_key_t int
+#define pthread_once_t int
 
 #define pthread_mutex_init(mutex, attr) dummy_pthread_init(mutex)
 #define pthread_mutex_lock(mutex)
@@ -48,6 +49,11 @@ int dummy_pthread_join(pthread_t pthread, void **retval);
 
 int dummy_pthread_init(void *);
 
+#define PTHREAD_ONCE_INIT 0
+int nothreads_pthread_once(pthread_once_t *once_control,
+			   void (*init_routine)(void));
+#define pthread_once(once, routine) nothreads_pthread_once(once, routine)
+
 #endif
 
 int online_cpus(void);
-- 
2.26.2

