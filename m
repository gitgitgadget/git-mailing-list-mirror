Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3FE1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 10:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeKITvy (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 14:51:54 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:36188 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeKITvy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 14:51:54 -0500
Received: by mail-wm1-f48.google.com with SMTP id v70-v6so967632wmd.1
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 02:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JSVLairJipMwAEe6UeO0dgzyIOmInfj8c+4iO48HKe4=;
        b=T6GpktRIZK+FRI++HweBzX1nxqMJLpXY4ffYIQdt88g/TPpNdyd949+Y507sB5IuWx
         ADrb1qjd9VcJe73kuUdSpypE61wqwA0enXXx5vYTczkbzlw90VEMhhFLHIPvODA4508a
         uenwCgXSUjdQ8QW4jQHfyrZxZJSX2jq9Zzo/sqqL8i0BRBx19IgxGXpIQp3aWL1E/gAM
         e9a54fJP2zhJQvWo971uiXBO3LfStO3S7qH6RjsHHm9Vx37jMdD4KU0bw3XNCtCDUFle
         VZfOjgTgXhUOve4UgAfgxsCPb3Dzx8UK9GLyjZeNTjkI71b08DDTV/UQFk/jHPW617f0
         pHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JSVLairJipMwAEe6UeO0dgzyIOmInfj8c+4iO48HKe4=;
        b=UYTtioZ814M/i88UqjynGa3ppjbULu5e2EH5vVSVAn7e7CLAn7kz3K37zZXLc0Ar3Q
         DxNZwK0l2PYtJX0w0U2w2O/3JQ3s4BL3VmsNkT7OhYxlaFRo4IXDd8a26Kf4ShQz/86j
         eJ4SNbp4UXNjh9P4YfTjU9RlYuz/Ed2cXz5VZGUpt0y3GecVajcoUA4aEtmv5N4s/rhR
         7TYjfAWXt9Ls6S7K428MHffV6LXU2i3mXleZK3bvlJ7Q3XWKKJDphQWit6aIsTki+Q8G
         znsfaE4Ol+heYdE7DHaNpVyBUpsO3rkzgyDvgqhoDkTvP5AHpcPN1cmdxfIOByO55BVe
         RlRw==
X-Gm-Message-State: AGRZ1gKkQ2eGfWmxpO2RzC2g/dI/i9M8vJ/Cw+LwS4pdGB9uSakqhpuq
        /84fqfxBzQKOHs5tPPQSF3g0oxmLyXI=
X-Google-Smtp-Source: AJdET5esz5V+j1/8u70V9rcR1GxStfsYNt8xt9YVhB3GW5+qb/KSnCI2loMB61D3r3JIkQhNbZ7WtA==
X-Received: by 2002:a1c:3288:: with SMTP id y130-v6mr4118634wmy.11.1541758317945;
        Fri, 09 Nov 2018 02:11:57 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id 66-v6sm1007109wmp.28.2018.11.09.02.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 02:11:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
        <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
        <87o9bgl9yl.fsf@evledraar.gmail.com>
        <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
        <20181027093300.GA23974@sigill.intra.peff.net>
        <87lg6jljmf.fsf@evledraar.gmail.com>
        <20181029150453.GH17668@sigill.intra.peff.net>
        <87bm7clf4o.fsf@evledraar.gmail.com>
        <20181029232738.GC24557@sigill.intra.peff.net>
        <20181107225524.GA119693@amazon.com>
        <20181108120256.GA29432@sigill.intra.peff.net>
        <87lg635hz4.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87lg635hz4.fsf@evledraar.gmail.com>
Date:   Fri, 09 Nov 2018 11:11:55 +0100
Message-ID: <87h8gq5zmc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 08 2018, Ævar Arnfjörð Bjarmason wrote:

> On Thu, Nov 08 2018, Jeff King wrote:
>
>> On Wed, Nov 07, 2018 at 10:55:24PM +0000, Geert Jansen wrote:
>>
>>> On Mon, Oct 29, 2018 at 07:27:39PM -0400, Jeff King wrote:
>>>
>>> > On Mon, Oct 29, 2018 at 08:36:07PM +0100, Ævar Arnfjörð Bjarmason wrote:
>>> > >  * Re-roll my 4 patch series to include the patch you have in
>>> > >    <20181027093300.GA23974@sigill.intra.peff.net>
>>> >
>>> > I don't think it's quite ready for inclusion as-is. I hope to brush it
>>> > up a bit, but I have quite a backlog of stuff to review, as well.
>>>
>>> We're still quite keen to get this patch included. Is there anything I can do
>>> to help?
>>
>> Yes, testing and review. :)
>>
>> I won't send the series out just yet, as I suspect it could use another
>> read-through on my part. But if you want to peek at it or try some
>> timings, it's available at:
>>
>>   https://github.com/peff/git jk/loose-cache
>
> Just a comment on this from the series:
>
>     Note that it is possible for this to actually be _slower_. We'll do a
>     full readdir() to fill the cache, so if you have a very large number of
>     loose objects and a very small number of lookups, that readdir() may end
>     up more expensive.
>
>     In practice, though, having a large number of loose objects is already a
>     performance problem, which should be fixed by repacking or pruning via
>     git-gc. So on balance, this should be a good tradeoff.
>
> Our biggest repo has a very large number of loose objects at any given
> time, but the vast majority of these are because gc *is* happening very
> frequently and the default expiry policy of 2wks is in effect.
>
> Having a large number of loose objects is not per-se a performance
> problem.
>
> It's a problem if you end up "faulting" to from packs to the loose
> object directory a lot because those objects are still reachable, but if
> they're not reachable that number can grow very large if your ref churn
> is large (so lots of expired loose object production).
>
> Anyway, the series per-se looks good to me. It's particularly nice to
> have some of the ODB cleanup + cleanup in fetch-pack.c
>
> Just wanted to note that in our default (reasonable) config we do
> produce scenarios where this change can still be somewhat pathological,
> so I'm still interested in disabling it entirely given the
> implausibility of what it's guarding against.

Some actual numbers for this for a fairly small repo on NFS, "cold"
cache (hadn't run it in a bit):

    $ time (find objects/?? -type f|wc -l)
    862
    real    0m1.927s

Warm cache:

    $ time (find objects/?? -type f|wc -l)
    872
    real    0m0.151s

Cold cache on a bigger monorepo:

    $ time (find objects/?? -type f|wc -l)
    real    0m4.336s

Warm cache on a bigger monorepo (more ref churn):

    $ time (find objects/?? -type f|wc -l)
    49746
    real    0m1.082s

This on a server where bulk sustained writes of large files are really
fast (up to 1GB/s). It's just these metadata ops that are slow.

I also get cold cache times of up to 6 seconds on:

    time (find $(ls -d objects/??|sort -R) -type f | wc -l)

As opposed max of ~4s without -R, so I suspect there may be some
client/server optimization where things are iterated over in recursive
glob order (pre-fetched?), whereas the cache will try to fill buckets is
it encounters loose objects, so iterate over objects/{00..ff} randomly.

I'm not really leading up to any point here I haven't made already. I
was just curious to try to find some upper bound of overhead if say a
pack with 512 objects is pushed. In that case it's very likely that we
need to fill at least 200/256 buckets.
