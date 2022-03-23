Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB557C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 21:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343512AbiCWVU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 17:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiCWVUz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 17:20:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431645FDD
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:19:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so7594791pjb.5
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SZyyrX/aN3MNEJjn2GNgfkjRPp8nP8aszKSJ6nBBkew=;
        b=PJcpLYND5fT/IsSe2o0IQVnZ/LIC8JvY/BbNpUd+YOAF6OgRVSHztGp1Jv9XHxv8Rx
         ZrO+jk+Z2ARp0YHHXwYV3KpyeEfyBvcnDd/XPwPCcyiKXKDWVJB5R6M77oxARVhCiYGC
         yEr+bW1oYxaKnHIYc7HAVsUSkraN65X2By/XH7OmgWFq9C/FmdFx6jqbtRAFBLw1hgNg
         mZ43y5GRY1+yCxzmFcKOTZ4ATpscvVxxlwatJWJPmDt0pZiEPa/rYah7oqFRrvsb2ulr
         SAFgtEoH2OZmoPGbtrOeycDK/GijytyUYKTSmgrNRS085Cxnf/5EW3OH4vxZSo83VMP5
         25Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SZyyrX/aN3MNEJjn2GNgfkjRPp8nP8aszKSJ6nBBkew=;
        b=F+koRcoNTUFGjXt1mA1nY411Fc9YpmEYUi3RubZBsCeH7aCkjeHsx1goqI/QPgdn7M
         dTPMc7cbgV03mPYyXeWZkJObBmi3plrSbplEHRMZbtbAY6E0+t2Tmrs+29gkGzGLw9bY
         nlUgLOOuioyZ7AsUmTSLsKfH7cehqcfTyR7l1Zi9MWGr87v1B5HIG236IUOhlT0eGB8G
         vJ/Vc9U/jd9AB8YNsnqZeJ+gJq3i8XpwtxJ8zRCJOKroEFM5nezBtdVD7fYcSr+T09eM
         DB++O1pnJumnBbbNIQOGT7y1bjOAHAaJ2m/nDgcYwmpWHRPn72xBzcQWb0uxguuBFRla
         w0yw==
X-Gm-Message-State: AOAM530/AWVYv5eT9Z5+P2k5HG5RwT6r2i4dfh8U+QBiEkSRMbOOULOZ
        lzNOnQ1ZnkbK/JRySroYcqVY
X-Google-Smtp-Source: ABdhPJyfod6y/ghqeildeYzhPYiTQSBrBkFwT96ugJ49p1tb9zJ3k6fS0zoXZmkxjJerngSwMY5FJg==
X-Received: by 2002:a17:902:7887:b0:154:4f3f:ec54 with SMTP id q7-20020a170902788700b001544f3fec54mr2069586pll.156.1648070364804;
        Wed, 23 Mar 2022 14:19:24 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7820e000000b004f7134a70cdsm780351pfi.61.2022.03.23.14.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 14:19:24 -0700 (PDT)
Message-ID: <1e69a59f-aa71-fb04-971b-6cffbd000512@github.com>
Date:   Wed, 23 Mar 2022 14:19:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        lessleydennington@gmail.com
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
 <fcfdcbb9-761a-0d34-7d36-61e0ef279922@github.com>
 <xmqqpmmcqtii.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqpmmcqtii.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>> I think the decision of whether to go with this approach or the alternative
>> listed below depends on the validity of a 'repository' without a gitdir. 
>>
>> As far as I can tell, there is an implicit conflict between the changes in:
>>
>> 1. b66d84756f (commit-graph: respect 'commitGraph.readChangedPaths',
>>    2020-09-09)
>> 2. 44c7e62e51 (repo-settings: prepare_repo_settings only in git repos,
>>    2021-12-06) (as you pointed out in your message)
>>
>> The former says that commit-graph should use a repository setting (implying
>> it needs a valid repository), and the latter says that you need a valid
>> gitdir to get repository settings.
>>
>> So to me, how to proceed depends on whether a repository can be "valid"
>> without a gitdir or not:
> 
> Sorry, I do not get it.  What does "a repository without a git dir"
> look like?  It does not make any sense to me.  A repository without
> working tree, I can understand.

I think that answers my question - if it doesn't make sense to have a
"repository without a git dir", then the code shouldn't allow
'the_repository' to be used without a valid 'the_repository.gitdir'. The
'BUG()' in 'prepare_repo_settings()' enforces that condition right now, so
removing it like this RFC does would make the tests fragile and the code
more prone to future bugs.

That said, if it's conceptually sensible for 'fuzz-commit-graph' to work
without a repository, then it could be updated to get its defaults from
somewhere other than 'the_repository' when the repo doesn't exist (like what
I mentioned in [1] ("If the 'repository' really is..."), or Taylor's
suggestion in [2]).

[1] https://lore.kernel.org/git/fcfdcbb9-761a-0d34-7d36-61e0ef279922@github.com/
[2] https://lore.kernel.org/git/Yjt6mLIfw0V3aVTO@nand.local/
