Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7125AECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 18:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiHaSFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiHaSFb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 14:05:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638E0357DA
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 11:05:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w5so3126638wrn.12
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=KW0ZTbYeJFvhuzlRW1blCvnaSr7MnJ1vxDMcdjdKdJk=;
        b=NbzMQi/SaQXI2DnRJ8VRVN7926Md76y/w+1yrGm+X3d3TgpDdPj8GtLaPfBJWJdcWM
         KhmrEx3TP7a4+i2uF5VMcqfQBWzAQOllprRmg8+7VuBxwsEXskE0tin7zLU2mTCEZgGI
         ofSUiepc6RQ7BqMHQCLBWpq2nVMCxPyQSSbpMtxXhUyFRoBR3ejTkl5XZ2WsE7saUrwB
         kQtaxBEzug8b4Cc9n5ujNR8mB7Wz2krxI5Y5XwfTnBjYx7gbFifws5ru14AF6qZ9xRQV
         nb7GUqVvEEldgbnoCypi1a+aoMax36EnUeUc55hiPgh8ybWks/ApAEeMT2MkkzkjNGYc
         4Dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=KW0ZTbYeJFvhuzlRW1blCvnaSr7MnJ1vxDMcdjdKdJk=;
        b=2rksoVqcw7iPfzzLVOopgiaEcabQTlr4E0imQntsvfI9uc8aJer6lpiZDOMeLP5x8u
         KbPw0VrB+AK49KYi8MM3eAtTXmMTCtVA5n5Ao1c5zl33qFfml+z+xKIQXmjx843/FOBW
         trmix+zFeiQjRIiV9hXD8raxvIY2bUdn0FzgpiNK4DPWGFF+I36PENRbyA1nxkAr9um8
         Oduu/765azszlA+ro3nayndQanUWwmQfgyLLKPHk9k0XZZ7t7y/toG4UnTdC6So7ZcvM
         FoXt2EaBGS21E0ZIORD1o5JURbXINn7O/0+bCijrdIEYkTPP//rM4cnvcYugHY+uUrOe
         l5AA==
X-Gm-Message-State: ACgBeo1pL85uTV2Bow8ANB7F1ryjG93l53iMwHjNRFLKnLRWrkKfR/FM
        AuNMnIKmR+eo8aHgaf9ggNRQaQ8aDis=
X-Google-Smtp-Source: AA6agR6T9KigtdRtQri0AbV1f2Te6psy7MuzttuljGg+1exGMxEg89vs6i1PSNojexmAQCu+ZinWig==
X-Received: by 2002:a05:6000:1541:b0:222:cf65:18d7 with SMTP id 1-20020a056000154100b00222cf6518d7mr12265329wry.659.1661969128768;
        Wed, 31 Aug 2022 11:05:28 -0700 (PDT)
Received: from localhost (62-165-236-110.pool.digikabel.hu. [62.165.236.110])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b00226d473ebd6sm11158844wrs.86.2022.08.31.11.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:05:28 -0700 (PDT)
Date:   Wed, 31 Aug 2022 20:05:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
Message-ID: <20220831180526.GA1802@szeder.dev>
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
 <xmqqwnax438x.fsf@gitster.g>
 <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
 <xmqqfshl3pbp.fsf@gitster.g>
 <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
 <Ywh6v8oo3nRl/O5h@coredump.intra.peff.net>
 <xmqqczcnymtd.fsf@gitster.g>
 <20220831084403.GA13663@szeder.dev>
 <220831.867d2oa95p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220831.867d2oa95p.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2022 at 02:13:51PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Aug 31 2022, SZEDER Gábor wrote:
> 
> > On Fri, Aug 26, 2022 at 09:46:54AM -0700, Junio C Hamano wrote:
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> >> But the fix here isn't to delete unused.cocci, but to hold off on the
> >> >> UNUSEwork D() patches until we figure out how to make coccinelle jive with
> >> >> them.
> >> >
> >> > Yeah, my general skepticism and disappointment above notwithstanding,
> >> > this seems like the best path forward from here. I tried a few other
> >> > tricks (like --macro-file and --iso-file), but if its parser chokes, I
> >> > don't think there's much we can do about it. Even if we wrote a patch to
> >> > coccinelle itself (and I have no interest in doing that myself), it
> >> > would take a while to become available.
> >> 
> >> If it is just a single unused.cocci, I would actually think removing
> >> it would be a much better path forward.  UNUSED() that renames to
> >> help folks without checking compilers would help noticing bad code
> >> much earlier than unused.cocci many contributors are not running
> >> themselves anyway.
> >
> > Here is another reason for the removal of 'unused.cocci': it's very
> > costly to apply that semantic patch to the whole code base.
> >
> >   make SPATCH_BATCH_SIZE=32 contrib/coccinelle/unused.cocci.patch
> >
> > takes 440s on my machine, whereas the second slowest 'object_id.cocci'
> > takes only 56s [1].  Applying 'unused.cocci' to some of our source files
> > individually takes well over a minute:
> >
> >   $ time spatch --all-includes --sp-file contrib/coccinelle/unused.cocci builtin/log.c
> >   warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
> >   warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
> >   HANDLING: builtin/log.c
> >   Note: processing took    83.1s: builtin/log.c
> >   
> >   real	1m23.083s
> >   user	1m22.983s
> 
> If you remove the "done:" line in cmd_format_patch() buiiltin/log.c runs
> in ~200ms instead of ~40s for me. Perhaps we should be discussing
> removing or refactoring that one line of code instead? :)
> 
> Removing coccinelle rules because we're seeing slowness somewhere seems
> particularly short-sighted to me.

It's not just slowness, it's drastic slowness.  I'm looking at two
"from scratch" 'make coccicheck' runs here, one with 'unused.cocci'
taking 9m51s, one without taking 4m56s.  So 'unused.cocci' effectively
doubled the runtime, and wastes other developers' time and resources.

I don't see anything wrong with removing a semantic patch that is as
slow as 'unused.cocci' in its current form on our current codebase.
We can always re-add it later, after those interested managed to
figure out a way to address its slowness, and updated the semantic
patch and/or the codebase accordingly.

> Maybe we do run into intractable problems somewhere with it being slow,

Looking at the runtimes I showed above, I think deeming it intractable
is fully justified.

> and we'd also like to cater to more "interactive" use.
> 
> But we shouldn't do that by removing rules until we get below some
> runtime limit, but rather by creating a "batch" category or something
> (just like we have "pending") now.
> 
> Or, just actually look into why it's slow and fix those issues and/or
> report them upstream.

IMO this should be the other way around: if applying a semantic patch
is this slow, then first look into why it's slow, fix it, and only
then submit it for merging.  A semantic patch this slow shouldn't have
been merged in the first place.

> There's nothing in unused.cocci that we either aren't running into
> elsewhere, or wouldn't run into if we had 10x the coccinelle rules we
> have now (which I think would be a good direction, we should rely on it
> more heavily).

Several developers have already stated that they might run 'make
coccicheck' more often if it weren't so slow.  I think we must keep
this in mind when adding new semantic patches, and should aim for a
good return of investment between the usefulness of the semantic patch
and its overhead.  'unused.cocci' doesn't seem to strike a good
balance here.

I doubt that I would ever run 'make coccicheck' if we had 10x as many
semantic patches.

> I've found that being able to have a ccache-like tool for "spatch"[1]
> solved almost all of the practical performance concerns I had with
> it. I.e. I can just run things in a batch, and usually any interactive
> use will hit things already in cache.

Well, perhaps that's why you didn't notice just how slow
'unused.cocci' can be... :)  Please don't forget about the runtime of
a default "from scratch" 'make coccicheck'.

> To the extent it doesn't it's usually some pathological issue in spatch.
> 
> >   sys	0m0.033s
> >   $ time spatch --all-includes --sp-file contrib/coccinelle/unused.cocci builtin/rebase.c 
> >   warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
> >   warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
> >   HANDLING: builtin/rebase.c
> >   Note: processing took    83.2s: builtin/rebase.c
> >   
> >   real	1m23.223s
> >   user	1m23.156s
> >   sys	0m0.017s
> 
> I didn't look at this one, but I assume it's some similar (and probably
> easily fixed) pathological issue.
> 
> 1. https://lore.kernel.org/git/patch-5.5-ce4734e5d79-20220825T141212Z-avarab@gmail.com/
