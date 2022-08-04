Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516E1C19F21
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 19:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiHDTQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 15:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiHDTQS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 15:16:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EBB6BD56
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 12:16:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v3so928569wrp.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 12:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=hM5OL4392s2w0eiUYX58LekOmIloHrtH1aYaIEDynRU=;
        b=mFP/xE1zW9usoxi23SFhG0OPM87EnAFfkdF0Eu4VsKt5sGmzYI20ViG01UwTRsp7Ym
         ffjjQDppAecsG2dCvzQnGR9iPZVI2YymhvGS6Z2y3o06b/XCnEwyUZcwEkthaYeLncdr
         +GYliLDZcxjT3KGDZJ2i7U040nERodTW2dUiv/QCVoInhiJGOUo67QUC/UZYm/VUGuiy
         ryuv5b7oZSEK4y91nPiP0mfdJ3YiqbPeeftZXcIRZephktYCJ66vBMF4WuHSuucJTyJM
         yCnrmCPyolhLeNlBfTY9JiHrOrDqWAjMAjMUF517fUt+PgXYQhh7tHOV079VAiDv/925
         4A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=hM5OL4392s2w0eiUYX58LekOmIloHrtH1aYaIEDynRU=;
        b=hcAhPeLNik3OY9iWx2lFhBxNGnaCHmaGzzR4NRirkzOaYCqaLplA5nI1FfRDa5cdPn
         KC08mPTu8KluwyH8zJLpLbJqMTz48BTbspKvuezyQrRdkIlCORE8MdZDZAppO7f8lkUP
         znKtKRr8/csTstSTqmRYktp/1KayyI/r5riCiM9T2oIFarPcAz9yxYDLUr0+3qZ6xznu
         CaDNXhS8XEsruwsG7yBi8JQhBPyNs9xBsrhBNhW5FpERkFHlgunWzOPjiT+yuypmcu0a
         TFSe+wHVnbh2MC6EU1pV7pLkC3IUOnwqxZkNPPwjy3aN38kW5fJjVXhas2louNtxO+hC
         Q9Ug==
X-Gm-Message-State: ACgBeo0htL0FRX+PNNbnfs99OOnHN/VQJ7D5BpqPFIO1xmFkiQbyhyn1
        2FGthE9yOJuzh+dtyyhZ148=
X-Google-Smtp-Source: AA6agR79Ng6/Zhp2epv4in/wPly0uvl2ownSrUwYNGx5j2ddiccxfRiQYBljJbitK3bQZDLbZCOycw==
X-Received: by 2002:adf:f646:0:b0:220:7d75:be7 with SMTP id x6-20020adff646000000b002207d750be7mr2357227wrp.256.1659640574801;
        Thu, 04 Aug 2022 12:16:14 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id b18-20020a5d4b92000000b0021d6924b777sm1778341wrt.115.2022.08.04.12.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 12:16:14 -0700 (PDT)
Message-ID: <53cffc06-ebb1-ac97-ceb4-4c242a82c68a@gmail.com>
Date:   Thu, 4 Aug 2022 20:16:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] tests: cache glibc version check
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1311.git.1659620305757.gitgitgadget@gmail.com>
 <xmqq4jyr6fuz.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq4jyr6fuz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 04/08/2022 19:08, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
 >
> Between USE_LIBC_MALLOC_DEBUG, which is the name Peff originally
> gave this intermediate variable, and the one you use here, I am
> undecided.  If the only thing the GLIBC_TUNABLES mechanism can do
> were to tweak the malloc checking, then both names are good, but
> that is not the case.  We are only seeing if we are going to use the
> malloc check feature given by glibc here, so the original name feels
> more to the point, and use of GLIBC_TUNABLE mechanism to trigger
> that malloc check feature is a mere implementation detail.
> 
> But that is minor.  Let's queue the patch to help me not to forget
> about it, and we'll amend it if necessary, as we'd probably need a
> helped-by or signed-off-by from Peff anyway before this hits 'next'.

Oh, sorry I'd missed that message where Peff posted essentially the same 
patch. I wrote this at the same time as 067109a5e7 ("tests: make 
SANITIZE=address imply TEST_NO_MALLOC_CHECK", 2022-04-09) but did not 
post in then as we were in a rc period and then forgot about it. Having 
just read Peff's message this does not make much difference to the test 
timings and if I'd seen that before I wouldn't have posted this.

As for the variable name I don't mind particularly either way, I chose 
this name as the variable is checking whether we should use the glibc 
tunables mechanism or not.

Best Wishes

Phillip

> Thanks.
