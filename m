Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E19EC433EF
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 08:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhLYIcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 03:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhLYIcI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 03:32:08 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999DCC061401
        for <git@vger.kernel.org>; Sat, 25 Dec 2021 00:32:08 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id iy13so9286112pjb.5
        for <git@vger.kernel.org>; Sat, 25 Dec 2021 00:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HHq47vxMVHcaVB998AF+/hVZUNKUTtBTWP9T1ylpM7E=;
        b=Gvmb+5eGwQoTPl93xo8a5a5q+DMrueA4haJcoeGxXNZSa4hsilV15XdB1bU4LsIWbl
         4IghgzpDIqYYMQmFULh1mdNWlqt8/oOjkQCfAvRUWmEqISB54okmNTiSwxJdiefvuaf5
         J/3XSis96wi8FqcVVIqs/e9Pu4o8JyzpgF/ujt9dWve7blVqawfXRQtZ6sS6qburTCsl
         LUgdY0/idUHv5Bxy/fRWxbBy78/yXBqXVErqYwgLSl0bxuxH4Cg4OSRtCOKRqvbL5E3/
         roIjtzI+uJa2g+sGf961xcSFVNeqCNNdohgWohR8sPmF5aCkO0Oh3s60P/xTplD77fbt
         +Bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HHq47vxMVHcaVB998AF+/hVZUNKUTtBTWP9T1ylpM7E=;
        b=Q5T8ryJFwz5a94qTT5ZicfBk+jLG6Dh/qRA4aDHSGYib6LSiM71LqULe/GRP57R6en
         iQ0lggIOGH2xoK3Kw2LJTg6Z5sKwImcFARjUgWvrzkjpeAf/aTwKbjQWnGHgkylk1Vi/
         pbCFpo4YTe8QrWbg2EF9yyaBt9LEcTni/+Gbw1q2m+y+18ii/o/qJEviHLbDD+oTt99B
         fg9KYtwfMkQj/wuwngUiYHYTPh3HIocWczddSdK/yYTeHry3iqdZIEbZoge+0vpNynHF
         XnhEZzR1SsJdRvH4NS+VPXAxHMlTCHSoUNYF1VGxjTTwnPY8pM/88dbFiXogyGH6n4+q
         8Dbg==
X-Gm-Message-State: AOAM531WLj3Kgk17inSOtj6Z8EgGYeQnHV6K7AO90WY5N9H3fhygTmyd
        AFxYrbaiHR+QiSHrS3FOKkFt6tB1qalh2g==
X-Google-Smtp-Source: ABdhPJwZNui9HpzMRn8oF5YrvOTSDgAlhOXc92dd+fVSD9pompXIwXKCZCmFOj1rUCx2bu1VQ24XtQ==
X-Received: by 2002:a17:902:a409:b0:149:28e8:8e80 with SMTP id p9-20020a170902a40900b0014928e88e80mr9649029plq.56.1640421127569;
        Sat, 25 Dec 2021 00:32:07 -0800 (PST)
Received: from [192.168.18.18] ([103.252.33.202])
        by smtp.gmail.com with ESMTPSA id v10sm13588089pjr.11.2021.12.25.00.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Dec 2021 00:32:07 -0800 (PST)
Subject: Re: Git internal command line parser
To:     =?UTF-8?Q?Jo=c3=a3o_Victor_Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
References: <0347f273-f9e9-3ce6-2a95-f1ce71285c09@gmail.com>
 <e2726eaa-ba73-4141-bf61-89d5a7e9a9c2@iee.email>
 <0e0f78e9-2cde-a20e-cd47-8542bc7bd314@gmail.com>
 <cc6fa52a-d782-d4a8-eb93-936b8d83fc2f@iee.email>
 <bZ5IKn77iTM5gCits_kl5lZ7uiOOkkt8dcHPT1UVlPWsrnqapXBtAkYB4uGGBA3Oizq4J7BN4GC6mLR8wQ7x_qqLJPbae6IMTqxW9JFJSbg=@protonmail.com>
From:   Lemuria <nekadek457@gmail.com>
Message-ID: <65fdfd25-736f-5105-6eba-b70cd51cc780@gmail.com>
Date:   Sat, 25 Dec 2021 16:32:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <bZ5IKn77iTM5gCits_kl5lZ7uiOOkkt8dcHPT1UVlPWsrnqapXBtAkYB4uGGBA3Oizq4J7BN4GC6mLR8wQ7x_qqLJPbae6IMTqxW9JFJSbg=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/12/2021 10:55 am, João Victor Bonfim wrote:
>> If you are on Windows, it gets even more interesting because all the
>> individual sub-commands are just hard links back to the single git.exe
>> that then links to those sub-command's code.
> 
> That seems undesirable...
> I know operating otherwise would be even more complicated and might create undue complexity or diminish performance, but I guess that, if it works, don't mess with it.
> 

Was this directed towards Lemuria (me)?

>> And I likely will consider this "front-end to many separate
> executable apps" approach for my future large projects.
> 
> Lemuria, please consider those points as, sometimes, what is great at performance might not help with scalability and other matters, therefore, as the designer/engineer of a software system, a choice must be made and an evaluation of the properties of each possibility is a necessity.
> 
> Do with that what you will.
> 
>> I'm also a beginner to C, not quite an expert at it.
> 
> Practice programming a lot and never forget two things: [1] you are working with a man made machine, therefore its limitations and capabilities are by design, so you must consider them every step of the way when developing (like how computers send information, how computers process informations, how machine behaviour can be altered, abused or exploited through alteration of the environment or mechanism and through the use of sleight of hand). [2] Your code always has real life consequences and it is your moral responsibility to consider them and make sure that prejudice isn't codified into them.

Okay, I understand. I'll do everything to keep my code bias-free.
I'm working on a project in C and if it's okay, I'll link you to
the GitHub repository.

I'm sure the git mailing list isn't the right place for me to get
criticism on that project however.

> Those are my two tid bits about being a responsible and effective programmer.
> 
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> 
> Em sexta-feira, 24 de dezembro de 2021 às 15:36, Philip Oakley <philipoakley@iee.email> escreveu:
> 
>> On 24/12/2021 18:30, Lemuria wrote:
>>
>>> On 25/12/2021 2:13 am, Philip Oakley wrote:
>>>
>>>> On 24/12/2021 14:38, Lemuria wrote:
>>>>
>>>>> #=< TLDR: Where's the code for git's internal command line parser?
>>>>>
>>>>>> ===#
>>>>>
>>>>> I'm interested in the internals of git, more specifically it's command
>>>>>
>>>>> line parser.
>>>>
>>>> One place to start is https://github.com/git/git/blob/master/git.c
>>>
>>> Wait, is all of Git just one big executable or are there many
>>>
>>> executables and `git` is just the front-end for accessing the
>>>
>>> separate git executables, such as say, the one for processing
>>>
>>> commits?
>>
>> Yes, `git` is a front end.
>>
>> If you are on Windows, it gets even more interesting because all the
>>
>> individual sub-commands are just hard links back to the single git.exe
>>
>> that then links to those sub-command's code.
>>
>>>>> Does Git use a library like getopt for it's command line handling, or
>>>>>
>>>>> does it use a custom parser?
>>>>>
>>>>> If possible, I would appreciate being redirected to the source code
>>>>>
>>>>> files that handle this.
>>>>>
>>>>> Sincerely,
>>>>>
>>>>> Lemuria
>>>>
>>>> Philip
