Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F32C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 15:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B2F61221
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 15:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhGAPCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 11:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbhGAPCp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 11:02:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82A3C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 08:00:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f11so3835918plg.0
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qCnOZVeUsUf+8/mF4LMPqTeZqRQDSnh1VAWEMxxjCP8=;
        b=bITmkDo6en9oLocB+tRorkBY5Jv0OHM+K3RXD77hfdh0Kn4v/FKQRWltwoc4KRivV4
         YVKU24Vl+zg1A8aJYDex59f0ObwxTjw9du6L1Vy72RXheCD647JbTSGJot8L3RxgrGw9
         QQPdAEONjTfHHRdWNfAjBlKUofR7IpSlIi4/ViNTfmP3EbIUTniy2MstJdQtwhv7Upox
         tWCTd+R4GApk/cmDgujwY6OYiv0U828okog0QBUC3iMP5iLb1/U5mR+rzJmjkKq/VQ13
         0EzK1iUd3tzudN9zSFYgzgcdEwMf3N06GuI6Q3DAoc8OFVw9a8GQ9glBpiYiAv7q16FG
         wjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qCnOZVeUsUf+8/mF4LMPqTeZqRQDSnh1VAWEMxxjCP8=;
        b=CjROFom/fHhimF40XPbP77qhf9ejUDlAIOYOT0rC+1p1GCv8DJ3vJURfVxTXm5BTGP
         FuMqmUYomJivpDTISZCbyBytEwOEdkGlNZ/cw8cIl9n+qllCzruIFQFEkvCTGUqPyfLk
         cizTDkE88p8T8Ctk1LIai53iOSEme/MQ/ftaTCjRb7sDZ4vdz0WotVr06TLorQDZQvoQ
         JlJ//XLFKr5guciFyQaduQGnSvNAFq4ceAmX/wwBbzOh1PVr3qzqU77YpbxXyLYokQVD
         Ird1SqOwXUiFml+6s/rvrDkTvV6xnuF6q8OqF7SE3eZZhtakF2I3BBNP4otQVuzRBsv5
         qnrg==
X-Gm-Message-State: AOAM531bhiM8qKs/YyhXRPqaFygjWLFhmKYLqzHh0JGegbue/SIRlk4X
        e9m9IuWwUUSpPpLMYpqhL49rA04ce6OztUBmcBA=
X-Google-Smtp-Source: ABdhPJwB/5rFNeDZmBnISO7h0j0/1MkV7B2CdCU5aOjO6EAPohvjIODYnChUugb5HiiYzpkdZNQvOQhx1K6zivHIlLA=
X-Received: by 2002:a17:903:208a:b029:125:8b69:53a1 with SMTP id
 d10-20020a170903208ab02901258b6953a1mr98600plc.17.1625151614372; Thu, 01 Jul
 2021 08:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com> <patch-1.5-9a92e7c216f-20210701T104855Z-avarab@gmail.com>
In-Reply-To: <patch-1.5-9a92e7c216f-20210701T104855Z-avarab@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 1 Jul 2021 17:00:02 +0200
Message-ID: <CAN0heSpsg=bwX9gbYfeWYqUbuen-zArR69FWxNmdtcQW_RubzA@mail.gmail.com>
Subject: Re: [PATCH 1/5] *.h: move some *_INIT to designated initializers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 1 Jul 2021 at 12:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
>
> Move *_INIT macros I'll use in a subsequent commits to designated
> initializers. This isn't required for those follow-up changes, but
> since I'm changing things in this are let's use the modern pattern
> over the old one while we're at it.

s/are/area/, maybe even s/area/area,/ on top.

> -#define CREDENTIAL_INIT { STRING_LIST_INIT_DUP }
> +#define CREDENTIAL_INIT { \
> +       .helpers =3D STRING_LIST_INIT_DUP, \
> +}

I've verified that all of these designated initializers assign the exact
same fields before and after this commit, e.g., `helpers` actually is
what comes first in the struct.

> -#define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
> -#define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
> +#define STRING_LIST_INIT_NODUP { 0 }
> +#define STRING_LIST_INIT_DUP   { .strdup_strings =3D 1 }

This "NODUP" one is a bit of an odd case though. You don't actually
change it to use designated initializers, as the patch says. Instead you
change it in a slightly different way. In a sense, you assign the
literal zero not to strdup_strings, but to the first field, which is a
pointer, where I would have expected NULL.

I think there's been some recent-ish "we can assign `{ 0 }` even if the
first field is a pointer, because it's idiomatic and works out fine"
even if assigning 0 to a pointer looks a bit odd. So it might not be
wrong as such, but it doesn't match what the commit message claims, and
I think it would be more clear to use `{ .strdup_strings =3D 0 }` here:
We're explicitly interested in *not* duplicating the strings. It's not
just some default "let's leave everything as zero/NULL".

Martin
