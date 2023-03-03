Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B47C64EC4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 13:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCCNq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 08:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCCNq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 08:46:58 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F8E515E5
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 05:46:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n6so2705922plf.5
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 05:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Il/dSSRmVfD6pBTaFfcffxpDrp7pBgb+1w3voF6VJ0s=;
        b=cGs2+4BLpbtUg47ncIC3XlYmWtdTAaPApZxeJGsTxJlJzu774y9HA6XOUR//o9p4Gp
         lQCCla+IaBJRoNi/qkevh10q3FfftzpInStQONi2cpgfuOHMhOQN6jeg/nOky5ddjkhv
         q62WIiM4NguHi1Wf0zHsDx3TCb6fVhMG2dsheK4PaUpn9+5N+JuHXk5oxhfT5Gtk2fUC
         UEdDKyXj/pKF9R5jVE3/zlitkfwB2qX7qQuOooBQZhN7n1KO3giG1749GYE25ufBww6N
         vzucHef5XUlff7hf6uKG1ydMb5JlQ91JKiI8ULcfvy9wG2IqrI1KLdyCdjDm+oSRGVo1
         aagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Il/dSSRmVfD6pBTaFfcffxpDrp7pBgb+1w3voF6VJ0s=;
        b=UiAscRiMTFim1CJeBRmGnP07YB1JHE9bjOuKu96l8QFEiDua+khNz9RBjHerckYk2Z
         O7FixU89lIr9yTKIVd/RZwNWbVKgrm5V/Uo25KdTzh1rQ5oYdLrgtmCRFGSZ6Um3Leiz
         KwR0UnPOqsEZZjOf8VO8UP268aFQ6HswcKSzSVoirMO9qXQVEbAjjFKfE7RGRHXZUMc8
         gL+Zl+voA4Z7VCarLNl5kaiz+F4byx7w0oQUpigHoGBLK26KxJU8c8JCcu92F9ovHYai
         q9ABLYf2yy4UotUjnP08005WmmUCYUszQlbUrcHgSywz75UL82wzCQ5UUV5MwlURK647
         vyAQ==
X-Gm-Message-State: AO0yUKWHTsDjvlWS3XmpiFK63f9fvblndvVTMijW9a8iC6i7DfmlOrN/
        6zeXsdnmNI9VvToibyC/yFRpZIOlzSs=
X-Google-Smtp-Source: AK7set/9E/FmhU9dPRGjDJHi5/y1eT0s3/Utor3e+1WGIkAaIl11g4oVi/NVVp2/7N2sK1OAP6MvUA==
X-Received: by 2002:a17:90b:4ac5:b0:237:dd21:c1e7 with SMTP id mh5-20020a17090b4ac500b00237dd21c1e7mr1712167pjb.35.1677851214617;
        Fri, 03 Mar 2023 05:46:54 -0800 (PST)
Received: from localhost.localdomain ([113.172.118.59])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090aab1500b00234465cd2a7sm1536138pjq.56.2023.03.03.05.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:46:54 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 0/4] Add a CI for unsigned char system
Date:   Fri,  3 Mar 2023 20:46:02 +0700
Message-Id: <cover.1677850517.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.2.gd15644fe02
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently, we have a brokeness on system with unsigned char because most of
people are working with x86_64 which has signed char.

This series tries to add a CI system for a widely used system with signed
char, which is arm64 via circle-ci.

In order to register for git to participate in Circle CI, you need to:
- Create an account and login into Circle CI, (I tried login with GitHub OAuth);
- Register a project with Circle CI, and choose which config.yml we would like
  to be used for Circle CI

Circle CI seems to allow 40000 (Forty thousand credits per month), in my
testing, with resource_class: 'arm.medium', (which costs 10 credits per minute),
it take 12m15s to finish, so that will be about 3000 run per month. I believe
arm.large, which is also available to free accounts and cost 20 credits per
minute, doesn't cost effective but I haven't checked out.

Sample run:
- Without the fix for unsigned char:
  https://app.circleci.com/pipelines/gh/sgn/git/12/workflows/9b39391d-0d03-4669-86e6-2796fd671c43/jobs/10
- Normal run:
  https://app.circleci.com/pipelines/gh/sgn/git/14/workflows/b8745f8e-8a57-4215-847e-2af66c1dd3c7/jobs/12

I'm not really sure if we want the 'store_test_results', which will upload the
test report in the 'TESTS' tab:
https://app.circleci.com/pipelines/gh/sgn/git/14/workflows/b8745f8e-8a57-4215-847e-2af66c1dd3c7/jobs/12/tests
and provides a test insights like this:
https://app.circleci.com/insights/gh/sgn/git/workflows/workflow/tests?branch=circle-ci

Đoàn Trần Công Danh (4):
  ci/lib.sh: remove an useless break
  ci/install-dependencies: libify p4 and git-lfs installation
  ci/install-dependencies: install git-lfs for arm64 build
  ci: add arm64 CI environment via CircleCI

 .circleci/config.yml       | 17 +++++++++++++++
 ci/install-dependencies.sh | 42 ++++++++++++++++++++++++++++++--------
 ci/lib.sh                  | 30 ++++++++++++++++++++++-----
 3 files changed, 75 insertions(+), 14 deletions(-)
 create mode 100644 .circleci/config.yml

-- 
2.40.0.rc1.2.gd15644fe02

