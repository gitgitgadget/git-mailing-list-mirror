Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCE0C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 13:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiFBNiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbiFBNiO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 09:38:14 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAAD137C44
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 06:38:13 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id 62so4812874iov.4
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 06:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MkWQ8/mUKw18jCNM7c+t9Lj7Ul87AnqXU6DtdYJLubk=;
        b=eSe/RJRLQ/MkiLUcK4x7zeGaiDsvr5+uXBBwILalj+pBKytmRYNl4Z46GesU4NEOwk
         dRus4xLwitRyHp8lZxaF8WeWL0u4nT5+9hOdtHjATKTcULdHXMuOUDSe4VD4BFkPuZMI
         hhN8UhFXUVZEtUAt6pNUPnY5bG04H+CIR/sJfKVaGvo52GyUgXiih7ILUgolyyn+YbMq
         Ert8zeQWPrdzJXH5DTvaLQsVF8i9mw/9FNvxCIihx2jKZcPgaFQ0ypj0vj24GXftBTKb
         1vCtg9moNtBY1CkbkUOS+pCm2PI33f9qQZzWVbVwwz/mrW4RZubjsBF99vU39MXx7Hq4
         7h9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MkWQ8/mUKw18jCNM7c+t9Lj7Ul87AnqXU6DtdYJLubk=;
        b=LDrf7O//Hz+OOu63zREYPlrJsOXi78lA8nLKZEGyzfVVIx9b71xoGZ3puYsMBu/Sly
         OLHu6zCAyWsgcMezUnlXn5IgSGiISLwpL59jhw9lg0F9/KR25oYXJJIlwl5MdbHh20ii
         DtcRFctDqnNls0A/a1lRYPla41Zo4t2JulmRYZGKRqdBv5csu8Tyw1VuEljB/P+SU84p
         ApsC66UBPKocm50EhHrtJoFVtnwsvzp2HaJn1y3oK/+H1hs/DGVVbmoh7xXCeM9jMN6q
         DEe2/l6atTi5rxXgEI2qhPM8C7MJfpzTam3un4bYXYVW0vzK5fUB8qs5+rV9MCWPH5X1
         l78Q==
X-Gm-Message-State: AOAM533ONhrF/GjM1IbacLEMz4D5IoNAqhP+WOxDVmtyUxDbh3bL8Puw
        D64NvsgzD6wCrnz4yl4EX9PB
X-Google-Smtp-Source: ABdhPJwNAxK36ITMqbluYSvLwczE7tCvHOZktB4yyURn7hVwku7IaXhvbwqZNY/PU18HI9e6ldPvdg==
X-Received: by 2002:a05:6602:1489:b0:665:7070:a592 with SMTP id a9-20020a056602148900b006657070a592mr2539213iow.152.1654177093033;
        Thu, 02 Jun 2022 06:38:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9cc9:fda3:3ddf:6700? ([2600:1700:e72:80a0:9cc9:fda3:3ddf:6700])
        by smtp.gmail.com with ESMTPSA id e34-20020a026d62000000b0032b3a7817a7sm1203707jaf.107.2022.06.02.06.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 06:38:10 -0700 (PDT)
Message-ID: <73cdf9e3-7c8f-048b-0845-f87fa0861cd5@github.com>
Date:   Thu, 2 Jun 2022 09:38:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/2] remote: create fetch.credentialsInUrl config
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
References: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
 <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
 <083a918e9b1474eff0d51c4502b6d54de9b63764.1654046173.git.gitgitgadget@gmail.com>
 <220601.86v8tkyyt4.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220601.86v8tkyyt4.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2022 3:19 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jun 01 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> +	for (int i = 0; i < remote->url_nr; i++)
> 
> I think we're trying to avoid that bit of C99 in general use until
> Junio's canary graduates. See 6563706568b (CodingGuidelines: give
> deadline for "for (int i = 0; ...", 2022-03-30).

Ah, thanks. I remembered that canary going out a long time ago,
but forgot to check if we had committed to it.

Thanks,
-Stolee
