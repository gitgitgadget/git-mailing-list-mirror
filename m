Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B81CC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 10:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345921AbiCHKmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 05:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiCHKmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 05:42:07 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BDE42A25
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 02:41:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q14so12213771wrc.4
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 02:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5ETA+ue/6eiW+9Y/IgMHXEelmeSrKYSAwy6GOmAtZJs=;
        b=GXpNNPmdOCL2dJZTEToum1ZFdPeXLpjYNunhOWpA/Q8ueJvdcidKTJI60+cevbKU52
         ozVv7AmjmKKm1kv/zDPzrcbNnwdUJi2XoxWq4M46QHyWxcGlWDnqpyPqsW8qBasmJSs6
         rlbazCj0jszElXn+5XT8fEcU9KHIWycptpwDdki2wlNCu/oKVUNgo13bO4b6q8etewOd
         UuptACYterHDYx86L+o2irJdBgAEXliG8YyXJF4rA29rDNFRCqiwyV2zbDWviyPRwdQT
         253ohu9T10cGW66vlC9mMMyReDiymCcDNI+KwNLS5TDeh0eFaMqd/+pFsqWD/Kzh9H+6
         l9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5ETA+ue/6eiW+9Y/IgMHXEelmeSrKYSAwy6GOmAtZJs=;
        b=VIkgdzCPinIaEbOvpTsKhszlWC4Liiof9aSXBImh2bYWsOgI9OX90llDN32olQ07BX
         5htN8Ryzb6RcHk98JVixwMfHsYWC5xgX+nnNLfwWt6vjs4bIBdoxA41b8k60vERKi37a
         ZDd5oftoiPmbeGCCH/O4umHZGalmtzfNkM6EKzftMHxQMaBT5OAUL/MGPXGiFeVEVIHu
         c8jfrYHvBrUkOVFe+QfTrcEQ4oBBjtcYDOef9zwbalUe7eVm0R79jxIKS+eQo1o3ftOk
         urLNDE/asT3jL3gfhz3Zd+AZmKB1nHiIUCly0T/zfpSgvA58Gx35YjOw6dSP6uHVzA3+
         Vszg==
X-Gm-Message-State: AOAM533vf3kUJ+P7XdBgdx2V3iHxCCs++QUxSqPuo9ALk8s9umFktpMV
        9fxIVyUS5H+RYNHD+r+/VLA=
X-Google-Smtp-Source: ABdhPJxUKw93VFi/DWOOPrIB0Bl1/FymxKFMNtWI5nd4aTxePCc4d3lTruNxHaFzw6RAbbTzEH5Sfw==
X-Received: by 2002:a05:6000:2ca:b0:1f1:e692:9986 with SMTP id o10-20020a05600002ca00b001f1e6929986mr9406649wry.427.1646736070174;
        Tue, 08 Mar 2022 02:41:10 -0800 (PST)
Received: from [192.168.1.201] (206.2.7.51.dyn.plus.net. [51.7.2.206])
        by smtp.googlemail.com with ESMTPSA id w9-20020a5d6089000000b001f0256761b9sm22407085wrt.45.2022.03.08.02.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 02:41:09 -0800 (PST)
Message-ID: <dbd48cc5-1f2a-12d7-e3aa-d5f885ef9ad1@gmail.com>
Date:   Tue, 8 Mar 2022 10:41:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] terminal: use flags for save_term()
Content-Language: en-US
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        phillip.wood@dunelm.org.uk, Git Mailing List <git@vger.kernel.org>
Cc:     carenas@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-2-phillip.wood123@gmail.com>
 <95cbca4c-ec26-853e-243f-461a365d9f71@ramsayjones.plus.com>
 <a2d91895-d933-9909-2f1b-5addd38974f3@gmail.com>
 <e16ee84f-4fa5-6cc8-c96d-3b728e3c8b2a@ramsayjones.plus.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <e16ee84f-4fa5-6cc8-c96d-3b728e3c8b2a@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay

On 07/03/2022 20:21, Ramsay Jones wrote:
> Hi Phillip,
> 
> On 07/03/2022 11:11, Phillip Wood wrote:
>> Hi Ramsay
> [snip]
>>> .. but here, you pass the flags as the second parameter. ;-)
>>
>> Oh dear that's embarrassing, thanks for your careful review.
>>
>> Are patches 3 & 4 OK for non-stop platforms?
> 
> Err... I didn't notice any problems with patches 3 & 4, but, as
> far as the non-stop platform is concerned, I wouldn't have a clue! ;-)
> 
> (Perhaps you were thinking of Randall?)

Sorry, yes I had confused you with Randall

Apologies

Phillip

