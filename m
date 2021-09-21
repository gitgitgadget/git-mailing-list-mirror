Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7F5C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 09:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9F160EE4
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 09:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhIUJF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 05:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhIUJF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 05:05:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446EFC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 02:03:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bx4so27200662edb.4
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 02:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2HCibjNFPO5xyEaNLIUvm2UuRoLe4NbjV5gAVdhnaXk=;
        b=IeUUsBid/koqvq5vu1s9JPr+D2lAl6SU61W4RCteMgrEyVvALehJ5o9dpI53GPAVxW
         NI5Pub+59IInSKwGrcTzOgDh/WxZpNEBPfs9n7XFspuIZi+DYgh6dFUj6OEgkfWWwl14
         isptnDyJrNO1Km1kV01WuI4xduw5TzY3c3PO3DhxfsIdIGXgTq6bJ458ioaaOgs0oYL7
         PamFUN5uORzSkpH9HifK9UrUk9M23jDFzA5nwqjg6K+TTV1TZ5jcZueLTIJTjEWwQ/VV
         qtW2QykdVnjGlXRAdcuowrMwkQ6sFM/1iFK8AY007XyKt+riyHaLqdHV2nqbr1vkSziN
         5e4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2HCibjNFPO5xyEaNLIUvm2UuRoLe4NbjV5gAVdhnaXk=;
        b=ZnZyXMObqTwikobZoFlFBreLeVeD6yWOICipvM90vBQUQdQ+pdvAwd/Zmlw2vJVEtg
         1+RkBUF/+7GXKjhh1jNbOf2v7kVbS8gxHZpjIEvnsHPxwpUOWCnI9Tdg9uBfRuzMK1sQ
         UFBVejhRLNv+0bzijlurn/RdS4ojXfGlZjHlXVqXrLtGTx6R721GA4XGgZzO5vxlJNpe
         S+ioTiqrmdyxn/f1riwpMdezUiX3AslqKE564ycgQB55kbDPzE5Z8UZChd1mfOInZTq4
         O4ZiyCvMxATOAXsCpGZkj6GDgcAQlr0s3aePEm+08HDV0gPMEYyhkIBh0u+fY6eAsGCK
         McyQ==
X-Gm-Message-State: AOAM530kPs/zfqcdPlgKwRd4GCWocyMx5yFGI2gh7fJazMtzrtWdGH0g
        pLLbN5S4LPkpxbnYcRXyEAsCpr6lgJO5wQ==
X-Google-Smtp-Source: ABdhPJy3Da7vMjJpRiNRwghtvQCOeMr5lMCIkL1j46hN7ANUoNBVBqdHJDN/QanPMehPuB9xm59a9g==
X-Received: by 2002:a17:906:5855:: with SMTP id h21mr32654932ejs.230.1632215037737;
        Tue, 21 Sep 2021 02:03:57 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ku7sm3956730ejc.90.2021.09.21.02.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 02:03:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: cb/pedantic-build-for-developers, POSIX-but-not-C99 and
 -Wno-pedantic-ms-format
Date:   Tue, 21 Sep 2021 10:44:02 +0200
References: <xmqq1r5iaj9j.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq1r5iaj9j.fsf@gitster.g>
Message-ID: <87lf3q9u6b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Junio C Hamano wrote:

> * cb/pedantic-build-for-developers (2021-09-03) 3 commits
>   (merged to 'next' on 2021-09-10 at b8df102019)
>  + developer: enable pedantic by default
>  + win32: allow building with pedantic mode enabled
>  + gettext: remove optional non-standard parens in N_() definition
>
>  Update the build procedure to use the "-pedantic" build when
>  DEVELOPER makefile macro is in effect.

With -pedantic one of my WIP branches started erroring on:

    error: ISO C does not support %n$ operand number formats [-Werror=format=]

I.e. complaining about "%m$" instead of "%" in printf formats, it's easy
enough to fix in my case, it's just something I used to de-duplicate a
rather complex format, this makes it C(89|99)-compliant:
    
    -       strbuf_addf(&fmt, "%%s%%s%%s-%%0%1$lud.%%0%1$lud-%%s-%%s-%%s",
    -                   (unsigned long)tmp.len);
    +       strbuf_addf(&fmt, "%%s%%s%%s-%%0%lud.%%0%lud-%%s-%%s-%%s",
    +                   (unsigned long)tmp.len, (unsigned long)tmp.len);

But in general, do we view -pedantic as an implicit endorsement that we
should be using less POSIX and more standard C than we otherwise would?

I may be wrong, but I believe that construct is widely portable, we
don't use it in the main source, but in the po/ files (so anything that
uses git + gettext tests for this already):

    git grep '%\d+\$' -- po
