Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F5FC433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761B164FE0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhCLL44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhCLL4a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 06:56:30 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB2EC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:56:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so10652928pjc.2
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sAF+AzKJ4XIPgk/xpCLuazxkcLHbAvdzw0KiFVL6Vbk=;
        b=aN7wFT0dN5LJD+LZN5Mn0gs0ZcDFGxnI1LgUWaNYeZ1J1iubKY3/sHydGYts17Oew7
         49Ue0/MQ9Rj0xPpeZSBvI8/p3+l6WCuPXatFdRHYpJsXgvU7yfIzZhMVj2hC8lFAP2QV
         c5jgOXpnZoxya61wTXvgHnZfiKrKPtfGEUavp+AGV+yQAoPr6PiBfSPyp7/0yLNLLCg2
         pKOhv35o+qX/IDb4lNrzCQHqQmnMSRVT1kCPzIf2MtSXDrN+7GZm9hp8dwxUdne7fLns
         Hlb4KwnNzyTMvLCh2AYhTXBrt7MEoPzPCDf5w9YtVceE2ZdxmzSmXqePtYnhNfcQz/MV
         TFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sAF+AzKJ4XIPgk/xpCLuazxkcLHbAvdzw0KiFVL6Vbk=;
        b=UgF6om3u9kQa908DipVUQ6E2BWw33j3amis9nGYFplapUslIa9Y5u8UKEzbWI1Jhn7
         LhulaxFeOXWzIMwglGHMZHBmtM6nlTSBhPxRGh97yr1MADfxZObBsnOFHVdx3QY8P4/w
         IIlJIatXAwPAXMjxW4RCzIMbTPa3RBwOpRSrYKK8XjQk7Bw0cd4wBmEWQXJsBt9e1YHT
         r3V8WgCozasyx/PYIqCWKE9C+1LYO7Ol0J+jnFhPfUx5xA7le3vCBf0leBFz25x80drG
         2QrDuyfc6JPvzrpO6HO80uPB7uXRofiOLzoygrFY7sgnWR74iUqbh945Fd7HOf2GotTw
         SA/A==
X-Gm-Message-State: AOAM532euLoF732Fk+kORpff9Vhfwh3VBkczwVLOXEIuCmXUekkUUYYW
        LL6LLkIAXt3ojjgKBi9yt/EcN5lsxd/CLw==
X-Google-Smtp-Source: ABdhPJx2ei9KcA3hJvHMZpJ5lbi5xkn52cs78TlIn+KRcj3j4n/weI7GVop5JWgxqjGylCRb/PaJHQ==
X-Received: by 2002:a17:902:d888:b029:e6:1ca1:d7f9 with SMTP id b8-20020a170902d888b02900e61ca1d7f9mr13230058plz.17.1615550189684;
        Fri, 12 Mar 2021 03:56:29 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id g6sm5504145pfi.15.2021.03.12.03.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:56:29 -0800 (PST)
Subject: Re: [PATCH 1/3] po/README: document PO helper
To:     Junio C Hamano <gitster@pobox.com>
References: <20210311125511.51152-1-bagasdotme@gmail.com>
 <20210311125511.51152-2-bagasdotme@gmail.com>
 <CANYiYbH_U=3gN+LH7e-LBdRdcE0geAuUzoBX4O09qego0xKX-Q@mail.gmail.com>
 <xmqqa6r8c3i0.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <2600d078-9ba0-2ebc-4611-c414ef8b12dd@gmail.com>
Date:   Fri, 12 Mar 2021 18:56:27 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqa6r8c3i0.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/03/21 13.03, Junio C Hamano wrote:
> Jiang Xin <worldhello.net@gmail.com> writes:
> 
>> Bagas Sanjaya <bagasdotme@gmail.com> 于2021年3月11日周四 下午8:56写道：
>>>
>>> Document about PO helper script (po-helper.sh). It covers about
>>> installing the script and short usage examples.
>>>
>>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>> ---
>>>   po/README | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/po/README b/po/README
>>> index efd5baaf1d..9beffc2954 100644
>>> --- a/po/README
>>> +++ b/po/README
>>> @@ -286,3 +286,25 @@ Testing marked strings
>>>
>>>   Git's tests are run under LANG=C LC_ALL=C. So the tests do not need be
>>>   changed to account for translations as they're added.
>>> +
>>> +
>>> +PO Helper
>>> +---------
>>> +
>>> +To make maintaining XX.po file easier, the l10n coordinator created
>>> +po-helper.sh script. It is wrapper to gettext suite, specifically
>>
>> It's better to rename the script to other name without the suffix
>> ".sh", so we can reimplement it in other programming language. Maybe
>> we can rename it to `git-po-helper`, and host this helper in a
>> separate project on GitHub.
> 
> It might be a good move in the longer term, but if the po-helper.sh
> is working well enough to fill the need of i18n/l10n team right now,
> I think documenting the status quo would be a good way to help the
> contributors immediately.
> 
> And when we reimplement it (if that is desirable---I have no opinion
> myself), we certainly would want to update this part of the doc to
> use the name of the rewritten tool.
> 
> In any case, I expect that you to be the main reviewer on this topic
> and you will feed me the final commits, just like any other change
> in the po/* area via a pull request.  In other words, I may have
> input to the discussion on list, but I won't be applying the result
> myself---I'll be pulling from git://github.com/git-l10n/git-po.git
> repository instead.
> 
> Thanks.
> 

Grazie Junio. However, I'm more of writing documentation rather than
contributing code, so I will help for the documentation and usage
testing. But anyways, we can ask for help from other l10n contributors
who are more proficient at coding.

-- 
An old man doll... just what I always wanted! - Clara
