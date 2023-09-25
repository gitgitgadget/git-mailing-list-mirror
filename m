Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86594CE7A95
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjIYLVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjIYLUz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:20:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FC7D3
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4053c6f0d55so56838235e9.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695640847; x=1696245647; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23l3Z8R4FAVJkDvMIqmZkHPda5QO1OxxfN1rwfQduxM=;
        b=SOuHma9yqqtJZORiroQ3rrgh7BrCqyUY9eZwsBUWqZn+pGV0WiOEvMgZxJzgygYOQ8
         r5N+fJyIjFJYDgrxWhtz8OjEVYBY0KaciJ2uOTkyVIE7I9MrefuyAwS2iYNiS1GXbEEP
         Abf31A2yOeVeHZpPiR/Kcuj/6i9qIVt6TPZ498NWZiE+fqjLqOPiGot7WIsvh9mSpKrm
         5F+MtFY/eLBLOVJCrgYukjQjNtG84S/rKzIcmONB1D0wd2btIegeBf6oQVeqP3Z1XzCp
         /etSEXYDSjCktZs5HGPZwhbn3Ioep+VL54HdnCTLwbqI92w/mIQUAnNcnMzPPkMjIhpU
         Fz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695640847; x=1696245647;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23l3Z8R4FAVJkDvMIqmZkHPda5QO1OxxfN1rwfQduxM=;
        b=CYSEw+KtFrrnToRcluWv+7AfDz01VblTa1lLP06+QAcicLnI5xa3yIe/wqlWFn/wjI
         sAprLPEjHOBT7XWIRirNQiRbffQmVuI+q9vL2xJAtjndb9leDTzu6U3f7tMd74RbaMpP
         Q9AuHhDwv/yU0PyNwWpBvsItrzqrymoJUTFVdipS+v2/e/5za0sX7WEDb/2yZfkzkkTP
         59V+SkZU1GZFrqXBK+/cCOMcdYrzLWd4/0jVYoR8UMjJDr4+ckdJbhgvEvLFEJWxC1xV
         pkDKoa3vSvbjgUwyF8wXCp7m70/aqu/Qk0fYGzZlCuXk7ICgRVxjZ/5GHGON9TGFTv4B
         nKxA==
X-Gm-Message-State: AOJu0Ywoo60XST5WvTeSLKkCrJMnFpKC9f59lAysOHhUUMzkho5SJPPD
        4JWeXIW/tfwPoAG6qtDKUMV4z3uI9/4=
X-Google-Smtp-Source: AGHT+IGaMfGnxqPDR1B+s6bFyGQbIa2woKESwdtzHPXfG5IgIkRZ81TExhv8E7TMGDUOBnV0O12DHQ==
X-Received: by 2002:a05:600c:3658:b0:405:37bb:d93e with SMTP id y24-20020a05600c365800b0040537bbd93emr6347118wmq.9.1695640846743;
        Mon, 25 Sep 2023 04:20:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11-20020a7bc04b000000b003fee6e170f9sm11840536wmc.45.2023.09.25.04.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:20:46 -0700 (PDT)
Message-ID: <75a74571fbee7677d0e473a199d99c10da35ba09.1695640837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
References: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
        <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:20:34 +0000
Subject: [PATCH v3 5/7] cmake: fix typo in variable name
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

