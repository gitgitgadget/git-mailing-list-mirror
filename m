Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C05C636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA076113D
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhGQR4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 13:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhGQR4R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 13:56:17 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203DDC061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 10:53:21 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u11so15129365oiv.1
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=7F7y+r1oSOVst2gX3wpf42j3mqf4U64GiPAnuOye7oQ=;
        b=b1vt7XyUvtPS4RSul1pE9/drhpkxEM9mN8HGapi3+9eCWDKZ7iZoCwNfEEqPtBy28z
         6WLlWnOtoHKTTHEqug3dgfxXTV+WGWHQh6k/wqJ891qk+IrJxLI2djz1b8uSTVMR3AaR
         +pwLk0D9pgtROeM3zk1/5wvwjoUpc+maAIjyLDgxkR7dPtxgX/6qTYxE1Md6c9aRDHek
         Pb1x5akgx/eNJqnu90T+m/M6kzftWNMiHbDotial5O60WwE2whetbu+Q4HLWsuONDoRe
         d9t/mmYgDTzcfNnFa6Q7rQSYH3gu1y5LrrHie16Oc6PqX3BMl5cbIDq9YDi0XCrjbicj
         jTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=7F7y+r1oSOVst2gX3wpf42j3mqf4U64GiPAnuOye7oQ=;
        b=aYUuUY62PSXVlmV9AIDMPyaWCz9G/5vDdUIdRBksP6lBMisUz6IYcYHVMtDwhxzIGi
         5kS0gZx8mrxx9ELMkM0wEVjJK+XxPrq8gSPwG+9npIcZitkMv5rDmasjkzfLPSBrYV7X
         jP8irTHVUITZ7Bo3VpLeRiWpDyCcp19pu+CtxDeZUOdZPCv+opDP7kG4mhWAoOcIdOwa
         24V4RYLEl4OCFwyui53Ni92MGCMNqsO82bcdgzLOUrKqBxnQsfloGIt9dEJcbsX2hnCL
         LnvfjyhmDlD0RICMMdZs36rXhB16FS/Gv4CrtNaM7tzeEYtkuPZPQq1tApcrq9PPDxGM
         ZDIQ==
X-Gm-Message-State: AOAM532WxIxjJ2x3ytyHSGJ15Jfy8ojIyHjHHr/Rtr/MlXkBCRJHbWVg
        Hp4EPe/Y+BgL41JaMDTTo4A=
X-Google-Smtp-Source: ABdhPJwY1vAvxhFtvehERTLUhVCF21To8WL0BpJ01orr3Dq8aXz2dNUsao/aG7Sy6mMhy4raZ2pJxg==
X-Received: by 2002:aca:5b82:: with SMTP id p124mr7609750oib.73.1626544400533;
        Sat, 17 Jul 2021 10:53:20 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id n14sm2724809ota.57.2021.07.17.10.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 10:53:20 -0700 (PDT)
Date:   Sat, 17 Jul 2021 12:53:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Message-ID: <60f3190eaba81_25f220843@natae.notmuch>
In-Reply-To: <c015e599-0178-cc3d-11be-175dc917f2b9@gmail.com>
References: <60f1daa896f69_330208b1@natae.notmuch>
 <c015e599-0178-cc3d-11be-175dc917f2b9@gmail.com>
Subject: Re: When are you going to stop ignoring pull.mode?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 17/07/21 02.14, Felipe Contreras wrote:
> > The solution is simple and self-documenting:
> > 
> >    pull.mode={fast-forward,merge,rebase}
> > 
> 
> But how about config transition from pull.{ff,rebase} to pull.mode?

I have already discussed how the transition would look like, and it's
pretty straightforward [1].

Additionally I already implemented the patch that does the mapping [2].

[1] https://lore.kernel.org/git/5fd8b1d5d4d7c_190cd7208b@natae.notmuch/
[2] https://lore.kernel.org/git/20210705123209.1808663-27-felipe.contreras@gmail.com/

-- 
Felipe Contreras
