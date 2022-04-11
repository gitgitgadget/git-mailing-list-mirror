Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9131CC433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 10:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345145AbiDKKNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 06:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345143AbiDKKNe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 06:13:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F401A4248E
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 03:11:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r13so29825941ejd.5
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9eBO1FjpY9WQBdztYl8CSLsFr+Z/wfeTw4svnjAnye4=;
        b=BM8Ag1FAw6/40sqI2Nriioknz2V32Z6UGvx4ZqgK17iEEJoTi6QsuOeeYrhFLHQljI
         lcmtVKjCpN+z0MPZxfJpbOg5s9hvyCA322bWkPX5ETVuIEQsKq3ZPYDZAe9eVwm9zZgA
         6wd1H2wpmzdjPh5lgDkdJWskUKKQjGuB5NITjrWzzkkFXy2wWXpf56sda8/8mmdIiqi9
         dCvRLqQS7mE4cKFVCAkhHzBkSSaKenmLXbfLuVWvdnQdrPC0KWvmG8GXzm76OT0uI2GP
         PSzRvvwVHcvSxsMFPq2C7VTEZu0JoTmfX602m35Cdr3mGfJqbce/XsfpktF6Rh2NGYk0
         MpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9eBO1FjpY9WQBdztYl8CSLsFr+Z/wfeTw4svnjAnye4=;
        b=Ua6JF+NTQliL/SlRlYxn/Y55It0FD3AdukrwCuT6x3YIhdXifKXLmOCeHEyH89O0/v
         0Igwkx55ya8gVi4c4Z7gPfrAC0eAWHh8L71VMkJziPRsA4FvAlRfIBn0nEGqJgiZnG97
         dE0AlZNMoRkrkIvKvLYUVjq+UsNzJin9syP8YrYMvdH+c75GpRROy+6Q4xkmXkOnzBsz
         0U+2d6mz/eDzxs82D7Si/zs+i9mK81HS7qamtYpxfsceJJJGKpmBnWzMvvfI4O4dRAko
         3la2z+6PmAZXEYLUg7P8BuRfe8RU7iRJxHGS+voGpWmVYPnQsYT+YNlVjI+JD4xmalTJ
         8i3A==
X-Gm-Message-State: AOAM532RdgcPL5y3wR0Mh0iVlS3udWiWcVqHMbkjsaILB4e8RHQzckyY
        ZqM82wC32+7oCciNhuwYx5SOLyhku7Y=
X-Google-Smtp-Source: ABdhPJxldNETreoBWOvmkqyxChwpfDHy77WF2woFEsj9Vb/ghPex2iFCz410z0xi+WHz2Ys52UfyGA==
X-Received: by 2002:a17:906:478b:b0:6db:8b6e:d5de with SMTP id cw11-20020a170906478b00b006db8b6ed5demr30012559ejc.161.1649671879025;
        Mon, 11 Apr 2022 03:11:19 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f7-20020a0564021e8700b0041d03a94f27sm6526086edf.66.2022.04.11.03.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:11:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ndr0v-000J6E-RI;
        Mon, 11 Apr 2022 12:11:17 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rene Kita <mail@rkta.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 3/8] Makefile: disable GNU make built-in wildcard rules
Date:   Mon, 11 Apr 2022 12:11:07 +0200
References: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
 <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
 <patch-v5-3.8-9f42f40b518-20220303T160155Z-avarab@gmail.com>
 <YlP9U8GOgsfnZcKQ@x200>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YlP9U8GOgsfnZcKQ@x200>
Message-ID: <220411.86a6csj5fe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 11 2022, Rene Kita wrote:

> On Thu,=C2=A0 Mar=C2=A003,=C2=A02022=C2=A0at=C2=A005:04:14PM=C2=A0+0100, =
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> [...]
>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  shared.mak | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>=20
>> diff --git a/shared.mak b/shared.mak
>> index 0170bb397ae..29f0e69ecb9 100644
>> --- a/shared.mak
>> +++ b/shared.mak
>> @@ -1,3 +1,14 @@
>> +### Remove GNU make implicit rules
>> +
>> +## This speeds things up since we don't need to look for and stat() a
>> +## "foo.c,v" every time a rule referring to "foo.c" is in play. See
>> +## "make -p -f/dev/null | grep ^%::'".
>                                   ^
> A bit late to the party, but are you missing an opening single quote
> there?

Yes, that's a typo. Oops!
