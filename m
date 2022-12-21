Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56E4C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 12:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiLUMvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 07:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiLUMvt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 07:51:49 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D11D21A8
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 04:51:48 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id jo4so27651907ejb.7
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 04:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvMaE6LfX2EnIpALvn4+aCnbdjXe60egGCVfc2gIPa0=;
        b=GiyEbAaxsmYOTzXJVZqUYZ7Yrt+D++vM02irXgxvieu9UBjduVUalM+Z7cf39kJBQN
         dVUtZ+Qrhx6HUNJ+Qxk4VaoFDKsiSaKeCCb4pBJwwjdZK3HcIZJchEKsXNbJXWnxsgqA
         bTLGulHh9iU0QqkPHF29slRXhpUl+Vur2fIv/PQguCzokPiKCdWUxErzgEPOmQOhicBu
         r9eND+Q6LvKsg3NcqU+ry09ifvtk1XzapRqgC07pDOvnDwKb2qHlHOVhVqvMqhgZqMra
         ipSxgql/gY4Q0EJaeaJsD1wBsLmIQhym56UJP4aFeFv5vGVUmE650VY3Ebl+QFdbOPRa
         L6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvMaE6LfX2EnIpALvn4+aCnbdjXe60egGCVfc2gIPa0=;
        b=VAAkI718jruojT5HFja/BIolLvMpLqCuzwZB1Ym26JGNvKnleFXivBzq5h02Es0vpO
         mkgrb1l+0LCQmmxtyUPIyl4vkISO5uW9WZoj6hh2//BUT3uNtnI+uNyYKpSE8cv5zhP5
         iiD2LDxrFpIQ/bBOTq0k2Yk3/AYLqn6izX1EC/NnQMe+q5SnIVenbuBiXjBZm8gyohbU
         a8eRdt6mTtNRT5CZFJfBUKD15XNjiLhUR7Pizg1ouyxSF3a5IkTAuLfjr9xoJUkMM9wJ
         +1Ug/wJAq3eBPNwMu1ohCzo7aT6/hGDNw/9KE+E21Nx7iwySIJWnx3NIOF/I6hgsyzUl
         HUCA==
X-Gm-Message-State: AFqh2kqPRueq8PDhNSDht4+qamGYKGQ4lBjESfZgP6p+aPi7SKcGuM4k
        i9Fy1LRZkTDwoRVNVa1wZl/v7A==
X-Google-Smtp-Source: AMrXdXsKmz5Vf4Q4LYdDjv2XK4LToppBYgsCfoWfzgVgBWquTfSOcag1Ituqqj8LJJYF0ZXkZx4nlg==
X-Received: by 2002:a17:906:2ccc:b0:7c0:e23d:12c4 with SMTP id r12-20020a1709062ccc00b007c0e23d12c4mr1239961ejr.63.1671627107266;
        Wed, 21 Dec 2022 04:51:47 -0800 (PST)
Received: from [10.45.34.36] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id g25-20020a170906539900b00738795e7d9bsm7069654ejo.2.2022.12.21.04.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 04:51:46 -0800 (PST)
Message-ID: <8c9650b7-8e36-909c-c193-2f6713427e57@unity3d.com>
Date:   Wed, 21 Dec 2022 13:51:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH] dir: check for single file cone patterns
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1446.git.1671546459151.gitgitgadget@gmail.com>
 <221220.86sfhaw3c3.gmgdl@evledraar.gmail.com>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <221220.86sfhaw3c3.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/12/2022 15.33, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Dec 20 2022, William Sprent via GitGitGadget wrote:
> 
>> From: William Sprent <williams@unity3d.com>
>> [...]
>> +	if (!(given->flags & PATTERN_FLAG_MUSTBEDIR) &&
>> +	    !!strcmp(given->pattern, "/*")) {
> 
> Style: We use !! to convert 123 to 1 or whatever, but here we just care
> about "not matched", so we can drop this !!strcmp() for strcmp().

Thanks. I'll drop the '!!' for next version.
