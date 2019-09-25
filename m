Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C911F463
	for <e@80x24.org>; Wed, 25 Sep 2019 08:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442787AbfIYIgC (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 04:36:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52250 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405068AbfIYIgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 04:36:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so2519834wmh.2
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=WplIugY8x7hdUBoczzQ/udELCd60j0lmPIZtdMLjVgM=;
        b=oE08SN8pBtlAe4UiycuJSeyn4Zw1blbMYUqS6ZahlNIoa2gRMyrcoDo1ZC0bUumfC8
         bk75DbZcbQK1gkrMIEW3DuzwEd9PcBRZDGshcokwEHMnZxI3cP/DXHvLZW64sPRB3MZj
         2UWEXeRQu5aK6OveM8L1M00a5rya0pNg4RWajVytvVrIflomBcA3TEX5pANtnenQ/G6H
         1ZBaMb5I00qcaEf8RPNVbEmulMuKP3IIxmROZdVfG8eSizMwD008cyd0bWA2dUwSbH71
         UCVL5f6fOa1mHEdhGTJKrgeIQshveyZg6g2pXbeqVXN+dc7ZynMSheNzij2xTQEHLECk
         VTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WplIugY8x7hdUBoczzQ/udELCd60j0lmPIZtdMLjVgM=;
        b=N5UMe+7nZWLAxty8hgK5Su4ttK9gSvZiE8H4pK8VJLknAm0lknpN0qLhLncA9j+qo3
         3H/bC4XGIVhCX7Mr1Q8EjZDY49SFc65hiSYl+Y40zViAQUo9wG6ZRYdJzlTkYGJ/5C38
         h6IT17hhWwW77/4UDcA8TJgsALJpl4nyKYK9lTTmSkl3lzC/GQ+QCckr6axcm9J8HL2s
         nS93z/wZvPpDhBr5SncxG1H5+BSVDZZnJUhzMzcnp5h6ykhlIiEHSDY6aScB/IVdiEMw
         OtXzVfGGuUvwI5SBXvDBYfqH/5c/N15nEeOXbCdpflGT31Qzi/1oyrKBc5rVYskMKihc
         1Hsg==
X-Gm-Message-State: APjAAAW1G6uXaLD4NVQNt3DNglwrNLQKw0tUU+lLTkt8Ksnl7ZoI3IZR
        PPfz7nExPT3IMfSNRZMtNtBiZVf0
X-Google-Smtp-Source: APXvYqw77GOVGVpId+XTvrK+p92DoShN0jisEIil4wZfkQxa2AfJjFSGNXtUWVpUmBszzMlOrx1Y0Q==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr6076840wmc.83.1569400560358;
        Wed, 25 Sep 2019 01:36:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f20sm2061881wmb.6.2019.09.25.01.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 01:35:59 -0700 (PDT)
Date:   Wed, 25 Sep 2019 01:35:59 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Sep 2019 08:35:56 GMT
Message-Id: <pull.352.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Git's rename detection requires a stable sort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the en/merge-recursive-cleanup patches already having advanced to next,
the problem I discovered when rebasing Git for Windows' branch thicket
becomes quite relevant now: t3030.35 fails consistently in the MSVC build &
test (this part of the Azure Pipeline will be upstreamed later).

The solution: use a stable sort.

Note: this patch series is based on top of en/merge-recursive-cleanup.

Johannes Schindelin (2):
  Move git_sort(), a stable sort, into into libgit.a
  diffcore_rename(): use a stable sort

 Makefile                  | 2 +-
 compat/mingw.c            | 5 -----
 diffcore-rename.c         | 2 +-
 git-compat-util.h         | 4 +++-
 compat/qsort.c => qsort.c | 2 +-
 5 files changed, 6 insertions(+), 9 deletions(-)
 rename compat/qsort.c => qsort.c (97%)


base-commit: 4615a8cb5b3a8d4959c30338925b1fa3b948ae52
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-352%2Fdscho%2Frename-needs-stable-sort-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-352/dscho/rename-needs-stable-sort-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/352
-- 
gitgitgadget
