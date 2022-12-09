Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D465FC4167B
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 09:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLIJEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 04:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLIJE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 04:04:28 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D3559C
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 01:04:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so5281470wma.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 01:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISH7xXoGi890MDPvWdBvBrKPj50uk97o8ysWqoztgto=;
        b=iARcYro1vUkfKpphVvhZG7KwKz1gC74BTi34rGrZ1ko4jUdm+Xq5UFMT5ef7+wkbQ5
         sp0yDIB2pYpx0ktoaLBRE1WBiUlkL7QBJzjTgyedcfA91oWBZ0XziyHZ+sYMwmkC1/ds
         Gy8afNtl24gDAsltKM/tifhR4taxp0l2l6+/4wGV52i5utb2owg+zBooVJgvfRCz/YyW
         DWAAUTo891NHrx/r4tJjkuxTB1noB36pj96sBH7jJNcZcTj/bZVcTM2zyZWsDYotkRD3
         kav37RD+/YcENCHepqhuVURUWOWVCCmNpNwcNkLYHAm+q5lq7GS5xQtR7wA5zRAjZmvr
         CzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISH7xXoGi890MDPvWdBvBrKPj50uk97o8ysWqoztgto=;
        b=UrZI7Jrz5IqeSyfwyEJTxAxScAl9EpmooJ06C8nUokiMuL+et6l6t8gDZ3pyF5xsbK
         lO8XRAi89m8Tt6eKLrh8l3L+G99H5KyNq4sgKCIDBxNnQp4mG+OlW8pj8KYYYb5N0BbU
         wD/ssVbTo2Eqkmi/AaCMG5543CisHrlBzQTXuaMpLcMqqjYaZLHWKZe9syRumaNx+P+s
         vbK7yD172lMXInASAtbAsVjUCN+rFpt8ql7jUyVGwqrUtbAOo+pzJPnZMHRdwECnVokh
         OkKy35AZFQUODmoTlieOTfBbbayNhZk1NSGAorFkbBxHZ6wQQRfNgFyqHXxPKCIy6N2T
         omPg==
X-Gm-Message-State: ANoB5plL8XAnLDMnUgLmIRVMu3hRhmuh5QR0C10QfsAAcjPd0IEIz5GQ
        fiqr20fujZGmRbFyWH4evOY=
X-Google-Smtp-Source: AA0mqf4koHa+gbf4w3yFR1k1HaIL9MlNDdMLZa3tPwB1NBSEfVSnTvjQzrNYUc4k8Z0qA+SjpwjYBA==
X-Received: by 2002:a05:600c:1da1:b0:3d0:7195:8f0f with SMTP id p33-20020a05600c1da100b003d071958f0fmr4171250wms.18.1670576665455;
        Fri, 09 Dec 2022 01:04:25 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c3b0600b003cf894dbc4fsm1250594wms.25.2022.12.09.01.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 01:04:24 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <f873ad40-f664-bdc4-a6bb-b4e4c113aff4@dunelm.org.uk>
Date:   Fri, 9 Dec 2022 09:04:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/3] [RFC] tests: add test_todo() to mark known breakages
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
 <472d05111a38276192e30f454f42aa39df51d604.1665068476.git.gitgitgadget@gmail.com>
 <07d963f0-45f2-ed8e-ea08-bcea14386a4d@github.com>
 <1b5fc712-9659-1bd6-493c-197b003d21d6@dunelm.org.uk>
 <xmqqedt92xjk.fsf@gitster.g>
In-Reply-To: <xmqqedt92xjk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 09/12/2022 01:09, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I added the restrictions to 'test_todo' to try and stop it being
>> misused but I'm happy to relax them if needed. I'm keen that test_todo
>> is able to distinguish between an expected failure and a failure due
>> to the wrapped command being misused e.g. 'test_todo grep
>> --invalid-option' should report an error.
> 
> Hmm, but it is not useful if the failure is from "you cannot use the
> system command grep with test_todo", as the (implicitly) encouraged
> "fix" the developer who wrote the test would pick would be to use
> "! grep --invalid-option" which would still fail for a wrong reason.
> 
> If a "git" command is expected to run to a completion but is
> currently broken and produces a wrong output, it would be very
> useful to be able to write
> 
> 	git command --args >actual &&
> 	test_todo grep -e "$expected_token" actual
> 
> to say "when 'git command' is fixed, the output should contains
> this, but we know it currently is broken".

You can do that now, the next patch adds support for "test_todo [!] 
grep" but you currently cannot pass arbitrary commands/helper functions.

Best Wishes

Phillip

>> I think you've convinced be to remove the restrictions on what can be
>> wrapped by 'test_todo' when I re-roll.
>>
>> Thanks for your thoughtful comments
> 
> Thanks.
