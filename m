Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A5DC433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 10:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbiBSKmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 05:42:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242027AbiBSKmH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 05:42:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FED0369E9
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 02:41:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e3so18659139wra.0
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 02:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ewoWvDPwqYD2y+K31lc4E9QPAp1SuizWovvB6htHz1I=;
        b=cPNq7zlYYuNaRMtvF98hnFZ6Pu6BnsTob6k1uPk29W0wlXXsphEy8XJCDqMB9n9QhW
         fHtiWPtnlWbNQG4nyWIV8mGVxQsj5Ngmg/5hje5C4RYjL5m5OP+IuL5vMLmrK0NcACVI
         iUeDaK2/nblkAvQQ3N3PQ9sEHwxyAWUiyXAY0PLl4c/fPHffgjGbiGjww8MF9xm927H/
         iOiPN3Mcr8WS6Sti/iHE8UTtqBmfNpMdqtRQpe3sTnZrQakyEsYkN+B6VcVvSMJy7l0T
         bYthXf8AIzRrIM92N1g/XqXyn/nRu8ZRz5MW1zzJrmIcTGLdpyL0rrV89xd6E1OvE7FC
         hNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ewoWvDPwqYD2y+K31lc4E9QPAp1SuizWovvB6htHz1I=;
        b=CJ4+lFTVwrSx+st8yWa9DiH4Y1obeddf6DlMsV/CSxyQ4FmVm8P7Fe2a4Qhmeb6ZX1
         dGOgMWOF79i/q6Ug6mN61dMStsnpCbloz8Hm1KnS9wVyPqnCiLvGOw36GFpEbM2C+uPM
         l1VKCman33+EICRwerTcgEq5SC7PUJCa4iHlJfNQPRal59obL7wDyIO2AwJ9pUdMs9CI
         i3ZA3+0WRAcjESTlcTXpHfHCj1a4/xuRp0M22HtCVeNRqJkEBKYCCnfhBYnOLBLL8MnC
         Jk1QJ6lxdsLiV4U4n1/exb82EtaFNKAAcDAD6k9aAHzg5pZbSFzt8Awq3N7YueoY4JG0
         4CGw==
X-Gm-Message-State: AOAM532MVccE0bZfBnwr80LXHJUmGHiupX3z+a1sJrbri0HCnyGuNLFM
        W2cuQmoaCK+2sGANy98UIw8m9laR7TdmAg==
X-Google-Smtp-Source: ABdhPJytEBJf+ExRhgwhiPXOn6K6a6dkYyEJbdzNwUfcfsCd064z05NDHaBYpX2hbN2WNApaBIeBeg==
X-Received: by 2002:a5d:452e:0:b0:1e2:e3df:5933 with SMTP id j14-20020a5d452e000000b001e2e3df5933mr9721937wra.158.1645267305998;
        Sat, 19 Feb 2022 02:41:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 1sm21623928wrz.75.2022.02.19.02.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:41:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/3] C99: remove hardcoded-out !HAVE_VARIADIC_MACROS code
Date:   Sat, 19 Feb 2022 11:41:09 +0100
Message-Id: <patch-v3-2.3-bd0f969be55-20220219T103752Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1129.g03fd99ecb8d
In-Reply-To: <cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20220128T110330Z-avarab@gmail.com> <cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "else" branches of the HAVE_VARIADIC_MACROS macro, which
have been unconditionally omitted since 765dc168882 (git-compat-util:
always enable variadic macros, 2021-01-28).

Since were always omitted, anyone trying to use a compiler without
variadic macro support to compile a git since version
git v2.31.0 or later would have had a compilation error. 10 months
across a few releases since then should have been enough time for
anyone who cared to run into that and report the issue.

In addition to that, for anyone unsetting HAVE_VARIADIC_MACROS we've
been emitting extremely verbose warnings since at least
ee4512ed481 (trace2: create new combined trace facility,
2019-02-22). That's because there is no such thing as a
"region_enter_printf" or "region_leave_printf" format, so at least
under GCC and Clang everything that includes trace.h (almost every
file) emits a couple of warnings about that.

There's a large benefit to being able to have a hard dependency rely
on variadic macros, the code surrounding usage.c is hard to maintain
if we need to write two implementations of everything, and by relying
on "__FILE__" and "__LINE__" along with "__VA_ARGS__" we can in the
future make error(), die() etc. log where they were called from. We've
also recently merged d67fc4bf0ba (Merge branch 'bc/require-c99',
2021-12-10) which further cements our hard dependency on C99.

So let's delete the fallback code, and update our CodingGuidelines to
note that we depend on this. The added bullet-point starts with
lower-case for consistency with other bullet-points in that section.

The diff in "trace.h" is relatively hard to read, since we need to
retain the existing API docs, which were comments on the code used if
HAVE_VARIADIC_MACROS was not defined.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/CodingGuidelines |   3 +
 banned.h                       |   5 --
 git-compat-util.h              |  12 ----
 trace.c                        |  80 +--------------------
 trace.h                        | 128 +++++++++++++++------------------
 trace2.c                       |  39 ----------
 trace2.h                       |  25 -------
 usage.c                        |  15 +---
 8 files changed, 64 insertions(+), 243 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index c37c43186ea..1a7bc4591cd 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -217,6 +217,9 @@ For C programs:
    . since mid 2017 with 512f41cf, we have been using designated
      initializers for array (e.g. "int array[10] = { [5] = 2 }").
 
+   . since early 2021 with 765dc168882, we have been using variadic
+     macros, mostly for printf-like trace and debug macros.
+
    These used to be forbidden, but we have not heard any breakage
    report, and they are assumed to be safe.
 
diff --git a/banned.h b/banned.h
index 7ab4f2e4921..6ccf46bc197 100644
--- a/banned.h
+++ b/banned.h
@@ -21,13 +21,8 @@
 
 #undef sprintf
 #undef vsprintf
-#ifdef HAVE_VARIADIC_MACROS
 #define sprintf(...) BANNED(sprintf)
 #define vsprintf(...) BANNED(vsprintf)
-#else
-#define sprintf(buf,fmt,arg) BANNED(sprintf)
-#define vsprintf(buf,fmt,arg) BANNED(vsprintf)
-#endif
 
 #undef gmtime
 #define gmtime(t) BANNED(gmtime)
diff --git a/git-compat-util.h b/git-compat-util.h
index 2d9b75a021a..e50e2fafaec 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1256,24 +1256,12 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 #endif
 #endif
 
-/*
- * This is always defined as a first step towards making the use of variadic
- * macros unconditional. If it causes compilation problems on your platform,
- * please report it to the Git mailing list at git@vger.kernel.org.
- */
-#define HAVE_VARIADIC_MACROS 1
-
 /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
 extern int BUG_exit_code;
 
-#ifdef HAVE_VARIADIC_MACROS
 __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
-#else
-__attribute__((format (printf, 1, 2))) NORETURN
-void BUG(const char *fmt, ...);
-#endif
 
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
diff --git a/trace.c b/trace.c
index f726686fd92..794a087c21e 100644
--- a/trace.c
+++ b/trace.c
@@ -108,16 +108,11 @@ static int prepare_trace_line(const char *file, int line,
 	gettimeofday(&tv, NULL);
 	secs = tv.tv_sec;
 	localtime_r(&secs, &tm);
-	strbuf_addf(buf, "%02d:%02d:%02d.%06ld ", tm.tm_hour, tm.tm_min,
-		    tm.tm_sec, (long) tv.tv_usec);
-
-#ifdef HAVE_VARIADIC_MACROS
-	/* print file:line */
-	strbuf_addf(buf, "%s:%d ", file, line);
+	strbuf_addf(buf, "%02d:%02d:%02d.%06ld %s:%d", tm.tm_hour, tm.tm_min,
+		    tm.tm_sec, (long) tv.tv_usec, file, line);
 	/* align trace output (column 40 catches most files names in git) */
 	while (buf->len < 40)
 		strbuf_addch(buf, ' ');
-#endif
 
 	return 1;
 }
@@ -229,74 +224,6 @@ static void trace_performance_vprintf_fl(const char *file, int line,
 	strbuf_release(&buf);
 }
 
-#ifndef HAVE_VARIADIC_MACROS
-
-void trace_printf(const char *format, ...)
-{
-	va_list ap;
-	va_start(ap, format);
-	trace_vprintf_fl(NULL, 0, &trace_default_key, format, ap);
-	va_end(ap);
-}
-
-void trace_printf_key(struct trace_key *key, const char *format, ...)
-{
-	va_list ap;
-	va_start(ap, format);
-	trace_vprintf_fl(NULL, 0, key, format, ap);
-	va_end(ap);
-}
-
-void trace_argv_printf(const char **argv, const char *format, ...)
-{
-	va_list ap;
-	va_start(ap, format);
-	trace_argv_vprintf_fl(NULL, 0, argv, format, ap);
-	va_end(ap);
-}
-
-void trace_strbuf(struct trace_key *key, const struct strbuf *data)
-{
-	trace_strbuf_fl(NULL, 0, key, data);
-}
-
-void trace_performance(uint64_t nanos, const char *format, ...)
-{
-	va_list ap;
-	va_start(ap, format);
-	trace_performance_vprintf_fl(NULL, 0, nanos, format, ap);
-	va_end(ap);
-}
-
-void trace_performance_since(uint64_t start, const char *format, ...)
-{
-	va_list ap;
-	va_start(ap, format);
-	trace_performance_vprintf_fl(NULL, 0, getnanotime() - start,
-				     format, ap);
-	va_end(ap);
-}
-
-void trace_performance_leave(const char *format, ...)
-{
-	va_list ap;
-	uint64_t since;
-
-	if (perf_indent)
-		perf_indent--;
-
-	if (!format) /* Allow callers to leave without tracing anything */
-		return;
-
-	since = perf_start_times[perf_indent];
-	va_start(ap, format);
-	trace_performance_vprintf_fl(NULL, 0, getnanotime() - since,
-				     format, ap);
-	va_end(ap);
-}
-
-#else
-
 void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
 			 const char *format, ...)
 {
@@ -342,9 +269,6 @@ void trace_performance_leave_fl(const char *file, int line,
 	va_end(ap);
 }
 
-#endif /* HAVE_VARIADIC_MACROS */
-
-
 static const char *quote_crnl(const char *path)
 {
 	static struct strbuf new_path = STRBUF_INIT;
diff --git a/trace.h b/trace.h
index e25984051aa..4e771f86ac2 100644
--- a/trace.h
+++ b/trace.h
@@ -126,71 +126,6 @@ void trace_command_performance(const char **argv);
 void trace_verbatim(struct trace_key *key, const void *buf, unsigned len);
 uint64_t trace_performance_enter(void);
 
-#ifndef HAVE_VARIADIC_MACROS
-
-/**
- * Prints a formatted message, similar to printf.
- */
-__attribute__((format (printf, 1, 2)))
-void trace_printf(const char *format, ...);
-
-__attribute__((format (printf, 2, 3)))
-void trace_printf_key(struct trace_key *key, const char *format, ...);
-
-/**
- * Prints a formatted message, followed by a quoted list of arguments.
- */
-__attribute__((format (printf, 2, 3)))
-void trace_argv_printf(const char **argv, const char *format, ...);
-
-/**
- * Prints the strbuf, without additional formatting (i.e. doesn't
- * choke on `%` or even `\0`).
- */
-void trace_strbuf(struct trace_key *key, const struct strbuf *data);
-
-/**
- * Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled.
- *
- * Example:
- * ------------
- * uint64_t t = 0;
- * for (;;) {
- * 	// ignore
- * t -= getnanotime();
- * // code section to measure
- * t += getnanotime();
- * // ignore
- * }
- * trace_performance(t, "frotz");
- * ------------
- */
-__attribute__((format (printf, 2, 3)))
-void trace_performance(uint64_t nanos, const char *format, ...);
-
-/**
- * Prints elapsed time since 'start' if GIT_TRACE_PERFORMANCE is enabled.
- *
- * Example:
- * ------------
- * uint64_t start = getnanotime();
- * // code section to measure
- * trace_performance_since(start, "foobar");
- * ------------
- */
-__attribute__((format (printf, 2, 3)))
-void trace_performance_since(uint64_t start, const char *format, ...);
-
-__attribute__((format (printf, 1, 2)))
-void trace_performance_leave(const char *format, ...);
-
-#else
-
-/*
- * Macros to add file:line - see above for C-style declarations of how these
- * should be used.
- */
-
 /*
  * TRACE_CONTEXT may be set to __FUNCTION__ if the compiler supports it. The
  * default is __FILE__, as it is consistent with assert(), and static function
@@ -204,7 +139,10 @@ void trace_performance_leave(const char *format, ...);
 # define TRACE_CONTEXT __FILE__
 #endif
 
-/*
+/**
+ * Macros to add the file:line of the calling code, instead of that of
+ * the trace function itself.
+ *
  * Note: with C99 variadic macros, __VA_ARGS__ must include the last fixed
  * parameter ('format' in this case). Otherwise, a call without variable
  * arguments will have a surplus ','. E.g.:
@@ -220,6 +158,16 @@ void trace_performance_leave(const char *format, ...);
  * comma, but this is non-standard.
  */
 
+/**
+ * trace_printf(), accepts "const char *format, ...".
+ *
+ * Prints a formatted message, similar to printf.
+ */
+#define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__)
+
+/**
+ * trace_printf_key(), accepts "struct trace_key *key, const char *format, ...".
+ */
 #define trace_printf_key(key, ...)					    \
 	do {								    \
 		if (trace_pass_fl(key))					    \
@@ -227,8 +175,11 @@ void trace_performance_leave(const char *format, ...);
 					    __VA_ARGS__);		    \
 	} while (0)
 
-#define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__)
-
+/**
+ * trace_argv_printf(), accepts "struct trace_key *key, const char *format, ...)".
+ *
+ * Prints a formatted message, followed by a quoted list of arguments.
+ */
 #define trace_argv_printf(argv, ...)					    \
 	do {								    \
 		if (trace_pass_fl(&trace_default_key))			    \
@@ -236,12 +187,36 @@ void trace_performance_leave(const char *format, ...);
 					    argv, __VA_ARGS__);		    \
 	} while (0)
 
+/**
+ * trace_strbuf(), accepts "struct trace_key *key, const struct strbuf *data".
+ *
+ * Prints the strbuf, without additional formatting (i.e. doesn't
+ * choke on `%` or even `\0`).
+ */
 #define trace_strbuf(key, data)						    \
 	do {								    \
 		if (trace_pass_fl(key))					    \
 			trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key, data);\
 	} while (0)
 
+/**
+ * trace_performance(), accepts "uint64_t nanos, const char *format, ...".
+ *
+ * Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled.
+ *
+ * Example:
+ * ------------
+ * uint64_t t = 0;
+ * for (;;) {
+ * 	// ignore
+ * t -= getnanotime();
+ * // code section to measure
+ * t += getnanotime();
+ * // ignore
+ * }
+ * trace_performance(t, "frotz");
+ * ------------
+ */
 #define trace_performance(nanos, ...)					    \
 	do {								    \
 		if (trace_pass_fl(&trace_perf_key))			    \
@@ -249,6 +224,18 @@ void trace_performance_leave(const char *format, ...);
 					     __VA_ARGS__);		    \
 	} while (0)
 
+/**
+ * trace_performance_since(), accepts "uint64_t start, const char *format, ...".
+ *
+ * Prints elapsed time since 'start' if GIT_TRACE_PERFORMANCE is enabled.
+ *
+ * Example:
+ * ------------
+ * uint64_t start = getnanotime();
+ * // code section to measure
+ * trace_performance_since(start, "foobar");
+ * ------------
+ */
 #define trace_performance_since(start, ...)				    \
 	do {								    \
 		if (trace_pass_fl(&trace_perf_key))			    \
@@ -257,6 +244,9 @@ void trace_performance_leave(const char *format, ...);
 					     __VA_ARGS__);		    \
 	} while (0)
 
+/**
+ * trace_performance_leave(), accepts "const char *format, ...".
+ */
 #define trace_performance_leave(...)					    \
 	do {								    \
 		if (trace_pass_fl(&trace_perf_key))			    \
@@ -285,6 +275,4 @@ static inline int trace_pass_fl(struct trace_key *key)
 	return key->fd || !key->initialized;
 }
 
-#endif /* HAVE_VARIADIC_MACROS */
-
 #endif /* TRACE_H */
diff --git a/trace2.c b/trace2.c
index b2d471526fd..179caa72cfe 100644
--- a/trace2.c
+++ b/trace2.c
@@ -641,20 +641,6 @@ void trace2_region_enter_printf_fl(const char *file, int line,
 	va_end(ap);
 }
 
-#ifndef HAVE_VARIADIC_MACROS
-void trace2_region_enter_printf(const char *category, const char *label,
-				const struct repository *repo, const char *fmt,
-				...)
-{
-	va_list ap;
-
-	va_start(ap, fmt);
-	trace2_region_enter_printf_va_fl(NULL, 0, category, label, repo, fmt,
-					 ap);
-	va_end(ap);
-}
-#endif
-
 void trace2_region_leave_printf_va_fl(const char *file, int line,
 				      const char *category, const char *label,
 				      const struct repository *repo,
@@ -717,20 +703,6 @@ void trace2_region_leave_printf_fl(const char *file, int line,
 	va_end(ap);
 }
 
-#ifndef HAVE_VARIADIC_MACROS
-void trace2_region_leave_printf(const char *category, const char *label,
-				const struct repository *repo, const char *fmt,
-				...)
-{
-	va_list ap;
-
-	va_start(ap, fmt);
-	trace2_region_leave_printf_va_fl(NULL, 0, category, label, repo, fmt,
-					 ap);
-	va_end(ap);
-}
-#endif
-
 void trace2_data_string_fl(const char *file, int line, const char *category,
 			   const struct repository *repo, const char *key,
 			   const char *value)
@@ -826,17 +798,6 @@ void trace2_printf_fl(const char *file, int line, const char *fmt, ...)
 	va_end(ap);
 }
 
-#ifndef HAVE_VARIADIC_MACROS
-void trace2_printf(const char *fmt, ...)
-{
-	va_list ap;
-
-	va_start(ap, fmt);
-	trace2_printf_va_fl(NULL, 0, fmt, ap);
-	va_end(ap);
-}
-#endif
-
 const char *trace2_session_id(void)
 {
 	return tr2_sid_get();
diff --git a/trace2.h b/trace2.h
index 0cc7b5f5312..1b109f57d0a 100644
--- a/trace2.h
+++ b/trace2.h
@@ -397,18 +397,9 @@ void trace2_region_enter_printf_fl(const char *file, int line,
 				   const struct repository *repo,
 				   const char *fmt, ...);
 
-#ifdef HAVE_VARIADIC_MACROS
 #define trace2_region_enter_printf(category, label, repo, ...)                 \
 	trace2_region_enter_printf_fl(__FILE__, __LINE__, (category), (label), \
 				      (repo), __VA_ARGS__)
-#else
-/* clang-format off */
-__attribute__((format (region_enter_printf, 4, 5)))
-void trace2_region_enter_printf(const char *category, const char *label,
-				const struct repository *repo, const char *fmt,
-				...);
-/* clang-format on */
-#endif
 
 /**
  * Emit a 'region_leave' event for <category>.<label> with optional
@@ -442,18 +433,9 @@ void trace2_region_leave_printf_fl(const char *file, int line,
 				   const struct repository *repo,
 				   const char *fmt, ...);
 
-#ifdef HAVE_VARIADIC_MACROS
 #define trace2_region_leave_printf(category, label, repo, ...)                 \
 	trace2_region_leave_printf_fl(__FILE__, __LINE__, (category), (label), \
 				      (repo), __VA_ARGS__)
-#else
-/* clang-format off */
-__attribute__((format (region_leave_printf, 4, 5)))
-void trace2_region_leave_printf(const char *category, const char *label,
-				const struct repository *repo, const char *fmt,
-				...);
-/* clang-format on */
-#endif
 
 /**
  * Emit a key-value pair 'data' event of the form <category>.<key> = <value>.
@@ -506,14 +488,7 @@ void trace2_printf_va_fl(const char *file, int line, const char *fmt,
 
 void trace2_printf_fl(const char *file, int line, const char *fmt, ...);
 
-#ifdef HAVE_VARIADIC_MACROS
 #define trace2_printf(...) trace2_printf_fl(__FILE__, __LINE__, __VA_ARGS__)
-#else
-/* clang-format off */
-__attribute__((format (printf, 1, 2)))
-void trace2_printf(const char *fmt, ...);
-/* clang-format on */
-#endif
 
 /*
  * Optional platform-specific code to dump information about the
diff --git a/usage.c b/usage.c
index 9943dd8742e..b738dd178b3 100644
--- a/usage.c
+++ b/usage.c
@@ -299,10 +299,7 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 	va_copy(params_copy, params);
 
 	/* truncation via snprintf is OK here */
-	if (file)
-		snprintf(prefix, sizeof(prefix), "BUG: %s:%d: ", file, line);
-	else
-		snprintf(prefix, sizeof(prefix), "BUG: ");
+	snprintf(prefix, sizeof(prefix), "BUG: %s:%d: ", file, line);
 
 	vreportf(prefix, fmt, params);
 
@@ -317,7 +314,6 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 	abort();
 }
 
-#ifdef HAVE_VARIADIC_MACROS
 NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
 {
 	va_list ap;
@@ -325,15 +321,6 @@ NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
 	BUG_vfl(file, line, fmt, ap);
 	va_end(ap);
 }
-#else
-NORETURN void BUG(const char *fmt, ...)
-{
-	va_list ap;
-	va_start(ap, fmt);
-	BUG_vfl(NULL, 0, fmt, ap);
-	va_end(ap);
-}
-#endif
 
 #ifdef SUPPRESS_ANNOTATED_LEAKS
 void unleak_memory(const void *ptr, size_t len)
-- 
2.35.1.1129.g03fd99ecb8d

