Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFD330D43
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736546; cv=none; b=AmpBVnrMkB0gIgwuFtwdrg33WC/WJzpzh1vPSBefR4J6iaXvFgHae30d90BsdZ3kMD7bwd3SFjZaeoLdsDDJYUgdAps8HwvFwGfp1KS09UVglcoQPQOedL1+wZyqCC5xFEOIve0ffX4ombcOh+AlACLIrV5aq9EsBlcYt3QczlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736546; c=relaxed/simple;
	bh=1T9u7FE1qhaRLZkUdJhRy4ITroOrftY9qIRW+wRBNXw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XoirpQbxGdo9e7k1wp+b3kWYkqpe4d59Cqvsv+zLvFRpp4k1n0TNBe2bCLAc3O0gA4rTHuWczXCDGGsTb/j+b3Q23+dILlWlKo1Uz6/FoZUFVmd0uOuNp4BFH/aTMISBGuNoQDcPvdoaixOXWZuZ22QOiWOZ15d9rHdZla1ZYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB5fqGI/; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB5fqGI/"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc50bcf87b2so394619a12.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2026 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789736544; x=1790341344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZTfm3stzB5eYOuQqey9L97wxKbHdK7KdoWQe+TWlFHM=;
        b=mB5fqGI/u2pVkzc1+BLxLuDo7E6BL0ngG23qXTOHUXFIqVOEa+/elaRCGpFhzK1ljS
         +0gVWgjgweVJeAm610HEVhbJF8emjnxpJYZNI6k4kRvntJH0TuSTEKQSx39MPwZTZzNv
         LhWWJRYip3MlfyDo/P595SGq013pWbpmJh/z8PFScGuv4Le1rshgJ51gMvjIAxx6Y2Hn
         ddDbMGey1axs+elTYJccyFCRxLxDQkCsRFRcB6MiHUz1QPazAE4zkXj8/tkzcWnVYsEo
         Vefro5e2rtkUi/083ACLvB1BLRjI4dxG25r4Ke5lXH/fdRyPMxPNz/Wdi4z/+xh2ho5A
         BSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736544; x=1790341344;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZTfm3stzB5eYOuQqey9L97wxKbHdK7KdoWQe+TWlFHM=;
        b=BGg+qmcACYPKoja1ICWWqJ49zj571TaeqvFx2/XOZm+utNl0XwTct3zekXux0VSFMz
         H0JKYhHX6K4V9jMlLr1JA0inDOpuQFyxd8RSqZLiWfkYfTYoDnti0a/qJ2bcUhjrq9dx
         MotL2G2LKIpJrz9EqkSU5l97/5d9Jg8A8TF6d92sNCni1FoqRXS3AmfXXAZLHb2QF6Hp
         jIncYhcaR6iNnOY5X4ARIdWKrJu/mnDYGCLrJoNmRkgQLL92JrED+G8auEq1gmAX/14H
         2Nu1WNFmI0VPf5OoRbcaA1S/F5ebtLRFZvpbGAb+28j/ZdKDxkDvSKSv0Abbh0G8wHWE
         qW6A==
X-Gm-Message-State: AFuF++nv/9X0rH3W/m6sm7nmXZXIwkuVjB5uE/8PZxPSN4MQD+np+z65
	1qCKkr8gHjxb9wqiKZEOU2tbwtZsuSG+0vFzVzfty+Gt2IxVI0PAoDM7DSVn2g==
X-Gm-Gg: AYBFou3oLI4LX6Nv8gTh9bkwqfMfZNFZ/BTe+d7XF7bTG9VxOgtZpBBH3eOML/BudHZ
	bRnCrWzbJgRZJs8gQSYflkQ4fICeWjusnxIyNaKJ2/xvY6kr+ER3eEtrpZPY/g1NzkU/aRYoWm4
	MyzLDR5qTx3YgQzDnNxLi0tKOYrRs1pfuzsaI9Glfp96gn6oH9e7LgZ/a00kZecCZrKoZAZN5CP
	8PjZuUxXXlWr7QqJCjSml7eP2L1zFU6lYWJSKpbNfF5rm0gmP8D7+tAy3nXQs1q10QZxCvIO5zq
	uxWoQjwTH4o5TiK1Kkhqre+Mcbv0XPZxsz4SNXNyRTTouQccoCS+lIvP+2QXqxAlUXgH9pliLDq
	AutvIME5zo4rzMy1mQ1jXRGD2DWi1nqhxuCi/8jjkalO89nZLTRx3Y7kxH0UiphTpN1gJlcIxLJ
	dWkw3MD57EArZLSPJ7FODkyYPMLLUiVIMsYfaUzLdWdV7s2CjBI7b7AGgLRH1d3JTzY3szamCTI
	tVfvy/2nGM=
X-Received: by 2002:a05:6300:220d:b0:3dd:85a8:cac6 with SMTP id adf61e73a8af0-3dd8c419610mr4574240637.29.1789736543688;
        Fri, 18 Sep 2026 06:02:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.95.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-875ddce1677sm774336b3a.58.2026.09.18.06.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:02:23 -0700 (PDT)
Message-Id: <b1779709120adc9c1df40c7210481d6bed9791c5.1789736540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 13:02:15 +0000
Subject: [PATCH 1/6] strbuf: add header for 'safe' API
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    peff@peff.net,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The strbuf library is an important API used all over the Git codebase.
Contributors use it in nearly any string-manipulating action. However, the
implementation uses other helping functions that die() on failure instead of
returning an error code. Thus, the strbuf API isn't _safe_.

In particular, we cannot include 'banned-die.h' in 'strbuf.c'.

To start the creation of a safe strbuf API, move the struct definition into
a new 'strbuf-safe.h' header file. All consumers of 'strbuf.h' will consume
that header transitively.

In the future, we will hope to have consumers that need a 'safe' API will
include 'strbuf-safe.h' instead of 'strbuf.h'.

We will see in future changes the inclusion of new implementations that
return an error code instead of halting.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 strbuf-safe.h | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
 strbuf.h      | 74 +++----------------------------------------
 2 files changed, 92 insertions(+), 70 deletions(-)
 create mode 100644 strbuf-safe.h

diff --git a/strbuf-safe.h b/strbuf-safe.h
new file mode 100644
index 0000000000..3cf14545bb
--- /dev/null
+++ b/strbuf-safe.h
@@ -0,0 +1,88 @@
+#ifndef STRBUF_SAFE_H
+#define STRBUF_SAFE_H
+
+/*
+ * NOTE FOR STRBUF DEVELOPERS
+ *
+ * strbuf is a low-level primitive; as such it should interact only
+ * with other low-level primitives. Do not introduce new functions
+ * which interact with higher-level APIs.
+ *
+ * This header file specifically conatins the "safe" API surface for
+ * working with strbufs. The implementations of these methods avoid
+ * using die() and other exits. Thus, these methods are appropriate
+ * for use within lower-level APIs such as trace2.
+ */
+
+struct string_list;
+
+/**
+ * strbufs are meant to be used with all the usual C string and memory
+ * APIs. Given that the length of the buffer is known, it's often better to
+ * use the mem* functions than a str* one (e.g., memchr vs. strchr).
+ * Though, one has to be careful about the fact that str* functions often
+ * stop on NULs and that strbufs may have embedded NULs.
+ *
+ * A strbuf is NUL terminated for convenience, but no function in the
+ * strbuf API actually relies on the string being free of NULs.
+ *
+ * strbufs have some invariants that are very important to keep in mind:
+ *
+ *  - The `buf` member is never NULL, so it can be used in any usual C
+ *    string operations safely. strbufs _have_ to be initialized either by
+ *    `strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
+ *
+ *    Do *not* assume anything on what `buf` really is (e.g. if it is
+ *    allocated memory or not), use `strbuf_detach()` to unwrap a memory
+ *    buffer from its strbuf shell in a safe way. That is the sole supported
+ *    way. This will give you a malloced buffer that you can later `free()`.
+ *
+ *    However, it is totally safe to modify anything in the string pointed by
+ *    the `buf` member, between the indices `0` and `len-1` (inclusive).
+ *
+ *  - The `buf` member is a byte array that has at least `len + 1` bytes
+ *    allocated. The extra byte is used to store a `'\0'`, allowing the
+ *    `buf` member to be a valid C-string. All strbuf functions ensure this
+ *    invariant is preserved.
+ *
+ *    NOTE: It is OK to "play" with the buffer directly if you work it this
+ *    way:
+ *
+ *        strbuf_grow(sb, SOME_SIZE); <1>
+ *        strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
+ *
+ *    <1> Here, the memory array starting at `sb->buf`, and of length
+ *    `strbuf_avail(sb)` is all yours, and you can be sure that
+ *    `strbuf_avail(sb)` is at least `SOME_SIZE`.
+ *
+ *    NOTE: `SOME_OTHER_SIZE` must be smaller or equal to `strbuf_avail(sb)`.
+ *
+ *    Doing so is safe, though if it has to be done in many places, adding the
+ *    missing API to the strbuf module is the way to go.
+ *
+ *    WARNING: Do _not_ assume that the area that is yours is of size `alloc
+ *    - 1` even if it's true in the current implementation. Alloc is somehow a
+ *    "private" member that should not be messed with. Use `strbuf_avail()`
+ *    instead.
+*/
+
+/**
+ * Data Structures
+ * ---------------
+ */
+
+/**
+ * This is the string buffer structure. The `len` member can be used to
+ * determine the current length of the string, and `buf` member provides
+ * access to the string itself.
+ */
+struct strbuf {
+	size_t alloc;
+	size_t len;
+	char *buf;
+};
+
+extern char strbuf_slopbuf[];
+#define STRBUF_INIT  { .buf = strbuf_slopbuf }
+
+#endif /* STRBUF_SAFE_H */
diff --git a/strbuf.h b/strbuf.h
index 1089ae687b..b41f8ef901 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,85 +1,19 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
+#include "strbuf-safe.h"
+
 /*
  * NOTE FOR STRBUF DEVELOPERS
  *
  * strbuf is a low-level primitive; as such it should interact only
  * with other low-level primitives. Do not introduce new functions
  * which interact with higher-level APIs.
- */
-
-struct string_list;
-
-/**
- * strbufs are meant to be used with all the usual C string and memory
- * APIs. Given that the length of the buffer is known, it's often better to
- * use the mem* functions than a str* one (e.g., memchr vs. strchr).
- * Though, one has to be careful about the fact that str* functions often
- * stop on NULs and that strbufs may have embedded NULs.
- *
- * A strbuf is NUL terminated for convenience, but no function in the
- * strbuf API actually relies on the string being free of NULs.
- *
- * strbufs have some invariants that are very important to keep in mind:
- *
- *  - The `buf` member is never NULL, so it can be used in any usual C
- *    string operations safely. strbufs _have_ to be initialized either by
- *    `strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
- *
- *    Do *not* assume anything on what `buf` really is (e.g. if it is
- *    allocated memory or not), use `strbuf_detach()` to unwrap a memory
- *    buffer from its strbuf shell in a safe way. That is the sole supported
- *    way. This will give you a malloced buffer that you can later `free()`.
- *
- *    However, it is totally safe to modify anything in the string pointed by
- *    the `buf` member, between the indices `0` and `len-1` (inclusive).
- *
- *  - The `buf` member is a byte array that has at least `len + 1` bytes
- *    allocated. The extra byte is used to store a `'\0'`, allowing the
- *    `buf` member to be a valid C-string. All strbuf functions ensure this
- *    invariant is preserved.
- *
- *    NOTE: It is OK to "play" with the buffer directly if you work it this
- *    way:
  *
- *        strbuf_grow(sb, SOME_SIZE); <1>
- *        strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
- *
- *    <1> Here, the memory array starting at `sb->buf`, and of length
- *    `strbuf_avail(sb)` is all yours, and you can be sure that
- *    `strbuf_avail(sb)` is at least `SOME_SIZE`.
- *
- *    NOTE: `SOME_OTHER_SIZE` must be smaller or equal to `strbuf_avail(sb)`.
- *
- *    Doing so is safe, though if it has to be done in many places, adding the
- *    missing API to the strbuf module is the way to go.
- *
- *    WARNING: Do _not_ assume that the area that is yours is of size `alloc
- *    - 1` even if it's true in the current implementation. Alloc is somehow a
- *    "private" member that should not be messed with. Use `strbuf_avail()`
- *    instead.
-*/
-
-/**
- * Data Structures
- * ---------------
+ * Also see strbuf-safe.h for the struct definitions and safe versions
+ * of some methods declared in this header file.
  */
 
-/**
- * This is the string buffer structure. The `len` member can be used to
- * determine the current length of the string, and `buf` member provides
- * access to the string itself.
- */
-struct strbuf {
-	size_t alloc;
-	size_t len;
-	char *buf;
-};
-
-extern char strbuf_slopbuf[];
-#define STRBUF_INIT  { .buf = strbuf_slopbuf }
-
 struct object_id;
 
 /**
-- 
gitgitgadget

