Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39658C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 14:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DAF661919
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 14:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhCUON1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 10:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhCUONK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 10:13:10 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ECCC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 07:13:10 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so13305621ota.9
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H2SRDpFUAr1Doq5sf9QePhDoqlW4v5u2uETm1oNzI6E=;
        b=CwSSKheczjIyqE6MujaPzYEcoSJnaMX/L3yV/t3cTPkYrinxbmJNEWjvQRNKiOVQja
         TLquWqmodCM8AzKT0a6H7kbEMtfwM4ldAoY1KnHdRj5MfsPQHplR58qA+pIjIUQlMJLH
         1bf4YOkTHM1F3BVId51m1nol2TaeHaapO+IaG8/iIO/C2Jo6kyI6Ar5lBsaeyqZWq2jF
         iK8biIlrf1+e4Q93WLH7exH0IdonChOK5Iut3BfyJ1FNKH5eInbOG3HAmaDFR95b7XAo
         rU7qvE1COCO0ThaL8+Q3pOW/6oGhtt68zQqe+2Ldi+XkuW4lShBACqHq83M2CiMWuDKf
         MKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H2SRDpFUAr1Doq5sf9QePhDoqlW4v5u2uETm1oNzI6E=;
        b=TrbqzA3kkjtL5B1GpDC+P41JFTPVl4rEANDlCG8DeaLQoSokdxZI1b3nHuUCpVjiaN
         1DH9nNmaeehi6+lF2xcdb1Zcg+SC3OAshBX5Vw/Rw5ZypTCRW45PfWM2MlR3hGKdp4Wb
         JR2WnpYtiT9hRlDYsWO0+p5WU/qsr/+A1nzz6Ignyh81r8kLHkc7/NVp5xFV0Gc5sPA4
         VyizC/X9ZzICPXQ2E2553JnTiR6GajdAATJZd37U+Mp80WUtRBPbg+xLtujiWbm8GBHE
         ESQmlWrLsYE0BYjcbZcRg+XfyMisbY8TJLuzemzcXO/gnh9fT0YNWiR1vZ78zUJizA0+
         1ZPQ==
X-Gm-Message-State: AOAM532KQhG3k0yeQLoUV2r99BejTbQlzvv5gPuuigAuIvy5PgG/yEN7
        h66sXNbiQF/bpQA9KqiFHw8jY/AkfhDzpUmcJ/NS/JJgEjuqgg==
X-Google-Smtp-Source: ABdhPJwjLAV8eO+pYRPVLoVx6JBZyvS74WEZ/uxX0eF/kjI47i9qYlhWp9R2rxZEmgWbd0hhPWisVYQ0kwh/vUnNe9c=
X-Received: by 2002:a05:6830:17d7:: with SMTP id p23mr8173026ota.164.1616335989277;
 Sun, 21 Mar 2021 07:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
 <ca521d3c01d652e09e716fb447b0b26da1a014e8.1616251299.git.gitgitgadget@gmail.com>
 <xmqqft0pk018.fsf@gitster.g> <CAOLTT8Q7yNscYrYHWJQcsGn67MjWe15nd7SnCEd5QVUG0A6dRg@mail.gmail.com>
 <xmqq5z1kd2z1.fsf@gitster.g>
In-Reply-To: <xmqq5z1kd2z1.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 21 Mar 2021 22:12:57 +0800
Message-ID: <CAOLTT8SMUg+gmz84HM-XhGJYJMhYTtZaU5D5GSW34Fxn4o_6TQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] interpret-trailer: easy parse trailer value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8821=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=889:57=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Do you think this is appropriate?
> >
> > @@ -370,5 +370,15 @@ int parse_buffer_signed_by_header(const char *buff=
er,
> >                                   struct strbuf *payload,
> >                                   struct strbuf *signature,
> >                                   const struct git_hash_algo *algop);
> > +/*
> > + * Calling `find_author_by_nickname` to find the "author <email>" pair
> > + * in the most recent commit which matches "--author=3Dname".
> > + *
> > + * Note that `find_author_by_nickname` is not reusable, because it hav=
en't
> > + * reset flags for parsed objects. The only safe way to use
> > `find_author_by_nickname`
> > + * (without rewriting the revision traversal machinery) is to spawn a
> > + * subprocess and do find_author_by_nickname() in it.
> > + */
>
> Telling people not to add any new caller is good, but everything
> after "because" does not make sense to me.
>
> I do not think calling find_author_by_nickname() in a subprocess
> alone would not help somebody who wants to do this, either.  We'd be
> doing a moral equivalent of that call, but the result has to be
> communicated back to the parent process,
>

What I am thinking about here is that `commit --trailer` itself jumps to a
sub-process to do this, but this does depend on the fact that
`interpret-trailers`
 itself does not have a traversal, and indeed should not be arbitrarily cal=
l it.

> In the longer term, we'd probably want to have a pre-computed table
> of contributors, like we have precomputed files for reachability
> bitmaps, commit DAG topology, and such, but that is obviously far
> outside of the scope of this series.
>

Indeed this will be a very big project. But `.mailmap` always makes me
feel similar.

> > +const char *find_author_by_nickname(const char *name);
