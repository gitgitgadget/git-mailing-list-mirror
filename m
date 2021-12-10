Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03A4C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 16:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbhLJQhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 11:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbhLJQhV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 11:37:21 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DCEC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 08:33:46 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y13so31242006edd.13
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 08:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=yh6MFPsmAxYgsqASx+pfZsiJxw1Nraz3m59nqZKJEys=;
        b=lLg7LRiSpzq43XYmyKIeyltJdb+WC4XM5IUwpXRY3KRRLn53HzWipH5YBOZZUw3OS5
         MutF7KcfbHzZ+UeHSCrHX9iQyTD0eqCVihoMwxJlhXk/cXYlmyaJPROCUeMnVc53TzN3
         i9gWIwwy4j/sO1xq4h74KAlN5Ab2+HPq3D1EPtsmItcmQ9yGxyO8280KOmZIahr6LFYT
         pCd+nhyXIGUCC92A/ITZWMUe2fdPcCAKJdW1k15GXNXNBfGahA96LE6kED1y53kKyR9h
         xpKsh5TYhWNAwkbenF57trxE7S+tcb7HlQQL4Mcd7w09RdK4GuZAMRDrrthBqJbAiEox
         SB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=yh6MFPsmAxYgsqASx+pfZsiJxw1Nraz3m59nqZKJEys=;
        b=R36Bd8k/NRuFHt+dYUJrede/OO5OlRS/D10zzNM1X3pZXg7gIAqpZPZKq0DaLkU9yu
         JXEABOqq5Qu8jG1pTlOvqzyPxHv2ShBQ9sOp8VL7lMH3fZBcaapz2wdDO0eFvNOrCrfo
         EMy6G5zVZIZ/viQES/xDs94C1bvvtjogkdT09NnrpIQ3cIsUbZyquwVA4mwXnLJkoKUw
         qMYi4Twya59/nlUrlDsvol25GQtA7SKNPTmDSJBJk71dkleXUw7vscDAcxzF6kBjl48s
         TH9+DQQW38itLM2H1zemTd6J7b7X70vUKZsysZUEE3Qzab6QLLwkw4cl+a5U42k9t9gF
         +iFA==
X-Gm-Message-State: AOAM533dvcdJBMpKRwuRW8NvBzqNoWzHziny3IEPy0aB3hBshsSQ8Gs4
        XMmebtzS02+kwmdH+kokAF4ThPX5DXdncg==
X-Google-Smtp-Source: ABdhPJzIJ1+1UK+b1noA7eWTUS/LMnJyPqylLy54WV77HDwQcduO4g2r698exg6Ywsg8JbfZ3x3mdA==
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr40524033edz.96.1639154024813;
        Fri, 10 Dec 2021 08:33:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d3sm1683929edx.79.2021.12.10.08.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:33:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mviq7-000Ob4-Qp;
        Fri, 10 Dec 2021 17:33:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jose Wielandt <jose.wielandt@timining.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Please, paint new branch errors in RED (or any visible color)
Date:   Fri, 10 Dec 2021 17:32:41 +0100
References: <CAJrA3nLUG_m1ftdAyzFBkmL3m1vMPuv5dd3bYVVOmXV-fThwnA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAJrA3nLUG_m1ftdAyzFBkmL3m1vMPuv5dd3bYVVOmXV-fThwnA@mail.gmail.com>
Message-ID: <211210.86r1akbes8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Jose Wielandt wrote:

> Hi community,
>
> At my work we've been struggling a lot with not realizing that our new
> branch creation actually failed, ending up with a push directly to
> develop. What are those cases?
>
> $ git checkout -b feature/solve p-eq-np
> fatal: Cannot update paths and switch to branch 'feature/solve' at the
> same time.
>
> What's my proposal?
>
> $ git checkout -b feature/solve p-eq-np
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>
> FATAL: CANNOT UPDATE PATHS AND SWITCH TO BRANCH 'feature/solve' AT THE SAME TIME
>
>                  YOU STILL IN THE SAME BRANCH ! ! ! !
>
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>
> ***(but in bright RED)***
>
>
> Another case!
>
> $ git branch feature/solve p-eq-np
> fatal: Not a valid object name: 'p-eq-np'.
>
> I'll let that one to your imagination but please, make it appear in
> red so we can easily (visually) realize that something went wrong.
>
>
> This has been the third time in a month we accidentally pushed changes
> to develop bc we didn't realize that the command failed.

I think if we'd improve the output we'd probably add some "advice"
output, i.e. "hint:" lines, not ALL CAPS.

But have you tried to see if the "git switch" command has the same UX
caveats? It was meant to address some of these tricky/unexpected issues
in 'checkout'.
