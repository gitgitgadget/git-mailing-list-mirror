Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CFC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 06:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2A5610A2
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 06:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbhJGGw6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 02:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbhJGGw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 02:52:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C2DC061762
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 23:51:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t8so15854930wri.1
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=DG7zG/WredvqOdEErkS8GCeC43iiYBUrkdttzEKNlNA=;
        b=V9vxWchrX9u/W+bwDcCuGMhTJRkbWZZ6So8W0TaT8djvZL2HsB7vcMR+qG7Ed3fpz6
         PS8279MwqBRCAxALmK1rdlWB19QthGEEV6kZqqL3ZHzVsUeLlIQgTRLgqRgGkfXL+DWH
         oUK9Mu+d88Oz1ev9u0RAzoenr0bMJ6k9f/0eTjL8eFqYamn/PfBZaJM/XFMV+RJmpQ0/
         r+i01ZD4voqohtxz0WqYboi8ipHxvNcGiyYVDa7/5eHaa8XLR6koa53kA8EzZmfGAYkx
         nNkK2hb9Uvb+KOzWINmEs6h8d+YMiXqBOtPiu75HGLqLU4t5gvyBCcEc/ig0z0ao8Zwt
         8ZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DG7zG/WredvqOdEErkS8GCeC43iiYBUrkdttzEKNlNA=;
        b=R+36Fg3VHUE27dcwiTHIrMbByOxuEveamZozoXY5/I7eB6E1UHOqr5UEzjvGXspD4K
         PhmJmS6JV9b0NexqLwr2+KjjPQQbyt1EtQEe06kWTRZ4NBropjNS2EZcm4nZeMRrktkj
         yzO4ZfRsaZtfdjNvYoRLVgzHZdY+Enpu/xre7GSYAwU+cympfRqmxxnelbnkH04kpeWj
         5PFpVUfJp0X1LW5Ick0dF7Vw/FiIqnr2B7wr+g8KZapfGWiLmZTQru6xOb7tisg7aP0q
         HER2ivm+98DUzwoouOPgHi6Vj68eGiZVx3AzJUmV8TClSZaVxUk+XPQ1w8M7vB/GWRoK
         oJ9g==
X-Gm-Message-State: AOAM531eRDtC1oHpyugEY4XsB3IzX1gpBKBKHhLdsks3GI2SPPkJwMgw
        iD26IVK84NrzDvUQL5IiwrSXB+knZOM=
X-Google-Smtp-Source: ABdhPJxt/AKEJ5VPRTnqYKISjOSNWxIZ0sr6GOiu0uM3wINDgzdwHP4NlHl+Z9jaJSmeizCYGOpxbA==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr2768224wmb.125.1633589462446;
        Wed, 06 Oct 2021 23:51:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm22866276wrm.40.2021.10.06.23.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 23:51:02 -0700 (PDT)
Message-Id: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 06:50:57 +0000
Subject: [PATCH 0/3] Fun with cpp word regex
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cpp word regex driver is a bit too loose and can match too much text
where the intent is to match only a number. The first patch fixes that.

The other two patches add support for digit separators and the spaceship
operator <=> (generalized comparison operator).

I left out support for hexadecimal floating point constants because that
would require to tighten the regex even more to avoid that entire
expressions are treated as single tokens.

Johannes Sixt (3):
  userdiff: tighten cpp word regex
  userdiff: permit the digit-separating single-quote in numbers
  userdiff: learn the C++ spaceship operator

 userdiff.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1054%2Fj6t%2Ffun-with-cpp-word-regex-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1054/j6t/fun-with-cpp-word-regex-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1054
-- 
gitgitgadget
