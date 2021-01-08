Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC09AC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6230423383
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbhAHJZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbhAHJZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 04:25:37 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055DDC0612F4
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 01:24:57 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id r4so5349064pls.11
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 01:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vs9Pv7nZ8gsiaDTofxmQS4pqFdm6TIVv8kgEG+RP+2A=;
        b=Db2loXkvQP68F22ZylK2OrExDf15X8EkbQyS2mEo0UkAGrsmUOJ8m2Zjn3JOkXF2EW
         Jhc3VNhKQptI9MeSRKtaNbm1zA8X+su1SW3uOGoYOPB8kL+KwzmPfDGJzi1cAHX1mw/G
         EtPPSlB7d5Nk1QeEyUtlD3g3T6D2lTipKftUjgWtVClIlf6TRiN4+tg9dOAGjxBXA8zC
         ktSZXLfLPKAuj2pkjfcfys7XdcuZ2TroY2T8NdQ54i3OX54Js3E/CMHvSvftxETsqyal
         R/fcLfXL8dZp3LTeHk0qN1yX4QaYDogt/whMvSVUGxqBFw5a86b9/Lj1VhAvS3epyhU6
         WF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vs9Pv7nZ8gsiaDTofxmQS4pqFdm6TIVv8kgEG+RP+2A=;
        b=d9pNgZSdjTYzEonTfxJnHZQSFX9VKakMPyLCPE400xWqdPiZ1PoMUwJHmfzL1+vVle
         wgja4f2ZOcsoLY95RXlM/gPgd1UwjkE3vrTuMRQg4lR3pG57y70M+eYAyGlynJwVS/dz
         QhE728tDfFR/Q/qocYEkUT1d37gDB3GJySdLbWzLWhgz6EyNh0TYbVg6IUOhS9WONUjg
         9RUPSochtTyOCnSiKoNSfjl2KKj+8luKJM8hnJDpu+NcDGFaKutJ1rDL4V+CbRHxuiCS
         nYL7TfdwAfuEz44s4Dt6AdoFLG7wDAx8jRla8ks7+ALFO65OEw1HDwYxfmh3CEpjVlCC
         DY8A==
X-Gm-Message-State: AOAM531ejpY+JutKEBuYWmlzbAQz0y34CvgFPhS6tQGMLSJC7nPaH0Xn
        qNHDLFmq9cLps+34sRe/9jYmwPCnAj3yFQ==
X-Google-Smtp-Source: ABdhPJwtCgJB4BtKAP0tjbXa0M2kJtBsOSm7zniPK/xv7exogGD6/aRrAEz0L0h4iJxOerIWPU2HSA==
X-Received: by 2002:a17:90a:fb8a:: with SMTP id cp10mr2842919pjb.136.1610097896301;
        Fri, 08 Jan 2021 01:24:56 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:e06:7e2e:2d21:e266:30b:8fc])
        by smtp.googlemail.com with ESMTPSA id 6sm8384234pfj.216.2021.01.08.01.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 01:24:55 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood@dunelm.org.uk,
        Johannes.Schindelin@gmx.de, Charvi Mendiratta <charvi077@gmail.com>
Subject: [RFC PATCH 0/9][Outreachy] rebase -i: add options to fixup command
Date:   Fri,  8 Jan 2021 14:53:37 +0530
Message-Id: <20210108092345.2178-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

This patch series adds fixup [-C|-c] options to interactive rebase. In
addition to amending the contents of the commit as the `fixup` command
does now, `fixup -C` replaces the commit message of the original commit
which we are fixing up with the message of the fixup commit.
And to edit the fixup commit message before committing, `fixup -c`
command is used instead of `fixup -C`. This convention is similar to
the existing `merge` command in the interactive rebase, that also supports
`-c` and `-C` options with similar meanings.

This patch series also changes `rebase -i --autosquash` to rearrange
commits whose message starts with "amend!" and replaces the pick
command with `fixup -C`. The creation of "amend!" commits will be
rebase -i: add options to fixup command added in another patch series.

This is done in reference to the issue opened by Dscho as here[1] and
further discussed briefly[2]. Also, there is discussion[3] regarding the
implementation of reword! commit. The past patches of Phillip Wood’s
work[4], implements 'reword!' as 'amend!' in git rebase and these patches
uses those as the initial base.
And to avoid the extra command in the interactive rebase, this patch
series instead add options to the current fixup command in interactive
rebase (fixup [-C | -c]) as discussed earlier[5].

Looking forward for the reviews.

Thanks and Regards,
Charvi

P.S - I thanks Christian and Phillip for mentoring in this project and
happy to work in community.

[1] https://github.com/gitgitgadget/git/issues/259
[2] https://public-inbox.org/git/alpine.DEB.2.21.1.1710151754070.40514@virtualbox/
[3] https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com/
[4] https://github.com/phillipwood/git/commits/wip/rebase-amend
[5] https://lore.kernel.org/git/29fc2f59-1cca-a3db-5586-bbd7b2e4806d@gmail.com/

Charvi Mendiratta (6):
  sequencer: pass todo_item to do_pick_commit()
  sequencer: use const variable for commit message comments
  rebase -i: add fixup [-C | -c] command
  t3437: test script for fixup [-C|-c] options in interactive rebase
  rebase -i: teach --autosquash to work with amend!
  doc/git-rebase: add documentation for fixup [-C|-c] options

Phillip Wood (3):
  rebase -i: only write fixup-message when it's needed
  sequencer: factor out code to append squash message
  rebase -i: comment out squash!/fixup! subjects from squash message

 Documentation/git-rebase.txt    |  12 +-
 rebase-interactive.c            |   4 +-
 sequencer.c                     | 307 +++++++++++++++++++++++++++-----
 t/lib-rebase.sh                 |   4 +
 t/t3415-rebase-autosquash.sh    |  27 ++-
 t/t3437-rebase-fixup-options.sh | 202 +++++++++++++++++++++
 t/t3437/expected-squash-message |  51 ++++++
 t/t3900-i18n-commit.sh          |   4 -
 8 files changed, 549 insertions(+), 62 deletions(-)
 create mode 100755 t/t3437-rebase-fixup-options.sh
 create mode 100644 t/t3437/expected-squash-message

--
2.29.0.rc1

