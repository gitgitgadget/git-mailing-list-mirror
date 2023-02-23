Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99215C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjBWIFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjBWIFl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E643467
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:30 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k37so4846656wms.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXQdDJPdCbRzie8PIOPazmdTtn6PMdJz2s3ttIu3+Qg=;
        b=iEqeAWoxHAl0mJJGT922pXxJIDv5J7mjyK7QQpAMZtoHQZspepopSuN95mTJE3sWQy
         RQMaUKqRFzKpRpnScVQGZYuy8JfcdXgfDZjBGg+Nt2eT9hMHz+zjApC+VG+9TmuZE24m
         SW2j7AfY4mBiPBJxV0mtMaGKmi+i9qGKCh29YLFOxd7abhuqNwDHUN34FaA9GDmqV8tK
         NhgOgpKGCjyUEqpRsQbEZVXKs4XUQghyFEIKMyyuHTxYSbtXcR+p46QDQWb7CehyguNw
         Zhylq4sRo0+pCLX240hXrmxVWzjRh55Co4YtkJXpF63/sAiPJzpwBNAmOyY+HbUFzTUd
         n5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXQdDJPdCbRzie8PIOPazmdTtn6PMdJz2s3ttIu3+Qg=;
        b=rmlbjREjBytWhCr41mTJJ7dHda7DG4czvHybkQCJYXJ9WK0RqyIUSUsJILYtCG47XS
         /1l7NpDupctfNNkvqd14URcMwRMNs3yVCfT0kQ2mTMUIFXfqVxH+3xuARQTiIc+8+KE+
         0grfnh034mM3BUyntbyJbTcjIlMwcoeH3mG0/Ofp7LoI+RMOSXrnx67ifnzZ1s6h/Nz8
         HDNBFtOFKBSysZdarXwzoEJcfTyIzd7lZpuwUTj/hApExHp6t4ZYMXhDZsY+y4d8/ptc
         ZGIU16gmFEPaNFthJsBgv36at7R6jUkXAqyOsUGyDSHgqSD0BZkuoTTquwIwgULRSVkJ
         ZgeA==
X-Gm-Message-State: AO0yUKVyLuw2xdUkqPSLY6pTTi3AlJxNrcubUteZ7J6EuzcnVbhN5jZH
        usVQxx7a7XQrViHfnLY7l92QZetbCP8=
X-Google-Smtp-Source: AK7set/C0O2HCTIrYMVqKeUZQXtumdEp3VLJnbk+cAwMbSI8ecZ5oOle6QR1GWjogyicJG8UDNunOQ==
X-Received: by 2002:a05:600c:2b45:b0:3df:85d2:c768 with SMTP id e5-20020a05600c2b4500b003df85d2c768mr8263663wmf.26.1677139528811;
        Thu, 23 Feb 2023 00:05:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d5350000000b002c53cc7504csm6235755wrv.78.2023.02.23.00.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:28 -0800 (PST)
Message-Id: <c9b1b27809298eb1b7a8c5e48866637268dc12a1.1677139522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:12 +0000
Subject: [PATCH 07/16] hex.h: move some hex-related declarations from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
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

