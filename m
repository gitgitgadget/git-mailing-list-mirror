Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E70881F453
	for <e@80x24.org>; Thu, 14 Feb 2019 21:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440225AbfBNVdO (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 16:33:14 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43824 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392871AbfBNVdO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 16:33:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id m35so2319983ede.10
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 13:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=CcQXfmjc+8bv939aaj/+a4FjW5cs6u2bHWW7cDje8C4=;
        b=n+eSSM0ZLQKPY40oxhVmomGa/DPie4vfRHAcNzFPcvrclVmecYGYEDRMfSNZ/r2XVX
         vGwcgjqWBSz/Vmk1Qi2l1HIrlA7QQkOGM5QP9DdikFxd2lrG/PCWiPDy5yD5Ac8vaUFb
         Ql7slYMMujeA1esZya5PMkNYrv9kHNuJsRaNYvQC1YCGjw0E4ufqCwlB2IRP+ivp7y/L
         NBbO53yuNEUtdDfL5LDWXm68xu1erVmPIgX00/6n2473odDE3WKxxhZ4TGiWsG284j3t
         enVrZyze1EzVuhC02pKCtwSpjB32cYIQEb7VTIJsiTWauMzuq/u6uwOHsNFDRbqCUVSR
         cHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CcQXfmjc+8bv939aaj/+a4FjW5cs6u2bHWW7cDje8C4=;
        b=QOR0zSfjRFrljzswKGHrvO2oiT0I3veJGLiVO/T79cuHgnvSM8+Zu4UInhsVUR4HeP
         DWMng5WGD2LrA4RYGneGQZX9+4KfUStBWJLg62ZNIfcp/QOapf6+8cbZHM50rGmo/0Js
         withfGdHWq1XrGNzXWR8fLapVDLr0tpstCU28z95C3bn3ndXBV8/8LW0+qoC8JA6PKjF
         NxNfDB1wPe6foYO+ia9TvH0vT1Rs7+87rsW+dggxDncsPiNeRW0u592V5JK5tFCMFa3x
         roGWLT0LbqipkjbSPeIt/PNajDSEf/RrToqk8mc0/XUvvyU1+RedTEwgAI5wS2Aifg1R
         YnEA==
X-Gm-Message-State: AHQUAuYXyN/13NX+gvkylAusJegcgFKo9a91GQ6B9Ge+xgW8PgZIHMxh
        QQSv+ON2XYFt1fIepSYJ+C9ua2DE
X-Google-Smtp-Source: AHgI3IZGnUlB/NwuKWxpUJf1GywE/pWe4IYRKkeVa0wcZ7a0PDUo/BiAXjXGnsKkmFFZE4dJ7pzPbg==
X-Received: by 2002:aa7:d41a:: with SMTP id z26mr4798302edq.224.1550179992402;
        Thu, 14 Feb 2019 13:33:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10-v6sm761143ejn.67.2019.02.14.13.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 13:33:11 -0800 (PST)
Date:   Thu, 14 Feb 2019 13:33:11 -0800 (PST)
X-Google-Original-Date: Thu, 14 Feb 2019 21:33:09 GMT
Message-Id: <pull.126.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Randall Becker <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last-minute patch to replace /dev/zero with a Perl script snippet broke
the Linux part of the CI builds on Azure Pipelines: it timed out. The
culprit is the rb/no-dev-zero-in-test branch (see the build for this branch 
here [https://dev.azure.com/gitgitgadget/git/_build/results?buildId=1727]).

All of master, next, jch and pu are broken that way. You might see it in the
commit status of the active branches
[https://github.com/gitgitgadget/git/branches/active].

Turns out that it is that particular Perl script snippet which for some
reason hangs the build. If you kill it, t5562.15 succeeds, if you don't kill
it, it will hang indefinitely (or until killed).

Sadly, despite my earnest attempts, I could not figure out why it hangs in
those Linux agents (I could not reproduce that hang locally), or for that
matter, why it does not hang in the Windows and macOS agents.

Let's avoid that hang. This patch fixes things on Azure Pipelines, and my
hope is that it also fixes the hang on NonStop.

Johannes Schindelin (1):
  tests: teach the test-tool to generate NUL bytes and use it

 Makefile                               |  1 +
 t/helper/test-genzeros.c               | 22 ++++++++++++++++++++++
 t/helper/test-tool.c                   |  1 +
 t/helper/test-tool.h                   |  1 +
 t/t5562-http-backend-content-length.sh |  2 +-
 t/test-lib-functions.sh                |  8 +-------
 6 files changed, 27 insertions(+), 8 deletions(-)
 create mode 100644 t/helper/test-genzeros.c


base-commit: 8989e1950a845ceeb186d490321a4f917ca4de47
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-126%2Fdscho%2Ffix-t5562-hang-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-126/dscho/fix-t5562-hang-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/126
-- 
gitgitgadget
