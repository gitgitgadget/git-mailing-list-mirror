Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B992FC433F5
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 05:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbhK0Fc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 00:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhK0Fa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 00:30:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E203C06173E
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 21:27:14 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g14so47069738edb.8
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 21:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+xImt8c8Ee77xbaZoJjpwhxUgMFgNlI55tWwDzXv/A=;
        b=p6f+Uu+aP2E84TXR5Jowj1LxILpFZ6WPtnyw51BzoU+V+VEE7Q8Zrqa4hGjD6fQs08
         zdfRTTxqfJCeP36nAqjVu3baRTalR5QkiljB3dXJJUWJspJF8XRkfQGfI0GC2hj0v+JR
         ceKggCiJ+FLjct6ywNK0UqR+LciY069lhauO+qwUZxfZD8wO7mwMUtx6tuVoUd8R3UxV
         Nm/s9V7u0X97JYJiKfxM1L1l/WxtBwYoJXE4ls8rB1e6ktDF/9/NC4CKlVRjndJTA3vZ
         TfoG3iIndvcV5XFSl+KYHdwU7IAKR1GLP+gcdYieOaaotpuci3OD837pyfpsvQzhqOpR
         8cJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+xImt8c8Ee77xbaZoJjpwhxUgMFgNlI55tWwDzXv/A=;
        b=VaXgaro4QGMOaBvO7hHqWkh12fCzFvQwG+Gddg25gMbg4uvGEXhPLbQgCFoMnuLusR
         YKYVYk6nmXHuE5/8qfrxkyiomOSzD3jdc0kTkkjIYmbh/Z1ZI6VRSKheJpAsggYkKrfV
         3+MGpm+bR/GdNy52WvnpyAYu5NGcqeURmUo11HxgwtLrDTt2lMy35URwJKfIDV97TqZJ
         fpNX62V+Isqk6MUHHKmCs6QtzSzA0jl6dBY5EkHGmeRsAjSZ7ajH/aRU7CIVA4e/6/Uo
         ISE0PJWEb5JvdJEcVAtk3kuCLWl0gdif+sUJqA2gJypSguoQAQNo/4GWOT06PxEHdT3E
         xW2A==
X-Gm-Message-State: AOAM532En8QTsbhFkTYU43GyejnrBYN0J3zR7PE2/x1+gPqCvf96ydvd
        u0x7cGkOFWBIbJhczCncE646gvlXHESYu3m48lM3pW00HoU=
X-Google-Smtp-Source: ABdhPJw3NA0tqH1KPQZK+riP4H0fPcfdBUDhcRhXso6cXJGNkgGhrqTyvQDlBfTb7fLSZTyIwuWGwjs3it37PKnP3/o=
X-Received: by 2002:a17:906:31c2:: with SMTP id f2mr44247663ejf.341.1637990832985;
 Fri, 26 Nov 2021 21:27:12 -0800 (PST)
MIME-Version: 1.0
References: <YYFEE/2g3SiM04zx@hades.panopticon>
In-Reply-To: <YYFEE/2g3SiM04zx@hades.panopticon>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Nov 2021 21:27:02 -0800
Message-ID: <CABPp-BFdtEB5chYz9tPxJ=M-4U408P7apiROD1-538sb5+aiDg@mail.gmail.com>
Subject: Re: pull.rebase config option broken in 2.33.1
To:     Dmitry Marakasov <amdmi3@amdmi3.ru>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dmitry,

On Tue, Nov 2, 2021 at 7:09 AM Dmitry Marakasov <amdmi3@amdmi3.ru> wrote:
>
> Hi!
>
> After update from 2.33.0 to 2.33.1 the pull.rebase = true option
> no longer works: `git pull` no longer tries to rebase (however manual
> `git pull --rebase` works fine):
>
> % git config pull.rebase
> true
> % git pull
> fatal: Not possible to fast-forward, aborting.

Was pull.ff also set?  As per
https://lore.kernel.org/git/xmqqzgr3pso7.fsf@gitster.g/, --ff-only
overrides --rebase if both are given on the command line, and by the
same token, pull.ff=only will override a pull.rebase=true if both are
set.

Yes, I know it's weird that we have two separate potentially
contradictory settings.  A single pull.mode would be better, but the
backward compatibility story to migrate is a long story.  Prior to
v2.33.1/v2.34.0, we had a bunch of untested and mishandled
interactions.

> % git pull --rebase
> Successfully rebased and updated refs/heads/local-fixes.

Right, the command-line options take precedence over config, so if you
add pull.ff=only, the --rebase overrides.

> % git pull
> fatal: Not possible to fast-forward, aborting.

This was the bug fixed in v2.34.1; see ea1954af77 ("pull: should be
noop when already-up-to-date", 2021-11-17)

> % grep -C1 rebase .git/config
> [pull]
>         rebase = true
> [rebase]
>         autostash = true
>
> After downgrade to 2.33.0:
>
> % git pull
> Current branch local-fixes is up to date.
