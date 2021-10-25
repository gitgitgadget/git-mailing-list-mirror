Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5723C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D4560F9B
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbhJYQmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhJYQmm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 12:42:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AA4C061767
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 09:40:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so509770pjb.0
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 09:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Hn6j9soov/YlNbtQj8fJ+xQK0ASs0NdD+Kvo1FDo7QA=;
        b=XwAo4hT/4tQaQf6j3AEyRmOchrJbshZlqCS3Yhkp4i24QIgO485FUiSl7qXGCthXI2
         LIJqbu5yA8+UTZ6qVvg3XXjXuGU4sS0Tdcg8hMPDsMfNEU8Z/vrBViF7aR2miaJRXezK
         31SFR7FWaDq3Uh1GyP+iUF3L0orp6n4jcqZnsfu/kMlt3P/EZZTKrfExozFKSdWaMnR9
         WDkAMW6kVgpEi/fadwGL90sGFezZFN1UiBd9ZEABcIlbtB+2kL2oGKuvnpf6Nz6LKCEr
         6+nohIbRWFWXBbCe+f4S9QQPaMCUh8Iu5SgsAy8XKGPtwSQr74oHJt240NJddfYcsjXf
         bavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hn6j9soov/YlNbtQj8fJ+xQK0ASs0NdD+Kvo1FDo7QA=;
        b=DfSS9EYTnPIga0GAdnlkV6taT2r9vwaxcNRV2+Ks/w35cCNwoL3dWzAroe5qoap1qs
         ZEu2LUma38MF1+yImANSSs+J0boLVbZUvluIa9IqekIsg25Ww7m6qzmeziTEnLgqhsu7
         YJc2HoivZqJTxMDs3i/lL/ekpgUZn1Ns1NwUmb3qpNtHzBBWp+UicvFNnPVAYHdqvl0q
         /QWXLwtAiUZlRrA7r8rf/s1vgPsQFiUc+G+sFvr8Lb5lIzx0yPPcI8CCJ0Rhf28n/2E1
         8Y30YpS/LAJQNvetb8GIFG1WgP1tKIisiPKgajmWw6bK0D8H+qK91XbyAopiwiTf8CmG
         e3DA==
X-Gm-Message-State: AOAM533J5fyHiFmnfVbyBb/KQDdWD/LpkBn723ZgjsY2Q2ZsRraIY8Mx
        4lRvygYbts1NqGXQxUL+/Do=
X-Google-Smtp-Source: ABdhPJyie3qW6V+CGKEvyLNAW0d6uNAu4INyZZxjOu96ocXsZRbj7pvF3DaYS3q38bC5gsc3H0h0Qg==
X-Received: by 2002:a17:90b:3a88:: with SMTP id om8mr4499818pjb.132.1635180016349;
        Mon, 25 Oct 2021 09:40:16 -0700 (PDT)
Received: from ?IPV6:2409:4060:2e05:4846:2142:ce55:4e26:8cfd? ([2409:4060:2e05:4846:2142:ce55:4e26:8cfd])
        by smtp.gmail.com with ESMTPSA id v12sm19152309pjs.0.2021.10.25.09.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:40:16 -0700 (PDT)
Message-ID: <d9edec0c-434f-800d-42ea-222423e7da04@gmail.com>
Date:   Mon, 25 Oct 2021 22:10:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] amend error message violations
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1062.git.1635164026698.gitgitgadget@gmail.com>
 <211025.86y26hgtm0.gmgdl@evledraar.gmail.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
In-Reply-To: <211025.86y26hgtm0.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 25-10-2021 18:07, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Oct 25 2021, Abhradeep Chakraborty via GitGitGadget wrote:
>
>> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>>
>> Issue no #635 in the gitgitgadget/git repo has a brief description
>> about the violation of error message style convention. These
>> violations are - 1) Do not end error messages with a full stop. 2) Do
>> not capitalize ("unable to open %s", not "Unable to open %s") 3) Say
>> what the error is first ("cannot open %s", not "%s: cannot open")
> Let's summarize the guidelines instead of asking readers to visit
> https://github.com/gitgitgadget/git/issues/635 (which isn't even
> directly linked here) only to find a quote from CodingGuidelines.

sorry for not mentioning that. I didn't realize at the time of writing

the commit message.


> I think it's good to split these up, e.g. the rewording of the BUG()
> message for the 3rd quoted item in CodingGuidelines from cases where
> you're only changing the capitalization of these messages.

But both of these don't comply with the error message style convention.

So, don't you think that all should be in the same commit (all of them

are equally violating style conventions)?


>> If we're going to mass-edit these I wouldn't mind an addition to the
>> guidelines that says we ''-quote things, and add that when appropriate....

Pardon me, I didn't understand the "we ''-quote things,
and add that when appropriate" part. Could you please explain
that again?

>> -	error(_("You have not concluded your merge (MERGE_HEAD exists)."));
>> +	error(_("you have not concluded your merge (MERGE_HEAD exists)"));
>>   	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
>>   		advise(_("Please, commit your changes before merging."));
>> -	die(_("Exiting because of unfinished merge."));
>> +	die(_("exiting because of unfinished merge"));
>>   }
> Surely any convention of not using full-stop should extend to advise()
> too?

I was thinking of it and even was confused at the starting. But later I 
thought

that advise and errors are not the same thing. So, there shouldn't be 
any change

for advise(). Though I am not so confident about this.


> But in this case aren't we constructing sentences in parts? Maybe having
> the full-stops here is better than not, I'm not sure.

Maybe you're right. One question to ask is, do error() and advise()

add "\n" at the end of these strings?


> Also, have you tried using coccinelle for this? Doing this sort of
> replacement should be a small matter of some inline Python, the
> linux.git repo has some good examples of that.
>
> It would make discussing these changes easier, and per the "pending"
> docs in contrib/coccinelle/README any patches could follow such rules
> incrementally...

No, I haven't used coccinelle but will definitely take a look at it.

Thanks.

