Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D8CC07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 07:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F8160241
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 07:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhGUG5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 02:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbhGUG5W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 02:57:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922EBC061574
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 00:37:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t2so1157007edd.13
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 00:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=g11Glg2o7mAbglLlDHPIBfT+tbtX1hjEBOkWb0Ij5HI=;
        b=YuvecYljCg9B3d/siSE+Oo6gL/WQBUXJMpGv1Ff0xLPfBGT9RScs1WDuQq+LLeRB/p
         877BpDIzjgk9oh1h6UVUahBLC+8czAMUpBhFmsfp7l2OXgqcvnJyTD1HKWW3cblPFxuP
         JjXHPwzKLO7U9Y4XwZyzLXNKix4gXKq4khC/0/C6de6ZVCQ5bS8m9rJODR95a8ndTOJf
         w+6KapZwNCsNyqEvcz3IQ24zzY5idEA2wJbkhlHtglfAh0Hr9jZA1oCM5RC5n1QCmsd4
         7pR1631M0+Zq6pWTCSVtPTiOZZNG8W/ytP5ysaVaGugnltVv5q3i3ogYNKW7k0xoxrvV
         DFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=g11Glg2o7mAbglLlDHPIBfT+tbtX1hjEBOkWb0Ij5HI=;
        b=O+amM/Weg1SDA3JOK+hXUSm5wuIa3jcJ9Dl7N5nWOqsyx0gmS7zbw0+ONX7rJQpxq9
         Tl70INXbLlTR1zx/MslbrXJc3HJ3PfwXmQ9xeo42kdQOvZwOF7KhXNlP70Q86R4jkBd6
         l9aGAJdYo/qijNDGnXsGjrV0jHBOJKFHd7cYo4Dknk/wETKUGeDFbMBemis3p+Azxx8y
         YaE0Lxym2UeBF0pbcsVGQ3nid+Qfhl9i+OcEhuCX9Uuu8nC8qT/F2tMhWNjyfBgqUSA0
         KsHymkwJQCplxeTXjSa0vdKB7KomvflCMGjyJFIoLpwvY/SDWyjd/4GsQvNWeiNeB4v3
         XKEQ==
X-Gm-Message-State: AOAM531+uk1s7IMmgAsMQJQxx3eRDRUuw5IsDIoO/ob8ML4B2t6u9nwz
        qdLd/4Hda4o5BviJexkFZD0=
X-Google-Smtp-Source: ABdhPJytmfk3wzahCI+86y0FJnXmfB0f1ViXkFMfEU3V2ln4btftYDthYRODWKUC/LahACfyItTZ8w==
X-Received: by 2002:a05:6402:17c4:: with SMTP id s4mr6540569edy.101.1626853077089;
        Wed, 21 Jul 2021 00:37:57 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d3sm10389048edp.11.2021.07.21.00.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 00:37:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 6/6] commit-graph: show usage on "commit-graph
 [write|verify] garbage"
Date:   Wed, 21 Jul 2021 09:26:38 +0200
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
 <patch-6.6-5c1694e071e-20210720T113707Z-avarab@gmail.com>
 <20210720174739.GA2025@szeder.dev> <20210720175530.GA23408@szeder.dev>
 <YPcU3LSpa/r5nFCP@nand.local> <87lf60vfyn.fsf@evledraar.gmail.com>
 <YPdEeBGi3RVrB/fu@nand.local>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPdEeBGi3RVrB/fu@nand.local>
Message-ID: <87im14unfd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 20 2021, Taylor Blau wrote:

> On Tue, Jul 20, 2021 at 11:17:13PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> > So we should definitely fix this instance via a reroll of this series,
>> > but that still leaves the others up for grabs. =C3=86var, are those (t=
he ones
>> > in the 'multi-pack-index' and 'env--helper' builtins) something that y=
ou
>> > want to clean up while you're working in this area, or would you rather
>> > that I take care of it?
>> >
>> > I don't mind either way, just want to make sure that we don't duplicate
>> > effort.
>>
>> I'm all for you picking it up :)
>>
>> If you wanted to pick up these patches (or some of them) and
>> partially/entirely replace this series I'd be happy with that too,
>> i.e. if it makes conflicts etc. easier.
>
> I think either is fine; there shouldn't be any conflicts in the
> multi-pack-index code just eyeballing based on what you wrote.
>
> I started working on it (which I suppose can count for me volunteering
> to patch it up myself ;-)), but I wondered why we have env--helper at
> all. When you wrote it back in b4f207f339 (env--helper: new undocumented
> builtin wrapping git_env_*(), 2019-06-21), you said that it wasn't added
> as a test-tool because it had some uses outside of tests.
>
> But I can't find any locations. We do use env--helper (via
> test_bool_env, which you also introduced) in a couple of t/lib-*.sh

FWIW test_bool_env is SZEDER'S, see 43a2afee82a (tests: add
'test_bool_env' to catch non-bool GIT_TEST_* values, 2019-11-22).

> files, but this would be far from the first test-tool that has been used
> in a test library.
>
> So ISTM that this could be converted to a test-tool and removed from the
> list of builtins. *And* we could do that without a deprecation warning,
> because it was never documented in the first place.
>
> Can you double check my thinking and/or let me know if there is a
> compelling reason to keep it as a builtin?

Unlike the test-tools it was used by installed git, namely
git-sh-i18n.sh before d162b25f956 (tests: remove support for
GIT_TEST_GETTEXT_POISON, 2021-01-20), but yes, now it could just be
migrated to a test-tool.

I suppose it never really *needed* to be a built-in, i.e. the
git-sh-i18n.sh code could have just died without the helper if
GIT_TEST_GETTEXT_POISON was set, anyway...

...yes, nowadays it can simply be moved to t/helper.

<digression>

I do think in general this recent proliferation of t/helper over new
plumbing built-ins has sent git a bit in the wrong direction.

E.g. I think the likes of t/helper/test-pkt-line.c should really be a
plumbing tool, the same goes for many (but not all) the test tool, we
could just document them as being "unstable plumbing" or whatever.

But I think I've been losing that argument recently, e.g. after [1]
(which I argued we should put into git-ls-files) even things like git's
basic idea of the state of the index are exposed in some helpers, but
not corresponding plumbing.

Anyway, even if we assume that's an argument that would carry the day in
general I'd find it hard to justify git-env--helper being a thing that
should be exposed to users or post-"make install", it's purely for the
use of our own test suite.

</digression>


So yeah, it can just be moved to t/helper if you want to do that.

>> I just re-submitted this now because it's been staring at me in my
>> "should re-roll at somep point" list for a while...
>>
>> FWIW if you're poking at this area more generally we really could do
>> with some standardization around these built-in sub-commands:
>>
>>     git built-in --here subcommand
>>     git built-in subcommand --or-here
>
> That's probably a step too far for this loose end for me, so if you want
> to work on that please be my guest, but I probably don't have time for
> it in the near future.

*nod*, but just to be clear, were you going to pick up &
re-roll/re-submit the patches I have in this series? That would be good
or me, but I don't mind either way, just wondering what state this
should be on my TODO list.

1. https://lore.kernel.org/git/a1b8135c0fc890b2c2c0271c923b2f8efa8d1465.161=
7109864.git.gitgitgadget@gmail.com/
