Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725E9C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 12:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244912AbiDZNAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 09:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiDZNAw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 09:00:52 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5251749F4
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 05:57:45 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r12so19505677iod.6
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KMLhy8i9Bap5G8IXEMLs95FM7BnmfC0apmP8taZx7lw=;
        b=hZ7uUxpKMlvc42/rOilqYRxTjMcRipkJgrcUWhEUgDH1oX3ZvvO1Nd8RJg2ycdJb7c
         KDiYAEGdYb/pBsUp61e84ZrWa+RTyyNqqCb6NHIcj1BIMTRlTsxI/pyoAwiJeRqNqwiC
         CnmqmZZQnQ94pTB5Yy9r5SRdHpAIIiqhHq7FrryMuzEY0bUOkakTtEkwr1arSWTk0hQY
         X9hFyEO9UkrQZvnZKVkk8j2QMQvbpQEs7kA1VQMw75X3+68TQa7zp0OI0Znwe1Zc6Jdw
         /TRh0XCg+wa67Mh5s/MX6ayq9gGpSo6RNW6LnTUsdBboGtXvShELsbxzkTFNJG+k/Caf
         QbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KMLhy8i9Bap5G8IXEMLs95FM7BnmfC0apmP8taZx7lw=;
        b=uGB+pqrwDKI+gtIfTDsdXv2jlTiZ0oMBhU/VNnpsKwvjUv88+2/8YEPOUrSzmJAzo3
         SpLYQbRM8VQhxH8rb3a54AN5Zpon4hXegPCck10b5IAKRsLn9R+RAc2yeKWlrFbkFav7
         pGXxeCzZbsoipGcEIiG1jdZMYyg1YBFPQU1ZTjM3AB1PKFvRMzQLupl80Q4u7we5wQ+v
         S+ZnqBVwR47pvtKEYFO+Z74db0BPReB14vq90CJApLi5x4p9OGq/X1UM2XISLz0i+G9q
         AO5e2MOWq+F1rSiJiGOHDpt+eUh1ZvLaqekQQrQ46GDv84nJ9o1T8M2SzBXD9oY753bW
         3spQ==
X-Gm-Message-State: AOAM531uR3VQo5cDeCrtFMWyv9X6hSEIHBdQySwa4d5NTeCS7hUxw0ZW
        2HwojPJKz9HhqFEQAUjJh0f/
X-Google-Smtp-Source: ABdhPJwU8yknI6cLnD1YJTYutTDvh4Tg726K+R1d+PKJe0RjS4CurmA2auPF5LLNS5PE55hs4w00IQ==
X-Received: by 2002:a05:6638:4810:b0:32b:b3e:431e with SMTP id cp16-20020a056638481000b0032b0b3e431emr579049jab.262.1650977864501;
        Tue, 26 Apr 2022 05:57:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a3:141e:f20d:6edf? ([2600:1700:e72:80a0:a3:141e:f20d:6edf])
        by smtp.gmail.com with ESMTPSA id r14-20020a92ce8e000000b002cd66e0bbc1sm7885219ilo.33.2022.04.26.05.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 05:57:44 -0700 (PDT)
Message-ID: <6db07cef-8536-62fd-ad56-f6ef6736ab22@github.com>
Date:   Tue, 26 Apr 2022 08:57:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/7] merge-recursive: add merge function arg to
 'merge_recursive_generic'
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Victoria Dye <vdye@github.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
 <80c25c7587484ca32afcfd6cc054eab78dd1348a.1650908958.git.gitgitgadget@gmail.com>
 <xmqqwnfcu9mi.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqwnfcu9mi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/2022 5:38 PM, Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> -	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
>> +	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, merge_recursive, &result)) {
> 
> This one does need input from Elijah to properly evaluate.  Off the
> top of my head, I wonder if the choice of the merge function should
> be part of "struct merge_options".
 
I agree that when we have an options struct, it is better to add a
member to the struct than to update the prototype of the function,
if only for the simplicity of not updating all callers.

I am interested in the effect that moving from recursive to ORT for
all 'git stash' commands might have, regardless of sparse index. I
expect 'git stash' to improve on a number of dimensions with that
change.

Thanks,
-Stolee
