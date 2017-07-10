Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FFAE20357
	for <e@80x24.org>; Mon, 10 Jul 2017 18:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754845AbdGJSHl (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 14:07:41 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36208 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754780AbdGJSHk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 14:07:40 -0400
Received: by mail-pf0-f169.google.com with SMTP id q86so53707353pfl.3
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iaUfdMyuitLbI8ao+52Qs7v/HzcW9IEHROdqoX2hjRM=;
        b=P7hnZuD+OHOzMSTx3K2kdphQJId4Gq8DZ9A6HXXL9nUaQ/nRWUXwqamv8Pt+WWcmA3
         Nn/AUH4Ljvk1wgKwjzug0XmLefMOk0GM33PFw/rAPlYF0zNy0Sk2S5Y5FdFnDdcP+kcW
         +Zc5cb9avY/ASDYG3JShK/98/UHt2BSlHWL6EA3FTCOc0xeXChk23zdrFuaZwe4MOUvm
         Tlq6XB2fbRO/DmaxmvQrE0qUchmhWAZ1FO0M6obu4krKnw4+H0Lo7IhthGmHp2dL0MMh
         rD1zNpDfNXwTk3XiiuhsrNUb8EWo4FCbFd4E/qu0Nq6y0P2zQgOHcRVIXL252+fDg9bh
         Wc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iaUfdMyuitLbI8ao+52Qs7v/HzcW9IEHROdqoX2hjRM=;
        b=D+QmrO/+8Vty5r1QVkOSsXi8Z0gESzDs6dKxRdAWPSbCSSQalzMEfj6s4TgIqLHSdI
         R6IW6gE7rqix0FL9ySrg7UzL9sDjiuW6rxKg6RkqniihSDBIVfZNvDgICEZTtiE2BnAQ
         rhnEvWm7uxyA6UrWCtaUthVw8AGjk5tZWywE1g/wdcCKYxotnBhtZn2Uyfd+3qN+cs1j
         SSKlBqZs6UoeQIallFoZiPyXqiIHqugbOHxMazP8kmX1XqAB8jIlISgyKpC10kzMp5I1
         CcZ4BjWd75umKux/a5Ik4SAVbzXA0MOnaERizpzU69TpY6zxlKD0Jzbj4s5ad6Fw+2Pl
         eK6A==
X-Gm-Message-State: AIVw113T+XGy1GgR7Mk8MXNuBLTcfMh5eX6KzdLpDtJ/tcVqLFV+Rsds
        HXXjRPLs39abog==
X-Received: by 10.84.133.69 with SMTP id 63mr19297859plf.225.1499710059707;
        Mon, 10 Jul 2017 11:07:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id p77sm22442729pfd.62.2017.07.10.11.07.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 11:07:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] Makefile: add helper for compiling with -fsanitize
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
        <20170710132442.epsox4rawxlyvrw3@sigill.intra.peff.net>
        <xmqqefto6vqb.fsf@gitster.mtv.corp.google.com>
        <20170710174454.jbkednmzwts7yr7z@sigill.intra.peff.net>
Date:   Mon, 10 Jul 2017 11:07:38 -0700
In-Reply-To: <20170710174454.jbkednmzwts7yr7z@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 10 Jul 2017 13:44:54 -0400")
Message-ID: <xmqq60f06u8l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 10, 2017 at 10:35:24AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > You can already build and test with ASan by doing:
>> >
>> >   make CFLAGS=-fsanitize=address test
>> >
>> > but there are a few slight annoyances:
>> >
>> >   1. It's a little long to type.
>> >
>> >   2. It override your CFLAGS completely. You'd probably
>> >      still want -O2, for instance.
>> >
>> >   3. It's a good idea to also turn off "recovery", which
>> >      lets the program keep running after a problem is
>> >      detected (with the intention of finding as many bugs as
>> >      possible in a given run). Since Git's test suite should
>> >      generally run without triggering any problems, it's
>> >      better to abort immediately and fail the test when we
>> >      do find an issue.
>> 
>> Unfortunately I do not think Comparing between versions in
>> https://gcc.gnu.org/onlinedocs, it appears that -fsanitize-recover
>> is not configurable for folks still with GCC 4.x series, and this
>> patch is not very useful unless you disable the recovery for the
>> purpose of running our tests as you said X-<.
>
> I didn't actually dig into the history of gcc support at all. Back in
> the 4.x time-frame I tried using ASan and couldn't get it to work at
> all. I ended up just always building with clang (which from my
> mostly-ignorant view seems to to be the primary platform for ASan
> development).
>
> Since this is an optional build that doesn't need to be available
> everywhere, I'd actually be fine with saying "just use clang". But as
> far as I can tell, gcc seems to work fine these days. I consider this
> mostly a best-effort tool.
>
> I'm also not sure of the behavior without -fno-sanitize-recover. I think
> ASan may barf either way. The commit message for my config.mak from a
> year or two ago claims that the problem was actually with UBSan. It
> would be useful in the long run for that to work, too.

Yes.  I'd agree with all of the above.  While copyediting my
response, I somehow ended up removing one paragraph before that
"Unfortunately" by accident X-<, but the paragraph said essentially
the same "this is optional so it is a strict improvement, and I do
agree recovery must be disabled to be useful in our context".

Sorry for a possible confusion.
