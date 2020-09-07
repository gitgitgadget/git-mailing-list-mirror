Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B6BC43461
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 00:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A3C2078E
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 00:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvgLtIXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIGADe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 20:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgIGADb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 20:03:31 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57217C061574
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 17:03:30 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t16so11000189ilf.13
        for <git@vger.kernel.org>; Sun, 06 Sep 2020 17:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pJp0EM0EB2KlF8SHxxM+5Ic4eNjv9290QoxdxDloOPg=;
        b=uvgLtIXJY3QN7yA0THVQxvgz+6WWGnEnDQAS9b4kfaAK1AJDFsfn+w+dUZ459v3N5F
         ivv3SzWEayi+rSXRN4+M4diR2z2c6Tl9LBLRoeC9iul0k6SaMRBfJm4Lh859Z8IYiQbh
         JQxDjyKjaBaE+8pYScxuHtDpF87CRNMbJPGBlPnf8CFFp5Z+PSykmAtdPoKGoGpflQkr
         BEDSueS20/U1x7NDL56tmbc3QwIcp1VrZAkPXz6CWW/27ARPm0veS7K7g3dfe7tJV51R
         OXjObx0c0ZjAnUnce5yP/Vzul8izR6BG9g84WmKjuRzKuK9XKxKhHWk9dUPZiR8erYiL
         ApBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pJp0EM0EB2KlF8SHxxM+5Ic4eNjv9290QoxdxDloOPg=;
        b=PAtgzhhoObUOegBXwBSWFNmLIKUS+m1XzHY4hYalrVxDf8apwUFHKCI9dmtOoUPkGC
         cp7Zs6D4SlV1KWVG68DlDyM8iNPJ/3UPdKo/DkkIkBXUOXOjhofDizUzIZuHD8/Km4RH
         Vnsr++r4pJ7pf2z5QhJyAn9vSxBUlrlwxq1riiotjUrzMwS6xLcicV9+jmzuwSCrHwCE
         BiS+85UIQYvRfj4zvI5QvWJNCMYBJ7M/mdzES+dmlt0j6H/UfLPnj43zpSPbJe46dnrK
         hv5JPP2fAurTSMKKy96CH5HdlehOEAEXSXDMxQcwrzx/RCKg2OIJIANXbjxXQdvqLlim
         fmBw==
X-Gm-Message-State: AOAM532eT2rC7sBtsvNl6c5cBFjjbq5cxMAqix/KbP9oEuPVOPuFhrDM
        HZ3AWE1hMq3/BKCmkCFytnr+WS0mlms=
X-Google-Smtp-Source: ABdhPJyY12Egkt++i2uOVo8zVjvL/zqFZ2xXbJCFPxen/BK8JHrEBl/XW8FqURPwvtZxFuqpjn8OZg==
X-Received: by 2002:a92:9a92:: with SMTP id c18mr17407351ill.265.1599437002484;
        Sun, 06 Sep 2020 17:03:22 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e22sm6381664ioc.43.2020.09.06.17.03.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Sep 2020 17:03:21 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/3] worktree: teach `add` -d for --detach & improve documentation
Date:   Sun,  6 Sep 2020 20:02:19 -0400
Message-Id: <20200907000222.4717-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <20200904070703.47898-1-sunshine@sunshineco.com>
References: <20200904070703.47898-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of [1] which brings `git worktree add` in line with
the other "checkout a branch" commands `git switch` and `git checkout`
by teaching it -d as shorthand for --detach (which those other commands
already understand). It also enhances `git worktree` documentation to
emphasize that `git worktree add <path>` creates a new branch by
default, and to discuss branch-based vs. throwaway worktrees, which may
help newcomers avoid creating branches without realizing they are doing
so, and later wondering why `git branch --list` shows branches they did
not intentionally create.

v2 adjusts the commit message of [2/3] to make it clearer[2] that it
teaches `git worktree add` (not `git worktree`, in general) to
recognized -d as shorthand for --detach.

[1]: https://lore.kernel.org/git/20200904070703.47898-1-sunshine@sunshineco.com/T/
[2]: https://lore.kernel.org/git/xmqqlfhm36v2.fsf@gitster.c.googlers.com/

Eric Sunshine (3):
  git-checkout.txt: document -d short option for --detach
  worktree: teach `add` to recognize -d as shorthand for --detach
  git-worktree.txt: discuss branch-based vs. throwaway worktrees

 Documentation/git-checkout.txt |  1 +
 Documentation/git-worktree.txt | 13 +++++++++++++
 builtin/worktree.c             |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  61ac1d5e14 ! 1:  538aaaf72d git-checkout.txt: document -d short option for --detach
    @@ Metadata
      ## Commit message ##
         git-checkout.txt: document -d short option for --detach
     
    -    git-checkout learned -d as short option for --detach in 163e3b2975
    +    `git checkout` learned -d as short option for --detach in 163e3b2975
         (switch: add short option for --detach, 2019-03-29) but the
         documentation was never updated to reflect the change.
     
2:  4f43ff6ddc ! 2:  49b3b3795d worktree: add -d short option for --detach
    @@ Metadata
     Author: Eric Sunshine <sunshine@sunshineco.com>
     
      ## Commit message ##
    -    worktree: add -d short option for --detach
    +    worktree: teach `add` to recognize -d as shorthand for --detach
     
    -    Like git-switch and git-checkout, git-worktree can check out a branch or
    -    set up a detached HEAD. However, unlike git-switch and git-checkout,
    -    git-worktree does not understand -d as shorthand for --detach, which may
    -    confound users accustomed to using -d for this purpose. Address this
    -    shortcoming by adding -d as shorthand for --detach in order to bring
    -    git-worktree in line with the other commands.
    +    Like `git switch` and `git checkout`, `git worktree add` can check out a
    +    branch or set up a detached HEAD. However, unlike those other commands,
    +    `git worktree add` does not understand -d as shorthand for --detach,
    +    which may confound users accustomed to using -d for this purpose.
    +    Address this shortcoming by teaching `add` to recognize -d for --detach,
    +    thus bringing it in line with the other commands.
     
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
     
3:  628a7b7bb0 ! 3:  e5de1aaf18 git-worktree.txt: discuss branch-based vs. throwaway worktrees
    @@ Metadata
      ## Commit message ##
         git-worktree.txt: discuss branch-based vs. throwaway worktrees
     
    -    By default, "git worktree add" creates a new worktree associated with a
    +    By default, `git worktree add` creates a new worktree associated with a
         particular branch (which may have been created automatically if not
         specified explicitly on the command-line). It is also convenient to
         create throwaway worktrees not associated with any branch, which can be
    @@ Commit message
         and throwaway worktrees is to help newcomers understand that the
         simplest form `git worktree add <path>` automatically creates a new
         branch. Stating this early in the description, may help newcomers avoid
    -    creating unwanted new branches without being aware that they are doing
    -    so, and later wondering why `git branch --list` shows branches the user
    -    did not intentionally create.
    +    creating branches without realizing they are doing so, and later
    +    wondering why `git branch --list` shows branches the user did not
    +    intentionally create.
     
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
     
-- 
2.28.0.618.gf4bc123cb7

