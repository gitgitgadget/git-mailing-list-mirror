Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED96C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 10:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJRK7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 06:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiJRK7R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 06:59:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0A480BD3
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 03:59:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i82-20020a1c3b55000000b003c6c154d528so268872wma.4
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 03:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7I87zxy1YkseDheQ3ObpIeu2VPLv1trvSuTyDBxiow=;
        b=f8DWgNuz0HrbmzLLvIqt3iY73+FidpO2XhAZOQXw2CokY4kpKlkfMFcqRi/OHlA7oL
         k0QF13DR5xtnP8Xls9PDDnIgsNHJxYD5PVj8DOMhSxRTtsH/0EyhilNwI/R00t9/qL//
         LkD37vvVnj4sq9wzyg1VkLQpvZvcWJytLQSnOkqVL1+dFcGf3VTy2xWkDXW7vPd6gOec
         RS3oIleVpYXPZaQycCPPLQLxbV6lUJmKpvPXo2Hww5WEwJmz7PtaBZx+kFgw1CrJtiN4
         4tIi24KDRX56+gmCYm4phU5LQdfwMyKWqhq5Y6A5lBderMsV4Vje4bUGn/QDWj8LXC6g
         6xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7I87zxy1YkseDheQ3ObpIeu2VPLv1trvSuTyDBxiow=;
        b=Wnnyo2Kpw5MLWRSkMAEOedgDsXbEAsMAAj10kHzmwwK0pCcv1uU4tdMeerWI9FZ+wC
         mitFGPXmOAytx+WdBcwviLRbbo1Hn10FHBIan+7PQn+gwMBwu0OGZdliKBlrYgakmUJq
         e1brV6MQ6ExWhHcuT3GXOzCnRGBUlOdzJt9Vw/KrGJYBLEyVdB1Hu4PHtrFnV3VTgB71
         lNbPwQRQbwEF9FqdGtyGjE7TsuAmRvJArc/wwLBgUOwb54xtymzHHpSWm6DYDS6q3BVs
         z3NJGL7rMMGMgw0ckWHxcQao/1FumOwvIt4A17mEmfaPpLYGr+wW06MP75nrj8+Or8Rf
         K8ZA==
X-Gm-Message-State: ACrzQf0uAtTnbh8ZTw3ksnvXNiRX77M8J5kU7dmLNS5nlxH5Y+3hCRU3
        VY1wqlxRUx2VccSqqe3lti1x3XnSHiY=
X-Google-Smtp-Source: AMsMyM6p+V6nXpJg2hibyfASkDLDgUUZGxqdN7KTanaRyorv9qUds/MtUtuxqAR5FbsP8vKVlwoz8Q==
X-Received: by 2002:a05:600c:3384:b0:3c6:f25a:96e9 with SMTP id o4-20020a05600c338400b003c6f25a96e9mr9763399wmp.112.1666090753721;
        Tue, 18 Oct 2022 03:59:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d62c5000000b00228cbac7a25sm10846771wrv.64.2022.10.18.03.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:59:13 -0700 (PDT)
Message-Id: <40cf872f48386f8eca0fa814e4cdfb0ded915ed8.1666090745.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
References: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
        <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Oct 2022 10:59:05 +0000
Subject: [PATCH v3 5/5] cmake: increase time-out for a long-running test
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

As suggested in
https://github.com/git-for-windows/git/issues/3966#issuecomment-1221264238,
t7112 can run for well over one hour, which seems to be the default
maximum run time at least when running CTest-based tests in Visual
Studio.

Let's increase the time-out as a stop gap to unblock developers wishing
to run Git's test suite in Visual Studio.

Note: The actual run time is highly dependent on the circumstances. For
example, in Git's CI runs, the Windows-based tests typically take a bit
over 5 minutes to run. CI runs have the added benefit that Windows
Defender (the common anti-malware scanner on Windows) is turned off,
something many developers are not at liberty to do on their work
stations. When Defender is turned on, even on this developer's high-end
Ryzen system, t7112 takes over 15 minutes to run.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 1d8cebb4cfe..7e0d040e0f6 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1088,4 +1088,8 @@ foreach(tsh ${test_scipts})
 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
 endforeach()
 
+# This test script takes an extremely long time and is known to time out even
+# on fast machines because it requires in excess of one hour to run
+set_tests_properties("${CMAKE_SOURCE_DIR}/t/t7112-reset-submodule.sh" PROPERTIES TIMEOUT 4000)
+
 endif()#BUILD_TESTING
-- 
gitgitgadget
