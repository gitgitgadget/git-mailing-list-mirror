Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0151DC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 20:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBIUhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 15:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBIUhX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 15:37:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CFF6312E
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 12:37:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id by3so1770917wrb.10
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 12:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jegE6p/Ztn2XinthuTK3aSPTz0TGF0cC8CqhqCvWXIw=;
        b=OQrgNmhkcpesiV6hY2k2oHn8JlSS9mBcRghknPRJ3htAMogz7u0UAuip+frqLdDduw
         FxiL3+1f8dLDEUaVEMxI77ZJSFm6/PvQMW82mx6bWX4EfHpwj+f518c+UQa5nnmmj8rD
         bthH1zZ+nK9sQWhIrKhq+inSXbUU01VKqnBaqsr+kHvtuHzqcPpZzErqMRFtpuYVy4mx
         jPz5aYwTfnkUY5CERDCTmK/lcNwZhxlnPO/qCwHiqscYC4HWI2lob9uS1CgB+0/HIcP5
         VLj1U3oX9T3Py2wZh8Q4imsGV6Httiom3RfqyCxSCN0yexL5ouSXdMwoEnRq9L7FJDyo
         ysxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jegE6p/Ztn2XinthuTK3aSPTz0TGF0cC8CqhqCvWXIw=;
        b=zRbKmgh/o2jYA+734vxrYawN3ockkEG+zlZxG3YfsjF063VMDlsUcJ2iQ+wg+qdFrz
         Irv4o7EV3ylWMbY3aOLTdmoQ7yN753oXEbZaPu2gspB8Z5vpkFFxnB4T4U97lWZfRNhH
         sI1BCQwi9aALFUXEWKxZ23Jq8RKneXLDHkqxD27ffUOZfBzhrmANCM9aHHCWPlsbPPWL
         WHKmj0y6U3XbrsrlslWXdG6/fPFwHYLwpa4XqzZ58ceIVZxvAzkFCtOUBiH+pqZis3Z3
         yeKKZIezpMveVYhpsIxundaaeRTKG8KPrfDRyyNYbB5tex328t8yqSA+dk06tz60SO8H
         McRA==
X-Gm-Message-State: AO0yUKWT9BOBBJ2M5eKc7AFqdfSvqWtyiP6ncUH0pMvrYeGTymAZ2Hrm
        G6XzmKnkbqaY+PV+lqp2QUo=
X-Google-Smtp-Source: AK7set+268qSxMXeIB+912SwOvC6GNk9l/qmGcHHy8ngA+S/JnB0AemQkP5cRp6AABOfn12w/eW/dw==
X-Received: by 2002:a05:6000:1091:b0:2c3:e5e6:f0d8 with SMTP id y17-20020a056000109100b002c3e5e6f0d8mr12010901wrw.11.1675975038405;
        Thu, 09 Feb 2023 12:37:18 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600012c300b002c54911f50bsm16040wrx.84.2023.02.09.12.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 12:37:17 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a86cda2c-71be-a19a-f269-92d095b2428d@dunelm.org.uk>
Date:   Thu, 9 Feb 2023 20:37:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 1/7] run-command: add duplicate_output_fn to
 run_processes_parallel_opts
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com
References: <20230117193041.708692-1-calvinwan@google.com>
 <20230207181706.363453-2-calvinwan@google.com>
 <cd528776-caa8-6372-0ca5-db0545947fba@dunelm.org.uk>
 <CAFySSZDeC-zc7wS7WXE+bAijVQkuin5GwLRnJ2ok7C9PRaH3+g@mail.gmail.com>
In-Reply-To: <CAFySSZDeC-zc7wS7WXE+bAijVQkuin5GwLRnJ2ok7C9PRaH3+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 08/02/2023 22:54, Calvin Wan wrote:
>>> +                     } else {
>>> +                             if (opts->duplicate_output)
>>> +                                     opts->duplicate_output(&pp->children[i].err,
>>> +                                            strlen(pp->children[i].err.buf) - n,
>>
>> Looking at how this is used in patch 7 I think it would be better to
>> pass a const char*, length pair rather than a struct strbuf*, offset pair.
>> i.e.
>>          opts->duplicate_output(pp->children[i].err.buf +
>> pp->children[i].err.len - n, n, ...)
>>
>> That would make it clear that we do not expect duplicate_output() to
>> alter the buffer and would avoid the duplicate_output() having to add
>> the offset to the start of the buffer to find the new data.
> 
> I don't think that would work since
> pp->children[i].err.buf + pp->children[i].err.len - n
> wouldn't end up as a const char* unless I'm missing something?

You can still pass it to a function that takes a const char* though and 
change type of the callback to

typedef void (*duplicate_output_fn)(const char *out, size_t offset,
				    void *pp_cb, void *pp_task_cb);

Best Wishes

Phillip
