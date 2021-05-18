Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B83DC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6A861028
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbhERMTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 08:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbhERMTA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 08:19:00 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2C8C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 05:17:41 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i9so13785041lfe.13
        for <git@vger.kernel.org>; Tue, 18 May 2021 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MDSwTa4zfPzURAcGooyfoqlFk+c3C0UPjMZkCt7Lp0E=;
        b=Mo08Igq0xl6LBqb+OPsA6TxZtlyDn8PvliaRNO3WBPZc5vVE0gtqtm4roDCmWbqAvF
         1/lXuNtKJ3T+zNX8ewolKTl4KpoOXp3sn6thWfjcCIAWh6fu2/CX+0842vx1nyJNulrp
         wjwFtH1tpuFF769ZljZyr0bTbvDJEdukwri1uq9N2NaooK4O6BYnrkvKcfyffu5jpZ8X
         ZKaK3ZDn89czAKbDsjxDsNsvBKaU9B/Je7MTT/YUbnjUANsLEYbnWy3yenGdhOUnkku0
         Y0dAgKWmeIdyg3KJGsVas8s2c+6QWKIPqUv6SpLYg3vCkLRt+o+kvFERfl0n6vRSOiQa
         LDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=MDSwTa4zfPzURAcGooyfoqlFk+c3C0UPjMZkCt7Lp0E=;
        b=QR/Uk2LMeE5LdunRWcSVo7NZqfc7LkCxrwToECC3vw6aNvR/DcC2Uh0+ChdjODww0n
         otNAAwZy0zZrCRWm0u4mPVyc/AVUpE4wtCMkp1ZDwkoV5HF9Ap7tBosjBjgG9GEKpPzN
         sHaBDbDjfgsB7r79r/Qm3voEfC4u8rw8XINjGFcmGRq/f62ek0Q3TcuAx42/Dez+jNRx
         XIoXqokDpZaCdmToo2J2lpAnfmPLIDSK+oM8s+Blly1jtRWr3OYopdiMh45Ei8C6R5+I
         HZWlc2H0Mz/C1Rpl9eNw//h4aIN7KJD/I8GR8bnIeGd/U21jh16afvrUSxHQOqYVsoke
         tFLg==
X-Gm-Message-State: AOAM531++rGsRbL8tMk2HNAP63AmzjwpE4X0/3cj5ZgHMy7dxaaA1Gkx
        HKlj6t5/F2Ter7hykoL34JCG1GEJN/I=
X-Google-Smtp-Source: ABdhPJwr4qyp8in/SeJi/QrECBXY9JGgfxMS/g8Fd2atz734eAU2y5Utth11umSegRA74PhkwCeBeg==
X-Received: by 2002:a05:6512:2315:: with SMTP id o21mr4127821lfu.227.1621340260005;
        Tue, 18 May 2021 05:17:40 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y19sm3293484ljj.125.2021.05.18.05.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:17:39 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 0/9] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210517155818.32224-1-sorganov@gmail.com>
        <321ca7e8-0ccb-20dd-e2de-2f3c2845e515@gmail.com>
Date:   Tue, 18 May 2021 15:17:38 +0300
In-Reply-To: <321ca7e8-0ccb-20dd-e2de-2f3c2845e515@gmail.com> (Bagas Sanjaya's
        message of "Tue, 18 May 2021 10:18:17 +0700")
Message-ID: <87a6osb5i5.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:


[...]

>> Exact historical semantics of -m is still provided by
>> --diff-merges=separate.
>> 
>
> Better say "Previously, the -m semantics is same as
> --diff-merges=separate".

Oops, unlike the rest of your suggestions, this one I don't get, sorry.

Thanks,

-- Sergey Organov
