Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AEFC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AF8613B9
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFQH3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 03:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhFQH3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 03:29:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B526AC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:27:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c7so1648491edn.6
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=heEFOKLA0p9UedoJTBucCX86HTeixzsvQiKnEghYqQY=;
        b=tp2tBtto3NDxbPsXM2gzp/vSuaDmFBWmjgKl0woWSY1u1D+3a80NKO9V/DHQUT8Eop
         q2lfqbgO1NnfK8QmRw/oxj0BNK2hmdpCTGnFTYK7LLQYvBbAdxQ7BQnijLNSHwrRjRSL
         R0IqgqeKG69u/pDaqYF0zYW7j3pTJjDKz+m2xRcL5MPeV42Th+NwJ43gr+c10lm/WhoF
         +orL1tE1OM+M4SPQTHgB+xfZt41RPxCbrGNzJQ+98gJ97/Wh7bZrBdEe6fsUXk0whdsD
         7bVlykhqLaCTcGfLmQbVMxIFmiWt4H25EwSlaKDOb80AizYUAbhGnlWs7nfk2j/p3dW0
         bHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=heEFOKLA0p9UedoJTBucCX86HTeixzsvQiKnEghYqQY=;
        b=mYRovoBszuIE9E/QjWQ8EZKtgfA3RcUAV49oZs197/3T2BPvN55SpTkEmfTCtI+HPA
         0NaAVBL1i0ixQjI21FmWfaDATKdLR/D1w5xvdCuVFK0AnyVeUhcehlXw1Wuv6NRcD07I
         y6d/fUlObSMGNrKM0uDcixXFrtQxdxgv1Ekda6AQRQ81qZ8z7PuFe1N55Ou3okZCe6Xn
         pERhBH11wjxHMd4VwMqMA+0TTRB7k9pCdFDLJgWsVy5Bx78UONGu4NkdmUW36OecCop6
         EgYm3pDFAqa1zIU8yJQPKjscM6p9xAmwRSygAEYBeOSXjjhBl9D9HVjGLJviJLdRR/Ao
         EgaA==
X-Gm-Message-State: AOAM5301BZg7yMX4aHPTpZr0S8GoMf/Y9Kj+GlNarLRL8pU2asvnHpeI
        NzpqM/ipUwZ8nIVhprHGMtI2GwM/hjvKsw==
X-Google-Smtp-Source: ABdhPJwij26C6+lhGqGcglMS35jhxwwcZlNZCoh3+2Kup0fesXpJuMunLN1/RGfQTFKO+9soupnk0w==
X-Received: by 2002:a05:6402:4311:: with SMTP id m17mr4595160edc.372.1623914836122;
        Thu, 17 Jun 2021 00:27:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z19sm3504667edc.90.2021.06.17.00.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 00:27:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 0/9] [GSOC][RFC] cat-file: reuse ref-filter logic
Date:   Thu, 17 Jun 2021 09:26:17 +0200
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
Message-ID: <87tulxvtm4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 15 2021, ZheNing Hu via GitGitGadget wrote:

> This patch series make cat-file reuse ref-filter logic, which based on
> 5a5b5f78 ([GSOC] ref-filter: add %(rest) atom)
>
> Change from last version:
>
>  1. Use free_array_item_internal() to solve the memory leak problem.
>  2. Change commit message of ([GSOC] ref-filter: teach get_object() return
>     useful value).

I left some comments, but saw after the fact that I'd replied to the v1
E-Mails by accident, but anyway, the comments were all on things that
are also in v2, so it worked out in the end. Sorry about the confusion.
