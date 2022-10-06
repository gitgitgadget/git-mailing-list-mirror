Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BABC433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 19:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiJFTnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 15:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiJFTnT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 15:43:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BC4E3195
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 12:43:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f11so4238397wrm.6
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OubDWcbKj1/e3L7ycAP1shHvzYTCXKmnWOkd6uEz4cM=;
        b=mp5djvtIzHOKHY3TEyhyM4lOsvIlyWd7y25vP7S08eFUQEaDLJgrsCs7JVXbCpsz3n
         YL1q+jD3czV9MAw+mlkvq+xMUUF45swkxbOkcE7i/Vm3IsuuehNFWVFtpjAA8nNt138o
         +xikVHJpBYlicMvZdJPr6frQT77xkzYzmmNqQ/OfW8y9x5U7UKg7DOcOfa843WaHz/TK
         SDjX4dQwLHuwKWrQVH5AglKxvSwZLKHwzWrjd0xoMlDECPBjc0iWabXtysaAjFEqJ9iB
         xknDv4TZISToGDmKq5tBOE+e449EnREZzTRugdLITQIWx6l09Kuw93g5O+t2fpIoeOkk
         ZptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OubDWcbKj1/e3L7ycAP1shHvzYTCXKmnWOkd6uEz4cM=;
        b=OjZdM93JSqXwImc6aPvREorL6ZHkfmr6380MAMfCKJ+J9+MLPhf+MhKjr4VM5Z/ZSY
         nBlygO/rg+NBggvaerdLYsYeCEneoJje9RK/y5X1J7tUmEAvk8He0wGz71pdcd0G8yZ/
         1vCm5u05C7b2B9SFOpTYj+ganFjc1kf+XYyyPvtnEt3k/qIVED2VMYXCH8kfz9pTU3gI
         iLT5+EWtHKrcPtPBvjBPdwA8W+Fvrwbl83LnLZpJSFb4PRdOg7bW1Tvfv7VwjKv+bkAt
         YBjjFhu66XjqKOQBCpW77pdxnH3NklXda3Z5kEyq5nPP9K6LML8qySQvl3ESObZmWMuy
         n9uw==
X-Gm-Message-State: ACrzQf15J9bDZJwC8yRW4Boxk9mHmWC1OT9TfJcKV5GSDAbIKD2pRCHi
        PyaZRFsTzvozQRpAzxfwWqcVFUK1ayo=
X-Google-Smtp-Source: AMsMyM7AYL/Jc+ivPtTdXAHckPpYV3PXfZMXSypQtRJfKXlPXc+mO3Hnj5JbHbZ2tLwZnkENtsyCYw==
X-Received: by 2002:a5d:500a:0:b0:22e:34bd:c907 with SMTP id e10-20020a5d500a000000b0022e34bdc907mr986805wrt.548.1665085396935;
        Thu, 06 Oct 2022 12:43:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cy5-20020a056000400500b00225307f43fbsm216551wrb.44.2022.10.06.12.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:43:16 -0700 (PDT)
Message-Id: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 19:43:13 +0000
Subject: [PATCH 0/2] Fix syntax errors under clang 11.0.0 on MacOS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes three syntax errors that caused compiler errors with
clang 11.0.0 on MacOS. I've included the error/warning messages in the
commit messages. The offending statements did compile successfully under
clang 14.0.0 on MacOS, so I have to assume that this usage is newer than
what clang 11 supports.

I originally sent these changes in my "Trace2 timers and cleanup and some
cleanup" series on Tuesday, but pulled them into a separate series based on
feedback. I'll omit them from the trace2 series in the next version.

Jeff Hostetler (2):
  builtin/merge-file: fix compiler error on MacOS with clang 11.0.0
  builtin/unpack-objects.c: fix compiler error on MacOS with clang
    11.0.0

 builtin/merge-file.c     | 4 ++--
 builtin/unpack-objects.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)


base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1375%2Fjeffhostetler%2Ffix-clang11-warnings-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1375/jeffhostetler/fix-clang11-warnings-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1375
-- 
gitgitgadget
