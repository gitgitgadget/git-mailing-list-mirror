Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A630C001DB
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 19:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjHDTs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 15:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHDTsz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 15:48:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A46E7
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 12:48:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3174aac120aso2121374f8f.2
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 12:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691178532; x=1691783332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=imEAmtRuouHQLR8GAmpo7BJ6wWrUF8e9CcVZR967Evo=;
        b=Ok+jqQfxRoYO+RUJuE74xMffhOHnuZlq8ODQnrmaDs5jWIJ9gkKBj0ghmclMfURJWv
         Z+layhGIDDRMTF5TzbAfHhc8Mt15MDeuewIr7JkGtelpXhP31pSFhmPlq5XwMoRq8dB3
         MCACHq2EF06z8IXhHuSGpTu6KxNjw6nyQhDpPxxkLxs/OBZ6DQNezhCt3RYkEdd6J5sh
         wz+zgxojl/fLKn/fwxq0bQXuhEaujJ+OhbVafrRoSYiCenHTi5FAYGXw5NlTciqlfLrL
         g5b1lm1EQyzjLNA1KbfAwQeoefsvQPWJ4Qvcv499g9r5zIk8l889K1F01ulEWcJ7mAYC
         jcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691178532; x=1691783332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imEAmtRuouHQLR8GAmpo7BJ6wWrUF8e9CcVZR967Evo=;
        b=AHlMGy0ewbd0HW9S33ZHcC9wmWc10Fsf+ZTysi5JXSlQJTJ4bVJ23FXUOqSKwI6tkm
         jQkSoJpQBQTNRXb1n9KPK7uT0gGjBqqyYkeJB78JosiHt+SozrOlHE6zFs0TVtgCofEd
         b+60izW5S4WxuAMXZUIY2ej0qYaEprjFkiBzQTJobGAGoC76Ybnbm4PWR/s+gfyn+fjG
         7fCNpgcOK0YJzCFrdaFiUG5Fba96B+WyHyDK+KmlITV2tTiIXCs4H8RZSDlHpC0eToZQ
         FbjuioCpT6+eQB7AtrWsLcjClCc81T9s0nHHbh0RVWx3sNZ1kjmjcFenNxKi3Gj83YwO
         ZtSQ==
X-Gm-Message-State: AOJu0YzS5zIV8BkqCSzr+sphVbvl89r9e6z3ymNz2s9GhHeQR6kHsR51
        Ic8//Co7+HKp04uc2wx3PbU=
X-Google-Smtp-Source: AGHT+IHUx8Vgxd9hvsU8uMkdjH/qb5h58FweeIYe8WijbTA2xwJS5tETtxKXLzQ3MbRR2KzfUYCZNw==
X-Received: by 2002:a05:6000:11d2:b0:314:34dd:aaec with SMTP id i18-20020a05600011d200b0031434ddaaecmr1866541wrx.8.1691178531980;
        Fri, 04 Aug 2023 12:48:51 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id e3-20020a5d5943000000b00317ac0642b0sm3234909wri.27.2023.08.04.12.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 12:48:51 -0700 (PDT)
Message-ID: <a9d51bb4-2897-c4ca-f8b3-85f50902b041@gmail.com>
Date:   Fri, 4 Aug 2023 20:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ls-tree: fix --no-full-name
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <1535f30e-3cf9-1a0a-04af-4ba4a7c46d15@web.de>
 <xmqqr0oxnnx4.fsf@gitster.g> <9e8225dd-1e8b-8af2-c3e1-0c5834694244@web.de>
 <xmqqh6ptnies.fsf@gitster.g> <a19879db-d45a-ee42-1ad5-497e4e9eb8df@web.de>
 <b17b4f6b-199f-973b-3aa9-ef995a61bb3d@gmail.com>
 <31b71333-de8b-d9a8-3ec4-1bad9cae2bf3@web.de> <xmqqjzug14jo.fsf@gitster.g>
 <xmqqbkfm3gne.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqbkfm3gne.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/08/2023 17:40, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> René Scharfe <l.s.r@web.de> writes:
>>
>>> A bit more verbose still: Document the negative form on its own line
>>> with a generated description -- requires no new syntax:
>>>
>>>      -v, --invert-match         show non-matching lines
>>>      --no-invert-match          opposite of --invert-match, default
>>>      -I, --no-index             find in contents not managed by git
>>>      --index                    opposite of --no-index, default
>>
>> I would expect _("opposite of %s, default") is acceptable by l10n
>> folks, and assuming it is, the above would be a good approach.
> 
> I was seeing what is likely to be in the -rc1 that will happen in
> next week, and noticed that this discussion is left unconcluded.  I
> am tempted to declare that the latest iteration that shows the
> negation of "--no-foo" as "--[no-]no-foo" is "good enough" for now,
> and leave the above improvement as one potential future direction.

While it could certainly be improved in the future I think 
"--[no-]no-foo" is probably good enough. I definitely prefer it over 
"--[[no-]no]-foo"

Best Wishes

Phillip

> Objections?  Otherwise the 5-patch series will be in 'next'.
> 
> Thanks.
