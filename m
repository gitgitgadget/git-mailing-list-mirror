Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CF1C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 20:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66D12078D
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 20:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0RDupoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHZUve (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgHZUvc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 16:51:32 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9539FC061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 13:51:31 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so2805214qtp.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 13:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WF7DKg4V9gX7NQy9OJczO+hv0vreLgCUGi9Q4ya/ioE=;
        b=k0RDupoAtsgR6bPWwQNW1RKJx2XvOH92nWRtoTew01kGmBkP6sFmP/fNDt1Nc8KVs3
         JhalK1vp4VLtuYK8osySczUK/fm2Nk5T/vQvWr/n0hYx49gVwoWmRNcuPDymHS/Oz38C
         XiKKwMbWnpo7TrHx3KTHWCNsLclVY5xuS8ff2zwLvG+hrsvcEKGx3QgLLV+lqF0ehI5p
         jXq+3jEOXtf7sZ75aZXW5imCLyotzfA/3o0G0CgWGiOcwhmePf+4qTQEik3jIqWTO5HH
         xzd9rvtTaOdPpw0jxHLMm7LypsZ4/5H2PbS4+H0qke6zwq7NEENAtnNUrsezt5Ri4ubA
         0bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WF7DKg4V9gX7NQy9OJczO+hv0vreLgCUGi9Q4ya/ioE=;
        b=N47msm0LfvMNTDkzVXlRFE5jU8vFqSVEDjbS3lRaDQ8wzG+7d1Frf1yTif5jLV1sP6
         6uGaLdnCEPDHhNLIS8kEZMQY8vcAV3/KlXq6MBLV8EPa0UT5yPKR30Z0KJ2Wjzp2gm/p
         rff3nJ5x51DGVB9Q3gp+EwyxAgyEW62isQQ1GdTOt750d6WedU9T6A/lGazZZjtp/Ois
         464MOU0v1KfoggVMAOLsNQD4fKXADZUuJEEbVBGEygQ1T7o7BywtY/JB6vN6G/KfapA6
         kGVr6vYAoKJxjXDQha7d0cmf3+dQBZaBOHK6MVE16pJtPtgwrf77TypeIMumr4G29PGX
         c8DQ==
X-Gm-Message-State: AOAM530ZH0rPyx8P/d+aZfxc93MOhu6TnHj7kHej5ZXB4HTcmK/Nrio3
        z3ElCqc/oVVWtq30sCPs2Co=
X-Google-Smtp-Source: ABdhPJy4ng+zjuBG85ByYgD8It+HunEdBN2Uncnb5s6GUH9cAamhfiCQpEM6+QWCvCIrvofJW6fGAA==
X-Received: by 2002:ac8:2935:: with SMTP id y50mr15749378qty.134.1598475090753;
        Wed, 26 Aug 2020 13:51:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:718c:9432:b85d:1e88? ([2600:1700:e72:80a0:718c:9432:b85d:1e88])
        by smtp.gmail.com with ESMTPSA id o25sm158915qkm.42.2020.08.26.13.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 13:51:30 -0700 (PDT)
Subject: Re: [PATCH v2] builtin/repack.c: invalidate MIDX only when necessary
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, peff@peff.net, sluongng@gmail.com
References: <20200825144515.GB7671@syl.lan>
 <87a3b7a5a2f091e2a23c163a7d86effbbbedfa3a.1598371475.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a9997a0b-9ba9-4614-2081-fc74e4c2171a@gmail.com>
Date:   Wed, 26 Aug 2020 16:51:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <87a3b7a5a2f091e2a23c163a7d86effbbbedfa3a.1598371475.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2020 12:04 PM, Taylor Blau wrote:
> In 525e18c04b (midx: clear midx on repack, 2018-07-12), 'git repack'
> learned to remove a multi-pack-index file if it added or removed a pack
> from the object store.
> 
> This mechanism is a little over-eager, since it is only necessary to
> drop a MIDX if 'git repack' removes a pack that the MIDX references.
> Adding a pack outside of the MIDX does not require invalidating the
> MIDX, and likewise for removing a pack the MIDX does not know about.
> 
> Teach 'git repack' to check for this by loading the MIDX, and checking
> whether the to-be-removed pack is known to the MIDX. This requires a
> slightly odd alternation to a test in t5319, which is explained with a
> comment. A new test is added to show that the MIDX is left alone when
> both packs known to it are marked as .keep, but two packs unknown to it
> are removed and combined into one new pack.
> 
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> Range-diff against v1:

I know this thread went in a new direction about pack-redundant and
dashed-git, but this version looks good to me. I wanted to make sure
it wasn't lost in the shuffle.

Thanks,
-Stolee

