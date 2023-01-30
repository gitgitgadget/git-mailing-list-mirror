Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED07AC54EAA
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 19:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbjA3TNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 14:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbjA3TM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 14:12:58 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E952C66B
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 11:12:45 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id x15-20020a4ab90f000000b004e64a0a967fso1411941ooo.2
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 11:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9MEK1+P998O1167GFE7aFuI5yCicX9x2PXw8BbP/8EU=;
        b=JooBIyTm6g53sTAWBgU9xOEfnR4RoDTvZzLnDUzhSdU9YewJWcTAa8qMuRJtRt9eMN
         VtAfh56U0vP54CRFgKzKiRyI22R5cmvRGuYx4aRiFpp+pZr665t7FzaW990tlSIm7KeF
         z6inANah34xwF4cqqhKBMhZCE6W7Q0cluGRe4GXd3Lou7stvWNVTHa7oHtGC7R5PaK5p
         gKT2zod3su/9OrtRwHuaHF/c3/5ZfSF6C6jXMxmKnZIGe30HPkLeMdhR7Gn4RjCLnVUm
         7ZA1gh6Gjk+YzbaEFgxXY2cipU/Fc5lQbmPveLf4rTBUK6idORjoVd3grIupSmsYW7Jy
         j/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MEK1+P998O1167GFE7aFuI5yCicX9x2PXw8BbP/8EU=;
        b=Ot/5f4jTkgPjHGdHLF9Tqi4L3HgdT6KsLMMFnGW8FtIvw8JlPJrS6q0tAydG7witsP
         DrFWaMIbn2a0PzslmlGQ/3nwbkTGs7/HCg3wwuuT4EwAYPAFe366nD5sUJ15E7fpd2nd
         8uTe7XunO8MPzGwX/JXJ2HnlxhpFQjLMPwmM2UKNINqx+VuQV9zi6t6zs7OWVYE2ENiR
         TEYh50YrZe1xj+pEUlfcDOryQoGCu71to7cDjkfO3wlLgjwL8z9YiR54dxo4QDm1BjXO
         FW75RJ8vvdVNDanIv1MuOXaa9ZXfKTsNP8ObFEyByDUjdZFFn6m8UXxzlRAk5hRDtHWd
         6HGg==
X-Gm-Message-State: AO0yUKVCp++qaStYoHNZkXGrBynfXjNs6fbShIi8zi33RyxMkO9qW33K
        eSaS9JSzgANcMBkHMXsK6aRN
X-Google-Smtp-Source: AK7set+WEbGo1bThQONOgWpxVgTSlFFO69qmJjjxW8OnDAdp0QJ0eMSmOZ6X6BTgJS2VCxwoBihTEQ==
X-Received: by 2002:a4a:4881:0:b0:517:98ae:b441 with SMTP id p123-20020a4a4881000000b0051798aeb441mr1124891ooa.1.1675105964854;
        Mon, 30 Jan 2023 11:12:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ecb7:2dbf:e64c:6f68? ([2600:1700:e72:80a0:ecb7:2dbf:e64c:6f68])
        by smtp.gmail.com with ESMTPSA id e79-20020a4a5552000000b0051765eb8c25sm2209344oob.10.2023.01.30.11.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 11:12:44 -0800 (PST)
Message-ID: <b6b76b2c-3a81-a612-d2ca-93b2b660feeb@github.com>
Date:   Mon, 30 Jan 2023 14:12:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 05/10] bundle-uri: download in creationToken order
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
 <7cfaa3c518cbedb65c585cc02015bb21ae24e9fa.1674487310.git.gitgitgadget@gmail.com>
 <a2896d5b-f395-68df-1f23-356d0128cb9c@github.com>
 <xmqqpmaz93k3.fsf@gitster.g>
 <07c4658e-89dd-0f82-77e9-e7c443f747cd@github.com>
 <xmqqtu073kx1.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqtu073kx1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2023 2:02 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> I think there are two possible directions we can have when talking
>> about interrupted downloads:
>>
>> 1. The network connection was disconnected, and the client may want
>>    to respond to that with a retry and a ranged request.
>>
>> 2. The client process itself terminates for some reason, and a
>>    second process recognizes that some of the data already exists
>>    and could be used for a range request of the remainder.
... 
> Mostly.  We probably do not want / need to cater to "I killed it
> with ^C and would want to continue".

I mention it because it has been mentioned to me as an example use
case. This includes other failures, such as power outages.

I don't think we have range requests enabled for the longer-lived
packfile-uri, but we shall see if adoption of bundle URIs presents
more motivation to build that feature. Case (1) will be the easiest
to consider, and I agree that it would be more generally useful.

Thanks,
-Stolee
