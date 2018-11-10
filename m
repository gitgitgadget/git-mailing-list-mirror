Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C86D61F453
	for <e@80x24.org>; Sat, 10 Nov 2018 14:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbeKJXtr (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 18:49:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37125 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeKJXtq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 18:49:46 -0500
Received: by mail-ed1-f67.google.com with SMTP id y10-v6so3944911edr.4
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 06:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TX2Y16ZLogmzE47aVV2l5VK4r+MvvTzQaDvobBXxE0A=;
        b=nJuMBa9aQt0IX/Szka7YWrCog38+oVmwyzACP1/efT5kr9ur8cPETlt21sXV6Zt0IO
         tbk17tsH0K206S7ZT5zWZtoTy26k2CfjOXMSgrKqX0Xu9je4zkSoNWYWwiosFqJG3yB1
         ECkOSJgstBlu8rh0iRSvs+c0t3yyCWdGz8FnP/nPDMR9JOG+aEZE3sp4t1KrWz3jhwkh
         eq0G2wEK0w+4g7kP7G6WpgLiHSdPifc62FU7FmSGxyRu+RJGfi9LXiqGq3nhFEIITZy+
         IgXTrGZ5ONAxA1MXdmDj4nscFFLQdWvsKGnHO/vPH+J1HRHFUgLDSzE1d0xxfVydPDkk
         kROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=TX2Y16ZLogmzE47aVV2l5VK4r+MvvTzQaDvobBXxE0A=;
        b=NEFZCvGu3slG13A0wBO4wduDq/01a7Z8XeJHCjAcFm0atWspnlFiwywjoNuteby0ie
         9ITx7529FyiDNpcOCsm7G+P0xuC6KsZAw4SWMy92oRFb/ZVnVc3OLdwAr3VCam7zQPMc
         gVhy/l7h1BeqjjeTSIIkPbS5tWMcevY6/BuTS7vb7pTxcMD2arS6aL/QnWLhSohwOKEx
         PCIbtwfuPMaa+YewwEfUuGm9Ih1b0+BwdHneNu3Hl9touoBgPikxjEQqPbXqEBfZMStI
         DXBJdhQW9aaw7PbIEw5M81uT2Hoyuszj8/ewQLjvy+lTqX9rKBhk2gZmLJgCCam5JLw+
         KNNA==
X-Gm-Message-State: AGRZ1gIe2O1yzU22l/3BR0wVxE3Se+4rduunRvQu9tT3he0mpiv4dvgl
        SLgtBck+wRNeDH8/iynN1bAoELzV
X-Google-Smtp-Source: AJdET5eUgYINTlk+wih/stpPVBnzkxrJvnNPud24Ky1fV8vUYcUaqZK2CnibmMJIfPQYfp6rfs4A2A==
X-Received: by 2002:a50:d303:: with SMTP id g3-v6mr6002425edh.206.1541858677901;
        Sat, 10 Nov 2018 06:04:37 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id e47-v6sm3026551edd.79.2018.11.10.06.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 06:04:36 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     gerardu@amazon.com, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
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
        <87d0re5pt3.fsf@evledraar.booking.com>
        <CACsJy8BvD6eSaxu1KyXawMcBCQGMQ5DywQpsycTTjKusioZZuQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8BvD6eSaxu1KyXawMcBCQGMQ5DywQpsycTTjKusioZZuQ@mail.gmail.com>
Date:   Sat, 10 Nov 2018 15:04:35 +0100
Message-ID: <87a7mh58r0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 09 2018, Duy Nguyen wrote:

> On Fri, Nov 9, 2018 at 2:46 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> I'm planning to re-submit mine with some minor changes after the great
>> Documentation/config* move lands.
>>
>> As noted in
>> https://public-inbox.org/git/87bm7clf4o.fsf@evledraar.gmail.com/ and
>> https://public-inbox.org/git/87h8gq5zmc.fsf@evledraar.gmail.com/ I think
>> it's regardless of Jeff's optimization is. O(nothing) is always faster
>> than O(something), particularly (as explained in that E-Mail) on NFS.
>
> Is it really worth adding more code to maintain just to shave a couple
> seconds (or a few percent clone time)?

Yeah I think so, because (in rough priority order):

a) The maintenance burden of carrying core.checkCollisions is trivial,
   and it's hard to imagine a scenario where it'll be difficult to
   selectively turn off some does_this_collide() function.

b) I think I need to worry more about a meteorite colliding with the
   datacenter than the threat this check is trying to guard against.

c) I think we should just turn it off by default on SHA-1, but don't
   expect that argument will carry the day. But I expect even those who
   think we still need it will have a hard time making that argument in
   the case of SHA-256. So having the codepath to disable it is helpful.

d) As shown in the linked E-Mails of mine you sometimes pay a 2-3 second
   *fixed* cost even for a very small (think ~100-200 objects) push/fetch
   that would otherwise take milliseconds with Jeff's version of this
   optimization (and not with mine). This can be a hundred/thousands of
   percent slowdown.

   Is that a big deal in itself in terms of absolute time spent? No. But
   I'm also thinking about this from the perspective of getting noise
   out of performance metrics. Some of this slowdown is also "user
   waiting for the terminal to be usable again" not just some machine
   somewhere wasting its own time.

e) As shown in the patch I have this direction as a very beneficial
   side-effect makes it much easier to repair corrupt
   repositories. Something I'm hoping to pursue even further. I've had
   cases where core.checkCollisions=false + stuff on top would have made
   repairing a broken repo much easier.

Anyway, I'm in no rush to send my patch. I'm happily using it in
production, but will wait for Jeff's be ready and to land before picking
it up again. Just wanted to do a braindump of the benefits.
