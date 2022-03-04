Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E10AC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 05:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiCDFRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 00:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiCDFRY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 00:17:24 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75981793A2
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 21:16:37 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id k7so5736800ilo.8
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 21:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=+xC8RFb5R+2vEzHaGM+cIz9NgDyAKodJAKQAd1VIx2M=;
        b=iYOlXGazHAm9AHqdYS/+1MJ/1vc/of5m+zggxoFEqWrZrA0KCsj18PJEBTPNdR0pn3
         xuAabAKT2LEDkDZDecsHv4NIMuC+qa87swwbBhtI6+4rHqiF8h3q2u9DxIwVSiyPR4O3
         793Cg4Y7X27lAeqm8shewjvi4Er5bQBuHZ8IUD5wzNXBUrLz5faxdxtjwvXxENy7usB/
         E4qGW8uQZgLILJqHWDDjcbzHcT2BNGQd2ejr/VNbLJczOr4A4WIq5os1WGNHwpXmbOTj
         IrDboyCL3Hm5oUxrGCQXxqtA7eUlu3E+ZZ7k3X3MAh/ax0FQ5G32si9GYDMRpPiguaDi
         vGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=+xC8RFb5R+2vEzHaGM+cIz9NgDyAKodJAKQAd1VIx2M=;
        b=vj2l3M59ajxpsR1oj43ABQwgeELTgKzGVYsn4DSMzmibyREnkvFXz+GFxR7s5IfMFY
         OG7yRbVK0BsE5sQhnK94D7dBM1TLcpXtDIHET0Ilk/+syPLhugGaEDAujwEIglWrQ+a1
         xwQVSUVcAir0SXCVRXtVl/YR/WZVjcm+0h8OZbFGbCW88EzSFcrRASdbgkceGf2qkOnO
         mfeUPaYTd0/1ggc29MwtiTKQWl/Ky2q/asE8zO0hiU6u949V+kx0Q6WMZjHltLZGrvCc
         BbbgKytnQljogYEFsgHNuq3CcMUKv62pEkdTNfLv4TfksCBQG0JstLk3pQ7MIt3FY4zk
         ZAUA==
X-Gm-Message-State: AOAM5303qaN5kppsYcwOvNqlNu/SuFO6oDlQSO98yOKt9OyqDo7a4ORq
        H2fevRJW8Vme5JIwl7JT4FvCbjUN5v8bFg==
X-Google-Smtp-Source: ABdhPJw+GvcFR87t/PEPZUddTSRjscW7Z/XOVFkjTna7FqJHw/aMGd8afRPVRedY9uaEFR+bnHS+cw==
X-Received: by 2002:a05:6e02:1547:b0:2c1:e881:47b6 with SMTP id j7-20020a056e02154700b002c1e88147b6mr34019233ilu.105.1646370996788;
        Thu, 03 Mar 2022 21:16:36 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:5194:c9b1:2d1f:598e? ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d97c5000000b006412c791f90sm3527873ios.31.2022.03.03.21.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 21:16:36 -0800 (PST)
Message-ID: <d38d18f5-f430-1f66-dff8-92b4a349b165@gmail.com>
Date:   Fri, 4 Mar 2022 10:46:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add builtin diff driver for Kotlin language.
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220303181517.70682-1-jaydeepjd.8914@gmail.com>
 <xmqqee3i4eso.fsf@gitster.g>
In-Reply-To: <xmqqee3i4eso.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/4/22 8:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jaydeep P Das <jaydeepjd.8914@gmail.com> writes:
> 
> > Subject: Re: [PATCH] userdiff: add builtin diff driver for Kotlin language.
> 
> "git format-patch --help" and look for "-v <n>", perhaps.  This is
> the fourth iteration, so [PATCH v4], I guess?
> 


Yes. I think I forgot to fill in the subject so it was sent with the default.
I didn't know format-patch allows to specify version numbers. I will check it out.
Also, In the next patch, should I do it as v4 or v5?

Thanks,
Jaydeep




