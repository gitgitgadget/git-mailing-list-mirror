Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6287BC001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 10:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjHIKGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 06:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjHIKGj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 06:06:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB7A1BFA
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 03:06:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe1d9a8ec6so3982465e9.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 03:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691575597; x=1692180397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LBjLnxZNZAs56pK/pcZeFq5+NrdAJr2QNuAWJr3ImoY=;
        b=FLNO5W1sjRfIKz35PskRSovfoVrfkfQXcFht+4yvHNAIYcTByQZ4dlVsFUU3ttsKE6
         CpnWS5iOkuaMe8UZROWFCkTNBX+wI7tKolFw+fuXKtygr8dZhvAYJcexiL4gMGkJdHFK
         VLCvp0ARCGEtF+wbDIT1biZNXm7IcgZ5OBA1Wt3oQe9WD+BBoRsx2ek39ZzqxQPHmxc8
         xiI+8CVWeuIcXDgiSd/UJxAXvyEHXz0wTN4QvRTepLgh/S0FvN8VRoEMH29CotDuXooV
         5MQ0+tK0OfMzlpHP8d0Vhq50v3Bve2A9bzns11C9UMuNjCXhf24O+RZM7VqNAWvjwsIu
         2Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691575597; x=1692180397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBjLnxZNZAs56pK/pcZeFq5+NrdAJr2QNuAWJr3ImoY=;
        b=BTT+T1O0uuTmZgF6KscCiMHY8ptsHLEiTLoqWu8KI8CocWzZR7J4BoQiv64K5LbpYE
         ksvpkQ7FcAa4JsVaOdqBD6FzsMdl6WAJPGdFQry1GyLne3uubueSvssNLjSa1Ldh4wdA
         i1UwqvfJ3ijhBJ2YRqhFvN6R0BqGJQZ3lftPL5lfLiwlQlX1Y7jH1/f2rKZMon1p5Ynx
         C91f3BbIYOLjI68vYoQg4EEuUq4g0f2TdoMkHpaD4DxkL4m9/ZnwDxvckUD/v/2j2i1D
         dpclc3CqujH2YjXeFZXLXVxgffBvELqe1ucDM07FOZoobqPLLn3BOAGwVnv/nn5/y0p5
         YEJA==
X-Gm-Message-State: AOJu0YwFA/WxABeuiI0RENzwb6Hr30BaEpN+FQonPfVrbtTRauHfJdvI
        sRUYk1lhUQi2kWR66v0N1u8=
X-Google-Smtp-Source: AGHT+IGoHo7e7cLnsI/8IW810k3NiWLWx9Y6z8GPJBPk1kwKYin1ehXkLJLDO8HqmpwRvOv78pSX3g==
X-Received: by 2002:a5d:4cc1:0:b0:313:f38d:555f with SMTP id c1-20020a5d4cc1000000b00313f38d555fmr1756621wrt.24.1691575596500;
        Wed, 09 Aug 2023 03:06:36 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id j9-20020a5d4489000000b0031411b7087dsm16426692wrq.20.2023.08.09.03.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 03:06:36 -0700 (PDT)
Message-ID: <a3b920a8-f446-2670-f1cd-de07b28f2c7d@gmail.com>
Date:   Wed, 9 Aug 2023 11:06:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/7] rebase -i: impove handling of failed commands
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
 <kl6l4jla38wc.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <kl6l4jla38wc.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/08/2023 21:16, Glen Choo wrote:
> Hi Phillip!
> 
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This series fixes several bugs in the way we handle a commit cannot be
>> picked because it would overwrite an untracked file.
>>
>>   * after a failed pick "git rebase --continue" will happily commit any
>>     staged changes even though no commit was picked.
>>
>>   * the commit of the failed pick is recorded as rewritten even though no
>>     commit was picked.
>>
>>   * the "done" file used by "git status" to show the recently executed
>>     commands contains an incorrect entry.
>>
>> Thanks to Eric, Glen and Junio for their comments on v2. Here are the
>> changes since v2:
> 
> Thanks for sending this version, and apologies for not getting to it
> sooner (I tried a few times, but it was hard to reconstruct the context
> around something as complicated as sequencer.c..). Unfortunately, I
> don't think I will be able to chime in on subsequent rounds.

Thanks again for you comments on the last round, they were really 
helpful in improving the commit messages.

>> Patch 1 - Reworded the commit message.
>>
>> Patch 2 - Reworded the commit message, added a test and fixed error message
>> pointed out by Glen.
>>
>> Patch 3 - New cleanup.
>>
>> Patch 4 - Reworded the commit message, now only increments
>> todo_list->current if there is no error.
>>
>> Patch 5 - Swapped with next patch. Reworded the commit message, stopped
>> testing implementation (suggested by Glen). Expanded post-rewrite hook test.
>>
>> Patch 6 - Reworded the commit message, now uses the message file rather than
>> the author script to check if "rebase --continue" should commit staged
>> changes. Junio suggested using a separate file for this but I think that
>> would end up being more involved as we'd need to be careful about creating
>> and removing it.
>>
>> Patch 7 - Reworded the commit message.
> 
> I found the updated commit messages much easier to understand, and the
> change to no longer test implementation is also very welcome, so
> overall, I think this is a marked improvement over the previous version.

Thanks, I'm glad the messages are easier to understand now

> Like Junio, I'm not familiar enough with sequencer or its 'expected
> behavior' to feel comfortable LGTM-ing the later patches.

Yes, I'm hoping Dscho will have time to take a look at them once 2.42.0 
is out.

Best Wishes

Phillip
