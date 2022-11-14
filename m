Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA6EC4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 16:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbiKNQfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 11:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbiKNQen (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 11:34:43 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5513FBA9
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 08:30:55 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y6so8547394iof.9
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 08:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K01Ij9Lj9qFQryVIHZMia94JPb08fdAETgf2ujNDRgg=;
        b=P2H8V5fBEk2jMSe1bB1S0WMqSpa04+A8LFfY5gBGIdIc0iUjVQFYGyjDXZ40lteeWc
         CBeWoQ6ILiA8htL7pbSvileCBuIZmp5G1JDDouZOgETjeKD6qBJdcVgfWVNVsvaYYeNZ
         +BzOFKVnmlmFOb8XloRfWzqtw5FMdnjCxLihRuPE/civypa/5ZFEal4/cUg9DVxd0QAc
         4pkBmYFRIk/UylSMjtXmou3jC6jGQaAW1MrsVrSj4+6dyMRT41jcO75zK+6fhrWg4I/7
         6mJ7JpQMFwdhJ6COp1vyBI+g1ZOYjcBuO8uk8U3EFzbs/Y9Pn2Lscw8w6irT6Dn0AI4L
         IpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K01Ij9Lj9qFQryVIHZMia94JPb08fdAETgf2ujNDRgg=;
        b=NLpdm07Hi0D7Si/UE1rV6z/84aAv8DHZqvy93p0cG8pJPDVNhWVH3ZYrUTIk6sElWk
         Gs0qRqzK/0CMwOKFHtM1RuyEKbWGhdP3efaYi+sJCs7Kg5w8Sp5307tycmjkFUe3ZmZs
         kSpIqyoWYGy0acggHfE4JK7NX+8OseC6injHCgFpOkIrveQc5SNu/NR2YDPf6XRmJZY2
         3K3vSpAw2k885TWa7xforNdsASPkPijJ10+RXpzAwFN8KCNXJMPA7zvEruoPsqJowT1+
         VNf1/jAIpbr1VVeM6BNn1nTvkMRBIJX4NmIt/Q/d9bK0ghQa/dC6lI0hMtEasTH1/UXW
         3NuA==
X-Gm-Message-State: ANoB5plBbFpEVtHOh6Qf7WtVvFPWB3WOyWCFMYJnIy2RAnSQ9IupDW/w
        fb5MBq6Av6aN/xyKok9jPExq
X-Google-Smtp-Source: AA0mqf4E8r07ZBSmn8sFp1MN0o/JUxI0B9QQqXtgi35dB2U5l3Am+OVQQSVOrAz78Ri6L3orVrlkLA==
X-Received: by 2002:a05:6638:227:b0:375:1b48:1e61 with SMTP id f7-20020a056638022700b003751b481e61mr6155738jaq.269.1668443443742;
        Mon, 14 Nov 2022 08:30:43 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:25ec:70af:bd50:7ae0? ([2600:1700:e72:80a0:25ec:70af:bd50:7ae0])
        by smtp.gmail.com with ESMTPSA id d14-20020a023f0e000000b003757ab96c08sm3651964jaa.67.2022.11.14.08.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:30:43 -0800 (PST)
Message-ID: <ca39e1d3-b08c-6ed3-8ab5-238efbd1f2dc@github.com>
Date:   Mon, 14 Nov 2022 11:30:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/30] read-cache: add index.computeHash config option
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <030d76f52af654470026b0c4b1dfba2b6c996885.1667846164.git.gitgitgadget@gmail.com>
 <CABPp-BEvF3XF+udzTkEtgrtXqYuYEeYi0R65EY5gCespwZgOeg@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BEvF3XF+udzTkEtgrtXqYuYEeYi0R65EY5gCespwZgOeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2022 6:31 PM, Elijah Newren wrote:
> On Mon, Nov 7, 2022 at 10:48 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The previous change allowed skipping the hashing portion of the
>> hashwrite API, using it instead as a buffered write API. Disabling the
>> hashwrite can be particularly helpful when the write operation is in a
>> critical path.
>>
>> One such critical path is the writing of the index. This operation is so
>> critical that the sparse index was created specifically to reduce the
>> size of the index to make these writes (and reads) faster.
>>
>> Following a similar approach to one used in the microsoft/git fork [1],
>> add a new config option that allows disabling this hashing during the
>> index write. The cost is that we can no longer validate the contents for
>> corruption-at-rest using the trailing hash.
>>
>> [1] https://github.com/microsoft/git/commit/21fed2d91410f45d85279467f21d717a2db45201
>>
>> While older Git versions will not recognize the null hash as a special
>> case, the file format itself is still being met in terms of its
>> structure. Using this null hash will still allow Git operations to
>> function across older versions.
>>
>> The one exception is 'git fsck' which checks the hash of the index file.
>> Here, we disable this check if the trailing hash is all zeroes. We add a
>> warning to the config option that this may cause undesirable behavior
>> with older Git versions.
>>
>> As a quick comparison, I tested 'git update-index --force-write' with
>> and without index.computHash=false on a copy of the Linux kernel
>> repository.
>>
>> Benchmark 1: with hash
>>   Time (mean ± σ):      46.3 ms ±  13.8 ms    [User: 34.3 ms, System: 11.9 ms]
>>   Range (min … max):    34.3 ms …  79.1 ms    82 runs
>>
>> Benchmark 2: without hash
>>   Time (mean ± σ):      26.0 ms ±   7.9 ms    [User: 11.8 ms, System: 14.2 ms]
>>   Range (min … max):    16.3 ms …  42.0 ms    69 runs
>>
>> Summary
>>   'without hash' ran
>>     1.78 ± 0.76 times faster than 'with hash'
>>
>> These performance benefits are substantial enough to allow users the
>> ability to opt-in to this feature, even with the potential confusion
>> with older 'git fsck' versions.
> 
> This is impressive and interesting...but an improvement unrelated to
> this series other than the fact that it builds on some of it.  Perhaps
> pull this patch out?

While patch 1 is required for the packed-refs work, this one is an easy
way to take advantage of it. I'll submit these two patches soon on their
own as the rest of the RFC is discussed.

> Also, would it make sense to integrate index.computeHash with feature.manyFiles?

It would make sense to include in feature.manyFiles and Scalar's recommended
config. I expect that it would be good to have the config available in a Git
release before updating those configs to include it. Perhaps that is too
conservative, though.

Thanks,
-Stolee
