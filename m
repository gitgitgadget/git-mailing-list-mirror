Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14942C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 18:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E289460FE8
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 18:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhJHSzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 14:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbhJHSzI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 14:55:08 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061CCC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 11:53:11 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so8305301ote.8
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z8HeuouGysEdBv9vS7XExtAUAmyu0WphCSx6n3xkXjE=;
        b=Tugz7JD48SS0o5YgvQr6/PiOUqSpUX971unQg76PDXcqJ4XMS+PBVs4m8tO5oeTSzl
         aes6LU9I/Mvm70hXnkaomHHHcsfX50XpVzdGEXaQzq0jljlbLvekb5eRai/uMVUFEmog
         1ExkrCT60mAuFGRod+gQNPv/DCcYPmK/HCaOgA30Gkg1ETw+M9o8IPF9ErujwC9wfw18
         dNpfyxlmegUxe5u49pwYEpP7jb3GsAU6C+pMKZtMoyVclxsqwiXC7m5M5+F0m0rKoS0a
         ywYxVM8olGOjSgGN5TKlLkUYSB7av3iqr3Anxzy5TgwBZq4wFxy9WvdU/xR6GMWUAhZk
         c2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z8HeuouGysEdBv9vS7XExtAUAmyu0WphCSx6n3xkXjE=;
        b=KYPzgjEPVUyIPz5ImFsQVxiaIpgN/cA0rL9MONBKFZEZOYVGLFn2gBbMyioLmzu6Aw
         +7vdRgA4inVsGi4u734liYwws4dD4ZD2SoF5sVUkofGnQGX6rijr8Jwonl7W8/duLxlo
         VwoRLbOPIXakaUhVWuPeYCMzhvCn8wtWh3RzOk0iSQvDLaemKeI1qEsKkN4cYk+ZMeNq
         VFG6ow/l8Vlw53PPJEAbMnlv0mkIlePdPuo6t+wzPSe70EOE3M1EEf5W41dDGHelwNa0
         3aSjtT2Un7jBU7LGnyWNZgDHeHoKrOZIwQz2Ca54AeBtJcKWzzHEJu0VGAZmOaOrzrsO
         99uw==
X-Gm-Message-State: AOAM530n1f1Nore/4ti/kkZphQuPTony2C/QcYSjXPnbluGxBrc+1QEE
        dxGBtCCbTU9oAQNgYVq5bu8=
X-Google-Smtp-Source: ABdhPJz0KMLx4ozUM5f/fqL4p2tW59jKftREo3qpnYW6BGyTW/q3Oxmlw9Fz9p5OM1Cpk5igWj2Neg==
X-Received: by 2002:a9d:6655:: with SMTP id q21mr9834863otm.269.1633719190306;
        Fri, 08 Oct 2021 11:53:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f5ce:4c04:8954:5ebf? ([2600:1700:e72:80a0:f5ce:4c04:8954:5ebf])
        by smtp.gmail.com with ESMTPSA id y9sm33344ote.39.2021.10.08.11.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 11:53:09 -0700 (PDT)
Message-ID: <e281c2e2-2044-1a11-e2bc-5ab3ee92c300@gmail.com>
Date:   Fri, 8 Oct 2021 14:53:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v3] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
 <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
 <xmqqee8wpm0u.fsf@gitster.g> <4ccaad06-a1ae-bd1b-f25d-bfa899ffa98f@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <4ccaad06-a1ae-bd1b-f25d-bfa899ffa98f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2021 5:09 AM, Phillip Wood wrote:
> On 07/10/2021 22:23, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>>       * Fixed the spelling of Stolee's name (sorry Stolee)
>>>       * Added "-q" to the test to prevent a failure on Microsoft's fork[1]
>>>           [1]
>>>      https://lore.kernel.org/git/ebbe8616-0863-812b-e112-103680f7298b@gmail.com/
>>
>> I've seen the exchange, but ...
>>
>>> -    for OPERATION in "merge -m merge" cherry-pick rebase
>>> +    for OPERATION in "merge -m merge" cherry-pick "rebase --apply -q" "rebase --merge"
>>>       do
>>
>> ... it looks too strange that only one of them requires a "--quiet"
>> option.  Is it a possibility to get whoever's fork corrected so that
>> it behaves sensibly without requiring the "-q" option only for the
>> particular rebase backend?
> 
> The issue is caused by a patch that Microsoft is carrying that stops apply from creating paths with the skip-worktree bit set. As they're upstreaming their sparse index and checkout work I expect it will show up on the list sooner or later. I agree the "-q" is odd and it also means the test is weaker but I'm not sure what else we can do.

That particular patch is old and is due to some interactions with
how VFS for Git (ab)uses the skip-worktree bit. I'm not sure it will
ever come upstream. It is probably very much like a recent example [1]
that we tried to upstream only to realize that it should be replaced
with something better.

[1] https://lore.kernel.org/git/65905bf4e001118e8b9ced95c1bcecbacb6334ac.1633013461.git.gitgitgadget@gmail.com/

I'm fine to leave the `-q` out of this patch and I can add it myself
when we take this into microsoft/git. That can also motivate me to
rethink that patch.

Thanks,
-Stolee
