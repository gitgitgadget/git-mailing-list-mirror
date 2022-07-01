Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC019C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 12:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiGAMmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 08:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiGAMmc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 08:42:32 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9853B544
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 05:42:30 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id n14so1311135ilt.10
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kL1cG4stiu4By5q+Znrgfbn3wgJ/MUW7ScDLHrhY4zg=;
        b=nbQPqcDSbzJ2+4oA49S6gOyuuBX/+3HhCFYuBII3oqx7uTSAhWQ3jxGeePeWBPPMml
         gA3zDJtEHjN7FVCXZMm2zeRiilLkOjwZIshb2l1eFEIKNFsGWtNYvrcR5JDTt+va54tX
         +dnyfabfFZrUQ4OcRIozia4T1PWuND9hRpsiutlOmG4cEZusGLrkXayFtWWwX2tD8rCO
         qM+ICRT7IYTfH7kizPyOhAKICgZfCiXSE+mArm3jJYKMDzx1XH/mkIKK/JiXgE9ZeJ8k
         CNnn/UuWlvvHIN2/VRh3n1k9FHBYi+FhCqZFidTz1W/fXgG/6wK9bSIs8khzYKggEt2L
         GvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kL1cG4stiu4By5q+Znrgfbn3wgJ/MUW7ScDLHrhY4zg=;
        b=kJjzWXL7OLRI9467gNDZXFMIYtTMdPPwyyoXGmjzIc6lr6n39ED95Sr7LRuobS4TiL
         YaHUGJhZL3Qkv+m5k3Mz/EqA+2LqJX5RjK4jjxmFyLnHkm+Wr8LvqB8tRbEqoUqEnB76
         FTRM+9OxFzr2Q/w4Z67Hrj3bBho5zd7ultTdBwkOzPp3011mF5DS2R3ZThIAxEIrATJ7
         sDa9Ya7JVoJ+SVk96X1Yei6bQPbGvMrqp+2xy+k6vIetVxYaWE+7o1J9fD4dJ8FmU7hQ
         UPXi81GhH5Rqi4oFLAjmSdfbh1M3q9PVG/qhbm0d1RKU8KOXa21VCK5scL4g51x/hpqZ
         r8cQ==
X-Gm-Message-State: AJIora/3F6gl+Dq4BEg82PzNP5XsdnZXydXbtsWQOnqOs5nSiEf6cZGg
        R520gnfEyW8CIHo4jMdPOO7cYv0Rs+JKIkEE7jcFQo0um7HK1w==
X-Google-Smtp-Source: AGRyM1vNFjnx97itCVSolAToZdckDdjAOVnnQli1JQjyvI1Ja0giUgE8LYM0EhccvmQkT9RyO0SwG0MgOQrI7tW+gIs=
X-Received: by 2002:a05:6e02:1bc3:b0:2da:da80:d344 with SMTP id
 x3-20020a056e021bc300b002dada80d344mr4179618ilv.254.1656679350147; Fri, 01
 Jul 2022 05:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
 <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com> <220627.86v8smgcx2.gmgdl@evledraar.gmail.com>
In-Reply-To: <220627.86v8smgcx2.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 1 Jul 2022 20:42:18 +0800
Message-ID: <CAOLTT8S7PA7Aerhcf=fqDwymmwgcys7+mRby2MkWDsbSyKTLLg@mail.gmail.com>
Subject: Re: [PATCH v4] ls-files: introduce "--format" option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=E5=
=B9=B46=E6=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C 02:48=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> On Sun, Jun 26 2022, ZheNing Hu via GitGitGadget wrote:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Add a new option --format that output index enties
> > informations with custom format, taking inspiration
> > from the option with the same name in the `git ls-tree`
> > command.
> >
> > --format cannot used with -s, -o, -k, --resolve-undo,
> > --deduplicate and --eol.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> > [...]
> > +test_expect_success 'git ls-files --format with --debug' '
> > +     git ls-files --debug >expect &&
> > +     git ls-files --format=3D"%(path)" --debug >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_done
>
> I'm not sure what to make of this.
>
> In some ways I think this makes more sense than what I suggested in
> https://lore.kernel.org/git/220624.86letmi383.gmgdl@evledraar.gmail.com/;
> but I had to think for a second about what's going on here.
>
> In my version I suggested having this work with --debug, but not in this
> way, in my version you'd always emit the debug output, and the format
> output.
>
> But here e.g.:
>
>     git ls-files -t --debug
>
> Will emit "H tag.c" or whatever, but if you add --format the -t option
> is silently discarded.
>
> So the test is relying on "%(path)" being the default format.
>
> I think extending this to e.g. test what happens with "-t" would be a
> good thing, but also in general does combining --format with -t make
> sense, and are there other such options where the combination might not
> make sense?
>

Why not we just let -t incompatible with --format? Is this because -t can a=
lso
be considered a =E2=80=9Cdebug=E2=80=9D message, and we often use --debug a=
nd -t together?

If so, we can just do something like:

@@ -238,6 +335,13 @@ static void show_ce(struct repository *repo,
struct dir_struct *dir,
                                  S_ISGITLINK(ce->ce_mode))) {
                tag =3D get_tag(ce, tag);

+               if (format) {
+                       fputs(tag, stdout);
+                       show_ce_fmt(repo, ce, format, fullname);
+                       print_debug(ce);
+                       return;
+               }
+


> So I'm not 100% sure, but I think I'd prefer my version, but I see how
> it would get hairy to support, e.g.:
>
>     git ls-files -s --debug --format=3D...
>
> Should work, but you'd have to special-case the logic for erroring if -s
> is combined with --format.
>

Agree. it's really weird.

> Anyway, I think it would be fine to leave this in whatever state is
> easy, the --debug option "just for debugging".
>
> But re
> https://lore.kernel.org/git/CAOLTT8Tc95-aUE+uN2d8QjTJpGpGw6cBJfG+bpmyE55O=
cXTSRA@mail.gmail.com/
> I think it might be interesting to get --format to a state where we can
> remove --debug entirely.
>
> I.e. in c2a29405105 (t1091/t3705: remove 'test-tool read-cache --table',
> 2021-12-22) we could replace some similar test-only code with "git
> ls-files". I for one wouldn't mind --debug going away entirely, and have
> the t3705-add-sparse-checkout.sh tests use --format instead.
>
> Or we could keep --debug, but just have it powerful enough to do what
> print_debug() is doing now, possibly without "truly internal" stuff like
> "ce_flags".

Ah, though we just remove these little "useless" atoms, maybe we can add
them back later? (not in this patch?)

ZheNing Hu
