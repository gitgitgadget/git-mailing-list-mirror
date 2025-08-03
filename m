Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F0155CBD
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256272; cv=none; b=nL98Tg2XAKPCtYTpv1K2Nl50YV29MtO7Y4KtgwZlY0COME/vxsBFDSopuTic51R1MQrvcJfvW1rHqP2AFR25xnJcbl/aJMFUrvGjjyD1zu7IPZyvZuSOVlbMYtKtn8QUyEU6u7xwf2gVaMBWCA0xWjgwvfaahbZ47GqyGlZyjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256272; c=relaxed/simple;
	bh=dxBUs7/yxE/5D5Vj0atNgxF3WTAnTYc5pRB0+4nmUcE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=MMXzi53Q9Q/Xm2IQ5C4u+gtZZ/F4TEFsnIouh13CGzPZxP5ws7eG5uGa8KOMWsoOwlyMiIJPKO0zmTLwV6bbj6DkUxqhhXsAeGfShlGkyqbRvRpP8O2Uyrq7sTDtuD1gRRTtzN1zn+EWSMu6sDb/Ypt6K+c6cD9Tx0XoW9lQNFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDRwqd/i; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDRwqd/i"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af66d49daffso461073366b.1
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754256268; x=1754861068; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yEbeGkO1iSyXmX+dCyuQWM7Lr25Ewzm7sX3YKDSACDs=;
        b=UDRwqd/iXD9vTmjvhqwrITRqSTPmQWiW/JFmPC1jXYwseciITddpQx5AQPTqtYzEp2
         /+LyZlBR4ghI/jc2KBFwcH+yqk0q1q50VivlC0sxjyTuEP8MADSIRfrdzlKYdzFlGnKz
         20JWve7xHlgdvyEiS+3S4vld0DjZdA4KYnZw2DVjYA/kJC0XaIOtCPwdyg/xXF3Lt2tl
         sJagsnTeLitC1uoaYJML+AuHg7K7MX97J+vhijoFgYNQzEv9KOxMOpbvTRH2ipk6eydF
         h0inxTH6tQQU12fp1DrufhW53ZGm8wzsdTqGyKn7IKwndZoBZm055/su9dSSbNciUa6Z
         xFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754256268; x=1754861068;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEbeGkO1iSyXmX+dCyuQWM7Lr25Ewzm7sX3YKDSACDs=;
        b=GUcOla28M9wKwVM80UKRlrh+Y/nEHZkXUATGb/BHu559Q+zIAo+AflDKnciMu81yeK
         Lsf9BSFHmuxQ64PuJhcDfPDa69p62NrElFvKE5VN+MhOd4vH2Yk5Czpdy6AIC9b8FY7d
         VUYc22OMvUnTQD6Nn8nIicjQY+CYaMURJzCECE9QrR0Yvn8Yoo6oIGz76IQRQKsjMWzw
         q1oerILaq8ucggEwcsvq0RWlh3NEtseSH4JFhLiRpXd4z+ohPMdxWa0wvG5o+kMDOqN0
         ZBhbI+ZXxVIX8QfM4hBPQz9pTVPQcHhCUl/Wxpltmgcyqxuth+Kgz6nlRuDBDRY/2hFH
         L7oA==
X-Gm-Message-State: AOJu0Yx583KfPEiYhEeAoZ1LoDRtU/vkHrV/X0jLsNGnXA1nvST6GHlo
	YKyGB0ChLKqCwT8LR8TANzGkHJuJKics8aJh5IIcZfyFFw+bwobSym5QZMMA9w==
X-Gm-Gg: ASbGnctujNetXPXRz6J0Hn4RuFVdJoKcWv38rXQY5Ld2ikrmDQQ0DzloDq87lCKPCL+
	Af7Yuwv1ZNPe4cjAClvF/mlCcdl3f4s1afue7x3xxdgcGHH+lQCM6bhjmxhdY+ekWFssoLRa6bQ
	lT//gNeomD6HowVyiql7Zzzf3yY9h6BDAeJ0TPfDex5mXE/VMFI6iY6CVwJPjs2IT6BUP5fM4Ht
	JQNm9jC8bkAjJ2+bBVACvwycfCzqqg9dEOcgeBECM+tsxaC4wbrtMr0a1aUNv3O08z+BAfZCzNe
	GAZtn6JiJGOz15D320T5q3d7YdZZlF6udMO5LiyWg70/xyc6hVc4vG4UA8KSNkqNQjPd6n4SY7H
	45d6btGeeEN/BIVz3GgXdSjY=
X-Google-Smtp-Source: AGHT+IGAvny5Ck366onNS+KLcuewjO9dHPDlcM6hRsOK1duKQj3NVgidrFibveMUlctHys70q5/wmA==
X-Received: by 2002:a17:907:1ca2:b0:ae0:ab3f:36b5 with SMTP id a640c23a62f3a-af93ffb934emr746541966b.4.1754256268252;
        Sun, 03 Aug 2025 14:24:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af92a2ec9cbsm522204866b.79.2025.08.03.14.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 14:24:27 -0700 (PDT)
Message-Id: <pull.1947.git.1754256267117.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Aug 2025 21:24:26 +0000
Subject: [PATCH] cmake: accommodate for `UNIT_TEST_SOURCES`
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

As part of 9bbc981c6f2 (t/unit-tests: finalize migration of
reftable-related tests, 2025-07-24), the explicit list of
`UNIT_TEST_PROGRAMS` was turned into a wildcard pattern-derived list.

Let's do the same in the CMake definition.

This fixes build errors with symptoms like this:

  CMake Error at CMakeLists.txt:132 (string):
    string sub-command REPLACE requires at least four arguments.
  Call Stack (most recent call first):
    CMakeLists.txt:1037 (parse_makefile_for_scripts)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    cmake: accommodate for UNIT_TEST_SOURCES
    
    This fix is needed to build Git using CMake in the wake of the recent
    migration of the reftable tests from being regression tests written in
    Unix shell script to being unit tests in pure C.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1947%2Fdscho%2Freftable-vs-cmake-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1947/dscho/reftable-vs-cmake-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1947

 contrib/buildsystems/CMakeLists.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 25b495fa737..edb0fc04ad7 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1005,7 +1005,9 @@ parse_makefile_for_sources(clar-test_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "CLAR_
 list(TRANSFORM clar-test_SOURCES REPLACE "\\$\\(UNIT_TEST_DIR\\)/" "${CMAKE_SOURCE_DIR}/t/unit-tests/")
 add_library(clar-test-lib STATIC ${clar-test_SOURCES})
 
-parse_makefile_for_scripts(unit_test_PROGRAMS "UNIT_TEST_PROGRAMS" "")
+file(GLOB unit_test_PROGRAMS "${CMAKE_SOURCE_DIR}/t/unit-tests/t-*.c")
+list(TRANSFORM unit_test_PROGRAMS REPLACE "${CMAKE_SOURCE_DIR}/" "")
+list(TRANSFORM unit_test_PROGRAMS REPLACE ".c" "")
 foreach(unit_test ${unit_test_PROGRAMS})
 	add_executable("${unit_test}" "${CMAKE_SOURCE_DIR}/t/unit-tests/${unit_test}.c")
 	target_link_libraries("${unit_test}" unit-test-lib clar-test-lib common-main)

base-commit: 866e6a391f466baeeb98bc585845ea638322c04b
-- 
gitgitgadget
