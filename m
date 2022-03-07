Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7574EC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbiCGMIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241987AbiCGMIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:08:39 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512AF13F3E
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:07:44 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bg10so31447993ejb.4
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Pu3O8st6QJR6QNQxMngW1jVzRJ9JS4pio3wcjoSFqVs=;
        b=VVBi6DRi6GH9Jztbmb1Y2D5yuJUB2I0L6aPyJsu4JH3i6l7iFJTR24q5GHCUqqP8lK
         2oK5PqYScGzCK9TKPxGzr5vFB6TUlFGLKn/N0DmOacgT/S194CzjXoojSSTP1K5JGW2C
         Yn9y3aCf2Ck7c+6QTIiEnE351qcYd5M1lr6QJ28wG9aESN6mLtihAzTGXmHA8wh2de9s
         QE6q02hrZaJ288RHgh7yXbV0/IUqbkd7x84a3+DZ7z8MoXNfxlT1d2pfupImvutrJ/OD
         Nt3vzGek6wXsCZc3JAQdL4hQPS+hDxLxa9BAisI/faU0iZdEASiaVOOlhumPao9BrwMg
         8ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Pu3O8st6QJR6QNQxMngW1jVzRJ9JS4pio3wcjoSFqVs=;
        b=dVCjzKRdg/ztMpxyT6Uc581JqbxYRXGNvC5MevhlW0BIS5B+7opXOAZ7tiMGVsrMAm
         n4FTin4oWbpJhNze0iG/zGpxtFj8UsZU9pma98adXqt4o9M1NspsY+OTC+FS5AVY4Gft
         YgywuBu1K8vOr4U8R2mVog+Kb1YDU4T7NrZzzLPLEgyNaOTvurMMrnYhfB/JDSXdoKhR
         lxOyV23SVIJWS+Ax3ntFTvAbQJBMbML+0NGz7Q1ttNCNZXpSdXvdBIVAy8FpU7w3NXib
         c7M2IrDI4irJ2TNbkbg3PqwY05Z3119kxClDKjiNnw93Xu3Itk2aasvxHpnLsbTsbiYw
         kiMA==
X-Gm-Message-State: AOAM530bYMlTdO1oxfihfqESafCijn54HWKi60UfjnwZjLfpGhhQFzxa
        S8nCm0aWYfJOXmqhtn5CoRs=
X-Google-Smtp-Source: ABdhPJzciqw5z2SIJFaMCaIoj+Dh2tyESWD+i+dwSyv2Mfg2U4IhqsAHwhatmUYnBoSsByhqZsDDig==
X-Received: by 2002:a17:907:6096:b0:6da:68d2:327f with SMTP id ht22-20020a170907609600b006da68d2327fmr8840392ejc.761.1646654862763;
        Mon, 07 Mar 2022 04:07:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7cf8a000000b004160af67840sm4320797edx.66.2022.03.07.04.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:07:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRC9N-001THm-Mt;
        Mon, 07 Mar 2022 13:07:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>, carenas@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] terminal: use flags for save_term()
Date:   Mon, 07 Mar 2022 13:06:54 +0100
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-2-phillip.wood123@gmail.com>
 <220305.867d984hsk.gmgdl@evledraar.gmail.com>
 <1351bb93-673e-817f-6911-d321217032ce@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <1351bb93-673e-817f-6911-d321217032ce@gmail.com>
Message-ID: <220307.86ee3e0xv6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 07 2022, Phillip Wood wrote:

> On 05/03/2022 14:02, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Mar 04 2022, Phillip Wood wrote:
>>=20
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> The next commit will add another flag in addition to the existing
>>> full_duplex so change the function signature to take an unsigned flags
>>> argument. Also alter the functions that call save_term() so that they
>>> can pass flags down to it.
>>>
>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> ---
>>>   compat/terminal.c | 41 +++++++++++++++++++++--------------------
>>>   compat/terminal.h |  5 ++++-
>>>   2 files changed, 25 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/compat/terminal.c b/compat/terminal.c
>>> index d882dfa06e..bad8e04cd8 100644
>>> --- a/compat/terminal.c
>>> +++ b/compat/terminal.c
>>> @@ -34,7 +34,7 @@ void restore_term(void)
>>>   	sigchain_pop_common();
>>>   }
>>>   -int save_term(int full_duplex)
>>> +int save_term(unsigned flags)
>> Doing e.g.  ...
>>=20
>>>   void restore_term(void)
>>> diff --git a/compat/terminal.h b/compat/terminal.h
>>> index 0fb9fa147c..f24b91390d 100644
>>> --- a/compat/terminal.h
>>> +++ b/compat/terminal.h
>>> @@ -1,14 +1,17 @@
>>>   #ifndef COMPAT_TERMINAL_H
>>>   #define COMPAT_TERMINAL_H
>>>   +/* Save input and output settings */
>>> +#define SAVE_TERM_DUPLEX (1u << 0)
>>=20=09
>> 	enum save_terminal_flags {
>> 		SAVE_TERMINAL_FLAGS =3D 1 << 0,
>> 	};
>>=20=09
>> Here would be better IMO. See 3f9ab7ccdea (parse-options.[ch]:
>> consistently use "enum parse_opt_flags", 2021-10-08) for how it makes
>> debugging better.
>
> I'd remembered Junio objecting to enums for bit flags in the
> discussion of that patch but looking at the whole thread it seems like
> the debugger support lead him to change his mind. I'll update.

Yeah, aside from that I think part of that was whether it was worth it
to refactor it for existing code, but since this is new code & we tend
to use that pattern liberally (which pre-dates any recent changes I did
by quite a bit...), ....
