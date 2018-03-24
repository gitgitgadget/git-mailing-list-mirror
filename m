Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920411F404
	for <e@80x24.org>; Sat, 24 Mar 2018 12:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeCXM0m (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 08:26:42 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:42133 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbeCXM0l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 08:26:41 -0400
Received: by mail-oi0-f54.google.com with SMTP id l190-v6so4257928oig.9
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 05:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JEbmSujG0fsrwXPiH2Z7c+TdEpYQ2gNbSdM8pa5kiso=;
        b=vFLjVk9LWSi0iDgPIWlq+aar7/hGoXn0Nt8Pa6MPDBZ9Rvo+Uk+VplmCEKdsM+SEqG
         PbaF+P5oYuakHNdnZ8aH3l6ns6AsbHkEn0DETst5AjrTvkp1bgP7NSFU6blTOAH+QK3G
         oGfymMVUtzbg8Vsu6qWEYZSZ/RllFbeCeEYtKpTTzEW1ZkptsCVH5KomfjdfmpxAZz7Y
         cbUIZk0RMpZs9795YtmGZagjwrZLcA8SGzDaTsvKsjY+jn9V3+qHoNJqefC/uqbhhbRJ
         xh6wb4OriPm0DaW1Soc2ywZ7DpBgnIAf7WF1nANi7n8xkoZQbNMm0MHXd+I3n0IOHtab
         kbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JEbmSujG0fsrwXPiH2Z7c+TdEpYQ2gNbSdM8pa5kiso=;
        b=RrzvRv6i07Dr74x/YHZCDXCGarj9BobGEpXdRK0G/TB4VXpDEZxqJDykO85m+0dRaY
         8N8XBYzJpUrfI/Nr2cSo6keVQkvLBveX9aafXhALaSVYLXP0JG1AgJX+81cBNqT+jKS0
         xrYdpba/YU9IBspANMj1lD7ajG8mPx8ZOoCE2mJlXqLvGhZ7RIB+EiXO6acvbpaMTUZy
         MuEC5e7mIzLChWEibnwfk15h2hwgphL/A6XCm3U63Pt9cH+5KdL0RR9/LjUex8ysH24F
         Na166qUwXUINWLeUfkHqZvf1IQQ/4uVbPAo1SGXDQfPCP1ziRR2P0GzoEwHvdA1uOKEL
         ncWA==
X-Gm-Message-State: AElRT7Ef11NDvPAS+B635IWp6nMryS+H9IZ6vmY05uekelhAJq6nyylJ
        +SBe5avBWXbroywZ+kHBvBmEvqhx7cIK05Yr14s=
X-Google-Smtp-Source: AG47ELtZGE1EjXvnepXhmRk7DLCe8YT9lC8twinSJzs4sBJe/VqInCDtjyssEyGDMAc5g7ErlthfU6Hks6wZZRmMcps=
X-Received: by 10.84.79.7 with SMTP id e7mr19238983oiy.281.1521894400681; Sat,
 24 Mar 2018 05:26:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sat, 24 Mar 2018 05:26:10 -0700 (PDT)
In-Reply-To: <87efk9yfm2.fsf@evledraar.gmail.com>
References: <20180318142526.9378-1-pclouds@gmail.com> <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-7-pclouds@gmail.com> <87efk9yfm2.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 24 Mar 2018 13:26:10 +0100
Message-ID: <CACsJy8B=TYTOu=4i0+0bqHRMDfJCQW5JA=3-g+v=D6pi2dbULw@mail.gmail.com>
Subject: Re: [PATCH v7 06/13] pack-objects: move in_pack out of struct object_entry
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 10:42 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Mar 24 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> +     if (pack->in_pack_by_idx) {
>> +             if (p->index <=3D 0)
>> +                     die("BUG: found_pack should be NULL "
>> +                                     "instead of having non-positive in=
dex");
>> +                     e->in_pack_idx =3D p->index;
>> +     } else
>
> The indentation after the die() here is wrong. GCC complaining about it:
>
>     ./pack-objects.h: In function =E2=80=98oe_set_in_pack=E2=80=99:
>     ./pack-objects.h:203:3: warning: this =E2=80=98if=E2=80=99 clause doe=
s not guard... [-Wmisleading-indentation]
>        if (p->index <=3D 0)
>        ^~
>     ./pack-objects.h:206:4: note: ...this statement, but the latter is mi=
sleadingly indented as if it were guarded by the =E2=80=98if=E2=80=99
>         e->in_pack_idx =3D p->index;
>         ^

Thanks. My gcc reported the same thing but only when not used with ccache, =
hm...
--=20
Duy
