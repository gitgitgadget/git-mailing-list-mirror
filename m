Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7755BC433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhK3L6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbhK3L6P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:58:15 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ED3C061748
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:56 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so43772930wru.13
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L9faUOUIjPF+NLN+ELTzI5NereQrkPug1GdsWQHqOzk=;
        b=jnhZNqJ+eIa8hZYkVo5QI/zy5ic0DfJG4gQhbDQuPe9Z/QaY/PMxbk5SgAZm4Dfmep
         zWNNCoZiJhFFJXPE/fSIFFgslMn7J4D90LnZXY9W3xS9pUtlYOuKKBhyejdnT1hR6OWj
         c6V+cgWF5QdNfZrXsHdGjTCKSElNvadwA8AAwzfr/80Vf+/4H3dZ6ytvX6Ni/jh+kIjr
         5ashgI+hLDfw8bzyn/PxE+siT84ZqHDHqrbbsvKWKhMWvNnx2MHKFSg7ILdKH69ZPAEG
         BwEBvW6jHP+JtbLzn+T+Szwp8bQTj54NXgplUFh8WnxO671QVunqqwgDojTnku3kuOaI
         oLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L9faUOUIjPF+NLN+ELTzI5NereQrkPug1GdsWQHqOzk=;
        b=siF7/PgaUs7iF78Wdp1+vs7cq6xSH+lqnljF733Uwpx6okdVdzmU1Z9MEeP2UGQwOA
         7Mn00FxYY5OAqGT8Od/ohJhjv64xH/BS7mTAjTGsyfh40EC6elncZq0DCPzBUffn2Ys9
         NTt+/uKaVsqYDN6O7FirmQCfQWTz0tcZu+mJV0WgGYcZuMfLkZh/HM+KUONOe1PhsS8U
         E/9ogxR3Sy8rr16ZJBc8n7sRvSTCR2IkYEnPxyGwOmhMy6K+LO1PuptEcurvukQSC9FJ
         LTUvtkw4pW/BYfSMFdYwN+Wo+9Qww+w6yC/XF3REhEFw93aqudkAt9CS6XchD5Ifzuyw
         MOTg==
X-Gm-Message-State: AOAM533o0c+8jjbtG7UpZWB7114O6X/wJDt7aFdZeo8fw3x/LVL9ORsB
        O7mi1EYRNFgF9wgdjiWcK+MnLUFT/40=
X-Google-Smtp-Source: ABdhPJwL4W5St7iwTL47zwCOWJohsjhOLyxXkxAL7dXCZL7CtndjAjaJNyabBa/eerfMrA0pT0qtzA==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr39545592wro.187.1638273294490;
        Tue, 30 Nov 2021 03:54:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm2642622wmp.26.2021.11.30.03.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:54:54 -0800 (PST)
Message-Id: <a39b9c812146f6721353a066670d248159161615.1638273289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 11:54:37 +0000
Subject: [PATCH v9 05/17] cmake: optionally build `scalar`, too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The CMake configuration unfortunately does not let us easily encapsulate
Scalar's build definition in the `contrib/scalar/` subdirectory: The
`scalar` executable needs to link in `libgit.a` and `common-main.o`, for
example.

Also, `scalar.c` includes Git's header files, which means that
`scalar.c` needs to be compiled with the very same flags as `libgit.a`
lest `scalar.o` and `libgit.a` have different ideas of, say,
`platform_SHA_CTX`, which would naturally lead to memory corruption.

To alleviate that somewhat, we guard the inclusion of Scalar via the
`INCLUDE_SCALAR` environment variable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index fd1399c440f..dd7496b0322 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -729,6 +729,13 @@ if(CURL_FOUND)
 	endif()
 endif()
 
+if(DEFINED ENV{INCLUDE_SCALAR} AND NOT ENV{INCLUDE_SCALAR} STREQUAL "")
+	add_executable(scalar ${CMAKE_SOURCE_DIR}/contrib/scalar/scalar.c)
+	target_link_libraries(scalar common-main)
+	set_target_properties(scalar PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/contrib/scalar)
+	set_target_properties(scalar PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/contrib/scalar)
+endif()
+
 parse_makefile_for_executables(git_builtin_extra "BUILT_INS")
 
 option(SKIP_DASHED_BUILT_INS "Skip hardlinking the dashed versions of the built-ins")
@@ -953,6 +960,13 @@ string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
 string(REPLACE "@@PROG@@" "git-cvsserver" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
 
+if(DEFINED ENV{INCLUDE_SCALAR} AND NOT ENV{INCLUDE_SCALAR} STREQUAL "")
+	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
+	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
+	string(REPLACE "@@PROG@@" "contrib/scalar/scalar${EXE_EXTENSION}" content "${content}")
+	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/scalar ${content})
+endif()
+
 #options for configuring test options
 option(PERL_TESTS "Perform tests that use perl" ON)
 option(PYTHON_TESTS "Perform tests that use python" ON)
-- 
gitgitgadget

