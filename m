Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5D3C433EF
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 17:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhLZRTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 12:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhLZRTK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 12:19:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED4FC06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 09:19:10 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x15so53423438edv.1
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 09:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nnpBzWLbkh2nP+vv0zm+UHVpRvePX6G4XeEe7tJIPyw=;
        b=nbbVs1WssPtE3JE98367MhWBJIYIe2gEeels0gNbWrG5Et8kTBp241twxwqQFCqown
         6lxdMAcuNkHN8NtmtGIV8GoyJu+5V1RAqZBsQwdb053O+SBP427oZXPmrPAHrzOjTrUV
         K3ld4OmUyxIR+aD+2JG1yfn9k2Pudp7cfYU8fmppOfwjTes+gW4ptfD7Acg1KTb9MQo9
         E7JX9djNMTEjMi0s0+iR5+nLgeVadb7JKUvmOExyuUc2t5WgC2zBSZt5WNmcwR5DH8SO
         S1lu+/NsH23Aontl+JtUCkSOQiE5Q/US8L8LF8gJJF3GZlPpy5MbBSbv5qYT0cF1UtLW
         Vmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nnpBzWLbkh2nP+vv0zm+UHVpRvePX6G4XeEe7tJIPyw=;
        b=y/PaBMaifNhEDFt1pKT4ZxNodBYK+yr4gMKtzvAYom4ux0AR3vOTcGpmiF+G6tjWqu
         sRaDcO1P4ox4zW5opcbu3oW0v+IfMkzkHIoDmyXDCuathst7FH0L8o04Cg7IKxe6hf8Q
         S8MLY2CZy5sMe2qUz/HktLs+yUBuYpMf8qN+UWkRdAeEAkB3WaYwA4HgE5rupR+PTal0
         eqNBIb9mZdvrfh3bAmTbrPjSc6RARRhNvxG+U9ASPR/EJ/n8mUXTyhduMB68Wt1nO4Zu
         nyWVV9N9O4p0jMdwkmugCN08pBDPow8Rrac8WCHFtu18gu6L+fIzFo4wg5jTlXTaqNwA
         LqUg==
X-Gm-Message-State: AOAM530R03MQUKzkbTZk/HPl1QxtnRSaFwkGgY29xcDa8CGRoBoVrPec
        +87Lbuwcdq+eAOieGvo+SuY=
X-Google-Smtp-Source: ABdhPJwgv8SpGt3A6hjNg2wNW7sHUof5Fh6pqa82HRyg76Io8voo7EJnZzLe3QLztl6YwRF+tK8LkQ==
X-Received: by 2002:aa7:de0f:: with SMTP id h15mr13077552edv.40.1640539148443;
        Sun, 26 Dec 2021 09:19:08 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id dd5sm4431520ejc.59.2021.12.26.09.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 09:19:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n1XAp-0009Id-41;
        Sun, 26 Dec 2021 18:19:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2021, #05; Thu, 23)
Date:   Sun, 26 Dec 2021 18:15:53 +0100
References: <xmqqsfui6g7q.fsf@gitster.g>
 <CADMgQSSwM3SMysB5=UkXOYLOTUTTN3kF2aaaQwHc+o7Q5qWDcA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CADMgQSSwM3SMysB5=UkXOYLOTUTTN3kF2aaaQwHc+o7Q5qWDcA@mail.gmail.com>
Message-ID: <211226.8635mfgu7o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 25 2021, Teng Long wrote:

> On Thu, 23 Dec 2021 15:42:33 -0800, Junio C Hamano wrote:
>
>
>  > "git ls-tree" learns "--oid-only" option, similar to "--name-only".
>  >
>  > Will merge to 'next'?
>  > source: <cover.1639721750.git.dyroneteng@gmail.com>
>
> Currently, the "source" is patch v6, and there are some test problems in
> [1]. They're not very hard to fix, but I'm considering whether to:
>
>      WAY-1: continue on the current implementation path;
>
>      WAY-2: Combine (steal :) the RFC patch from =C3=86var Arnfj=C3=B6r=
=C3=B0 Bjarmason
>      and some commits of mine, to the next patch, because some arguments
>      given from =C3=86var are compelling (of course the test problems wil=
l be
>      fixed too).
>
> So, I will work on it, I think I will send a new patch based on WAY1
> quickly, and send a further RFC patch on WAY2. If both are ok, let the
> community decide which one to use.
>
> Thanks.

Yes there's the test problem I mentioned in [1], but in addition to that
your current set of patches have around a ~10% performance regression,
as noted in [2]. My RFC series[2] side-steps that by leaving the current
code in-place, and only introducing a new optional --format path for new
output formats.

I really don't mind if you go for "WAY-1" first over my RFC --format
"WAY-2", but I do think any such change should be prominently
noting/selling that this new feature is worth the performance
regression, or finding some alternate "WAY-1+" to avoid it.

1. https://lore.kernel.org/git/211217.86o85f8jey.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/RFC-cover-0.7-00000000000-20211217T131635Z-a=
varab@gmail.com/
