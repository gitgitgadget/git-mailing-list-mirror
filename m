Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1FFC77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 21:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjECVqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 17:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjECVqp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 17:46:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3856B4EE2
        for <git@vger.kernel.org>; Wed,  3 May 2023 14:46:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f315735514so41665075e9.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683150402; x=1685742402;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbKQoY5DKMO3tIfdKKWi7ifsJmYPiuq/pxGNpOoHmlw=;
        b=Mg//IpPOkiRbD7wXhYifCWEr13xCp03S7qHB6eaNiRNkBoQc4x+zMr5Oc626FZL5Vn
         k0vPuGok60bI8puwulAox5rQXNF5+YTADxjQcU68zZNDwmfHBKPgVVF2+S7GM2XqAs6m
         bsR1KplNGsgQiVbx4WL0Vjmquu2m20MtvIpEj4Q5Jxhn/oF7YekNdIXajEBpKd3LpNeA
         /1JYN50Vz8pUIpHK+cUasv5DLzCt3oXjVoeYp5Wmc9SO5F+0ZDuFM7JrIGKjWaXU0XJv
         ald+HBij1x44hGGa9Vq2zjtB4Hl1jikMT1+xWwLX7kml4R6+LF9q5E3TasE87UW1DTWf
         dumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683150402; x=1685742402;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbKQoY5DKMO3tIfdKKWi7ifsJmYPiuq/pxGNpOoHmlw=;
        b=YeHupGzr/hLQAHniRd17JdfSDS3yVgLkUBcNQAd5rpxUOYC2HALyrAIjVbVb0S5qjp
         m5m6OPtx5gnqAZAOuM0EVFPLczZIwnhIKTrN+NF7kHsC43ZUd78maO2CZPqmQRoIoqR1
         fdSVsfQA5bHz7/t9C1mcNNP94uksfNBR1kAV7UQ43qq1LkYO35eVqlxIY79qCEXQI65N
         5vY4cT6P5+KE+5T0/erHf0TKVhC0rNEs88ekEYysiQZq928Pkc7F0WV4SnnI0AQunmaU
         fZjNVp4mlUfJ61Q8iVJ0aWV6LpMsEaMuuI7y5VPG/LwLK1YvdAdTbG+Tp1J9RaX81nHa
         2Lmg==
X-Gm-Message-State: AC+VfDyvB6umMUzX2/RTjul4mhSDhcUkVMfv2owvhpEVizvC59kVwYR/
        8JqSeu+ATXcLB2Pgad7P0eq4cRY/hHY=
X-Google-Smtp-Source: ACHHUZ7QopqZ/slD+gjHs2mxMhk1f8poWPE952g1WDSarA2PPPhlNsh4sxdpLSHRdcqacgkNGA7myQ==
X-Received: by 2002:a1c:ed15:0:b0:3f1:72d8:a1b1 with SMTP id l21-20020a1ced15000000b003f172d8a1b1mr2591145wmh.7.1683150402359;
        Wed, 03 May 2023 14:46:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6-20020a1c4b06000000b003f17131952fsm2933720wma.29.2023.05.03.14.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:46:41 -0700 (PDT)
Message-Id: <pull.862.v3.git.git.1683150400953.gitgitgadget@gmail.com>
In-Reply-To: <pull.862.v2.git.git.1683127916363.gitgitgadget@gmail.com>
References: <pull.862.v2.git.git.1683127916363.gitgitgadget@gmail.com>
From:   "Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 May 2023 21:46:40 +0000
Subject: [PATCH v3] docs: clarify git rm --cached function in gitignore note
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Sohom Datta <sohom.datta@learner.manipal.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sohom Datta <sohom.datta@learner.manipal.edu>

Explain to users that the step to untrack a file will not also prevent them
from getting added in the future.

Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
---
    docs: Clarify git rm --cached function in gitignore note
    
    I've fixed the Sign-Off v/s commit author issue and incorporated the
    changes suggested :)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-862%2Fsohomdatta1%2Fgitignore-note-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-862/sohomdatta1/gitignore-note-v3
Pull-Request: https://github.com/git/git/pull/862

Range-diff vs v2:

 1:  c3257398c8f ! 1:  ae09ff2e70c docs: clarify git rm --cached function in gitignore note
     @@
       ## Metadata ##
     -Author: Sohom <sohom.datta@learner.manipal.edu>
     +Author: Sohom Datta <sohom.datta@learner.manipal.edu>
      
       ## Commit message ##
          docs: clarify git rm --cached function in gitignore note
      
     -    Explain to users that the step to untrack a file will not also keep it
     -    untracked in the future.
     +    Explain to users that the step to untrack a file will not also prevent them
     +    from getting added in the future.
      
          Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
      
     @@ Documentation/gitignore.txt: The purpose of gitignore files is to ensure that ce
       To stop tracking a file that is currently tracked, use
      -'git rm --cached'.
      +'git rm --cached' to remove the file from the index. The filename
     -+can then be added to the `gitignore` file to stop the file from
     ++can then be added to the `.gitignore` file to stop the file from
      +being reintroduced in later commits.
       
       Git does not follow symbolic links when accessing a `.gitignore` file in


 Documentation/gitignore.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index f2738b10db6..4c17f2356c4 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -146,7 +146,9 @@ The purpose of gitignore files is to ensure that certain files
 not tracked by Git remain untracked.
 
 To stop tracking a file that is currently tracked, use
-'git rm --cached'.
+'git rm --cached' to remove the file from the index. The filename
+can then be added to the `.gitignore` file to stop the file from
+being reintroduced in later commits.
 
 Git does not follow symbolic links when accessing a `.gitignore` file in
 the working tree. This keeps behavior consistent when the file is

base-commit: 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
-- 
gitgitgadget
