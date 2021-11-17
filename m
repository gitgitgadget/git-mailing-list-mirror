Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB8FC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D42E61BA1
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbhKQXtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 18:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbhKQXsy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 18:48:54 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A469C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 15:45:54 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id v3so9601561uam.10
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 15:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7kwndGGiR0/WVr6LSDL5TQsIbAlpuXojsEyuOMNeMPk=;
        b=QyspIMcVajrO1BEk99m0gGrOxNrXrCXoe4lZgX1AxwAls2qYN9e+H6SjSSqlunsoj6
         ja4J1Ppn+AN1sdQoBPO5ZAvHyzIWh0XpIYOXVhlGSNOrzH4fG+GUAP+gU5kIYZubPxrg
         M49WqmgQBQzS2kCCdWSbVpncjvJ0/RQzfI7XwFFyRk7m8f/E7hopJdrINYRHVnmWcvLT
         /WJxYsaMqlwOfbR4Ms8A8q9/XQZJxo/yltb0RiJxce87hHctLp1/ONh0xxOAzrhPYy6n
         NN7zQLp0bB0RK1h5oM0piyGXDgsr07ev4/W8Ijy122vzTJ8/FuLvlzl2G3eywDTR6HFl
         nG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7kwndGGiR0/WVr6LSDL5TQsIbAlpuXojsEyuOMNeMPk=;
        b=Rm2sQQHx2BSHEqvXm+W0pFC7zwgaZ45x+ABDja0zBZcZjWOxlZZFbsD/0rKjLW+x2K
         YA+fWDi7MhLeUdsAACdLOJfpPJN/DXWs6Ea82oAzvUA2+aIwq1iXPHMCH8vcyPk9Q76q
         YNfoOnW722N1W49TTYuUs78ilD+hENo1CGOfzhJZC3WF9cQ10jMkacEtEyuvxiUnty7F
         /8NlRFiSGJFskTZyrcnP5GczkAEnV3W0zvu9lXNsw7LJLx5VfjQalmg3CzD1FUj/FHNe
         rU9o4VWooRm5ajBZ8DrABpY2tp7CyVVv6q5bpNXvgh4U7lMIYtk7m6CIBMVIo0D68Sin
         L8Jw==
X-Gm-Message-State: AOAM530qD0Z6yXaXZen1/HvhlbNvwoWltE958zYELwTJdOrJMX00T29B
        /dME6haM7PUrLFrsCkCyWwGA5UsWbWVe1PJsChU=
X-Google-Smtp-Source: ABdhPJyBDJdBVoP0WM1ztXwV1/VlgHfgjDHJDQce8H8Xg4FQqlqmldwVstT7aexL+/zrTLPruS9OfC2GjCzCers80Iw=
X-Received: by 2002:ab0:7c65:: with SMTP id h5mr29246859uax.138.1637192753358;
 Wed, 17 Nov 2021 15:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-1-sandals@crustytoothpaste.net> <20211116021241.1565740-2-sandals@crustytoothpaste.net>
 <YZOh370ZMMqSADUE@coredump.intra.peff.net> <211116.86pmr0p82k.gmgdl@evledraar.gmail.com>
 <YZPGKHYE/9km1rH5@coredump.intra.peff.net> <YZRurUdyB/cGL6Y3@camp.crustytoothpaste.net>
 <YZRwpekXlilhOEx4@coredump.intra.peff.net> <YZWNumAlsek9Gi22@camp.crustytoothpaste.net>
In-Reply-To: <YZWNumAlsek9Gi22@camp.crustytoothpaste.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 17 Nov 2021 15:45:39 -0800
Message-ID: <CAPUEspg=ef9xSiYsVKHfo7zogExeMwL3gMnN_bq1QcKv0fnNng@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] git-compat-util: add a test balloon for C99 support
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 3:18 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-11-17 at 03:01:57, Jeff King wrote:
> > My thinking was that breaking older compilers was preferable to breaking
> > non-gnu ones, because at least old ones go away eventually. But your
> > other email makes me wonder if those non-GNU ones may already be
> > overriding CFLAGS.
>
> Our only problem platform, as far as I can tell, is RHEL/CentOS 7.  That
> uses GCC 4.8, and even Ubuntu 18.04 ships with GCC 7.

There are several odd BSD platforms that are still stuck in pre-GPLv3
gcc (AKA gcc 4.2.1) like OpenBSD Alpha, hppa, landisk (and maybe also
SPARC64 which is tier1) and that will need the same, there is indeed
also luna88k that uses an even older gcc but hopefully will be able to
work if it understands enough C99 and can be told to use it by this
flag.

> > Still, if we can come up with a solution that breaks neither (with some
> > light auto-detection or heuristics in the Makefile), that could be the
> > best of both worlds.
>
> I can move COMPILER_FEATURES out of config.mak.dev and into Makefile so
> that we can make use of it.  We'll need to depend on GCC 6 for this
> because we lack a way to distinguish 5.1 (which should work) from 5.0
> (which will not).

5.0 works AFAIK, is anything older than 5 than does not as reported[1]
before, but it won't be still a good fit, since it only works for gcc
and clang AS-IS.

Carlo

[1] https://lore.kernel.org/git/CAPUEsphnCvK+RZ+h30ZarA1zo9yZ=ndEBrcAbKGf4W92j647vA@mail.gmail.com/
