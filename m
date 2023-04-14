Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BBCC77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 17:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDNR6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNR6n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 13:58:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243757D91
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:58:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e7so8288909wrc.12
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681495120; x=1684087120;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FnA6/YolMMmO2tc4leibR54IFJLffBmscCL9fWdJ6tE=;
        b=QytZLTScI7BpOaPVXcXB0avDmGB5+aZm3mowdvsuVM31L2CueoJkqLw67g2SIOY7nN
         D33SCLshkPNpsh1mcgj5vP6sHUy2Dlf0wt092HoGVWITcQjVsnWZdYQySmclIJaYnSLN
         d67jxMc1Nsv/ZSWst2Gbb8OcEMzYJhWJsAj6UOBJ0zyshxTt5oCzYr2VbMiUB8tCQBeU
         Xn9DjnFpQvom1BvtMAOmSUo9gONpf8nkfr0mFq64ETpV+rbK9zpHMD36nzikiRGzhV7j
         VrEiQ9ri9/amFaFdLoMyyb98RcZSG+5AUEgOUMxUgcAS3mKeEGRw4W8XCC7dMmpE0kGS
         bz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681495120; x=1684087120;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnA6/YolMMmO2tc4leibR54IFJLffBmscCL9fWdJ6tE=;
        b=gs1vuSgK8U4QRqoGWKwvVQTSr+7VNYt+lUz/kVzSpuXaM1qM7nRyfly5dXjtnei6/G
         LVNB/+4a57CK4AlqjQVqIdvtX/2rEiG0pLe83gV1ljQ6UEGYXpzSHtAqZKRIaFU+Vtk1
         7klfhrVONdRw4YJHE0Si9MKWLMd6HKtynSFuI9fqOS69FFf7/ERpLU3gPiBiHDf1nqsh
         NKlc8IzOnHG6cEx1aXgMM0OdBiFsafmo4rVAWPlq2YEFJoTgSRPacfnsjDNHP9Q6Y7di
         7G9Xn6We/5ik+As4rt8PmApnEP5WLGOPwYk3L2k/6WPnwgt8GqzO2LAgiMuAvz0cT4TK
         Gp6w==
X-Gm-Message-State: AAQBX9eA74GJBZJjEHugn9iJZuKmecIqN0iC7OB3PB9yCDqOIU2lW2Ca
        xh1Zk3Yxdc7c2eGvBBsS7Df1z/6j8lA=
X-Google-Smtp-Source: AKy350YvOQpd39SD0YNuL0zbyI8qYL+UNiFT4z1W/c/YDwEM4xUzttFExa9mLn7epTL8rPAHOBEQgw==
X-Received: by 2002:adf:e3cb:0:b0:2f5:8116:6458 with SMTP id k11-20020adfe3cb000000b002f581166458mr5194514wrm.66.1681495119992;
        Fri, 14 Apr 2023 10:58:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4-20020adfe544000000b002f6dafef040sm2289986wrm.12.2023.04.14.10.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:58:39 -0700 (PDT)
Message-Id: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Apr 2023 17:58:33 +0000
Subject: [PATCH 0/5] Document 'AUTO_MERGE' and more special refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds documentation (and completion!) for AUTO_MERGE. In doing so
I noticed that some other special refs where not mentioned in 'gitrevisions'
nor suggested by the completion, so I also tried to improve that.

Since the changes are in the same parts of the same files, I thought it made
more sense to send everything in the same series to avoid conflicts, but I
can send the AUTO_MERGE patches on top of the other ones in a separate
series if that would be preferred.

Here is a breakdown of the patches. First the "other special refs" patches:

 * [PATCH 1/5] revisions.txt: document more special refs
 * [PATCH 2/5] completion: complete REVERT_HEAD and BISECT_HEAD

Then a preparatory cleanup for the AUTO_MERGE patches:

 * [PATCH 3/5] git-merge.txt: modernize word choice in "True merge" section

Finally the AUTO_MERGE patches:

 * [PATCH 4/5] Documentation: document AUTO_MERGE
 * [PATCH 5/5] completion: complete AUTO_MERGE

Thanks Elijah for this very useful feature! Dscho, I'm CC-ing you since you
opened https://github.com/gitgitgadget/git/issues/1471, I hope that's OK.

Cheers,

Philippe.

Philippe Blain (5):
  revisions.txt: document more special refs
  completion: complete REVERT_HEAD and BISECT_HEAD
  git-merge.txt: modernize word choice in "True merge" section
  Documentation: document AUTO_MERGE
  completion: complete AUTO_MERGE

 Documentation/git-diff.txt             |  8 +++++++-
 Documentation/git-merge.txt            | 11 ++++++++---
 Documentation/revisions.txt            | 15 ++++++++++++--
 Documentation/user-manual.txt          | 27 ++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  2 +-
 5 files changed, 56 insertions(+), 7 deletions(-)


base-commit: a0f05f684010332ab3a706979d191b9157643f80
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1515%2Fphil-blain%2Fdoc-auto-merge-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1515/phil-blain/doc-auto-merge-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1515
-- 
gitgitgadget
