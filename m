Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEFEEED61A
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 17:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbjIORxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 13:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbjIORxh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 13:53:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D19199
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 10:53:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9adcb89b48bso134915866b.2
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694800410; x=1695405210; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0DOu1kmTeXXfsRvOdFwblxr1cR21ehxv9jJVcDmkvoo=;
        b=b6NMC9DT/tR3MXthN58pQdVCy16DYZ3B3q9K1MbzNhKRCcEkcFBquORuNx3uMRyVq4
         YoA7fNn7YxZhqblVEQQu49B0riFI5ZjxEiYw4Gvhm/WPKWX6L5NW4UlS3BLLxgrFcU1o
         lxCZcdIZRFcqbrJlBCak5ufeAs8uhI71cQPR/ynmRmt4rhaAiI1nOUEBx3nmuHFoKKuy
         1CrpgBT7PDpw8URuc1GHL5B0+E1/GXnoXQZpLVdQgUHG1SvT5LMwViqS5rXRvHFX1o3R
         Jn1RAcoeAne+oHWdtT+M31UW21FomJ5Gil8K9f7Hh9wAQS2rHjma+KSN7FIR9wySaaQd
         MPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694800410; x=1695405210;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DOu1kmTeXXfsRvOdFwblxr1cR21ehxv9jJVcDmkvoo=;
        b=GcdVBvpxIHK+72GHLsIHVT+IWxE580zA4GRhTAVekfqWLHU+/nGn2L6atIeRWb8Eo4
         M7FWRB5uzkPPPNpnuYgXUgKI8t+QK7gGI5mp9DEM4Ggpr/AJU9IPluK1gSwy7asoatx5
         wPt1gLtNAAjvM2RqxRS2N5V6TxQ+01dH1iFQSIXvXcqnyTQqJ45jvu+WDd7osbBI3TB4
         JtcKcLBaNZhPD91z8FAXY+6x2PEunj0mLIqUCtRgOJ/LgGJ+Qugbxz7JHcJtkCv5Vk+8
         DSoVJhBU00rs46rhi1Uiv/HruBzQjNQ4JRfQ9PztQ/0c+mUf9VCCeAcwnk5cPEvs0m/b
         vSgA==
X-Gm-Message-State: AOJu0YztgM8kmun9QkuSza1ryb8numFpTEy2bSBoXpZ6Mcs7aBsriPJB
        HErgwHTQzjsXkFRpZnG3xtkluPbUTIc=
X-Google-Smtp-Source: AGHT+IHR3k4qcapYOO8V8VzXJL42P9VYsDVxwRa+Cvk6GehIcYzzPUBJ3G0k/7+hKLcfEU9PaoFSnQ==
X-Received: by 2002:a17:907:2724:b0:9a6:6314:4437 with SMTP id d4-20020a170907272400b009a663144437mr2063432ejl.39.1694800410304;
        Fri, 15 Sep 2023 10:53:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906854b00b0099ccee57ac2sm2692247ejy.194.2023.09.15.10.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:53:30 -0700 (PDT)
Message-ID: <pull.1572.git.git.1694800409471.gitgitgadget@gmail.com>
From:   "Caleb Hill via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Sep 2023 17:53:29 +0000
Subject: [PATCH] docs: fix "without do cleaning" typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Caleb Hill <hillcaleb@protonmail.com>,
        Caleb Hill <chill389cc@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Caleb Hill <chill389cc@gmail.com>

This pr fixes a typo I noticed today while reading documentation here:
https://git-scm.com/docs/git-clean#Documentation/git-clean.txt-quit

Signed-off-by: Caleb Hill <chill389cc@gmail.com>
---
    docs: fix "without do cleaning" typo
    
    This pr fixes a simple typo I noticed today while reading documentation
    here:
    https://git-scm.com/docs/git-clean#Documentation/git-clean.txt-quit

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1572%2Fchill389cc%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1572/chill389cc/master-v1
Pull-Request: https://github.com/git/git/pull/1572

 Documentation/git-clean.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 160d08b86bb..5e1a3d5148c 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -127,7 +127,7 @@ ask each::
 
 quit::
 
-  This lets you quit without do cleaning.
+  This lets you quit without doing any cleaning.
 
 help::
 

base-commit: 94e83dcf5b5faaa22e32729305f8fd7090bfdfed
-- 
gitgitgadget
