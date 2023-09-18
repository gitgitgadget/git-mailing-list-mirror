Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225B1C46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 20:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjIRUyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjIRUyk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 16:54:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E3F8E
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401b5516104so53428325e9.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070473; x=1695675273; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWVgy3TCCF3l/JJt+MfR17FAOgB5+dYGh0iwW3wP6N4=;
        b=jJB7zvpkx3oIRadmXU8hI5eV/4f8Mu6nD7nl+87/Ch1BM/RyOLcjZKEcm7aCedaOOi
         iDqmEPF0GuPEwfIbvgVsV2G6hjd77aODY3W+TzGEKGm8KK3TD9Q2SqfxLhvXnbFgWlyG
         OrfbuHq05i55K51oLW4WslJyuZb8YTN4gm/8LpPIH1L+UjJheH8K+T7+0gFGErRUyku5
         AHV9lY+MpKQeiOiOQegdVd20Dwaqy9FW3nCbXIk11bryeXpLgqHet/sQicqxcQxerubr
         4YUOQCMZioTREItZckp4sD9q8M6XURsN+tZ33KIur6hnjeXO4gpLu1xLIKIHitQ/QQeh
         wdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070473; x=1695675273;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWVgy3TCCF3l/JJt+MfR17FAOgB5+dYGh0iwW3wP6N4=;
        b=kH/cW+bF3OCiqp95qDreAXImf5RGwRFo+nmg/JiKeDzSYnMep1V4jZq22XtzArmUZj
         pZ4jf70KHx/FIb7Di11ALia5t6bhemgDAM21bbwsJaIjzVNqhTE7yQeuOAVVECVwXiPm
         MqcmhUcPeIc6gsEGPxPF76GTDccBW5AYLzXqO6EJ18M3LqVNpbU8VixrzqJCt0YNalMO
         yv4YILCeKiz4Na7dCg8NBkjLARcr+WWi5E3GZP5XnSXCScd0te7ljaxv054m25P0rF4K
         hX+5z0a6ZmX1y1mEGwPW2pCT/F+7fdpqIb2gdtM+2V9MFd+oUwLxrFo3ffldSrT/nPw9
         PjBg==
X-Gm-Message-State: AOJu0YxN+VlbTv9JwrMr8diALEAheyxf9JaSjDTCLELPY9/l70sKqF8N
        tFt5wBTBZ+4z/XBSWM8/YnqzgGLGJak=
X-Google-Smtp-Source: AGHT+IE5SGxft1DkADjloHw2JoVY7cG5nIrvxQo0fgObrnhxWRA7oEv18IO0XPlFqAtAH1aYVeeTfw==
X-Received: by 2002:a05:600c:1d9a:b0:404:f9c1:d5d7 with SMTP id p26-20020a05600c1d9a00b00404f9c1d5d7mr6546297wms.25.1695070473153;
        Mon, 18 Sep 2023 13:54:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bce0a000000b003fee53feab5sm13441291wmc.10.2023.09.18.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:54:32 -0700 (PDT)
Message-ID: <41228df1b469d9a79f3278fe8c1ca37082600669.1695070468.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
        <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 20:54:27 +0000
Subject: [PATCH v2 6/7] cmake: use test names instead of full paths
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

The primary purpose of Git's CMake definition is to allow developing Git
in Visual Studio. As part of that, the CTest feature allows running
individual test scripts conveniently in Visual Studio's Test Explorer.

However, this Test Explorer's design targets object-oriented languages
and therefore expects the test names in the form
`<namespace>.<class>.<testname>`. And since we specify the full path
of the test scripts instead, including the ugly `/.././t/` part, these
dots confuse the Test Explorer and it uses a large part of the path as
"namespace".

Let's just use `t.<name>` instead. This still adds an ugly "Empty
Namespace" layer by default, but at least the ugly absolute path is now
gone.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index ad197ea433f..ff1a8cc348f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1106,13 +1106,14 @@ file(GLOB test_scripts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
 
 #test
 foreach(tsh ${test_scripts})
-	add_test(NAME ${tsh}
+	string(REGEX REPLACE ".*/(.*)\\.sh" "\\1" test_name ${tsh})
+	add_test(NAME "t.${test_name}"
 		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
 endforeach()
 
 # This test script takes an extremely long time and is known to time out even
 # on fast machines because it requires in excess of one hour to run
-set_tests_properties("${CMAKE_SOURCE_DIR}/t/t7112-reset-submodule.sh" PROPERTIES TIMEOUT 4000)
+set_tests_properties("t.t7112-reset-submodule" PROPERTIES TIMEOUT 4000)
 
 endif()#BUILD_TESTING
-- 
gitgitgadget

