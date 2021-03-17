Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7A7C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA0B64F20
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhCQVsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:48:54 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:45947 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhCQVsa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:48:30 -0400
Received: by mail-ej1-f45.google.com with SMTP id va9so704376ejb.12
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDXmSfKW3WC2I8AQFr4u5thaPC53lu9NDw+WFdqvYKk=;
        b=hhQarIHQSt2bW5HAbC7N1fs+SyqUCWoraB1CiyYLVnFspx9XSTUYYO6CtygzL4S32Q
         doCGNxwZf6euUdlIg8viUndxTwEm4rKxv7gjSOTW1tc1XVATy27asJMHndi4NDed1ahR
         qbfdVHxmaZwFnwJ2nZloqxLTJP9cLVrwIrrBTrIr27jFqsyQ+r/rZVcnKVQ+G2tL5TFW
         VHRVFTrkVMXfuhNicLwZqGkt2YBbBe/Z/p5pwy0KmArdfs1+SPnleZShgMq300XzDa6i
         Q9dTRwiZpPxK/I3Evh2JsfksJ7TPph6FvCwnXKuVf+eO8B9wyYuNPKQb7sqnZXa9uKJQ
         uZqQ==
X-Gm-Message-State: AOAM532wsSuNupGpFngG9VxWce2ywTPaBfX72uQRdnGjLfZV2WlXg2hw
        tS1TXE26uMo7hXGjeG6/Aikbxo5/kORzZij9fEo=
X-Google-Smtp-Source: ABdhPJy3/wb6E7wzkD8Leed+ODKhqJ1QUSDwG7ncRYKkDVXittlpUiB6llEsm0d9p+dD7k9WuZS9iA9zNHZWUo+UiM4=
X-Received: by 2002:a17:906:d8c6:: with SMTP id re6mr36541307ejb.311.1616017709452;
 Wed, 17 Mar 2021 14:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615856156.git.liu.denton@gmail.com> <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
 <87mtv2dk18.fsf@evledraar.gmail.com> <YFI9QzKMKLMXYoyz@coredump.intra.peff.net>
In-Reply-To: <YFI9QzKMKLMXYoyz@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 17 Mar 2021 17:48:18 -0400
Message-ID: <CAPig+cRk-fCLFtug47w3trYQFiPzZ3bD4g11Qu4fTd3Fh6_bCQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] Makefile: add 'check-sort' target
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 1:34 PM Jeff King <peff@peff.net> wrote:
> TBH, I'm a little on the fence on whether automatically checking this is
> even worth the hassle. Doing the make function above was a fun
> diversion, but already I think this discussion has taken more time than
> people actually spend resolving conflicts on unsorted Makefile lists.

I had the same reaction. Like you, I jumped in for the fun diversion.
It allowed me to flex my Perl muscle a bit which has atrophied, but an
out-of-order item here and there is such a minor concern, especially
since they don't impact correctness, that I worry that such a CI job
would be more hassle than it's worth. Making the feedback loop
tighter, as discussed elsewhere in this thread, makes the idea of the
automated check a bit more palatable.
