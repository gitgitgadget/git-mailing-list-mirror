Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FF3CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjIYLVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbjIYLUy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:20:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F6C6
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4054496bde3so43171305e9.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695640846; x=1696245646; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPUNwTpoGT9m/YFejKsp7W7P/TOk3usDGQALMcYRJwg=;
        b=V3dHugFanECtiahS3JZTKYw4mFP2jyH9lHW9yLArRnKlVZ/f2it8p4b9wVAuf3TNqp
         dvgOXesla6bU8vTTulHQ7IoPYts5AymDVoYDMBiAajCHWOPUa96NSVWy+WZFmmNtCFLA
         IWZt7a7lcHFuT5M/SY2dM4yfCx5tNMCfuha3r8rZgZ8dqCnZAjtBMzAjBCtVyMyKs44D
         ZY9xuHIJt1ISzNRVgYjv5Su83yfw2NvAHH6X5Svg9xjzFOErKk70VhkCq4gZSD5mNr5n
         Bgs5me42VQqN3c9Xa68RNueOX89nmhRamQ32eyuTSTEii1WUKNEHODRV6wh76zydmqdU
         o5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695640846; x=1696245646;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPUNwTpoGT9m/YFejKsp7W7P/TOk3usDGQALMcYRJwg=;
        b=dGVO5BKcNlkidUBGA18BKXe4fx8lHHfZbDDDXXx9k4bi1LbmxU/7/NFw9NGNo3OMYk
         2vwmysPwJ3xvEU46/qWJoJhVCiCxPx7BNoOTubv8YoMWKPUpNMG+t5ngvy68wrP3uIfV
         7dEBt+HWO3GvvFCrV86PUA4dmjkLaIlzRlL8iaFhzSimvsAiYHBKxMJedwEdpOKOvquY
         uHCQz6if44NIrDJhExTEVkpmv+F1IM5eCSZrx0vGQEugec4EafFHqYR1Eex7DhyjEGpj
         iFP3qHs2/ceCqGYPsVS3XnmP/KGrj3DT7VEOaSwlMggfzvDRpof0trBXnp5a1RlElyDk
         bSMA==
X-Gm-Message-State: AOJu0YycAFZHRe+oKKK8tH92Z4QTQsbpH8f/fcZGf1qnrzwi+clPoULF
        zGI/yI1GfnAhg/NmyfOB494/f6Cixq4=
X-Google-Smtp-Source: AGHT+IE0FponFSjYy9+dajtwvuwfMSqOaxkvCieF8FyJbPTjQ2sedJHObkdPnJ9x2yj0eXkYAbVdvQ==
X-Received: by 2002:a7b:ca45:0:b0:405:40c6:2b96 with SMTP id m5-20020a7bca45000000b0040540c62b96mr5360596wml.3.1695640845676;
        Mon, 25 Sep 2023 04:20:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc44a000000b003fed70fb09dsm11950596wmi.26.2023.09.25.04.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:20:43 -0700 (PDT)
Message-ID: <a70339f57a7f49b5db7d7b96131e53601592e8b5.1695640837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
References: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
        <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:20:33 +0000
Subject: [PATCH v3 4/7] artifacts-tar: when including `.dll` files, don't
 forget the unit-tests
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

As of recent, Git also builds executables in `t/unit-tests/`. For
technical reasons, when building with CMake and Visual C, the
dependencies (".dll files") need to be copied there, too, otherwise
running the executable will fail "due to missing dependencies".

The CMake definition already contains the directives to copy those
`.dll` files, but we also need to adjust the `artifacts-tar` rule in
the `Makefile` accordingly to let the `vs-test` job in the CI runs
pass successfully.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4016da6e39c..d95a7b19b50 100644
--- a/Makefile
+++ b/Makefile
@@ -3596,7 +3596,7 @@ rpm::
 .PHONY: rpm
 
 ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
-OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll)
+OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll t/unit-tests/*.dll)
 endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
-- 
gitgitgadget

