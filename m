Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 250981F516
	for <e@80x24.org>; Fri, 22 Jun 2018 18:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934215AbeFVSdB (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 14:33:01 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46981 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933869AbeFVSc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 14:32:59 -0400
Received: by mail-qt0-f194.google.com with SMTP id h5-v6so6747819qtm.13
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=T1rC0K4kpL8HNigeI3J6MJPy9odQlG4fqhF9xwZllnY=;
        b=FX3XAftiiEOxQ88MCBsJkim9ck82PrxkbVDmPAcEw6HC3zYLMyDEbzJMBTVaFi84qz
         la4cxK+X8R7gqRkb9P/fuSJ/IyQxYVtxbsPIxoOjP2vo/61uGLI3lgbFzLSmNGxmOgnH
         JiCJJzP8LckyNPsj2IijgzmwOK84fRHW9MfPzJ3pjEohhOgBGgEjzwO9lbPT+kjxv+Ua
         s4lZngIO4Fk2cZy+t6fDsqnbJEDm0SlNyvovQSmtVp3T4ZfPqxHRAfDqD0BZpVvcDBx4
         j2SkzXS3EfBbDIzsWZLbiVhhgzOc7n584KswSUG50I7vLEMSK7YZ+MS3PVVWpE8hdLOq
         o8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T1rC0K4kpL8HNigeI3J6MJPy9odQlG4fqhF9xwZllnY=;
        b=PsyWD2ScI4bzJvnJveZsRrzIAtmuQEBAmJh3eB1pA9y/LmTVDQTsJICvuBqsyiY+by
         Ch+oWt3ktAGggS8arT2GdYU6f9O+6euq6jzhZCKEqDW+WWfx++aDiuJW0LpFkpjYHjp2
         1+6WSv28Hn9guOSHchHuL70nR93DVU/sie4+dY7SpC3KuC0EQM2EzjJYEX9Ul++4BnUA
         JQjZEI55LFjAgk8BZEShZeA/9QLoI46Ab3XHg8pKOKseVN91r9OjSTh+ofIkw+8RZZub
         xjUFxSzHjekuCAUwgHgwSO2lgUIFVYEj6QHefbAzCKb4lqGp7HpZ8/al/mKEl0f/DC1/
         O5DQ==
X-Gm-Message-State: APt69E2I/ZpusuWDguS6oyVC9lRuOIWix2FeK1LYeq3xWq5WlPUZUUax
        xZtq5Yq67WT/5ldv6Yp9a6g=
X-Google-Smtp-Source: ADUXVKJs+l90EIPpoJ1aW39FCY+o7RdwOqyKpFNOlsm2pocLabRL2qr5tpkFfx99albopNWVTicHFw==
X-Received: by 2002:ac8:2be8:: with SMTP id n37-v6mr2480917qtn.293.1529692378547;
        Fri, 22 Jun 2018 11:32:58 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:355a:cab3:6059:73ce? ([2001:4898:8010:0:1e90:cab3:6059:73ce])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6654177qtv.50.2018.06.22.11.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 11:32:57 -0700 (PDT)
Subject: Re: [PATCH 09/23] midx: write pack names in chunk
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-10-dstolee@microsoft.com>
 <CACsJy8ARDLeWaWq1_npZq5ARCVgcETpS--YUVLqZkZA52E7Msw@mail.gmail.com>
 <4082c785-9fb2-7b15-b646-3c658b54abbe@gmail.com>
 <xmqqfu1gt4ye.fsf@gitster-ct.c.googlers.com>
 <08667213-02fa-6104-d8de-20ee92b6bdce@gmail.com>
 <xmqqzhzmptab.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d79e4b0f-eeaa-0995-1ee6-8565903f2899@gmail.com>
Date:   Fri, 22 Jun 2018 14:32:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhzmptab.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/22/2018 2:31 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> The index extension documentation doesn't appear to be clear about
>> which extensions are optional or required, but it seems the
>> split-index is the only "required" one and uses lowercase for its
>> extension id.
> read-cache.c::
>
>      /* Index extensions.
>       *
>       * The first letter should be 'A'..'Z' for extensions that are not
>       * necessary for a correct operation (i.e. optimization data).
>       * When new extensions are added that _needs_ to be understood in
>       * order to correctly interpret the index file, pick character that
>       * is outside the range, to cause the reader to abort.
>       */

Thanks! I was reading Documentation/technical/index-format.txt and 
optional extensions are mentioned but not described precisely.
