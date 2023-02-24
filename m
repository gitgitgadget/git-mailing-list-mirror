Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3A2C64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBXAKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBXAJx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:09:53 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413C61CAF7
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:48 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h14so3657425wru.4
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+s0sHRFvNx18kn/Si3oEhtnyEV23sFKqpYR+O4c4J4=;
        b=idv/60gIFnjh104ckxvxX9Vj4T7IAx+ddLcQBD+eiuiluVTOGZX9qK7vy+bQh/LTfY
         hPBjyssOonlm496xFPOxjmd0qQtmHMBIEvjhKAA3mVq4vyfuGRdtpcvRxt2DXjjjt8Df
         oj6leWxYnycxvOx2sqxa9fEOl2xXcTnFzVIK0X/BZs7b6tyfZA42+3WS578NGHaPF/ot
         s59XKiwq3DcisgSFbyIcor0nyi72CyyyDkFguZd6hLUjCo3REeZqvtKBhttd8c8OG30A
         TvB2+SBvAxuOUgQ+KjS/kabuGXPvmQNE6nZQJQgK5dttM38/EZNxCK6Ko2PtUqzQ+w6Q
         bCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+s0sHRFvNx18kn/Si3oEhtnyEV23sFKqpYR+O4c4J4=;
        b=jcRw9Eh0oYH2meTnjxbvkG1DD/aIBMddh9wBrgKQ6//9Z8Gs32K7rR37WbNR3+Btfm
         gFxT9INp3R/aubV1m1SY2zMb13kxEQgPtn1rwE6W7aB2n+bDF2xFBqbHiU7SMjix1O1W
         U9FyNyhG7VFkmRTBJYLP46Rqx/WBCI2Ha/lf0z07rBo0coQfg8Uo7dqLjvDEBO4xRVi6
         KtLdD3DMEmnMF4ezbUfVlpaM75NCWnNFSPYpA2bUpUFZP7khJ/Zlk8bO3TYvjTkA6dUq
         WKgz0dFeXUhLRuhFPQmZIXqDhS+u7vsbdr8Hhs6c2YQn2fhuOjQj0szSiEiGWxp/MhRn
         6W3A==
X-Gm-Message-State: AO0yUKXNdwfD4m7Wcpb4wDz+JTt7reG1mne1sNye+tuccJ+AJHRaLbnP
        eHhINhFayYjHqBRhSEFAu/T9gqYckaw=
X-Google-Smtp-Source: AK7set/C+QoSCOGc7ifECfQ4F8Ht6OMtNFQBX5OVyrA1oCPNnj+sz5u2yBuJsnjjPlLfE46sybr2AQ==
X-Received: by 2002:a05:6000:1f83:b0:2c3:f79a:7319 with SMTP id bw3-20020a0560001f8300b002c3f79a7319mr8899669wrb.17.1677197386338;
        Thu, 23 Feb 2023 16:09:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6-20020adff9c6000000b002c5493a17efsm8229225wrr.25.2023.02.23.16.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:45 -0800 (PST)
Message-Id: <6d5c13c4693f4436dc8fc69d7a3fad00cdb08c59.1677197377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:26 +0000
Subject: [PATCH v2 07/17] hex.h: move some hex-related declarations from
 cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

hex.c contains code for hex-related functions, but for some reason these
functions were declared in the catch-all cache.h.  Move the function
declarations into a hex.h header instead.

This also allows us to remove includes of cache.h from a few C files.
For now, we make cache.h include hex.h, so that it is easier to review
the direct changes being made by this patch.  In the next patch, we will
remove that, and add the necessary direct '#include "hex.h"' in the
hundreds of C files that need it.

Note that reviewing the header changes in this commit might be
simplified via
    git log --no-walk -p --color-moved $COMMIT -- '*.h'`
In particular, it highlights the simple movement of code in .h files
rather nicely.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h           | 79 +-------------------------------------------
 git-compat-util.h |  1 +
 hex.c             |  3 +-
 hex.h             | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 mailinfo.c        |  4 ++-
 oidset.c          |  4 ++-
 wildmatch.c       |  2 +-
 7 files changed, 95 insertions(+), 82 deletions(-)
 create mode 100644 hex.h

diff --git a/cache.h b/cache.h
index daf6150bb3c..d0619ce2e63 100644
--- a/cache.h
+++ b/cache.h
@@ -13,6 +13,7 @@
 #include "string-list.h"
 #include "pack-revindex.h"
 #include "hash.h"
+#include "hex.h"
 #include "path.h"
 #include "oid-array.h"
 #include "repository.h"
@@ -1325,22 +1326,6 @@ int finalize_object_file(const char *tmpfile, const char *filename);
 /* Helper to check and "touch" a file */
 int check_and_freshen_file(const char *fn, int freshen);
 
-extern const signed char hexval_table[256];
-static inline unsigned int hexval(unsigned char c)
-{
-	return hexval_table[c];
-}
-
-/*
- * Convert two consecutive hexadecimal digits into a char.  Return a
- * negative value on error.  Don't run over the end of short strings.
- */
-static inline int hex2chr(const char *s)
-{
-	unsigned int val = hexval(s[0]);
-	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
-}
-
 /* Convert to/from hex/sha1 representation */
 #define MINIMUM_ABBREV minimum_abbrev
 #define DEFAULT_ABBREV default_abbrev
@@ -1393,68 +1378,6 @@ int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_f
 
 int set_disambiguate_hint_config(const char *var, const char *value);
 
-/*
- * Try to read a SHA1 in hexadecimal format from the 40 characters
- * starting at hex.  Write the 20-byte result to sha1 in binary form.
- * Return 0 on success.  Reading stops if a NUL is encountered in the
- * input, so it is safe to pass this function an arbitrary
- * null-terminated string.
- */
-int get_sha1_hex(const char *hex, unsigned char *sha1);
-int get_oid_hex(const char *hex, struct object_id *sha1);
-
-/* Like get_oid_hex, but for an arbitrary hash algorithm. */
-int get_oid_hex_algop(const char *hex, struct object_id *oid, const struct git_hash_algo *algop);
-
-/*
- * Read `len` pairs of hexadecimal digits from `hex` and write the
- * values to `binary` as `len` bytes. Return 0 on success, or -1 if
- * the input does not consist of hex digits).
- */
-int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
-
-/*
- * Convert a binary hash in "unsigned char []" or an object name in
- * "struct object_id *" to its hex equivalent. The `_r` variant is reentrant,
- * and writes the NUL-terminated output to the buffer `out`, which must be at
- * least `GIT_MAX_HEXSZ + 1` bytes, and returns a pointer to out for
- * convenience.
- *
- * The non-`_r` variant returns a static buffer, but uses a ring of 4
- * buffers, making it safe to make multiple calls for a single statement, like:
- *
- *   printf("%s -> %s", hash_to_hex(one), hash_to_hex(two));
- *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
- */
-char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const struct git_hash_algo *);
-char *oid_to_hex_r(char *out, const struct object_id *oid);
-char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *);	/* static buffer result! */
-char *hash_to_hex(const unsigned char *hash);						/* same static buffer */
-char *oid_to_hex(const struct object_id *oid);						/* same static buffer */
-
-/*
- * Parse a 40-character hexadecimal object ID starting from hex, updating the
- * pointer specified by end when parsing stops.  The resulting object ID is
- * stored in oid.  Returns 0 on success.  Parsing will stop on the first NUL or
- * other invalid character.  end is only updated on success; otherwise, it is
- * unmodified.
- */
-int parse_oid_hex(const char *hex, struct object_id *oid, const char **end);
-
-/* Like parse_oid_hex, but for an arbitrary hash algorithm. */
-int parse_oid_hex_algop(const char *hex, struct object_id *oid, const char **end,
-			const struct git_hash_algo *algo);
-
-
-/*
- * These functions work like get_oid_hex and parse_oid_hex, but they will parse
- * a hex value for any algorithm. The algorithm is detected based on the length
- * and the algorithm in use is returned. If this is not a hex object ID in any
- * algorithm, returns GIT_HASH_UNKNOWN.
- */
-int get_oid_hex_any(const char *hex, struct object_id *oid);
-int parse_oid_hex_any(const char *hex, struct object_id *oid, const char **end);
-
 /*
  * This reads short-hand syntax that not only evaluates to a commit
  * object name, but also can act as if the end user spelled the name
diff --git a/git-compat-util.h b/git-compat-util.h
index 4f0028ce60c..f77f986fbf1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1225,6 +1225,7 @@ extern const unsigned char tolower_trans_tbl[256];
 #undef isxdigit
 
 extern const unsigned char sane_ctype[256];
+extern const signed char hexval_table[256];
 #define GIT_SPACE 0x01
 #define GIT_DIGIT 0x02
 #define GIT_ALPHA 0x04
diff --git a/hex.c b/hex.c
index 4f64d346963..0a1bddc1284 100644
--- a/hex.c
+++ b/hex.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "hex.h"
 
 const signed char hexval_table[256] = {
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
diff --git a/hex.h b/hex.h
new file mode 100644
index 00000000000..e2abfc56fae
--- /dev/null
+++ b/hex.h
@@ -0,0 +1,84 @@
+#ifndef HEX_H
+#define HEX_H
+
+#include "hash.h"
+
+extern const signed char hexval_table[256];
+static inline unsigned int hexval(unsigned char c)
+{
+	return hexval_table[c];
+}
+
+/*
+ * Convert two consecutive hexadecimal digits into a char.  Return a
+ * negative value on error.  Don't run over the end of short strings.
+ */
+static inline int hex2chr(const char *s)
+{
+	unsigned int val = hexval(s[0]);
+	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
+}
+
+/*
+ * Try to read a SHA1 in hexadecimal format from the 40 characters
+ * starting at hex.  Write the 20-byte result to sha1 in binary form.
+ * Return 0 on success.  Reading stops if a NUL is encountered in the
+ * input, so it is safe to pass this function an arbitrary
+ * null-terminated string.
+ */
+int get_sha1_hex(const char *hex, unsigned char *sha1);
+int get_oid_hex(const char *hex, struct object_id *sha1);
+
+/* Like get_oid_hex, but for an arbitrary hash algorithm. */
+int get_oid_hex_algop(const char *hex, struct object_id *oid, const struct git_hash_algo *algop);
+
+/*
+ * Read `len` pairs of hexadecimal digits from `hex` and write the
+ * values to `binary` as `len` bytes. Return 0 on success, or -1 if
+ * the input does not consist of hex digits).
+ */
+int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
+
+/*
+ * Convert a binary hash in "unsigned char []" or an object name in
+ * "struct object_id *" to its hex equivalent. The `_r` variant is reentrant,
+ * and writes the NUL-terminated output to the buffer `out`, which must be at
+ * least `GIT_MAX_HEXSZ + 1` bytes, and returns a pointer to out for
+ * convenience.
+ *
+ * The non-`_r` variant returns a static buffer, but uses a ring of 4
+ * buffers, making it safe to make multiple calls for a single statement, like:
+ *
+ *   printf("%s -> %s", hash_to_hex(one), hash_to_hex(two));
+ *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
+ */
+char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const struct git_hash_algo *);
+char *oid_to_hex_r(char *out, const struct object_id *oid);
+char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *);	/* static buffer result! */
+char *hash_to_hex(const unsigned char *hash);						/* same static buffer */
+char *oid_to_hex(const struct object_id *oid);						/* same static buffer */
+
+/*
+ * Parse a 40-character hexadecimal object ID starting from hex, updating the
+ * pointer specified by end when parsing stops.  The resulting object ID is
+ * stored in oid.  Returns 0 on success.  Parsing will stop on the first NUL or
+ * other invalid character.  end is only updated on success; otherwise, it is
+ * unmodified.
+ */
+int parse_oid_hex(const char *hex, struct object_id *oid, const char **end);
+
+/* Like parse_oid_hex, but for an arbitrary hash algorithm. */
+int parse_oid_hex_algop(const char *hex, struct object_id *oid, const char **end,
+			const struct git_hash_algo *algo);
+
+
+/*
+ * These functions work like get_oid_hex and parse_oid_hex, but they will parse
+ * a hex value for any algorithm. The algorithm is detected based on the length
+ * and the algorithm in use is returned. If this is not a hex object ID in any
+ * algorithm, returns GIT_HASH_UNKNOWN.
+ */
+int get_oid_hex_any(const char *hex, struct object_id *oid);
+int parse_oid_hex_any(const char *hex, struct object_id *oid, const char **end);
+
+#endif
diff --git a/mailinfo.c b/mailinfo.c
index 833d28612f7..9f1495ddcf1 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1,5 +1,7 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
+#include "gettext.h"
+#include "hex.h"
 #include "utf8.h"
 #include "strbuf.h"
 #include "mailinfo.h"
diff --git a/oidset.c b/oidset.c
index b36a2bae864..d1e5376316e 100644
--- a/oidset.c
+++ b/oidset.c
@@ -1,5 +1,7 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "oidset.h"
+#include "hex.h"
+#include "strbuf.h"
 
 void oidset_init(struct oidset *set, size_t initial_size)
 {
diff --git a/wildmatch.c b/wildmatch.c
index 7e5a7ea1eaa..42e38e34590 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -9,7 +9,7 @@
 **  work differently than '*', and to fix the character-class code.
 */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "wildmatch.h"
 
 typedef unsigned char uchar;
-- 
gitgitgadget

