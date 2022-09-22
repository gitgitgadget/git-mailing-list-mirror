Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C33C6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 12:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiIVMiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 08:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIVMhv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 08:37:51 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8432E7C0D
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 05:37:48 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id y15so4797883ilq.4
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=RGz9vAXH5Wmqad25eQcGeslhuTtEvg5ywvxdjm183a4=;
        b=jKVcy+NV49FmfmMP5+pG/iXYx7cPW/JN6zWDBRQuEUze7QDTJXyg3VhUrVPr7S42QN
         jwckHwgoPlAWq5S6XA0aGH5lR+kXlPQttg10U66Z3x7Qd3A5Yc4j/oFBtQT2QFvCUqHP
         KmDuHNyXUHF8oArJGCVzhuXwkQkJudUGwxTqqSI+uAlmKNQ9Zx2uolbaMwx2+NBJKEnh
         7W0zMILMZI2KVuCMLvvyOFOIOXNXWuBMLg/jdVDTqQ4jtl+jXG1x85rt2zeimRJfe1JV
         bd9KWP2rPnOkjdPxgXTIlkOcUl0UOSxG4uATQTKmOer7zKvZLwugC2Vhjb3sw8qCdz2Z
         zUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RGz9vAXH5Wmqad25eQcGeslhuTtEvg5ywvxdjm183a4=;
        b=UhjjOTtLEOgpF5diCDp6SCMkxgdFudsXUH9355Fd1er1yMJ8KPLKgbgkkAFwM8DwnY
         bxsvt5JmZ4VtTMW77cFDME2K7Vo7F9Y9svnWDqSXBMA5ydUgurmHAu3uYq6SMudVDgfe
         dNECwwtN9NKackMkJnlvVNPa/oEjtMFmnzP1Gx9+DAHxS947NwqCfabvvggJPHjXqLZ9
         2s/CINRYxht00EqYeNDmNlCC9brbwF4hzGlX7hoieQup/fkkRImMyqY3oWi1ismvw7Z9
         WeaGaQPsRH4+5clsV8CMmp34e6Gr09Vyyr1fMH+YDNSnMWHbVJ19p5TMZdVpFEuucf1N
         N1WQ==
X-Gm-Message-State: ACrzQf2dFwjuNV7gFRBhB7tGsiWC84IUstePg/LbF4bHwO8r9VPM782C
        nwwuw6WIyA2KgoRV2lNBUk5RNX+6phpR
X-Google-Smtp-Source: AMsMyM5tO6y0k8njxIt5kjzYDyBsqJglP6KDTKhOmo4yRWnKOZqv0Y3diFgK9yBWalXKX4r10nJ9iA==
X-Received: by 2002:a05:6e02:1c2b:b0:2f5:7827:e74 with SMTP id m11-20020a056e021c2b00b002f578270e74mr1564499ilh.274.1663850268003;
        Thu, 22 Sep 2022 05:37:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e4c7:912a:7017:ed79? ([2600:1700:e72:80a0:e4c7:912a:7017:ed79])
        by smtp.gmail.com with ESMTPSA id q4-20020a02a984000000b0034e9ceed07csm2173049jam.88.2022.09.22.05.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 05:37:47 -0700 (PDT)
Message-ID: <bc57439a-bddc-6c1a-a51d-11498d17c206@github.com>
Date:   Thu, 22 Sep 2022 08:37:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] maintenance: make unregister idempotent
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com
References: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
 <xmqqpmfo4pc7.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqpmfo4pc7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2022 1:19 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The 'git maintenance unregister' subcommand has a step that removes the
>> current repository from the multi-valued maitenance.repo config key.
>> This fails if the repository is not listed in that key. This makes
>> running 'git maintenance unregister' twice result in a failure in the
>> second instance.
>>
>> Make this task idempotent, since the end result is the same in both
>> cases: maintenance will no longer run on this repository.
> 
> I am not sure if this is a good idea.  What is the ultimate reason
> why we want to allow running it blindly without knowing if it is
> necessary?  Is it because there is no easy way to tell if unregister
> is needed in the first place?

We want to leave the internal details of what it means to be
registered as hidden to the user. They could look for the repo in
the global config, but that seems like a hassle when they just
want to make sure they are not currently registered. 

>> +	# Expect unregister to be idempotent.
>> +	git maintenance unregister
>>  '
> 
> ... given that the user does not have any control over what to
> unregister from the command line (it is decided implicitly by where
> the user is), I am halfway OK with it.
> 
> A user with two repositories may still be upset after running
> "unregister" in the one they did not mean to, and not getting told
> about the mistake, though, e.g.
...
> I wonder if something like the "--force" option, 

I like the --force option. I'll add it in v2 and then update Scalar
to use that option.

Thanks,
-Stolee
