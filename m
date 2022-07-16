Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E710EC433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 07:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiGPHz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 03:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPHz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 03:55:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5917813D74
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 00:55:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id j22so12570187ejs.2
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9kCb5MhcQsiatGQRINX8eNvCexUGux5bjMwME1zhXOs=;
        b=eGG9tJYEePovX8zBoTzQbSM/MIRL144ZLMlKVyC0P+CUwBqtI6XAjvy4+vq3Z8bUDi
         XyaYAuW2Ct/KMiLKvT1PbLARntLWecYmdIovjfuBvjajHicoMSE0NCe1mbn7mzSxsEB3
         a5dyJs7+0Hk9Mg74Ucx1fiLItoH+CXrL2+L41IGOATZ4V2jZ5AXtNZqjAOMwhBGEuduK
         dv6HSshFgK36QkGAz0RnenjZd2GWRYxIKEgzOpoi9me7MofzH5ixUz/AsU5n/LJBYvq3
         xyW0PKqjdQb6HvW3nIiPXyN5JyIC8IzTfRSyqb0VvM+sLoRvyWeI+mjlgFKLIJyRa4q4
         FKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9kCb5MhcQsiatGQRINX8eNvCexUGux5bjMwME1zhXOs=;
        b=Bm3R//tgNYfhs0sdrla5cifNKyjAT073Ie0GcIYIntmQ6QIdsdgeAOWVWd/PDOyxOd
         MdkxQ2zBkoL48h4y1VXg04sD1f2Dt8bn19qIyiJ73zs7tmQxPQBLiA43mVhM+1oCAHNV
         oZpNjMoFdejC5m8mx4RIt3jPWeB+dWo5JnS2tsxA669nBlf8ZKW2g+A2xtDGN4kaMQbt
         Nvl9BPsR6A8UWGGga8Kl6rkysShZTvAZ0/8A357U4ER20tJ3WlioklLRx41q1X/1Outi
         7pRuBg3lsVckp/3p7jF6t8aMB0yJOgSLrIl2imbhomrMDxRi99vL0jt/x3Ge83jHE4zM
         SBSA==
X-Gm-Message-State: AJIora9T0mPpJuDS8mAawYExbIbErpiAHvVHh7iHJpUU8yFtapk/nMaU
        UUhvSLdjBdHIm9kPS/WKnRCYRpxLcik=
X-Google-Smtp-Source: AGRyM1vMsvt2fVYpy8lwyv9ine5EcbaKH0SL/MeyDeBklqTDZAXxr6kAmZVyaSk/eHlxMLd5mf/vvw==
X-Received: by 2002:a17:906:b150:b0:711:c6a5:c5c1 with SMTP id bt16-20020a170906b15000b00711c6a5c5c1mr17278472ejb.177.1657958125745;
        Sat, 16 Jul 2022 00:55:25 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t10-20020a05640203ca00b0043a26e3db72sm4314215edw.54.2022.07.16.00.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 00:55:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oCce4-002sot-1c;
        Sat, 16 Jul 2022 09:55:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] doc: unify config info on some cmds
Date:   Sat, 16 Jul 2022 09:53:23 +0200
References: <cover.1657819649.git.matheus.bernardino@usp.br>
 <220714.86ilnz1j1i.gmgdl@evledraar.gmail.com>
 <CAHd-oW4zHA1YLX-5B1vYTA1f8PocziUCi0WxvSEkFUuf2GqKxg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAHd-oW4zHA1YLX-5B1vYTA1f8PocziUCi0WxvSEkFUuf2GqKxg@mail.gmail.com>
Message-ID: <220716.867d4dze37.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 15 2022, Matheus Tavares wrote:

> Em qui, 14 de jul de 2022 18:27, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> escreveu:
>>
>>
>> Here's a cleaned up version of what I have, which I figure is probably
>> better linked-to than contributing to my E-Mail quota :):
>>
>>         https://github.com/git/git/compare/master...avar:git:avar/doc-co=
nfig-includes
>
> Thanks for sharing your version!
>
>> The one thing I'd like you to reconsider is to drop the idea of adding
>> these "ifndef::git-grep[]" defines and the like. In your version it
>> yields an arguably better result.
>>
>> But I think what we should be going for is the more general direction
>> outlined above, at which point that becomes quite a mess of
>> ifdefs. I.e. config/gc/rerere.txt would need to know what it's going to
>> get include in, which would be N number of manpages in the genreal case,
>> not just "main or config" as this series leaves it.
>>
>> I think the solution I have to that in 1/9 in that first series is a
>> better trade-off, i.e. we just (eventually, your series doesn't need to
>> do that) include some standard wording saying that what you're looking
>> at in git-CMD(1) is transcluded as-is from the relevant part of
>> git-config(1). I.e.:
>>
>>         Everything below this line in this section is selectively includ=
ed
>>         from the linkgit:git-config[1] documentation. The content is the=
 same
>>         as what's found there:
>>
>> What do you think about doing that instead?
>
> I like the includes/* idea, and I agree that it is a more sensible way
> forward than the many 'ifndef[]::git-cmd.txt's :) Your linked changes
> also cover a wider range of cmds than my series does. So I'd be happy
> to have them as a replacement to this series.

I can submit what I've got as a v2 if you'd like, but I'd be just as
happy with you picking this up & running with it, whether that's seeing
what you'd like to integrate into your series here, or perhaps rebasing
your patches on the 1st patch I have (the one that introduces those
"Everything below this..." template)>

But OTOH if you're going to drop the "ifndef" idea I think what you'd
come up with will be identical to the patch bodies I've got for the bits
you modified, so perhaps it's easier if I just submit mine...

Just let me know, I'd just like these docs fixed & unified.
