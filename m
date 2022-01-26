Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05CEC5AC75
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 00:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiAZAbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 19:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiAZAbC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 19:31:02 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC03C06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:31:01 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a8so34553360ejc.8
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NmvcAHBrFYdtUda5I1grmoTWlVqgNZWTa1ahBC7971U=;
        b=RTIfy5BhdGeumNZ96OKZL9Fazz+gkEC/HtJxX630hLbo4cULs62ZEKCbzcrGd3wUOl
         KikFw4GL20ILka771+sHK3QacyqqUZOnfHJ9oBZEgemI68WMPq8BV3DIYKFilAovBota
         IksSDd135DiBIuQkEfhFBRd9qYYPvPLOwwcLw3tJ1HQFjBgsYUyXq0+ehvoXEHZz9fCJ
         DVXqVYPmd2w+fKXWwlWcf2quZ6Abrv0m3Vy9l8r+TkUeu5BoaENKdOngTj/BJwWAWXwK
         DPcIItaKju+npfS6mFQYVmjajLVCl2J483raG5mysGrfYgsg9iFZWSgP/Dud95nT+IJg
         VZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NmvcAHBrFYdtUda5I1grmoTWlVqgNZWTa1ahBC7971U=;
        b=BFepAz0fuvtwsxP3nlUW3hKe1DBd8Ha26dPm2/o4h4oaLevusMK7Q8yw4Pr7Qwro1u
         InukjG95xyZ+ncXO6IX5cx3ws5g78Nleao4KYEAUSUltzsMjISk8RNYhYoVont7eJuD6
         p1OSJfl/NDbQ1cchd5MncI8DXjwTky2q4oNL//yGz0HMETlmbtH8ki90OnjPx+PqBro1
         2jy89UUD+gfcikEa8dxaXO8yiq3K8bm992aCJF1t4Xi05CTBkTxjoa25DEcM7LGYp2vR
         OAO42ezKNZA35akHC5f6VIRz6dlEdC+sZynM8IjZaGBfgYrRPdsazvrzalQes/zwNoG8
         EAiw==
X-Gm-Message-State: AOAM530ltKt9GqNlO5/T0RQwPMtT07GhIV+08jdmhA5S9Lzd98ij3SAZ
        gLDHf5nDOc9mX+mmRMTmAM8=
X-Google-Smtp-Source: ABdhPJwnXc4WvEWdt2DoAWY2WgHfVgAPb5K4DK0hCnDVxQKULIA7dXDQgqkjhiV9AenaykpWUXN20w==
X-Received: by 2002:a17:906:6015:: with SMTP id o21mr18530919ejj.637.1643157059853;
        Tue, 25 Jan 2022 16:30:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h1sm8813544edz.64.2022.01.25.16.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 16:30:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCWDC-00356h-Vo;
        Wed, 26 Jan 2022 01:30:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
Date:   Wed, 26 Jan 2022 01:25:54 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
Message-ID: <220126.86k0enfid9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 24 2022, Johannes Schindelin via GitGitGadget wrote:

> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Recent patches intended to help readers figure out CI failures much quick=
er
> than before. Unfortunately, they haven't been entirely positive for me. F=
or
> example, they broke the branch protections in Microsoft's fork of Git, wh=
ere
> we require Pull Requests to pass a certain set of Checks (which are
> identified by their names) and therefore caused follow-up work.

This seems to be a reference to my df7375d7728 (CI: use shorter names
that fit in UX tooltips, 2021-11-23) merged as part of ab/ci-updates,
and I understand from this summary that you had some custom job
somewhere that scraped the job names which broke.

That's unfortunate, I do think being able to actually read the tooltips
in the GitHub UI was a worthwhile trade-off in the end though.

But I'm entirely confused about what any of that has to do with this
series, which is about changing how the job output itself is presented
and summarized, and not about the job names, and making them fit in
tooltips.

Later in the summary you note:=20

> Using CI and in general making it easier for new contributors is an area =
I'm
> passionate about, and one I'd like to see improved.
> [...]
> =E2=8A=97 linux-gcc (ubuntu-latest)
>    failed: t9800.20 submit from detached head

Which has one of the new and shorter jobnames, but in a part of the UX
where the length didn't matter, and I can't find a way where it does.
