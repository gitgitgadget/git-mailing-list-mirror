Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0863AC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 12:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiF3Miv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 08:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbiF3Miu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 08:38:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6073B299
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 05:38:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r18so18514287edb.9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 05:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g4gbp87lrUiarNXmL3ln/dEaDFk6j6Xu+K3GeBLC9bo=;
        b=ZHvM2+MMgKhwJ+WFelrbpH1zT3Z59k2nU6onEc4Z1WRg9DHctu4p5RH/8diaCpvfVP
         BqWnnsuBWt4qF5zJA6428YZj4ETpRuYFE4y6B8JjmNkt6Gvq5MM4/s/j6X32c08b+Zay
         lTUEuBqbkQ/ZDtJgYm2vTehbKseJhXy1KVHp/HajQVGSf7tzx7ElbLw/Ee2SIq/X3AcA
         0bQiAPcqF7ZulQGcooU4HDNMylBxdf9c0yeAJm1O74XbzVU1GUt63PXnWFasCKL1l+hZ
         cpAiG6Q3VqzOK1pdzNJ0kgpmbOCBHai7r6p94BPZFR8atK2cmSH/9lFWj+nRAOjlG4zI
         arRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g4gbp87lrUiarNXmL3ln/dEaDFk6j6Xu+K3GeBLC9bo=;
        b=wPNMIfPwEM0oxiE2tlC+W4YzwNphZMS7/JWDQQTH2nOQ/j8w1m5iiB59PiMeUSCRxD
         rt92MWdqKdWVjD9OQMCuY6gDaZ/D1Fj3gXq4TQkj3kuVlh5Ciemi74VDOZI/bkl8fx2h
         zZLBE2lE7QPoD1nNZF4Z5VwIbjlo+azX/LY34jpZu2x4U5Adb9DsDWAOq3MokwIxDjI0
         Sgv8F2zdFq0Zu1R6hN19bPpptHlKvALsMC9Cm+fvmO+WjPOV4DmijG3XMBroRWUDNPcf
         IfWEeCvYiz7mVUuKUYffJEcMZE3K33v/MAhofGOVrs47bZ22Vb8GvhGkf7WBIgnxZXtp
         WbPQ==
X-Gm-Message-State: AJIora/pTp6C+4N+FPQSoDjI+GSxKFKLw2HXnp336z71AHVpBlxkFL0C
        TK6YU8v5EypBpco/KH7ZwKeIAujAvDY=
X-Google-Smtp-Source: AGRyM1sSX9RHDqqOdcFBx+LkHszD9uhVxh/FtiMkuGqNUl4V0j8UG9qFkSbhiNakGexbfA1x2mY+jQ==
X-Received: by 2002:a05:6402:201:b0:431:665f:11f1 with SMTP id t1-20020a056402020100b00431665f11f1mr11364465edv.378.1656592727063;
        Thu, 30 Jun 2022 05:38:47 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id v18-20020a50a452000000b0043576d146f0sm13252183edb.54.2022.06.30.05.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 05:38:46 -0700 (PDT)
Message-ID: <0a1650bf-a7f5-0cc5-e6c9-0e02d1f542bf@gmail.com>
Date:   Thu, 30 Jun 2022 13:38:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] xdiff: introduce XDL_ALLOC_GROW()
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
 <da996677f0730ec7a50d399524fb58c44dad468a.1656516334.git.gitgitgadget@gmail.com>
 <220630.86czeqe74c.gmgdl@evledraar.gmail.com>
 <5734b393-57c8-dc63-282e-221ee1937351@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <5734b393-57c8-dc63-282e-221ee1937351@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/06/2022 13:03, Phillip Wood wrote:
> On 30/06/2022 11:54, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Wed, Jun 29 2022, Phillip Wood via GitGitGadget wrote:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> Add a helper to grow an array. This is analogous to ALLOC_GROW() in
>>> the rest of the codebase but returns −1 on allocation failure to
>>> accommodate other users of libxdiff such as libgit2.
>>
>> Urm, does it? I just skimmed this, so maybe I missed something, but I
>> don't see where you changed the definition of xdl_malloc(),
>> xdl_realloc() etc.

Oh I think I might have misunderstood your question. For git.git it will 
still die() but for other users that arrange for xdl_realloc() to return 
NULL on failure it will return -1. The same applies to the comments in 
the previous two patches about XDL_[CM]ALLOC_ARRAY() returning NULL on 
allocation failure.

Best Wishes

Phillip
