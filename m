Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A7DC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 21:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbiC3Vo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 17:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiC3Voy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 17:44:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022086A411
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 14:43:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so31140561wrg.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 14:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=weYzSYC+soQL02GTTTIZHPHsn0YcPztzg5wsjm6w8vY=;
        b=ey1B9lRYfeQRDqs39hBd8PnOu0/GqCPP1GF0Yw+RGdGjDRKpmWnAPB29qKITnBBLgY
         tIlXX9gcf4vkEKI0cI3SS0P3xnLRTn9CAx2IjXnxaltnZNCxNXsd7Q5M0CjNrNlwSyxZ
         /2HmpBqtj+0/9FbL7BKo5jACKEFTqeNCujkz3c8G++xIOkBw8XhiPl0KYrDU7plAv9ms
         B5V9/5Nl2VxU9Ri3VQWWf2QqIR0Oj61NlTwuwMjwuNmqF+MBxPqyk7COuJ/u5K8qFton
         l8xnQ9xH5hw9XOY2AP1cC+kjObf3F0/v31r+ThJJeNT0W6EAp1VyFtyI/DZho5i/uJx+
         7S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=weYzSYC+soQL02GTTTIZHPHsn0YcPztzg5wsjm6w8vY=;
        b=6R0I+aX8S5Naiwm8wmLwE1arVp/FsVflafn0WaSfyR1RFfU+IGPp9GQF+LQzPU0DbO
         orSbPYAkabvgupF7TiYUNHdoTxcpc8IbTKNvGqgpH5wPUbnAJtXUHXqVThdYJ0C8T5SO
         TWbLLByMURfkOh9EPYIMP9yuwMLial02QDDhizTLDsndFnC5BfOYlg/qT+88gl9tWiyF
         ZT77RKNevhT2LhlhvPlj658Do9nAs5D+g2/OROHZr8bueWNPmTGOP1q/nV358yY33q1b
         OqFttI6w7XRvR7PXRZuxt2+rT/vlhsZThqOIBq9/OXkjm/LFo2Xt9t6QrMNTH9jUDHSA
         J6+Q==
X-Gm-Message-State: AOAM531d7fRke/Nu6YglZU3CLqawqhhkpfenewQ32MUCaDUKNJodY03H
        Tum9QOHsfSRx/k2NQ7cF2FBdU6Y1YwY=
X-Google-Smtp-Source: ABdhPJxhoZ3NnXAH6byX0x3mXN5xg+kuThVzmwvuBCkKvGBQ6gmu3Y2mtVhMIrPNHJpOanDIEHHnsg==
X-Received: by 2002:adf:a482:0:b0:1e3:3e5f:496c with SMTP id g2-20020adfa482000000b001e33e5f496cmr1437360wrb.606.1648676586987;
        Wed, 30 Mar 2022 14:43:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm7014967wmp.13.2022.03.30.14.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 14:43:06 -0700 (PDT)
Message-Id: <pull.1195.git.1648676585765.gitgitgadget@gmail.com>
From:   "Labnan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 21:43:05 +0000
Subject: [PATCH] t3501: use test_path_is_* functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Labnan <khalid.masum.92@gmail.com>,
        Labnann <khalid.masum.92@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Labnann <khalid.masum.92@gmail.com>

Two test -f are present in t3501. They can be replaced with appropriate
helper function: test_path_is_file

Signed-off-by: Labnann <khalid.masum.92@gmail.com>
---
    [GSoC][PATCH] t3501: Use test_path_is_* Functions
    
    Two test -f are present in t3501. They can be replaced with appropriate
    helper function: test_path_is_file. Which makes the script more readable
    and gives better error messages.
    
    Signed-off-by: Labnann khalid.masum.92@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1195%2FLabnann%2Ft3501-helper-functions-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1195/Labnann/t3501-helper-functions-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1195

 t/t3501-revert-cherry-pick.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 8617efaaf1e..45492a7ed09 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -67,7 +67,7 @@ test_expect_success 'cherry-pick after renaming branch' '
 	git checkout rename2 &&
 	git cherry-pick added &&
 	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
-	test -f opos &&
+	test_path_is_file opos &&
 	grep "Add extra line at the end" opos &&
 	git reflog -1 | grep cherry-pick
 
@@ -78,7 +78,7 @@ test_expect_success 'revert after renaming branch' '
 	git checkout rename1 &&
 	git revert added &&
 	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
-	test -f spoo &&
+	test_path_is_file spoo &&
 	! grep "Add extra line at the end" spoo &&
 	git reflog -1 | grep revert
 

base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b
-- 
gitgitgadget
