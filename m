Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87938ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiISRwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiISRwM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:52:12 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF2446616
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:51:36 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id f26so14783qto.11
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mkKB6JwkJyBppJc7xIpKT8xYhtHrbQB8MiCAD7+a/CQ=;
        b=T3v+d5ewloY2Ao4/5SFy72dEmV+Mg9QFlOCXaC+VVSMaDp0CLijvQ5cJIAApqnNhCW
         7ry5huUtKTcNdDJgeBGc2pF7T5BAcSmCvULa3AqLyETYLeC+W0I9cWZgCKQTAHOuw773
         Kl3aNEdgBQSNVbEX7yc4um0FlWZR/oSipgSyUAcBBmpMz1OYYTeQv0ehmYBjpuNH5ko+
         AdMM85N1MUYK26WOfGnz7OlSFKn0RwX79iynZtccI3yHs2ns7AIr5MvYrAom8SuDoY7/
         Md7d1aBWBjNjbOQRD5ZZ3FYlGCGCEqaa7dKODB2hmWCanPOL+zlTavgGvqAAX/Ag2TAu
         qm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mkKB6JwkJyBppJc7xIpKT8xYhtHrbQB8MiCAD7+a/CQ=;
        b=d8du5D6XNuH6cX/IWvGENasy21IB62+e0gUoCHkBI03WMpkj+QQO0fJvyKmXP/XCzX
         JuPkJFmAdjGk6amrwrpUE7eXwsJC42+kdoAOu+mKxAPGHrPev0s/vq3DorRhhwYqu7pI
         h/rxdHxmiwUKWHnAoX8yoEdDSR04egLmbusNk2rvEzT8dz9RM07hkFCQWUMBHMNpykDI
         EbSPTgOWN01hwrXhCmsVU1hJy3dNKcgCB6p+jcTQ9ScvOF7qe+p/emwqRzxBKMzky2Ke
         VZMvIYXfgk13mLwj8tzPk4jhZMnrgDDZbfZL9qa2m2GFfAGBAzo9FXi+GKFVjDSy8+9O
         MI/w==
X-Gm-Message-State: ACrzQf1LphTTxJfIrxEbpgvfnNj+YmH/ZZLhY7qtIKh1Q9pXgJBXF5u9
        uPIrpicelb6PKcBNQbT8CDgtF2NLN1tR
X-Google-Smtp-Source: AMsMyM6QST+0ij0M+0gN2Vyo+aceXKvDsVBqyKU5oRiDy/AL/4537MDbQ/9NOjsMR+NCe5tHmuBclA==
X-Received: by 2002:a05:622a:492:b0:35c:df7b:448e with SMTP id p18-20020a05622a049200b0035cdf7b448emr8830057qtx.87.1663609895590;
        Mon, 19 Sep 2022 10:51:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id fz16-20020a05622a5a9000b00359961365f1sm10630378qtb.68.2022.09.19.10.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 10:51:34 -0700 (PDT)
Message-ID: <a0d692da-9910-9c43-d710-6cfe739ce09e@github.com>
Date:   Mon, 19 Sep 2022 13:51:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/4] list-objects-filter cleanups
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2022 12:57 AM, Jeff King wrote:
> In the recent jk/plug-list-object-filter-leaks topic[1], I stopped short
> of fixing all of the callers to actually initialize the filter struct
> beyond zero-ing it.
> 
> This series does the cleanup that I was afraid to do there. :)
> 
> I think the end result is less confusing and error-prone. And as you can
> see in patch 4, it matches how the code originally hoped to be written,
> but the author was also afraid of the zero-initialization thing.
> 
> It is kind of churny, and carries some risk of regression (if I missed a
> spot). IMHO it's worth it, but even if we don't take it, we should pick
> up the first two patches, which are small bug-lets that the conversion
> turned up.

I agree that it's worth it. Hopefully the BUG() you inserted is sufficient
to catch any regression in CI.

Thanks,
-Stolee
