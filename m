Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BEBC4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 23:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5E0206F4
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 23:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2jZWoFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgI3XXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgI3XXl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 19:23:41 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA40C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 16:23:41 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a2so1933586qkg.19
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 16:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NMoQPJYyZYrvpsWJU8rP3kXPZyaii+ELibiAHPIENoY=;
        b=q2jZWoFTfAuHVyaqvW5w1Xc643HBqzolFWp1ayYNKlJkxTNfMgH5QL1bOpnjSccShW
         71RGbeR2YUccIw9h17xoRtF8jj4xnluJQ0vLDFGIWohAJGaNubLkuIvZ1tGFoJfHTU8B
         o2u4IT+0S3PglSrrSNDVCzxF6F0u6s5WNEBV8ZuiMdd1jDSa1koG9tP0pZ8ww2DiM1Xa
         yg1zlDi8l80GCjzzxs4Rjeh2yVyCLaCVEJ45K5BAJvatPEwqjfukQ0DGuPRwKYRNYb4y
         7Dv0WlrFAJKl0UMhrG/pKgpKe80D2NtAtqGiM4QRmxNJxTy+lK9vKwQM/TQ84UDwQVQw
         EMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NMoQPJYyZYrvpsWJU8rP3kXPZyaii+ELibiAHPIENoY=;
        b=UF7S03NBWY5HdXcKMwC3DsrkTeEtLbemFWNzVKVLfpK6rnZxbx9RQKi612iUrkcOIW
         NzEhJeKjA4GzyoiNpez8D5PsyIYbATAFDFf0bJaQgNRL0hdpXIDnRFdeDLtjOiIGHMkd
         x8OIEqur9MgsHM/QCgWQCt2lPr0dwQq0DBV9lYHroq+nLvenP3OsilnW2SE4E52X/DcC
         Ck6biIWkB6PV33UVGH4p1IV0Yj/7zxKdDS5x0VkVb6EFz412irPvBRzBTJVKHQmlr0mr
         DHYLmjhN4RVuYQC2fz/2oBzbUY7lGdgfKXskZlNTrbwva4VPgu7AipkxdC+60P6iuq5E
         WwuA==
X-Gm-Message-State: AOAM531/a547m8Pz/cCL3hUvrg33PgO90Zt3wfSwgUz0dblW370XYskK
        wE5YZvKMUxTYggbBenw4g17aRsrsfp+iNhTZdq/DuMbtW80VTVoWPtXcY89i2nvZcEAgsNVJJMr
        0Um/O9T+y4/dXPT8inch4uYebDhbfi4Lp5Kw2ClqoUYiGrFzsWuiHs9ffD1Z1
X-Google-Smtp-Source: ABdhPJyhg1xn0YfFZtNU4mG+KKhS8ocPLRmv9dCeHMnHKckmrkYrI+9ne6++qX9i65n/Fy2D0AjShjyyvu1E
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a0c:b202:: with SMTP id
 x2mr4901789qvd.49.1601508220294; Wed, 30 Sep 2020 16:23:40 -0700 (PDT)
Date:   Wed, 30 Sep 2020 23:21:37 +0000
In-Reply-To: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
Message-Id: <20200930232138.3656304-1-shengfa@google.com>
Mime-Version: 1.0
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
From:   Shengfa Lin <shengfa@google.com>
To:     git@vger.kernel.org
Cc:     nathaniel@google.com, rsbecker@nexbridge.com, santiago@nyu.edu,
        gitster@pobox.com, Shengfa Lin <shengfa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Discussed with Jonathan and Junio regarding whether we should support
letting user specify timezone or restricted to UTC only. There was no
defnite conclusion. I think it's a good idea to start with this
implementation which might result in the change landing or e.g. a
documentation change.

The patch add checking for user.hideTimezone and change environment
variable TZ to UTC in the beginning of cmd_commit if it's true. As a
result, when calculating timezone offset in datestamp(date.c) would result in 0. 

Shengfa Lin (1):
  hideTimezone: add a user.hideTimezone config

 Documentation/config/user.txt   |  4 ++++
 builtin/commit.c                |  5 +++++
 t/t7527-commit-hide-timezone.sh | 37 +++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100755 t/t7527-commit-hide-timezone.sh

-- 
2.28.0.709.gb0816b6eb0-goog

