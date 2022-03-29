Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D734C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 18:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240722AbiC2S4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 14:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbiC2S4o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 14:56:44 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA49C22E953
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 11:55:00 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id 10so16120975qtz.11
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6OA0sW2F99FcJCFXphFHwcHuIb7Qj9kQmNqEh/yYfJU=;
        b=a66oy4j4fJwctmXABkmGyI6/kNks+wCurgb18ekbNz243Kc3mj6T/Lv/M8VJuO/+mk
         5xJswID6imhfa7EyI9UL5X6rUpjt6F0KXOTq+DikQh/eYFFPO2H431rQMctHEfKvNXUD
         JEakwgaRxObckhoNAByjjIPRiSNy6osP0rLStNFd5tB7tqhssoSwQrR3sYJ+3aCYPASH
         pTQhQ6QTWYp5rllSd8qwLHpqlBQSc51ydg22nC7Skh/aRAJqV4PBNeZ5qIszlNivwE6G
         N7XzvM6P8ZkiClnCthWGgUCydAd4gY9Vy5oWZsK0NSeUPoj3KgP1GOxxgHu5brayoAJ9
         YD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6OA0sW2F99FcJCFXphFHwcHuIb7Qj9kQmNqEh/yYfJU=;
        b=uEJTCI3cNFW9x8YvUTE884+VlradnyGGPRVX+1pRA4heQqjYnrqrmFduIJqoMw3XX8
         tztP1lCpehHWxeJP7sGzHyK6Furq/xxnIHPT7WyikusuiE4TyzCQwcHcPmXqndPXQvM9
         Bx0KPU32fPBR1wYXFSFitjDWe065P/W4IEkrfTlC1HvDjNuZD0OwA7kSSapyX1TvIQ8t
         4OQO5cjezbYqfIVx/+h2w9Gbu16BdQIIDLG+qTe75FF3MIp9ghjfPgZearvk6S05Y9I8
         bLnnRcW8zgOuzsqHa73HA5Tc7J5yv6Ar/VeoT5EjoTVsh16UJj7OKEmFZN8rbVN3L1ku
         Vzyw==
X-Gm-Message-State: AOAM531n/0aQUsXkSe3gtC93i75KyrBnje6plRw1aVwwWc2RADvbxBgd
        mTrLEH+fa/Q4VZYovDQA5C2V
X-Google-Smtp-Source: ABdhPJxbx1/tV58EA4caLJZ48smbK7DoW6f/W3x+zuU5y525o6zCpmuml70wcMBiGXto1iI5rwdImQ==
X-Received: by 2002:ac8:7e84:0:b0:2eb:8ec5:27b6 with SMTP id w4-20020ac87e84000000b002eb8ec527b6mr423078qtj.416.1648580100055;
        Tue, 29 Mar 2022 11:55:00 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p64-20020a37a643000000b0067d9afad07asm9882004qke.76.2022.03.29.11.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 11:54:59 -0700 (PDT)
Message-ID: <d017b0c6-c06b-e8cd-55a1-6972a9ae7c52@github.com>
Date:   Tue, 29 Mar 2022 14:54:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] mv: refresh stat info for moved entry
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, reichemn@icloud.com,
        Victoria Dye <vdye@github.com>
References: <pull.1187.git.1648173419533.gitgitgadget@gmail.com>
 <pull.1187.v2.git.1648516027925.gitgitgadget@gmail.com>
 <5ca04e86-6c61-3d4e-88a0-a3c827e19e13@github.com>
 <xmqqa6d8wvwt.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqa6d8wvwt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/29/2022 12:44 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>>> Note that the test added in 't7001-mv.sh' requires a "sleep 1" to ensure the
>>> 'ctime' of the file creation will be definitively older than the 'ctime' of
>>> the renamed file in 'git mv'.
>>
>> Unfortunate that this is necessary, but it seems to be the only way
>> to handle this because of the interaction with the system clock and
>> the filesystem. There are several sleeps like this in
>> t1701-racy-split-index.sh, for example.
> 
> Does "test-tool chmtime" to tweak the filesystem timestamp help?  I
> didn't look at the specific step that uses sleep to work around.

The issue here is related to ctime, which is not modified by that
helper. It also uses utime() which does not seem to have a way to
modify ctime (which makes sense).

Thanks,
-Stolee
