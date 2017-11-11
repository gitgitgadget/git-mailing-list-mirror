Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A37E1F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 19:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbdKKT3v (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 14:29:51 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:53711 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbdKKT3u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 14:29:50 -0500
Received: by mail-wr0-f193.google.com with SMTP id u40so11173752wrf.10
        for <git@vger.kernel.org>; Sat, 11 Nov 2017 11:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TeWSNr/5An/G8PgabUhIHqdcNUb4RB+w+rjMPUIcCRg=;
        b=B393/hw8gRAr5CUgFgfRJTreT86LM5GQ6FZ1QXJ2fb0JfAlGAMZrbW3Te1R+8H2cfI
         JrQpvAEY20YDhB21ZA7LjYl2FjYEQh7gY4BaNAXujF/GPMtWE1robG4317Bs+AuZOl+v
         waM315DIDcb+WUxzYpO4GxLZUwYaZh2Fd3vbQWvqonPo1HiEH25zwlkrbZ/NIlZC3I7k
         lFpQbik5sK6t1nC1tpU9Y9WH3aZIKwyh8/nnEhPXm20dty+/lyHOWYVG84J8vQYzYcJL
         9aVOYfkzSheWwh4uFbOzfqUaA8Iqsw+js6d1HD0XXSlWW+qzFTj2d/96VT3QyCPjKLeW
         kpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TeWSNr/5An/G8PgabUhIHqdcNUb4RB+w+rjMPUIcCRg=;
        b=fKfo0C/zx0Pzy2h9t25YTw5xWizE6bXDJuV6VqiOOB94J5FdbWSICBx1O99syZxc1W
         L27qqYmQpJd4Xz0ZJ2xoKB9iEp15fnHi6zN33ZgIMX2K1n7l1wlye3uYlIDFGqEgDWgy
         2+l3ogUKrX0TtK/ZoOy7O7+22CMGt7uduAjIEl0ZMw+U7ouZUy08cnEGwhkio8x0JjSD
         eMLOhYFWQN0u1e3qLf8vOtlHBZ6TY8EwKTTvXziKMuATLnjxshWjiToaPKItXmw27KG0
         wb58GPeFT8rHJ4dh/3udUEkgzGgiqUJzsFgd1l8mycAT11VnglPsuaV8CDhepyWOVkZr
         a7UA==
X-Gm-Message-State: AJaThX7kmu2OmKQznU0PFLAm0wBdVWo1/mZl2qJlgpZuIFwwg+RuoVwh
        VML3dwpgOiYE8HnjWF1DCrLMRREb
X-Google-Smtp-Source: AGs4zMaB1ZyttVixdZoGk5CkEPN01igtYY/ultpRLZj8DjpdZaoDAeDWmb5t9g+hBE/9jBVnv/prxg==
X-Received: by 10.223.138.175 with SMTP id y44mr3717708wry.273.1510428588834;
        Sat, 11 Nov 2017 11:29:48 -0800 (PST)
Received: from p50-debian.bsdmn ([213.205.251.146])
        by smtp.gmail.com with ESMTPSA id m3sm19330041wrf.56.2017.11.11.11.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Nov 2017 11:29:48 -0800 (PST)
From:   gennady.kupava@gmail.com
To:     git@vger.kernel.org
Cc:     Gennady Kupava <gkupava@bloomberg.net>
Subject: [PATCH] Reduce performance penalty for turned off traces
Date:   Sat, 11 Nov 2017 19:28:58 +0000
Message-Id: <20171111192858.27255-1-gennady.kupava@gmail.com>
X-Mailer: git-send-email 2.15.0.164.g4123bcaed.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Gennady Kupava <gkupava@bloomberg.net>

Signed-off-by: Gennady Kupava <gkupava@bloomberg.net>
---
One of the tasks siggested in scope of 'Git sprint weekend'.
Couple of chioces made here:
 1. Use constant instead of NULL to indicate default trace level, this just
makes everything simpler.
 2. Move just enough from implementation to header, to be able to do check
before calling actual functions.
 3. Most controversail: do not support optimization for older compilers not
supporting variadic templates in macroses. Problem is that theoretically
someone may write some complicated trace while would work in 'modern' compiler and be too slow in more 'classic' compilers, however expectation is that risk of that is quite low and 'classic' compilers will go away eventually.

Passes test suite locally on Linux/amd64.

 trace.c | 29 ++++++----------------------
 trace.h | 68 +++++++++++++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 55 insertions(+), 42 deletions(-)

diff --git a/trace.c b/trace.c
index 7508aea02..180ee3b00 100644
--- a/trace.c
+++ b/trace.c
@@ -25,26 +25,14 @@
 #include "cache.h"
 #include "quote.h"
 
-/*
- * "Normalize" a key argument by converting NULL to our trace_default,
- * and otherwise passing through the value. All caller-facing functions
- * should normalize their inputs in this way, though most get it
- * for free by calling get_trace_fd() (directly or indirectly).
- */
-static void normalize_trace_key(struct trace_key **key)
-{
-	static struct trace_key trace_default = { "GIT_TRACE" };
-	if (!*key)
-		*key = &trace_default;
-}
+struct trace_key trace_default_key = { TRACE_KEY_PREFIX, 0, 0, 0 };
+struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
 
 /* Get a trace file descriptor from "key" env variable. */
 static int get_trace_fd(struct trace_key *key)
 {
 	const char *trace;
 
-	normalize_trace_key(&key);
-
 	/* don't open twice */
 	if (key->initialized)
 		return key->fd;
@@ -82,8 +70,6 @@ static int get_trace_fd(struct trace_key *key)
 
 void trace_disable(struct trace_key *key)
 {
-	normalize_trace_key(&key);
-
 	if (key->need_close)
 		close(key->fd);
 	key->fd = 0;
@@ -129,7 +115,6 @@ static int prepare_trace_line(const char *file, int line,
 static void trace_write(struct trace_key *key, const void *buf, unsigned len)
 {
 	if (write_in_full(get_trace_fd(key), buf, len) < 0) {
-		normalize_trace_key(&key);
 		warning("unable to write trace for %s: %s",
 			key->key, strerror(errno));
 		trace_disable(key);
@@ -168,13 +153,13 @@ static void trace_argv_vprintf_fl(const char *file, int line,
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!prepare_trace_line(file, line, NULL, &buf))
+	if (!prepare_trace_line(file, line, &trace_default_key, &buf))
 		return;
 
 	strbuf_vaddf(&buf, format, ap);
 
 	sq_quote_argv(&buf, argv, 0);
-	print_trace_line(NULL, &buf);
+	print_trace_line(&trace_default_key, &buf);
 }
 
 void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
@@ -189,8 +174,6 @@ void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 	print_trace_line(key, &buf);
 }
 
-static struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
-
 static void trace_performance_vprintf_fl(const char *file, int line,
 					 uint64_t nanos, const char *format,
 					 va_list ap)
@@ -216,7 +199,7 @@ void trace_printf(const char *format, ...)
 {
 	va_list ap;
 	va_start(ap, format);
-	trace_vprintf_fl(NULL, 0, NULL, format, ap);
+	trace_vprintf_fl(NULL, 0, &trace_default_key, format, ap);
 	va_end(ap);
 }
 
@@ -341,7 +324,7 @@ void trace_repo_setup(const char *prefix)
 
 int trace_want(struct trace_key *key)
 {
-	return !!get_trace_fd(key);
+       return !!get_trace_fd(key);
 }
 
 #if defined(HAVE_CLOCK_GETTIME) && defined(HAVE_CLOCK_MONOTONIC)
diff --git a/trace.h b/trace.h
index 179b249c5..64326573a 100644
--- a/trace.h
+++ b/trace.h
@@ -4,6 +4,8 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 
+#define TRACE_KEY_PREFIX "GIT_TRACE"
+
 struct trace_key {
 	const char * const key;
 	int fd;
@@ -11,7 +13,10 @@ struct trace_key {
 	unsigned int  need_close : 1;
 };
 
-#define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
+#define TRACE_KEY_INIT(name) { TRACE_KEY_PREFIX "_" #name, 0, 0, 0 }
+
+extern struct trace_key trace_default_key;
+extern struct trace_key trace_perf_key;
 
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(struct trace_key *key);
@@ -77,24 +82,49 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
  * comma, but this is non-standard.
  */
 
-#define trace_printf(...) \
-	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, NULL, __VA_ARGS__)
-
-#define trace_printf_key(key, ...) \
-	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__)
-
-#define trace_argv_printf(argv, ...) \
-	trace_argv_printf_fl(TRACE_CONTEXT, __LINE__, argv, __VA_ARGS__)
-
-#define trace_strbuf(key, data) \
-	trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key, data)
-
-#define trace_performance(nanos, ...) \
-	trace_performance_fl(TRACE_CONTEXT, __LINE__, nanos, __VA_ARGS__)
-
-#define trace_performance_since(start, ...) \
-	trace_performance_fl(TRACE_CONTEXT, __LINE__, getnanotime() - (start), \
-			     __VA_ARGS__)
+#define trace_pass(key) ((key)->fd || !(key)->initialized)
+
+#define trace_printf(...)						    \
+	do {								    \
+		if (trace_pass(&trace_default_key))			    \
+			trace_printf_key_fl(TRACE_CONTEXT, __LINE__,        \
+					    &trace_default_key,__VA_ARGS__);\
+	} while(0)
+
+#define trace_printf_key(key, ...)					    \
+	do {								    \
+		if (trace_pass(key))					    \
+			trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key,   \
+					    __VA_ARGS__);		    \
+	} while(0)
+
+#define trace_argv_printf(argv, ...)					    \
+	do {								    \
+		if (trace_pass(&trace_default_key))			    \
+		       trace_argv_printf_fl(TRACE_CONTEXT, __LINE__,	    \
+					    argv, __VA_ARGS__);		    \
+	} while(0)
+
+#define trace_strbuf(key, data)						    \
+	do {								    \
+		if (trace_pass(key))					    \
+			trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key, data);\
+	} while(0)
+
+#define trace_performance(nanos, ...)					    \
+	do {								    \
+		if (trace_pass(key))					    \
+			trace_performance_fl(TRACE_CONTEXT, __LINE__, nanos,\
+					     __VA_ARGS__);  		    \
+	} while(0)
+
+#define trace_performance_since(start, ...)				    \
+	do {								    \
+		if (trace_pass(&trace_perf_key))			    \
+			trace_performance_fl(TRACE_CONTEXT, __LINE__,       \
+					     getnanotime() - (start),	    \
+					     __VA_ARGS__);		    \
+	} while(0)
 
 /* backend functions, use non-*fl macros instead */
 __attribute__((format (printf, 4, 5)))
-- 
2.14.1

