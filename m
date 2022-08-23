Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F912C32774
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 09:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348961AbiHWJNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349231AbiHWJLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 05:11:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D3D86C28
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 01:31:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso7310277wmb.2
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 01:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=oqn06qcCx888JqXrAWFrPw6Pt3QXV7A7ysDTY/54nAY=;
        b=FMRIfLC1QHixgi1btbBqNrWFqVtgbv1jCzL8cmYNZz/0IKhmrFFlECycccJ4cwtOrq
         BfiLhafOBWzSwoTH2imt6LPFZ+x22it0QMgPPiHHnh+1OuKlvik7WJYKxPFv14nM85UD
         job5DLyinI3vyXwcamnrE9CX+d+ZaPzhMBa7jDLDIphwtpzM+AsCABs//noQrPoztXk/
         ObMwM41n2GVIlBkkvHiidGswDapbVQv6fu7Vk1OEbPaL9cgE5F4RP3xABcs/zLSd2pAg
         5HDc5YCXNaeh8f147V0MawRxFu7fz17QQ27qU0Cp2AiNGKt2kE+zOnlWb4zHAvVFtPVL
         XLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=oqn06qcCx888JqXrAWFrPw6Pt3QXV7A7ysDTY/54nAY=;
        b=2C2QefuOyCTU+wNfLQZGZRx8Vo1/cx2wrUKH4QBZ0kOSJHliIYi5FqsJTgFNeABhiU
         lhK0RLi/MuWfk/YCUaQHnC1ga8j4g8QRwlvskBqM89BvME2XMuJm5N4Dz4vROUdxZOOR
         XybizOjN+kNmkzbIij9SpHYsTorx+Y0VYL5kgVxZs9cuikKBmDEZ7YgRn6QOnLNVrF+Q
         UCgal6WvSmX7DtAJo4PNPvmV51jJTANKNIdJaaZ3W3MqNF873s5bRQSU8oceNQtODqxX
         UM9FrOP8e3KIT3ou2AQwyWXvk7nzqJk0673AD+oQhwap3FRTo4S4zFUxXsbuUMYUsKKw
         NtiQ==
X-Gm-Message-State: ACgBeo1lC6H1EA9ZvFlqI+lqTiPKha9oe3wB24dL5mE1YI/is1mEvx0e
        32szeWydkw1Pi6aKq2uSgorgT9euVl8=
X-Google-Smtp-Source: AA6agR47YWBGBlY5PwkrTL1MU7rBgF8lp6klMCpqLk2m+rhYWr80bKJ9uxEvC3e0Wq73RHDOY+doZQ==
X-Received: by 2002:a1c:7916:0:b0:3a6:3540:5b3c with SMTP id l22-20020a1c7916000000b003a635405b3cmr1362933wme.178.1661243470083;
        Tue, 23 Aug 2022 01:31:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c350b00b003a63a3b55c3sm14059232wmq.14.2022.08.23.01.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:31:09 -0700 (PDT)
Message-Id: <22473d6b8f3d4e4c482c27a4fb3b58705d4c93ca.1661243463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
        <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 08:31:02 +0000
Subject: [PATCH v2 4/5] cmake: avoid editing t/test-lib.sh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
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
 t/test-lib.sh                       | 11 ++++++++++-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/.gitignore b/.gitignore
index a4522157641..b72ddf09346 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,7 @@
 /fuzz_corpora
 /fuzz-pack-headers
 /fuzz-pack-idx
+/GIT-BUILD-DIR
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
diff --git a/Makefile b/Makefile
index 04d0fd1fe60..9347ed90da7 100644
--- a/Makefile
+++ b/Makefile
@@ -3028,6 +3028,7 @@ else
 	@echo RUNTIME_PREFIX=\'false\' >>$@+
 endif
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
 
 ### Detect Python interpreter path changes
 ifndef NO_PYTHON
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index fe606c179f7..29d7e236ae1 100644
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
index 55857af601b..4468ac51f25 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -42,7 +42,16 @@ then
 	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
 fi
 GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
-if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
+if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
+then
+	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
+	# On Windows, we must convert Windows paths lest they contain a colon
+	case "$(uname -s)" in
+	*MINGW*)
+		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
+		;;
+	esac
+elif test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
 then
 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
 	exit 1
-- 
gitgitgadget

