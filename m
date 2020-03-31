Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_ABUSE_SURBL,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEA2C2D0EE
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30F920848
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5bje309"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgCaMsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:48:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38719 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbgCaMsi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 08:48:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id e5so24947693edq.5
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=XiZpKbhJ+fgrN3kXl0MNR4sLtmid3jg7o/Aavla0SHc=;
        b=h5bje309TAGrimQV7SUQJJj3qDcdMsB/Y+3XEpNFpbgGX3+60g7OZz/ex1Ouqdb+CP
         l9mby6PIb5jddc/BTCqAqu2FCqfCmpSbIARCQAk3ACh+isQ430gJx0gHO+tc8RaKkS/N
         B9jdpL6BopOW4Mq/5IflobyyzRXavcYCYozSwnaCUGOV/CVl06gevPpXRpOgfPdHNuDL
         W6WzabWtb1QEP0r5FGaPB/VL8HbeRrXxMFsMEboUfroPSb7aVqwtmD5eTuRqfM5ZkO8A
         efocVG3kemK8mmNitBFKsdKLEGGAA22BS9Pmzky8RCr5q/2ERfU6Br7sSzlkIzV+w+VX
         rDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XiZpKbhJ+fgrN3kXl0MNR4sLtmid3jg7o/Aavla0SHc=;
        b=ULmm/1QXntI4US8hHf6PeqN+f66wrAx7zQL7WFGbOvIuauOpZubih701mEtKo+bmzG
         pZ8zicEbehNXVqQ1bwgXo2+Rg14FcVWRzr6yJX93KrYvmMpX5uGJBbxuWAQDZE9dqtx2
         Gxbl1DVW8/DPT8v9iOpWmA87RKeTogmDWge+9UcQiMcKyv5O2U/gaODCvtF/kTIGKu35
         VaSjY+jPulnSM3MCyxbuLR7rtDVjNiEH6xsH+4VkFlBV3ZBpsBC8evlR3FSMzToj6Wjm
         kdicBj1Zf7eSOKQ2m59Mc5mSoo4+o+Dznjpb+oxI+j2Ai7WlzJIIgSnHOyZVyn8kCUOg
         z0jg==
X-Gm-Message-State: ANhLgQ3aMNmlqe6JMGm2b1ihziYyidWYyeANI9S0SPCNRBmaPMVTMo6c
        u96KymfLPqcoYWOUVC+j1vFZWUJj
X-Google-Smtp-Source: ADFU+vuWX7eDAn0iKWX7wWLrdVXKLsHshR3dq8H4NiSr6ZvoKIMCjNyG8gLKauj6ec3H5VVQbiBU9Q==
X-Received: by 2002:aa7:d4d1:: with SMTP id t17mr16041904edr.362.1585658914319;
        Tue, 31 Mar 2020 05:48:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm2078628ejt.25.2020.03.31.05.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:48:33 -0700 (PDT)
Message-Id: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Mar 2020 12:48:28 +0000
Subject: [PATCH 0/5] ci: replace our Azure Pipeline by GitHub Actions
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

Our Azure Pipeline has served us well over the course of the past year or
so, steadily catching issues before the respective patches hit the next 
branch.

There is a GitHub-native CI system now, though, called "GitHub Actions"
[https://github.com/features/actions] which is essentially on par with Azure
Pipelines as far as our needs are concerned, and it brings a couple of
advantages:

 * It is substantially easier to set up than Azure Pipelines: all you need
   is to add the YAML-based build definition, push to your fork on GitHub,
   and that's it.
 * The syntax is a bit easier to read than Azure Pipelines'.
 * We get more concurrent jobs (Azure Pipelines is limited to 10 concurrent
   jobs).

With this change, users also no longer need to open a PR at 
https://github.com/git/git or at https://github.com/gitgitgadget/git just to
get the benefit of a CI build. They just push to their fork on GitHub and
monitor the build. Easier than making apple pie.

The only caveat is that this will only work once the patch series makes it
to master. In the meantime, you can adore the CI build here: 
https://github.com/dscho/git/actions/runs/67349068

Johannes Schindelin (5):
  ci/lib: if CI type is unknown, show the environment variables
  ci/lib: allow running in GitHub Actions
  ci: configure GitHub Actions for CI/PR
  README: add a build badge for the GitHub Actions runs
  ci: retire the Azure Pipelines definition

 .github/workflows/main.yml | 271 ++++++++++++++++++
 README.md                  |   2 +-
 azure-pipelines.yml        | 558 -------------------------------------
 ci/lib.sh                  |  21 +-
 4 files changed, 292 insertions(+), 560 deletions(-)
 create mode 100644 .github/workflows/main.yml
 delete mode 100644 azure-pipelines.yml


base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-743%2Fdscho%2Fgithub-actions-git.git-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-743/dscho/github-actions-git.git-v1
Pull-Request: https://github.com/git/git/pull/743
-- 
gitgitgadget
