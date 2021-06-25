Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F1EC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 09:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE7F6141F
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 09:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhFYJLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYJLC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 05:11:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3397BC061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 02:08:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id df12so12471141edb.2
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8mBkUqafHyL/wBoz0apOaQ+3uvlJP10Tr41UT8YD3IE=;
        b=RHT+Qe36CljYxv/prALHPZDPvKOI4dOB0GRFcuO1jjFElAKutZeDTp2S1W66MUgXID
         2EiOYa0h+G8u0/AMtcfK10yE43HfM5UOdVvenLx1wNwTBBvV1uVQmEQJIXZLHi+n1Sng
         UUNbDgeVzNJgK5wMJ+jdsIhP5uBwq6Unm/N9BTf6k6UEhAFepgvpIU2w543MklpfYPxJ
         jJSQrO77ACOUNSabRadbIMlwRU50afb3NvDtNNpyQzqvhXdwAPsJHpnwFlyliRbrlmTf
         UbPdZ5yDg9JM+CproM0D6GA0TIurXxL7Z9/S0MyeaCVQGbkjGkHRrhwYVgX2Nvl0fE+b
         3qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8mBkUqafHyL/wBoz0apOaQ+3uvlJP10Tr41UT8YD3IE=;
        b=ooAE4FLmTLY0ifl165mNJX3WKpORnFK1Xt9rJBRv9bNxnQ9NjdX/pmfLqebuMeQYDe
         2ByCg6uaqIrLfBs7HWD2orbxFlsufQtB66+Lh7Rc4OAD+WLslF4aP6rWgmfDtm2F0CBG
         9Pfbzs95fTcfBcnGpPEFC3kOgOs8Iuo7jHoLZqKgtqpYA2feLcVwKa9Le8ZfvmzRBYke
         k2S9871j8VR7UhwB8pN608T62PuhOpNXXobcwO4PwlvoNYq8fg0awumcMNMloMITjopT
         7erSSnNEJfTTDByruiawfeu1D2lh3CLUP/3uPSqn+jtwaomOlK5WodfC3sxNxpa8/ZL6
         LzuA==
X-Gm-Message-State: AOAM532JpNE5DWygrDLJQ4K2OsYOwNjEM1wgbpVrGJw5IJNSfGmIWzw/
        XtRpjegm7vbktuBfqzqtKLQ=
X-Google-Smtp-Source: ABdhPJxC9nPEqjDhJrZKUVpd340uVwcbQVa1CsycsZtVsSejO9zAIJWhzaOJLa2m9iYbZGUcEM9mOg==
X-Received: by 2002:aa7:cc87:: with SMTP id p7mr13075052edt.82.1624612119760;
        Fri, 25 Jun 2021 02:08:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r4sm2407799ejd.105.2021.06.25.02.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 02:08:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 00/24] multi-pack reachability bitmaps
Date:   Fri, 25 Jun 2021 11:06:21 +0200
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <cover.1624314293.git.me@ttaylorr.com>
Message-ID: <87lf6yxqeh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Taylor Blau wrote:

> Thanks in advance for your review, and sorry for the wait.

Thanks for working on this, exciting feature!

Just a note on my comments on this. I left them after some light reading
and would describe them as some combination of "musings", "shallow",
"nit-y" and "bikesheddy".

I.e. I did not have time (or I feel, the familiarity) to give this
series the sort of review it actually deserves as far as the actual
important bits go, i.e. nits aside whether this feature works and
behaves as desired. Sorry, but hopefully at least some of comments were
somewhat useful anyway.
