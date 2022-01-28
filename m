Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58C4C433FE
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 00:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbiA1AMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbiA1AMf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 19:12:35 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAB3C06173B
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r7so3094853wmq.5
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=k/r/wDMbFmS4hcl0tVfSiFI52aceqzyR8nzDjQU8Q+g=;
        b=Nn8nc1yckTmyYIio+ckpAXIHmw4XFUvBRveX5wx6Yt4BldShpGjrbteANRg36nN9/1
         t6y/khG7mLywCGOfrt3PUXeeF12bfw/9EcUWNtpCC//TiZkJDLYOla+/cTU3bW9PP/47
         AARSfO0rXjvGj/HmMxwie0JR+TFDh1b/p2HHacCZqey9zCNiTG5AFsRdjR1odpFpnMBs
         iXgPjwN06fkRdBtmyaSFIuXvabc6KJt5GZuowLvEi2xL8Vg0gc17r7onmGSjUjtHELrY
         lD7RAYDCHt6w7KZhUvqWYPS5tqCBa3nPrV/6nTaiCBQZKXME1ktB5/pTDJrrM71vE9ni
         efag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k/r/wDMbFmS4hcl0tVfSiFI52aceqzyR8nzDjQU8Q+g=;
        b=cDPf8DkKiRUHTKMRG2zkuVRsBJWZqeDoGT04J1V6M5KMi8CPm8tvCUcSSAWWUxH1ox
         gGS8qRzf1nTMzSEcDkgNuZbOr0PzQtvcwQlWY1Fc5NAk0lgvt6W8K8nAO5eK2GoOSgK6
         zgjhpAwlfChDWpZeGlZZkN93KxCc2QGVPR8R776+JTHm10kIbIOKTDsFrZJ2PoZvM5FW
         DniVJlngcfPLFiSguCGjLX2+ob7AvmzLLtic4etvRsrDG0wYG5KkhCWSN0YeJYmEoRJA
         t+O00NG8C6HvbaIZrVmsMHgvgZ/pVbFIIn6v4JyWby0a0zi/EgoUdJYaJrAZB1gEKIc1
         x0Hg==
X-Gm-Message-State: AOAM53123uLxJrc9QeCqo7sCVDlw/5vkwWU5+SaXUA6INAZqArCrtUxl
        g1VkYr0ZqmheeIcxV3V+A7nsTgTAbQM=
X-Google-Smtp-Source: ABdhPJyF3NEYpYFzrg+vtHI6ehJg7ZY6idmIhHCF8DX8f3G8EVB9/tac08e0zLkiGG2bb76YBlS6+g==
X-Received: by 2002:a7b:c7cf:: with SMTP id z15mr13774368wmk.105.1643328753856;
        Thu, 27 Jan 2022 16:12:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16sm631758wmq.3.2022.01.27.16.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:12:33 -0800 (PST)
Message-Id: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 00:12:21 +0000
Subject: [PATCH 00/11] Finish converting git bisect into a built-in
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After three GSoC/Outreachy students spent an incredible effort on this, it
is finally time to put a neat little bow on it.

Johannes Schindelin (11):
  bisect run: fix the error message
  bisect--helper: retire the --no-log option
  bisect--helper: really retire --bisect-next-check
  bisect--helper: really retire `--bisect-autostart`
  bisect--helper: align the sub-command order with git-bisect.sh
  bisect--helper: make `--bisect-state` optional
  bisect: move even the option parsing to `bisect--helper`
  bisect--helper: using `--bisect-state` without an argument is a bug
  Turn `git bisect` into a full built-in.
  bisect: remove Cogito-related code
  bisect: no longer try to clean up left-over `.git/head-name` files

 Makefile                               |   3 +-
 bisect.c                               |   3 -
 builtin.h                              |   2 +-
 builtin/{bisect--helper.c => bisect.c} | 201 ++++++++++---------------
 git-bisect.sh                          |  84 -----------
 git.c                                  |   2 +-
 t/t6030-bisect-porcelain.sh            |   1 -
 7 files changed, 84 insertions(+), 212 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (87%)
 delete mode 100755 git-bisect.sh


base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1132%2Fdscho%2Fbisect-in-c-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1132/dscho/bisect-in-c-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1132
-- 
gitgitgadget
