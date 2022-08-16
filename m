Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823F3C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 21:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiHPV1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 17:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiHPV1R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 17:27:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1948C47D
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 14:27:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a4so2351199wrq.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=btKCCaSmo7fgvI6Fw6sry9xDTz0Nsc3fl5IbdzgZjO0=;
        b=I1yi33muoRhKhXYOF147F31rqYudyR0NYRQUV+yYm2MBI3LsyO40MTgqu5ufE6V1oP
         Zlb6YKkoocH2rX4VJmr+Qda2Lke6KjjRFfbQZQq6/VOQ78oc+wEr+ou60qerGhffxCaw
         njPptTokcPvlFfIFW4XnYRlfmkjLI4Z08YjKBdH/kRDbZLflAP9TDHiQs+dtqgXOjYv8
         LQ46N2KIdb/aD/BvZWGb1l7SQ1X6o83+enaMl0pTYwoQfNQ+02aaTPHdjTm418Bg3uSK
         5eskwgpJhu5AP2qkcyI0Hp+WF8DM/romBdL+TNXTsmDZtMQ+xniGd24lmjg1xW2a+np7
         OjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=btKCCaSmo7fgvI6Fw6sry9xDTz0Nsc3fl5IbdzgZjO0=;
        b=h4Gm58OhWrj4qdOaqETKzAjtv43AQzcvR8d/dqsbRcJ/uJooyhvfiwfghI7ZZwvtlb
         MOXpC4zjD4ENhDHKXg3ReMWrm1P8vN1jHUV9f4Vs1qY3vor3exdm/EAj/CsZoLuiowSy
         9tzDxhe6s62GOAlzxN7wlwwR9p95Q7H5c77BS1HIVGeuHdYHLPOS3WKrItNo/orKX8mw
         fk1f72oVQcyqMgh6N3Au3twSN5iCTL+KdDKN35ovTrYDdMwDCnlsjKCvmZSOpE4O7hv2
         SWMsst+02QKLBiRdPZOYzxFlh6gbCaUUQcfkmvUQE5AOnV5IsphbHX8HxqFQpUzsWdXE
         HEEw==
X-Gm-Message-State: ACgBeo0oNTA8c+dgooRz8geUCosLdsFV8Yk5YSpEejrJYA/v0NeqnJqs
        H5xBkYoQgpLFaO57x+U9caU=
X-Google-Smtp-Source: AA6agR4xD7l+GqVQNKM0kA2/CXgTebt1kHRhhvLN1YXZYgEFuzA/uO0eJ6e+8raFmf2Dy3Kqtth9Gg==
X-Received: by 2002:a05:6000:151:b0:225:23dc:9b0d with SMTP id r17-20020a056000015100b0022523dc9b0dmr216567wrx.525.1660685235179;
        Tue, 16 Aug 2022 14:27:15 -0700 (PDT)
Received: from [192.168.2.52] (68.83-213-117.dynamic.clientes.euskaltel.es. [83.213.117.68])
        by smtp.gmail.com with ESMTPSA id e2-20020adfe382000000b0022517522f8asm2534416wrm.96.2022.08.16.14.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 14:27:13 -0700 (PDT)
Subject: Re: [PATCH v2] allow "-" as short-hand for "@{-1}" in "branch -d"
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Rub=c3=a9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
 <pull.1315.v2.git.1660669912043.gitgitgadget@gmail.com>
 <xmqqo7wkt3w7.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <4707eba3-bcfa-24ef-ca6d-a23d6a64ee6d@gmail.com>
Date:   Tue, 16 Aug 2022 23:27:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqo7wkt3w7.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/16/22 8:55 PM, Junio C Hamano wrote:
> 
>> From: rjusto <rjusto@gmail.com>
> 
> Documentation/SubmittingPatches:
> 
>      Also notice that a real name is used in the `Signed-off-by`
>      trailer. Please don't hide your real name.
> 

Fixed.

>>       -    branch: allow "-" as a short-hand for "previous branch"
>>       +    allow "-" as short-hand for "@{-1}" in "branch -d"
> 
> The "branch:" prefix is lost here, which is not an improvement.  The
> "<area>:" prefix is what makes it easier to locate a particular
> change in "git shortlog --no-merges v2.37.0..v2.38.0".

Just want to reduce the confusion, as Johannes suggested, that could 
apply to the whole command. But ok, I've put it back.

> 
> As to the implementation, there is nothing to complain about, but as
> we already discussed during the reivew of the first iteration, I am
> not sure if the goal is sound in the first place.
> 

Sorry, I don't want to be annoying, I just think the effort is worth of it.

The change rounds the workflow: "checkout/merge/branch -d" and does not 
introduce any new confusion or new circumstance. The commands that 
already support the substitution doesn't support it in all combinations, 
complex use cases can (probably, should) use the @{-1} syntax and 
definitely those uses are not the candidates to use the short-hands.

> Thanks.
> 

Thank you.

Rubén.
