Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4515DC433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 08:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE2322D72
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 08:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgLEIu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 03:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLEIuB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 03:50:01 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A13C0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 00:49:14 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id jx16so12136925ejb.10
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 00:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=enAK9GHnbexDBuJd5MOI8wdXo4RK2sk3Bc8ZPWINNpg=;
        b=pOrMX7HfuFVDf2rmGSV3mLzdauvSM3hBKWLXqVNt2rVIDLtMjdKXnEExWVH0wYCBDB
         23Gk+swfEItpzPnoJOcGO6gMRyFvirj6NBFMb7sCMWTl90ocRYq08Y6TvEYtYlKF9iJ8
         xuCBshGso4zXm0zSfsswVPxGMtivdOs7wAnLgEfuQnZYo7ZC1gdjnfgGGru568qnSXzY
         r/HjoR+OU9kLI9wTFdrNcibevrUYsHFiYlhovU+cmXaWO3FXQ8ua7i4vFcLHy1ebFNxy
         Zj1LXtCmfrMTbnhuXHZYnCGEhfT0Au7f9OomVB4SVn9yBt51GGGaz6EB6dXOBwLXYE4o
         kR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=enAK9GHnbexDBuJd5MOI8wdXo4RK2sk3Bc8ZPWINNpg=;
        b=Odjie12XFUGJVBmOFN8tG6bnVr3iXcf+Ic4nkZM6huK9MrmlzObG5hUYRU2AcbEacr
         /jjYEY8zJG/ZpA9NTZFh3xZnSzkh/fGlpePJ0OxgfCyZZJzbmChnvh5H1l5nJub9+zY4
         tOEScE8wuba8/FhE8JJldYaIZ9VOJnurqFj4sxvxawdK2N0+G3ivqr837mNf03OrE3mY
         ERSJ2NQfpvRICCB1BZUtQaYgmo0Yig/QVHu+xZIl7i1v51dnK0DHbJVuEkEp/Wa0jsJW
         TSGpoZBhFbs1eUoiJ7aZDNyi1abZ0Q3f8XtyOJgSnK71pWIuwIh/14yngkMOqxSezvex
         NKDQ==
X-Gm-Message-State: AOAM5323vx5b9QMmU5HpZmfd87ShBQ042O1nuR2PQrWC0pwi1l9QoUBF
        UVuYFb4Y6iVwJ6EhgkYEsuk=
X-Google-Smtp-Source: ABdhPJxgGN8xsC7sDmp6yf+QAvyQn0HenXRBlGbCu/1LAfoxz9fM/pk1bavxtfrkaqgRAo2dasuqnQ==
X-Received: by 2002:a17:906:128d:: with SMTP id k13mr10605422ejb.309.1607158153173;
        Sat, 05 Dec 2020 00:49:13 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id f13sm4778266ejf.42.2020.12.05.00.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 00:49:12 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 5/5] pretty format %(trailers): add a "key_value_separator"
References: <20201025212652.3003036-1-anders@0x63.nu>
 <20201205013918.18981-6-avarab@gmail.com>
 <CAP8UFD1q7ab5wyhmxknoM8FC5y_QqrF34HCRiS3=MP8YLCx20A@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <CAP8UFD1q7ab5wyhmxknoM8FC5y_QqrF34HCRiS3=MP8YLCx20A@mail.gmail.com>
Date:   Sat, 05 Dec 2020 09:49:11 +0100
Message-ID: <87pn3oy6wo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 05 2020, Christian Couder wrote:

> On Sat, Dec 5, 2020 at 2:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> As noted in a previous commit which added "keyonly" it's needlessly
>
> Maybe add a comma after `"keyonly"` and s/"keyonly"/the "keyonly" option/

Thanks a lot for all the feedback. I'll work it into a v2 when I send
it.

I'll wait a bit to see if Anders W. pops up again and see if he'd like
to incorporate this into his series or submit his first/after etc.
