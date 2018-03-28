Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742DF1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbeC1Wfg (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:35:36 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33321 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeC1Wff (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:35:35 -0400
Received: by mail-pf0-f172.google.com with SMTP id f15so1822414pfn.0
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BFh3YpYUdraaFfPakfX0cKzncKsIJaKKLYoyzL1UJu8=;
        b=Vp/i1cr9rFO0RtcXG1WF/3Y+DuNKT6URor9tF/Js61rh2jbOx024HWyVOOV8MGWOxq
         zw9IGSzavIBj0M/hxXkUoCdCfisW1xBHtGHJ4xlljc523bO12xCdBH1BXiF605B8PKOw
         PLN5GYD0BhERjiurEAxBDMj8+yH3m5nCTv7ZH4LFZ3ySjw4D43DVk0+27q5lqvtGvO+7
         ZFbjvHAu3v/+kQTY8RoEItopJRlhudHbavKeVBcz+Q/z3qaiY+2w7ZwbzN9R76ydkHjC
         A4HRnyKrUM5eurzQeEJr8O3XbnPZ9EKUFwmJelGlZAo8JcY81HtuxTdsJcIS8Ykhd2wy
         87Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BFh3YpYUdraaFfPakfX0cKzncKsIJaKKLYoyzL1UJu8=;
        b=ni8WQdG2C1Ii9TailU1DO/0tm5cDX4mwgn5RO5kxpflWoJx3V7cr/dEovr2XOQd0IW
         8YH0W0UclQqQoYm+MBSAI9of0bwb0jXij3YUi/0ejj2+voyjXQbfTtka7ZnLus5ZXhhZ
         ijcZBKxzEw5xi/MDOPU9rHMd9WDj4W66EIltRXi4TW/Pfrc/W4ZPlT+4Jy2/pMWxXR4A
         +v9E9FkYRGSiYq4DCDnoeN2ECFBIdAl1msiQbx+ixFcRUkXg1wCZIzIVQsyxyZkjmWvG
         UkuQRPjpyabGxkMkU8pVJ/zlpQmX5sOG+8V94DK2yEUS70FauUZXDeg6POoXJB/JthL0
         bYEA==
X-Gm-Message-State: AElRT7EYbPlCzAWbzUNdI0m+eHettaVxQig6NlHT3KmbPjv5PaEZ3PrG
        yStHBm0yTjSJ3YjMuxBygsIaDg==
X-Google-Smtp-Source: AIpwx4+XVQjhwwacWr4Rgk/Z8fnLKC+8mBodyd9yJ3J05N3kCtvGzIFaCO7nCLsSHqww+3bga3fO5w==
X-Received: by 2002:a17:902:7c95:: with SMTP id y21-v6mr5604178pll.170.1522276534988;
        Wed, 28 Mar 2018 15:35:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x5sm9834247pfx.110.2018.03.28.15.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 15:35:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        hvoigt@hvoigt.net, sbeller@google.com, seanwbehan@riseup.net
Subject: [PATCHv3 0/6] Moving submodules with nested submodules
Date:   Wed, 28 Mar 2018 15:35:25 -0700
Message-Id: <20180328223531.241920-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328105416.3add54858bac92573d7d1130@google.com>
References: <20180328105416.3add54858bac92573d7d1130@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3:
* reordered patches to have Jonathans patch before submodule_free
* addressed Jonathans comments on patch 5.
* rebased on origin/sb/object-store to resolve a visibility conflict
  about repo_init being exposed outside of repository.c

v2:
* addressed memleaks and messy code in patch 5
* removed the extern keyword where applicable
* extended the commit message, stating we want to rename submodule_free
  in the future.
* picked up Jonathans patch and added it as a nice finish of the series.
  I did not see the need or aesthetic desire to put that patch earlier
  in the series.
  
Thanks,
Stefan

v1:

This fixes the bug reported in [1] ("Bug: moving submodules that have submodules
inside them causes a fatal error in git status")

[1] https://public-inbox.org/git/20180306192017.GA5797@riseup.net/

Thanks,
Stefan
Jonathan Tan (1):
  grep: remove "repo" arg from non-supporting funcs

Stefan Beller (5):
  submodule.h: drop declaration of connect_work_tree_and_git_dir
  submodule-config: allow submodule_free to handle arbitrary
    repositories
  submodule-config: add repository argument to submodule_from_{name,
    path}
  submodule-config: remove submodule_from_cache
  submodule: fixup nested submodules after moving the submodule

 .../technical/api-submodule-config.txt        |  2 +-
 builtin/grep.c                                | 14 ++---
 builtin/mv.c                                  |  6 +-
 builtin/submodule--helper.c                   | 17 +++---
 dir.c                                         | 60 ++++++++++++++++++-
 dir.h                                         | 12 +++-
 repository.c                                  |  8 +--
 repository.h                                  |  3 +
 submodule-config.c                            | 29 ++++-----
 submodule-config.h                            | 15 +++--
 submodule.c                                   | 40 +++++++------
 submodule.h                                   |  1 -
 t/helper/test-submodule-config.c              |  8 ++-
 t/t7001-mv.sh                                 |  2 +-
 unpack-trees.c                                |  2 +-
 15 files changed, 140 insertions(+), 79 deletions(-)

-- 
2.17.0.rc1.321.gba9d0f2565-goog

