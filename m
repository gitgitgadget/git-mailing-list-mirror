Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C584FC77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 19:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjEBT6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 15:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEBT6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 15:58:09 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18A1FC9
        for <git@vger.kernel.org>; Tue,  2 May 2023 12:58:07 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2a8baeac4d1so43495531fa.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683057485; x=1685649485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ddsi3fKRDECk/OzMvwQmUfeJf3bakMeLScQAt315+0c=;
        b=fs4P+z9BFy94HGmJdvjl+vS64PFbZt/X2UzfpXUrem++eq/UKhCM9BCcwAWnoyXLp6
         zFfoJncgUpR+31E9nkJG/5JadzPM8G22oeZHxdFyMaEfTr9Xjpj7z4drWjVNW0IyDLlY
         VO4WbNtL6lm0yO986PXsO3NsiB49//LKc/e/uQF4hb1F8aYk3Wgry2OiAT6XyXYLtZD/
         rOxglo9eeimgKWPL+BnzrSHO7nV/qH811KAl08+BP3mZjCagYFY5dnjN3wilNj/8L47a
         1V8h0txHyBulHmeE3AQdHD7FX5diCBirYuNTyDmFlzqQubYICRTeXig0Q+CvSD4OQO3m
         lafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683057485; x=1685649485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddsi3fKRDECk/OzMvwQmUfeJf3bakMeLScQAt315+0c=;
        b=ZMDTUMKwueWwSAx+bi0DK0wpD7X5xYC/Ro1ABniJEQXCCdj7HckRYQhkbc4t36Expi
         vfIkecqQr097VqTCJcj53Ja1cAl8iCWH33JXGL2VoRyeTC6qNZwRB/O9+YioeU8DzDr+
         nFOKpbg9AvY/6mWLnET9kd8j3myApEoHpSt6cTEO2GJDZAg3KWMm6WN6d6Jn/IZ5OKJM
         xnbXzFMcZGJIiGin0Xg7KlhhfOE1Rp+/sNWdScUa9+xzQtYLs4zwcYWXyXgjZFIbMdG+
         IDkFOykB4wvKx6c0/Ewcti0pugzPbpVTOn1tgy1PVyed7/7vmisYHtTUeOSAGTxWr2aH
         Rk6g==
X-Gm-Message-State: AC+VfDwiNHfvRaEK9bj4OEymRQrSU3EgbxyFhdyGjh6XeHIuArBg38jv
        JZWREQAZWG22QE7NGfEP/OE=
X-Google-Smtp-Source: ACHHUZ77PZ82sRQzvEdIZxultvsHQ4DY/ZFM8C3Zf0qhq0KQRqv5yb6o2P5+zG5poPVRrQgWdvvibw==
X-Received: by 2002:a2e:90cb:0:b0:2a8:ea22:28b5 with SMTP id o11-20020a2e90cb000000b002a8ea2228b5mr4959721ljg.4.1683057485153;
        Tue, 02 May 2023 12:58:05 -0700 (PDT)
Received: from [10.2.18.49] ([195.246.120.77])
        by smtp.gmail.com with ESMTPSA id a15-20020a2e860f000000b00293534d9757sm5499136lji.81.2023.05.02.12.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 12:58:04 -0700 (PDT)
Message-ID: <d0ff3e23-480b-4292-85fd-3af5f065ef33@gmail.com>
Date:   Tue, 2 May 2023 21:58:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/3] git config tests for "'git config ignores pairs
 ..."
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>
References: <20230418175034.982433-1-rybak.a.v@gmail.com>
 <20230423134649.431783-1-rybak.a.v@gmail.com> <xmqqy1m73e3o.fsf@gitster.g>
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <xmqqy1m73e3o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/05/2023 00:02, Junio C Hamano wrote:
> Andrei Rybak <rybak.a.v@gmail.com> writes:
> 
>> Clean up existing tests and add new tests in t1300-config.sh.
>>
>> v1 cover letter:
>>    https://lore.kernel.org/git/20230414081352.810296-1-rybak.a.v@gmail.com/
>> v2 cover letter:
>>    https://lore.kernel.org/git/20230418175034.982433-1-rybak.a.v@gmail.com/
> 
> This hasn't seen any further reactions.  Is everybody happy to see
> us declare victory and merge it down to 'next'?

I'm happy with this series, especially because new tests in patch 3/3 indirectly
address some of the concerns for unused files removal in t1300 in the original
series of this thread, "t: fix unused files, part 2".

   https://lore.kernel.org/git/230406.86pm8htnfk.gmgdl@evledraar.gmail.com/

> Thanks.

