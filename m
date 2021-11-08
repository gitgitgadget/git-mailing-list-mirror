Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC57C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 18:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A86617E5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 18:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbhKHSyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 13:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbhKHSyt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 13:54:49 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7C9C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 10:52:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g14so65864937edz.2
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 10:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=LzVkZsjMe1qo+GWb3JXhUqq4pjE/6w2FSbb1h99wHu0=;
        b=Gh2+9E/wntyrEf6R0MIdTiBef7gSjeMC9inf6m+9I+v65hMauaR0m+snoAXXyACS7p
         4qk8OOEsQDwEx7WKC2iNu+H49o8uDT+7LCxygOWO/flCA0prhVw6rUlD274Nj3ABKX2m
         hFhC8K93GBkEAWYcLGT9So0hQtzWkzUDHLFV2V1Sgy0dhg6B7jv8I7hXABbME90mLog3
         sT1mAj0YSbmcQGz1NkWnn1dIRKixYawn5Y9qUQhdRqUTqoBWDUl+/xNxKOl3ne/sJfMG
         N/UQqpzi2G7OH30NkwslkwBipEH9z3J4P3S6fw+drb7p5csBHnVDvA2PGYLE5oou/Aiy
         oy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=LzVkZsjMe1qo+GWb3JXhUqq4pjE/6w2FSbb1h99wHu0=;
        b=vZJkJKfnxOEHWpVRW532fYAyl0mv7K1a8CpyYjJmpGq5gP9X2b9WsORariANf539A/
         qzFX9knLVentBMSfAO7duaeY7WcFbRIW1wvzXHelqrRZ9mMt01K+OStqIErA+soVCRsA
         rSOhaEwYohLE4kpcGIWYNBsp0vcL//u0z7/C1Y9MzGgJROe9DYhzTZpswu/9lep2zwSK
         A3sUQWWNEqL9TDnUJbSyRM1G4vllXMUK7mRD+MFzr+7KnF+QIVNkhT0M7y+PtGf4kYDm
         FHOPnAsMPSqh3oSEf0qGim0jPMPRPhZ8HwmfvxHIYdneZTXgFpzKPFjO09kKkbnwzyPZ
         Q1XA==
X-Gm-Message-State: AOAM532T1P14kEoFIzlTpVx2RZS410V+BHJAsGyzxHD98jeYNDeNkfDp
        XNOpHreq3TFdiHZn6drVNKc=
X-Google-Smtp-Source: ABdhPJwB7bP7djWxgSqVDuCNMWgN9WQY4eY3TbOqChTlfZzb7kzxNYu+DyOSe61XDKulu01e3QvKNQ==
X-Received: by 2002:a17:906:2788:: with SMTP id j8mr1710685ejc.203.1636397522383;
        Mon, 08 Nov 2021 10:52:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hs8sm8574838ejc.53.2021.11.08.10.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:52:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mk9kP-001DKj-FF;
        Mon, 08 Nov 2021 19:52:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] ci: disallow directional formatting
Date:   Mon, 08 Nov 2021 19:49:28 +0100
References: <pull.1071.v2.git.1635942236065.gitgitgadget@gmail.com>
 <pull.1071.v3.git.1636031609982.gitgitgadget@gmail.com>
 <211104.86ee7whvoz.gmgdl@evledraar.gmail.com> <xmqqpmrf3kjz.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqpmrf3kjz.fsf@gitster.g>
Message-ID: <211108.86cznafpke.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 04 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> +# U+202a..U+2a2e: LRE, RLE, PDF, LRO and RLO
>>> +# U+2066..U+2069: LRI, RLI, FSI and PDI
>>> +regex=3D'(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u20=
69)'
>>> +
>>> +! LC_CTYPE=3DC git grep -El "$(LC_CTYPE=3DC.UTF-8 printf "$regex")" \
>>> +	-- ':(exclude,attr:binary)' ':(exclude)*.po'
>> ...
>>    ! git -P grep -nP '[\N{U+202a}-\N{U+202e}\N{U+2066}-\N{U+2069}]' ':!(=
attr:binary)'
>
> So you are comparing
>
>  * requiring bash and C.UTF-8 locale to be available
>
> vs
>
>  * requiring git built with PCRE
>
> assuming that "Dscho says doesn't work with PCRE and you say it
> works with PCRE" is resolved?  They seem roughly the same
> difficulty to me.

We can hard depend on a git built with PCRE, since the point of this
thing is to run in GitHub CI, Ubuntu builds git with PCRE, and that's
unlikely to ever change.

The caveats around PCRE that still somewhat persist around PCRE are due
to a misunderstanding, i.e. I think Johannes tried the \uXXXX syntax,
which we don't opt git-grep into, but as shown above you can just use
the other universally supported PCRE syntax for referring to Unicode
codepoints.
