Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D37C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 22:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7104460EBD
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 22:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhHJWj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 18:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhHJWj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 18:39:26 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55CAC061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 15:39:03 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id e17-20020a0562141511b029034f8146604fso119439qvy.12
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 15:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+9GjZ+pkAtpGvUugjfvy5OIQJTf/AMj6JHy2ezj4UXg=;
        b=qVsybDzO7UtgILwZDXhT4QSarDql3Yi35jVm7whyr4HedzaqlDaolkShogVWSr421L
         3NKDAh+cSnPIO2gbXc1zd6/KsePX0oS0z/ZwTs6O4HDUrBrSOrQ64LqML3iZmoD442Sk
         b5RSWMxFoHjEQCSWC5tTKs3Sd/GrvCUT1+xRkgVDtEpYeCLmqXTohvP27o4JRRoawbmP
         MCVtaAPlnSo9CVA9UzNdFGEy6AT9NnnresjOqs+wK/sI81maFx+2WXzLuuZQP/xUq4f4
         39KV5oJbnSBb9MedbA+hvV6ITa6BEw/00v1NFQYepkCfJ34mHsGZHuDuo59DGNvZliCU
         zxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+9GjZ+pkAtpGvUugjfvy5OIQJTf/AMj6JHy2ezj4UXg=;
        b=N6Or7KhMWFDpyfkwkLLDnZ9FP/vVhT3cDhjKWMy/SGNMalD6Wj4Elx7pyBZw1a3SCX
         BVsWFVAbJV7Y6dEzUs3xFZkcFHRk8lxhBF8LtCe1O8kGAFDq5jueGEyR3HzLjs8NjHxL
         Wx1yISWURUFJ7PPr8OKe1z1CNLAuLr9n9o65yi/pGhpGLLwWn0mV7QogWB9dY0C/Nabn
         du/LqtVc1cgaMMyLhj1EWQsW37qnYV5utTiYmMFF4NzWHbPRmddbX2g5FY50DIBKTP8T
         CksGKbpqUIbA+DbAeKiuR6aYNRQoAClfafgT5N4fjOmcbFMVou5KFPx4XqYNrFQRJ5zi
         IcjQ==
X-Gm-Message-State: AOAM531l7VUcFKEVw3HcGgCNVu+aJSPcLH8NqR0gxpF11HvFoN0nX8md
        ErqAYhjKLvMHJZSY76WuCWrPV4YoeIscwOKxjBQE
X-Google-Smtp-Source: ABdhPJy4aOF6s0fSbx/7hHe0y2UkJmKlO5BIj2KSMEIyOwUJXX+l1qRPYx7RY/sUWGWwB5Hg26+VXG5LR/n2II6+jqnf
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:10c4:: with SMTP id
 r4mr31837749qvs.58.1628635143052; Tue, 10 Aug 2021 15:39:03 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:38:59 -0700
In-Reply-To: <CABPp-BFOusrK6E6n91XSXcKP8kin-8RX8L_HXdKRjS790HkwHQ@mail.gmail.com>
Message-Id: <20210810223859.2820306-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BFOusrK6E6n91XSXcKP8kin-8RX8L_HXdKRjS790HkwHQ@mail.gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: What's cooking in git.git (Aug 2021, #03; Fri, 6)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     gitster@pobox.com, git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm not at all familiar with the protocol areas of the code, but I
> tried to read over the patches too.  I think it'd have been a bit
> easier to understand for someone unfamiliar with this area if there
> were separate patches that introduced test_expect_failure showing the
> particular failures being fixed, followed by fixes in subsequent
> patches.  I also noticed a stray newline removal in patch 2.  Those
> are pretty minor issues, though, and I didn't spot anything
> substantial.

Thanks Elijah and everyone else for discussing. I don't think I have
anything to add to the discussion, but just to address this part, I do
try to write my patches in such a way that in each patch, if a test is
included, it would fail if the accompanying code change in that patch
did not exist. Just in case, I've verified this with my branch by
splitting out the tests and code into their own commits, and pushed it
onto GitHub [1]. The tip points to the exact same tree as
jt/push-negotiation-fixes.

[1] https://github.com/jonathantanmy/git/commits/push-negotiation-fixes-split
