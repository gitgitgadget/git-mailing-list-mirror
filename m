Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4675CC4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 15:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiKNPEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 10:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiKNPEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 10:04:43 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E27115D
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 07:04:42 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id r81so8347836iod.2
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 07:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKOyAdRegOcmfh8HMjtlQqUIN16Xcxu0skHB5P06PHo=;
        b=T+n1RMVZKDO4LiK14utZnUvmsZ1U7akMT+l9BOnY8AL06Oh+5OZw1Dxfpq62vzThdb
         V8LKZU+IEGOkBCkIe0EWF17/OTc0FmmFV7IrpRPtQkGHmzPw/O6pKhi+v0PuoVBwJK2U
         nt67OTZb40tXXP2trt3WdXdG+8/MwIzaAM1w503Obzd7ZcL5yDkO86o5lY2Rs+lHKJlE
         dGq05vLnkN5NvkEnBwoWUpsYMElrfhppVHzpVfzpl+uETIclpOEk0Fk+VzOiI+G0M2iZ
         Up2+jEKlZ14k7u0pFlqb9PLP1ABZ6w1w13giaxGHKKSKXVZKG/URDWYh2hkPLZQUtDQk
         iIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKOyAdRegOcmfh8HMjtlQqUIN16Xcxu0skHB5P06PHo=;
        b=VN19QGJ6LbYaCrEvbNKZoEd2QWfvdukGJee3fKTktEqAIsaPZxGwqQIF+PQjM3Lihu
         LMfkGUGWlh3VjtFjFEU6PeyL4WDuWmw24UMwQtUiRZRsNdeszFuNMbv3TzzRYpyclvY3
         pQDHj/4QzVZBXRIwEcZYYtL/NEakdxWYN8EB+b56h0cQYNS/xXo9tl/ptHTAYot4gjoO
         JzfXs+hyUtBd+P4rEBMdfCuBV+JcAFVSIVtrKBRvvc0HzFfSsi4Pz3Abb6PefmHb8STg
         4bqRXHZEGfqOMeyNAyfRCBquY4t+imG3hPbAHQ+yXe0W3mekLk8zAtCoYa9MDRjgTonV
         ieWQ==
X-Gm-Message-State: ANoB5pkfhPxz6tPBV8szz1DN9KzrPgSOicwWjaLtszuki9jNd9DRduY5
        wrXaxHFtu6K8RyfS6aV3DDQi
X-Google-Smtp-Source: AA0mqf4nh5R04qP2v/IGXySMRbaPEXM6r10aBzz1PU/IU/YMrLkZoLjJC+W3tPYAXnJXCbruHf3dsw==
X-Received: by 2002:a02:a902:0:b0:375:16d:2eaf with SMTP id n2-20020a02a902000000b00375016d2eafmr5915792jam.10.1668438280917;
        Mon, 14 Nov 2022 07:04:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:25ec:70af:bd50:7ae0? ([2600:1700:e72:80a0:25ec:70af:bd50:7ae0])
        by smtp.gmail.com with ESMTPSA id p2-20020a056638216200b003755c84f596sm3545560jak.9.2022.11.14.07.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 07:04:40 -0800 (PST)
Message-ID: <2c78ee6b-0ee1-8955-a692-384a238d0f64@github.com>
Date:   Mon, 14 Nov 2022 10:04:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] maintenance: improve error reporting for unregister
To:     Ronan Pigott <ronan@rjp.ie>, git@vger.kernel.org
Cc:     me@ttaylorr.com
References: <20221111231910.26769-1-ronan@rjp.ie>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20221111231910.26769-1-ronan@rjp.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2022 6:19 PM, Ronan Pigott wrote:
> Previously the unregister command would only check the standard paths to
> determine if the repo was registered. We should check the provided path
> when available instead.

Thank you for following up on these items. I appreciate your diligence.

LGTM.
-Stolee
