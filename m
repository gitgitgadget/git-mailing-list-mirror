Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EA4C74A5B
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 14:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjCZOah (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 10:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCZOag (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 10:30:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C5D59DB
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 07:30:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso4043603wmo.1
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679841034;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1lB8ry5f95NJJ/8feG/cR1WjRPXUBnfIxgP2ZqM/iqg=;
        b=G6+f+8FowfCkfDUdkslexwd4/Bhc4TnstXBSS1/rFuP7n3fE1LW10Q7DziLnAYkvwH
         GcuUn56hX7vF0QthgKfDP/zgWiCxBQpAsd/K0qGj3+5Ji+zZ3hwNslBSK7NOsshW7Yps
         xVtUi8Xx/oiaI107LFgAmBV3hB+5/jOJR/+bwcO5FjfS7oOZyYfD3vk7m/CpyEc/5xFL
         ws9IZMc2jylUXtxqWKgH0IAz3pOPAQBQylpbvET/0xQkgkfyUVGI5yPB9MXdpq8bN9mh
         RcBMSLbEPSoXvNfgDI2veBHT8cHR5ajqiBEsVVs64ilvVxx5cmeOPbCRPfq3QpjTEWmz
         hpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679841034;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lB8ry5f95NJJ/8feG/cR1WjRPXUBnfIxgP2ZqM/iqg=;
        b=l//JiSEyDWE9WGf23GAcsx8a+PuTraV9UxPO7dpib3rSQQrBv5jG8furneH/ALDrHQ
         pH9puRe9o92QHRdIm/U0rLn+7DQErI3zYYgVYfMOcsH64ftUsCM3VXE5BZccsvMHG/8F
         lnEawlmafBjr5eSHe5egRyQ1KHjEAZuwComaiKrqf73Ed/c7IO03ExkBNnV/iNn6keqX
         3edazF7HBdQVAw08rOc0yEwl8kIAr5ZOiKcwf6LSjikSmlmfdpHRNX/AdFH2cuWV4p0z
         z2OgmgR121E4F6r033y+g68/gV573LCMj4oCn9mhxDjSC8p0AeCHiuxyChQNJetP0Dg6
         HQdA==
X-Gm-Message-State: AO0yUKUK2rRaM8mtBLewAYsMWdRdQYHigrGzNAZDg1aqRVUK0YHNdGGe
        4n35WK4LWtJ8iEY7A37/bFg=
X-Google-Smtp-Source: AK7set9jYjEznuRjJx3ck+MicoxJQ9TIMa8dBjdKBG7AJaTdAWGlXePLU37Ij3MFMbp088/LhiyTaA==
X-Received: by 2002:a05:600c:2295:b0:3ef:4ea0:1853 with SMTP id 21-20020a05600c229500b003ef4ea01853mr6400368wmf.13.1679841033910;
        Sun, 26 Mar 2023 07:30:33 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d590f000000b002cfec8b7f89sm22946701wrd.77.2023.03.26.07.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 07:30:33 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <e240a88d-37d0-83c6-7268-0fc15f5dee18@dunelm.org.uk>
Date:   Sun, 26 Mar 2023 15:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t3070: make chain lint tester happy
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
 <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu>
 <20230325063731.GB562387@coredump.intra.peff.net>
 <CAPig+cT9zjP++ECkTMjh33gzWyh_ho6n8_XYkXTHxnuGiDbnow@mail.gmail.com>
 <20230325075832.GA579632@coredump.intra.peff.net>
 <20230325080453.GA852237@coredump.intra.peff.net>
In-Reply-To: <20230325080453.GA852237@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/03/2023 08:04, Jeff King wrote:
> On Sat, Mar 25, 2023 at 03:58:32AM -0400, Jeff King wrote:
> 
>>>> This looks like the right solution. I do wonder how Phillip managed to
>>>> miss it, though, since the test script complains loudly.
>>>
>>> I am unable to reproduce any linting errors when running this script
>>> through chainlint, which is why I was more than a little confused by
>>> this patch when I read it, and I was just about to ask for more
>>> information, such as the actual error message.
>>
>> It's not your chain-lint script, but rather the builtin one that sticks
>> "(exit 117) &&" in front of the snippet and evals it. So it creates the
>> exact "foo && bar &" situation by prepending a line to the snippet.
> 
> And btw, I think that is the answer to "how did Phillip not notice it?".
> When running "make test" these days, we rely on chainlint.pl to detect
> any problems, and then set GIT_TEST_CHAIN_LINT=0 so that the scripts do
> not invoke it again. But that variable also suppresses the internal
> linter, and thus "make test" passes, but running the script individually
> does not.

Ah, that explains it, I was wondering how the CI run had passed. Thanks 
to Michael for the patch and Peff and Eric for digging into cause of the 
problem

Best Wishes

Phillip

> It does seem like a recipe for confusion if the two linters are not in
> agreement. I think we might want to either:
> 
>    1. Say that the internal linter still has value, and tweak the
>       suppression so it only turns off the extra per-script run of
>       chainlint.pl, and not the internal one (which is cheap-ish to run).
> 
>    2. Say that the internal linter does not have value, and we should
>       rely on chainlint.pl. In which case we might as well ditch the
>       internal one completely.
> 
>       I'm OK with this direction, if we're comfortable that there are no
>       real problems that would be caught by the internal one but not the
>       script.
> 
> -Peff
