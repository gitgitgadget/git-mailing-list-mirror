Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A04AC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242065AbhK3ORk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242054AbhK3ORi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:17:38 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E661C061746
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:14:18 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d24so44823982wra.0
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=JBPZ/sm97Y1R00W0Nh3+pcj8m8F6YVlzsqE/wIxKfG4=;
        b=cXKXtz6F6TeU8yVNftK0Z/UA7SafeV5LECX++99cnsQ4W41/1ESysmJBwuzqRIZOuw
         We8saAoebBGRlAkslkI10SDXlsflPcutpNDV4K6zv6CNT50AlMyVMtM4N40bw6KiZdCA
         +8+m0XfofwowTqm+T64q+QzW7P6Mwa20TSGZS4F5PDfBrpnVJ6NcUB8LUEQm99VpIBVs
         H+3CCzBjq9T9TnMLKxIbzB7wBenFMy++7DYl5BkOUYXSWkP8UNOogd3Ythhqj7ctWhcj
         ZQrqyb/l4hgTrUBS13//VF+XwG3f8Kv0GM0MccdrFFtcdXSuotm3JHmb7iy8G4ySZpMZ
         Hdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JBPZ/sm97Y1R00W0Nh3+pcj8m8F6YVlzsqE/wIxKfG4=;
        b=53o2E8mtG/mP8OI1j5Yh3m8F6WMLveNpXsHRTISe/u2R5JksuMVIgvDEeSM7DdmrUe
         I6hXuxgjefllCaKDKflA0aPbuCiCUacvnYF4AhkMggk3yW7GGHkQNruSoibp32HyKXG5
         GkvxGpLSGBtvo873bMqiG1SLT7dQwxWl7J+yapZ+xpTUiD9vSk4s6mE4xC+iKSteQC49
         JDiL2wwyoHPM4L/gGAWpuKAbmjNe+BbDjtTKGL1hCfk4AUEClzwpOL+qo0Bk88IP1mFb
         w1jav1JBvYXQP5TkbnfFjOqvqA/fG6Kut8OtBw+TuWeAlgxAqQhOSCSwzs7C5QhHwWWi
         Cp0g==
X-Gm-Message-State: AOAM532RgeyO7986X/kZ3odzTAI0AyCt+IK1iw26lqMFu8wQv0Wo0xrH
        RmPT8DOWiK+htoYF+buocxTz6luFZoo=
X-Google-Smtp-Source: ABdhPJzkRctA//nZiJILbipFztA09c4rI4hlCc9CAZ5nS4AzD0oFfrk7SLbzGdEL3eC23zXRYuObeQ==
X-Received: by 2002:a5d:4883:: with SMTP id g3mr40655588wrq.590.1638281656578;
        Tue, 30 Nov 2021 06:14:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm17515025wra.9.2021.11.30.06.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:14:16 -0800 (PST)
Message-Id: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 14:14:13 +0000
Subject: [PATCH 0/2] Use the built-in implementation of the interactive add command by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Slavica =?UTF-8?Q?=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over two years ago, Slavica Đukić participated in the Outreachy project,
starting to implement a built-in version of the interactive git add command.
A little over a year ago, Git turned on that mode whenever users were
running with feature.experimental = true.

It is time to declare this implementation robust, to use it by default, and
to start deprecating the scripted implementation.

Johannes Schindelin (2):
  t2016: require the PERL prereq only when necessary
  add -i: default to the built-in implementation

 Documentation/config/add.txt |  6 +++---
 builtin/add.c                | 15 +++++--------
 ci/run-build-and-tests.sh    |  2 +-
 t/README                     |  2 +-
 t/t2016-checkout-patch.sh    | 42 +++++++++++++++++++-----------------
 5 files changed, 32 insertions(+), 35 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1087%2Fdscho%2Fdefault-to-builtin-add-p-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1087/dscho/default-to-builtin-add-p-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1087
-- 
gitgitgadget
