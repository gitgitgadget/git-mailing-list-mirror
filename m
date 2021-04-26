Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B518C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 21:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD9161090
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 21:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhDZVfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 17:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbhDZVfk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 17:35:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F43AC061756
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 14:34:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e2so25360770plh.8
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RtHy3AYtgBv1EahtgocDFq2uVGtf5fEmWw6N/P0efCQ=;
        b=C7Rfb6VFkDUUGFiX1fFCWgNlQQXDDBtBxAFJGvFLy96EfN4qBsas1QMvrJh7Y9sb5J
         hSsHfyWm6DDLI/68Cdjmn4vOrzHPTeZHnOtgmgKe90fsCo4Uyv2fqxtv41s0FVoj//Zp
         KQxB1BE5mWh7hS4H0TeVBKPeJsp14O13kYAoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RtHy3AYtgBv1EahtgocDFq2uVGtf5fEmWw6N/P0efCQ=;
        b=Gdg5HiBRypcKow7bzGsL/Xz7BC9Nqc2ng7QJK0pG6KEEexg442nv4zQV5w7qWUOuDd
         rZFU9Vmtqgvkkxm7DQ80P2tI4GOAenwiY3C+9EqzgYY1LgbHkDiuv0aS9Td0kTJer5xt
         dzXJrDHjok63Hb6RgjGH5gnLONSyll1J4JEpwg3PcH3XU9JsZKC8jPiIfDTE8HqzfL1S
         5pk0chDFajz0dchOSetPNzBhiRBC/qbrnlrrH8lfLK6Niho8FfM5TJgh6Ch61OonGdap
         ZV7iij4TLdz+zFpMQuzzU5p2xB1N2MKiEEOX3GUS7fjIx+Est0Rxyq+vcC9SygZ6WcrB
         E63g==
X-Gm-Message-State: AOAM531aBC+tmB4mkFo3NNmYRenFHoverJAaXrQmiSEtlLJd96LIT2uf
        97xkVzmYApnSVBuPicOa8u9y/azs9Pjclw==
X-Google-Smtp-Source: ABdhPJxNlFGyYNCZJlvVl5XSkg+Gy0oETzYYq1gpaYtiWEES2+HoiODgI9H6LP+0cC9LRIR6aHDAqg==
X-Received: by 2002:a17:902:7c94:b029:e6:e1d7:62b7 with SMTP id y20-20020a1709027c94b02900e6e1d762b7mr20887419pll.29.1619472897767;
        Mon, 26 Apr 2021 14:34:57 -0700 (PDT)
Received: from [192.168.245.142] (cpc108961-cmbg20-2-0-cust748.5-4.cable.virginm.net. [80.5.130.237])
        by smtp.gmail.com with ESMTPSA id s13sm469442pjl.48.2021.04.26.14.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 14:34:56 -0700 (PDT)
Subject: Re: Track changes across multiple branches, c.f. "p4 interchanges" ?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
References: <d9022ce8-2752-db75-f4b7-d5188c41bd90@diamand.org>
 <xmqqpmynxxup.fsf@gitster.g>
From:   Luke Diamand <luke@diamand.org>
Message-ID: <7985e148-8bde-4b5c-ea7d-eb5c9f13e61f@diamand.org>
Date:   Mon, 26 Apr 2021 21:35:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqpmynxxup.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 21/04/2021 19:05, Junio C Hamano wrote:
> Luke Diamand <luke@diamand.org> writes:
> 
>> 2. Merge
>> ...
>> If I do "git merge bugfix" onto relbranch, then as well as getting X,
>> I also get B and C, which I don't want.
> 
> This won't work exactly for the reason why you want to do #3 below.
> 
>> 3. Always start from a merge base
>>
>> I could tell people that if they are making a bugfix that will need to
>> go onto multiple branches, that they need to start from some common
>> merge base, and then merge to the final target branches.
>> ...
>> And invariably people will start out thinking their change is not a
>> bugfix, but a new feature, and then find that actually we need the new
>> feature on the release branch.
>>
>> 4. Use gerrit change-ids
>>
>> We could adopt gerrit change-ids. It feels like this is kind of a
>> kludge, but perhaps it's the only thing that really works?
>>
>> Is there something better?
> 
> Just to throw another in for completeness (not claiming which one is
> better and which one is worse):
> 
> 5. Primarily use #3 to merge, but use "cherry-pick -x" when
>     replaying a fix that was built on a wrong base, and tweak the
>     procedure to find out "is this fix already on branch X?" to also
>     pay attention to it.
> 
> It is no worse than #4, I would think, as both approaches would need
> to scan the commit log messages to find the commits that are not in
> the ancestry chain that participated to the branch.

With the gerrit change-id I can enforce that every commit will always 
have a change-id - either a brand new one, or one that's preserved from 
another commit.

If I just rely on people to use "git cherry-pick -x" then they will 
certainly forget, or do it twice, because people make mistakes.

