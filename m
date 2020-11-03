Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323FAC00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E977A206CA
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOzvnev8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgKCA0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 19:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCA0S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 19:26:18 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335BBC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 16:26:18 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id m64so11151468pfm.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 16:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Rg4rOO7tWJzIYrYGPK1XYq5alNw+GLF0yiKR9B2rVv0=;
        b=qOzvnev8NZqFBxPkkIS2I4gFpBjhJVuj1D1a+RDakDUcIU2EV79QQS1VbnYEyA8GtT
         c+Pxez0hsfvl43UCf2jWrF5ts3gxl73vTN52lKvBV1u1gVEp/avd+ghcR83DvKPvYeaL
         WWqUH0PuOQ9ufPbEZj7g1+Fs8kuwTlzizSjWzFiaJWr4tqnLkYChbZOPeOsO8lv9/GL9
         J6I4gD52sW54F5OqqhuVabJ+vuniNE4PRpgFGWrDmiHLXJlgOgDNb29OWMOVo37juvt0
         6wVZysgXGUmiMxJIJ/t8AhZpwuuYmKT7okqrvIqbj9JH0MTWu8EU+mySeaBzMCZO+XIF
         5XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Rg4rOO7tWJzIYrYGPK1XYq5alNw+GLF0yiKR9B2rVv0=;
        b=AzeEe/yr7FeJl1+96ii5qZ3Czadvf9oeWTh9GbAYgMT8/9ozExDAAcFuvclw1qxv65
         HRs0Rmg5CQqhmSnretEl4Gd1qVJr05tK2jtohGQ6GPVxWtu5qwYFtwpIufwSEI1o3/OI
         2LudLgvNnzMNU+maNzgMPJdRjzESJErQ5ykEVq5Jh0vj+0vjzPcFoacZNmqA80VmCt/Q
         H3IYq+qTCUs9/4E0uoTiWXQtByONS4KaN8fjEflJARZuoegePV08M4v9Vfcrv2wLSRYo
         q843ybSSFu7l+s8bLDFclB2gsN12zQpAVfECA/ImhHUsqnQLChtADNOktuy5XDxzYPwJ
         B+Ng==
X-Gm-Message-State: AOAM533oPnbD2ieMkihr0XPoAg1XI9L7cXLCDufscWB+ywJHs9SKWQ3Q
        rkTf5OJMvjYd3DOzdH0Aj6FmK5UUJ2ITZzE+yeKN+trS9sUbUmtR1Eg3wO3AUU1cmi1rOmifEP1
        +n3XsZ/g2QkhBp58/BO0EiR9OJXK7nR6lZAEhem0rcFyEKJVsHwd4FvqdSbylBoo+nEoRDvk3lp
        7W
X-Google-Smtp-Source: ABdhPJz5DnzEcUlHlbAaKliRAvKbuILEEY3HqoLsP/za6X1tsf13kZJJiDFQPXs/sItRG5pSATOAt8J3yrX3iIrNcMq7
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:b091:b029:d6:af8c:506c with
 SMTP id p17-20020a170902b091b02900d6af8c506cmr14244974plr.27.1604363177606;
 Mon, 02 Nov 2020 16:26:17 -0800 (PST)
Date:   Mon,  2 Nov 2020 16:26:09 -0800
Message-Id: <cover.1604362701.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 0/4] "Push" protocol change proposal: user-specified base
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At $DAY_JOB, we've noticed some pushes being larger than necessary.
Here's a first step towards solving that. In this protocol change, we're
allowing the user to specify an ancestor believed to be common; if the
server agrees, the server sends that ancestor as the lone so-called ref
being advertised instead of the full ref advertisement. Not only does
this save bandwidth for the ref advertisement, but this avoids the issue
of the server's refs being ahead of the client (and thus the client
cannot use them since it is unaware of those objects).

More information (including a design doc) can be found in the
documentation patch.

This works for file://, ssh://, and http(s)://.

One last concern I had is the locations of the tests - I just bundled
the protocol v0 ones with their corresponding protocol v1 ones, as I
couldn't find good places to put them.

Jonathan Tan (4):
  connect: refactor building of Extra Parameters
  push: teach --base for ssh:// and file://
  remote-curl: teach --base for http(s)://
  Doc: push with --base

 Documentation/gitremote-helpers.txt        |   8 ++
 Documentation/technical/pack-protocol.txt  |  10 +-
 Documentation/technical/push-with-base.txt |  61 ++++++++++++
 builtin/fetch-pack.c                       |   2 +-
 builtin/push.c                             |  12 ++-
 builtin/receive-pack.c                     |  46 ++++++++-
 builtin/send-pack.c                        |   2 +-
 builtin/upload-pack.c                      |   2 +-
 connect.c                                  |  39 +++++---
 connect.h                                  |   4 +-
 http-backend.c                             |   2 +-
 protocol.c                                 |   5 +-
 protocol.h                                 |   5 +-
 remote-curl.c                              |  25 +++--
 t/t5700-protocol-v1.sh                     | 110 +++++++++++++++++++++
 transport-helper.c                         |  15 +++
 transport.c                                |  14 ++-
 transport.h                                |   9 ++
 18 files changed, 332 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/technical/push-with-base.txt

-- 
2.29.1.341.ge80a0c044ae-goog

