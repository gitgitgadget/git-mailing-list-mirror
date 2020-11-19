Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EFBC5519F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AEAC22264
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7xK0tPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgKSAzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 19:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgKSAzj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 19:55:39 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018AEC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 16:55:38 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id g7so2802577pfc.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 16:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TQLsjgq0jyw68xhp+xLYlfVuP/Kdo5y+VY9LP+nfTRk=;
        b=k7xK0tPEdNwqhdOIrS/6WHiTNfH7ts3CMXl56ou18HZTuCBFSB6hpRF9Q5siTak1UY
         zSeEUcoX0JW3SLU0gbUhrZCmrr0FW4a4yQKTEnJZVJbsyD9jgv5dEjn+qN2bCJdTFiPu
         gv71ny1/Z2OukHkqZTtRQ/EiPU2Q+0KXs3yMHy8wu24oS4ZCBAfeBYZoLzincL1hKQlq
         0wBKuskhEYA7clh69nKh2pH41mMARMY+kywuxYWN+QPtD569DVideCR0VpRwLpLQuZs7
         vyraEU+EmdphxUZGP0pORQSuk7nP+YzoaqdDigp+n4JWYNRE/p8wJekMHvoPJgiBi82E
         itZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQLsjgq0jyw68xhp+xLYlfVuP/Kdo5y+VY9LP+nfTRk=;
        b=pHzLb5Il/jz0Gz5hgCjWkoxsZyRypkhaGYBPf7OKTB96Laf2rHnXW0d/2TOHDJ60uC
         g0p4uoisyYIpJ81fR1wYmc2pPzpnTjWOnEmL6Gy9wyL0FtPwairihsLkuvDwgufLjsQK
         VW/7nvZPGfvgEYLdh/bi1xJLC1+A1v0QldWzrWHrYZgEcjTPjRuHgvewBYlNxcYZC6Xk
         F/v4jn5N0vhxU9UJ8AcKyc0Apm9xCH1J9CboF5oTycod9k3z26dtMRQMGsWChvtHllLS
         PdemXAYrUq7FsuDTnxmHYoP0qfhDP+V1pku8BWJgVlcw9WxYlFMiBWZMwCydLpvos5V1
         xxrA==
X-Gm-Message-State: AOAM533ugk6FKRRipT5VJduLOoZ6WaTmPqExh03eFOwpSiYqvh701rDu
        0lgQcGhBslEl//g1Z48KD8QXVwIX6joVJyu5Nho=
X-Google-Smtp-Source: ABdhPJwFLunoWjvt8kkTI7wvdtZbTPvNxX1IIoquIXL+H0PUrnnW6ria4zBR6eelJ/HaJ6qRJ1uOR5wSgRVnYMezZMs=
X-Received: by 2002:a17:90a:4601:: with SMTP id w1mr151843pjg.109.1605747337475;
 Wed, 18 Nov 2020 16:55:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org> <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
 <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email> <nycvar.QRO.7.76.6.2011190057370.56@tvgsbejvaqbjf.bet>
 <CABrPy+HYji9yD4pjYcGpmRq488nSgwEMfqFMOsxbmhO3GaXctA@mail.gmail.com> <36e028c3-b2be-30ba-11a0-7dc277c1ceca@iee.email>
In-Reply-To: <36e028c3-b2be-30ba-11a0-7dc277c1ceca@iee.email>
From:   Peter Hadlaw <hadlawp@gmail.com>
Date:   Wed, 18 Nov 2020 18:55:13 -0600
Message-ID: <CABrPy+EiBRXCFUG-bG5b2ixnxaT6XyUw33qQ9gt-EAGNEk4_2Q@mail.gmail.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's still a responsibility for ~57 years worth of human life that
doesn't actually need to be put at risk.

Someone forgetting how to rebase a branch in some given way and then
having to search is their own responsibility.
On the other hand, this is a decision made on their behalf, without
their consent, ... on everyone's behalf.

If you're not going to change the default without user input, are you
going to ask the user for a default branch name?
Figure out the math and annoyance on that.

On Wed, Nov 18, 2020 at 6:44 PM Philip Oakley <philipoakley@iee.email> wrote:
>
> On 19/11/2020 00:30, Peter Hadlaw wrote:
> > That leaves us with 10 million users of git that are either unaware or
> > are not on board. Let's say it takes 3 minutes for a user to search on
> > the web why exactly they can't
> > navigate to their "master" branch. That's 30 million minutes of time
> > wasted, or about 57 man-YEARs of time wasted.... for what?
> That's (3 mins) probably about the same amount of time as most users
> waste on stack overflow for Git questions, or the old 'RTFM', for their
> problems in a typical week anyway.
>
> 3 mins out of a 35 hr week, over a 44 week x 25 year life is 1.3 ppm,
> unless you work too hard and too long, where it's an even lower ppm.
>
> There are mechanism in this series for setting the default branch name.
>
> --
> Philip
>


-- 
Peter
