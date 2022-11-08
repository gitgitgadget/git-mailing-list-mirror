Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3620C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 09:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiKHJyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 04:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiKHJyH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 04:54:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDB713DD8
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 01:54:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w14so20065963wru.8
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 01:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/6bo3MNxCsVNMAduKwGDIZjUa9ySHNNkxgaarjfbyY=;
        b=nOHO5WM9lwdezPu8jZea00f8b72Lq+73LdZ0ab/lsxzSSNBMGbTvWBN3FnGxomMfM3
         3Xyh8k7uaINhMoOS1FzQcV/NTKDsp2LNAvWNSRsRJsGXwW5VWUOK9CKtxgz7vI0Oq9UO
         OrdRvpGL6meDUAVXJR0/Qm7MQZ+ErPbVS/etl//9f7fUVHFk9d383EySygfsTtjdq8Ht
         djRZmNdLAmses+XbGnXBJn3rXs4yEhorKUGOi5ceqQfyrvneE1Zi/8GWi/AQbrQHY4AN
         EpUNdoa6IHBb7bzpAae7vvOU/pNpsTzd94sVkgg2ahLHYiCJCm6QS5goMGMLkDY98p6N
         6cRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/6bo3MNxCsVNMAduKwGDIZjUa9ySHNNkxgaarjfbyY=;
        b=LEaUyjlqZ0FQ8+mM3scuCJKpDIjEbi2bgGfhhHlfbgur0DQ2eoXsT79hiqhMv2Ed3f
         DRFj19VbzDvoabUBKMRmbyjoqCLHx5v75zuZ/cnj/H3k/y4jjwwrZYZblkbiLqIaWO3o
         fgD2KIvDeQxekBg25X72gw6AgQP5nFGI9pRmMpfelKUTrymFTMzQvAlKL7DX4Vvi7tt1
         YDBOgIlnNbyvnc+bvaYog837WhLZbgiD4Cad/RHP0GxxSzySdbuRo67DqLQ9cdtDFS61
         AaHak8FF4aG2RLzEthZlcuZ9huUCxzNLYq8uo2tRXAxks/NRtJGsRB/vILGgiSqj9+WB
         x5qA==
X-Gm-Message-State: ACrzQf1LquLcZhkrZPyWlU4Gg9xLpybSrR50/yt5ep1gjQRAeXzXV/P3
        iMBUn6SRpYOSIDquYQB3/n8=
X-Google-Smtp-Source: AMsMyM6dB+lcYBlYLf0a2pkKVFvVMcLr4uRpl0l8ryufFZugMiUv5FlAyprmRMsDl599b6Pt+/e3LA==
X-Received: by 2002:adf:e19e:0:b0:22e:64de:39fa with SMTP id az30-20020adfe19e000000b0022e64de39famr33314498wrb.369.1667901244205;
        Tue, 08 Nov 2022 01:54:04 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id v2-20020adfedc2000000b00228daaa84aesm9740100wro.25.2022.11.08.01.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 01:54:03 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <16baa0cd-0797-4427-3e39-e5ffd2dca544@dunelm.org.uk>
Date:   Tue, 8 Nov 2022 09:54:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] sequencer: stop exporting GIT_REFLOG_ACTION
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
 <e9c3f5ac5c6b7a01ee9e43730889d8066a270271.1667575142.git.gitgitgadget@gmail.com>
 <221107.86iljqvhzf.gmgdl@evledraar.gmail.com>
 <03cd4cdb-5f6b-11b9-1959-d58d5b544565@dunelm.org.uk>
In-Reply-To: <03cd4cdb-5f6b-11b9-1959-d58d5b544565@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 07/11/2022 19:35, Phillip Wood wrote:
>>> @@ -5116,7 +5121,7 @@ static int single_pick(struct repository *r,
>>>               TODO_PICK : TODO_REVERT;
>>>       item.commit = cmit;
>>> -    setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>>> +    opts->reflog_message = sequencer_reflog_action(opts);
>>>       return do_pick_commit(r, &item, opts, 0, &check_todo);
>>
>> Here you're adding a new memory leak, which you can see if you run
>> e.g. the 1st test of ./t1013-read-tree-submodule.sh before & after this
>> change.

What's a read-tree test using rebase for? I find the submodule tests 
completely incomprehensible. It is calling 
test_submodule_switch_recursing_with_args() which does not call rebase 
directly but who knows what is going on in all the helper functions. 
Have you got a simple example of a test which shows a new leak?

> I'm not sure how, opts->reflog_message will be a copy of 
> opts->reflog_action which is freed at the end of the rebase. I'll have a 
> proper look tomorrow to see if I'm missing something.

So it is possible this is showing up because I think we only free the 
heap allocated members of opts in sequencer_remove_state() and that is 
not called when we stop for a conflict resolution, a break command, a 
failed exec or a rescheduled pick/reset etc. The way to fix that would 
be to refactor sequencer_remove_state() to create replay_opts_release() 
and call that from builtin/{revert,rebase}.c

As that is unrelated to removing the setenv() calls which is the focus 
of this series I will not be doing that in this series.

> Best Wishes
> 
> Phillip
