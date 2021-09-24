Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678A2C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 01:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4619C61100
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 01:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbhIXB1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 21:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXB1m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 21:27:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A3BC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 18:26:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v22so29083927edd.11
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 18:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6jIFM9gxIOb/YO22NX5geKbZklVRLU1lee/ixAnpjuk=;
        b=oZD5/HnkoR5TUQdYqvaLt6031FoiUBimnTGGMSLn3Pc0npNpODCvkOVR3K6rMkbDVc
         /dHSdnxBUmbNSmeeiDv/ADr2deH8GqMA5rhDPj6Acog1LVZHCtJBEJYacgrgwmWW52ZV
         eVq/vzatSJlwQ/BlhJCzr9oWNM1gdXs/seabZyUYZyu9GIsA1M9r3v3c6f/0yjI+NRAr
         YsYNWckggUEJHt72wsBwH3TNMKwOOpYkRph05T0XSsAvYZNo+hkHpfGJ7iWslrzHP7t6
         rXVOz9CosLYmYNUYNt8pbM8Z0STmlRy/0aREJVWYT4ANN3eB32K9tlobJu2+YeqLB2/r
         aerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6jIFM9gxIOb/YO22NX5geKbZklVRLU1lee/ixAnpjuk=;
        b=ExOPX9XDx1Znad1lA+e7UETpFUaLRC3owMk4Y9/742BGcA9gML1y/AzfkOSPlH5ew5
         aIHO62RLwLOsybdCgd7f9QEaCAxxk0hnKh931F9NOAjftaZkx2I+c/DLL7TQVXTJXsn1
         +LVw6gscglsYG0xXqavllyK84+xOipXVCGYFqw6LKN7f+LzbR0F4sh4kVLV9B6WiPepe
         KldT/ymmI7x57COk1+TAE0mj2i4Zju9a5Pzjed6SUDmtLm3BBfKkYLierzos3MmAnBR6
         nf0dwkQ2+sekWhA4BYUjbxfO1deCw2LSGGiTwaYYCHjU8iNt5Na8NlLgcO08qj9qBHY8
         nqcQ==
X-Gm-Message-State: AOAM533iQ9C0WeUeu8WYmTB7YhHIPQsOk/RGWLv5Y2P9qcumUnyAijfL
        9+CntRzM7iQyCJ8m9/LPJGI=
X-Google-Smtp-Source: ABdhPJxtGyCzT/1I2JlU1IvjeQG+9UhVmXih10+za+fXRhiYDcASIQsca3B42tOq+/kyhW0EiOSWNQ==
X-Received: by 2002:a50:954c:: with SMTP id v12mr2084749eda.313.1632446769022;
        Thu, 23 Sep 2021 18:26:09 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q19sm4959024edc.74.2021.09.23.18.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:26:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] Makefile: make the "sparse" target non-.PHONY
Date:   Fri, 24 Sep 2021 03:16:53 +0200
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
 <patch-v2-1.1-059829f2195-20210923T000654Z-avarab@gmail.com>
 <YUyqIpOLFDqG/kEJ@coredump.intra.peff.net> <xmqqtuib199x.fsf@gitster.g>
 <457ec039-1e26-9da9-55f6-9ea79b962bfe@ramsayjones.plus.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <457ec039-1e26-9da9-55f6-9ea79b962bfe@ramsayjones.plus.com>
Message-ID: <87a6k24vdc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 24 2021, Ramsay Jones wrote:

> On 23/09/2021 18:39, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>=20
>>> On Thu, Sep 23, 2021 at 02:07:16AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>>>
>>>> We ensure that the recursive dependencies are correct by depending on
>>>> the *.o file, which in turn will have correct dependencies by either
>>>> depending on all header files, or under
>>>> "COMPUTE_HEADER_DEPENDENCIES=3Dyes" the headers it needs.
>>>>
>>>> This means that a plain "make sparse" is much slower, as we'll now
>>>> need to make the *.o files just to create the *.sp files, but
>>>> incrementally creating the *.sp files is *much* faster and less
>>>> verbose, it thus becomes viable to run "sparse" along with "all" as
>>>> e.g. "git rebase --exec 'make all sparse'".
>>>
>>> OK. I think this solves the dependency issues sufficiently. It is a
>>> tradeoff that you must do the normal build in order to do the sparse
>>> check now. That is certainly fine for my workflow (I am building Git all
>>> the time, and only occasionally run "make sparse"). I don't know if
>>> others would like it less (e.g., if Ramsay is frequently running sparse
>>> checks without having just built).
>>>
>>> (I'd say "I do not care that much either way", but then I do not care
>>> all that much either way about incremental sparse checks either, so I'm
>>> not sure my opinion really matters).
>>=20
>> My build procedure runs "make sparse" before the primary build,
>> simply because the former tends to be much faster to fail when there
>> is an issue in the code.  I can understand that depending on .o is a
>> cheap way to piggyback on the dependencies it has, but my latency
>> will get much slower if this goes in _and_ I keep trying to pick up
>> potentially problematic patches from the list.
>
>
> I always run 'make sparse -k >sp-out 2>&1' after having done the main
> build, so that is not an issue for me. Note that I always send all
> output from each build step (for master, next and seen) to a series of
> (branch keyed) files, so that I can easily diff from branch to branch.
> Also, as above, I use '-k' on the 'sparse' and 'hdr-check' targets to
> collect all errors/warnings in one go.
>
> So, this evening, with the v2 version of =C3=86var's patch having landed =
in
> the 'seen' branch, we see this (abridged) diff between next and seen:
>
>   $ diff nsp-out ssp-out
>   77a78
>   >     SP hook.c
>   289a291
>   >     SP builtin/hook.c
>   417a420
>   >     SP t/helper/test-reftable.c
>   449a453,478
>   >     SP reftable/basics.c
> ...
>   >     SP reftable/tree_test.c
>   452a482,483
>   >     CC contrib/scalar/scalar.o
>   >     SP contrib/scalar/scalar.c
>   $=20
>
> So, this almost looks normal, except for the 'CC' line! Having discovered
> some leftover cruft from old builds yesterday:
>
>   $ git ls-files | grep contrib/scalar
>   contrib/scalar/.gitignore
>   contrib/scalar/Makefile
>   contrib/scalar/scalar.c
>   contrib/scalar/scalar.txt
>   contrib/scalar/t/Makefile
>   contrib/scalar/t/t9099-scalar.sh
>   $ ls contrib/scalar
>   Makefile  scalar.c  scalar.o  scalar.sp  scalar.txt  t/
>   $ rm contrib/scalar/scalar.{o,sp}
>   $ make
>       SUBDIR git-gui
>       SUBDIR gitk-git
>       SUBDIR templates
>   $ make sparse
>       CC contrib/scalar/scalar.o
>       SP contrib/scalar/scalar.c
>   $=20
>
> Hmm, interesting, but not relevant here. So, lets play a bit:
>
>   $ make sparse=20=20
>   $ make git.sp
>   $ make git.sp
>   $ touch git.sp
>   $ make git.sp
>   $ touch git.c
>   $ make git.sp
>       CC git.o
>       SP git.c
>   $ touch git.o
>   $ make git.sp
>       SP git.c
>   $=20
>
> Hmm, so I think it is working as designed. However, I find it to be
> more than a little irritating (curmudgeon alert!).

Specifically that there's now "SP" lines in the output, that *.sp files
are created at all, that they're created where they are, or some
combination of those thigs?

> Note there are currently no sparse warnings in any of the branches
> I build (mainly because Junio patches them up before they hit the
> git.kernel.org repo - I am not complaining! ;) ). However, should
> any warnings/errors appear (from my own development, say), then I
> would make extensive use of 'make <file>.sp' while fixing the
> problem. Prior to this patch series, 'make <file>.sp' would _always_
> run sparse over the file - it would not depend on the 'mtime' or
> existence of any other file, or run the compiler (and wouldn't leave
> any 'droppings' either). I liked that! :D
>
> So, I still don't quite get where the 'savings' come from - maybe it
> is just me, but I don't think this improves any workflow (well not
> mine anyway). I just don't get it. :(

The point is that you can now instead of:

    make -jN all

Just do:

    make -jN all sparse

And do those checks all the time, whether it's in your your normal
edit/compile/test cycle, or via "git rebase --exec", and not have it
take much longer than not having "sparse" there.

So I think you won't have any reason to run "make <file>.sp" anymore.
Why not just run "make all sparse"?

As long as you have any outstanding errors in a <file>.sp" you'll keep
getting just that relevant output, and once you fix the issue the
dependency is satisified.

Just like if you've got a compile error in say usage.c now you've got no
reason to stop running "make all" and start running "make usage.o", the
dependency graph makes it so that you'll get the right output via "make
all", and the added time from running the more general target is
trivial.
