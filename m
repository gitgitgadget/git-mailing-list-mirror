Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D53C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 07:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbiHEHxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 03:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiHEHxK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 03:53:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A1610FFE
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 00:53:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h132so2018310pgc.10
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 00:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6m/SweN4enEepnmhgj0r3UViZtbrLW9zTn/e+yJAUsc=;
        b=iDKkNVn9UuWaxsWDsc8phJhlU5tluHX8/VSX+geT1uF9xy+SX+WACAVbutqBRo7Pjq
         R4rgFy/Fd9lqEa1Wbv37Dux8C09qDDVAsdm5XXir0nhAobgK23Y5FbttsCT2fz44cqFp
         v5CWi4T/gAL+zNnoZJKHxYWLP2iepSvg4DfOlEEvYdboeBQvAc4lPwILCvVCX2TmXWOn
         /l1lI1ksUaxl+NtJVCiItQcKjPyhLxgMKyKGE109qYMdNdrVycihho0uzuXI7ehqIaXQ
         i2PZphlFdif0VDN7RXZ1+5NPwAbXKCwtYDwl9a95Z+3NL47fNuqx+Qa28l3PrrKbSgN3
         YUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6m/SweN4enEepnmhgj0r3UViZtbrLW9zTn/e+yJAUsc=;
        b=MJ6cXIR/JvPlF+ePu7r9IE3/kORYA0t2s9qT0xEHmdOifKN+RaPHr+7PlRFdXtOWEX
         QoAPLkrUQ4EZwQzcE52wvHibbiBYefPV1WCWr7xwNGc/CiUXyZad6Xz9WfOoplLANhzu
         //8ws01Otq8dJLueRRsV++X5jQ77uCRicuItCWo3t6kQgpX+Cur4BlTGibpLLglbl+TG
         NM9uAdKkXRw9kbkZs7s3P/5EhM+hlAl7TSooLbkFaGMq7bvCF9pNBCZm1BVAf8dg/vcP
         hQbv8MGYeOKoyUrxI29LI53/keZrBNzFmbeqJyiumyVdV1DPFWTej7AOva7vBlpyowsy
         JHHA==
X-Gm-Message-State: ACgBeo1ly3NQkOj/2cS/kiR9BGCSxi+e9HjpFnTQV7t8DjW/7AmlWTvC
        q2IrFQrfj9/uO7yYIW+hJaUxp+pXmNlOsg==
X-Google-Smtp-Source: AA6agR52hRJhlJUlNLYDJE7CPissmeDB46Th7tYIPDhyYt3EwEnN0xSSL45/tb3k3+Kow9yGRdEyQw==
X-Received: by 2002:a05:6a00:16cb:b0:52b:cc59:9468 with SMTP id l11-20020a056a0016cb00b0052bcc599468mr5656521pfc.46.1659685989345;
        Fri, 05 Aug 2022 00:53:09 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id 186-20020a6206c3000000b0052d4b0d0c74sm2297949pfg.70.2022.08.05.00.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 00:53:09 -0700 (PDT)
Message-ID: <892e718a-f9ab-51d9-619f-7aa661ddcda6@gmail.com>
Date:   Fri, 5 Aug 2022 15:53:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/4] pathspec.h: move pathspec_needs_expanded_index()
 from reset.c to here
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220803045118.1243087-3-shaoxuan.yuan02@gmail.com>
 <90f817f1-340d-48e0-22b1-c6644d62f19f@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <90f817f1-340d-48e0-22b1-c6644d62f19f@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 10:35 PM, Derrick Stolee wrote:
 > On 8/3/2022 12:51 AM, Shaoxuan Yuan wrote:
 >> Method pathspec_needs_expanded_index() in reset.c from 4d1cfc1351
 >> (reset: make --mixed sparse-aware, 2021-11-29) is reusable when we
 >> need to verify if the index needs to be expanded when the command
 >> is utilizing a pathspec rather than a literal path.
 >>
 >> Move it to pathspec.h for reusability.
 >>
 >> Add a few items to the function so it can better serve its purpose as
 >> a standalone public function:
 >>
 >> * Add a check in front so if the index is not sparse, return early since
 >>   no expansion is needed.
 >>
 >> * Add documentation to the function.
 >
 > I took a look at this diff on my machine with --color-moved, which
 > highlighted the other valuable thing about this move: it takes an
 > arbitrary 'struct index_state' pointer instead of using the_index and
 > active_cache. These are good things that might be worth mentioning in
 > the commit message.

Thanks for pointing it out! Will add.

--
Thanks,
Shaoxuan

