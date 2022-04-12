Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F85C433EF
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 19:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354252AbiDLT3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356450AbiDLT3a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 15:29:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED88852E58
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 12:27:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so4002574pjb.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 12:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:references
         :content-language:cc:in-reply-to:content-transfer-encoding;
        bh=NSC9GsKGz8iRec+8Ein34chDs5c4dsKYaMy0Tv7PjOI=;
        b=T5MWg3XspCass86t/X/2Prdizmh/feqhZMlpWZlolVyCjXjUkUDgLdL+r1zxBI1/HD
         yeH8Ds5yKq25UhKzQI04x4pEdPLv3Zf3mnBGOPHwGMI9TqVZS5pd5h1IULymHLjHRKmx
         1F78UWf6XjwgEOpogxwmFLPz3n1ei85qQzd6XkyVVF6j4j/abWVGYegyy5gmUSy9XPMC
         3v0ig43inz2wMkppwLf0n/uqhcI1EZDnQCDzXYkhClJZoDMDcOFad8zGd6oH8NV8sf4G
         T3BeOBpMfImS75P6Qhu7xESDKJhGgq6HIKy3kTavP9/OMtraW/DihhDLpgaStXwqV6ct
         1ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:references:content-language:cc:in-reply-to
         :content-transfer-encoding;
        bh=NSC9GsKGz8iRec+8Ein34chDs5c4dsKYaMy0Tv7PjOI=;
        b=PxgO3U0BHi0hmYH+ItvEGTDueLeXcTz+hzfyZS6UTWitEH1by/j6QpDRy2aDmu2tKw
         viz+27d+o6ujsY5vYbxWJc2Dme6+/30/h3OubWwHhG44Y/sdrWBkfS0P49ua27LM6U8r
         Nqx7claz3LloyfyvP45eEQpO2siJ7PdoXEDYCSBzl7Avns6uNYoeYmLZ4tne3P8hS2Rt
         UMO76Ggv8sLjziAz6MHUBeiv+PeP9TXoKiwPENr/MdookOR3sw1h6hMeSqdgxahtZmWz
         CnxyEtBINi8VC40xGnBsRaqE0cLCOlOcnJ63QOiGp6ozy9ne9oK/oFBqkPkUiGaqEiI8
         3CnA==
X-Gm-Message-State: AOAM530/pNn4FeH4DinmOqFUkpXovTvJX+9pbcSsxi5B0YWha6NWguv9
        5ozDQWx4E+Ev4mKe/JzQysC/EiTx8DU=
X-Google-Smtp-Source: ABdhPJx6nlOyYDRMWhVRh68rKdLhAdhJCAxv9VQoYwPMEDHqakospUTJ7QaVlVU/SPY2JmPD9iNPVQ==
X-Received: by 2002:a17:90b:4b42:b0:1cb:a213:65d9 with SMTP id mi2-20020a17090b4b4200b001cba21365d9mr6771843pjb.138.1649791626378;
        Tue, 12 Apr 2022 12:27:06 -0700 (PDT)
Received: from [192.168.208.37] ([49.204.141.17])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090a138200b001cb6512b579sm266335pja.44.2022.04.12.12.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 12:27:05 -0700 (PDT)
Message-ID: <f939ebd9-b801-0961-ffad-b87c94096f5d@gmail.com>
Date:   Wed, 13 Apr 2022 00:57:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: Issue when using the fsmonitor-watchman hook?
To:     Derrick Stolee <derrickstolee@github.com>
References: <3ce82619-6305-69b6-b4e5-bbbc91c17530@gmail.com>
 <edea2223-a9e1-c026-089f-80ea36cf97c2@github.com>
Content-Language: en-US
Cc:     Git Community <git@vger.kernel.org>
In-Reply-To: <edea2223-a9e1-c026-089f-80ea36cf97c2@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On 11/04/22 19:16, Derrick Stolee wrote:
>   
>> I recently installed v2.36.0-rc1 and started getting the warning about
>> the deprecation of core.useBuiltinFSMonitor configuration. It appeared
>> for each 'git' invocation which was a bit annoying. Fortunately, I had
>> some spare time so I went the route of actually applying the suggested
>> alternative rather than suppressing the warning.
> 
> So, the new alternative is to set core.fsmonitor=true, which continues
> to use the builtin FS Monitor. What advice did you see that was
> different?
> 

Ah ha. I should've guessed that. The actual advice I saw was the following:

   hint: core.useBuiltinFSMonitor will be deprecated soon; use 
core.fsmonitor instead
   hint: Disable this message with "git config 
advice.useCoreFSMonitorConfig false"

Rather than trying out configuring 'core.fsmonitor' to 'true', I went
and took a look at the documentation for it in git-config [doc] which
read as follows:

   If set, the value of this variable is used as a command which will
   identify all files that may have changed since the requested
   date/time.

That made me think the value could only be a command. So, it never
occurred to me that it could be a boolean. I just checked the local
doc that shows up when running `git config --help` in Windows and that
seems to clearly mention the behaviour that setting to `true` would
enable the built-in file system monitor. Looks like I made a mistake
and referred to the doc for v2.35.2 when trying out the v2.36.0-rc2 x-<

[doc]: 
https://git-scm.com/docs/git-config#Documentation/git-config.txt-corefsmonitor

> (Also, this thread will only apply to Git for Windows, since core Git
> did not include core.useBuiltinFSMonitor. Feel free to move this
> discussion to [1] if you'd rather talk there.)
> 
> [1] https://github.com/git-for-windows/git/discussions/3251
> 
> Hopefully using core.fsmonitor=true solves your issue.
>

Yeah. That works fine and suppresses the warning properly. Thanks!

> 
> If you really want to use the Watchman-based hook solution, then
> here's the rest of my response:
>
 > ...

I do wish to try out Watchman but not right now. For now, I suppose
I'm fine with whatever the builtin fsmonitor does. Anyways, thanks
for the details!


-- 
Sivaraam
