Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A73C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB3826124A
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242692AbhI1USk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhI1USj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:18:39 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2E1C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:16:59 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id z11so34855oih.1
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l37EDkycn3jIuu9REsMQeYLu1EzCbWdTDmR2bA7VXe8=;
        b=ni+Zl+5Nhf/d+3cwGpSiS16fW5+tY7L8UZSgjPka2G8FqdmS9u8i68wxzaopllVUmZ
         PQGhTsPvJu8P1cYoq4Vq4DRQFhT9vzez2Vn9jmGVEmuZkn/Sr53H5HzcpI4gZWVHkZvU
         K8SmsmOshkc0szQRtMtL+eVFa0PWa1WzOx1hEc743VBdos6VvO9eIxPRrjFOmo8lad0s
         qZ6Ohz657rSqIe6tUfsTPRt6PcBLXt6YFbAdCakxf7uqySfvVr/bdbclvwL7DKYWulmy
         CpNV7EBi3V3c8t3jO548hfXbLTGoFk26afy8dKdc8yeWmgE6RtQUusojvdoya8D8sZnM
         RpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l37EDkycn3jIuu9REsMQeYLu1EzCbWdTDmR2bA7VXe8=;
        b=unEK6VA6GPi4/8oKtYkRne4cARxz33uFp78uYzJbzQRMRm2bDwFw//ZAJ/7usNZaup
         maaem1mcrTCezTHVp33yRrIawAzQyT9mLy7O4l8UgWiPqydbOPXsSFLdwHMqNezQ+Uuc
         t8oZp9jBXIgwBhShJ4w/pf0nhM940jzxkmSLCGiajsffAyQDuDH+grpppfr3iFJDjZBN
         ejb1SGqFvu6OEVRGVBN8P9hQWlq6rfpeHHOkeCQI7wcE8mQ8ycmVhhepNYTWIN1+7GRq
         THbYs7PhYqeE62lQinm6nxhzkkXj9jDllvhWj0QvmCu7lC1KeBLytItFPmq9LkuAbHKc
         NUUg==
X-Gm-Message-State: AOAM530O8vTMWkHk8d4s0XQoJgnr7NoZ+GZro4130DpNmO+1uHCK/nFZ
        OIbTDzOZ94xec0M51JigXm/P57Cyo4ySIQ==
X-Google-Smtp-Source: ABdhPJxiGzFPDJ7Tblh447tQfkEf8Le35yqHr0xn3p0U8qADve/rm+rRMtbMsk5DEkm3C4EDwXHIwA==
X-Received: by 2002:aca:3304:: with SMTP id z4mr2474551oiz.68.1632860219068;
        Tue, 28 Sep 2021 13:16:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ce8:d663:cc6a:5d40? ([2600:1700:e72:80a0:ce8:d663:cc6a:5d40])
        by smtp.gmail.com with ESMTPSA id z17sm325ooz.38.2021.09.28.13.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 13:16:58 -0700 (PDT)
Message-ID: <98d25b30-9961-3356-69f0-890f9b1006da@gmail.com>
Date:   Tue, 28 Sep 2021 16:16:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
References: <xmqq8rzhmsi7.fsf@gitster.g>
 <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <97eb5075-2ef3-8891-138a-44a035437404@gmail.com> <xmqq7df0li4n.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq7df0li4n.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/28/2021 1:33 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> Yes, I agree. I was waiting to see if more comments trickled in, but
>> it seems stable now. Do you want me to re-roll the whole series, or
>> do you want to apply the fixup below?
> 
> Let us wait for a bit more trickling in, but in the meantime, here
> is what I'd keep.  Thanks.
> 
> [ds/add-rm-with-sparse-index] $ git range-diff @{1}...
>  1:  f1309dd7be !  1:  edd2cd345f t1092: behavior for adding sparse files
>     @@ t/t1092-sparse-checkout-compatibility.sh: test_sparse_match () {
>      +	for repo in sparse-checkout sparse-index
>      +	do
>      +		# Skip "unmerged" paths
>     -+		git -C $repo diff --staged --diff-filter=ACDMRTXB -- "$file" >diff &&
>     ++		git -C $repo diff --staged --diff-filter=u -- "$file" >diff &&
>      +		test_must_be_empty diff || return 1
>      +	done
>      +}
>  2:  9a8c340809 =  2:  f6526728f9 dir: select directories correctly
>  3:  2a4e495cd4 =  3:  ed4958477b dir: fix pattern matching on dirs

That's exactly the diff I was hoping for. I'll keep an eye for more
feedback.

Thanks,
-Stolee
