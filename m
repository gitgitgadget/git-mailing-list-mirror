Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECB6C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A20B2065C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4n+CI/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390473AbgEMUH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387445AbgEMUH7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 16:07:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48ABC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:07:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so30023844wma.4
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VKozT7j6t7R/1Lv8b+F9Axx2UdMh9K24C/YqZJ0/l4s=;
        b=i4n+CI/xSle0MVNJzewvHgk5nUkBHtOTPz2fpmfwnIt6NRpfTo4r6s8nuekqKsAJVt
         j2tjSlyWEzdSck1/oeIDlBxvuVBwkdUBL3KBx8dKACrvxCAiDGoG2LZondfadgqQxiPc
         xFkSf2k4bJOChap/XQAWIAUoZEWPvAE/6Ru70w1oVvPOK0Tpb9Oz7DLaH6rbIvv3TPoQ
         u6abI7HOBQKDxh+q/koI38zXNabumersFMb4Jn7mgAdtWd2QZxEUseEddPGgu8A1w0Gg
         2m0MzJO33JHDKVA3WhdFDYtMAHF4fJZS8PekDKC3gcRQqS0wJ/ed/ICtKWDGVo4RVjLr
         W1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VKozT7j6t7R/1Lv8b+F9Axx2UdMh9K24C/YqZJ0/l4s=;
        b=JAl2DDsJR8tIEgthvElxnxEwnR2dz0fVMegvIBr3ZzaqbwLamZ2OZLrsSL8feBOox9
         C/MEWc86nVx0IRfWM7YCT7o24URi3nCCvu/0rXZ90uQMRLRzA7lqdCndlCEM7t2KGNZF
         Q8QrexI00o/ldwZrpCjJ5UlhDr03Sx1GR7cfHGlRE4WfIH0rRgReOJyhwiq7vU/SsYv7
         TO8bDfCXqLwreU174DGoND6+cFjxi4vpfbO4Zd3+mfpDrESfbdUSaoZXxjJOueyLtIua
         HOrWLX/yCiWGUOmoXgS22GPhS4ycP4bN2rDWaJ6GVuFNLO2jvKWIUx21LFmta5XRoGuV
         JUJA==
X-Gm-Message-State: AGi0PuZbRh+ySd4tmNZ+UfkXAtUVd/LElC3DcTCKEEGZkVv72aiu/gOq
        CnxBZEYPHNLO9KRPOQn4rwatvkBNwCGh7A==
X-Google-Smtp-Source: APiQypLMbqBD0mPwoVETWYkAn31W0zG3zAdAeE7ZF7AP+MxgEwTc7mQKjztGLjldyov5Ts/stafRpQ==
X-Received: by 2002:a1c:1fc8:: with SMTP id f191mr18709274wmf.97.1589400477229;
        Wed, 13 May 2020 13:07:57 -0700 (PDT)
Received: from [192.168.1.21] (xdsl-31-164-191-108.adslplus.ch. [31.164.191.108])
        by smtp.gmail.com with ESMTPSA id v20sm901923wrd.9.2020.05.13.13.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 13:07:56 -0700 (PDT)
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
 <xmqq8shxc7ct.fsf@gitster.c.googlers.com>
 <cf25c55e-e0c8-6374-3adf-84f4314869e9@gmail.com>
 <xmqqwo5fvoe1.fsf@gitster.c.googlers.com>
From:   Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Message-ID: <83b37142-f6f0-2f5d-e92c-de3891e8fe18@gmail.com>
Date:   Wed, 13 May 2020 22:07:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqwo5fvoe1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> 	git submodule foreach --trait=is-active ...
>>> 	git submodule foreach --trait=!is-active ...
>>> 	git submodule foreach --trait=is-populated ...
>>>
>>> to allow iterating only on submodules with/without given trait (I am
>>> not suggesting the actual option name, but merely making sure that
>>> 'is-active' is not anything special but one of the possibilities
>>> that can be used to limit the iteration using the same mechanism).
>>
>> The idea that other candidate are possible seem good. But then users
>> will need combination like is-active && !is-populated. ...
>> ... this would allow combination with the is active filter and the
>> previous example would be
>>
>>          git submodule--helper --is-active --is-populated=false <cmd>
> 
> There is no difference between that and
> 
> 	git submodule--helper --trait=is-active --trait=is-populated
> 
> so I fail to see what new you are proposing, sorry.
> 

The difference is that you repeat twice the same flag. Sometime 
repeating a flag overwrite the previous value, but it depend how it is 
implemented. In current case it should be possible to implement it this 
way, if this is required.

Regarding previous example, it use '!' to negate the value. Not all 
people know the meaning of it. A new proposal would be:

         git submodule--helper foreach [--trait=[not-](active|populated)]

What do you think?
