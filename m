Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6860FC33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 08:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DC820748
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 08:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccZrVrlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgAPIdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:33:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51352 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgAPIdL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 03:33:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id d73so2785624wmd.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 00:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=oiG1Z32jCj60cDEMxvp85q7hcwAtAlhFxyYsXyUPgwY=;
        b=ccZrVrlOq+Y+JFLP04kkQa9zoHltpWvG8kIcEp3xxCymHAQ57pJrHMKfGFn8FijHIY
         mcdOLWVjQsQ+A2iBhsESHQKuTyTct4iEq8sUajwfDiLCGrGqEX33pLzCrWzBCMJwcaUs
         vFExBNle7gon5bKf+xVfpnE7ZOYTuIJ/OBhqAemCFbHPgpp+wqWuvgFyx8mTVD+6PCok
         C+GPZQSK1Q6/KnPj/LBdcCpYIkFw1xbpyK9jMwUSpNUNfTx8MmLLN//3nrXYeKLW4cZB
         A4JqWSOSxW4NBTCSlFa2YaiS+CkNHvHoYPzQsLb848TMM15SoyqXWob3Kf9yOpiju9Zs
         K0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oiG1Z32jCj60cDEMxvp85q7hcwAtAlhFxyYsXyUPgwY=;
        b=IIuCBleyyqjMkfiqjTTCcXE25NZ6yTXSwYeg0k/tPRul2nfrwK6P7pBpm4zHvJuMlc
         QpUj5lzR5L4Ir0SwdUZmkxyCUvvaKiV2pSDnZSJlDCPaIxfzEg3vpNEUinBiY4XJXhWq
         pSWYyyWsY/h+XQWgtWMSO75eWXzRXXx8nSKp6gnZu3pCs/mKRoxKU9QF16g04ZQ66tHn
         xSZr3uaMDGrf9ORVUiMBiSnNSIMWACQ9PE0aXvWqjtNIU5su+JSZ6XMvkuTmqbcRGvrO
         l0Nbwfi7o2bry/nPdZnOEgVegheGvH0rMsfcSrMQgWJOFGguz/4HbHfkmdoDdsb/yqoU
         HwYw==
X-Gm-Message-State: APjAAAWMK6ATq5G+6cFiL80aDqDmGTyImXGC1tdcKjuvlA01oRn3Zbw+
        wFjoddkhAzo8GmLu/0JqRWF8dNyj
X-Google-Smtp-Source: APXvYqxZhl9zkgVlpaiBDDrGFr/YQ2vZ2YOdpMirkwld/OkeM2LlZLArxQwd/RYrQDaGT7YjGirXHA==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr4759837wmc.36.1579163588614;
        Thu, 16 Jan 2020 00:33:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t125sm3680280wmf.17.2020.01.16.00.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 00:33:08 -0800 (PST)
Message-Id: <pull.528.git.1579163587.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 08:33:05 +0000
Subject: [PATCH 0/2] Two fixes for the built-in git add -i
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These issues were noticed in 
https://github.com/git-for-windows/git/issues/2466, fulfilling my hope that
Git for Windows' exposure of the built-in git add -i/git add -p as an
experimental option would attract testers.

Johannes Schindelin (2):
  built-in add -i: do not try to `patch`/`diff` an empty list of files
  built-in add -i: accept open-ended ranges again

 add-interactive.c          | 9 ++++++---
 t/t3701-add-interactive.sh | 9 +++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)


base-commit: 2e697ced9d647d6998d70f010d582ba8019fe3af
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-528%2Fdscho%2Fbuiltin-add-i-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-528/dscho/builtin-add-i-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/528
-- 
gitgitgadget
