Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB314C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3E720672
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyZ6hDmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfKWUuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:50:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33359 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWUuq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 15:50:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id w9so12810466wrr.0
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 12:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=PegDbpOLNlkPxHrrXCFJJgFvSRb7RrczaU7hgzMEMyE=;
        b=HyZ6hDmX0ySfshVxclI3G8R1OW3jUqALlB6IJHclnU9ENM1hP9BSpOdt9oq9aTDYNk
         h39xbWyBJ/n+TkdowPUCzZGysR9l7RrtgWYzCHuP55Qen3AEIiCo/n884XHOrjsYNNb7
         8mKAnu9tAoU4VbQlzOPrPXUzHJjd3nYADaH26+2x/+0q+Y+yxVr86GKM7oksvQGFWsR+
         IUXPypSG8/mpdqu96TD8dkxCOlwy+jRGvCcSx1UWs70va5cBPuoZTXyImt25NtgJG3nU
         nNYP6B2k0vxGDc1mknIz7stHyn1nLVnRfwJDAHu/3YqZeD/g7og54cZzGLC+v+u9PyUU
         giMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PegDbpOLNlkPxHrrXCFJJgFvSRb7RrczaU7hgzMEMyE=;
        b=UYKtVyIokp0vACZvqB0hJQrHFBMSbMkqYi+8/Xf2vKz3C0+XRlRGTM69NWaxMSZ8+W
         P1B0u42Hgegwla1nughDciLxl7n3wznE8rvpZf5L5lJpMtGfkLQyP13OM56YzxVMMBcS
         HxurNHmjV9VKlxKdZlnYbGEEjATIMLDOK0Axdw04pCR8K8mhVj43bxleE2Ccs98zE/tX
         2/rqG8FInm6QKXyHhtZnD7yidTQUzo4ND352XnuFp+8WBUwpXZxQiS9ge1XFj72/E8LL
         g/mlpKqTBietVGFFqin4Msuho+hXIrbsroa+MgTI6eaWh+Rusb/ORX60neSIn7IlGcuN
         xIbA==
X-Gm-Message-State: APjAAAWURNbJqo5H9mbjCIbVLOOL3UxgSh2+9FETXxJz8QVZnoKGgGxc
        YgKLTMm5IFJNaodRAtLzQg2dNYfM
X-Google-Smtp-Source: APXvYqwAdDr55IuACKxVSfQ83PJ+Bvxl/2Hm0qyuxat22Avp5CtHSYdjVcTM9Viq3LlB37CM/984UQ==
X-Received: by 2002:a5d:5224:: with SMTP id i4mr23765944wra.303.1574542244273;
        Sat, 23 Nov 2019 12:50:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10sm3468101wrx.30.2019.11.23.12.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 12:50:43 -0800 (PST)
Message-Id: <pull.195.git.1574542242.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 20:50:34 +0000
Subject: [PATCH 0/8] Drop support for git rebase --preserve-merges
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

In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (which was
included in v2.22.0), we officially deprecated the --preserve-merges 
backend. This patch series drops that deprecated backend. Maybe we want to
make that happen around v2.26.0?

Note: this patch series is based on js/git-svn-use-rebase-merges

Johannes Schindelin (8):
  t5520: do not use `pull.rebase=preserve`
  remote: warn about unhandled branch.<name>.rebase values
  tests: stop testing `git rebase --preserve-merges`
  pull: remove support for `--rebase=preserve`
  rebase: drop support for `--preserve-merges`
  git-svn: drop support for `--preserve-merges`
  rebase: drop the internal `rebase--interactive` command
  remote: no longer claim that branch.*.rebase=preserve is a thing

 .gitignore                                |    1 -
 Documentation/config/branch.txt           |    4 -
 Documentation/config/pull.txt             |    4 -
 Documentation/git-pull.txt                |    6 +-
 Documentation/git-rebase.txt              |   47 -
 Documentation/git-svn.txt                 |    1 -
 Makefile                                  |    2 -
 azure-pipelines.yml                       |    2 -
 builtin/pull.c                            |   12 +-
 builtin/rebase.c                          |  316 +-----
 builtin/remote.c                          |    5 +-
 contrib/completion/git-completion.bash    |    2 +-
 git-rebase--preserve-merges.sh            | 1067 ---------------------
 git-svn.perl                              |    1 -
 git.c                                     |    1 -
 t/t3404-rebase-interactive.sh             |   76 --
 t/t3408-rebase-multi-line.sh              |   10 -
 t/t3409-rebase-preserve-merges.sh         |  127 ---
 t/t3410-rebase-preserve-dropped-merges.sh |   90 --
 t/t3411-rebase-preserve-around-merges.sh  |   80 --
 t/t3412-rebase-root.sh                    |   37 -
 t/t3414-rebase-preserve-onto.sh           |   85 --
 t/t3418-rebase-continue.sh                |   15 -
 t/t3421-rebase-topology-linear.sh         |   19 -
 t/t3422-rebase-incompatible-options.sh    |   11 -
 t/t3425-rebase-topology-merges.sh         |  151 ---
 t/t3427-rebase-subtree.sh                 |   19 -
 t/t5520-pull.sh                           |   24 +-
 t/t7505-prepare-commit-msg-hook.sh        |    1 -
 t/t7517-per-repo-email.sh                 |   13 -
 t/test-lib.sh                             |    4 -
 31 files changed, 17 insertions(+), 2216 deletions(-)
 delete mode 100644 git-rebase--preserve-merges.sh
 delete mode 100755 t/t3409-rebase-preserve-merges.sh
 delete mode 100755 t/t3410-rebase-preserve-dropped-merges.sh
 delete mode 100755 t/t3411-rebase-preserve-around-merges.sh
 delete mode 100755 t/t3414-rebase-preserve-onto.sh


base-commit: ea8b7be1476a2301e3658a8e626b69c9d7f540bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-195%2Fdscho%2Fdrop-rebase-p-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-195/dscho/drop-rebase-p-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/195
-- 
gitgitgadget
