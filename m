Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC28C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 22:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D59A20716
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 22:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djCpBqxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgA2WDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:03:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35040 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2WDs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 17:03:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so1441821wro.2
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 14:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=gpH5Ipgk0juTpzAPixDWLmXN8kyBd7D95Sw1Iewzjfg=;
        b=djCpBqxTG3sr96Ly9/+WoI/RwkPOIpz9IQIct9FxlHjloGDMn9/qV014KFMM0rAYVW
         jrij1iY2kQE9FHC99MBRkSQhJjzf09rDVg6qWpLlQP7+NnI5kGGZ9hVEh7RVBYE8Ban4
         GfVFIkfAX/7ooU/Nh0rLLHXnWu198jQ/O8iW1o5TBersmWzI0nhG2KJQl/RA1f8Pe4/U
         dy1MQ6Do8srUW8GMDXc4iLBNjBUmkdDsF/P+xesNuZEBCaM2zp1xkpmKMH38MCEfIPjC
         hT1WkDWjGvWbkR4jZBzx5LHI5o9xHnPOfayHvQsO6FZoehQ3ZYyd7K/SK4N867/IU/rV
         nGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gpH5Ipgk0juTpzAPixDWLmXN8kyBd7D95Sw1Iewzjfg=;
        b=mlac+2b9RbwsAQGKsbnErFHaBN2bxSoQ93EprsqaZByHIKZhTkmCA4uhB4yZDuFvHP
         Ko+m2WB8lgi7p6AJRO2djLodFiAEnB5szoDFj9mGZxbXz0QdZLjfnqDmEf2wYgMA2Skc
         fYNHBbxytrFyW26iF7oedLsiuStJgRzEaVdZ2+0fsBuxS4WAF3tZVY6px+eYKBZeQW7H
         qrMnNnqwT1RWohjWe0MZ2U+D7DYEr3vEYrIheAf0/7Xf4YmXqcUIwm3g03NKiLS0Y15x
         ju/mFWF4+NOvEdSSDjKvT1svb0QWukyJbbLla9/nCg3ePxkT2h1XwBQGChyd4GKuF1xk
         /PMg==
X-Gm-Message-State: APjAAAWB8+2JDeL1f824i2t605q+2AwI90iCMSZ/wdkE5/mKi2nWSeKv
        vjhrMVq7CWv5rAzU+fsrP1R158/Z
X-Google-Smtp-Source: APXvYqzSyimhUgSiCkdKCGiD6AcTHBggzedFbnhrAooofpKBUN3SOdCQmtWtU6SFEJC6CfBjvJ1/+g==
X-Received: by 2002:a05:6000:cf:: with SMTP id q15mr973332wrx.393.1580335425501;
        Wed, 29 Jan 2020 14:03:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f189sm4234137wmf.16.2020.01.29.14.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 14:03:44 -0800 (PST)
Message-Id: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jan 2020 22:03:37 +0000
Subject: [PATCH 0/6] Avoid multiple recursive calls for same path in read_directory_recursive()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series builds on en/fill-directory-fixes-more. This series should
be considered an RFC because of the untracked-cache changes (see the last
two commits), for which I'm hoping to get an untracked-cache expert to
comment. This series does provide some modest speedups (see second to last
commit message), and should allow 'git status --ignored' to complete in a
more reasonable timeframe for Martin Melka (see 
https://lore.kernel.org/git/CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com/
)

Elijah Newren (6):
  dir: consolidate treat_path() and treat_one_path()
  dir: fix broken comment
  dir: fix confusion based on variable tense
  dir: move setting of nested_repo next to its actual usage
  dir: replace exponential algorithm with a linear one
  t7063: blindly accept diffs

 dir.c                             | 295 +++++++++++++++++-------------
 t/t7063-status-untracked-cache.sh |  50 ++---
 2 files changed, 191 insertions(+), 154 deletions(-)


base-commit: 0cbb60574e741e8255ba457606c4c90898cfc755
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-700%2Fnewren%2Ffill-directory-exponential-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-700/newren/fill-directory-exponential-v1
Pull-Request: https://github.com/git/git/pull/700
-- 
gitgitgadget
