Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8BE91F406
	for <e@80x24.org>; Sat, 12 May 2018 12:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbeELMNh (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 08:13:37 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:44325 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeELMNh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 08:13:37 -0400
Received: by mail-ot0-f170.google.com with SMTP id g7-v6so9272175otj.11
        for <git@vger.kernel.org>; Sat, 12 May 2018 05:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OtmJ3hlH6onzGm68cfey9I6UG9nHnZXgcwOj5aLEPns=;
        b=VSqSG/BGs63UFZo3OgIQzXSX4cKRzKBriGqryvdejmuU1vLZK1KaSa9GbxXVzj7Sfo
         ctBtHr4y6PSrXx87y+0vnQ0zof139hliB57LPUL1/E1RAwSzXaci/YIr7amhPBshk67Z
         RREO5kOT5+8kqQBaVgT4xNaEphFohg5PWuvy7kLExdhGGcvQzJTC370iEr+R1fuc+pCU
         DmGAq8G8+7/4WHKxPCpqcHolEXbYj1w8XvDEzQa4siHTJL5CgBmzPnnWKUUlbfNDEhYL
         CxfiD6hLjqII3lStCoUxI9uWcrtGqX30wW+ZtW9cwINKCAOGi24WwOSNKq17wYpIcTr/
         P3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OtmJ3hlH6onzGm68cfey9I6UG9nHnZXgcwOj5aLEPns=;
        b=mSL6cLZUDzOMNYL+NhrF2gnHL+9dZdrKeYYqYHzZzUJrHotphvDliy3PxJTFLznPXh
         SB6GQDpdF23W3swPEAN6o43XrlaO8kuGbVwIE+U4l4Ew+p9WGgEIdFqKadFeEg4LFA1M
         gwNpidEra1oHshnSkSjhqkegX3NWiCppiq+3QlKGRuBCj2K1pR7Gd8fkgeZSBfwDsGto
         5fyo0yB2AcMgaKBHM9VmqMroywJ8jzkr0CqqRrS8AIMstfB+i12wTW7naUO8fllqml08
         XT5l1UrEj9zFrS3nYs/B0crDGzHXSwDd+RpbOGnphMQ3DppNwhMo8GAkMYkDjhtPwKsV
         j2jA==
X-Gm-Message-State: ALKqPwc0SM++dk0gMIpJHKNz7AKMR722vua3jWQGuOJOpGkQdcGgMG0d
        sxvO6WIkgiG72NPhO7vFF55Vto2/iWLEM8Q2pNQ=
X-Google-Smtp-Source: AB8JxZoEesGfAVUQXViGgyAoGI1PW258tw7rGI0vpOrQLzb/FGPcZ3pRqhrClDrELecHWCQGYtFdHqkD82bFY6PYtLI=
X-Received: by 2002:a9d:2fa6:: with SMTP id r35-v6mr1508879otb.356.1526127216680;
 Sat, 12 May 2018 05:13:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sat, 12 May 2018 05:13:06 -0700 (PDT)
In-Reply-To: <20180512092241.GD28279@sigill.intra.peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com> <20180512080028.29611-2-pclouds@gmail.com>
 <20180512092241.GD28279@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 12 May 2018 14:13:06 +0200
Message-ID: <CACsJy8BaeiH1xcB94sPX511Gc+FrWW==XRuModE3Csz9J_i2Kw@mail.gmail.com>
Subject: Re: [PATCH 01/12] blame: use commit-slab for blame suspects instead
 of commit->util
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 11:22 AM, Jeff King <peff@peff.net> wrote:
> On Sat, May 12, 2018 at 10:00:17AM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> +define_commit_slab(blame_suspects, struct blame_origin *);
>> +static struct blame_suspects blame_suspects;
>> +
>> +struct blame_origin *get_blame_suspects(struct commit *commit)
>> +{
>> +     struct blame_origin **result;
>> +
>> +     result =3D blame_suspects_peek(&blame_suspects, commit);
>> +
>> +     return result ? *result : NULL;
>> +}
>
> Hmm. You need this helper because you want to be able to peek and get a
> NULL. But that's already what _at() would return, with the only
> difference that we may extend the slab just to return NULL.
>
> I wonder how much it matters in practice. We'd generally be extending
> the slab to hit every commit anyway in this case, I would think.

I don't know much about blame so I stay very conservative ;-) If it's
safe to just do _at() here, I'll update this patch.

> I suppose it doesn't actually simplify the code that much to do it that
> way, though. We could get rid of this helper, but the caller would still
> look like:
>
>   for (p =3D *blame_suspects_at(o->commit); p; p =3D p->next)
>
> which is actually slightly uglier than get_blame_suspects(), because we
> have to do the pointer-dereference ourselves.

And the caller would need to include commit-slab.h too. I added
get_blame_suspects() because I wanted to avoid that.
--=20
Duy
