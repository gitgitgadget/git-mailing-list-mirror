Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB19BC433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 19:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhLLTGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 14:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhLLTGN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 14:06:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43631C061714
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 11:06:13 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g14so44820328edb.8
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 11:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pBDL4vGgOmqkLXJlnmJxujU7nW/+LsFTCdABlcATYa4=;
        b=aC/14KzgiEXrn6eRhU2nemKgp1liVfaqoO5Ky+1sgKDev78C+ohmgnOwLgAU0S5E2z
         cunBAXIrsrGdqobjLWoUOGC4GSY72ynPvgYyUWYh1VOZrK+gvX+z+7xzErgtwJnAwING
         rLLqeRW8YSquCjysQ2JWjCGq3/XUanYUjfSUX81s03HUQA1idLBneJKJeHgJF9vNu+sB
         AO6BZ5bKiV7taT3wC+ajGcG2+SjKRTuYTho97QKJhTvkGPWb/oB8nxYgXhlSbf9taxCP
         n2zwNtGFTSuIWSXWcpwMR4MmEvMifuRPltailfyzQ0XUvA8z2dFk5N8up+XscmDFWNEu
         a5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pBDL4vGgOmqkLXJlnmJxujU7nW/+LsFTCdABlcATYa4=;
        b=GYRHJVE8CfR74gntjZtiv7QafLh2AkS1d5kJwnVFSYeKWcNiXxRDvGdLHKq9oNfbVZ
         FK+ExsKF95Bnd5mE05/5k+rHGnDz0VYYyYD9WnoaG5gY2eo8jbfCvN+A+1BhCHZKaIsA
         QCfWEbWUb1MrW07vdtEw2PVya5fX7BY6kecPw143uWm6a1BxBKfj3ZlcJVUWSQH1UJFi
         8nH8IW/EwcMQQY4Pp+0g26h6IiOIH5ZVG0PmZP9AlDq3NvWIovHbHdZiT8JDTeQlgFsE
         BUIAFkj5PDBViOnXIx5EBB4MCl5VBApwUbf6KHYTC0Tdx3Hyvd+JpmX8H2AvbhD0lg5i
         8Qbg==
X-Gm-Message-State: AOAM530yrYO/ASy4ub+4nplz1lEY3Hi+m3S5X4m80bHtlFArms6e75aK
        JjXc+UrTsjVYxSx6vHnuGcU=
X-Google-Smtp-Source: ABdhPJw/iTZnoU3TRgehRrxYlhrxYzX8+EyD8RJ1LLi/3TT+45eBq4brSEPA6MjTVXdD8yotRTiGBQ==
X-Received: by 2002:a17:907:8a12:: with SMTP id sc18mr39253247ejc.274.1639335971654;
        Sun, 12 Dec 2021 11:06:11 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qa31sm4591570ejc.33.2021.12.12.11.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 11:06:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwUAk-000aOB-Lf;
        Sun, 12 Dec 2021 20:06:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jose Wielandt <jose.wielandt@timining.com>,
        Fabian Stelzer <fs@gigacodes.de>, git <git@vger.kernel.org>
Subject: Re: Please, paint new branch errors in RED (or any visible color)
Date:   Sun, 12 Dec 2021 20:01:34 +0100
References: <CAJrA3nLUG_m1ftdAyzFBkmL3m1vMPuv5dd3bYVVOmXV-fThwnA@mail.gmail.com>
 <211210.86r1akbes8.gmgdl@evledraar.gmail.com>
 <20211210164249.bahhe5ogjjhz4lxo@fs>
 <CAJrA3nKbUK=_5d5KTCDehrfge4y1aB9YGsFwQYNzUDWGcfog4w@mail.gmail.com>
 <211211.86a6h7c1mq.gmgdl@evledraar.gmail.com> <xmqq4k7dlld3.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq4k7dlld3.fsf@gitster.g>
Message-ID: <211212.86o85labj1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 12 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Fri, Dec 10 2021, Jose Wielandt wrote:
>>
>>> Yes, I git switch has the same behavior.
>>> I also agree that add hints could be a good idea.
>>
>> I'll pick up this topic.
>
> Please make sure color challenged users can configure it away or
> customize it somehow.

Yes, I think it's a bug if we add any such coloring that isn't
configurable via the usual color.* configuration. Although in this case
it's usage.c. So perhaps "color.usage" (as in usage.c). But that squats
on any future hypothetical "git usage". So maybe "color.coreUsage" (a
"color.core.usage" would squat on any future "color.core.usage.<slot>"
(i.e. there's no 4-level keys)>

> Making it opt-in is even better, but it is my personal taste.

*nod*. I'll see how it turns out. FWIW I think that it's probably too
over-colored to do:

    <RED>fatal: the message</RED>

And it's probably better to just do:

    <RED>fatal</RED>: the message

But I'll see once we have actual examples. The advice output is
fully-colored now. I.e. "hint: message", not just the "hint" part...
