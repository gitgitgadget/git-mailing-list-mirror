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
	by dcvr.yhbt.net (Postfix) with ESMTP id BCDA51F462
	for <e@80x24.org>; Wed, 12 Jun 2019 09:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408718AbfFLJZ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 05:25:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35237 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406207AbfFLJZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 05:25:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so20630358edr.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=w0d4LMQavNCVeOl2+Q0JW/eqjgcgxnX84QnjHVNekrU=;
        b=rzjyCGoCKAaBg6y54V9x49Zcvj/BR1UgnQxcOMn1ZxUT0CGvzAcy0pYiuRDHuOxZap
         birPTID/wP6jH+a/A+ubB6/V8dxe3U87NpNn6k2oyeGoXU0gtEJrXH8L/xB2S5iTbgs4
         ZQ0urTZoIpaL+ZxB6uBAUS5lPe7PXsi2mTI0/0LfP8kRWYrpY2RPgc43qdsTt5rADAnH
         +vIT1mYeuMKdAAlCNekjJo5O0fJ+RoEaZ07rIeTC1ARLz5nzKvV0K9oSxit6zCMeNGR6
         yf82dOwsSs0wufM99SCewFh3FuCL25PqCoRaksS9aks/WX12FsT2jY9vTRaQz34tqbJe
         +FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w0d4LMQavNCVeOl2+Q0JW/eqjgcgxnX84QnjHVNekrU=;
        b=HvlsCXsuuLnS5KqlElrdzL2c/y0iyeWIRxqYiTcy8/tHx+gdYiw/LlF1VAZXX677UQ
         i08x4ui11JDhuYnn5AZck/FLLNmDX0EIibigTTJ//lk8gUek8HgSS0TnS+PG4BzWZfNm
         dZ9Jkfj4hFCor61nR+kOWzXSKLihRtwAZh39EycmmoMmTXwmgHh0895PIsGnEQZ6ja+2
         F5xdcgcOgCHE0wfUIUJG6ChgKuz8YUNr8OLjwlAxjZWtzLm1b6Hqi2ie/vNocNwpQe0m
         2f6y6mJ8EC9mIdndXulMBILT/GkpGUhguWD53Dim8h/b/6E3IDfkVK6qFx8NTtInSgqD
         QpCQ==
X-Gm-Message-State: APjAAAXN3Xow0QWIU7Ml75vhd6zbZBNXH1RRg1ve5bKY/wVd4Nwo08tv
        wopwqPznYCRpZHE/E4bMowxioYRn
X-Google-Smtp-Source: APXvYqzkaRMmru3CA0yKYQOD4+8LJDmTo5Ga1gLTZzznzku6sj9bxIyYcdxf210fz9j2y8eft2GcJw==
X-Received: by 2002:a17:906:3e97:: with SMTP id a23mr56596485ejj.233.1560331527599;
        Wed, 12 Jun 2019 02:25:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18sm4393009edh.13.2019.06.12.02.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 02:25:27 -0700 (PDT)
Date:   Wed, 12 Jun 2019 02:25:27 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 09:25:25 GMT
Message-Id: <pull.262.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] add -p: fix checkout -p with pathological context
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

When I fixed the hunk offsets in add -p when hunks are skipped I forgot that
the reverse patch case needs to be handled differently.

Phillip Wood (1):
  add -p: fix checkout -p with pathological context

 git-add--interactive.perl  | 6 +++++-
 t/t3701-add-interactive.sh | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)


base-commit: aeb582a98374c094361cba1bd756dc6307432c42
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-262%2Fphillipwood%2Fwip%2Ffix-checkout-p-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-262/phillipwood/wip/fix-checkout-p-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/262
-- 
gitgitgadget
