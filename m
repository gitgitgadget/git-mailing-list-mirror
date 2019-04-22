Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF831F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 12:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfDVMfI (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 08:35:08 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36576 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfDVMfH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 08:35:07 -0400
Received: by mail-it1-f193.google.com with SMTP id y10so17923385itc.1
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gCVsQvDiruF43P4k65fAlnNryd6v5Qx75mP7vDRmItU=;
        b=GOZRXSaNyGEN4A26EQNEadmeyorO4aSyk9gb+iftL7YE6fTxEO1AlWOHMWOWjU1cJN
         S+S+iVwZaI6iXBi7f06vl9bqoAn6dZ8o4R/kB+26I9BceD4DMz/qEUZL1/DWO5Fx2tr7
         dew2dgBZsBgAzZK57JIGGXh33dA06Wp/YqRMqde+ScOW3U/j8zl1fSO5hwDyW/XPMmBm
         mNkAYRYCX37AuoR5zkpZO+PjKqPnfrGwtUW8hqrHWJZQY0YnnkbDzwF6E9cu7z1z0nt3
         PPZeD0otxa1Yax4awGsm8l/WdKFH9gV4xTt/OZP0kZjmrFo+JmcS8D2jgJiHXIphEPjq
         J1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gCVsQvDiruF43P4k65fAlnNryd6v5Qx75mP7vDRmItU=;
        b=iR4upZ1rJD3BhEYlcYLSZ1PF4RpBv9T7mjIKFMGDbjXZxFtIHpAJQYxht460aVoYtB
         m4ONjngR9MoB0GT6sBf1CjUXebqNbAKWlekE6hVBFrN6F48v3broZAMNXm4BYn6ksV8/
         sB3R67e3hTu03tjf0b/ssPMlIWp19m98lfZvGpeF1SQbtkCGUPvlZC7t7/2Y64Qc11LT
         L3Aui0ZppW0TBXqCTPScx6PjsKOQ3JXmPE7jkuXtjMqTEFMteL/HgKimvb9JNQfcgptw
         ZfnWfklgFBfpdy61bJzXI+3g1aL9Yz1/us4I4rjvvTMNcrkFKHOgZOd9lc1zPdxusJzt
         xRUA==
X-Gm-Message-State: APjAAAXQtAx2elnVbJK+2uU9noaAY9rkFBknKNLxBFkNxdZb8Y6GpYPI
        ifwK4wQ8rv1A4ZDUihqNv43h3jYsNkhE47wAt4Q=
X-Google-Smtp-Source: APXvYqyGUS1IuevEMoxwvu74p01+lMc/5wUYotv0njeaH+ei5hccABK9MwoV6tfvl6hbD5e6OfyVP4dVS/ajOKLeMpo=
X-Received: by 2002:a24:4d8a:: with SMTP id l132mr13130133itb.70.1555936507123;
 Mon, 22 Apr 2019 05:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq1s1yfw24.fsf@gitster-ct.c.googlers.com> <20190422122250.15248-1-pclouds@gmail.com>
In-Reply-To: <20190422122250.15248-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Apr 2019 19:34:40 +0700
Message-ID: <CACsJy8ByLxUn8vgSmkPJQvO5vV-=vSwyP=ug3QKJL7hhD11-KA@mail.gmail.com>
Subject: Re: [PATCH] parse-options: don't emit "ambiguous option" for aliases
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 7:23 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
> @@ -574,6 +615,70 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
>         return PARSE_OPT_COMPLETE;
>  }
>
> +/*
> + * Scan and may produce a new option[] array, which should be used
> + * instead of the original 'options'.
> + *
> + * Right now this is only used to preprocess and substitue
> + * OPTION_ALIAS.
> + */
> +static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
> +                                        const struct option *options)
> +{
> +       struct option *newopt;
> +       int i, nr, alias;
> +       int nr_aliases =3D 0;
> +
> +       for (nr =3D 0; options[nr].type !=3D OPTION_END; nr++) {
> +               if (options[nr].type =3D=3D OPTION_ALIAS)
> +                       nr_aliases++;
> +       }
> +
> +       if (!nr_aliases)
> +               return NULL;
> +
> +       ALLOC_ARRAY(newopt, nr + 1);
> +       COPY_ARRAY(newopt, options, nr + 1);
> +
> +       /* each alias has two string pointers and NULL */
> +       CALLOC_ARRAY(ctx->alias_groups, 3 * (nr_aliases + 1));
> +
> +       for (alias =3D 0, i =3D 0; i < nr; i++) {
> +               const char *source;
> +               int j;
> +
> +               if (newopt[i].type !=3D OPTION_ALIAS)
> +                       continue;
> +
> +               if (!newopt[i].long_name)
> +                       BUG("An alias must have long option name");
> +
> +               source =3D newopt[i].value;
> +
> +               for (j =3D 0; j < nr; j++) {
> +                       const char *name =3D options[j].long_name;
> +
> +                       if (!name || strcmp(name, source))
> +                               continue;
> +
> +                       if (options[j].type =3D=3D OPTION_ALIAS)
> +                               BUG("No please. Nested aliases are not su=
pported.");
> +
> +                       memcpy(newopt + i, options + j, sizeof(*newopt));

Eck. I need to restore newopt[i].long_name and .short_name after this
memcpy, or we'll just have two --recurse-submodules instead. Luckily
it still works after this bug is gone.

> +                       break;
> +               }
--=20
Duy
