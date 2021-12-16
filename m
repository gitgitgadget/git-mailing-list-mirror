Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A672C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 23:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhLPXqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 18:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhLPXqE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 18:46:04 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3FBC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:46:04 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x15so1466543edv.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CKTNiqJJSz7Eh3Nd9B94SLdBSvbpelT1x+UNZRFUfeQ=;
        b=YYwO5sJG7l7e6zR1fFaSaJxJbxLp8R7PtlzutuZXust8Kf2Sx/mQ+2xmovTeAG7TMd
         /PLxp3o+LLni34yPy3fuatctH3+2WePqnMvYDp43YUsboGrjEaU8yJaNBAzJxe/mHAVY
         Dfefr1sWgZp40w1WRXtlAC73LADTd9ZM2oQ/XfrKaeSC609tegYTX2TVxCAdovmvMEp7
         9wYSmC+F27GNUhYVOWkOo6G3PA83Brz1qQxE5XnKst2/FBm7UCYBljP1u2cMmJhEa9Pa
         RpODUuuMPP8UWvMfw9gwdxOmjqqU/Zrcq8pzFgLv7nKRB3dIHdjRWvvutsU474ZRhM2U
         fJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CKTNiqJJSz7Eh3Nd9B94SLdBSvbpelT1x+UNZRFUfeQ=;
        b=el9hAjjWmTX3Kb836THT13Jal12bw5y4+9Fd5gCunl5NGKcdNueq52lYPaFlf9vAkr
         Mua97Ej43an1p1aNDV8E1pHyKcF0ChYTdcRWphsruFPBqVTF6Jp1lEC4hGJ1SFoXDF38
         4VSA6CwGOakADrLxz0j7paJ/hv7Kb29KOzoRx6SvkRPjjUS5kY7h/Y/h19ix3vwQ9hIo
         0lhh0AJ6ztb3GCsgKg8I4yNdRyi5CnvjMdDzWEmEFXtqrThUPpMw1WJkfNNe8HyDcZxY
         meuxQ6lWlZ887rvMk0tG2UskuDGSewNGnZJVsfMFGR+cSW39NyY+sPcFK3jGKKeGhpx1
         GxsA==
X-Gm-Message-State: AOAM531xmXcN7v2rNStsDcpDJd0S1jIN2NtQN5jyZFis3HGr6J7QC2lc
        Vbdj8ARnWCR1nUeD6YM2WFAeaLirBAJPCg==
X-Google-Smtp-Source: ABdhPJzJ3pMAAJJX0wJi4j+sVtAzcA4eol4uU3hP+LYyLdULxIqYxXORlTreBIeKkDOXJOTOLOlm5A==
X-Received: by 2002:a50:e688:: with SMTP id z8mr294700edm.107.1639698363127;
        Thu, 16 Dec 2021 15:46:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y17sm3072629edd.31.2021.12.16.15.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:46:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1my0Rk-000cxl-MV;
        Fri, 17 Dec 2021 00:46:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jasdeep Khalsa <jasdeepkhalsa1@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Adding new/create & del/delete aliases into git
Date:   Fri, 17 Dec 2021 00:43:48 +0100
References: <CALtRjJ3bu1ub=407kt-aemfV6BU8CfPZJxLRG5WgTZBYWbaXCQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CALtRjJ3bu1ub=407kt-aemfV6BU8CfPZJxLRG5WgTZBYWbaXCQ@mail.gmail.com>
Message-ID: <211217.86ee6c9kqv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 16 2021, Jasdeep Khalsa wrote:

> Hi there Git Community!
>
> I've been using the following aliases for a long time:
>
> del or delete = branch -D
> new or create = checkout -b
>
> And I feel these are good candidates as an addition into the core git
> API as they provide an easy way for new starters to understand the
> creating and deleting of branches - which is arguably one of the most
> common git operations.

As a general advice if we're providing any sort of sugar / default flags
either as a guide or as aliases for newcomers it's probably good to not
do so with --force, i.e. your -D will shred data users might still want,
better to make it a -d. You can always add -D when needed.

> In comparison, passing in flags for this purpose for new starters to
> git, is both hard to remember and not easy or obvious to understand
> what is going on.
>
> From my understanding, these flags were also meant as a shortcut to do
> a git branch && git checkout in one operation - effectively being
> alias flags anyway.
>
> So I wanted to reach out to find out what appetite there may be out
> there to add/change these to be simpler for new starters to git :)
>
> Thanks for considering my proposal and happy to discuss any thoughts!
>
> Jasdeep
>
> https://github.com/jasdeepkhalsa

There was a more extensive proposal discussed on-list recently here:
https://lore.kernel.org/git/20210702100506.1422429-6-felipe.contreras@gmail.com/

I think if you're interested reading that & using some of the things
that came up there as a jumping-off point would be a good place to
start.

