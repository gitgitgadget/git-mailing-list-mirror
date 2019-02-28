Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3670720248
	for <e@80x24.org>; Thu, 28 Feb 2019 23:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfB1XVM (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 18:21:12 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:38641 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfB1XVM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 18:21:12 -0500
Received: by mail-pl1-f174.google.com with SMTP id g37so7686668plb.5
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 15:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P6fbR3tzni453T9OoF/JkuqwPkcvsAXzKAtK9nLQN+w=;
        b=LjOVNhzSVGrTd16Kp+ivWDBcKMWEFyyvhbOrUS3k8q0kkdvHxmBYZryYv0I2XsB2zI
         i/P7y70bKou6PTwzvro9NB6DgRWlVAnSxTzt9FsBXwSD21+ESjGuV8gZ8vCXxs+l/PJ+
         lnLO6GWWZjzPT4LKsqApXsozQO+DL/ZUs/QQgdqTYHd2IO/1bhrkWGhKxcXRcidWHY4x
         G2QEhEb4YGlvNI1Dt1uOwaccIQ9bb8sj7Q7ZDbQI1sqmn/dsPV8G+4oJ2I8y3F6YDUHl
         SG64G3fMa/6cyE0aM8jzNU9SQKsPvdM9BmRUQQbb13OfeqrmTTciUvgl6Dx+JeoCGBgV
         1aNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P6fbR3tzni453T9OoF/JkuqwPkcvsAXzKAtK9nLQN+w=;
        b=E2jfgNjE4MsNGUeKv3YujGrHCdt5RQSPWUfhqILjDd0n4Mx/FA5WTRgLjn+FeImSeR
         J0bDd0AVbtRIJCbXRx8+gaSP2+1a0POBj4p0M9AyLu0jC91ne8e8Q4u4dKhKwoIWf6fD
         HHIz9sXmF8VEfo6LFfvLuEr+Vkj76sLnPzRXCtct83tp9b47hWj/ra863mpKxO5CnfiS
         Lz+QlPXCr+4gMFv6uwfw5/g4iUF4WZVI6gDURWatTuMXY27hn6PycF2+H1rnYZ23qHRZ
         zmpPWGFZWIa4yK3xnXbP8Cb90STfLAmdSjpeeo7C6HSCUTEoW+hxYosvhvHT0WXWeTyT
         8tMQ==
X-Gm-Message-State: APjAAAX4Osk/kOtl5HksKMdefCtwHp+UcdG0A/rp9KA5vUPv5ljODobc
        hOl+TJVEmyjwTpF58AusjQk=
X-Google-Smtp-Source: APXvYqwyqaj7KiIIjh9jALcIeKSdP5rKK41gtNlPfXvovTpoE9OIm7zuGSO2gnOnPZAqTdwI6kgk3w==
X-Received: by 2002:a17:902:3f81:: with SMTP id a1mr2079407pld.238.1551396071302;
        Thu, 28 Feb 2019 15:21:11 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id o2sm33095434pfa.76.2019.02.28.15.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 15:21:10 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:21:08 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [WIP 0/7] CDN offloading of fetch response
Message-ID: <20190228232108.GA163714@google.com>
References: <cover.1550963965.git.jonathantanmy@google.com>
 <CAP8UFD19521P=-R1XEdRK++HPatt3BJaxWPvpPRo8LHr3eisjA@mail.gmail.com>
 <20190225234528.GD16965@google.com>
 <CAP8UFD1tKNFO9wU8CbgNnSnQyvHYPsZMk1Bit2y1jxH4vk62qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD1tKNFO9wU8CbgNnSnQyvHYPsZMk1Bit2y1jxH4vk62qQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for the slow followup.  Thanks for probing into the design ---
this should be useful for getting the docs to be clear.

Christian Couder wrote:

> So it's likely that users will want a way to host on such sites
> incomplete repos using CDN offloading to a CDN on another site. And
> then if the CDN is not accessible for some reason, things will
> completely break when users will clone.

I think this would be a broken setup --- we can make it clear in the
protocol and server docs that you should only point to a CDN for which
you control the contents, to avoid breaking clients.

That doesn't prevent adding additional features in the future e.g. for
"server suggested alternates" --- it's just that I consider that a
separate feature.

Using CDN offloading requires cooperation of the hosting provider.
It's a way to optimize how fetches work, not a way to have a partial
repository on the server side.

[...]
> On Tue, Feb 26, 2019 at 12:45 AM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> This doesn't stop a hosting provider from using e.g. server options to
>> allow the client more control over how their response is served, just
>> like can be done for other features of how the transfer works (how
>> often to send progress updates, whether to prioritize latency or
>> throughput, etc).
>
> Could you give a more concrete example of what could be done?

What I mean is passing server options using "git fetch --server-option".
For example:

	git fetch -o priority=BATCH origin master

or

	git fetch -o avoid-cdn=badcdn.example.com origin master

The interpretation of server options is up to the server.

>> What the client *can* do is turn off support for packfile URLs in a
>> request completely.  This is required for backward compatibility and
>> allows working around a host that has configured the feature
>> incorrectly.
>
> If the full content of a repo is really large, the size of a full pack
> file sent by an initial clone could be really big and many client
> machines could not have enough memory to deal with that. And this
> suppose that repo hosting providers would be ok to host very large
> repos in the first place.

Do we require the packfile to fit in memory?  If so, we should fix
that (to use streaming instead).

Thanks,
Jonathan
