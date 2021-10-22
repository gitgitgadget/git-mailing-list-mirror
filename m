Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BD0C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95FDE60FBF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 17:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhJVRWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 13:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhJVRWe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 13:22:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F264C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 10:20:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ec8so4313410edb.6
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ak8jbSqdkMC6nUYTl2ABDbKfQLuz23H+1KUBhsdbtzE=;
        b=l+Q7WB4YCvdybPRTt3cv5EYmDKYUl8UAC7894Jnj+JRgQscUdMrjdipBpv9dS01Wfa
         xbQ5C8bqf3cD5OSMfJaNQyihnnXqIGDON4d2eGXZOyVsvxYg2bQpMjRLXWq8ZgScZz21
         zL7ZrW2ptQ2oZc2qevk/dNdKzfqx7qjWn4By2LDGeTmjr7HCtp2HRQg3WTLypjmfXW9O
         9mdu555AH89XcBwVHGjos4hpkr6lQjARAzMFPl0/JeRk4diKOIZO/CZ4QDudPiWsO/zz
         2isj6T2o18UgsNJCLVkJTxoV87sePG+1taef6JXK7vGe+WCdubiVt7vicsA1ASqQcpU6
         gQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ak8jbSqdkMC6nUYTl2ABDbKfQLuz23H+1KUBhsdbtzE=;
        b=AYhxd8aGzObY3pCqOSEpHxMap7Y9TDOgcEM1dLAPXjpshhjVcF2mzydBI1SeWPxcaT
         9hShbDjUvduYhxMom5vkX+nPcOwRE733dsD0F//jBg2PRQGgwYfINfMTsslzULPPhU7d
         j447984D+MEt8n/0m4J/0UPm/asuKhBB2r9Gw8peSHsqJ2GoBTWkdGLDwBHBNvxN1i81
         u9Wm/MhWeMaMVdUQP4ecUFZDzpKyPfLNoUzuVVD6cWzqcEJ2umdlfa3xma7Yt4HKwUCK
         5YA1kjR9p9oJ1FqTGmzP0LG9qnTTHT7JGKALnYtkYFZO4oDaT7Udj74CaSXB1RYkr5FC
         VB/g==
X-Gm-Message-State: AOAM533shlo07vMvxYCB0gsRRarb07bneDCtrbMExi49qOyQwCKhkm8A
        xuP5QRjBoRsY9II61lZWdvU=
X-Google-Smtp-Source: ABdhPJwK470H3e9iORjAq2m3lcPjL/vDozUykoUfernWMDH92jPrwizxr1to3I47NB9baVlXDSeU8w==
X-Received: by 2002:a17:907:3e22:: with SMTP id hp34mr1005899ejc.464.1634923215009;
        Fri, 22 Oct 2021 10:20:15 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y6sm4891455edj.51.2021.10.22.10.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:20:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdyDF-001I37-3d;
        Fri, 22 Oct 2021 19:20:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 2/3] config.c: don't leak memory in
 handle_path_include()
Date:   Fri, 22 Oct 2021 19:19:26 +0200
References: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
 <patch-v2-2.3-d6d04da1d9d-20211021T195133Z-avarab@gmail.com>
 <xmqqmtn2gdlv.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqmtn2gdlv.fsf@gitster.g>
Message-ID: <211022.86ilxpj7si.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 21 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Fix a memory leak in the error() path in handle_path_include(), this
>> allows us to run t1305-config-include.sh under SANITIZE=3Dleak,
>> previously 4 tests there would fail. This fixes up a leak in
>> 9b25a0b52e0 (config: add include directive, 2012-02-06).
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  config.c                  | 7 +++++--
>>  t/t1305-config-include.sh | 1 +
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/config.c b/config.c
>> index 2dcbe901b6b..c5873f3a706 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -148,8 +148,10 @@ static int handle_path_include(const char *path, st=
ruct config_include_data *inc
>
> Not a problem introduced by this function, but if you look at this
> change with "git show -W", we'd notice that the function name on the
> hunk header looks strange.  I think we should add a blank line
> before the beginning of the function.

I think this is a bug in -W, after all if without it we we show the
function context line, but with it we advance further, then that means
that -W didn't find the correct function boundary.
