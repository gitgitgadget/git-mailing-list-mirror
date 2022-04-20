Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075C9C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 10:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377516AbiDTKOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 06:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242267AbiDTKN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 06:13:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F63ED37
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 03:11:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p18so1557103wru.5
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 03:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FOlHC/ks7+qsYP9nNPByGBUGdyu50pgufUD/0EpKJpM=;
        b=R9YioOURBe91X4OQngwGP8RBZ8SYmoagc1pqE77EIi37Yxn190cGFWXJmtDWAMCsfl
         konBzYOaCKMDyhnd4G9yt1ltKYXEUbeeW1L268zZm1GUE2rBaI3YkH7DhFXho0ACfq1c
         pqC5yAqkuGujmwOmrTh7bQYAgfiTbR6IyW6kjF7A4p2Cw6WtOSH3AwEL8SOkOlv8oQM4
         vrMOlrbh1DBbG/pwnY0LgNUpNaX7XeYk1rd++KOt4IrbsUTO0BFfcvV4INF+9/m2FKdK
         gNwqby74wmusSK9jUB1HvQQEDVyejwRh6j0EkUPncpkbX8w/Itj43n4Ky5bG5+oXUCQk
         V2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FOlHC/ks7+qsYP9nNPByGBUGdyu50pgufUD/0EpKJpM=;
        b=wmdg7+JHdlZLU1TlxzuepFBdT9cTx5OsYuXrn/SMxAHVcO5se8zKRGXJu1iLJcCXv6
         FegUYaU1kFzF6JVKm7Lp7vUaMTWjKM/DT1dWBgsITHaGqtSa3lV3oDd1uJRfY+Pqsp4S
         jYFOo92oqBhNkva9gswdInG8KQ1+caJ9VM5j9UG4ptWWuUFp9UsJWUW/X3uaM2qEj5Ki
         +GoAmLmhDdX/xki98KFTjbLrZX0MNYy6aFxHOFvJ5spQbno91lR91RCrtSL0EsnP/luY
         IADyqpvUMPZU6Ap9D5Pl4Kob8BJzLCN7ipGRgsSiiiqHNyJU0os+OM0AS2VNzqru6GNm
         Qpxw==
X-Gm-Message-State: AOAM530HU2E7pT1PNTOYYEL9xq7Ar7b8r3tmCa/3+IrPj0sIKJFpWt7M
        4JscA2otPm1xWPaIq1Xm7jo=
X-Google-Smtp-Source: ABdhPJzU9BCOD0tjsv3c+Os73b1BcNWLOSNK2O1xqdnR4eKX4awiMHO4Xcyxv4Fk6lJZAD2tjLo8uw==
X-Received: by 2002:a05:6000:16c1:b0:20a:b1c5:d7db with SMTP id h1-20020a05600016c100b0020ab1c5d7dbmr1108984wrf.64.1650449470504;
        Wed, 20 Apr 2022 03:11:10 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id v11-20020adfa1cb000000b0020ab21e1e61sm659938wrv.51.2022.04.20.03.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 03:11:10 -0700 (PDT)
Message-ID: <52382f7c-5b6a-63b6-2eb2-26c12f31f529@gmail.com>
Date:   Wed, 20 Apr 2022 11:11:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 30/31] CI: have osx-gcc use gcc, not clang
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
 <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
 <patch-v4-30.31-94abb826627-20220418T132809Z-avarab@gmail.com>
 <55271bbe-7b6e-7c92-7337-2439a2f5be26@talktalk.net>
 <xmqqh76orx3v.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqh76orx3v.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/04/2022 09:13, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> On 18/04/2022 17:29, Ævar Arnfjörð Bjarmason wrote:
>>> Fix a regression in 707d2f2fe86 (CI: use "$runs_on_pool", not
>>> "$jobname" to select packages & config, 2021-11-23). In that commit I
>>> changed CC=gcc from CC=gcc-9, but on OSX the "gcc" in $PATH points to
>>> clang, we need to use gcc-9 instead.
>>
>> As this is fixing a bug in master, perhaps it would be better as a
>> separate patch that can be merged before this series (this series
>> could be rebased on to the fix)
> 
> Yeah, that sounds quite sensible.
> 
> Or perhaps start from 'master', merge this (and other fixes, if
> there are, in this series), merge Dscho's CI updates and then use
> that as an updated base?

It would certainly be nice to get Dscho's updates merged sooner rather 
than later as I think they represent a more significant improvement for 
CI users. There is a complication though in that Dscho's series adds 
github markup to the build output and this series separates the build 
from the tests which means that is not necessary. I think it should be 
easy enough to change Dscho's series so it only uses github markup for 
the tests which is the main improvement and just wait for the build and 
tests to be separated in this series (ideally they'd be a short easy to 
review series that did just that).

Best Wishes

Phillip
