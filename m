Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5ACC83F2E
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbjHaGPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjHaGPj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:15:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BCF1B1
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:15:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fee8af9cb9so4215215e9.1
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693462535; x=1694067335; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltxtQ9vs58ZkLsFx7dc2UlYFSCGlP20DljWV5O0PqwY=;
        b=UEvuUeWyXDCmzr/RoBPwYnnYBWoqKcHLnfkoQboncFxYvH/r/j+v6FCjOXHV4W6v11
         fXNQEW5473zU7egEiAE+keE93EKGom6O8UB+4PfKVTyufarQUZPKWb+B53sg8d0dXuNx
         03yBRo7MTQMp9tsbAgCQiYfznTeu/SumeD0A3oHcHhdErH2+Xwy3J4/DtiOIXUszrwr7
         A+jJufm1OoJKAIkTTpt24lVqQ9l+HIMBRkjkFFfaiw/nd12uTGknvr8b9IoIVxujXuJK
         9dc21ctvRvMwvSEKT6NYY4TJ0I4OcHLVjt95UwN56gN5b4i5HATh7b6o9odg73jGq8Px
         mYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693462535; x=1694067335;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltxtQ9vs58ZkLsFx7dc2UlYFSCGlP20DljWV5O0PqwY=;
        b=DQsdJukzw1EkhsqrOgkoJEH/yLbHWB9QOIaycKRLjLsUU9UkWaykjaIuAzowWG4o3v
         EhEhg8opO+7BQ9ZOni2MK/+4bmjKs0KQP+3akx9WlcGrVLfxJhfMq4BNxBfZRkoEvpUy
         VKufsdbjESFcRbpk5RLdlbB/9JKbZ24CFJsmvB05jDIv9EBca+U9GnTbRYOT7o8tCLbk
         rCB7pYyvaILiNST8JT9DLM+PmCDB+Yvcz3Ta99OQlToXdbCnIFJSQVIBdcku1r9IsoPT
         ezZwdOloa5XOWPWy2sH29yWNLVXUI5XSnwYQyS+cWO2J1c2o4Unrs1tv1/6t7jZoH9+Y
         ybCg==
X-Gm-Message-State: AOJu0YwNdAIsBHc5tQXFZVEvZLOh+2ipej9m5P/RMIOCwflioADFY0nC
        yesFYS9Wp90BZ5V+NOaXfcqGHX/0/og=
X-Google-Smtp-Source: AGHT+IFi01QPJqrsVMwaH2VtiociWdkxmzj/11pMOuvOyLEaAgcZZTl2AviSHsmrGzCHwmHldK0g7Q==
X-Received: by 2002:a1c:4b18:0:b0:401:4417:a82d with SMTP id y24-20020a1c4b18000000b004014417a82dmr3809770wma.38.1693462535177;
        Wed, 30 Aug 2023 23:15:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17-20020a7bcbd1000000b003fee777fd84sm899051wmi.41.2023.08.30.23.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 23:15:34 -0700 (PDT)
Message-ID: <2cc1c03d85153356edd55fc0747a957db3c94ab0.1693462532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Aug 2023 06:15:29 +0000
Subject: [PATCH 1/4] cmake: also build unit tests
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

