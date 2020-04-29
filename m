Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31711C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2072083B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgD2WtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:49:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44794 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgD2WtE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 18:49:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so4490222wrg.11
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5jPgVT+3Pe1LCJjQ+rgSU6mqtxepivbDu0uzlxCPvk=;
        b=EfjT914A/oYWIh4uNQtRftJxr4GTyN7GhOkKe5mSBk7OXSnFY4UkaIpwbXyi6xs2Q6
         tEiP9jqRX/lPOVaJxiEaw7aP7YjAHrsEjfYgSnHFCuplhjdfAQ8UsoEfrPeZdWnMjkDD
         Xku8nnAyBgQAgfEKzQ5ekfq8OaigYU6XMy9LpQ1rd1z6lWBRVuYUC5aOzAOMq3zUtNl/
         LYPlca2igMtP6IIab820HyoJDAxUZ1N4o253yHtbGMgLEa1jyde6SIMSlYGu1yRH5XCe
         Nd8hEU5u4Sjrrb+bp7OHxPcVQ7kU7+bnOPjqblCMsCyNbHCUBedLAT56DFQt5XKxcs/b
         i0DQ==
X-Gm-Message-State: AGi0PuaRUxO/ZA7slLfoDQ51hHcTcP59lf79CqUBg6wb1oTOhh2SINwM
        PwMVMHnIZ6g+NgpYtGGER+N5ME5KbcAyBVo48yM=
X-Google-Smtp-Source: APiQypJD3y23qtaf+KY5ul0T1lBDQRZ1rB8TwwbJVnSPgsQylcNgQlMe2ILBfu2LEnVsod9iCHEOWTe+LoyhvcwpjN4=
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr244237wrx.386.1588200542076;
 Wed, 29 Apr 2020 15:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588199705.git.me@ttaylorr.com> <0b93abe072aa35ab96ba3b97118caa8ffe8e439d.1588199705.git.me@ttaylorr.com>
In-Reply-To: <0b93abe072aa35ab96ba3b97118caa8ffe8e439d.1588199705.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Apr 2020 18:48:51 -0400
Message-ID: <CAPig+cS4K=crmPqdb0xeoD0H9FGCYdxb4GhQLCoRPEs-uurz6g@mail.gmail.com>
Subject: Re: [PATCH 2/5] shallow: extract a header file for shallow-related functions
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 6:39 PM Taylor Blau <me@ttaylorr.com> wrote:
> There are many functions in commit.h that are more related to shallow
> repositories than they are to any sort of generic commit machinery.
> Likely this began when there were only a few shallow-related functions,
> and commit.h seemed a reasonable enough place to put them.
>
> But, now there are a good number of shallow-related functions, and
> placing them all in 'commit.h' doesn't make sense.
>
> This patch extracts a 'shallow.h', which takes all of the headers from

Did you mean s/headers/declarations/ ?

> 'commit.h' for functions which already exist in 'shallow.c'. We will
> bring the remaining shallow-related functions defined in 'commit.c' in a
> subsequent patch.
>
> For now, move only the ones that already are implemented in 'shallow.c',
> and update the necessary includes.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
