Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3431520357
	for <e@80x24.org>; Fri, 14 Jul 2017 18:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbdGNSsV (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 14:48:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34491 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdGNSsU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 14:48:20 -0400
Received: by mail-pf0-f194.google.com with SMTP id c24so11867328pfe.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 11:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UXHLDUe7kWxWT24H8zWztx3DmbFghzI9CgYbJc2K55Y=;
        b=Xf9+3HSQ0J5U6sLpVyoBYFzsRkZ2LoCWZExvHcjNfa2fGpb1ogccByGjGBxOct6F0H
         ej5JKsqKymvHw3SA2qqSTGCATuyv9+qxFsDIaaci+h2gkF3ptrvtertmuCXR2M6lbaU7
         IaMXEuywmOPodbk1i3aa9ed7mwjLYzzUwT/zsF6RfPbk7VnXyJ5PqCqOapi5RPUU39EU
         XdVRbBmEUN2afuj/KQJ5JBQpVABd9LYGmaVzKUn9vjhRkabf7ICEPkk5qaof/IPZWc5n
         Wxr9vGJAJllNJwJC7ESp46fNaULqnFqdcG1K1l5twwWaON/VlNyHiieDTbsUOvdaRsfa
         5sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UXHLDUe7kWxWT24H8zWztx3DmbFghzI9CgYbJc2K55Y=;
        b=Fhe19nAhCZC3kFrPq7pLFxR3QBtcHj6gweWNsWEPw0mDyRTbBq/HF/81p3oJCX2e8Z
         Kg3CXrqepdK3BqvlinudjqiFcs9Wg9aVbAfMPZt/5ydyXKYn9LO22bSjrcQer44Wvehi
         FMlnbWlJCXmob6iar3Ji2qBq60XY9SlmM0zteEljcY+/uePGbATJ+fpgajVl2fBi0RZb
         vIk3ajRjHwNgWVvOWjJq5Eu+5Q297GYEpBaqa/aTB727QuK7O6ZWoQnM/Yttgg1XwjHi
         EcXOFARGhoJQL45LFbb0HGa58uWKossiqiu+q2wa6+xYGOkDlLGjqM55wiEyQu8q8UOt
         KTtw==
X-Gm-Message-State: AIVw111VqjBY/1R/IIFgOHsOfC4RQ++oOkmZPrLRZmf9au5CnBLZ4cA+
        EGjXPJ5CNIYxQQ==
X-Received: by 10.99.54.205 with SMTP id d196mr16339035pga.79.1500058099665;
        Fri, 14 Jul 2017 11:48:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d522:5f:8052:2b20])
        by smtp.gmail.com with ESMTPSA id z67sm15399562pgb.58.2017.07.14.11.48.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 11:48:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
        <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
        <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com>
        <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org>
        <xmqqy3rw3rc8.fsf@gitster.mtv.corp.google.com>
        <xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com>
        <20170714173658.2q24oxhatwh5qrqk@sigill.intra.peff.net>
Date:   Fri, 14 Jul 2017 11:48:14 -0700
In-Reply-To: <20170714173658.2q24oxhatwh5qrqk@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 14 Jul 2017 13:36:58 -0400")
Message-ID: <xmqqd192rh1t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +static int clean_use_color = -1;
>> +static char clean_colors[][COLOR_MAXLEN] = {
>> +	[CLEAN_COLOR_RESET] = GIT_COLOR_RESET,
>> +	[CLEAN_COLOR_PLAIN] = GIT_COLOR_NORMAL,
>> +	[CLEAN_COLOR_PROMPT] = GIT_COLOR_BOLD_BLUE,
>> +	[CLEAN_COLOR_HEADER] = GIT_COLOR_BOLD,
>> +	[CLEAN_COLOR_HELP] = GIT_COLOR_BOLD_RED,
>> +	[CLEAN_COLOR_ERROR] = GIT_COLOR_BOLD_RED,
>> +};
>
> I think this is much nicer to read. I assume if we have a "hole" in our
> numbering that the hole is initialized in the usual static way (a
> COLOR_MAXLEN array full of NULs in this case, I guess)?

I would expect that would be the case.  

Do we need to have a check to detect a buggy compiler that takes the
syntax but produces an incorrectly initialized array?  I could add a
test to ensure that HEADER comes out BOLD, etc. (or we may already
have such a test) and then reorder these lines in this patch, if
that is the kind of breakage we anticipate.
