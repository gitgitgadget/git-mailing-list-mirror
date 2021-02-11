Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2746FC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0B064E3C
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhBKHjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBKHjT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:39:19 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B77FC061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:38:39 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id u7so2504083vsp.12
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pmrN/34OFeDQwGTAysxERKYFXVRZva5wVpyaWcRBWGE=;
        b=VcpMjlkYjdUOchESsbYhepLGKkIYQ/S2YrnFMiX2nUXjLPXVk67c5kmjLosw7WMKcu
         660qZbYUTgw4oaP62QCnPTJVlcIiYaY5IzI9m/KHhYbsSsrtAcWxoS+uJVrzpBMUQl+m
         YmxOXOyG1s+TACMLkIQaLd4eE9QpR6KV4fArahXq6ecP12S9hCk989VSHGIKgLkFqbAP
         /Gn/IO0dT8rdSuEymoP0iQoNftNVJHrEFN9g7iox23/DZj5XMEKeLXmfKxnDfzH5eZIO
         N0A0Z3gAMUVcA0Q53q+1B/+X2T5y56Lm12M4NQmzc6f3Z29wHhunB4i4dCGAy6tOqw+/
         5wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pmrN/34OFeDQwGTAysxERKYFXVRZva5wVpyaWcRBWGE=;
        b=XGhHpDU5L3sLEgsuULOK2dZkOoeAdf4Lgp124PC00xsoJuifL0DMUFMkdka8o0nnrZ
         jhaRpPoVwgRi853rTmV8L/MOS7Mh/dsIGcwvxj0/wtUNiRXGAR/Mr5AGSb15BJYdxm4c
         lt8ewLudRsfK7sGVxJz7BD5Av57olRsBzzcSYLrXx8iSsW5FSqM8WqGn1qiw7pAYaADO
         nHt/Ylq94R3/k54Oeos165tTSZ0VOL7gal1FRJY1pn4FUbXXXGdh3d2yeAj3zJ2aySra
         R0hgjRlhmi1EE7Qdd8LRjF+Fp2J21hqeVwjjp7sonZbFLPp+3UxAPHXZEl7bazSJXC/L
         iOgg==
X-Gm-Message-State: AOAM5335zp3HUJiKToSuPMkpcE1na2uscc4hLlyOqMKngftuq1G8cSi3
        u16Gt43R2GZOnUoOU5+3vwncQHN3+JK5kZrI4zOnSw==
X-Google-Smtp-Source: ABdhPJwu8dY6HQN3ZGBe6mjCyk+g6n/QPo1ttaE8j8qOErcy8YzKIVe5HxLed10oAyil7vAr/F85Oh4059ae09YjzkM=
X-Received: by 2002:a05:6102:3110:: with SMTP id e16mr4088140vsh.12.1613029118624;
 Wed, 10 Feb 2021 23:38:38 -0800 (PST)
MIME-Version: 1.0
References: <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
 <xmqqo8grzbjv.fsf@gitster.c.googlers.com> <CAESOdVDgpe9yacMxKLO_AjAnadcSjrik_NdwhW-4vDELf+UxPw@mail.gmail.com>
 <xmqqeehnysbv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeehnysbv.fsf@gitster.c.googlers.com>
From:   Martin von Zweigbergk <martinvonz@google.com>
Date:   Wed, 10 Feb 2021 21:38:27 -1000
Message-ID: <CAESOdVCYceVgF4B0f--yjheS+FijX-GJWUYjfgz1tRrL7kU+yA@mail.gmail.com>
Subject: Re: [PATCH] docs: clarify that refs/notes/ do not keep the attached
 objects alive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 9:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin von Zweigbergk <martinvonz@google.com> writes:
>
> > Good point. You dropped the bit about the notes (texts) being kept
> > alive. I don't know if you did that intentionally are not.
>
> Yes, I did it on purpose, because it is just one of the things that
> can be reached from refs/, but we shouldn't write our document for
> those like me, who know what notes and other things in Git are.
>
> > I initially
> > thought that we should keep that bit, but it's probably not actually
> > very useful information. Users probably don't have large amounts of
> > information stored in notes, so they probably don't care whether notes
> > text is kept, especially since there's no good way of pruning the
> > notes.
>
> I am not sure if I agree with any part of the above.  End-user data
> is precious no matter the volume, and we keep notes by making them
> reachable from refs in the refs/notes/ hierarchy.

Sorry, I forgot to qualify that whole paragraph with something like
"Regarding notes attached to unreachable commits: ". Users will
obviously not want to lose notes about reachable commits and they
won't. So the only remaining concern in my mind was whether they might
care about it because they *want* to save the space that the note
used. Makes more sense then?

> I am not sure what qualifies, in your eyes, "good" way, but "git
> notes prune" is a good way to remove notes that are attached to
> objects that have already been pruned away.

My paragraph above probably clarifies (that I was thinking about
saving the space used by notes, which I don't think `git notes prune`
helps with).
