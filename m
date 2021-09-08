Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C88C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA39F61151
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245428AbhIHBYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhIHBYd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:24:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC6CC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:23:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id t19so724771ejr.8
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BXw5eBEdHt7xQ1SWliLCHiqTn/WbH2IHtopI892uZqI=;
        b=mXIiV0MtBaARgyDuGwCaGttnPCaQmfIAK0XIvsblGoREc47e/OqEYgXDMWx8NPnTT7
         C+pSPwTzWLBBfbGbQScXMIlk1Q9kccQSBpidSEnGU5wp+rJh5oosEUD1czmsUdukfzMx
         st6x6OHlDWlG7KnyZOiUtz2m89cjnO/IC92HDDevZeabhMon5ChEjMUz1+9eyE57GaiJ
         2hpexxuYBUM+eR+XKeAfjPPGWOc3eA90JGoGU6Yk5MDwvP0n3xiJQ7PuXEDqcA5uUHxo
         qb/jUyk81TBfw5Wt5UfJHI78Gg54jUkfjWn328zysIJ7f45EsY9AsTSzQG7qrhnzxUZD
         WKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BXw5eBEdHt7xQ1SWliLCHiqTn/WbH2IHtopI892uZqI=;
        b=FObQXb38Og8u3GHuO6qciC+xE5QwKAM32KHZkasP3kRZUxX1nMPaymHNxUj6O7I1pq
         X+e5qoj9Zbtlhk7nT5RHzMXnzKQfOm/C6fplRCR2/1QUN2VYEbcCtMp8BZUuvjyMw1ws
         LAQJto6ssVrOFUxKf2DjOHL9ENAUBpg+Rs/3VnJxn3iBMhN7wrurOIg1DceJPT0m+o7D
         Y1/+ALCqGgytlcr1LM5ttqiwxzQ9wxIasD2qIdOPt0BXwVDdBSzY9+kZQZcOcAca7Mkp
         7Xl1jJsgZ1/OpxzXuaioq5AOoI/3CKQWTkseWWR9RGBDnUBvt+KbDJFNOzLN4W/HrjXP
         Gb3Q==
X-Gm-Message-State: AOAM533fDt6A7Oi61pdEx8sajEo7FKKXN7ZLnpumA4XyA1BjJrDO+Ops
        GCRUKtAb8WXmXWkav5b1OeM=
X-Google-Smtp-Source: ABdhPJyGz0MlgKZH2xKLpAYvp3keI09YP2zxXw5MEaVSsj52xx8iLtu07Rq/lJEIAUAtHyadFSV4ig==
X-Received: by 2002:a17:906:4a82:: with SMTP id x2mr1342403eju.111.1631064205220;
        Tue, 07 Sep 2021 18:23:25 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w13sm292943ede.24.2021.09.07.18.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:23:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for
 core.fsyncObjectFiles
Date:   Wed, 08 Sep 2021 03:22:38 +0200
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
 <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
 <003701d7a422$21c32740$654975c0$@nexbridge.com>
 <CANQDOdcKsUqrQ6K6MEBoXS1BW8_tO8mx4tcq6nvqyiuM4e2CmA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CANQDOdcKsUqrQ6K6MEBoXS1BW8_tO8mx4tcq6nvqyiuM4e2CmA@mail.gmail.com>
Message-ID: <87h7evkghf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Neeraj Singh wrote:

> On Tue, Sep 7, 2021 at 12:54 PM Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
>>
>> On September 7, 2021 3:44 PM, Neeraj Singh wrote:
>> >On Fri, Aug 27, 2021 at 4:49 PM Neeraj K. Singh via GitGitGadget <gitgitgadget@gmail.com> wrote:
>> >>
>> >> Thanks to everyone for review so far! I've responded to the previous
>> >> feedback and changed the patch series a bit.
>> >>
>> >> Changes since v1:
>> >>
>> >>  * Switch from futimes(2) to futimens(2), which is in POSIX.1-2008. Contrary
>> >>    to dscho's suggestion, I'm still implementing the Windows version in the
>> >>    same patch and I'm not doing autoconf detection since this is a POSIX
>> >>    function.
>>
>> While POSIX.1-2008, this function is not available on every single
>> POSIX-compliant platform. Please make sure that the code will not
>> cause a breakage on some platforms - the ones I maintain, in
>> particular. Neither futimes nor futimens is available on either
>> NonStop ia64 or x86. The platform only has utime, so this needs to
>> be wrapped with an option in config.mak.uname.
>>
>> Thanks,
>> Randall
>
> Ugh. Fair enough.  How do other contributors feel about me moving back
> to utime, but instead just doing the utime over in
> builtins/pack-objects.c?  The idea would be to eliminate the mtime
> logic entirely from write_loose_object and just do it at the top-level
> in loosen_unused_packed_objects.

Aside from where it lives, can't we just have a wrapper that takes both
the filename & fd, and then on some platforms will need to dispatch to a
slower filename-only version, but can hopefully use the new fd-accepting
function?
