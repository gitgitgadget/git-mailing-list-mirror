Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0711CD4843
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 16:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjIVQZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 12:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjIVQZc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 12:25:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1CB122
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 09:25:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4054f790190so1232645e9.2
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695399922; x=1696004722; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEE437CagqyQSITNOQ6p/znMNn2MuSctedgfESQqjkc=;
        b=RENx62X+e82LCgv5qWZ+z6IjuDcbDPn8JYKxZpM0fblgJ5/d+hR8Q+imkMepo/uD2g
         KwmsltP1qYLJ2Uxgo26R9m0sjqHmfSQRORH1bdG19PAbP//owssMiyyZZply0FuoqFkz
         h8xaYqOITJfw5PGJlHIwkRH5b608yxppLesAv1fBOHKWjX7s0m2ZoxT7mhvZGvdKv9c7
         23POhwGqibVx6lmrobLFC7j6Q/iD/SlS4saR6huXv+n889eK0NnR4E2w/0WFZgCVfWqK
         2B1bFy4+k198WdJBdWvURN2zGrE+4MNlrWBFOzfKz2HSGyRP9axIlnuD80E+5w7l93IJ
         y81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695399922; x=1696004722;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEE437CagqyQSITNOQ6p/znMNn2MuSctedgfESQqjkc=;
        b=SNlUn3K/w0tJOcwMXymg3uHyLSbghi5iiJHD85S6DMr9gfQcsvz+5th0e9cHRajNgL
         6tJOkqxyxPbd6pHkv8KHAD5Qg0u+7K6u7fukV4yoMxzo19uwdw8TnyThL7w8ZZ2WxyHk
         MCumaR8CHzq5g3rAqG/JZzZL4YZkXoQyfHsbbN+oUfMcdCMB6EX6QCw0IcXmt3ysUAfd
         KXuR/oykxUUKvj3wtqtqOz84IeJsbYpBLESE8bMcAnUGAW/UULpXJYnlGVgF+aDo2KSo
         t896PFYVHoRJ26quhBhoIxP7+MXi5A0wMQvptkW5Ajz8Yjjxq3elzbP1T0izSJ/z2SB1
         3wrA==
X-Gm-Message-State: AOJu0Yx/WFburqw8jtAFScj1YUWO/yi7UykGHMslxAnAZ8VggvH6Wysi
        NQerM3C8Op7s7p5jJQLAdTLga8YK8dA=
X-Google-Smtp-Source: AGHT+IHH1AJUGcG8JgoiXNekaSHUEb7Wo1Isl/3QzDgvIYEbOwtiprFK2IhpROh46VxDyxdxXpLmWg==
X-Received: by 2002:a7b:c3d0:0:b0:403:7b2:6d8f with SMTP id t16-20020a7bc3d0000000b0040307b26d8fmr8698478wmj.2.1695399921644;
        Fri, 22 Sep 2023 09:25:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d474d000000b003217cbab88bsm4789704wrs.16.2023.09.22.09.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:25:21 -0700 (PDT)
Message-ID: <pull.1587.v2.git.1695399920.gitgitgadget@gmail.com>
In-Reply-To: <pull.1587.git.1695067516192.gitgitgadget@gmail.com>
References: <pull.1587.git.1695067516192.gitgitgadget@gmail.com>
From:   "Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 16:25:18 +0000
Subject: [PATCH v2 0/2] subtree: fix split processing with multiple subtrees present
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Zach FettersMoore <zach.fetters@apollographql.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there are multiple subtrees in a repo and git subtree split --rejoin is
being used for the subtrees, the processing of commits for a new split can
take a significant (and constantly growing) amount of time because the split
commits from other subtrees cause the processing to have to scan the entire
history of the other subtree(s). This patch filters out the other subtree
split commits that are unnecessary for the split commit processing.

Zach FettersMoore (2):
  subtree: fix split processing with multiple subtrees present
  subtree: changing location of commit ignore processing

 contrib/subtree/git-subtree.sh | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)


base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1587%2FBobaFetters%2Fzf%2Fmulti-subtree-processing-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1587/BobaFetters/zf/multi-subtree-processing-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1587

Range-diff vs v1:

 1:  43175154a82 = 1:  43175154a82 subtree: fix split processing with multiple subtrees present
 -:  ----------- > 2:  d6811daf7cf subtree: changing location of commit ignore processing

-- 
gitgitgadget
