Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2D2C433FE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E392610E7
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhJMNPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhJMNPC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:15:02 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044E0C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:12:59 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id o13so1617477qvm.4
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U/MkZr3FEbLjoCSlJobKdbRe1XO9sQwUFTDFHej0hG0=;
        b=LsFqactujnNBOlkf62/zDdmVkX23qNSHfhzYHnaiL6vGNacnKr7PboJBR6lbrubUv2
         myI/2FRMl9ntKPxQgbiVLXEOnhDhbc/O5Ia0pxdr2DR+1GVXO0nrdhZv3RQh5Y6x4aTi
         DQCDzxaQWwYhjKRlDuPbmFNxD4ZXB2LijZkGbAimJIRezj3C2GCuAIvIUC7Ch9AXXFDI
         fdlT4wHfxqYd7Tbzl9/+g+VOgfBX3KtTZR7gFv+fqdQBajrr58d/7fCaLv/8aFFnrLtO
         KHTd0JEt4Ojw9F7JinIX9oYi3xFrYy+p8V9JtQKE027nxZxKteOnzumrn6Xh3qm0KXLD
         UVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U/MkZr3FEbLjoCSlJobKdbRe1XO9sQwUFTDFHej0hG0=;
        b=0FcxbcY/m7beSsVV2CcwlvS5R8wX7cArGURiyYFAUVnjTYGSNuEkS9ZIi9TGE8sfuU
         jg+G/iG2ruLG2Fsdi2Z+40Vs2EzbNc52VaarhgPKj2c/6fHtdbrY+bfOzrSo27Bw+ubZ
         YqUIpuNEh4ovLCJ8Bcu+FNstGAMlz7XuAd4xgO7gvsrao342AtHUb5QjHUTyNxY36uyL
         pbohKf8x/Kht5iJ3NB0rlesdK1L0mQZMWI+hM3URCxCXr4rjmWJPGqQuy2+Y+I6VAuNH
         bkYmGKUD9H5qY0dd1frNfSltNLgyWgCbfADygkjCPvAqHryoq85RY59tV+ShFOpb7Plc
         hYtw==
X-Gm-Message-State: AOAM531QEd1Fsj4y1cG7YlsbITwfSnp/CpBDfBu3kX3fry2HmJnR4cP3
        C4AIQlFo8UWVaUUdnmSB48U=
X-Google-Smtp-Source: ABdhPJwYzbolWQnhnt3dakg3ahJ2PTpWXG72ufvOZ+qosGZ6hMPsrRnXd8vZf53Mz/2Ih008I/f8gg==
X-Received: by 2002:a05:6214:506:: with SMTP id v6mr35170310qvw.52.1634130777930;
        Wed, 13 Oct 2021 06:12:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4c86:317:426a:54d0? ([2600:1700:e72:80a0:4c86:317:426a:54d0])
        by smtp.gmail.com with ESMTPSA id v3sm7339895qkd.20.2021.10.13.06.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 06:12:57 -0700 (PDT)
Message-ID: <02947b5e-7ce3-4760-0d27-621c7362f839@gmail.com>
Date:   Wed, 13 Oct 2021 09:12:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 0/3] Use default values from settings instead of config
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <20211005001931.13932-1-chooglen@google.com>
 <20211012174208.95161-1-chooglen@google.com>
 <87wnmihswp.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <87wnmihswp.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2021 4:34 PM, Ævar Arnfjörð Bjarmason wrote:...
> If I comment yout your addition of GIT_TEST_COMMIT_GRAPH=0 in that file
> I see that we fail N number of tests, but all of them are actually
> fallout of just this test:
> 
>         git replace $head_parent $head && 
>         git replace -f $tree $blob 
> 
> I.e. we've created a replacement object replacing a tree with a blob, as
> part of tests I added to test how mktag handles those sorts of weird
> edge cases.
> 
> This then causes the graph verify code to throw a hissy fit with:
> 
>     root tree OID for commit 0ddfaf193ff13d6ab39b7cbd9eed645e3ee2f050 in
>     commit-graph is da5497437fd67ca928333aab79c4b4b55036ea66 !=
>     0fbca9850869684085d654f9e1380c9780802570
> 
> I.e. when we wrote the graph we somehow didn't notice that the root tree
> node we wrote is to an object that's not actually a tree? Isn't this a
> bug where some part of the commit graph writing should be doing its own
> extended OID lookup that's replacement-object aware, it didn't, and we
> wrote a corrupt graph as a result?
> 
> If there is a legitimate reason why we're not just hiding a bug we've
> turned up with these fixes let's disable that one test, not the entire
> test file.

The commit-graph should be disabled if replace-objects are enabled. If
there is a bug being introduced here it is because the commit-graph is
being checked during fsck even though it would never be read when the
replace-objects exist.

Thanks,
-Stolee
