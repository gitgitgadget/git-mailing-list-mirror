Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AE5C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 21:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C1E22D71
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 21:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbhAEVQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 16:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbhAEVQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 16:16:28 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FDDC061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 13:15:47 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id k47so402591uad.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 13:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sF4UzLEsseXdNMFESpnjxh65t0kOPXUQbJ+oMWYCDDQ=;
        b=Z/izZgqVtZoYmOw81/kdp3geXRx8CiqDzHYWIgUpjr42EkOyOWjK1TCH2/9qciUwmp
         DOlWWoI306BIondmrwPXlk/gyiaFl9HJYsy18XbRxcvEZx+waKdSmhR9kCqH5RVa3w4S
         bOO1RvyXJchr5Cc7/iFzxj/dde1FpQhTg67EGwrOkHieNaqI5YBmemmrXd5J937HTfQN
         nD6pbaMX1B1Oy1WwIWq5TosKQsQFBIM2q+XmrLCOife+Mw5QEXOTu6B0uxcZjVruRx5U
         DwYkImbi5JavkdtkP65mmCTCt6D/SGGLrvd50XPCiQyr6x70iRwFdtwCszhAeHwV1qSy
         9U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sF4UzLEsseXdNMFESpnjxh65t0kOPXUQbJ+oMWYCDDQ=;
        b=exIIjwuFWV7ykFo4acu75zO1k0nQsYTG0PcDkKo/E0R7s2yxvH7GMIkKoxGaSlJrGq
         sMck3RcJwcyokJQM6brDGtJZAj1koVaJAcsNARJhDfzOooQByoFNsoM4jfsmyGDqA4wT
         HGt8FyxQr7Yg7gEC04bayXZD2QdcsP8bLD+gZiwxzExggTUx14UHzy6DOZv/q+vsYms0
         RBHVpunNkxwzwTWSznXaXZCnc+lc8Q9IdsSfFKAyT0A+fEGxSQbtxKFKx/HQDjfSr4Zk
         MTarWjwxhbbw7BZjRve3HCgJKytUl/AMPKWZQHhLV4GMPKst/iAhAUi3Q5WFMyQ1EbQM
         kj5g==
X-Gm-Message-State: AOAM533mtsgz9+ygenJwYYOqYtTea8+unlfLGUJMEhzyOAGMMJyarc/V
        cTyttadj1N7uFUSLxDBMu+thTeSktwv0cmF0phA=
X-Google-Smtp-Source: ABdhPJyd5ceC+EEZtnJyWKyZijfjCtC10alFBA9+Qj8uonzzDhfTyKDfu7rgmQc7ahy7jQWTnTyQ0CzlOb6y/ps83/w=
X-Received: by 2002:a9f:21f8:: with SMTP id 111mr1221392uac.115.1609881346836;
 Tue, 05 Jan 2021 13:15:46 -0800 (PST)
MIME-Version: 1.0
References: <7vejrs54kp.fsf@assigned-by-dhcp.cox.net> <20210105130359.21139-1-avarab@gmail.com>
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 5 Jan 2021 22:15:35 +0100
Message-ID: <CAN0heSoKYWXqskCR=GPreSHc6twCSo1345WTmiPdrR57XSShhA@mail.gmail.com>
Subject: Re: [PATCH] shortlog: remove unused(?) "repo-abbrev" feature
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Tue, 5 Jan 2021 at 14:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
>  {
>         char *name1 =3D NULL, *email1 =3D NULL, *name2 =3D NULL, *email2 =
=3D NULL;
> -       if (buffer[0] =3D=3D '#') {
> -               static const char abbrev[] =3D "# repo-abbrev:";
> -               int abblen =3D sizeof(abbrev) - 1;
> -               int len =3D strlen(buffer);
>
> -               if (!repo_abbrev)
> -                       return;
> -
> -               if (len && buffer[len - 1] =3D=3D '\n')
> -                       buffer[--len] =3D 0;
> -               if (!strncmp(buffer, abbrev, abblen)) {
> -                       char *cp;
> -
> -                       free(*repo_abbrev);
> -
> -                       for (cp =3D buffer + abblen; isspace(*cp); cp++)
> -                               ; /* nothing */
> -                       *repo_abbrev =3D xstrdup(cp);
> -               }
> -               return;
> -       }
>         if ((name2 =3D parse_name_and_email(buffer, &name1, &email1, 0)) =
!=3D NULL)
>                 parse_name_and_email(name2, &name2, &email2, 1);

I think this is a tiny bit too aggressive -- it stops recognizing and
skipping comments. For example, this whitespace-damaged diff:

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 586c3a86b1..4d461ad343 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -373,6 +373,7 @@ test_expect_success 'Shortlog output (complex mapping)'=
 '
        echo "Committed <$GIT_COMMITTER_EMAIL>" > internal_mailmap/.mailmap=
 &&
        echo "<cto@company.xx>
<cto@coompany.xx>" >> internal_mailmap/.mailmap &&
        echo "Some Dude <some@dude.xx>         nick1
<bugs@company.xx>" >> internal_mailmap/.mailmap &&
+       echo "# Comment <no@mail.xx>         nick1 <bugs@company.xx>"
>> internal_mailmap/.mailmap &&
        echo "Other Author <other@author.xx>   nick2
<bugs@company.xx>" >> internal_mailmap/.mailmap &&
        echo "Other Author <other@author.xx>
<nick2@company.xx>" >> internal_mailmap/.mailmap &&
        echo "Santa Claus <santa.claus@northpole.xx> <me@company.xx>"
>> internal_mailmap/.mailmap &&

... which passes before this, makes the test fail after this patch. It
seems our test coverage for comments is basically zero here. It might
make sense to first introduce some testing around comments (maybe not in
this "complex mapping" test, though) before doing this patch you're
posting here, but keeping something like

       if (buffer[0] =3D=3D '#')
               return;

Martin
