Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1822C4332F
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 02:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLRCm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 21:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLRCmV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 21:42:21 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD81DF89
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 18:42:20 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r18so4106229pgr.12
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 18:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTgsEZDukmXlHAIS3ddjTPUPUmkupuWf2vVpriUqS9g=;
        b=OKHVZoxxQL2BFEUiCYhlYg0skHN690Um1DVhrT+dzjgNQYZtbKfsYH/dBMkxGwNDhV
         5MI/7DOpb7pCba1ioZD8+PV98nTKC1hz88BU9OTrJ3p1U1BJ42JNLBAv0afalaziohlr
         IpQ13cw3O+uS19PC4ppXDIP3qcz16VsUA6MJarTFD0/csqHW8kUGdEgmwFGMTV9tfItF
         Tu6IdPmfgMUqisQxf3waExZk4NT5Z3UfohKAnM6Ic//ZlcRWiMNK+XoJZiJFhkwzljmb
         pgrMLq16uSsIlSTOTx/EV3Ih5ODAPjNEpDnh1k8TOW9l5HqTIjCW8ux6YiP6rZ5DD45y
         b9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YTgsEZDukmXlHAIS3ddjTPUPUmkupuWf2vVpriUqS9g=;
        b=L/h9Ls5XY/uGp1QAPEY3nFQ6XsOQM+GalXpCMzif6dMpXdIK2Ed1slPVkH+zspJrmZ
         3IIVzJZL3xT7traaF68o/iMRawJqxu0rW9kbsRRiwgQ9N1SXfgPCjNhSmF38IlRLJStE
         cgSh9iojrS7z3ytucLrj7XL2hQ9JSGieP0Rf26d6ON91edq+CvJLdm6R1vfQoNSuo50t
         f+X0kCTPubLNqmOGVOc+Aa0i24GY2iGlUHf6+VE/EOrb7QbHSnesHz7lDivzmPlUossh
         dndFu/H6SR4XFkEdpHzsyg3PrMpC+oSqSEDwhDMtmdpHRuE6gMdaaVCEBEXjyRoWPRNh
         QFgQ==
X-Gm-Message-State: ANoB5plD1vF0cqTxD8A/oN1Vn3dn59idCUcGrn89ZNc82hzLi+2Uk8vY
        tMqK7UekIDvnMOfLCec0U3o=
X-Google-Smtp-Source: AA0mqf4rW1QzQAbZHkCepz4jiZgki4q7VNTuBy6cl4YiKzlyOuyF0VgWcYmnvrDoG2FojoCV5eyfPg==
X-Received: by 2002:a62:ce87:0:b0:577:3546:d7be with SMTP id y129-20020a62ce87000000b005773546d7bemr40428436pfg.30.1671331340158;
        Sat, 17 Dec 2022 18:42:20 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y184-20020a6264c1000000b00576d4d69909sm3809503pfb.8.2022.12.17.18.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 18:42:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] am: don't pass strvec to apply_parse_options()
References: <baf93e4a-7f05-857c-e551-09675496c03c@web.de>
        <221213.86mt7r4ru2.gmgdl@evledraar.gmail.com>
        <2d0d77a4-f6ac-1fa7-bddb-9083579d8dd7@web.de>
        <Y53DAoJ4eK01rEji@coredump.intra.peff.net>
        <91c5120d-bbd4-8aa5-a205-d1f5387a7f19@web.de>
        <Y546bgdvYIkfwTlv@coredump.intra.peff.net>
Date:   Sun, 18 Dec 2022 11:42:19 +0900
In-Reply-To: <Y546bgdvYIkfwTlv@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 17 Dec 2022 16:53:50 -0500")
Message-ID: <xmqqili9xwj8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Making a shallow copy to give to parse_options() in callers that currently
>> pass a strvec directly or indirectly seems like the simplest solution to
>> me for now.
>
> Yes, I thought your original patch actually got to the root of the
> problem. strvec owns the array and its elements, and parse-options wants
> to munge the array itself (but not the elements). Making a shallow copy
> is eliminates the conflict over ownership.

Yup, it did look very sensible to me.
