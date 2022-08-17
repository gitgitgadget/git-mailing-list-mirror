Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE22C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 13:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbiHQNqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 09:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiHQNqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 09:46:30 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4585130561
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 06:46:26 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q74so6574704iod.9
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=uWEDgZiECVi4ZhTxbwF3fuOr5sX9EwK7YSL/G1Elcg4=;
        b=cYXBL4RssqOMX3Ih+m5Xhp6ZSsJ3iB3DKPj1lbaxerJ31Jd11Vgh+1nXlSSpnTS3Ep
         n212K0i3/wzOQXHIFICH7fslx09s3PkOegrr1uN0uxr9D4AcbLbfA8WL+PWFUsHBPsSt
         BOwcHarlyVOlqe5SkphTrLbkmeDAfqylEFVlnb5wLqd1fMhMz9rwLewaeBiHq7l0zhXw
         LZbJyJLm3TrODy2BMd8Trpwu3JPoutg+U1Le/wW138B+BF7iPN1Svq/fvOBBZG9f6mWK
         6wm4Bsikzvnh4N5j1+Oguv7Rd4VQ3hB2KIZy1a+agqJYYcDFjPfiHvSF4EorZG0BEF3G
         su4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=uWEDgZiECVi4ZhTxbwF3fuOr5sX9EwK7YSL/G1Elcg4=;
        b=eUxY9O/9g6n98TNZVmcdrQvcAfpzXujIMxgluc4D7hg7nFycqHjcZIPmEr9LG0X0WX
         Oq8jvVtf2lbThsoxMltN3Ywg70Xccapvkm6xMLd9QgaD7Ivyz/cjMmezmUFaFlPFX/Kw
         n9a5fsSmHWJHFgGNf9ng6nAThGrHSIS7FSVBaH0F8OPMEyoxe0y1eAKzVjHrKQ7h60WI
         WfXEoPfkJiDJjGRRJx381iYMly/rt33+0mJamjADHgnu5inZ1leY5dkV1NSl0PVAO+dl
         aCTYwCpsSlp7Qic8hgP8gMOoYTRBO9uBdNf5+HCikLBhDY11tjcirQgbhM8VAvDyhWue
         X8Pw==
X-Gm-Message-State: ACgBeo0HOy76eDVFV2+0LWusyhRCwud+4ATNfqTA0aXnVGSLFLwcApio
        em9U5x95xQPFXGPnQVw+0OBI
X-Google-Smtp-Source: AA6agR5C0TCs1+A6jLe2Dh5Zthgd7YPmbJi+tqDsixEChAKxwxK1heCWKmjkHpj70MBK9QrL1qxYvw==
X-Received: by 2002:a05:6638:3d8e:b0:346:89af:b0f7 with SMTP id ci14-20020a0566383d8e00b0034689afb0f7mr6531011jab.187.1660743985664;
        Wed, 17 Aug 2022 06:46:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f8cc:7049:fd75:5ebd? ([2600:1700:e72:80a0:f8cc:7049:fd75:5ebd])
        by smtp.gmail.com with ESMTPSA id 20-20020a056e0211b400b002df3e4de248sm6006870ilj.8.2022.08.17.06.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 06:46:25 -0700 (PDT)
Message-ID: <83b259ab-bc1c-fccc-6666-a1fc0c52bb69@github.com>
Date:   Wed, 17 Aug 2022 09:46:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 0/2] grep: integrate with sparse index
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2022 3:56 AM, Shaoxuan Yuan wrote:
> Integrate `git-grep` with sparse-index and test the performance
> improvement.
> 
> Note: This series is based on 'next' because the 'rm' series
> ede241c715 (rm: integrate with sparse-index, Aug 7th 2022) is in the
> 'next', and the test cases overlap. Base on top of 'next' makes sure
> there are no conflicts to reduce work for Junio.

Do not base things directly on 'next' because that branch can be
completely rewritten and changes can make it difficult to apply your
patches.

Instead, you can base your change directly on the sy/sparse-rm branch.

Please update the base in v2, but I'll take a review of these patches now.

Thanks,
-Stolee
