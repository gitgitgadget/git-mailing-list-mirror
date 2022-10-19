Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6446FC433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 15:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiJSPio (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiJSPiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 11:38:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7199DDB
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 08:34:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w18so29745088wro.7
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ER6ed+4fOWe+pmI2kPGB0LqcQSGJy9KArAhpIsXCwvE=;
        b=RL/tYwd4YjCK9UvoGBX6eoKyni0sXTOhING1X8pEcJvf7akc+Nklc9BoDY597mM9XT
         dC2jgt8UDnGtnHTYRjyKCO9vjGICzzKwByhAIclBhGoxG88ny433dRMjSmPsZxOOFK+6
         u/+yWfxUiA1SsoHLL7VxI8aQfHfLTgLViBH9DKc+Fw4Dam1UJkkyAh/CCBkGntq73bax
         VQA5tx610tAoNengRk8lSypD4/64HdBVoaL3L3lqm/aGd8zA1DAk4qecaNCxxqRrS8bg
         C2J0kEfCufImUMna371qLTGa07g1hKQid/lFBEYzwF/YiKDnL2bwvBjngxEbfqKxetjx
         xo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER6ed+4fOWe+pmI2kPGB0LqcQSGJy9KArAhpIsXCwvE=;
        b=cCZQCKraEXLQoJakNERil2M5bgEa4xo7NwizvgWFaxhhaMrwh4ar+NVVOCyCvkTEfX
         jaaLlxMErUHnxKcNJMcp8w8F6nHyLG8qS26j6bwYYDWES8xnshGLeuMNp6TL12ECTqcX
         NgnWBOp8FpGS2yMXvgK1BFVnV+5AU5d/0cR9kBURBfR5Ay/MiC1sDmqexXg2R5NiBIqU
         caMCjiNXNOPr9B+4mB8w4uDnuyRU1X5UD9RiJVMOhMjKPo1o6/4QZFsW2hQZtGvu1gHG
         AxpJdmO0rYRGdhS4N/QmgRICHIewv6I+VYLjtvGLzL1WyPtIuXoagiOAhLkU09V9x3Ci
         nJhw==
X-Gm-Message-State: ACrzQf1JPp/0cQLqYymuisIL0lf+2tQySKNw99rInsKevShNyYfaiM4c
        +pecBqt5yJvR5oteUTnHrPs=
X-Google-Smtp-Source: AMsMyM4ptr531Kq2aZTUSI/X45JKAEiga2QGIxedoX3PRN/DxLuWr6MvKQmRVkGVDTb6RrEWW3gzvw==
X-Received: by 2002:a5d:4c8e:0:b0:22e:3979:7dc9 with SMTP id z14-20020a5d4c8e000000b0022e39797dc9mr5449295wrs.41.1666193579772;
        Wed, 19 Oct 2022 08:32:59 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c3b0600b003c6c2ff7f25sm350492wms.15.2022.10.19.08.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 08:32:59 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a65ea394-1c97-c8e1-8614-8a56ce86b613@dunelm.org.uk>
Date:   Wed, 19 Oct 2022 16:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/8] rebase: be stricter when reading state files
 containing oids
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
 <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
 <1d5e0419c45087c474f33d5ea6b3bcdacd072fa5.1666012665.git.gitgitgadget@gmail.com>
 <xmqqtu42z3k8.fsf@gitster.g>
In-Reply-To: <xmqqtu42z3k8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/10/2022 19:51, Junio C Hamano wrote:
>> diff --git a/commit.c b/commit.c
>> index 0db461f9735..de30b098dd3 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -59,6 +59,14 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
>>   	return c;
>>   }
>>   
>> +struct commit *lookup_commit_object (struct repository *r,
>> +				     const struct object_id *oid)
> 
> Let's lose the SP before opening parenthesis (I'll do that while
> queuing unless I forget ;-).

Sorry, thanks for fixing it up

Phillip
