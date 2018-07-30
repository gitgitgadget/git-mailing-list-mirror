Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A88A1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 16:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbeG3SFV (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 14:05:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39197 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeG3SFU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 14:05:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so4386182edi.6
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+g1VtwbNS5rnF2mPqRJdvKYzVc5tmymtm6sjVm1uqVg=;
        b=EDwbo3MtCoLLD+YeuRU7vKtI+h770m7cBvjH5wpptHt0cjxaxrfN1s9ooC6Qav1y6s
         tAYWPTmjuaHqInDmi4w6bfj8cqXwgr3QbYdxqJJP2c7nwAKcbJeOcx1xYXL9X+3HxJx/
         zMzDXFlYhcx9rc5uVxUY51264U13dLvHZcrxsGoLS7wmtJVjmejKUOO8u1Uh46bysmOK
         vKPxHF/d4j2zzPTnnko7wQ3cKT+Vfv/gV1yUOK5f8Eh9IM4xB28xj7B5YRW8/08VwjqY
         BemtuxhlSWbRitUI8Ew3WjdawhOvDeSsL+y+nPDzEOotbJNrxe7U0vm+s3IwptUmCPHz
         UxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+g1VtwbNS5rnF2mPqRJdvKYzVc5tmymtm6sjVm1uqVg=;
        b=eAT9di3eSuJw3G1aXTWlyIUSDt6mnNxS7zN5sGZVM8XG0ao4vx+lVzLLrZTdrJbBgi
         gNn/dwjj884ZHmOadPhfDQ+R+orBwtJFSIqpFGB7W2ThpnRPWy2eECNmdPKqyEiLBpsL
         XA10zbBune4+QgYyBexYVTwLqpH+GxWLT/4krpqK+WEtWpmwTd9ZLADhZMhpdS19lXWO
         4tX7CJ+Xyx4DdCihO5Od7jJQoADx1z7/17ZrUZlN5havqWSfu+AJdDeTiMUGz75B45GU
         oXFSNyodmdQ+jQXK1TrH1LTgxSq7bOrUxhI6+2ZZ9lc58bKxs+yiJyuG94j71gxxtVSX
         Ywpw==
X-Gm-Message-State: AOUpUlGf4FIBrCIvKWqh2Qqauv9x/wbErW4HketI4WVMV2S5kaJLv33c
        FBXO2painRkzNvgUp+SA8SGSNbmr
X-Google-Smtp-Source: AAOMgpd6qtoY36nYzONZuPbcjIfvVaRBdE1/tsjmRDGqF4aU1hiHYNtggrPYpy7oBaw5j3VYqgNuQQ==
X-Received: by 2002:a50:eacb:: with SMTP id u11-v6mr8999776edp.7.1532968173677;
        Mon, 30 Jul 2018 09:29:33 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.81])
        by smtp.gmail.com with ESMTPSA id a13-v6sm2880906edf.84.2018.07.30.09.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 09:29:33 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        rybak.a.v@gmail.com, dev+git@drbeat.li, pclouds@gmail.com,
        sunshine@sunshineco.com, Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH v5 0/3] rebase: rewrite rebase in C
Date:   Mon, 30 Jul 2018 22:14:17 +0545
Message-Id: <20180730162920.20318-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708180104.17921-1-predatoramigo@gmail.com>
References: <20180708180104.17921-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a GSoC project, I have been working on the builtin rebase.

The motivation behind the rewrite of rebase i.e. from shell script to C
are for following reasons:

1.  Writing shell scripts and getting it to production is much faster
    than doing the equivalent in C but lacks in performance and extra
    workarounds are needed for non-POSIX platforms.

2.  Git for Windows is at loss as the installer size increases due to
    addition of extra dependencies for the shell scripts which are usually
    available in POSIX compliant platforms.

This series of patches serves to demonstrate a minimal builtin rebase
which supports running `git rebase <upstream>` and also serves to ask for
reviews.

Changes since v4:

  -  Remove the `do_reset()` refactored function from sequencer.
     In other words `sequencer: refactor the code to detach HEAD to checkout.c`
     patch was dropped to introduce a new function `reset_hard()` for `rebase.c`
     (as suggested by Johannes).

  -  Fix a case of leak in `rebase: start implementing it as a builtin`.
     (as pointed out by Andrei Rybak and Eric Sunshine).

  -  Wrap the user visible comments in `_()` and used `BUG()` depending on the
     scenarios (as pointed out by Duy Nguyen).

  -  Fix the macro `GIT_PATH_FUNC` which expands to function definition and
     doesn't require semicolons (as pointed out by Beat Bolli).

Pratik Karki (3):
  rebase: start implementing it as a builtin
  rebase: refactor common shell functions into their own file
  builtin/rebase: support running "git rebase <upstream>"

 .gitignore                            |   2 +
 Makefile                              |   4 +-
 builtin.h                             |   1 +
 builtin/rebase.c                      | 406 ++++++++++++++++++++++++++
 git-rebase.sh => git-legacy-rebase.sh |  69 +----
 git-rebase--common.sh                 |  68 +++++
 git.c                                 |   6 +
 7 files changed, 488 insertions(+), 68 deletions(-)
 create mode 100644 builtin/rebase.c
 rename git-rebase.sh => git-legacy-rebase.sh (90%)
 create mode 100644 git-rebase--common.sh

-- 
2.18.0

