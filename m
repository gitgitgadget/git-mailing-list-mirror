Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F01C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 12:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiGUMO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiGUMO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 08:14:27 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67041863F4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:14:26 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c24so1102339qkm.4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=04+BvsbdxGKJT2WNs1WjsLHwv1NXrDOwKqsNdD5pNL0=;
        b=H73hTqE/oEeO7SRKR0i5R+td3H+cyvGGPK+6Z1JoQEV6KMbU87vc8b/QbKsTSXNNcS
         Vo1v2fYGwOgYkuvIRRGst5Cj9Q0q8UJimW8aogc8Q1fJq5mSMx6dn6r82Qh3T0FAMPep
         2NuHx7WPmn8J5XZGxtFNHKZOQ6aqp6O7p4UX5sgdbJGWt4csXjkiexF6zDE/MAS7aL+6
         uhh7jqd7mYLDg8myDtSs3s0Sg7F1jBem5sNPdFQqfpcKqFpLBh2UT9vtXOpzBrfN7m3/
         ElBVjbzW6p1z55lv5SO5w7mysAOPiR6pY8nbZQnDqnf13ipyNxPStCBJEFAfY+OLXxjn
         Pmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=04+BvsbdxGKJT2WNs1WjsLHwv1NXrDOwKqsNdD5pNL0=;
        b=S3fJemCa7J0iF/kPepjURsqX9WqOmltjwNJsRMcdtBI3IXJCnc+JsCCZQppKSIRC9/
         AYckRw93HHf44K7vQF4r0gixuz/a5eojt/zcSdjmcOYEiDPg6QlBHXAeaEePv8QLUw8X
         jWqVCdYkQRR3QViF1tv5WAnzXo+zxgdHuoSvZCBYH/hsCuDz2pC87gFNbQ8L9SZ2DvTI
         FBINy1zD5VUKZIAWUtvQKO4iWeeMXf2QeKVxEEUSGS8//ppG6a0L/cRprHoSUYI4q/5C
         eyL9WMPYxACc0WK6107uEAq5S64G1jrc0jg0Y+SyGuZuZVS67rgit3xelGuXX8LtxLVe
         xJtg==
X-Gm-Message-State: AJIora+BwRDdWlwk7Ks+XGTCn90MycNbCBjLlaGBK1Sx2LkayKA/C/D3
        O97/suhE+/FMUY404QVUYoyLM0D9D6T4
X-Google-Smtp-Source: AGRyM1uMTg7A9SqlWRAGhuRiPIbN00kzy+EJ1mhgNImheI35u11mkQhPl5xy6wwlhO40U7/JuQEdOA==
X-Received: by 2002:a05:620a:460e:b0:6b6:1df9:1fc3 with SMTP id br14-20020a05620a460e00b006b61df91fc3mr1836284qkb.217.1658405665465;
        Thu, 21 Jul 2022 05:14:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8099:5229:7961:505e? ([2600:1700:e72:80a0:8099:5229:7961:505e])
        by smtp.gmail.com with ESMTPSA id v33-20020a05622a18a100b0031f0b43629dsm1288323qtc.23.2022.07.21.05.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 05:14:25 -0700 (PDT)
Message-ID: <304fd857-db62-7a1a-a9a9-cbfa93c2a00c@github.com>
Date:   Thu, 21 Jul 2022 08:14:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Can I use CRoaring library in Git?
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <CAPOJW5yJDq046nhq0V-syAg4ttoy++rBtq_RHSXPAKhtDDw6jQ@mail.gmail.com>
 <xmqq7d47m1t2.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq7d47m1t2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/2022 2:12 AM, Junio C Hamano wrote:
> Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:
> 
>> On Sat, Jul 16, 2022 at 7:20 PM Abhradeep Chakraborty
>> <chakrabortyabhradeep79@gmail.com> wrote:
>>>
>>> Hello,
>>>
>>> I need the CRoaring[1] library to use roaring bitmaps. But it has
>>> Apache license v2 which is not compatible with GPLv2[2].
>>
>> I have reached out to Daniel and he agreed to make CRoaring
>> dual-licensed under MIT and Apachev2[1].
>> Now, I can use CRoaring, right?
>>
>> [1] https://groups.google.com/g/roaring-bitmaps/c/0d7KoA79k3A
>>
>> Thanks :)
> 
> Nice.

Great news! Thanks for reaching out. I'm pleasantly surprised at
the turnaround. Good luck integrating it into the Git codebase!

-Stolee
