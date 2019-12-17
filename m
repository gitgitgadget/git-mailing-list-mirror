Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A40C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CA92072D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMvlqvIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfLQKlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:41:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33894 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfLQKlI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 05:41:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so10756820wrr.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 02:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=nXTBXfqQtloih21f81vhRjfaEf6eI3zhvmVaDoxuxpo=;
        b=FMvlqvIpoTHZB+Sh1YPKELi9CsDj6r675O8+4p6XKvkz94IXdH0GQW3zbOJW0Rhb/m
         SW9pkmMJnoFdkTF39AyDPt69Yp7l3jLlXY1x7z7iwa7h6dAaL6/iZlGoKk7idwkT2KOR
         AYt0CP7tfaEDgyOcrzuj7JYDoujL5TbShhXh14xxNl2JfrcP4BquP3+dgWsexs10d1sL
         pgBrS8gjoKfVZcXy+9lO/+H+4SeMJURY3IEMxsxjkFx6J6XeKMUzD0l3+u5ArfA2StXx
         wbQg/Fr4xTeh7h/AmTsmH8QnxOXvII1abyaa0HXvV2pIGmgaLlNAON6HA6ZRHWdKyP4K
         KxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nXTBXfqQtloih21f81vhRjfaEf6eI3zhvmVaDoxuxpo=;
        b=nqYZXul8F8oGkR4eu3w/JdM1oYGghy1XHcsB9CBAzteDaOnq2uHr+ySynrstrZ91GZ
         dwke/pFhg8i4uE93bF8SoGtmOZ7RP+gT6L/7kG+Yo1hxwFfZwlcGDDMdsUCAXgshtiHj
         L8La4tSzOQp5WgPZiQ5nw1Q0fI9cvm2Tbhv+MALVp7PUqIUWBq0VnNZEq5BeVUlqQ88l
         hKV9Dg+WQfUNJa2YYapJo7mQp39d2OhZvmkhjbZ5iPw71sK+JkRWv7xVOutBqy2b67aE
         XJhqkCx/WB4wuxLrBc/SjOj+oAr41KAQNdHgcxy6uJXTkJkV/fS8E0tRZ4s9DNd29XCf
         WUsA==
X-Gm-Message-State: APjAAAXS2mFbUCZG7ynBCcrshn4Pf414sEsNRmU1+hrwad2+wzGCFT2l
        40yzoRIBLJ2ACLTGU6XyS8MzrNpN
X-Google-Smtp-Source: APXvYqwF1dvBepob+/rWBo0kk8ad5XZiVAU91FduExgAUyr2HhT0mwbclbeKzmQHy2jbtuD5uGt4wg==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr34960487wru.52.1576579266253;
        Tue, 17 Dec 2019 02:41:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm2516296wmc.8.2019.12.17.02.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 02:41:05 -0800 (PST)
Message-Id: <pull.174.git.1576579264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 10:40:57 +0000
Subject: [PATCH 0/7] stash/reset/checkout -p: optionally use the add --patch backend written in
 pure C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At this stage on the journey to a fully built-in git add, we already have
everything we need, including the --interactive and --patch options, as long
as the add.interactive.useBuiltin setting is set to true. This config
setting is kind of a feature flag that is currently turned off by default,
and will be for a while, until we get confident enough that the built-in
version does the job, and retire the Perl script.

However, the internal add--interactive helper is also used to back the 
--patch option of git stash, git reset, git checkout and git worktree.

This patch series (based on js/add-p-in-c) brings them "online".

Johannes Schindelin (7):
  built-in add -p: prepare for patch modes other than "stage"
  built-in add -p: implement the "stash" and "reset" patch modes
  legacy stash -p: respect the add.interactive.usebuiltin setting
  built-in stash: use the built-in `git add -p` if so configured
  built-in add -p: implement the "checkout" patch modes
  built-in add -p: implement the "worktree" patch modes
  commit --interactive: make it work with the built-in `add -i`

 add-interactive.c   |   2 +-
 add-interactive.h   |  12 +-
 add-patch.c         | 353 ++++++++++++++++++++++++++++++++++++++++----
 builtin/add.c       |  35 ++++-
 builtin/commit.c    |   8 +-
 builtin/stash.c     |  25 ++--
 git-legacy-stash.sh |   2 +-
 7 files changed, 388 insertions(+), 49 deletions(-)


base-commit: 2e4083198d1508206488af4c82093ceb6cf20f4e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-174%2Fdscho%2Fother-command-p-in-c-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-174/dscho/other-command-p-in-c-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/174
-- 
gitgitgadget
