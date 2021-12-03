Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7863C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 07:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350594AbhLCHFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345605AbhLCHFR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 02:05:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D91C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 23:01:53 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u1so3587201wru.13
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 23:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=IXiVw866U2II27Wp3ZDxjRCRx0pMTBY1ToYlSOE/2gY=;
        b=AG1vKY4kbMOK9uhkpyETYwutJyI1jegSCoEvygIHJIpKDhh0LALGJGqmtfgWI+cMKB
         hbpmHhHGdG/m4c4xPrpYdbSQ8H+8997d1Q1k6+wzPwNA1HwB71EYGONPv52sYO4euBZF
         mJmguqbHmsGmvVKYnzXidlSRidaNoeBzezL3vwnraiQcC+Ay1LXKsgTekXNU7wQ1rHNf
         yLKpftm3hQDgt6qFHuBWwlzF1ggxMbW8ESCSgSN/WAycZG0EBWV+fCusgeTgha1LOmac
         FI911xBUBeEvHjIynDLBxXCM0kyR0v0W+S54fQFkEzFWFYKj57usJEpUjqP98XQM65lv
         nm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=IXiVw866U2II27Wp3ZDxjRCRx0pMTBY1ToYlSOE/2gY=;
        b=rGmicgQS0uEN3CPtTSfP5DftfmduEbZW6aClvSEofCmpFOF4gG+Lf4cjVmOR+I3WQy
         QGZcZ4mwYhktwqg7d4I6IuspAkl6JnKOKqo24hdEc7uVfhRiMQ3dL2Xf5ogyf7tanqCl
         D+Nb5MawNLszBH6k931YdcXTs14ohoQTQj9W1GG4SM/iQwKCkgvOPO5R8mo9W9pvMeq/
         SxGiPQ18gGQjH9yhCD9pBscJ8+XONxibv/TVGR3t5LC2NrykJNXaMEa91uEgUs+uwdkB
         Xodjh/YmBjCQssq1BR4bFygNPABycZ+DlYnvDSSWxcE0PQ2dWqJHqM4Swr/8ldYBqaxP
         eDeQ==
X-Gm-Message-State: AOAM532Nw0zk2OPv1dm0AGXH6yjQYgGGaR05RMOUCVqZgc4b5szz38C5
        V7va/IOFLNDuQev7d7QTEVyGfrUEvek=
X-Google-Smtp-Source: ABdhPJyrBzTrP02aSXSzBly3Fn3DjseQkG3WteqRieztKIY438b/GkU1UabG4qKZofSqtyD/eocAsg==
X-Received: by 2002:adf:e0c7:: with SMTP id m7mr20041304wri.530.1638514912237;
        Thu, 02 Dec 2021 23:01:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w2sm1781767wrn.67.2021.12.02.23.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 23:01:51 -0800 (PST)
Message-Id: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 07:01:39 +0000
Subject: [PATCH 00/10] Factorization of messages with similar meaning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a meager attempt at rationalizing a small fraction of the
internationalized messages. Sorry in advance for the dull task of reviewing
these insipide patches.

Doing so has some positive effects:

 * non-translatable constant strings are kept out of the way for translators
 * messages with identical meaning are built identically
 * the total number of messages to translate is decreased.

I'm inclined to even go a step further and turn these messages into #define
or const strings. This would have the added benefits:

 * make sure that the messages to translate are identical
 * create a library of message skeletons to be picked up when new messages
   are needed

What do you think?

Jean-Noël Avila (10):
  i18n: refactor "foo and bar are mutually exclusive"
  i18n: refactor "%s, %s and %s are mutually exclusive"
  i18n: turn "options are incompatible" into "are mutually exclusive"
  i18n: standardize "cannot open" and "cannot read"
  i18n: tag.c factorize i18n strings
  i18n: factorize "--foo requires --bar" and the like
  i18n: factorize "no directory given for --foo"
  i18n: refactor "unrecognized %(foo) argument" strings
  i18n: factorize "--foo outside a repository"
  i18n: ref-filter: factorize "%(foo) atom used without %(bar) atom"

 apply.c                           |  8 ++++----
 archive.c                         |  8 ++++----
 builtin/add.c                     | 12 ++++++------
 builtin/branch.c                  |  2 +-
 builtin/checkout.c                |  8 ++++----
 builtin/clone.c                   |  2 +-
 builtin/commit.c                  |  6 +++---
 builtin/describe.c                |  2 +-
 builtin/diff-tree.c               |  2 +-
 builtin/difftool.c                |  4 ++--
 builtin/fast-export.c             |  4 ++--
 builtin/fetch.c                   |  6 +++---
 builtin/index-pack.c              |  4 ++--
 builtin/init-db.c                 |  2 +-
 builtin/log.c                     |  8 ++++----
 builtin/pack-objects.c            |  2 +-
 builtin/push.c                    |  8 ++++----
 builtin/repack.c                  |  4 ++--
 builtin/reset.c                   |  8 ++++----
 builtin/rm.c                      |  2 +-
 builtin/stash.c                   |  4 ++--
 builtin/submodule--helper.c       |  4 ++--
 builtin/tag.c                     | 10 +++++-----
 builtin/worktree.c                |  6 +++---
 diff.c                            |  2 +-
 fetch-pack.c                      |  2 +-
 git.c                             |  6 +++---
 http-fetch.c                      |  4 ++--
 range-diff.c                      |  2 +-
 ref-filter.c                      | 20 ++++++++++----------
 revision.c                        | 22 +++++++++++-----------
 t/t2026-checkout-pathspec-file.sh |  4 ++--
 t/t2072-restore-pathspec-file.sh  |  2 +-
 t/t3704-add-pathspec-file.sh      |  6 +++---
 t/t3909-stash-pathspec-file.sh    |  2 +-
 t/t5606-clone-options.sh          |  2 +-
 t/t7107-reset-pathspec-file.sh    |  2 +-
 t/t7526-commit-pathspec-file.sh   |  4 ++--
 38 files changed, 103 insertions(+), 103 deletions(-)


base-commit: 35151cf0720460a897cde9b8039af364743240e7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1088%2Fjnavila%2Fi18n-refactor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1088/jnavila/i18n-refactor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1088
-- 
gitgitgadget
