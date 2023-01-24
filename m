Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BA6C25B4E
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 12:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjAXM1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 07:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAXM1a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 07:27:30 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0254FC171
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 04:27:08 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z9so12859233qtv.5
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 04:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VnML+2bZ2glBEn8Bn17mE5fbdiZmVxbLx6tD+Eq4bds=;
        b=hL4uKewDrAj6Dn7YCBDmgMbvbhPIZEuGdh6/y3bK8UBw2ssTFee3KhjpSICdl+DS8v
         B9ue/LKHlkpilez+xzKbKkdfyyWuejq91IZy4p9kESOZvdqHaCfXWFZ1l8x7x8LipwSd
         iw3tR2FhlrX5cs1FIensFE0zalosRKXcKWERgCpDb3wU51D6ig/9/+90kf3rnEXvmXA1
         8yTIPdBoEG/mLsX0VFv3YUH2+MYTwZpiEyB1Ka8/4Cik3ASt1CwmKqL1Y3KEfvySqvlP
         mrCHhRU6CqrCqt3Qw/rXUxAv0y45xLHbxJpQ+aJ0fBWAmUaAnOqXtxVumGXIoUEHWRTq
         ZXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnML+2bZ2glBEn8Bn17mE5fbdiZmVxbLx6tD+Eq4bds=;
        b=BF0yVlta3qP3VABu8o0KQz2180WzSSug9OSjHOpU1tVpgYBs7A800mLR6HPxEepxHK
         FLLgI3XuvMq0Xr9FB8Jd0wfJcoNNFiI7RZmWsv474zEDU3qvTitgX44XifF+7LHMea8i
         3sbv07X80bg5Doy89hmBoHagtl/VwAPUsw5cznVCcpbmVNRjk6DMSqKk+rDK9IfoXMW8
         5rcsqThRfpQhS9RGjYulVNquOoXeyGYX9BMluucw6LuKQEB4Ozxc0T8KOK/+3jrJQ8tm
         PpzyiJRkVRGKOMc1wtS3X/gXjCfu7dD/8Tfq7IsxZT35Y9e+bgVBYhUuH11opWfsM6O/
         ZE3A==
X-Gm-Message-State: AFqh2kpJQWo7IChTF+VWNO99aEa/JBllTwLN7DWuEvIbvp8en6s/XN6b
        YrF83NIT+HXP9pEw0jxXcVcb
X-Google-Smtp-Source: AMrXdXsDz5cJsxY7yUw4lQhBSce2pMwucWM33yyVfmG3Xw7i0PoYQw93h52UKONXCk/6h29nXSbhjw==
X-Received: by 2002:ac8:5ed3:0:b0:3b6:3596:182b with SMTP id s19-20020ac85ed3000000b003b63596182bmr36932572qtx.36.1674563226318;
        Tue, 24 Jan 2023 04:27:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:70c6:2d77:ae17:eae3? ([2600:1700:e72:80a0:70c6:2d77:ae17:eae3])
        by smtp.gmail.com with ESMTPSA id e127-20020a376985000000b006f9ddaaf01esm1297173qkc.102.2023.01.24.04.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 04:27:05 -0800 (PST)
Message-ID: <771a2993-85bd-0831-0977-24204f84e206@github.com>
Date:   Tue, 24 Jan 2023 07:27:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 01/10] bundle: optionally skip reachability walk
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
 <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
 <xmqqsfg1m8l6.fsf@gitster.g>
 <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com>
 <xmqqilgxm2ky.fsf@gitster.g> <xmqqtu0glw81.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqtu0glw81.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/23/2023 5:30 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> A repository having some unreachable objects floating in the object
>> store is not corrupt.  As long as all the objects reachable from refs
>> are connected, that is a perfectly sane state.
>>
>> But allowing unbundling with the sanity check loosened WILL corrupt
>> it, at the moment you point some objects from the bundle with refs.
> 
> While all of the above is true, I think existing check done by
> bundle.c::verify_bundle() is stricter than necessary.  We make sure
> that the prerequiste objects exist and are reachable from the refs.
> But for the purpose of ensuring the health of the repo after the
> operation, it is also OK if the prerequisite objects exist and they
> pass connected.c::check_connected() test to reach existing refs.
> verify_bundle() that is used in unbundle() does not allow it.

Thank you for all of the detailed explanation, here and in other
messages.

I'll focus on this area today and see what I can learn and how I
can approach this problem in a different way. The current options
that I see are:

 1. Leave verify_bundle() as-is and figure out how to refresh the
    refs. (This would remain a stricter check than necessary.)

 2. Find out how to modify verify_bundle() so it can do the more
    relaxed connectivity check.

 3. Take the connectivity check that fetch uses before updating
    refs and add that check before updating refs in the bundle URI
    code.

There could also be a combination of (2) and (3), or others I have
not considered until I go poking around in the code.

I'll let you know what I find.

Thanks,
-Stolee
