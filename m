Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF6262047F
	for <e@80x24.org>; Tue,  1 Aug 2017 18:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbdHASXZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 14:23:25 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35908 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdHASXY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 14:23:24 -0400
Received: by mail-lf0-f54.google.com with SMTP id o85so10498448lff.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=NwpMB1YJpwxsrzUQKzapUcxMIMdK07BkZUemxV4TMW4=;
        b=QGkRmXrKHpU7XvYcAEAhbrL6BayiA56eZmK34aGXy2NzOf0/OJC8KbQlVFQg9BISjn
         W5rMuGsLZuZwRgyooBQXZp1lWrqOoMRQKvcnRZ4uJMdBDcGET4XUJL47iNbtr7rC0FBE
         /AHNYqPatmo23SpI/5YSf+kvSkKRNCntrlQ2JGaHgsIcqwXFmm/de2PdCQvCIpZAmfgG
         dm8EZgnUPi4zAyKeolhstEuk0arstdl6hsqkd2laHe3/LrttnKWqiadNEt4fVRyBgFLR
         ErxXkf+F62tG0UCk1uueH2WyurEXauWGngrMx9AXnpJmhkENwm9NqFmeFDwrYPnsvj1w
         yOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=NwpMB1YJpwxsrzUQKzapUcxMIMdK07BkZUemxV4TMW4=;
        b=pybHTVGNS30PacP1FibNyc9giC0ZLJv2eRX6NkPPwX7DRU66z0zTeHC3VajHDr229N
         oKzj5lbI6yfIZbgTfX2CWmHC2AtveKmlh8hC9IyhX4U6NXKMUwKcSOJU7c+2M97jTrdY
         Es0vrKA4xmAh9BedetbbR4y4uKXwYU4nGyihvHO4WWTSQc65ysihqt+t6Dg7WU1qyK9c
         0xccEcTEvXmDRgleiDnh7t+aZ3JFrd8zeJtqfONShTAQUaUYyq2hZCdLC8Z4wVLCW33j
         46RWoJtr5i7wAT+Sqq7sYhg8olDrK4x11idRXrReLExjC/192uu4lKZomV1FGHN35R4L
         8Vvg==
X-Gm-Message-State: AIVw111Fu8in4YTEYOtKlJXYxibf9HhG0MKtkGMJcuFHqoBWJln8niPo
        9DkpXIblxiKDH4l3w5LJkrdrsDrphw==
X-Received: by 10.25.90.152 with SMTP id y24mr7922935lfk.182.1501611803359;
 Tue, 01 Aug 2017 11:23:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.0.131 with HTTP; Tue, 1 Aug 2017 11:23:22 -0700 (PDT)
In-Reply-To: <20160625075433.4608-6-pclouds@gmail.com>
References: <20160625075433.4608-1-pclouds@gmail.com> <20160625075433.4608-6-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 1 Aug 2017 14:23:22 -0400
X-Google-Sender-Auth: P_PJxyRhCWh2NRuNAZ0kJwXp8Rg
Message-ID: <CAPig+cTR0CODi_mgjYQtQJ7c_BMvMxKq0qqjFeo8D+k77=qXyA@mail.gmail.com>
Subject: Re: [PATCH 05/10] copy.c: convert copy_file() to copy_dir_recursively()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the (more than a year) late review. I realize that a
subsequent version of this patch series renders a few of the review
comments meaningless, but I'm including them in case the code is
revived later.

On Sat, Jun 25, 2016 at 3:54 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> This finally enables busybox's copy_file() code under a new name
> (because "copy_file" is already taken in Git code base). Because this
> comes from busybox, POSIXy (or even Linuxy) behavior is expected. More
> changes may be needed for Windows support.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/copy.c b/copy.c
> +/*
> + * Find out if the last character of a string matches the one given.
> + * Don't underrun the buffer if the string length is 0.
>   */
> +static inline char *last_char_is(const char *s, int c)

Is this function ever used in anything other than a boolean capacity?
If not, then perhaps a simpler signature would work?

    static inline int ends_with(const char *s, char c)

(and you could drop the ugly casting in the function body)

> +{
> +       if (s && *s) {
> +               size_t sz =3D strlen(s) - 1;
> +               s +=3D sz;
> +               if ( (unsigned char)*s =3D=3D c)

Style: if ((...

> +                       return (char*)s;
> +       }
> +       return NULL;
> +}
> +
> +static int do_unlink(const char *dest)
> +{
> +       int e =3D errno;
> +
> +       if (unlink(dest) < 0) {
> +               errno =3D e; /* do not use errno from unlink */

This comment is repeating the code itself but does not explain _why_.
More helpful might be a function-level comment explaining that
do_unlink() does not clobber errno.

> +               return error_errno(_("can't create '%s'"), dest);

However, it's not really clear what the intention is here. This is
emitting an error message only if unlink() failed, but the actual
error message is from some entirely unrelated operation. Confusing.

Also, is the idea that 'errno' should be restored no matter what happens?

> +       }
> +       return 0;
> +}
