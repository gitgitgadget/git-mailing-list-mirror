Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1678FC00528
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjHASmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjHASml (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:42:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E542D79
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:42:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so27284375e9.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690915338; x=1691520138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TSmcFr3Q++JH3/B/QTskSPuc9UXITxH1JMIMSf/pnEs=;
        b=XWcXkpC5nMnVuxL+iiNiHEqXerSHomO8WI/nKFkMjDaqvj4P9x/j8vOI62DuWiwFNG
         JPFXw2nMCV5JzYBCactooeEb9AonY/0+z66Hj8TqPLEM6Jd83JCkPJorxMvW9df1x9Vc
         C65TRjM50wfx5SOU/way69DE7vRONyzXIwRaPiiPVRhN2TykYeCPAQtdOdwoz3ZMyjJW
         UcrrNOyv4XoJ7RiWhAUEWSvIFsEVWxAMGEs2vxpCxIX/Dz9zAmi5/SbkR96c7ywHX08k
         9fqs7ViABq/uRy4RO98T8tZ3bKjQO3C2JctpJx5gZbOtqgJ4pbBEJf71tHiQs+UJ5/OK
         FZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915338; x=1691520138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSmcFr3Q++JH3/B/QTskSPuc9UXITxH1JMIMSf/pnEs=;
        b=PMm5tHvBb9IDsXgUPM/dD4+axmAwrs+FHkUolgZk/ZK7NdQGsG+tFxFZdSg0MpQR42
         2S0dOjrXwvnWnadPp981WP8HAaZnNmguIRhR4dl8OxXYNVdPaWLiZvx+pjfPQhyWlFM3
         Zq81BcFzhIdN/D03v/RSoQrunJGWdxxgRalHVrZ78sPcugJfXAbO4SWQbtKBHd2VC+um
         29pc0FtOsZKSaQ7JUAzXNEIplVHB4qI6baMw43LrO687mQm7ioCM6MSO/+3woiZJa1fO
         7LICRBKa6hYIx3T49m7Bsyb7h9YqVmkcfCMn3HUvN1n6YMfylmJn+wepMDzakfWROY7K
         DbyQ==
X-Gm-Message-State: ABy/qLZnzE44+c8Sl/csQDfMhIwRO1ogbWZAlO6IaQtxgIZvij39qvss
        KBCkUdIF42w9BtR433ZYWbuDS7sS0Tk0ug==
X-Google-Smtp-Source: APBJJlGwF9ewdOxA/+nnsFvGJKHvbdO0Da5uLreRQd4aq7BHHI1luqv2cZiWOlYVjD4uPi3hsMCIsw==
X-Received: by 2002:a05:600c:2949:b0:3f9:9a93:217f with SMTP id n9-20020a05600c294900b003f99a93217fmr3039130wmd.3.1690915337475;
        Tue, 01 Aug 2023 11:42:17 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id t12-20020a1c770c000000b003fc06169abdsm2503721wmi.2.2023.08.01.11.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 11:42:17 -0700 (PDT)
Message-ID: <48fefaf0-6a31-0518-3424-73d93343f1d8@gmail.com>
Date:   Tue, 1 Aug 2023 19:42:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/7] rebase -i: move unlink() calls
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
 <1ab1ad2ef07687c25c1d346b5b7b26f38bafe5b9.1690903412.git.gitgitgadget@gmail.com>
 <xmqqa5vad6ea.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqa5vad6ea.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/08/2023 18:22, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> At the start of each iteration the loop that picks commits removes
>> state files from the previous pick. However some of these are only
>> written if there are conflicts and so we break out of the loop after
>> writing them. Therefore they only need to be removed when the rebase
>> continues, not in each iteration.
> 
> "They only need to be removed before the loop" assumes that the SOLE
> purpose of the removal is to give the next iteration a clean slate
> to work with, but is that really the case?  The original unlink's is
> followed by "if TODO_BREAK, break out of the loop", presumably to
> give control back to the end-user.  So three files that were not
> available to the user after "break" are now suddenly visible to
> them.

The files will never exist when the "if TODO_BREAK" is executed because 
we've removed them before entering the loop and as I tried and seemly 
failed to explain in the  commit message they are only created when 
we're about to break out of the loop.

Best Wishes

Phillip

> Perhaps that is the effect the series wanted to have.  Or it could
> be an unintended side effect that may be a regression.  Or perhaps
> the visibility of these three files (but not others?) is considered
> an implementation detail no users should ever depend on.
> 
> It is hard to tell from the above description and the patch text
> which is the case.  Care to enlighten?
> 
> Thanks.
> 
> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   sequencer.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index cc9821ece2c..de66bda9d5b 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -4656,6 +4656,10 @@ static int pick_commits(struct repository *r,
>>   	if (read_and_refresh_cache(r, opts))
>>   		return -1;
>>   
>> +	unlink(rebase_path_message());
>> +	unlink(rebase_path_stopped_sha());
>> +	unlink(rebase_path_amend());
>> +
>>   	while (todo_list->current < todo_list->nr) {
>>   		struct todo_item *item = todo_list->items + todo_list->current;
>>   		const char *arg = todo_item_get_arg(todo_list, item);
>> @@ -4679,10 +4683,7 @@ static int pick_commits(struct repository *r,
>>   						todo_list->total_nr,
>>   						opts->verbose ? "\n" : "\r");
>>   			}
>> -			unlink(rebase_path_message());
>>   			unlink(rebase_path_author_script());
>> -			unlink(rebase_path_stopped_sha());
>> -			unlink(rebase_path_amend());
>>   			unlink(git_path_merge_head(r));
>>   			unlink(git_path_auto_merge(r));
>>   			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
