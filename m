Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD23C433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 20:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJHUsv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 16:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJHUst (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 16:48:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C736437
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 13:48:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so4333202wmq.1
        for <git@vger.kernel.org>; Sat, 08 Oct 2022 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0DbWh73in1WhnXtxrNI1P9sWiqcPdFycMYGyD7QnX8=;
        b=HDTt0Ec6OwD8n3bNlKmfjL7yHi3lYkErvC1U1yT9ypLU21816xPVBXRMmmjw0yKdPv
         +k9ms3k+axpH+yKedWMJQfEBM4GuZRvjiSxAApzp11tiAMsMBeHVmH1JpRrXFxjjiDZ0
         HU3GAKt2ObCw0G1XeJ9eF6LkPQW9u/y9wCTQbZ2KZixLGLQBL4LHNrJbD2Cn6MmRkCdU
         rqtESTt3s/bVH1p0p0iQ1VewhC3CkCOFt5YXFMrw6NyObwbGmtUu07B1TqugsaWFNTsg
         CRAvuPWIIsE1psXujBSFZwhKGDIwt2eJsqprjAQ67Y+qSCEdn1Wrqf4nc/r77RW4UicE
         rM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0DbWh73in1WhnXtxrNI1P9sWiqcPdFycMYGyD7QnX8=;
        b=vxpQjb0XFWaoaSoGhxIQkM5fsAmiPvSuqsUsA6juLYVnI7l/tQVD+AScdu0Pu0N0by
         VFiX6bn4qpBtNAY+HHj2n8zmkg85aCGkdE6aY3cJh0i7P5TXbu6O6YBGZ7BilclLDO3j
         C/+MfdpiafWnr/XUqQ1UtJaMQcwZGdZxItZhoOxmcoMeUNE/8WPrszBc+zrB4AREBQD7
         9tgtKd26Om6rb564LdaeAJ/p1vPv4ZkQ0itHuspoH8dfP/FSZSwGRIrUfbQMUQBdyXai
         Zf5Ha6YVfYvFRQxzmval71cFcyuhHxsvH7+F2lg9MlfAghCkKv+4EpwbvOSmCkeyE9wo
         IBug==
X-Gm-Message-State: ACrzQf0u0algMiLJf5ZZ45Buv4mdE00AEucG9Z6bAmJ7bPMDpPvAKXbI
        SNfCWwkuAp34hNRAa0oOSkMg6DSK/8o=
X-Google-Smtp-Source: AMsMyM4lLpvXI6VRZUlet+ga3+AdHwnneOroN04GiqiSrsT3C49pXgzvmdqclkKiePPl8cBR/peIWg==
X-Received: by 2002:a7b:c050:0:b0:3b4:fae1:6bce with SMTP id u16-20020a7bc050000000b003b4fae16bcemr7149953wmc.131.1665262125767;
        Sat, 08 Oct 2022 13:48:45 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id ck10-20020a5d5e8a000000b0022ca921dc67sm5474359wrb.88.2022.10.08.13.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 13:48:45 -0700 (PDT)
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
 <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
 <f24837e9-7873-c34c-bd78-8ae3be0fc97a@gmail.com>
 <CAPig+cSn29Fq4ywC9zXoJYRVG8KUEhHuDdwEUSioFMUVs+S-ow@mail.gmail.com>
 <a7aca891-dd37-7e5e-61fc-8012fec18ae9@gmail.com>
 <CAPig+cRxy5C+CqUOzmhe16j+hssxsygha3huVga8tLJ+imM4Hw@mail.gmail.com>
 <xmqq1qrib435.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <48fa9be6-2e55-e2e1-d1ad-7895811bfca7@gmail.com>
Date:   Sat, 8 Oct 2022 22:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq1qrib435.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 8/10/22 19:46, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>>> Yeah, I thought about that.  What convinced me to use "git stripspace" was
>>> that maybe that '\n' tail could be removed sometime from the description
>>> setting and this will be fine with that.  I haven't found any reason for
>>> that '\n' and it bugs me a little seeing it in the config :-)
>>
>> That reasoning occurred to me, as well, and I'd have no objection to
>> git-stripspace if that's the motivation for using it. I don't feel
>> strongly one way or the other, and my previous email was intended
>> primarily to point out the lightweight alternatives in case you hadn't
>> considered them. Feel free to use git-stripspace if you feel it is the
>> more appropriate choice.
> 
> I do not think I would agree with the line of reasoning.
> 
> It all depends on why we anticipate that the terminating LF may go
> away someday, but if it is because we may do so by mistake and
> without a good reason when making some unrelated changes to the
> implementation of "git branch --edit-desc", we would want to know
> about it, and such a loose check that would miss it is definitely
> unwelcome.  It is very likely that not just "git merge" but people's
> external scripts depend on the presence of final LF especially when
> the description has only one line, so unless we are doing
> deliberately so, we should prepare to catch such a change.
> 
> If it is because we may gain a consensus that the description string
> (which by the way can well consist of multiple lines) is better
> without the LF on its final line, and we are "fixing" the code to do
> so very much on purpose, it would be good to have a test to protect
> such a change from future unintended breakages.  Adding a loose test
> that won't break across such a change today may be OK, but whoever
> is making such a change in the future has to make sure there is a
> test that is not loose to protect the change.  And it would very
> likely to be done by adding a new test, instead of noticing that
> this loosely written test can be tightened to serve the purpose.
> 
> So if we start with a tight test that expects the exact number of
> LFs at the end, we would be better off in that case, too.
> 

Fair point.  Thank you for being cautious.
