Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5429EC32792
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 09:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348486AbiHWJNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349203AbiHWJLW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 05:11:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6504D86C29
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 01:31:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u14so16060185wrq.9
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Q3KJWsUHoyvk83fYpnqq1nuFuvSaE5HztSbDUOVTRRs=;
        b=gEr5wkQzVRzpUfuyuZ5al7azA1VlQMMZtGh9MgnbgJyNnwJ5Xulcqf2+F96fIVhsKR
         UF+wwidtq23MWsAAMIc9wtySJDf5YbL12wY9ntz42fFaNoDvcQWEr+H7C2JBhG4js6Ui
         PgTx9eLpX7C/zZTZLjOKtCZaqzUwjChxA8dQerci6GBPSurVgdVsDKEVuEbrJsS3oHax
         osMJyGEsbdC9SnoZGUjyCWoVn1fGFPPwu8NzMX3ZN7rkLyjK3z/pvevKrQ5YeER0Cjcv
         Z/TyQQFIh0SNfyGUUBlRClYj08GtuB27Oo25aKZD22bgZBark01H2tgRuTrpJOjmY3Ev
         vbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Q3KJWsUHoyvk83fYpnqq1nuFuvSaE5HztSbDUOVTRRs=;
        b=pUC5pfB8P17BAlYZmQNFNNH8xal+gVy2oJhhgOm3ZiS5cS1tyLHg/r3EWgxDOjD+MQ
         U+p9fvUo4Mtg/bEhPNVmU9Z16uzIdx2aEX0hwOaxij+TntSJp/py1ySQPyc/2WgVnvGq
         YJuDALmFu3ILhjYxwm6TOb/aSZJl+lgUQGl2aw5csZdkN2+gMa4xI2Zf6CN0l/0U7Zrs
         fvvQmPHZzRUgQNZQAUh6v4reoQqaGBnTOYo+K8lFAAZicK+5inIBMqZpEiEWnNhkPtYY
         kJ8HkJf47lJQGFiKRbmyCIPvA2mq5YYOp61+yrqIIePWYjeHgklScl1euaESNulpC4p0
         sLiA==
X-Gm-Message-State: ACgBeo2zJTAAa3ujzFRnZtBzzNWU0QIwh788zt2ioPwIpTLwCb9mEXTD
        0pbPgL0d1VhBFda1076dV1Mn7OSP4Jg=
X-Google-Smtp-Source: AA6agR6ECqsfKiD0mYOa+fhHYB10448TShLfHRE7tMTez0zM/Kgm22ULJwZwCPjoFh6cZVIug/l81A==
X-Received: by 2002:a05:6000:1182:b0:225:2a9e:77d9 with SMTP id g2-20020a056000118200b002252a9e77d9mr13090257wrx.699.1661243467804;
        Tue, 23 Aug 2022 01:31:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5f2cc2f1dsm21036312wmq.42.2022.08.23.01.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:31:07 -0700 (PDT)
Message-Id: <de7b47a9aa7eb002412caac978485577b241c6b3.1661243463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
        <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 08:31:00 +0000
Subject: [PATCH v2 2/5] cmake: copy the merge tools for testing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Even when running the tests via CTest, t7609 and t7610 rely on more than
only a few mergetools to be copied to the build directory. Let's make it
so.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 4aee1e24342..fe606c179f7 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1078,7 +1078,8 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 	#misc copies
 	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
 	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
-	file(COPY ${CMAKE_SOURCE_DIR}/mergetools/tkdiff DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
+	file(GLOB mergetools "${CMAKE_SOURCE_DIR}/mergetools/*")
+	file(COPY ${mergetools} DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
 	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
 	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-completion.bash DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
 endif()
-- 
gitgitgadget

