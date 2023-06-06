Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449FDC7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 17:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbjFFRKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 13:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbjFFRKW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 13:10:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10A3170C
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 10:10:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b37d9d2so8668686276.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 10:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686071414; x=1688663414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C79XVMVTZWBnTLPrgNeM1GcFPEM1uSWbgrhNAMDc8cE=;
        b=vH3HIQEDuNwcuEztZpl3x5PntptHqKRWFyY6uHMZ2SgWceOcGr+Kv87v+4U1YXmcbE
         dPGvSrqxDaj6QP2P/WJwqvzVoQz5AnFrs0uZI3FPYNc8ewIAK7j0iO4TkflY6md3aBFA
         Xcai0Te47fPzTe1kid04/fvbxNTLumrMuXUepUxtjorbyk+hRl3MGnd0VXA1the3TQBU
         YOYAtVvfYqRKMtSnkxmwI/5M0PcCpdEEVwUI6HRGH8zEEosm5IlKdEj4SIryi1RD1NWL
         OZAPxFbTJPm1fmVYy1oi2yrJJ/rpOvswW2sBykVV+JoIRRl5ZEBx7LxIA9U6oqxKgS3A
         OQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686071414; x=1688663414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C79XVMVTZWBnTLPrgNeM1GcFPEM1uSWbgrhNAMDc8cE=;
        b=iwEY4gCq0EGQDO5w9/LtyN397XrB5jH3h5tYvENt7hVjD3bXCamx3nQ2iS94bGtuz5
         M9AlxzTU0jbkzBZPxShwLJU8rf22pTtcBO2PpAQe5oVVnH2dVcFCR6yc6aLPNaYK15Lu
         scaZIt59Xhhzup4VdJNi15v6uihVUyrjF40NjXFddB4pU08HL1FafAbTUR5qlUq8lTfB
         1NQ5/yAXd12/xIIIGXPv3RPcrbyeE17BXRIqoew4AE1th9uuBfNOqEtcFoGSYh7wgAby
         mwA9STOns80Er1qkz14SKa61HYCy99q/d/5PayfZH1JZFXSA1DV3dUWF8WXLEHmgP++O
         JgbQ==
X-Gm-Message-State: AC+VfDxk+TVftd33Lx26Yw7Hc+lvnyEf+TKXJx/P0gVSrrDsFCA1/MOM
        OvKBJp3JUxuVXOf2f5HywVORl615X6+lPLtInBoTR/fWt1b7v6fzNB3UumF7Tn8D0r+A0Vx3fSa
        61jFqyDJppHX/EVyn3StOYQAY4mf2o2mgIZGkA812L3Q6G9HCEj2UY1CR+b8x9IF/1g==
X-Google-Smtp-Source: ACHHUZ5jFmOoclx7rCH7NQUgv8HgRcrH7FDVYKmt2+1zb+0F+ZUJX1Ei8bCnZ3S6hB2ozt1Czmf7hBDUZPLOcKA=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:4c8:0:b0:bac:2448:2aa3 with SMTP id
 191-20020a2504c8000000b00bac24482aa3mr920141ybe.9.1686071413944; Tue, 06 Jun
 2023 10:10:13 -0700 (PDT)
Date:   Tue,  6 Jun 2023 17:10:00 +0000
In-Reply-To: <20230606170711.912972-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606170711.912972-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230606171002.914075-6-calvinwan@google.com>
Subject: [PATCH v3 6/8] git-compat-util: move usage.c funcs to its header
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 common.h          |  1 +
 git-compat-util.h | 55 -------------------------------------------
 usage.h           | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 55 deletions(-)
 create mode 100644 usage.h

diff --git a/common.h b/common.h
index 0f164c1071..e3b673847d 100644
--- a/common.h
+++ b/common.h
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "wrapper.h"
+#include "usage.h"
 
 /*
  * ARRAY_SIZE - get the number of elements in a visible array
diff --git a/git-compat-util.h b/git-compat-util.h
index f73c8727d1..481dac22b0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -572,20 +572,6 @@ static inline int git_has_dir_sep(const char *path)
 
 #include "compat/bswap.h"
 
-#include "wrapper.h"
-
-/* General helper functions */
-NORETURN void usage(const char *err);
-NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
-NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
-NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-int die_message(const char *err, ...) __attribute__((format (printf, 1, 2)));
-int die_message_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
-int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
-void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
 #include "compat/apple-common-crypto.h"
@@ -600,30 +586,6 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 #include <openssl/rand.h>
 #endif
 
-/*
- * Let callers be aware of the constant return value; this can help
- * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
- * because other compilers may be confused by this.
- */
-#if defined(__GNUC__)
-static inline int const_error(void)
-{
-	return -1;
-}
-#define error(...) (error(__VA_ARGS__), const_error())
-#define error_errno(...) (error_errno(__VA_ARGS__), const_error())
-#endif
-
-typedef void (*report_fn)(const char *, va_list params);
-
-void set_die_routine(NORETURN_PTR report_fn routine);
-report_fn get_die_message_routine(void);
-void set_error_routine(report_fn routine);
-report_fn get_error_routine(void);
-void set_warn_routine(report_fn routine);
-report_fn get_warn_routine(void);
-void set_die_is_recursing_routine(int (*routine)(void));
-
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
 
 #ifndef PROT_READ
@@ -942,23 +904,6 @@ int git_regcomp(regex_t *preg, const char *pattern, int cflags);
 #endif
 #endif
 
-/* usage.c: only to be used for testing BUG() implementation (see test-tool) */
-extern int BUG_exit_code;
-
-/* usage.c: if bug() is called we should have a BUG_if_bug() afterwards */
-extern int bug_called_must_BUG;
-
-__attribute__((format (printf, 3, 4))) NORETURN
-void BUG_fl(const char *file, int line, const char *fmt, ...);
-#define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
-__attribute__((format (printf, 3, 4)))
-void bug_fl(const char *file, int line, const char *fmt, ...);
-#define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
-#define BUG_if_bug(...) do { \
-	if (bug_called_must_BUG) \
-		BUG_fl(__FILE__, __LINE__, __VA_ARGS__); \
-} while (0)
-
 #ifndef FSYNC_METHOD_DEFAULT
 #ifdef __APPLE__
 #define FSYNC_METHOD_DEFAULT FSYNC_METHOD_WRITEOUT_ONLY
diff --git a/usage.h b/usage.h
new file mode 100644
index 0000000000..770076e684
--- /dev/null
+++ b/usage.h
@@ -0,0 +1,60 @@
+#ifndef USAGE_H
+#define USAGE_H
+
+#include "git-compat-util.h"
+
+/* General helper functions */
+NORETURN void usage(const char *err);
+NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
+NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
+NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int die_message(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int die_message_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+
+void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
+void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+
+/*
+ * Let callers be aware of the constant return value; this can help
+ * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
+ * because other compilers may be confused by this.
+ */
+#if defined(__GNUC__)
+static inline int const_error(void)
+{
+	return -1;
+}
+#define error(...) (error(__VA_ARGS__), const_error())
+#define error_errno(...) (error_errno(__VA_ARGS__), const_error())
+#endif
+
+typedef void (*report_fn)(const char *, va_list params);
+
+void set_die_routine(NORETURN_PTR report_fn routine);
+report_fn get_die_message_routine(void);
+void set_error_routine(report_fn routine);
+report_fn get_error_routine(void);
+void set_warn_routine(report_fn routine);
+report_fn get_warn_routine(void);
+void set_die_is_recursing_routine(int (*routine)(void));
+
+/* usage.c: only to be used for testing BUG() implementation (see test-tool) */
+extern int BUG_exit_code;
+
+/* usage.c: if bug() is called we should have a BUG_if_bug() afterwards */
+extern int bug_called_must_BUG;
+
+__attribute__((format (printf, 3, 4))) NORETURN
+void BUG_fl(const char *file, int line, const char *fmt, ...);
+#define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
+__attribute__((format (printf, 3, 4)))
+void bug_fl(const char *file, int line, const char *fmt, ...);
+#define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define BUG_if_bug(...) do { \
+	if (bug_called_must_BUG) \
+		BUG_fl(__FILE__, __LINE__, __VA_ARGS__); \
+} while (0)
+
+#endif /* USAGE_H */
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

