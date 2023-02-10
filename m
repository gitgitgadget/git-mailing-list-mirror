Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35014C05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 19:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjBJTZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 14:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjBJTZs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 14:25:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762547D899
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:25:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1106E61E00
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 19:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778D3C433D2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676057146;
        bh=ZzYqv3GYHJ9eTQlKyZ17xzIWB+D/wQPKFdZ40GMHxe8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZVG94G5UaJ+osCoDv/vYc3pITpncvOe7O3MKYr4AbRygeSGApTZ+CM/8c5Mg6XClP
         P+eYFOXuIKyyyn7pwq9HvWq60pdlnrzZtunVWTRUeSmiG6OMIEMT3s7EbYUbakBkMY
         RLai0nFwUieXF1Z/J5Oz5O4EdeeiLBdRg0M/trRK+75PfUgNbrbCrDYU+STPbVqIcz
         LHEgyzch7n7ifO5gD5KJReTCs6OOYmU6bKO+elka1Ej1ibCaRWrB3PcyvZis5LaK7Y
         hjAtOf9owVDUu/I5meO/cbBrM6npORAzWB0K189wjjXzE7RvqZuu+gCy6jk4hDxA69
         Sa5Qg40x8gTbw==
Received: by mail-oi1-f180.google.com with SMTP id cz14so5283683oib.12
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:25:46 -0800 (PST)
X-Gm-Message-State: AO0yUKVTtIo2ZqGbyvxLxmO6I5Qn0J2Lbuu6UO/DSb3MLqvS/4IIJDaS
        8XfgX2w/AnY7Rf1zS6XZD5jgMfyPqzxdElPEpuA=
X-Google-Smtp-Source: AK7set9ArOgshk0nNBV/hzHnbvUk2roCbaXQgcrf4zRruhAM41jWZ5SuWT9bqS4b7gOudcH9mE0pO3N4dWesE3+u2Mo=
X-Received: by 2002:aca:210c:0:b0:35e:7c55:b015 with SMTP id
 12-20020aca210c000000b0035e7c55b015mr1422291oiz.287.1676057145753; Fri, 10
 Feb 2023 11:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20230210075939.44949-1-masahiroy@kernel.org> <20230210075939.44949-2-masahiroy@kernel.org>
 <xmqqo7q1ibek.fsf@gitster.g>
In-Reply-To: <xmqqo7q1ibek.fsf@gitster.g>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 11 Feb 2023 04:25:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQM6tGmZvy9jVWy099dsOte_=P-Ro3CuAqAc5akiakyoQ@mail.gmail.com>
Message-ID: <CAK7LNAQM6tGmZvy9jVWy099dsOte_=P-Ro3CuAqAc5akiakyoQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] git-compat-util: add isblank() and isgraph()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 11, 2023 at 4:11 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Masahiro Yamada <masahiroy@kernel.org> writes:
>
> > Use them with care because they are not robust against the pointer
> > increment, like isblank(*s++).
> >
> > The same issue already exists for isspace().
>
> Does it?


Sorry, I meant:

 "The same issue already exists for isprint()"




   #define isprint(x) ((x) >= 0x20 && (x) <= 0x7e)


is not robust against pointer increment.




>
> >  #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
> >  #define isascii(x) (((x) & ~0x7f) == 0)
> >  #define isspace(x) sane_istest(x,GIT_SPACE)
>
> sane_istest() evaluates x and mask only once, and isspace evaluates
> x only once, no?
>
>         isspace(*x++)
>         ->
>         sane_istest(*x++,GIT_SPACE)
>         ->
>         ((sane_ctype[(unsigned char)(*x++)] & GIT_SPACE) != 0)
>
> > +#define isblank(x) (isspace(x) || (x) == '\t')
> > +#define isgraph(x) (isprint(x) && !isspace(x))
>
> Given that all the other tests are implemented with just picking an
> integer from the table and checking bit(s), the above two look
> somewhat out of place.  The fact, as you noted, that they cannot be
> used safely does not help, either.
>
>


At first, I hesitated to move these to git-compat-util.h
for this reason, but I noticed isprint() was in the same situation.

So, I decided to go.



-- 
Best Regards
Masahiro Yamada
