Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC52C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 18:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B043120719
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 18:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNaQ41Ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgKDSna (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 13:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKDSna (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 13:43:30 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DCFC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 10:43:30 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id dj6so6420726qvb.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 10:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ngZ2vRvC0MwI4q/C1pNTgOQN539tsWEE5cZWrBdmvGg=;
        b=cNaQ41MlUaMcriWp1u8OsVYLSQOgh+MPu//IVUgyT97wIi6spWA7TCmNpxasyyxbbo
         3h3RY95fRYlzNKtoyD/Ze/42FCb/1dz+vkpPf+HbAVxq5k+PPb2NXughmFIRAFhoVv3/
         9blKMo07Ic62fFqSdBN4w3gQPw7v/Dn8jasKGHP0y1+DgHanlgBWlKzNVg3ywZLvMRw4
         h+fnM4bXG6zYrsl/alDnGo9yXnh7VnOdL1ZizWdMzb+kMPc3q0jbg8uk/tKO6Uslsjxh
         +6+bvfJ5PkX0C5c7PjEIKC0cP3+kz6G6ckLYegWPPn1m5F0iGdFl6Xtr5h2hFqy3Qayj
         PFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ngZ2vRvC0MwI4q/C1pNTgOQN539tsWEE5cZWrBdmvGg=;
        b=gBunThaq6BKptz+zCjNYJjPm0WU/ueec18JTvoBquRmAKWUtEknyHdVYvOUWdAB3VB
         0U6u9SaowBHs4XuP5T9bUlcK1FJ4S//FvmibMye1qp0BU7wPKabQJej7wp+ltXJ5AolF
         HhQ90OnU2AUGH4DdVBuJ5CCfmwW5nRfC3HOLQurFvUZrHawcE7qagbXKByMx9xwhPcBd
         gO+x3e8Wjrq5mgnP0CREOFEn7n4y/jRhvwNuOFyAiEOoSvZh93NIj4ZCi0xzPNjCeTRO
         v49JR00v5N0w2BS8FrngJl/iN/I7TKhJ6rP5vckTMy6OQnAeQ6g5sjZ6KeDYouwzVK3V
         r2Ow==
X-Gm-Message-State: AOAM533Tyskp3ew/CGyFDi55GK/NuEgRW8j2EupaHOiIgXj2J5ONA51i
        zVf8X2VkQoGURBQG0D1C6PlP343aFWlFLQ==
X-Google-Smtp-Source: ABdhPJzYoTesz4wS6Cx8YDdnP2uEn8eb+8k6X7KNEL+YkgfGQIo+fO0dsewjfXHllxXzTT6sRUDCqA==
X-Received: by 2002:a0c:f706:: with SMTP id w6mr34961262qvn.48.1604515409337;
        Wed, 04 Nov 2020 10:43:29 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id m2sm798411qtu.62.2020.11.04.10.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:43:28 -0800 (PST)
Subject: Re: [PATCH 0/3] Maintenance IV: Platform-specific background
 maintenance
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
 <xmqqmtzyqjil.fsf@gitster.c.googlers.com>
 <022c5792-e66c-71d8-fbf4-ead9231030ad@gmail.com>
 <xmqqo8keoyy8.fsf@gitster.c.googlers.com>
 <af2befd7-7d93-5981-42c8-700e49f3999a@gmail.com>
 <xmqqblgdnjjx.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <56d6524f-c8ac-a303-d9e4-aef1b082dc74@gmail.com>
Date:   Wed, 4 Nov 2020 13:43:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <xmqqblgdnjjx.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/4/2020 12:00 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 11/3/2020 5:30 PM, Junio C Hamano wrote:
>>> Derrick Stolee <stolee@gmail.com> writes:
>>>> I'm hoping that parts 3 and 4 can make it in time for 2.30,
>>>> so the feature is universally available for all platforms.
>>>> I realize that's not entirely up to just me.
>>> ...
>>> I was wondering if I should propose making these two parts into one,
>>> so we may be pretty much on the same page.
>>
>> I'm happy to have the two topics be merged into one series, but
>> I'd prefer to only re-roll these three patches during review.
>> Of course, by keeping them together we have the ability to re-
>> roll all of the patches, but part-3 has a decent length and has
>> been stable for a while.
>>
>> I defer to what is easiest for you.
> 
> Two topics, one on top of the other, is fine, as long as I can
> remember (and you help me by reminding) to keep them together,
> and the bottom one is reasonably solid that I do not have to do the
> rebasing myself ;-)

Sounds good to me. If I need to re-roll part 3, then
I'll consider replacing both parts with a new series.

Thanks,
-Stolee

