Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E321F4C1
	for <e@80x24.org>; Fri, 25 Oct 2019 15:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440669AbfJYPXc (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 11:23:32 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42901 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731315AbfJYPXc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 11:23:32 -0400
Received: by mail-wr1-f49.google.com with SMTP id r1so2775185wrs.9
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=McXjEp4grTpauurG3Rayv+LpvXdg9su9TsMWbX1viaI=;
        b=ExZNP0PT1Ny9KvWeWRbZvRUPiyUEdY3yClvzOEpY/5ughRoeP3O87wsSXTzU0Y+vGQ
         yMvXaQrOCOJFvBkW3EWbQOoUI0syGP82TM8Tbxb25tROjNYKgPdeMR9Jb8JCZdhIzgGB
         yB/ckc1T0RNRAt8kD4gCHQE8J4GgU+l76rOMS5Y+z18vcFGxlYo/qJK8QuzB/7ncuWeR
         EpOl8fdhlL+mN5eMOVrEzjxQ+wMTt31O95771rym+j3M2yyG1W0Q2PLkX8Tgtv/gPbz7
         eZ5kgW3OfBEU9rMUM+f/deOkLwIskGgYrC5aDgIApgfsjxWDTM1+/y1/WBazMHMIzOUu
         EPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=McXjEp4grTpauurG3Rayv+LpvXdg9su9TsMWbX1viaI=;
        b=PsaCWMoAkxTmFN2JOxAsjGn0EO682TDfmm5t0MacsUczfgrxrbl4NxeTw5I8fMoHkI
         fWWF7Nh09vtoZMzibyW8mLA/rTkzlfo1aZEcXX7qTdD5a049Bh37+6zjZT7wpV3LHf6t
         sRIdtAe/HZ0DhvC7Gnqk79H/o6nqsHBXlUztUuiboW6pcSRkfZsBs9YwdfAbmovxJnkl
         Qs3OTBasYW8nc68+elqszF7Ubd4hXLI66d/raNk9w5o3p2x7c5U3gAJt/EUm1E/z7/iB
         e0SX9zi8388JI2BqBsVHRfs8gDmRLp+63/D6lIJDUbJjCqP4vkCM3R8wsZAcCC6aXv5y
         8xjQ==
X-Gm-Message-State: APjAAAXiSr8acxUUGLgvhB8RyqrWb1tLySO0iUAqyBVgNhVQuiX4iGho
        C7kK+eqvNjHaXCwW+MhtN/Hg9P9O
X-Google-Smtp-Source: APXvYqz60V9wOCsQO60H8KN/hWyeaU/EWqNWaF4yW2T9lVJO0eqC+1xz1KNoS5pbObutGO5iyX3jkw==
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr3558427wrb.222.1572017009253;
        Fri, 25 Oct 2019 08:23:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm2399427wrt.7.2019.10.25.08.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 08:23:28 -0700 (PDT)
Message-Id: <pull.424.git.1572017008.gitgitgadget@gmail.com>
From:   "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Oct 2019 15:23:27 +0000
Subject: [PATCH 0/1] unpack-trees: skip lstat on files based on fsmonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git stash runs git reset --hard as its final step, which can be fairly slow
on a large repository. This change lets us skip that if fsmonitor thinks
those files aren't modified.

git stash goes from ~8s -> 2s on my repository after this change.

Utsav Shah (1):
  unpack-trees: skip lstat based on fsmonitor

 unpack-trees.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-424%2FUtsav2%2Fskip-lstat-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-424/Utsav2/skip-lstat-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/424
-- 
gitgitgadget
