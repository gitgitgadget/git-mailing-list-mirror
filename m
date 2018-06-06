Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13F3E1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 12:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeFFMFB (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 08:05:01 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36979 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeFFMFA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 08:05:00 -0400
Received: by mail-it0-f67.google.com with SMTP id l6-v6so7595104iti.2
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/kzdiFaCMtapSbqgk2/kZpecnmu3LfXs2cz+ka0+200=;
        b=lE/ZDBHpkoCvZTMI+pkdEBAYAra6f7ku6ig5Ce/RwursJooo1/lzDYUtkJqCd2ojFP
         7B8+8ZFXUdMOK6XK24RX+lxgPhcHoNDFGncGnlRKx0DELBYIfC4Xe8Ek1k2LUz4F14oC
         M0Bh46qwzmTCGUtu7uqa/mX0EGd9Obn3N5LWCpYWz4RvYhsG/HjNQLgyOoCgURk6ca/K
         VU/WHYvf0bu/MHXIMt2M2OGBA9D/ERPjvRm9Yd0i9sdyhBfwxp0AoO+F/CBLr6EoG6PU
         LDQHpWQYrTJS5jJwF2dgPHN8I0yXtTE8YHdVHbcUxkYozeamP+6BOqIxFiODYsOPQmlU
         7lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/kzdiFaCMtapSbqgk2/kZpecnmu3LfXs2cz+ka0+200=;
        b=Kyke536IKNPWyo2eKNga9sqPTJ4d9KjlikzowsSB3i3YNZKICtdvP40Ts+d1bT2j1S
         dVpKn1mtXFSfvoeQVO5166gItdYgWPSq6ZMabdrXwb3QrPV5+1WVn0tYm6D6Vhb17gtD
         eABaxD+uCL3A2dB7HhCTcWScAkgTIOw0r24puPjKX2sYGlblbbxLtqizwnDYqIiN5okr
         hsVl4M98ipjItAEZ9NlM7pSsOlCdmFzh6ujAf5xjQWCZPPy3KXkSBPo6WpM5D36ncI10
         Ed0iXAo119AfomR8jhpFPt0AoN7Te67qxEnaFT/UtLQFBBJF1oRHqig7iKLo2aD3o3m6
         GxKQ==
X-Gm-Message-State: APt69E2LGDWzVsIL2TPyh84pidXrRPhhBDJXzj8Y+yTMRroBgDUI9Mq1
        9xPYx1DkZBlTK6y/Dnr28H2zc9BL+wqGXSrPlzI=
X-Google-Smtp-Source: ADUXVKJj+IDldAbJpkVAFy1gKConPwcx5YLUoTs/LXTtHpikOGwKemcz9e3aV/8y/kn8dQmCVEqKTns+VGJwFLDXUdc=
X-Received: by 2002:a24:b21a:: with SMTP id u26-v6mr2174967ite.81.1528286699660;
 Wed, 06 Jun 2018 05:04:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22d0:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 05:04:59 -0700 (PDT)
In-Reply-To: <20180606102719.27145-3-avarab@gmail.com>
References: <87lgbsz61p.fsf@evledraar.gmail.com> <20180606102719.27145-1-avarab@gmail.com>
 <20180606102719.27145-3-avarab@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 6 Jun 2018 14:04:59 +0200
Message-ID: <CAP8UFD1VcQceStBFp9A_j5ts5W2GT12n=jE91osHvhYqKPGrHA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] sha1-name: add core.validateAbbrev & relative core.abbrev
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        dstolee@microsoft.com, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 12:27 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> +This setting changes that to `O(1)`, but with the trade-off that
> +depending on the value of `core.abbrev` way may be printing

s/way may be printing/we may be printing/

> +abbreviated hashes that collide. Too see how likely this is, try

s/Too see/To see/

> +running:

[...]

> +Even without `core.validateAbbrev=3Dfalse` the results abbreviation
> +already a bit of a probability game.

s/the results abbreviation already a bit of/the resulting abbreviation
is already a bit of/ maybe?

> diff --git a/sha1-name.c b/sha1-name.c
> index 60d9ef3c7e..aa7ccea14d 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -576,6 +576,7 @@ int find_unique_abbrev_r(char *hex, const struct obje=
ct_id *oid, int len)
>         struct disambiguate_state ds;
>         struct min_abbrev_data mad;
>         struct object_id oid_ret;
> +       int dar =3D default_abbrev_relative;
>         if (len < 0) {
>                 unsigned long count =3D approximate_object_count();
>                 /*
> @@ -602,6 +603,20 @@ int find_unique_abbrev_r(char *hex, const struct obj=
ect_id *oid, int len)
>         if (len =3D=3D GIT_SHA1_HEXSZ || !len)
>                 return GIT_SHA1_HEXSZ;
>
> +       if (dar) {
> +               if (len + dar < MINIMUM_ABBREV) {
> +                       len =3D MINIMUM_ABBREV;
> +                       dar =3D 0;
> +               }
> +
> +               if (validate_abbrev) {
> +                       len +=3D dar;
> +               } else {
> +                       hex[len + dar] =3D 0;
> +                       return len + dar;
> +               }

I wonder what happens if len + dar > GIT_SHA1_HEXSZ

> +       }
