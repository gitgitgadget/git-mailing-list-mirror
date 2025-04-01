Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6E204C19
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540026; cv=none; b=uhj+bkPWW7C0EXOR3vmFoTnKnnB1rpSqr6PHQ9r6+wUXmt6xL1UwzuNi9Ol0qWPQEh67GwckY2/nPQrxB3KyCWHk3EKcfAyHxJqe1YKnWYVctQSK4j2oDZ+QIJZ3cz53ht7OPsmaoY43nSj8/Oq1YVSP2OAmhyZeXhiWXqnHpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540026; c=relaxed/simple;
	bh=V62rqrApuLnOjo87cw17VUegdEEnLrAcLnv7Wv/lHiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URYr/lkHoWTW/1DHj5tiDGLv7bpYM0vvrjTwRIHR5hJMgSQAqedqvCUflibaQewoz+wDd4rRx//BVFP51ga07j+VDgdXStYFjrHKVgjDWRINfCc+IH6de5dNjEkXBE0zebOpSQeqNQkFbg9uXDS/CDXnDx4INUXVm3Dz17sG1hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUupb97k; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUupb97k"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3feb0db95e6so3610054b6e.1
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743540023; x=1744144823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FtHVTKRq/6330jWIttP0ezIEXQv70wEPVyIJe/alGo=;
        b=lUupb97k5Ceu2eSDqAT73SkWJFL8bLzkwES3YS4H/hfM8Xzy7topXm4prJ3+O3glqM
         QWltMiyo4IMS9XdRncBebiEjVfbN8UvWgqHoi0FVjtUASQysB1+bOOzs9ZJ3/iBGia9+
         yJXW8JQGcVni8F2mruNB+VLcyaxpUwwzIWWz3llRYkYBu4yf5ZM7s5YDLrgWmPo0pYIN
         zC6ygNqTkSU5X3i9Ie34cGCz9Y7qz18boW9l9AwzoLm3Ss77qc99E+heG3SIC/dHoeJY
         3ZqyaSoobdav6a2Ri/hryl2vsLalKdmCvd+JHtiGexWBlnWAaGt/dE/uVJYpFePcnZn1
         ZOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540023; x=1744144823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FtHVTKRq/6330jWIttP0ezIEXQv70wEPVyIJe/alGo=;
        b=YMxZ2ASeI7wsF4UBN8SmY4NLe0Zro5gvKa203X8/N6HPupKDwZXbZhZvxBs8llzqNe
         0TSZ1/SAoAfRSsMBSvjCPi+hdpnx7o/FUdDanSEMa1gD1PCWxl/4zPkZmgA+HLwU+oiq
         Rf5LR9cNJudVqOUtV5RaBLFm0YeUMzpUFOfnYjaRmmZXpkm8HcLYO1ofqDTDlKhDtK9F
         x6Ef+h0yb7Ft2tsfFJqgENSPTotXlmFEfX6mLAf1lzdSYnOQIXObqO/xz1cFlTDFRVBW
         QGG0Tfj2XClewa7pwq1o6prtll8+tL/66OX1C/pKTskHjVg/fonUaNAaTjtg2tL/WHnZ
         C+AQ==
X-Gm-Message-State: AOJu0Yx3unUPDRTZY1SjcrD8t3peq7zFU/isM6i2HWege7vCYDnzo12A
	oOqZmfYKL2FanVmpGVTcntq33a6cQVREp9+5wm9ap6IKRjAS1Qq3gAbnmA==
X-Gm-Gg: ASbGncs70wsosgIIw1e+dfldJppW03hxByxhAHRNARiDUcVBuh+h11GwmWLAFXVlSNX
	/X72ggFp1nBd380WItGeQyRkCJJS2dHELeGBNz0VPHBnuBUzKKP1vIBsJv8d9vCYRkqqr0ERr4/
	CX/TAW2oxAZudV17RO4mlYD8AJWK+99c6xInCyPP/gyUStsdq0M4YrKqzrm+4VKCmZ1IxUYlU2g
	6RpMV/QVByQDCfMhBqfEjoWeApWUI2GLUOKokV6NAvAQrf3G9cqV+LZTuf+dsNJqcbe7HxXuJsH
	XT9i0vTCBrF+e76CdoPK1Cn5eoJVJ4bQQnVRJmlCu8kmZhTYNNTb
X-Google-Smtp-Source: AGHT+IENwRey2e3+xE87+DCb6uOso8mVb8VYEXci2nAWz5Yvp3NuZrKFeC3rKcVZLE7BidqoltrKlw==
X-Received: by 2002:a05:6808:190e:b0:3f9:73c5:6900 with SMTP id 5614622812f47-3ff0f526ca7mr7327666b6e.15.1743540023568;
        Tue, 01 Apr 2025 13:40:23 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ff051aa10bsm2100953b6e.23.2025.04.01.13.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:40:22 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/2] help: include SHA implementation in version info
Date: Tue,  1 Apr 2025 15:36:29 -0500
Message-ID: <20250401203630.285451-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401203630.285451-1-jltobler@gmail.com>
References: <20250328170121.157563-1-jltobler@gmail.com>
 <20250401203630.285451-1-jltobler@gmail.com>
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
 Documentation/git-version.adoc | 3 +++
 hash.h                         | 8 ++++++++
 help.c                         | 8 ++++++++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/git-version.adoc b/Documentation/git-version.adoc
index 80fa7754a6..f06758a7cf 100644
--- a/Documentation/git-version.adoc
+++ b/Documentation/git-version.adoc
@@ -22,6 +22,9 @@ OPTIONS
 --build-options::
 	Include additional information about how git was built for diagnostic
 	purposes.
++
+Note that the SHA1 options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_BLK` do not
+have collision detection.
 
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
index c54bd9918a..3aebfb3681 100644
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
@@ -768,6 +769,12 @@ char *help_unknown_cmd(const char *cmd)
 	exit(1);
 }
 
+static void get_sha_impl(struct strbuf *buf)
+{
+	strbuf_addf(buf, "SHA-1: %s\n", SHA1_BACKEND);
+	strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
+}
+
 void get_version_info(struct strbuf *buf, int show_build_options)
 {
 	/*
@@ -803,6 +810,7 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 #elif defined ZLIB_VERSION
 		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
 #endif
+		get_sha_impl(buf);
 	}
 }
 
-- 
2.49.0

