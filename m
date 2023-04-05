Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967C7C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 19:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjDETlZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 5 Apr 2023 15:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjDETlT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 15:41:19 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226977A9C
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 12:40:54 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id o20so35500858ljp.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 12:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680723632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wq98D7+2AkYfDLkf1OqLxyRym/GbLikvkppAQQaLhwc=;
        b=rfH5w5rQHFInxcdRd5wn2QbBgOAdri61KVck+5FfWKmE2uT4lIJtQ0ftfS2TCCgrDW
         sr/9/qW7QS5lBfHEvNf8HYyHWqruZ13eTnhSwJ3ojh29rRY58GP4alw8iTyjEnrRiFdw
         pbQE1zeCiWH/FLgs3DbwsNEHK7VEeKgXa/KfArIAqy5Tb81wk4tHOTkx6L+Ivp9dOWsq
         +qiTdlXYvh6Nq9QMP2dm+7/Nb24R7McmFOKCjTi8g7abb6UyHYIzO9GN9WYI5oit0APv
         V6MAJa93l2Cj4b+3Nqm45dQHLG0un9j9NxJTqNpCOMCX9/bmXzN2pT3qU7rcXJGh3Fvl
         is+Q==
X-Gm-Message-State: AAQBX9ftbSh6MztQiwntwfZs4B5CTzN18NSmMyU1GmdlIMmqMWb1kEb8
        y5ZGIU0VsuvajGXppzA4NZ5EIi7o55PJLl41TAk=
X-Google-Smtp-Source: AKy350Y7hXDqiTw4u77IrwBslHwTeFnWZ3TuHB0VTmrcrUtuVprIqOAtICyO5QtbQuEFutlYez2HWzx2n69d1vhbQNw=
X-Received: by 2002:a2e:a401:0:b0:295:acea:5875 with SMTP id
 p1-20020a2ea401000000b00295acea5875mr1410079ljn.2.1680723631858; Wed, 05 Apr
 2023 12:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
 <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
 <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu> <xmqqttxvzbo8.fsf@gitster.g>
 <6d86214a-1b80-eb88-1efb-36e61fd3203e@cs.ucla.edu>
In-Reply-To: <6d86214a-1b80-eb88-1efb-36e61fd3203e@cs.ucla.edu>
From:   Jim Meyering <jim@meyering.net>
Date:   Wed, 5 Apr 2023 12:40:18 -0700
Message-ID: <CA+8g5KHYqgAZPpTOXWekDpWv-mvj-rBkGu+4MXy4OB1VDeS4Lw@mail.gmail.com>
Subject: Re: bug#60690: -P '\d' in GNU and git grep
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, demerphq@gmail.com,
        Philip.Hazel@gmail.com, 60690@debbugs.gnu.org,
        mega lith01 <megalith01@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        pcre-dev@exim.org,
        =?UTF-8?Q?Tukusej=E2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 11:33 AM Paul Eggert <eggert@cs.ucla.edu> wrote:
> On 2023-04-04 12:31, Junio C Hamano wrote:
> > My personal inclination is to let Perl folks decide
> > and follow them (even though I am skeptical about the wisdom of
> > letting '\d' match anything other than [0-9])
>
> I looked into what pcre2grep does. It has always done only 8-bit
> processing unless you use the -u or --utf option, so plain "pcre2grep
> '\d'" matches only ASCII digits.
>
> Although this causes pcre2grep to mishandle Unicode characters:
>
>    $ echo 'Ævar' | pcre2grep '[Ssß]'
>    Ævar
>
> it mimics Perl 5.36:
>
>    $ echo 'Ævar' | perl -ne 'print $_ if /[Ssß]/'
>    Ævar
>
> so this seems to be what Perl users expect, despite its infelicities.
>
> For better Unicode handling one can use pcre2grep's -u or --utf option,
> which causes pcre2grep to behave more like GNU grep -P and git grep -P:
> "echo 'Ævar' | pcre2grep -u '[Ssß]'" outputs nothing, which I think is
> what most people would expect (unless they're Perl users :-).

Good argument for making PCRE2_UCP the default.

> Neither git grep -P nor the current release of pcre2grep -u have \d
> matching non-ASCII digits, because they do not use PCRE2_UCP. However,
> in a February 8 commit[1], Philip Hazel changed pcre2grep to use
> PCRE2_UCP, so this will mean 10.43 pcre2grep -u will behave like 3.9 GNU
> grep -P did (though 3.10 has changed this).
>
> That February commit also added a --no-ucp option, to disable PCRE2_UCP.
> So as I understand it, if you're in a UTF-8 locale:
>
> * 10.43 pcre2grep -u will behave like 3.9 GNU grep -P.
>
> * 10.43 pcre2grep -u --no-ucp will behave like git grep -P.
>
> * Current GNU grep -P is different from everybody else.
>
> This incompatibility is not good.
>
> Here are two ways forward to fix this incompatibility (there are other
> possibilities of course):
>
> (A) GNU grep adds a --no-ucp option that acts like 10.43 pcre2grep
> --no-ucp, and git grep -P follows suit. That is, both GNU and git grep
> act like 10.43 pcre2grep -u, in that they enable PCRE2_UTF, and also
> enable PCRE2_UCP unless --no-ucp is given. This would cause \d to match
> non-ASCII digits unless --no-ucp is given.
>
> (B) GNU grep -P and git grep -P mimic pcre2grep in both -u and --no-ucp.
> That is, they would both do 8-bit-only by default, and use PCRE2_UTF
> only when -u or --utf is given, and use PCRE2_UCP only when --no-ucp is
> absent. This would cause \d to match non-ASCII digits only when -u is
> given but --no-ucp is not.

Changing grep -P's \d to match multibyte digits by default would break
an important contract. Avoiding that feels like it must outweigh any
cross-tool portability concern.

(C)  preserve grep -P's tradition of \d matching only 0..9, and once
grep uses 10.43 or newer, \b and \w will also work as desired.

> Under either (A) or (B), future pcre2grep -u, GNU grep -P, and git grep
> -P would be consistent.

I hope git grep -P's \d will also stick to ASCII-only by default.
Those rare few who desire multibyte matches can always specify \p{Nd}
instead of \d, or (with new enough PCRE2), use (?-aD) and (?aD) to
toggle the digit-matching mode.
