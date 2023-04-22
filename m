Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37A2C77B78
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 21:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjDVVx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 17:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDVVx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 17:53:57 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9D910E6
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 14:53:55 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-5ef8aaf12bdso12987966d6.3
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682200434; x=1684792434;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfZYAb1lTvuL8kCKuNzC5Zf+R3IH41H46boWKWqcEMk=;
        b=VUJrFVj/zYccDGcFRy5MZ4xQiYYMMA5ya8P03CoKlJwVJrMqt+HM4FUPiP50QHCFzU
         ju2IaQ4zfAHdie4OAI0CiycMTS8G++A6m+1DW+2F8qdG6SvZWve9sqmy3ezk0F1zslcZ
         tUOc/smQEmixdAdBGgoixupjCOpV3ylCSEucs+XuRumxQuvTPHM18/Mhu5hXy3SWZzk6
         IvaIwsOn1yOusV5QgrFULhWKypgVqWE2Fd5G2s0J6byWjSdnHX2h8lXR9Tjv88FYCi10
         GRe/U0gSuwHivYaZ9BsjrRowopLMZz524GYkuM0DhFtoCZs4NadIaQ1eHxscjJ0z6mLP
         fk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682200434; x=1684792434;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfZYAb1lTvuL8kCKuNzC5Zf+R3IH41H46boWKWqcEMk=;
        b=Zd2HEYHTLGia9UzQZ42B25l2Gi9DEZBGL5+sP47UV9VopHYUBfUHaVuyDwpceaO03g
         2ct2Wn//DHGsmwaFLT0xpbvPb+cnvylt2/T6q7c0Ixk5u/AqklL/b/mU7wQd0zcHj5xf
         zd2w9hczR3ZimfQytSirlpwv4fEbKt0oFP8xq16gY3yjIw+yACzCEEmxb5BYDdcknVgH
         K2GS8LE4ZnQtGduimncJGmluyNZVfnIsnaEuk/15aqbUi/wcKLUTNtm3Rzm41qYHxBTF
         zFYbsBBrhnq5HSx2pVa4oSDNLlVxuYXoTNWPq+JfErnOnkFnvXfPmL8tiCaL+2MwmJ/T
         13Pg==
X-Gm-Message-State: AAQBX9czxeqczGLoBaHG3eVBfgZlPs6VmDwfRHzXT7CL+OEwNfaj2wM2
        r3Xyo85RovGsLkzoNGWg4s/GX9M5zo4=
X-Google-Smtp-Source: AKy350aVck1mP05+5FuUJGBIDcfInZ/jGLsZJ/8indZYxjkEEAfDGV0FCTvF+DKILFqes8825+5vEA==
X-Received: by 2002:ad4:5be8:0:b0:5f3:deca:ead with SMTP id k8-20020ad45be8000000b005f3deca0eadmr13177843qvc.28.1682200434054;
        Sat, 22 Apr 2023 14:53:54 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id u14-20020a0cdd0e000000b005ef447e24adsm2189153qvk.19.2023.04.22.14.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 14:53:53 -0700 (PDT)
Subject: Re: pb/complete-and-document-auto-merge-and-friends (Was: Re: What's
 cooking in git.git (Apr 2023, #06; Thu, 20))
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <xmqqwn26w5cd.fsf@gitster.g>
 <CABPp-BGPbo8B6JXBOHTQs0LegpwHccbnnGe__ea05fkO_34YKA@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <a10648d5-8cba-4c7c-a303-b5b0dcdd3310@gmail.com>
Date:   Sat, 22 Apr 2023 17:53:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGPbo8B6JXBOHTQs0LegpwHccbnnGe__ea05fkO_34YKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio and Elijah,

Le 2023-04-22 à 11:00, Elijah Newren a écrit :
> On Thu, Apr 20, 2023 at 3:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * pb/complete-and-document-auto-merge-and-friends (2023-04-14) 5 commits
>>   (merged to 'next' on 2023-04-20 at 2728a01622)
>>  + completion: complete AUTO_MERGE
>>  + Documentation: document AUTO_MERGE
>>  + git-merge.txt: modernize word choice in "True merge" section
>>  + completion: complete REVERT_HEAD and BISECT_HEAD
>>  + revisions.txt: document more special refs
>>
>>  Document more pseudo-refs and teach the command line completion
>>  machinery to complete AUTO_MERGE.
>>
>>  Will merge to 'master'.
>>  source: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
> 
> This merged to next already?  Doh.
> 
> There was some misleading text (and a few typos) in 4/5, and good
> suggestions from both Eric and Victoria in the thread for wording and
> display improvements.
> 
> Perhaps we can at least wait for a fixup patch?

Yes, sorry for not having send a v2 yet (or responding to reviews),
I'm very busy with work.

I'm also surprised that this is already in 'next' since your "What's cooking"
of the 17th did not mention "will merge to next" for this branch [1].

I've fixed the typos and also would like to incorporate Victoria's suggestion.

I probably won't have time to do this before May though. I'll send a v2 then.
I can do fixup patches on top if it stays in next, or I can wait till 
next is rebuilt... whatever works best.

Cheers,
Philippe.


[1] https://lore.kernel.org/git/xmqqfs8xfw25.fsf@gitster.g/
