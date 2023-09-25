Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1168ACE7A95
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjIYLVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjIYLU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:20:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2932ADA
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so5934957f8f.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695640847; x=1696245647; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDyY9qQi7KqDWV5dNj7AbYxVuBY39f/ATbDI8z43VBk=;
        b=KtkBfW8Qr1QDBeRuYwewlkvvfaj6k1ijRrqdCvatk0A7uvdJlTWm+T+qK7Im3SwO4m
         sQBGiszuNZAjgIOc6h1q5f0i18WhKX8V3AeX7q1hg/QCO3JEHRUGbqHO+DQWxAMz3hFP
         68wyhOA5v92q+oxJNtiF0bwSedzP5rYc463VDOsNerIamaqrgrx1czxtOHxJnhI6I6T/
         6ySwOchNnZC84qsNz7Y8mDh29g4yV6QdK6NLSv03u1kNcOiG6jP+SmVFc4j3BJyp15vo
         dxxPpgkXB1K0iwNjfY3f4UvwOoeGEMLrg0HZIXukf/RvIgq+01bD5YUgriS/gjhnwN49
         OFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695640847; x=1696245647;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDyY9qQi7KqDWV5dNj7AbYxVuBY39f/ATbDI8z43VBk=;
        b=qnBcu59/eGLWA0eSVekQbd+DUQNfOdTpt+AKkBjeeTQc5v8lZOFzPT6L2Ctqoyexxr
         +mGIa9F5shbeHSx1SFwXBaK//o62Fa4KxBFYwWh3xW4Sn9bFHfdv4RsNTcakiw7ZI6XF
         uVwgHbDG8AZoNqWV9k4lV3VUWpQISzCsSThg6pT1ikaEsfC+5fHYW7fFUAe0sg29OmEf
         av++K8iBUpl/QXkMcbP8LKIsinnx8m/KeH6wPMM/uT5F5O2oO7kH9AUZF/QCnjhRdM9e
         Bra92QKhC/leSVsp5wQO4d0NnHTTOK9ILnATnHRu/B2pwvPRJDChH/b+J/68zekTF1Qu
         taEA==
X-Gm-Message-State: AOJu0YzASIeUT5ONEDPjkgrChaJvYN2MuViJQakRSDq+xGca9kpy8qeq
        QdcKVdIv9ZHrtrb7NPQjrixWlZpWbXU=
X-Google-Smtp-Source: AGHT+IHH6SJKV/AFGVuowLZKjITFi4H/WfGToQ1hfqITrlTcXVcj8pPsYdP4SK9e5vZYRrncJO54/Q==
X-Received: by 2002:adf:cd81:0:b0:314:12c:4322 with SMTP id q1-20020adfcd81000000b00314012c4322mr5775161wrj.4.1695640847438;
        Mon, 25 Sep 2023 04:20:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020a5d4bd0000000b003216a068d2csm11575453wrt.24.2023.09.25.04.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:20:47 -0700 (PDT)
Message-ID: <0a2d08b91e56aba19e02cd43a55d4c74c40cfe71.1695640837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
References: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
        <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:20:35 +0000
Subject: [PATCH v3 6/7] cmake: use test names instead of full paths
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The primary purpose of Git's CMake definition is to allow developing Git
in Visual Studio. As part of that, the CTest feature allows running
individual test scripts conveniently in Visual Studio's Test Explorer.

However, this Test Explorer's design targets object-oriented languages
and therefore expects the test names in the form
`<namespace>.<class>.<testname>`. And since we specify the full path
of the test scripts instead, including the ugly `/.././t/` part, these
dots confuse the Test Explorer and it uses a large part of the path as
"namespace".

Let's just use `t.suite.<name>` instead. This presents the tests in
Visual Studio's Test Explorer in the following form by default (i.e.
unless the user changes the view via the "Group by" menu):

	◢ ◈ git
	 ◢ ◈ t
	  ◢ ◈ suite
	     ◈ t0000-basic
	     ◈ t0001-init
	     ◈ t0002-gitfile
	     [...]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index ad197ea433f..5e0c237dfd4 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1106,13 +1106,14 @@ file(GLOB test_scripts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
 
 #test
 foreach(tsh ${test_scripts})
-	add_test(NAME ${tsh}
+	string(REGEX REPLACE ".*/(.*)\\.sh" "\\1" test_name ${tsh})
+	add_test(NAME "t.suite.${test_name}"
 		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
 endforeach()
 
 # This test script takes an extremely long time and is known to time out even
 # on fast machines because it requires in excess of one hour to run
-set_tests_properties("${CMAKE_SOURCE_DIR}/t/t7112-reset-submodule.sh" PROPERTIES TIMEOUT 4000)
+set_tests_properties("t.suite.t7112-reset-submodule" PROPERTIES TIMEOUT 4000)
 
 endif()#BUILD_TESTING
-- 
gitgitgadget

