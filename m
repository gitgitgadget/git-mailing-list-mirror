Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0A36208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 19:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbdHOTc3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 15:32:29 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33395 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbdHOTc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 15:32:28 -0400
Received: by mail-qk0-f194.google.com with SMTP id d145so1586242qkc.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 12:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t4cQfNENCooTegjPZq5Hg7k3ED9KcTZVHfSoSWj5ulE=;
        b=bnHYN9Xh0Q7Q/9/uObPfTee2/lbD5Jwb7m8yWAMM/ptxBe94JLUqmmfzt56NkE3GFB
         gmbTwupVmunDAbjNyg6MxkJx4bfLrE+gP9aSbtpoUUIaQOOsQ+PYcd4mldjuA8Mr3rGs
         OPkPueOeBbKa6msiVVd1+ai1ny4e/72o4c4F7PXvqJ1NZS2tbLipK4GpukrbwYCERt2B
         mAcd3a+a6iXi+YHaDY8Ga+DUJJzALtYAihvRBW9JqFScvBwz6ERAVBmCcwMSlek+DVfu
         /frKOuiZI7Uq3J+G+Lqm6rVrth12QziKMiSsJh7ykjUaCZPt/QCe5VuOzGVpJZctPtUW
         XOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t4cQfNENCooTegjPZq5Hg7k3ED9KcTZVHfSoSWj5ulE=;
        b=dx7/ka1oWVuJbmwPa7OEbq0uH8c7fDDrB30ksTnQThWbCpXFml1AtOrc69u0eRZHJh
         +cgq88dN9lgJoHkky+txWKAWagEUkHgzlK2MTMnvmljYcJEkuNRmDCOySn8kZ2lBCxzr
         NwlfEGARpEgEzk6fvvj8FWa5k3oemptyBqiu7TRKIfu/t7Rs1BtIc/UF08TIMg3T1lb0
         y1DuzigMX+oQQ4QR7ovcGMuAlEWtaWSS3ctmWkA9+TjRe1e3qD9WsaUAgvPOmk6P6h32
         WAfZfFj3IHxzq5scNnfOnULq6VPsfSbB0uwjb0b2rl6FUG+cgAuny4CVSMMluJw1PNLj
         vCOg==
X-Gm-Message-State: AHYfb5h94O5qgfOlgfbcVYFoJbnOm8xjy9g7vQAbrYVcCNRaX6Jxt3gi
        McZ6/s5oJhTX1fVcW841XxOfjHDW4iRf
X-Received: by 10.55.71.76 with SMTP id u73mr40167081qka.25.1502825548007;
 Tue, 15 Aug 2017 12:32:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.77.16 with HTTP; Tue, 15 Aug 2017 12:32:27 -0700 (PDT)
In-Reply-To: <CAP8UFD2KBEVwZE8obaDxf+0AyU4zH0+5bWJzzHazFywgWT9QjQ@mail.gmail.com>
References: <20170815173611.2267-1-chriscool@tuxfamily.org>
 <836F754B-C78C-4D19-8365-875D96B3F115@gmail.com> <CAP8UFD2KBEVwZE8obaDxf+0AyU4zH0+5bWJzzHazFywgWT9QjQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 15 Aug 2017 21:32:27 +0200
Message-ID: <CAP8UFD18KbTkQZqEXK6AsPDABda-diaMLLhyFvACeVQLb+qwrA@mail.gmail.com>
Subject: Re: [PATCH] sub-process: print the cmd when a capability is unsupported
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 9:29 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Aug 15, 2017 at 9:00 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>
>>> On 15 Aug 2017, at 19:36, Christian Couder <christian.couder@gmail.com> wrote:

>>> @@ -184,8 +185,8 @@ static int handshake_capabilities(struct child_process *process,
>>>                       if (supported_capabilities)
>>>                               *supported_capabilities |= capabilities[i].flag;
>>>               } else {
>>> -                     warning("external filter requested unsupported filter capability '%s'",
>>> -                             p);
>>> +                     warning("subprocess '%s' requested unsupported capability '%s'",
>>> +                             cmd, p);
>>
>> Wouldn't it be possible to use "process->argv[0]"?
>> Shouldn't that be the same as "cmd"?
>
> Well in sub-process.h there is:
>
> /* Members should not be accessed directly. */
> struct subprocess_entry {
>     struct hashmap_entry ent; /* must be the first member! */
>     const char *cmd;
>     struct child_process process;
> };
>
> so if cmd is always the same as process->argv[0], maybe there is no
> need for the cmd member in the first place?

In case it is not clear, what I mean is that if we consider that they
should always be the same, it could be considered a different patch
altogether to just remove the cmd member of this struct.
