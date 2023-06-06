Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B096FC7EE29
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 17:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbjFFRKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 13:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjFFRKH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 13:10:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA618E
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 10:10:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb2a7308f21so5081457276.2
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 10:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686071405; x=1688663405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vbSktGsfNNW4YeZwoXzLPrrfGc2uWPNTwBuyRE8SYgI=;
        b=72O1IMP3qeQW1JJMqB+pExmF/Y/pcdrksRBrUnAvA+RiiLZvt0GGOpbIPCcB/l+0U4
         h1Df8hXqq1e171N3Y6dLxS/T+Mone1rSkSFMrbfTXcGgKqH1vZvYj58YHw3Afq5ro53N
         M+Bth3DjRFAegmVx1s042Eq2aZNf5B07DccZ6HRdGuaE7770FPo8nSlM+cAN4wFHjXgF
         MyqdR6Teq0192g6PbZC2CwuzqmhTYnmzY9NpKeZ1fbJ+cPdjyk7ujpOO464z0l/z7dT0
         p61TQHqHQKe7XiSTVuuuIHIRlWs6OB5zSipTh6luqHxHldDQgY06naPKw902ysSo3XBD
         nJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686071405; x=1688663405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbSktGsfNNW4YeZwoXzLPrrfGc2uWPNTwBuyRE8SYgI=;
        b=SzL7/RxPonyumK91ZkCh5rTYfExFMzUtPQDarLM5Fjp8MAu4XzmwCZxswfYY6ISt4g
         F3hAIkx1cdLnD0jqkko2uWO0Ozoq/jsQ9+95xsGnpQoaMTw8KQxbWsixdsgWR7E1RJar
         U+1wlqZxVT96JhVCdnbi4lG56uo0yVALuEp9KNTBNZmbInERC1R69o/Stp4qZLXpQkar
         gAGPbDZGaj+faAgkbDKleOxX2cajiKygNISefiFIdVzcBxBmuxeo8dsVoiaEqln1hUGD
         +OE8MR1c9ls5r+Y4cZ/nXAQZTXL825fINsdvz4JW2Po4DcuNQ11eWx84hTcukIGH3UDt
         Zk7g==
X-Gm-Message-State: AC+VfDyC5kYDoif6zGmDTzvJ7KPTakV445Kv6hJNvwX04jcymXfkO5Vn
        zVfrqwlccWyqow+h/n1tfniVPLIJprqhlkCV+ZAXbeTZeJQAlTBUoow6y+ISGopp35wNW1obhcn
        /699itQIwr/V7XtrDtp9iTA/mtfGW8+X+WUeJISW23iRQRLkwJ/vpBTrDg4HhLD8ZHg==
X-Google-Smtp-Source: ACHHUZ5KuOd7SQh1Q4Z2WxJ+KwH+Sf+jY8TBsLJt/DmMGVJAc+N3THeYSptvc+b7Kyf8A7Fh7/Y+zzl3VRlf1qE=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6902:100b:b0:bad:600:1833 with SMTP
 id w11-20020a056902100b00b00bad06001833mr1487649ybt.0.1686071405520; Tue, 06
 Jun 2023 10:10:05 -0700 (PDT)
Date:   Tue,  6 Jun 2023 17:09:55 +0000
In-Reply-To: <20230606170711.912972-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606170711.912972-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230606171002.914075-1-calvinwan@google.com>
Subject: [PATCH v3 1/8] git-compat-util: move strbuf.c funcs to its header
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While functions like starts_with() probably should not belong in the
boundaries of the strbuf library, this commit focuses on first splitting
out headers from git-compat-util.h.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 builtin/symbolic-ref.c   |  1 +
 builtin/unpack-objects.c |  1 +
 git-compat-util.h        | 32 --------------------------------
 strbuf.h                 | 32 ++++++++++++++++++++++++++++++++
 versioncmp.c             |  1 +
 5 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index a61fa3c0f8..c9defe4d2e 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "strbuf.h"
 
 static const char * const git_symbolic_ref_usage[] = {
 	N_("git symbolic-ref [-m <reason>] <name> <ref>"),
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index b4b46ae729..0510e60e6e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -12,6 +12,7 @@
 #include "blob.h"
 #include "commit.h"
 #include "replace-object.h"
+#include "strbuf.h"
 #include "tag.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/git-compat-util.h b/git-compat-util.h
index 1889da7986..fe9e86bad0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -677,9 +677,6 @@ void set_warn_routine(report_fn routine);
 report_fn get_warn_routine(void);
 void set_die_is_recursing_routine(int (*routine)(void));
 
-int starts_with(const char *str, const char *prefix);
-int istarts_with(const char *str, const char *prefix);
-
 /*
  * If the string "str" begins with the string found in "prefix", return 1.
  * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the point in
@@ -708,29 +705,6 @@ static inline int skip_prefix(const char *str, const char *prefix,
 	return 0;
 }
 
-/*
- * If the string "str" is the same as the string in "prefix", then the "arg"
- * parameter is set to the "def" parameter and 1 is returned.
- * If the string "str" begins with the string found in "prefix" and then a
- * "=" sign, then the "arg" parameter is set to "str + strlen(prefix) + 1"
- * (i.e., to the point in the string right after the prefix and the "=" sign),
- * and 1 is returned.
- *
- * Otherwise, return 0 and leave "arg" untouched.
- *
- * When we accept both a "--key" and a "--key=<val>" option, this function
- * can be used instead of !strcmp(arg, "--key") and then
- * skip_prefix(arg, "--key=", &arg) to parse such an option.
- */
-int skip_to_optional_arg_default(const char *str, const char *prefix,
-				 const char **arg, const char *def);
-
-static inline int skip_to_optional_arg(const char *str, const char *prefix,
-				       const char **arg)
-{
-	return skip_to_optional_arg_default(str, prefix, arg, "");
-}
-
 /*
  * Like skip_prefix, but promises never to read past "len" bytes of the input
  * buffer, and returns the remaining number of bytes in "out" via "outlen".
@@ -775,12 +749,6 @@ static inline int strip_suffix(const char *str, const char *suffix, size_t *len)
 	return strip_suffix_mem(str, len, suffix);
 }
 
-static inline int ends_with(const char *str, const char *suffix)
-{
-	size_t len;
-	return strip_suffix(str, suffix, &len);
-}
-
 #define SWAP(a, b) do {						\
 	void *_swap_a_ptr = &(a);				\
 	void *_swap_b_ptr = &(b);				\
diff --git a/strbuf.h b/strbuf.h
index 8903195416..28b3038e83 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -698,4 +698,36 @@ char *xstrvfmt(const char *fmt, va_list ap);
 __attribute__((format (printf, 1, 2)))
 char *xstrfmt(const char *fmt, ...);
 
+int starts_with(const char *str, const char *prefix);
+int istarts_with(const char *str, const char *prefix);
+
+/*
+ * If the string "str" is the same as the string in "prefix", then the "arg"
+ * parameter is set to the "def" parameter and 1 is returned.
+ * If the string "str" begins with the string found in "prefix" and then a
+ * "=" sign, then the "arg" parameter is set to "str + strlen(prefix) + 1"
+ * (i.e., to the point in the string right after the prefix and the "=" sign),
+ * and 1 is returned.
+ *
+ * Otherwise, return 0 and leave "arg" untouched.
+ *
+ * When we accept both a "--key" and a "--key=<val>" option, this function
+ * can be used instead of !strcmp(arg, "--key") and then
+ * skip_prefix(arg, "--key=", &arg) to parse such an option.
+ */
+int skip_to_optional_arg_default(const char *str, const char *prefix,
+				 const char **arg, const char *def);
+
+static inline int skip_to_optional_arg(const char *str, const char *prefix,
+				       const char **arg)
+{
+	return skip_to_optional_arg_default(str, prefix, arg, "");
+}
+
+static inline int ends_with(const char *str, const char *suffix)
+{
+	size_t len;
+	return strip_suffix(str, suffix, &len);
+}
+
 #endif /* STRBUF_H */
diff --git a/versioncmp.c b/versioncmp.c
index 74cc7c43f0..45e676cbca 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
+#include "strbuf.h"
 #include "string-list.h"
 #include "versioncmp.h"
 
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

