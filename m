Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CA9C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BF621D7E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OspTIdXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLTRAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:00:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46786 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfLTRAx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:00:53 -0500
Received: by mail-ot1-f65.google.com with SMTP id c22so12563506otj.13
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBQNdUz7lXQqP9MQNfuyuoqcb1ygmcN52Y6XY0vIC1Y=;
        b=OspTIdXqejzMzwzdmKc8OC4dF8ZU4zup7Z/3NeB0m3g9RjFByUPgNZN9+1unYIg+5u
         WzEqoPFSxi1f9V0tDmYxUuZuK5uz1WY0PsxwY/YFygeD2TipnndPcBWemWxilxUQq33p
         AdNO+y9ct58/GSImj+hqV1j3RM4afKziirO5hCa1McuGovIaGzUuRVzndTp2EcwhftIz
         m2KcrD6Tuv+Ra/cVgWjpW0hF9wRI3qHDs/6LohwDBMbGtf1VR7adCQU2/5QUWH1kXKi+
         092LV8QCDwQkcDupWBo/mui4oS4Ko3zMbSLc9l6pCB2APWcc1Kexls1xhChkSpNK9mTi
         K1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBQNdUz7lXQqP9MQNfuyuoqcb1ygmcN52Y6XY0vIC1Y=;
        b=EcylK2i+f2c1noOJkmb61fZJqEsNK/5cZXiLdntEweC0Ia47PNYVtMPi5uq0vCTYQw
         hBSXhph2DQ+tT7blk26a0sdFlVWUGau8I4L1XQUWam1TGaNPAVFkQPmBe7PdO0gub1a1
         Yqp3d48y9DxTFSGC7xOoezPYfLIGV/fIgdjnbr1oAjueE6QylSmuw2Pu4Wb0yNHN6t4m
         drT5+gNX9EiDm2ILFIM/nOp8+XQeHaO0acjNRKm2uM6y5k9jgVuj+9rs/VePJKyqcKrU
         FBirVAuiRd/4zDxcSFGfTSFgmwfwSt8Dy2wb2hUqDxuaXwmpZKPQnJdjszauTST5oFAn
         h/Tw==
X-Gm-Message-State: APjAAAXH1gN9l4KijhAhOjJy9s5OyYMQu83D40zFTADuhWSh6QhJHb9q
        J0n3PiX4j4ZaP7biIBNDhAlI69HC5car2a3KEmA=
X-Google-Smtp-Source: APXvYqzNg8gZXwSxpXdxY+7fn29G/aYuIonm5uRCJp8+NTLfstBEUk0hp3Tiwj/aveHsYZ28x8WTu7Tn69WzdESVGL4=
X-Received: by 2002:a9d:7d81:: with SMTP id j1mr10561857otn.267.1576861251696;
 Fri, 20 Dec 2019 09:00:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
 <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com> <1f3978aa461929923eeb5037e69be6569f0ba331.1576697386.git.gitgitgadget@gmail.com>
 <xmqq1rt1e30q.fsf@gitster-ct.c.googlers.com> <CABPp-BHhAPjL9daPdp7UmVT+vLrcpo6SX0rKt5s1bH4Vz31wxw@mail.gmail.com>
 <20191219222403.GA705525@coredump.intra.peff.net>
In-Reply-To: <20191219222403.GA705525@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Dec 2019 09:00:40 -0800
Message-ID: <CABPp-BEe7=LfR5KJriu1Lq-v5SVET-zm3GK3ZPjOYuLHrxqimg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] dir: fix checks on common prefix directory
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, Dec 19, 2019 at 2:24 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Dec 19, 2019 at 12:23:29PM -0800, Elijah Newren wrote:
>
> > > >       while (len && path[len - 1] == '/')
> > > >               len--;
> > > >       if (!len)
> > > >               return 1;
> > > > +
> > > > +     de = xcalloc(1, sizeof(struct dirent)+len+1);
> > >
> > > That "+len+1" may deserve a comment?
> >
> > Good point, I'll add one and send a re-roll.
>
> Please use st_add3() while you are at it.

I would, but Junio already took the patches and applied them to next
already.  (I am curious, though, why we're worried about overflow in a
context like this?)

> I'd also usually suggest FLEX_ALLOC_MEM() for even more simplicity, but
> it looks like filling the string is handled separately (and done many
> times).

Yes, the string is handled separately; I don't manufacture a dirent
per leading directory component of the common prefix, but just
allocate one and re-use it.

> I have to wonder, though, if it wouldn't be simpler to move away from
> "struct dirent" here (and it looks like Junio suggested the same earlier
> in the thread). I don't know this code very well, but it looks
> like it could easily get by passing around a name pointer and a dtype
> through the cached_dir. The patch below seems like it's not too bad a
> cleanup, but possibly the names could be better.

This was mentioned twice upthread, first by me then by Junio (and I'll
include my final response too):

>>> I need to manufacture a dirent myself; short of that, the most
>>> likely alternative is to drop patches 2 & 5-8 of this series and
>>> throw my hands in the air and give up.
>>> ...
>>> It'd be an awful lot of work to rip [dirent] out...unless someone
>>> else has some bright ideas about something clever we can do, then I
>>> think this problem blows up in complexity to a level where I don't
>>> think it's worth addressing.
>>> ...
>>> Any bright ideas about what to do here?
>>
>> Restructuring the code so that we do not use "struct dirent" in the
>> first place, even in the original code that used only those obtained
>> from readdir(), perhaps?
>
> Okay, I'll submit a new series dropping most the patches.

It's possible I vastly overestimated how much work ripping out the
dirent would be; I mean I've mis-estimated absolutely everything in
dir.c and assumed each "little" thing would all be a small amount of
work, so maybe I'm just swinging the pendulum too far the other way.
But, although I think this alternative would be the cleanest, I saw a
couple things that looked like this was going to turn into a huge can
of worms when I started to peek at what it all touched.  I'd be happy
for someone to take this route, but it won't be me (see also
https://lore.kernel.org/git/CABPp-BEkX9cH1=r3dJ4WLzcJKVcF-KpGUkshL34MMp3Xhhhpuw@mail.gmail.com/).

Elijah
