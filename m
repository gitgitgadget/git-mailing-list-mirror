Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FE2C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 14:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiCAOH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 09:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiCAOH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 09:07:27 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E526D9F38E
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 06:06:46 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q5so16303230oij.6
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 06:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=viIN+vvJZYmKlGjwhlDdvPGc1hBjMbbCTOmQa8UqZNE=;
        b=WC4pg4h2Ic0PNBZ+VawQtT6n5j46gyVVYD5Uac1tgVjqMhALRCkRGVy8L7YtFnyuu8
         NPBH9SjhsDs0rxaf0RIQ4DwzbLcRmddB4Vz5guTmxs41nGVp6mUpJPKbjkMoxBs7hVeB
         JJnijMy2ejk2GOSqgOwrAMPS8BuQ68wZW9/vhT8AG03rUfY6Uf+9O3jsCyG1iNUP6B0i
         98RycWjRxfQyXZdkJwrVcPLwMo48M72F2W3u4p39PlUnLm4/dA5cErZYqwrl92B7MDcd
         0y4kqdSHo53nfov7eXS4i/P6VmSBqn4oEx5+xDYKWYiLhRFVmQEFSFIJYKq0/Ah1pm4V
         vXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=viIN+vvJZYmKlGjwhlDdvPGc1hBjMbbCTOmQa8UqZNE=;
        b=CfbXaLVztuX3D75eVUTxER5U/j/DzuGEId9knAjQP8kL5sS4QPD7GcSdzMRZJdXlB9
         0g1OGakiKjmlMhECdoHN6blHHKWkJh8dtmajoVP2BI7vz08jdAuqQS9umTF+Fe5ANio3
         kWgb8tijhXt23aB3CL/ajMXywAcyUkLRFn2OthQdcfSI1OeXN0M212k2DVoTu2shE+oU
         pcYb1EPZnnq2g5I9hGfrmFBkoj2ndZd+S+SY8uxCOnE7K7DNVYf0Zj/b3yXYdB0bcIr7
         BP6hUPVJq06jJd/ivm1j2AVQnMXBi3yBk0hAKAeOQmjsZ3dDUUjY0Lcemk1tdBDOHq/5
         gQmg==
X-Gm-Message-State: AOAM533R8dO/LPIb+Uls3oX9h2gA1WwH7Nt64FBQPKIaOYYl3Y0dGFMO
        6iAzFOlbuJl8eqE+3TuT4+Ud
X-Google-Smtp-Source: ABdhPJzRLbSQifiOcGx0yfCxAM186siibjoqfcVbVmeVBnZjESBsWbyERO9IIuk0f84ZmHfr16FQcQ==
X-Received: by 2002:aca:502:0:b0:2cd:c24:278f with SMTP id 2-20020aca0502000000b002cd0c24278fmr14923770oif.150.1646143606032;
        Tue, 01 Mar 2022 06:06:46 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id kz3-20020a056871408300b000d75f1d9b85sm215748oab.50.2022.03.01.06.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 06:06:45 -0800 (PST)
Message-ID: <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com>
Date:   Tue, 1 Mar 2022 09:06:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
 <YhzkdMxrIGlNutr6@ncase> <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
 <Yhz/hsDDGNVjt64R@xps> <dbb59fe7-4918-50ef-33a6-79eb430445e8@github.com>
 <Yh3rZX6cJpkHmRZc@ncase> <Yh325v3RBDMxjFnD@ncase>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yh325v3RBDMxjFnD@ncase>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 5:35 AM, Patrick Steinhardt wrote:
> On Tue, Mar 01, 2022 at 10:46:14AM +0100, Patrick Steinhardt wrote:
>> On Mon, Feb 28, 2022 at 01:44:01PM -0500, Derrick Stolee wrote:
>>> On 2/28/2022 11:59 AM, Patrick Steinhardt wrote:
>>>> On Mon, Feb 28, 2022 at 11:23:38AM -0500, Derrick Stolee wrote:
>>>>> On 2/28/2022 10:18 AM, Patrick Steinhardt wrote:
>>>>>> I haven't yet found the time to dig deeper into why this is happening.
>>>>>> While the repository is publicly accessible at [1], unfortunately the
>>>>>> bug seems to be triggered by a commit that's only kept alive by an
>>>>>> internal reference.
>>>>>>
>>>>>> Patrick
>>>>>>
>>>>>> [1]: https://gitlab.com/gitlab-com/www-gitlab-com.git
>>>>>
>>>>> Thanks for including this information. Just to be clear: did you
>>>>> include patch 4 in your tests, or not? Patch 4 includes a fix
>>>>> related to overflow values, so it would be helpful to know if you
>>>>> found a _different_ bug or if it is the same one.
>>>>>
>>>>> Thanks,
>>>>> -Stolee
>>>>
>>>> I initially only applied the first three patches, but after having hit
>>>> the fatal error I also applied the rest of this series to have a look at
>>>> whether it is indeed fixed already by one of your later patches. The
>>>> error remains the same though.
>>>
>>> Thanks for this extra context. Is this a commit-graph that you wrote
>>> with the first three patches and then you get an error when reading it?
>>>
>>> Do you get the same error when deleting that file and rewriting it with
>>> all patches included?
>>>
>>> Thanks,
>>> -Stolee
>>
>> Yes, I do. I've applied all four patches from v2 on top of 715d08a9e5
>> (The eighth batch, 2022-02-25) and still get the same results:
>>
>>     $ find objects/info/commit-graphs/
>>     objects/info/commit-graphs/
>>     objects/info/commit-graphs/graph-607e641165f3e83a82d5b14af4e611bf2a688f35.graph
>>     objects/info/commit-graphs/commit-graph-chain
>>     objects/info/commit-graphs/graph-5f357c7573c0075d42d82b28e660bc3eac01bfe8.graph
>>     objects/info/commit-graphs/graph-e0c12ead1b61c7c30720ae372e8a9f98d95dfb2d.graph
>>     objects/info/commit-graphs/graph-c96723b133c2d81106a01ecd7a8773bb2ef6c2e1.graph
>>
>>      $ git commit-graph verify
>>     fatal: commit-graph requires overflow generation data but has none
>>
>>      $ git commit-graph write
>>     Finding commits for commit graph among packed objects: 100% (10235119/10235119), done.
>>     Expanding reachable commits in commit graph: 2197197, done.
>>     Finding extra edges in commit graph: 100% (2197197/2197197), done.
>>     fatal: commit-graph requires overflow generation data but has none
>>
>>      $ rm -rf objects/info/commit-graphs/
>>
>>      $ git commit-graph write
>>     Finding commits for commit graph among packed objects: 100% (10235119/10235119), done.
>>     Expanding reachable commits in commit graph: 2197197, done.
>>     Finding extra edges in commit graph: 100% (2197197/2197197), done.
>>     fatal: commit-graph requires overflow generation data but has none)
>>
>> So even generating them completely anew doesn't seem to generate the
>> overflow generation data.
>>
>> Patrick
> 
> I stand corrected. I forgot that the repository at hand was connected to
> another one via `objects/info/alternates`. If I prune commit-graphs from
> that alternate, too, then it works alright with your patches.

OK, thanks. That clarifies the situation.

I ordered the patches such that the fix in patch 4 could be immediately
testable, which is not the case without patch 3. However, it does leave
this temporary state where information can be incorrect if only a subset
of the series is applied.

> This makes me wonder how such a bugfix should be handled though. As this
> series is right now, users will be faced with repository corruption as
> soon as they upgrade their Git version to one that contains this patch
> series. This corruption needs manual action: they have to go into the
> repository, delete the commit-graphs and then optionally create new
> ones.
> 
> This is not a good user experience, and it's worse on the server-side
> where we now have a timeframe where all commit-graphs are potentially
> corrupt. This effectively leads to us being unable to serve those repos
> at all until we have rewritten the commit-graphs because all commands
> which make use of the commit-graph will now die:
> 
>     $ git log
>     fatal: commit-graph requires overflow generation data but has none
> 
> So the question is whether this is a change that needs to be rolled out
> over multiple releases. First we'd get in the bug fix such that we write
> correct commit-graphs, and after this fix has been released we can also
> release the fix that starts to actually parse the generation. This
> ensures there's a grace period during which we can hopefully correct the
> data on-disk such that users are not faced with failures.

You are right that we need to be careful here, but I also think that
previous versions of Git always wrote the correct data. Here is my
thought process:

1. To get this bug, we need to have parsed the corrected commit date
   from an existing commit-graph in order to under-count the number
   of overflow values.

2. Before this series, Git versions were not parsing the corrected
   commit date, so they recompute the corrected commit date every
   time the commit-graph is written, getting the proper count of
   overflow values.

For these reasons, data written by previous versions of Git are
correct and can be trusted without a staged release.

Does this make sense? Or, do you experience a different result when
you build commit-graphs with a released Git version and then when
writing on top with all patches applied?

> The better alternative would probably be to just gracefully handle
> commit-graphs which are corrupted in such a way. Can we maybe just
> continue to not parse generations in case we find that the commit-graph
> doesn't have overflow generation data?
>
> This is more of a general issue though: commit-graphs are an auxiliary
> cache that is not required for proper operation at all. If we fail to
> parse it, then Git shouldn't die but instead fail gracefully just ignore
> it. Furthermore, if we notice that graphs are corrupt when we try to
> write new ones, we may just delete the corrupt versions automatically
> and generate completely new ones.

You are right that we can be better about failures here and report
and error instead of a die(). Especially in this case, we could just
revert to topological levels instead of throwing out the commit-graph
entirely.

This seems like something for another series, so we can be sure to
audit all cases of fatal errors when parsing the commit-graph so we
catch all of them and do the "best" thing in each case.

Thanks,
-Stolee
