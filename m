Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0FA31F453
	for <e@80x24.org>; Sat, 27 Oct 2018 17:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbeJ1CMA (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 22:12:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37674 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbeJ1CMA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 22:12:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id c4-v6so4019113lja.4
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drqTQBtS50H1vlemHJ1Blbd8zNG6Y/k1rTNoKJyfCqs=;
        b=UbFa98pbnlvd/LDeJAN1b339brRwnyspRdg9kdZ7acYTXsMeEYLfpi2f3oWwVJUw3f
         KZB56v0caqOU6PViz2WZf6FdUi06Fjc8A+gSG5amfyXwoodajMz5tzzcHqNSk6i9iXFA
         o2M9Oa6O0C05SfzkO5i4/KRe5B+kCtxkcH9Wza+B0Qo6vOrz+K3sowEP+LmU/bSYT4Ha
         EwCfALUmTOUEPHZ/Pt9lDCgHIXqeExneaq3XJdqlgtlFatTjr6bdniRypcQQ3L155Wor
         HZ1GYHdin+KcqZ+a/dROMSS5f2j1iZ07/4xivhGwOlUt2LdTl1ranSVktn5WMqVmnDXn
         zk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drqTQBtS50H1vlemHJ1Blbd8zNG6Y/k1rTNoKJyfCqs=;
        b=EhARxAVFWbQRnfcn+DOpLIui3ImWBcIQw2XH/AwyFiJujc/RxI97ahYEdHLzd0kh9b
         iVhJHAypIa7WLBbuXrB1+o+JJuMGlEsfzFP8pnn6HptPCNxy7aGcuu43VuMMlZ2tcS2H
         xxPAA+56kxk6f5ddjdi/JE1nr3dSxo5zjhp58nEnsKII8TMUvDBvc9rSeIurw6xg/Y+y
         0Gr3PyZg+6I9xiCAtQHausDaHSG0AW16mfqBTwDejP/xlaOVI5nmZ2aP17XDAE/AJWz7
         3DGxT6wsrrpVk4SK/8nTfD7hMl0SrvnITmg9XmUOdy78FuC3Zoq/LdqeM0H1b66Sohjf
         YmWg==
X-Gm-Message-State: AGRZ1gJFBpzYyrVPXfiHDA6C3VEGbXxcLeZrroIvffeopFon7QYqAX2Q
        TqKxQi+sThC8RIB+bbptc0ZE6aGE
X-Google-Smtp-Source: AJdET5dQgAFBXkfuPnJx8QQPyk5jEm7XSF9xpubzHUCocBBZHGMsi/Ct4aiKk8e0aOC48UCFvwE8EQ==
X-Received: by 2002:a2e:924b:: with SMTP id v11-v6mr1124536ljg.9.1540661417260;
        Sat, 27 Oct 2018 10:30:17 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i185-v6sm2333517lfg.89.2018.10.27.10.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 10:30:16 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v2 01/10] thread-utils: macros to unconditionally compile pthreads API
Date:   Sat, 27 Oct 2018 19:29:59 +0200
Message-Id: <20181027173008.18852-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027173008.18852-1-pclouds@gmail.com>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When built with NO_PTHREADS, the macros are used make the code build
even though pthreads header and library may be missing. The code can
still have different code paths for no threads support with
HAVE_THREADS variable.

There are of course impacts on no-pthreads builds:

- data structure may get slightly bigger because all the mutexes and
  pthread_t are present (as an int)

- code execution is not impacted much. Locking (in hot path) is
  no-op. Other wrapper function calls really should not matter much.

- the binary size grows bigger because of threaded code. But at least
  on Linux this does not matter, if some code is not executed, it's
  not mapped in memory.

This is a preparation step to remove "#ifdef NO_PTHREADS" in the code
mostly because of maintainability. As Jeff put it

> it's probably OK to stop thinking of it as "non-threaded platforms
> are the default and must pay zero cost" and more as "threaded
> platforms are the default, and non-threaded ones are OK to pay a
> small cost as long as they still work".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile       |  2 +-
 thread-utils.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 thread-utils.h | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index b08d5ea258..321540a736 100644
--- a/Makefile
+++ b/Makefile
@@ -991,6 +991,7 @@ LIB_OBJS += sub-process.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += tempfile.o
+LIB_OBJS += thread-utils.o
 LIB_OBJS += tmp-objdir.o
 LIB_OBJS += trace.o
 LIB_OBJS += trailer.o
@@ -1674,7 +1675,6 @@ ifdef NO_PTHREADS
 else
 	BASIC_CFLAGS += $(PTHREAD_CFLAGS)
 	EXTLIBS += $(PTHREAD_LIBS)
-	LIB_OBJS += thread-utils.o
 endif
 
 ifdef HAVE_PATHS_H
diff --git a/thread-utils.c b/thread-utils.c
index a2135e0743..5329845691 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -20,6 +20,9 @@
 
 int online_cpus(void)
 {
+#ifdef NO_PTHREADS
+	return 1;
+#else
 #ifdef _SC_NPROCESSORS_ONLN
 	long ncpus;
 #endif
@@ -59,10 +62,12 @@ int online_cpus(void)
 #endif
 
 	return 1;
+#endif
 }
 
 int init_recursive_mutex(pthread_mutex_t *m)
 {
+#ifndef NO_PTHREADS
 	pthread_mutexattr_t a;
 	int ret;
 
@@ -74,4 +79,47 @@ int init_recursive_mutex(pthread_mutex_t *m)
 		pthread_mutexattr_destroy(&a);
 	}
 	return ret;
+#else
+	return 0;
+#endif
+}
+
+#ifdef NO_PTHREADS
+int dummy_pthread_create(pthread_t *pthread, const void *attr,
+			 void *(*fn)(void *), void *data)
+{
+	/*
+	 * Do nothing.
+	 *
+	 * The main purpose of this function is to break compiler's
+	 * flow analysis and avoid -Wunused-variable false warnings.
+	 */
+	return ENOSYS;
+}
+
+int dummy_pthread_init(void *data)
+{
+	/*
+	 * Do nothing.
+	 *
+	 * The main purpose of this function is to break compiler's
+	 * flow analysis or it may realize that functions like
+	 * pthread_mutex_init() is no-op, which means the (static)
+	 * variable is not used/initialized at all and trigger
+	 * -Wunused-variable
+	 */
+	return ENOSYS;
 }
+
+int dummy_pthread_join(pthread_t pthread, void **retval)
+{
+	/*
+	 * Do nothing.
+	 *
+	 * The main purpose of this function is to break compiler's
+	 * flow analysis and avoid -Wunused-variable false warnings.
+	 */
+	return ENOSYS;
+}
+
+#endif
diff --git a/thread-utils.h b/thread-utils.h
index d9a769d190..4961487ed9 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -4,12 +4,54 @@
 #ifndef NO_PTHREADS
 #include <pthread.h>
 
-extern int online_cpus(void);
-extern int init_recursive_mutex(pthread_mutex_t*);
+#define HAVE_THREADS 1
 
 #else
 
-#define online_cpus() 1
+#define HAVE_THREADS 0
+
+/*
+ * macros instead of typedefs because pthread definitions may have
+ * been pulled in by some system dependencies even though the user
+ * wants to disable pthread.
+ */
+#define pthread_t int
+#define pthread_mutex_t int
+#define pthread_cond_t int
+#define pthread_key_t int
+
+#define pthread_mutex_init(mutex, attr) dummy_pthread_init(mutex)
+#define pthread_mutex_lock(mutex)
+#define pthread_mutex_unlock(mutex)
+#define pthread_mutex_destroy(mutex)
+
+#define pthread_cond_init(cond, attr) dummy_pthread_init(cond)
+#define pthread_cond_wait(cond, mutex)
+#define pthread_cond_signal(cond)
+#define pthread_cond_broadcast(cond)
+#define pthread_cond_destroy(cond)
+
+#define pthread_key_create(key, attr) dummy_pthread_init(key)
+#define pthread_key_delete(key)
+
+#define pthread_create(thread, attr, fn, data) \
+	dummy_pthread_create(thread, attr, fn, data)
+#define pthread_join(thread, retval) \
+	dummy_pthread_join(thread, retval)
+
+#define pthread_setspecific(key, data)
+#define pthread_getspecific(key) NULL
+
+int dummy_pthread_create(pthread_t *pthread, const void *attr,
+			 void *(*fn)(void *), void *data);
+int dummy_pthread_join(pthread_t pthread, void **retval);
+
+int dummy_pthread_init(void *);
 
 #endif
+
+int online_cpus(void);
+int init_recursive_mutex(pthread_mutex_t*);
+
+
 #endif /* THREAD_COMPAT_H */
-- 
2.19.1.647.g708186aaf9

