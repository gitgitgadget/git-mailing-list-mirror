Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E75C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0478E64F67
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhCQNzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhCQNyw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:54:52 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534CCC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:54:52 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t83so31844498oih.12
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5nyZ+Vn4AmXf/GPB0+mU8urIe4L3iIXITYlQ0lHvpCM=;
        b=DCeiRIq4WSe1SCjgQlhN+mkP6nXjmdTaxvtNt2+oCiEYOxbgCUPpDIKBL1XXw7Ml03
         PiGGvcmRqiijClxZfePrVOoi9vD4GniqxwN2HI6EHECW7F7wfZnIbL1KhqxhKPZHLjQn
         5VY//3BYXtLsgNJKPfWKjJ1AkQddyJhcAGLAuXywtaG/o/nRO2283rAAatiy16WryLAB
         A+EIaWJ1ooBfUrBD+q9T8UtK4+lY8aov/0qEmuYM75msZKY1nGfp3xDL0NWhvuXZT+zm
         hQJagyClawHVBPRTnl9NXQ5zmiAs5ehwiS8IT2S6OsHfQeEBAumWnOlGfB9+17TZLGIg
         zjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5nyZ+Vn4AmXf/GPB0+mU8urIe4L3iIXITYlQ0lHvpCM=;
        b=LS1abjjsc+jxOiCgWundP7xRdvgEl/qFcFwJSYl+N9RQ8J6OaB/XJQBaFlQJjyVlLj
         1Xm57n9Mo2tkzzSFRF1+rpcDzczK/z1Uq/hflY2p35rUMWRTnvUeywEMxYDc6il5OZnP
         cTd5Y5gbSCoEWKVF9btTfmGaG/GkzLLYHJX1xfFF28t33e/sC3mWuzqEAsnnewi1NRAM
         AFmC3DrgDtfceor894K2Qr15nE826rCRVhPt6HFWi5vhRLgd20zYU+zQdeYSMjKyx75B
         VGIql4FqqxfMZME+yBuUSZxs5bF6x7lfxBkf+mbaNm+LgRs7fNc/axfNg2yIWHfqAaxN
         1Q8w==
X-Gm-Message-State: AOAM533E9CAdDDagCpXvEMSgLQSgGbXKm3V/HTyQPdCChrXN3Ca5GC9V
        Z4TZxqNXaVnDnBLtnlomRpsThNhbhu4fXCgDe0M=
X-Google-Smtp-Source: ABdhPJxnEDI4OKk9sRj4U40U6gtRlzFl2KX7nTk1p8QHZYH4SdMgOTPE+Md4lfVooWVvFIWz3/CIn5wG4vF6HUGuzUQ=
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr2988672oia.44.1615989289423;
 Wed, 17 Mar 2021 06:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
 <pull.901.v8.git.1615813658.gitgitgadget@gmail.com> <f81b6e66a6ba6b2fc8e6307dbc5fba9cddcff181.1615813658.git.gitgitgadget@gmail.com>
 <87zgz3dzvl.fsf@evledraar.gmail.com> <CAOLTT8RyCvs8bbedPaRSo44o566Tk1MK9BeLx=-APnFsHJtejw@mail.gmail.com>
 <87wnu6dwxx.fsf@evledraar.gmail.com>
In-Reply-To: <87wnu6dwxx.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 17 Mar 2021 21:54:37 +0800
Message-ID: <CAOLTT8SFd=Zg01kR9rvTO6yh+tSS5VbcLBjAcB+d_DX_NY_HOw@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] [GSOC] commit: add --trailer option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B43=E6=9C=8817=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:08=E5=86=
=99=E9=81=93=EF=BC=9A
> > Logically speaking, `interpret_trailers` should be dedicated to `commit=
`
> > or other sub-commands that require trailers.
> >
> > But I think that in the later stage, the parse_options of the `cmd_comm=
it`
> > can keep the unrecognized options, and then these choices can be direct=
ly
> > passed to the `interpret_trailers` backend.
>
> We have this interaction with e.g. range-diff and "log", it's often
> surprising. You add an option to one command and it appears in the
> other.
>

All right, I'm wrong, I may have reference to an wrong experience
of `difftool`-->`diff`.

> >>    It seems to me to be a good idea to (at least for testing) convert
> >>    the --signoff trailer to your implementation. We have plenty of tes=
ts
> >>    for it, does migrating it over pass or fail those?
> >>
> > I don=E2=80=99t know how to migrating yet, it may take a long time.
> > Even I think I can leave it as #leftoverbit later.
>
> Sure, I mean (having looked at it) that at least for your own local
> testing it would make sense to change it (even if just search-replacing
> the --signoff in the test suite) to see if it behaves as you
> expect. I.e. does the --trailer behavior mirror --signoff?
>
> >>  * I also agree with Junio that we shouldn't have a --fixed-by or
> >>    whatever and wouldn't add --signoff today, but it seems very useful
> >>    to me to have a shortcut like:
> >>
> >>        --trailer "Signed-off-by"
> >>
> >>    I.e. omitting the value, or:
> >>
> >>       --trailer "Signed-off-by=3D"
> >>
> >>    Or some other thing we deem sufficiently useful/sane
> >>    syntax/unambiguous.n
> >>
> >>    Then the value would be provided by fmt_name(WANT_COMMITTER_IDENT)
> >>    just as we do in append_signoff() now. I think a *very common* case
> >>    for this would be something like:
> >>
> >>        git commit --amend -v --trailer "Reviewed-by"
> >>
> >>    And it would be useful to help that along and not have to do:
> >>
> >>        git commit --amend -v --trailer "Reviewed-by=3D$(git config use=
r.name) <$(git config user.email)>"
> >>
> >>    Or worse yet, manually typo your name/e-mail address, as I'm sure I
> >>    and many others will inevitably do when using this option...
> >>

Well, that's what I think here:

Now we can go through:

$ git -c trailer.signoff.key =3D "Signed-off-by" commit --trailer
"signoff =3D commiter <email>"

to get a trailer: "Signed-off-by: commiter <email>", this means we
can't just do simple string
matching in `cmd_commit` to replace `--trailer=3D"Signed-off-by"` or
`--trailer=3D"Reviewed-by"` to
user's own identity, to replace the trailers which have omitting value
 we passed in, but I think
we can provide a new option to `commit` which can mandatory that
trailers with no value can be
 replaced with the identity of the user.

e.g.

$ git -c trailer.signoff.key =3D "Signed-off-by" commit --trailer
"signoff" --trailer "Helped-by" \
 --trailer "Helped-by =3D C <E>" --own_ident

will output like this:

Signed-off-by: $(git config user.name) <$(git config user.email)>
Signed-off-by: $(git config user.name) <$(git config user.email)>
Helped-by: $(git config user.name) <$(git config user.email)>
Helped-by: C <E>

I don't know if this idea is good, I will try to do it first.

Thanks.
