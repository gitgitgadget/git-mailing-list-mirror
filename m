Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEF8ECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 19:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiIVTqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiIVTqp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 15:46:45 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBEE10B233
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 12:46:44 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e205so8667527iof.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 12:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=XeiGPvyIN0rJFp2me95Y+Jpm7gZ9Lniil6HIOla8PsI=;
        b=F1VqyV1cL1yPWaiUZiuDral1jrKHSpvjOHHnLjm2tgHCLa4cHdA2+LUMAzEP4m57jO
         ONvQz9j5tATHtu4IY9U09a4YkRALVaNC5miHtoJpHOxZ51rN9jkDcuGNvgVFgmWkQezG
         algJia9uOTC4NrviM7QSh1FWdSY8DktnQC9Uq9iUlIsyIGh8zvFWU/qg9phay5oS2A5Z
         1+mB2HVPuatmWoPFLGWQXrae+qpEdvlUiM5olOl5PZ/Qeiv6OQtECco5yT+uL3q66ym0
         O0qRziPLIU0uo8dmBVr253NbxNJweEIztUKPg2E6DJ3+WOVAF5lOfslyfwq5itCrJiOW
         R5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XeiGPvyIN0rJFp2me95Y+Jpm7gZ9Lniil6HIOla8PsI=;
        b=iEXoV1SQC8a/Nb7K2GgiAzQUUn9YrIPXASraa5CYgq7e4K9ZgP7C9Ddk1c0unpgLBI
         Ebc8rZtleTyAVvzW0xFsSd2gT09YLPnfDZpFRtY4odi3s77Q3150UN2s3VRSSwjq9Sgg
         UZSvD9ffZFMy1imJgPBNGRkDDA6Kgvb/NKbXiUIKie8GqUb3/5MTa6D0uJUTALElf5cQ
         MZAdYo0mBmv0vR/A0Vb3z8SBdkVenUxD00Q/xUlQ1IfIjQekO0e1pu9mayp/9SAz6zqQ
         obpDpRO/deIZOjElEVrjTfuZvlpM+5i93hVrGjc6fFdjUYJ7lACR51YAU9h8AKTuuzlQ
         YuoA==
X-Gm-Message-State: ACrzQf2c73xAam84FoJ5LFd+mKIw87TnQ7QPfDXOVsvHiRDJTlBT3NmV
        oGC9WKitEvnPJxAQUAjf2xbgye3DpueF
X-Google-Smtp-Source: AMsMyM4fIuRoPuhYBrW7uCOrck5fp0ftzu7yjrFYBcLkaMrwtIxjemy+XwUTFILy3m+CdFxTjwY7nQ==
X-Received: by 2002:a05:6602:346:b0:6a2:8fcd:625c with SMTP id w6-20020a056602034600b006a28fcd625cmr2448162iou.3.1663876003666;
        Thu, 22 Sep 2022 12:46:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e4c7:912a:7017:ed79? ([2600:1700:e72:80a0:e4c7:912a:7017:ed79])
        by smtp.gmail.com with ESMTPSA id c17-20020a92c8d1000000b002e939413e83sm2351780ilq.48.2022.09.22.12.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 12:46:43 -0700 (PDT)
Message-ID: <748f4e1f-f2a3-872c-2ffd-643841c454dd@github.com>
Date:   Thu, 22 Sep 2022 15:46:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] maintenance: make unregister idempotent
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com
References: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
 <xmqqpmfo4pc7.fsf@gitster.g>
 <bc57439a-bddc-6c1a-a51d-11498d17c206@github.com>
 <xmqqtu4zxl25.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqtu4zxl25.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/22/2022 3:31 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>>> I am not sure if this is a good idea.  What is the ultimate reason
>>> why we want to allow running it blindly without knowing if it is
>>> necessary?  Is it because there is no easy way to tell if unregister
>>> is needed in the first place?
>>
>> We want to leave the internal details of what it means to be
>> registered as hidden to the user. They could look for the repo in
>> the global config, but that seems like a hassle when they just
>> want to make sure they are not currently registered. 
> 
> OK, so there is no published officially sanctioned way to ask "is
> this repository under maintenance's control and cron jobs run in
> it?" or "give me the list of such repositories".  
> 
> Then I can see why you want to allow users to blindly run
> "unregister", with or without "--force".
> 
> But doesn't it point at a more fundamental problem?  
> 
> Is there a reason why we want to hide the list of repositories
> (enlistments?) from the users?

I don't think we want to hide it, but we've never needed to present
the list in a canonical way before. It's been sufficient to let
users run 'git config --global --get-all maintenance.repo', assuming
they know that config key is the important one.

Adding a 'git maintenance list-registered' or something would solve
that problem, but I'm not sure it is a super high priority.

Thanks,
-Stolee
