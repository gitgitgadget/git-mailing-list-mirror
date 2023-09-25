Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01516CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjIYLVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjIYLUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:20:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA0CD3
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4054f790190so44829775e9.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695640842; x=1696245642; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltxtQ9vs58ZkLsFx7dc2UlYFSCGlP20DljWV5O0PqwY=;
        b=cpa/gvONQYdJUDcZlOlhmG1jBwU10iHrNLCQ9DD6iZm0Bd2/tjHuur3DbdeJWFzTux
         PwaFey4iEabzhJmNK7SIQZDu3HHS1AW0r2OQ41X6hrtGy4Xw0KRBLAHQi7sgL5OfrsuZ
         4FB4fxinwoHC7R6sR1epOz7Ywl1lmWcNbejyjOcAhYM86DU011eWAOW3r8HD0lok0UZr
         2KRp/t1dzKoi+ZKJRa9GK+UWqFCa2zAjeqBX+a7qdOmx75G7Efy0FlBDm35TqZwt+oum
         2x+ygpR+mCFjGPTL9uUCjC/PLf/8AV+FLr88E2aGsza2GK7I+mAm2+96Wd8pcJR3CPoY
         ZteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695640842; x=1696245642;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltxtQ9vs58ZkLsFx7dc2UlYFSCGlP20DljWV5O0PqwY=;
        b=dFU5k3dKMwFd1kINPLDt/5kv1+sJJGhDgXoz4gQHttzY00Q22T1fWIvtmZyA3wMeyg
         BYBI4yvsJ8cV9H6+7aPLst0ugLrUcXFV80aEkJfyAhgdw8g/XCYn3AQEdq6vZp2a9yMh
         SU3iZ46giLKMzdKwnbC9CloYNHgMWW2jvah6/UF76wAFvlhxMaLpOid0gn3jjm8QdJ9d
         L43Kl9PtXxBxiLRFNMMfLk8y15d4pjnrmZMHdbFG/fXWrcPI1xAvC42z1ZrIQJWPlNaA
         FKw9h7Aeb1IftmMYgE382GrC39xhEsaInix6E7WuwRMZs5+xpAUHckOMs6FnazRMXmnw
         x3jg==
X-Gm-Message-State: AOJu0Yz0w+IMs4DirJfrdCHj38cwyQ2H/ke7yljnqYO8pJTBhqiVlp/q
        4UDodE5ertX0616PllYJtrEWz4K6H1g=
X-Google-Smtp-Source: AGHT+IGgRVtSCunyQNyJBveFd3eQ8We2hkDhn4vkwvqTsVofITrEehyHXSbLTbreZUqZNxnw5aqPUg==
X-Received: by 2002:a05:600c:2215:b0:405:348e:aa43 with SMTP id z21-20020a05600c221500b00405348eaa43mr5437104wml.12.1695640841521;
        Mon, 25 Sep 2023 04:20:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c0b4300b003fe1fe56202sm12072225wmr.33.2023.09.25.04.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:20:41 -0700 (PDT)
Message-ID: <2cc1c03d85153356edd55fc0747a957db3c94ab0.1695640837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
References: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
        <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:20:30 +0000
Subject: [PATCH v3 1/7] cmake: also build unit tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A new, better way to run unit tests was just added to Git. This adds
support for building those unit tests via CMake.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2f6e0197ffa..45016213358 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -965,6 +965,24 @@ target_link_libraries(test-fake-ssh common-main)
 parse_makefile_for_sources(test-reftable_SOURCES "REFTABLE_TEST_OBJS")
 list(TRANSFORM test-reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 
+#unit-tests
+add_library(unit-test-lib OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/test-lib.c)
+
+parse_makefile_for_scripts(unit_test_PROGRAMS "UNIT_TEST_PROGRAMS" "")
+foreach(unit_test ${unit_test_PROGRAMS})
+	add_executable("${unit_test}" "${CMAKE_SOURCE_DIR}/t/unit-tests/${unit_test}.c")
+	target_link_libraries("${unit_test}" unit-test-lib common-main)
+	set_target_properties("${unit_test}"
+		PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/unit-tests)
+	if(MSVC)
+		set_target_properties("${unit_test}"
+			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/unit-tests)
+		set_target_properties("${unit_test}"
+			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/unit-tests)
+	endif()
+	list(APPEND PROGRAMS_BUILT "${unit_test}")
+endforeach()
+
 #test-tool
 parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
 
-- 
gitgitgadget

