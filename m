Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EA3F1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 20:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeGPVZ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:25:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37164 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbeGPVZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:25:58 -0400
Received: by mail-pf0-f195.google.com with SMTP id a26-v6so4792567pfo.4
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 13:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=frsk0pGw0O7yPJ4+gZ1FCJOOMYsh11ZVIlRHhiSWrIo=;
        b=YTF0W4zLvJfLxvfYQFFgrgnvt1HPsJ7xJugzwDo508Uu4zIYfM/NIMi1yV4j8UU8HK
         Tq+AZBx8aNqe+GH0r/e/CnPEEBHSLOLxXy+8djWBrVBnXC1BgOQtNE9BJuEMg/GY1Anx
         Q1T/InxvOzrYnuB56SBoKG5vsRGI7MEIPF7fB9CtrglHB98TQm7tBIyv9YJ+bGVu0fj2
         4Ro3xYcT/nW0L2pfEeySOAMqXenKefiCYWWQC8akqMBz+Djk31IT0dgEnhwFd/lWECgh
         pdFdyX2P+W5FSiWAt3bTYufRo9U2jeJ77E97iC/SehXbFPpOam3vAb+oAwAnoKu3zwq3
         Xngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=frsk0pGw0O7yPJ4+gZ1FCJOOMYsh11ZVIlRHhiSWrIo=;
        b=bOOdjGiQP9xYcpBNkoC0yprXNvSpZaigv8TtkOXHsF7L/3oMQTkcV0wZD5yVPQBs6Z
         bgj8PuksCoA4+vPXpckco8/ABjWWUX6aQiBXr4Vf8q9imbw/ZUyubxMr6b4LiicKWlet
         xd0u55YByHUMys4bY2eNQ9jzP0FZ/D3gPSQSwY54C3mqyINaOtV9SAVFaSu7j+Bww6Vn
         PcTE+eYocd1PxGjcMjzrZdyf4AQ8YY4P9Ghz9SPA21L1Zt8fxaTq70pCCDPQS1qwWI+5
         0orVI8eTG8o6q76CF5Obv18R+ARHQSO01WGSMGkpcv5DRL9QwVUvckqwbfX7w7o2Co4W
         jy7w==
X-Gm-Message-State: AOUpUlGCdVQf+NXOezp8FMbLpK1vCeUtIyyrlu/jYBZqhTmS9zfGz5yE
        L1UJBISsIdOdYZMcAOatlk4=
X-Google-Smtp-Source: AAOMgpdHIUJsddYOmHbaPPk1xyv2/zd/HF4QKiE8bgdBgsS9Qt9TOcQ+Ke/lr9mBpNCw45VDnmhHNQ==
X-Received: by 2002:a63:f919:: with SMTP id h25-v6mr16368656pgi.401.1531774608930;
        Mon, 16 Jul 2018 13:56:48 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y33-v6sm61939115pga.41.2018.07.16.13.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 13:56:48 -0700 (PDT)
Date:   Mon, 16 Jul 2018 13:56:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716205646.GF11513@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com>
 <20180716191923.GC11513@aiede.svl.corp.google.com>
 <CABPp-BGN4NeH2QAP0WMyuOdr2GYq+hpt9584wdn2jHHinEAgDg@mail.gmail.com>
 <20180716203539.GD25189@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716203539.GD25189@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Jul 16, 2018 at 01:21:40PM -0700, Elijah Newren wrote:
>> Jonathan Nieder wrote:

>>> My understanding is that exploding the objects is intentional behavior,
>>> to avoid a race where objects are newly referenced while they are being
>>> pruned.
[...]
>> Ah, that's good to know and at least makes sense.  It seems somewhat
>> odd, though; loose objects that are two weeks old are just as
>> susceptible to being referenced anew by new commits, so the default of
>> running 'git prune --expire=2.weeks.ago' as gc currently does would
>> also be unsafe, wouldn't it?  Why is that any more or less unsafe than
>> pruning objects only referenced by reflog entries that are more than
>> 90 days old?

Part of the answer is that this safety feature applies even when
reflogs are not in use.  Another part is that as you say, you can
start referencing an object at the same time as the reflog entry
pointing to it is expiring.

[...]
>                                    That's why we retain non-fresh
> objects that are referenced from fresh ones (so as long as you made the
> new commit recently, it transitively infers freshness on the old blob),
> and why we fresh mtimes when we elide a write for an existing object.
>
> That's _still_ not race-proof, because none of these operations is
> atomic.

Indeed.  One of the advantages of using a packfile for unreachable
objects is that metadata associated with that packfile can be updated
atomically.

I don't believe we are very good at transitively propagating freshness
today, by the way.

Thanks,
Jonathan
