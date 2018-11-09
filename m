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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3A21F453
	for <e@80x24.org>; Fri,  9 Nov 2018 13:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeKIXYj (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 18:24:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51734 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeKIXYi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 18:24:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so2074123wmc.1
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 05:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=aQkHrwDKI71f5VcukQsBcpp91/NDpn3sGrudrmAC6dE=;
        b=VwUfoUT7w4kueID+7rycZwIcKJZcOmRMoUgBfcd9URIIOLgBNT1VryqTIiXf8V9BAQ
         uiFk3i/hoobvQ5a9ZekZrFu+zWDdNMMAvsA+R7dtggRBSyz1XyHZZlNp0WFPi4e/gIQI
         EG8TwmbJ0jlsCzJGRETVct7UzVNckII/k60ZBOLx7ysN2vK/PIlfuGlDRtF/k+DHClW1
         RWOJTpMhoAGRVZOqN50sdwiBtPAm23kuwgjRUwUq17ybUDEWTre1BefDC0TEhgTDQUFF
         JbzWfiqb/zCWIcCYZjOOUtgxQ9rs7cMD1xRTCsUCsnQtLsGaI55qQNEzmYc1vyuRX/C8
         V7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=aQkHrwDKI71f5VcukQsBcpp91/NDpn3sGrudrmAC6dE=;
        b=luW1FHwpM1L8G8NwX/VFmygj/6kT2I/hb0g02EK/038JE9kxLUKGeyxgyRIS+cwZAO
         vgStVKy6i1Am/tBo8SGBqrqHIJSbqLRPGd927TQMQWHAdqqHcg/OKaobEhAdu0nHFGan
         38ByJKGdAJ9l6JJI9My8xFoDRA78Q5mdOOYlN/yX/nrdwlqMC+QBHvZkQ5NMuD35OGoc
         uYxDfxSqLKIIs2B3oYnDZ4N1p4JxsEX3QwzwEFcn1CAGeAhHZSXTggdGCjTPEP5J2sP+
         sP+b3I08yZMs/wEozF/BsZJBcdhumBPDr8Fm+ozD7OSybU6O4fc79jAP5hfZb+u21wpH
         E3Sw==
X-Gm-Message-State: AGRZ1gL8ODbkIwANWA6tr9R0nE5rc+gtZjT5B30X02kORjVt7XASGWSd
        z/vSP0G51QvQ1xQid7PDLEg=
X-Google-Smtp-Source: AJdET5daetxjonfK11Vvs7HiEu5iJWQefb3vJgvWEW3xpVGKyvV0o6ahuSVdrPiaE3CCaTUxM8gNUw==
X-Received: by 2002:a1c:f712:: with SMTP id v18-v6mr4764053wmh.48.1541771035508;
        Fri, 09 Nov 2018 05:43:55 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id x11-v6sm1038043wmg.14.2018.11.09.05.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 05:43:54 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     Jeff King <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
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
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181107225524.GA119693@amazon.com>
Date:   Fri, 09 Nov 2018 14:43:52 +0100
Message-ID: <87d0re5pt3.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 07 2018, Geert Jansen wrote:

> On Mon, Oct 29, 2018 at 07:27:39PM -0400, Jeff King wrote:
>
>> On Mon, Oct 29, 2018 at 08:36:07PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> >  * Re-roll my 4 patch series to include the patch you have in
>> >    <20181027093300.GA23974@sigill.intra.peff.net>
>>
>> I don't think it's quite ready for inclusion as-is. I hope to brush it
>> up a bit, but I have quite a backlog of stuff to review, as well.
>
> We're still quite keen to get this patch included. Is there anything I can do
> to help?
>
> Also I just re-read your comments on maximum cache size. I think you were
> arguing both sides of the equation and I wasn't sure where you'd ended up. :)
> A larger cache size potentially takes more time to fill up especially on NFS
> while a smaller cache size obviously would less effective. That said a small
> cache is still effective for the "clone" case where the repo is empty.
>
> It also occurred to me that as a performance optimization your patch could read
> the the loose object directories in parallel using a thread pool. At least on
> Amazon EFS this should result in al almost linear performance increase. I'm not
> sure how much this would help for local file systems. In any case this may be
> best done as a follow-up patch (that I'd be happy to volunteer for).

I'm planning to re-submit mine with some minor changes after the great
Documentation/config* move lands.

As noted in
https://public-inbox.org/git/87bm7clf4o.fsf@evledraar.gmail.com/ and
https://public-inbox.org/git/87h8gq5zmc.fsf@evledraar.gmail.com/ I think
it's regardless of Jeff's optimization is. O(nothing) is always faster
than O(something), particularly (as explained in that E-Mail) on NFS.

You didn't answer my question in
https://public-inbox.org/git/20181030024925.GC8325@amazon.com/ about
whether for your purposes you're interested in this for something where
it needs to work out of the box on some random Amazon's customer's
"git", or if it's something in-house and you just don't want to turn off
collision checking. That would be useful to know.

I've turned on core.checkCollisions=false in production at our
site. Cloning for some large repositories went from ~200 minutes to ~5m,
and some pushes from ~5 minutes to ~10 seconds. Those numbers will be
very similar (but slightly higher, maybe 1-5 seconds higher in the
latter case) with Jeff's (depending on the push).
