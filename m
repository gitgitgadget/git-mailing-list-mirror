Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BB2C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 16:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BFEA6115B
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 16:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhGMQFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 12:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhGMQFB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 12:05:01 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD6CC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 09:02:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q16so14930266oiw.6
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=eaeSMDvBqy4CpN9toKV5GxXpSTr/Uim6uRtkFYoUAco=;
        b=DWOPaVKCYLsKcz5b/B3Y8o53XCdjiefOecf5p08ZEcKuCYHBkxtD4/wg16LuriwcP1
         CdxJ0A27/e0jRrDjBrI9p2F+5X+Ce7V56o/RVbYJipO3W6uJ6QrK6FitlATQsq0U3GKy
         LzanRZn+Yz9NrmraMnnzkqOpMeuLAU7Lr7JV+vmQbDU4x8/Y+b2Wuz5+tSTFu7PXZLVq
         Yh9JWr4ShgHpHdbWnPhsci4COlkw50c5tk4K4giaOfqoFA71KsDMO2gdvewgTNS6RrYR
         KlF0W9ymMZqOCQ6w1YMhzSQNKobTYP9W6VuM5zNCmqFjfEBFRrO2unIOsVscYlI1/hFv
         sJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=eaeSMDvBqy4CpN9toKV5GxXpSTr/Uim6uRtkFYoUAco=;
        b=t8SXavwor0UNWL9IxIPf14sj330Tq3MVe1PttdInCjirZcwTdkygkABxB+MJz0Z/RN
         rBS5FrMgaM8ic4o2Tdyguj+E9LgCftgnRjdCPCpD+mOQw6XtAE4HgBQmeM/fW/vvc8E6
         zucYmPirSQtQ4G0ki/rLwbkfNSnQqq3JY+PudCQ/3grrc/GnnM7gD4wH8t6+1JL51Sr0
         cEf4SF5RTmGZL9yZy7zKB6KX//nGwUVbaISv7COB/6eWcEJfd8whZTurpLZpI4iLEy2q
         wYLnGb+7bKD9frUFtPNCijau/j9uJZd29umu6XgY5EqlIEmmTuVfd7k9pIaQl5ye6Dzh
         3CQA==
X-Gm-Message-State: AOAM5337o8ES02cowyJwqzYdlP1cQetjQY5EAWNexwzx4E9P0HY4z79H
        Q1tGQrPtW9pxfNRuDVgNhNI=
X-Google-Smtp-Source: ABdhPJwc4OiBQe9JY/gZOdaMUc8xGJDZ+6+xoELwfpXZEQXqCifm5TOuBqdK584r2JQ5Funjtyg6Eg==
X-Received: by 2002:aca:5a04:: with SMTP id o4mr3682880oib.33.1626192130127;
        Tue, 13 Jul 2021 09:02:10 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id o25sm3346245ood.20.2021.07.13.09.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 09:02:08 -0700 (PDT)
Date:   Tue, 13 Jul 2021 11:02:07 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Message-ID: <60edb8ff814cf_ab6dd208d9@natae.notmuch>
In-Reply-To: <d3678ef6-1bcd-2666-87dc-751aef2ca1a7@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
 <60e9f8d462bd9_7ef20898@natae.notmuch>
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
 <60ea07e3495e8_7ef2081d@natae.notmuch>
 <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
 <60ea2eb562f26_2a69208e8@natae.notmuch>
 <1e18c4ed-6975-5041-4b4f-75c4d3d21860@mfriebe.de>
 <60ec6d91deced_a452520825@natae.notmuch>
 <54644739-2138-8086-1696-d3c52960216c@mfriebe.de>
 <60ec74c513b2b_a45252081b@natae.notmuch>
 <0d7bd249-2aba-236a-9f93-3a5b30182d15@mfriebe.de>
 <60ec93155663f_a231f208fb@natae.notmuch>
 <3a84e4c9-4e48-1cbe-4fe6-150ff56c8508@mfriebe.de>
 <60ecbe577a086_a6b702082@natae.notmuch>
 <d3678ef6-1bcd-2666-87dc-751aef2ca1a7@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 13/07/2021 00:12, Felipe Contreras wrote:
> > Martin wrote:
> > A user that does:
> > 
> >    git switch -n <branch>
> > 
> > Would naturally expect a new branch to be created.
> > 
> > If that command creates a new branch safely, why would the user do:
> > 
> >    git switch -N <branch>
> > 
> > What do you think the user expects to happen without reading the
> > documenation?
> 
> Well, first of all what would he think it does if he reads the doc? And 
> if that doc looses no (explicit) word on the possible loss?
> 
> First of all (not sure, if I mentioned that before), I have seen *many* 
> case like that:
> The user wants to create a new branch on master "my-feature".
>     git switch -c my-feature
> Then he realizes that he had not been on master, but on some other 
> branch. "-c" now gives an error.
> So the  user reads the documentation.
> Up to this point, everything is exactly as it should be.
> Now what the user reads is that "-C" works if the branch already exists. 
> At this point, without being prompted those user will not think of any 
> content of the branch (they haven't even added some).
> "-C" does in that case what they want.
> 
> Of course now, that they had no need to think about any commits, an no 
> warning that would have prompted that, they believe "-C" to be save.

Why would they think -C "saves"? And save how?

> > And what do you think they'll expect to happen given this documentation:
> > 
> >    Create a new branch like '--new', but if the branch already exists
> >    it's replaced.
> > 
> > Forget about what they could misunderstand. Nobody does anything without
> > a reason, so what would be the reason why a user does `git switch -N`
> > instead of `git switch -n`?
> 
> You and I will make the connection between "something happens to the 
> branch" and "something happens to the commits".
> A lot of people with less experience, who a busy looking through lots of 
> stuff to solve their problem, they will not make that connection in that 
> particular moment.
> Heck, I've seen highly educated people missing far more obvious things 
> like that.

Once again I'm not talking about what they could miss, I'm talking about
what they are thinking the command will do.

> > To me this is another instance of "do not drink scorching hot coffee".
> > Sure, some users might benefit from reading this, but how many? And how
> > many would be annoyed by the obvious unnecessary warning?
> 
> Well, at least in the U.S, you apparently have to tell your customers 
> that the coffee you sell is hot. (If you recall, there was a "famous" 
> court case).

Yes, and that's stupid. There's plenty of unnecessary warnings.

  * Do not hold the wrong end of a chainsaw.
  * Do not drive with sun shield in place.  
  * Avoid death.

https://www.forbes.com/2011/02/23/dumbest-warning-labels-entrepreneurs-sales-marketing-warning-labels_slide.html

> I have always thought, that coffee should be hot (except iced coffee).
> You also have to warn people not to put their pets into the microwave. 
> Again to me: bleeding obvious.

The fact that you have to do it in USA doesn't mean you should.

> > Moreover, most users don't even read the documentation. Some might even
> > be doing `git switch -h`, and others using zsh completion description.
> > So we can't just rely on them reading this line.
> 
> Well, so we can't warn the rest? Why do we have docs at all?

To explain how to use commands.

> > If you are really worried about the user losing information, why don't
> > we add a true warning:
> > 
> >    hint: The previous state of the '%s' branch might have been lost.
> >    hint: The id was '%s'.
> >    hint:
> >    hint: If you didn't intend to do this, you can restore the previous
> >    hint: state with:
> >    hint:
> >    hint:  git reset --hard @{1}
> >    hint:
> >    hint: Disable this message with "git config advice.switchForceNew false"
> > 
> > That way the user doesn't need to read the documentation.
> 
> Well yes, printing a recovery note, may be another helpful addition.
> 
> But as you said, a single way of pushing info, will not reach everyone. 

Our objective is not to reach everyone.

-- 
Felipe Contreras
