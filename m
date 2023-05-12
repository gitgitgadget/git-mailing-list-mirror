Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A86C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 15:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbjELPJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 11:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241720AbjELPJV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 11:09:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92605FFF
        for <git@vger.kernel.org>; Fri, 12 May 2023 08:09:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f42b984405so32531625e9.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683904158; x=1686496158;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Iij93rJdDuabRIYHT2lU0GRF9R+zjBILr74xrJHzZE=;
        b=HCqeR8ZlOTcVSFQHoBrPPBPllZhKMmx+LbY2NhW3xSCVpxxI8XzZKOdVvkfpkh+Y8u
         EhxkE2ByoPTDR4FDBRKlyZfLEly+HRMAYsszNrY5d4QXV9U+vaoUlRbkNxpTy+wW2+Jy
         Q6wDktY9u69B9WGp77Q1SkbwC4Tm9Gtrg6ICe8ztqifT8iKkVAGrVApm0H5EHnpFQIKy
         5baypVq27GRfVS8V1u439Dq7Wx6NK25y8QtPCip86Nj2kM30e+h4Q6IE1OOaJbTgeW8z
         INwWetjjPQC0QvV3lfuv2j6PQm8Enmmo603VZI77r85vZQwy3XHtvytm/9eIyrqDoB1D
         PcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683904158; x=1686496158;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Iij93rJdDuabRIYHT2lU0GRF9R+zjBILr74xrJHzZE=;
        b=iiPYxg7479utNdjfnCyW9pVbkrf69PXjWy0O0eN3uhzfArSNTKAYxnJGc9umMf54a/
         ynazISn1+Rxq5z+MMz3RVC3UdVKD9hdzn+/MaEUm48rvwFCtk0aN+ClhtchfYX5OZBXI
         NuLy0/UdRmBCVW73Vws7THqf0tTkeQVYDhAa/vM/RoCcq114a51IamPX8cJj3hv8ablE
         V7B7h+SESsx3z9rRGe/I0ARIDgnkWTPFMgjVZKeuVawmZ/M/5sCczEIEYgy0xIV70DvE
         ytBjw9f6ylsALV7dp7NEw6fLr+tHOvby14GePec01hv3fPPWrXIFtxdpFMLiD16qgQ7o
         ejsg==
X-Gm-Message-State: AC+VfDwKCQYZp+/YaGA/7GsfP+miLbbHtXQy/LLO8SR0MI2/DpdJFqHX
        RzQaXEFYPIYk67QjNzJcF9MlFuyQ8IM=
X-Google-Smtp-Source: ACHHUZ7E47eT25golREznzHuu0K6vCNHKKO/nGU8Z1bqtfTmsyiAluqVwk7irHk573PYjKzmiZ7/uA==
X-Received: by 2002:adf:dd46:0:b0:307:8d6a:a48e with SMTP id u6-20020adfdd46000000b003078d6aa48emr14859313wrm.52.1683904157657;
        Fri, 12 May 2023 08:09:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15-20020adfe6cf000000b0030633152664sm23662975wrm.87.2023.05.12.08.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 08:09:17 -0700 (PDT)
Message-Id: <pull.1532.git.1683904156670.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 15:09:16 +0000
Subject: [PATCH] t5583: fix shebang line
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The shebang was missing the leading `/` character, resulting in:

    $ ./t5583-push-branches.sh
    bash: ./t5583-push-branches.sh: cannot execute: required file not found

Add the missing character so the test can run.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    t5583: fix shebang line
    
    Applies on the top of tl/push-branches-is-an-alias-for-all.
    
    Noticed yesterday when testing my header cleanups against next & seen.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1532%2Fnewren%2Ffix-tl-push-branches-is-an-alias-for-all-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1532/newren/fix-tl-push-branches-is-an-alias-for-all-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1532

 t/t5583-push-branches.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5583-push-branches.sh b/t/t5583-push-branches.sh
index 29a5c5601bd..e7e1b6dab66 100755
--- a/t/t5583-push-branches.sh
+++ b/t/t5583-push-branches.sh
@@ -1,4 +1,4 @@
-#!bin/sh
+#!/bin/sh
 
 test_description='check the consisitency of behavior of --all and --branches'
 

base-commit: 425b4d7f47bd2be561ced14eac36056390862e8c
-- 
gitgitgadget
