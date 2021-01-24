Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6C2C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B9622D57
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbhAXR36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbhAXR3x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 12:29:53 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBA6C061574
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:29:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g1so12484611edu.4
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qA4cECCWzBDw6Q+mWF1ZnaGFgm/mHyQ7BueGsBVVdEo=;
        b=Wzcqb/8x9xMycn7s7Zg2n+2n6qpAM8do3mKIsF4tou9snL7+LxQIzLumIDbZqQbWZe
         qH+nTwjKuJbRXBQB+4Iz54H9ixYhDvHJXC4JkqGtmyqn6F1vOSRn7rQ3MKvBu6h+iU14
         dfhEzLe3NFS+v0Ajat8xaIovTI5zohSCbMzzYAgJaGlbmG7oz4VBWrgTi7+cudJ2TbLi
         QWofJYCvk9z4leMBAnh6dJzqqLXUidRY6Vj6hagduiSlsHvWEdYsT8Pz2auaw2sc/off
         k+iPgNYfoF9yZI552UxDH3X045ttj0Orze/NCMezvfCrHAKUIeM2g+U34EDOjEPifYac
         WM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qA4cECCWzBDw6Q+mWF1ZnaGFgm/mHyQ7BueGsBVVdEo=;
        b=lyeHr/NPDXAGvIub9dBMbHKRUimiyaN9C15lCR32YxaLK/xgr4X2LxqpcwtEWMD9Fv
         yLD7N2kIO3my3EtAhuvIw/WncWQYX51CkLwJOcx9aCUD452wfTmmLZBygFcKxoQl47J/
         HRiz5fDJo+dq5vweVQUUYX0+i89KfGpSeJzMEZqhbEre3tl51jfCDOO3yKuQ8sa9JRbG
         cJ06edwpT82i4+7H+Td4C5xukEvmoHRjIxp/gl0dePv0kqrnEgJtqaqHkQPNghdCQbtH
         zUm+b3CBGSzUL2iT1L+1Nw9Z7B8aVT9QrEnlaxerbkGIETY9Cf/gC1WlrwJCoKLh+G3d
         RZ5A==
X-Gm-Message-State: AOAM531GgV9/EFNapvNDB/68s1O39Mglm2PX1Z8G56TcEUrnf/QYGQXq
        w/4nI/38dQw2uwcuMPKmPrI=
X-Google-Smtp-Source: ABdhPJwaBVMbfdn7RkKsqsSKWfPZdH34kmkNZ8A69s3yKLuSaqYuRkQiDHSntthfCoheRTqt4LZ0Cw==
X-Received: by 2002:a05:6402:78f:: with SMTP id d15mr359600edy.362.1611509351190;
        Sun, 24 Jan 2021 09:29:11 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id i18sm8861895edt.68.2021.01.24.09.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:29:10 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 2/2] grep/pcre2: better support invalid UTF-8 haystacks
References: <20210124021229.25987-1-avarab@gmail.com>
 <20210124114855.13036-3-avarab@gmail.com>
 <6fe69ede-d24b-1742-f699-c9af05560c0c@ramsayjones.plus.com>
 <3f32c0da-ddb9-d821-5d37-5c002b48f9f9@ramsayjones.plus.com>
 <87a6sy75ka.fsf@evledraar.gmail.com>
 <a75cfde9-0ac3-9af4-777c-1824063c6b0b@ramsayjones.plus.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <a75cfde9-0ac3-9af4-777c-1824063c6b0b@ramsayjones.plus.com>
Date:   Sun, 24 Jan 2021 18:29:10 +0100
Message-ID: <877do26y6x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 24 2021, Ramsay Jones wrote:

> On 24/01/2021 14:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Sun, Jan 24 2021, Ramsay Jones wrote:
>>=20
>>> On 24/01/2021 13:53, Ramsay Jones wrote:
>>> [snip]
>>>
>>>>> diff --git a/grep.c b/grep.c
>>>>> index efeb6dc58d..e329f19877 100644
>>>>> --- a/grep.c
>>>>> +++ b/grep.c
>>>>> @@ -492,7 +492,13 @@ static void compile_pcre2_pattern(struct grep_pa=
t *p, const struct grep_opt *opt
>>>>>  	}
>>>>>  	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pat=
tern) &&
>>>>>  	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>>>>> -		options |=3D PCRE2_UTF;
>>>>> +		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>>>>> +
>>>>> +	if (PCRE2_MATCH_INVALID_UTF &&
>>>>> +	    options & (PCRE2_UTF | PCRE2_CASELESS) &&
>>>>> +	    !(PCRE2_MAJOR >=3D 10 && PCRE2_MAJOR >=3D 36))
>>>>                                    ^^^^^^^^^^^^^^^^^^
>>>> I assume that this should be s/_MAJOR/_MINOR/. ;-)
>>>>
>>=20
>> Oops on the s/MAJOR/MINOR/g. Well spotted, I think I'll wait a bit more
>> for other comments for a re-roll.
>>=20
>> Perhaps Junio can be kind and do the s/_MAJOR/_MINOR/ fixup in the
>> meantime to save be from spamming the list too much...
>
> Umm, sorry for not making myself clear, _just_ changing MAJOR to
> MINOR is insufficient.
>
>>=20
>> FWIW I have tested this on a verion without PCRE2_MATCH_INVALID_UTF, but
>> I think I did that by manually editing the "PCRE2_UTF" line above, and
>> then wrote this bug.
>
> Yep, I seem to have 10.34 on Linux Mint 20.1 (based on Ubuntu 20.04).
>
>>=20
>>> Although, perhaps you want:
>>>
>>>             !(((PCRE2_MAJOR * 100) + PCRE2_MINOR) >=3D 1036)
>>>
>>> ... or something similar.
>>=20
>> Probably better to use pcre2_config(PCRE2_CONFIG_VERSION) at that point
>> and versioncmp() the string.
>
> OK, but it needs to be 'something similar' (try putting, say, MAJOR 11
> and MINOR 0->35 in your expression).

Ah yes, of course. I re-rolled a v5 with a fix for that. Thanks.
