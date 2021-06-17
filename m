Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551B2C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 09:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38EFB61209
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 09:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhFQJYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 05:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhFQJYi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 05:24:38 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2F4C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 02:22:31 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id b5so4763063ilc.12
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ds/me/t5k1kgsApxoFByQxDdHGqqa2FUaFnSv7OgNLA=;
        b=AM8uiIa+DUZN76nPC+4g1ojQi9VB9Zj95FbO/9l1IcyyS3onP6wv6ngn/0Viy5yuCm
         U09JRTGt152TJvdbEOBsyjn+QVOEZbt8juIU3DOP8V8sLaox/xO1tj/q9tGMxEdjdhkM
         mM/h2mFVw0Fh1GZKJlMUTO+4uNCnTMxzZKKBTTNXQZpWJ7LamAfUAimMhwBDWM1Kulvi
         i+SUH2BrcKSuZ3Yp+29bcGYVgk5THlLqMjl/N2Hcg/c2UsJ4+vDNL85elxusofORFQqr
         opAvlAOttAxAU7AizeDtzT2FXh/m2MPHsH66RlNHkebxU93SzAfnZTXk9WomRBWeKYx6
         idwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ds/me/t5k1kgsApxoFByQxDdHGqqa2FUaFnSv7OgNLA=;
        b=D21js87nHcXY2B/WruhcizPTByEkX87WJtff+4hPNEmsNtDqofjea9SFcu+H8oNbp2
         5esesLalOA1bTjWlhT/IxbaUw9U5EMSAz7vFtF86eM22jc5MwJWdEbPAVuU2PBMLT3hm
         WyzLSj8dXgnWlmSZ8mwvoGZuHNu/OvCtdvjj3eL0s/dshK8lZCXqLFLnfKYncqg3KP4f
         3NEo6BudlDoZYvLtsATqbJSeasqNockW5fp8vZ880Dwz8NxJO+FPIJUrkcfVdlwlr1I/
         kF8jV7TW2BGDCD7PZF1FQjdG/cAayvqm9zpk07W8MqJlYdpEMjsAFYNm7TlAVkQSxRNb
         1p4Q==
X-Gm-Message-State: AOAM533Mpiokf6bhPymXWmGsNKTgGXaPlQ96fcXmpoZauTYtEUKnW1Mc
        8qTrzzsz1Lzs0sfUxJvUcPS/bjJcswOS61pn1SE=
X-Google-Smtp-Source: ABdhPJxiOsMPJI+C5vBUjAifNB9pXDrLD6PgxPTomwJVqMJ1zOOUxQRMl7s0NDKQdJtU86v9AAU+gy/9Q1IxOFwcLDQ=
X-Received: by 2002:a92:c8d2:: with SMTP id c18mr391956ilq.301.1623921750924;
 Thu, 17 Jun 2021 02:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <abee6a03becb929ffb292648d1ef64e61b66d53d.1623496458.git.gitgitgadget@gmail.com>
 <875yydx8oo.fsf@evledraar.gmail.com>
In-Reply-To: <875yydx8oo.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 17 Jun 2021 17:22:19 +0800
Message-ID: <CAOLTT8TMOs-FF+EcTZBbxfGnKQipe_nx_eZon=S=PWRTNT4CjA@mail.gmail.com>
Subject: Re: [PATCH 2/8] [GSOC] ref-filter: add %(raw) atom
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
=B9=B46=E6=9C=8817=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:16=E5=86=
=99=E9=81=93=EF=BC=9A
>
> > The raw data of blob, tree objects may contain '\0', but most of
> > the logic in `ref-filter` depends on the output of the atom being
> > text (specifically, no embedded NULs in it).
> >
> > E.g. `quote_formatting()` use `strbuf_addstr()` or `*._quote_buf()`
> > add the data to the buffer. The raw data of a tree object is
> > `100644 one\0...`, only the `100644 one` will be added to the buffer,
> > which is incorrect.
> >
> > Therefore, add a new member in `struct atom_value`: `s_size`, which
> > can record raw object size, it can help us add raw object data to
> > the buffer or compare two buffers which contain raw object data.
>
> Most of the functions that deal with this already use a strbuf in some
> way, before we had a const char *, now there's a size_t to go along with
> it, why not simply use a strbuf in the struct for the data? You'll then
> get the size and \0 handling for free, and any functions to deal with
> conversion can stick to the strbuf API, there seems to be a lot of back
> and forth now.
>

Yes, strbuf is a suitable choice when using <str,len> pair.
But if replace v->s with strbuf, the possible changes will be larger.

> > Beyond, `--format=3D%(raw)` cannot be used with `--python`, `--shell`,
> > `--tcl`, `--perl` because if our binary raw data is passed to a variabl=
e
> > in the host language, the host language may not support arbitrary binar=
y
> > data in the variables of its string type.
>
> Perl at least deals with that just fine, and to the extent that it
> doesn't any new problems here would have nothing to do with \0 being in
> the data. Perl doesn't have a notion of "binary has \0 in it", it always
> supports \0, it has a notion of "is it utf-8 or not?", so any encoding
> problems wouldn't be new. I'd think that the same would be true of
> Python, but I'm not sure.
>

Not python safe. See [1].
Regarding the perl language, I support Junio's point of view: it can be
re-supported in the future.

>
> > +test_expect_success 'basic atom: refs/tags/testtag *raw' '
> > +     git cat-file commit refs/tags/testtag^{} >expected &&
> > +     git for-each-ref --format=3D"%(*raw)" refs/tags/testtag >actual &=
&
> > +     sanitize_pgp <expected >expected.clean &&
> > +     sanitize_pgp <actual >actual.clean &&
> > +     echo "" >>expected.clean &&
>
> Just "echo" will do, ditto for the rest. Also odd to go back and forth
> between populating expected.clean & actual.clean.
>

Are you saying that sanitize_pgp is not needed?

>
> > +test_expect_success 'set up refs pointing to binary blob' '
> > +     printf "a\0b\0c" >blob1 &&
> > +     printf "a\0c\0b" >blob2 &&
> > +     printf "\0a\0b\0c" >blob3 &&
> > +     printf "abc" >blob4 &&
> > +     printf "\0 \0 \0 " >blob5 &&
> > +     printf "\0 \0a\0 " >blob6 &&
> > +     printf "  " >blob7 &&
> > +     >blob8 &&
> > +     git hash-object blob1 -w | xargs git update-ref refs/myblobs/blob=
1 &&
> > +     git hash-object blob2 -w | xargs git update-ref refs/myblobs/blob=
2 &&
> > +     git hash-object blob3 -w | xargs git update-ref refs/myblobs/blob=
3 &&
> > +     git hash-object blob4 -w | xargs git update-ref refs/myblobs/blob=
4 &&
> > +     git hash-object blob5 -w | xargs git update-ref refs/myblobs/blob=
5 &&
> > +     git hash-object blob6 -w | xargs git update-ref refs/myblobs/blob=
6 &&
> > +     git hash-object blob7 -w | xargs git update-ref refs/myblobs/blob=
7 &&
> > +     git hash-object blob8 -w | xargs git update-ref refs/myblobs/blob=
8
>
> Hrm, xargs just to avoid:
>
>     git update-ref ... $(git hash-object) ?
>

I didn=E2=80=99t think about it, just for convenience.

> > +test_expect_success '%(raw) with --python must failed' '
> > +     test_must_fail git for-each-ref --format=3D"%(raw)" --python
> > +'
> > +
> > +test_expect_success '%(raw) with --tcl must failed' '
> > +     test_must_fail git for-each-ref --format=3D"%(raw)" --tcl
> > +'
> > +
> > +test_expect_success '%(raw) with --perl must failed' '
> > +     test_must_fail git for-each-ref --format=3D"%(raw)" --perl
> > +'
> > +
> > +test_expect_success '%(raw) with --shell must failed' '
> > +     test_must_fail git for-each-ref --format=3D"%(raw)" --shell
> > +'
> > +
> > +test_expect_success '%(raw) with --shell and --sort=3Draw must failed'=
 '
> > +     test_must_fail git for-each-ref --format=3D"%(raw)" --sort=3Draw =
--shell
> > +'
>
> s/must failed/must fail/, but see question above about encoding in these
> languages...


[1]: https://lore.kernel.org/git/CAOLTT8QR_GRm4TYk0E_eazQ+unVQODc-3L+b4V5JU=
N5jtZR8uA@mail.gmail.com/

Thanks for a review.
--
ZheNing Hu
