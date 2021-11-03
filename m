Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48DBC433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 15:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8076103B
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 15:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhKCPIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 11:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhKCPIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 11:08:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FB9C061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 08:06:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ee33so10481641edb.8
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=UX3dAGLky0v6+6deyxPiXWpZ4RZ0Sv5QCSxF+TNfzBw=;
        b=ei0QafWAdqnSyHnRDvwjaG6ozTQpXEzL+cHIVfIAujGfiZwiFGp7FK7mmcKrNmVff/
         3VGDk7gu/XuVIZhzme/tewExEQ/jOMdWHsyFtq+tI0grD/kStC5S9wKhVv+UfV1EKwDd
         EeuC/XA0sXN21Ke32wZ5/3eGgXpOU8kHWvAs+FjrVHLKzRPEPyy28ptoIi0CS8MTSovG
         U6lP7r45mzXpNOdF+RZaE5Cn4M6EO9Dv77WIWbqvb1r3l5G2qOxjgDWCHRRMIieoduQ/
         xcckIVL5sVCymLLC0ReNyxHTRZ8N8YLc1aNmCH3m0sC6oWCJY1Qv2zvFTDcHAIcI6q+8
         xVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=UX3dAGLky0v6+6deyxPiXWpZ4RZ0Sv5QCSxF+TNfzBw=;
        b=omqAt2dDMoaDpOdxDLV5/dDXEYTC0mAPgnk3DpcPjbbksw8xex/Sem70vCZoRK+G1K
         qlX+OhT4nEeZK3Ocu3xjYOPu7BiHHJ+ms76g0vGhTMKLnSof1DpDRdX0nKqJ228qYN8+
         hBSZHocTULkCWA1i9dxiDYZCra1psoYtClI0xHqhO67dkyCHA6+yJfAZh9hKTGjriBgp
         QuVFe/SWwg2n+9BZ55al+tRJD2+ntUpHUX/KL2tdpLfsuLbUCyCQAOZaAoJstORdbfdV
         4Rv/WNonSU93p24iuXMf1+0E1L5gNoALsH6IzZUIRmlmpzT8+kjlWeOIQXng0Xiv56mN
         ab9g==
X-Gm-Message-State: AOAM531+94cHpQ+B5nTp1hzRe4HnK2LalR+/Sk2hTA4cgxvs72QZ41Ag
        zBGztUMB2h5u7VGseVfLtJw=
X-Google-Smtp-Source: ABdhPJxbou2IDQwFayseKRBQB2LeB7AIq8uJ7bhVdmHQiKNZCUVHKPBfDlFsPbZQ+YGv/UDRTdy5Wg==
X-Received: by 2002:a17:906:f894:: with SMTP id lg20mr2034419ejb.33.1635951966560;
        Wed, 03 Nov 2021 08:06:06 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gn2sm1426440ejc.88.2021.11.03.08.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 08:06:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1miHq1-00018r-93;
        Wed, 03 Nov 2021 16:06:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH] Makefile: replace most hardcoded object lists with
 $(wildcard)
Date:   Wed, 03 Nov 2021 15:57:35 +0100
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
 <YX5T+wt0hSkxkLHA@coredump.intra.peff.net>
 <211031.86a6ip47ib.gmgdl@evledraar.gmail.com>
 <YYJy4BuX6JI6p+aV@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YYJy4BuX6JI6p+aV@coredump.intra.peff.net>
Message-ID: <211103.868ry5jn36.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 03 2021, Jeff King wrote:

> On Sun, Oct 31, 2021 at 02:00:42PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
> [...]
>> I didn't notice before submitting this but this patch breaks the
>> vs-build job, because the cmake build in "contrib" is screen-scraping
>> the Makefile[1].
>>=20
>> What's the status of that code? It's rather tiresome to need to patch
>> two independent and incompatible build systems every time there's some
>> structural change in the Makefile.
>
> My opinion when we took in the cmake topic was that it would be OK for
> people working on the main Makefile to break cmake. It's an add-on and
> the people who care about cmake are the ones who will do the work to
> track the Makefile.
>
> But since there's a CI job that will nag you if it fails, that kind of
> makes it everybody's problem in practice. That doesn't change my opinion
> on how things _should_ work, but I have done small fixups as necessary
> to stop the nagging.

Yes, that was clearly the intent from reading the original discussion,
but we've crept towards it being an actual hard dependency. I'd also be
fine with some direction that just removed that vs-build/vs-test job to
something optional...

>> I hadn't looked in any detail at that recipe before, but it the vs-build
>> job has a hard dependency on GNU make anyway, since we use it for "make
>> artifacts-tar".
>>=20
>> So whatever cmake special-sauce is happening there I don't see why
>> vs-build couldn't call out "make" for most of the work it's doing, isn't
>> it just some replacement for what the "vcxproj" target in
>> config.mak.uname used to do?
>
> The big question for me is whether that really is a hard dependency.
> Obviously "make artifacts-tar" is for the CI job, but is the cmake stuff
> supposed to work for regular users without relying on having GNU make at
> all? I have no clue.

It's a hard dependency for the job, since it tars up its built assets in
the first step, and those are then unpacked and used in subsequent
steps. It's being used to ferry the built binaries between CI phases.

But yes, the intent was clearly to not have a dependency on GNU make,
but as I argue in
<patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avarab@gmail.com> I think
having those developers simply install it is better than forcing us to
maintain two distinct and incompatible build systems.

The selling point was that it was going to be really easy to maintain
them in parallel, i.e. you'd just add a thing to a list here and a list
there, but that assumes that nothing will ever structurally change in
the Makefile.

I think the other X-Y problem being solved there was that cmake has some
better integration for Visual Studio somehow. I.e. it does what the
"vcxproj" target in config.mak.uname does/did.

I think that would be a fine use for cmake, and we can clearly
accomplish that by having our cmake file effectively be a mostly thin
wrapper for logic that lives in the Makefile.

I.e. it would ask the Makefile what's in this list or other, what the
CFLAGS are etc. etc., and feed that into relevant cmake variables.

My patch starts us moving in that direction (but doesn't get anywhere
close to that end-goal). I think if we did that the ~1k line
CMakeLists.txt would be maybe 100-300 lines.
