Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5019E211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 19:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeLET7I (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 14:59:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41858 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLET7I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 14:59:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id z28so18084392edi.8
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9iuXv1J3/hsoYSl3iMmZwQY6/aFZGT+IJMdm7xVX/Oo=;
        b=kEngyL5TohZ3/7beejEnucIoRbpVOwnmyzf6StgXsdCCIUJW5lNcczI7p6PZdX1mO1
         LwoG/NtwrdxvzFySmPxxISGH5gmqH0HmzzymW1B3Sptjf5ssyF72mUk3N4o7Qbnc2Vub
         +Ls2Y3CFLKT4AJ+MI56EQ7q1l0vBWzKFFZyHVcAS9eZoRA3ZJrcBDq07ILc0naPm54kG
         BCzByhRYVHjPU12DgG+p6vMnsstD8R1rT2tZli/MjnZ5knNwF8kRfRGDnthh/wYSUz5z
         XSzz9p60yUDmQGAwiCh4FfBQfhSqmN5GsTHRUd3rwtInCsUaWxsszzD/hkcZmVes5DdO
         EvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9iuXv1J3/hsoYSl3iMmZwQY6/aFZGT+IJMdm7xVX/Oo=;
        b=qASMaZowNepCUH4z/3Df0eWjz+DIL0xv2PwMh/gU3lB30cn/0kLoLciaRXtchh7Ep5
         jJmr1fMr0uEu8mFyY4O3apvc0p3112K/pJ74klFJ4M7TS8LqRWZFKDRsolia0e9feYC4
         q2kTdKikEGBfTP+asmu0YLY1txVhJtWafro2x16SUr/Lr/+NrAcsau6sdZ8RTdYzuZ10
         XLyWOkn70kSL6Ag4mSGtqBFANaIulxp7RdJtWxDC+CZxWt/duoK4mkNndVHq923tTZTe
         26gFaL9239zw8nkcKevJ/Fm3J8eVcTJdC0CBBFtLyUtqa3fvo53++2rd2/8UzGuGxdrO
         96ww==
X-Gm-Message-State: AA+aEWbU1tZCp33HpHC6kmM6bbyQaRZd8+NEySj8zVeh/HM2xIItmw9a
        aQ94SoYWGh6KPPFsAqNWTUI=
X-Google-Smtp-Source: AFSGD/WrVTGGgL0ZsVcV8vLK1uNEH2LBBQdJzpN4E3xSvsbGO+8tSQi+kd5fdpH3CwYeDQClnkdh1g==
X-Received: by 2002:a50:d797:: with SMTP id w23mr23164971edi.19.1544039946785;
        Wed, 05 Dec 2018 11:59:06 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id v9sm5833053edl.3.2018.12.05.11.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 11:59:05 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a test repeatedly under load
References: <20181204163457.15717-1-szeder.dev@gmail.com> <20181204163457.15717-4-szeder.dev@gmail.com> <87muplyxfn.fsf@evledraar.gmail.com> <20181205120725.GK30222@szeder.dev> <87wooof4xm.fsf@evledraar.gmail.com> <20181205143919.GN30222@szeder.dev>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181205143919.GN30222@szeder.dev>
Date:   Wed, 05 Dec 2018 20:59:04 +0100
Message-ID: <87a7ljzqwn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 05 2018, SZEDER Gábor wrote:

> On Wed, Dec 05, 2018 at 03:01:41PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> >> decide to stress test in advance, since we'd either flock() the trash
>> >> dir, or just mktemp(1)-it.
>> >
>> > While 'mktemp' seems to be more portable than 'flock', it doesn't seem
>> > to be portable enough; at least it's not in POSIX.>
>>
>> We are already relying on stuff like mktemp() being reliable for
>> e.g. the split index.
>
> That's the mktemp() function from libc; I meant the 'mktemp' command
> that we would use this early in 'test-lib.sh', where PATH has not been
> set up for testing yet.

Ah, if that ever becomes an issue it's a one-line test-tool wrapper.
