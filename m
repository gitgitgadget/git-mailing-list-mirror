Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE0EC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 12:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481CB61075
	for <git@archiver.kernel.org>; Tue, 11 May 2021 12:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhEKMwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 08:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhEKMwi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 08:52:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59B4C061763
        for <git@vger.kernel.org>; Tue, 11 May 2021 05:51:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n25so22720314edr.5
        for <git@vger.kernel.org>; Tue, 11 May 2021 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=oBWDlFUBkcWftACA5f17z8ZP2bhgImKatstXPkGjEZU=;
        b=JJCBzC4c3x3beIiWFwObiRoVlK9t0+M6g+1fhjVnRup7pqIgZkM3/SSKz7QTlNC334
         aBggQrFmSjdcFIJtHQBfnrkhDU7UN8v3gCwWbml6or0CvWndcAXGQZCOykdF0obB8GG+
         aj2Od7S0ttNhGFjbHnnesUeDm6noOZ7/1WLVUQzef/IEBjd3WqKLg2U9oNmsrHe1Dzds
         VAAOjHO3feudYPqpK7LNnatcb84vE+IQnp/VuAhCD5XSzBMkZZmi1T/lRKk6yk4bOMuC
         pqgd3l35SpZTPTiSwHHXvfOAXXmzezLtSdsCkBUAj7MquRe4dYO/3fajrADcjnNazhrU
         AHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=oBWDlFUBkcWftACA5f17z8ZP2bhgImKatstXPkGjEZU=;
        b=t+UUW5YM3Qg84pNl+pf8mN8wPcY/0CDu5rAjNr3spW2tLvgaiVImn9dKopbNT9mRiO
         yU1ee+yQP6XW6p7Ype70R14sTqLCpuqyfn3OT8PafXQhoIhC7jAd7AJ6cly1qdLKJcUY
         cF77NUSDmW1ArfgBl6MnjgZbYJQYsczNGKuJ1esjX25iwRcbMzREGsWNnUcUGZSqVxDz
         lU6jKvwfetNV84iKQ9+raG7Hqdws5LfnyAi/zc86EOG0P1ihLiLA/9dciJOgwsV3Bymn
         jumN0D+HB+SfIWvu9aXfXiKwFYdXKZ9eIhqo9B00yUIQp8uBS6nZ7Sz6IO1NrbtFQ+pN
         2Gmw==
X-Gm-Message-State: AOAM530GRO5j0VUBPKC7eT94EAa9nXzwKNH8+Z4D1wG+OXgd8FcEyh1k
        EfFh2HWVOQPgIhByAjQVofg=
X-Google-Smtp-Source: ABdhPJyx0W5EYZC4LZYgP2SQ36NtkoXmWLbrZppzv8aq9RY/onvByblDdpI0Qxb4gqX1x0pz2cwPoQ==
X-Received: by 2002:a05:6402:1d8f:: with SMTP id dk15mr33631997edb.146.1620737489439;
        Tue, 11 May 2021 05:51:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a24sm14559926edr.74.2021.05.11.05.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:51:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Date:   Tue, 11 May 2021 14:44:41 +0200
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
        <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
        <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
        <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
        <YJmykGWaWi03+WoW@coredump.intra.peff.net>
        <609a07ca6a51c_5afe12088b@natae.notmuch>
        <YJogn8cUtSP/BAbJ@coredump.intra.peff.net>
        <609a3a5a7aa08_5d5d32088@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <609a3a5a7aa08_5d5d32088@natae.notmuch>
Message-ID: <877dk5tovj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 11 2021, Felipe Contreras wrote:

> Jeff King wrote:
>> On Mon, May 10, 2021 at 11:27:54PM -0500, Felipe Contreras wrote:
>> > Jeff King wrote:
>> [...]
>> > I've never understood developers worried about how the bleeding edge
>> > would build in ancient platforms, when ancient platforms don't care
>> > about the bleeding edge.
>> 
>> Again, this is about developers. Are there people contributing new
>> documentation to Git who are doing so on Debian stable, and would be
>> inconvenienced by needing to upgrade their toolchain?
>
> Developers don't need to create (or use) debian packages. They can
> simply do `gem install asciidoctor` and be done with it. Some may even
> create a docker container to install all the doc toolchain in order to
> avoid polluting their main environment.
>
> I for one would start building the documentation more if all I needed is
> one dependency.

Just because I'm developing the latest git.git revision on Debian stable
that doesn't mean that I'm keen to install the very latest openssl,
libcurl, asciidoc, C compiler, or whatever other thing we depend on.

I'm not disagreeing with bumping the dependency in this case (I haven't
looked into it). I'm just pointing out that in general there's a lot of
use-cases for e.g. building a latest git on an N year old OS.

Of course we can ask these people to just build their dependencies too,
as I noted in [1] in a past discussion. Whether we bump our required
dependencies is a trade-off between our own convenience and these sorts
of in-the-wild builds.

I'm just saying we should keep this use-case in mind, it's not an all or
nothing where you either have ancient deps + ancient git or bleeding
edge deps + bleeding edge git. A lot of people build ancient deps +
bleeding edge git.

The "just use the built doc tarballs" is only a partial solution, and
e.g. won't work for someone who's interested in building "next" or
otherwise applying local patches that have doc changes.

1. https://lore.kernel.org/git/874ltg2tvo.fsf@gmail.com/
