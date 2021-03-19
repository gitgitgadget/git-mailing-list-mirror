Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD08C433E6
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 09:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ECF364F68
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 09:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhCSJeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 05:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhCSJdf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 05:33:35 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0A2C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 02:33:35 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id k25so4079093oic.4
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KWEveqDT2rbkuQyBg+g4QF/rAH1BgzMu4TZzGdlQiEU=;
        b=dUp/6egD4B1ZDQ4P6Jz/IWd/6n+fEbJDkdDoqgvESgSQV1xeeVzH0q4sODODzxMpZw
         oR7DqunlujwehhZX/RyTT63sx3bKks18BXZ1Xr6tfakXTvgsOqhRN+qSpQgHPpjrtEx7
         tQNSfFCVYnia0FVlnBw7GkW/Q62wcQlGcFGtEpp6mEpxXDFvMbZb2jXpjPkTzbCEJ4YR
         6jbsiApZh0EFCLprnMZ0sDN6YKoiGiAriAkecDQW/Zs0isz4fasQCjXJoz70919qabND
         BzBJLE8V6LLtjBh7kKckfQXfsZx2X/6V6ci34IUihJQsUBPbXWyHRl+2wKXVy+5d+/ut
         2+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KWEveqDT2rbkuQyBg+g4QF/rAH1BgzMu4TZzGdlQiEU=;
        b=sykPMBJc3oyvE5ILFLXYGxUQAIEuF14wlavCrcIPZyxgS2mothp5xRUARNzCuzMkq4
         LAd/7+AyoYDWMrb3izRYa2XDMhhtjBweTQf8gOs2EoqgZev1YBTCd5gY3Y1wdXzOWAR5
         vV3esCICqk/z5pVHvaHY1ifJjI4wrsBesZh8lucvN3WAAJGdKh9GQ/F1qvzbKSg8Z5bZ
         tGElDTaK02hst5UpWmAe+/YiHnOYsprEpVQ3mcX8FKvKkaJlxwucL9SF/mqI2T5WNVoz
         YMG2HqjBysQfBZ1Fsb1T/su9nGOysnNeXo35Z+YmF89AJuWWQCL4czN0HxOCRQCppPl2
         XHlQ==
X-Gm-Message-State: AOAM532rI0nkHLFu+iTK1/1en04J+WyPZUISF5xnd2gzLgttGs3NN6/m
        h79Wp7ZNu+dyy5PqZnAYjTt//3usZoBneJDrltk=
X-Google-Smtp-Source: ABdhPJxq3R7Ut7809nP5ustuSLpfzpF0jcxUEXwSTmFJTLHeqVKDsE7EeNm3bdtJUV577lCxXKYYZHDK2qlly69kfTE=
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr363741oia.44.1616146414929;
 Fri, 19 Mar 2021 02:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
 <pull.901.v10.git.1616066156.gitgitgadget@gmail.com> <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
 <xmqq1rcctgj7.fsf@gitster.g>
In-Reply-To: <xmqq1rcctgj7.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 19 Mar 2021 17:33:23 +0800
Message-ID: <CAOLTT8RzvQzD0baWPdJzRLK3Q+WeJR_HNA4RVHMxRmwHeym9QQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] interpret-trailers: add own-identity option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=883:20=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Beacuse `git commit --trailer=3D"Signed-off-by: \
> > $(git config user.name) <$(git config user.email)>"`
> > is difficult for users to add their own identities,
> > so teach interpret-trailers a new option `--own-identity`
> > which allow those trailers with no value add the user=E2=80=99s own
> > identity. This will help the use of `commit --trailer` as
> > easy as `--signoff`.
>
> I have a suspicion that this is too narrowly focused to be useful in
> practice, and I find that the proposed "--own-identity" is quite a
> mouthful.
>

Well, the original meaning of this `--trailer`and`--own-identity` option is=
 to
imitate the behavior of `--signoff` to create other trailers, For the
time being,
it can only "imitation", it does not yet support the ability to provide mul=
tiple
identities instead of "own-identity".

If `--own-identity` is mouthful, is there a better name?

> > +--own-identity::
> > +     Used with `--trailer`. Those trailers without value with the
> > +     `--own-identity` option all will add the user's own identity.
>
> So, the assumption here is that the name of the trailer tag alone,
> without the ':' separator, can identify which trailer the user is
> talking about, and it can be distinguished from the tag name plus ':'
> and nothing else which is calling for a trailer entry with an empty
> string as its value?
>

Yes. `--own-ident` is for trailers without a separator.

> OK.
>
> The reason why this looks too narrowly focused on oneself alone to
> be useful to me is because I often need to add various -by trailers
> to incoming patches, and have a script to do exactly that (which
> does not use interpret-trailers, as I do not think
> interpret-trailers can accept a patch email as its input, and the
> script predates interpret-trailers) but it will be useless if that
> script were limited to add -by for myself.
>

I understand it. But I think `--own-ident` is more inclined to add
identities for users. If users want to add other people=E2=80=99s identitie=
s,
they need to use another method.

> Wouldn't it be a lot more useful if
>
>         git commit --trailer=3D"Helped-by:@Ch.*Couder"
>
> is expanded (note: I am not married to the syntax, but only for
> illustration purposes, I am using "a value prefixed by @ triggers
> the 'name expansion'" convention in this example.  People can come
> up with better convention) by finding an author or a committer whose
> name matches the given pattern from "git log"?  Then, instead of
>
>         git commit --own-identity --trailer=3DSigned-off-by
>
> I can say
>
>         git commit --trailer=3DSigned-off-by:@gitster
>
> and I can even add more than one, e.g.
>
>         git commit --trailer=3DHelped-by:@peff --trailer=3DSigned-off-by:=
@gitster
>

I agree that this idea can be extended again from "own-identity "
mode to "multiple-identity mode",=E2=80=98@=E2=80=99 seems to have a lot of
 important meanings in git, but I don=E2=80=99t know how to design a soluti=
on
 that is more suitable than yours for the time being.

 Another doubt  is what happens if one person corresponds to
 multiple mailboxes or one mailbox corresponds to multiple people?

I think `--own-ident` may be a somewhat "narrow" option that can be
kept. Also add a new option for interpret-trailers to resolve the identity
of other people?

Thanks for suggestions.
