Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54E9C3DA7A
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 11:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjAELjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Jan 2023 06:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjAELjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2023 06:39:09 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BDB13CDF
        for <git@vger.kernel.org>; Thu,  5 Jan 2023 03:39:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id tz12so89420010ejc.9
        for <git@vger.kernel.org>; Thu, 05 Jan 2023 03:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LeDpdlCq/SaB3ApLoNcisToh2F+3MnJeEpMsYHwtl3w=;
        b=jdGEuCaKLMi7f9oIKp7b12vxtsYyMXAUtosQ2mIJ0i+4kK4efRnkhx8ECZ95mvdqDi
         l2X2+M5UCiGYHBw6wA75+ahw0fXAsZ+Za51hzRFaUhhCV2oOC7I62fkJj0ACTN/ruUGD
         L+I/UvJjr0MkHnlOQpbwO9mTun/5jbXowhYD9BPWBd2Db0juX+xlGEvVk65Hx4QozaWX
         wwc/sZVaSE2NTwr1Ua9+Ec/rrxOUqq9W2l8Xqvzmg+3RccKs4H57mzQXz1SUVBM5wFRA
         QHonKC5mlAr+kf2E8WL1erMXlNhUkYtpfmSw4Nbw5FCcBbpl77b1Nq1VorAeWJQMh4Iu
         nz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeDpdlCq/SaB3ApLoNcisToh2F+3MnJeEpMsYHwtl3w=;
        b=jP/1j4ZRbt47B/kqSw0ADr5OQZRnh34H8IL3ITzqItRIbAJBRg44Hvj15bi8yXZWMy
         3IQ3VpfZ0PyE0q0K2c+BevVHC5kUvvKDkTDKHGYjbkvIpxYSexCcus8C+kIrHHK7N68k
         ILDbkhLxtaxhHSdQwelSFxM3ak0UiWAoiJnhKEV6dHGIGDPnqVdOyZVJ4EUbzPcLdjmg
         WnVVRFgR6oS4x/jSnNCqtVVTGaA4Zzf4kCw0sR8Cl2jdOaL7ZUIq9LmVoqiA0xcYut4r
         lrWRsFgParJswhnNddYbyAmQxFUPGphI4uUXt0W866h+CAot+GlQQbxeahuP1gtUzcMI
         35jw==
X-Gm-Message-State: AFqh2kpAfjs0G+pexYJWOhqAFXrJoQnJ4OTX3sCNYhYV3JqTZhG03Nmg
        91deQdOESuQIaushkSsqyclzFw==
X-Google-Smtp-Source: AMrXdXsugolXSEBtwAJz5EvjzgcpHjlD5b0br7k2Pdo5veeyqug+Jj/Ywb48kjbDbqqPncSeLP1MXw==
X-Received: by 2002:a17:906:17d2:b0:846:fafa:5c77 with SMTP id u18-20020a17090617d200b00846fafa5c77mr36476611eje.48.1672918746451;
        Thu, 05 Jan 2023 03:39:06 -0800 (PST)
Received: from [10.45.33.168] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id nd12-20020a170907628c00b0084cc87c03ebsm4915032ejc.110.2023.01.05.03.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 03:39:06 -0800 (PST)
Message-ID: <fd873f47-1f7b-b1dc-8a2d-e1bf8fdfcf05@unity3d.com>
Date:   Thu, 5 Jan 2023 12:39:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] dir: check for single file cone patterns
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1446.git.1671546459151.gitgitgadget@gmail.com>
 <pull.1446.v2.git.1672734059938.gitgitgadget@gmail.com>
 <99e3c0f9-ecfa-7c26-eea5-685bc324f674@github.com>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <99e3c0f9-ecfa-7c26-eea5-685bc324f674@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01/2023 00.48, Victoria Dye wrote:
> 
> I think this is the best way to maintain the current intended behavior of
> cone mode sparse-checkout. While the idea of single file "exceptions" to
> cone patterns has been brought up in the past (I think most recently at the
> Contributor's Summit this past September [1]), it'd be a substantial change
> that's definitely out-of-scope of this small bugfix.
> 
> [1] https://lore.kernel.org/git/YzXwOsaoCdBhHsX1@nand.local/
> 

Thanks for the context. I didn't know that it had been discussed.

>>
>> ...
>>
> 
> And this test ensures the new check is working for the appropriate patterns.
> 
> This patch looks good to me, thanks for finding & fixing the bug!
> 

Thanks for taking the time to review!

