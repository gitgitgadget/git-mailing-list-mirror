Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8B1C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 15:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjATPmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjATPmh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 10:42:37 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BA2210F
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:42:35 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-142b72a728fso6566108fac.9
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3rbb8tBgDc3fOun1jQI/Mcqn3grSUpCi4rHnlNKpmY=;
        b=VYLQl1Dg1wQZQPn5ORcbHNeVNAtlEsUUtxGr5sdMSxAZvRj7u/+xA5ivoC1uKvHoLe
         GHNryPq5kpXNebFvaaTFL7I5r2MqLSCxdr9arpdm/I2B9ocQLY8NvHRtieCzNJNq6QGe
         Q90tLexzVnZ1qcNwaoTNjUamitM6TefmpkXLVokgqXvpNBzlNueUkknro0W7FBvv1lnG
         EoiquEyz/gaublMtfp0M0T4PuY9mxpVgplm6NNeQsYu0KC/IL3NK672vgf50I1RtbM65
         BndFBr5eaQoMXqoit+iNKIbfDQU8ijfFTgH6WzOQYQzKgR3Q6Q020htUDuwcPMReQWdj
         m88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3rbb8tBgDc3fOun1jQI/Mcqn3grSUpCi4rHnlNKpmY=;
        b=hA9IXs1wMYHw6bvKO1/uR+2RrsVIjsWENIg6IateU3WO5p9ti6S2iPK14JTp4KizLf
         frHhdur+ojx+f/5PrBlCITX6fIaskMtQaFzslcv//CTwUrkSjhLsAvc5e6r9p5wpW1co
         k97zvXm6ojo0H9vzWXfnfEVQtryZxEyBPWZ3rR/aWvjGH7hqcFTEpiXE81wEEJjAEHja
         4yMc3FG7Wp/+kDQkcKeOcTexViTNOAatx9IcN/KN31OZa3chW/zzwUUH1l80pD8Sw6Ji
         jxUdpVkAF6HUX54kHHYz6nWrhOQrCNeszg+lxdQIJ5iNxMukCR8Qx/C0MdbJqUhonsRc
         tpQQ==
X-Gm-Message-State: AFqh2kpeXBrma9gducFkiiWK8i6vm/icZf39Z4QkHkFlnxuhncOE4hK0
        fGExnNjlA5GMLM5ehKOZr8Kj
X-Google-Smtp-Source: AMrXdXsj7l6aftMx3Tt+3pWziC64d5tuehqUJG0hvucsAVU8OjxCSZsMv+GaW6XlzWAzAx56T/k7NA==
X-Received: by 2002:a05:6870:6b93:b0:15b:8c60:52de with SMTP id ms19-20020a0568706b9300b0015b8c6052demr7765509oab.42.1674229353215;
        Fri, 20 Jan 2023 07:42:33 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ede7:6bce:9af7:733c? ([2600:1700:e72:80a0:ede7:6bce:9af7:733c])
        by smtp.gmail.com with ESMTPSA id f8-20020a056870d14800b00136f3e4bc29sm22038739oac.9.2023.01.20.07.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 07:42:32 -0800 (PST)
Message-ID: <75d25afd-f941-3090-5cac-f1a4ca7d9827@github.com>
Date:   Fri, 20 Jan 2023 10:42:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/8] clone: set fetch.bundleURI if appropriate
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <d9c6f50e4f218267c1e8da060ce5b190dc8a709c.1673037405.git.gitgitgadget@gmail.com>
 <61a830f0-a8d8-5a8a-e952-db213d571352@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <61a830f0-a8d8-5a8a-e952-db213d571352@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/19/2023 2:42 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:
>> diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
>> index cd65d236b43..4f796218aab 100644
>> --- a/Documentation/config/fetch.txt
>> +++ b/Documentation/config/fetch.txt
>> @@ -96,3 +96,11 @@ fetch.writeCommitGraph::
>>  	merge and the write may take longer. Having an updated commit-graph
>>  	file helps performance of many Git commands, including `git merge-base`,
>>  	`git push -f`, and `git log --graph`. Defaults to false.
>> +
>> +fetch.bundleURI::
>> +	This value stores a URI for fetching Git object data from a bundle URI
>> +	before performing an incremental fetch from the origin Git server. If
>> +	the value is `<uri>` then running `git fetch <args>` is equivalent to
>> +	first running `git fetch --bundle-uri=<uri>` immediately before
>> +	`git fetch <args>`. See details of the `--bundle-uri` option in
>> +	linkgit:git-fetch[1].
>
> Since it's not mentioned from this or any other user-facing documentation
> (AFAICT), could you note that this value is set automatically by 'git clone'
> iff '--bundle-uri' is specified *and* 'bundle.heuristic' is set for the
> initially downloaded bundle list?

Can do.

> It would also be nice to make note of that behavior in the documentation of
> the '--bundle-uri' option in 'Documentation/git-clone.txt', since command
> documentation in general seems to be more popular/visible to users than
> config docs.

Yes. I also thought that I had updated this documentation to not refer
to 'git fetch --bundle-uri', which doesn't exist anymore since an earlier
RFC version. I'll be sure to update that, too.

>>  	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
>> diff --git a/bundle-uri.c b/bundle-uri.c
>> index b30c85ba6f2..1dbbbb980eb 100644
>> --- a/bundle-uri.c
>> +++ b/bundle-uri.c
>> @@ -594,9 +594,10 @@ static int fetch_bundle_list_in_config_format(struct repository *r,
>>  	 * it advertises are expected to be bundles, not nested lists.
>>  	 * We can drop 'global_list' and 'depth'.
>>  	 */
>> -	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN)
>> +	if (list_from_bundle.heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN) {
>>  		result = fetch_bundles_by_token(r, &list_from_bundle);
>> -	else if ((result = download_bundle_list(r, &list_from_bundle,
>> +		global_list->heuristic = BUNDLE_HEURISTIC_CREATIONTOKEN;
>
> If the 'heuristic' field already existed and was being used to apply
> bundles, why wasn't 'global_list->heuristic' already being set? Before this
> patch, was the 'global_list->heuristic' field not accurately reflecting the
> heuristic type of a given bundle list?
>
> If so, I think it'd make sense to move this section to patch 4 [1], since
> that's when the heuristic is first applied to the bundle list.
>
> [1] https://lore.kernel.org/git/57c0174d3752fb61a05e0653de9d3057616ed16a.1673037405.git.gitgitgadget@gmail.com/

Can do.

Thanks,
-Stolee
