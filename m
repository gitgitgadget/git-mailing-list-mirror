Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E5CC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 23:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjEQX4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 19:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjEQX4q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 19:56:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9117D3AA2
        for <git@vger.kernel.org>; Wed, 17 May 2023 16:56:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c2999fdc7so25296257b3.2
        for <git@vger.kernel.org>; Wed, 17 May 2023 16:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684367800; x=1686959800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6lnBw9UgSDyYoKKv89LKUHO8I1pzGmjfITzghvPLKDo=;
        b=dIXVUvFKD7V2fNU9+Xd0wr0todT9OZv5qtIhnggMMyux7RPF9rcwuVeE8B0fBl3IPq
         Ck2CtdNRZNFb0eR2Ts0DWK9/xnpcbLE+MG+BGN3GGPZc5SmRNwlMzDRxoYnWjthqnbFB
         MDvd/C/fWiXS53qkHH29jnyeD15reqW9iid0PmBNBj8QLHfcfOQPWGhwzs2VG6WzLXTv
         g8DnXp+LYjuHpmKx7rCK2+A9DVcTkP8K+hqXwdQVOrYe/9/iwq/j8WxR9wjRowKNA1Ul
         YKqGoQO5Qwyjp2MZ42Fgbgyuw3vVH4nehQ4daYjSzzkWqCpuK2J2SEPZPomzGqAgp4yG
         51Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684367800; x=1686959800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lnBw9UgSDyYoKKv89LKUHO8I1pzGmjfITzghvPLKDo=;
        b=Fx/aJj7OlE7UNVHxBs05l7SNbPQtgRNKo/JyB9KPJf3ZLjtVL4+SClAc6GwgPG6KNk
         rjUZ4LNf5/biI7KPkkW9yNqztL5OBYvFmUAT4IhvAe1ZGm/ZMAo/UXeNn/mSlnrr0YwF
         pXklBVKDvm9RY69tUs0F4yqF79o03ILFdM1Pp+eaT3YIsEtlqi1jn5aqP/80jAvlfi0Y
         u5vo7auam6RClDnta3lQ8ndeMMrxXvsFB9RqDHoZefao+dynhua7/IteLnvyh26w7j30
         Wm/Q+hZ6yJ+gLYg3HRByU3a/C9ri9hLu5nPrn6eriuKvIyqR+HhyINeS8DSxB7JvfQdl
         FicQ==
X-Gm-Message-State: AC+VfDy/uD4h7CGWhx6d/N62E95PPhTuI7hZnVN/g4mV6wNo3U9F3bdx
        EOQJK2c+hEF7e4SC7HGS5mfeVeGNXk6idzCQXALLGDpEWuxnTLQXq5v9o28KN07057ifOQlSHhB
        LiZzO1WYIBnTMtkkX2g5O9kP44iDnPKbAbO5ryAeKzgCcuAU50vJ9zq4qSFjtpRQ=
X-Google-Smtp-Source: ACHHUZ4Bzjs5ih0KFZULbCJt1hvajqG/ztqUv0knm4gRy0W7pUgKuAU04+qhv9tpnlBxVCaXM/LPKwgGvaMWCw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:202:f597:a1b7:3c54:2bc8])
 (user=steadmon job=sendgmr) by 2002:a81:ae26:0:b0:561:949f:227 with SMTP id
 m38-20020a81ae26000000b00561949f0227mr4197949ywh.1.1684367800710; Wed, 17 May
 2023 16:56:40 -0700 (PDT)
Date:   Wed, 17 May 2023 16:56:33 -0700
In-Reply-To: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
Mime-Version: 1.0
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
X-Mailer: b4 0.12.2
Message-ID: <20230517-unit-tests-v2-v2-3-21b5b60f4b32@google.com>
Subject: [PATCH RFC v2 3/4] Add C TAP harness
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, calvinwan@gmail.com,
        szeder.dev@gmail.com, phillip.wood123@gmail.com,
        chooglen@google.com, avarab@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net, Calvin Wan <calvinwan@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Calvin Wan <calvinwan@google.com>

Introduces the C TAP harness from https://github.com/rra/c-tap-harness/

There is also more complete documentation at
https://www.eyrie.org/~eagle/software/c-tap-harness/

Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Change-Id: I611e22988e99b9407a4f60effaa7fbdb96ffb115
---
 t/runtests.c   | 1789 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/tap/basic.c  | 1029 ++++++++++++++++++++++++++++++++
 t/tap/basic.h  |  198 +++++++
 t/tap/macros.h |  109 ++++
 4 files changed, 3125 insertions(+)

diff --git a/t/runtests.c b/t/runtests.c
new file mode 100644
index 0000000000..4a55a801a6
--- /dev/null
+++ b/t/runtests.c
@@ -0,0 +1,1789 @@
+/*
+ * Run a set of tests, reporting results.
+ *
+ * Test suite driver that runs a set of tests implementing a subset of the
+ * Test Anything Protocol (TAP) and reports the results.
+ *
+ * Any bug reports, bug fixes, and improvements are very much welcome and
+ * should be sent to the e-mail address below.  This program is part of C TAP
+ * Harness <https://www.eyrie.org/~eagle/software/c-tap-harness/>.
+ *
+ * Copyright 2000-2001, 2004, 2006-2019, 2022 Russ Allbery <eagle@eyrie.org>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+/*
+ * Usage:
+ *
+ *      runtests [-hv] [-b <build-dir>] [-s <source-dir>] -l <test-list>
+ *      runtests [-hv] [-b <build-dir>] [-s <source-dir>] <test> [<test> ...]
+ *      runtests -o [-h] [-b <build-dir>] [-s <source-dir>] <test>
+ *
+ * In the first case, expects a list of executables located in the given file,
+ * one line per executable, possibly followed by a space-separated list of
+ * options.  For each one, runs it as part of a test suite, reporting results.
+ * In the second case, use the same infrastructure, but run only the tests
+ * listed on the command line.
+ *
+ * Test output should start with a line containing the number of tests
+ * (numbered from 1 to this number), optionally preceded by "1..", although
+ * that line may be given anywhere in the output.  Each additional line should
+ * be in the following format:
+ *
+ *      ok <number>
+ *      not ok <number>
+ *      ok <number> # skip
+ *      not ok <number> # todo
+ *
+ * where <number> is the number of the test.  An optional comment is permitted
+ * after the number if preceded by whitespace.  ok indicates success, not ok
+ * indicates failure.  "# skip" and "# todo" are a special cases of a comment,
+ * and must start with exactly that formatting.  They indicate the test was
+ * skipped for some reason (maybe because it doesn't apply to this platform)
+ * or is testing something known to currently fail.  The text following either
+ * "# skip" or "# todo" and whitespace is the reason.
+ *
+ * As a special case, the first line of the output may be in the form:
+ *
+ *      1..0 # skip some reason
+ *
+ * which indicates that this entire test case should be skipped and gives a
+ * reason.
+ *
+ * Any other lines are ignored, although for compliance with the TAP protocol
+ * all lines other than the ones in the above format should be sent to
+ * standard error rather than standard output and start with #.
+ *
+ * This is a subset of TAP as documented in Test::Harness::TAP or
+ * TAP::Parser::Grammar, which comes with Perl.
+ *
+ * If the -o option is given, instead run a single test and display all of its
+ * output.  This is intended for use with failing tests so that the person
+ * running the test suite can get more details about what failed.
+ *
+ * If built with the C preprocessor symbols C_TAP_SOURCE and C_TAP_BUILD
+ * defined, C TAP Harness will export those values in the environment so that
+ * tests can find the source and build directory and will look for tests under
+ * both directories.  These paths can also be set with the -b and -s
+ * command-line options, which will override anything set at build time.
+ *
+ * If the -v option is given, or the C_TAP_VERBOSE environment variable is set,
+ * display the full output of each test as it runs rather than showing a
+ * summary of the results of each test.
+ */
+
+/* Required for fdopen(), getopt(), and putenv(). */
+#if defined(__STRICT_ANSI__) || defined(PEDANTIC)
+#    ifndef _XOPEN_SOURCE
+#        define _XOPEN_SOURCE 500
+#    endif
+#endif
+
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdarg.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <strings.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+
+/* sys/time.h must be included before sys/resource.h on some platforms. */
+#include <sys/resource.h>
+
+/* AIX 6.1 (and possibly later) doesn't have WCOREDUMP. */
+#ifndef WCOREDUMP
+#    define WCOREDUMP(status) ((unsigned) (status) &0x80)
+#endif
+
+/*
+ * POSIX requires that these be defined in <unistd.h>, but they're not always
+ * available.  If one of them has been defined, all the rest almost certainly
+ * have.
+ */
+#ifndef STDIN_FILENO
+#    define STDIN_FILENO  0
+#    define STDOUT_FILENO 1
+#    define STDERR_FILENO 2
+#endif
+
+/*
+ * Used for iterating through arrays.  Returns the number of elements in the
+ * array (useful for a < upper bound in a for loop).
+ */
+#define ARRAY_SIZE(array) (sizeof(array) / sizeof((array)[0]))
+
+/*
+ * The source and build versions of the tests directory.  This is used to set
+ * the C_TAP_SOURCE and C_TAP_BUILD environment variables (and the SOURCE and
+ * BUILD environment variables set for backward compatibility) and find test
+ * programs, if set.  Normally, this should be set as part of the build
+ * process to the test subdirectories of $(abs_top_srcdir) and
+ * $(abs_top_builddir) respectively.
+ */
+#ifndef C_TAP_SOURCE
+#    define C_TAP_SOURCE NULL
+#endif
+#ifndef C_TAP_BUILD
+#    define C_TAP_BUILD NULL
+#endif
+
+/* Test status codes. */
+enum test_status {
+    TEST_FAIL,
+    TEST_PASS,
+    TEST_SKIP,
+    TEST_INVALID
+};
+
+/* Really, just a boolean, but this is more self-documenting. */
+enum test_verbose {
+    CONCISE = 0,
+    VERBOSE = 1
+};
+
+/* Indicates the state of our plan. */
+enum plan_status {
+    PLAN_INIT,    /* Nothing seen yet. */
+    PLAN_FIRST,   /* Plan seen before any tests. */
+    PLAN_PENDING, /* Test seen and no plan yet. */
+    PLAN_FINAL    /* Plan seen after some tests. */
+};
+
+/* Error exit statuses for test processes. */
+#define CHILDERR_DUP    100 /* Couldn't redirect stderr or stdout. */
+#define CHILDERR_EXEC   101 /* Couldn't exec child process. */
+#define CHILDERR_STDIN  102 /* Couldn't open stdin file. */
+#define CHILDERR_STDERR 103 /* Couldn't open stderr file. */
+
+/* Structure to hold data for a set of tests. */
+struct testset {
+    char *file;                /* The file name of the test. */
+    char **command;            /* The argv vector to run the command. */
+    enum plan_status plan;     /* The status of our plan. */
+    unsigned long count;       /* Expected count of tests. */
+    unsigned long current;     /* The last seen test number. */
+    unsigned int length;       /* The length of the last status message. */
+    unsigned long passed;      /* Count of passing tests. */
+    unsigned long failed;      /* Count of failing lists. */
+    unsigned long skipped;     /* Count of skipped tests (passed). */
+    unsigned long allocated;   /* The size of the results table. */
+    enum test_status *results; /* Table of results by test number. */
+    unsigned int aborted;      /* Whether the set was aborted. */
+    unsigned int reported;     /* Whether the results were reported. */
+    int status;                /* The exit status of the test. */
+    unsigned int all_skipped;  /* Whether all tests were skipped. */
+    char *reason;              /* Why all tests were skipped. */
+};
+
+/* Structure to hold a linked list of test sets. */
+struct testlist {
+    struct testset *ts;
+    struct testlist *next;
+};
+
+/*
+ * Usage message.  Should be used as a printf format with four arguments: the
+ * path to runtests, given three times, and the usage_description.  This is
+ * split into variables to satisfy the pedantic ISO C90 limit on strings.
+ */
+static const char usage_message[] = "\
+Usage: %s [-hv] [-b <build-dir>] [-s <source-dir>] <test> ...\n\
+       %s [-hv] [-b <build-dir>] [-s <source-dir>] -l <test-list>\n\
+       %s -o [-h] [-b <build-dir>] [-s <source-dir>] <test>\n\
+\n\
+Options:\n\
+    -b <build-dir>      Set the build directory to <build-dir>\n\
+%s";
+static const char usage_extra[] = "\
+    -l <list>           Take the list of tests to run from <test-list>\n\
+    -o                  Run a single test rather than a list of tests\n\
+    -s <source-dir>     Set the source directory to <source-dir>\n\
+    -v                  Show the full output of each test\n\
+\n\
+runtests normally runs each test listed on the command line.  With the -l\n\
+option, it instead runs every test listed in a file.  With the -o option,\n\
+it instead runs a single test and shows its complete output.\n";
+
+/*
+ * Header used for test output.  %s is replaced by the file name of the list
+ * of tests.
+ */
+static const char banner[] = "\n\
+Running all tests listed in %s.  If any tests fail, run the failing\n\
+test program with runtests -o to see more details.\n\n";
+
+/* Header for reports of failed tests. */
+static const char header[] = "\n\
+Failed Set                 Fail/Total (%) Skip Stat  Failing Tests\n\
+-------------------------- -------------- ---- ----  ------------------------";
+
+/* Include the file name and line number in malloc failures. */
+#define xcalloc(n, type) \
+    ((type *) x_calloc((n), sizeof(type), __FILE__, __LINE__))
+#define xmalloc(size)     ((char *) x_malloc((size), __FILE__, __LINE__))
+#define xstrdup(p)        x_strdup((p), __FILE__, __LINE__)
+#define xstrndup(p, size) x_strndup((p), (size), __FILE__, __LINE__)
+#define xreallocarray(p, n, type) \
+    ((type *) x_reallocarray((p), (n), sizeof(type), __FILE__, __LINE__))
+
+/*
+ * __attribute__ is available in gcc 2.5 and later, but only with gcc 2.7
+ * could you use the __format__ form of the attributes, which is what we use
+ * (to avoid confusion with other macros).
+ */
+#ifndef __attribute__
+#    if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 7)
+#        define __attribute__(spec) /* empty */
+#    endif
+#endif
+
+/*
+ * We use __alloc_size__, but it was only available in fairly recent versions
+ * of GCC.  Suppress warnings about the unknown attribute if GCC is too old.
+ * We know that we're GCC at this point, so we can use the GCC variadic macro
+ * extension, which will still work with versions of GCC too old to have C99
+ * variadic macro support.
+ */
+#if !defined(__attribute__) && !defined(__alloc_size__)
+#    if defined(__GNUC__) && !defined(__clang__)
+#        if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 3)
+#            define __alloc_size__(spec, args...) /* empty */
+#        endif
+#    endif
+#endif
+
+/*
+ * Suppress the argument to __malloc__ in Clang (not supported in at least
+ * version 13) and GCC versions prior to 11.
+ */
+#if !defined(__attribute__) && !defined(__malloc__)
+#    if defined(__clang__) || __GNUC__ < 11
+#        define __malloc__(dalloc) __malloc__
+#    endif
+#endif
+
+/*
+ * LLVM and Clang pretend to be GCC but don't support all of the __attribute__
+ * settings that GCC does.  For them, suppress warnings about unknown
+ * attributes on declarations.  This unfortunately will affect the entire
+ * compilation context, but there's no push and pop available.
+ */
+#if !defined(__attribute__) && (defined(__llvm__) || defined(__clang__))
+#    pragma GCC diagnostic ignored "-Wattributes"
+#endif
+
+/* Declare internal functions that benefit from compiler attributes. */
+static void die(const char *, ...)
+    __attribute__((__nonnull__, __noreturn__, __format__(printf, 1, 2)));
+static void sysdie(const char *, ...)
+    __attribute__((__nonnull__, __noreturn__, __format__(printf, 1, 2)));
+static void *x_calloc(size_t, size_t, const char *, int)
+    __attribute__((__alloc_size__(1, 2), __malloc__(free), __nonnull__));
+static void *x_malloc(size_t, const char *, int)
+    __attribute__((__alloc_size__(1), __malloc__(free), __nonnull__));
+static void *x_reallocarray(void *, size_t, size_t, const char *, int)
+    __attribute__((__alloc_size__(2, 3), __malloc__(free), __nonnull__(4)));
+static char *x_strdup(const char *, const char *, int)
+    __attribute__((__malloc__(free), __nonnull__));
+static char *x_strndup(const char *, size_t, const char *, int)
+    __attribute__((__malloc__(free), __nonnull__));
+
+
+/*
+ * Report a fatal error and exit.
+ */
+static void
+die(const char *format, ...)
+{
+    va_list args;
+
+    fflush(stdout);
+    fprintf(stderr, "runtests: ");
+    va_start(args, format);
+    vfprintf(stderr, format, args);
+    va_end(args);
+    fprintf(stderr, "\n");
+    exit(1);
+}
+
+
+/*
+ * Report a fatal error, including the results of strerror, and exit.
+ */
+static void
+sysdie(const char *format, ...)
+{
+    int oerrno;
+    va_list args;
+
+    oerrno = errno;
+    fflush(stdout);
+    fprintf(stderr, "runtests: ");
+    va_start(args, format);
+    vfprintf(stderr, format, args);
+    va_end(args);
+    fprintf(stderr, ": %s\n", strerror(oerrno));
+    exit(1);
+}
+
+
+/*
+ * Allocate zeroed memory, reporting a fatal error and exiting on failure.
+ */
+static void *
+x_calloc(size_t n, size_t size, const char *file, int line)
+{
+    void *p;
+
+    n = (n > 0) ? n : 1;
+    size = (size > 0) ? size : 1;
+    p = calloc(n, size);
+    if (p == NULL)
+        sysdie("failed to calloc %lu bytes at %s line %d",
+               (unsigned long) size, file, line);
+    return p;
+}
+
+
+/*
+ * Allocate memory, reporting a fatal error and exiting on failure.
+ */
+static void *
+x_malloc(size_t size, const char *file, int line)
+{
+    void *p;
+
+    p = malloc(size);
+    if (p == NULL)
+        sysdie("failed to malloc %lu bytes at %s line %d",
+               (unsigned long) size, file, line);
+    return p;
+}
+
+
+/*
+ * Reallocate memory, reporting a fatal error and exiting on failure.
+ *
+ * We should technically use SIZE_MAX here for the overflow check, but
+ * SIZE_MAX is C99 and we're only assuming C89 + SUSv3, which does not
+ * guarantee that it exists.  They do guarantee that UINT_MAX exists, and we
+ * can assume that UINT_MAX <= SIZE_MAX.  And we should not be allocating
+ * anything anywhere near that large.
+ *
+ * (In theory, C89 and C99 permit size_t to be smaller than unsigned int, but
+ * I disbelieve in the existence of such systems and they will have to cope
+ * without overflow checks.)
+ */
+static void *
+x_reallocarray(void *p, size_t n, size_t size, const char *file, int line)
+{
+    n = (n > 0) ? n : 1;
+    size = (size > 0) ? size : 1;
+
+    if (n > 0 && UINT_MAX / n <= size)
+        sysdie("realloc too large at %s line %d", file, line);
+    p = realloc(p, n * size);
+    if (p == NULL)
+        sysdie("failed to realloc %lu bytes at %s line %d",
+               (unsigned long) (n * size), file, line);
+    return p;
+}
+
+
+/*
+ * Copy a string, reporting a fatal error and exiting on failure.
+ */
+static char *
+x_strdup(const char *s, const char *file, int line)
+{
+    char *p;
+    size_t len;
+
+    len = strlen(s) + 1;
+    p = (char *) malloc(len);
+    if (p == NULL)
+        sysdie("failed to strdup %lu bytes at %s line %d", (unsigned long) len,
+               file, line);
+    memcpy(p, s, len);
+    return p;
+}
+
+
+/*
+ * Copy the first n characters of a string, reporting a fatal error and
+ * existing on failure.
+ *
+ * Avoid using the system strndup function since it may not exist (on Mac OS
+ * X, for example), and there's no need to introduce another portability
+ * requirement.
+ */
+char *
+x_strndup(const char *s, size_t size, const char *file, int line)
+{
+    const char *p;
+    size_t len;
+    char *copy;
+
+    /* Don't assume that the source string is nul-terminated. */
+    for (p = s; (size_t) (p - s) < size && *p != '\0'; p++)
+        ;
+    len = (size_t) (p - s);
+    copy = (char *) malloc(len + 1);
+    if (copy == NULL)
+        sysdie("failed to strndup %lu bytes at %s line %d",
+               (unsigned long) len, file, line);
+    memcpy(copy, s, len);
+    copy[len] = '\0';
+    return copy;
+}
+
+
+/*
+ * Form a new string by concatenating multiple strings.  The arguments must be
+ * terminated by (const char *) 0.
+ *
+ * This function only exists because we can't assume asprintf.  We can't
+ * simulate asprintf with snprintf because we're only assuming SUSv3, which
+ * does not require that snprintf with a NULL buffer return the required
+ * length.  When those constraints are relaxed, this should be ripped out and
+ * replaced with asprintf or a more trivial replacement with snprintf.
+ */
+static char *
+concat(const char *first, ...)
+{
+    va_list args;
+    char *result;
+    const char *string;
+    size_t offset;
+    size_t length = 0;
+
+    /*
+     * Find the total memory required.  Ensure we don't overflow length.  We
+     * aren't guaranteed to have SIZE_MAX, so use UINT_MAX as an acceptable
+     * substitute (see the x_nrealloc comments).
+     */
+    va_start(args, first);
+    for (string = first; string != NULL; string = va_arg(args, const char *)) {
+        if (length >= UINT_MAX - strlen(string)) {
+            errno = EINVAL;
+            sysdie("strings too long in concat");
+        }
+        length += strlen(string);
+    }
+    va_end(args);
+    length++;
+
+    /* Create the string. */
+    result = xmalloc(length);
+    va_start(args, first);
+    offset = 0;
+    for (string = first; string != NULL; string = va_arg(args, const char *)) {
+        memcpy(result + offset, string, strlen(string));
+        offset += strlen(string);
+    }
+    va_end(args);
+    result[offset] = '\0';
+    return result;
+}
+
+
+/*
+ * Given a struct timeval, return the number of seconds it represents as a
+ * double.  Use difftime() to convert a time_t to a double.
+ */
+static double
+tv_seconds(const struct timeval *tv)
+{
+    return difftime(tv->tv_sec, 0) + (double) tv->tv_usec * 1e-6;
+}
+
+
+/*
+ * Given two struct timevals, return the difference in seconds.
+ */
+static double
+tv_diff(const struct timeval *tv1, const struct timeval *tv0)
+{
+    return tv_seconds(tv1) - tv_seconds(tv0);
+}
+
+
+/*
+ * Given two struct timevals, return the sum in seconds as a double.
+ */
+static double
+tv_sum(const struct timeval *tv1, const struct timeval *tv2)
+{
+    return tv_seconds(tv1) + tv_seconds(tv2);
+}
+
+
+/*
+ * Given a pointer to a string, skip any leading whitespace and return a
+ * pointer to the first non-whitespace character.
+ */
+static const char *
+skip_whitespace(const char *p)
+{
+    while (isspace((unsigned char) (*p)))
+        p++;
+    return p;
+}
+
+
+/*
+ * Given a pointer to a string, skip any non-whitespace characters and return
+ * a pointer to the first whitespace character, or to the end of the string.
+ */
+static const char *
+skip_non_whitespace(const char *p)
+{
+    while (*p != '\0' && !isspace((unsigned char) (*p)))
+        p++;
+    return p;
+}
+
+
+/*
+ * Start a program, connecting its stdout to a pipe on our end and its stderr
+ * to /dev/null, and storing the file descriptor to read from in the two
+ * argument.  Returns the PID of the new process.  Errors are fatal.
+ */
+static pid_t
+test_start(char *const *command, int *fd)
+{
+    int fds[2], infd, errfd;
+    pid_t child;
+
+    /* Create a pipe used to capture the output from the test program. */
+    if (pipe(fds) == -1) {
+        puts("ABORTED");
+        fflush(stdout);
+        sysdie("can't create pipe");
+    }
+
+    /* Fork a child process, massage the file descriptors, and exec. */
+    child = fork();
+    switch (child) {
+    case -1:
+        puts("ABORTED");
+        fflush(stdout);
+        sysdie("can't fork");
+
+    /* In the child.  Set up our standard output. */
+    case 0:
+        close(fds[0]);
+        close(STDOUT_FILENO);
+        if (dup2(fds[1], STDOUT_FILENO) < 0)
+            _exit(CHILDERR_DUP);
+        close(fds[1]);
+
+        /* Point standard input at /dev/null. */
+        close(STDIN_FILENO);
+        infd = open("/dev/null", O_RDONLY);
+        if (infd < 0)
+            _exit(CHILDERR_STDIN);
+        if (infd != STDIN_FILENO) {
+            if (dup2(infd, STDIN_FILENO) < 0)
+                _exit(CHILDERR_DUP);
+            close(infd);
+        }
+
+        /* Point standard error at /dev/null. */
+        close(STDERR_FILENO);
+        errfd = open("/dev/null", O_WRONLY);
+        if (errfd < 0)
+            _exit(CHILDERR_STDERR);
+        if (errfd != STDERR_FILENO) {
+            if (dup2(errfd, STDERR_FILENO) < 0)
+                _exit(CHILDERR_DUP);
+            close(errfd);
+        }
+
+        /* Now, exec our process. */
+        if (execv(command[0], command) == -1)
+            _exit(CHILDERR_EXEC);
+        break;
+
+    /* In parent.  Close the extra file descriptor. */
+    default:
+        close(fds[1]);
+        break;
+    }
+    *fd = fds[0];
+    return child;
+}
+
+
+/*
+ * Back up over the output saying what test we were executing.
+ */
+static void
+test_backspace(struct testset *ts)
+{
+    unsigned int i;
+
+    if (!isatty(STDOUT_FILENO))
+        return;
+    for (i = 0; i < ts->length; i++)
+        putchar('\b');
+    for (i = 0; i < ts->length; i++)
+        putchar(' ');
+    for (i = 0; i < ts->length; i++)
+        putchar('\b');
+    ts->length = 0;
+}
+
+
+/*
+ * Allocate or resize the array of test results to be large enough to contain
+ * the test number in.
+ */
+static void
+resize_results(struct testset *ts, unsigned long n)
+{
+    unsigned long i;
+    size_t s;
+
+    /* If there's already enough space, return quickly. */
+    if (n <= ts->allocated)
+        return;
+
+    /*
+     * If no space has been allocated, do the initial allocation.  Otherwise,
+     * resize.  Start with 32 test cases and then add 1024 with each resize to
+     * try to reduce the number of reallocations.
+     */
+    if (ts->allocated == 0) {
+        s = (n > 32) ? n : 32;
+        ts->results = xcalloc(s, enum test_status);
+    } else {
+        s = (n > ts->allocated + 1024) ? n : ts->allocated + 1024;
+        ts->results = xreallocarray(ts->results, s, enum test_status);
+    }
+
+    /* Set the results for the newly-allocated test array. */
+    for (i = ts->allocated; i < s; i++)
+        ts->results[i] = TEST_INVALID;
+    ts->allocated = s;
+}
+
+
+/*
+ * Report an invalid test number and set the appropriate flags.  Pulled into a
+ * separate function since we do this in several places.
+ */
+static void
+invalid_test_number(struct testset *ts, long n, enum test_verbose verbose)
+{
+    if (!verbose)
+        test_backspace(ts);
+    printf("ABORTED (invalid test number %ld)\n", n);
+    ts->aborted = 1;
+    ts->reported = 1;
+}
+
+
+/*
+ * Read the plan line of test output, which should contain the range of test
+ * numbers.  We may initialize the testset structure here if we haven't yet
+ * seen a test.  Return true if initialization succeeded and the test should
+ * continue, false otherwise.
+ */
+static int
+test_plan(const char *line, struct testset *ts, enum test_verbose verbose)
+{
+    long n;
+
+    /*
+     * Accept a plan without the leading 1.. for compatibility with older
+     * versions of runtests.  This will only be allowed if we've not yet seen
+     * a test result.
+     */
+    line = skip_whitespace(line);
+    if (strncmp(line, "1..", 3) == 0)
+        line += 3;
+
+    /*
+     * Get the count and check it for validity.
+     *
+     * If we have something of the form "1..0 # skip foo", the whole file was
+     * skipped; record that.  If we do skip the whole file, zero out all of
+     * our statistics, since they're no longer relevant.
+     *
+     * strtol is called with a second argument to advance the line pointer
+     * past the count to make it simpler to detect the # skip case.
+     */
+    n = strtol(line, (char **) &line, 10);
+    if (n == 0) {
+        line = skip_whitespace(line);
+        if (*line == '#') {
+            line = skip_whitespace(line + 1);
+            if (strncasecmp(line, "skip", 4) == 0) {
+                line = skip_whitespace(line + 4);
+                if (*line != '\0') {
+                    ts->reason = xstrdup(line);
+                    ts->reason[strlen(ts->reason) - 1] = '\0';
+                }
+                ts->all_skipped = 1;
+                ts->aborted = 1;
+                ts->count = 0;
+                ts->passed = 0;
+                ts->skipped = 0;
+                ts->failed = 0;
+                return 0;
+            }
+        }
+    }
+    if (n <= 0) {
+        puts("ABORTED (invalid test count)");
+        ts->aborted = 1;
+        ts->reported = 1;
+        return 0;
+    }
+
+    /*
+     * If we are doing lazy planning, check the plan against the largest test
+     * number that we saw and fail now if we saw a check outside the plan
+     * range.
+     */
+    if (ts->plan == PLAN_PENDING && (unsigned long) n < ts->count) {
+        invalid_test_number(ts, (long) ts->count, verbose);
+        return 0;
+    }
+
+    /*
+     * Otherwise, allocated or resize the results if needed and update count,
+     * and then record that we've seen a plan.
+     */
+    resize_results(ts, (unsigned long) n);
+    ts->count = (unsigned long) n;
+    if (ts->plan == PLAN_INIT)
+        ts->plan = PLAN_FIRST;
+    else if (ts->plan == PLAN_PENDING)
+        ts->plan = PLAN_FINAL;
+    return 1;
+}
+
+
+/*
+ * Given a single line of output from a test, parse it and return the success
+ * status of that test.  Anything printed to stdout not matching the form
+ * /^(not )?ok \d+/ is ignored.  Sets ts->current to the test number that just
+ * reported status.
+ */
+static void
+test_checkline(const char *line, struct testset *ts, enum test_verbose verbose)
+{
+    enum test_status status = TEST_PASS;
+    const char *bail;
+    char *end;
+    long number;
+    unsigned long current;
+    int outlen;
+
+    /* Before anything, check for a test abort. */
+    bail = strstr(line, "Bail out!");
+    if (bail != NULL) {
+        bail = skip_whitespace(bail + strlen("Bail out!"));
+        if (*bail != '\0') {
+            size_t length;
+
+            length = strlen(bail);
+            if (bail[length - 1] == '\n')
+                length--;
+            if (!verbose)
+                test_backspace(ts);
+            printf("ABORTED (%.*s)\n", (int) length, bail);
+            ts->reported = 1;
+        }
+        ts->aborted = 1;
+        return;
+    }
+
+    /*
+     * If the given line isn't newline-terminated, it was too big for an
+     * fgets(), which means ignore it.
+     */
+    if (line[strlen(line) - 1] != '\n')
+        return;
+
+    /* If the line begins with a hash mark, ignore it. */
+    if (line[0] == '#')
+        return;
+
+    /* If we haven't yet seen a plan, look for one. */
+    if (ts->plan == PLAN_INIT && isdigit((unsigned char) (*line))) {
+        if (!test_plan(line, ts, verbose))
+            return;
+    } else if (strncmp(line, "1..", 3) == 0) {
+        if (ts->plan == PLAN_PENDING) {
+            if (!test_plan(line, ts, verbose))
+                return;
+        } else {
+            if (!verbose)
+                test_backspace(ts);
+            puts("ABORTED (multiple plans)");
+            ts->aborted = 1;
+            ts->reported = 1;
+            return;
+        }
+    }
+
+    /* Parse the line, ignoring something we can't parse. */
+    if (strncmp(line, "not ", 4) == 0) {
+        status = TEST_FAIL;
+        line += 4;
+    }
+    if (strncmp(line, "ok", 2) != 0)
+        return;
+    line = skip_whitespace(line + 2);
+    errno = 0;
+    number = strtol(line, &end, 10);
+    if (errno != 0 || end == line)
+        current = ts->current + 1;
+    else if (number <= 0) {
+        invalid_test_number(ts, number, verbose);
+        return;
+    } else
+        current = (unsigned long) number;
+    if (current > ts->count && ts->plan == PLAN_FIRST) {
+        invalid_test_number(ts, (long) current, verbose);
+        return;
+    }
+
+    /* We have a valid test result.  Tweak the results array if needed. */
+    if (ts->plan == PLAN_INIT || ts->plan == PLAN_PENDING) {
+        ts->plan = PLAN_PENDING;
+        resize_results(ts, current);
+        if (current > ts->count)
+            ts->count = current;
+    }
+
+    /*
+     * Handle directives.  We should probably do something more interesting
+     * with unexpected passes of todo tests.
+     */
+    while (isdigit((unsigned char) (*line)))
+        line++;
+    line = skip_whitespace(line);
+    if (*line == '#') {
+        line = skip_whitespace(line + 1);
+        if (strncasecmp(line, "skip", 4) == 0)
+            status = TEST_SKIP;
+        if (strncasecmp(line, "todo", 4) == 0)
+            status = (status == TEST_FAIL) ? TEST_SKIP : TEST_FAIL;
+    }
+
+    /* Make sure that the test number is in range and not a duplicate. */
+    if (ts->results[current - 1] != TEST_INVALID) {
+        if (!verbose)
+            test_backspace(ts);
+        printf("ABORTED (duplicate test number %lu)\n", current);
+        ts->aborted = 1;
+        ts->reported = 1;
+        return;
+    }
+
+    /* Good results.  Increment our various counters. */
+    switch (status) {
+    case TEST_PASS:
+        ts->passed++;
+        break;
+    case TEST_FAIL:
+        ts->failed++;
+        break;
+    case TEST_SKIP:
+        ts->skipped++;
+        break;
+    case TEST_INVALID:
+        break;
+    }
+    ts->current = current;
+    ts->results[current - 1] = status;
+    if (!verbose && isatty(STDOUT_FILENO)) {
+        test_backspace(ts);
+        if (ts->plan == PLAN_PENDING)
+            outlen = printf("%lu/?", current);
+        else
+            outlen = printf("%lu/%lu", current, ts->count);
+        ts->length = (outlen >= 0) ? (unsigned int) outlen : 0;
+        fflush(stdout);
+    }
+}
+
+
+/*
+ * Print out a range of test numbers, returning the number of characters it
+ * took up.  Takes the first number, the last number, the number of characters
+ * already printed on the line, and the limit of number of characters the line
+ * can hold.  Add a comma and a space before the range if chars indicates that
+ * something has already been printed on the line, and print ... instead if
+ * chars plus the space needed would go over the limit (use a limit of 0 to
+ * disable this).
+ */
+static unsigned int
+test_print_range(unsigned long first, unsigned long last, unsigned long chars,
+                 unsigned int limit)
+{
+    unsigned int needed = 0;
+    unsigned long n;
+
+    for (n = first; n > 0; n /= 10)
+        needed++;
+    if (last > first) {
+        for (n = last; n > 0; n /= 10)
+            needed++;
+        needed++;
+    }
+    if (chars > 0)
+        needed += 2;
+    if (limit > 0 && chars + needed > limit) {
+        needed = 0;
+        if (chars <= limit) {
+            if (chars > 0) {
+                printf(", ");
+                needed += 2;
+            }
+            printf("...");
+            needed += 3;
+        }
+    } else {
+        if (chars > 0)
+            printf(", ");
+        if (last > first)
+            printf("%lu-", first);
+        printf("%lu", last);
+    }
+    return needed;
+}
+
+
+/*
+ * Summarize a single test set.  The second argument is 0 if the set exited
+ * cleanly, a positive integer representing the exit status if it exited
+ * with a non-zero status, and a negative integer representing the signal
+ * that terminated it if it was killed by a signal.
+ */
+static void
+test_summarize(struct testset *ts, int status)
+{
+    unsigned long i;
+    unsigned long missing = 0;
+    unsigned long failed = 0;
+    unsigned long first = 0;
+    unsigned long last = 0;
+
+    if (ts->aborted) {
+        fputs("ABORTED", stdout);
+        if (ts->count > 0)
+            printf(" (passed %lu/%lu)", ts->passed, ts->count - ts->skipped);
+    } else {
+        for (i = 0; i < ts->count; i++) {
+            if (ts->results[i] == TEST_INVALID) {
+                if (missing == 0)
+                    fputs("MISSED ", stdout);
+                if (first && i == last)
+                    last = i + 1;
+                else {
+                    if (first)
+                        test_print_range(first, last, missing - 1, 0);
+                    missing++;
+                    first = i + 1;
+                    last = i + 1;
+                }
+            }
+        }
+        if (first)
+            test_print_range(first, last, missing - 1, 0);
+        first = 0;
+        last = 0;
+        for (i = 0; i < ts->count; i++) {
+            if (ts->results[i] == TEST_FAIL) {
+                if (missing && !failed)
+                    fputs("; ", stdout);
+                if (failed == 0)
+                    fputs("FAILED ", stdout);
+                if (first && i == last)
+                    last = i + 1;
+                else {
+                    if (first)
+                        test_print_range(first, last, failed - 1, 0);
+                    failed++;
+                    first = i + 1;
+                    last = i + 1;
+                }
+            }
+        }
+        if (first)
+            test_print_range(first, last, failed - 1, 0);
+        if (!missing && !failed) {
+            fputs(!status ? "ok" : "dubious", stdout);
+            if (ts->skipped > 0) {
+                if (ts->skipped == 1)
+                    printf(" (skipped %lu test)", ts->skipped);
+                else
+                    printf(" (skipped %lu tests)", ts->skipped);
+            }
+        }
+    }
+    if (status > 0)
+        printf(" (exit status %d)", status);
+    else if (status < 0)
+        printf(" (killed by signal %d%s)", -status,
+               WCOREDUMP(ts->status) ? ", core dumped" : "");
+    putchar('\n');
+}
+
+
+/*
+ * Given a test set, analyze the results, classify the exit status, handle a
+ * few special error messages, and then pass it along to test_summarize() for
+ * the regular output.  Returns true if the test set ran successfully and all
+ * tests passed or were skipped, false otherwise.
+ */
+static int
+test_analyze(struct testset *ts)
+{
+    if (ts->reported)
+        return 0;
+    if (ts->all_skipped) {
+        if (ts->reason == NULL)
+            puts("skipped");
+        else
+            printf("skipped (%s)\n", ts->reason);
+        return 1;
+    } else if (WIFEXITED(ts->status) && WEXITSTATUS(ts->status) != 0) {
+        switch (WEXITSTATUS(ts->status)) {
+        case CHILDERR_DUP:
+            if (!ts->reported)
+                puts("ABORTED (can't dup file descriptors)");
+            break;
+        case CHILDERR_EXEC:
+            if (!ts->reported)
+                puts("ABORTED (execution failed -- not found?)");
+            break;
+        case CHILDERR_STDIN:
+        case CHILDERR_STDERR:
+            if (!ts->reported)
+                puts("ABORTED (can't open /dev/null)");
+            break;
+        default:
+            test_summarize(ts, WEXITSTATUS(ts->status));
+            break;
+        }
+        return 0;
+    } else if (WIFSIGNALED(ts->status)) {
+        test_summarize(ts, -WTERMSIG(ts->status));
+        return 0;
+    } else if (ts->plan != PLAN_FIRST && ts->plan != PLAN_FINAL) {
+        puts("ABORTED (no valid test plan)");
+        ts->aborted = 1;
+        return 0;
+    } else {
+        test_summarize(ts, 0);
+        return (ts->failed == 0);
+    }
+}
+
+
+/*
+ * Runs a single test set, accumulating and then reporting the results.
+ * Returns true if the test set was successfully run and all tests passed,
+ * false otherwise.
+ */
+static int
+test_run(struct testset *ts, enum test_verbose verbose)
+{
+    pid_t testpid, child;
+    int outfd, status;
+    unsigned long i;
+    FILE *output;
+    char buffer[BUFSIZ];
+
+    /* Run the test program. */
+    testpid = test_start(ts->command, &outfd);
+    output = fdopen(outfd, "r");
+    if (!output) {
+        puts("ABORTED");
+        fflush(stdout);
+        sysdie("fdopen failed");
+    }
+
+    /*
+     * Pass each line of output to test_checkline(), and print the line if
+     * verbosity is requested.
+     */
+    while (!ts->aborted && fgets(buffer, sizeof(buffer), output)) {
+        if (verbose)
+            printf("%s", buffer);
+        test_checkline(buffer, ts, verbose);
+    }
+    if (ferror(output) || ts->plan == PLAN_INIT)
+        ts->aborted = 1;
+    if (!verbose)
+        test_backspace(ts);
+
+    /*
+     * Consume the rest of the test output, close the output descriptor,
+     * retrieve the exit status, and pass that information to test_analyze()
+     * for eventual output.
+     */
+    while (fgets(buffer, sizeof(buffer), output))
+        if (verbose)
+            printf("%s", buffer);
+    fclose(output);
+    child = waitpid(testpid, &ts->status, 0);
+    if (child == (pid_t) -1) {
+        if (!ts->reported) {
+            puts("ABORTED");
+            fflush(stdout);
+        }
+        sysdie("waitpid for %u failed", (unsigned int) testpid);
+    }
+    if (ts->all_skipped)
+        ts->aborted = 0;
+    status = test_analyze(ts);
+
+    /* Convert missing tests to failed tests. */
+    for (i = 0; i < ts->count; i++) {
+        if (ts->results[i] == TEST_INVALID) {
+            ts->failed++;
+            ts->results[i] = TEST_FAIL;
+            status = 0;
+        }
+    }
+    return status;
+}
+
+
+/* Summarize a list of test failures. */
+static void
+test_fail_summary(const struct testlist *fails)
+{
+    struct testset *ts;
+    unsigned int chars;
+    unsigned long i, first, last, total;
+    double failed;
+
+    puts(header);
+
+    /* Failed Set                 Fail/Total (%) Skip Stat  Failing (25)
+       -------------------------- -------------- ---- ----  -------------- */
+    for (; fails; fails = fails->next) {
+        ts = fails->ts;
+        total = ts->count - ts->skipped;
+        failed = (double) ts->failed;
+        printf("%-26.26s %4lu/%-4lu %3.0f%% %4lu ", ts->file, ts->failed,
+               total, total ? (failed * 100.0) / (double) total : 0,
+               ts->skipped);
+        if (WIFEXITED(ts->status))
+            printf("%4d  ", WEXITSTATUS(ts->status));
+        else
+            printf("  --  ");
+        if (ts->aborted) {
+            puts("aborted");
+            continue;
+        }
+        chars = 0;
+        first = 0;
+        last = 0;
+        for (i = 0; i < ts->count; i++) {
+            if (ts->results[i] == TEST_FAIL) {
+                if (first != 0 && i == last)
+                    last = i + 1;
+                else {
+                    if (first != 0)
+                        chars += test_print_range(first, last, chars, 19);
+                    first = i + 1;
+                    last = i + 1;
+                }
+            }
+        }
+        if (first != 0)
+            test_print_range(first, last, chars, 19);
+        putchar('\n');
+    }
+}
+
+
+/*
+ * Check whether a given file path is a valid test.  Currently, this checks
+ * whether it is executable and is a regular file.  Returns true or false.
+ */
+static int
+is_valid_test(const char *path)
+{
+    struct stat st;
+
+    if (access(path, X_OK) < 0)
+        return 0;
+    if (stat(path, &st) < 0)
+        return 0;
+    if (!S_ISREG(st.st_mode))
+        return 0;
+    return 1;
+}
+
+
+/*
+ * Given the name of a test, a pointer to the testset struct, and the source
+ * and build directories, find the test.  We try first relative to the current
+ * directory, then in the build directory (if not NULL), then in the source
+ * directory.  In each of those directories, we first try a "-t" extension and
+ * then a ".t" extension.  When we find an executable program, we return the
+ * path to that program.  If none of those paths are executable, just fill in
+ * the name of the test as is.
+ *
+ * The caller is responsible for freeing the path member of the testset
+ * struct.
+ */
+static char *
+find_test(const char *name, const char *source, const char *build)
+{
+    char *path = NULL;
+    const char *bases[3], *suffix, *base;
+    unsigned int i, j;
+    const char *suffixes[3] = {"-t", ".t", ""};
+
+    /* Possible base directories. */
+    bases[0] = ".";
+    bases[1] = build;
+    bases[2] = source;
+
+    /* Try each suffix with each base. */
+    for (i = 0; i < ARRAY_SIZE(suffixes); i++) {
+        suffix = suffixes[i];
+        for (j = 0; j < ARRAY_SIZE(bases); j++) {
+            base = bases[j];
+            if (base == NULL)
+                continue;
+            path = concat(base, "/", name, suffix, (const char *) 0);
+            if (is_valid_test(path))
+                return path;
+            free(path);
+            path = NULL;
+        }
+    }
+    if (path == NULL)
+        path = xstrdup(name);
+    return path;
+}
+
+
+/*
+ * Parse a single line of a test list and store the test name and command to
+ * execute it in the given testset struct.
+ *
+ * Normally, each line is just the name of the test, which is located in the
+ * test directory and turned into a command to run.  However, each line may
+ * have whitespace-separated options, which change the command that's run.
+ * Current supported options are:
+ *
+ * valgrind
+ *     Run the test under valgrind if C_TAP_VALGRIND is set.  The contents
+ *     of that environment variable are taken as the valgrind command (with
+ *     options) to run.  The command is parsed with a simple split on
+ *     whitespace and no quoting is supported.
+ *
+ * libtool
+ *     If running under valgrind, use libtool to invoke valgrind.  This avoids
+ *     running valgrind on the wrapper shell script generated by libtool.  If
+ *     set, C_TAP_LIBTOOL must be set to the full path to the libtool program
+ *     to use to run valgrind and thus the test.  Ignored if the test isn't
+ *     being run under valgrind.
+ */
+static void
+parse_test_list_line(const char *line, struct testset *ts, const char *source,
+                     const char *build)
+{
+    const char *p, *end, *option, *libtool;
+    const char *valgrind = NULL;
+    unsigned int use_libtool = 0;
+    unsigned int use_valgrind = 0;
+    size_t len, i;
+
+    /* Determine the name of the test. */
+    p = skip_non_whitespace(line);
+    ts->file = xstrndup(line, p - line);
+
+    /* Check if any test options are set. */
+    p = skip_whitespace(p);
+    while (*p != '\0') {
+        end = skip_non_whitespace(p);
+        if (strncmp(p, "libtool", end - p) == 0) {
+            use_libtool = 1;
+        } else if (strncmp(p, "valgrind", end - p) == 0) {
+            valgrind = getenv("C_TAP_VALGRIND");
+            use_valgrind = (valgrind != NULL);
+        } else {
+            option = xstrndup(p, end - p);
+            die("unknown test list option %s", option);
+        }
+        p = skip_whitespace(end);
+    }
+
+    /* Construct the argv to run the test.  First, find the length. */
+    len = 1;
+    if (use_valgrind && valgrind != NULL) {
+        p = skip_whitespace(valgrind);
+        while (*p != '\0') {
+            len++;
+            p = skip_whitespace(skip_non_whitespace(p));
+        }
+        if (use_libtool)
+            len += 2;
+    }
+
+    /* Now, build the command. */
+    ts->command = xcalloc(len + 1, char *);
+    i = 0;
+    if (use_valgrind && valgrind != NULL) {
+        if (use_libtool) {
+            libtool = getenv("C_TAP_LIBTOOL");
+            if (libtool == NULL)
+                die("valgrind with libtool requested, but C_TAP_LIBTOOL is not"
+                    " set");
+            ts->command[i++] = xstrdup(libtool);
+            ts->command[i++] = xstrdup("--mode=execute");
+        }
+        p = skip_whitespace(valgrind);
+        while (*p != '\0') {
+            end = skip_non_whitespace(p);
+            ts->command[i++] = xstrndup(p, end - p);
+            p = skip_whitespace(end);
+        }
+    }
+    if (i != len - 1)
+        die("internal error while constructing command line");
+    ts->command[i++] = find_test(ts->file, source, build);
+    ts->command[i] = NULL;
+}
+
+
+/*
+ * Read a list of tests from a file, returning the list of tests as a struct
+ * testlist, or NULL if there were no tests (such as a file containing only
+ * comments).  Reports an error to standard error and exits if the list of
+ * tests cannot be read.
+ */
+static struct testlist *
+read_test_list(const char *filename, const char *source, const char *build)
+{
+    FILE *file;
+    unsigned int line;
+    size_t length;
+    char buffer[BUFSIZ];
+    const char *start;
+    struct testlist *listhead, *current;
+
+    /* Create the initial container list that will hold our results. */
+    listhead = xcalloc(1, struct testlist);
+    current = NULL;
+
+    /*
+     * Open our file of tests to run and read it line by line, creating a new
+     * struct testlist and struct testset for each line.
+     */
+    file = fopen(filename, "r");
+    if (file == NULL)
+        sysdie("can't open %s", filename);
+    line = 0;
+    while (fgets(buffer, sizeof(buffer), file)) {
+        line++;
+        length = strlen(buffer) - 1;
+        if (buffer[length] != '\n') {
+            fprintf(stderr, "%s:%u: line too long\n", filename, line);
+            exit(1);
+        }
+        buffer[length] = '\0';
+
+        /* Skip comments, leading spaces, and blank lines. */
+        start = skip_whitespace(buffer);
+        if (strlen(start) == 0)
+            continue;
+        if (start[0] == '#')
+            continue;
+
+        /* Allocate the new testset structure. */
+        if (current == NULL)
+            current = listhead;
+        else {
+            current->next = xcalloc(1, struct testlist);
+            current = current->next;
+        }
+        current->ts = xcalloc(1, struct testset);
+        current->ts->plan = PLAN_INIT;
+
+        /* Parse the line and store the results in the testset struct. */
+        parse_test_list_line(start, current->ts, source, build);
+    }
+    fclose(file);
+
+    /* If there were no tests, current is still NULL. */
+    if (current == NULL) {
+        free(listhead);
+        return NULL;
+    }
+
+    /* Return the results. */
+    return listhead;
+}
+
+
+/*
+ * Build a list of tests from command line arguments.  Takes the argv and argc
+ * representing the command line arguments and returns a newly allocated test
+ * list, or NULL if there were no tests.  The caller is responsible for
+ * freeing.
+ */
+static struct testlist *
+build_test_list(char *argv[], int argc, const char *source, const char *build)
+{
+    int i;
+    struct testlist *listhead, *current;
+
+    /* Create the initial container list that will hold our results. */
+    listhead = xcalloc(1, struct testlist);
+    current = NULL;
+
+    /* Walk the list of arguments and create test sets for them. */
+    for (i = 0; i < argc; i++) {
+        if (current == NULL)
+            current = listhead;
+        else {
+            current->next = xcalloc(1, struct testlist);
+            current = current->next;
+        }
+        current->ts = xcalloc(1, struct testset);
+        current->ts->plan = PLAN_INIT;
+        current->ts->file = xstrdup(argv[i]);
+        current->ts->command = xcalloc(2, char *);
+        current->ts->command[0] = find_test(current->ts->file, source, build);
+        current->ts->command[1] = NULL;
+    }
+
+    /* If there were no tests, current is still NULL. */
+    if (current == NULL) {
+        free(listhead);
+        return NULL;
+    }
+
+    /* Return the results. */
+    return listhead;
+}
+
+
+/* Free a struct testset. */
+static void
+free_testset(struct testset *ts)
+{
+    size_t i;
+
+    free(ts->file);
+    for (i = 0; ts->command[i] != NULL; i++)
+        free(ts->command[i]);
+    free(ts->command);
+    free(ts->results);
+    free(ts->reason);
+    free(ts);
+}
+
+
+/*
+ * Run a batch of tests.  Takes two additional parameters: the root of the
+ * source directory and the root of the build directory.  Test programs will
+ * be first searched for in the current directory, then the build directory,
+ * then the source directory.  Returns true iff all tests passed, and always
+ * frees the test list that's passed in.
+ */
+static int
+test_batch(struct testlist *tests, enum test_verbose verbose)
+{
+    size_t length, i;
+    size_t longest = 0;
+    unsigned int count = 0;
+    struct testset *ts;
+    struct timeval start, end;
+    struct rusage stats;
+    struct testlist *failhead = NULL;
+    struct testlist *failtail = NULL;
+    struct testlist *current, *next;
+    int succeeded;
+    unsigned long total = 0;
+    unsigned long passed = 0;
+    unsigned long skipped = 0;
+    unsigned long failed = 0;
+    unsigned long aborted = 0;
+
+    /* Walk the list of tests to find the longest name. */
+    for (current = tests; current != NULL; current = current->next) {
+        length = strlen(current->ts->file);
+        if (length > longest)
+            longest = length;
+    }
+
+    /*
+     * Add two to longest and round up to the nearest tab stop.  This is how
+     * wide the column for printing the current test name will be.
+     */
+    longest += 2;
+    if (longest % 8)
+        longest += 8 - (longest % 8);
+
+    /* Start the wall clock timer. */
+    gettimeofday(&start, NULL);
+
+    /* Now, plow through our tests again, running each one. */
+    for (current = tests; current != NULL; current = current->next) {
+        ts = current->ts;
+
+        /* Print out the name of the test file. */
+        fputs(ts->file, stdout);
+        if (verbose)
+            fputs("\n\n", stdout);
+        else
+            for (i = strlen(ts->file); i < longest; i++)
+                putchar('.');
+        if (isatty(STDOUT_FILENO))
+            fflush(stdout);
+
+        /* Run the test. */
+        succeeded = test_run(ts, verbose);
+        fflush(stdout);
+        if (verbose)
+            putchar('\n');
+
+        /* Record cumulative statistics. */
+        aborted += ts->aborted;
+        total += ts->count + ts->all_skipped;
+        passed += ts->passed;
+        skipped += ts->skipped + ts->all_skipped;
+        failed += ts->failed;
+        count++;
+
+        /* If the test fails, we shuffle it over to the fail list. */
+        if (!succeeded) {
+            if (failhead == NULL) {
+                failhead = xcalloc(1, struct testlist);
+                failtail = failhead;
+            } else {
+                failtail->next = xcalloc(1, struct testlist);
+                failtail = failtail->next;
+            }
+            failtail->ts = ts;
+            failtail->next = NULL;
+        }
+    }
+    total -= skipped;
+
+    /* Stop the timer and get our child resource statistics. */
+    gettimeofday(&end, NULL);
+    getrusage(RUSAGE_CHILDREN, &stats);
+
+    /* Summarize the failures and free the failure list. */
+    if (failhead != NULL) {
+        test_fail_summary(failhead);
+        while (failhead != NULL) {
+            next = failhead->next;
+            free(failhead);
+            failhead = next;
+        }
+    }
+
+    /* Free the memory used by the test lists. */
+    while (tests != NULL) {
+        next = tests->next;
+        free_testset(tests->ts);
+        free(tests);
+        tests = next;
+    }
+
+    /* Print out the final test summary. */
+    putchar('\n');
+    if (aborted != 0) {
+        if (aborted == 1)
+            printf("Aborted %lu test set", aborted);
+        else
+            printf("Aborted %lu test sets", aborted);
+        printf(", passed %lu/%lu tests", passed, total);
+    } else if (failed == 0)
+        fputs("All tests successful", stdout);
+    else
+        printf("Failed %lu/%lu tests, %.2f%% okay", failed, total,
+               (double) (total - failed) * 100.0 / (double) total);
+    if (skipped != 0) {
+        if (skipped == 1)
+            printf(", %lu test skipped", skipped);
+        else
+            printf(", %lu tests skipped", skipped);
+    }
+    puts(".");
+    printf("Files=%u,  Tests=%lu", count, total);
+    printf(",  %.2f seconds", tv_diff(&end, &start));
+    printf(" (%.2f usr + %.2f sys = %.2f CPU)\n", tv_seconds(&stats.ru_utime),
+           tv_seconds(&stats.ru_stime),
+           tv_sum(&stats.ru_utime, &stats.ru_stime));
+    return (failed == 0 && aborted == 0);
+}
+
+
+/*
+ * Run a single test case.  This involves just running the test program after
+ * having done the environment setup and finding the test program.
+ */
+static void
+test_single(const char *program, const char *source, const char *build)
+{
+    char *path;
+
+    path = find_test(program, source, build);
+    if (execl(path, path, (char *) 0) == -1)
+        sysdie("cannot exec %s", path);
+}
+
+
+/*
+ * Main routine.  Set the C_TAP_SOURCE, C_TAP_BUILD, SOURCE, and BUILD
+ * environment variables and then, given a file listing tests, run each test
+ * listed.
+ */
+int
+main(int argc, char *argv[])
+{
+    int option;
+    int status = 0;
+    int single = 0;
+    enum test_verbose verbose = CONCISE;
+    char *c_tap_source_env = NULL;
+    char *c_tap_build_env = NULL;
+    char *source_env = NULL;
+    char *build_env = NULL;
+    const char *program;
+    const char *shortlist;
+    const char *list = NULL;
+    const char *source = C_TAP_SOURCE;
+    const char *build = C_TAP_BUILD;
+    struct testlist *tests;
+
+    program = argv[0];
+    while ((option = getopt(argc, argv, "b:hl:os:v")) != EOF) {
+        switch (option) {
+        case 'b':
+            build = optarg;
+            break;
+        case 'h':
+            printf(usage_message, program, program, program, usage_extra);
+            exit(0);
+        case 'l':
+            list = optarg;
+            break;
+        case 'o':
+            single = 1;
+            break;
+        case 's':
+            source = optarg;
+            break;
+        case 'v':
+            verbose = VERBOSE;
+            break;
+        default:
+            exit(1);
+        }
+    }
+    argv += optind;
+    argc -= optind;
+    if ((list == NULL && argc < 1) || (list != NULL && argc > 0)) {
+        fprintf(stderr, usage_message, program, program, program, usage_extra);
+        exit(1);
+    }
+
+    /*
+     * If C_TAP_VERBOSE is set in the environment, that also turns on verbose
+     * mode.
+     */
+    if (getenv("C_TAP_VERBOSE") != NULL)
+        verbose = VERBOSE;
+
+    /*
+     * Set C_TAP_SOURCE and C_TAP_BUILD environment variables.  Also set
+     * SOURCE and BUILD for backward compatibility, although we're trying to
+     * migrate to the ones with a C_TAP_* prefix.
+     */
+    if (source != NULL) {
+        c_tap_source_env = concat("C_TAP_SOURCE=", source, (const char *) 0);
+        if (putenv(c_tap_source_env) != 0)
+            sysdie("cannot set C_TAP_SOURCE in the environment");
+        source_env = concat("SOURCE=", source, (const char *) 0);
+        if (putenv(source_env) != 0)
+            sysdie("cannot set SOURCE in the environment");
+    }
+    if (build != NULL) {
+        c_tap_build_env = concat("C_TAP_BUILD=", build, (const char *) 0);
+        if (putenv(c_tap_build_env) != 0)
+            sysdie("cannot set C_TAP_BUILD in the environment");
+        build_env = concat("BUILD=", build, (const char *) 0);
+        if (putenv(build_env) != 0)
+            sysdie("cannot set BUILD in the environment");
+    }
+
+    /* Run the tests as instructed. */
+    if (single)
+        test_single(argv[0], source, build);
+    else if (list != NULL) {
+        shortlist = strrchr(list, '/');
+        if (shortlist == NULL)
+            shortlist = list;
+        else
+            shortlist++;
+        printf(banner, shortlist);
+        tests = read_test_list(list, source, build);
+        status = test_batch(tests, verbose) ? 0 : 1;
+    } else {
+        tests = build_test_list(argv, argc, source, build);
+        status = test_batch(tests, verbose) ? 0 : 1;
+    }
+
+    /* For valgrind cleanliness, free all our memory. */
+    if (source_env != NULL) {
+        putenv((char *) "C_TAP_SOURCE=");
+        putenv((char *) "SOURCE=");
+        free(c_tap_source_env);
+        free(source_env);
+    }
+    if (build_env != NULL) {
+        putenv((char *) "C_TAP_BUILD=");
+        putenv((char *) "BUILD=");
+        free(c_tap_build_env);
+        free(build_env);
+    }
+    exit(status);
+}
\ No newline at end of file
diff --git a/t/tap/basic.c b/t/tap/basic.c
new file mode 100644
index 0000000000..704282b9c1
--- /dev/null
+++ b/t/tap/basic.c
@@ -0,0 +1,1029 @@
+/*
+ * Some utility routines for writing tests.
+ *
+ * Here are a variety of utility routines for writing tests compatible with
+ * the TAP protocol.  All routines of the form ok() or is*() take a test
+ * number and some number of appropriate arguments, check to be sure the
+ * results match the expected output using the arguments, and print out
+ * something appropriate for that test number.  Other utility routines help in
+ * constructing more complex tests, skipping tests, reporting errors, setting
+ * up the TAP output format, or finding things in the test environment.
+ *
+ * This file is part of C TAP Harness.  The current version plus supporting
+ * documentation is at <https://www.eyrie.org/~eagle/software/c-tap-harness/>.
+ *
+ * Written by Russ Allbery <eagle@eyrie.org>
+ * Copyright 2009-2019, 2021 Russ Allbery <eagle@eyrie.org>
+ * Copyright 2001-2002, 2004-2008, 2011-2014
+ *     The Board of Trustees of the Leland Stanford Junior University
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include <errno.h>
+#include <limits.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#ifdef _WIN32
+#    include <direct.h>
+#else
+#    include <sys/stat.h>
+#endif
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <tap/basic.h>
+
+/* Windows provides mkdir and rmdir under different names. */
+#ifdef _WIN32
+#    define mkdir(p, m) _mkdir(p)
+#    define rmdir(p)    _rmdir(p)
+#endif
+
+/*
+ * The test count.  Always contains the number that will be used for the next
+ * test status.  This is exported to callers of the library.
+ */
+unsigned long testnum = 1;
+
+/*
+ * Status information stored so that we can give a test summary at the end of
+ * the test case.  We store the planned final test and the count of failures.
+ * We can get the highest test count from testnum.
+ */
+static unsigned long _planned = 0;
+static unsigned long _failed = 0;
+
+/*
+ * Store the PID of the process that called plan() and only summarize
+ * results when that process exits, so as to not misreport results in forked
+ * processes.
+ */
+static pid_t _process = 0;
+
+/*
+ * If true, we're doing lazy planning and will print out the plan based on the
+ * last test number at the end of testing.
+ */
+static int _lazy = 0;
+
+/*
+ * If true, the test was aborted by calling bail().  Currently, this is only
+ * used to ensure that we pass a false value to any cleanup functions even if
+ * all tests to that point have passed.
+ */
+static int _aborted = 0;
+
+/*
+ * Registered cleanup functions.  These are stored as a linked list and run in
+ * registered order by finish when the test program exits.  Each function is
+ * passed a boolean value indicating whether all tests were successful.
+ */
+struct cleanup_func {
+    test_cleanup_func func;
+    test_cleanup_func_with_data func_with_data;
+    void *data;
+    struct cleanup_func *next;
+};
+static struct cleanup_func *cleanup_funcs = NULL;
+
+/*
+ * Registered diag files.  Any output found in these files will be printed out
+ * as if it were passed to diag() before any other output we do.  This allows
+ * background processes to log to a file and have that output interleaved with
+ * the test output.
+ */
+struct diag_file {
+    char *name;
+    FILE *file;
+    char *buffer;
+    size_t bufsize;
+    struct diag_file *next;
+};
+static struct diag_file *diag_files = NULL;
+
+/*
+ * Print a specified prefix and then the test description.  Handles turning
+ * the argument list into a va_args structure suitable for passing to
+ * print_desc, which has to be done in a macro.  Assumes that format is the
+ * argument immediately before the variadic arguments.
+ */
+#define PRINT_DESC(prefix, format)  \
+    do {                            \
+        if (format != NULL) {       \
+            va_list args;           \
+            printf("%s", prefix);   \
+            va_start(args, format); \
+            vprintf(format, args);  \
+            va_end(args);           \
+        }                           \
+    } while (0)
+
+
+/*
+ * Form a new string by concatenating multiple strings.  The arguments must be
+ * terminated by (const char *) 0.
+ *
+ * This function only exists because we can't assume asprintf.  We can't
+ * simulate asprintf with snprintf because we're only assuming SUSv3, which
+ * does not require that snprintf with a NULL buffer return the required
+ * length.  When those constraints are relaxed, this should be ripped out and
+ * replaced with asprintf or a more trivial replacement with snprintf.
+ */
+static char *
+concat(const char *first, ...)
+{
+    va_list args;
+    char *result;
+    const char *string;
+    size_t offset;
+    size_t length = 0;
+
+    /*
+     * Find the total memory required.  Ensure we don't overflow length.  See
+     * the comment for breallocarray for why we're using UINT_MAX here.
+     */
+    va_start(args, first);
+    for (string = first; string != NULL; string = va_arg(args, const char *)) {
+        if (length >= UINT_MAX - strlen(string))
+            bail("strings too long in concat");
+        length += strlen(string);
+    }
+    va_end(args);
+    length++;
+
+    /* Create the string. */
+    result = bcalloc_type(length, char);
+    va_start(args, first);
+    offset = 0;
+    for (string = first; string != NULL; string = va_arg(args, const char *)) {
+        memcpy(result + offset, string, strlen(string));
+        offset += strlen(string);
+    }
+    va_end(args);
+    result[offset] = '\0';
+    return result;
+}
+
+
+/*
+ * Helper function for check_diag_files to handle a single line in a diag
+ * file.
+ *
+ * The general scheme here used is as follows: read one line of output.  If we
+ * get NULL, check for an error.  If there was one, bail out of the test
+ * program; otherwise, return, and the enclosing loop will check for EOF.
+ *
+ * If we get some data, see if it ends in a newline.  If it doesn't end in a
+ * newline, we have one of two cases: our buffer isn't large enough, in which
+ * case we resize it and try again, or we have incomplete data in the file, in
+ * which case we rewind the file and will try again next time.
+ *
+ * Returns a boolean indicating whether the last line was incomplete.
+ */
+static int
+handle_diag_file_line(struct diag_file *file, fpos_t where)
+{
+    int size;
+    size_t length;
+
+    /* Read the next line from the file. */
+    size = file->bufsize > INT_MAX ? INT_MAX : (int) file->bufsize;
+    if (fgets(file->buffer, size, file->file) == NULL) {
+        if (ferror(file->file))
+            sysbail("cannot read from %s", file->name);
+        return 0;
+    }
+
+    /*
+     * See if the line ends in a newline.  If not, see which error case we
+     * have.
+     */
+    length = strlen(file->buffer);
+    if (file->buffer[length - 1] != '\n') {
+        int incomplete = 0;
+
+        /* Check whether we ran out of buffer space and resize if so. */
+        if (length < file->bufsize - 1)
+            incomplete = 1;
+        else {
+            file->bufsize += BUFSIZ;
+            file->buffer =
+                breallocarray_type(file->buffer, file->bufsize, char);
+        }
+
+        /*
+         * On either incomplete lines or too small of a buffer, rewind
+         * and read the file again (on the next pass, if incomplete).
+         * It's simpler than trying to double-buffer the file.
+         */
+        if (fsetpos(file->file, &where) < 0)
+            sysbail("cannot set position in %s", file->name);
+        return incomplete;
+    }
+
+    /* We saw a complete line.  Print it out. */
+    printf("# %s", file->buffer);
+    return 0;
+}
+
+
+/*
+ * Check all registered diag_files for any output.  We only print out the
+ * output if we see a complete line; otherwise, we wait for the next newline.
+ */
+static void
+check_diag_files(void)
+{
+    struct diag_file *file;
+    fpos_t where;
+    int incomplete;
+
+    /*
+     * Walk through each file and read each line of output available.
+     */
+    for (file = diag_files; file != NULL; file = file->next) {
+        clearerr(file->file);
+
+        /* Store the current position in case we have to rewind. */
+        if (fgetpos(file->file, &where) < 0)
+            sysbail("cannot get position in %s", file->name);
+
+        /* Continue until we get EOF or an incomplete line of data. */
+        incomplete = 0;
+        while (!feof(file->file) && !incomplete) {
+            incomplete = handle_diag_file_line(file, where);
+        }
+    }
+}
+
+
+/*
+ * Our exit handler.  Called on completion of the test to report a summary of
+ * results provided we're still in the original process.  This also handles
+ * printing out the plan if we used plan_lazy(), although that's suppressed if
+ * we never ran a test (due to an early bail, for example), and running any
+ * registered cleanup functions.
+ */
+static void
+finish(void)
+{
+    int success, primary;
+    struct cleanup_func *current;
+    unsigned long highest = testnum - 1;
+    struct diag_file *file, *tmp;
+
+    /* Check for pending diag_file output. */
+    check_diag_files();
+
+    /* Free the diag_files. */
+    file = diag_files;
+    while (file != NULL) {
+        tmp = file;
+        file = file->next;
+        fclose(tmp->file);
+        free(tmp->name);
+        free(tmp->buffer);
+        free(tmp);
+    }
+    diag_files = NULL;
+
+    /*
+     * Determine whether all tests were successful, which is needed before
+     * calling cleanup functions since we pass that fact to the functions.
+     */
+    if (_planned == 0 && _lazy)
+        _planned = highest;
+    success = (!_aborted && _planned == highest && _failed == 0);
+
+    /*
+     * If there are any registered cleanup functions, we run those first.  We
+     * always run them, even if we didn't run a test.  Don't do anything
+     * except free the diag_files and call cleanup functions if we aren't the
+     * primary process (the process in which plan or plan_lazy was called),
+     * and tell the cleanup functions that fact.
+     */
+    primary = (_process == 0 || getpid() == _process);
+    while (cleanup_funcs != NULL) {
+        if (cleanup_funcs->func_with_data) {
+            void *data = cleanup_funcs->data;
+
+            cleanup_funcs->func_with_data(success, primary, data);
+        } else {
+            cleanup_funcs->func(success, primary);
+        }
+        current = cleanup_funcs;
+        cleanup_funcs = cleanup_funcs->next;
+        free(current);
+    }
+    if (!primary)
+        return;
+
+    /* Don't do anything further if we never planned a test. */
+    if (_planned == 0)
+        return;
+
+    /* If we're aborting due to bail, don't print summaries. */
+    if (_aborted)
+        return;
+
+    /* Print out the lazy plan if needed. */
+    fflush(stderr);
+    if (_lazy)
+        printf("1..%lu\n", _planned);
+
+    /* Print out a summary of the results. */
+    if (_planned > highest)
+        diag("Looks like you planned %lu test%s but only ran %lu", _planned,
+             (_planned > 1 ? "s" : ""), highest);
+    else if (_planned < highest)
+        diag("Looks like you planned %lu test%s but ran %lu extra", _planned,
+             (_planned > 1 ? "s" : ""), highest - _planned);
+    else if (_failed > 0)
+        diag("Looks like you failed %lu test%s of %lu", _failed,
+             (_failed > 1 ? "s" : ""), _planned);
+    else if (_planned != 1)
+        diag("All %lu tests successful or skipped", _planned);
+    else
+        diag("%lu test successful or skipped", _planned);
+}
+
+
+/*
+ * Initialize things.  Turns on line buffering on stdout and then prints out
+ * the number of tests in the test suite.  We intentionally don't check for
+ * pending diag_file output here, since it should really come after the plan.
+ */
+void
+plan(unsigned long count)
+{
+    if (setvbuf(stdout, NULL, _IOLBF, BUFSIZ) != 0)
+        sysdiag("cannot set stdout to line buffered");
+    fflush(stderr);
+    printf("1..%lu\n", count);
+    testnum = 1;
+    _planned = count;
+    _process = getpid();
+    if (atexit(finish) != 0) {
+        sysdiag("cannot register exit handler");
+        diag("cleanups will not be run");
+    }
+}
+
+
+/*
+ * Initialize things for lazy planning, where we'll automatically print out a
+ * plan at the end of the program.  Turns on line buffering on stdout as well.
+ */
+void
+plan_lazy(void)
+{
+    if (setvbuf(stdout, NULL, _IOLBF, BUFSIZ) != 0)
+        sysdiag("cannot set stdout to line buffered");
+    testnum = 1;
+    _process = getpid();
+    _lazy = 1;
+    if (atexit(finish) != 0)
+        sysbail("cannot register exit handler to display plan");
+}
+
+
+/*
+ * Skip the entire test suite and exits.  Should be called instead of plan(),
+ * not after it, since it prints out a special plan line.  Ignore diag_file
+ * output here, since it's not clear if it's allowed before the plan.
+ */
+void
+skip_all(const char *format, ...)
+{
+    fflush(stderr);
+    printf("1..0 # skip");
+    PRINT_DESC(" ", format);
+    putchar('\n');
+    exit(0);
+}
+
+
+/*
+ * Takes a boolean success value and assumes the test passes if that value
+ * is true and fails if that value is false.
+ */
+int
+ok(int success, const char *format, ...)
+{
+    fflush(stderr);
+    check_diag_files();
+    printf("%sok %lu", success ? "" : "not ", testnum++);
+    if (!success)
+        _failed++;
+    PRINT_DESC(" - ", format);
+    putchar('\n');
+    return success;
+}
+
+
+/*
+ * Same as ok(), but takes the format arguments as a va_list.
+ */
+int
+okv(int success, const char *format, va_list args)
+{
+    fflush(stderr);
+    check_diag_files();
+    printf("%sok %lu", success ? "" : "not ", testnum++);
+    if (!success)
+        _failed++;
+    if (format != NULL) {
+        printf(" - ");
+        vprintf(format, args);
+    }
+    putchar('\n');
+    return success;
+}
+
+
+/*
+ * Skip a test.
+ */
+void
+skip(const char *reason, ...)
+{
+    fflush(stderr);
+    check_diag_files();
+    printf("ok %lu # skip", testnum++);
+    PRINT_DESC(" ", reason);
+    putchar('\n');
+}
+
+
+/*
+ * Report the same status on the next count tests.
+ */
+int
+ok_block(unsigned long count, int success, const char *format, ...)
+{
+    unsigned long i;
+
+    fflush(stderr);
+    check_diag_files();
+    for (i = 0; i < count; i++) {
+        printf("%sok %lu", success ? "" : "not ", testnum++);
+        if (!success)
+            _failed++;
+        PRINT_DESC(" - ", format);
+        putchar('\n');
+    }
+    return success;
+}
+
+
+/*
+ * Skip the next count tests.
+ */
+void
+skip_block(unsigned long count, const char *reason, ...)
+{
+    unsigned long i;
+
+    fflush(stderr);
+    check_diag_files();
+    for (i = 0; i < count; i++) {
+        printf("ok %lu # skip", testnum++);
+        PRINT_DESC(" ", reason);
+        putchar('\n');
+    }
+}
+
+
+/*
+ * Takes two boolean values and requires the truth value of both match.
+ */
+int
+is_bool(int left, int right, const char *format, ...)
+{
+    int success;
+
+    fflush(stderr);
+    check_diag_files();
+    success = (!!left == !!right);
+    if (success)
+        printf("ok %lu", testnum++);
+    else {
+        diag(" left: %s", !!left ? "true" : "false");
+        diag("right: %s", !!right ? "true" : "false");
+        printf("not ok %lu", testnum++);
+        _failed++;
+    }
+    PRINT_DESC(" - ", format);
+    putchar('\n');
+    return success;
+}
+
+
+/*
+ * Takes two integer values and requires they match.
+ */
+int
+is_int(long left, long right, const char *format, ...)
+{
+    int success;
+
+    fflush(stderr);
+    check_diag_files();
+    success = (left == right);
+    if (success)
+        printf("ok %lu", testnum++);
+    else {
+        diag(" left: %ld", left);
+        diag("right: %ld", right);
+        printf("not ok %lu", testnum++);
+        _failed++;
+    }
+    PRINT_DESC(" - ", format);
+    putchar('\n');
+    return success;
+}
+
+
+/*
+ * Takes two strings and requires they match (using strcmp).  NULL arguments
+ * are permitted and handled correctly.
+ */
+int
+is_string(const char *left, const char *right, const char *format, ...)
+{
+    int success;
+
+    fflush(stderr);
+    check_diag_files();
+
+    /* Compare the strings, being careful of NULL. */
+    if (left == NULL)
+        success = (right == NULL);
+    else if (right == NULL)
+        success = 0;
+    else
+        success = (strcmp(left, right) == 0);
+
+    /* Report the results. */
+    if (success)
+        printf("ok %lu", testnum++);
+    else {
+        diag(" left: %s", left == NULL ? "(null)" : left);
+        diag("right: %s", right == NULL ? "(null)" : right);
+        printf("not ok %lu", testnum++);
+        _failed++;
+    }
+    PRINT_DESC(" - ", format);
+    putchar('\n');
+    return success;
+}
+
+
+/*
+ * Takes two unsigned longs and requires they match.  On failure, reports them
+ * in hex.
+ */
+int
+is_hex(unsigned long left, unsigned long right, const char *format, ...)
+{
+    int success;
+
+    fflush(stderr);
+    check_diag_files();
+    success = (left == right);
+    if (success)
+        printf("ok %lu", testnum++);
+    else {
+        diag(" left: %lx", (unsigned long) left);
+        diag("right: %lx", (unsigned long) right);
+        printf("not ok %lu", testnum++);
+        _failed++;
+    }
+    PRINT_DESC(" - ", format);
+    putchar('\n');
+    return success;
+}
+
+
+/*
+ * Takes pointers to a regions of memory and requires that len bytes from each
+ * match.  Otherwise reports any bytes which didn't match.
+ */
+int
+is_blob(const void *left, const void *right, size_t len, const char *format,
+        ...)
+{
+    int success;
+    size_t i;
+
+    fflush(stderr);
+    check_diag_files();
+    success = (memcmp(left, right, len) == 0);
+    if (success)
+        printf("ok %lu", testnum++);
+    else {
+        const unsigned char *left_c = (const unsigned char *) left;
+        const unsigned char *right_c = (const unsigned char *) right;
+
+        for (i = 0; i < len; i++) {
+            if (left_c[i] != right_c[i])
+                diag("offset %lu: left %02x, right %02x", (unsigned long) i,
+                     left_c[i], right_c[i]);
+        }
+        printf("not ok %lu", testnum++);
+        _failed++;
+    }
+    PRINT_DESC(" - ", format);
+    putchar('\n');
+    return success;
+}
+
+
+/*
+ * Bail out with an error.
+ */
+void
+bail(const char *format, ...)
+{
+    va_list args;
+
+    _aborted = 1;
+    fflush(stderr);
+    check_diag_files();
+    fflush(stdout);
+    printf("Bail out! ");
+    va_start(args, format);
+    vprintf(format, args);
+    va_end(args);
+    printf("\n");
+    exit(255);
+}
+
+
+/*
+ * Bail out with an error, appending strerror(errno).
+ */
+void
+sysbail(const char *format, ...)
+{
+    va_list args;
+    int oerrno = errno;
+
+    _aborted = 1;
+    fflush(stderr);
+    check_diag_files();
+    fflush(stdout);
+    printf("Bail out! ");
+    va_start(args, format);
+    vprintf(format, args);
+    va_end(args);
+    printf(": %s\n", strerror(oerrno));
+    exit(255);
+}
+
+
+/*
+ * Report a diagnostic to stderr.  Always returns 1 to allow embedding in
+ * compound statements.
+ */
+int
+diag(const char *format, ...)
+{
+    va_list args;
+
+    fflush(stderr);
+    check_diag_files();
+    fflush(stdout);
+    printf("# ");
+    va_start(args, format);
+    vprintf(format, args);
+    va_end(args);
+    printf("\n");
+    return 1;
+}
+
+
+/*
+ * Report a diagnostic to stderr, appending strerror(errno).  Always returns 1
+ * to allow embedding in compound statements.
+ */
+int
+sysdiag(const char *format, ...)
+{
+    va_list args;
+    int oerrno = errno;
+
+    fflush(stderr);
+    check_diag_files();
+    fflush(stdout);
+    printf("# ");
+    va_start(args, format);
+    vprintf(format, args);
+    va_end(args);
+    printf(": %s\n", strerror(oerrno));
+    return 1;
+}
+
+
+/*
+ * Register a new file for diag_file processing.
+ */
+void
+diag_file_add(const char *name)
+{
+    struct diag_file *file, *prev;
+
+    file = bcalloc_type(1, struct diag_file);
+    file->name = bstrdup(name);
+    file->file = fopen(file->name, "r");
+    if (file->file == NULL)
+        sysbail("cannot open %s", name);
+    file->buffer = bcalloc_type(BUFSIZ, char);
+    file->bufsize = BUFSIZ;
+    if (diag_files == NULL)
+        diag_files = file;
+    else {
+        for (prev = diag_files; prev->next != NULL; prev = prev->next)
+            ;
+        prev->next = file;
+    }
+}
+
+
+/*
+ * Remove a file from diag_file processing.  If the file is not found, do
+ * nothing, since there are some situations where it can be removed twice
+ * (such as if it's removed from a cleanup function, since cleanup functions
+ * are called after freeing all the diag_files).
+ */
+void
+diag_file_remove(const char *name)
+{
+    struct diag_file *file;
+    struct diag_file **prev = &diag_files;
+
+    for (file = diag_files; file != NULL; file = file->next) {
+        if (strcmp(file->name, name) == 0) {
+            *prev = file->next;
+            fclose(file->file);
+            free(file->name);
+            free(file->buffer);
+            free(file);
+            return;
+        }
+        prev = &file->next;
+    }
+}
+
+
+/*
+ * Allocate cleared memory, reporting a fatal error with bail on failure.
+ */
+void *
+bcalloc(size_t n, size_t size)
+{
+    void *p;
+
+    p = calloc(n, size);
+    if (p == NULL)
+        sysbail("failed to calloc %lu", (unsigned long) (n * size));
+    return p;
+}
+
+
+/*
+ * Allocate memory, reporting a fatal error with bail on failure.
+ */
+void *
+bmalloc(size_t size)
+{
+    void *p;
+
+    p = malloc(size);
+    if (p == NULL)
+        sysbail("failed to malloc %lu", (unsigned long) size);
+    return p;
+}
+
+
+/*
+ * Reallocate memory, reporting a fatal error with bail on failure.
+ */
+void *
+brealloc(void *p, size_t size)
+{
+    p = realloc(p, size);
+    if (p == NULL)
+        sysbail("failed to realloc %lu bytes", (unsigned long) size);
+    return p;
+}
+
+
+/*
+ * The same as brealloc, but determine the size by multiplying an element
+ * count by a size, similar to calloc.  The multiplication is checked for
+ * integer overflow.
+ *
+ * We should technically use SIZE_MAX here for the overflow check, but
+ * SIZE_MAX is C99 and we're only assuming C89 + SUSv3, which does not
+ * guarantee that it exists.  They do guarantee that UINT_MAX exists, and we
+ * can assume that UINT_MAX <= SIZE_MAX.
+ *
+ * (In theory, C89 and C99 permit size_t to be smaller than unsigned int, but
+ * I disbelieve in the existence of such systems and they will have to cope
+ * without overflow checks.)
+ */
+void *
+breallocarray(void *p, size_t n, size_t size)
+{
+    if (n > 0 && UINT_MAX / n <= size)
+        bail("reallocarray too large");
+    if (n == 0)
+        n = 1;
+    p = realloc(p, n * size);
+    if (p == NULL)
+        sysbail("failed to realloc %lu bytes", (unsigned long) (n * size));
+    return p;
+}
+
+
+/*
+ * Copy a string, reporting a fatal error with bail on failure.
+ */
+char *
+bstrdup(const char *s)
+{
+    char *p;
+    size_t len;
+
+    len = strlen(s) + 1;
+    p = (char *) malloc(len);
+    if (p == NULL)
+        sysbail("failed to strdup %lu bytes", (unsigned long) len);
+    memcpy(p, s, len);
+    return p;
+}
+
+
+/*
+ * Copy up to n characters of a string, reporting a fatal error with bail on
+ * failure.  Don't use the system strndup function, since it may not exist and
+ * the TAP library doesn't assume any portability support.
+ */
+char *
+bstrndup(const char *s, size_t n)
+{
+    const char *p;
+    char *copy;
+    size_t length;
+
+    /* Don't assume that the source string is nul-terminated. */
+    for (p = s; (size_t) (p - s) < n && *p != '\0'; p++)
+        ;
+    length = (size_t) (p - s);
+    copy = (char *) malloc(length + 1);
+    if (copy == NULL)
+        sysbail("failed to strndup %lu bytes", (unsigned long) length);
+    memcpy(copy, s, length);
+    copy[length] = '\0';
+    return copy;
+}
+
+
+/*
+ * Locate a test file.  Given the partial path to a file, look under
+ * C_TAP_BUILD and then C_TAP_SOURCE for the file and return the full path to
+ * the file.  Returns NULL if the file doesn't exist.  A non-NULL return
+ * should be freed with test_file_path_free().
+ */
+char *
+test_file_path(const char *file)
+{
+    char *base;
+    char *path = NULL;
+    const char *envs[] = {"C_TAP_BUILD", "C_TAP_SOURCE", NULL};
+    int i;
+
+    for (i = 0; envs[i] != NULL; i++) {
+        base = getenv(envs[i]);
+        if (base == NULL)
+            continue;
+        path = concat(base, "/", file, (const char *) 0);
+        if (access(path, R_OK) == 0)
+            break;
+        free(path);
+        path = NULL;
+    }
+    return path;
+}
+
+
+/*
+ * Free a path returned from test_file_path().  This function exists primarily
+ * for Windows, where memory must be freed from the same library domain that
+ * it was allocated from.
+ */
+void
+test_file_path_free(char *path)
+{
+    free(path);
+}
+
+
+/*
+ * Create a temporary directory, tmp, under C_TAP_BUILD if set and the current
+ * directory if it does not.  Returns the path to the temporary directory in
+ * newly allocated memory, and calls bail on any failure.  The return value
+ * should be freed with test_tmpdir_free.
+ *
+ * This function uses sprintf because it attempts to be independent of all
+ * other portability layers.  The use immediately after a memory allocation
+ * should be safe without using snprintf or strlcpy/strlcat.
+ */
+char *
+test_tmpdir(void)
+{
+    const char *build;
+    char *path = NULL;
+
+    build = getenv("C_TAP_BUILD");
+    if (build == NULL)
+        build = ".";
+    path = concat(build, "/tmp", (const char *) 0);
+    if (access(path, X_OK) < 0)
+        if (mkdir(path, 0777) < 0)
+            sysbail("error creating temporary directory %s", path);
+    return path;
+}
+
+
+/*
+ * Free a path returned from test_tmpdir() and attempt to remove the
+ * directory.  If we can't delete the directory, don't worry; something else
+ * that hasn't yet cleaned up may still be using it.
+ */
+void
+test_tmpdir_free(char *path)
+{
+    if (path != NULL)
+        rmdir(path);
+    free(path);
+}
+
+static void
+register_cleanup(test_cleanup_func func,
+                 test_cleanup_func_with_data func_with_data, void *data)
+{
+    struct cleanup_func *cleanup, **last;
+
+    cleanup = bcalloc_type(1, struct cleanup_func);
+    cleanup->func = func;
+    cleanup->func_with_data = func_with_data;
+    cleanup->data = data;
+    cleanup->next = NULL;
+    last = &cleanup_funcs;
+    while (*last != NULL)
+        last = &(*last)->next;
+    *last = cleanup;
+}
+
+/*
+ * Register a cleanup function that is called when testing ends.  All such
+ * registered functions will be run by finish.
+ */
+void
+test_cleanup_register(test_cleanup_func func)
+{
+    register_cleanup(func, NULL, NULL);
+}
+
+/*
+ * Same as above, but also allows an opaque pointer to be passed to the cleanup
+ * function.
+ */
+void
+test_cleanup_register_with_data(test_cleanup_func_with_data func, void *data)
+{
+    register_cleanup(NULL, func, data);
+}
diff --git a/t/tap/basic.h b/t/tap/basic.h
new file mode 100644
index 0000000000..afea8cb210
--- /dev/null
+++ b/t/tap/basic.h
@@ -0,0 +1,198 @@
+/*
+ * Basic utility routines for the TAP protocol.
+ *
+ * This file is part of C TAP Harness.  The current version plus supporting
+ * documentation is at <https://www.eyrie.org/~eagle/software/c-tap-harness/>.
+ *
+ * Written by Russ Allbery <eagle@eyrie.org>
+ * Copyright 2009-2019, 2022 Russ Allbery <eagle@eyrie.org>
+ * Copyright 2001-2002, 2004-2008, 2011-2012, 2014
+ *     The Board of Trustees of the Leland Stanford Junior University
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef TAP_BASIC_H
+#define TAP_BASIC_H 1
+
+#include <stdarg.h> /* va_list */
+#include <stddef.h> /* size_t */
+#include <stdlib.h> /* free */
+#include <tap/macros.h>
+
+/*
+ * Used for iterating through arrays.  ARRAY_SIZE returns the number of
+ * elements in the array (useful for a < upper bound in a for loop) and
+ * ARRAY_END returns a pointer to the element past the end (ISO C99 makes it
+ * legal to refer to such a pointer as long as it's never dereferenced).
+ */
+// #define ARRAY_SIZE(array) (sizeof(array) / sizeof((array)[0]))
+// #define ARRAY_END(array)  (&(array)[ARRAY_SIZE(array)])
+
+BEGIN_DECLS
+
+/*
+ * The test count.  Always contains the number that will be used for the next
+ * test status.
+ */
+extern unsigned long testnum;
+
+/* Print out the number of tests and set standard output to line buffered. */
+void plan(unsigned long count);
+
+/*
+ * Prepare for lazy planning, in which the plan will be printed automatically
+ * at the end of the test program.
+ */
+void plan_lazy(void);
+
+/* Skip the entire test suite.  Call instead of plan. */
+void skip_all(const char *format, ...)
+    __attribute__((__noreturn__, __format__(printf, 1, 2)));
+
+/*
+ * Basic reporting functions.  The okv() function is the same as ok() but
+ * takes the test description as a va_list to make it easier to reuse the
+ * reporting infrastructure when writing new tests.  ok() and okv() return the
+ * value of the success argument.
+ */
+int ok(int success, const char *format, ...)
+    __attribute__((__format__(printf, 2, 3)));
+int okv(int success, const char *format, va_list args)
+    __attribute__((__format__(printf, 2, 0)));
+void skip(const char *reason, ...) __attribute__((__format__(printf, 1, 2)));
+
+/*
+ * Report the same status on, or skip, the next count tests.  ok_block()
+ * returns the value of the success argument.
+ */
+int ok_block(unsigned long count, int success, const char *format, ...)
+    __attribute__((__format__(printf, 3, 4)));
+void skip_block(unsigned long count, const char *reason, ...)
+    __attribute__((__format__(printf, 2, 3)));
+
+/*
+ * Compare two values.  Returns true if the test passes and false if it fails.
+ * is_bool takes an int since the bool type isn't fully portable yet, but
+ * interprets both arguments for their truth value, not for their numeric
+ * value.
+ */
+int is_bool(int, int, const char *format, ...)
+    __attribute__((__format__(printf, 3, 4)));
+int is_int(long, long, const char *format, ...)
+    __attribute__((__format__(printf, 3, 4)));
+int is_string(const char *, const char *, const char *format, ...)
+    __attribute__((__format__(printf, 3, 4)));
+int is_hex(unsigned long, unsigned long, const char *format, ...)
+    __attribute__((__format__(printf, 3, 4)));
+int is_blob(const void *, const void *, size_t, const char *format, ...)
+    __attribute__((__format__(printf, 4, 5)));
+
+/* Bail out with an error.  sysbail appends strerror(errno). */
+void bail(const char *format, ...)
+    __attribute__((__noreturn__, __nonnull__, __format__(printf, 1, 2)));
+void sysbail(const char *format, ...)
+    __attribute__((__noreturn__, __nonnull__, __format__(printf, 1, 2)));
+
+/* Report a diagnostic to stderr prefixed with #. */
+int diag(const char *format, ...)
+    __attribute__((__nonnull__, __format__(printf, 1, 2)));
+int sysdiag(const char *format, ...)
+    __attribute__((__nonnull__, __format__(printf, 1, 2)));
+
+/*
+ * Register or unregister a file that contains supplementary diagnostics.
+ * Before any other output, all registered files will be read, line by line,
+ * and each line will be reported as a diagnostic as if it were passed to
+ * diag().  Nul characters are not supported in these files and will result in
+ * truncated output.
+ */
+void diag_file_add(const char *file) __attribute__((__nonnull__));
+void diag_file_remove(const char *file) __attribute__((__nonnull__));
+
+/* Allocate memory, reporting a fatal error with bail on failure. */
+void *bcalloc(size_t, size_t)
+    __attribute__((__alloc_size__(1, 2), __malloc__(free),
+                   __warn_unused_result__));
+void *bmalloc(size_t) __attribute__((__alloc_size__(1), __malloc__(free),
+                                     __warn_unused_result__));
+void *breallocarray(void *, size_t, size_t)
+    __attribute__((__alloc_size__(2, 3), __malloc__(free),
+                   __warn_unused_result__));
+void *brealloc(void *, size_t)
+    __attribute__((__alloc_size__(2), __malloc__(free),
+                   __warn_unused_result__));
+char *bstrdup(const char *)
+    __attribute__((__malloc__(free), __nonnull__, __warn_unused_result__));
+char *bstrndup(const char *, size_t)
+    __attribute__((__malloc__(free), __nonnull__, __warn_unused_result__));
+
+/*
+ * Macros that cast the return value from b* memory functions, making them
+ * usable in C++ code and providing some additional type safety.
+ */
+#define bcalloc_type(n, type) ((type *) bcalloc((n), sizeof(type)))
+#define breallocarray_type(p, n, type) \
+    ((type *) breallocarray((p), (n), sizeof(type)))
+
+/*
+ * Find a test file under C_TAP_BUILD or C_TAP_SOURCE, returning the full
+ * path.  The returned path should be freed with test_file_path_free().
+ */
+void test_file_path_free(char *path);
+char *test_file_path(const char *file)
+    __attribute__((__malloc__(test_file_path_free), __nonnull__,
+                   __warn_unused_result__));
+
+/*
+ * Create a temporary directory relative to C_TAP_BUILD and return the path.
+ * The returned path should be freed with test_tmpdir_free().
+ */
+void test_tmpdir_free(char *path);
+char *test_tmpdir(void)
+    __attribute__((__malloc__(test_tmpdir_free), __warn_unused_result__));
+
+/*
+ * Register a cleanup function that is called when testing ends.  All such
+ * registered functions will be run during atexit handling (and are therefore
+ * subject to all the same constraints and caveats as atexit functions).
+ *
+ * The function must return void and will be passed two arguments: an int that
+ * will be true if the test completed successfully and false otherwise, and an
+ * int that will be true if the cleanup function is run in the primary process
+ * (the one that called plan or plan_lazy) and false otherwise.  If
+ * test_cleanup_register_with_data is used instead, a generic pointer can be
+ * provided and will be passed to the cleanup function as a third argument.
+ *
+ * test_cleanup_register_with_data is the better API and should have been the
+ * only API.  test_cleanup_register was an API error preserved for backward
+ * cmpatibility.
+ */
+typedef void (*test_cleanup_func)(int, int);
+typedef void (*test_cleanup_func_with_data)(int, int, void *);
+
+void test_cleanup_register(test_cleanup_func) __attribute__((__nonnull__));
+void test_cleanup_register_with_data(test_cleanup_func_with_data, void *)
+    __attribute__((__nonnull__));
+
+END_DECLS
+
+#endif /* TAP_BASIC_H */
diff --git a/t/tap/macros.h b/t/tap/macros.h
new file mode 100644
index 0000000000..0eabcb5847
--- /dev/null
+++ b/t/tap/macros.h
@@ -0,0 +1,109 @@
+/*
+ * Helpful macros for TAP header files.
+ *
+ * This is not, strictly speaking, related to TAP, but any TAP add-on is
+ * probably going to need these macros, so define them in one place so that
+ * everyone can pull them in.
+ *
+ * This file is part of C TAP Harness.  The current version plus supporting
+ * documentation is at <https://www.eyrie.org/~eagle/software/c-tap-harness/>.
+ *
+ * Copyright 2008, 2012-2013, 2015, 2022 Russ Allbery <eagle@eyrie.org>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef TAP_MACROS_H
+#define TAP_MACROS_H 1
+
+/*
+ * __attribute__ is available in gcc 2.5 and later, but only with gcc 2.7
+ * could you use the __format__ form of the attributes, which is what we use
+ * (to avoid confusion with other macros), and only with gcc 2.96 can you use
+ * the attribute __malloc__.  2.96 is very old, so don't bother trying to get
+ * the other attributes to work with GCC versions between 2.7 and 2.96.
+ */
+#ifndef __attribute__
+#    if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 96)
+#        define __attribute__(spec) /* empty */
+#    endif
+#endif
+
+/*
+ * We use __alloc_size__, but it was only available in fairly recent versions
+ * of GCC.  Suppress warnings about the unknown attribute if GCC is too old.
+ * We know that we're GCC at this point, so we can use the GCC variadic macro
+ * extension, which will still work with versions of GCC too old to have C99
+ * variadic macro support.
+ */
+#if !defined(__attribute__) && !defined(__alloc_size__)
+#    if defined(__GNUC__) && !defined(__clang__)
+#        if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 3)
+#            define __alloc_size__(spec, args...) /* empty */
+#        endif
+#    endif
+#endif
+
+/* Suppress __warn_unused_result__ if gcc is too old. */
+#if !defined(__attribute__) && !defined(__warn_unused_result__)
+#    if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 4)
+#        define __warn_unused_result__ /* empty */
+#    endif
+#endif
+
+/*
+ * Suppress the argument to __malloc__ in Clang (not supported in at least
+ * version 13) and GCC versions prior to 11.
+ */
+#if !defined(__attribute__) && !defined(__malloc__)
+#    if defined(__clang__) || __GNUC__ < 11
+#        define __malloc__(dalloc) __malloc__
+#    endif
+#endif
+
+/*
+ * LLVM and Clang pretend to be GCC but don't support all of the __attribute__
+ * settings that GCC does.  For them, suppress warnings about unknown
+ * attributes on declarations.  This unfortunately will affect the entire
+ * compilation context, but there's no push and pop available.
+ */
+#if !defined(__attribute__) && (defined(__llvm__) || defined(__clang__))
+#    pragma GCC diagnostic ignored "-Wattributes"
+#endif
+
+/* Used for unused parameters to silence gcc warnings. */
+// #define UNUSED __attribute__((__unused__))
+
+/*
+ * BEGIN_DECLS is used at the beginning of declarations so that C++
+ * compilers don't mangle their names.  END_DECLS is used at the end.
+ */
+#undef BEGIN_DECLS
+#undef END_DECLS
+#ifdef __cplusplus
+#    define BEGIN_DECLS extern "C" {
+#    define END_DECLS   }
+#else
+#    define BEGIN_DECLS /* empty */
+#    define END_DECLS   /* empty */
+#endif
+
+#endif /* TAP_MACROS_H */

-- 
2.40.1.606.ga4b1b128d6-goog

