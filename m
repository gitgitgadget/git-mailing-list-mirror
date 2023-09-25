Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FD1CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjIYLVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjIYLU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:20:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B9DF
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32329d935d4so1301435f8f.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695640848; x=1696245648; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2F3WZpJqC4U8ZhQgsyD+2VJZclnONnsWhqageMddbs=;
        b=D4xlYnPrsozq6X8zf4wkeDYWGGkg8r1dxSJriNFrWvRqluZUh+5dKzE8b2wQf7U9L7
         5VEEi7N4hAttIWXRuNT1OvTUgj9CPpuPXQpkIQG4SNvywxzPpF4u9khlwuU9L7qfgdAx
         2RwxQMLODP8icDcCKJB9+BKidLB9Z+K29As1HNAtBSuCcoz80UjWp6qXvIBXsUXDPhKB
         H39MjDCQlxVaAva8kaN88TtdQuFS3EB0oVvwCmPGXiQC4JOB/76MIylhFgxbp4vJaXrP
         +rkXqX9u58AhHY/MOWx68/Q6SlfgQ/rmTXGXodKQzeLJWSqb5un5NTy0ZITH4jK77PnS
         1nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695640848; x=1696245648;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2F3WZpJqC4U8ZhQgsyD+2VJZclnONnsWhqageMddbs=;
        b=ThOou3Go6+f2DqV7uoOn1ROguzR2kF//nKLGsvrxYWTzSEbsjL2lomLsCAQSHwN5ZJ
         0cYNhKeuR/kSSc0uxe3HE8d8MvTP51JKqsIuDAOZD8Ssosl5ZuFoFY8HCFLB2ySz/BS0
         0KSek3i885Xm5bj1ngDiJGLVF44U3dWR0yewoRfoz42EVWJ0/J4Nfv9FErWFh6gToo1k
         kV+1prjFQgrg1aGQK+Yz8hclXuuQjEy5P6a958vAbN97JoGtZlEy/F2D88VDw3KDq4SB
         i3q235pQ0Tq4rE20hU9PEquFuCzlko4NWJ/tCCqgUAiEfQlkR/zgybnQcmjoG1Wu0zPL
         orWg==
X-Gm-Message-State: AOJu0YzvM9YLgUY4v6nt+HeqjY+vms0frCkhFzbKEw58HhjwW9GwNUaT
        QE2sf47EL5RMYAJCQ1ov9vsJ9o9KBuA=
X-Google-Smtp-Source: AGHT+IFgrNy7Ccj1ENnTcCzrFsZgnmdUvsb4PF+LVq1CokFlqPpep2P3RtECtzW4ELdpDjMC2SM4JA==
X-Received: by 2002:a5d:5582:0:b0:31f:ffd1:6cf4 with SMTP id i2-20020a5d5582000000b0031fffd16cf4mr5904930wrv.12.1695640848024;
        Mon, 25 Sep 2023 04:20:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b003196b1bb528sm11666942wrw.64.2023.09.25.04.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:20:47 -0700 (PDT)
Message-ID: <64707240a4eabde1e96446f9314e13248c35ed41.1695640837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
References: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
        <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:20:36 +0000
Subject: [PATCH v3 7/7] cmake: handle also unit tests
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
index 5e0c237dfd4..d21835ca65c 100644
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
+		add_test(NAME "t.unit-tests.${unit_test}"
+			COMMAND "./${unit_test}"
+			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t/unit-tests)
+	endif()
 endforeach()
 
 #test-tool
-- 
gitgitgadget
