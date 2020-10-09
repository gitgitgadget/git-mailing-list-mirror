Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883BCC433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 05:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2959522255
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 05:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=webstech-net.20150623.gappssmtp.com header.i=@webstech-net.20150623.gappssmtp.com header.b="iU0tO8Y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgJIFAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 01:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJIFAb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 01:00:31 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67792C0613D2
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 22:00:29 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w12so9436583qki.6
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 22:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webstech-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7ROJhVJCFW5UlsC9udMheCOX/Beb9qJ/1xfiz882ro=;
        b=iU0tO8Y/ebI4+N6gZbKpd3sB2iVmCXVgbakyOAaYn7/xgDt0yCjgrYGI5JjDkaP4lM
         KTLZG9ILTUdMO3Cn0nzpvk6C0n9sysbG9jZaZ11PNCrJv22yYYNuCG13dYI+11rpuhee
         JoAuoqTvzPQnRk5+FzN5uVInvTKAsNHO3eTg/B5lo8Jmyt06hU+FIqFT4mVgOnwTEoxb
         5xcyVUr0tOETgSwoWVwOGanwJMfFbvRFB4Rx9asXDZD0eKcwpapn5LEp7+NOc07I9eXE
         +h2SDYIb9Eb1788rPP6zQXDaRfdIbnaCRBo9O7osMkSgnfsH3tsPPUYKKc2xwqsISB/A
         2BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7ROJhVJCFW5UlsC9udMheCOX/Beb9qJ/1xfiz882ro=;
        b=ovZPv2Yel2R92T6ZRFpbCWOPmd5PO9NGblqVa3QTqPkEyPh7VKHC7+HNqxCvr8qT2G
         rHewozM7SPuTcpTBBvFvtUxPScokPzg8yb00HIr5Vps5PZvgYLu5xd2ZdWrV+JHFX1Fh
         nQDg/SnyUlCxm4oghXYszlbUJtolMAbuMTmOV2MY4RuSoHl+p8LOCqSqjPykgFllfmb7
         8BixsbwLsVm9qLO+m79bhrtIflN+yVNsynz9AHFpvf9UJZhYDss53ln6F74k5pBEmsaS
         6BbYr0BllXxv05FCl4kpXtr2IWIlRQ+WmN1NksNWsYe+jSnZ4wPIMLLpabj6iki1qPv/
         raxg==
X-Gm-Message-State: AOAM533zYH3TxRaPFmlalgNf1jS5eBk3X+oOcYOUGy0F3e772+XSrqgC
        QA8j6JE46TXkOVEV+HAIAWfC7Mrc/iD3o2Y9Uso2XQ==
X-Google-Smtp-Source: ABdhPJydiBo2s3f+2FcuNv6XJuCBxeTDBP6DEvTvzkj5jxIf6LZESN7TRO1Ll5Xq7mJMzY7apD9qe9UfN4y0sVamC5g=
X-Received: by 2002:a37:52c2:: with SMTP id g185mr11042232qkb.283.1602219628455;
 Thu, 08 Oct 2020 22:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
 <20200922170745.GA541915@coredump.intra.peff.net> <xmqq1ritlmrk.fsf@gitster.c.googlers.com>
 <CAGT1KpU4Kjv2PEAA7-bNbGp2DFvfsKqABuUK68128xkLjdcEhA@mail.gmail.com>
In-Reply-To: <CAGT1KpU4Kjv2PEAA7-bNbGp2DFvfsKqABuUK68128xkLjdcEhA@mail.gmail.com>
From:   Chris Webster <chris@webstech.net>
Date:   Thu, 8 Oct 2020 22:00:25 -0700
Message-ID: <CAGT1KpXz4nFBu2xkVSaoW4DgXc_5oB69MQRQW=365gfgd_R-mQ@mail.gmail.com>
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is this waiting for some action on my part?  I thought the question of
running on push vs pull had been resolved (in favour of pull).

thanks,
...chris.
