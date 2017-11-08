Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB4991F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 19:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbdKHTzZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 14:55:25 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:51685 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbdKHTzY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 14:55:24 -0500
Received: by mail-io0-f175.google.com with SMTP id b186so7244024iof.8
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 11:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8ovWDhXBZ39bJzKSj63ATEiS5nnQ6nu1odL3jUUtzGQ=;
        b=jgEDVt00DihPACx0KWWmoX0yjtj0Sb4YkaHPvL8RZWUtVe/cYEGJ2OpZy9x9d0jew9
         bMx1av3KoRjppTY5KYbuMujbK3+e0oLAcz4QCMIMgb4UlHvdC2mqasoXpkuTeTas+gGt
         IecHkc2V5oD8kWdSlTsbZhy88wxDUvFM5hjtsRAbeqzIrrt/9WhHN+neVP4Wi/qWeQ2D
         8O+46yAJVGcqnGNc6MaQdOtRofn1tyrB8ngzOtgbUlwN0YXUUk0WE4wZidyqzGjfhba8
         OHkCeCPgi/y5WDMBtpkdQTayt7XUSBQCwIxJiYCwJFsT4nf/nGunX1Z5zG81KuNcccte
         dqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8ovWDhXBZ39bJzKSj63ATEiS5nnQ6nu1odL3jUUtzGQ=;
        b=qPSLH34ZWXWCUsP3PYcrLywmgXVUhCuYvgxzFjxne4FPGpCC/QZfi6gktflWwaaHba
         EMoRYtuHd1XgghQfnLXTzgEewMQ7VCRxEj/b2VUH2XboewLp2RGfb6za8QjX4EBVcZ6R
         Z34i2kZhMQy9EGj4PL3ACMBO+tQ3+9KCfF0MnFC25coEyy9fvTyh0PJ6bKEW+ylxol6B
         Ins9Ja576sXlQ1PM+MEmUY4LrcuxfPABYSKrgCpBVJkKKLHQEZ0t5WOQel4qyKrFm6QI
         cS9tkm7UR+xnY30MbujAcRAaEoBV7HtzLglm5vVDPbgZ1y3MIxtcYVHotHdvQHmpMF2N
         F/pw==
X-Gm-Message-State: AJaThX4SiBcytOcKF+BBsUb+UFvAwYFYvczsZYq2ZLgQXBRwvyp6CK6j
        CkWBOjPKD/lHKhZC9zqcQDgK41twDjA=
X-Google-Smtp-Source: ABhQp+RTfjZROVRy4j7/i8OTJzySRM0v78nVq3zEWSIBpbrygzec9JdHCUvp38B0v62ibrlglIx+Ng==
X-Received: by 10.107.25.18 with SMTP id 18mr2164262ioz.11.1510170923464;
        Wed, 08 Nov 2017 11:55:23 -0800 (PST)
Received: from localhost ([2620:0:100e:422:c178:b390:b6a8:a0e2])
        by smtp.gmail.com with ESMTPSA id e99sm2593759itd.40.2017.11.08.11.55.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Nov 2017 11:55:22 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 0/4] git-status reports relation to superproject
Date:   Wed,  8 Nov 2017 11:55:05 -0800
Message-Id: <20171108195509.7839-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  $ git -c status.superprojectinfo status
  HEAD detached at v2.15-rc2
  superproject is 6 commits behind HEAD 7070ce2..5e6d0fb
  nothing to commit, working tree clean

How cool is that?

This series side steps the questions raised in
https://public-inbox.org/git/xmqq4lq6hmp2.fsf_-_@gitster.mtv.corp.google.com/
which I am also putting together albeit slowly.

This series just reports the relationship between the superprojects gitlink
(if any) to HEAD. I think that is useful information in the current
world of submodules.

Stefan

Stefan Beller (4):
  remote, revision: factor out exclusive counting between two commits
  submodule.c: factor start_ls_files_dot_dot out of
    get_superproject_working_tree
  submodule.c: get superprojects gitlink value
  git-status: report reference to superproject

 Documentation/config.txt |  5 +++
 builtin/commit.c         |  2 ++
 remote.c                 | 40 +-----------------------
 revision.c               | 45 +++++++++++++++++++++++++++
 revision.h               |  7 +++++
 submodule.c              | 80 ++++++++++++++++++++++++++++++++++++------------
 submodule.h              |  6 ++++
 t/t7519-superproject.sh  | 57 ++++++++++++++++++++++++++++++++++
 wt-status.c              | 37 ++++++++++++++++++++++
 wt-status.h              |  1 +
 10 files changed, 222 insertions(+), 58 deletions(-)
 create mode 100755 t/t7519-superproject.sh

-- 
2.15.0.128.g40905b34bf.dirty

