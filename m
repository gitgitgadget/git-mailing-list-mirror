Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09B0C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 13:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942A964F4E
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 13:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhBBNE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 08:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhBBNEz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 08:04:55 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F2AC061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 05:04:14 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id v1so19713409ott.10
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 05:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LSB0jc0c6StMJVHuvT9FoowSnH63vCuuLy/ovgbtREM=;
        b=qjiic7CXptEVC2m/jAI62fNJl8fLYdE0Kr6gdb8JQ3tliCdQDAw/tAxRgb9xu62xL/
         trrCiaumyBnoq/NabW0lkv3YPPyrhwcoDvtGx0hyQ8jSi98PZpaltnCiuKEY1GBeNfIR
         1wGpq6uzUQ6mAbeFMgMJqpbfuEqdzm+985erW1SRkPzYBaTWp9Y4QEgL1tMcCc3y6R5P
         UqBo0kCmbqA1gTidoIfDvC5MsBycVeRnvey8CoeRp2Fah5pxyeMJqHjwQNoxWyFl7aj8
         5731GMdnW0hZq8EVq5Hk6wVQBaXP/8fNUL9ON9xZ44t4viJr1h86/ssICJWRHwSeZQ3E
         c7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LSB0jc0c6StMJVHuvT9FoowSnH63vCuuLy/ovgbtREM=;
        b=C1DciS44OgDrwlRdzo/hl3Cb4Z+k65pbVr7nS+pmZ5FqZYlPeND3O+yBdbNENLACap
         kz6sIIpQUkCCaePvJjLaSE2FogRRILwB3F5Ys//SoI10b3d3t97g9Tcr1ykSeNiNIpVO
         Qj4r0jSN6NZaZzKxu0LmAkeroAQar5LWlREaCb2/BtHe9CgYZaDGdjqOWJOcio4wbtLF
         tPkOKx8n4sWLfFCIScykxOHJ57aGZT0Wt0RSCGB+w1glupvXxaLS7kSlPtLKnaa67wqN
         0EuJ5vRBysaGOQKQBdv/6AAfzRXCWXWvAeLc2x44FPxsN1TtyOMtPZeE7DLo6JeknseB
         TRyA==
X-Gm-Message-State: AOAM531cwQEXJAeNeoyRlA73cQRhYKt4IcVJ5lNG5BhmtOIUCkNqpYp8
        Jflwtik85cBaTTgiAIfwp3J/SuFUu+tEku1SdXavOFZ+YG/FoMpT
X-Google-Smtp-Source: ABdhPJzM6ClmPD7jN+ya9zJH6ESVRehm3bxqZath4YO+n4bUJ/NFwyMY1zkCohDWBZPrtQGjGKfXSUKZHbegJWtHRvA=
X-Received: by 2002:a9d:4812:: with SMTP id c18mr14484515otf.160.1612271053285;
 Tue, 02 Feb 2021 05:04:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.857.git.1612011569489.gitgitgadget@gmail.com>
 <pull.857.v2.git.1612175966786.gitgitgadget@gmail.com> <xmqqpn1jn033.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn1jn033.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Tue, 2 Feb 2021 21:06:17 +0800
Message-ID: <CAOLTT8ShJzJangqkk8KQVdptFB5K0TiB1ETQcXb=HwinbkL9Hw@mail.gmail.com>
Subject: Re: [PATCH v2] alloc.h|c: migrate alloc_states to mem-pool
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?6Zi/5b6354OIIHZpYSBHaXRHaXRHYWRnZXQ=?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To Junio:
Thanks for checking.forget my unprofessional
description.Macroscopically speaking,
both alloc_state and mem_pool are doing one thing:Apply for a
large block of memory in advance,and when needed a dynamically
allocated memory ,we call the interface function to apply for memory,
This can reduce the overhead of calling malloc multiple times.And the
mem-pool or alloc_state will Automatic Expand capacity.

So that ,my this patch may have something not considered,
>     mem_pool_init(o->blob_pool,0);
may be a wrong way to init this mem-pool
because:
>void mem_pool_init(...)
>       ...
>       if (initial_size > 0)
>              mem_pool_alloc_block(pool, initial_size, NULL);
the first time calloc malloc may  decay to we first call "mem_pool_alloc_bl=
ock",
I think this may not be great.

A little ashamed,I did not consider the optimization point of this
at the beginning,


Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:56=E5=86=99=E9=81=93=EF=BC=9A
>
> "=E9=98=BF=E5=BE=B7=E7=83=88 via GitGitGadget"  <gitgitgadget@gmail.com> =
writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > "alloc_state" may have similar effects with "mem_pool".
>
> What "similar effects" do you have in mind?  "mem_pool" may have
> more than one "effects" to multiple things that are affected, but it
> is unclear which effect that "mem_pool" exerts on what you are
> referring to.
>
> > Using the new memory pool API may be more beneficial
> > to our memory management in the future.
>
> Many things may or may not be "beneficial" in the future.  We do not
> build things on a vague "hunch".
>
Now,I make a rough comparison.
Situation : when we just use it to malloc little struct node
such as `object`,`blob` ,`tree`.
> Are you seeking performance (e.g.  number of objects that can be
> allocated per minute)?

1.  performance.
`mem_pool` api will allocate 2^20 byte everytime ,
`alloc_state` api will allocate 1024*nodesize byte and ALLOC_GROW everytime=
.
A repo like git may call malloc fewer times when using `mem_pool`,
while a small repo may not have this amount of objects. The number of
calling `malloc`
may be similar.
may be `mem_pool` win a little...
>Are you seeking better memory locality
> (e.g. related objects are likely to be stored in the same page,
> reducing number of page faults)?
2. page faults .
I might think they are similar at first.But now,I start to understand
what you mean:`alloc_state` more like an object pool,so that we could
go through the list of all objects.Therefore, mem_pool is not conducive
to continuous access to all objects.Because There may be fragments
in the memory And this must be a cross-page operation.
so `alloc_state` win.
>Are you seeking reduced wasted
> memory (e.g. custom allocator packs objects better than bog-standard
> malloc(3))?
3.Memory utilization.
`alloc_state`win.No doubt.
 Are you seeking functionality (e.g. you have this and
> that specific codepaths and usecase where you wish to be able to
> release all the objects instantiated for a particular repository,
> without having to go through the list of all objects, and use of
> mempool is one way to allow us do so)?
>
4.functionality
yeah,As mentioned above.Object pool will be better.
`alloc_state`win.
5.
Indeed, the object pool `alloc_state` may be better than the
memory pool `mem_pool`.
But We can assume that the original author=E2=80=99s intention may be to
The five alloc_states are merged together.
Because the original author said: "migrate alloc_states to mem-pool"
Or another advantage of using the memory pool is that it can dynamically
allocate a variety of different objects, I now think the original author ha=
s
this intention.So my patch code also needs some modifications.But at the
same time, it may not be good to count them separately if multiple objects
are allocated using the memory pool at the same time.
so 'mem_pool' win a little.
> It is not even clear in your problem description what kind of
> benefit you are seeking, let alone how much quantitative improvement
> you are getting with this change.
>
I don't know how to quantify them temporarily.
I may need the opinions of you and the original author before I can move on=
.

Thanks.
