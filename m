Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFD9C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 02:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CABA60724
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 02:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhHCCge (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 22:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbhHCCge (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 22:36:34 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF04C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 19:36:24 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id k3so18311760ilu.2
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 19:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fyJ8/kmWgzqarBDLZP45XnseAa/MjoRv6V3lw5kgtfY=;
        b=oBA25gmhsmnkoCSxscSW5K2bsDiINcz9R7PJRmaRpwiZBmNl1fLURKD5oqKskvX15O
         uelHvJ7oJ00OxWhaTRlpR0YYQP6cll10oXfs1bhHjwJoc72Dz5pO3eStmjqIyTGMAs9R
         966UFLsBuHPR+2lHlG4kHuXE/bWDVvPusSWfmDKLshoRVNmnQmKtrJTTdrEaiGcuDQvc
         2lRQkOgN2Z/HOaszX2iRBXWO2pNqGZ3BIG7XIUek/w98rBe9Sm47ZGgMjRPViB8/qyxV
         D3g02yii7qX+yYLpsVRxg04jCq1MQYXY3N0GL6EjrCD2xdc10TFEf6ypK+K98idvEkkG
         NtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fyJ8/kmWgzqarBDLZP45XnseAa/MjoRv6V3lw5kgtfY=;
        b=Bl8rFwdhVU4/wM4s3f2w5Iwc8sr0oUh0aRm9nBdVXSEQZ9XbjgCXvN8e0ndrS/8dZJ
         SKcVQHsAn88Ub/vRB83ZhKh22RnzHZubfjmUdNTYi6/Y+QlC8ioVJr7o+2/fXxx9q56R
         XOw2glUBCGQc63Kq+C1mClfp5obrgNQcR9trZgdfT4bQ6dW1v/R5YazaVYg6J9twv0Wd
         XSVQmMd983pnLFU6l9s4DBP6Yij4dtdXCnRvWxZEJon2y0f4KUyZ6GnYzjIHgxgex70F
         ztSa39TIFXaTOMr+alttYaKIQWCDPosly2l2jkW1TejDmiAIf34aTjUrg6X9JdNPQXpZ
         xsjg==
X-Gm-Message-State: AOAM533Xuc1FJN42Gb3CBH06qeqhY+oBW5PmN7Q45kx29yi9w25nu3Wc
        WMtyPh7tlvJM2o89fc7lryQisE1Oglwvx0BbKto=
X-Google-Smtp-Source: ABdhPJzxlOOvFXvHGomhl6yejXCDFKRSVroCvn+Qr0K9wDHZQkQY42MaMJjQu+WNyGMS2jpAwsJvwnekRyBz6CK8jlM=
X-Received: by 2002:a05:6e02:190d:: with SMTP id w13mr808292ilu.53.1627958183584;
 Mon, 02 Aug 2021 19:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RwwMF07f=XxWN=zGsPU0VQ8FqPVdyepQp78Ei8WZpSrw@mail.gmail.com>
 <CAP8UFD16pqERdF4Mdq=_ktvFB1rcXwB9PRy8TjNq=ThH5HbeqA@mail.gmail.com>
In-Reply-To: <CAP8UFD16pqERdF4Mdq=_ktvFB1rcXwB9PRy8TjNq=ThH5HbeqA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 3 Aug 2021 10:37:06 +0800
Message-ID: <CAOLTT8SaXqWF3AJssqudrDK-KZN3oESO7Xh0JTYB_=HR9L9sHg@mail.gmail.com>
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
=882=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:25=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Sun, Aug 1, 2021 at 8:45 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> > in some cases, this is the result of the performance test of
> > `t/perf/p1006-cat-file.sh`:
> >
> > ```
> > Test                                        HEAD~             HEAD
> > -----------------------------------------------------------------------=
-------------
> > 1006.2: cat-file --batch-check              0.10(0.09+0.00)
> > 0.11(0.10+0.00) +10.0%
> > 1006.3: cat-file --batch-check with atoms   0.09(0.08+0.01)
> > 0.09(0.06+0.03) +0.0%
> > 1006.4: cat-file --batch                    0.62(0.58+0.04)
> > 0.57(0.54+0.03) -8.1%
> > 1006.5: cat-file --batch with atoms         0.63(0.60+0.02)
> > 0.52(0.49+0.02) -17.5%
> > ```
> >
> > We can see that the performance of `git cat-file --batch` has been a
> > certain improvement!
>
> Yeah, sure -8.1% or -17.5% is really nice! But why +10.0% for
> `cat-file --batch-check`?
>

I think it's not very important. Because our optimization is skipping
parse_object_buffer(), git cat-file --batch-check will not set oi->contentp
by default, parse_object_buffer() will not be executed, Therefore, we did
not optimize `git cat-file --batch-check` at all. 10% may be small enough
for git cat-file --batch-check. The noise of environment even will cover it=
...

> > Tell a joke: removing 1984531500 if checking can reduce the startup
> > time of GTA5 by 70%. :-D
>
> s/if checking/checks/
>
> As this joke refers to:
>
> https://rockstarintel.com/a-fan-reduces-gta-online-loading-times-by-70
>
> it might be nice to add a link to help people like me who didn't know
> about this and had to google it.
>

Ehhh, makes sense.

> > Currently the patch has not been submitted to the mailing list, let us
> > wait a bit...
>
> Looking forward to it...

I am afraid we need to wait until ref-filter-raw-data merged into master.

The preview version is here:
https://github.com/adlternative/git/commit/6fcf51c4b1cbb510dac775a6fbf3db36=
1bc1c327

Thanks.
--
ZheNing Hu
