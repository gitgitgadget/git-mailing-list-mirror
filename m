Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A632C4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 13:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E89A22240
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 13:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLv7fPra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgKPNNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 08:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgKPNNW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 08:13:22 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A729EC0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 05:13:20 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id m13so18723265oih.8
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 05:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uj+A8OmSoYkS8vr4jH59REOdHwHeC81yiFnt5ZqT6L0=;
        b=CLv7fPraKvQGhl1g2NdP43QrNW+tKBB989pOBWklht901tnrtGTt9C4Nuidi1TOw0h
         2oerzFYKJSMM9qsWVl8g/e+g4En6T1DXwi6b349YEdsEO79tRw8b/C8x0s6YbwLHys+R
         gotwRQyJDL4iXnAUQ3f64PVsRr9PGu14/T4PC0Xm+w3R1kIFffdKxqzSr4sztmT42T7C
         L5ZL/gcZY0uMAaKNAMJZmTHIUCxM/DL+umifqQq/XzfqXkan3WokvTQ6tS8Tu4/ZzCuf
         VqWTaCzfALbh23l881psBdo7vrFoK/VxzavkKor2nH3KiRvfUUJOsGMy9ja+Qq9JVLoq
         Xoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uj+A8OmSoYkS8vr4jH59REOdHwHeC81yiFnt5ZqT6L0=;
        b=p/OKAZEgsb53EYl8YwDZ2VVHVdShUZfq943PMFx9NhJSUbmQHDKY9WgggEFDjycdlg
         CEOBwUP4ThkdCPEVncDNBUcmMNuqBdGPSl6FD1A4RKkfEIg6pf9X8s4BhlDgsbqc53y5
         dWp5KEkxgWiDGTCJcly8f/H1+icR90WxzXAc17OxM/DyCMd/s77V902sf0vdwV/r0hvH
         D33/g07OS8OgeL8gYI3WYdGI5+sKkKnQG3Ohi354T495XkNhzZVGX6g6eM82BEq0WaaG
         ryyJBSjHgLx1ziyEg4hoXE9D9ctZVAQT/JLX/E4JzqjoNYJ7gEOveUtpTs+3YV/Jc4QH
         TZTw==
X-Gm-Message-State: AOAM532pXMV80FvpLhwqdLSQcG1ll0MMd/QehubT2iZCtVQzqC1NCWEA
        e8pWxVP2Gph/Dyi6qWGvUfM=
X-Google-Smtp-Source: ABdhPJwWG5Ni2fT5y4pircZCicCyL4qGVEYC/08Kd8X9O//hcbpeoZRTUrgCPol2OwDtxPeVmJSpnQ==
X-Received: by 2002:aca:e046:: with SMTP id x67mr9259834oig.141.1605532399881;
        Mon, 16 Nov 2020 05:13:19 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:6dc1:e5c:951b:3570? ([2600:1700:e72:80a0:6dc1:e5c:951b:3570])
        by smtp.gmail.com with UTF8SMTPSA id p12sm4583021oti.35.2020.11.16.05.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 05:13:18 -0800 (PST)
Subject: Re: [PATCH v3 4/4] maintenance: use Windows scheduled tasks
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
 <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <ed7a61978fe9dce26ca459b5a86490c15e470698.1605276024.git.gitgitgadget@gmail.com>
 <CAPig+cS3YXH=SmTsRTOa5Cdppt9L=MbFRT+LWn9QE7aEqRiDqQ@mail.gmail.com>
 <73c902db-40f5-2693-c350-9c04ba2751cf@gmail.com>
 <CAPig+cRv_Swd4WcZDnyDxg4E1HdwdkfybjWiZsYwPFSxkhUz0w@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b24ea2df-e937-b8f5-07db-3a1f365035ad@gmail.com>
Date:   Mon, 16 Nov 2020 08:13:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRv_Swd4WcZDnyDxg4E1HdwdkfybjWiZsYwPFSxkhUz0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/13/2020 4:40 PM, Eric Sunshine wrote:
> On Fri, Nov 13, 2020 at 4:32 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 11/13/2020 3:44 PM, Eric Sunshine wrote:
>>> On Fri, Nov 13, 2020 at 9:00 AM Derrick Stolee via GitGitGadget
>>>> +       GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance start &&
>>>
>>> Is it a requirement on Windows to mention /bin/sh here? Specifically,
>>> I'm wondering why a simple ./print-args doesn't work. (It's especially
>>> unclear since write_script() is used heavily in the test suite and it
>>> seems to work well enough on Windows without specifying /bin/sh.)
>>
>> I landed on this after trying several attempts to get this to work,
>> including "$(pwd)/print-args" and I'm not sure why it doesn't work
>> in the Windows case. It is something to do with how I am executing
>> the subcommand from within Git. I'm pretty sure this idea of "mocking"
>> an executable through Git is relatively new, or at least rare
> 
> Just for clarification... You mentioned in response to my [3/4] review
> that your accidentally-working write_script() only worked as expected
> on Mac but not on Windows. When you arrived at this solution of
> GIT_TEST_CRONTAB="/bin/sh ..." here, was that before or after you
> fixed write_script() to take the script body from stdin?

You're right. That was necessary only for the old way that I was
creating the script. The correct way works with GIT_TEST_CRONTAB
equal to ./print-args.

-Stolee
