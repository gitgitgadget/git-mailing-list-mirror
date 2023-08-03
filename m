Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9DCC00528
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 10:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjHCK2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 06:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjHCK2X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 06:28:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC98419B0
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 03:28:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso8453885e9.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 03:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691058500; x=1691663300;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uk0YHgP+UUm0Rr2Vw/A1YV13J6tgrvIHz8DBTPJoRHc=;
        b=m8F+nAllrZpZME5bPqm22gntvAZABfaYaRxbuzWOs3u7NBCxf+yLmaX8u/y1f6df82
         1TiXfSA59o+sjmzIu70l8D6282vxJY9hcp96kK2eggMsVIW+mdi+qc86wd96tXN5B0Mx
         VAMVrt8fj8FFpXlPR6IYvWdV7gOq+tBaW3PjOY0J3hzrx13L5Iy87U/8Z9sRY3QE+Aeu
         mHG7wsAH6uHV4K9kx/Hho0FXkO2K/Lnrzsu0KH0JwwPwiiSz3PsPmXQZp76p0kRjQUDK
         w7J+bHnbeEg50C0o/DVuXqq4ZR9c7tMASQnSu222Us9a1lJYuzE0HWUsfjpeVyNlq2Nk
         C7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691058500; x=1691663300;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uk0YHgP+UUm0Rr2Vw/A1YV13J6tgrvIHz8DBTPJoRHc=;
        b=aF58wguVHz/12kPz6Xtmj1Yq1bHSsyk8TsfTYDskat4wqQ7qfznOVu6UOmGjnGUzPQ
         E7k2uZxnka/QfwsG9fyxByZKtlOAzaPVYnOUawtn6dxyERuguhk9u/GisqeuCveHS6AX
         8n3NN+R4psqo0YWJo8A9pDXAG3aiuxymbZL8CArYZRaZn5BaogO0iTYbxVM6blWNK/oM
         v+bgFQBh2FqBpU3PWB5838KQ94YP4PeTBPT2NFQNIc5hGa3rswV/S43ExOKFD03ZrPlz
         /uvZ6Xw/Az/rGcegSwNbPHdDKFU5COcfq48IDA1/xBrluB8Ljct/65aqmwIRtAZmLSNO
         89ew==
X-Gm-Message-State: ABy/qLZKiDXceeLst9wZ5eKzBv9He0CTwmpzA/teTzuAApFM5OYTmOsR
        uNcnSbrrfcZzpd7eAplwTPxN3fGphaE=
X-Google-Smtp-Source: APBJJlHUUs3BZWdyOlVs5oLU1noC2OFRjjZwHfPCJFxtpAiGqawqlbKfHCyYAOWN8+b/YjQ8RbeqIA==
X-Received: by 2002:a05:600c:44a:b0:3fb:e254:b81e with SMTP id s10-20020a05600c044a00b003fbe254b81emr7937919wmb.12.1691058499912;
        Thu, 03 Aug 2023 03:28:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t25-20020a1c7719000000b003fe2b6d64c8sm3884420wmi.21.2023.08.03.03.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:28:19 -0700 (PDT)
Message-ID: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
From:   "Matthias =?UTF-8?Q?A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 03 Aug 2023 10:28:15 +0000
Subject: [PATCH 0/3] git bisect visualize: find gitk on Windows again
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Louis Strous reported a regression in git bisect visualize on Windows[1]
that caused git bisect visualize to use git log instead of gitk unless
explicitly called as git bisect visualize gitk.

This patch series fixes that regression.

[1]
https://lore.kernel.org/git/VI1PR10MB2462F7B52FF2E3F59AFE94A7F500A@VI1PR10MB2462.EURPRD10.PROD.OUTLOOK.COM/

Matthias Aßhauer (3):
  compat: make path_lookup() available outside mingw.c
  run-command: teach locate_in_PATH about Windows
  docs: update when `git bisect visualize` uses `gitk`

 Documentation/git-bisect.txt |  6 +++---
 compat/mingw.c               | 20 ++++++++------------
 compat/mingw.h               |  6 ++++++
 run-command.c                |  8 ++++----
 4 files changed, 21 insertions(+), 19 deletions(-)


base-commit: fb7d80edcae482f4fa5d4be0227dc3054734e5f3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1560%2Frimrul%2Fwin-bisect-visualize-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1560/rimrul/win-bisect-visualize-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1560
-- 
gitgitgadget
