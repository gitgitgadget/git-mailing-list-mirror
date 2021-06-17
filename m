Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD26C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 02:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1273610EA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 02:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhFQCIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 22:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhFQCIt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 22:08:49 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AB1C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 19:06:42 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so4610433ott.1
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 19:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=dUEfaJ0D6nZtztKPCIni3x/9pPEDrU4kBMdk20iFULQ=;
        b=kxSwxdCwhCT/TVjErswY/dWf2S7r33rtSvT+CXVcYPMFvLNGGOrry/W0evWL+uTfvJ
         ncZxAqQzbt67v+fmBKmGPw0FRPWpPhkMFcdO8f3XE2moxGD36D9McuuBZSgfZaZyBOM6
         cm5QowaWXdh3RsI1lbLB3nzK/Iawn+hR4phHyZur4DF1XLsN0E3WVF2+hC6XpcRTn/F7
         CWdAf4JIe/jlDCdAVqbsmE4xmUbtyFB214ixJFN1hgrixxb5IgSULIMOJaRVWLpVFQsQ
         gYSRQepKWvDkHX6+r4GA2nW5SUJolymaunLq9NK9q/ZdBml2vAjB/Hi0nyx3mwdrUBvA
         Cw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=dUEfaJ0D6nZtztKPCIni3x/9pPEDrU4kBMdk20iFULQ=;
        b=qMllrbryGUw8aRu0WdQ4P4FpX7pUFXmlLKVc6Z01A9MuFzdTFk2KTii2BRQ89P4B7/
         4YIydqsTAw6fcf0QqopGYNG70O9tcPL+qbrt6OWcybyN+NBTaWET7hii+jRZM5f73Wjx
         R2ZHRDjGyJbFweKrZqWzzXa1xfC4O642Nqhz1Wg8PKggS+4yqq+lYbH9aj9DEuhO8tpC
         NaoKmyH+s+WkRk9408Ay9mD8mmhw0S/pXBmRaxecibDaCTJmqbnD4n05xO/aHLOUFUGS
         zhKS1sI0tr1qMsB0O5gyJp36p52UGeO8ow4LmT8gDaNqxbbR+D0d4Rgy5s0xzs/b4VOF
         I5Ow==
X-Gm-Message-State: AOAM5314cfY7I3lcYWR9fg5umB8JuVLMgHnb5AhrnWqfdTwCjm//cXcJ
        PfOKWHs9nbCOr584gytYUck=
X-Google-Smtp-Source: ABdhPJxw1qTVNDSLSZ3FFDbg5jfkWjlvP3LdAOdBxjZ2tHmOeZCOBdYpdlfBsl0DPSXC67FBmczjjg==
X-Received: by 2002:a9d:7acc:: with SMTP id m12mr2429793otn.27.1623895601324;
        Wed, 16 Jun 2021 19:06:41 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id r14sm815919oie.43.2021.06.16.19.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 19:06:40 -0700 (PDT)
Date:   Wed, 16 Jun 2021 21:06:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Harrison McCullough <mccullough.harrison@gmail.com>,
        git@vger.kernel.org
Message-ID: <60caae2f893ec_894e2085d@natae.notmuch>
In-Reply-To: <CAHLeu+y3DxLv7M4SM2f5yVxtKXbpAWD7Ad2m+rVKpKfKiA6PVw@mail.gmail.com>
References: <CAHLeu+y3DxLv7M4SM2f5yVxtKXbpAWD7Ad2m+rVKpKfKiA6PVw@mail.gmail.com>
Subject: RE: Error in bash completion
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Harrison McCullough wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> 1. Create a Bash function, e.g. `ga() { git add "${@:-.}"; }`
> 2. Use the `__git_complete` function to add Bash tab completion for your custom
>    Bash function, e.g. `__git_complete ga git_add`
> 3. Attempt to tab complete a file path, e.g. `ga my-incomplete-file-path<TAB>`

I can reproduce this issue; it's caused by 59d85a2a05
(git-completion.bash: use $__git_cmd_idx in more places, 2021-04-22)
which is present in v2.32.

The problem is that __git_find_on_cmdline now relies on __git_cmd_idx,
which is not defined when you do __git_complete.

The solution is to add __git_cmd_idx=1 to __git_func_wrap.

zsh is also broken by the same change, and the fix is to do the same in
the _git service.

I've fixed this in git-completion's master branch [1].

You are welcome to trying the fix.

Cheers.

[1] https://github.com/felipec/git-completion/commit/95b3b49
[2] https://github.com/git/git/commit/59d85a2a05

-- 
Felipe Contreras
