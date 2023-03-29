Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BB1C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 13:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjC2NRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 09:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjC2NRa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 09:17:30 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AE64EFC
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 06:17:20 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id f188so780570ybb.3
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1680095839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CEiJLq3zvy7upQDZa1W5DHSsKSUOiB0WqKOnSNfmcFs=;
        b=ij1K/LCpPJlUtW+tWCLvrmZ/VuQDyiV4S8LcUNHksPiltPwslLDPiA1AOPBsqdEaY6
         Eb85xm0WDM0LnNWZmRNqpNUhZqUJyO6vfsjOaUYrMa+wd+k19dRjP/zltKq2rcY7KirM
         h3a7QbswsNeN3lktTIoa/5z+bq+Ay9aGQRvjc5yK7XzrsoR0qOLNrjph1UebiqNferTO
         FaWFfih/z0R+5GzQNeu9Xd4JXLM0dpgzikbqYX3a8Mk0S+6R0ZvzuzjZmYi7UgyrnoR4
         irRllO9eEq33PWcNf7XyfFrtuJGcNQG+75EzmaNvFo7PxaIVoO9AvTHf7Zeb4PfDxwvw
         IoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680095839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEiJLq3zvy7upQDZa1W5DHSsKSUOiB0WqKOnSNfmcFs=;
        b=8MLraiQTPkd7vgPclxk+fXmw6pD0c8ayVX2w1oj74rm6whzSWRnui+sL6BMKHqVBYO
         w0yYnoFuthtT5+O29hsHec6IO3SfCpICQaL72U59vU6m//fnp4JyrHaW2VInGRD13B5h
         En9yPiUNqSyKhhTADzZ1a1Axm7V1vYZnNU/9TqBK08RLz3vNseZM27vloSLoM8Sg8vR/
         6oi7a2E+jg4E2ex2whKPOL4mr2qgkses7SjmNrWn+B/UoBdvK7PhXGBnP8Quj14QoSKg
         1+humU9RuEM9vnbvocke7twszUM92qGb7g2aTCRpy0I50L/RLPQxVrmz4fujygWkPDR+
         KmIQ==
X-Gm-Message-State: AAQBX9cZfNMyh6pIJXYQUcL7qI+37Q+CqBAmGkQyAXpOdRj9bPi5NVaO
        UqHfzkRWeroEqfjxTkNNFEaR
X-Google-Smtp-Source: AKy350bJXjPcnJk0Nucj1+nyuBHHxMzJcL9pnrMbqL4rw9erPqPBVtOSHqoH1imeJgR8Dq/llQwZ8Q==
X-Received: by 2002:a25:248c:0:b0:a27:3ecc:ffeb with SMTP id k134-20020a25248c000000b00a273eccffebmr2566686ybk.18.1680095839382;
        Wed, 29 Mar 2023 06:17:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e80b:ce41:eec1:761f? ([2600:1700:e72:80a0:e80b:ce41:eec1:761f])
        by smtp.gmail.com with ESMTPSA id c129-20020a251c87000000b00b7767ca7494sm3518230ybc.49.2023.03.29.06.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 06:17:19 -0700 (PDT)
Message-ID: <90a8dd7d-59ed-8de8-27c7-c7dc9cf8a77a@github.com>
Date:   Wed, 29 Mar 2023 09:17:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/7] unused argc/argv/prefix parameters
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20230328205253.GA1753925@coredump.intra.peff.net>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230328205253.GA1753925@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/28/2023 4:52 PM, Jeff King wrote:
> More from my -Wunused-parameter silencing. The first one actually fixes
> a bug. The second is a cleanup, and the rest are just UNUSED annotations
> (but grouped into similar cases).

This was easy to read and LGTM.

Thanks,
-Stolee
