Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E3BC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93806139F
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhKSHLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 02:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhKSHLH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 02:11:07 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6D0C061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 23:08:06 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w1so38491537edd.10
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 23:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VBEpNze/NI1dJ9FOyijJRAoPWJIM0b6dH93EPIz8Uuw=;
        b=BGofVf6kwFOI8R0hwDdpZxTnEDV9ZJkpYfdiF3GYffnEO24M7XvFXMnmhvesJnvQFl
         5FoneO4ciYChTRyoKPGOUm9nIZRawxiRlGNwK0biI5Z2gUwXmQ7XuVzrI+6zl2WniIvu
         BFTwZfTBKKwk+G+yrYSTZfHGjfgDz/Qbh803hHQPiIUe6f423MtIpDUwQaUCHvIbNSRj
         IpeXj9kJN5z3MENH7nfhUappzjZmF85ac6PzGxGWXnUrJb25TIoSp0xbqXaahXZGTk0Z
         4ln9qQ/t8+fzw1svYv2D4pT5/1rapKUegsP7MJ8Elu/veHizd2nlxyOp7Iq2851IWILb
         /V8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VBEpNze/NI1dJ9FOyijJRAoPWJIM0b6dH93EPIz8Uuw=;
        b=SBc+ZzZWnfJOMcl2jbWLBTKYxrzJs3W9mb/QxslQcI5KZk7LT4TanXadA03snsbFIk
         tBRQdErzQoxfSaU9Gz1BKAYdj0iqCRAOc5QVlPpQHgi84Q8vy1eM0zAOIUsDQ/ZvdUpE
         y6ufh9x5wNflJrxgjDDQUesXdXpzJG4yRMzw1SfDyBjsvFhW3S7YZjCbjEJLEWRudk6z
         8N4vowQ3b6XL4L7y/gbGS1FsXAlLp1/OP8Om9tLA/6OS4jxxFFqbLjTE1ohmRRpVbBeV
         uKwmRlO9AzKFckiYrriR5rgpybJE3NUmpTKGPdj7E1q5DO1MoBHK54AoCKMqGp2uedNL
         sSyQ==
X-Gm-Message-State: AOAM530uFMNquLRPKpySsoMVhxt9lMh9OAM4IVI7i2LU0AEPv/7HFXuk
        P1uf0CbqAWuwyzJWGdQkyWMk0YHrAfI=
X-Google-Smtp-Source: ABdhPJyjGBglIcnTUZSrs3uwOYoUG3J7soPEcSHg9poXVEKEcWZNG5VyeYCp4mKdKB0ROF3zwY/yoA==
X-Received: by 2002:a05:6402:c8:: with SMTP id i8mr20848252edu.183.1637305684554;
        Thu, 18 Nov 2021 23:08:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v10sm995896edt.24.2021.11.18.23.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:08:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mny0B-000a9j-Id;
        Fri, 19 Nov 2021 08:08:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] Makefile: fix parallel build race
Date:   Fri, 19 Nov 2021 08:06:04 +0100
References: <7d82342089a80b19e54ac8997d5765a33951499f.1637112066.git.congdanhqx@gmail.com>
 <YZR0djZbRUicXcQm@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2111180012470.21127@tvgsbejvaqbjf.bet>
 <211118.86tuga5o68.gmgdl@evledraar.gmail.com> <YZWqK38NRjD7aPOG@danh.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YZWqK38NRjD7aPOG@danh.dev>
Message-ID: <211119.86ilwo4o8c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 18 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2021-11-18 00:56:35+0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>>=20
>> On Thu, Nov 18 2021, Johannes Schindelin wrote:
>>=20
>> > On Tue, 16 Nov 2021, Jeff King wrote:
>> >
>> >> I wondered if contrib/buildsystems/CMakeLists would need a similar
>> >> fixup, but it doesn't have any generated header dependencies at all (=
not
>> >> for hook-list.h, but not for the existing command-list.h). So I'll
>> >> assume it's fine (as did cfe853e66b).
>> >
>> > The strategy we take in our CMake-based configuration is for files like
>> > hook-list.h to be generated at _configure_ time, i.e. before the build
>> > definition file is written, i.e. well before the build. That's why the=
re
>> > is no explicit dependency, it's not necessary.
>>=20
>> It is necessary, otherwise how will it know to re-generate the
>> hook-list.h if its source of truth changes? I.e. if we add a new
>> hook. Ditto for a new built-in, config variable etc.
>>=20
>> I understand that the answer is that cmake (or at least our use of it)
>> doesn't even try to solve the same problem as the Makefile does, i.e. to
>> declare dependencies and to be capable of incremental builds.
>
> If used correctly, with correct dependencies link, cmake is fully
> capable to regenerate hook-list.h upon its source mtime changed.
>
>> It's more of a one-shot command where you'll need to run its equivalent
>> of "make clean" before you recompile.
>
> However, the current CMakeLists.txt has a bigger problem: it won't
> re-run itself when a source file has been added or removed.
> It couldn't be configured on Linux system, except with this diff
> applied (because CMake documentation mandated <docstring> in
> (set CACHE FORCE) [1]):
>
> ----- 8< ----
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/C=
MakeLists.txt
> index 6d7bc16d05..a612217dd9 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -52,9 +52,10 @@ cmake_minimum_required(VERSION 3.14)
>  #set the source directory to root of git
>  set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
>=20=20
> +if(WIN32)
>  option(USE_VCPKG "Whether or not to use vcpkg for obtaining dependencies=
.  Only applicable to Windows platforms" ON)
> -if(NOT WIN32)
> -	set(USE_VCPKG OFF CACHE BOOL FORCE)
> +else()
> +	set(USE_VCPKG OFF)
>  endif()
>=20=20
>  if(NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
> ----- >8 ----
>
> Even after it's applied, the linking step is failing.
> (seems to not link with compat/linux/procinfo.o, I didn't dig further)
>
> The traditional method to list source files in CMake (and meson)
> is listing them all in the CMakeLists.txt (or meson.build).
> With manual listing like that, we can avoid the current complicated
> logic to parse Makefile. The bigger benefit from listing manually is:
> CMake will generate an implicit dependency to CMakeLists.txt,
> hence, whenever a source/header files was added/removed,
> cmake will told to re-run configuring steps.
>
> If you're interested on moving on that direction, I can provide
> some patches to make the cmake buildsystem a bit less messy,
> I'm not a fan of CMake, don't count too much on me, though.
>
> [1]: https://cmake.org/cmake/help/v3.16/command/set.html#set-cache-entry

I think getting it working on non-Windows if we're going to keep it
(which looks to be the case) would be very useful.

I think you should look at the WIP patches from & coordinate with
Phillip Wood, who has WIP patches in that direction. See:
https://lore.kernel.org/git/24482f96-7d87-1570-a171-95ec182f6091@gmail.com/
