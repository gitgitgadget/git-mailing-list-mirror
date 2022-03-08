Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C646C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 13:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347168AbiCHNzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347208AbiCHNzE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 08:55:04 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D59849F1F
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 05:54:07 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hw13so39256174ejc.9
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 05:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CZndpV3DABXqXh9jjhNKicXyJS3Nne3FeV0Z+bi/eII=;
        b=YUlpWsvUWOVKW8JOqs87fMFce8WVZdat6IAEsegsd8O+XLcfv19Y68hmNMZFC1YGno
         UrgSHKoawpORaEOYr09vFZxorWVD5T9Y+vXX7D8ox/chFj7dAV1lOizsyy468VEQ+B4i
         tRHFC3O7geD8AKLzZGilzUlhxUYVBoaM/ZeO3KvBrWptm1e0A+10yJnihrwNx4QsLnek
         e45ix6QF3+tRh5USSRAt6JaPZPsgyqnj1UAFXXJPnant+o4i0PIqNZJGMZa6HUy09WAO
         jAnKVXhjsli1dKJHikb9zg0xzK617gCNyyui3s/8shoann9R6ByQyXTtdapiAPaB8f8f
         TiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CZndpV3DABXqXh9jjhNKicXyJS3Nne3FeV0Z+bi/eII=;
        b=uzpNI8epazyTSzu2sMFWjzN/RT8/56mpycG/YLF7d2jfZdJS3xTTCUTiOmNIno0ARd
         qNoGoqOuRnF1cSgZoh62hOm8RoibBF/KJv94EPVIsGY/M8XZEguQ9GXY5LsAduuQAJ4E
         lb9GTg3kpEIO+X4oRsZ7zmH3HwNtqSqocCxOJKHa+8KhfLweEwJdIGagQBNlfgjo6h+f
         tGs0gFFu7UM7TOHUr020OwCpla4XiphV5HnXQX6Dt42/uRwJWefIWrm6PGRQFX2B4EOy
         c/BP/W6yA7uB0fjweCEr3BBByvj2YZB1s51IaQywXVEGQe1UXtaT52j7uxS1YRIII1x3
         85Qw==
X-Gm-Message-State: AOAM532OjaaC/gQjFIgYU6WSPKp64ZbZkS1nVNwK6cv9sAjZ2xV8o7s1
        dSkEUseHwNYo24GGPcsBa8CfseaSWt/dWQ==
X-Google-Smtp-Source: ABdhPJymgK/k/G8P07zLW9ISdeTkAEaoDJhSijc9IQlToHRidoDZBNczClNUvUm3Yv84iewoTHjfDw==
X-Received: by 2002:a17:907:971b:b0:6db:32b4:f262 with SMTP id jg27-20020a170907971b00b006db32b4f262mr7496978ejc.522.1646747645694;
        Tue, 08 Mar 2022 05:54:05 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i31-20020a0564020f1f00b00415a3351f06sm7556024eda.35.2022.03.08.05.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 05:54:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRaHs-001vZz-If;
        Tue, 08 Mar 2022 14:54:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v2 07/12] bundle: safely handle --objects option
Date:   Tue, 08 Mar 2022 14:53:36 +0100
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
 <19694d5b255227f2314456118c2c7fc986ae52a0.1646689840.git.gitgitgadget@gmail.com>
 <220308.86h788ydm6.gmgdl@evledraar.gmail.com>
 <ea7b6ac0-1212-6682-60cf-d79f5deb61e5@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <ea7b6ac0-1212-6682-60cf-d79f5deb61e5@github.com>
Message-ID: <220308.86v8wownwj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 08 2022, Derrick Stolee wrote:

> On 3/8/2022 4:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> Re this comment on v1: https://lore.kernel.org/git/220307.86fsntzsda.gmg=
dl@evledraar.gmail.com/
>> Aside from whether that's a good idea, doesn't that at least point to
>> missing test coverage here, see traverse_non_commits() and other paths
>> in list-objects.c that'll call ctx->show_object().
>>=20
>> I think an actually sensible patch for this is the below, i.e. the API
>> is conflating "do show" with "should we show AND we have a callback?":
> ...
>> I think that'll do what you want, and also seems to set us up for safer
>> API use going forward, i.e. we have a couple of NULL-passing callers
>> already.
>
> Squashing this change into the commit makes most sense to attribute
> authorship to you. May I forge your sign-off in that patch for v3?

Sounds good! :)

(Also, for anything inline or throw-away like that that I post on list
it's safe to assume my Signed-off-by)
