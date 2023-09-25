Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD01CE7A91
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 00:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjIYAQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 20:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYAQG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 20:16:06 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB1EE8
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 17:15:59 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59f6e6b206fso13881927b3.3
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 17:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695600959; x=1696205759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eZSLbeY7oc8VYRyueKg4yhn5oepSlx8Ehb03RRRYrE=;
        b=Z909cnW4Ql2zSxvOu5K+HAyzioK9uK40ilue1V/3GYs0iUx7G+a+39x1Kbc79IK/I3
         8YNApfLA8rEsM1RKhQJAAihjVscwR/lcDPepWuFxTbjRM9wbGyCG9jFD4wswgKMpkBne
         80jhhmKFd1PdElnFEbf4qrT4zdh9qy1oynd1/b3oIufVzN4XmJONBzEPDdUpASyxYe1r
         UrZbtp9ME90XigJD2/4HynUm/FEtpCJBnv9w1d8liNzub4Yaa3RTGpz9V5PeRl90d18n
         iEof9yYQO06NrhYpcIUou1tJizDCtcNdq57cUDMrnEZsGb5s78h9Vk22vofmzbQsaB1x
         ir/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695600959; x=1696205759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eZSLbeY7oc8VYRyueKg4yhn5oepSlx8Ehb03RRRYrE=;
        b=VisHKJr0lXNT/orGMn1lv/9XpX5Xde+38TcB1hxj6Ib0s4vyQxHgCRQ3TjdtLNQwAC
         WkmtJQ73unCZiLydATfHPOwTB6hWNwT5GjluRwiU33KwMuNdnp/E2FVD+V4eK4Yshols
         F1hJz3I7FqxG0Gy11acRY1CITFkzkc7Uao0EtXVDIKGKb4yXVMlZGrN4z9qU3j/Ut7Ka
         h/w70Ga41wUjlaU064TZNAZwyp1mgWgIG6GZfSKdB6/Uxf2pKpGJVhf9+Mbi9vWaF0OY
         9Bz4fwKwWi3wco7i9ZspZR0fDKshiynklb3n7f0qqftT1vRtPxfv5qbpw/bMnd7pVZ0a
         tGQQ==
X-Gm-Message-State: AOJu0YxfLXOVUjBRQGNcwbc6IbnK3GNSP7+x/Op7TN4UA1AhAGPNOvRa
        cQz5nUO5r6u/HewbTeAwLjbAlfgz5YAb2+F8J3I=
X-Google-Smtp-Source: AGHT+IGdy7uTm1e2b7ssMCmMR3flTqO/Qy2wVM16yep/lR49pmQ8TtYz933SyOUw5/9xF5fxE+o/49ImhCBR6JhOH5s=
X-Received: by 2002:a0d:e6cf:0:b0:561:206a:ee52 with SMTP id
 p198-20020a0de6cf000000b00561206aee52mr6451109ywe.24.1695600958708; Sun, 24
 Sep 2023 17:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy1h2f5dv.fsf@gitster.g> <20230923152201.14741-4-worldhello.net@gmail.com>
 <CAPig+cTRByz10ySknTxPB2yVJf5Snz29LNRq5MtPk2MF3nMziQ@mail.gmail.com>
 <CANYiYbFkG+CvrNFBkdNewZs7ADROVsjd051SDQsU0zVq8eBhew@mail.gmail.com> <007601d9ef43$00731690$015943b0$@nexbridge.com>
In-Reply-To: <007601d9ef43$00731690$015943b0$@nexbridge.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 25 Sep 2023 08:15:47 +0800
Message-ID: <CANYiYbGf4U2_UG674GqfauNPg+TgOtzRT=xCJ=x0gHM+TcrNpQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] archive: support remote archive from stateless transport
To:     rsbecker@nexbridge.com
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023 at 7:58=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
>
> On Sunday, September 24, 2023 7:40 PM, Jiang Xin wrote:
> >On Sun, Sep 24, 2023 at 2:52=E2=80=AFPM Eric Sunshine <sunshine@sunshine=
co.com>
> >wrote:
> >>
> >> On Sat, Sep 23, 2023 at 11:22=E2=80=AFAM Jiang Xin <worldhello.net@gma=
il.com> wrote:
> >> > Even though we can establish a stateless connection, we still cannot
> >> > archive the remote repository using a stateless HTTP protocol. Try
> >> > the following steps to make it work.
> >> > [...]
> >> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >> > ---
> >> > diff --git a/http-backend.c b/http-backend.c @@ -639,10 +640,19 @@
> >> > static void check_content_type(struct strbuf *hdr, const char *accep=
ted_type)
> >> > -       const char *argv[] =3D {NULL, "--stateless-rpc", ".", NULL};
> >> > +       const char *argv[4];
> >> >
> >> > +       if (!strcmp(service_name, "git-upload-archive")) {
> >> > +               argv[1] =3D ".";
> >> > +               argv[2] =3D NULL;
> >> > +       } else {
> >> > +               argv[1] =3D "--stateless-rpc";
> >> > +               argv[2] =3D ".";
> >> > +               argv[3] =3D NULL;
> >> > +       }
> >>
> >> It may not be worth a reroll, but since you're touching this code
> >> anyhow, these days we'd use `strvec` for this:
> >>
> >>     struct strvec argv =3D STRVEC_INIT;
> >>     if (strcmp(service_name, "git-upload-archive"))
> >>         strvec_push(&argv, "--stateless-rpc");
> >>     strvec_push(&argv, ".");
> >
> >Good suggestion, I'll queue this up as part of next reroll.
>
> Which test covers this change?

See: https://lore.kernel.org/git/20230923152201.14741-4-worldhello.net@gmai=
l.com/#Z31t:t5003-archive-zip.sh

> Thanks,
> Randall
>
