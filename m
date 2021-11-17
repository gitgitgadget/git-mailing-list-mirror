Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F3CC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 16:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C770361BFB
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 16:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhKQQzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 11:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhKQQzF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 11:55:05 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B427C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 08:52:06 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t30so5908635wra.10
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 08:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ojtWQvv3GfCOcF+OqqNwLHmJ/o3CzCCNFF6TTl2mdpw=;
        b=L9MlwFaW4ux31iqH4ACldoQPPqxun/TJFFdqgtFSWh9FeOaNeHx5HWMC6vuHgdkj5u
         hLTvy1tfXhCDE23+t9sKw6pidXLMX5S9SRTuhS7hHm0uzsdWrdjRKX/Vuyjso/QtEBXd
         /rEuY3RJHY5UDmm/HnYnIKahZ1+6zZV7O0oxfqtzNEWHrgdD7bpaToQn2Tiawy4kKQte
         uWNs6Fiws1TtSgp/IW8W++IkAx82j2k9i3qNS23rpiqb2F2fWRD8fNQm5UhLwX1A2awt
         vwvddeV9++1YNTuc9r3ar5uxFHbl8cfeDHEXXHKUMCOeWgBpP1eJ2h6XJdBoJYiymhBa
         hiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ojtWQvv3GfCOcF+OqqNwLHmJ/o3CzCCNFF6TTl2mdpw=;
        b=5QVw6JXdFqk+bMzWgln65M84H6vkvp/5LRkVoJNkNM0WsvXoUUUhobAXQCYKS5oDFM
         9f5teXMyo5skzFidRbMYXr/W/lXKnIz3jNgPyDwJCcNxK6xgbGyUZ8FdmgFyyAp+mxyW
         FbjQ+1FBYZVtFwnh4j4zHu8NOqDYEch0Kzxn9RsJnYMeY+P3fECKGFpxBoRJsSAaOfWT
         oH7kKfs9IpsVAC7/lQp8I1Cnv71wzZEtX2NCK6UJ9jQ8hOkdBt4HUhB8VPDQiSle1P8f
         9SFO4t9w4pefSvlbS9KPIsboPTgFvzWULTt0WUiZ/J5GDEzuCyx6rAow2UxgNt+KvdzZ
         bqCQ==
X-Gm-Message-State: AOAM532d5S3xLIrKFUVBD/sFEiHNE+sgF0Imy4r9yvFJ3gasyPlT+ibt
        wTNFMRXBXo02UHXeXvz7KPderDAFKl7g7Q==
X-Google-Smtp-Source: ABdhPJx/YZhtoxNEY+zNT21lTDk2b63o+lv0XTvBMg1vGeETp2yajo+XupM3NI1+CePzxJu6ZjInAA==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr22154323wrx.426.1637167925030;
        Wed, 17 Nov 2021 08:52:05 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id h18sm426426wre.46.2021.11.17.08.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 08:52:04 -0800 (PST)
Message-ID: <88eaee89-4536-fba4-3aa0-c3693f58eae0@gmail.com>
Date:   Wed, 17 Nov 2021 16:52:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/3] diff histogram: intern strings
Content-Language: en-GB-large
To:     Derrick Stolee <stolee@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
 <38c771a74d2a348e6a752555f95b746de029b1d7.1637148025.git.gitgitgadget@gmail.com>
 <2b2bd380-540f-959b-b950-cfdc95cbff29@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <2b2bd380-540f-959b-b950-cfdc95cbff29@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 17/11/2021 15:55, Derrick Stolee wrote:
> 
> 
> On 11/17/2021 6:20 AM, Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Histogram is the only diff algorithm not to call
>> xdl_classify_record(). xdl_classify_record() ensures that the hash
>> values of two strings that are not equal differ which means that it is
>> not necessary to use xdl_recmatch() when comparing lines, all that is
>> necessary is to compare the hash values. This gives a 7% reduction in
>> the runtime of "git log --patch" when using the histogram diff
>> algorithm.
>>
>> Test                                  HEAD^             HEAD
>> -----------------------------------------------------------------------------
>> 4000.1: log -3000 (baseline)          0.18(0.14+0.04)   0.19(0.17+0.02) +5.6%
>> 4000.2: log --raw -3000 (tree-only)   0.99(0.77+0.21)   0.98(0.78+0.20) -1.0%
>> 4000.3: log -p -3000 (Myers)          4.84(4.31+0.51)   4.81(4.15+0.64) -0.6%
>> 4000.4: log -p -3000 --histogram      6.34(5.86+0.46)   5.87(5.19+0.66) -7.4%
>> 4000.5: log -p -3000 --patience       5.39(4.60+0.76)   5.35(4.60+0.73) -0.7%
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   xdiff/xhistogram.c |  5 ++---
>>   xdiff/xprepare.c   | 24 ++++++++----------------
>>   2 files changed, 10 insertions(+), 19 deletions(-)
>>
>> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
>> index e694bfd9e31..6c1c88a69a1 100644
>> --- a/xdiff/xhistogram.c
>> +++ b/xdiff/xhistogram.c
>> @@ -91,9 +91,8 @@ struct region {
>>   static int cmp_recs(xpparam_t const *xpp,
>>   	xrecord_t *r1, xrecord_t *r2)
>>   {
>> -	return r1->ha == r2->ha &&
>> -		xdl_recmatch(r1->ptr, r1->size, r2->ptr, r2->size,
>> -			    xpp->flags);
>> +	return r1->ha == r2->ha;
>> +
> 
> nit: stray newline.
> 
> The only meaningful change here is that you are relying entirely on
> the hash and not checking the content again. This means that hash
> collisions on this 32-bit hash could start introducing different
> results. Are we worried about that?

xdiff-interface.c limits the size of the file that can be passed to just 
below 1GB so we are safe. The other diff algorithms are already using 
this optimization. (the hash is 64 bits on most platforms, the xdiff 
code could really benefit from a unsigned long -> size_t cleanup)

> I see that a similar hash-comparison is done in xpatience.c without
> further checking the contents, but xdiffi.c compares the hashes and
> then checks with xdl_recmatch(). So, we are still not reaching full
> consistency across all diff algorithms with how we handle these
> comparisons. I think it is good to have at least one that can be used
> if/when we hit these hash collisions within a diff, but it can be hard
> to communicate to a user why they need to change a diff algorithm for
> such an internal reason.

I think that code in xdiffi.c is only used by the diff slider code that 
implements diff.indentHeuristic, the Myers diff implementation just 
compares the hash values. Before this change the diff slider code needed 
to do the full check to be correct when processing the output of the 
histogram algorithm.

> The following bits looked scary at first, but you are just removing the
> special-casing of XDF_HISTOGRAM_DIFF from the preparation stage.
> 
>> -	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF)
>> -		hbits = hsize = 0;
>> -	else {
>> -		hbits = xdl_hashbits((unsigned int) narec);
>> -		hsize = 1 << hbits;
>> -		if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *))))
>> -			goto abort;
>> -		memset(rhash, 0, hsize * sizeof(xrecord_t *));
>> -	}
>> +	hbits = xdl_hashbits((unsigned int) narec);
>> +	hsize = 1 << hbits;
>> +	if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *))))
>> +		goto abort;
>> +	memset(rhash, 0, hsize * sizeof(xrecord_t *));
> 
>> -			if ((XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
>> -			    xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
>> +			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
> 
>> -	if (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF &&
>> -	    xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
>> +	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
> 
>> -	if (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)
>> -		xdl_free_classifier(&cf);
>> +	xdl_free_classifier(&cf);
> 
> The existence of these conditions gave me pause, so I went to look for where they
> were inserted. They were made in 9f37c27 (xdiff/xprepare: skip classification,
> 2011-07-12) with the justification that
> 
>      We don't need any of that in histogram diff, so we omit calls to these
>      functions. We also skip allocating memory to the hash table, rhash, as
>      it is no longer used.
> 
>      This gives us a small boost in performance.
> 
> But you are actually _using_ these preparation steps, which means you are
> re-adding the cost of hashing but overall improving because you use the
> data correctly. Excellent.

Thanks for looking at this

Best Wishes

Phillip

> Thanks,
> -Stolee
> 
