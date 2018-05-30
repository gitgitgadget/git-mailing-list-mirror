Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D98C1F42D
	for <e@80x24.org>; Wed, 30 May 2018 06:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934498AbeE3GAm (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 02:00:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52133 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752182AbeE3GAl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 02:00:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so17832430wmc.1
        for <git@vger.kernel.org>; Tue, 29 May 2018 23:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pHmWSRwg9Q2atVFby/sFvH+Ru2JQNcabTdn6GspnRxs=;
        b=qiO63vJ80d1TLUvcGnV+cbXQTMXDAnXWH+1wBlqchmbTjPHUGm1Q3jGapVz3dII25n
         yEyGtqo7so6qUg66/NYoGN5Vw82a/KgnFDCq6/GkPmVf9jLn8qW82VK+KwjLoMMvOgGN
         iGNB4G6QHQ6SQJFH+EhErFj5HterKViZPHzKr5yKh+HWUuEP1AU6qvgIhfAYvBLfTIPM
         P5ofxzrHBARffoymyR6bjm/zjwmtvs6hxuBIYnOuvvql6yA4N8BRIbaaBgP1fdxGlRWV
         bLo98QgoylL2f1feUfUm4MpLdBwKRuM4By5ZAu6fzXUchXU1RuAfflDICDBr3r/NX353
         LhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pHmWSRwg9Q2atVFby/sFvH+Ru2JQNcabTdn6GspnRxs=;
        b=G0NhnJqnsRLiLtzmAgdBqR7QTL6Ub3m5YlfmVe4bggwt482fVWknvBEHZ/+TXYwaxs
         3PB/QBweIcBMz1Khl5E8y5caD3y3at61Hs7bBu/DgxZZIkBDGAsPNWfnVn7yxs4VloNT
         1RUEldcTZvL0r0p6W7e/uci4udtota7OOlDevfwnW7M4FplJN5PDmyE80etpAVkNQMHQ
         c1/aeyWE7dB2GUOosI1blDqz1c6M8BAiYUSm+tqUvYeveVcpWheCZl24w2XIYYkiayAm
         cjStU1mby2+rwu+adTesTNPxj40doCPt8nHHq430wEqzSW5dkiEHpRYVw5eeSdBQldYv
         w7Qw==
X-Gm-Message-State: ALKqPwfl2SkKdSFxwij0hEg8dVr5QbrLn9JwQIPcVFSV+g+TYoxzTbdS
        nFW1PX6EBkdsn+hnWae/u3Y=
X-Google-Smtp-Source: ADUXVKJKieHBOpIopQa1gahybYQFCpzRyOF4ktLibDUAE3gMZvGfM/hU/zCcu9Xx/IV57K7gNlZBGw==
X-Received: by 2002:a1c:3e4f:: with SMTP id l76-v6mr343659wma.145.1527660039384;
        Tue, 29 May 2018 23:00:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x70-v6sm18015440wma.9.2018.05.29.23.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 23:00:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 1/3] usage: extract `prefix_suffix_lines()` from `advise()`
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
        <cover.1527279322.git.martin.agren@gmail.com>
        <90ac0a41563f070a840076521d8935ad7c21beb9.1527279322.git.martin.agren@gmail.com>
        <20180529213957.GF7964@sigill.intra.peff.net>
        <xmqqfu29gbqp.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 30 May 2018 15:00:37 +0900
In-Reply-To: <xmqqfu29gbqp.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 30 May 2018 10:42:38 +0900")
Message-ID: <xmqq4lipel8a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> But most importantly, it means we could eventually colorize errors, too,
>> where we are not allowed to allocate.
>>
>> So perhaps:
>>
>>   void report_lines(FILE *out,
>>                     const char *color, const char *color_reset,
>> 		    const char *prefix, const char *msg);
>>
>> or something?
>
> Sounds good to me.  And if you hate the repeated "error:" prefix
> that makes the prefix on the second and subsequent lines included in
> cutting and pasting, we could use the two-prefix idea elsewhere in
> the thread, too.

If we do not want duplicate prefix, another approach is to leave
everything including alignment up to the translators.  For example,

        error(_("the first line of error.\n"
                "       ... and the second."));

could be a valid way to produce

        error: the first line of error.
               ... and the second.

on the display, and get it translated to

        ERRORX: THE FIRST LINE OF ERROR.
                ... AND THE SECOND.

with these entries for that hypothetical "shout in caps" language.

        msgid "error: "
        msgstr "ERRORX: "
        msgid "the first line of error.\n       ... and the second."
        msgstr"THE FIRST LINE OF ERROR.\n        ... AND THE SECOND."

So I do not think the two-prefix idea is necessary (and if people
prefer to have repeated prefix, that can also be done perfectly well
within this scheme---the second and subsequent message needs to
duplicate "error:" at the beginning, which is sort of ugly, but the
leading spaces for alignment we see above already knows how wide
"error:" and its translation is, so it is not that much worse
anyway).

But still, your suggestion to allow color/reset so that we can do
without extra allocation is a good idea.
