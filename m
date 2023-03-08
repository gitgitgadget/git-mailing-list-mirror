Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B963C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 13:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCHNt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 08:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCHNtU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 08:49:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EB44E5FB
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 05:49:11 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c18so9849272wmr.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 05:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678283350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mKJZoOwlRDGGHI2keEvDIcedCrXuZGOk4OsJMYYZOQs=;
        b=hwhko6ynnwWQQ8Qe7fHG8iuvx2z78kBgB/BPTnV4Y7R+SwAXze6zBmhRSN0IWrdALM
         T7REdJCDFY6h5LggVBo988w3Eb8nQ8Gff6c0u/N0WXmd0cJub8CQGdbu4AEEClshsSW4
         kDiDuKXs5noprRrdl8pYeui3IVm3Ih1wcR0q7xXSWtorweyJeCW4TJzzr3q8W42UrCIC
         4X7SkhVNMleH1yrLC+Ha074b1203W193k2W5xyYNrO2tHbus5282lZiJ2k9J6fa2Yj0k
         IWC4OQwdzAdarfmq7lZL9aY+UUSu+E6uzHNZkDrBhlR0dnkFzoEXxDprfTKIlF7rEgdT
         O93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678283350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKJZoOwlRDGGHI2keEvDIcedCrXuZGOk4OsJMYYZOQs=;
        b=ZPwPDktJDcW+ZPeLuWnYqhdkp1n/ssYctUo4v8Sn7Szy3Q2ML9BjhPamyb6R5rg5LS
         mr547GCqSslKsOdPQ2EAHhA54bNp1xP/29ne9JcQeUlzifHXZXFnzf3G8uu3aLvCOLQt
         xFH+jmHQJ5AT4zCN44ZEgWztITVIdm2M+smFw54/FAUl3nQHg9x/c8OiW+8YCfqk7lnB
         tBj696ETprx8rcRCgb2ADY6CsemDvSzYiW/hzx1TtpkSrZvjG45UIx+9Uxq1PSMvR7kz
         uqTdUhJffXH8Qj7FSCOWFTR9Oe8Fx1Fu0lH7r78vHhJ/eqV4dN5Eg2oodHDwBx6oyFi6
         8AcA==
X-Gm-Message-State: AO0yUKXnt2+R9OzJUqAXtK/1X2k3Cyo8Cr0kczXRFieOBHkH+bTsdnsc
        nBUTtV+YTXn1M3ZSbEDjmcQnsS+5yvc=
X-Google-Smtp-Source: AK7set+1KGKiGtFniYlzSRkbuSeCZYTnZ17ZZmP88b7Xo/9qi4JNBtquhs3wdcM8TbVN9B3h3pKgmw==
X-Received: by 2002:a05:600c:470a:b0:3eb:3843:9f31 with SMTP id v10-20020a05600c470a00b003eb38439f31mr16527387wmo.10.1678283350072;
        Wed, 08 Mar 2023 05:49:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d42-20020a05600c4c2a00b003e6efc0f91csm15568781wmp.42.2023.03.08.05.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 05:49:09 -0800 (PST)
Message-Id: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
From:   "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Mar 2023 13:49:07 +0000
Subject: [PATCH 0/2] builtin/sparse-checkout: add check-rules command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

Back in January I submitted a patch which suggested to teach 'ls-tree' to be
able to filter its output based on sparse checkout specifications [1]. My
main motivation for doing so was (is) to enable building more tooling on top
of sparse checkouts, which is currently hampered a bit by the fact that git
doesn't expose the pattern matching rules for the sparse checkouts.

I think the main point from that thread was that the 'ls-tree' change was
conceptually a larger change that I had initially thought it was. It was
suggested that perhaps it would be more straight-forward to initially add a
command in the vein of 'git-check-ignore' before teaching all the other
commands about sparse checkout specifics, and I think that makes sense. So I
am proposing here a new 'check-rules' sub-command to 'sparse-checkout'. This
exposes the sparse checkout pattern matching logic while still keeping the
pattern specification local to the sparse-checkout command.

Since the intention is that this new behavior would not need a work tree as
it allows the user to supply a set of rules to verify the paths against, the
change that introduces the sub-command is preceded by one that removes the
'NEEDS_WORK_TREE' flag for 'sparse-checkout' and replaces it with calls to
'setup_work_tree()' to keep current behavior.

1:
https://public-inbox.org/git/pull.1459.git.1673456518993.gitgitgadget@gmail.com/

William Sprent (2):
  builtin/sparse-checkout: remove NEED_WORK_TREE flag
  builtin/sparse-checkout: add check-rules command

 Documentation/git-sparse-checkout.txt |  23 +++-
 builtin/sparse-checkout.c             | 132 +++++++++++++++++----
 git.c                                 |   2 +-
 t/t1091-sparse-checkout-builtin.sh    | 162 +++++++++++++++++++++++++-
 4 files changed, 295 insertions(+), 24 deletions(-)


base-commit: d15644fe0226af7ffc874572d968598564a230dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1488%2Fwilliams-unity%2Fsparse-doodle-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1488/williams-unity/sparse-doodle-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1488
-- 
gitgitgadget
