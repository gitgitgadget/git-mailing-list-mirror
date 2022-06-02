Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDCBC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 09:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiFBJFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 05:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiFBJFm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 05:05:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F51C2A80F1
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 02:05:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q7so5596988wrg.5
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 02:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cCiB9TBHF350f1MiVfzAb5UnlPREDQAdUy45fCto+Bk=;
        b=Ejkojn43JqR3w3XCMMcKHBv8L7IE7MAjziXd1p8ejr46jDDocVtiZPQgP+RuKP9jyO
         c/MjdPpGK3FcCFbX+oUr9vHJzrNzV1oHuI/0sKOd1jqgxoLUTyIJMOLQb5aDevAdk/tD
         K5TluvsN+9WH92lYTDAZVKPJnUq/idTMsdIwN2O7Irc5HPGl3MWz0b1j/B9zvCOT4YHL
         8gLJdluS8D4Cp+MJDHOU3ZW/i9l3Jx2eH6bJTADXGU6qi2SfS2oiWZffrgzTLl30JxD0
         0nHCZTOkq3tUIykoPqISsp2wcMfcrn++KvuTiL48zlPiAMvqMNpHFb+tu1zg6MPEDH7p
         ZsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cCiB9TBHF350f1MiVfzAb5UnlPREDQAdUy45fCto+Bk=;
        b=daM0nyGBOpLVMM846gFAFkqtQX2zVPARj1IUWZCiWA+L2eQJICW8dVCX5TVCqill1O
         ff1SzZxlroTiOLN3iD6BcZMaRAjUOhWh7w1zBSJV3tHTV03rWD7bROK6tYJWHz8jKYS0
         ST2HLVSvDLdiSsgpcktOmppMzl4aJyT9cZ1l+kirrGC4LGEq2YvQ0PcKsOLSmE4J/44T
         FhFn8VpPi+pQkNz4IfHzkCooAQV4R7vs1JwmXah5HcDS3+rIooYSitN6TZ3K9mdYGObd
         ybg8/xp+ip//N/QJqkwWwyjdIBdrXTq7TltWxsQyGYMOBvBzFGWdMrR38M7om2r0bJpr
         6PlA==
X-Gm-Message-State: AOAM530WgI3epuhWnKMYjuRrtBvRYaGJDlG4fjm6WFVCbEQbxOppb7Yw
        jNfp4sanpUZcMQ3zjYc/j06WYTyuTC4=
X-Google-Smtp-Source: ABdhPJxjADynnKXABDa/i0IofrRg9zEt14FhaCPl7b2nZpSspQJNNL7q50WanQrIOngphuAV2XXjkQ==
X-Received: by 2002:a05:6000:1f19:b0:20f:ff31:7f38 with SMTP id bv25-20020a0560001f1900b0020fff317f38mr2816718wrb.496.1654160738505;
        Thu, 02 Jun 2022 02:05:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c4f0d00b0039c3055a63dsm1295617wmq.36.2022.06.02.02.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 02:05:37 -0700 (PDT)
Message-Id: <c155cadfa309e856f13ea7d005870dab706a74ce.1654160735.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
References: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jun 2022 09:05:34 +0000
Subject: [PATCH 1/2] cmake: optionally build `scalar`, too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Unlike the `Makefile`-based build, the CMake configuration unfortunately
does not let us easily encapsulate Scalar's build definition in the
`contrib/scalar/` subdirectory: The `scalar` executable needs to link in
`libgit.a` and `common-main.o`, for example.

Also, `scalar.c` includes Git's header files, which means that
`scalar.c` needs to be compiled with the very same flags as `libgit.a`
lest `scalar.o` and `libgit.a` have different ideas of, say,
`platform_SHA_CTX`, which would naturally lead to memory corruption,
crashes and quite tricky debugging (talking from experience).

To alleviate that lack of encapsulation somewhat, we guard the Scalar
parts in `CMakeLists.txt` via the `INCLUDE_SCALAR` environment variable.
This not only allows the CMake-based build to exclude Scalar by default,
but also gives better visual cues as to which sections are related to
Scalar.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 185f56f414f..c8a802463ba 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -753,6 +753,13 @@ if(CURL_FOUND)
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
@@ -980,6 +987,13 @@ string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
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

