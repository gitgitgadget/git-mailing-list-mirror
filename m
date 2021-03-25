Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E164C433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 01:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2ED6023C
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 01:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhCYBo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 21:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbhCYBoK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 21:44:10 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640DEC06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 18:44:10 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w70so589809oie.0
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 18:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HhPS709AWplWudCMEEHyxOUYa7XwaPzwDD6vvNe5Z80=;
        b=DWpwDGEJ+WmQrSLxQkJVoNDyxDfc+tKuDdOaIxtEseXZ2P0CYIIiIeruxCtLJKg2OQ
         mTL7mYRXbCu09gIH0Ynry7SPH3zN5cTtVFde5Acac2ZqURffuuoBh9fu2aWrKRwWAnaR
         ImO0QevHLmQGljx21qqrbOOzYWFWKwwGgGFv7D+uGj+edSdCZW79esBsuOglkunyWcnT
         3j3rAxwpXP0hmhLK8uzMRnKA9lBQxrfhT0azfJsS0kHNx3gAdzKaQ/eMuC59j71/rBXR
         ST89ud50hnpktIbzDWomSC/O7QZtyfRl3gXEptJV6srtp0qRJXmKUy2v79Kg2S5CxYEw
         6VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HhPS709AWplWudCMEEHyxOUYa7XwaPzwDD6vvNe5Z80=;
        b=L+qMsEwjuP+YHVKesoUlJgZuTAu9o+IRVVD0EUQBIk7xRkp6CpMhEZbG8smCXWaD1U
         GRTnAZzO5Z4KXkeeleNadFNOobmcw4YP6/COlYV+oCRIgAw9VhqS+qVpwrkdWv3RsuSq
         pZaO+TCkaViZ9zVSVCFMY1M85mi71+UlWWwuVvP45nOox4Z0TsZfx9uUYYcnQScbUFXh
         7KIJ8nLjI1l2ayWCZU1fEDUAp3IgiVvatluGgXCqg76WaSy8VFYFPnRUHTqGs9dRlY14
         aDkPanFX4yxAZYDcfVWPy4KaOEvBdwP6+Mhl3CgNa7V22wPOge+Mz4r58OITNHTfURTj
         8Z6A==
X-Gm-Message-State: AOAM533sL8OaDQKv+ibRvXYVVijMdmUx3OrpZOg1Fxogj4fsKS7J8BGM
        oAq/qx++dzTEh+bfnWzZALTHDbf4a6+3FamkQfM=
X-Google-Smtp-Source: ABdhPJx+HMHqfo4t0ZZUQpGWMm2Q6RZb4EugtCkREFLZhkoYZ/2wNf8hPWui7S/uo+6l6EboKnp3NlBxy6jYHihFj3M=
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr4410757oia.44.1616636649853;
 Wed, 24 Mar 2021 18:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.git.1616511182942.gitgitgadget@gmail.com>
 <pull.913.v2.git.1616600555906.gitgitgadget@gmail.com> <xmqqft0kxq4m.fsf@gitster.g>
In-Reply-To: <xmqqft0kxq4m.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 25 Mar 2021 09:43:58 +0800
Message-ID: <CAOLTT8TeL3MofqoGUR2fXq+b+s8ZuxdjkdVnfiuG+vk2TUcwcg@mail.gmail.com>
Subject: Re: [PATCH v2] [GSOC]trailer: pass arg as positional parameter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:18=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > In the original implementation of `trailer.<token>.command`,
> > use `strbuf_replace` to replace $ARG in the <value> of the
> > trailer, but it have a problem: `strbuf_replace` replace the
> > $ARG in command only once, If the user's trailer command have
> > used more than one $ARG, error will occur.
> >
> > If directly modify the implementation of the original
> > `trailer.<token>.command`, The user=E2=80=99s previous `'$ARG'` in
> > trailer command will not be replaced. So now add new
> > config "trailer.<token>.cmd", pass trailer's value as
> > positional parameter 1 to the user's command, users can
> > use $1 as trailer's value, to implement original variable
> > replacement.
> >
> > Original `trailer.<token>.command` can still be used until git
> > completely abandoned it.
>
> Sorry, but that's quite an ungrammatical mess X-<.
>

Somewhat embarrassing. I have tried to fix it...

> >  1:  abc5b04d152f ! 1:  185356d6fc90 [GSOC]trailer: change $ARG to envi=
ronment variable
> >      @@ Metadata
> >       Author: ZheNing Hu <adlternative@gmail.com>
>
> As this is completely a different design and does not share anything
> with the earlier round, the range-diff is merely distracting and
> useless.
>

I thought the designs of the two were very similar.

> >  Documentation/git-interpret-trailers.txt |  7 +++++++
> >  t/t7513-interpret-trailers.sh            | 22 +++++++++++++++++++-
> >  trailer.c                                | 26 +++++++++++++++++-------
> >  3 files changed, 47 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/g=
it-interpret-trailers.txt
> > index 96ec6499f001..38656b1b3841 100644
> > --- a/Documentation/git-interpret-trailers.txt
> > +++ b/Documentation/git-interpret-trailers.txt
> > @@ -252,6 +252,13 @@ also be executed for each of these arguments. And =
the <value> part of
> >  these arguments, if any, will be used to replace the `$ARG` string in
> >  the command.
> >
> > +trailer.<token>.cmd::
> > +     Similar to 'trailer.<token>.command'. But the difference is that
> > +     `$1` is used in the command to replace the value of the trailer
> > +     instead of the original `$ARG`, which means that we can quote the
>
> "quote"?
>

parse.

> > +     trailer value multiple times in the command.
> > +     E.g. `trailer.sign.cmd=3D"test -n \"$1\" && echo \"$1\" || true "=
`
>
> This needs to explain what happens if the user gives both .cmd and
> .command to the same token.  Is it an error?  Is the newly invented
> .cmd takes precedence?  Something else?
>

For the time being, if I make "cmd" and "command" equivalent, it will
only trigger a warning.

> Whatever the answer is, the reasoning behind reaching the design
> must be explained and defended in the proposed log message.
>

OK.

>
> > diff --git a/trailer.c b/trailer.c
> > index be4e9726421c..80f47657ff1a 100644
> > --- a/trailer.c
> > +++ b/trailer.c
> > @@ -14,6 +14,7 @@ struct conf_info {
> >       char *name;
> >       char *key;
> >       char *command;
> > +     int is_new_cmd;
>
> Poor naming.  The .cmd thing may be "new" right now in your mind,
> but how would you transition out of it when design flaws are
> discovered in it and replace it with yet another mechanism?
>

I thought if the "command" will need to be replaced in later releases,
 "is_new_cmd" will be removed at the same time, now I think
 "is_new_cmd" may cause misunderstandings.

> Add a new "char *cmd" field, and at the using site, define the
> precedence between the two when both cmd and command members of the
> structure are populated, perhaps?

It sounds feasible, I will try.

Thanks.
