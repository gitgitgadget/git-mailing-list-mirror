Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82662C32772
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 14:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245269AbiHROac (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 10:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245468AbiHROaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 10:30:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33289B99D9
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 07:30:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k26so3580838ejx.5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=danil-cz.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=2rlpopBIM4ml+26wfjoQ0SMW06jZogVlWXAAbjyyjpI=;
        b=TY80qjHe4Fvs2nOW8BjcB8qOWnXA7yar1ughlidmfzcYO68Oqa7s50y1nkoh9O6MFA
         P+N2DIhf3fjpWpZdVcVka8Tlocr8gdM4q0mOJObnrXSw9weHMIx0XB/qCQ6LltsjoJdy
         hQFoHas1FP6bIyhChL5oyAI2+svuqHKZfIuZu/mjVk7TMEFBUU/j6Iqc5CUha2EipQPB
         Pfcfn5SJRJFS4CDlE7QczDJJAPW9AhoZjOrYlvEsr512kMpwnStkAjPhNFbBz8oSbjV3
         KcM4GZS72wQ+7Rts2XKAyeKOowz7yyYlYGFvjZNpzmScWChEoeY+sFpIR66LVqtbpxTZ
         kAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2rlpopBIM4ml+26wfjoQ0SMW06jZogVlWXAAbjyyjpI=;
        b=Nu/MmnpezqnoRMqGv+9ed32+PkBLv6zsVRjUYLICHgQC11LPwJXR/n0Dn/YxIdDZUS
         tGPrzeQ2Z418UnVhQojZBoYOYGlQjNLuqFIQIzCca2ESu1QfKGD3YpcGXUQTpdzpLyTN
         AJ9GSU+tLP+rjlIRRt9lkC4mK8bTjZZLVTx3N4cAQOxWXroZkK6n04pwxb3CCOWtzXUa
         MY+qdzuvimthOGNOBfMkp5fIWbQR8v4lKgEEget6mtJqmzFtgAeu4Mn4HKjUYXJa4wx2
         Nhd+xjAys4BM5/GpTdlpur5yEWJQbduBgR7I5zHhh5iXINsvRjPUU5uz1uQXDYKZycHt
         CsQw==
X-Gm-Message-State: ACgBeo34si3HVUvuGm31/ofQViuEiNyYQ6ShUutABaG2Tc6zdjdbFocH
        xtHvO4iIN/n1lQjAzuyGtS9dDw==
X-Google-Smtp-Source: AA6agR4mqfgWs5W/+Ebta1/jCb9fXpNglDL8/IjnB1LAXOHmaSTddBvUI8CN5ZYOHM9FUZ1lpitTWw==
X-Received: by 2002:a17:907:8687:b0:730:7c7b:b9ce with SMTP id qa7-20020a170907868700b007307c7bb9cemr2037272ejc.656.1660833018749;
        Thu, 18 Aug 2022 07:30:18 -0700 (PDT)
Received: from [192.168.50.49] ([109.183.18.108])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b0072abb95c9f4sm895146eje.193.2022.08.18.07.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 07:30:18 -0700 (PDT)
Message-ID: <09d5a345-af62-c411-8fb5-b489337ebc36@danil.cz>
Date:   Thu, 18 Aug 2022 16:30:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [Question] How to know which branch(ref) is the latest updated
 branch?
Content-Language: en-US
To:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>,
        git <git@vger.kernel.org>
References: <2022081818034939145210@oschina.cn>
From:   Dan Pristupov <danil@danil.cz>
In-Reply-To: <2022081818034939145210@oschina.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can use `for-each-ref` for that. For example:

```
git for-each-ref --count=1 --sort='-authordate' refs/heads
```

https://git-scm.com/docs/git-for-each-ref#_examples has an example how 
to get 3 recent tags

