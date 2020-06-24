Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B26C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0886214F1
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZ3PIPQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbgFXB2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387842AbgFXB2j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 21:28:39 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2868EC061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 18:28:38 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id q5so585006qvq.18
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 18:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uoHQ9FHvstZvnDQn28G5h8uY+k7OrgviJRajO58SkXM=;
        b=IZ3PIPQI1M8jF02Z0kXCkDa3HWfIBxhJmWE9e5NKgZmLtynySeZnxfoyj1bI8yv2c6
         OLPi/rD2bLQuA2YH7F2hIczUC3PskHhp/KcMRaD7gkA996RQW1BilAHpbRpxQqxG3+OE
         lwU8x1gSiRZ7olEBG/xse+Xu8I5f1/wBEALP6qXsOwnwlu/yj4A3AOh0SGCnrFk8K+FV
         iBBrYI/WCtuVBpA0P2bwYJR1bJSyiqwRESCDIaGYyPdcj7vRLrrNW/gkFZv6ptxk8PVn
         e8XN5g1tkfq3/G9OznkAEBqdjXajanB1O2OCF3eTlw8POLmXz+8zBLfK3mCft3dMF1t9
         qEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uoHQ9FHvstZvnDQn28G5h8uY+k7OrgviJRajO58SkXM=;
        b=fiE344RNcdDSZz6V8G2jeSZZODlEvfRck8ZTTyCn/cCLnw58UQG82dQOnoExUyqFbu
         e3aaKsmwKouICjigTdJQDTCcl6LAbwJduEMiA4/yFOMDauaTU+J9hT1WzEeoULqnKten
         ejtaT7FRitjWpMhjlHGbaHdJmkUB4gBIyA9Ldndx5tv3yTYwxtqDRz1PgQgiGEHMsCBh
         R9gCE45XB8q4KgYL2cdUDPauhx4YDblP8ChRECNRSAsbSO+7L4q0fAf6iuTsxJJr1eO0
         5VStPsIoZCZk55ziqiYg1F4Wz/Iq8fQghLmKYpniISaa9QglehBdfmrKe7qgjPCt1aBg
         OTDg==
X-Gm-Message-State: AOAM530/Ihwg7w2gajnee5hx8vHbuUKZ1ZaVAzAECRSd5puYLAQxHoG5
        tP3FErdfTqubvILxCo6kqgJENes0GNa2qKeKk0ZFPChELoSpKciehYRSz/nV2JVLPS7Rn7VyEwU
        BIprfpivDYcKTWdZ1nWS7Mg3NJm6fgRetKJTYkiVFPyMvVEsj7XSgdQpsv7ETlwJvevc8I7VLyg
        ==
X-Google-Smtp-Source: ABdhPJzLUhZgPhq8DA1FGrMWC3J++OcwqvOzaG8s0oe2qi3kL6+ibWuboP2WlgQgUfPlIQwn9S+MJyBBy/ZCvpjGsxY=
X-Received: by 2002:ad4:5492:: with SMTP id q18mr28815655qvy.166.1592962117220;
 Tue, 23 Jun 2020 18:28:37 -0700 (PDT)
Date:   Tue, 23 Jun 2020 18:28:25 -0700
Message-Id: <20200624012827.34126-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH 0/2] bugreport: report configs from safelist
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some configs are useful to know when trying to diagnose or reproduce an
issue. However, other configs are sensitive and should not be shared
with others. Finally, many tools which wrap or augment Git also use
Git's config system, and so may store sensitive information which Git
is not aware of. Therefore, it makes sense for git-bugreport to gather
configs which Git developers have decided are safe and useful - a
safelist - but no other configs which the user may have. This list of
safe configs can be expanded over time and is generated from
documentation.

This series is based on 'master' but was cherry-picked from quite some
time ago, so it's possible there's some anachronism I missed reviewing
it myself :)

 - Emily

Emily Shaffer (2):
  bugreport: generate config safelist based on docs
  bugreport: add config values from safelist

 .gitignore                              |  1 +
 Documentation/asciidoc.conf             |  9 ++++
 Documentation/asciidoctor-extensions.rb |  7 ++++
 Documentation/config/sendemail.txt      | 56 ++++++++++++-------------
 Documentation/git-bugreport.txt         |  1 +
 Makefile                                |  9 ++++
 bugreport.c                             | 28 +++++++++++++
 generate-bugreport-config-safelist.sh   | 18 ++++++++
 8 files changed, 101 insertions(+), 28 deletions(-)
 create mode 100755 generate-bugreport-config-safelist.sh

-- 
2.27.0.111.gc72c7da667-goog

