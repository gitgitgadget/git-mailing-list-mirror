Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91FEA1F454
	for <e@80x24.org>; Thu,  8 Nov 2018 00:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeKHKJv (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 05:09:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33214 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeKHKJv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 05:09:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so9005030wrr.0
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 16:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JGUCurbWS27I7R+GdxgK85dy8Q966qVjqhba4CCePrc=;
        b=hXcV0/3CD3gimcczQ0pAOWdKiWFWcn5rpLGMuve/FIsiWxJEyzSKIVddp6b9tRspf0
         Qtqc1IkCyRGR66fEUglOWfwr2P2JTW/4aIaSAroWKhtlJRtB8DMBdiR2eKrnEHCwjWqv
         PrwwqP7hsrnjRL/QEcu9ENV9Nb+rN4cQi5AT1GTlkh2SVx/9kbNzOqRuAlHdnE2pSNR6
         f2zI0c8g7roG3nfKTiTMftqXyFcIH1MdOKm8HUPpCxQ3+Lqmjh8X7gQ4odOn3tl5+26b
         Il+W0hTM6Q6FO0ZBBnZbNGt3lnAHRPkdc5vOqwRUnA+ttzJGpnbxebfUFAApxixuh9vP
         dluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JGUCurbWS27I7R+GdxgK85dy8Q966qVjqhba4CCePrc=;
        b=d9yEfqVy1Zu6IY7vOD7axvv7NLi9ROzsVXTZFunuOIqddWuMT8EmbfXA/4658k21Us
         zzajBq6mIwheqzTLoQKN2g42S9pnn/t/dt0aAez6Br5TC4Ca6UjH/AZKGXIlfAZqHBXq
         WtDlsPZbU91mFYlNyfCgPFJ62X7ERPEFc4cWFwJImt5nqfxx1XBqX7+3yvGFnHsDl5rH
         jXxkOjHY237MR7LNVcrQTl621SNj1ZnZillM2Y3uuJIt68vJblimY+6fXB+3PKEKXqzy
         1AmIcFhcmjgm4zXGSlCQTAYMxeGLgNtBC8bdAII+3EA/JvgyJIdB3P+J5cEO1I0zgbUv
         qWOw==
X-Gm-Message-State: AGRZ1gIv7RE9fLRMgw9b8KiWnOlVPpvRgttuhryESRQpv26e3lTk26aV
        F6yMuKnzgB+9NmqdSPc2nGqG4hb0NAY=
X-Google-Smtp-Source: AJdET5cnsPz0u5V4dbMAgiGVdDtWIELt4QiHBeh71NjKkNmhWQCaSvwOGxNlwqDXqVsJj2gUPppXOA==
X-Received: by 2002:adf:f5cc:: with SMTP id k12-v6mr2102953wrp.59.1541637418721;
        Wed, 07 Nov 2018 16:36:58 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j189-v6sm4836566wmf.18.2018.11.07.16.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 16:36:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        andals@crustytoothpaste.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Support --append-trailer in cherry-pick and revert
References: <20181104181026.8451-1-pclouds@gmail.com>
        <20181106171637.15562-1-pclouds@gmail.com>
        <871s7y6qs9.fsf@evledraar.gmail.com>
        <20181106221118.GA9975@sigill.intra.peff.net>
        <CACsJy8DTdW-P9zG3DBPArjhZU1VwwBmd7qNibyHxYkyjRrdWmw@mail.gmail.com>
Date:   Thu, 08 Nov 2018 09:36:56 +0900
In-Reply-To: <CACsJy8DTdW-P9zG3DBPArjhZU1VwwBmd7qNibyHxYkyjRrdWmw@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 7 Nov 2018 16:30:38 +0100")
Message-ID: <xmqqh8gs9zh3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> There is still one thing to settle. "revert -m1" could produce
> something like this
>
>     This reverts commit <SHA1>, reversing
>     changes made to <SHA2>.

I do not think it is relevant, with or without multiple parents, to
even attempt to read this message.

The description is not meant to be machine readable/parseable, but
is meant to be updated to describe the reason why the reversion was
made for human readers.  Spending any cycle to attempt interpreting
it by machines will give a wrong signal to encourage people not to
touch it.  Instead we should actively encourage people to take that
as the beginning of their description.

I even suspect that an update to that message to read something like
these

	"This reverts commit <SHA-1> because FILL IN THE REASONS HERE"

	"This reverts commit <SHA-1>, reversing changes made to
	 <SHA-1>, because FILL IN THE REASONS HERE"

would be a good idea.  It of course is orthogonal to the topic of
introducing a new footer to record the "what happened" (without the
"why") in a machine-readable way.

