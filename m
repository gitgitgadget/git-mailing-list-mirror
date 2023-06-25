Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B807BEB64DC
	for <git@archiver.kernel.org>; Sun, 25 Jun 2023 17:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjFYRBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jun 2023 13:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFYRBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2023 13:01:16 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF8B100
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 10:01:15 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6237faa8677so16700876d6.1
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 10:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687712475; x=1690304475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DbUPLWkrCVrgnGQVRKYoW/eaw+J/yf2FBfnAYNsAEE=;
        b=oR7aJPSaw604UXQxUZw43tP80szbR7ouV3ez1v67y/LFfs6g6f4aQXHLII9RYYlr/v
         KNWWqfmueJdsiOyFtaqpQO3lA6M5oRhw4YG7QnhocIrS44iH7SbLZMScwW2hZdyV8BB8
         aEJI8x2uxY3l9Bhh0IYZhpv/82freUwfMpjMr31RkjP7IxeosJX2T7C7DLkc+ugH47LR
         wVdoOHy1o0UghrF9/dOZKn9Ons2P9fQR43qm2MxVFEDjA79tHplJUV//OJ01vJXi+7R7
         trlQ/ViUhr8zKJmQ94scfp/8eJEd3H4w1Cv5TGaalSrikRWoPCzVpDd/xK2B1rgIQ452
         wHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687712475; x=1690304475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DbUPLWkrCVrgnGQVRKYoW/eaw+J/yf2FBfnAYNsAEE=;
        b=Li7fNcsrTcYQ7pkYdtMaQiivVOngZM4VMTbBtC8ngi3Tybls63opTwT/Wk1rlZIk35
         oVXKAbr+MQxYAszSNb+NshtavAWaWNOmeeNQ9Us6g7vWSvI5buyOBAT7wIRA6+eAYZ8s
         nLGCoT7Nl3KQlQYgyAvdKeE0KnYkYvdFHDbnIc9Zy6upjOYBn/EFfChOOHSR1nD63NUY
         TEf4us0n/8yoTqFG4D7SHtcxTDoj9UxB+MaZ4XAm0EvbV+JY038gRvNl3yFH6s984m0l
         wheCKaDJrvhpPUPpKthRki7XnCsjWufobtUWVFrD0KY8fFi9qnngtB8mCcxBpP4WB15H
         DnPA==
X-Gm-Message-State: AC+VfDwaYMUu/0oA70vyVDDLVsGUm+hpEMEUDoKeCD0o8Lw9O35llUzA
        taCPv9mUhRVMCtL2TN7kocfALMW2hTWmpQ==
X-Google-Smtp-Source: ACHHUZ5hidNUbMAesul4Q3e6qM0An834t9CeH+qdPEln0erBNNoiTixvIqZk6R52TJeSbf8jn0ratA==
X-Received: by 2002:ad4:4ea4:0:b0:62f:ebc4:89b8 with SMTP id ed4-20020ad44ea4000000b0062febc489b8mr27703825qvb.26.1687712474950;
        Sun, 25 Jun 2023 10:01:14 -0700 (PDT)
Received: from ?IPV6:2600:4040:266e:4d00::387? ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id a17-20020a0ccdd1000000b005dd8b9345b9sm2231630qvn.81.2023.06.25.10.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 10:01:14 -0700 (PDT)
Message-ID: <b7181a2d-ba97-eae8-6bf4-4fc4b0db64c2@gmail.com>
Date:   Sun, 25 Jun 2023 13:01:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v0 0/4] Remove obsolete Cygwin support from git-gui
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de
References: <20230624212347.179656-1-mlevedahl@gmail.com>
 <xmqq8rc8781p.fsf@gitster.g> <e04e28e2-2308-1db8-9462-5f81aeff1155@gmail.com>
 <xmqqwmzr5yul.fsf@gitster.g>
Content-Language: en-US
From:   Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <xmqqwmzr5yul.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/25/23 11:46, Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>> So, the code under the is_Windows and is_Cygwin branches of the
>> if/else trees are now completely independent, and the is_Windows
>> branch is never entered on Cygwin.

>
> So, earlier I said [2/4] made sense and obviously good.  But not
> anymore.  It does a bit too many things and then have later steps
> compensate for it, which made reviewing the series harder than
> necessary.  It needs to be cleaned up a bit, I think.
>
> Thanks.
>

I had originally organized as you suggest, no problem doing so again. 
What gave me pause was this paragraph I originally wrote for the cover 
letter:


Patches 1/2 cause git-gui to function as it has for the last decade on
Cygwin, but with Cygwin being detected. However, the browsing and
shortcut creation menu items, removed in 2012 then re-added when is_Cygwin
was fixed, do not work, and shortcut creation will crash git-gui if used.
These are fixed in patches 3 / 4.


So, I'm just checking that the above situation is ok. I agree, this 
makes the changes easier to follow.


Mark

