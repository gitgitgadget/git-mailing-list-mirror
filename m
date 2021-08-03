Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C470DC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 02:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A495B60E09
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 02:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhHCCst (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 22:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbhHCCss (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 22:48:48 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB23C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 19:48:37 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id c3so18318267ilh.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 19:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GcB8FgWSRZ4mCkXCwzuy4myI2Xtl1u+wJkEahSmAQhg=;
        b=R4KeYVwv9T4aQlvGCF5jBmAQl6XCY3rFoPNTb0oAwZRGmkLbQm9/q+JdP8YbK/hmQB
         WwjNd937855YWBGjK1jGf30cqqvivzHkWkuWqzPA1pLZzZ4k133bdJdbM1ghb2ObWc83
         YXjT8Q258EmfKCCXlrzqO295n4qho1fMz3h0u4NCjOnX4HCfNdmAmInNOBICFA6rlTer
         C/Q7Fpe/jGDBDnOxAPEpiLZx6hdQGkNxfHAEWdQaEphzriCdzE816jHdgkmYb70IDzFk
         2cBwNYWcB7IiLMl4WNaYSNX/YJg8uSfJHV1wcmxPgSh3JPX38KSTf44pucXy5lEd9PbV
         va8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GcB8FgWSRZ4mCkXCwzuy4myI2Xtl1u+wJkEahSmAQhg=;
        b=rtT21PP+VCQEloBBEenCK16tPqc3wwH3VVpQs+msZl6hbKhZk+G4nF10VghYlmroL2
         nyJoCpQTV9ZGcOko+NFXJJBleKLRlcknhQoe2t8dCbj0Mb08yz/BWuwKy0eZ/N1vYi2a
         Po+l9pMfoNRK6xTQpTGh4CX4N+D93TVi0avJ1uzjQLwcbAh7DkkFQoMim4GU4j4nlGcO
         jx6HRBcgrbpyoqbeclbEDZlLDUocfPy8+p29pd/dfNfoIuNwDQI5MRn5v1sYWAv4/8TC
         1Wf6lV4t03AM3VQn1COpcl5dZ9hfs2a2JEeRkJvmXaYmgk46brbbtPX6rlfjP06Ro6CN
         g2Zw==
X-Gm-Message-State: AOAM531YJVryrIy5Z6WurMQ/prKYnwjd7VO6BEnUaBjmk3xKULmG6ZyU
        GUYXmXccTDFWSM6YBMWzAz8ubn0GA0MI5Q/NpzQ=
X-Google-Smtp-Source: ABdhPJyMMLxERCh1n4XmeBAzlHvofeHp+N5TA1NDjgnTVqAwZEPjAAnyEEMprrERNpb4MlAPtQMafyLqSqgGV9Go6t8=
X-Received: by 2002:a05:6e02:5b0:: with SMTP id k16mr66948ils.301.1627958916076;
 Mon, 02 Aug 2021 19:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RwwMF07f=XxWN=zGsPU0VQ8FqPVdyepQp78Ei8WZpSrw@mail.gmail.com>
 <CAP8UFD16pqERdF4Mdq=_ktvFB1rcXwB9PRy8TjNq=ThH5HbeqA@mail.gmail.com> <CAOLTT8SaXqWF3AJssqudrDK-KZN3oESO7Xh0JTYB_=HR9L9sHg@mail.gmail.com>
In-Reply-To: <CAOLTT8SaXqWF3AJssqudrDK-KZN3oESO7Xh0JTYB_=HR9L9sHg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 3 Aug 2021 10:49:18 +0800
Message-ID: <CAOLTT8QDo1A4tRqU0w-yas8OxrHB6uQ_PECswUQtQ7yY2-iWgw@mail.gmail.com>
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

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:37=E5=86=99=E9=81=93=EF=BC=9A
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=
=9C=882=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:25=E5=86=99=E9=81=93=
=EF=BC=9A
> >
> > On Sun, Aug 1, 2021 at 8:45 AM ZheNing Hu <adlternative@gmail.com> wrot=
e:
> >
> > > in some cases, this is the result of the performance test of
> > > `t/perf/p1006-cat-file.sh`:
> > >
> > > ```
> > > Test                                        HEAD~             HEAD
> > > ---------------------------------------------------------------------=
---------------
> > > 1006.2: cat-file --batch-check              0.10(0.09+0.00)
> > > 0.11(0.10+0.00) +10.0%
> > > 1006.3: cat-file --batch-check with atoms   0.09(0.08+0.01)
> > > 0.09(0.06+0.03) +0.0%
> > > 1006.4: cat-file --batch                    0.62(0.58+0.04)
> > > 0.57(0.54+0.03) -8.1%
> > > 1006.5: cat-file --batch with atoms         0.63(0.60+0.02)
> > > 0.52(0.49+0.02) -17.5%
> > > ```
> > >
> > > We can see that the performance of `git cat-file --batch` has been a
> > > certain improvement!
> >
> > Yeah, sure -8.1% or -17.5% is really nice! But why +10.0% for
> > `cat-file --batch-check`?
> >
>
> I think it's not very important. Because our optimization is skipping
> parse_object_buffer(), git cat-file --batch-check will not set oi->conten=
tp
> by default, parse_object_buffer() will not be executed, Therefore, we did
> not optimize `git cat-file --batch-check` at all. 10% may be small enough
> for git cat-file --batch-check. The noise of environment even will cover =
it...
>

By the way, its performance may still be worse than "upstream/master", but =
it
will be better than before optimization.

Test                                        HEAD~             this tree
---------------------------------------------------------------------------=
---------
1006.2: cat-file --batch-check              0.10(0.09+0.01)
0.09(0.08+0.01) -10.0%
1006.3: cat-file --batch-check with atoms   0.09(0.07+0.02)
0.08(0.05+0.03) -11.1%
1006.4: cat-file --batch                    0.61(0.59+0.02)
0.53(0.51+0.02) -13.1%
1006.5: cat-file --batch with atoms         0.60(0.57+0.02)
0.52(0.49+0.03) -13.3%

Test                                        upstream/master   this
tree
---------------------------------------------------------------------------=
---------
1006.2: cat-file --batch-check              0.08(0.07+0.01)
0.10(0.07+0.02) +25.0%
1006.3: cat-file --batch-check with atoms   0.06(0.05+0.01)
0.08(0.08+0.00) +33.3%
1006.4: cat-file --batch                    0.49(0.46+0.03)
0.53(0.50+0.03) +8.2%
1006.5: cat-file --batch with atoms         0.48(0.45+0.03)
0.51(0.48+0.02) +6.3%

Test                                        upstream/master   HEAD~
---------------------------------------------------------------------------=
---------
1006.2: cat-file --batch-check              0.08(0.07+0.01)
0.10(0.07+0.03) +25.0%
1006.3: cat-file --batch-check with atoms   0.06(0.05+0.00)
0.08(0.08+0.00) +33.3%
1006.4: cat-file --batch                    0.48(0.46+0.02)
0.60(0.57+0.03) +25.0%
1006.5: cat-file --batch with atoms         0.47(0.44+0.03)
0.63(0.59+0.04) +34.0%

Thanks.
--
ZheNing Hu
