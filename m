Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7799C4BA24
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E4324650
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuDr1YlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgB0AO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 19:14:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44736 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgB0AO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 19:14:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so1059203wrx.11
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 16:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=s3MnehiNcQHExAJhKyaOvYvpmT7kA3TYzaq/MfzMGC8=;
        b=YuDr1YlSZXgOs5ny176z7XeQgZuQSdCe+LnBT2l14X6pWp7tZ2RT9sqCDZrOLmXh9K
         CRTLv+L0xFyEeQn9Byrt7Wg/2/CDG5n4ojoZwunspf1QhHWzzSE4hcZ8o5zl9EsZKj/F
         iltvkxESHYLiMGcZIWKaAOjIjc1UI83FT5yOj6eFxFL+1Jh5nJH9yZYjqMTSnEHzXhdK
         Lc8YmXXuc0NSBy8yS5KhRGmlHf2VFaeHHHZs/PWBKcckJ3ju0XDGJBmjTF8H/jgjRcMD
         /mHvEHfmYGaOpfialVY99FkXs5xiAkVdVMHQjn3OQ4NGDeRUCV/1vaoiDJZViaCRa+te
         8quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s3MnehiNcQHExAJhKyaOvYvpmT7kA3TYzaq/MfzMGC8=;
        b=eZIxwUmoV/ed5l1RF3YvJKA6EdwekOW9rSxGnZkXaV4CNrEkzaSjXhFlZmRpeoFKa+
         MG9Tvn2yz7kQLl8C3pPtH8uqnH2CtgE2zrANsGfGsY4SULBw4H3VqJUmiyBb0952hNr7
         oN/f1FUcLLQtDRAmgDQyGAB8+q51KQn6Y/ejgM24d7l4iu1VOLg9tIZnai/aKgm/cA61
         8R0Cl9JTBymZB+z1drztRvsqFweVo0iFAIDDYEIWcXDtvZnoDI6ITqGLBtJeyRyt1qrp
         bnJmTZVne38qmhxEhYdQ8/Dm3sE6et809zTojZffEPgxRwbaDlqwVWQvKbDuxRLBybMS
         dHwQ==
X-Gm-Message-State: APjAAAWqmIyNfkv/aVKWI2AL791fB2XAY6g53gIqPdJIi8XP1VxaA/0P
        HrlJ866AxgfB7rkMvR7uHYlz979W
X-Google-Smtp-Source: APXvYqyccIlseFSDmab5F96ZERDpIKJEGeI+1/qAc+4X9721MF7dKr3WXK8gVKHHTIg8lfjYicxGRw==
X-Received: by 2002:a5d:4204:: with SMTP id n4mr1169805wrq.123.1582762466008;
        Wed, 26 Feb 2020 16:14:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i18sm2270367wrv.30.2020.02.26.16.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 16:14:25 -0800 (PST)
Message-Id: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 00:14:19 +0000
Subject: [PATCH 0/5] Testcase cleanups (merge related)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series has a few testcase cleanups, and a new testcase. In more detail:

 * The first three patches are just various forms of testcase modernization
 * The fourth patch updates some tests to check intended behavior instead of
   a proxy thereof
 * The fifth patch adds a new simple testcase that there is no other
   merge/rebase/cherry-pick test for in our testsuite, just for added
   defensiveness.

As a side note: t60[01]* is used by rev-list, and then t60[234].sh is kinda
taken by merge-recursive except that t6030 and t6041 are for bisect and
t6040 for remote tracking stuff. Because t60[234].sh got filled up, rev-list
spilled over to t61[01]* as well. It's all kind of a mess. I'm curious if
moving the merge stuff over to t64* would make sense, since that'd keep the
merge stuff together, and would also free up space for rev-list, bisect,
remote-tracking and whatnot. Would that just be too much churn?

Elijah Newren (5):
  t602[1236], t6034: modernize test formatting
  t6020, t6022, t6035: update merge tests to use test helper functions
  t3035: prefer test_must_fail to bash negation for git commands
  t6022, t6046: test expected behavior instead of testing a proxy for it
  t6020: new test with interleaved lexicographic ordering of directories

 t/t3035-merge-sparse.sh                |   4 +-
 t/t6020-merge-df.sh                    |  55 ++-
 t/t6021-merge-criss-cross.sh           | 135 +++---
 t/t6022-merge-rename.sh                | 382 +++++++++--------
 t/t6023-merge-file.sh                  | 568 +++++++++++++------------
 t/t6026-merge-attr.sh                  |  46 +-
 t/t6034-merge-rename-nocruft.sh        | 122 +++---
 t/t6035-merge-dir-to-symlink.sh        |  28 +-
 t/t6046-merge-skip-unneeded-updates.sh |  89 ++--
 9 files changed, 752 insertions(+), 677 deletions(-)


base-commit: 2d2118b814c11f509e1aa76cb07110f7231668dc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-716%2Fnewren%2Ftestcase-cleanups-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-716/newren/testcase-cleanups-v1
Pull-Request: https://github.com/git/git/pull/716
-- 
gitgitgadget
