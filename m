Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0593E743F0
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 21:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjI2VVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 17:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjI2VVD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 17:21:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6B71AA
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 14:21:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8134eb83so187077437b3.2
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 14:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696022460; x=1696627260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSqK0HweFHjWdsnPW0bdmckN6lsXfMyrTavCbIKCkBw=;
        b=JImwSZB/VpRWn/i60mZfn8uF8mq56/bCDH+0qBKqcJjPa4I/XsZsDiKkBWVZ+bSrIf
         hvJlT05jDzV0/H1lEoNisgUZCtkm9u723HQwu49boJY6plrWurdwL54Ud3NL4QhTmeMG
         CLfisUylr6A1MKl9vPXm5L6QQ/MlSXFOgH/brqLoAi9iEhD36ymZwrSBbBoLeoQg22vs
         elqt32WWoOiUSfnsSl1wpa5NTUyfGvGGYnRRjfkpzk66gEel8lNojaOdavSDfXF/G3lT
         JoBWHOhAd1DjTkqLpp4D7p3GF/KvzsEkUW5WkLolwgp9yq72wKkBNLph7JJJfjHVsBdE
         LZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696022460; x=1696627260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSqK0HweFHjWdsnPW0bdmckN6lsXfMyrTavCbIKCkBw=;
        b=EKA1vQEAIzpP77nUltzgc87JQfNv4/4pkCR5qB19ZSyd7ynp0NfJtzoh9QUTs9DRma
         8kUn/wg8tittfb23DXY2xzsDW2AsVOpv940mvZW3W+nuoDyw6NJVSh+L4nYiUSMBV3GE
         UFVNiAUC2YItQHHw14LjiQAbu2gW4ahK9mBZukSGlii1nNjnT9KBz81sxarlgCOptIwR
         1U2mzwpw+sfmNwBo0boo4iyEwPzZ4on1SkYick1iZNPrPLSqfRwdjPmYy/QIjWuENhGR
         Waisrtu1LayUYMyoOKtr5wynGoLVULfbMK7aPjXVGsizt6lxhWxzMbdjJB3jlc1uh2J2
         bpQA==
X-Gm-Message-State: AOJu0Yy8wGePdoxXHdjk6JXpKd+GGPI8IaBI3kyDjjHwrfXsDnimlZ8A
        3it/Pe09TbirnQQVRvFIcPEB+Oj10MSdCANndDfe2I/i05q+5ZDZ2U4aa2v/evJylovz5DN3aF4
        oh1WD1r4skI3O7ekOu5x+QNK7uTUq32zjlhMJoZROuBKKIPa8F+NdQ8u4bUa7fyxdW3m4RcqEqO
        qk
X-Google-Smtp-Source: AGHT+IEbJV1VezkcZub8ipGi5MENaibZrUlZhuna/fYB+cTIc6A1+r4W35RSPaU8RvlLu6jrvUNZdEQn+wVoUR6J/876
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:b708:8deb:d032:67cf])
 (user=jonathantanmy job=sendgmr) by 2002:a25:5042:0:b0:d89:47d6:b4fa with
 SMTP id e63-20020a255042000000b00d8947d6b4famr79683ybb.13.1696022459473; Fri,
 29 Sep 2023 14:20:59 -0700 (PDT)
Date:   Fri, 29 Sep 2023 14:20:48 -0700
In-Reply-To: <cover.1696021277.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com> <cover.1696021277.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <02ecc00e9c7226c9eeb960cc49c8c03dcb182a38.1696021277.git.jonathantanmy@google.com>
Subject: [PATCH v4 1/4] hex-ll: separate out non-hash-algo functions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Calvin Wan <calvinwan@google.com>

In order to further reduce all-in-one headers, separate out functions in
hex.h that do not operate on object hashes into its own file, hex-ll.h,
and update the include directives in the .c files that need only such
functions accordingly.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile   |  1 +
 color.c    |  2 +-
 hex-ll.c   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 hex-ll.h   | 27 +++++++++++++++++++++++++++
 hex.c      | 47 -----------------------------------------------
 hex.h      | 24 +-----------------------
 mailinfo.c |  2 +-
 strbuf.c   |  2 +-
 url.c      |  2 +-
 urlmatch.c |  2 +-
 10 files changed, 83 insertions(+), 75 deletions(-)
 create mode 100644 hex-ll.c
 create mode 100644 hex-ll.h

diff --git a/Makefile b/Makefile
index 5776309365..861e643708 100644
--- a/Makefile
+++ b/Makefile
@@ -1040,6 +1040,7 @@ LIB_OBJS += hash-lookup.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hex-ll.o
 LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += json-writer.o
diff --git a/color.c b/color.c
index b24b19566b..f663c06ac4 100644
--- a/color.c
+++ b/color.c
@@ -3,7 +3,7 @@
 #include "color.h"
 #include "editor.h"
 #include "gettext.h"
-#include "hex.h"
+#include "hex-ll.h"
 #include "pager.h"
 #include "strbuf.h"
 
diff --git a/hex-ll.c b/hex-ll.c
new file mode 100644
index 0000000000..4d7ece1de5
--- /dev/null
+++ b/hex-ll.c
@@ -0,0 +1,49 @@
+#include "git-compat-util.h"
+#include "hex-ll.h"
+
+const signed char hexval_table[256] = {
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 10-17 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 18-1f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 20-27 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 28-2f */
+	  0,  1,  2,  3,  4,  5,  6,  7,		/* 30-37 */
+	  8,  9, -1, -1, -1, -1, -1, -1,		/* 38-3f */
+	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 40-47 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 48-4f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 50-57 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 58-5f */
+	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 60-67 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 68-67 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 70-77 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 78-7f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 80-87 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 88-8f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 90-97 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 98-9f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a0-a7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a8-af */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b0-b7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b8-bf */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c0-c7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c8-cf */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d0-d7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d8-df */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e0-e7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e8-ef */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f0-f7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f8-ff */
+};
+
+int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
+{
+	for (; len; len--, hex += 2) {
+		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
+
+		if (val & ~0xff)
+			return -1;
+		*binary++ = val;
+	}
+	return 0;
+}
diff --git a/hex-ll.h b/hex-ll.h
new file mode 100644
index 0000000000..a381fa8556
--- /dev/null
+++ b/hex-ll.h
@@ -0,0 +1,27 @@
+#ifndef HEX_LL_H
+#define HEX_LL_H
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
+ * Read `len` pairs of hexadecimal digits from `hex` and write the
+ * values to `binary` as `len` bytes. Return 0 on success, or -1 if
+ * the input does not consist of hex digits).
+ */
+int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
+
+#endif
diff --git a/hex.c b/hex.c
index 01f17fe5c9..d42262bdca 100644
--- a/hex.c
+++ b/hex.c
@@ -2,53 +2,6 @@
 #include "hash.h"
 #include "hex.h"
 
-const signed char hexval_table[256] = {
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 10-17 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 18-1f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 20-27 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 28-2f */
-	  0,  1,  2,  3,  4,  5,  6,  7,		/* 30-37 */
-	  8,  9, -1, -1, -1, -1, -1, -1,		/* 38-3f */
-	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 40-47 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 48-4f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 50-57 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 58-5f */
-	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 60-67 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 68-67 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 70-77 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 78-7f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 80-87 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 88-8f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 90-97 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 98-9f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a0-a7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a8-af */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b0-b7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b8-bf */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c0-c7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c8-cf */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d0-d7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d8-df */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e0-e7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e8-ef */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f0-f7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f8-ff */
-};
-
-int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
-{
-	for (; len; len--, hex += 2) {
-		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
-
-		if (val & ~0xff)
-			return -1;
-		*binary++ = val;
-	}
-	return 0;
-}
-
 static int get_hash_hex_algop(const char *hex, unsigned char *hash,
 			      const struct git_hash_algo *algop)
 {
diff --git a/hex.h b/hex.h
index 87abf66602..e0b83f776f 100644
--- a/hex.h
+++ b/hex.h
@@ -2,22 +2,7 @@
 #define HEX_H
 
 #include "hash-ll.h"
-
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
+#include "hex-ll.h"
 
 /*
  * Try to read a hash (specified by the_hash_algo) in hexadecimal
@@ -34,13 +19,6 @@ int get_oid_hex(const char *hex, struct object_id *oid);
 /* Like get_oid_hex, but for an arbitrary hash algorithm. */
 int get_oid_hex_algop(const char *hex, struct object_id *oid, const struct git_hash_algo *algop);
 
-/*
- * Read `len` pairs of hexadecimal digits from `hex` and write the
- * values to `binary` as `len` bytes. Return 0 on success, or -1 if
- * the input does not consist of hex digits).
- */
-int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
-
 /*
  * Convert a binary hash in "unsigned char []" or an object name in
  * "struct object_id *" to its hex equivalent. The `_r` variant is reentrant,
diff --git a/mailinfo.c b/mailinfo.c
index 931505363c..a07d2da16d 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
-#include "hex.h"
+#include "hex-ll.h"
 #include "utf8.h"
 #include "strbuf.h"
 #include "mailinfo.h"
diff --git a/strbuf.c b/strbuf.c
index 4c9ac6dc5e..7827178d8e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "hex.h"
+#include "hex-ll.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "utf8.h"
diff --git a/url.c b/url.c
index 2e1a9f6fee..282b12495a 100644
--- a/url.c
+++ b/url.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "hex.h"
+#include "hex-ll.h"
 #include "strbuf.h"
 #include "url.h"
 
diff --git a/urlmatch.c b/urlmatch.c
index 1c45f23adf..1d0254abac 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "hex.h"
+#include "hex-ll.h"
 #include "strbuf.h"
 #include "urlmatch.h"
 
-- 
2.42.0.582.g8ccd20d70d-goog

