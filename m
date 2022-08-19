Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32B4C32792
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 20:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351889AbiHSUtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351680AbiHSUtS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB09A061E
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 13:49:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r16so6424656wrm.6
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=ooA3ydplkn5wP5BPJPhLvXnm+4U4d0ZasVxA1wCiCP4=;
        b=qbX9U2k6ETb4VjiypY/4lqwRpzMLg9QafNGtVN6Jsj47rFL/hjNeXu15YzOCQhEz3g
         o9+wPmcWvqTyPNPCJ7WHFulpFomWBbr118EPI0q3yDk3wFI+g+LSq0ULzakSsQshqsGn
         TTlIvSimuZsdn3jdCTdDs3lAc+arZIFgBBxowzMo7Xt0FAQ/14bNnBBZrN3VhgC8eCkB
         70Evo4UQJLQgPSmKK2jYBCJCFbdodQZHXEf9CTJUy8JijkFQEKFBsk7X0A4oHTRrUfxv
         lm6Q8az8il8vb4LGBjM7L4QL2qktUHyFzPAGNMrIapOH5w7efBfFtHAQU5m/CbAvZ321
         4mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=ooA3ydplkn5wP5BPJPhLvXnm+4U4d0ZasVxA1wCiCP4=;
        b=uQjViGr0lxmLpVZLwJZTq/H09gXBGiBd8jQ7YV1QLxOc2L58I5y7Sd8alP5AR3gs8I
         Io+xCajJM1en4jNJWB5snK7k/1kpxEVJkbsyrcsY1SIYMOWRRbwYH5OpNxdvrDIPPXrl
         5eqq6cHply+W5NV7ZBzTV+/DiFkQpEyYazoDrbKGjEr03CnsU1nnAqhW14uwMzOOZLg+
         outFiySPMQRqGIVh6zArMaFwirvBBG170Z52vuDI8ZDLcX99A5BEatOGBM0Law1O+8Ob
         6xxide4+K7riiwRKa1UkLGvlMmrAi7H2ZrbA4G6xaYtJOyzViFhKnrPCmjkmwmqBNLkS
         FMNA==
X-Gm-Message-State: ACgBeo0fXtMyzWF6Vp2Bg/Lf8ipHE1IJQYLTUcKXNtjAzSzj2UHiNgVe
        7xlzSzNrkAV0n1BTEj+7n+bJFaWJnmk=
X-Google-Smtp-Source: AA6agR5Unw2Xt9oSekAVogK+4xwaF3JQFGwlACu0pnxamh5TQsD0j2TGSmM0DCoC37KWeB1ylJSHhQ==
X-Received: by 2002:a5d:50c3:0:b0:225:2840:2f41 with SMTP id f3-20020a5d50c3000000b0022528402f41mr5071163wrt.391.1660942150935;
        Fri, 19 Aug 2022 13:49:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5-20020a5d4685000000b0022526db2363sm4928236wrq.30.2022.08.19.13.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:10 -0700 (PDT)
Message-Id: <pull.1330.git.1660942149.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 20:49:07 +0000
Subject: [PATCH 0/2] t/perf: fix broken tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes two performance tests (p0004 & p0006) with syntax issues
preventing them from running properly. Since these are pretty
straightforward syntax bugs, the fixes don't seem to change the intended
behavior of the tests.

Thanks!

 * Victoria

Victoria Dye (2):
  p0004: fix prereq declaration
  p0006: fix 'read-tree' argument ordering

 t/perf/p0004-lazy-init-name-hash.sh | 2 +-
 t/perf/p0006-read-tree-checkout.sh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1330%2Fvdye%2Fbugfix%2Fperf-test-bugs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1330/vdye/bugfix/perf-test-bugs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1330
-- 
gitgitgadget
