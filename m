Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB0FC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7FF6124C
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhJDCAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 22:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhJDCAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 22:00:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E94C0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:58:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r10so11294778wra.12
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pgqk6A84bInxWm4D51qqT7yAftqm4BzJ1BnDEMap1io=;
        b=NoTZrQhiBfnnws38Qun6JOffHznCb7aEeOnDev9JBKSoEDurclznJw+rCcmfXGCzHo
         ITVqK/WBttPI2BicRRqqgPkM2erHn247sOrgP+S4f3/AuOB7k01gLLMVi2auXHmLvrLj
         GGhUjF2TSKFTx5cBDw35TV+U1XhJnVCRcYEh0aP+wxt232mMs+C+ZZofHLLWHKhfjNQK
         Vuy29ndhdCiT4kuKnU6usPlJErZ89BbB50fh22ys+6fS31SNRtEaZWdUA7s7kWj7CVTm
         QLO2Zv4jtVsHGWYNqRtxwAIKpFDT4kZb8wLgSoVWnIMU7HRPWBdnSxs83wVkN9mzXlUG
         OwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pgqk6A84bInxWm4D51qqT7yAftqm4BzJ1BnDEMap1io=;
        b=xr6Ww1rXWvcVi8kWk+0q05yxft4VAvF3l5rvbmz+0IFiqHvXe24PzanaLwXRhtoaJj
         Xu6h1OzNtR0VkI3IHH0ar5bWETNkgoUiQsN0FL63FO8sbEXxlkaIlDwabqQupCdWFubn
         9z6mBEKSPrBm3av1tDpJdN6IfJJa17JEMx6nc22RIB8BlCSrezhDHyd2ynV6TjMXIipF
         yIZ1QxggTWqEnSh14HmgoVGZu0sndqC6JeKr54GQUdQrees3GuPROs1WToqXiFSpvR6R
         Bdwti1KtZFR8Sm+yEkCltUoe2qzLrL6rkVCQmRFteV083D2HzFkP/htbyBkM5qpNjoNf
         KzyQ==
X-Gm-Message-State: AOAM532EPZH4dBa+8X8Pkr0a/30xM/oxCxGZw3X/1xHQQ1ty8FiW3JhP
        EXY2BGx298ePyeQ0lU7cLoZTTHoNXsDY2g==
X-Google-Smtp-Source: ABdhPJyH/u9JDJg6DxQKsBPAohLnPdwtaFf4IX3MlyJ2r0hupizX4Fi6uLvey8zw9OH/KnAzQCJyog==
X-Received: by 2002:a5d:4344:: with SMTP id u4mr11670775wrr.106.1633312706526;
        Sun, 03 Oct 2021 18:58:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y23sm15349355wmi.16.2021.10.03.18.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:58:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Heba Waly <heba.waly@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] advice API: simplification, small fixes, readability
Date:   Mon,  4 Oct 2021 03:58:19 +0200
Message-Id: <cover-0.5-00000000000-20211004T015432Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g7bcfc82b295
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A follow-up to recent advice.[ch] improvements in fd0d7036e0d (Merge
branch 'ab/retire-advice-config', 2021-09-10). There are no in-flight
additions of new advice variables, and this doesn't conflict with
"seen". So now seems like a good time to submit this.

The API carried some complexity due to needing to alias one of the
variables, which goes away in 3/5, 4/5 then further reduces
boilerplate.

Ævar Arnfjörð Bjarmason (5):
  advice.h: don't indent top-level enum
  advice output: emit empty lines as "hint:", not "hint: "
  advice.[ch]: remove advice.pushNonFastForward alias
  advice API: revamp the API, again
  advice.[ch]: sort enum fields in alphabetical order

 advice.c                                    | 100 +++++++++-----------
 advice.h                                    |   5 +-
 contrib/mw-to-git/git-remote-mediawiki.perl |   2 +-
 t/t7004-tag.sh                              |   4 +-
 4 files changed, 51 insertions(+), 60 deletions(-)

-- 
2.33.0.1404.g7bcfc82b295

