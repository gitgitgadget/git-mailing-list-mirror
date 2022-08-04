Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A694AC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 14:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbiHDOvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbiHDOvA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 10:51:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75D62613B
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 07:50:59 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id d139so1553719iof.4
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=qgbDhdYRVLZ1vncGxF+6y9p+ikaWTZ7nlahfJAmScUg=;
        b=HNRZGKcvvQwYBU7PiuPnUJpTJyG+/JeQRKP/+CgHq2kT9T38ZeeAVc6CGl24obr+tY
         cAZHi8+8moS3uh4IbRnUoiZ2wpocNh9hjzLzpQRMOelqZ+2h1asm/bDGTA0LoQWSrUuB
         hRsnZhxGdvjoECVrRo2vcIWtGPa/9mnDwLzCmrVqjMawzoeLyJLvzeGEVwjU5CE9Qq1l
         fv9ErIbeXBrVQ+gckxD2YCrepRujUC1NmnT7yKR6lWSKmpnFHnzrsm7Q2KCsLHTo3Nek
         qEoqrJ3p8aQPbotIvdPn8ZT4frnbw6IzF47iHqM/aczKFKfnfCRFsR+r1wNAU48AUaZm
         RshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=qgbDhdYRVLZ1vncGxF+6y9p+ikaWTZ7nlahfJAmScUg=;
        b=kQKmkB8oOGQ/5VeC/iAHy1gCssMMuHfHZDhakyenc7HiLMJ8xVdo7TG3S9PWCToRB7
         lY0VAEbC5BwSKDXAjm8Wniki3q7Pfqko7IjjMTfuT2yIZAnv6noJ4F7SYtB5IKE88h5k
         cwm1Yoa5DPbbtzlFyMTa7Ww2HF0fON3XaSRvPISZqsO7rrnqrR+SD6YJIaSXF8yGG7wE
         Nzkzx9uik9wjnZPNeZVyLu9KXGpxzr7B8TGgKFVk04ZCZiJ9qnWah1iIWD+09/UD40ci
         o/lnHc95AO8B7RuqgTAHQ6yYl8j/XXTosTJYVjP+nZwPj2J6VO01HbLLDtbslzGK+mly
         m7yg==
X-Gm-Message-State: ACgBeo3Zh/vv/YY43hbrKf7L8qkHYl7ShDvjMySoCbNrsf/ny4vRo7en
        u5WJ5jowqO7QYBRqztjdKZCy
X-Google-Smtp-Source: AA6agR7g8dc8Idpdl/kuV5r/piyTLj0Uo8j8HYRzcpKQ0R4PVDf00z32SDm3D41XykiL1oMpImUVAA==
X-Received: by 2002:a05:6638:1342:b0:342:7280:d5c3 with SMTP id u2-20020a056638134200b003427280d5c3mr1012421jad.156.1659624659094;
        Thu, 04 Aug 2022 07:50:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id x10-20020a92de0a000000b002de30ec2084sm489767ilm.75.2022.08.04.07.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 07:50:58 -0700 (PDT)
Message-ID: <96cf691b-5190-5ba7-d612-e8473055c45c@github.com>
Date:   Thu, 4 Aug 2022 10:50:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 05/10] log-tree: use ref_namespaces instead of
 if/else-if
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <53b15a0b7932f892505d07a509909b62c473037e.1659122979.git.gitgitgadget@gmail.com>
 <xmqqv8r9dei7.fsf@gitster.g>
 <b4f07dd1-b59d-864b-f881-110c9bf87202@github.com>
 <2d24b539-a5b8-ed7d-2320-97588854eb5b@github.com>
In-Reply-To: <2d24b539-a5b8-ed7d-2320-97588854eb5b@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2022 10:34 AM, Derrick Stolee wrote:
> On 8/4/2022 9:31 AM, Derrick Stolee wrote:
>> On 8/3/2022 2:31 AM, Junio C Hamano wrote:

>>> Very nice.  The double-dash in the NAMESPACE__COUNT constant somehow
>>> looks strange.  As we scan through ref_namespace[] array densely,
>>>
>>> 	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++)
>>> 		...
>>>
>>> without having to use the constant would probably be more in line
>>> with the way how the rest of the codebase works.
>>
>> Ah, I did not know about that trick. Thanks!
> 
> ...except that it doesn't work because the array is declared as
> 'extern' so we don't know its size outside of refs.c.
> 
> This motivates the use of NAMESPACE__COUNT (and the double
> underscores differentiates the "COUNT" from other namespaces, so
> there is no confusion about "COUNT" being a namespace). If there
> is another way around this, then I would love to hear it!

My current workaround is to define the size of the array in the
header file:

---

enum ref_namespace {
	NAMESPACE_HEAD,
	NAMESPACE_BRANCHES,
	NAMESPACE_TAGS,
	NAMESPACE_REMOTE_REFS,
	NAMESPACE_STASH,
	NAMESPACE_REPLACE,
	NAMESPACE_NOTES,
	NAMESPACE_PREFETCH,
	NAMESPACE_REWRITTEN,

	/* Must be last */
	NAMESPACE__COUNT
};

/* See refs.c for the contents of this array. */
extern struct ref_namespace_info ref_namespaces[NAMESPACE__COUNT];

---

Then ARRAY_SIZE(ref_namespaces) works properly.

Thanks,
-Stolee
