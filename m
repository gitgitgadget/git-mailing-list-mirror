Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8BE1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 04:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeBIEg4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 23:36:56 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:37499 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeBIEgz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 23:36:55 -0500
Received: by mail-qk0-f170.google.com with SMTP id c128so8548239qkb.4
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 20:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=8YTIlqNmR6vtJ5cOt7DiZGu+V8DoZ+ZRj4VBtPivvKw=;
        b=D6PxOrFRwaNeorO8qzVa72U/IE0wQGr51nbDyXbQ+JbuN0NSyB0aGEzIrewh0YWE4V
         JaHfjWk0B1oc01Lqo6HRguyURytga8EElIbYzDCdWQ5TPH7prlbjTiwTE7wE46Crwck7
         3Phcd7ADX+s/VtFhc6pMq2gLw/CjzwsdM6aM8kxqjbB1Ml1cPMS0fTajXPqmoJXT96Yz
         jxs+lVJK91KPbo+cNDEJzzJtsUqrjSZ8qwFhcOMeI5DVeS4qVuk6JOiYPORGy/CesO4n
         g1PIFbhpAioxeeizBqG0flvfTGh7pZRFFmjH6u0Fa5ZcRkrajaPbgbj/GnuVYxdxqeLV
         RQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=8YTIlqNmR6vtJ5cOt7DiZGu+V8DoZ+ZRj4VBtPivvKw=;
        b=gudypktptWgrcwy+ERsmRe7WWsyiiKkAgNlZ8CLispnet/WysKJ0l+DaNil0Z8GMvu
         ZOgqYdTvNBGOQDOcdsvzElk6jLGEu+SjMtqYdSy8hfF/sMiXrmyiV+5jJ2HCNxJ73mFC
         VPxFedwBbwJ3BaVkC4UIaEVr38ThzcvStmT4YeEtHW2hKN8m4RNzLCOhnCSrfMkMQzbZ
         jSBXuUsQSSse6VKpqH6mmaEhwuBdpXhmLr1CygSPqfPVZW311cGA4j5GAU1RNQvGaPQU
         72sCXLQYY+tjTLVTLYoaj3oP5ZWiJqhwygcCuZBrA6EtOJjtJ9ePIYAgZTX9z42IMuGo
         RDVw==
X-Gm-Message-State: APf1xPBxuixVE5cj4Es5bPPIgBjMxzGTVXgdfCwJFpo/FMH7pMhjDNoU
        DyGXOFtpHlZGEPZ96+37ix3vecHOa8CIX0vj7VQ=
X-Google-Smtp-Source: AH8x2244IBcvAMMSe92XFrSystZN5PS2yN5KxZw4ha+PUUKiAAiy2Z5uYSQy7KyApUTeOuvp7Xco2Tbjj21QY7HWd14=
X-Received: by 10.55.183.70 with SMTP id h67mr2026047qkf.331.1518151015066;
 Thu, 08 Feb 2018 20:36:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.133 with HTTP; Thu, 8 Feb 2018 20:36:54 -0800 (PST)
In-Reply-To: <20180208161936.8196-2-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com>
 <20180208161936.8196-2-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Feb 2018 23:36:54 -0500
X-Google-Sender-Auth: gqHkZsfsTR_o4AIoF-8GDvXnokk
Message-ID: <CAPig+cTwQj0UPvRy9xAF1kbyR8vx4WCsvb0KXsS5GQcDLiqcuQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] fetch: don't redundantly NULL something calloc()
 gave us
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Daniel Barkalow <barkalow@iabervon.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 11:19 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Stop redundantly NULL-ing the last element of the refs structure,
> which was retrieved via calloc(), and is thus guaranteed to be
> pre-NULL'd.
> [...]
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> @@ -1302,7 +1302,6 @@ static int fetch_one(struct remote *remote, int arg=
c, const char **argv)
>                         } else
>                                 refs[j++] =3D argv[i];
>                 }
> -               refs[j] =3D NULL;
>                 ref_nr =3D j;
>         }

This is purely subjective, and I neglected to mention it as early as
v1, but I find that this change hurts readability. Specifically, as
I'm scanning or reading code, explicit termination conditions, like
this NULL assignment, are things I'm expecting to see; they're part of
the idiom of the language. When they're missing, I have to stop, go
back, and study the code more carefully to see if the "missing bit" is
a bug or is intentional. And, it's easy to misread xcalloc() as
xmalloc(), meaning that it's likely that one studying the code would
conclude that the missing NULL assignment is a bug.

If anything, if this patch wants to eliminate redundancy, I'd expect
it to change xcalloc() to xmalloc() and keep the NULL assignment, thus
leaving the idiom intact.
