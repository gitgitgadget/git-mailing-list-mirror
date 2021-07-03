Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B359CC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 05:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859676127C
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 05:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhGCFwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 01:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhGCFwq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 01:52:46 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6C2C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 22:50:12 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b15so14258059iow.4
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 22:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zjf/jPkGdRaZt3IzRp9i7xMPbxcpnMq+Efq/oxvnQO0=;
        b=k5bURgyJUfzBJ/DPr68lFDUlTuRPYkUy0SLp2v/aMMd3ooVbnLiuhUXl0na3o62/dm
         aEaUs0sD1znwm3KNpKipbjllFYwHdbRFHIzx4G64psrcXquUAspQN3gy+Fxs51yk5Vby
         1XCv4AHvvOZ7srnKMkZ3ijqWqljJswH6YReIc+O7UrS0Y7bsBqHuuF4gVLosYnti2D0F
         pLmtNuRwUG9x9v/10tNw/51I8oRBfXfe5ldV2b4xy8yCUzpO3bCympDVoTUoz8Z0oC/i
         ZJYJAlNVXGX6Nw57cqHenvxJrc+XRZP2Ubnj63Nt4it3TEk+sjQZuPzYrFZ8oDaVwA4Z
         Ij6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zjf/jPkGdRaZt3IzRp9i7xMPbxcpnMq+Efq/oxvnQO0=;
        b=MX2Os8lWTMDLrdUEVzLKrCYge1Em5x5+06G3/3cKo2N+fL/gPGolZrgOy8wEnocaDL
         g3uLKQ7ZX1c4POht5TL91UN7P5KzoG6TXlZjB5odz0PxiBUIDpfv3Db7oTdyHN4nGCVJ
         aQlSxwLeWrX/sDpLNb4His/SMReREHLLisEbCVHM3yKmHgXauyHf3vrqQ7ceuqEcJMj0
         Z1UcIWNoZu3Zt/wfQlrh5/WentmLukamlmxI5nfMIQRU+ONLhFp4lxjq316u/gtYy7aJ
         yjk9VVQuz0cnr5qUJZhRP7Sirx8Hamw7c+9aA6huCf7uwFqC9vRGJH1E1+HiwR6OPF8W
         otKg==
X-Gm-Message-State: AOAM530Oio0b3kv1Arw3ZP3f2nyPEjNG8rMkUOTq6GaD4RYCHfVCfKVi
        f24psHjL7uNqRl4/X+DzYZ6Um0nxbKcedGPiSLA=
X-Google-Smtp-Source: ABdhPJwrCgVCAwck67WI/Ans5rvwEkRY07ytrkuKEeGRDT0J/8Kcc0DZrGG8phWopbQhgHD5PuSwm7rVBEFaIEzUZ5s=
X-Received: by 2002:a6b:f81a:: with SMTP id o26mr2954138ioh.68.1625291411316;
 Fri, 02 Jul 2021 22:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <18f38075b3c70748894ad6b2e1158f2b17460845.1625155693.git.gitgitgadget@gmail.com>
 <87a6n4alfk.fsf@evledraar.gmail.com>
In-Reply-To: <87a6n4alfk.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 3 Jul 2021 13:50:05 +0800
Message-ID: <CAOLTT8SD1eSNy1w8HBt0Z2BA=YqiUYrWsnAA9cDhBOdff=U=Yg@mail.gmail.com>
Subject: Re: [PATCH 10/15] [GSOC] cat-file: add has_object_file() check
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B47=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:34=E5=86=
=99=E9=81=93=EF=BC=9A
>
>
> On Thu, Jul 01 2021, ZheNing Hu via GitGitGadget wrote:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Use `has_object_file()` in `batch_one_object()` to check
> > whether the input object exists. This can help us reject
> > the missing oid when we let `cat-file --batch` use ref-filter
> > logic later.
> >
> > Mentored-by: Christian Couder <christian.couder@gmail.com>
> > Mentored-by: Hariom Verma <hariom18599@gmail.com>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >  builtin/cat-file.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 243fe6844bc..59a86412fd0 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -428,6 +428,13 @@ static void batch_one_object(const char *obj_name,
> >               return;
> >       }
> >
> > +     if (!has_object_file(&data->oid)) {
> > +             printf("%s missing\n",
> > +                    obj_name ? obj_name : oid_to_hex(&data->oid));
> > +             fflush(stdout);
> > +             return;
> > +     }
> > +
> >       batch_object_write(obj_name, scratch, opt, data);
> >  }
>
> In 12/15 the old "missing" is removed, so is this strictly redundant to
> what's in batch_object_write() for now, does it change anything?

Both of these commits are used to pass some tests for checking missing obje=
cts.

If we don't have this commit, "empty --batch-check notices missing
object" in "t/t1006-cat-file.sh"
will fail;
If we don't have the commit "[GSOC] ref-filter: modify the error
message and value in get_object",
"bogus OFS_DELTA in packfile" in "t/t5313-pack-bounds-checks.sh" will fail.

Thanks.
--
ZheNing Hu
