Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F3F1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 19:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfHUTSf (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 15:18:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46517 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfHUTSf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 15:18:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so3070389wru.13
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hvbPPelYD+ejdg/HnCylw6EPanjvzpYb4Pybh2rL4QA=;
        b=bafEhy51IWjVZMcXtoXKynjZe+uS142tmoKC+oHii69CybYnUuCw67b/aczz2d3Ixz
         ERSYDqAp9768zb+eNYcVSD2S5wjlli4dfRRhStgTg15tqEHV9/hRwObFhNnVt3gmKSAE
         k4/kAEgTW60PakP4d97rP2bg3tE90INZcRBLAbZOajjihwtLeOEqAq175o/SCRttz8O3
         1SAOTAm6gY2tQLaL5RwFKbmMqaxFSgk8/VGylOQWb+hAEVcFSYCscamZZGrcbojMmRHZ
         KisGjO5bw9Wm3PfZKAMTTFUhIYdBqSHhiB7r0v9QWcP49V+TDkHSDYBb3EUDUB+fS4xm
         TWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hvbPPelYD+ejdg/HnCylw6EPanjvzpYb4Pybh2rL4QA=;
        b=Q9jdVzAUW21EmT943MG2tugdSInKP3WskBOpQ1497jjeNhdJSoLmrc3LQ7cGP70VYa
         psh0S1Yb2EiotJZBVy9WIMnPvlju8yHvCvvilowCAE9vahDS1M1bKDbdBcZwaHWllZ68
         BddNNKE+QqMrQ7EHgRgPd2unXG4/0sQTqUXI7I+3v1iHP/fbv5dFEFLD59yH4dWNHoz8
         SSgbmOOMwxPovtadkqBZH+t1oKmmb3uluUbV4BHRhOxWP6Tzx+/syc2+DMWPD8E0u6va
         VakQnir3D9l7x41gfiSfyhio2i6zVT8qNlm+p1W6hSi1s5hxBuyzzCJZvgD0fo8q+mae
         YqNQ==
X-Gm-Message-State: APjAAAVOV9FGo+FFpnxkrstrnMlO8VSJLn7hG71SLPzN+sMVq12VmZJK
        PP9CevccdgOm/68i+HRkbTgAZzcl
X-Google-Smtp-Source: APXvYqzYFG5+NtKhjBqaKyjMAXUo9M9uKFdQNiLGAe9i6r5dXXE9oC/bPF2a1GeYzcypNeA6buN+Ow==
X-Received: by 2002:adf:e4c3:: with SMTP id v3mr42055420wrm.107.1566415113499;
        Wed, 21 Aug 2019 12:18:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15sm20308666wrn.70.2019.08.21.12.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 12:18:32 -0700 (PDT)
Date:   Wed, 21 Aug 2019 12:18:32 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Aug 2019 19:18:30 GMT
Message-Id: <pull.317.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] [RFC] Revert/delay performance regression in 'git checkout -b'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we were integrating Git 2.23.0 into VFS for Git, we discovered that "git
checkout -b new-branch" went from 0.3s to 10+s on the Windows OS repo. This
was an intentional change when writing the "git switch" builtin. Here is the
commit message for 65f099b ("switch: no worktree status unless real branch
switch happens" 2019-03-29):

When we switch from one branch to another, it makes sense to show a
summary of local changes since there could be conflicts, or some files
left modified.... When switch is used solely for creating a new
branch (and "switch" to the same commit) or detaching, we don't really
need to show anything.

"git checkout" does it anyway for historical reasons. But we can start
with a clean slate with switch and don't have to.

This essentially reverts fa655d8411 (checkout: optimize "git checkout
-b <new_branch>" - 2018-08-16) and make it default for switch,
but also for -B and --detach. Users of big repos are encouraged to
move to switch.

I was considering doing a full, long-term revert of this change to get the
performance back to normal, but I also saw this feedback on the list for
this patch:

I like this last bit. The skip_merge_working_tree() function which
this removes was ugly, difficult to maintain, and difficult to get
just right (and easy to break -- even by changing parts of the system
which one might not expect to impact it).

So, the goal is to reduce the complication given by
skip_merge_working_tree() by recommending that users use 'git switch -c'.
The only problem is: users will take a while to move, unless prompted.

This series does the following:

 1. Reverts the change that makes 'git checkout -b' slow again.
 2. Creates a warning that recommends users start using 'git switch -c'
    instead.

This allows us to strip out this performance feature after users have had
time to adopt the new way of doing things.

Derrick Stolee (2):
  Revert "switch: no worktree status unless real branch switch happens"
  DEPRECATION: warn about 'git checkout -b'

 Documentation/config/checkout.txt |   8 ++
 builtin/checkout.c                | 130 +++++++++++++++++++++++++++++-
 t/t1090-sparse-checkout-scope.sh  |  14 ++++
 3 files changed, 150 insertions(+), 2 deletions(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-317%2Fderrickstolee%2Frevert-switch-slow-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-317/derrickstolee/revert-switch-slow-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/317
-- 
gitgitgadget
