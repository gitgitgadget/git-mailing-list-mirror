Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70D4C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 18:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiHWS0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiHWSZa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 14:25:30 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4D5B2
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 09:43:34 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 62so11348611iov.5
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HFueA3JNlMm9d3y1qNOxMKuvJFYTLVyKmGNvCzi/9Fo=;
        b=UJWIYIlWNWQE/DzMswsU3SVYnK2vVYqHDYSEX7GcLDegZkaj3dJ8UdvARdAB0kmQtq
         UKZiFfnw0uK/WiNXVMMlwHVV7Z2wPw5+bImpK+AbCbYGccmztY5tCwFpJzTcZJ13WveF
         1dOHOIr4lvFPVMCalQYFoNT1KP3S1PW9JZUYXyU53lAXAp5Okgb28jw5xI/e056xbcfX
         K34VwkNHzUv8RLzDzQVy5lX4182Kex2B06DiaK13G5wOOQZpUFdGf2WugUkvghfbWECp
         k6hpuk3SOVH9WXTGH6bpZqS+OKJEelYqdzlpTd8vvhmy5Woh9AxkqyyIE9Rh19UaE0Hr
         zxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HFueA3JNlMm9d3y1qNOxMKuvJFYTLVyKmGNvCzi/9Fo=;
        b=5P6mVSS+xILCrpNInAGnFvcN+tZ0Vov38+BrmjOGO5aHQYf241IyA04UB1OwRcWAn4
         LQ2AW1O1/z8kktJWSnziIdeGoq205kC1KE3eN67TjoKwDSArbL4tRd3zQVl13k7uKnKW
         JzovbYmT7EYtsE12Xjm33ydljTVvodi4ZGKHFKKA5K6lG91xUHI87GXdcQTQwZCeDDxO
         engyKw55nIoxMpi3HVJXZwlhK08hyDMKY0XADVqZaLIfJBwmnzN4AmkcYcnZIjH3uinM
         h+R0uqCEDRBDCy4O7mZnEQ5ZP45OzrFEjmrA1uy4vshJTD8q/LYv5JgICdIQ0GvnozHV
         LfQg==
X-Gm-Message-State: ACgBeo02i+MOYX+hBPs0T9Fc7uccIlbGiqBQmVXICH5oMoOxgtEP3qCa
        8v9mesnWVsBh7xaFwLw/8Ta8
X-Google-Smtp-Source: AA6agR7jnAlFPju7v2ghHD5CR0gBeJwYzPU+rOXZ9DH28fTrfBBsc5gxUHxaF+G1nmbdQi7oqPDl1A==
X-Received: by 2002:a02:cb85:0:b0:349:ed4e:af5a with SMTP id u5-20020a02cb85000000b00349ed4eaf5amr3036752jap.301.1661273013632;
        Tue, 23 Aug 2022 09:43:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1b9:9fd8:f860:8737? ([2600:1700:e72:80a0:f1b9:9fd8:f860:8737])
        by smtp.gmail.com with ESMTPSA id f7-20020a056e0204c700b002ea1c777c45sm66643ils.56.2022.08.23.09.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 09:43:33 -0700 (PDT)
Message-ID: <8d8e5256-8b87-7154-5865-675c2355b915@github.com>
Date:   Tue, 23 Aug 2022 12:43:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 5/7] bundle-uri: parse bundle list in config format
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
 <1d1bd9c710327b4d705cfede017771da7fb6ec52.1661181174.git.gitgitgadget@gmail.com>
 <xmqqilmkcc7i.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqilmkcc7i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2022 3:25 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> To allow for the incremental fetch case, teach Git to understand a
>> bundle list that could be advertised at an independent bundle URI. Such
>> a bundle list is likely to be inspected by human readers, even if only
>> by the bundle provider creating the list. For this reason, we can take
>> our expected "key=value" pairs and instead format them using Git config
>> format.
> 
> "can" does not explain why it is a good idea.  "As a sequence of
> key=value pairs is a lot more dense and harder to read than the
> configuration file format, let's declare that it is the format we
> use in a file that holds a bundle-list" would be.

This "more dense and harder to read" was definitely my intention for
wanting a different format. 

> I do not personally buy it, though.  As I hinted in an earlier step,
> some trait we associate with our configuration fioe format, like the
> "last one wins" semantics, are undesirable ones, so even if we reuse
> the appearance of the text, the semantics would have to become
> different (including "syntax errors lead to die()" mentioned
> elsewhere in the proposed log message).

The points you made earlier about "last one wins" semantics are the
biggest road-blocks to using the config file format, from what I've read
so far. We could change those semantics to be different from my current
implementation which respects the "last one wins" rule, and then that
makes the config format match not as closely. That burden of avoiding
multiple key values is not on the end-user but the bundle provider to
match the new expectations. (There might be something we should be careful
about when advertising the bundle list from our Git config in the
'bundle-uri' command in the next series.)

The "syntax errors lead to die()" is mitigated by using
CONFIG_ERROR_ERROR, which is what I meant by "Be careful to call..." I
should have been more clear that we are _not_ going to die() based on the
remote data. We might write an error message and then abort the bundle
download.

With all of these points in mind, I'd still prefer to use the config file
format as described in the design document. If you still don't agree, then
I'll change the format to be key=value pairs split with newlines, and
update the design document accordingly.

Thanks,
-Stolee
