Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2742AC04A6A
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjHHTZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjHHTZF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:25:05 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DEA2124F
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 10:28:53 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5861116fd74so57099267b3.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1691515732; x=1692120532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqLp/79+ZhMbfiddA4j/95DC+1wHq4Me2L0ltBnFaBA=;
        b=GZZU0Oxi6sxgnxhQtyIQdcABnLoOepyf8kDz2Pd1Mk7lZ49ZZlZtn8kmr/cyzrNrm3
         CEYjf278RmvmyJEqadO6yvyf9ku4viruTJf7a0ZtF8M1F2uGc5uTJNVwMlVaXY0jaP+x
         z/UNC1w0IfqVRlI1KWK4MozeLHVKoft0urSYTWYFGxWsCShGOEdFBhinOMGe6dwsRwvO
         h1jWQBn2ia7CJp35sDrsbvaagcULTf0CEtIYM0QV1u2Y2IFXZAiqd+f5fU5kFFGCQdQ6
         KFa/MrXqsRvMch5EzpBwkHdY5OTvam1hxkxvumZlkuux+QAXvH2BWmGcWFNrg35qP7Lm
         /x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515732; x=1692120532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqLp/79+ZhMbfiddA4j/95DC+1wHq4Me2L0ltBnFaBA=;
        b=DPyIZhG/tlb3/jFfVc+plbau3JpSaBlvB3r7Apatgeuj1o9NwBN9+NNmzLHDasVe6F
         aJ8a9lkv5lWrvTBAm6TSuVOv2lIGu/zL7vFRyEG3crO2s9SYL6C7MHrI8QQqc2b32CF3
         oHx55Dey0yp6qtMZlcArPd1mJsMXTgUoE5wcFIeik8s5iygSfZogTwouW6eFgeBt0UH2
         ihU1ekN4kU2u/zuwloOXb/TkLUCqrFLYlMvZAbkKkM6NIHeNh53FxBOIBlMjNXk2P5ff
         UjUDMRiFzgwKk/cGJSXEBkg9X8+/NT3mlq3mUPtxkk2WlxMzprVzp3jo+54qRukOK3kg
         jfvA==
X-Gm-Message-State: AOJu0YyHeEaLZX5jsd9vbC2nYUZl87PQA3hbtoPHfxJ358W6JRmUKeoE
        FMHt6DE2gf0uKYHgSF6oj4j/
X-Google-Smtp-Source: AGHT+IFn8/z31P82PoaiVQOFWJSqGid0SYXpQPYTUIsRWAUwxEqXlOaPbnb0HIZ/wxFNGTVDsjiNJg==
X-Received: by 2002:a81:4fd8:0:b0:570:63d3:9685 with SMTP id d207-20020a814fd8000000b0057063d39685mr383800ywb.25.1691515732358;
        Tue, 08 Aug 2023 10:28:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1d2:c14b:5536:5192? ([2600:1700:e72:80a0:f1d2:c14b:5536:5192])
        by smtp.gmail.com with ESMTPSA id w13-20020a81a20d000000b0057a05834754sm3404294ywg.75.2023.08.08.10.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:28:52 -0700 (PDT)
Message-ID: <8854e369-fabb-4044-a06c-eaf5b9fbde4a@github.com>
Date:   Tue, 8 Aug 2023 13:28:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] maintenance: add get_random_minute()
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, lenaic@lhuard.fr
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <fefdaa9457948ee5302e7cbfaae250e0b589d752.1691434300.git.gitgitgadget@gmail.com>
 <ZNFgIyuhlNd8I9Y2@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZNFgIyuhlNd8I9Y2@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/7/2023 5:20 PM, Taylor Blau wrote:
> On Mon, Aug 07, 2023 at 06:51:35PM +0000, Derrick Stolee via GitGitGadget wrote:

>> +	if (!random_initialized) {
>> +		srand((unsigned int)getpid());
>> +		random_initialized = 1;
>> +	}
> 
> I was wondering where else we call srand() within Git, and it looks like
> the only other spot is in `lock_file_timeout()`.
> 
> I doubt it, but is there a chance that that code depends on only calling
> srand() once? I think the answer is "no", since we only use rand()
> within that function to generate a random-ish backoff period, so I think
> the repeatability of it doesn't matter all that much.

The main point would be to avoid the cost of spinning up the number
generator, but there is potential for a bug if we run both initializers:
the lockfile would re-use the same filenames after the generator is
reset.

> So I think this is kind of outside the scope of your series, but I
> wonder if we should have a git_rand() that automatically initializes the
> PRNG with the value of getpid()? Then multiple callers can grab random
> values at will without reinitializing the PRNG.

I see you're moving ahead with removing the srand() from the lockfile code,
so I'll focus on creating a `git_rand()` that centralizes the use of
srand(), but won't touch the code in the lockfile so your patch applies
independently.

Thanks,
-Stolee
