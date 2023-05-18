Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C09C77B73
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjERUDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjERUDa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E626BE72
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3093a6311dcso2401919f8f.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440207; x=1687032207;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IWj0ii6FXMUYZkoo5iWHZwcfvktjkg3lFjffmjZv/4g=;
        b=fS/q+MOO2kxABarADnOn0t+zH+6w67FAgBAakNoJOpmZfjB9r5hNHoQbptCIWFRRc6
         ZBtRpYIeGOe96JZyF6vXPsgq7zCM//gj6c5GHYj726Q2jZ+u7rsUOpVZnmo3dvz9L1Q+
         Q5TwwddmxwBsdQ5s5kl0AnSFS8rIYz+43FoGP0pWzRWmw+lR5wEFGS5Rycx/Ezhpjonw
         Kq+uyrJiNbtPfq56a6bBuBaYXGJYj6vNgZD+VDo24cKw7/A+eSMWcCIAJd1QWJNw+o6B
         hkpmx1r3/spyKmHYyArEmntv6KYLoKK7Sx8nEq6FKjxi6uMizvwnhYgyYh3VZv3XtqjD
         QpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440207; x=1687032207;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWj0ii6FXMUYZkoo5iWHZwcfvktjkg3lFjffmjZv/4g=;
        b=U5heBR1Nv1UGPzNNd3Xv9LGvb5e3nra4YGdj8hVGqDunxmdLwiZJtVr2+P45JNYOYk
         4YQbMCIL4iM7uc/rvwjiwEGdrvhrcK3fXUWsp5BdULdkXCBZsSJbDgd/+OeHYs5uhlrp
         PSqE3Ue+3o23CHIzMA4PAEP4vPQW3q0XC3rf4buDNt5nBk9n2RkAnmBiwuwZAkr9GlNg
         DI7cZSC3xaXbWF2/S4kALjEFpjIiePJYK4inkCjkX8KqrTVcNxZq8MVVzITZC++8yb+7
         /vn4hW0rYWPuwXatFI/KN+LpyC8BdkigBMD4tBreIohJ8VfY2oTV8MHis496rTrsCicG
         /pXw==
X-Gm-Message-State: AC+VfDx2Ciil5LJZECC5zA++zp2wmUdW6t2xqmCNVs3trwZCgBsC9FWw
        tBIRNbgnFHfhLypetbmPuMc0hHZa+Nk=
X-Google-Smtp-Source: ACHHUZ7akmkpu2FhlVBF5+iUYMMwYDr0IDqatNKssZP0UxQhuv41i8dSshiGUEg1SkDl0VgmLrqdzQ==
X-Received: by 2002:adf:ea0f:0:b0:309:48ec:2c82 with SMTP id q15-20020adfea0f000000b0030948ec2c82mr2223843wrm.48.1684440207043;
        Thu, 18 May 2023 13:03:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d4591000000b00300aee6c9cesm3122279wrq.20.2023.05.18.13.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:26 -0700 (PDT)
Message-Id: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:05 +0000
Subject: [PATCH 00/20] tests: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a number of tests that still follow an old convention of using
four-space indentation. Update a bunch of tests to use the new convention
with tab indentation.

John Cai (20):
  t1000-basic: modernize test format
  t0030-stripspace: modernize test format
  t3210-pack-refs: modernize test format
  t1001-read-tree-m-2way: modernize test format
  t1002-read-tree-m-u-2way: modernize test format
  t1006-cat-file: modernize test format
  t3500-cherry: modernize test format
  t3700-add: modernize test format
  t3903-stash: modernize test format
  t4002-diff-basic: modernize test format
  t4003-diff-rename-1: modernize test format
  t4004-diff-rename-symlink: modernize test format
  t4202-log: modernize test format
  t4206-log-follow-harder-copies: modernize test format
  t5300-pack-object: modernize test format
  t5301-sliding-window: modernize test format
  t5303-pack-corruption-resilience: modernize test format
  t5306-pack-nobase: modernize test format
  t6050-replace: modernize test format
  t7101-reset-empty-subdirs: modernize test format

 t/t0000-basic.sh                      |   2 +-
 t/t0030-stripspace.sh                 | 560 ++++++++++++------------
 t/t1001-read-tree-m-2way.sh           |   2 +-
 t/t1002-read-tree-m-u-2way.sh         | 589 +++++++++++++-------------
 t/t1006-cat-file.sh                   |  26 +-
 t/t3210-pack-refs.sh                  | 154 +++----
 t/t3500-cherry.sh                     |  69 ++-
 t/t3700-add.sh                        |  34 +-
 t/t3903-stash.sh                      |  26 +-
 t/t4002-diff-basic.sh                 | 243 ++++++-----
 t/t4003-diff-rename-1.sh              |  62 +--
 t/t4004-diff-rename-symlink.sh        |  42 +-
 t/t4202-log.sh                        |   8 +-
 t/t4206-log-follow-harder-copies.sh   |  36 +-
 t/t5300-pack-object.sh                | 184 ++++----
 t/t5301-sliding-window.sh             | 100 ++---
 t/t5303-pack-corruption-resilience.sh | 584 ++++++++++++-------------
 t/t5306-pack-nobase.sh                |  94 ++--
 t/t6050-replace.sh                    | 296 ++++++-------
 t/t7101-reset-empty-subdirs.sh        |  48 +--
 20 files changed, 1565 insertions(+), 1594 deletions(-)


base-commit: 004e0f790f947c9c511a9ac4f905021c7dbfa9e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1513%2Fjohn-cai%2Fjc%2Fmodernize-test-format-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1513/john-cai/jc/modernize-test-format-1-v1
Pull-Request: https://github.com/git/git/pull/1513
-- 
gitgitgadget
