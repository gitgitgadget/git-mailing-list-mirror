Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A1F1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 18:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbeJSCHn (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 22:07:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45522 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbeJSCHm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 22:07:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id j4-v6so28549887ljc.12
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cTxB4efU9wZ03jLpurLVXFS5i7q/BAbsLAf4IYQZuqw=;
        b=tCSHP2nkElrRzEItq9steta4xq60J4UZIMgNBGzkf+7WEjKLPHTb5AaKy4DXhf7FNN
         e/gKM/uP5ygfYv4wMKJZMiVLSQKMvKu8e5Lq0xIQsMQfQ7EZjh8mKHgzj7CmxNkLIpGc
         KnlD3xIiLaDdJ0m7J0PdB8BQckWY+1jCkiugAsqvYCqfCsfxxFpMy9pcCsdwf2Hq+vha
         broatTlqxe6jCKIubJ9xtXV0GlciAQN49J0mZRk/KqZHlXvJz2AD1lJ1U+HpH+ZU351y
         tw8wj+wzoUFjkybbx6n7Dh0oflJaJk/Ob6QVpR3Xir2oSAplGTQDETCfW4AeavdYnOl8
         /uWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cTxB4efU9wZ03jLpurLVXFS5i7q/BAbsLAf4IYQZuqw=;
        b=uAZDQvuA0sihqAUW1t3fgrtD8W8v1PQ1bmQB3owptxWyLaSeRKzqb+y69liOztumgE
         5ee//ipG5pw9P/MG7B9gup4aNdGv9PgiYw7t1EIs6hoQAAykfffXsQd9WDiW+1xqPYpD
         s8McQeuXNF2FykXBrMoRkQtW3RJuP8WCoPlWkoQ2xh2DHga5d44/R03/4jIqPmfhWyyc
         ecVGyB/5Pmp2kvFSFGdAv4gxN38db9hEwmUl+IdvM8BfjorV48WXHHaQHMIHzD6LJd4c
         AMxW1HlCJhNlRFMFETle5scQde11T3Xiqxm6n5tV6A9KZzB75uTtAcPqOwsYUGjJ+xob
         bjAg==
X-Gm-Message-State: ABuFfognFmWtmBmwBflC3hWKjB4aKy5tRSJ1c7qkp/2iLsImDQwF9sb2
        fRtImFA1p1dNOYwfOp321HGy4EAj
X-Google-Smtp-Source: ACcGV61xas3sVZawLf7NIjM13bWY/5t7sXh6XPNhQXUWXhj2a6zyB+peicfF1B/pF79Y3Mhqeocqcg==
X-Received: by 2002:a2e:4502:: with SMTP id s2-v6mr20912517lja.44.1539885931500;
        Thu, 18 Oct 2018 11:05:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1063930lfc.36.2018.10.18.11.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 11:05:30 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC] thread-utils: better wrapper to avoid #ifdef NO_PTHREADS
Date:   Thu, 18 Oct 2018 20:05:22 +0200
Message-Id: <20181018180522.17642-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181018170934.GA21138@sigill.intra.peff.net>
References: <20181018170934.GA21138@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 7:09 PM Jeff King <peff@peff.net> wrote:
> > In this particular case though I think we should be able to avoid so
> > much #if if we make a wrapper for pthread api that would return an
> > error or something when pthread is not available. But similar
> > situation may happen elsewhere too.
>
> Yeah, I think that is generally the preferred method anyway, just
> because of readability and simplicity.

I've wanted to do this for a while, so let's test the water and see if
it's well received.

This patch is a proof of concept that adds just enough macros so that
I can build index-pack.c on a single thread mode with zero #ifdef
related to NO_PTHREADS.

Besides readability and simplicity, it reduces the chances of breaking
conditional builds (e.g. you rename a variable name but forgot that
the variable is in #if block that is not used by your
compiler/platform).

Performance-wise I don't think there is any loss for single thread
mode. I rely on compilers recognizing HAVE_THREADS being a constant
and remove dead code or at least optimize in favor of non-dead code.

Memory-wise, yes we use some more memory in single thread mode. But we
don't have zillions of mutexes or thread id, so a bit extra memory
does not worry me so much.

Hmm?
---
 Makefile             |  2 +-
 builtin/index-pack.c | 68 ++++++++++++--------------------------------
 thread-utils.c       | 30 +++++++++++++++++++
 thread-utils.h       | 38 +++++++++++++++++++++++--
 4 files changed, 84 insertions(+), 54 deletions(-)

diff --git a/Makefile b/Makefile
index 5bf1af369e..ef852031bd 100644
--- a/Makefile
+++ b/Makefile
@@ -981,6 +981,7 @@ LIB_OBJS += sub-process.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += tempfile.o
+LIB_OBJS += thread-utils.o
 LIB_OBJS += tmp-objdir.o
 LIB_OBJS += trace.o
 LIB_OBJS += trailer.o
@@ -1664,7 +1665,6 @@ ifdef NO_PTHREADS
 else
 	BASIC_CFLAGS += $(PTHREAD_CFLAGS)
 	EXTLIBS += $(PTHREAD_LIBS)
-	LIB_OBJS += thread-utils.o
 endif
 
 ifdef HAVE_PATHS_H
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2004e25da2..bbd66ca025 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -42,9 +42,7 @@ struct base_data {
 };
 
 struct thread_local {
-#ifndef NO_PTHREADS
 	pthread_t thread;
-#endif
 	struct base_data *base_cache;
 	size_t base_cache_used;
 	int pack_fd;
@@ -98,8 +96,6 @@ static uint32_t input_crc32;
 static int input_fd, output_fd;
 static const char *curr_pack;
 
-#ifndef NO_PTHREADS
-
 static struct thread_local *thread_data;
 static int nr_dispatched;
 static int threads_active;
@@ -179,26 +175,6 @@ static void cleanup_thread(void)
 	free(thread_data);
 }
 
-#else
-
-#define read_lock()
-#define read_unlock()
-
-#define counter_lock()
-#define counter_unlock()
-
-#define work_lock()
-#define work_unlock()
-
-#define deepest_delta_lock()
-#define deepest_delta_unlock()
-
-#define type_cas_lock()
-#define type_cas_unlock()
-
-#endif
-
-
 static int mark_link(struct object *obj, int type, void *data, struct fsck_options *options)
 {
 	if (!obj)
@@ -364,22 +340,20 @@ static NORETURN void bad_object(off_t offset, const char *format, ...)
 
 static inline struct thread_local *get_thread_data(void)
 {
-#ifndef NO_PTHREADS
-	if (threads_active)
-		return pthread_getspecific(key);
-	assert(!threads_active &&
-	       "This should only be reached when all threads are gone");
-#endif
+	if (HAVE_THREADS) {
+		if (threads_active)
+			return pthread_getspecific(key);
+		assert(!threads_active &&
+		       "This should only be reached when all threads are gone");
+	}
 	return &nothread_data;
 }
 
-#ifndef NO_PTHREADS
 static void set_thread_data(struct thread_local *data)
 {
 	if (threads_active)
 		pthread_setspecific(key, data);
 }
-#endif
 
 static struct base_data *alloc_base_data(void)
 {
@@ -1092,7 +1066,6 @@ static void resolve_base(struct object_entry *obj)
 	find_unresolved_deltas(base_obj);
 }
 
-#ifndef NO_PTHREADS
 static void *threaded_second_pass(void *data)
 {
 	set_thread_data(data);
@@ -1116,7 +1089,6 @@ static void *threaded_second_pass(void *data)
 	}
 	return NULL;
 }
-#endif
 
 /*
  * First pass:
@@ -1213,7 +1185,6 @@ static void resolve_deltas(void)
 		progress = start_progress(_("Resolving deltas"),
 					  nr_ref_deltas + nr_ofs_deltas);
 
-#ifndef NO_PTHREADS
 	nr_dispatched = 0;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
 		init_thread();
@@ -1229,7 +1200,6 @@ static void resolve_deltas(void)
 		cleanup_thread();
 		return;
 	}
-#endif
 
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
@@ -1531,11 +1501,11 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 		if (nr_threads < 0)
 			die(_("invalid number of threads specified (%d)"),
 			    nr_threads);
-#ifdef NO_PTHREADS
-		if (nr_threads != 1)
-			warning(_("no threads support, ignoring %s"), k);
-		nr_threads = 1;
-#endif
+		if (!HAVE_THREADS) {
+			if (nr_threads != 1)
+				warning(_("no threads support, ignoring %s"), k);
+			nr_threads = 1;
+		}
 		return 0;
 	}
 	return git_default_config(k, v, cb);
@@ -1723,12 +1693,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				nr_threads = strtoul(arg+10, &end, 0);
 				if (!arg[10] || *end || nr_threads < 0)
 					usage(index_pack_usage);
-#ifdef NO_PTHREADS
-				if (nr_threads != 1)
-					warning(_("no threads support, "
-						  "ignoring %s"), arg);
-				nr_threads = 1;
-#endif
+				if (!HAVE_THREADS) {
+					if (nr_threads != 1)
+						warning(_("no threads support, "
+							  "ignoring %s"), arg);
+					nr_threads = 1;
+				}
 			} else if (starts_with(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
@@ -1791,14 +1761,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (strict)
 		opts.flags |= WRITE_IDX_STRICT;
 
-#ifndef NO_PTHREADS
-	if (!nr_threads) {
+	if (HAVE_THREADS && !nr_threads) {
 		nr_threads = online_cpus();
 		/* An experiment showed that more threads does not mean faster */
 		if (nr_threads > 3)
 			nr_threads = 3;
 	}
-#endif
 
 	curr_pack = open_pack_file(pack_name);
 	parse_pack_header();
diff --git a/thread-utils.c b/thread-utils.c
index a2135e0743..d205a474e0 100644
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
 
@@ -74,4 +79,29 @@ int init_recursive_mutex(pthread_mutex_t *m)
 		pthread_mutexattr_destroy(&a);
 	}
 	return ret;
+#else
+	return ENOSYS;
+#endif
+}
+
+#ifdef NO_PTHREADS
+int dummy_pthread_create(pthread_t *pthread, const void *attr,
+			 void *(*fn)(void *), void *data)
+{
+	return ENOSYS;
 }
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
+}
+#endif
diff --git a/thread-utils.h b/thread-utils.h
index d9a769d190..b8c6500c42 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -4,12 +4,44 @@
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
+
+#define pthread_mutex_init(mutex, attr) dummy_pthread_init(mutex)
+#define pthread_mutex_lock(mutex)
+#define pthread_mutex_unlock(mutex)
+#define pthread_mutex_destroy(mutex)
+
+#define pthread_key_create(key, attr) dummy_pthread_init(key)
+#define pthread_key_delete(key)
+
+#define pthread_create(thread, attr, fn, data) \
+	dummy_pthread_create(thread, attr, fn, data)
+#define pthread_join(thread, reval) ENOSYS
+
+#define pthread_setspecific(key, data)
+#define pthread_getspecific(key) NULL
+
+int dummy_pthread_create(pthread_t *pthread, const void *attr,
+			 void *(*fn)(void *), void *data);
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

