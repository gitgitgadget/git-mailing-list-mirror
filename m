Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBB2C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 07:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614DD610E7
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 07:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhDBHDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 03:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhDBHDa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 03:03:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D67EC0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 00:03:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so2180244pjg.5
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=rdOoVGCSjmGkLkyrPTNLAZSmWKDnN4vTMpXocyttuvE=;
        b=YtnJqcNAtdpBcB4ZyXV76bkIC6xRWRFyeUDOMuDIsEIbj2rUSWeIp+CqTOEu5kzXdd
         DWQwO8c8R0qbrGWrjXsS2jo4RtnurCMM75RqxzspDsppDaruz9331vlADuSVjoehyNd6
         Cgp4Gl9tpEcholji0RNFufoPeXUqtC9uNyqaOVwelCwm7Krt3Uu4DkYSvGkBdYMF8oge
         e64ySZjbX9Lg339k9M9ZugBmUtqZOEAJfwYUm3GWw9acLu/y7vKVk3lUp3v3zR57PCac
         KS53hdFJh3+WQG5P/r4oZEv8F+6kbe42NWOlbSzOt2q2DlQeMipRPaa5pIhXK/gWTvqj
         4MCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rdOoVGCSjmGkLkyrPTNLAZSmWKDnN4vTMpXocyttuvE=;
        b=FDhvZ9qig+2aCpF5PsuH3WaAkuyr00Z9kssgLOLZ2pMYj3l9k3ZGiI4BV/6YNQX7nh
         G4SnuJaitKjG3MV2t4hSQSymcPh1isey/fCoPzNcUahqPXgyrPdoyIX8IWhxBO0GI5oP
         agL4Bcf+BH42ccgItAdVYDBcPYvYpLIVzObZeIcoGE26OzCO1+ZgRLICHEDdlkQDC2t+
         RxV8fQiHLCx1g0EtaAH3iMliHXNaaIjltGdw+sCVuM7VqRduXWnnEKLBXp321feinY6y
         jO89m7RErHCMYGKxQPJF8CRjaTCbwdTHcaMw6p6UI8GnvwR/9MA49yrq92XONrFUSk+J
         nKiQ==
X-Gm-Message-State: AOAM532ARH9Z85FpsDEt494EHVu2lLPRxTq0IkJA8HJLUC8HHndhVgBp
        8NQN/Vo5h6JNd73KtJUoWK4S+B/wzZYVKg==
X-Google-Smtp-Source: ABdhPJy+ZUZ2AiQx1KrXV1oXUm354rlMTLrsH8BqCwtrwOzsaCXtLiHntYh28f0rmUyM0fh5un4Jxw==
X-Received: by 2002:a17:902:e549:b029:e6:6b3a:49f7 with SMTP id n9-20020a170902e549b02900e66b3a49f7mr11954067plf.52.1617347009104;
        Fri, 02 Apr 2021 00:03:29 -0700 (PDT)
Received: from [192.168.10.22] ([125.21.249.98])
        by smtp.gmail.com with ESMTPSA id t22sm7049987pjo.45.2021.04.02.00.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 00:03:28 -0700 (PDT)
Subject: Re: [GSoC] Draft Proposal (Convert submodule to builtin)
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
References: <195bf718-6226-43c9-8c58-167388d3d99b@gmail.com>
 <f5b9ea24-e2f7-6c54-b4ff-86cef27527f7@gmail.com>
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Message-ID: <ecedddea-2f9e-3daa-80e6-981b86e5267c@gmail.com>
Date:   Fri, 2 Apr 2021 12:34:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <f5b9ea24-e2f7-6c54-b4ff-86cef27527f7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 4/2/21 11:02 AM, Bagas Sanjaya wrote:
> Looking from your proposal, you seems like you're using Kali Linux as
> daily driver. Why do you do that?

Well I've tried various Linux distros (including ubuntu, mint). I have been

using Kali linux for 4 years now, and at this point of time it's rather just

a personal preference. I am interested in pen testing too as a general

hobby, so I need the tool-set provided by Kali every once in a while :).


> I know these helper functions will be required for porting 
> `git-submodule.sh`
> and used by `module_add()`, but do you have any justification for these?

All the functions listed above was based on the previous work and 
discussions.

I read through all the versions of the patches and studied the issues faced

and then structured a proper skeleton of the design. You may follow the

previous work through :

https://lore.kernel.org/git/20201214231939.644175-1-periperidip@gmail.com/


> Anyway, I copy-pasted the quotation above from your proposal in PDF 
> format.
> but when I pasted it into text-only mail, it looks rather ugly.
> So next time when sending GSoC proposal for Git, I would like to see
> proposals in Markdown format (as well as PDF) for the reason above.
>
> Thanks.

Sure I'll do that :). Thanks for the review.


Regards,

Chinmoy Chakraborty.

