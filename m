Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E905FFA373E
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiJZOeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiJZOep (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:34:45 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E8314D2E
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:34:44 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13c2cfd1126so1401228fac.10
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oB9ZhxZCgs60tVUGHY8QAMhXlIHxB32mHrlzkHOjXJI=;
        b=TmN6wc2C4Dsp0UsCRE02sQ4OcYLqOpqBYOaiaK7tCtUkP2eIy8zT4DXjQeLOs8zixt
         +g2fUlC8aoV5mRScsw25J39vvr8HDIYCwZ0EyJoIphQljNuddxvGWX6ma3YM5PWHaUvK
         H9pTaNBhblzdpqHbbLEsBeEYCAe5NlIgBF/AeM8zvdNx9B7p4AwUePu0EZan5GeeQ0Hv
         +mWewGT4W5fAtQa93UtYZQ4JINVG0Vzt83bryNlXUk8QOI3UHndVOb2sdefeDny500sx
         DUvfuSUBFh8uZja5y9SSKlFm0v9gW2EZ1NLn/hLwkJXht9ppFnAqYf+2XgvMVswwqSbU
         Z7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oB9ZhxZCgs60tVUGHY8QAMhXlIHxB32mHrlzkHOjXJI=;
        b=8QhhPRvVzK55XurX5eMD2uk0YtBTTwE4nyxfN02K1/xBAprzZdHpOTb5Nil6Yuvfmz
         uu3f9ennT6daCecslAQmxVYd/GaHCdPIi2lpy0LxJz83ewKZ8m73lSh/kFts70FHshEb
         iRUzN9zB7qvAUj7nkqJ6OrTeTcuf1YBoKP31rfwoSityggRfIQqC7oD4KGUUs4VNWglI
         TWyd/ASRqPod2n/55l+MJL4zRunBpS+9CrM/KSFkxFcJOXW7GoBIqrNwiWHPTqLjKfVI
         NKGN1QzTBu3df6zcdl+xzfB5p6jWELBhQ3G/D06h1vaBca9QnqH1WZglrWxZUJQsj769
         qJQw==
X-Gm-Message-State: ACrzQf3Gn00sRo/nLp6fKZGLz0nyicKaOxQYq4ekKcJJyieezxUHTFWF
        GHU/Y1bfuPJznBr5YpEsBBAT
X-Google-Smtp-Source: AMsMyM7IpCyM9ll7RGVftXkgVunE2FBlqz8GICoWgqdnrd8t1qZ+K4e6vPtjm7X1jw223y57xGbn1w==
X-Received: by 2002:a05:6870:c1c7:b0:13c:2cfc:9b70 with SMTP id i7-20020a056870c1c700b0013c2cfc9b70mr1098458oad.102.1666794883842;
        Wed, 26 Oct 2022 07:34:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b472:9a5:ecfe:20c7? ([2600:1700:e72:80a0:b472:9a5:ecfe:20c7])
        by smtp.gmail.com with ESMTPSA id a19-20020a056870d19300b00127fbb7afffsm3173207oac.5.2022.10.26.07.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:34:43 -0700 (PDT)
Message-ID: <0267162a-098b-2280-46b6-51932a8df6c3@github.com>
Date:   Wed, 26 Oct 2022 10:34:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 00/12] Bundle URIs III: Parse and download from bundle
 lists
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
 <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2022 8:52 AM, Derrick Stolee via GitGitGadget wrote:
> This is the third series building the bundle URI feature. It is built on top
> of ds/bundle-uri-clone, which introduced 'git clone --bundle-uri=' where is
> a URI to a bundle file. This series adds the capability of downloading and
> parsing a bundle list and then downloading the URIs in that list.
> 
> The core functionality of bundle lists is implemented by creating data
> structures from a list of key-value pairs. These pairs can come from a
> plain-text file in Git config format, but in the future, we will support the
> list being supplied by packet lines over Git's protocol v2 in the
> 'bundle-uri' command (reserved for the next series).

This version has been available for a while now without comment. Could
we consider it for merging to 'next' soon?

I want to wait for this series to merge into 'master' before sending
part IV on top, which advertises bundle URIs over protocol v2.

Thanks,
-Stolee
