Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC88C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 11:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447128AbiDVLqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 07:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447127AbiDVLqj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 07:46:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5FB54BEB
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 04:43:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bv19so15848968ejb.6
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 04:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yo8j6eJ/scH6PuwMNW9N6heEdiWyDBB1xuhNeGxj7Is=;
        b=crhColGw3YcL+GYDRCPfPM48C8rr3Jrd1+X20NclHTSJ5dapgH6yD2+8UscFswFQvv
         2c8oUO7bFcHVREkkNmNmIsKEYDTBR+U9buCEwgfHlZOWvwwkQ2kFm8Q3rMTcjB7KnSSV
         JkshzjpKrETS22q4sQmdPrIq42KY3DAddam6qxvh3b/bzNnMCnUHjJ/sMIBhGIrXrL9/
         4qQzrYxRaHsiD2dB5Zhq7MVQTc3Du0y2kw9HV00RbK2kRGZH4JsXd+Eu78RCETK2hTuH
         bCYddPDdqtpugmqJDGZMED1lRqXB1wxrJwYrhMhG4uxpM+o0mO7/PVjygC0mVVEAMU4h
         kTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yo8j6eJ/scH6PuwMNW9N6heEdiWyDBB1xuhNeGxj7Is=;
        b=oXPsGp8VsH9AdR5ehWY8nzp7q0Ve5J2u1k/4QVsyWsbScQoEbigJYTda26EYZHZAVd
         bOgbBMUSUjFmGcgyitPgdRJj5/Ede9u0kNbAwisaj7biTmuiEq/hju5i2SBrLNZk+3/B
         a3SP6NHN7Js8XFLmoThCEhOBRA015tPSatysDymkewkKI6Bky+R1afZVF6XuJGaxyTp1
         N556D0Ev/IAWIRSszgIwRCGRzqiYWqwYtNDvHm8Jzhvq5Yyv+SPp5RH3QhtSkTjjR6k1
         k1/+N/otLV/YBAqVOp6TR5K7yg4SOHqbgZ6HiwT1RQB2uvZgeu3z49Fsnn3jdne8WeQY
         p6fw==
X-Gm-Message-State: AOAM531wCQlwAz6EhfnbqGse6FCIE/SupxqQUKHUR2qUmSiRJ9BjMgi3
        aTntl0AIkA35Yn/t4gIczyBpHTyFapqcuw==
X-Google-Smtp-Source: ABdhPJzhCAQ9P6Biv8tCYmaogDQZgaQyTS9ppJ0pBEr5keD+hw+s4jh6Mu5j9Shy5HLyxubcey5pSQ==
X-Received: by 2002:a17:906:9746:b0:6e0:5c9a:1a20 with SMTP id o6-20020a170906974600b006e05c9a1a20mr3888878ejy.714.1650627824635;
        Fri, 22 Apr 2022 04:43:44 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id au9-20020a170907092900b006e8985cc68asm670781ejc.1.2022.04.22.04.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 04:43:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhrhP-008iLy-JF;
        Fri, 22 Apr 2022 13:43:43 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v3] CI: select CC based on CC_PACKAGE (again)
Date:   Fri, 22 Apr 2022 13:43:01 +0200
References: <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
 <patch-v3-1.1-8b3444ecc87-20220422T092015Z-avarab@gmail.com>
 <1654562506.42130.1650619559902@apps.talktalk.co.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <1654562506.42130.1650619559902@apps.talktalk.co.uk>
Message-ID: <220422.86r15p4a34.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 22 2022, Phillip Wood wrote:

> Hi =C3=86var
>
>> On 22 April 2022 at 10:20 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
>>=20
>>=20
>> Fix a regression in 707d2f2fe86 (CI: use "$runs_on_pool", not
>> "$jobname" to select packages & config, 2021-11-23).
>>=20
>> In that commit I changed CC=3Dgcc from CC=3Dgcc-9, but on OSX the "gcc" =
in
>> $PATH points to clang, we need to use gcc-9 instead. Likewise for the
>> linux-gcc job CC=3Dgcc-8 was changed to the implicit CC=3Dgcc, which wou=
ld
>> select GCC 9.4.0 instead of GCC 8.4.0.
>>=20
>> Furthermore in 25715419bf4 (CI: don't run "make test" twice in one
>> job, 2021-11-23) when the "linux-TEST-vars" job was split off from
>> "linux-gcc" the "cc_package: gcc-8" line was copied along with
>> it, so its "cc_package" line wasn't working as intended either.
>>=20
>> As a table, this is what's changed by this commit, i.e. it only
>> affects the linux-gcc, linux-TEST-vars and osx-gcc jobs:
>>=20
>> 	|-------------------+-----------+-------------------+-------+-------|
>> 	| jobname           | vector.cc | vector.cc_package | old   | new   |
>> 	|-------------------+-----------+-------------------+-------+-------|
>> 	| linux-clang       | clang     | -                 | clang | clang |
>> 	| linux-sha256      | clang     | -                 | clang | clang |
>> 	| linux-gcc         | gcc       | gcc-8             | gcc   | gcc-8 |
>> 	| osx-clang         | clang     | -                 | clang | clang |
>> 	| osx-gcc           | gcc       | gcc-9             | clang | gcc-9 |
>> 	| linux-gcc-default | gcc       | -                 | gcc   | gcc   |
>> 	| linux-TEST-vars   | gcc       | gcc-8             | gcc   | gcc-8 |
>> 	|-------------------+-----------+-------------------+-------+-------|
>
> Having this table is helpful. I do find it confusing that we're still set=
ting=20
> CC in the main.yaml and then overriding it in lib.sh. I think it would ma=
ke=20
> things clearer if we got find of the cc settings in the job matrix.

Yes, this stand-alone patch is just a band-aid.

Do you like the state at the tip of my larger CI series? It's only set
in ci/lib.sh there, or in the case of the package we need the
installation script is tasked with it now.
