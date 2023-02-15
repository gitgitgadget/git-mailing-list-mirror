Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CFDC636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 14:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBOOsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 09:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBOOr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 09:47:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA676B9
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 06:47:54 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bu23so19389005wrb.8
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 06:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eHf7L5Tvq5TP82XNdXrWsrB7eJt4BZ0FfnfzSUVnsDg=;
        b=oyyM4E2t/kEhY5Y+23ImFZLaTscQDLD0dth/4HjrtOU3wjxDzJKwMIIrYVxi6sOWwo
         qHXs/MRImIKs5tHxksepzl3xDY9AUt1/ZCz3F5IV0JsRr+n3p3iA/fZYE/DXF1NEStu6
         af8pJqbkZWNznDYLNVRKNAvVYyuwG3Qp2zysN4KyWK/MVF/SC4RrcLVZCkKG0V3W+VLG
         3vW+QJSXatljMWVqvme8HOPaLdylEu/swPAYkeo8cN0dKvvrL4b9EIVws2C8xMiwKzEI
         p9Kl2/gJ2ytyMBQ5SK4ijZOHltn2mAk4NUTvbPF+DoAtmqcomqCSxE5dCl0caJ5kELoH
         kw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHf7L5Tvq5TP82XNdXrWsrB7eJt4BZ0FfnfzSUVnsDg=;
        b=6K2g6y20OhFidlfixFjg6m4LH+tNrU2X8PZtuCPF+A9D8YcY9doKlEuedFeghtNAel
         iIESLaJUMACyiwQMgStS+7GxwhGEqPc8EbMICfeDyWSZZG7o7zUK71IIervAUuDn4U0U
         vjStteO+RRWT+4kkpusTWogR77ltFLZ7/UmK0gtH40Tq3KilrCI354BWp+zZdTWmVifO
         iEqWNxt/MqwEwNpFTn+4GFCzOhQ3Ptx+3nMH8URGT8bl/b2ItnYyvYBWpv+R5sIqmdFS
         NKbcoYK57eoFw8ZZ4DnCHWFiTza+ecvJYAmlYeW95iCWAXePqLL5nGw/AMX83+6vqVY9
         +esA==
X-Gm-Message-State: AO0yUKXq4WinAKkHBA0y1JFZ87olpWaBHZUydIbKwBEkBT9IrLU4Ao1D
        0MqJ/5vzNGiC+fxewinX97pVjOurN3Y=
X-Google-Smtp-Source: AK7set/o3ntuprnvUiDJ4cnH+uDHpt/ER70D7g5wixt7fT8RGqZSKzydIDAjtvY+vpOGxQ/Gdda3CA==
X-Received: by 2002:a5d:69c7:0:b0:2c5:5ed8:77d4 with SMTP id s7-20020a5d69c7000000b002c55ed877d4mr1660327wrw.57.1676472472593;
        Wed, 15 Feb 2023 06:47:52 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb4d000000b002c573a6216fsm805704wrs.37.2023.02.15.06.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 06:47:52 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <159f09b1-8a69-f662-637d-8e883c31d0ec@dunelm.org.uk>
Date:   Wed, 15 Feb 2023 14:47:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     John Cai <johncai86@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
 <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk>
 <230207.86sffh2xcu.gmgdl@evledraar.gmail.com>
In-Reply-To: <230207.86sffh2xcu.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 07/02/2023 17:27, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Feb 07 2023, Phillip Wood wrote:
> 
>> This is slightly off topic but one thing I'd really like is a way to
>> tell diff use automatically use --diff-words on some files
>> (e.g. Documentation/*)
> 
> Unlike changing the algorithm, -U options, diff.orderFile etc. doing
> that would give you a diff that can't be applied with "git apply" or
> other tools that expect a valid unified diff.

That's a good point, we'd probably would want to guard it by checking if 
the output is going to a tty.

> So I can imagine that it would be neat in some contexts, but such a
> change would have much wider implications than options that tweak how a
> valid unified diff looks, or is generated.
> 
> We'd need some way to mark a diff as "for ad-hoc viewing only".
> 
> But as it sounds like you want this for git.git the
> Documentation/doc-diff script is much better than anything word-diff
> could spew out, as it diffs the resulting generated docs.

It's true that I should look at the doc-diff script for git, but it is a 
wider wish for text files in other projects as well.

Best Wishes

Phillip

> I wonder (but haven't tried) whether you can't "diff" that using the
> same method that can be used to diff binary files using a custom driver.
> 
> Hrm, except that in that case (with includes etc) there isn't really a
> 1=1 mapping between files within Documentation/ and generated docs (due
> to includes etc.). But I suppose it could be used only for those files
> that 1=1 correspond to the generated manpages.
