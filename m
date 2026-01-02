Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E313AD05
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767313671; cv=none; b=gkZAnkGIdgEmkAi57opX819BABOG+kmPUYqxsCvHxHhndV83cp/eZYFKaB9a6Bsj4+FcWnpQM1loZ4f5WhjO/h+CK/A7SPU85wj6bfhSsndc/EOk21SjgALiaPm3PWwkZqKZXjP4Fc5uZWv83Xlq+aQ/eNu8j0nezt824ZWK3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767313671; c=relaxed/simple;
	bh=R0U0FHERcCWl/edNoaVqtHnfbUqUg+HNEtKc6ERpGL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGx4lCr1BaMLGLoIinyAoUH2lWUMyEjD733+w84ovKpGYA/k7ISWzXyd2786Mj5FLD4doYr3rLiZrk/qztj8xruxyZrBZ3cA/eEqwPkD8ddB90voYcjUmqoTVRtemVwh4q3nCgFxewNGGPgNJ1/wmUyu5wvLxMLEUP9ooUucp9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1azaQaA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1azaQaA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477563e28a3so71586805e9.1
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 16:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767313668; x=1767918468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3VyBtUk5xLpca26ndquP+3jg14cV56jfqwBd2gN178=;
        b=F1azaQaA9AlEu3LKhEZ3PypLvNdv+bX5dXB19T60ZP/j4oiJALZ6RR6KkWm/zxwRCT
         1lWBu1osr+37f4IGlhhsUjFukxmNQxtYw78QLY5JhUYzdME0BI9FOJmBOWXt42M02Bz4
         Txl2qloFVhDbgaZuM+w/t/4FDRDc/hI+gXAn6h26a46XJvhRQGugR+WJPFK6sAW8AEbq
         kK3rfPQad4GvI36TNfzzxRfR7Sy82lN4h073cYnRT9hd9Jss1zNimBVDvKhA5Abs4zwq
         jElICwHUG2Z/8101fedzjknIAX3EUwc4j+VcsIPW0zb2KcNAWW2iND+cvDgrxRhPL1lQ
         NAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767313668; x=1767918468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3VyBtUk5xLpca26ndquP+3jg14cV56jfqwBd2gN178=;
        b=LSzMfYJgYBtOqMLUMBSbl8IHY5wDKAKL8lNuIqWu2dKwQa63TDo5xmzL7NDlhwc4wS
         GJsvhgdqo1yWknAj0qVz8JeyLN2Tud1H4c6/1hT/wvIyJi1RsClZ873CqRGW0VOVgePi
         ow1RhiXczl1mVn4spfQhTNmKZUTqWQG6jVlvEcAyfN5UOX/MdQlUslFibuwDKreswaEN
         L24fMEAn06OKQGi02346gL2+qxClGOevilxxts7gAvUckmY68VW2lFEuUc2m2tzUxEWI
         iyQFWxoBhEXG/O5Bk7vZI/+/VQ47hYp2NhbRB4QDCGig1FoMZsegQhXglD3WHsldMfYj
         p+cw==
X-Gm-Message-State: AOJu0YxqymkPAVxMtPpZudzpHlM2SXXwHHJcY1Mo4evOSK0HwozcCSd+
	KrZzPHJjRlQ7QrE7k3n5h2GHqCoHY6vHmy1ZQDEDsYfmuq0jD3LENnPksjxg2B/U
X-Gm-Gg: AY/fxX4Zq+DAaN+y+XYvBN0DF2MwyfhJUJQFAK3iqy5N+mlPeE99OfIn/r25ITPd2k3
	qplhjmhHXaqY9IZRxjCikVtxNypJ9uiskG6OnAyTtf7DsrkClhIzCqu7uzS9GHgM45RpLcQ3v2r
	yp9BrI3DMI01GJ4UlidvM9FrvIbIuQTe1fArCvRPNKnz2t0/dOheam+agBsGKUQ6EG07CNJq/Ky
	5d2Joc8gCU84l8tRid6lUg9fmvmNamcEJKR/DAZ+QjN2APSUv4vYDBuFD1aZRHAWgI2kvPjBJfv
	q4JTwpHIS9Syg/r7Rzx3TVreH6+Gnxj1bmU2WejnOpHjRbyshPkQL4Dh/wdYbXhWFxzTfQRfEMQ
	W+VqhY5/NK6OScFxYmGyvoOOMBnXt6nnHNABIvOq+E7r1gpevBbe9hUr9s6vhrWaOrYgv6MmEOl
	5YIbZPU1gxKak=
X-Google-Smtp-Source: AGHT+IE0yWY0gztVEvqYbYrkKZFQJy8wTpMDgrlEl87VQ9/biHe2j7N6lT0qNg6eD3n5wSgMQfOtww==
X-Received: by 2002:a05:600c:3508:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-47d18bd57bemr437719515e9.9.1767313667519;
        Thu, 01 Jan 2026 16:27:47 -0800 (PST)
Received: from fedora.lan ([2a0d:6fc1:2:c000:95b3:4a19:75dc:a979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19362345sm715700585e9.6.2026.01.01.16.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 16:27:47 -0800 (PST)
From: Rostislav Krasny <rostiprodev@gmail.com>
To: git@vger.kernel.org
Cc: Rostislav Krasny <rostiprodev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	Jeff King <peff@peff.net>
Subject: [PATCH 1/1] compat: modernize and simplify byte swapping functions
Date: Fri,  2 Jan 2026 02:27:35 +0200
Message-ID: <20260102002735.31390-2-rostiprodev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260102002735.31390-1-rostiprodev@gmail.com>
References: <20260102002735.31390-1-rostiprodev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual bit operations with memcpy + network functions for better
maintainability. Add missing 16-bit network byte order conversion.

Key improvements:
- Simplify the get_be*() and put_be*() functions
- Add bswap16() macro with automatic compiler optimization:
  * GCC/Clang: __builtin_bswap16() intrinsic
  * MSVC: _byteswap_ushort() intrinsic
- Add default_bswap16() static inline function with manual fallback implementation
- Rename default_swab32() to default_bswap32() for naming consistency
- Add ntohs() and htons() macros for complete 16/32/64-bit network conversion
- Add put_be16() function for API completeness alongside existing put_be*() and
  get_be*() functions
- Performance improvements (GCC 15.2.1, Clang 21.1.7):
  * on x86-64 with -O0 4.2x faster (GCC), 3.7x faster (Clang)
  * on x86-64 with -O1 4x faster (GCC), identical (Clang)
  * on x86-64 with -O2 identical (GCC), 1.8x faster (Clang)

Signed-off-by: Rostislav Krasny <rostiprodev@gmail.com>
---
 compat/bswap.h | 74 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 28635ebc69..f9954ef090 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -9,10 +9,15 @@
  */
 
 /*
- * Default version that the compiler ought to optimize properly with
+ * Default versions that the compiler ought to optimize properly with
  * constant values.
  */
-static inline uint32_t default_swab32(uint32_t val)
+static inline uint16_t default_bswap16(uint16_t val)
+{
+	return ((val & 0xff00) >> 8) | ((val & 0x00ff) << 8);
+}
+
+static inline uint32_t default_bswap32(uint32_t val)
 {
 	return (((val & 0xff000000) >> 24) |
 		((val & 0x00ff0000) >>  8) |
@@ -40,6 +45,7 @@ static inline uint64_t default_bswap64(uint64_t val)
 # define __has_builtin(x) 0
 #endif
 
+#undef bswap16
 #undef bswap32
 #undef bswap64
 
@@ -47,6 +53,7 @@ static inline uint64_t default_bswap64(uint64_t val)
 
 #include <stdlib.h>
 
+#define bswap16(x) _byteswap_ushort(x)
 #define bswap32(x) _byteswap_ulong(x)
 #define bswap64(x) _byteswap_uint64(x)
 
@@ -54,8 +61,9 @@ static inline uint64_t default_bswap64(uint64_t val)
 #define GIT_BIG_ENDIAN 4321
 #define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
 
-#elif __has_builtin(__builtin_bswap32) && __has_builtin(__builtin_bswap64)
+#elif __has_builtin(__builtin_bswap16) && __has_builtin(__builtin_bswap32) && __has_builtin(__builtin_bswap64)
 
+#define bswap16(x) __builtin_bswap16((x))
 #define bswap32(x) __builtin_bswap32((x))
 #define bswap64(x) __builtin_bswap64((x))
 
@@ -98,24 +106,36 @@ static inline uint64_t default_bswap64(uint64_t val)
 
 #endif
 
+#undef ntohs
+#undef htons
 #undef ntohl
 #undef htonl
 #undef ntohll
 #undef htonll
 
 #if GIT_BYTE_ORDER == GIT_BIG_ENDIAN
+# define ntohs(x) (x)
+# define htons(x) (x)
 # define ntohl(x) (x)
 # define htonl(x) (x)
 # define ntohll(x) (x)
 # define htonll(x) (x)
 #else
 
+# if defined(bswap16)
+#  define ntohs(x) bswap16(x)
+#  define htons(x) bswap16(x)
+# else
+#  define ntohs(x) default_bswap16(x)
+#  define htons(x) default_bswap16(x)
+# endif
+
 # if defined(bswap32)
 #  define ntohl(x) bswap32(x)
 #  define htonl(x) bswap32(x)
 # else
-#  define ntohl(x) default_swab32(x)
-#  define htonl(x) default_swab32(x)
+#  define ntohl(x) default_bswap32(x)
+#  define htonl(x) default_bswap32(x)
 # endif
 
 # if defined(bswap64)
@@ -129,47 +149,41 @@ static inline uint64_t default_bswap64(uint64_t val)
 
 static inline uint16_t get_be16(const void *ptr)
 {
-	const unsigned char *p = ptr;
-	return	(uint16_t)p[0] << 8 |
-		(uint16_t)p[1] << 0;
+	uint16_t n;
+	memcpy(&n, ptr, sizeof n);
+	return ntohs(n);
 }
 
 static inline uint32_t get_be32(const void *ptr)
 {
-	const unsigned char *p = ptr;
-	return	(uint32_t)p[0] << 24 |
-		(uint32_t)p[1] << 16 |
-		(uint32_t)p[2] <<  8 |
-		(uint32_t)p[3] <<  0;
+	uint32_t n;
+	memcpy(&n, ptr, sizeof n);
+	return ntohl(n);
 }
 
 static inline uint64_t get_be64(const void *ptr)
 {
-	const unsigned char *p = ptr;
-	return	(uint64_t)get_be32(&p[0]) << 32 |
-		(uint64_t)get_be32(&p[4]) <<  0;
+	uint64_t n;
+	memcpy(&n, ptr, sizeof n);
+	return ntohll(n);
+}
+
+static inline void put_be16(void *ptr, uint16_t value)
+{
+	uint16_t n = htons(value);
+	memcpy(ptr, &n, sizeof n);
 }
 
 static inline void put_be32(void *ptr, uint32_t value)
 {
-	unsigned char *p = ptr;
-	p[0] = (value >> 24) & 0xff;
-	p[1] = (value >> 16) & 0xff;
-	p[2] = (value >>  8) & 0xff;
-	p[3] = (value >>  0) & 0xff;
+	uint32_t n = htonl(value);
+	memcpy(ptr, &n, sizeof n);
 }
 
 static inline void put_be64(void *ptr, uint64_t value)
 {
-	unsigned char *p = ptr;
-	p[0] = (value >> 56) & 0xff;
-	p[1] = (value >> 48) & 0xff;
-	p[2] = (value >> 40) & 0xff;
-	p[3] = (value >> 32) & 0xff;
-	p[4] = (value >> 24) & 0xff;
-	p[5] = (value >> 16) & 0xff;
-	p[6] = (value >>  8) & 0xff;
-	p[7] = (value >>  0) & 0xff;
+	uint64_t n = htonll(value);
+	memcpy(ptr, &n, sizeof n);
 }
 
 #endif /* COMPAT_BSWAP_H */
-- 
2.52.0

