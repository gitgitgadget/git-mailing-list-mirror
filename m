Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF33C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJLTTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 15:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJLTTs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 15:19:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F2265D3
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:19:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bk15so27599427wrb.13
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D6LMfvMb/4/FmaGMLfiCuygVZLsrXLOc1f5KHtS/eBo=;
        b=IXIRe+XDqo6wp/ltVvoPrZ0UN8PT3CEOqAq8DayzIdlt9Tz3SbFhyn2UgYtxvnki/Q
         3pfAfqzeLNUldvXNqWQpNvpc6wvyVGt5VQzvc45KkDUWCY3jK3aXOdD8S40/DyAdvAVs
         QwS7d2k4Lk7D96S4jfsgETPL6xOLnOTu0qEQd+NYrzUYo7AuzN5CIwnFfY8hgi0MXoE0
         C5hJ1PWeIUEnhrudsx/C/AANupjdz/5JpMV4dXvzDeYtH3A3NH4QFfGdlHlpgTy1fLaP
         o59rjjXkJ3WuhSox4IkI0FA3OzkutSRJSTKueCtOEGINQVxXtrG+MKanqaVFQyzq3zR2
         SM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6LMfvMb/4/FmaGMLfiCuygVZLsrXLOc1f5KHtS/eBo=;
        b=KXY82uA60LoRIrL8NxkGLR7wXTjJ5wJJqlnxq1kwi7pAICIYxzw+0b1Wgfzb3mWPK3
         uySOnAEnseB1CFzX9NHHSANWBd6pefwRnbPVTA6Lv/omOL4/B2FWRIogStDiAkpgUV19
         za/ZzDe9YZhc4tjHu/tpAUGbMvS5U+l53blmsGDO8Gr9qPdvLvjYpTgHtgt08PGLkEuW
         /pDxhBhHDUq17E8YtpsO7bG+MBP8eTAPGPc4EQqRRyPoWVko96tz14xN9r8YuMcAFbJg
         XgrA5tixPQwMjSqNiIHDWIgmftVPlbqKZiyLfglLsBOo2Etzg7P6VKjDEAMyOPswqRJ3
         G9og==
X-Gm-Message-State: ACrzQf0z0zlj53129fDfrMRClRfcMxzl5D0IzqNNT1kNcuth2j8NMM1W
        wY44AgfeX6t92w0ZrwGIxUQ=
X-Google-Smtp-Source: AMsMyM66noRJnhAtaY+GMXDffHSNJsUn4XhOU4sBZzAnnhgoQHvEmF+wZRf7sZ4l4HSVZl00OA18dw==
X-Received: by 2002:adf:d1ec:0:b0:22e:5c8e:813e with SMTP id g12-20020adfd1ec000000b0022e5c8e813emr18625263wrd.706.1665602384055;
        Wed, 12 Oct 2022 12:19:44 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id t2-20020adfe442000000b0021badf3cb26sm479698wrm.63.2022.10.12.12.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 12:19:43 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <37f56330-36c5-d333-0863-75e369d43d8d@dunelm.org.uk>
Date:   Wed, 12 Oct 2022 20:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 01/10] technical doc: add a design doc for the evolve
 command
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Chris Poucet <poucet@google.com>,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
 <a5eb93254191b7ae9c17ce52e056955c669ea007.1664981958.git.gitgitgadget@gmail.com>
 <35d65b75-c5c4-132a-bbd5-49d3c012c69f@github.com>
 <3384d8ab-ddbb-6e57-1663-d039fc99e0a6@dunelm.org.uk>
 <0c7a87bc-f2b7-4c9e-cfe5-b4ba6b33fee7@github.com>
In-Reply-To: <0c7a87bc-f2b7-4c9e-cfe5-b4ba6b33fee7@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

On 11/10/2022 17:59, Victoria Dye wrote:
> Phillip Wood wrote:
>> On 10/10/2022 20:35, Victoria Dye wrote:
>>> Stefan Xenos via GitGitGadget wrote:
>>> 3. Can't handle multiple changes sharing the same parent when the parent
>>>      needs to be rebased
>>>      - Since the introduction of '--update-refs' [1], this is technically
>>>        possible (although it needs a UI for the use case you mentioned).
>>
>> '--update-refs' is more limited though I think. With evolve if I have
>>
>>                    D (topic-2)
>>                   /
>>      A - B - C (topic-1)
>>                   \
>>                    E (topic-3)
>>
>> then if I checkout topic-1 and amend one of the commits I can run "git
>> evolve" to automatically rebase topic-2 & topic-3. One cannot do that with
>> "rebase --update-refs". We could extend rebase (or have a new command) so
>> that users can say "amend commit X and rebase all the branches that contain
>> it".
> 
> Sorry, let me clarify what I mean. The 'update-ref' command in a
> 'rebase-todo' script (not the '--update-refs' option) can be used to create
> a rebase script that does what's described in your example:
> 
>    label onto # A
> 
>    reset onto
>    pick 1342ab B
>    fixup 8a7f3e fixup! B
>    label branch-point-1
> 
>    pick 90d7fc C
>    label topic-1
>    update-ref refs/heads/topic-1
> 
>    reset branch-point-1
>    pick 42f92b D
>    label topic-2
>    update-ref refs/heads/topic-2
> 
>    reset branch-point-1
>    pick 06d8ec E
>    label topic-3
>    update-ref refs/heads/topic-3
> 
> So, while it'd need a less manual UI (e.g., a 'rebase --evolve' option) to
> generate that script, the 'update-ref' command makes this functionality
> possible in a rebase.

Ah, I'd misunderstood what you meant, that makes sense - thanks for 
clarifying.

Best Wishes

Phillip
