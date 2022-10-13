Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25797C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 08:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJMIpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJMIo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 04:44:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40724165B2
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:44:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so2756285wmr.2
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NWJ/HJUE1HaWFKAphULP25TVrf6Hvo9SHI3IPSinCYg=;
        b=VFdr2nXEw++xMXOtlJtS1DLiRuZaF9bC+sChmmaXEBJh3rCkA6ovZ+diTXQMU4CQfc
         1naoU41Fc70O+ditQ7BOXETDIAZAHIKcA0IwskPBn5+IvKR305D2/4X6UDgUiVWb79Xb
         Lbp0PbTIRkeHEYuUGpBNhs1yaHW/W4n+8AwtHeFuQxc/bCHEGOUBOkeTA5wd5WLCNC0j
         63FkghFIyrtk38yFX1unokkiwqKFZFoFRWCCKZTMDCESlNBpt3xCq057XC/YJr0o4wOp
         tmDJ1jAid21kFAEJc/dqgk+Nn68dJh5+14pHfcYz4uWV/fWRWrW/ymjupwcqaTT/JfHx
         0GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWJ/HJUE1HaWFKAphULP25TVrf6Hvo9SHI3IPSinCYg=;
        b=VjK/NvUkKKDF3wvIZB6pN/g6hBJWlHvxKWxOTbZLjiGoH/Y9Gwlc98BueTMairvbQw
         O/JQTs0jkw86IhSfq3syHwRZiDoWV7wrES8kCXtbVFHbTbdar6thViogc2sNxyc/NeVj
         4qa/VcqlKoxbbIkL0AGlb7nNMCs+yDtgE1cpigo0dyKuFZgnCm2ROZjJ2VEPj1trwqka
         B4Ym//wst/Vzq8h45So5y3oSl1yzziPVErx4/XSihP9cnqw0aIRgVDBEKzTMMSD2NTOo
         yR4jZgxuX6k2Ue2xLkTygtgCZeUAtxL3YxnxnFZuJFI+47Fm5Q+fDO3/ym4NNk2cAJPl
         EN5g==
X-Gm-Message-State: ACrzQf3nZ0Io2f2pfQWUbw0EAmprkdmQExbQ/AVmeL6yxMLOeAxdttOM
        Gac0A7+alN6iqp3SP6C72cmckr07vjQ=
X-Google-Smtp-Source: AMsMyM439Z8kizm6fznmfcT/JbmQbO+zarFnapjmPE1A+PwMyL9YUGeXtywX19A1ZzCgvdw9iAKakA==
X-Received: by 2002:a7b:c4d9:0:b0:3c4:e77f:b991 with SMTP id g25-20020a7bc4d9000000b003c4e77fb991mr5897208wmk.104.1665650692693;
        Thu, 13 Oct 2022 01:44:52 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id l3-20020a7bc343000000b003b47ff307e1sm3755438wmj.31.2022.10.13.01.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 01:44:52 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <64155477-827d-6a16-a5fa-7e2cfc78569e@dunelm.org.uk>
Date:   Thu, 13 Oct 2022 09:44:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/8] rebase: make reflog messages independent of the
 backend
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, Victoria Dye <vdye@github.com>
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
 <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
 <xmqq7d14lqxc.fsf@gitster.g>
In-Reply-To: <xmqq7d14lqxc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2022 21:37, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This series fixes some bugs in the reflog messages when rebasing and changes
>> the reflog messages of "rebase --apply" to match "rebase --merge" with the
>> aim of making the reflog easier to parse.
>>
>> Thanks to everyone who commented on V2, I've added the review club
>> participants that I've got address for to the cc list. I've rebased onto
>> pw/rebase-keep-base-fixes.
> 
> Thanks for identifying the base clearly.
> 
> If "What's cooking" is correct, the base topic is waiting for an
> update?  I'd prefer to see us build new stuff on top of solidified
> ground.

Oh sorry, I thought I'd submitted a new version last week but it seems I 
pushed it to gitgitgadet, updated the cover letter but forgot to say 
"/submit". I'm hoping that will be the final version and provide a 
stable base for this series.

Best Wishes

Phillip
