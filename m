Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51E101F404
	for <e@80x24.org>; Wed,  5 Sep 2018 14:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeIETRE (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 15:17:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46926 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbeIETRE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 15:17:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so3587329pfn.13
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=KSlqyE6UJWBuIsNdTv1ZaSUgDj4aSbzsALAXc+ZP498=;
        b=FA7c/q7+n9bQoyLJer2hYKmLOLxz6JcxUExnDa3PS2l8iTXF6ifq6MpANfuKqebvNY
         s/Bl/by734ydtY+527kEVADRfC34qFnMwmw0huLYgDpLm59QY2z7m5aPNuLgREk/7u2y
         gakPS30HsWPGcai0afuQOJHnv0X4/13WKFJqHVFQ1goudDA4WA1H1AiTtwvHgghL7wCU
         ReZ9uFouUeizfwXmJ52mbn1dFzVRcaLg6Bcq3zFI1NpyuGuAQqRW/jlvRGSlbng2RRb8
         V7iAvOpqvs6YeFa90S6s2bQAiPHS04g+nyeW0SIpHPRU9nPBSuj48gdIRYOYaTJfbLqm
         49rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KSlqyE6UJWBuIsNdTv1ZaSUgDj4aSbzsALAXc+ZP498=;
        b=pyZEi7t7CMnYNL8GSxvQ3rgwbYJjosmJHvmhlP3NYdYWuBx9jq4hC+KeF4wNMAV4BS
         +wQBtI+SKakGr5zi1ppc0MQQrvFCJvN+yELaBYUjGyJIjFNmJF6xkmlvuRdWGaMMFqJy
         PGTwQ/Xz74xmmTbKxdxt2F56sC+xPxKpXru63vIITafLKDY576Ox6vycqLNp3zT5yYPx
         UIzfPp2T5iehWe8Xgem4tMJ9xUeySCm+zP8/sdJ3orzJ3Incdok6ZNM4AG30BWiCRQ4g
         juU2+y7LCZ/SY6CplqZq7wqV2V+bfq1loC4Uryemn/A9a2qL9s9j1fUzJo1WCs/nwmdX
         jEhQ==
X-Gm-Message-State: APzg51DwQDzh95pncI/3NfTnTNPuL5w02LQkmAKuiN+B8LKu7riRVNKa
        nb40IjTXheJ5i1kFnhSBBD46Tkph
X-Google-Smtp-Source: ANB0VdbieEI1pIXjVFe7QqgbnemS4Y2BV2BrJFYDKSS3RyZULH90u+XaFizTNNUQOZ+VgD/l1ynx6w==
X-Received: by 2002:a63:fb57:: with SMTP id w23-v6mr36768049pgj.441.1536158792503;
        Wed, 05 Sep 2018 07:46:32 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id v72-v6sm6769580pfj.22.2018.09.05.07.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:46:31 -0700 (PDT)
Date:   Wed, 05 Sep 2018 07:46:31 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 14:46:18 GMT
Message-Id: <pull.34.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 00/11] Add 'git multi-pack-index verify' command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index file provides faster lookups in repos with many
packfiles by duplicating the information from multiple pack-indexes into a
single file. This series allows us to verify a multi-pack-index using 'git
multi-pack-index verify' and 'git fsck' (when core.multiPackIndex is true).

The pattern for the tests is similar to that found in t5318-commit-graph.sh.

During testing, I found a bug in how we check for the size of off_t (we are
not actually checking off_t, but instead uint32_t). See "multi-pack-index:
fix 32-bit vs 64-bit size check".

Thanks to Ævar [1], I added a commit that provides progress updates when
checking object offsets.

Based on ds/multi-pack-index

[1] 
https://public-inbox.org/git/20180904202729.13900-1-avarab@gmail.com/T/#u

Derrick Stolee (11):
  multi-pack-index: add 'verify' verb
  multi-pack-index: verify bad header
  multi-pack-index: verify corrupt chunk lookup table
  multi-pack-index: verify packname order
  multi-pack-index: verify missing pack
  multi-pack-index: verify oid fanout order
  multi-pack-index: verify oid lookup order
  multi-pack-index: fix 32-bit vs 64-bit size check
  multi-pack-index: verify object offsets
  multi-pack-index: report progress during 'verify'
  fsck: verify multi-pack-index

 Documentation/git-multi-pack-index.txt |  10 ++
 builtin/fsck.c                         |  18 ++++
 builtin/multi-pack-index.c             |   4 +-
 midx.c                                 | 112 ++++++++++++++++----
 midx.h                                 |   1 +
 t/t5319-multi-pack-index.sh            | 136 ++++++++++++++++++++++++-
 6 files changed, 261 insertions(+), 20 deletions(-)


base-commit: 6a22d521260f86dff8fe6f23ab329cebb62ba4f0
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-34%2Fderrickstolee%2Fmidx%2Fverify-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-34/derrickstolee/midx/verify-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/34
-- 
gitgitgadget
