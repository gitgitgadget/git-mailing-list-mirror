Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9625C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 10:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJRK7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 06:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJRK7R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 06:59:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954DDB1DED
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 03:59:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y10so10465368wma.0
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 03:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pfgl4E0nDpcq6VgmFXsgjzOUpD0wiXOTzccdHRZVp5o=;
        b=TVCtrXnJorAY3qgoCgpYwqHuWeGyA/YwxDHvTPt9dMWLIJDXJnqFLQE108zVZNxIF1
         MeTdPPBRmr3Hy8wDzJnHLS2kRby2y9jMzkQ1NSWCXyeGN0rWp5bLZ2iva/d6SUZC9svm
         rCqznMVox6Zo++1WpzKgaK08leqlPLahVbYm904f2QNGrgg6eGk3c3Ds6wNdnmLmBeTk
         2ZC8pTtJzVLTUTTQm+cEqIHHKm/+axNZOlH/AK4kMj87O7KWTufNfWx0Qyjx0Q0P64SU
         tXrZpElK9qr7s3Yw6uqAqodZVrtQFncavmpfMHTe+HVtvG0gz+JBWqdMPn3XB8SHIKT6
         KBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pfgl4E0nDpcq6VgmFXsgjzOUpD0wiXOTzccdHRZVp5o=;
        b=uinQCpWKH2NDSK3Hh6HrsAT71qT1qJOFKaA5oAnorAOaHU9yeRKcxmTvcL3x+OkQA0
         cUMzP6A77AtNssRe/BxdaET7bHyKiFV7YoZR8fOj3yvLJtKDDsbxY7wwU0u+Zd+tU+VV
         bW/ojAezf24TKhllpDRTyhZopD9tYLOzkuOre6B3n2Lgrln8yy5efPxMj8cE2z0KQSW+
         QVjNx4RgupiwVT4Id4PP+rOt+SQdKEC7EnFGx4hIkeCuchjnYyXxSyc2PTY1a5AXBYe/
         9xD+w9g1dxnEsrkWUMViQF6GuQGgGC+/Hk0wZTk5Wc5XSknmpemq0rHEv59T9Ex3mjiG
         Ns+w==
X-Gm-Message-State: ACrzQf30sLBXTS6q+FjqFuAyWTCg0u3gsk2H6xbTbX+Z6QcRSOwk80uq
        H10oCtv9na3YpQ/yvGhclvk4CRn72Ck=
X-Google-Smtp-Source: AMsMyM7FPe03gDfq4gd7n4gNV155Yk4Zrv4uP+ZXzIY8t54a6XEfK4uuhPDRYqwQoIh2ozEEGCEhyw==
X-Received: by 2002:a05:600c:538a:b0:3c6:c223:7ec5 with SMTP id hg10-20020a05600c538a00b003c6c2237ec5mr1585791wmb.37.1666090752726;
        Tue, 18 Oct 2022 03:59:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d4b02000000b0022ed6ff3a96sm10646959wrq.39.2022.10.18.03.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:59:11 -0700 (PDT)
Message-Id: <5b0c2a150e9fce1ca0284d65628b42ed5a7aad9a.1666090745.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
References: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
        <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Oct 2022 10:59:04 +0000
Subject: [PATCH v3 4/5] cmake: avoid editing t/test-lib.sh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 7f5397a07c6c (cmake: support for testing git when building out of the
source tree, 2020-06-26), we implemented support for running Git's test
scripts even after building Git in a different directory than the source
directory.

The way we did this was to edit the file `t/test-lib.sh` to override
`GIT_BUILD_DIR` to point somewhere else than the parent of the `t/`
directory.

This is unideal because it always leaves a tracked file marked as
modified, and it is all too easy to commit that change by mistake.

Let's change the strategy by teaching `t/test-lib.sh` to detect the
presence of a file called `GIT-BUILD-DIR` in the source directory. If it
exists, the contents are interpreted as the location to the _actual_
build directory. We then write this file as part of the CTest
definition.

To support building Git via a regular `make` invocation after building
it using CMake, we ensure that the `GIT-BUILD-DIR` file is deleted (for
convenience, this is done as part of the Makefile rule that is already
run with every `make` invocation to ensure that `GIT-BUILD-OPTIONS` is
up to date).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                          |  1 +
 Makefile                            |  1 +
 contrib/buildsystems/CMakeLists.txt |  7 +------
 t/test-lib.sh                       | 10 ++++++++++
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/.gitignore b/.gitignore
index 73df7295795..89ad7e68b4b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,4 +1,5 @@
 /fuzz_corpora
+/GIT-BUILD-DIR
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
diff --git a/Makefile b/Makefile
index 88178c5b466..886614340c7 100644
--- a/Makefile
+++ b/Makefile
@@ -3029,6 +3029,7 @@ else
 	@echo RUNTIME_PREFIX=\'false\' >>$@+
 endif
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
 
 ### Detect Python interpreter path changes
 ifndef NO_PYTHON
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 0c741e7d878..1d8cebb4cfe 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1067,14 +1067,9 @@ endif()
 #Make the tests work when building out of the source tree
 get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
 if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
-	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/CMakeCache.txt)
-	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_RELATIVE})
 	#Setting the build directory in test-lib.sh before running tests
 	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
-		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL REGEX \"GIT_BUILD_DIR=(.*)\")\n"
-		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
-		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
-		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
+		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
 	#misc copies
 	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
 	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 120f11812c3..dfc0144ed3b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -47,6 +47,16 @@ then
 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
 	exit 1
 fi
+if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
+then
+	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
+	# On Windows, we must convert Windows paths lest they contain a colon
+	case "$(uname -s)" in
+	*MINGW*)
+		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
+		;;
+	esac
+fi
 
 # Prepend a string to a VAR using an arbitrary ":" delimiter, not
 # adding the delimiter if VAR or VALUE is empty. I.e. a generalized:
-- 
gitgitgadget

