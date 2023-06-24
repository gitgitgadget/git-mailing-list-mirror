Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A2CEB64DD
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 10:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjFXKNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 06:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjFXKNb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 06:13:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3324419BF
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 03:13:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3110ab7110aso1718412f8f.3
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687601605; x=1690193605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l7Koi3NRsQXww19l3vYC5P2pXFSghRKjBM3r3DgKiGs=;
        b=LatzrJo8NeuiAjYJIikXKFId6V+2muFomk8wUc3mkedti12ob2R9w2Z/oJHNCkgLzh
         WY1QBjSqskJdGf9GOh/6p9IdxXSEzVwWBgi8j0KU4G9jBv4hHvlZ1oTJrblcPgd5MncB
         HQHHOuQiw0J1XAqW8dNwLbRBs/P85ZZWHxocabUevuzJ3Vu/y3fnVdQTuXo9O9WS8894
         bA+DVEl8GuFtoNu6avN6RtC+2CJehb0SCIZqYoNQY/rJPhGYqQpNLhg5Yv/5IqNkAwnI
         3cRhENWxXunHHj6Wz9pHdVf9ptu4FZTZ875lC5ow5pTi/kMajDVK2xnvMmPZTyg5we58
         t3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687601605; x=1690193605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7Koi3NRsQXww19l3vYC5P2pXFSghRKjBM3r3DgKiGs=;
        b=Mj38BprvOdQAeN3n/VZ5Hk/Oz1wyjTeBtuAzc7t2vuw7/RbrpsTnE4grYTEzxx7Ikh
         fdXcFC93UzpF2peL9HUQQHYs/qqeenROIuemxIZPmDXHRjlFgFJQhMAtR4YeTspqvccu
         95e4xTuqzEjRIHi5FqnfD9JaxeI2VUVTB5s4CJ+GROJD+JS95tPKjRaOezyRhpFZjFdn
         AbZHYNogzSop9c4RUPG6a1nhh9q9RWkIqIlYjvgwF2zkPtEAVbx04L6gyqz6IlkM7Off
         Ylcnuxrdnw3/ctUaxGzQ6fNnI5TkUogGosdI6g3hxeSQRwfcC5FYgsujCz1OaFM2ho1h
         ejOA==
X-Gm-Message-State: AC+VfDzyNSuChQrzQtKznuZBK00Ngcv8lSY5yiFg4VkKHs7K7p/fyl/F
        8J6lC1KdA+8dFgfgD8KwDrpEcwVbMS0=
X-Google-Smtp-Source: ACHHUZ5bzibXuYG5Y2ygL9Oy3VKtTNkesHtRIRMr2/5OQvWfKT9ZND0Bs14Od2opJ52+5ntJsqvf6w==
X-Received: by 2002:adf:ecd0:0:b0:313:dec6:a2fb with SMTP id s16-20020adfecd0000000b00313dec6a2fbmr1377210wro.6.1687601605342;
        Sat, 24 Jun 2023 03:13:25 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id c14-20020a5d4f0e000000b003062ad45243sm1745206wru.14.2023.06.24.03.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 03:13:24 -0700 (PDT)
Message-ID: <d748b4bb-6be2-4936-04d0-f0edcf228dfb@gmail.com>
Date:   Sat, 24 Jun 2023 11:13:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug: git add does not process gitignore properly
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        David C Black <david.black@doulos.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <CWLP265MB3841D32521E79202079DB7F58C22A@CWLP265MB3841.GBRP265.PROD.OUTLOOK.COM>
 <CAPig+cQ1qzO5txhZhki4UrvLBThdgo-aknBmEkNSjFhR9WXLRg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPig+cQ1qzO5txhZhki4UrvLBThdgo-aknBmEkNSjFhR9WXLRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/06/2023 23:07, Eric Sunshine wrote:
> On Thu, Jun 22, 2023 at 3:56 PM David C Black <david.black@doulos.com> wrote:
>> Sitting at the rood of my working directory I attempted to add a file to the git repository with:
>>> git add extern/bin/build
>>
>> The repository had the following .gitignore file contents:
>>> /extern/
>>> !/extern/bin/
>>> !/extern/ABOUT.md
>>
>> I received an error message:
>>> The following paths are ignored by one of your .gitignore files:
>>> extern
>>> hint: Use -f if you really want to add them.
>>
>> By negating entries in the /extern/bin/ directory, I did not expect an error
>> message. Of course adding -f made it work, but I think it does not match the
>> described behavior for this tool.
> 
> This appears to be working as documented. From the gitginore(5) man page:
> 
>      An optional prefix "!" which negates the pattern; any matching
>      file excluded by a previous pattern will become included again. It
>      is not possible to re-include a file if a parent directory of that
>      file is excluded.
> 
> In your .gitignore file, /extern/ is ignored, which means that the
> subsequent "!/extern/.../" lines are ineffectual. So, as far as Git is
> concerned, /extern/bin/build is indeed ignored, thus its refusal
> without --force.

I think the usual way around this is to use patterns like

	/extern/*
	!/extern/bin/
	!/extern/ABOUT.md

see the example on the gitignore man page.

Best Wishes

Phillip
