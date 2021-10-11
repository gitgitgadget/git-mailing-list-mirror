Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2700C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 08:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C80160231
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 08:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhJKIZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhJKIZW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 04:25:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F555C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 01:23:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ns7-20020a17090b250700b001a0937b87b7so1253273pjb.1
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=aItKDRDQXjE9SpEoESs9+uWXEW8IO/w1l+L3hr6tbpo=;
        b=OBlfGH3+wQj/jyRLZ4sRXpCjebbBCUr86QdQCf1EgKSVpvgQ8eKDuhUdd+m3kmTItk
         vCWx+5+0wikbhT+tXRXRn2O4yowc6gcUrI/p9XP3tdJ6lXq4K/UjJtEiEXyL03vpEbbY
         bOxsdFuLgjK2MQlmQTjOCLf7+bZi3q7CuycsTpCs3RIenx01VhIoeYQFoBojsWdJmmOL
         UA4gRmQJqHP9YEtlvneZVf9IvOc9n0HtQRqyLxKaGU79svF8N+xfL4GLy8UsA9LJCfxR
         E7vvrhwG+S0akIVhJktKDIzD59tDFOtLH8oyaJa8KQZryCFeZZMAnOB+bxvZKyHm11c+
         0+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aItKDRDQXjE9SpEoESs9+uWXEW8IO/w1l+L3hr6tbpo=;
        b=Sx5PdSTJ3CwL9B5o8stQ73+QCevf3YtckH/bjfk7loun9w97KK9gxhB+zELDnsueHw
         mZBQhnRlXRjozqxy+8jZ6oja0B2Wj2mg21/Q8t8IC/ju1fXCsFtBkLYQOIgcxAIqZhFz
         JMgXr4QoJhOf9xXJ13YU6zlJuKQg7verXCtNO8udNPKpCb8n6QKB8zz1nBVPv66RV2VD
         iXD1E2CXugd6oLWASuXqn5Epgyl0m3TSvFp3KP5ecxH9mTRxmCcOT48HmEiJ7gdP0nkq
         UF5ZY1sgl6tJSjuncwLzxsccPm41AyLe9NcvpO21+70k/UG+zPGf1yrgkk4YE3dNiVkc
         paqg==
X-Gm-Message-State: AOAM532HV9hFFZJn+aLA4NuTTJ7nHHVS3bZ9EuxQHYP2e4Ku4QBLKpTC
        AsQhTPxnbG21DYo+k73Iml8=
X-Google-Smtp-Source: ABdhPJx1SzoosTGZvliAjT7Cf9y4Y3Tg1HjF9KOoqcQ6WydV1iTnb2LrhfiEgzoJ7OxUvCQ4T2ZY/w==
X-Received: by 2002:a17:90a:384a:: with SMTP id l10mr28158419pjf.168.1633940602650;
        Mon, 11 Oct 2021 01:23:22 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-94.three.co.id. [180.214.233.94])
        by smtp.gmail.com with ESMTPSA id y3sm7244488pge.44.2021.10.11.01.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 01:23:22 -0700 (PDT)
Message-ID: <732e64ad-0ca0-d384-a09b-55c74479e254@gmail.com>
Date:   Mon, 11 Oct 2021 15:23:19 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: git log with %(describe) placeholder does not find most recent
 tag
Content-Language: en-US
To:     Benjamin Kircher <bkircher@0xadd.de>, git@vger.kernel.org
References: <61d28b8e9dd906eba821ecc9ee81bd4ac2374494.camel@0xadd.de>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <61d28b8e9dd906eba821ecc9ee81bd4ac2374494.camel@0xadd.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/21 15.08, Benjamin Kircher wrote:
> What did you do before the bug happened? (Steps to reproduce your
> issue)
> 
>      git log --format='%(describe)' -n1
> 
> produces a different result than
> 
>      git describe --tags
> 
> What did you expect to happen? (Expected behavior)
> 
> I expected both to produce (roughly) the same result. At least,
> reference the same tag.
> 
> What happened instead? (Actual behavior)
> 
>      git log --format='%(describe)' -n1
>      v0.11.0
> 
> and
> 
>      git log --format='%(describe)' -n1
>      v0.3.0-beta-253-g4ccd023
> 
> What's different between what you expected and what actually happened?
> 
> git log with %(describe) placeholder does not seem to find the most
> recent tag as git-describe would do. Is this intended?

I tried to reproduce your issue. I have linux.git shallow repo (master 
branch pulls from torvalds' mainline tree and stable branches pull from 
stable tree). HEAD currently points to v5.15-rc5 tag.

The result (note that I use custom-compiled Git):

```
$ /opt/git/bin/git version
git version 2.33.0

$ /opt/git/bin/git log -n 1 --format='%(describe)'
v5.15-rc5

$ /opt/git/bin/git describe --tags
v5.15-rc5
```

Both results (git log and git describe) are same.

-- 
An old man doll... just what I always wanted! - Clara
