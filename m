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
	by dcvr.yhbt.net (Postfix) with ESMTP id EA41B1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 07:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389347AbfJPHHV (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 03:07:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38381 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388580AbfJPHHV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 03:07:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so1469215wmi.3
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 00:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Y0FjQrHr8MhW8sRJ71GUXw5XvOWDe2w3T3yyGajkOIM=;
        b=EY4AoZtykoQsMWkb2Of8tCjJ6QWRvrDRMkgvsECQHHZmyTtdmbawPHrkLRanDSwPKn
         fLDW0m8uXk1CSYk/BWnyrHA4bnNH16yHnndOL72SNFbnwtaSAnvbcq6crU+dcEj/xHLF
         rcp1d+xaha9AqnoU9fw1404fJDwbVruVE6BWF87OZbi5KoOxTj7HvCJR/LrobLjuIpvR
         pUflqBYBmJVA2J3BDs18NtSSKTxVs75LsYr2TVJ3n7fC7vx6PMUn+T5GbIbHTa5HsZ+v
         IiibZL01DK31UQwsZV0NQCEipbPv0SkgLQknLQy3Kw8arbVIwhkURoUwZomdh0KspkOQ
         hO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y0FjQrHr8MhW8sRJ71GUXw5XvOWDe2w3T3yyGajkOIM=;
        b=MZWovbtQPCXSq3TZ/yHiinl3gSLkv1ovKHbBg2KCQa58+K/qke78dIJlbuuHO8vCui
         8LILUE6hk76TdnlsepocUJNiStwPccKl6VkgAq8a8rfWiKtRxFnr8cOtEBXmdIHekMvH
         QuQC6H5Qfar/wJjEtoub8wZxRXeHkRMs8uhe5v75XicvwbKvGOtGRqVx6qsZ0t0Jo0JS
         n4HQ0tc+4tSGPHRmTHuagyr2aS7+aWbt5bs6ayb3/5/X9024I87N7th28qAnQNCZSWhG
         GehNmW1wL9MjJoY4fwhwjPxjDXUB2V0AZmvpg0GGRBCSSazlJR1FU3evajbcEyL0HTf/
         bexg==
X-Gm-Message-State: APjAAAXRh1WbBQLrh+JteijcVUIabJsX6LxrD+UcWxnj25S+Ylp40jLU
        PztNa89DmWRU42mFYFouzmoZaXSb
X-Google-Smtp-Source: APXvYqzI4H02klruQopTvDwSkMZtSci9ZTf+zzX6hKAlIZdCToerAm+itgErBu1Zyv5fHaK0woHljg==
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr1960307wmk.126.1571209639317;
        Wed, 16 Oct 2019 00:07:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4sm1495665wmm.10.2019.10.16.00.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 00:07:18 -0700 (PDT)
Message-Id: <pull.401.git.1571209637.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 07:07:15 +0000
Subject: [PATCH 0/2] Handle git_path() with lock files correctly in worktrees
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I stumbled over this during my recent work in Git GUI
[https://github.com/gitgitgadget/git/pull/361] that was originally really
only intended to use the correct hooks directory.

Technically, the first patch is not needed (because I decided against adding
a test to t1400 in the end, in favor of t1500), but it shouldn't hurt,
either.

Johannes Schindelin (2):
  t1400: wrap setup code in test case
  git_path(): handle `.lock` files correctly

 path.c                |  4 ++--
 t/t1400-update-ref.sh | 18 ++++++++++--------
 t/t1500-rev-parse.sh  | 15 +++++++++++++++
 3 files changed, 27 insertions(+), 10 deletions(-)


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-401%2Fdscho%2Flock-files-in-worktrees-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-401/dscho/lock-files-in-worktrees-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/401
-- 
gitgitgadget
