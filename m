Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2313A89E
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045050; cv=none; b=NRDicrpy6vwpjtByUXI+ZltWqRiMNdFD+SZwayj9k75I4rsBn6eycsPyDXVs3zz3z+aVtERq21TN0bsdA3qWamdHULSrNawwEa5Xxq1NmPzbFvoqDds1e3PYT/8vj4Pkm3uJfmtgjTmzI7uQJH0cp8ibGlWxBHBi6T/RH83KDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045050; c=relaxed/simple;
	bh=tYPUgnykpxDJV0/nqpibvG6hfcwF5k9ycQDsWDDIxio=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Rdug2BdwHU/vPE2xKr8otBTvrgI94W9KmmDl8hV8LsdHPBp7bIA6lNklSz2cB6o38Po6OgWa8JrDV2meMVQTkTgt19uKK5YVhxMg+YTPvnHhBFyBlHCTYJUg0yjRtvvPEoFgpHuWSFDRt4+PMvxEDpwYBAG/3EWFWnvEH/a+1T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk+yL0Id; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk+yL0Id"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412ae087378so4854825e9.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709045046; x=1709649846; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LykhM71dTMu7oTSfSDdnQ/64eKNxQ8n9iGVER5RrVq8=;
        b=Sk+yL0IdMBdTfSgBcOZcXpIt/MYIegnWnegGcgxr+m0eAHyXYwwmZJJVqphSgUxpcF
         5Z8/H4laGaAK3UhtZxSfVc341mTmNzRLE8c/alAX4Cb0a+EvFBGfSzOjyMwUoNVeUw/1
         ci/7qpffe5UpzYq4t99dpyBFZf/Dlo+D+6qff2DCAIMyz59WnUJi+JfRFY1n60l4OMrI
         3h8AoKldO76z45ZfDUwWPWEO8GBuELEG70GO5CR4GVYpt2lQR23N9yEGa4Gx7ki531p3
         IhHiShUWY5VwaJ9z1+tRmCptZ0pJMA1cZRLkEMkQbSOa8N0yYLKnf73iJNcCAd3W4Dd+
         Go+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709045046; x=1709649846;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LykhM71dTMu7oTSfSDdnQ/64eKNxQ8n9iGVER5RrVq8=;
        b=RnUzC/5fMdZ0Pio1R7jb4N8uN7vSTwC3Aty3RzuIpCRvTEieAQpZAjeGlo6fE+qz1i
         NBgciX4L5EEM53wKRBdxGYMBoZfNZICL4vP8muAYUdRyo9rOjRoTbvzFC+A3LOtN/r8m
         ftBwpHml/5ucyBykVXVej+sOTJWkmnz6DfhKRXKOCdYdZAjIe4gvKrsvDMd02zHcLa5m
         QgIVNqycSJ4L6DrPHfxPX7E3LJT9M5T4F0YcwQK57YdpzkQnuD8dBjybYNv+A1chh1Vw
         3fXzhOSvhkwg2NcZb3ZKTJAUHABCTb0N8r/vwnfTvbYKwdIyz49SGHmjNXxK8IwdNua2
         euBg==
X-Gm-Message-State: AOJu0YzlXhzFNAPpOy1uXT0mTDJrs+QJ0Hu/PAE2xLUybKR2UvPhA8Zx
	a2N0AgQJ75T0Qo8u4ezB/BHxRQIcILyzHr0OsU/Uh+29PvKRYikTg8DPe9Zl
X-Google-Smtp-Source: AGHT+IFx/CuqDg3k61lNsbAX3r4/akILtzjlPR7A5FCHfQjM+TZLDygcGDEXQ1UW6KGA93iP9Csuow==
X-Received: by 2002:a05:600c:1553:b0:412:a206:ad3c with SMTP id f19-20020a05600c155300b00412a206ad3cmr4671563wmg.3.1709045045923;
        Tue, 27 Feb 2024 06:44:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b00412a3420e71sm7909890wmo.0.2024.02.27.06.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:44:05 -0800 (PST)
Message-ID: <pull.1677.git.1709045045235.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 14:44:04 +0000
Subject: [PATCH] cmake: adapt to the Git Standard Library
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

In the commit "git-std-lib: introduce Git Standard Library" of the
`cw/git-std-lib` topic, the Makefile was restructured in a manner that
requires the CMake definition to follow suit to be able to build Git.

This commit adjusts the CMake definition accordingly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    cmake: adapt to the Git Standard Library
    
    The usual CMake adjustments. This is based on cw/git-std-lib.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1677%2Fdscho%2Fcmake-vs-git-std-lib-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1677/dscho/cmake-vs-git-std-lib-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1677

 contrib/buildsystems/CMakeLists.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 804629c525b..6f46f8f9070 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -676,10 +676,12 @@ include_directories(${CMAKE_BINARY_DIR})
 #build
 #libgit
 parse_makefile_for_sources(libgit_SOURCES "LIB_OBJS")
+parse_makefile_for_sources(std_lib_SOURCES "STD_LIB_OBJS")
 
 list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+list(TRANSFORM std_lib_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
-add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
+add_library(libgit ${libgit_SOURCES} ${std_lib_SOURCES} ${compat_SOURCES})
 
 #libxdiff
 parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")

base-commit: c9e04a1e1f954dd60b1373f75b710f64d34e502b
-- 
gitgitgadget
