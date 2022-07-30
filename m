Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C28C04A68
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 07:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiG3Hu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 03:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiG3Hu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 03:50:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B68917E3F
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 00:50:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so7218812pjk.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 00:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ossmVyBaj5B/B8v/EwJMggdo7f7Z1hzUSUn8fQGe9lo=;
        b=dNy/lS/sF4+RMkEGNq+OVBGFm2du8UZqvipZxOIlkE+vV39Pvm2iY5vhSOVVTlseoF
         EsCRg6aygqJhao/N9ZdPipuACWca9vWcvuhdROXD+lwmVodqGw2RECYRlT7De7MO4Euv
         y9yeb2nfEdp1sFhfsVnBrCRZiqKUuovRCbmfRnSvM/h8OBUCLxNST7WIhUy92WGDFKQO
         p5rSdWsc7iL7C0ZXPtMiMqC4kQ/rMVLHYncbvrrP0bH4FevvVTwLIF8Qa6TdLCJg0rsr
         ZC2Uiep3u4SmOT4MQAx9qMO7PZ8sbFgKQemkF/vbMneleY+wSumbV2RSoTTjsf6EiWoL
         5JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ossmVyBaj5B/B8v/EwJMggdo7f7Z1hzUSUn8fQGe9lo=;
        b=BJcCYJBtpByynf6/Fhfr1hk9ZxyU5CQ9dVScsgENnUUdmtT/H+XzqEyEWntaptQdc4
         xrPK/tLewPkrUS/DDNJQoJFIbFKNtuwVji2OjWf0PzrXXey5Kpnc9KeLBMs7tUCg+26P
         7/YBxRob2ZBg7jplRnBFibIzc0ywrTFbfWBcDOiFrH0JJ1rYGXP1rrvKS40IZh/hfIf5
         BNFgljFYOtHn4p80l+3dbFCzUjNl8PM+Ij+sUpk3UA6gE1FMHrFdM6ZpxjtOmYnEltSF
         uzXDOMI8wPtRscfMsnqoaHg0+E7yPUto1okRZ/Kko8NnmZoOR8h28z1xlCfl74LdHZXZ
         E+lQ==
X-Gm-Message-State: ACgBeo3ioxq5+GNdIOHGnx34evbrvqEFYtRGOIzFmMsbsLdu77O0ax/b
        GDIcX4207hUy95y7XEpCjp8=
X-Google-Smtp-Source: AA6agR6Vc+m2FdzPGVSPWnoDT+oMENLyuL2Ikgn8+Yipfv2KsihHQDkaQRgXGn33TZVyYmdVL++GLw==
X-Received: by 2002:a17:90b:1bce:b0:1f0:505c:74f7 with SMTP id oa14-20020a17090b1bce00b001f0505c74f7mr7840634pjb.87.1659167456721;
        Sat, 30 Jul 2022 00:50:56 -0700 (PDT)
Received: from [192.168.1.4] ([223.235.77.46])
        by smtp.gmail.com with ESMTPSA id s63-20020a625e42000000b00518a473265csm4092280pfb.217.2022.07.30.00.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 00:50:55 -0700 (PDT)
Message-ID: <1396d611-970f-d11a-ac35-3bf7d03469d8@gmail.com>
Date:   Sat, 30 Jul 2022 13:20:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 0/4] Add support for mailmap in cat-file
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
References: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
 <20220718195102.66321-1-siddharthasthana31@gmail.com>
 <xmqqpmht3tq1.fsf@gitster.g>
 <CAP8UFD0U8hQ+gyN1=7M4oYEhX6=z_1LS4JaLjqdPG52BELRqtg@mail.gmail.com>
 <xmqqh731av9f.fsf@gitster.g>
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqh731av9f.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/07/22 01:02, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
>> On Mon, Jul 25, 2022 at 8:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>>> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>>>
>>>> Changes in v6:
>>>> - The function rewrite_ident_line() returns the difference between the
>>>>    new and the old length of the ident line. We were not using this
>>>>    information and instead parsing the buffer again to look for the line
>>>>    ending. This patch set starts using that information to update the
>>>>    buf_offset value in commit_rewrite_person().
>>>> - This patch set also tweaks the commit_rewrite_person() so that it is
>>>>    easier to understand and avoids unnecessary parsing of the buffer
>>>>    wherever possible.
>>>>
>>>> Siddharth Asthana (4):
>>>>    revision: improve commit_rewrite_person()
>>>>    ident: move commit_rewrite_person() to ident.c
>>>>    ident: rename commit_rewrite_person() to apply_mailmap_to_header()
>>>>    cat-file: add mailmap support
>>>>
>>>>   Documentation/git-cat-file.txt |  6 +++
>>>>   builtin/cat-file.c             | 43 +++++++++++++++++++-
>>>>   cache.h                        |  6 +++
>>>>   ident.c                        | 74 ++++++++++++++++++++++++++++++++++
>>>>   revision.c                     | 50 ++---------------------
>>>>   t/t4203-mailmap.sh             | 59 +++++++++++++++++++++++++++
>>>>   6 files changed, 190 insertions(+), 48 deletions(-)
>>>
>>> I haven't seen any comments or objections to this round.  Are people
>>> happy about it going forward?  I am planning to merge it to 'next'
>>> and down to 'master' soonish.
>>
>> I am biased, but I am happy with the current state of this patch
>> series. During the last versions of this patch series there were only
>> comments related to the first patch in the series (revision: improve
>> commit_rewrite_person()). It seems to me that they were all properly
>> taken into account, and that the code in that patch is now correct and
>> relatively simple to understand.
> 
> Thanks, let's move it forward.
Thanks a lot Junio, Phillip, Đoàn, Ævar, Johannes, Christian and John 
for helping me with the reviews and making this patch better. Thanks a 
lot for accepting it :)
