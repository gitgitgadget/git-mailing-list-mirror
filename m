Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EC1C47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E2F613DF
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFFMGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 08:06:01 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:43762 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhFFMGA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 08:06:00 -0400
Received: by mail-wr1-f49.google.com with SMTP id u7so8717899wrs.10
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 05:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xUpoyi/EP+oYPLo23BB9sSu+ETCfoRKWS1iw6Jne+8Y=;
        b=ui092qIBp08BVjmUgRcampPjzoL5zCnKViMSd7F8hiTWR8ukP5Mss9cVUdTsvDCUPU
         wPqyODCx/eKHjljThzppQaPcwcKkQI+C0jB3Rcxn1WKPJy4sX0k2V4DDFmGVKDg+BxMO
         tHpWEDYqm8dg5i1sKyqkLxgg31nZXa42X3m9DXLvds5stIvEdSkU/0lhsg4vQ5grbflV
         vHJsDbtlgjc2fD2OoDOft85yk4dTvY7cC/jyRKFsfsG3mX+6MLmEOSfwQUVMA8PRF3cP
         sBPlN/mQ/K4PSDgw04/vVyPN1LQ18xt5glvDfSHf1PQkafcJ1Mp5KePfUYMnncBhvA1B
         MOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xUpoyi/EP+oYPLo23BB9sSu+ETCfoRKWS1iw6Jne+8Y=;
        b=CuNa2PN5NK1/OgQJkFksma2TTaMMwisR126VoWi9ZlanD8VUg1gLldXRWXgUBUEnMW
         C/TQR0T7yW81TpPtcwz7lED8sRpReDRwFaqbnx+UDW4e5e6k30rfo6QrwFkJFhTMYQF8
         1/0NidyShV0Jc6O1PlO6ytxIXK1/mDEYPy+ZwG6/EeJy4ewc9vaVViboGUpwvJsroPHh
         AlxliNIwgAKEchHX/MPEwPGysK4soME55zrgJerNGR26HiLJllPwSJ36jfWeCknoZnql
         xwhnYb3AhBUf3ul8pRabnNQx8bC1wq2v1PyF6Cv9Ml3Rx2j5gCMWb5+RXz3bmffpHxVy
         Llhg==
X-Gm-Message-State: AOAM530qBdsoycUCzQZVeHlvB4GefNCRET8YBr1Ih6MP9wr76OHNVFzX
        W+lXqeyD8BGVSdoMFGHmynT7sZZmHhQ=
X-Google-Smtp-Source: ABdhPJx5GZzkvD3XVpsG1awVTirPfJgktz+f+DeqlafzsMAOejZfOybIDLYDBS/kPvzGYjmnuVr0Iw==
X-Received: by 2002:a5d:440a:: with SMTP id z10mr12241032wrq.323.1622980976066;
        Sun, 06 Jun 2021 05:02:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm12324259wrr.48.2021.06.06.05.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 05:02:55 -0700 (PDT)
Message-Id: <pull.970.v2.git.1622980974.gitgitgadget@gmail.com>
In-Reply-To: <pull.970.git.1622828605.gitgitgadget@gmail.com>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Jun 2021 12:02:51 +0000
Subject: [PATCH v2 0/3] Make CMake work out of the box
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This pull request comes from our discussion here[1], and I think these
patches provide a good compromise around the concerns discussed there

1:
https://lore.kernel.org/git/CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKMRgi_oZAWw@mail.gmail.com/

CCing the people involved in the original discussion. cc: Philip Oakley
philipoakley@iee.email cc: Sibi Siddharthan
sibisiddharthan.github@gmail.com, cc: Johannes Schindelin
johannes.schindelin@gmx.de, cc: Danh Doan congdanhqx@gmail.com

Matthew Rogers (3):
  cmake: add knob to disable vcpkg
  cmake: create compile_commands.json by default
  cmake: add warning for ignored MSGFMT_EXE

 contrib/buildsystems/CMakeLists.txt | 37 ++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 9 deletions(-)


base-commit: c09b6306c6ca275ed9d0348a8c8014b2ff723cfb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-970%2FROGERSM94%2Ffix-cmake-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-970/ROGERSM94/fix-cmake-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/970

Range-diff vs v1:

 1:  3170f78daa5f ! 1:  485254b49de8 cmake: add knob to disable vcpkg
     @@ Commit message
              generators.
      
            - Some versions of Visual Studio 2019 moved away from using the
     -        VS 2019 by default, making it impossible for Visual Studio to
     -        configure the project in the likely event that it couldn't find the
     -        dependencies.
     +        VS 2019  generator by default, making it impossible for Visual
     +        Studio to configure the project in the likely event that it couldn't
     +        find the dependencies.
      
            - Inexperienced users of CMake are very likely to get tripped up by
              the errors caused by a lack of vcpkg, making the above bullet point
              both annoying and hard to debug.
      
     -    As such, lets make using vcpkg the default on windows.  Users who want
     +    As such, let's make using vcpkg the default on windows.  Users who want
          to avoid using vcpkg can disable it by passing -DNO_VCPKG=TRUE.
      
          Signed-off-by: Matthew Rogers <mattr94@gmail.com>
     @@ contrib/buildsystems/CMakeLists.txt: NOTE: By default CMake uses Makefile as the
       set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
      -if(WIN32)
      +
     -+if (WIN32 AND NOT NO_VCPKG)
     -+	set(USING_VCPKG TRUE)
     -+else()
     -+	set(USING_VCPKG FALSE)
     ++option(USE_VCPKG "Whether or not to use vcpkg for obtaining dependencies.  Only applicable to Windows platforms" ON)
     ++if(NOT WIN32)
     ++	set(USE_VCPKG OFF CACHE BOOL FORCE)
      +endif()
      +
     -+if(USING_VCPKG)
     ++if(USE_VCPKG)
       	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
      -	if(MSVC AND NOT EXISTS ${VCPKG_DIR})
      +	if(NOT EXISTS ${VCPKG_DIR})
     @@ contrib/buildsystems/CMakeLists.txt: endif()
       find_program(MSGFMT_EXE msgfmt)
       if(NOT MSGFMT_EXE)
      -	set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
     -+	if (USING_VCPKG)
     ++	if (USE_VCPKG)
      +		set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
      +	endif()
       	if(NOT EXISTS ${MSGFMT_EXE})
     @@ contrib/buildsystems/CMakeLists.txt: file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-O
       file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
       file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SUPPORTS_SIMPLE_IPC='${SUPPORTS_SIMPLE_IPC}'\n")
      -if(WIN32)
     -+if(USING_VCPKG)
     ++if(USE_VCPKG)
       	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
       endif()
       
 2:  c3bf266cf03a ! 2:  a3b5eef54188 cmake: create compile_commands.json by default
     @@ Commit message
          time of this writing, and no real negative consequences that I can find
          with my search-skills.
      
     -    NOTE: That the comppile_commands.json is currenntly produced only when
     +    NOTE: That the compile_commands.json is currently produced only when
          using the Ninja and Makefile generators.  See The CMake documentation[3]
          for more info.
      
     @@ Commit message
          Signed-off-by: Matthew Rogers <mattr94@gmail.com>
      
       ## contrib/buildsystems/CMakeLists.txt ##
     -@@ contrib/buildsystems/CMakeLists.txt: else()
     - 	set(USING_VCPKG FALSE)
     +@@ contrib/buildsystems/CMakeLists.txt: if(NOT WIN32)
     + 	set(USE_VCPKG OFF CACHE BOOL FORCE)
       endif()
       
     -+if (NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
     -+	SET(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
     ++if(NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
     ++	set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
      +endif()
      +
     - if(USING_VCPKG)
     + if(USE_VCPKG)
       	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
       	if(NOT EXISTS ${VCPKG_DIR})
 3:  07763a9de723 ! 3:  2110c8ffa423 cmake: add warning for ignored MSGFMT_EXE
     @@ Commit message
          configured, as such add a check for NO_GETTEXT before attempting to set
          it.
      
     -    suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Matthew Rogers <mattr94@gmail.com>
      
       ## contrib/buildsystems/CMakeLists.txt ##
     @@ contrib/buildsystems/CMakeLists.txt: if(WIN32 AND NOT MSVC)#not required for vis
       
      -find_program(MSGFMT_EXE msgfmt)
      -if(NOT MSGFMT_EXE)
     --	if (USING_VCPKG)
     +-	if (USE_VCPKG)
      -		set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
      -	endif()
      -	if(NOT EXISTS ${MSGFMT_EXE})
     @@ contrib/buildsystems/CMakeLists.txt: if(WIN32 AND NOT MSVC)#not required for vis
      +else()
      +	find_program(MSGFMT_EXE msgfmt)
      +	if(NOT MSGFMT_EXE)
     -+		if (USING_VCPKG)
     ++		if(USE_VCPKG)
      +			set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
      +		endif()
      +		if(NOT EXISTS ${MSGFMT_EXE})

-- 
gitgitgadget
