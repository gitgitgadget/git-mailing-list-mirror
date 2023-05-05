Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846ABC77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 15:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjEEP02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 11:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjEEP0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 11:26:07 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0EA18FFC
        for <git@vger.kernel.org>; Fri,  5 May 2023 08:24:48 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-55a010774a5so28531517b3.3
        for <git@vger.kernel.org>; Fri, 05 May 2023 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683300287; x=1685892287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xA9fv1atq4+Deilj3Ela+iwwVB/+qQxVR4XWHdSaf/c=;
        b=Z5KYDjKXMDy3nf/xEnXu1fTR3W/hhYSwpPBh0DekvKMvXjnT42MUhcWlPn6Y6TpT+X
         LxregZm0yY8wmsB6M38ZOjTjaOY7Rsm7mrP9l+oVHD2Y/pUOo9KlrWt4SckhTWo9rEEn
         or0gbp/FbF7WzFedi3HjExmIZ/cJmKNO6rx2K7Dga5jA/DORaWlMBXWk2r2nI9bPojgU
         LLSwadaztMMyKCSjBqhZ+7xYZynvPRqSN0d+STUHx0h3AKbJa8tPSzWJoRsh8lz866Wf
         DyaP8CLix31y6rCxGeXcGvrVoG9zt4//aiOpoSgw8iQt4M5ot1baqW/8yz2YYrmqRGZt
         g8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683300287; x=1685892287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xA9fv1atq4+Deilj3Ela+iwwVB/+qQxVR4XWHdSaf/c=;
        b=ffxsXHJj178KMOxTNpp6451kyqaUyhb8p1zwneh7y+ywB4s7hHeYCA/wJjSEfzE16B
         ThoEQkmi47g/x5+/Wb74m5qYNc8BooRhjidKMe4e9ct2a2bLn+nvg2lmo0ElwQ6PIQU9
         44VE4A3sTZURd8u7Lj1JrMV9EXYKaKiX+2/aRzYHuZ9HMkftnGopB53ZToXN3pAYyvUl
         o50G0ARajwRe8Ebb+SuNthBOviA5m31mpVf6zNezzKakZ8NJ7+YIgyE8pgYTc8rT5vdh
         9hPHuZU5Zhgzc7tic07JNR4/udlpQk6GFqa09+enCr8Y53gLHlsff8X/Aytvu4HjTrMF
         zHpg==
X-Gm-Message-State: AC+VfDw7uzxIxTj3ilnRA6dTlRVspG/Ofi0NrTHPLIEUsl+0pZOxdFhw
        3RaFU+oazCzZsQsAi9vi5w1c
X-Google-Smtp-Source: ACHHUZ5KgmKIbXtbfPzFNSgKSogGn+EP3mIDfpkprJ4ZVNz6IZ/OgZHMDzomHazZcrnb0wsMOpLzKg==
X-Received: by 2002:a81:498f:0:b0:55a:52f0:8465 with SMTP id w137-20020a81498f000000b0055a52f08465mr2120375ywa.44.1683300286778;
        Fri, 05 May 2023 08:24:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fcac:2b0b:1f40:7f1a? ([2600:1700:e72:80a0:fcac:2b0b:1f40:7f1a])
        by smtp.gmail.com with ESMTPSA id j17-20020a819211000000b0055a581c7f03sm525894ywg.29.2023.05.05.08.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 08:24:46 -0700 (PDT)
Message-ID: <bd745f48-038f-f4f2-2041-f4b2c7bd0d20@github.com>
Date:   Fri, 5 May 2023 11:24:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/7] contrib/credential: avoid protocol injection attacks
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1682956419.git.me@ttaylorr.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1682956419.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2023 11:53 AM, Taylor Blau wrote:
> This series addresses a handful of potential protocol injection attacks
> possible via some of the credential helpers in contrib/credential, and
> the new "wwwauth[]" directive.

Sorry for being late to review this. I was not one of the three
developers involved in writing and/or testing these changes, but I
am motivated to see these fixes land.

> But the new "wwwauth[]" field does allow this attack to take place.

In particular, because this should be resolved before 2.41.0-rc0.

Each patch was simple to read and well-motivated. I was particularly
happy with this diffstat:

>  contrib/credential/gnome-keyring/.gitignore   |   1 -
>  contrib/credential/gnome-keyring/Makefile     |  25 -
>  .../git-credential-gnome-keyring.c            | 470 ------------------

The rest of the changes looked to be obvious improvements, so this
v1 LGTM.

Thanks,
-Stolee
