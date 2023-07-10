Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2A3EB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 16:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGJQvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 12:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjGJQv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 12:51:29 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F758E3
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 09:51:29 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-783544a1c90so237732839f.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1689007888; x=1691599888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kI/soLAloMslPVDu7tWj5UG3z+bb//Q6u4wE/wGhU4Y=;
        b=enABn9y+2b33a2WV4Z9vGsEfyPXRhgWzvQnSa0GX5wJFQxjVqosTv46wXJ2HYZbHzd
         PiajwcvQ50JZ7EB0sLaHwDFJpzq+WbxdDQseM7kYzYoLTd5ty0N8wyOku2wJcMLyLqBN
         RT+IC2rRS2It7Zk6sb43MFuXwf0zNs4mZp6v8guw1JPs1YhDDHxST1rehms/q0n88p3c
         dDLhxu6VUMWChWHS14MZdvyYOdS1iFhxpNScbbl4CCOQHCvFEdaaxBesxYT7DjnArKoY
         sgaqqfUYvZPt45JQuexPsknceoX8Qhv8YKStEWlY9bZoV5Kofr7dszADk+rSKCRYjvA2
         S6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689007888; x=1691599888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kI/soLAloMslPVDu7tWj5UG3z+bb//Q6u4wE/wGhU4Y=;
        b=MHc0168dRS/kcYVZ+ltB/Ak1DjfuiaRctl51TEe807oYENDXYcRkbsqN/TqoozoPdu
         GbFoobvaLWmX1B3Ats0Y6gJmWxZljwmmA4Mu1Ag9DKwa5LK655AJplZmV4pptGetIozL
         IgWSnswX86J4aI9JnjLos976WXYnAwRC90goP0wRP8V0l5tE7CtbEIZ79AfWgr+eupdA
         nYZKhgYdua45j0RnBMoDOCYFM67ecMshHy/HVVhtDhc+u+dRqdeNLkzn566Sbb61fviY
         X4Qsl9a6AcBNrKmhoslNqU4NNm42JDIcjnpXNis/X0PK3dLabTmFw5l04x9tyx8HUAnZ
         mZxQ==
X-Gm-Message-State: ABy/qLaOn1kfsQatxOjxZTqn1io2iD717Ds4R8Pd6PnEKAYDfPuvLRrh
        5R4IxORgqCVHTtdGEg3QUKdexGQQHs3XMoE00g==
X-Google-Smtp-Source: APBJJlH9mXLPRU318zxQ6woHuyEVf5aBa9aSYEykuvzTFerZGbAULJzMC4iwDpeQ/dI4OzQzeHjq4Q==
X-Received: by 2002:a5e:c705:0:b0:786:8523:7578 with SMTP id f5-20020a5ec705000000b0078685237578mr15703234iop.15.1689007888487;
        Mon, 10 Jul 2023 09:51:28 -0700 (PDT)
Received: from [10.0.0.16] (75-166-6-41.hlrn.qwest.net. [75.166.6.41])
        by smtp.gmail.com with ESMTPSA id ee17-20020a056638293100b0042b37080b23sm3267265jab.73.2023.07.10.09.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 09:51:28 -0700 (PDT)
Message-ID: <4715a469-8c68-8dcc-0254-9b7b857c3722@github.com>
Date:   Mon, 10 Jul 2023 10:51:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] for-each-ref: add --count-matches option
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        vdye@github.com, me@ttaylorr.com, mjcheetham@outlook.com
References: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
 <9121e027fb9f157878a9624ce6c834b69cd38472.1687792197.git.gitgitgadget@gmail.com>
 <20230627073007.GD1226768@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230627073007.GD1226768@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/27/2023 1:30 AM, Jeff King wrote:
>On Mon, Jun 26, 2023 at 03:09:57PM +0000, Derrick Stolee via GitGitGadget wrote:
>
>>+for pattern in "refs/heads/" "refs/tags/" "refs/remotes"
>>+do
>>+   test_perf "count $pattern: git for-each-ref | wc -l" "
>>+       git for-each-ref $pattern | wc -l
>>+   "
>>+
>>+   test_perf "count $pattern: git for-each-ref --count-match" "
>>+       git for-each-ref --count-matches $pattern
>>+   "
>>+done
>
>I don't think this is a very realistic perf test, because for-each-ref
>is doing a bunch of work to generate its default format, only to have
>"wc" throw most of it away. Doing:
>
>  git for-each-ref --format='%(refname)' | wc -l
>
>is much better (obviously you have to remember to do that if you care
>about optimizing your command, but that's true of --count-matches, too).
Thank you for pointing this out! I'll be sure to modify the test and the
analysis about it.
The other check I need to compare is when multiple refspecs are provided
at the same time, which I do believe still is a valuable thing to combine
into a single process instead of multiple pipes to 'wc'.
Did you have any thoughts on whether or not this works as an option in
'git for-each-ref' or would be better broken into a new builtin?
Thanks,
-Stolee
