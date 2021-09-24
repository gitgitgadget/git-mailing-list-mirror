Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0396C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 10:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B611A60EE4
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 10:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245624AbhIXKSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 06:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245573AbhIXKR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 06:17:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BC4C061574
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 03:16:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d6so25697622wrc.11
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GBpYA93UwUX/rH2xcUzeQMHgCPO+kB6170R1RX+CgV4=;
        b=dMO1qc9yQMit1VFgFebvgckmaP4tjWPiD7s2fHFQ7i1aylea1zwAUbxZ/0Rxl/F0bV
         452puvb8+fj1QgDQccYkSGayahZN5Ybfp8u2kgr2NHnysZoq7BYmjO/qwsJAKqakCKb9
         HnXKdd1MqvLN6Dj16KHa66nIu7Lr/IqfEBwpkcgnBt5FNWP0zlWtp/dgxpPh+Im8rOp9
         62ZTmZAIq2GSIuH4hClC1tpIn0CzAWwtEiw8OnrmpJIQ0yBpra/KCkYKp3n9XaJbyINf
         K6kF9GgLuZRmb/6oVmBnaWqxoiHrqF2COvinNK1MkPWxS+sTs72n2CCzLEWwCrapgkaz
         EV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GBpYA93UwUX/rH2xcUzeQMHgCPO+kB6170R1RX+CgV4=;
        b=dR4IuHFRXXTeIf6uu62yRl9JW1iJerEyyOWC2jQA5f+ZzFgVM+b90F6womgGIG8LoL
         3f+46MvQdDeb7iV/U95vZ+7Kc4my72WJaoVKr0o5ceA8yZ3ve8XMnz8YVwObHlMErSHs
         zinGq0KZxzUZEnWzcHQA09AivJmSighx/FwlBf0qYnjLbm/msFYqsOxgAmIU9kGRwUAX
         g/VPL+KIJ8eZCPbIfXGChE1FZ2KaRuhFH+stV9DsWTWHA0WSKgxx9PvIxQz2bcbW01qX
         qV7h97+hT+TCcfkzW3xnANlr8A0dA2DCoV/sZzagce6AjUu3dNLDUyqroVzGQkWTdgXM
         LdMw==
X-Gm-Message-State: AOAM531bJ9lvreSLdFTl64kcw4oeNnycZ/OsuNjvLOvTtB9XKrLwvVfw
        ZvZNllZHXIjujfI3S50248g=
X-Google-Smtp-Source: ABdhPJzotTL/3JqLiokRgTvNoz9nTU/npoi0EMBhju1bPnRTmy4YTQMQ8+VAN6s/+7DjOA/yTxvzUw==
X-Received: by 2002:adf:e390:: with SMTP id e16mr10533095wrm.217.1632478585288;
        Fri, 24 Sep 2021 03:16:25 -0700 (PDT)
Received: from [192.168.1.201] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.googlemail.com with ESMTPSA id 4sm7282565wmv.42.2021.09.24.03.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 03:16:24 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] xdiff: implement a zealous diff3, or "zdiff3"
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <pull.1036.v2.git.git.1631379829.gitgitgadget@gmail.com>
 <06e04c88dea3e15a90f0a11795b7a8eea3533bc8.1631379829.git.gitgitgadget@gmail.com>
 <b6818661-ac6e-fbde-2cab-429c5550a0da@gmail.com>
 <CABPp-BFQ8wDinW9MuOU6FuGq_h5W=4nv2hVhO0R6bbCxzv_Vyg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3f5e1569-4ccd-8494-ea18-1e00bdc73017@gmail.com>
Date:   Fri, 24 Sep 2021 11:16:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFQ8wDinW9MuOU6FuGq_h5W=4nv2hVhO0R6bbCxzv_Vyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 18/09/2021 23:04, Elijah Newren wrote:
> Hi Phillip,
> [...]
>> I do wonder (though a brief try failed to trigger it) if there are cases
>> where the diff algorithm does something "clever" which means it does not
>> treat a common prefix or suffix as unchanged (see d2f82950a9
>> ("Re(-re)*fix trim_common_tail()", 2007-12-20) for a related issue). We
>> could just trim the common prefix and suffix from the two sides
>> ourselves using xdl_recmatch().
> 
> You seem to understand the xdl stuff much better than I.  I'm not sure
> how xdl_recmatch() would be called or where.  Would you like to take
> over the patches?

I could do if you really want but I wont have time to do anything for at 
least a couple of weeks (I really need to get on top of my current 
series before starting anything new). I outlined the rough idea in [1]. 
tldr; instead of diffing the two sides of the conflict just walk the 
start and the end of the two sides until we find a line that does not match.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/f76c79d6-f280-3011-d88d-6de146977626@gmail.com/

