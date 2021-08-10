Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F084DC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C2360E09
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhHJS3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbhHJS3O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 14:29:14 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3F1C0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:28:51 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id h21-20020a17090adb95b029017797967ffbso237642pjv.5
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7u8EBgiIze6Rlk0riEfFr9qBuPVtvQh6vLkd++mbMsI=;
        b=jyYAHmm9ZEazY4K2xvll3QVG6YwNZx9ojQqh6NUvDblKf2Bj6bmzoH/uiG9E/VB2MZ
         my7tUjU5Y4WhdN9GdCSIVzMZprTZ8vmQdsYVCavw9gYcCAygVEmvB0XaO7Eb3xigTbjE
         C9x8xDDfk3hwuAIKC7HiuRanM2HC+ascobUP3jDtBv3pQC/02BAsuD6jnTws5KxG/nYo
         U5o9f/dyRLLRrsjAfVydBMysU12EUJCSCL4syj0NOnZaU+Ef1LApulSuWrtBFmOwoh0U
         wmI55TygjsEzjjsVU4dEai2xsfSnhBoUqu6Ru0cIo0VecXZE8OVuNQeEmVcpTlylxlYh
         VZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7u8EBgiIze6Rlk0riEfFr9qBuPVtvQh6vLkd++mbMsI=;
        b=ga5WwYcoelR/K9cd2zxrQcF9HrEcULBfJWiX7tSfR+RLBxY/+a8kfOcpA/yW1Buz6f
         Slar44cfSy3YwH+mLgNJW4gO74xE7ChFIpWOJeMIEJotCQ0ffqMDZSga7NeGc/BG2L9P
         XLG2KLXYQDgsyKcoqC8n32Zh80kfUK+5/6lbg7NkVVBH4T2bBWsu5ZxUW34PYLdRkPOv
         9VddNp7+gdBHNxABgJj39/tqG3T1WeqPt8+EbWaP8pPX1Hs/uwB3VILVe9rpEx707slP
         nHhJEVeLRDKAkpkr7NQHwVfqh4G8VMiGtfcSPkLIE8WCw00If3hjQpkhUwMYfyhDAiaL
         TB6A==
X-Gm-Message-State: AOAM530lgkx9fwJV82pMdRFaSxBK1hb9xbEqhXKlYLWMKHM1CVz0apzn
        /CFNqmzmxUn4n9b8FNaoWHGZg+BV9j9GRlHG98gVi6FChMNpaDFMjLpFOPonBK6BdKdMtGoXPFf
        NXuN/h8p+HFg510y12pYqA1jj4BFQb1pvDCHy2cP9Cmw5/dUsxPaCFboq6fSuq1q/H+i5kakPZh
        Y2
X-Google-Smtp-Source: ABdhPJzYfo6IxMYueGEisV1t38+KeKj+Q8CwbHm5G7g1ev9+bsqYW8D1biB8xWE5K7sCymuG/Vp7Q0/DAQi6S3q/Dzi6
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:6947:: with SMTP id
 j7mr29109107pjm.196.1628620131229; Tue, 10 Aug 2021 11:28:51 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:28:38 -0700
Message-Id: <cover.1628618950.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 0/7] In grep, no adding submodule ODB as alternates
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series removes the need to add submodule ODBs as alternates
in all codepaths covered by t7814. I believe that that is also all the
codepaths covered by "git grep", but if it isn't, the uncovered
codepaths will still work - they will just not benefit from the
performance improvements.

In doing this work of migrating away from adding submodule ODBs as
alternates, I'm mainly motivated by the possibility of adding partial
clone submodule support, but this has benefits even for those who do not
use partial clones, as described in the documentation in patch 1.

To reviewers: you can cherry-pick the last patch onto one of the earlier
ones to observe what happens when the code still accesses a submodule
object as if it were in the_repository.

Jonathan Tan (7):
  submodule: lazily add submodule ODBs as alternates
  grep: use submodule-ODB-as-alternate lazy-addition
  grep: typesafe versions of grep_source_init
  grep: read submodule entry with explicit repo
  grep: allocate subrepos on heap
  grep: add repository to OID grep sources
  t7814: show lack of alternate ODB-adding

 builtin/grep.c                     | 49 +++++++++++++++++++++---------
 grep.c                             | 48 ++++++++++++++++++-----------
 grep.h                             | 10 ++++--
 object-file.c                      |  5 +++
 submodule.c                        | 25 ++++++++++++++-
 submodule.h                        |  8 +++++
 t/README                           | 10 ++++++
 t/t7814-grep-recurse-submodules.sh |  3 ++
 8 files changed, 122 insertions(+), 36 deletions(-)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

