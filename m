Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B00223716
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689368; cv=none; b=Jny7kTtkSIYAZM+410Kz5jq+lNtb04esL1+zLVP79oi2YdO9vAt+pl/zK/kWRGLF+Rh1HIChMJdKevPznm3168bishVaAvibqCPOi040WyLLZRCXNsLTKU3q8qYYuhFynvMcit3y4yuZFws3q/KBTktIVjv6IKalJ6u3AmcH76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689368; c=relaxed/simple;
	bh=M1uSDsHDlsVTTAyErH+FJF0qvggB29eNgDDAdC9vbJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJ7Aj7k967NAVkVKj09tA+zhI3O49SStyXoRKU1PIkBlts6ftDzAGJOWQ4VhDHR6zDn3QPcQqh+2+wHDYBhZVAGgT+PkvAApV7GOwjqAJKQw93avBPS1D7kFpTEtSA8j0r+0qJAQSzFhC9vnhbQFSqR3rsZyWuv+rSV0di9p/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnL1mo2B; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnL1mo2B"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72a4793d4e2so631072a34.2
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743689365; x=1744294165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLnKEbGhYDdoRcV3VKGjE9dwP2vi8Q956Ag/VL4r9F0=;
        b=WnL1mo2BobnTQLK+JNtNzaUPycTMxIxXD0pAtwGaKt5IpFbScQeBrjfnYigLWVjldN
         bhLaVBX9zn5x53eSo2QM/or1XXtSt56FUI4RFQx/dLBIgBNBZBm+Fetfi5j8H8B6VUHH
         jsFrw/X84uDUlPcNnJOm0P0mfkI8ombB6aeR0JyIA4uzusztUHczbV+jyeLIUQIjOmsk
         D1GIPPyq/WmlhRSs3RrDMztxBHzViQ3VH9F9o5nJtQm5SsnoJkyvn2v+zuVT1yItis2M
         PZuOh5TG/KCGpu6orOH+m/GrJHT6H/5oPTh8cY23AGwX+PecoPMdRYZJXKj03Z3Qvrxf
         tOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743689365; x=1744294165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLnKEbGhYDdoRcV3VKGjE9dwP2vi8Q956Ag/VL4r9F0=;
        b=Tgf6jBPGlZKVvGf10KGHp07+8EQOjuSl+V4MeskIJ4rjXXlV1+Z099YYcF5jdMa++8
         JirUQAI7SihYq+OsyOfoDTYpB/yPoOwVJWHRJ0ChghamotDHUKSPLTFy+FSmi/XFiMT4
         b6CZdQ8ySbfoZvlLbUvvbC+8du94sTQ9ds5ukdvMHA5ZfL/72mGQ45B5y3tMlY7z2yuv
         M51RZH5d3BElpE/+CKv2TJqslBzjX1oo10thWBgUDfzApDkTnKQymi1noDINJVCm3vos
         FyugaKAIcaJowJSjZyI7XrGQS0TF6DoVNQ9Be+hgWggREX9HVw0NBKe+n4nj8zl3PQ11
         6jAQ==
X-Gm-Message-State: AOJu0YypyEhsJWmFgk515sQLOtrFWXHjl3CAF4SJX+d/a4nVXR09DbMb
	QH85/HUhAgQigq37pRmTL3YBNlwJ52gTWqpnYjWN00wSLolQtZqkNJQqcg==
X-Gm-Gg: ASbGncvDQ0xrIBBrN9hDx3+/Tyz916jGsdNFzUrvtexPCURflX46y1ag7ISuL/MCvmW
	J+UtIfi49qUDKU99WNqxqrI2UbLDEfDR0OxY3Ada24gXnaJY5pMA5qE348fSJA5i5oCUcGj03/2
	3uxd4ndmBHcQFvy7rYKY4PeucCE4Y4GdxlSxonhL0p/63pS2nYbvYDIkrcGwOmmeYtgBP5VcPwX
	eYLWtYuiJGD6PnvQ/7zhCyAEuRmqIZ6MFeCb9Kzr+1JZ+f1Wt40o4XH2y4uwt0AGQVJeSt4kgEd
	U4HbWumCPKJEpy0ht//r23jKb3zuTt4K7D5FryJ8Hm7npKlsql12
X-Google-Smtp-Source: AGHT+IEOpD+kl+Km1XlsTSBzwFa73EBIoRwtiqae0jwdXh5e9rlvHByBsSIb4CIwdc3/eNlq6L1lMg==
X-Received: by 2002:a05:6830:2a8f:b0:72b:7d60:fda6 with SMTP id 46e09a7af769-72e305555f5mr1501135a34.0.1743689365249;
        Thu, 03 Apr 2025 07:09:25 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2cc845bb8fcsm261557fac.11.2025.04.03.07.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:09:24 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/2] help: include SHA implementation in version info
Date: Thu,  3 Apr 2025 09:05:28 -0500
Message-ID: <20250403140529.497876-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403140529.497876-1-jltobler@gmail.com>
References: <20250401203630.285451-1-jltobler@gmail.com>
 <20250403140529.497876-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the `--build-options` flag is used with git-version(1), additional
information about the built version of Git is printed. During build
time, different SHA implementations may be configured, but this
information is not included in the version info.

Add the SHA implementations Git is built with to the version info by
requiring each backend to define a SHA1_BACKEND or SHA256_BACKEND symbol
as appropriate and use the value in the printed build options.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-version.adoc | 6 ++++++
 hash.h                         | 8 ++++++++
 help.c                         | 3 +++
 3 files changed, 17 insertions(+)

diff --git a/Documentation/git-version.adoc b/Documentation/git-version.adoc
index 80fa7754a6..913ebf147d 100644
--- a/Documentation/git-version.adoc
+++ b/Documentation/git-version.adoc
@@ -22,6 +22,12 @@ OPTIONS
 --build-options::
 	Include additional information about how git was built for diagnostic
 	purposes.
++
+The libraries used to implement the SHA-1 and SHA-256 algorithms are displayed
+in the form `SHA-1: <option>` and `SHA-256: <option>`. Note that the SHA-1
+options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_BLK` do not use a collision
+detection algorithm and thus may be vulnerable to known SHA-1 collision
+attacks.
 
 GIT
 ---
diff --git a/hash.h b/hash.h
index 4367acfec5..51cd0ec7b6 100644
--- a/hash.h
+++ b/hash.h
@@ -2,16 +2,20 @@
 #define HASH_H
 
 #if defined(SHA1_APPLE)
+#define SHA1_BACKEND "SHA1_APPLE (No collision detection)"
 #include <CommonCrypto/CommonDigest.h>
 #elif defined(SHA1_OPENSSL)
+#  define SHA1_BACKEND "SHA1_OPENSSL (No collision detection)"
 #  include <openssl/sha.h>
 #  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
 #    define SHA1_NEEDS_CLONE_HELPER
 #    include "sha1/openssl.h"
 #  endif
 #elif defined(SHA1_DC)
+#define SHA1_BACKEND "SHA1_DC"
 #include "sha1dc_git.h"
 #else /* SHA1_BLK */
+#define SHA1_BACKEND "SHA1_BLK (No collision detection)"
 #include "block-sha1/sha1.h"
 #endif
 
@@ -46,17 +50,21 @@
 #endif
 
 #if defined(SHA256_NETTLE)
+#define SHA256_BACKEND "SHA256_NETTLE"
 #include "sha256/nettle.h"
 #elif defined(SHA256_GCRYPT)
+#define SHA256_BACKEND "SHA256_GCRYPT"
 #define SHA256_NEEDS_CLONE_HELPER
 #include "sha256/gcrypt.h"
 #elif defined(SHA256_OPENSSL)
+#  define SHA256_BACKEND "SHA256_OPENSSL"
 #  include <openssl/sha.h>
 #  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
 #    define SHA256_NEEDS_CLONE_HELPER
 #    include "sha256/openssl.h"
 #  endif
 #else
+#define SHA256_BACKEND "SHA256_BLK"
 #include "sha256/block/sha256.h"
 #endif
 
diff --git a/help.c b/help.c
index c54bd9918a..991a9525db 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,7 @@
 #include "run-command.h"
 #include "levenshtein.h"
 #include "gettext.h"
+#include "hash.h"
 #include "help.h"
 #include "command-list.h"
 #include "string-list.h"
@@ -803,6 +804,8 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 #elif defined ZLIB_VERSION
 		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
 #endif
+		strbuf_addf(buf, "SHA-1: %s\n", SHA1_BACKEND);
+		strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
 	}
 }
 
-- 
2.49.0

