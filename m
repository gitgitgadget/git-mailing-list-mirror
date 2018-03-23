Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B423A1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 14:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbeCWOgL (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 10:36:11 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:40271 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbeCWOgK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 10:36:10 -0400
Received: by mail-wm0-f41.google.com with SMTP id t6so3946402wmt.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=6Uxw0prTifPaa9dwCLscXWkN0lW4CiyafFk1D1bktl4=;
        b=Ar3rEUukgv9hMxadw9RUXm9zCozWbUoVYxilPmS5RBLP3IGW2nBG47o7C4ueAs0Owt
         8XzWmqNYXc2v2OmvvoAvmCTexBgzyMhmyes6SSsEmYlH/8ijL+N52UW18hvU1GvEZu+Y
         a8isDCwgYkRYN/SlCZp4Hd4al77WHYaGnIsF+MiQf6uoyojbzh340gYKblEx12CY4XJd
         JL+O6fA5gsS6+Kxnpi1rPjkvefNveiSyf6sIS+HxXm8AVmFjUHn04U5a6DmicO42tD2T
         hjEWu8/95e4ku+Wz7BybzWtcUE6xwX87Snb1a6YA2Us8nHmv0J4CfgOM3HuJtGk8a6ck
         sNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=6Uxw0prTifPaa9dwCLscXWkN0lW4CiyafFk1D1bktl4=;
        b=rIRNQGUjCdhO6AAungtEO+Z0sLHHhz3KUZ8GUcd+1iCrbPrCQr9Fk/9NS/2nVgWXyQ
         SXCTxKsh4iSk6PBCFypK6sq2wTcOrMuoHlmGfY9gD16uXx0QHQIy2Qzt6Je1ZJb7QGUS
         CxzMoiOoWoaEXAuSaUObEbRkakZt9L28aJIF1sTLyZJ5fzLjQsg+Lo8qdr8wNshWANDa
         b+4YK2ELC/d16dt3ZR7Lj7fVe/JO3jpCzZ5jGs2vcCbLGmmjcWEKxHyqV6oUmCtZCX7k
         djXbO7Dtao9Tf+z3C9+FdrwN9GdsiTinSn3pV08d0YeOIh/lBhzEEQ86ZSxInmkWb20S
         AelA==
X-Gm-Message-State: AElRT7EP+JyN5sHgfWeeqMQFvn074yGPl5FcuDAITrtPmI99lw79Dyl4
        WHvK0Zp3GTPmHmw15TIu/6k=
X-Google-Smtp-Source: AG47ELuqZhPYXjKnGNe0KT5wvGqvr3l2ukXBTVYXEMT2fFbryrGQvhaDXoocFVXxoByLCw607KZS2Q==
X-Received: by 10.80.180.216 with SMTP id x24mr22122661edd.126.1521815769435;
        Fri, 23 Mar 2018 07:36:09 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id y46sm4146159edd.77.2018.03.23.07.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 07:36:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: The most efficient way to test if repositories share the same objects
References: <14d0937f-0e39-7af7-a395-3046ec5d5c16@linuxfoundation.org>
        <87o9jfyl0y.fsf@evledraar.gmail.com>
        <xmqqlgejlx8e.fsf@gitster-ct.c.googlers.com>
        <906555df-e906-775a-0255-fbc71f7138f6@linuxfoundation.org>
        <xmqqa7uzlr8x.fsf@gitster-ct.c.googlers.com>
        <179c3cf0-72bd-559a-1e00-b18ce97e8136@linuxfoundation.org>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <179c3cf0-72bd-559a-1e00-b18ce97e8136@linuxfoundation.org>
Date:   Fri, 23 Mar 2018 15:36:06 +0100
Message-ID: <87lgeiyi3t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 23 2018, Konstantin Ryabitsev wrote:

> On 03/22/18 17:44, Junio C Hamano wrote:
>> Wouldn't it be more efficient to avoid doing so one-by-one?
>> That is, wouldn't
>>
>> 	rev-list --max-parents=0 --all
>>
>> be a bit faster than
>>
>> 	for-each-ref |
>> 	while read object type refname
>> 	do
>> 		rev-list --max-parents=0 $refname
>> 	done
>>
>> I wonder?
>
> Yeah, you're right -- I forgot that we can pass --all. The check takes
> 30 seconds, which is a lot better than 12 hours. :) It's a bit heavy
> still, but msm kernel repos are one of the heaviest outliers, so let me
> try to run with this.
>
> Thanks for the suggestion!

Unless you have just one CPU core your script would probably benefit
from being wrapped in GNU parallel. I.e.:

    parallel 'stuff-to-do {}' ::: $(list-of-repos)

Or something similar.
