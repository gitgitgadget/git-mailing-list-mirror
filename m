Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4044C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242916AbhLFRhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbhLFRhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 12:37:02 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301A4C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 09:33:32 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id t23so22809632oiw.3
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xxa2YEvuqvcpxB1zuzfsCmmW0iCzuymFGabDDeT4HWk=;
        b=g755ZiGge79BQtDxOQIkSfP8AwfaKJz2lW6K+dItDY5nHTtdawwj46uy3mioiLOIEW
         mTMVFWObxfbQ6k5Hrk9pyDnlFzn+6Ez0iKJIx1I+lLcc5YAOiSzZHP/viwllOuXZuopH
         6arTwuhA3bT3Ovpiiwvx/MzwmvwIHcGEhCDJ6JAwliqyYyA1HYqke5KWEVp5SxRqi4kd
         ZDOSMwYzn2DEDBgzNuNg3YMC7ZnzmVQ76DdEpkzbiKABgMExs6d8MuJrqcPkJBYZ5tgu
         FhWCXFN64RTwHEj6uZU/K1RToaWPxEvcuTblBdXaNYZyUNPhw5eHmQXijU/7/CmwDtF+
         iHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xxa2YEvuqvcpxB1zuzfsCmmW0iCzuymFGabDDeT4HWk=;
        b=yOm6NG/lEIs8VvfZ4abyrF1qCd3SjGKLDTBPrGYqC4nZxCArnpQXsOAXVphVA174Ee
         gqN8UTByuDth3MpSzCYmx6S6HwIXS+rGp72bcHiyeThCQ6weithZf9yXbLSeHPckmUlU
         BXk6P2tU7wqvoIuqm865ujiD4oiEsN5Bx4DsJibExWO1JeRlSdSn5Q1/hox0hS0Q6Qg9
         8Q/tH3bM5KtPNVDMpx9RmTci8Y7BDgYLSDOd7MJDHuZ8K74vZb+bGK5jNX+fy32dUHn2
         IYjFLKXC6EslbdqxEiOVqa5DsT6k4VbWUvdJBTME5ciXjrb285el9G8/nZqdZUl/4CcU
         kPKw==
X-Gm-Message-State: AOAM531lSZnAaDCVH3hfLvglNMzJlKy3zcwsyNhfcifvCqDbEG+XXCP+
        rcRHpdbrgrUDpCs4EyE21WQ=
X-Google-Smtp-Source: ABdhPJzkwtrdCzFC2783PBo4mUUrhhRZcAVjQ+urMZSbLIoSj1adMAEZ40pe4vu/AmrOnUHFQjr88g==
X-Received: by 2002:a05:6808:1509:: with SMTP id u9mr24682467oiw.4.1638812012068;
        Mon, 06 Dec 2021 09:33:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c1ec:5177:a5cf:f9b? ([2600:1700:e72:80a0:c1ec:5177:a5cf:f9b])
        by smtp.gmail.com with ESMTPSA id bi20sm2939394oib.29.2021.12.06.09.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 09:33:31 -0800 (PST)
Message-ID: <518f6dde-e849-f9f1-ef9c-274cd9179ce0@gmail.com>
Date:   Mon, 6 Dec 2021 12:33:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 04/17] chunk-format.h: extract oid_version()
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        peff@peff.net, tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <ea245b7216067093fdd3a5b2e3a9390f634c8af0.1638224692.git.me@ttaylorr.com>
 <2d5456f6-5a4d-1600-83f3-2b6d3e1b270a@gmail.com>
 <Yaqc6FYo1pLhsNSB@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Yaqc6FYo1pLhsNSB@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/3/21 5:40 PM, Taylor Blau wrote:
> On Thu, Dec 02, 2021 at 10:22:05AM -0500, Derrick Stolee wrote:
>> I notice that you don't use this in load_pack_mtimes_file(),
>> in pack-mtimes.c but you could at this point.
> 
> Hmm, I'm confused. Te extracted function converts a pointer to a struct
> git_hash_algo into a uint32, but here we just care about reading the
> four byte value we wrote.

Ah. I got mixed up here. Sorry.

-Stolee
