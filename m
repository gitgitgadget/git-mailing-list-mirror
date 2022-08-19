Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98221C25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 06:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346656AbiHSG5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 02:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346676AbiHSG5k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 02:57:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB8CDF4D6
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 23:57:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a4so4116268wrq.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 23:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=lVnF047FVdASNiQ4TVaFKo95oyGrwzsr9lE743HRbDM=;
        b=i9gOjVOvL1FippmWpX0eRGfcugfjvzqSyB/wKchOcPq0Doz/pZyNC2hh5daEOx2MxE
         +Ua61tLOiW4vpatx0revQavM+0Uv6GaTC0/vRainlAJX4um4Cizx7Awof5gIIaIBGAfA
         CobozGimw87WX79l/+ncF4gEZevW9M0yur6VotM0GAfPst/N8jrGwTPahK98NZZOOVnc
         35/L2mCnA9BpbIQFjZ6h1OqB2QrzGWQ8jBKYJt5WI0NivnhxZmvTkUH+OdYNShgu/XDb
         W5rKw5oBPdcEU/+0cRPioAAeO0T7wDp8pZdi/ENfpZ0v6mDxfGYAxK+/rlQSgafK3zo6
         mnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=lVnF047FVdASNiQ4TVaFKo95oyGrwzsr9lE743HRbDM=;
        b=7WAqUb/NX2hniBwFJTfXA7/IVy/8Zg+KZWxYvlClSjzaz9ulELU+e0JqTYaCtHl3zb
         tFVmRe6SCYU9svWEe+UXwBRHwXCWybQTkgfdgFhKzJVXHsIotatsI8d3L4jaCt2KtsCX
         N1gPsRUnd2gvvZQmf2l1ktd25r3UAQGlP3gncc9bucwn8Ag+fTSpAVVrCpm+kowLUfTM
         3bM9Y76Ead0RSJlan2l2rpcSGTruRcxXf/6w095jpJdw94zEMBp8BgujVLSiCy0Ypfsk
         yW/0kvFTbEBnZ/QvT5lK2BwfLy6cDXKJH9Llw1I9jM6BBoW3a+8PlwIg2qXYtfkQoYJW
         I2nQ==
X-Gm-Message-State: ACgBeo3AzRkOwDuFMJjgiJb8gZOqcmM0Hwt07+q18bZoI0d2JWPmM6I4
        nBcgO5WLcMkL9IFIioArq0S9nay9/Y8=
X-Google-Smtp-Source: AA6agR4lJa02VviXistyAnW8wS82btdpCM3PmHcXv6ziBEdg50goLKeVJwRzx+3Dfva0l9EgJ/iNHg==
X-Received: by 2002:a05:6000:1888:b0:222:c8e3:6bb with SMTP id a8-20020a056000188800b00222c8e306bbmr3203788wri.88.1660892257482;
        Thu, 18 Aug 2022 23:57:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c35c600b003a626055569sm4424423wmq.16.2022.08.18.23.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:57:36 -0700 (PDT)
Message-Id: <pull.1327.git.1660892256.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 06:57:33 +0000
Subject: [PATCH 0/3] Show original filenames in merge tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git merge-tree command has not seen much of real-world usage (because it
only recently learned to do something actually useful, and those changes
have not been part of any official Git version yet), which means that we are
prone to find corner-cases where we want to improve it in ways that we had
not originally foreseen.

I had the chance to give it some real-world exposure and noticed the
following concern: So far, git merge-tree shows munged file names in its
output that would make sense if the corresponding files were written to disk
(you cannot write a file and a directory of the same name, after all). But
for an application or a web service relying on git merge-tree to operate in
worktree-less mode, it makes much more sense to show the original file names
because that's what the user needs to see.

So let's do that.

Note: The written-out tree object still uses the munged names, as do the
conflict messages. But the machine-parseable part now consistently uses the
original file names.

Also note: This patch series addresses a bug where the ls-files -u-formatted
output would not reveal the correct file names in a rename/rename conflict.

This patch series is based on en/merge-tree.

Johannes Schindelin (3):
  merge-tree -z: always show the original file name first
  merge-tree: show the original file names in the conflict output
  t4301: add a test case involving a rename, type change & modification

 builtin/merge-tree.c             |  2 +-
 merge-ort.c                      | 16 +++++-----
 merge-ort.h                      |  1 +
 t/t4069-remerge-diff.sh          |  8 ++---
 t/t4301-merge-tree-write-tree.sh | 54 +++++++++++++++++++++++++-------
 5 files changed, 57 insertions(+), 24 deletions(-)


base-commit: 7260e87248e743b197d34c1caf3949ae4fa3bc12
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1327%2Fdscho%2Fshow-original-filenames-in-merge-tree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1327/dscho/show-original-filenames-in-merge-tree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1327
-- 
gitgitgadget
