Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91D2C1F462
	for <e@80x24.org>; Wed, 24 Jul 2019 20:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392419AbfGXUD5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 16:03:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46248 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392414AbfGXUDz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 16:03:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id d4so48194389edr.13
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bB5xQi2qoFYp9QiunhWAWTfcnjWXN1rzpnzwxjVZyds=;
        b=liIAuBPkGgw+8WY/IDaqcXIgKs3trilezcnYn2zE8komNCGggohqrfXweSrLz47LVl
         WD7YlePCL1ir3DA3zmY8TgIz1qUGNKVNt750CY4jStJUPDrTcyrWkRjPvGwveoX4Oifi
         jjGD6IRDRK02VNUQYKb5OAQssOQVVvBpU40cDolpxf5/kDXY43bWxiR6znWcze+TW/xZ
         GX9PB9ZHjlQsL9pOeQ60rmSs7VGXjJTvQQkX/zkcFc7RXpaohMOOfhAPAoZkQNpw6QSk
         46Ve0dnR2nda68TmU6yerttkoutcusIRXccm+w7dfOPKgS7eiaHiJJQyyehEmbcXrZoK
         hyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=bB5xQi2qoFYp9QiunhWAWTfcnjWXN1rzpnzwxjVZyds=;
        b=nAYlkV3nlpKgEz3qY9iWjdsL0IQquKI9CzUC4TZOHYSmlzbIm0DXwualt00GKTTajF
         gndmznkBIKe0llvXypkBPpPYgKryR5LIWaQE2i/T/rNelA3MZuMnmI1DO3ZHgewhrqZZ
         asMoK1utuBYsr65OmB5KpVH20tx4x9cx1dC1Fjy3QZaOWeJs9YfdvRPgDOwb3HF3oLd3
         KKANkDhtKIB7XnZYO97JFK6EXjWrJjF9YOTIpJF8Qdgv44mc6dvFOxVMSyj+BrDpGkuV
         pmSzuT5feETWGhjhs+4xiRcLVygSmvN6oxX+KqOhdahEWr4zoa94BV7mqG2EQ07Ybk2L
         aktw==
X-Gm-Message-State: APjAAAVC8KRHGF40Ef/TMZkFW+/P8Mo2AU4HHq49piQSiweXONVcvRlX
        0o+jJ/4lTNA9fp0/HYgJsXU=
X-Google-Smtp-Source: APXvYqztniPJkg3Cey+YIM4QsfWbNU1ggpe0Y9vr8DxFW3tilbTAHkd/Db34GMOCA6+Y8PvRmfmYxg==
X-Received: by 2002:aa7:d1da:: with SMTP id g26mr73313198edp.198.1563998633417;
        Wed, 24 Jul 2019 13:03:53 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id gz5sm9430123ejb.21.2019.07.24.13.03.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:03:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] grep: PCRE JIT fixes
References: <20190721194052.15440-1-carenas@gmail.com> <20190724151415.3698-1-avarab@gmail.com> <xmqq1ryfs8ws.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqq1ryfs8ws.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 24 Jul 2019 22:03:51 +0200
Message-ID: <87k1c76vyw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 24 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> There's a couple of patches fixing mistakes in the JIT code I added
>> for PCRE in <20190722181923.21572-1-dev+git@drbeat.li> and
>> <20190721194052.15440-1-carenas@gmail.com>
>>
>> This small series proposes to replace both of those. In both cases I
>> think we're better off just removing the relevant code. The commit
>> messages for the patches themselves make the case for that.
>
> I am not sure about the BUG() that practically never triggered so
> far (AFAICT, the check that guards the BUG() would trigger only if
> we later introduced a bug, calling the code to compile when we are
> not asked to do so)---wouldn't it be better to leave it in while
> there still are people who are touching the vicinity?

The BUG() in 1/3 is just checking if pcre2?_config() returns a boolean
when promised, so it amounts to black-box testing of that library.

I think code in that style is overly paranoid and verbose, it's
reasonable to just trust the library in that case.

I think the reason it ended up in the codebase in the first place was
converting some first-draft implementation I wrote where I was being
more paranoid about using the PCRE API as a black box.

> The other two I am perfectly OK with.  It is easy to resurrect the
> support for v1 (which may not even be needed for long) and resurrect
> the support for v2 with Carlo's fix, if it later turns out that some
> users may need to use a more complex pattern.
>
> Thanks.
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>>   grep: remove overly paranoid BUG(...) code
>>   grep: stop "using" a custom JIT stack with PCRE v2
>>   grep: stop using a custom JIT stack with PCRE v1
>>
>>  grep.c | 46 ++++++----------------------------------------
>>  grep.h |  9 ---------
>>  2 files changed, 6 insertions(+), 49 deletions(-)
