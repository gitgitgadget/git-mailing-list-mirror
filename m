Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0756520401
	for <e@80x24.org>; Sat, 24 Jun 2017 18:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdFXSVT (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 14:21:19 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35299 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdFXSVS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 14:21:18 -0400
Received: by mail-pf0-f173.google.com with SMTP id c73so37086185pfk.2
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=HXOwCg9Xw256doFpZHem8XEhXNKIiGXPVZHCXsaysPQ=;
        b=nR3C+owEfnTkPOKpH/ckbXG2YQsYsJyNBTilViuK3MZUxV4aC6hWkDloJ8pGspDL8P
         AmyBI02hNFKoejqb75pEZmkP3iBOPT7r0jbvGplurHxGC5HLSlpQjnH7H7WdyCQO6Y81
         ZI/4ASMSrbgsODzoeDm4HopDQRffp7GpF5HmY7U6r/KW4Or/gdM+Hzfe2lEyHzIJpjA1
         87uHO5ruIY8l3ZvzEVzi1l2rwteRaDaLXB2l4e6qkiCuMrx4P+BW+hGvgY2Lr7wna00Q
         JjwuW4cCW7pENexf1hsYjqVbtZhgeKQ9BYLeG32/6jZz9zrbkET3hUQ38BLPrLain/Le
         UU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=HXOwCg9Xw256doFpZHem8XEhXNKIiGXPVZHCXsaysPQ=;
        b=Rt9ZRpp2qNYkoyeLvW1ZNCzLJHJmYTcW7E1/gC8zyeYwainYWBaqlLOA8iWSV65wk+
         3vDrpD9yof4K1dMbHiVk8aTLTmWRuFnVevqcyP7ZBlH2x78qGcz7c7RNw/dLOiHP/eGz
         xqqJEe9N6v88AnbM6vY/rdYRgkFKqDowOnt37fD1YzP6UuZM00ocuCpAllyRmSmVdSxf
         sTkq2NkhsILt/DQbw/pNGNoc32M3ttc2bEjjGHMLpITWRKHlFxunis18vx2MNOoi2suR
         /ZoU24n74u5ncxGKAVWXuCQnY1Z7CujV54KWbGSSm4IUYHIsw9KXYJzD7nHCDPdiKFv/
         WrTQ==
X-Gm-Message-State: AKS2vOxZcXrK21ZhOjs6+Sbgsmbigk3iOj66VsZWbKHuIwWvC2G2rmul
        10yNZPYUHCkBXA==
X-Received: by 10.98.9.205 with SMTP id 74mr3494092pfj.77.1498328477478;
        Sat, 24 Jun 2017 11:21:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:c3f:f54c:5646:5c2e])
        by smtp.gmail.com with ESMTPSA id u78sm17231734pfd.109.2017.06.24.11.21.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 11:21:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/2] strbuf: change an always NULL/"" strbuf_addftime() param to bool
References: <20170624121452.7952-1-avarab@gmail.com>
        <20170624121452.7952-2-avarab@gmail.com>
        <9f3720e5-b8be-978d-4f6c-8c082aef3680@web.de>
Date:   Sat, 24 Jun 2017 11:21:15 -0700
In-Reply-To: <9f3720e5-b8be-978d-4f6c-8c082aef3680@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 24 Jun 2017 15:17:20 +0200")
Message-ID: <xmqqk2419rhg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 24.06.2017 um 14:14 schrieb Ævar Arnfjörð Bjarmason:
>> Change the code for deciding what's to be done about %Z to stop
>> passing always either a NULL or "" char * to
>> strbuf_addftime(). Instead pass a boolean int to indicate whether the
>> strftime() %Z format should be suppressed by converting it to an empty
>> string, which is what this code is actually doing.
>>
>> This code grew organically between the changes in 9eafe86d58 ("Merge
>> branch 'rs/strbuf-addftime-zZ'", 2017-06-22). The intent was to use
>> this API in the future to pass a custom leave the door open to pass a
>> custom timezone name to the function (see my [1] and related
>> messages).
>
> "leave the door open to pass a" seems redundant.

    The intent was to use this API in the future to leave the door open
    to pass a custom timezone name to the function (see my [1] and
    related messages).

perhaps?

>> But that's not what this code does now, and this strbuf_addstr() call
>> always being redundant makes it hard to understand the current
>> functionality. So simplify this internal API to match its use, we can
>> always change it in the future if it gets a different use-case.
>
> I don't understand the confusion, but of course I'm biased. And I don't
> like binary parameters in general and would use named flags or two
> function names in most cases.  But that aside I find the description
> hard to follow (perhaps I should do something about my attention span).

I share this feeling.

> Here's an attempt at a commit message that would have be easier to
> understand for me:
>
>   strbuf_addstr() allows callers to pass a time zone name for expanding
>   %Z.  The only current caller either passes the empty string or NULL,
>   in which case %Z is handed over verbatim to strftime(3).  Replace that
>   string parameter with a flag controlling whether to remove %Z from the
>   format specification.  This simplifies the code.

I think the first one is strbuf_addftime(); other than that, I think
this version explains what is going on in this patch than the
original.

I'll wait for Ævar to respond, but my inclination is to take the
patch with the above tweaks to the log message, as the change is
easy to revert if we find it necessary.

