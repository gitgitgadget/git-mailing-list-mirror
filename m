Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4198AC6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjDYSaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjDYSaH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:30:07 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC7AAD3B
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:30:03 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b951f5e1b3fso4632772276.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682447403; x=1685039403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J73d0uED9lDULY6glY7Sl0d1FgyJ64lvkQaEd85h4Us=;
        b=esNLQV/ABY79ZC+BifZg47UJg1zWcwMxHmu2+jbgWjPlMauD5/lcz0rRuKSv0bF717
         vH/2j0lULrPAM4ZpZ9bjMH6JJ3nrKoJ0dhllK+VWTDWbJKxfXhDQBerAdJMjeupAGBtU
         cUCFa+rAg9lDpqI9WB26RrJ1lcWrfnReMcT4CjPrX+fYu/qDQhfRWgNvZ1kErBOcfZbi
         EmCBDAOPLs8A4duHVyVALKLVdt0LFNnMll6qDk3ILLUflDKXg0x0QpvT+bW9qUvO8cCP
         g0f9wAFMbzSpbj+FN2q9xLLclHaUwPYneRw1b8mj9V/QVpGax73ExEB+wYBtpP6kKZBy
         Os+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682447403; x=1685039403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J73d0uED9lDULY6glY7Sl0d1FgyJ64lvkQaEd85h4Us=;
        b=IxPD31ertYDlPEa9VyOpCZ221Smg2PS/6ZQdn9tsGk2GRwJcU6EDAePHfCfQdix9jB
         gcZkgFYi6KaI3IAVSTj1ayNP1DdmLB9BwydIKKONi43briF4O9JDZHwuFN0Hxb5d8JKT
         aKkNgCW4n6NJpyW66IzI+QuxDnamc5j2g9uaEjK40l93kf/ZH7tacADqYIrget8x23t9
         Jt66732TQNPq1l7OTxJ+llsAdM1FdZ7hDEBkmh9Jfsfh9JimFA4rd+CKdd98RCvIWyt3
         TPojVVuTCYr+qBYcenNjamM0EtjY5xddtNGWWI0jSTREN7RTPV9lzXCkeEHyZ6W6ujZb
         AKyQ==
X-Gm-Message-State: AAQBX9dUvL6pPZoxngUnRXsSllMkbe8RXCo2hfkpo3mtzQ7u4KylFNIa
        gLH2s0gBxWHgMwFzKyHSVnn9+wDtV3tVpiZ0tA==
X-Google-Smtp-Source: AKy350ba1PIuVYKd3pJVBoJz0hATDQeaUtiyiEXm6LOEE90DfcZkFA6bRhCZtuYaV7RyVGMrIm5K5Q==
X-Received: by 2002:a25:378d:0:b0:b8f:66e8:445e with SMTP id e135-20020a25378d000000b00b8f66e8445emr12375946yba.8.1682447402939;
        Tue, 25 Apr 2023 11:30:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9117:8293:39bd:7100? ([2600:1700:e72:80a0:9117:8293:39bd:7100])
        by smtp.gmail.com with ESMTPSA id a33-20020a25ae21000000b00b8eeb4dc37fsm3618078ybj.9.2023.04.25.11.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 11:30:02 -0700 (PDT)
Message-ID: <1a09d246-5750-7d98-08f7-bad6d3dee3c9@github.com>
Date:   Tue, 25 Apr 2023 14:30:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] pack-bitmap: boundary-based bitmap traversal
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
References: <cover.1682380788.git.me@ttaylorr.com>
 <xmqqy1mfzvpq.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqy1mfzvpq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/2023 2:02 PM, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>> This improves many cases where using bitmaps was significantly *slower*
>> than regular, non-bitmap traversal. In some instances, using bitmaps is
>> still slower than the non-bitmap case, but it is a substantial
>> improvement over the classic bitmap walk.
>> ...
>> In a large repository on GitHub.com, the timings to compute the objects
>> unique to "master", as in:
>>
>>     $ git rev-list --count --objects master --not --exclude=master --branches
>>
>> improve as follows:
> 
> Curious---when would it be significantly faster to use bitmaps?
> "Most of the time"?  "In not-too-large repository?"

This is an interesting question that is very difficult to predict
in advance.

When building an independent implementation of reachability bitmaps
for Azure Repos, we never managed to make the bitmap method faster
for incremental fetches, on average, and so only enabled them during
full clones (no haves).

Of course, it's relatively easy to construct something that looks
like an incremental fetch but is as expensive as a clone (include
one have being a root commit), but it is very rare in practice.

It would be interesting if we used the initial commit walk to the
boundary as a predictor of whether bitmaps would be good, or if
we should use the tree-parsing walk instead.

But perhaps this series gets the bitmap walk "close enough" in
the typical case that it's better to use bitmaps in the chance that
we have accidentally hit a case where we'd normally need to walk a
lot of trees.

Thanks,
-Stolee


