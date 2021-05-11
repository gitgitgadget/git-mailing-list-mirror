Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF69C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 12:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FD161622
	for <git@archiver.kernel.org>; Tue, 11 May 2021 12:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhEKMTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 08:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhEKMTz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 08:19:55 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD4EC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 05:18:47 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id l21so17947031iob.1
        for <git@vger.kernel.org>; Tue, 11 May 2021 05:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fe8N6dhV24Cq4tRxZBQ+vufHdUDAsml0kl6ngXxZb6U=;
        b=XudvBY2uri+eOFsQaxAUKpuM7TnQoybQvHQcIe1Vq3NNekUO8tYZoIq2a+w/KlCEnj
         j7ZnmwpJC8n1QDTScEd1/SxcDA0lpsdOWVZJCTs/arl/eSnSBxcgEQeg2VpSUWpqxdUg
         TUMDBvbc9wEycGFfgEHN2s+HC+H5pm90vdsrTlh+47sKtISKMT7qOgJMXVFuNUSUUXdx
         yzdnT9T36KxORkAJl3jeX0qRFCLm5krqXQvD9JUZ1uYL7hTJfk+uL5WVoM/MVnumsLI6
         baE/SC3TLmErL9trYMR8sbHeA0n4oA1wDZHC5MDhXNc7SFibKa1xt+1ffpcAfy8MlFUo
         58xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fe8N6dhV24Cq4tRxZBQ+vufHdUDAsml0kl6ngXxZb6U=;
        b=IbyEJseEjhW0qCihKmwbdsyr5MLJWKVLNoOsQJqtyGr6E0ALyciBWyyS17FucV25go
         lFabbpIGNVWT9cIll/basQxJO/E32bjVR2n3tPP3AkGoPtOLP5JIuRhXDWqhgqLCTHry
         qjO1xSj4BR8lAWMVlVxg9F4dcobg5MvVb35BM7mjFZy+atqt7LES5Ub0cW0EItXTYMvM
         846w5diPB2LoxASMn5bARoVEasNYPdlB5c1Xr85nYTUpa+1mXVIcyoHeXN1Dhq38frUz
         9ZCyPCZiPndgBM+vYccDWLIYQro+YmZAp8QwC92W7mwOxVKi7uOo4dLCiQllnxI3JGty
         3KUA==
X-Gm-Message-State: AOAM533y8e0Pnz1kyKHD3YRH6jytPI6NIFrZ78efohQeltU4lrLuljjZ
        yl0Ea4kLL+dUWXfynSy3kphFrH2Wst0y0s/7CfoDdTybxzpR0scd
X-Google-Smtp-Source: ABdhPJztbUkjzjJCsDLSGtHxh7oJN1JoLINYjf/VGRg1ZUYli5RMZKHRoOwftQ4LUfLlX0eXdY96ED/AkdDOzqPnwaA=
X-Received: by 2002:a6b:d213:: with SMTP id q19mr21537679iob.203.1620735526946;
 Tue, 11 May 2021 05:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
 <pull.951.v2.git.1620659000.gitgitgadget@gmail.com> <a1f70b39b7efbadff9e2202968dd1ca65ea3c1b4.1620659000.git.gitgitgadget@gmail.com>
 <xmqqh7jaow31.fsf@gitster.g>
In-Reply-To: <xmqqh7jaow31.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 11 May 2021 20:18:24 +0800
Message-ID: <CAOLTT8Sd=zxCDPjHQm3M_xsHafG2pkFbNgdibpzBJuTzAu8ECQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: introduce enum atom_type
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> And I'd assume I am right in the following.
>
> > + * ATOM_INVALID equals to the size of valid_atom array, which could he=
lp us
> > + * iterate over valid_atom array like this:
> > + *
> > + *   for (i =3D ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++) {
>
> I find it far more intuitive to say
>
>         for (i =3D 0; i < ATOM_INVALID; i++)
>
> than having to say UNKNOWN+1.
>
> In any case, the values should be indented, and a comment should
> ensure that the final one stays at the end, perhaps like this.
>
>         enum atom_type {
>                 ATOM_INVALID =3D -2,
>                 ATOM_UNKNOWN =3D -1,
>                 ATOM_REFNAME,
>                 ...
>                 ATOM_ELSE,
>                 ATOM_MAX /* MUST BE AT THE END */
>         }
>
> (note that the trailing comma is deliberately omitted).
>
> It would allow people to say
>
>         for (i =3D 0; i < ATOM_MAX; i++)
>
> instead, which would be even nicer.

I think ATOM_INVALID and ATOM_MAX all will have a
similar effort. Why don't we omit one of them?

For the time being, all the used_atom entry create in
`parse_ref_filter_atom()`, we directly use
`used_atom[at].atom_type =3D i;` after realloc the used_atom.
There is no time for "ATOM_UNKNOWN" at all.

I don=E2=80=99t know if it makes a lot of sense use "ATOM_UNKNOWN"
at the moment.

--
ZheNing Hu
