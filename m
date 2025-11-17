Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E234B662
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763412020; cv=none; b=G7TTU3MsATKhBl52rwJy7VYd6HFSZLXSMQACxuTESi3XoZgu94RsrOgmlZ36oQd4u46TxRnKL93Cwj1kesVs8NSxtinZ3GJdVrW+GTOW4avhm54tvs1baERDk5r2PGR/2q7NvGrWKuCcw8IA8EV0h1tpJcxm6AWZh54NKj9YJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763412020; c=relaxed/simple;
	bh=gJyGJwh4p1T7YIHVd9sLcmNd/wDOV3t5rUPyPUg9/y8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=gfGayb8QEE7HuzlPcPeLul5i6EhFJNXWNe6ikBtKQWNLWQKgzXWSaNQpxBI8e1Kx0J8E8EeJfEV2qz1OmzKaBs2DOdmYfZb2mzuEGdlM5s9wNnK1DEW3FVKGTh79xBJGWHMg+MTLy4x4GdAvI/LFmya/s083Zy7BX8GT/TnQtz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMFemRPQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMFemRPQ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso2800658b3a.0
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 12:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763412010; x=1764016810; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zmpoqYFY6T+OS+5vWmTvxcu1e6Z0nQEuEeP5vjC3gio=;
        b=NMFemRPQVZuNjInFNjXvQ3KoqyD1t8dfZheFNp/andFzdXwlhp0MAsxqxaVWT924b1
         9H4/hWN9OKJB87J+lxmBGhoiOocr/aB+0IuaiaI7t/2FM7ftRZl+Qoe5RkUnAmu0Jp6k
         QvhlhHR/t9EpcjfiAWtFvpyYegyFNcOggJv+MW7bkEcLa61Pp7C2OCMuDst17uUdCeLs
         KGiDlsj/sYrKj8cm+fBpt66xZOny/xP5E/05d+iZN/e9ZGCWL20oeAIBkXf2ayvkcHEf
         2AMs69ZC71l50O3quOvBpKjoOzQLXI6ABdpctxYXvnXMtCueH6qIt4YpqMXAuWD9yHiF
         zngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763412010; x=1764016810;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmpoqYFY6T+OS+5vWmTvxcu1e6Z0nQEuEeP5vjC3gio=;
        b=kiMTfoVr1jQYP8DB75CywNTen/xODgwAUAb6qFWJgKSb/MD2oCLMAGd7cOGS/nSPpl
         R+ngbrCAprRcSPe17f0LbUXnyGkfWjFvBEqWVhvpY2j3Zz8rmq/B1QLDCaiY4mgnr2Bm
         dU6z29v8heal56+3yViZ1WzZCqSz/LX8zk2lrrYRUwdm8Chb587nBWq/SF4RYdcsVwqJ
         30JKO8lSPEpovvvd65+z5iVBaTpR3Do31RCmAkNsVlKyn3MeaLA0qSJp/bH4rrdLbv7a
         n0OOhRy2Zt1VySiazvR72sMfP/tTGs8j9nxhMicyhLsNYi4ZqI1tcdHdaGqgVLrsDhDy
         P2Uw==
X-Gm-Message-State: AOJu0YxFvcLOrO1Sh28MPx6B/v2jW0RSdW8WDtmNqWeyhy3nRDocfOq6
	eURigNesvGzm/+5G/5Ui4sgTt/1+s/Ngkeq/V2foC1IE40Q6kCIDWamgZtnkWg==
X-Gm-Gg: ASbGnctpsYcA61W4nHC8Efiy0bQ8cO+yUUv770jnVZXFoQ7RtMQGfQfJb3FRl2RNM1/
	3GqqEtos2kkMPqzuC9IcnBb/31KmPkeJ/99+dUB98Cl79QyqdBR8OpeA1KpjpQ10U+s6KZ+6ol0
	MrT0DSJMG4lU4qcv90FudvBaP640CtxYyK/22XwG0dbVZFXTX5l7zCio/4KBPJ5QeLZY4ilQyGU
	7EUBsOmcyJO6hsu6zwATdMWtj86NzWmDcDyVCdouj8+TysBrcTWs/qo1CuMt0OepsCD4N2fUFhM
	ZvPpPUn1R5g+OAglzhskS+MOjhZMjvFXwGUUtcRERvGIZwDCl8PE+eB/ajL1Yy5Bsn5zvxYNsGi
	p6i+DQ6aZ62Q3weRuqcRsyjI1/aWo1o9YYUinqqi/GKlcljIog2ljgSMOyY02XpL2oeeEI4H8m/
	Ap19RMABthWDXtfVycDxQGvZuY
X-Google-Smtp-Source: AGHT+IGsEPF7eF5pINdb4aDnXZjsvpFTMitlqDWjSvxQ7iBoXr+Jqbhh5Q8oYibcnvP8WuOFFN2P9w==
X-Received: by 2002:a05:7022:43a9:b0:11b:f271:835a with SMTP id a92af1059eb24-11c74885b6dmr390091c88.3.1763412010247;
        Mon, 17 Nov 2025 12:40:10 -0800 (PST)
Received: from [127.0.0.1] ([128.24.163.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088625sm52854182c88.8.2025.11.17.12.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 12:40:09 -0800 (PST)
Message-Id: <pull.2006.git.1763412008722.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Nov 2025 20:40:08 +0000
Subject: [PATCH] cmake: stop trying to build the reftable and xdiff libraries
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

In the `en/make-libgit-a` topic branch, more precisely in the commits
f3b4c89d59f1 (make: delete REFTABLE_LIB, add reftable to LIB_OBJS,
2025-10-02) and cf680cdb9543 (make: delete XDIFF_LIB, add xdiff to
LIB_OBJS, 2025-10-02), the strategy to build three static libraries was
rethought, and instead only one static library is now built.

This is good.

However, the CMake definition was not changed accordingly, and now
CMake-based builds fail thusly:

  [...]
  Generating hook-list.h
  CMake Error at CMakeLists.txt:122 (string):
    string sub-command REPLACE requires at least four arguments.
  Call Stack (most recent call first):
    CMakeLists.txt:711 (parse_makefile_for_sources)

  CMake Error at CMakeLists.txt:122 (string):
    string sub-command REPLACE requires at least four arguments.
  Call Stack (most recent call first):
    CMakeLists.txt:717 (parse_makefile_for_sources)

  -- Configuring incomplete, errors occurred!

Fix that by removing the parts that expect the reftable and xdiff
objects to be defined separately in the Makefile, still.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    cmake: stop trying to build the reftable and xdiff libraries
    
    This was needed to be able to pass the CI builds of Git for Windows
    v2.52. With all the Windows build problems observed in the win+Meson job
    in seen lately, it might become unsustainable to also keep taking care
    of the CMake definition. But then, the same might be said about the
    Windows part of the Meson build definition.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2006%2Fdscho%2Fadjust-cmake-to-xdiff-and-reftable-merge-into-libgit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2006/dscho/adjust-cmake-to-xdiff-and-reftable-merge-into-libgit-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2006

 contrib/buildsystems/CMakeLists.txt | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index edb0fc04ad..479163ab5c 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -679,18 +679,6 @@ list(APPEND libgit_SOURCES "${CMAKE_BINARY_DIR}/version-def.h")
 
 add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
 
-#libxdiff
-parse_makefile_for_sources(libxdiff_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "XDIFF_OBJS")
-
-list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
-add_library(xdiff STATIC ${libxdiff_SOURCES})
-
-#reftable
-parse_makefile_for_sources(reftable_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "REFTABLE_OBJS")
-
-list(TRANSFORM reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
-add_library(reftable STATIC ${reftable_SOURCES})
-
 if(WIN32)
 	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.rc
 			COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
@@ -720,7 +708,7 @@ endif()
 #link all required libraries to common-main
 add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)
 
-target_link_libraries(common-main libgit xdiff reftable ${ZLIB_LIBRARIES})
+target_link_libraries(common-main libgit ${ZLIB_LIBRARIES})
 if(Intl_FOUND)
 	target_link_libraries(common-main ${Intl_LIBRARIES})
 endif()

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
gitgitgadget
