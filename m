Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD04E0202
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610700; cv=none; b=nmbyw/9pg9NHob8+s372J3cW6JPkc4ZGXG1MxksYSaFfZ52q7dXzZDinMdS6hP9MFZF8Fcsl20tdyTGIW2nG6FF8OGABhqiEJnF02DuLUm89g3FDxshQ4Ytfo9jE7XFmgyQYlMKB6aIVaI11XnLzjaEiyVaw3aRSVaAXaDrWcbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610700; c=relaxed/simple;
	bh=st2I5OW8Jtz3miNPjagTcOL2nFS5GGPsGDFmOM3CeXY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fdNb7aYDO0gZlJUut0iRpjONDFojXitetbPOGIQjJaPBTGmgGL5xEJ8Zc9miLciNCRLvCYhyH4Kx5wIATNouQmmGgPafUY/fkL3fx79okk//9eaSEELUBwoIDfj2iXY0O8hYFmwDrnFJuTcnGhaT34SotimdWOxQ6u+KIqc6mfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgOrAK1Y; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgOrAK1Y"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db22383fe8so12396975ad.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610699; x=1791215499; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ljEXt4oiCp43iaOrqNjNtqvtI9I4YeqI/YC9EdfruAg=;
        b=NgOrAK1YDNrxPKRHrUvRRX8BTxlxtnmMOl1AKqT+4RCDY95WiCNp1bgpE8jLzg3I6W
         7LssFtZW5/hgnU6uEGM1C63tmNLHrtT0tjDBKOc2qjtzIGuoNsKr8ATzSNxTrW0Zb+NI
         0WoBpc+8jCKGb/lAyheE1/LY66w7a+k6lEWg//5YJDCvr41OQTO4vojiLZPfY19s3Dji
         xffJ7pSYHf770Fs+uD7jhNnZgerSKxLrPfgl1ap++6VTkI7QWeWsXdyTaDPJcIWIIxzj
         cvJ3FJZEkVyTQ+vprUUQhvrwZFg5snrd7nPixqYnuoqeIJPVVpMiJJNKRURdSbXYfMjh
         D2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610699; x=1791215499;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ljEXt4oiCp43iaOrqNjNtqvtI9I4YeqI/YC9EdfruAg=;
        b=HW4qTeWZDH/QwTrfuThu0dob7ZQc/bXUd9WJB/+SlaMasLRS4kCMndPHRTbBvpezSV
         px0yIlBaQ026Qb0AcqT8abA1AjosJdJ5WZTXyrxNTdpHKBTI0Os9ohSBfH03k5aTsfs0
         d+0XwoR3IazlSPyrSgC6O6h5mZesini1XoYM+qfpUEqAyYD1MGdDXVPL88J5Xk9F3Hgf
         1gnjagXy32QBl6zlaNpPleYuDUCdxtvQuxR/5r2olP1fJ6ou8iFRLO0WYQ3EPGuM8amw
         N+TuxSjM643VbOgdeWwCMX0Fpx3PymhP3tHSiRvP5ckhTnpv68vrgCcs84zb+pK6RoZC
         ZrKQ==
X-Gm-Message-State: AFq9FYIWULVTxJ/idNceTEbrrRhCl/U2wclblivVbRYcWOe1/BzijLhI
	TQvcV2tdzXL+59zyvMhp1qQstrvcCZoG1ESIMX2Mk831HK1DL830zQr5OblanN5+
X-Gm-Gg: AYBFou1a5khLDnNtXK8HjcwpGm/cubBMVigNQdFdAN5RMKt1o7xbjk+XPFBLaXE4KW4
	mchMtRYszo7sf4jQaRnUTqLZmVDQ5CIhPttVuwbpewfgDEp053WeIJq/F1JQXVBWiyem8ex+uzb
	MmN2j3/35GhGuQenXG8lj5kBHDk0C1iBixpD92tnSctPwWw0O16vC9QwJ+xjlx7z/AVUj9FOFu8
	KmJU2GalR8WaVFq7j/tKMYX+iuSKxT7d5dvsXPWzAHySpNv7l/reh9+8qgCGjhmW2pL+tGyDExI
	B0pQ+hkxbPFBOKpysSayErSnYLowd4v0jpHmXpTxamRfp4GfS3kE2KY9OoIldGPuqFOB4KQGiSy
	lpVy9IKM26YqZ6syzb1gxCRt0p3dKtWTB/tebfn78TZK17PkUMp2chTLm8rimxiGisrSEl6/0Cf
	fpgt3+CQdq2ESskOxLzEIsZCHv5DL3scu77ErDKHO2OkDiermSbUnobeLV0t6STuAyE2rYP9uSf
	Q==
X-Received: by 2002:a17:902:d98e:b0:2dd:c0ff:e726 with SMTP id d9443c01a7336-2df7dfd637fmr110300985ad.56.1790610698702;
        Mon, 28 Sep 2026 08:51:38 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.102.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913e032bsm44830435ad.27.2026.09.28.08.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:51:38 -0700 (PDT)
Message-Id: <aac6a83a8ebd91f33cbe2074245b6d45cb264105.1790610691.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2240.git.1790610691.gitgitgadget@gmail.com>
References: <pull.2240.git.1790610691.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 15:51:31 +0000
Subject: [PATCH 4/4] sha1dc: make `sha1dc_init()` thread-safe
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `sha1dc_init` function pointer initially points to a function that
determines which sha1dc backend to use. Naturally, this initialization
should only run once.

To allow for that function to be called concurrently in multiple
threads, we need to use a pthread primitive to ensure that the
`sha1dc_*()` function pointers are initialized exactly once.

Unfortunately, this requires quite a bit of non-DRY code to prevent data
races when different threads run `initial_init()` concurrently (see
https://en.cppreference.com/c/language/memory_model#Threads_and_data_races).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sha1dc_git.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 7 deletions(-)

diff --git a/sha1dc_git.c b/sha1dc_git.c
index dcc5c1ca8e..eba62b12ab 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -7,6 +7,7 @@
 #ifdef DC_SHA1_RS
 #include "config.h"
 #include "repository.h"
+#include "thread-utils.h"
 #endif
 
 #ifdef DC_SHA1_EXTERNAL
@@ -58,16 +59,21 @@ static void sha1dc_c_discard(SHA1_CTX *ctx UNUSED)
 }
 
 /* The first SHA-1 initialization must precede concurrent hashing. */
-static void sha1dc_choose(SHA1_CTX *ctx);
+static void initial_init(SHA1_CTX *);
+static void initial_clone(SHA1_CTX *, const SHA1_CTX *);
+static void initial_update(SHA1_CTX *, const void *, size_t);
+static void initial_final(unsigned char [20], SHA1_CTX *,
+			  void (*die_fn)(const char *, ...));
+static void initial_discard(SHA1_CTX *ctx);
 
-void (*sha1dc_init)(SHA1_CTX *) = sha1dc_choose;
-void (*sha1dc_clone)(SHA1_CTX *, const SHA1_CTX *);
-void (*sha1dc_update)(SHA1_CTX *, const void *, size_t);
+void (*sha1dc_init)(SHA1_CTX *) = initial_init;
+void (*sha1dc_clone)(SHA1_CTX *, const SHA1_CTX *) = initial_clone;
+void (*sha1dc_update)(SHA1_CTX *, const void *, size_t) = initial_update;
 void (*sha1dc_final)(unsigned char [20], SHA1_CTX *,
-		     void (*die_fn)(const char *, ...));
-void (*sha1dc_discard)(SHA1_CTX *);
+		     void (*die_fn)(const char *, ...)) = initial_final;
+void (*sha1dc_discard)(SHA1_CTX *) = initial_discard;
 
-static void sha1dc_choose(SHA1_CTX *ctx)
+static void sha1dc_choose(void)
 {
 	const char *backend;
 	int use_c = 0;
@@ -86,6 +92,49 @@ static void sha1dc_choose(SHA1_CTX *ctx)
 	sha1dc_final = use_c ? git_SHA1DCFinal : sha1dc_rs_final;
 	sha1dc_discard = use_c ? sha1dc_c_discard : sha1dc_rs_discard;
 	sha1dc_init = use_c ? git_SHA1DCInit : sha1dc_rs_init;
+}
+
+static pthread_once_t once = PTHREAD_ONCE_INIT;
+
+static void initial_init(SHA1_CTX *ctx)
+{
+	int ret = pthread_once(&once, sha1dc_choose);
+	if (ret)
+		die("cannot initialize SHA-1 backend: %s", strerror(ret));
 	sha1dc_init(ctx);
 }
+
+static void initial_clone(SHA1_CTX *dst, const SHA1_CTX *src)
+{
+	int ret = pthread_once(&once, sha1dc_choose);
+	if (ret)
+		die("cannot initialize SHA-1 backend: %s", strerror(ret));
+	sha1dc_clone(dst, src);
+}
+
+static void initial_update(SHA1_CTX *ctx, const void *buf, size_t len)
+{
+	int ret = pthread_once(&once, sha1dc_choose);
+	if (ret)
+		die("cannot initialize SHA-1 backend: %s", strerror(ret));
+	sha1dc_update(ctx, buf, len);
+}
+
+static void initial_final(unsigned char hash[20], SHA1_CTX *ctx,
+			  void (*die_fn)(const char *, ...))
+{
+	int ret = pthread_once(&once, sha1dc_choose);
+	if (ret)
+		die("cannot initialize SHA-1 backend: %s", strerror(ret));
+	sha1dc_final(hash, ctx, die_fn);
+}
+
+static void initial_discard(SHA1_CTX *ctx)
+{
+	int ret = pthread_once(&once, sha1dc_choose);
+	if (ret)
+		die("cannot initialize SHA-1 backend: %s", strerror(ret));
+	sha1dc_discard(ctx);
+}
+
 #endif
-- 
gitgitgadget
