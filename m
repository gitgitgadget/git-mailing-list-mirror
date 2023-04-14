Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D3BC77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 14:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjDNOXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 10:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDNOX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 10:23:28 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC2DA5CC
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 07:23:12 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id c17-20020a4aa4d1000000b005418821052aso3699071oom.6
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681482191; x=1684074191;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTMCT6GKD9An18SppH8dxG6lLUefyoMNwNc4ay4OoGw=;
        b=Bo4cloFdnAbxzMCW4qZPbYtdAhJl3fXUNfYtdwS+kZIgaZrNRaCNPr5Iu68f5DV/EI
         PE8GHWMJ3W7vCbHA0j28qN/xBXeoFt7kKOpetEbnL663Mp0R+aYB47PFyLqi3Pw/WVUc
         sgz6fBkD1+5YWf8zjWiswmdLRu3p331C+JPwOzjwkrb/DGRZkz1lVh1JFcrcQytMzFHp
         QyspGLTkO2aPLXXakpJ+rD9lY7bg5ZJTzr28RyLbGofEtwBHNHkJildZc92q6CrcxrZw
         qGu94+dPTtcIjuVRZBkSp15hJ8wibFh15R0atKw17DdNtL43DTV4UXOUTba9clmt1RMx
         rP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482191; x=1684074191;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTMCT6GKD9An18SppH8dxG6lLUefyoMNwNc4ay4OoGw=;
        b=W5SgF41zV7vGWzfqB233auH6Hi6AQqxTJ8UjnbDZqLy5X8N3dyzNNB02WUOL2TRXTR
         YW4aWuaMyE44ednx5hrmVvv/AG2gN4zPkht+XMPr4D6+SOZ77TCUgA4nVbNDUxg5W7qB
         afwTWxZs0ZIBiQmGSeVB+zjPRWjusjOwgRQch93zTUYABlTnPGfrNCUNZS5XyVWNEUOM
         cYLiB7Hd1wcrWu7fUCCrN8SQlsBpGjM3cHN4+YxppSnF4pf5sGJN+3q5mKm9XszLHkSY
         BliFo2i61mYHPGWO5zSKjEzIS+Sa8iIzt2GjFklthwQGrQSPTnBFIvSk73qq59nyoJLp
         1Icg==
X-Gm-Message-State: AAQBX9faFZ4bVq8+k7v3x6Ikr+A/WpbQ3+GZc9eQpL9t8JSstua8Xt7a
        BzgW3eUo8zVvuel/HdNue+ucV7eAAF9g2OcD0w==
X-Google-Smtp-Source: AKy350ZKY/jk4lcmOzx+hKt2Og5xXp4WS8YMIvEAn8M8qkPjDZupw9IKLQ+7BOzvF1BoRrPEv9jBag==
X-Received: by 2002:a4a:57c3:0:b0:525:59fd:fbe7 with SMTP id u186-20020a4a57c3000000b0052559fdfbe7mr2201918ooa.2.1681482191350;
        Fri, 14 Apr 2023 07:23:11 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 125-20020a4a0d83000000b005251e3f92ecsm1707751oob.47.2023.04.14.07.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 07:23:11 -0700 (PDT)
Message-ID: <89c78da5-388a-e52b-b20b-e376ac90de14@github.com>
Date:   Fri, 14 Apr 2023 10:23:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com>
 <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
In-Reply-To: <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2023 10:09 AM, Derrick Stolee wrote:
> On 4/7/2023 3:24 AM, Christian Couder wrote:
>> From: Elijah Newren <newren@gmail.com>
>>
>> Instead of the fixed "<oldbase> <branch>" arguments, the replay
>> command now accepts "<revision-range>..." arguments in a similar
>> way as many other Git commands. This makes its interface more
>> standard and more flexible.
> 
> Unfortunately, while doing this, you have broken the --onto
> logic:
> 
>  $ git replay --onto HEAD~2 HEAD~1 HEAD
>  fatal: replaying down to root commit is not supported yet!
> 
> The rev-walk you are supplying by this line...
> 
>> +	argc = setup_revisions(argc, argv, &revs, NULL);
> 
> is taking the remaining arguments and using them as tips to
> walk. We need to be able to recognize that --onto A B C means
> that A is the new base and our walk is B..C.

I'm realizing after hitting "send" that this change is
intentional (based on your test updates). I don't agree with
it, though.

Sending arbitrary command-line arguments to setup_revisions()
creates an opportunity for behavior you are not expecting.

For instance, can users pass multiple ranges? Can users
supply --first-parent? What happens if they add an --author
filter?

(I was able to get a segfault by rebasing this series with
--author=stolee because the commit list became empty. Something
to watch for.)
 
> Something like:
> 
> 	'git replay [options] <base> <tip>'
> 	This mode means to rebase <tip> onto <base>,
> 	detecting the range of commits to rewrite.
> 
> 	'git replay [options] <new-base> <old-base> <tip>'
> 	This mode means to rebase the range <old-base>..<tip>
> 	onto <new-base>.

For that reason, I think we should be using explicit argument
parsing in the builtin and only transform arguments we
understand into the setup_revisions() (by building a strvec).

Thanks,
-Stolee
