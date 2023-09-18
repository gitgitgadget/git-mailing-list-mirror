Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E94CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 20:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjIRUyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjIRUyk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 16:54:40 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F33710D
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-403012f27e1so53159645e9.1
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070473; x=1695675273; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23l3Z8R4FAVJkDvMIqmZkHPda5QO1OxxfN1rwfQduxM=;
        b=KOakKsJP5q/XAYGVWf73lccnQl44fybleK/XXP9i4WVrQJMCL06A3VbvFzmbRnPdOt
         bB9kwhRUbMbNMqEsTJsMJJbguGI8E0u9xn5s6wFKcdzLLGOxz1BAPrYV1aG0XB5LR85U
         CbGMJiAGEBhj9EdopgEAsXnyhB3wCl94QwhaJEzIvh9WbLU9xXGxfp9YHPlUnBc12dBW
         ZAORM9iZF0PGGptf7b16Yh75onxAKLd+6a7nf0upHIodaFwzRzJNyRhpJ2kVLYm3hoay
         MBETBBfvPWL5sGOrg88UVUpvd3o7cs5bhbSF4kNhXD2lzupNYmoTYO9ShYGx0bPwObox
         HG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070473; x=1695675273;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23l3Z8R4FAVJkDvMIqmZkHPda5QO1OxxfN1rwfQduxM=;
        b=K5r+I6lTDnJm7if45o/qaGpwspcC7PPdAH/U/+zd7f3hPkpv+LtSajH8pW1PzyiKft
         jRbh35fg41eyvfpWFPFhzEg4omQLhw30EAK2RHajxJgkGE8YhqesFZNZa1E0/ApXhdSN
         aLSGvSZme5wwwCLb70ly2bM0MNYtaSxyu2pgPfIrZQZ852yheZkI9rQTDlxy00gkbE18
         rdoK7T/0Jn0cwTnxpZ8pTozU8EvIbp6itXWRx9iG/Rvdas5nPoZky14pJe0ze97iYPB6
         +1qt5N4f3jGppx4TIKBVA5XlaJw+wXac04u0+n6ohw6hUtt+n6qURy2SnYxCqmAD8heu
         uAiw==
X-Gm-Message-State: AOJu0YyfSSIQoEpHFPHyX/ScMrTK6kWmCS4Vroea7nYiITaj/hZPh2lK
        ubHOh2Vl6ZfIcC/lFzqyglOhOVBSJVA=
X-Google-Smtp-Source: AGHT+IFDpe0lMpbAylTJgJN1Y5dT+T248e+edIaNygKojznmkNyTRlGPBSQAAev8VAJ35K6X/cug2g==
X-Received: by 2002:a1c:4c07:0:b0:402:ee9e:ed98 with SMTP id z7-20020a1c4c07000000b00402ee9eed98mr8338366wmf.34.1695070472696;
        Mon, 18 Sep 2023 13:54:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14-20020a1c740e000000b003fe407ca05bsm16269391wmc.37.2023.09.18.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:54:32 -0700 (PDT)
Message-ID: <75a74571fbee7677d0e473a199d99c10da35ba09.1695070468.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
        <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 20:54:26 +0000
Subject: [PATCH v2 5/7] cmake: fix typo in variable name
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 45016213358..ad197ea433f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1102,10 +1102,10 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-completion.bash DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
 endif()
 
-file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
+file(GLOB test_scripts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
 
 #test
-foreach(tsh ${test_scipts})
+foreach(tsh ${test_scripts})
 	add_test(NAME ${tsh}
 		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
-- 
gitgitgadget

