Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F10C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57CAC60E52
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbhHMI0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbhHMI0e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:26:34 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15642C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:26:08 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id y3so10001731ilm.6
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2GZNXK81MvsHAMLHIym4xxzZnhvrF55m51N0KGg61Rk=;
        b=kLkHnGm4QGvw0ybfsu/eH4GaOUY9/QM3H2eGUK0jLCB8gpQKcYb83i7QnZ5nIR2NM5
         6A44t/l+HsjPumvnyR6AxnqRHBaib3OigPS1UxOTrvGrLoVGmsAN1O3Ji+MlCRqQEufC
         p2xghBMNedZkcvt/Hqn4QJk8I0CKOBmNBei90UUzSOaQblm+Hd/f7DS+AALIphgMvrY8
         U42s9C0qZ1Ua6XDywPpTeKoFxcG2w+zzK8wkhIsqVrdAvasJQ/EnPJVfM2ogrj2wGXkP
         WGObuI0FgloP0wwuqGNnKSNQp0nGlhdMy1zGG7/unsR3jmMWOJKACktLgCmhaQzmAvlO
         mQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2GZNXK81MvsHAMLHIym4xxzZnhvrF55m51N0KGg61Rk=;
        b=MdBQaR7/7aEaQY0HVW2AF8RHqz7/n4xwo4udXYaCwQ4ApFiuppAM2pURER/Qn9snl5
         bK9qVHi2ioi2oFL3ZO7y0XGcTWsVuSRx81Hl17P/Wpuu/wO+ykzsOsQNqsAakPpSUk3X
         X8gBK/CeLLYl2QsPmhJXBFaHLUh22LTCsMbrOpNGFt7PsIoyGqD1l09Au7zOPRvAOg/W
         IboXDK9PWw7nNsJ6q62c4QUu26/DPYEbfkFJFVko36J9q4X30pCpO6CQXUtd38sWgF7R
         SEtsOIgFQHDcmEJQGhLFP3Dg8WnG5DK891uY/hKxJsrSFIpt09wHji1a+5alEjBlNGbT
         Z4aA==
X-Gm-Message-State: AOAM530rHW/pdgHY7DnV/WPA9VMl/f/7o4RdNvZlWBXGPW/bCFUoz7HB
        K5BZ9VVbe8ViJBdtSZrbO4qzBJUnlKhiFv/d094=
X-Google-Smtp-Source: ABdhPJwO+w6bT4Q0V0bcqFlky66bu39VSM9tJSVn0dkGgmf5xUbnM8PXcfpe44b0QaLgOUkrkuN0fqdV0ChAY20SnTg=
X-Received: by 2002:a92:440c:: with SMTP id r12mr975410ila.174.1628843167565;
 Fri, 13 Aug 2021 01:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TYiUbXbkSTPY50jCU1bYP3JFx2P+hVmGL58S8V=AUMbA@mail.gmail.com>
 <CAP8UFD2yG3cC3qM3Ty7prdpVd=gXvArjM1soXD7EUn_NFFODaw@mail.gmail.com>
 <CAOLTT8TQxz2xkQE7etDa3cgb-kRfho-WAyhfHTsK=FrYVsPN1A@mail.gmail.com>
 <CAOLTT8S0etdnFNKuD7z5QMxWdERZ-FWimn4Sc+u+7Ra1F2WAmA@mail.gmail.com> <CAP8UFD19PG7DnFzHF42PUDQ49pr8126ucYLVF6H4mAp61+Od2g@mail.gmail.com>
In-Reply-To: <CAP8UFD19PG7DnFzHF42PUDQ49pr8126ucYLVF6H4mAp61+Od2g@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 13 Aug 2021 16:25:56 +0800
Message-ID: <CAOLTT8QKapv6mFAr_AicDvivPPxZhan2hpbvQXvXMX6WeVMBpQ@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 12
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=
=8811=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:20=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Wed, Aug 11, 2021 at 5:47 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8810=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:20=E5=86=99=E9=81=93=EF=BC=
=9A
>
> > > I think find_subpos() called by grab_sub_body_contents() and find_who=
line()
> > > called by grab_person() are evidences that we are repeating iterative=
ly.
> > > But the proportion of time they occupy is too small. 0.0142% and 0.01=
09%
> > >
> >
> > Using such a method may reduce some unnecessary scans [1]
> > But it can do very little optimization... 1.6%.
> > On the other hand, our optimization should focus on the default format =
of
> > `git cat-file --batch`.
> >
> > My new idea is to need a fast path: when we use the default format,
> > let us directly execute get_object() to avoid unnecessary traversal
> > and checking.
>
> I think it should be done not only when we use the default format but
> when we use any format that only needs the metadata provided by
> get_object(). This way that wouldn't be a special case fast path, but
> rather a generally useful optimization.

Sorry, the reply is a bit late. These two days have been busy implementing
more valuable performance optimization patches. I finally did not implement
the above plan. At present, ref-filter does have some small areas worth
optimizing. A large part of the remaining performance loss comes from
more allocated memory and more copying. We must bear a certain gap
in performance. But we can minimize it as much as possible. This is perhaps
the most reasonable at present.

Let=E2=80=99s forget about the previous commit-slab for now and take a look=
 at my
new optimization these two days:
https://lore.kernel.org/git/pull.1016.git.1628842990.gitgitgadget@gmail.com=
/

Thanks.
--
ZheNing Hu
