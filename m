Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1694C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 04:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715DF610A8
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 04:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhHEEtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 00:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhHEEtv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 00:49:51 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBCAC061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 21:49:37 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h18so3865752ilc.5
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 21:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MqrMBK58iw9eBW2uBwwHrEzp7sMiddrFgh+wA5dN7g0=;
        b=gzJ+CqsIcdLUwnPFBTXIIRzcnYu0D+QrEXzP0Jq6nkm8TSGGShP7e0dfms5cfumFuh
         M7egDPJGjFq0/YtiiyWCaOOCyiwddl6iGxLvYa4ZnFBa1Qq8vMobgZhKIHADv23++PJS
         +V2HVyMB6Z2lUCnTkDXfYhbjgXLdOYVfAIbyS/ZlB4qMRjrVRhvzmMFKhV1CExSlNBIO
         zurksGFyLCcbyDGBuX3dkYZxgzUwNb6SFdBbc5mzrTgQwt3HwWcgU/x/iAqv9mAKZ+fV
         0F29uflJkzONs2p3rkAIiOJzVmOe4gGlFaaF8YKiXCpqtzNVN2WqByw+3+CN4jRX3wi1
         3+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MqrMBK58iw9eBW2uBwwHrEzp7sMiddrFgh+wA5dN7g0=;
        b=sl3aQh60auc7Y5mvEx65K1Fit9CIYwaSebbH5qVn7leFkmZAR8wov+ahXbvmv2h9OH
         8qmvxbyNH8jDvmvgJN31iUncvlrN8IRU+x6V2ulLRkvb5MrTExUfHpHPvo0nE1yIcUMl
         0miko79VBCt3acbH93OCTKq5JACjitmHR//ZWedPPUhOuiYbq/i8E6fjVzFkJKKVerec
         lkI3doAycl7na4mHNhiMmAatPVPQyPPYn4ZmtPye+oVI6j+Vla4ql4E6zN/H6IOHx6Do
         nVg+G2IkhVs6j7NQAhlAgRlJcS/A1mO4tT2H0KKs2VRZVufrlHm3eYob/THq2MpeGIUB
         AbNA==
X-Gm-Message-State: AOAM530PRMTfkhwu/1P83tZQoM5VF/x7Lx+zEHUFybBbJD9m4bJ/pMRy
        b0OSwRmWI43trQT+o9mpVckxqVyACML70T2pP5Y=
X-Google-Smtp-Source: ABdhPJwOpnpTAuYbxBg6HvqZO/2zxraJvvWqMuVdDoJuTrymwOVscvJCXlWEr29YznyqzY1TPYs/ZcsCL1B47IKz5Hw=
X-Received: by 2002:a05:6e02:5b0:: with SMTP id k16mr1044410ils.301.1628138976239;
 Wed, 04 Aug 2021 21:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RwwMF07f=XxWN=zGsPU0VQ8FqPVdyepQp78Ei8WZpSrw@mail.gmail.com>
 <CAP8UFD16pqERdF4Mdq=_ktvFB1rcXwB9PRy8TjNq=ThH5HbeqA@mail.gmail.com>
 <CAOLTT8SaXqWF3AJssqudrDK-KZN3oESO7Xh0JTYB_=HR9L9sHg@mail.gmail.com>
 <CAOLTT8QDo1A4tRqU0w-yas8OxrHB6uQ_PECswUQtQ7yY2-iWgw@mail.gmail.com> <CAP8UFD3E9oR9E4S=f8iReKOnvVO_WrXVziyztHZJCiScUAxDRg@mail.gmail.com>
In-Reply-To: <CAP8UFD3E9oR9E4S=f8iReKOnvVO_WrXVziyztHZJCiScUAxDRg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 5 Aug 2021 12:50:21 +0800
Message-ID: <CAOLTT8Sd6OCU_Ufrhqstz-Mw0Ej=9F2Y20BjPOpkgsuB5D-4Nw@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 11
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=
=884=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:57=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Tue, Aug 3, 2021 at 4:48 AM ZheNing Hu <adlternative@gmail.com> wrote:
> >
> > ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=883=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:37=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=
=E6=9C=882=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:25=E5=86=99=E9=81=
=93=EF=BC=9A
> > > >
> > > > On Sun, Aug 1, 2021 at 8:45 AM ZheNing Hu <adlternative@gmail.com> =
wrote:
> > > >
> > > > > in some cases, this is the result of the performance test of
> > > > > `t/perf/p1006-cat-file.sh`:
> > > > >
> > > > > ```
> > > > > Test                                        HEAD~             HEA=
D
> > > > > -----------------------------------------------------------------=
-------------------
> > > > > 1006.2: cat-file --batch-check              0.10(0.09+0.00)
> > > > > 0.11(0.10+0.00) +10.0%
> > > > > 1006.3: cat-file --batch-check with atoms   0.09(0.08+0.01)
> > > > > 0.09(0.06+0.03) +0.0%
> > > > > 1006.4: cat-file --batch                    0.62(0.58+0.04)
> > > > > 0.57(0.54+0.03) -8.1%
> > > > > 1006.5: cat-file --batch with atoms         0.63(0.60+0.02)
> > > > > 0.52(0.49+0.02) -17.5%
> > > > > ```
> > > > >
> > > > > We can see that the performance of `git cat-file --batch` has bee=
n a
> > > > > certain improvement!
> > > >
> > > > Yeah, sure -8.1% or -17.5% is really nice! But why +10.0% for
> > > > `cat-file --batch-check`?
> > >
> > > I think it's not very important. Because our optimization is skipping
> > > parse_object_buffer(), git cat-file --batch-check will not set oi->co=
ntentp
> > > by default, parse_object_buffer() will not be executed.
>
> Do you think that if git cat-file --batch-check would set
> oi->contentp, there would be no performance regression for `cat-file
> --batch-check`?
> Could you test that?
>

Oh, I mean that if git cat-file --batch-check with its default format
"%(objectname) %(objecttype)
%(objectsize)", it will not have any optimization; But if git cat-file
--batch set with "%(contents)" or
some other atoms, it will indeed be optimized. See 1006.4:

Test                                                 this tree
HEAD~
---------------------------------------------------------------------------=
------------------
1006.2: cat-file --batch-check                       0.15(0.12+0.02)
0.15(0.13+0.01) +0.0%
1006.3: cat-file --batch-check with basic atoms      0.12(0.10+0.01)
0.12(0.10+0.02) +0.0%
1006.4: cat-file --batch-check with contents atoms   0.66(0.63+0.02)
0.75(0.72+0.02) +13.6%
1006.5: cat-file --batch                             0.61(0.57+0.04)
0.70(0.65+0.05) +14.8%
1006.6: cat-file --batch with atoms                  0.58(0.57+0.01)
0.67(0.63+0.03) +15.5%

> > > Therefore, we did
> > > not optimize `git cat-file --batch-check` at all. 10% may be small en=
ough
> > > for git cat-file --batch-check. The noise of environment even will co=
ver it...
> >
> > By the way, its performance may still be worse than "upstream/master", =
but it
> > will be better than before optimization.
>
> Nice that there is some improvement, but it would be better if it was
> similar to "upstream/master".
>

Agree.

> > Test                                        HEAD~             this tree
> > -----------------------------------------------------------------------=
-------------
> > 1006.2: cat-file --batch-check              0.10(0.09+0.01)
> > 0.09(0.08+0.01) -10.0%
> > 1006.3: cat-file --batch-check with atoms   0.09(0.07+0.02)
> > 0.08(0.05+0.03) -11.1%
> > 1006.4: cat-file --batch                    0.61(0.59+0.02)
> > 0.53(0.51+0.02) -13.1%
> > 1006.5: cat-file --batch with atoms         0.60(0.57+0.02)
> > 0.52(0.49+0.03) -13.3%
>
> Yeah, your patch seems to be an overall improvement when the
> ref-filter code is used.
>
> > Test                                        upstream/master   this
> > tree
> > -----------------------------------------------------------------------=
-------------
> > 1006.2: cat-file --batch-check              0.08(0.07+0.01)
> > 0.10(0.07+0.02) +25.0%
> > 1006.3: cat-file --batch-check with atoms   0.06(0.05+0.01)
> > 0.08(0.08+0.00) +33.3%
> > 1006.4: cat-file --batch                    0.49(0.46+0.03)
> > 0.53(0.50+0.03) +8.2%
> > 1006.5: cat-file --batch with atoms         0.48(0.45+0.03)
> > 0.51(0.48+0.02) +6.3%
>
> This means that some further performance improvements are still needed
> both for --batch and --batch-check though.
>
> Have you tried to see, using gprof or something else, what is still
> degrading the performance compared to when the ref-filter code isn't
> used?

Yeah, gprof show that Number of calls of strbuf_add(), xstrdup() has increa=
sed
after using the logic of ref-filter. But at the same time, I noticed
that grab_person()
seems to be an area worth optimizing. grab_person() uses its parameter
"const char *who"
for type comparison, But after we added `enum atom_type` to
ref-filter, We can use it
for some comparisons. And there are two for() loops in grab_person(),
and we can merge
them into one. With this patch [1], there is a slight improvement in
performance.

Test                                                this tree
HEAD~
---------------------------------------------------------------------------=
----------------
1006.2: cat-file --batch-check                      0.14(0.13+0.01)
0.15(0.14+0.01) +7.1%
1006.3: cat-file --batch-check with atoms           0.12(0.10+0.01)
0.12(0.09+0.02) +0.0%
1006.4: cat-file --batch-check with contents atom   0.66(0.65+0.01)
0.66(0.64+0.02) +0.0%
1006.5: cat-file --batch                            0.60(0.57+0.02)
0.60(0.57+0.03) +0.0%
1006.6: cat-file --batch with atoms                 0.58(0.53+0.04)
0.58(0.56+0.02) +0.0%
1006.7: cat-file --batch with person atoms          0.59(0.57+0.02)
0.60(0.56+0.04) +1.7%

It=E2=80=99s also worth mentioning that I found that grab_person() seems to=
 be doing
repeated parsing which parse_object_buffer() may already be done.
parse_commit_buffer()
and parse_tag_buffer() have parsed part of the content of the object,
and used by
grab_tag_values() and grab_commit_values(). For the time being, I
think this is a kind of
shallow parsing, if we can let parse_object_buffer() do in-depth
parsing, it would be great.
We can save a lot of work in grab_person()... Of course this may be a
little difficult.

Thanks.
--
ZheNing Hu

[1]: https://github.com/adlternative/git/commit/cec0ee72e64d651c01d7a2a7fe1=
7a4adab1ef0de
