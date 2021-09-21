Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EA6C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6204361166
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhIUQwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhIUQwn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:52:43 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAFFC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:15 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r6-20020a05622a034600b002a0ba9994f4so216565789qtw.22
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HuuF+K8uVND9d8PbNM9ree4LvQc5oC8FXE+Q2AZJn0Q=;
        b=pwSO8iY3WPPJstREUlhNqajAy1ao3Rze3RerkiXgsmYL4td65s14eMmIcrx1n9/wrq
         e9ezdumCqLndlipsMi31Gw1crCvHOXqTPsTVTzrjFjiKX0QVD9QR6qG4mBHacjKeOq8f
         wc6baUQEsCF4Ai6psQB1OG2CYTuIyfs6ZI1Hn/RytRgvNyOErxIhFNNskL3QOJ/9RztT
         D3uCfoDBDgvzjQIcVfL5kuHkBlXM5H5IVCMWfSFMps4Hd5Ea+rfn8EUcwqb6zDJ+i79H
         2h9mYU9hJARYAjktTH63wim14uZ9boAqxMDVGhXJtvDSYOSA6aDZDLEnzPnjK9XyX/af
         lTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HuuF+K8uVND9d8PbNM9ree4LvQc5oC8FXE+Q2AZJn0Q=;
        b=kXw0l9b5bccUkTCua5QBnPnbdkSn+UA/JXXWaRZBEAcd+Ip9LbEQh36HBNC6c3NclM
         9QBOizOCyVyZaWcaNHclDWANPMqiNsqANQmF8RGRhb8yFDabH4pLHbvZd2KacGZupDiX
         dtkzGzF0H4UsEg6fp1slRsy1rRISfoVFuzrY3uN9jAHrjixSBEIY2ovx5pbDKDaihr22
         EjOWOJ6Uh7VBnlzyCYpgbSs6EPfPdwiq0aSTWHKpzNIeA+tCCBoQ7WPbH9DHzevOYAw/
         MpsD9WcZbZa95fDS5PPeiukbdMuLi6y2XFVeunV+6wT/znIIl1FaUepkSIDrm+K45lB3
         LKTA==
X-Gm-Message-State: AOAM533akutAgSQLv6Yl1xtGt6Yvo5citMmL5cUL96J8Wwml6lmZYCPM
        9waq8dtLQc2jUK4LZ8SoECAJeZllPTEUofbMbHjFGzxbUBuGZ3+M4/8UR1U8sCBbWwsAhFgZd8p
        0dyF4yV601hKP/bqnhflKxZpRqQk9XMvQKH0XlAeexlKgj7T2XONaDuf9M1r3iunAksXUNspVyH
        Af
X-Google-Smtp-Source: ABdhPJxoXQyNS2SX+FvcthXRAo+e2/SGJehQRLf0Lq2hDwDFWXHCRcOdE0S9EnmGKOlcY4+8M9S/7kHrZcWmicJ0JsxF
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:2cc2:: with SMTP id
 s185mr40775681ybs.196.1632243074348; Tue, 21 Sep 2021 09:51:14 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:51:02 -0700
Message-Id: <cover.1632242495.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 0/9] No more adding submodule ODB as alternate
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is on jt/add-submodule-odb-clean-up.

After this series, the entire test suite runs without ever adding a
submodule ODB as an alternate (checked by running with
GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1). The code to lazily add
submodule ODBs as alternates still remains (with a trace message printed
if it happens) just in case there is a rare interaction that the test
suite doesn't cover.

This is part of my effort to support partial clone in submodules, but
the results here are also beneficial for non-partial-clone submodule
users in that access to submodule objects are now quicker (because Git
no longer needs to linearly search through alternates when accessing
these objects). It also improves code health in that it is clearer at
the call site when a submodule object is being accessed.

This patch series contains the 2 patches from my previous work on
iterating over submodule refs [1], and 7 new patches.

[1] https://lore.kernel.org/git/cover.1629933380.git.jonathantanmy@google.com/

Jonathan Tan (9):
  refs: make _advance() check struct repo, not flag
  refs: add repo paramater to _iterator_peel()
  refs iterator: support non-the_repository advance
  refs: teach refs_for_each_ref() arbitrary repos
  merge-{ort,recursive}: remove add_submodule_odb()
  object-file: only register submodule ODB if needed
  submodule: pass repo to check_has_commit()
  refs: change refs_for_each_ref_in() to take repo
  submodule: trace adding submodule ODB as alternate

 builtin/submodule--helper.c            | 16 +++--
 merge-ort.c                            | 18 ++----
 merge-recursive.c                      | 41 ++++++------
 object-file.c                          |  3 +-
 object-name.c                          |  4 +-
 refs.c                                 | 87 ++++++++++++++------------
 refs.h                                 | 12 ++--
 refs/debug.c                           |  9 +--
 refs/files-backend.c                   | 28 ++++-----
 refs/iterator.c                        | 51 ++++++++++++---
 refs/packed-backend.c                  | 24 +++----
 refs/ref-cache.c                       |  7 ++-
 refs/refs-internal.h                   | 55 +++++++++++-----
 revision.c                             | 12 ++--
 strbuf.c                               | 12 +++-
 strbuf.h                               |  6 +-
 submodule.c                            | 28 +++++++--
 t/helper/test-ref-store.c              | 20 +++---
 t/t5526-fetch-submodules.sh            |  3 +
 t/t5531-deep-submodule-push.sh         |  3 +
 t/t5545-push-options.sh                |  3 +
 t/t5572-pull-submodule.sh              |  3 +
 t/t6437-submodule-merge.sh             |  3 +
 t/t7418-submodule-sparse-gitmodules.sh |  3 +
 24 files changed, 271 insertions(+), 180 deletions(-)

-- 
2.33.0.464.g1972c5931b-goog

