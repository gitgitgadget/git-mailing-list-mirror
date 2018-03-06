Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DFC91F404
	for <e@80x24.org>; Tue,  6 Mar 2018 00:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932767AbeCFAKj (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 19:10:39 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:37561 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbeCFAKi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 19:10:38 -0500
Received: by mail-oi0-f46.google.com with SMTP id f186so13522984oig.4
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 16:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=bqDdaQRSNT9SxayepU1CsxCvn0v2Y4FxZN1xxFr/QFc=;
        b=d/BtmKhU2lnnjE0N9GoYQvRwu5iJ7aH0h/+WaQyz0yT/jElx/4aPLG7rnUGJstbtXY
         oYsymqv6N40QfiTWX+GaUEH+B1jP/omNjO56g0MkRYFLjEARBJ8BNMhIYYg9wUU5aDJi
         kp3MXyOTQHjIxsm627CClNs0gJDW9TnEIKb9k5XK8I/4uo+bEnrCC+74xU5e1kO7FPpr
         6XIsUppEN/wiRVS7eu4EvOGycxJUlm6Xwcgxi0XhNJdxsAR9RHqTLIdRuW28r+QgRrLU
         d8zCVejVx6GsMi4e0xqALkyeFHHUtC562lZaxUhI1GS8q95Nn+tFHrC4HtTpbNw3FbH+
         PU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=bqDdaQRSNT9SxayepU1CsxCvn0v2Y4FxZN1xxFr/QFc=;
        b=gyk/u+3A/5Bx2U7tlxdzqpWTD3n9TPfukTRa/NiD0HbL0/h5fRG9OOvAbVQhbdwaAk
         BHtVsOqofpLmP/wzcVnXIrD3Majx9n+qrVeQIK2RMXrjIoqrl1lW3nQPsw4vyDIIWdtq
         81AM1D1qeXH92dw9hhsbgeEJYhhnW0w5lvsQsy5Jm/xLAnAALZP5PpGdO/Q489o7i4Dt
         3xjEGZQ53OaDnH/XkFiZAfPoySn6HweaWgoxDeiD6Xi2YB3pmLQ1K2hSYT1KGrzNk3x1
         5cVKcFQODbXzczI8ubguEWg88zV1WOBf6irwefx5VjXMvgzsHT9YkcsL6eofzwlmY9Ed
         l2vQ==
X-Gm-Message-State: APf1xPCGE9oeQBCCNGjkMB28MK2V7K8/z9M4N++JRhSYhcZ0rFAYuFcp
        tj8w2CSZtryNg4rfCAdQZqnaAIZMvED6X+WeOi8=
X-Google-Smtp-Source: AG47ELsuIAtbP10jRi0SlQTgG4Fg3XbUtso/QlS4ZZ3SpUIux4wXNisopL/ROCKTiIkYH58u8qHox9oIYnsvf/t+/Ik=
X-Received: by 10.202.206.71 with SMTP id e68mr11164123oig.34.1520295037659;
 Mon, 05 Mar 2018 16:10:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 5 Mar 2018 16:10:07 -0800 (PST)
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Mar 2018 07:10:07 +0700
Message-ID: <CACsJy8BySv+EWSY8-Uwzf3o14dP8NdpcPTa7Bh2c2wtJ3jny1w@mail.gmail.com>
Subject: Re: [PATCH/RFC 1/1] gc --auto: exclude the largest giant pack in
 low-memory config
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 5, 2018 at 9:00 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Mar 01 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy jotted:
>
>> pack-objects could be a big memory hog especially on large repos,
>> everybody knows that. The suggestion to stick a .keep file on the
>> largest pack to avoid this problem is also known for a long time.
>>
>> Let's do the suggestion automatically instead of waiting for people to
>> come to Git mailing list and get the advice. When a certain condition
>> is met, gc --auto create a .keep file temporary before repack is run,
>> then remove it afterward.
>>
>> gc --auto does this based on an estimation of pack-objects memory
>> usage and whether that fits in one third of system memory (the
>> assumption here is for desktop environment where there are many other
>> applications running).
>>
>> Since the estimation may be inaccurate and that 1/3 threshold is
>> arbitrary, give the user a finer control over this mechanism as well:
>> if the largest pack is larger than gc.bigPackThreshold, it's kept.
>
> This is very promising. Saves lots of memory on my ad-hoc testing of
> adding a *.keep file on an in-house repo.

The good news for you is when we run external rev-list on top of this,
memory consumption seems even better (and I think even peak memory
should be a bit lower too, but I'll need to verify that).

>> +     if (big_pack_threshold)
>> +             return pack->pack_size >=3D big_pack_threshold;
>> +
>> +     /* First we have to scan through at least one pack */
>> +     mem_want =3D pack->pack_size + pack->index_size;
>> +     /* then pack-objects needs lots more for book keeping */
>> +     mem_want +=3D sizeof(struct object_entry) * nr_objects;
>> +     /*
>> +      * internal rev-list --all --objects takes up some memory too,
>> +      * let's say half of it is for blobs
>> +      */
>> +     mem_want +=3D sizeof(struct blob) * nr_objects / 2;
>> +     /*
>> +      * and the other half is for trees (commits and tags are
>> +      * usually insignificant)
>> +      */
>> +     mem_want +=3D sizeof(struct tree) * nr_objects / 2;
>> +     /* and then obj_hash[], underestimated in fact */
>> +     mem_want +=3D sizeof(struct object *) * nr_objects;
>> +     /*
>> +      * read_sha1_file() (either at delta calculation phase, or
>> +      * writing phase) also fills up the delta base cache
>> +      */
>> +     mem_want +=3D delta_base_cache_limit;
>> +     /* and of course pack-objects has its own delta cache */
>> +     mem_want +=3D max_delta_cache_size;
>
> I'm not familiar enough with this part to say, but isn't this assuming a
> lot about the distribution of objects in a way that will cause is not to
> repack in some pathological cases?

Yeah this assumes a "normal" case. When the estimation is really off,
either we exclude the base pack or repack everything unnecessarily,
but we always repack. A wrong decision here can only affect
performance, not correctness.

There's one case I probably should address though. This "exclude the
base pack" will create two packs in the end, one big and one small.
But if the second pack is getting as big as the first one, it's time
we merge both into one.

> Probably worth documenting...
>
>> +     /* Only allow 1/3 of memory for pack-objects */
>> +     mem_have =3D total_ram() / 3;
>
> Would be great to have this be a configurable variable, so you could set
> it to e.g. 33% (like here), 50% etc.

Hmm.. isn't gc.bigPackThreshold enough? I mean in a controlled
environment, you probably already know how much ram is available, and
much of this estimation is based on pack size (well the number of
objects in the pack) anyway, you could avoid all this heuristics by
saying "when the base pack is larger than 1GB, always exclude it in
repack". This estimation should only needed when people do not
configure anything (and still expect reasonable defaults). Or when you
plan multiple 'gc' runs on the same machine?
--=20
Duy
