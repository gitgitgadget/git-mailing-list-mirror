Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F03CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 20:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjIRUyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjIRUyh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 16:54:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0978290
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-402d0eda361so54132245e9.0
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070470; x=1695675270; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltxtQ9vs58ZkLsFx7dc2UlYFSCGlP20DljWV5O0PqwY=;
        b=D4RuuusQN4wGVDDc6T0DADe+2Dtd8KUWbbJ1WRDUPDRkonnkyNxFPLETOC8GgDgM/P
         QUdAb/2b02mY04o8Nmy2yp2pM6IftuzOVDA/SkmVRbDJGa7t+IhjX1GnLQNLyY23orrp
         /52aOafG4GsrKl0OcTXjRbX+cYJYWVtOktDi0tr69eWJZCMiXVlg0RMVi0gySy7h3ENt
         AOalZpqgptVyWuxN3x1IxUIKUqXtinYJAWrDdxRJkLxIv0DkQ2NkJsuVBBZfywdODYI6
         uokAzQC8KXwWhajcQXlYvM8dlcoZnPMrjNCiT3HfT+pcn+jygd82SZnwelAkTt32i/RF
         VzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070470; x=1695675270;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltxtQ9vs58ZkLsFx7dc2UlYFSCGlP20DljWV5O0PqwY=;
        b=lEVoizIc8vKY01yUjlAoI8TlFO1Sd/x3PKuuNMksYDxgTKTbJxmCMk7hLpNjvuhje+
         iM+jLDbe+Pa/l08K35Ai+7HyhZagVMMhiMPzMtJJkbJq24/GxDgBfZAKhsKehpwkmCG8
         tfXPg24sR7gxQZrEZu/s/Wogj0aC3Ysw6i4LyRAroZitsO/NGBhrsT3QJf+BBuekctNx
         fHRLjOhozJuJQHa3HXgc5rv3lnlly6+ZHndq4IOzVIXe6utbh66rc787JW/Isqxzgg7b
         n2OId9GettiGSp4kefXbfygLpprRGeirZfRTOi4E6rWXhMXoK2kKA2mWZrYtclt9t79f
         4Clw==
X-Gm-Message-State: AOJu0Yw/9fmo7xlKfaF7tbCk+hhHkfwenIW2B9yNNdX0E4kdwA+gOdyz
        9nSWUtj/jdVB0d6XEiWIJcK+x5g8n1o=
X-Google-Smtp-Source: AGHT+IG30m0RTrzEv3YEwYtlnpSoBwQWUxo1VYYJfySLbPgKYUqa06oJgcSFqqvwF0Vvmev7mJseiQ==
X-Received: by 2002:a7b:ca4a:0:b0:401:c297:affb with SMTP id m10-20020a7bca4a000000b00401c297affbmr9357653wml.37.1695070469990;
        Mon, 18 Sep 2023 13:54:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11-20020a1c770b000000b003fc04d13242sm16166976wmi.0.2023.09.18.13.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:54:29 -0700 (PDT)
Message-ID: <2cc1c03d85153356edd55fc0747a957db3c94ab0.1695070468.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
        <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 20:54:22 +0000
Subject: [PATCH v2 1/7] cmake: also build unit tests
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

