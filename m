Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D1EC433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 04:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiEREDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 00:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiEREDu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 00:03:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205D143395
        for <git@vger.kernel.org>; Tue, 17 May 2022 21:02:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t6so850540wra.4
        for <git@vger.kernel.org>; Tue, 17 May 2022 21:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Zsy1x22sxPzHhbviyXdX6v3rpQh3Kip9v1QmmOH4QEw=;
        b=St5u5HNzpSmJMERNl9H9K9yDO3wWjJnRuJTC+91B8aR7bElTllcSz9O2zdgDO87+lx
         yGeDwcGkRScWFpIF+awFR6cwqSkm99sboTy0Eb60uMlTgINbOzl7WQy4AuChVWrhi58T
         gmNEeh69td0BqxC+igzc34u7NSb7x9+bLOuWRu2xIy+/XYUxi1RnhvYOlWDQX99BzfgX
         WoynNwzA9QV4ahbxKUKVZUwQDQ81DFTM7m+0qmiHWBNst5sW7t3WAb/PLnVGu16HG0k8
         guwEytL0DNHjpGBZvwjOKVVGzPRhXLGHLMlxsu+BANLjohr1ZgXwHo3CceoUhuo/8Puh
         D+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zsy1x22sxPzHhbviyXdX6v3rpQh3Kip9v1QmmOH4QEw=;
        b=bd9PK7RnYa095B54U151wpVvJ1gzXf60osin7OrXFOg7Cid7ah/eOCwCRptGYvtAQF
         lxUjY1HQ0tXyYYSRJAfP87osJZFMSO43HxwoyQN7gIwjw/I+9bcwI7TQNMdNTCe1qngO
         rRZ5eIm7/FdZOfiTELKJI4hxNS7ubJVj1+uY/tyivYHfHGU2loN+xWJa1G0h8n98MQaH
         gLOppPmLBYkn6KEYYJa9kV9JKz4iYvmWrrUWi6vn4mLHB8YlqwvSSJfzKznS9PMboujA
         6ttwYeMtqCaNhtnOauGPAGUdtdFwZ28jt3JmOGQOGU9k/gm+ntjfhDX/Oy7/rILIJ2Tj
         mxkQ==
X-Gm-Message-State: AOAM533PwKvgAi99gdascIh8Gg2WCLRGl5S6oADgH/lf0mVRsPjjoQ4x
        Xktr9dEQZNxWB9VpVFRd8Wu+zCcTYTg=
X-Google-Smtp-Source: ABdhPJwLJvcJidYYQoUoF2UG0aHfYEA/lQ+IC5CO/V7W15BMj25svCwqpuWd/tfLoC34hU1H9d+sBQ==
X-Received: by 2002:adf:ed0e:0:b0:20d:fd3:de77 with SMTP id a14-20020adfed0e000000b0020d0fd3de77mr8402957wro.213.1652846306819;
        Tue, 17 May 2022 20:58:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2-20020adfab02000000b0020c5253d8edsm694919wrc.57.2022.05.17.20.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 20:58:26 -0700 (PDT)
Message-Id: <pull.1267.git.git.1652846305514.gitgitgadget@gmail.com>
From:   "Yuyi Wang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 May 2022 03:58:25 +0000
Subject: [PATCH] Add pcre2 support for cmake build system.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Yuyi Wang <Strawberry_Str@hotmail.com>,
        Yuyi Wang <Strawberry_Str@hotmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Yuyi Wang <Strawberry_Str@hotmail.com>

This commit fixes one of the TODOs listed in the CMakeLists.txt.

There's also some small fix to ensure it builds successfully.

Signed-off-by: Yuyi Wang <Strawberry_Str@hotmail.com>
---
    Add pcre2 support for cmake build system.
    
    Pcre2 is dealt with pkg-config.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1267%2FBerrysoft%2Fcmake%2Fpcre2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1267/Berrysoft/cmake/pcre2-v1
Pull-Request: https://github.com/git/git/pull/1267

 contrib/buildsystems/CMakeLists.txt | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 185f56f414f..99d6cb963c4 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -54,7 +54,7 @@ set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
 
 option(USE_VCPKG "Whether or not to use vcpkg for obtaining dependencies.  Only applicable to Windows platforms" ON)
 if(NOT WIN32)
-	set(USE_VCPKG OFF CACHE BOOL FORCE)
+	set(USE_VCPKG OFF CACHE BOOL "" FORCE)
 endif()
 
 if(NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
@@ -108,7 +108,6 @@ project(git
 
 #TODO gitk git-gui gitweb
 #TODO Enable NLS on windows natively
-#TODO Add pcre support
 
 #macros for parsing the Makefile for sources and scripts
 macro(parse_makefile_for_sources list_var regex)
@@ -160,6 +159,14 @@ if(NOT (WIN32 AND (CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID ST
 	find_package(Intl)
 endif()
 
+find_package(PkgConfig)
+if(PkgConfig_FOUND)
+	pkg_check_modules(PCRE2 libpcre2-8)
+	if(PCRE2_FOUND)
+		add_compile_definitions(USE_LIBPCRE2)
+	endif()
+endif()
+
 if(NOT Intl_FOUND)
 	add_compile_definitions(NO_GETTEXT)
 	if(NOT Iconv_FOUND)
@@ -180,6 +187,9 @@ endif()
 if(Intl_FOUND)
 	include_directories(SYSTEM ${Intl_INCLUDE_DIRS})
 endif()
+if(PCRE2_FOUND)
+	include_directories(SYSTEM ${PCRE2_INCLUDE_DIRS})
+endif()
 
 
 if(WIN32 AND NOT MSVC)#not required for visual studio builds
@@ -277,7 +287,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 
 elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
 	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
-	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c)
+	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c compat/linux/procinfo.c)
 endif()
 
 if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
@@ -700,6 +710,9 @@ endif()
 if(Iconv_FOUND)
 	target_link_libraries(common-main ${Iconv_LIBRARIES})
 endif()
+if(PCRE2_FOUND)
+	target_link_libraries(common-main ${PCRE2_LIBRARIES})
+endif()
 if(WIN32)
 	target_link_libraries(common-main ws2_32 ntdll ${CMAKE_BINARY_DIR}/git.res)
 	add_dependencies(common-main git-rc)

base-commit: 277cf0bc36094f6dc4297d8c9cef79df045b735d
-- 
gitgitgadget
