Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744E7C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 09:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjFAJT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 05:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjFAJT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 05:19:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A55497
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 02:19:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6d01d390bso6391905e9.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685611165; x=1688203165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ALIXY2j4L5WigNqrvgabx0MMzzUEoi3DkxCbZxK5u/U=;
        b=rx/dJeMOCdTKKNyrcAC/zPIOTWnGQJMf6oeriO7Hx4o6E+uQSPPW2V53a+ALMqts+S
         oazlfKn3/aUOQSCRxTgzZEENgklx7zm2A1Kh/4T1NdgCf3b1PMh6cOiLEZuwjbumY7BY
         pBhS7ZkfPie8dabrUf5w1UXMPbc/pczCZCwBV5aGF9zdf1OBMYEABL8at4/pD/Ff5dv9
         bXv1I453JjG5IA1++DH9zi3IOqXqWgMMLqdfXOqazch8LXnPAUs5+bafDu5xxkGgl1Ej
         zvo/r9uSgIkoncTgyPR/Bj/+vgoTXk007cEeL2Au26CAmN6464haNN6jRJysGDY+0Weo
         Q1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685611165; x=1688203165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALIXY2j4L5WigNqrvgabx0MMzzUEoi3DkxCbZxK5u/U=;
        b=ME6CZB1JjIBK9CP/KRmfmUmSL4YEb1r8rUiP6s90Psq+Xi9UVzmAK/DpffEcSKbdmN
         +jlkKscKb7DzgUDy5goUt6P03IZT/ndAH+O9jEE331/wumZ9cZq6gf+c0WWjAkejp2Ko
         GrJJ9TRkYjW7tjQoTHlNn0kI+zSwK1jjjLS1MGJsx7crrVc9UJ5JbSYt7WNV0rVfIufi
         BZAs5j59u/9/xokjTarX6p6WegJYKkLRULCg9R8mP9rGY2zzAvUXFYut2Su2yUhf2Q9v
         G2AAkJSseWFFaobnjeFoDsip+IOzBlr1yH5iDWCJpzO/7GOngw7OkXJS04DoySL4IBHp
         MIPw==
X-Gm-Message-State: AC+VfDzs6pY/NsuhqjWxn0vuZtW6EwNPLM5KIFowZtEG27os6EjgUWml
        9maHq7sP9y/VuPRVU3tJSN0=
X-Google-Smtp-Source: ACHHUZ5pYBeiekR7dxgtidemRqkuG/kJtU8pLfvbLjgOVH7RoFabq4ieOw9CG7s/cNgT6GW6c9lfYA==
X-Received: by 2002:a1c:f01a:0:b0:3f7:16ed:4ca3 with SMTP id a26-20020a1cf01a000000b003f716ed4ca3mr1695269wmb.1.1685611164792;
        Thu, 01 Jun 2023 02:19:24 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b003f423508c6bsm1609303wmc.44.2023.06.01.02.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 02:19:24 -0700 (PDT)
Message-ID: <73580406-f2cd-12ff-954a-2adb73b0edc8@gmail.com>
Date:   Thu, 1 Jun 2023 10:19:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v2 2/4] unit tests: Add a project plan document
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>, steadmon@google.com,
        git@vger.kernel.org
Cc:     szeder.dev@gmail.com, avarab@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net, Calvin Wan <calvinwan@google.com>
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <20230517-unit-tests-v2-v2-2-21b5b60f4b32@google.com>
 <kl6lzg61xuox.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <kl6lzg61xuox.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen

On 18/05/2023 21:15, Glen Choo wrote:
> steadmon@google.com writes:
 >
> A third option would be to pick another, more mature third party testing
> library. As I mentioned in
> 
>    https://lore.kernel.org/git/kl6lpm76zcg7.fsf@chooglen-macbookpro.roam.corp.google.com
> 
> my primary concern is the maintainability and extensibility of a third
> party library that (no offense to the original author) is not used very
> widely, is relatively underdocumented, is missing features that we want,
> and whose maintenance policy is relatively unknown to us. I'm not
> opposed to taking in a third party testing framework, but we need to be
> sure that we can rely on it instead of being something that requires
> active upkeep.
> 
> I don't what sorts of testing libraries exist for C or how widely they
> are used, but a quick web search gives some candidates that seem like
> plausible alternatives to C TAP Harness:
> 
> - cmocka https://cmocka.org/ supports TAP, assert macros and mocking,
>    and is used by other projects (their website indicates Samba, OpenVPN,
>    etc). The documentation is a bit lacking IMO. It's apparently a fork
>    of cmockery, which I'm not familiar with.
> 
> - Check https://libcheck.github.io/check/ supports TAP and has
>    relatively good documentation, though the last release seems to have
>    been 3 years ago.
> 
> - µnit https://nemequ.github.io/munit/ has a shiny website with nice
>    docs (and a handy list of other unit test frameworks we can look at).
>    The last release also seems to be ~3 years ago. Not sure if this
>    supports TAP.

Thanks for finding those. I'd add

  - libtap https://github.com/zorgnax/libtap which seems to have nice
      assertions and TAP output. It is licensed under LGPL3 but used
      to be GPL2 and there don't seem to have been many changes since
      the license change so we could just use the older version.

I think it would be helpful to have a section in the plan which clearly 
states the features we want (TAP output, helpers that make it easy to 
write tests with good diagnostic output, ...) in our unit test framework 
and explains how the selected solution meets those criteria.

It would also be helpful to have a guide to writing effective tests that 
sets out some guidelines on where unit tests are appropriate and 
outlines our expectations in terms of style, coverage, leak cleanliness etc.

Best Wishes

Phillip

> For flexibility, I also think it's reasonable for us to roll our own
> testing library. I think it is perfectly fine for our unit test
> framework to be suboptimal at the beginning, but owning the code makes
> it relatively easy to fix bugs and extend it to our liking.
