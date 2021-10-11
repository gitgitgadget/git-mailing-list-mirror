Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B07BC433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 19:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433B261027
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 19:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhJKTt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 15:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhJKTtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 15:49:25 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E077C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 12:47:25 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id r17so6637647uaf.8
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+UTNemJJXjAFMrEv1WLR/poj5pXHoGJAp1jmuQUvqtE=;
        b=ZLxYDezLRkTw9zalU/69TD3nJUfvaFxS+dRDMpN48rBJd/ZHPlftPqyd27zrvLwBSi
         R87vnPWUANHf6JjCInx8ecG02YMA6OPicxbzkJAntitrkIlHTn29nUziDvxOCkpcJ6Gd
         QAe5slLHCbcvsBjSLeh8fNHlgXmCHc+6BcKZSQ5N0N7uMvcImuLMnI5K6jHYta42xUM/
         oc+WmMobInV8uLyhYm4HRFFdQ/Lx6iCeX72xtqJv7xH7T+Ayf00jLT5mXNI0vu++930O
         mQWW7TPuySN9VSWUQNdQwUt+7Mh6PNLzCaohW3JGgXNzjGhJ0V2VwrjFiRjGdPoMhIfj
         t/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+UTNemJJXjAFMrEv1WLR/poj5pXHoGJAp1jmuQUvqtE=;
        b=ufz7cqKJgPUmu2JxND2E2suAw1JliEu1APVNkbsBTgg/vbEjBm4Y47Kk/Ijy0gArbC
         Rz63y2HhW5cmtzqp9wNmS3/4/KihkHuPLtc+D/i/lK9VGT6oPEKGC3DyeSzABoQ+7ZEA
         0r0LjETa52aphi1IzKMmRFygVdrx90j83F/7GnbcWDTcX/aegVHjq08Sev2nLvxQD8Uh
         yjQSYI9wotLThyQ8c91zKGvYGdEjGhoG8bRfdDZt9NM6p63Ol0wYtNDylx7vWs6kpPkJ
         zYT2Fp8zEW6e63k/MrslGta1kF/ORDvCGpjx8ssM56MrQTZmqm5tzHDCg73IONfaiEp3
         ZYkQ==
X-Gm-Message-State: AOAM531EjEJhwNT4/Yom2u+JHkkGm1V87cwv+Ka3Tqa2QR9nadEx4WI5
        V9YdRq56QC/iGmNeRm8ePD50LxzgTpbaprxwo1CMLPAYL80e+A==
X-Google-Smtp-Source: ABdhPJyF0vlIR5VkYmvrXyaRiUnGVakNoJePoCaWzKSKXDK3KKnk3dUE1YKFSV2Uurm1nm3aqdnlBqPFVtBFbyRYvic=
X-Received: by 2002:a67:f5c3:: with SMTP id t3mr5228498vso.14.1633981644196;
 Mon, 11 Oct 2021 12:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211011121757.627-1-carenas@gmail.com> <87bl3vlk0j.fsf@evledraar.gmail.com>
In-Reply-To: <87bl3vlk0j.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 11 Oct 2021 12:47:13 -0700
Message-ID: <CAPUEspjFZDKtP8oJmuA6dCcX9XF1WBFvFikkZTNcKfHbOxJwPA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] git-gui: support SHA-256 repositories
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, angavrilov@gmail.com, me@yadavpratyush.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 7:21 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Oct 11 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
> > [1] https://lore.kernel.org/git/20211011114723.204-1-carenas@gmail.com/
> >
> > Carlo Marcelo Arenas Bel=C3=B3n (4):
> >   blame: prefer null_sha1 over nullid and retire later
> >   rename all *_sha1 variables and make null_oid hash aware
> >   expand regexp matching an oid to be hash agnostic
> >   track oid_size to allow for checks that are hash agnostic
> >
> >  git-gui.sh                   | 30 ++++++++++++++++--------------
> >  lib/blame.tcl                | 18 +++++++++---------
> >  lib/checkout_op.tcl          |  4 ++--
> >  lib/choose_repository.tcl    |  2 +-
> >  lib/commit.tcl               |  3 ++-
> >  lib/remote_branch_delete.tcl |  2 +-
> >  6 files changed, 31 insertions(+), 28 deletions(-)
>
> There was a similar series earlier this year which didn't make it that
> fixes some of the same issues:
> https://lore.kernel.org/git/pull.979.git.1623687519832.gitgitgadget@gmail=
.com/

This specific series is for git-gui, and the one posted before is for gitk,
but the code is still similar enough, and indeed the gitk part was
included in a reference.

> Just seems like a lot of needless work as opposed to just matching
> x{40,64} or whatever.  Yes that's not the same regex semantically, but I
> think the current code is just being overly strict, i.e. it's parsing
> some plumbing output, we can trust that the thing that looks like the
> OID in that position is the OID.
>
> If anything I'd think we could just match [0-9a-f]{4,} in most/all of
> these cases, would make things like this easier to read:

It makes me nervous though to see checks like the one I fixed on
commit[1] that use logic to check the correct size of the SHA as an
implication of it being a valid value.

considering the code is very old, maybe that was relevant long ago?,
but agree some checks seem to be unnecessarily strict.

I have relaxed some of the checks in the gitk patch and will be
posting it soon, so hopefully reviews from people that know the code
better could be collected.

Carlo

[1] https://lore.kernel.org/git/20211011121757.627-5-carenas@gmail.com/
