Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501E2C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 15:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjECPcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 11:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjECPcA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 11:32:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F9359D1
        for <git@vger.kernel.org>; Wed,  3 May 2023 08:31:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f18335a870so33397345e9.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683127917; x=1685719917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqJA5kJh8OfYJU5vYvtM2c8Iz2ru8lfdqzkLPnVuUTQ=;
        b=XKN+2qdzGCb42l8jBu3Zjy74adcWwoe2XmYNeGgellMFbGCnV4YK8aEV52cu7tY9Z5
         ZzmuAoj54cxgt28qHH3tZUIb9MGbxcTQ8d0pU438D1Gn0MaV1x/PR7WYLk7YhZHi9RJ3
         SYJ3WlPczeErPkadmVmAMk1nVSar9YORVtjun5hstBJQjEOMID0xTLp8+o5D8RglI9/W
         e4RDY1oBlFl9KdWKy9IQPslWAX7mvH24lX3r9kw3ZsUa/QHclpjh13H+DIhApimCJWoo
         VAkSIU8QBPf48DLT/0EZvawWaZwqnhAjDPnHzfB/x2DzK5qygP3Ka5IftLycDJpNFK9F
         REvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683127917; x=1685719917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqJA5kJh8OfYJU5vYvtM2c8Iz2ru8lfdqzkLPnVuUTQ=;
        b=Pi6kmmm237QaM/thwIdu5W9somwyKjGmaCMmChjLZVRLgqfQdclraqGXMR5zJRRgAR
         dMVqoTxkYhL/ezWkHG3jOaWM1PPICXA1ltoDUpOa87CJLANjDU1Zo2WbvVhVftOSxDtQ
         +KC1/jhbNYDoW9R86fw3Gm9bsVmlw13Cb7iv6n/SWO304Vx5BAGJ/V7Dcy139Qhrk4B/
         CCqWHkec72+IIWHaQLBYU79xOB77V99nUuW/IXXvxCfnPAjDKuChur4IdVVDeK+c7/vb
         iCyYl8X1at7NwyLj03q9kf/yXZPEz84O3L5MuSHWvZQqDA/T4d9ov68CZSocP/U+qnGH
         SK/w==
X-Gm-Message-State: AC+VfDyKLlBRg9M3yVON6PlygYYrMVU34rvpKEpPRbjLrltiRxDXc0uo
        0e4t7LKXfF/xqUnEr7Wjhr0Q3a8l9eQ=
X-Google-Smtp-Source: ACHHUZ5fBZ89AKWVmC5WRJHHCNf5bm/sPUpBUcNbDxQbN+geSXMDDouyWNqn/vmhqq7hst/vrZRUUA==
X-Received: by 2002:adf:eec3:0:b0:306:297b:927f with SMTP id a3-20020adfeec3000000b00306297b927fmr393554wrp.25.1683127917393;
        Wed, 03 May 2023 08:31:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm34267654wrz.75.2023.05.03.08.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:31:57 -0700 (PDT)
Message-Id: <pull.862.v2.git.git.1683127916363.gitgitgadget@gmail.com>
In-Reply-To: <pull.862.git.git.1601888338644.gitgitgadget@gmail.com>
References: <pull.862.git.git.1601888338644.gitgitgadget@gmail.com>
From:   "Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 May 2023 15:31:56 +0000
Subject: [PATCH v2] docs: clarify git rm --cached function in gitignore note
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Sohom <sohom.datta@learner.manipal.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sohom <sohom.datta@learner.manipal.edu>

Explain to users that the step to untrack a file will not also keep it
untracked in the future.

Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
---
    docs: Clarify git rm --cached function in gitignore note
    
    Added text explaining that the git rm --cached command isn't analogous
    to the gitignore file and that the file will need to be added to
    gitignore to prevent later commits from adding the file back.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-862%2Fsohomdatta1%2Fgitignore-note-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-862/sohomdatta1/gitignore-note-v2
Pull-Request: https://github.com/git/git/pull/862

Range-diff vs v1:

 1:  053e9f99c9e ! 1:  c3257398c8f docs: clarify git rm --cached function in gitignore note
     @@ Metadata
       ## Commit message ##
          docs: clarify git rm --cached function in gitignore note
      
     -    Added text explaining that the git rm --cached command
     -    isn't analogous to the gitignore file and that the file
     -    will need to be added to gitignore to prevent later
     -    commits from adding the file back.
     +    Explain to users that the step to untrack a file will not also keep it
     +    untracked in the future.
      
          Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
      
     @@ Documentation/gitignore.txt: The purpose of gitignore files is to ensure that ce
      +can then be added to the `gitignore` file to stop the file from
      +being reintroduced in later commits.
       
     - EXAMPLES
     - --------
     + Git does not follow symbolic links when accessing a `.gitignore` file in
     + the working tree. This keeps behavior consistent when the file is


 Documentation/gitignore.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index f2738b10db6..8b78e1b3e08 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -146,7 +146,9 @@ The purpose of gitignore files is to ensure that certain files
 not tracked by Git remain untracked.
 
 To stop tracking a file that is currently tracked, use
-'git rm --cached'.
+'git rm --cached' to remove the file from the index. The filename
+can then be added to the `gitignore` file to stop the file from
+being reintroduced in later commits.
 
 Git does not follow symbolic links when accessing a `.gitignore` file in
 the working tree. This keeps behavior consistent when the file is

base-commit: 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
-- 
gitgitgadget
