Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A906DC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 22:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707B72070E
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 22:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMf6Nzww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfKVW7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:59:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54900 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfKVW7c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 17:59:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id x26so8858619wmk.4
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 14:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=g9geY1O+ReyoCwVO1SR7B9HaxO1cT6Fcj+Ixddmw+/g=;
        b=JMf6Nzww1QNQYbw8GKGp36U1EbQ8XiC2MFfMHbcwIMVAbji8WkruBIiHJPSGCHoumI
         zPE4E+rQu7g02Dw/zjDCGCJHxA0Vuf+JREimLsl18tB5yc2n216cNQZrWk6DRyvVGEED
         fcrsCBXoKdZunC5DKvZ+HiFYjeNxQ/MvVgRzf0aC0wZEcB2xw7RYe9t6OP0eyLHKDhvQ
         LIOGzSN5D+B94WFEPyBZuNlizw3nt6hNOnar84ptQHZSfJN+2LOAkbcI9ug9ecEcE46g
         1Dy93Mxkfnt6K3or/mfCQHUeyhhmnymU2+lKqEvUhe2lK5G3LumDmiI0Dr9oSMEGVSzW
         db/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g9geY1O+ReyoCwVO1SR7B9HaxO1cT6Fcj+Ixddmw+/g=;
        b=ebmKcMcIjLkTjGN2DWeY15Vc2OmBuXqYj6lYTodM7sbaE7EFQxPBLorylD0G3it6jv
         xv70fao9YeUsvJGP3YoVQc/0BPAnEotOymjLIt7f4ym1bK84ltT5OP3rmK2R7IZTUfoK
         ycb+HDhbRbGZF77Nz0OM1mVfkgAM2GutXBwKV2DORgkb5C8vTLPwBLuTO5MwTgWVHwey
         CvzBbEFTAWsXbu0C6ppvXeGznLoVGR6C1Ru7mRRdpFT+cTkvJH1go3CknWuVA9FjQyOv
         IPyg1TB2/KQ+xkRXCG1m+tUXEQarwgfleH9uBoGFT0eUR4O8HGBnBoWfsgx/UXBe7JXd
         ouqg==
X-Gm-Message-State: APjAAAV1aNpCfXJ4JbLscoFb6TpiZhnCl7JhxXWJRP8lWDTgAby75/Bm
        ReO7mWXmBYF1UDoPvGnijaSLPTQW
X-Google-Smtp-Source: APXvYqzd3VOzLv7paRfIqrtD5pKDpIX25MTaQ7rOK/HQ33MJbH0h1hp2lvB0AQ58Jf3R7AGk4+1Juw==
X-Received: by 2002:a7b:c34a:: with SMTP id l10mr14762917wmj.66.1574463570427;
        Fri, 22 Nov 2019 14:59:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v184sm563174wme.31.2019.11.22.14.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 14:59:29 -0800 (PST)
Message-Id: <pull.295.git.1574463569.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Nov 2019 22:59:28 +0000
Subject: [PATCH 0/1] git svn: use rebase --rebase-merges instead of preserve-merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By now, git rebase -r is on par with git rebase -p (or better), at least as
far as git svn's usage is concerned. So let's use the former instead of the
(deprecated) latter option.

Johannes Schindelin (1):
  git svn: stop using `rebase --preserve-merges`

 Documentation/git-svn.txt | 3 ++-
 git-svn.perl              | 9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-295%2Fdscho%2Fuse-rebase-r-in-git-svn-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-295/dscho/use-rebase-r-in-git-svn-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/295
-- 
gitgitgadget
