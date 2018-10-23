Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49781F453
	for <e@80x24.org>; Tue, 23 Oct 2018 19:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeJXEWI (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 00:22:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36748 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJXEWI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 00:22:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id l81-v6so1214214pfg.3
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 12:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=J8hMrAyECB+foEXUXlCuxpKI5ZBh1BT3gtJCYmZSiXY=;
        b=o6loPfMqf3rQne2IM+/dA8V8VNPiimPEa4/F79v66gYLDVm4sXgTWRzYRtFH9rlDej
         xDd994rRwhuvVlwF8mPwWrol1ceiQYeSJmxIPIKWAEt9qApzdNhP09hoDlciV8M83xed
         lmErS/nCyMRPdCaiIPLD4i+iIHEGvzdTNj1OD7vnKFgejQWuPE62IIFjYW/QyHrMe92y
         wBEZ1Uffphy9EdPHZnmBwVIpeRh0md0mGwoER9/ntVtjhdXyQQFF8yETKCZO/O93Wzz7
         /3KyJuohpRhsQhDszZ/UzMdPXqGSnu/mHhQIbZ34WpL3RN2z8XbrCDGW2DvNKcEkP2Tn
         FmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J8hMrAyECB+foEXUXlCuxpKI5ZBh1BT3gtJCYmZSiXY=;
        b=NX/OoXiZZRPp3sICkiUJTOXskh6muth1zKcvHGkXQPtG/+iQjWOdF7E56RXC7/tzz8
         cyYdMCi5zmBHmfqkTNKlyPZ5cxgyLxMUaL9qp85mvZQzIxvq7fxOIGWodDVz5pDhE+M7
         3NkbWKQ7KY+YeLF8a/eh/s00ZPTm/CEK/srLQ/48B1rNKwJFd7KqJQ4Xh+S59ALt1Zeg
         3K8rMB83dc8OuMWI/ferJvVTCLrcYkPw6CQbAi9OQq1GXn6KDUviedSOoaR03z/kfXNk
         WKyF+RVxtC8KmIvgQdQw2MRQufoxQlPMun7OklCuJ9JVpu4VN10v1cFCN1Drjjz16R5e
         k5lg==
X-Gm-Message-State: ABuFfojjFg9EQBx5oyYEj+jPueghB+aU2mmxLNwx9J33Lq3rvuOlrx5m
        vikT52yKLTkmPGPddjb9UuqH1Rm4
X-Google-Smtp-Source: ACcGV63M3I1oqg4yAjI9/VVqGP/jUUSI5Ed5iCeiuW4fRe+NpfQFfceicN7MjPPFeZdDgIz1Iu4CTg==
X-Received: by 2002:a63:e141:: with SMTP id h1-v6mr48223361pgk.47.1540324635478;
        Tue, 23 Oct 2018 12:57:15 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id y7-v6sm2772671pfl.57.2018.10.23.12.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:57:14 -0700 (PDT)
Date:   Tue, 23 Oct 2018 12:57:14 -0700 (PDT)
X-Google-Original-Date: Tue, 23 Oct 2018 19:57:10 GMT
Message-Id: <pull.56.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Demonstrate and fix a rebase --autostash bug with dirty submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This bug report came in via Git for Windows (already with version 2.19.0,
but I misread the reporter's enthusiasm to take matters into his own hands).

The culprit is, in a nutshell, that the built-in rebase tries to run git
stash only when the worktree is dirty, but it includes submodules in that.
However, git stash cannot do anything about submodules, and if the only
changes are in submodules, then it won't even give us back an OID, and the
built-in rebase acts surprised.

The solution is easy: simply exclude the submodules from the question
whether the worktree is dirty.

What is surprisingly not simple is to get the regression test right. For
that reason, and because I firmly believe that it is easier to verify a fix
for a regression when the regression test is introduced separately (i.e.
making it simple to verify that there is a regression), I really want to
keep the first patch separate from the second one.

Since this bug concerns the built-in rebase, I based the patches on top of 
next.

Johannes Schindelin (2):
  rebase --autostash: demonstrate a problem with dirty submodules
  rebase --autostash: fix issue with dirty submodules

 builtin/rebase.c            |  2 +-
 t/t3420-rebase-autostash.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)


base-commit: 209f214ca4ae4e301fc32e59ab26f937082f3ea3
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-56%2Fdscho%2Ffix-built-in-rebase-autostash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-56/dscho/fix-built-in-rebase-autostash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/56
-- 
gitgitgadget
