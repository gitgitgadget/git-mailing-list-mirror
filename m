Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99302C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 07:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbhKVHFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 02:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhKVHFn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 02:05:43 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B785C061574
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 23:02:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d27so30782801wrb.6
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 23:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=j6+cnn5axpudBfN2z6Yuzt/eFvt6AkMrWXXtLLod5rY=;
        b=huv+p3cOp9dVPyVPgeNnntG3aoBzsvHz6cyn0yeRsHWIWaunct1TTSnjcLOPLQSqv/
         EohObraUCL4QJ4TLez4/OIRlnkw5/I3irzLY8tYLmfy+VlxBDGXFc5Oo7Sdpr6kpqZL9
         /uR4GUXLkfq6tbrIWCkyZWnduNyVxDx+l3Pxjc0jXMMsk5raZ3FH4loMausApaEUnkaF
         K5N2R0qO5bYkxo5YtmS065KLXC70ogZ9xDAPg+lSwwb+3uVEOgNTwffe+xWORB3yOzNW
         rvk36/WObIE8yErxC3Y9rBJ5viKDDDqDyS1HWK+T2nQYBhijTWfg1DwuPZTMYSWfcPKx
         lsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=j6+cnn5axpudBfN2z6Yuzt/eFvt6AkMrWXXtLLod5rY=;
        b=2dgFM1Th081Srx5L0aLQEDbJDdjkpiqrWsLpwzfoz7WSlteSLcZ5Okqv01fo5uMT6n
         wPEToBkfZRR6viAWZMDMOt/e1tNHkYNdYzAiTTSebx0YgmW8Si0kiVlH3aOpKyPTYx/h
         zlkDA/x4JFrYG9dHvbG2vG3cv7a9PQIWv2436mdjgSjHamhg8AG6t4Yyf0mheEQkvpEL
         Ojtup6cctlZTUGU10Jt8IAOrgBW/5Fnr8EV1Kx0mN/hFCdno852i5HGNSa+0/i+pnqCv
         l9BbXEi6vQQmHIXaXlVmfvEZAxEQWyD6z3xTwFhx0Dh8ZHOhoG85hsI5JM8HyxHAHFYl
         /AIQ==
X-Gm-Message-State: AOAM531vuTI13Q68Bd0kUue92XxatLqtGrY1bj1xOKtdVmQyjhLs/iUN
        7RTpz0IJP0cRIiSowzUPogxaLE69lGc=
X-Google-Smtp-Source: ABdhPJzW8JOBVA9f0rDvBTR7zCjelK3UX/yoNChevItkk6uArqJZUSh//wdWY16F7OhrzLnPtx0CsA==
X-Received: by 2002:a5d:4b06:: with SMTP id v6mr35294627wrq.194.1637564556032;
        Sun, 21 Nov 2021 23:02:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm847110wmp.9.2021.11.21.23.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 23:02:35 -0800 (PST)
Message-Id: <pull.1076.v9.git.1637564554.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v8.git.1637563611.gitgitgadget@gmail.com>
References: <pull.1076.v8.git.1637563611.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 07:02:32 +0000
Subject: [PATCH v9 0/2] am: support --empty=(die|drop|keep) option to handle empty patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option.
 2. rename the --always option to --allow-empty.

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit.
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Changes since v3:

 1. generate the missed file for test cases.
 2. grep -f cannot be used under Mac OS.

----------------------------------------------------------------------------

Changes since v4:

 1. rename the --empty-commit option to --empty.
 2. rename three different strategies (die|skip|asis) to die, drop and keep
    correspondingly.

----------------------------------------------------------------------------

Changes since v5:

 1. throw an error when passing --empty option without value.

----------------------------------------------------------------------------

Changes since v6:

 1. add i18n resources.

----------------------------------------------------------------------------

Changes since v7:

 1. update code according to the seen branch.
 2. fix the wrong document of git-am.
 3. sign off commits by a real name.

----------------------------------------------------------------------------

Changes since v8:

 1. update the committer's name with my real name to fix DCO of GGG.

Aleen 徐沛文 (2):
  doc: git-format-patch: describe the option --always
  am: support --empty=<option> to handle empty patches

 Documentation/git-am.txt           |  8 +++++
 Documentation/git-format-patch.txt |  6 +++-
 builtin/am.c                       | 55 +++++++++++++++++++++++++++---
 t/t4150-am.sh                      | 49 ++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 6 deletions(-)


base-commit: ca35af825273b98fc8dc11527488952f5db8eb80
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v9
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v8:

 1:  5d98a088e14 ! 1:  3b41ca3dec7 doc: git-format-patch: describe the option --always
     @@
       ## Metadata ##
     -Author: Aleen <aleen42@vip.qq.com>
     +Author: Aleen 徐沛文 <aleen42@vip.qq.com>
      
       ## Commit message ##
          doc: git-format-patch: describe the option --always
 2:  3ff18e16a7a ! 2:  d2ec18b36af am: support --empty=<option> to handle empty patches
     @@
       ## Metadata ##
     -Author: Aleen <aleen42@vip.qq.com>
     +Author: Aleen 徐沛文 <aleen42@vip.qq.com>
      
       ## Commit message ##
          am: support --empty=<option> to handle empty patches

-- 
gitgitgadget
