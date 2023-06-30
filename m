Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96DEEB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 16:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjF3Qui (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 12:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjF3Quh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 12:50:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFFB3ABD
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 09:50:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6a152a933so32756251fa.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688143834; x=1690735834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qlm3I9MMAvoQTxZ/1l3lJGN4Brb6XT2FZ/kE8BcffQw=;
        b=Vybu7T25CxmQj86GMRYmRWM59pXr5u0Mn2oPYGEJJO+gmCoYrGlitQ3bKoso0DkXlJ
         iVT/73jRxqQaqlTJOHr9FXcw1RUzk9gNNooDsqYKj8bGJG8yS16RylROQ9O7SxXC/7Tb
         JRXqi6opZkY4uzpvByH6yrnKrYCbBrXBEDY1mYufsSfsvqXwan/NdPL92750ogGF0R1y
         7ozl0gVeeq935/CBhJEUC8AeKKCXp7t8OfgdlMXWVeOBouI5nym2CffV4ziKPoZogqKJ
         qSFx5vnHdqgM7ejKkJf745MA/7+8+0Er8rwwCKbh6ckqcviySr/TuXLQp5ngt+51JnjZ
         UI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688143834; x=1690735834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qlm3I9MMAvoQTxZ/1l3lJGN4Brb6XT2FZ/kE8BcffQw=;
        b=Mm8702bkL5+9GWyl4+9zzsu2MgIl/XWRrNE0dfYrBYXrb7f68gIMWhblnIE1QdCYPI
         n8vA3PsDXDk30RSdQg2oSRar1VAPw3YbnsjxEtaDg1JUDkHDALuuBq3hl8c+D6TSPzXO
         cTct6GY4bmBUhfA+3SHHj7ANwB1SuTKJw+/2Ub/eLt3vVtkslRP6nKrKY/P4hBjdFhBk
         +woPHRArGS/+wRxOhwsZafGgPbrdijO/emI8gjLp0QK2tmWMlwzBst/lZ95wsM2xwEVx
         0cVW6VyedgTmFX5aWW4SmcfDC/hceJpCARRaO18MBWO7Lgfll73fbVIzEF47UTv+YFFl
         yNRA==
X-Gm-Message-State: ABy/qLYQgZGXCQpqUluawMWXXUJtDD9bY+qAXjdKAsoTTmJKY13xU7nj
        Fte1GRNispTZg7OnS38YOQtKjMGqsqBAjCXq4to=
X-Google-Smtp-Source: APBJJlHlQBeQhVdQ5P8BqB1jTM1pBlR0zd4a65bvNSR5jpwMtHKPIqsEnNBBjR6s8jjlta6XMqDLYMuRfDaFDfDXLqc=
X-Received: by 2002:a05:651c:238:b0:2b6:9da9:2884 with SMTP id
 z24-20020a05651c023800b002b69da92884mr2260461ljn.40.1688143834246; Fri, 30
 Jun 2023 09:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230629185238.58961-1-vinayakdev.sci@gmail.com>
 <xmqqjzvm7z13.fsf@gitster.g> <CADE8NapyQJU1rDPvyMcRXcJfz3kzzg_fYXSSEvYJ7dFO+UHGaQ@mail.gmail.com>
 <xmqqsfa87w9o.fsf@gitster.g>
In-Reply-To: <xmqqsfa87w9o.fsf@gitster.g>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Fri, 30 Jun 2023 22:20:21 +0530
Message-ID: <CADE8NaqEEKx=oYgEnXH0Er8x8HbVay2S7mGtkRyVQXX1ktHQzQ@mail.gmail.com>
Subject: Re: [PATCH] docs: include "trace.h" in MyFirstObjectWalk.txt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, nasamuffin@google.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Jun 2023 at 21:55, Junio C Hamano <gitster@pobox.com> wrote:

Hello again, and thanks for replying!

> Vinayak Dev <vinayakdev.sci@gmail.com> writes:
>
> > That is a good suggestion, but wouldn't the same argument apply to
> > including trace.h itself? It makes it necessary for the code to work
> > that any API changes must involve changing the included headers.
>
> Exactly.  That is exactly what I meant by "tone down 'defined in X'
> somehow to hint that these details may change".
>
> IOW, it may allow us to "cop out" of the problem to say "You'd add a
> new file like so, and call this API function, and include headers
> necessary to do so.  The codebase may have evolved since this
> tutorial was written, so some details (like names of the API
> functions and in which header files the functions are declared) may
> be different in the code you have."
>
> > Either way, I would be happy to fix my mistake. Should I send out a V2?
>
> Oh, sorry to see you took it that way.  I think the change you sent
> as-is is a fine fix for the immediate problem.  Everything you
> quoted above is "while the issue is fresh on our minds, what are the
> follow-up improvements we can make" material, so there is no "mistake"
> to fix.

That is certainly nice to hear! However, I must admit that I did make
a mistake in the patch
in that I missed to include "hex.h" down in the file. This is needed
because the tutorial uses
the function oid_to_hex(), which is defined there. I found this while
fixing the code in Emily's
branch to which the tutorial points. I have fixed that there, so maybe
if you think a V2 would be
alright, I would be happy to send it fixing both the problems.

Thanks a lot!
Vinayak
