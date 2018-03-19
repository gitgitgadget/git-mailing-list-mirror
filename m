Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED1A1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 19:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968451AbeCSTEj (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 15:04:39 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:52414 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968291AbeCSTEg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 15:04:36 -0400
Received: by mail-wm0-f41.google.com with SMTP id l9so8050472wmh.2
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SNBKYsdMuFStP20LJTrzYlsvdxCbr9gTDBy9EcYAha4=;
        b=NK9sAztb2Nwbd3SrVY6/5LBfCAJxK216YuzQk1jFyIebSaLPv5k6Sfx/+YaoGh8lfU
         ztECWXB6aKLrNGAmPcgFzGepntKhqxb1l8P0DUqcuYsHNPm6LHlalLgD7VjONKH2GDSQ
         GDehCsklYZwUsGjovjWci3NvyDVOZxNV3bQLI53NNF6m6kxz1FG1gx4IMcBHLLNhXKxr
         zhMND18mHvV5KoHPtregRo0ZCRlwrV1HJMGM0Bd6lDRYxHqwS25rlKYEdDRoE4xYACpe
         /qV4PPOg9QTAdwPQ1SUXWI9gxevX9mWd4dBYVLmWi/2I96ZJhe+AoETlLZjP/T+uQwB/
         Ke+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SNBKYsdMuFStP20LJTrzYlsvdxCbr9gTDBy9EcYAha4=;
        b=ttwGCZlhv+W0IEzyVCJ9cqJ87Qhk/vRKJZ3NGF+/kznJueaaRMP9DAhdLOTm15xJXo
         No0jIvxV8GkRJxq4XkfWm20Ov+/267yJXpLc01bjvAGzanPMhnWPeBObl9qTpNiQCbhQ
         n9hWZBgt7tA4bocSa+JhWhjy81BJolgzm9mqiWQB0GeqhWpz1NLjwpLKKHEeDAdGZgg+
         s9B4yUv8+8MjrPiklKi6IZcDVFx/4mLbc8XiXz+wEEhWXqg74ymm9pwRqWeIgm5bMC+z
         BwgZIWCT6GuLYf4kbjsvgCXaLSHu5oEjgWRBP1Lb5058dl2lBNd4VXasuO6ehk4P9+ey
         SmaA==
X-Gm-Message-State: AElRT7GyYwP6UzcegBHGm3L80z7h+xIOcD9zGxY/VSsxNfSMBaM/eZEk
        CVOVteDdvHr9NcIe3Uqq7pIwzQAB
X-Google-Smtp-Source: AG47ELtK1mLRzqi9xgPGPe5hh66ynOIsQGefmBfWMseAdNOXVvGC+XR5ujAsxj86CzO/Ql6iYRfVPg==
X-Received: by 10.28.113.216 with SMTP id d85mr5640782wmi.97.1521486274958;
        Mon, 19 Mar 2018 12:04:34 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id l22sm91352wmi.39.2018.03.19.12.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 12:04:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/7] gc: add --keep-base-pack
References: <20180306104158.6541-1-pclouds@gmail.com>
        <20180316192745.19557-1-pclouds@gmail.com>
        <20180316192745.19557-3-pclouds@gmail.com>
        <87zi37d93w.fsf@evledraar.gmail.com>
        <CACsJy8BoA7H+5nYigLRVTVAU70=WRiwQV2GkM10xhJWA2onvyA@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CACsJy8BoA7H+5nYigLRVTVAU70=WRiwQV2GkM10xhJWA2onvyA@mail.gmail.com>
Date:   Mon, 19 Mar 2018 20:04:31 +0100
Message-ID: <871sgfdgzk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 19 2018, Duy Nguyen jotted:

> On Fri, Mar 16, 2018 at 10:05 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Fri, Mar 16 2018, Nguyễn Thái Ngọc Duy jotted:
>>
>>> +--keep-base-pack::
>>> +     All packs except the base pack and those marked with a `.keep`
>>> +     files are consolidated into a single pack. The largest pack is
>>> +     considered the base pack.
>>> +
>>
>> I wonder if all of this would be less confusing as:
>>
>>> +--keep-biggest-pack::
>>> +     All packs except the largest pack and those marked with a `.keep`
>>> +     files are consolidated into a single pack.
>>
>> I.e. just skimming these docs I'd expect "base" to somehow be the thing
>> that we initially cloned, of course in almost all cases that *is* the
>> largest pack, but not necessarily. So rather than communicate that
>> expectation let's just say largest/biggest?
>
> Keeping the term base pack allows us to change its definition later
> (something else other than "largest"). But to be honest I can't see
> what else can a base pack(s) be. So unless people object I'm changing
> this to --keep-biggest-pack (which could take a value <N> to keep <N>
> largest packs, but I will refrain from doing things we don't need
> right now).

Maybe I've just been reading this differently, but to me the "base" pack
means the pack that holds the basis of our history, i.e. the thing we
first cloned. As in the base of the history.

Let's say we have a 100MB pack that we cloned, and someone adds a 200MB
(uncompressible) binary file to the repo, then we'll have a "base" pack
that's smaller than the "largest" pack.

So when I was initially reading this series I kept looking for some
discovery of *that* pack, but of course it turned out that it's just
looking for the largest pack.

I just think it's best to avoid that confusion since we really mean
largest, and maybe in the future it would be legitimate to treat the
"base" pack differently, i.e. as you pull down more updates you're
likely to need to be consulting it less and less as time goes on, so
maybe we should have some mode to explicitly exclude just *that* pack
eventually. I.e. as an optimization to keep the more relevant stuff in
cache.
