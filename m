Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FFEC433E1
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919862089D
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="qxu33yVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgFZVyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZVyR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 17:54:17 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CAEC03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 14:54:17 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j80so10214325qke.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3i9XBYl/vR64idbyp/u5ZP79qVrK+1qV4Gmws6W/uc=;
        b=qxu33yVdev/OVxEACxy19gJnZ7QrXhcnCX30XijADbImdKtkyhkdyOoYcuh8kjPMgI
         CRrnG/cBQAhNjIpj0cbAZtQSnbcwMqNx2xr14uq1EASZ2dX60eyk3+YBHyfsbuNTnuqy
         5FEaC07ncZbWuiv+3G+uRwfPTg9AgOLegP7x+PvHSXEqp8/EbTqve+ftcrspnRbGJsMb
         bTecy12qukBWnbGcIKENvZz6D05fU59Xv+SQ/9p9MovAtWhpqK0cZyVrAeZydR0mztmE
         8V6vkF5MRUVxn1n0C8rNWDTlhk04E7m/1pMHhO7SV1dvfvBUNQBxNZLBGCrEUPC02Wee
         EOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3i9XBYl/vR64idbyp/u5ZP79qVrK+1qV4Gmws6W/uc=;
        b=t3UvnM6oZWOaTtpwltkLdOpTmDzAeT1LmBNvFGiHlSdgcyjLfjEmzdD8WMiTcY1Mb9
         dXgWBgJ65SX1U6j3/7Rdg7O38+IiWl8xNp5oDuz/wZlmlQWC+FnysfNiL0FS53IqFN54
         h/1rosf3wXeQx3cI5VJ91gyReTq7/o1JPPoAMAmelb2kUN4mbWFfc5LWs+ciYddY1YQm
         lgjY2uh7DSHCxjVs383Rf+jkAAPCh8y22rkThUlO9LlgfMYzdHKLSZyHYbvFHrz8p4D+
         lblztCbx+kFpful/1NKW9MgX1Kagw9ivvq30FNYduJFBAid0Z3AQBF68qKdcoBTvarSN
         iPKw==
X-Gm-Message-State: AOAM531dmJ1TRp6tlO/y7TdpTvS3U33TX2o4S7p+W31CK6SHofTIJpY1
        0S31QBZpERTf1t4xu2RkLUtf3Mh8f28=
X-Google-Smtp-Source: ABdhPJzDhh/6vZ518Wh6KJRi7rAo8zkaeNJZlsCVNWArKMyrHDb3gylSnOgssyyjZpD222yrL3M5Lg==
X-Received: by 2002:ae9:e519:: with SMTP id w25mr4841607qkf.327.1593208455833;
        Fri, 26 Jun 2020 14:54:15 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::2])
        by smtp.gmail.com with ESMTPSA id c27sm9473475qka.23.2020.06.26.14.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:54:15 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, j6t@kdbg.org,
        jonathantanmy@google.com, peff@peff.net,
        Johannes.Schindelin@gmx.de, christian.couder@gmail.com
Subject: [PATCH v2 1/2] compat/win32/pthread: add pthread_once()
Date:   Fri, 26 Jun 2020 18:54:02 -0300
Message-Id: <783fcddf8db92805ecab2d209d04466d22312075.1593208411.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593208411.git.matheus.bernardino@usp.br>
References: <cover.1593208411.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add pthread_once() emulation for Windows. This function provides an easy
way to do thread-safe one-time initializations in multithreaded code. It
will be used in the next commit to make hash_to_hex_algop()
thread-safe.

The pthread_once() implementation added comes from libav
(https://git.libav.org/?p=libav.git), commit b22693b ("w32pthreads: Add
pthread_once emulation", 2015-10-07). The code is licensed under
LGPLv2.1 which is compatible with GPLv2. Only the section for support on
Windows Vista+ has been ported, as that's the minimum version required
to build Git for Windows.  Also, the code was modified to (1) check and
return error codes; and (2) do not call InitOnceComplete() again after a
successful initialization, as that results in an error.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 compat/win32/pthread.c | 18 ++++++++++++++++++
 compat/win32/pthread.h |  5 +++++
 thread-utils.c         | 11 +++++++++++
 thread-utils.h         |  7 +++++++
 4 files changed, 41 insertions(+)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 2e7eead42c..cb32f8c504 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -56,3 +56,21 @@ pthread_t pthread_self(void)
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
+	if (!InitOnceBeginInitialize(once_control, 0, &pending, NULL)) {
+		ret = err_win_to_posix(GetLastError());
+	} else if (pending) {
+		init_routine();
+		if (!InitOnceComplete(once_control, 0, NULL))
+			ret = err_win_to_posix(GetLastError());
+	}
+
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
index 4961487ed9..8f9786217a 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -19,6 +19,7 @@
 #define pthread_mutex_t int
 #define pthread_cond_t int
 #define pthread_key_t int
+#define pthread_once_t int
 
 #define pthread_mutex_init(mutex, attr) dummy_pthread_init(mutex)
 #define pthread_mutex_lock(mutex)
@@ -48,6 +49,12 @@ int dummy_pthread_join(pthread_t pthread, void **retval);
 
 int dummy_pthread_init(void *);
 
+#define PTHREAD_ONCE_INIT 0
+#define pthread_once(once, routine) nothreads_pthread_once(once, routine)
+
+int nothreads_pthread_once(pthread_once_t *once_control,
+			   void (*init_routine)(void));
+
 #endif
 
 int online_cpus(void);
-- 
2.26.2

