Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A48EC48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 11:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24E861878
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 11:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhF0Lgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 07:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhF0Lgu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 07:36:50 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C60BC061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 04:34:26 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id t12so5799032ile.13
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UNw9nKdaYrWUALHmQuLg5tWglFofpvABWFsCwHvtXic=;
        b=RZDVSh/nvGdaArVo+PueVG0dWhLau65xsEmBr/5T8Pu32Fa+tegm3sxNWPNRooJ1ob
         TFVhyghgQQPiUHvrWyBpz9jQGQIN37EgDJYHYbe6NdFF4i1yQ26zJ40ufqVgF3vKJ8WP
         gR8gMH8nmfqyKnmRmIBQIjDSxKfJhpJfegdQOskEwAnLCkaWIgOebaTApkZUHMrGStpr
         m4QT1B6k/hAv4BXkqlZH3/4oKKxCThYODMkj/miwwYq9fzbRg6Mb4Hv8Ay7t0RKxuUPq
         M8EPVTSKYV0TGSyaX10J7/2ynA7g4LCAmuXE+zMcRGkaoiUoQ+s4vlRLw7PxAtkf1hkX
         fDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UNw9nKdaYrWUALHmQuLg5tWglFofpvABWFsCwHvtXic=;
        b=bdDnRjvlp3xWT9md1ZY93O+uTPHUBN31DnOMgog6YXfBhiLhcKxMyWiqaOsV0DAYf7
         15ClVVnUdQDimgVHbsMjPTHwyJ9/zfbXE8RYMJk4DYg9E7pikAxyZdMP2Rq8M3Jv49O9
         EaG08q4Dir6RCvb01KcIum0ZcAd68rXrot4yYcdknkiZ+JAP2vSG99KWCIoyZP+Z5apc
         pcwVI3ozWXtkzLhDASQdykHog4QfGgyynFT02s2uvNdI360Q9NybQQ/z5HION2rhjZy8
         oFo0md1Nwn9Ss9PXkeFGpJbwxlt7fPJcwqmpp59x81rPApSMXAgdRTlJuvp1BElZeytZ
         Py5g==
X-Gm-Message-State: AOAM530LTaR/e5TeiRTtQzgXZTFzaO6KdJOEtKuJbjW9A7MRhnLYhApN
        B3IBfaQnTpwv+w1gvRU34Hv2JfVCAhfayA2ASRY=
X-Google-Smtp-Source: ABdhPJzJdit7MxjGQeliOwWePHoo/uzE6Wn6wdWSFqVLB4e7By+XKa6xiITIjmAcNYcHMUlirxdWtBmKOlcwB1uBkFE=
X-Received: by 2002:a92:c8d2:: with SMTP id c18mr14059581ilq.301.1624793665718;
 Sun, 27 Jun 2021 04:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
 <pull.980.v5.git.1624636945.gitgitgadget@gmail.com> <370101ba65f0989487360366f8b83144a6641a04.1624636945.git.gitgitgadget@gmail.com>
 <CA+CkUQ9XR4TjEea0Z4pHBeOdQi7fuTLPtzi01JdTKSS38=4CMg@mail.gmail.com>
In-Reply-To: <CA+CkUQ9XR4TjEea0Z4pHBeOdQi7fuTLPtzi01JdTKSS38=4CMg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 27 Jun 2021 19:34:14 +0800
Message-ID: <CAOLTT8Qq4sgR9DnCk=+ovHUEqNeSkg-07fOpJQu5povaZFXgiA@mail.gmail.com>
Subject: Re: [PATCH v5 12/15] [GSOC] cat-file: reuse ref-filter logic
To:     Hariom verma <hariom18599@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8827=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=882:08=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jun 25, 2021 at 9:32 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> >  static void batch_object_write(const char *obj_name,
> >                                struct strbuf *scratch,
> >                                struct batch_options *opt,
> >                                struct expand_data *data)
> >  {
> > -       if (!data->skip_object_info &&
> > -           oid_object_info_extended(the_repository, &data->oid, &data-=
>info,
> > -                                    OBJECT_INFO_LOOKUP_REPLACE) < 0) {
> > -               printf("%s missing\n",
> > -                      obj_name ? obj_name : oid_to_hex(&data->oid));
> > -               fflush(stdout);
> > -               return;
> > -       }
> > +       int ret =3D 0;
>
> No need to initialize `ret` with 0. Later we are going to assign it
> with the return value of `format_ref_array_item()` anyway.
>

I agree. It is worth noting that there are similar `int ret =3D 0` in
ref-filter.c,
they should be changed too.

> > +       struct strbuf err =3D STRBUF_INIT;
> > +       struct ref_array_item item =3D { data->oid, data->rest };
> >
> >         strbuf_reset(scratch);
> > -       strbuf_expand(scratch, opt->format, expand_format, data);
> > -       strbuf_addch(scratch, '\n');
> > -       batch_write(opt, scratch->buf, scratch->len);
> >
> > -       if (opt->print_contents) {
> > -               print_object_or_die(opt, data);
> > -               batch_write(opt, "\n", 1);
> > +       ret =3D format_ref_array_item(&item, &opt->format, scratch, &er=
r);
>
> Here.
>
> --
> Hariom

--
ZheNing Hu
