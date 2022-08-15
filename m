Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352BCC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 13:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242837AbiHONSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 09:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHONSl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 09:18:41 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0F7183B4
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 06:18:40 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 10so2342540iou.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=zsVJtcjilHgbDuTVjq2T1ruw4+F6OY1HASJMUvnYb/E=;
        b=N/20ziEhfBMWnOlGlw+6YwBrbSvldZDAjmPeJWq7o/UG/i1GZvYGwAGCwbbfhY7F8I
         Wr5ZRTsIz3tkgXVETW4dbFqA+lZyFISdu0BNgu5cV2nv1Pjgx+n+8pzzaHMOyZBNn1gU
         KXUdo11aBzrCdD/F7YgZvpmx2naJ0DyqpMAUYAN48re+rxr/w2v7fXRQa1ie8YhTjCZn
         e36PWUiX/pgupeBm5z+zHrqhQtRGVefbvdg7HRcGzjG0g+obdKVJeNBejD/AmEyyeRpd
         oqCLSzYMEeQ01SSmxYZG/5lWxh6b7t9wUb9KM+OVntM1TJHNHPPeYXu8noi0YMelUhvs
         mM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=zsVJtcjilHgbDuTVjq2T1ruw4+F6OY1HASJMUvnYb/E=;
        b=Ogps61vEQ++mmO8+Rn6zoHvea7kHMHvS2iSpFJLkmaS15RFa33HLsHz1PVVrG0uD4M
         /BRjnGSCcHi9gfGIJpWnCy/XYY5uxneagAq6N/QagV3ArgUrKi2bTzaxL2+uf9mStyBV
         cK0yUWyjWuvhmWf3UZ4+UyEsmlndVU7GrPyuEp8ylElggrPxjceaNTyDRUejnqBN/WK5
         rDBP2/ECw58D8nic2aYhWdfa9G36Ot6dK0qypGqmvH7pE5xWDYDeqdbI/7byxb+BPPNX
         zGDWysaqKgBDYsFQX7yPvRsg6mGSQiZvmEnXG8a4fAhHRJXpQNzZkM8AZyNcF3Cl9Ppk
         hzaA==
X-Gm-Message-State: ACgBeo3/FdXjNPt4nnfYvae0RPNA7yGaIwLUWRhSAIl/wxlFJ62fork8
        bKQuDjEyNPTb/IWhC3sdG6WP
X-Google-Smtp-Source: AA6agR7V07tyHx5KUpicMh2sCM841D/7G2dDoLHF236ynU8nciKePTUgMghyAD0rwsPLkO+WzUHxkg==
X-Received: by 2002:a6b:ba08:0:b0:688:5fd3:e75b with SMTP id k8-20020a6bba08000000b006885fd3e75bmr1587477iof.59.1660569520180;
        Mon, 15 Aug 2022 06:18:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:dc96:39f4:9d7d:e4b1? ([2600:1700:e72:80a0:dc96:39f4:9d7d:e4b1])
        by smtp.gmail.com with ESMTPSA id z5-20020a029385000000b0033f4e58cfadsm3219186jah.133.2022.08.15.06.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 06:18:39 -0700 (PDT)
Message-ID: <85e6fd08-c741-26d4-1393-4b115133e687@github.com>
Date:   Mon, 15 Aug 2022 09:18:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Partial-clone cause big performance impact on server
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?UTF-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?UTF-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?UTF-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?UTF-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
 <YviaoXRctE9fg/mB@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YviaoXRctE9fg/mB@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/14/2022 2:48 AM, Jeff King wrote:
> On Thu, Aug 11, 2022 at 08:09:56AM +0000, 程洋 wrote:
> 
>>     4. And we then track our server(which is gerrit with jgit). We
>>        found the server is couting objects. Then we check those 40k
>>        objects, most of them are blobs rather than commit. (which
>>        means they're not in bitmap)
>>     5. We believe that's the root cause of our problem. Git sends too
>>        many "want SHA1" which are not in bitmap, cause the server to
>>        count objects  frequently, which then slow down the server.
> 
> I'd be surprised if bitmaps make a big difference either way here, since
> blobs are very quick in the "counting" phase of pack-objects. They can't
> link to anything else, so we should not be opening the object contents
> at all! We just need to find them on disk, and then in many cases we can
> send them over the wire without even decompressing (the exception is if
> they are stored as deltas against an object the client doesn't have).
> 
> I didn't generate a test case, but I'm pretty sure that is how git.git's
> pack-objects should behave. But you mentioned that the server is jgit;
> it's possible that it isn't as optimized in that area.

I just remembered that Gerrit specifically has branch-level security,
where some branches are not visible to all users. For that reason, blobs
cannot be served without first determining if they are reachable from a
branch visible to the current user.

I'm not sure if that's the problem in this particular case, but it could
be.

Thanks,
-Stolee

