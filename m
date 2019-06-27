Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D4F1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 16:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfF0Q2C (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 12:28:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43251 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfF0Q2C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 12:28:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so7641832edr.10
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bx3WS1CddI24peaSgDgCfOroGDTNry8WRuxuOcvq18k=;
        b=ilQZ31cHmSBmvrJH6Bt0b2yUQ1fsMU/Ks6q1MZXkQcrseKcXlRU9QvazO0Y6zRQHWx
         48Tuf2pQg86TrsP42FqkZIxcEi6zU0X870YEIK2esaq3i/OFpzEWyCpRme14XtTJrh9c
         /LiIktSSYbsO04ABBjGR63rqy4fTsOFVbT9VYYnDgr7x+nu4hV1nIKSAtGKVqlDgMVse
         vQoZABbrvi23T2l4ehldxlHCm4Cd5lKPkPSFPej9KvIqwatVa0HuEmVdoZqzLST4Tvc0
         A71JgKkAqRWrvkGAagjoM/CDoUqkdDIRsYO5j/hJvERU2giwHY3nl5x/ikdvxYCt5mru
         y8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=bx3WS1CddI24peaSgDgCfOroGDTNry8WRuxuOcvq18k=;
        b=SWSNZzvraJ7LFV+wh5CxbVLpObtMt8iFN8YkPG8M1GIklHkMdtvdSCTwd4k3fkhnEr
         SdIV7xYr0+xZXLmZhoUfioFAj3SnqxZgfq9Xoi4TkRWK11wA2pufVdMi28Gz/vlkZ+6J
         cfpVxGHupBUw+xHVY2PIbXt0ExXfcAEg4XhW3MTflPk4D0aZEsHLnxjY5ipdOvyWdZ4w
         9o4GIKdbr2HfYXUM/DwF1aBWt/B2kjcFVmyuFkOgOCr/dsgeGqTT1NvJs9MTrLzXNApm
         XPXIddjJtL1K7y7GUzPriRW0zjdvhG4zKIrOSeDG7FUsUEeEA3YalbsNuKnwAAe9guKM
         o/rQ==
X-Gm-Message-State: APjAAAXT1Fo00qfBS4xGJ8FaJZNqEIte8VSDei8Ltt0cHDoR13TckCDk
        lHzt7pFf69KE4o9GBYh4dDE=
X-Google-Smtp-Source: APXvYqxvYtnirC0vYde5CNR4mKTiNNviT3XcqW2LURNu5azUmq8LIoNDrQiYDEtfDzUMTnLq6zoK4g==
X-Received: by 2002:a50:9282:: with SMTP id k2mr5243455eda.269.1561652880801;
        Thu, 27 Jun 2019 09:28:00 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id s47sm917218edd.40.2019.06.27.09.27.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 09:28:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, gitster@pobox.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 0/7] grep: move from kwset to optional PCRE v2
References: <87r27u8pie.fsf@evledraar.gmail.com> <20190626000329.32475-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1906261601270.44@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1906271113090.44@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1906271113090.44@tvgsbejvaqbjf.bet>
Date:   Thu, 27 Jun 2019 18:27:59 +0200
Message-ID: <871rzf8034.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 27 2019, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Wed, 26 Jun 2019, Johannes Schindelin wrote:
>
>> On Wed, 26 Jun 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> > This speeds things up a lot, but as shown in the patches & tests
>> > changed modifies the behavior where we have \0 in *patterns* (only
>> > possible with 'grep -f <file>').
>>
>> I agree that it is not worth a lot to care about NULs in search patterns.
>>
>> So I am in favor of the goal of this patch series.
>
> There seems to be a Windows-specific test failure:
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11535&vie=
w=3Dms.vss-test-web.build-test-results-tab&runId=3D28232&resultId=3D101315&=
paneView=3Ddebug
>
> The output is this:
>
> -- snip --
> not ok 5 - log --grep does not find non-reencoded values (latin1)
>
> expecting success:
> 	git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D$utf8_e >actual
> &&
> 	test_must_be_empty actual
>
> ++ git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D=C3=A9
> fatal: pcre2_match failed with error code -8: UTF-8 error: byte 2 top bits
> not 0x80
> -- snap --
>
> Any quick ideas? (I _could_ imagine that it is yet another case of passing
> non-UTF-8-encoded stuff via command-line vs via file, which does not work
> on Windows.)

This is an existing issue that my patches just happen to uncover. I'm
working on a v2 which'll fix it.
