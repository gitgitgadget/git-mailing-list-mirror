Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5B7C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 15:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiJZPRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 11:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiJZPRX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 11:17:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884191213ED
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:17:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so1763406wme.5
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lxIJdGydgdYcu+ecAjYikevcuM3DXF7pT4TpU5JnRE=;
        b=Lk8dyk9+FSjzN15C+QhIlcSun/Uc2dlVe0hXyoWx+jkeVsQstPMevUhMHJtJan1den
         x518hT7etxKF3TGW2/iiiNk+ih5R1Kii1Q4XAvGGrMAcdVQcIq0cbp/yPEL83lHKkQgM
         JxokW8GsAA4oJ8KdZbHa7Sh6XUSCwJCcB1xZJ1LMP/YyLzM5ElHjghzaXs9YbNoJDP84
         0utS5HZ7X3idClqdqrJZcjjNZD6IvRWiuMMzBk+XGOB7shiArXWjvGQ0EWRKcjheWgvO
         Z6Zic0PRoSr76zoy+Nvd4VaHcLUTFl9uWe4kv67nh6MI9lBvVMpwORl8L0nwGMtxsQ/e
         B/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lxIJdGydgdYcu+ecAjYikevcuM3DXF7pT4TpU5JnRE=;
        b=0Oa3BS0lOGqb2+ZgShZ/qfEirl58rIV2Tq33INkO/UwZGnCHzXTjQjqvFMoIl+/JDc
         wd5x/GVmAUljctXbJIGEF2XrWukqo3vqcumwek2eQ5w8OBYsnnIqkpu+pIZZ6eAc8sba
         ylUkvb/ue32F7Q9Jc1pGeWz0OzW5s4nHs544QJait4Ku7MW7HKWB9HHKZIpYEYypprhz
         ekJkowampb/A/GFMEtfZ+XxyMyifN/dCQUjJw61M0cscvpJJRlXxJlsXBCS4RQUf4PvQ
         ma5LYm43a3VNIYJ4QGD8hi7JQ/usI2+pAI2L+nKiVimT1yIqqb3BFeooLNqKhTrJUb3O
         UqtQ==
X-Gm-Message-State: ACrzQf3I8Mo4Wx5etrZR8IFMfDM8u504/QiDiAMbed7qQLndoNRrAWVo
        dpfBupD+XK78CdAb9k9ge6Q=
X-Google-Smtp-Source: AMsMyM4B9STplHRc9hGSx+Rd2RDv3gSlR26OjtMQiZVD35bVb0qhCsdCdY1kgy1pjFoDdOfQ8cbWVw==
X-Received: by 2002:a7b:c455:0:b0:3c6:bd0e:f9b0 with SMTP id l21-20020a7bc455000000b003c6bd0ef9b0mr2866243wmi.21.1666797440041;
        Wed, 26 Oct 2022 08:17:20 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b003c6b9749505sm2137394wmq.30.2022.10.26.08.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 08:17:19 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8af26af0-548d-52c8-9752-1a265af8fd54@dunelm.org.uk>
Date:   Wed, 26 Oct 2022 16:17:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/8] rebase --merge: fix reflog when continuing
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, Victoria Dye <vdye@github.com>
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
 <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
 <2c965f4b97c1773abc6b844b87fa64c5d6d1524c.1666344108.git.gitgitgadget@gmail.com>
 <xmqqk04tm62o.fsf@gitster.g>
 <86699708-d631-fb49-482c-af27204a3570@dunelm.org.uk>
 <xmqqczafopc0.fsf@gitster.g>
In-Reply-To: <xmqqczafopc0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 25/10/2022 17:11, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>> Both of these will be fixed in a future series that
>>>> stops the sequencer calling setenv().
>>> If it gets fixed in a future step in the same series, that is a
>>> different matter, but if it is easy enough not to deliberately
>>> introduce a new leak, we'd prefer to do so.
>>
>> It's a couple of patches to fix which are more or less finished, I'm
>> planning to send them once this series is in next.
> 
> So we will do the "add a known breakage of the same kind as there
> exists others, and then later fix them all up, including the one
> that is added by this series, because fixes are non-trivial and this
> topic is easier to finish if we allowed to add a known breakage"
> approach?  Just making sure it is what you plan to do.

Yes, that's right

Thanks

Phillip

> Thanks.
