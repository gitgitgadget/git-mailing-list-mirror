Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0430C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE632065E
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BgQ1T1Kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgG2WzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgG2WzW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 18:55:22 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F719C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:55:22 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id nl2so3198106pjb.7
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CkAQiFBW8Snp2vSmOrIneG72Bo3wayn3mi8tldGtgd4=;
        b=BgQ1T1KzWZn6eT1OeKyvqEDEUQt6d161Dtly+8pshCXerqfX5I/OmrLmSxBySr6eAo
         lizlbblsJX2od9lG5fw5OF2Z+TYILiRzAdRWZHMcd5gnKu0g54VAM2rM6qvi0Gtmfd+L
         RNA5Dt0JPpLwAO9kgQriNGmi6vsWnR04ADVAjz+MX7hwwg48FWXfvyu7cpbcs2yHHFTe
         /Lyh2LysP8x/2+kmgfNbg5di5rOgmbSblXYomopP/f51RHEbBUqU2RGWROi2OnzagjSo
         /QF1PU8fPsbk9gGCF4itieQncYG/WAu1cNtfscpLMUV5NvOaW1zdgcaI+WnHrZQGWTx8
         9iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CkAQiFBW8Snp2vSmOrIneG72Bo3wayn3mi8tldGtgd4=;
        b=BRwxHpRdSCxD24wMVjqoPkRx/funu48TXrwPQ7+RviaXz0gJeoPvZveCZvWwOB43FU
         1YwuEyNPPSE4/DiBIkCYJ+ZVepwq2cNkiqblCYaSzXMuDnjiOmLSK+HAQc1wMMq4vGGt
         azCR4nPlxbRMkLpZ814/NbITCClHUvWKrE9dYIeIYZQnW0kB+OS8at5AvEuZ36wMVWGd
         I1jKA40etPOFWKchlNbvQAgRJCzGDiqH+GTqo01AUOmsNaKeqeSlJtAkJzn0DfRMHfWQ
         kQ5k2x4ElamUdPo+h8kjUEnVCjuhVjyJAhmceHQXJjbXonf5w2rV27P/CZUvgoPjAJAm
         3g3w==
X-Gm-Message-State: AOAM5327kjgdpLFsRHfiYN409uHwBao158abqYWZ0j1F6g9E7jChOtwu
        TXl9qWDLyTno7bh8DeR0stYtYL/IdeMjC0cd9aZo
X-Google-Smtp-Source: ABdhPJx13lD2t21293B1HtdA53hSrjx7DB5UwEuG/4HZCJvuddv6Q6bi86w87W6N3FtGsru5t3YS1LHqz6uFoRd/yhds
X-Received: by 2002:a17:902:be17:: with SMTP id r23mr29539210pls.284.1596063321699;
 Wed, 29 Jul 2020 15:55:21 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:55:18 -0700
In-Reply-To: <xmqqr1su9mbf.fsf@gitster.c.googlers.com>
Message-Id: <20200729225518.700585-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqr1su9mbf.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: Re: [RFC PATCH] Modify fetch-pack to no longer die on error?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     peff@peff.net, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The "more naive and stupid way to run them as subprocesses, just
> like we do for cURL based transport" was primarily because I thought
> it would be easier to get right (as the transport API and interface
> has long been established) than hunting down all the callers of
> die() and touch all the functions involved in the callchain.  I
> won't complain or block if a harder-but-more-correct approach is
> taken ;-)

Well, I was prepared to do the harder approach (as you can see from my
first email) but it will be harder not just for the author but also for
the reviewer and future readers of the code; now I think that I should
try the subprocess way first, especially since there is another part of
Git that will do that too (the maintenance prefetch [1]). I'll try that
and write back about how it goes.

[1] https://lore.kernel.org/git/3165b8916d2d80bf72dac6596a42c871ccd4cbe6.1595527000.git.gitgitgadget@gmail.com/
