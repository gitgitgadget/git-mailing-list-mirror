Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7922C433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 19:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350015AbhLWT3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 14:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhLWT3x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 14:29:53 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42859C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 11:29:53 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id e5so3912891wmq.1
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 11:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cwmwXFmxlspXJriI0CeCAiATYsyh0QuJzl/5qQnCNmg=;
        b=C6hPLTFMhFhSFKIO0cFXEEzjZ0ao2xk6wly+HItKWiCusT9JLcYhclcfOdy8sGjKR8
         wyMdZ2j5pXROfoCPrPcDgsNIAKYj25t552eT4SGaG9S8KYk8l7lsIpvrIIG1F83LqWKz
         seIwaIVcoUQxQx30H8ODllBrATHjCLS7VbTo1SL43vnJ3L/fIBUeerJcfTiH02PB9qEx
         twxv00NthzLGU1iQ0S/Jz0g9trXqS+jG/5Rg8ygq9TYMZ6JiJgiVT4qwgM14229bHxaj
         2Q+5LWLP/6k3u5h5Vbv9mxZZcAuOo1b2jIyf1CmCz30uJq2xnCEgrhyVjmA4nDkKv1c0
         PvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cwmwXFmxlspXJriI0CeCAiATYsyh0QuJzl/5qQnCNmg=;
        b=hbh9qC+H+BI081oa8D8TV36zEGZ2yQzjuNRu7BQ2DJm1ryY4FEGeAtMnDdxnpPeYpa
         /vDePiIWh2kaKJgixpP3UScrHgwF75APA5nF41PTTqx5bVnzzRDAYb/KZV4bUbbTvC30
         bQW1kSJShcF9cpP/kMl04uF/8vqYxLwxQIMMG+oiIC1oNAY5S2UxK1ApUAVoi8Z3xf7V
         Lk40HRkAqDCQc0hEvQe7OLZEDbdb+9umjpKQdWM11IQrY5kp5zG2kBu1m66U6pjFoNy0
         KrBYGgVBsM9poul3zVbEp4CrVESoK4VnI9GEuHGeFwDxcwt+Wrz1a+tT1UPrL2mAz7Q6
         RUuA==
X-Gm-Message-State: AOAM530kR62HZkijzFO39j/ibihZtdE9DFVi44sxH4t3slvwz0dmKjpG
        Ktwn4h1KwVUP73MiDd3Oh2NDAV+nlxM=
X-Google-Smtp-Source: ABdhPJw5EfTwdHpXw4UqAFaIldgr0fCVB/QBvcuJmHZSJvcQBm+prhT4u0XayKl/mbDWOIj3m1L2cg==
X-Received: by 2002:a05:600c:3582:: with SMTP id p2mr2765687wmq.34.1640287791767;
        Thu, 23 Dec 2021 11:29:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h3sm5692692wrt.94.2021.12.23.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 11:29:51 -0800 (PST)
Message-Id: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Dec 2021 19:29:47 +0000
Subject: [PATCH 0/3] preliminary fixes for reftable support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

these two commits to the reftable library prepare for making 2 tests in the
test suite pass in my pending changes for reftable support.

This series was built against 'master'. It also has a fix for a fd leak (>=
0 vs > 0), which is part of my reftable-coverity fixes topic.

Han-Wen Nienhuys (3):
  reftable: fix typo in header
  reftable: signal overflow
  reftable: support preset file mode for writing

 reftable/block.h           |  2 +-
 reftable/error.c           |  2 ++
 reftable/readwrite_test.c  | 35 +++++++++++++++++++++++++++++++++++
 reftable/reftable-error.h  |  4 ++++
 reftable/reftable-writer.h |  3 +++
 reftable/stack.c           | 30 ++++++++++++++++++++++++------
 reftable/stack_test.c      | 33 +++++++++++++++++++++++++++++----
 reftable/writer.c          |  3 +++
 8 files changed, 101 insertions(+), 11 deletions(-)


base-commit: fae76fe5da3df25d752f2251b7ccda3f62813aa9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1164%2Fhanwen%2Freftable-features-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1164/hanwen/reftable-features-v1
Pull-Request: https://github.com/git/git/pull/1164
-- 
gitgitgadget
