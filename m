Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49CFE1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 23:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeIZGGS (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 02:06:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53484 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIZGGS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 02:06:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so336416wme.3
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 16:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jbEAEIJmnhsJqv/owd8Qi5D9NpKCD5iO934W03lHRe0=;
        b=oCHPiVFRfwh/b3rjmfHUAOctuIJloPCSzIHVg6ZSZYwM0+2MIEV6iX+UNIUwfqCLPp
         F+5E6ZbhBXDFcFhRFE/VbLvgWqNJhORaUTudU9WxODiRonlnEMXIl08pXmVwGZC4sfRl
         LuLH6su7S7pqGHWqnE/yn3ycvnR1TKH5+fK8hdo9zCxygBSfeIV1cLeaYIMnt3t6Olhq
         9d2cn/EgCdru22nPeexp6zKX90vLvhCltqzgvDchoeosPNCIi/0Kd+qRqjep6Mtw35pY
         P8fqXye4NdTVKtPag+Yi+bz6S2XXZL21nJ8Kd4zGtsSISlZfvYGIB3qjAsIT5AD4UiEL
         3Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jbEAEIJmnhsJqv/owd8Qi5D9NpKCD5iO934W03lHRe0=;
        b=iiQ4SyarHlk7U1HR2M3NW0nePHBHk07ZlifZ5ISvWusvqxypYo483/P4KT21KGgILz
         WslFjDVjjq+Ei3ounYnBNDq4MT26mIOdHZHTayL4lqd4y5VX0vhw0Rbi4WB4Av8rYS1K
         fpC+CXPccM987UWyNvfho67AzPyb7ix1ik3FLRJYhyg/pCXNZOHBc9+rA8JhgSIph7/T
         7H7sKVKLIUXIMmyNfZyltpoyc96ECpteJ86iveg3thopd6pJmB/g9xJ0EXeRz+x1SoDK
         ePBCxKYUhEiyFle3qYFQIU/ZiQWNprc+KzX+mTQ50FGAGbJr5ObNAMIcCF7Ry5Q1HoJm
         I7/Q==
X-Gm-Message-State: ABuFfoiPbBFZU0mzrbsiPDQRDgUgoYyF0P+l0GQavDWBJo0SNZH0ubNh
        0dhroLWVBhHdGTsSkiH/+ZiFRT9B
X-Google-Smtp-Source: ACcGV61E1+tjXrnnQ86USKb8YofvW510exCXThFTvUu4y/BSwvc9S7EUU6qBofA8GxIwmva8gcoFIw==
X-Received: by 2002:a1c:5801:: with SMTP id m1-v6mr2513583wmb.135.1537919774081;
        Tue, 25 Sep 2018 16:56:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f9-v6sm2670227wmc.24.2018.09.25.16.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 16:56:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
References: <20180921213753.GA11177@sigill.intra.peff.net>
        <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com>
        <20180921221832.GC11177@sigill.intra.peff.net>
        <xmqqftxzsz5x.fsf@gitster-ct.c.googlers.com>
        <20180924181011.GA24781@sigill.intra.peff.net>
        <xmqqa7o6skkl.fsf@gitster-ct.c.googlers.com>
        <20180924205022.GA26936@sigill.intra.peff.net>
        <xmqqva6ur24y.fsf@gitster-ct.c.googlers.com>
        <20180924231455.GA7702@sigill.intra.peff.net>
        <xmqq1s9hqxtt.fsf@gitster-ct.c.googlers.com>
        <20180925224645.GG4364@syl>
Date:   Tue, 25 Sep 2018 16:56:11 -0700
In-Reply-To: <20180925224645.GG4364@syl> (Taylor Blau's message of "Tue, 25
        Sep 2018 15:46:45 -0700")
Message-ID: <xmqq4lednnc4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> My reading of this is threefold:
>
>   1. There are some cosmetic changes that need to occur in t5410 and
>      documentation, which are mentioned above. Those seem self
>      explanatory, and I've applied the necessary bits already on my
>      local version of this topic.
>
>   2. The core.alternateRefsCommand vs transport.* discussion was
>      resolved in [1] as "let's use core.alternateRefsCommand and
>      core.alternateRefsPrefixes" for now, and others contributors can
>      change this as is needed.
>
>   3. We can apply Peff's patch to remove the refname requirement before
>      mine, as well as any relevant changes in my series as have been
>      affected by Peff's patch (e.g., documentation mentioning
>      '%(refname)', etc).

I do think it makes sense to allow alternateRefsCommand to output
just the object names without adding any refnames, and to keep the
parser simple, we should not even make the refname optional
(i.e. "allow" above becomes "require"), and make the default one
done via an invocation of for-each-ref also do the same.

I do not think there was a strong concensus that we need to change
the internal C API signature, though.  If the function signature for
the callback between each_ref_fn and alternate_ref_fn were the same,
I would have opposed to the change, but because they are already
different, I do not think it is necessary to keep the dummy refname
parameter that is always passed a meaningless value.

The final series would be

 1/4: peff's "refnames in alternates do nto matter"

 2/4: your "hardcoded for-each-ref becomes just a default"

 3/4: your "config can affect what command enumerates alternate's tips"

 4/4: your "with prefix config, you don't need a fully custom command"

I guess?
