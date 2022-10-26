Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AC0C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 16:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiJZQzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 12:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiJZQzD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 12:55:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0D15FFF
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 09:55:02 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i3so15897750pfc.11
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzibGMmDVPB6HoOZTUQmxvTU5yAbOV7KP3G1SFR3+Gk=;
        b=CAT9eC3NP8AdMleisum8tyVgauidbRH9EhJozWOv6OCbXwLfPcnwiyYRvBHtwaHAm8
         ZborwhwNCnj0jzh+c6AUym+cLT7zeWFikMhBKe1OkYVtSJp96z0bXxjXSiop4TOX/EeA
         1vFtRfsTqh5bIGKVeYzxOc3AQtk1mG99fXvbLxsTBjfaySNfm11x1vh8ob+WLND9y4xK
         xMGF87K8gxDf3nF5JYzoGTJ5fh0vdWmOvPFHhovRPy0n1dgqc9ifOep2HahQCr56NMc7
         yB3kClMEjxAb4Kma9aXNN+tJ6q9JCtb/GPUR9yhAxZLHd9ALp6tHbTs1k+47J3+/GZBe
         VDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kzibGMmDVPB6HoOZTUQmxvTU5yAbOV7KP3G1SFR3+Gk=;
        b=bZiIXusHIHEMMvN1XBCHcGj7kDE5Z/lIHCjVIUHJZfJ1U6PmkutztS+Q/s3qkp6oal
         mcm9J4lLLUOVXiIgdw58Ef1giPnZL6P//mfcWA24dBEnp2+T3S2trJUwHdQAs9MwfM0D
         eQjVog1uXBWq53v4UVFv/QEfzoYTFzmEM5IW8MxIyRrCVm4/Meq8uaajBLafUX3bp3+t
         GL49noi4qeumHXUws7ngIucHcbgS96yBlSa8Ta9twtBsBpHLc/ZvkawTBYg1oGseg5/R
         nDFuiwQRiChtTUz0pvpIRbvaMnv4kGoIuLUXoPnz2M0W2qNa5pW0MX4p9wn6wuEUyxZK
         9v8g==
X-Gm-Message-State: ACrzQf198AOIC1Y8fekhweXRcXgiAcy3MOaVanHXEgxpRZvpByTOkBqP
        hiswpgz1Dw2uuSyraKDJizw=
X-Google-Smtp-Source: AMsMyM6ncdduND6WouLv3922d9qy2PeBgSIUkAZXOle15vChHgBtvYxQ14ucsL4Ns0ObHh5ly8+1Rg==
X-Received: by 2002:a63:91:0:b0:461:f509:2a31 with SMTP id 139-20020a630091000000b00461f5092a31mr37728142pga.108.1666803301429;
        Wed, 26 Oct 2022 09:55:01 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b0018699e6afd8sm3127476plf.265.2022.10.26.09.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 09:55:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v4 3/8] rebase --merge: fix reflog when continuing
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
        <2c965f4b97c1773abc6b844b87fa64c5d6d1524c.1666344108.git.gitgitgadget@gmail.com>
        <xmqqk04tm62o.fsf@gitster.g>
        <86699708-d631-fb49-482c-af27204a3570@dunelm.org.uk>
        <xmqqczafopc0.fsf@gitster.g>
        <8af26af0-548d-52c8-9752-1a265af8fd54@dunelm.org.uk>
Date:   Wed, 26 Oct 2022 09:55:00 -0700
In-Reply-To: <8af26af0-548d-52c8-9752-1a265af8fd54@dunelm.org.uk> (Phillip
        Wood's message of "Wed, 26 Oct 2022 16:17:13 +0100")
Message-ID: <xmqq7d0mikyj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio
>
> On 25/10/2022 17:11, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>>>> Both of these will be fixed in a future series that
>>>>> stops the sequencer calling setenv().
>>>> If it gets fixed in a future step in the same series, that is a
>>>> different matter, but if it is easy enough not to deliberately
>>>> introduce a new leak, we'd prefer to do so.
>>>
>>> It's a couple of patches to fix which are more or less finished, I'm
>>> planning to send them once this series is in next.
>> So we will do the "add a known breakage of the same kind as there
>> exists others, and then later fix them all up, including the one
>> that is added by this series, because fixes are non-trivial and this
>> topic is easier to finish if we allowed to add a known breakage"
>> approach?  Just making sure it is what you plan to do.
>
> Yes, that's right

OK, I do not mind as long as we leave a NEEDSWORK note to tell
others that we know the leak and promise to fix it soon (so they do
not waste their effort to fix it independently).

Thanks.
