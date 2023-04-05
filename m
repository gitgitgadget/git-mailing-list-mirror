Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279F4C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 22:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjDEWr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 18:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDEWrz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 18:47:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2609419BD
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 15:47:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f22so31692962plr.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680734871;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ4ytY4+IhuK/Z+2/exqSivdEcnmeiGN0BUnZ+42r1g=;
        b=PtjAh8Dqvv64x9yIcWuMP5fWyflukmppN/2BA821S3pdouI80Edzu9stTAwGd5rLiO
         oZDeb+wyvBPX+4bELhdGvAfF9f7W6nAXAcxRaGtZ98De1R8PGsoYw34eb8izEKHcqPMT
         y+AkIZDXnTGutx8QbVn3EWUZeKxDpZiqpR6pwWWpsBvOdS2NOUhanLUTzYI/flm6OrVj
         SThDqQ2KnKE36OUG/YaxtJr0aMPnIqGlQadAx3ka10XJ0rOe7OzKW+dpGpvPRRXH7BvG
         N847dC2orbicgxRhqQsTkEA2MPjRuzaIapupNQQUT1GUuzb4ZIUTskP15yFI6QJuFJPi
         BOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680734871;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJ4ytY4+IhuK/Z+2/exqSivdEcnmeiGN0BUnZ+42r1g=;
        b=SXPfg86GYepMGB2rrMl85F7u9uPcEsU4Tcb30t0/fy233ilZwseIMCQ2kxSPktQJLW
         TmVFLR6z4hvHGMCcrNDfKw0ciSoFJJPZgY5z+B+w32Oqu80CmMFxKne+v94JEgd+YhZ1
         QlPjBeVoJRI/ekkJbPDwTlwrO00WscBczSVK8iicLpAdFAXlx+LcWxKUeNBRdDY+iEwU
         BuUJ7RN2JieKmsOhLl6A3TSQm7iPY3qJ4p5jt9Cu1PcxuKud2KVel8T+IeVihZtIto5h
         MdvCUv7EHbyzLhmEuiO1HF0slz91L9RnM3pLpm52Pr9wkY1/qSi2sLigDN0UpEZdX7q7
         pXOg==
X-Gm-Message-State: AAQBX9dNPwmLaQN6ElOZ/snnHxwhL2uUbAhSPeBdH5XnjekdUcmRapkA
        tGXzuZcOHDB224I9ItchyPk=
X-Google-Smtp-Source: AKy350Z0E1Rr/+ax3vNG5/fhs8l1Z0aHU1xV7OPU6oCyUbAa2LNUM4Pps2VyHjFaSnNmZiTh3+6dig==
X-Received: by 2002:a17:90a:b907:b0:23d:980:e2 with SMTP id p7-20020a17090ab90700b0023d098000e2mr8925743pjr.6.1680734871454;
        Wed, 05 Apr 2023 15:47:51 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id 72-20020a63014b000000b004fab4455748sm9992925pgb.75.2023.04.05.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 15:47:50 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2023, #01; Tue, 4)
References: <xmqqzg7nw5gq.fsf@gitster.g>
        <CAMP44s1ePrbxQc3KzU8A2Z-ZMXTaJHyt5hh9JsY337kd=OvOCw@mail.gmail.com>
Date:   Wed, 05 Apr 2023 15:47:50 -0700
Message-ID: <xmqqa5zmrlnt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Any reason why this patch to remove a workaround only needed for ~2005
> software wasn't picked?
>
> https://lore.kernel.org/git/20230322000815.132128-1-felipe.contreras@gmail.com/

I did not pick it up because I did not see it.  It seems Todd gave
an ack on it---I will queue it and merge it to 'next' soonish.

Thanks for a ping.  
