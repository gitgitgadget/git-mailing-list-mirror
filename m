Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CB8C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiKGTp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKGTp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:45:27 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA8BBFC
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:45:26 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id s4so7513568qtx.6
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1o0boN/2Gbgr34WxOI2Qs9fjgplURtjhrwNBnUjUSs=;
        b=WpKsuveY32ffDng40abVQt4KRtypo49+J9+Ih2r/bafA+y4xrp2pKZ7VM/1+0NtcOl
         sOdx+QcMgBcipc2NUJpq9ZQWvF88+6+Uhr/GHoNyvmoEoO4YuLVVj7e2hnqp9+8d44Ws
         Lgk8NMTK1dyAHvzkRolIhbWylrkvAX+ABzvzlNcjuomhw+oLddYvWVe1aRC2z7vhvsi7
         DJVkTQD6NvkU5mo+1H4CK1peY+egv3W9Drle4I1pnFInF9uj6kQ1fz0fIOJTd4jwdTwL
         nD0Plwgzanrzyj6qK9a5dsQgMuRTVQkg4ZYxuZwyLlZGyp5y2nTiyiLOVcSdHlahL3iD
         vsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1o0boN/2Gbgr34WxOI2Qs9fjgplURtjhrwNBnUjUSs=;
        b=hmYHrcu1RsUusEdnEcg1vZhFxDJ7GaYEwm1YZE1rtB9yWwGr6dPSfjkoZ9ZdCTDjHz
         aSI5mNGxD5G5F6j31cAWmyrm6OjeSNqmvM0HMeh6m3VXlgGX462hvy2Y0TjX2LnGnM0j
         20dOv1p0w+BchPxyBCUHZIxkkV41OCY+YAan008JAmKTveHgCZoJvrfLSPCtg7o9vJv5
         BC4OO0LOixkqSCwAWhgSAvafbc6IW+rQ9WKogUnUxh3XF7+KwzYcSkYu5oxHIDJJc5ck
         /XplE3jOuHVw4QDz1FW9TpEWgNTUT6zQ7WiskqT/J7xelDqaQcITLvsAd/+RvxrnFVDn
         iG+w==
X-Gm-Message-State: ACrzQf2lfS3ruMwOSd8EWEdNl4k4ePXgYqQ3UcKT4Cu5qGwJDJxjgsUf
        uoFZJSkqNq7GToB82IBAOEaB
X-Google-Smtp-Source: AMsMyM759bHGLM2/Hm7eC7m3bTyEkTJLo1Yr0KbqbORrwpXhZlrpgi9vyocM1bAEHy9fR2VIeEcM0g==
X-Received: by 2002:a05:622a:8cb:b0:3a5:5987:42be with SMTP id i11-20020a05622a08cb00b003a5598742bemr17529795qte.311.1667850325944;
        Mon, 07 Nov 2022 11:45:25 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id ge17-20020a05622a5c9100b0039cc64bcb53sm6642773qtb.27.2022.11.07.11.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 11:45:25 -0800 (PST)
Message-ID: <f975f57e-71e2-3227-8039-14dff82f04db@github.com>
Date:   Mon, 7 Nov 2022 14:45:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] ci: avoid unnecessary builds
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/22 9:34 AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Whenever a branch is pushed to a repository which has GitHub Actions
> enabled, a bunch of new workflow runs are started.
> 
> We sometimes see contributors push multiple branch updates in rapid
> succession, which in conjunction with the impressive time swallowed by
> even just a single CI build frequently leads to many queued-up runs.
> 
> This is particularly problematic in the case of Pull Requests where a
> single contributor can easily (inadvertently) prevent timely builds for
> other contributors.

As someone who is both the cause and the victim of this, I
thank you for finding a way to reduce wasted CPU time. This
patch looks good to me, though I'll need to trust the docs
and your testing to be sure it will work. We will definitely
see it in place as it merges into 'next' and 'main'.

Thanks,
-Stolee
