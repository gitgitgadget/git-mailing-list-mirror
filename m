Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F7AC433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 18:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJJSNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 14:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJJSNN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 14:13:13 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBDC631F2
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:13:12 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p16so3356613iod.6
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHT6RseWRecgF3Gkq3ELEqwhg5uHhL84htxuEbuG7CA=;
        b=itIv7nkxuLZsY5vFoGxEAtd3F49DKSGQQwLk7qG58+zHbA4IPwC9l4i+AK3wqED14C
         oN6RgmxrcyGA8Jw5N6eDvvdItUPlMvwWkuX/upT/yiHA+dUGviIvC4s/EzHeNVRr7yi+
         rL7+EYC4Xk8hFfV8JWLwR6rOjXBxU+lE1sVjfwQm6hn4j1RzXhrkLVYtNm7mBvgdLKoD
         cwhFJqFUU+Lq6llwER0sOMCAuXBZePkKhWd//hLpRs12LDVx6aZaGQtk2f0y8f8Wo5X1
         t832FbfEHPo/t+TiarqAykCXrCtL1rwGPx4auKvRM/rcn+1yhuVQjsmUQ800jLGnyQGV
         uqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHT6RseWRecgF3Gkq3ELEqwhg5uHhL84htxuEbuG7CA=;
        b=m9YqRNy3gPxqQgKWxP2tCHSVXNunnXuq2z7wFVmKMh9QuM8uw/XzzzpHppL9dulsKJ
         93rLmtPKrn7LHQZKJ1J82OM7D77wFrlLC3irDZcAqD3yg6D60XN/7Mszh33JZNFz2ak+
         celIQ5swRa78MjO5ClbM9EltFQhsGC56WSv/LohVp72DPU1qPBdcZI+5KjThJ6/dqIiu
         JtRgHk3lpmJ8ZEaw++GmS9EfKNTnETwvE2ACdvMoSHvu2p46wuEpWFo12F6+/lT78q5i
         BaLiO8CqvOHw8m8D8XB6D33ru8pLa0VK8ht6u2XGcspxqGP4GbXJG6YLs4eiR2BQZg/w
         dRKA==
X-Gm-Message-State: ACrzQf1aH5FshTnSTxmIrPDAkbyuwX+W5K+dboN6yYAWd70BmJuR4MXG
        47Bawyhrd7Vcznc6AWTv8Grz
X-Google-Smtp-Source: AMsMyM4mn9ghkoHuY3LdqZfXeWrFQtlVDpQdQEfW6A5lRfVMzZRGBQasEFBqNzP4tfVHH1QSX/2CwA==
X-Received: by 2002:a05:6638:25d3:b0:35a:41e1:bb6a with SMTP id u19-20020a05663825d300b0035a41e1bb6amr10752747jat.36.1665425592304;
        Mon, 10 Oct 2022 11:13:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2102:4070:cf6:fed2? ([2600:1700:e72:80a0:2102:4070:cf6:fed2])
        by smtp.gmail.com with ESMTPSA id m5-20020a023c05000000b00359ae384ffbsm4366072jaa.19.2022.10.10.11.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 11:13:12 -0700 (PDT)
Message-ID: <08877824-b454-df37-1819-edee34919f95@github.com>
Date:   Mon, 10 Oct 2022 14:13:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 08/11] bundle: add flags to verify_bundle(), skip walk
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>
References: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
 <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
 <83f2cd893a4c47c947a93fe99d202d67f540e963.1665417859.git.gitgitgadget@gmail.com>
 <xmqqbkqj4mj7.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqbkqj4mj7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2022 1:27 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> When unbundling from a list of bundles, Git will create refs that point
>> to the tips of the latest bundle, which makes this reachability walk
>> succeed, in theory. However, the loose refs cache does not get
>> invalidated and hence the reachability walk fails. By disabling the
>> reachability walk in the bundle URI code, we can get around this
>> reachability check.
> 
> The above makes it sound like the real culprit is that cache goes
> out of sync and the presented solution is a workaround; readers are
> left in suspense if the "real" solution (as opposed to a workaround)
> would come in a later step or in a future series.

I've been going over the refs code multiple times today trying to
fix this "real" culprit, with no luck. I can share this interesting
point:

 * The initial loop over the bundles tries to apply each, but the
   prerequisite objects are not present so we never reach the revision
   walk. A refs/bundle/* ref is added via update_ref().

 * The second loop over the bundles tries to apply each, but the only
   bundle with its prerequisites present also finds the commits as
   reachable (this must be where the loose ref cache is populated).
   Then, a refs/bundle/* ref is added via update_ref().

 * The third loop over the bundles finds a bundle whose prerequisites
   are present, but verify_bundle() rejected it because those commits
   were not seen from any ref.

Other than identifying that issue, I was unable to track down exactly
what is happening here or offer a fix. I had considered inserting
more cache frees deep in the refs code, but I wasn't sure what effect
that would have across the wider system.

>> diff --git a/bundle-uri.c b/bundle-uri.c
>> index 8a7c11c6393..ad5baabdd94 100644
>> --- a/bundle-uri.c
>> +++ b/bundle-uri.c
>> @@ -301,7 +301,13 @@ static int unbundle_from_file(struct repository *r, const char *file)
>>  	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
>>  		return 1;
>>  
>> -	if ((result = unbundle(r, &header, bundle_fd, NULL)))
>> +	/*
>> +	 * Skip the reachability walk here, since we will be adding
>> +	 * a reachable ref pointing to the new tips, which will reach
>> +	 * the prerequisite commits.
>> +	 */
>> +	if ((result = unbundle(r, &header, bundle_fd, NULL,
>> +			       VERIFY_BUNDLE_SKIP_REACHABLE)))
>>  		return 1;
> 
> This is not a new problem introduced in this new round, but if we
> are updating this, can we fix it to omit assignment inside if
> condition?
> 
>  * result is initialized to 0.
> 
>  * when unbundle returns non-zero, it is assigned to result and the
>    function returns immediately, discarding whatever was assigned to
>    the variable.
> 
>  * if unbundle returns zero, it is assigned to result and the
>    control continues from here.  We know result is set to 0, but
>    then that is what it was initialized earlier.
 
Since we are not "trusting" the integer result of unbundle, we
can definitely stop this assignment in the if.

Thanks,
-Stolee
