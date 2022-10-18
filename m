Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3941C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 10:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJRK7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 06:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJRK7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 06:59:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09A018B08
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 03:59:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w18so22839262wro.7
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 03:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0tMKdv7eU70aifszClnd20mLEDmV7jo+jeNIIrwvS0=;
        b=dD1NZ2fuQ3OMCY9BzEghk4zGLWr3903zndfB0Fb0/khEXrJ+YyDHfNcZCvkdLtr4kj
         mfX6Ji64bYIAtDSDmPkOmvA4/U6V28XlljaFzGx/jv/sclb8o/8/4e1MGDcqYEmFYx2P
         iCaijnG4MbrG58NsJyzzjsp/o9VbK4flbMqECPALPaXryT1LU8V+4pNvaxYUGPeL1/qB
         BJFwI5RXgXMCk14us8093yt1QzVndJYX6LvfG4T+pa1j3aYW2O/46dVoebXZ5h+kumbD
         vUWouE7nZZC69yzpDoce9+kCqlZGPbt/1g+DK6nI8V1YDxH/Gd/8yxdesxeN8NKlmc+Q
         cl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0tMKdv7eU70aifszClnd20mLEDmV7jo+jeNIIrwvS0=;
        b=ahyeW4uVnXth9N+efMM2V49cJltEdJHlicD32qc9eBPw2ji01+/KvN+cWEFD1jK6S/
         EH5N1+pqy4LFjeUeOlbK0OxgCP4z5YpDt5jsMUfkOGTr6qNZ8F40oWfLX3l2o5cs6L0J
         18y+TlyCdfNJPEC8bcequpBQt1GAbDNtpd0EnKjtPF2A2/hgqeaA5Blgopokj4WQTllf
         x8LXiCUL5IvDSdzCb9eYcSGQ9MyANUgZKY30oASeq8qWoPPgMYLRlT1P1fQFeAwOFoFp
         kIlP50eVufj4VwX86ECZNDamMdyZBfAxp7Q97ET8MX/bzSPC4DR4qbZPHNqZ7huCkf6V
         WMIw==
X-Gm-Message-State: ACrzQf0/uuOp+6UDI1Iv1zJSS4aOslwELhvxufWGHpv72JkJgb3JhJy8
        j6UvLQcTl6uWnkIOSC8hR0Nk1BgATI0=
X-Google-Smtp-Source: AMsMyM74bQvvti44mzVtMb3anq8E/m8/rxGlstJ4XEh9MKLTfTs20hAnDE8fZF/CxL6ELPbVRpqsJQ==
X-Received: by 2002:adf:e18b:0:b0:22e:a2ce:7746 with SMTP id az11-20020adfe18b000000b0022ea2ce7746mr1498600wrb.468.1666090749943;
        Tue, 18 Oct 2022 03:59:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u6-20020adfeb46000000b002258235bda3sm10649042wrn.61.2022.10.18.03.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:59:09 -0700 (PDT)
Message-Id: <9faca9d5cbe706c00d03ca2a125f2e113294a548.1666090745.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
References: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
        <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Oct 2022 10:59:02 +0000
Subject: [PATCH v3 2/5] cmake: copy the merge tools for testing
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

Even when running the tests via CTest, t7609 and t7610 rely on more than
only a few mergetools to be copied to the build directory. Let's make it
so.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 6ac20bc5054..0c741e7d878 100644
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

