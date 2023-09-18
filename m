Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E12CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 20:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjIRUyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjIRUyk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 16:54:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6430D111
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so56412635e9.0
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070473; x=1695675273; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=504cxXwL03Ag40A4Pc/uIlsTRsHlyA+4I9I/EJ5xJ+0=;
        b=O1/Ghx2fnIpkpkCbBKxoHa6ocJ5y/bF4ALxoBsqN8CjUUpvd0cIYoxSjsTWw3BzH9A
         sUSZFWhYBRAoveb6iVPe/ooj6zx/sb30dS9+SZXSDYLBCepPl4QL4T8HAejAs4QFKd2r
         zUwaU4m0qo0ffL2JIpKFJRwztRoxCYS3ri3jiYvEj2x5jPqzpRldKSlYKczF/Vf2Qp0g
         e53rrcSNLWh7MetdQgoyQWnZFvKNEosc3s0RTormLdcffNDBMnEOVE8LrR/FzeKP0bCy
         zp+W41j6B6tqziK4C1rMagm1C7qGunw3wtUedef28HLjTbb4MX4gaQcbGvk7EoXj7jB9
         BiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070473; x=1695675273;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=504cxXwL03Ag40A4Pc/uIlsTRsHlyA+4I9I/EJ5xJ+0=;
        b=A3rEoCvPJ+/0nvr+yER9DWM3+eda1WeONbgH5zE06MvvV3W4fd3ybEc9BtDACIQaWR
         7E7W5xKvjCbQiRauPCLhKkgQ/lMveOnQWvRZzscPiCaXMvWS0VAvoKMuQjgvzXEgeWkV
         hUr5qWPM0yxEzMirC5FYWjH4v2yCAguCKPfiov2So+DFZqXQ6Hfr5ou+enJ/qqsg35oR
         5lMDM0Ew/tEQyaBP4IZNHQ75LO8wVz9smYl8/sCKIU7Xr3GKphaDTEV+6Q9ICOxoMykA
         w3PMYdWbaH90bE4nyopipX2UTJeXZH9djrjV+YvEVPrJQ8UWm5TmT5TpLrwR3mwMmoAm
         OmqA==
X-Gm-Message-State: AOJu0Yx6hbzdAK8gwibi7T61A9SedPo8Vt+HeB82wO7AjTQFxRdZPGbp
        6FKTeQ8UI8yNPH1z+YGBYg71AmLr07k=
X-Google-Smtp-Source: AGHT+IEmFZ8q8YIUTBh4kvvFSBsaKId2TTXyO4IluVIaIaEbhHqBB3uV2h2TWt2UQEZu81RACYsbzw==
X-Received: by 2002:a1c:f204:0:b0:401:4c61:90ac with SMTP id s4-20020a1cf204000000b004014c6190acmr9454609wmc.11.1695070473684;
        Mon, 18 Sep 2023 13:54:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c00d100b003fe0a0e03fcsm16239148wmm.12.2023.09.18.13.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:54:33 -0700 (PDT)
Message-ID: <003d44e9f0d73efae887d6b61ebdffb3c4e0904f.1695070468.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
        <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 20:54:28 +0000
Subject: [PATCH v2 7/7] cmake: handle also unit tests
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

The unit tests should also be available e.g. in Visual Studio's Test
Explorer when configuring Git's source code via CMake.

Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index ff1a8cc348f..35d451856a0 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -981,6 +981,17 @@ foreach(unit_test ${unit_test_PROGRAMS})
 			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/unit-tests)
 	endif()
 	list(APPEND PROGRAMS_BUILT "${unit_test}")
+
+	# t-basic intentionally fails tests, to validate the unit-test infrastructure.
+	# Therefore, it should only be run as part of t0080, which verifies that it
+	# fails only in the expected ways.
+	#
+	# All other unit tests should be run.
+	if(NOT ${unit_test} STREQUAL "t-basic")
+		add_test(NAME "unit-tests.${unit_test}"
+			COMMAND "./${unit_test}"
+			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t/unit-tests)
+	endif()
 endforeach()
 
 #test-tool
-- 
gitgitgadget
