Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A30CC433ED
	for <git@archiver.kernel.org>; Sun,  9 May 2021 13:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671AB613C5
	for <git@archiver.kernel.org>; Sun,  9 May 2021 13:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhEINqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 09:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhEINqS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 09:46:18 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC8BC061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 06:45:14 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id c3so11813664ils.5
        for <git@vger.kernel.org>; Sun, 09 May 2021 06:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8z6hH4CMJIwMeLqc70Or/8g23kakDuABezHv1rgijrk=;
        b=pajlv7GhFjdS/TUEOx9GN6Pa/4f3H4q4atnSHMdans1GNCrT9fomwfaSYgcIeeYnNk
         inII40NKqPDhTw6HilpgJ1IV1qs1YdeEnaDBC9wpxc5bXNwb9nY0kg76wcXUv1q3xNzO
         J3K0zI3I+fugcu4GvYu9KbiPCtIgchLQdHQxCeJeA57oUaAiduUjxkO8sg5ghsh3JwdW
         uLqX22+ITqLPdpC8WwpuHF+S4CZIAJyzWog3vAPDWyYnUgR1j/6Guddth1Mf+XJK/E5R
         LfeRsRYZShsr/JB7ZdziZMpYf07DV9GQ+rRZybiUC5HC9HujIw5vu+e1orka9ZGemCCR
         y/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8z6hH4CMJIwMeLqc70Or/8g23kakDuABezHv1rgijrk=;
        b=Rdq2vDsZq7wes6nA4pkgoslFIGrUKq1VbiJbCHcVyKb1snVqmlj1g6AtZrZZqi2PV7
         tkpJyLOwsxriSADxGINdEiUPYp6w6BLeso2bv9mt/kNkTersUW7Q4vJoE3AT4MBW65UB
         bVJc3moXZ26cJxcYBxHtB+5rANttBKiVgshzVKfWAp7Cr4lnkiKW8Z40F5fCSgjbOPtv
         lAe+na2o9beQDeuUxRXN3SFS/yOBrRxQocX7VUk1AbnvTNcKoby4ebJIyLKrOufCkx+x
         GqSzTNimph7sO/cGX0UsLD/jtod7jf6E7gnAO60RAtYGTUmrZ4pTHl3XJRlW/oRv7AJK
         qQBw==
X-Gm-Message-State: AOAM533FjnVZYvvkQV/syvyIjsb3TxpEWjRPLroQ//IVZc4suqUbFN49
        MeQ3NaQLfjhc1lUCquopdc42g+gkf7nFSK6wSeM=
X-Google-Smtp-Source: ABdhPJygzc5ZQHx5yf0jDUQW//Vqye+SqyI/BWak7hftvjSKm+VIU7xSGhZuuwIcscT/2ScLVVZajVbfA/ETjXkhfis=
X-Received: by 2002:a92:c20e:: with SMTP id j14mr5255912ilo.259.1620567913915;
 Sun, 09 May 2021 06:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
 <3770df1829830229e768607b699730d2a7c21c5e.1620487353.git.gitgitgadget@gmail.com>
 <CAP8UFD0mOmqWUS49wywDVoWOyAkCRSUY5+i7Gqq-ZZSNCr-jvg@mail.gmail.com> <xmqqh7jctiru.fsf@gitster.g>
In-Reply-To: <xmqqh7jctiru.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 9 May 2021 21:44:58 +0800
Message-ID: <CAOLTT8Q3QLsD=yy8OBYcHh7FGhfmOebLVk71fidoih-X5HgNsQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC][RFC] ref-filter: introduce enum atom_type
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=889=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=884:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > I am not sure it's worth having an atom_type field for each valid_atom
> > element if the value of that field is already the index of the
> > element, because then one would always be able to replace
> > `valid_atom[i].atom_type` with just `i`. Or is it for some kind of
> > type safety issue?
>
> > I wonder if the enum should be instead defined like this:
> >
> > enum atom_type {
> > ATOM_UNKNOWN =3D 0,
> > ATOM_REFNAME,
> > ...
> > ATOM_ELSE,
> > ATOM_INVALID, /* should be last */
> > };
> >
> > As a struct containing an atom_type would typically be initialized
> > with 0 after being allocated, `ATOM_UNKNOWN =3D 0` could ensure that we
> > can easily distinguish such a struct where the atom_type is known from
> > such a struct where it is unknown yet.
> >
> > Having ATOM_INVALID as always the last enum value (even if some new
> > ones are added later) could help us iterate over the valid atoms using
> > something like:
> >
> > for (i =3D ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++)
> >         /* do something with valid_atom[i] */;
>
> OK.
>
> As to "safety", I think it still makes sense to declare "enum", but
> I agree that we do not necessarily have to have it in the valid_atom[]
> struct.  We could do something like this instead:
>
>     static struct {
>             const char *name;
>             info_source source;
>             cmp_type cmp_type;
>             int (*parser)(const struct ref_format *format, struct used_at=
om *atom,
>                           const char *arg, struct strbuf *err);
>     } valid_atom[] =3D {
>            [ATOM_REFNAME] =3D { "refname", SOURCE_NONE, FIELD_STR, refnam=
e_atom_parser },
>            [ATOM_OBJECTTYPE] =3D { "objecttype", SOURCE_OTHER, FIELD_STR,=
 objecttype...
>            [ATOM_OBJECTSIZE] =3D { "objectsize", SOURCE_OTHER, FIELD_ULON=
G, objectsi...
>            ...

Thank! Good suggection. We hope that the atom_type and
valid_atom items establish a clear connection. Maybe we
should add some comments before the definition of the
`enum atom_type` to remind the coder of the connection
between atom_type and valid_atom.

--
ZheNing Hu
