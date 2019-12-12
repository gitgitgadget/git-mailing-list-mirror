Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F089AC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D0621655
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZACrQEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfLLOg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54796 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbfLLOg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so2612442wmj.4
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=91RcYvNjwbODoBD6ec9CSUDcz3DRZle1W2EWvAFVIG8=;
        b=mZACrQEUY+MRahYSmfBDSArpqsJpPlK4fme+ov9N905tEh3iKo26a6HFwPLFYi9qDm
         EkhLB+4VB2Yjkkc2ZIGXknefoRcZFHjAWgTaNAxG8jBaD6C0FbBvPJzrg1qBrSq8mxtL
         7D+6vms+nojHkgIPneQRop+50utxeOUDsfoWk8/cPQi4Hkdi9+3qz+1x1aLa5Ak/GJYS
         2oTQ+c3aqUodKQhBhR+Jd7WVVUOeEPiTaMb28fu7bliANoWN5El0/u+D7/B3zS6mls7B
         YcYylLJ9epS1lH8cvWTjlz4bD+c4TNv/MiZaS++PzpIlnukjqMNv2pPCDP8sMcrRcn3H
         59Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=91RcYvNjwbODoBD6ec9CSUDcz3DRZle1W2EWvAFVIG8=;
        b=LE4RTIF9FQYUaWC56o2VimmpeqYI2xvC0fQG82JdqgtTxNT2agmcCg3EeA9kBWJAaA
         ul0UGHk1mCuV5JguHCCoelTe+iXp2SAhQHglvCIR6MpvkwZPP9jVrIs203BJZVmCXuVl
         QPOoipkpjPQ5OzGPj7LJ8FNGNUNJEI1A6kEpDDZWss+RwxPpkzRXH9to0boYB46U/jIO
         hOYx6JR0upBnvTsIxUnWkddR6W11Aujm1mvDsEyQsJpJlKE7LQXCocSrPHwSSa4XaiNT
         mDDqXFf8zEvmzGfRpB9sIDvJWzmWL+LzZlG+ZPSC880AyNQtW77gmK5KR7Gt+KUvPoJm
         zB2Q==
X-Gm-Message-State: APjAAAVcNqBRvOg/N2MqRr/4tMY6fS5d6DQ2qd2HrJ2NmUGX/iDawddk
        qkyahy6lAeAf3phy9LphMyVLjjUP
X-Google-Smtp-Source: APXvYqxtZIlt61aoE4HBY0+zyKKFQd4aU0+4RjyVgE5Q0YhL6jc2r+jp45z/irgQ2zQTc02RC8GDGQ==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr6800626wmj.53.1576161386401;
        Thu, 12 Dec 2019 06:36:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm6307174wrt.82.2019.12.12.06.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:25 -0800 (PST)
Message-Id: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:09 +0000
Subject: [PATCH 00/16] Extend --pathspec-from-file to git add, checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano" 
        <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic continues the effort to support `--pathspec-from-file` in various
commands [1][2]. It also includes some refactorings that I developed while
working on it - previously submitted separately [3][4] which was probably a
mistake.

Anatomy of the branch:
  checkout, restore: support the --pathspec-from-file option
    Extends `--pathspec-from-file` to `git checkout/restore`.

  t2024: cover more cases
    Some new tests for cases that I deemed worthy while working
    on `parse_branchname_arg()` refactoring.

  parse_branchname_arg(): refactor the decision making
  parse_branchname_arg(): update code comments
  parse_branchname_arg(): introduce expect_commit_only
  parse_branchname_arg(): easier to understand variables
    These patches prepare for `|| opts->pathspec_from_file` addition in
    `git checkout/restore` patch. Without this refactoring, I found it
    pretty hard to modify the old code.

  checkout: die() on ambiguous tracking branches
  parse_branchname_arg(): extract part as new function
    Initially I was trying to remove some inconsistency standing in the
    way of `git checkout/restore` patch. Later I figured that this change
    is worthy on its own: it prevents some pretty surprising behavior of
    git.

  doc: restore: synchronize <pathspec> description
  doc: checkout: synchronize <pathspec> description
  doc: checkout: fix broken text reference
  doc: checkout: remove duplicate synopsis
    Some polishing of docs in preparation for `git checkout/restore` patch.

  add: support the --pathspec-from-file option
  cmd_add: prepare for next patch
    Extends `--pathspec-from-file` to `git add`.

  commit: forbid --pathspec-from-file --all
  t7107, t7526: directly test parse_pathspec_file()
    Some polishing of merged topic [1].

CC'ing people who shown interest in any of the previous topics, thanks for
your reviews!

[1] https://public-inbox.org/git/pull.445.git.1572895605.gitgitgadget@gmail.com/
[2] https://public-inbox.org/git/20191204203911.237056-1-emilyshaffer@google.com/
[3] https://public-inbox.org/git/pull.477.git.1574848137.gitgitgadget@gmail.com/
[4] https://public-inbox.org/git/pull.479.git.1574969538.gitgitgadget@gmail.com/

Alexandr Miloslavskiy (16):
  t7107, t7526: directly test parse_pathspec_file()
  commit: forbid --pathspec-from-file --all
  cmd_add: prepare for next patch
  add: support the --pathspec-from-file option
  doc: checkout: remove duplicate synopsis
  doc: checkout: fix broken text reference
  doc: checkout: synchronize <pathspec> description
  doc: restore: synchronize <pathspec> description
  parse_branchname_arg(): extract part as new function
  checkout: die() on ambiguous tracking branches
  parse_branchname_arg(): easier to understand variables
  parse_branchname_arg(): introduce expect_commit_only
  parse_branchname_arg(): update code comments
  parse_branchname_arg(): refactor the decision making
  t2024: cover more cases
  checkout, restore: support the --pathspec-from-file option

 Documentation/git-add.txt           |  16 +-
 Documentation/git-checkout.txt      |  50 +++--
 Documentation/git-restore.txt       |  26 ++-
 Makefile                            |   1 +
 builtin/add.c                       |  60 ++++--
 builtin/checkout.c                  | 279 ++++++++++++++--------------
 builtin/commit.c                    |   3 +
 t/helper/test-parse-pathspec-file.c |  34 ++++
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/t0067-parse_pathspec_file.sh      |  89 +++++++++
 t/t2024-checkout-dwim.sh            |  55 +++++-
 t/t2026-checkout-pathspec-file.sh   |  61 ++++++
 t/t2072-restore-pathspec-file.sh    | 139 ++++++++++++++
 t/t3704-add-pathspec-file.sh        |  49 +++++
 t/t7107-reset-pathspec-file.sh      | 105 +----------
 t/t7526-commit-pathspec-file.sh     |  80 +-------
 t/t9902-completion.sh               |   2 +
 18 files changed, 694 insertions(+), 357 deletions(-)
 create mode 100644 t/helper/test-parse-pathspec-file.c
 create mode 100755 t/t0067-parse_pathspec_file.sh
 create mode 100755 t/t2026-checkout-pathspec-file.sh
 create mode 100755 t/t2072-restore-pathspec-file.sh
 create mode 100755 t/t3704-add-pathspec-file.sh


base-commit: ad05a3d8e5a6a06443836b5e40434262d992889a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-490%2FSyntevoAlex%2F%230207_pathspec_from_file_2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-490/SyntevoAlex/#0207_pathspec_from_file_2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/490
-- 
gitgitgadget
