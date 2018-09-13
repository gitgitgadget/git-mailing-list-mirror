Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CCFD1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 21:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeINDDU (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 23:03:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36071 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbeINDDU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 23:03:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so8285191wrt.3
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 14:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Yh8eFyFS0l0QG9p89y9VJGYoO0MsP3HZXxurNWrbWEQ=;
        b=Z2ssQiI0hzMzL0YrYrfhE5CUHWA8T1Z5kn2+nNRLe54GIbq3geeZTvraSixfTv2qWQ
         4VdOdAzLME785cFDe5Vap8EIwqaMpBksZ+Lwyi41rNbJYfOWKtKSkGkHpDiA40LT2QnE
         TP+wj5ePR+pZIjhCDTBGhzS4R7TT6lTGsN3acuzyUN8YeGwlkFpg7gtiEN57AuHLYLef
         SJgsnu955k3OTbD+86xENqSIse4zgWRv3wHpQ/RnWJS1ZC04gTauuojme5wyX8ucFQX7
         ybzE9vGNyTenS+NzcXXSLUyooNNvbc2JT2ZbHCocqpNY1HTYn/0JDGfrSZ0nNThXIBOw
         QsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Yh8eFyFS0l0QG9p89y9VJGYoO0MsP3HZXxurNWrbWEQ=;
        b=miL1VtCTb//lTkojO2mai/DKR0oYpQpTMTGMOwBj1x5t6mrUA5bHmBGXtczLJwxb/N
         Ngh38Ba6GRsyBq76r++WlPN6658pfqmWxjG3H8ss3pjn0vb4jHJ2PLIUVQKrdjnsgEEu
         jXjZ2Ny3RVZJx4PdG11hpMydeOTkx2gmC8Q30kvu9+FoDp6OfjhPrzg8j01Bt926QwRt
         bPG+gqYN0SbossBBOz53sxu5X3MWHvJGRf12F/IHrzoG7OisETK4D+bYQl5Ii5vUmbAX
         3oht51yMgiHpfeqfMIU6jb/qBlarMK5yioDflLvFymPUJIXH+dDQJJ2vU9ydWesRpmc3
         +i6g==
X-Gm-Message-State: APzg51AioXKvYR/4kt7qXTS6CVjp85AZUb+VebbnvLwALKApqmTg/Z1i
        A5betwo/BYcRia0aTTh80G4t/SFE
X-Google-Smtp-Source: ANB0VdZEwvdE2aUQX6z4pQ3165Bs/EPACSvRrKex/gq3Ldu7/DxxqYI8mrBw63N+xGN7nomFklQgMA==
X-Received: by 2002:adf:b357:: with SMTP id k23-v6mr7365367wrd.207.1536875517258;
        Thu, 13 Sep 2018 14:51:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q200-v6sm582856wmd.2.2018.09.13.14.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 14:51:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shulhan <m.shulhan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/remote: quote remote name on error to display empty name
References: <20180913131833.32722-1-m.shulhan@gmail.com>
Date:   Thu, 13 Sep 2018 14:51:56 -0700
In-Reply-To: <20180913131833.32722-1-m.shulhan@gmail.com> (Shulhan's message
        of "Thu, 13 Sep 2018 20:18:33 +0700")
Message-ID: <xmqqpnxhdq0z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shulhan <m.shulhan@gmail.com> writes:

> When adding new remote name with empty string, git will print the
> following error message,
>
>   fatal: '' is not a valid remote name\n
>
> But when removing remote name with empty string as input, git shows the
> empty string without quote,
>
>   fatal: No such remote: \n
>
> To make these error messages consistent, quote the name of the remote
> that we tried and failed to find.
>
> Signed-off-by: Shulhan <m.shulhan@gmail.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/remote.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Have you run "make test" with this change?  

I expect at least 5505.10 to fail without adjustment.
