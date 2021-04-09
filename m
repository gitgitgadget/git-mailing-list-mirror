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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482F6C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A558610A7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhDIBKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 21:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIBKU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 21:10:20 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C99C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 18:10:08 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id t1so2095563pfg.5
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 18:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=weUXpf22nUY/zE0nGiFmDSk/yZjL1xCJ/qIbj/ACJw8=;
        b=o8pWcwxSefyiCbyTys3gBwmKBMJUWwLQuGwSl+CMXFhOODD1/PHpGXYnA98cmf/2Sx
         AZAg6zY3CmIcurgJKan/rP9MjBK5DHT+4+HGBgmAWuE+0hFcwESJEGOgQz7MhVJbl0cj
         N9k/ylXivsStag1zrcXgJz7XgjDDlY8Qq1uZWIBmO4ESqIBc01Mwhor1ZCDGb1MNOVmZ
         ixCCZG1IlLlDYgb20MYwV/PhijmlVwPqq5tbp7SMIylmjGB8IEE60uYun92wEmaAuPps
         mP9JwbCr0L8L4O5Y/Ib5AQ7DrKDwRfpfn1flNqCW63oG4HD+LLi20Ro/Iv4LMOZADl5T
         Yo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=weUXpf22nUY/zE0nGiFmDSk/yZjL1xCJ/qIbj/ACJw8=;
        b=f/IVSNhZWWl2QMlgwHNC4IgqB/lBog0E+y/1fNY3Og+oCiSAc5QJaz95b+NWtl7r8A
         iBBc3+tTESjdN7hN09NENzeaD5gYxqLqRY0+B3GU+IFkYGH0Xt9RimaWRfe33qGcjU6S
         IS3C+gVLyZkr8zDzpK9BWKmjcFRygEGXwAnyZz59V3jv/G6oBF1pIu7nURzOE0Etn4hx
         itiT8LyC3xW0ALWr0/QNGKBw0C/j0rSnH70rWK67/z2j2qStAF1E08dnzC6mxnnlUqWQ
         vnKHPTykvA9WmzLZdGVfabr2BC4H3pHZeSVb7q6xw3xNpIC4PV7UBeeUVLLOiZVhcT2r
         SMHg==
X-Gm-Message-State: AOAM530id5Mqr3jZbggtotoCCVfWRoK8TpCXlo7Qzd32+7gmX6js8cDW
        EmvD/TpHp/93wTFHm/CyxxMlCjePMKT99syBwtJGlgPmVlohZ0CO1lWNjqWrKQ1okOeexxw1FKz
        bZmeLhPRQUVq5ROGEhIKDPR5s26HdZx7qZCyboJZI4bamjgKFHa92UCLfGAgvJOARZaAsr/N8+C
        U6
X-Google-Smtp-Source: ABdhPJyl2msU/dRpYsjoc57wPdTlHSsUX2r1QwTyVlbKEkic3CSqOwjmlm6Iw3gJuy5jJNAG6oXdKNSy+slDUo9DgsUM
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:e211:b029:e9:a266:53a7 with
 SMTP id u17-20020a170902e211b02900e9a26653a7mr3400651plb.11.1617930607660;
 Thu, 08 Apr 2021 18:10:07 -0700 (PDT)
Date:   Thu,  8 Apr 2021 18:09:57 -0700
Message-Id: <cover.1617929278.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 0/6] Push negotiation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are patches for push negotiation. The basic idea is that we can
reuse part of the fetch protocol (and code) to find out what is in
common between the client and server, and then use that information to
further narrow the objects sent in the packfile during a push.

Patch 1 is a bug fix that probably should be merged even if the rest
aren't. Patches 2-4 are refactorings in preparation for the future
patches. Patches 5-6 contain the actual logic and documentation.

I have written more about it in my prior work [1], although the commit
messages and documentation in patches 5-6 should be enough to explain
what's going on. (If they're not, feel free to make review comments.)

The main change from [1] is that the client-side code that used to be in
builtin/fetch-pack.c is now in builtin/fetch.c, because I realized that
builtin/fetch-pack.c does not support HTTP. Other than that, all the
"what hasn't been done yet" items have been done except for statistics
in the commit message.

[1] https://lore.kernel.org/git/20210218012100.928957-1-jonathantanmy@google.com/

Jonathan Tan (6):
  fetch-pack: buffer object-format with other args
  fetch-pack: refactor process_acks()
  fetch-pack: refactor add_haves()
  fetch-pack: refactor command and capability write
  fetch: teach independent negotiation (no packfile)
  send-pack: support push negotiation

 Documentation/config/push.txt           |   7 +
 Documentation/technical/protocol-v2.txt |   8 +
 builtin/fetch.c                         |  27 ++-
 fetch-pack.c                            | 224 +++++++++++++++---------
 fetch-pack.h                            |  11 ++
 object.h                                |   2 +-
 send-pack.c                             |  61 ++++++-
 t/t5516-fetch-push.sh                   |  35 ++++
 t/t5701-git-serve.sh                    |   2 +-
 t/t5702-protocol-v2.sh                  |  89 ++++++++++
 transport-helper.c                      |  10 ++
 transport.c                             |  30 +++-
 transport.h                             |   6 +
 upload-pack.c                           |  18 +-
 14 files changed, 430 insertions(+), 100 deletions(-)

-- 
2.31.1.295.g9ea45b61b8-goog

