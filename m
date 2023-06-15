Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856B8EB64D8
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 03:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbjFODJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 23:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242793AbjFODIz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 23:08:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5648226A9
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 20:08:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd69bb4507eso1563325276.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 20:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686798533; x=1689390533;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68UCDMKZjtx+nnomQPBdDfgDl7+CmrigZcCTUXxJlBk=;
        b=zNjD6y2y/fVAQl+OmgI87TBIj/ZrNVbRX2yoCaTKGFnFfOdW2bf1My+XGgnpxNW/DU
         8GFZ7X6FYz0vak4gfdhqq278VpqDAHpBv0L5s0vC2LLUdxoE5JDl/GhEEHkzCZAGMlgG
         boOGVFOlFCnDJl1K4STCbeStdwwz5LZGASByigu/VtHmbb0FQuEl9KwP7YqTyjF9JYHq
         ie0nbkxFh8UroVAAx1VOWJME0R6sVIBBt35lGbPUkWmyYWrCSRGBekHBOkz21N9DLEgK
         8TcFFnwFM6s6UhFp7RCPV+IETxW7HBzdDpXtWjyRNyQ2MM5k33BaxYkaRz4TUF5V2KU1
         DJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686798533; x=1689390533;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68UCDMKZjtx+nnomQPBdDfgDl7+CmrigZcCTUXxJlBk=;
        b=UWdKggp4/O8fjmiXNJiagu0hthew860hD0GG3EXSNmS00pXf+G2eyf2YzNvfbIBjlX
         L/OlZPYVK+A3Up+5TbMxqtAqiY7B70B+8tLiT8tO30mTNJOOH4vhpSlAeLdp9f8ovR7n
         g633GteU1m5kmT0bR0Yk2C+U/XiK4O9eChVN4NHpSZ8Y7+OeTjYCbz4SlnuK3toROUEp
         HIZT/vg3QgDmDJDVtJI7+It2BE8U3NFXdNiaQh6RdMGnHTKghG9MXYikEgWI4ppTI6qY
         UjTfPwiHswM85iuy5WqYemQ4SIv1CPtavYp/i23Bp0NOgN+NrgzoSTUYa2h9xaZJa38G
         072Q==
X-Gm-Message-State: AC+VfDwwpQSkpNlwvAvPP3F4u6Ue7BmEuDaleVsEfA0ZMx4CA4pcpLtF
        GL9/G7KqIke4BZxzyG40QjBs2qhQbg8=
X-Google-Smtp-Source: ACHHUZ7Mo0STL5SeKEBb59tWIgQLqmJD8CTYeeRo9vilPdeU+knx2v03yLuX9gr0jcvQ8YnKCJrhZTPscRg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:4d0:b0:bcf:9ae7:c39 with SMTP id
 v16-20020a05690204d000b00bcf9ae70c39mr610943ybs.0.1686798533653; Wed, 14 Jun
 2023 20:08:53 -0700 (PDT)
Date:   Wed, 14 Jun 2023 20:08:52 -0700
In-Reply-To: <xmqqedmdwput.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqedmdwput.fsf@gitster.g>
Message-ID: <owlya5x1o20r.fsf@fine.c.googlers.com>
Subject: Re: What's cooking in git.git (Jun 2023, #04; Wed, 14)
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * la/docs-typofixes (2023-06-12) 1 commit
>   - docs: typofixes

>   Typofixes.

>   Will merge to 'next'.
>   source: <pull.1542.v2.git.1686166007816.gitgitgadget@gmail.com>

I am in the middle of addressing some review comments and have rerolled
to v4 [1] for the time being.

[1]  
https://lore.kernel.org/git/pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com/
